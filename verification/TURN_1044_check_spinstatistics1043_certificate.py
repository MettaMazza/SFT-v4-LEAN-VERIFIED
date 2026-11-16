from pathlib import Path
from fractions import Fraction
from math import comb,prod
import ast,json,subprocess,os,re,hashlib
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');env={'Fraction':Fraction,'comb':comb,'prod':prod};exec(compile(ast.Module(body=[n for n in ast.parse((w/'spinstatistics1043_law.py').read_text()).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-v3','exec'),env);expected=env['theorem_certificate']()
p=w/'spinstatistics1043_certificate_check.lean';p.write_text('''import SFT.Physics.SpinStatisticsCertificateProof
import SFT.Physics.SpinStatisticsOccupationEnumeration
import SFT.Host.Canonical
open SFT.Physics SpinStatisticsCondensationCertificate SFT.Host.Canonical
#eval IO.println (render (match certificate with
 | .error e => .text e
 | .ok c => .object [("occupation",.boolean c.occupation),("weights",.boolean c.weights),("cold",.boolean c.cold),("spin",.boolean c.spin)]))
''')
mods=['SpinStatisticsCondensationCertificate','SpinStatisticsOccupationCertificateProof','SpinStatisticsWeightsCertificateProof','SpinStatisticsColdCertificateProof','SpinStatisticsCertificateProof','SpinStatisticsOccupationEnumeration'];names=[];hashes={}
for m in mods:
 body=(r/f'SFT/Physics/{m}.lean').read_text();hashes[m]=hashlib.sha256(body.encode()).hexdigest();names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M)]
with p.open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in names))
x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'spinstatistics1043_certificate_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];assert json.loads(x.stdout.splitlines()[0])==expected;assert all("'"+n+"' does not depend on any axioms"in x.stdout for n in names),x.stdout
(w/'spinstatistics1043_certificate_report.json').write_text(json.dumps(dict(status='PASS',original_certificate=expected,modules=mods,declarations=names,source_sha256=hashes,axioms=[]),indent=2));print('PASS original4fieldcertificate and',len(names),'zeroaxiom declarations')
