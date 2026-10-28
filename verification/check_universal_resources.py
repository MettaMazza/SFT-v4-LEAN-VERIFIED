"""Fresh native checks for the pinned resource_ledger translation."""
from pathlib import Path
import hashlib,json,subprocess
root=Path(__file__).resolve().parents[1]
expected=json.loads((root/'verification/TURN_200_RESOURCE_EXPECTED.json').read_text())
v3=json.loads((root/'reference/SOURCE.json').read_text())['local_source']
source=subprocess.check_output(['git','-C',v3,'show',expected['source_commit']+':'+expected['source_path']])
assert hashlib.sha256(source).hexdigest()==expected['source_sha256']
actual=json.loads(subprocess.check_output(['lake','env','lean','--run','verification/TURN_200_ResourceChecks.lean'],cwd=root,text=True))
assert actual==expected['expected']
report=dict(status='PASS',cases=len(actual),source_commit=expected['source_commit'],source_sha256=expected['source_sha256'],fresh_native_lean_output=True,source_python_executed=False,scope='Duplicate/nonempty guard order; all time rows and counts; retained occupied support; Unicode labels; repeated observations; two-digit position labels.')
(root/'verification/TURN_200_RESOURCE_REPORT.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report))
