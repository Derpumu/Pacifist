from collections.abc import Iterable
import pathlib
import subprocess
import re
import pytest

from approvaltests.approvals import verify
from approval_utilities.utilities.exceptions.exception_collector import gather_all_exceptions_and_throw
from approvaltests.namer import NamerFactory
from approvaltests.scrubbers import create_regex_scrubber, combine_scrubbers

TIMESTAMP_RE = r"   \d\.\d{3} "

test_file = pathlib.Path(__file__)
test_dir = test_file.parent
mod_path = test_dir.parent

def factorio_exe() -> pathlib.Path:
    exe = mod_path / '..' / '..' / 'bin' / 'x64' / 'factorio.exe'
    assert (exe.exists())
    return exe


def keep(line: str) -> bool:
    if '__Pacifist__' in line:
        return not "Checksum for script" in line
    if re.match(TIMESTAMP_RE, line):
        return False
    if line.startswith("Running update") or line.startswith("  checksum: ") or line.startswith(
            "  Performed 1000 updates") or line.startswith("  avg: "):
        return False
    return True


def parse_log(lines: Iterable[str]) -> Iterable[str]:
    in_pacifist = False
    nesting = 0
    for line in lines:
        if "__Pacifist__/lib/debug" in line:
            in_pacifist = True
            nesting = 0
            yield line
            continue

        if not in_pacifist:
            continue

        if line.endswith("{"):
            nesting += 1
            yield line
            continue
        elif nesting > 0:
            if line.strip().startswith("}"):
                nesting -= 1
            yield line
            continue
        else:
            in_pacifist = False


def filter_output(cout: str) -> str:
    lines = (line for line in parse_log(cout.splitlines()))
    return str.join('\n', lines)


def run_scenario(scenario: pathlib.Path) -> str:
    factorio = factorio_exe()

    try:
        save = scenario
        cwd = scenario.parent

        # sync mods first then run the load that actually
        sync = subprocess.run([str(factorio), '--sync-mods', str(save)], cwd=cwd, capture_output=True, text=True)
        if sync.returncode != 0:
            pytest.exit(f"{scenario_name(scenario)}: mod sync failed : {sync.stdout}")

        completed = subprocess.run([str(factorio), '--benchmark', str(save)], cwd=cwd, capture_output=True,
                                   text=True)
        if completed.returncode != 0:
            pytest.exit(f"{scenario_name(scenario)}: loading/benchmark failed")

        return filter_output(completed.stdout)
    except StopIteration:
        return ""


def scenario_name(scenario: pathlib.Path) -> str:
    return str(scenario.stem)


def collect_scenarios() -> Iterable[pathlib.Path]:
    scenario_dir = test_dir / 'scenarios'
    scenarios: list[pathlib.Path] = []
    #return [scenario_dir / '02-small_compatibility']
    for subdir in scenario_dir.iterdir():
        if subdir.is_dir():
            scenarios += [f for f in subdir.iterdir() if f.is_file() and f.suffix == '.zip']
    return scenarios


def create_timestamp_scrubber():
    return create_regex_scrubber(TIMESTAMP_RE, "")


def debuglog_scrubber():
    return create_regex_scrubber(r"Script @__Pacifist__/lib/debug\.lua:\d+:", "Pacifist:")


def test_logparse():
    log = """
   0.211 Script @__Pacifist__/lib/debug.lua:11: cleaning up: 167 technologies remaining
   0.087 Running in headless mode
   0.211 Script @__Pacifist__/lib/debug.lua:11: cleaning up: 143 technologies remaining
   0.211 Script @__Pacifist__/lib/debug.lua:11: cleaning up: 127 technologies remaining
   0.207 Script @__Pacifist__/lib/debug.lua:51: 
compatibility.base: {
  extra: {
    main_menu_simulations: {
      1: nauvis_mining_defense
    }
  }
}
   0.087 Audio is disabled
   0.211 Script @__Pacifist__/lib/debug.lua:11: cleaning up: 27 technologies remaining
      
    """
    verify(filter_output(log))


@pytest.mark.parametrize("scenario", collect_scenarios(), ids=scenario_name)
def test_scenario(scenario: pathlib.Path):
    scrubbers = combine_scrubbers(create_timestamp_scrubber(), debuglog_scrubber())
    verify(run_scenario(scenario), options=NamerFactory.with_parameters(
        scenario_name(scenario)).with_scrubber(scrubbers))
