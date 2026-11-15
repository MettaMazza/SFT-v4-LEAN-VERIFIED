from pathlib import Path
import sys,json,subprocess,os
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.mathematics.calculator_complete.session import CalculatorSession
from sft.mathematics.calculator_complete import controller as c
from sft.mathematics.calculator import values as v
old=Path('work/check_calculator1023_session.py').read_text();exec(old[old.index('def canon'):old.index('actions=')]);head=old[old.index("header='''")+10:old.index('def action')].replace('import SFT.Mathematics.CalculatorCompleteSession','import SFT.Mathematics.CalculatorCompleteController')
cases=[(p,m,k) for p in [0,3,61] for m in ['rad','deg','invalid'] for k in [-1,5]];expected=[]
for p,m,k in cases:
 try:expected.append({'ok':snapshot(CalculatorSession(places=p,angle_mode=m,operation_limit=k))})
 except v.CalculatorHalt as e:expected.append({'error':str(e)})
head+='''def made (p : Int) (m : String) (k : Int) : SFT.Host.Canonical.Value :=
 match create p m k with | .ok s => .object [("ok",snapshot s)] | .error e => .object [("error",.text e)]
#eval IO.println (render (.array ['''+','.join('made ('+str(p)+') '+json.dumps(m)+' ('+str(k)+')' for p,m,k in cases)+']))\n'
head+='''#eval IO.println (render (.array [
 .array (CalculatorCompleteController.mainButtonRows.map fun row => .array (row.map SFT.Host.Canonical.Value.text)),
 .array (CalculatorCompleteController.functionCatalog.map fun (a,b,c) => .array [.text a,.text b,.text c]),
 .array (CalculatorCompleteController.insertions.map fun (a,b) => .array [.text a,.text b]),
 .array (CalculatorCompleteController.unaryImmediate.map fun (a,b) => .array [.text a,.text b]),
 .array (CalculatorCompleteController.binaryPrefix.map fun (a,b) => .array [.text a,.text b])]))
'''
p=w/'calculator1023_boundaries.lean';p.write_text(head);x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True,capture_output=True);(w/'calculator1023_boundaries.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout;rows=[json.loads(line) for line in x.stdout.splitlines()];assert rows[0]==expected;static=[c.MAIN_BUTTON_ROWS,c.FUNCTION_CATALOG,list(c.INSERTIONS.items()),list(c.UNARY_IMMEDIATE.items()),list(c.BINARY_PREFIX.items())];assert rows[1]==json.loads(json.dumps(static));(w/'calculator1023_boundaries_report.json').write_text(json.dumps(dict(status='PASS',constructor_cases=len(cases),complete_static_tables=5),indent=2));print('PASS',len(cases),'constructor outcomes and all five original UI tables')
