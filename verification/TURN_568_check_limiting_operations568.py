from pathlib import Path
import json,subprocess,os,itertools
ns={};exec(Path('work/limiting_spec568.py').read_text(),ns);sc=ns['namespace']
cases=[([],[]),([], [1]),([(1,2)],[]), ([(1,2)],[1]), ([(1,2),(3,4)],[1,1]), ([(1,2),(1,2)],[1,1]), ([(1,2),(1,1)],[1,2]), ([(1,2),(1,2)],[1]), ([(1,2)],[1,1]), ([(1,3),(1,2),(2,3)],[2,3,4]), ([(3,4),(1,2),(1,4)],[1,1,1]), ([(1,1000000007),(1,1000000009)],[1,1])]
for n,d,k,m,e,l in itertools.product([1,2],[2,3],[1,2],[1,2],[2,3],[1,2]):cases.append(([(n,d),(m,e)],[k,l]))
expected=[];expressions=[]
for amounts,requirements in cases:
 try:expected.append({'positions':[x.value for x in sc['limiting_component_positions'](tuple(sc['ExactPart'].from_pair(n,d) for n,d in amounts),tuple(sc['PositiveCount'](x) for x in requirements))]})
 except sc['InadmissibleExactValue'] as err:expected.append({'error':str(err)})
 aa='['+','.join('SFT.Foundation.ExactOperations.normalizePart '+str(n)+' '+str(d)+' (by decide) (by decide)' for n,d in amounts)+']'
 rr='['+','.join('⟨'+str(n)+',(by decide)⟩' for n in requirements)+']'
 expressions.append('limitingComponentPositions '+aa+' '+rr)
s='import SFT.Chemistry.LimitingProgress\nimport SFT.Host.Canonical\nopen SFT.Chemistry.LimitingProgress SFT.Host.Canonical\ndef result (value : Except String (List Nat)) : Value := match value with\n | .error error => .object [("error",.text error)]\n | .ok positions => .object [("positions",.array (positions.map fun n => .integer (Int.ofNat n)))]\ndef main : IO Unit := do\n'
s+='\n'.join(' IO.println (render (result ('+x+')))' for x in expressions)+'\n'
r=Path('work/constants-recovery').resolve();(r/'LimitingOperations568.lean').write_text(s)
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','LimitingOperations568.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True)
Path('work/limiting_operations568.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected,(actual,expected)
Path('work/limiting_operations568_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],cases=len(cases),fresh_native_execution=True,results=actual,compares='original paired-input guards and every tied positive position using exact source ratios'),indent=2));print('PASS',len(cases),'fresh exact operation cases')
