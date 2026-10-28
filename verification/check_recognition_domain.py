"""Fresh native checks for the pinned complete_enumeration/self_negating_boundary translation."""
from pathlib import Path
import hashlib,json,subprocess
root=Path(__file__).resolve().parents[1]
expected=json.loads((root/'verification/TURN_201_DOMAIN_EXPECTED.json').read_text())
v3=json.loads((root/'reference/SOURCE.json').read_text())['local_source']
source=subprocess.check_output(['git','-C',v3,'show',expected['source_commit']+':'+expected['source_path']])
assert hashlib.sha256(source).hexdigest()==expected['source_sha256']
actual=json.loads(subprocess.check_output(['lake','env','lean','--run','verification/TURN_201_DomainChecks.lean'],cwd=root,text=True))
assert actual==expected['expected']
report=dict(status='PASS',cases=len(actual),source_commit=expected['source_commit'],source_sha256=expected['source_sha256'],fresh_native_lean_output=True,source_python_executed=False,scope='Exact guards/errors, full ordered enumeration, held complement labels, excluded labels, Unicode and two-digit positions.')
(root/'verification/TURN_201_DOMAIN_REPORT.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report))
