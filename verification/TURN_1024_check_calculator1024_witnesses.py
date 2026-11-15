from pathlib import Path
import os,json,re,sys,subprocess,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete.law import SPEC
s=(r/'SFT/Mathematics/CalculatorCompleteWitnesses.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M)
code='import SFT.Mathematics.CalculatorCompleteWitnesses\nopen SFT.Mathematics.CalculatorCompleteWitnesses SFT.Host.Canonical\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n#eval IO.println (render (.array ['+','.join('.boolean witness'+str(i)for i in range(10))+']))\n'+''.join('#print axioms SFT.Mathematics.CalculatorCompleteWitnesses.'+n+'\n'for n in names)
p=w/'calculator1024_witness_check.lean';p.write_text(code);x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M12288',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True,capture_output=True);(w/'calculator1024_witness_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];assert json.loads(x.stdout.splitlines()[0])==[x.passed for x in SPEC.witnesses];assert x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1024_witness_report.json').write_text(json.dumps(dict(status='PASS',original_witnesses=10,declarations=names,axioms=[],source_sha256=hashlib.sha256(s.encode()).hexdigest()),indent=2));print('PASS10 original witnesses;',len(names),'emptyaxiom definitions')
