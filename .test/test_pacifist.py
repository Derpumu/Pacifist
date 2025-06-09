import pathlib
import subprocess
import re

from approvaltests.approvals import verify
from approval_utilities.utilities.exceptions.exception_collector import gather_all_exceptions_and_throw
from approvaltests.namer import NamerFactory
from approvaltests.scrubbers import create_regex_scrubber, combine_scrubbers

TIMESTAMP_RE = r"   \d\.\d\d\d "


def factorio_exe(mod_path: pathlib.Path) -> pathlib.Path:
    exe = mod_path / '..' / '..' / 'bin' / 'x64' / 'factorio.exe'
    assert (exe.exists())
    return exe


def filter_output(cout: str) -> str:
    lines = (line for line in cout.splitlines() if '__Pacifist__' in line or not re.match(TIMESTAMP_RE, line))
    return str.join('\n', lines)


def run_scenario(scenario: pathlib.Path, factorio: pathlib.Path) -> str:
    zip_files = (f for f in scenario.iterdir() if f.is_file() and f.suffix == '.zip')
    save = next(zip_files)
    args = [str(factorio), '--sync-mods', str(save)]
    completed = subprocess.run(args, cwd=scenario, capture_output=True, text=True)
    return filter_output(completed.stdout)


def scenario_name(scenario: pathlib.Path) -> str:
    return str(scenario.stem)


def create_timestamp_scrubber():
    return create_regex_scrubber(TIMESTAMP_RE, "")


def debuglog_scrubber():
    return create_regex_scrubber(r"Script @__Pacifist__/lib/debug\.lua:\d+:", "Pacifist:")


def test_scenarios():
    test_file = pathlib.Path(__file__)
    test_dir = test_file.parent
    mod_path = test_dir.parent
    factorio = factorio_exe(mod_path)

    scenario_dir = test_dir / 'scenarios'
    scenarios = [subdir for subdir in scenario_dir.iterdir() if subdir.is_dir()]

    scrubbers = combine_scrubbers(create_timestamp_scrubber(), debuglog_scrubber())

    gather_all_exceptions_and_throw(scenarios, lambda s: verify(run_scenario(s, factorio),
                                                                options=NamerFactory.with_parameters(
                                                                    scenario_name(s)).with_scrubber(scrubbers)
                                                                ))
