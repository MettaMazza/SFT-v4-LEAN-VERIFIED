from pathlib import Path
import ast,subprocess,json,os,dataclasses,__future__,hashlib
from fractions import Fraction
repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def raw(p):return subprocess.check_output(['git','-C',repo,'show',pin+':'+p],text=True)
ns={'dataclass':dataclasses.dataclass,'Fraction':Fraction}
for p,limit in [('sft/physics/structural_constants.py',180),('sft/physics/atomic_constants.py',209),('sft/chemistry/gblock_predictions.py',100)]:
 nodes=[n for n in ast.parse(raw(p)).body if isinstance(n,(ast.FunctionDef,ast.ClassDef)) and n.lineno<limit]
 exec(compile(ast.Module(body=nodes,type_ignores=[]),p,'exec',flags=__future__.annotations.compiler_flag),ns)
def arg(n):return '(.boolean '+str(n).lower()+')' if isinstance(n,bool) else '(.integer ('+str(n)+'))'
def atom(x):
 if dataclasses.is_dataclass(x):return ','.join(str(v) for v in dataclasses.astuple(x))
 if isinstance(x,tuple):return ','.join(map(str,x))
 return str(x)
cases=[]
def add(fn,lean,args,kind):
 try: value=ns[fn](*args);expected='ok:'+ (';'.join(map(atom,value)) if isinstance(value,tuple) else str(value))
 except Exception as e:expected=type(e).__name__+': '+str(e)
 cases.append(dict(operation=fn,args=args,expected=expected,expression=lean+' '+' '.join(arg(x) for x in args),kind=kind))
for n in [-2,0,1,False,True,*range(2,25),274]:add('generated_subshell_order','generatedSubshellOrder',[n],'pairs')
for n in [-1,0,False,True,*range(1,138),138,184,1000]:add('fill_configuration','fillConfiguration',[n],'rows')
for n in [-1,0,False,True,*range(1,15),136,137,138]:add('noble_closures','nobleClosures',[n],'nats')
for p,o in [(1,1),(8,1),(5,5),(1,2),(0,0),(True,True),(-1,1),(False,1),(9,9)]:
 add('first_occupied_coordinate','firstOccupiedCoordinate',[p,o],'nat')
 for n in [1,118,119,120,121,126,137]:add('subshell_occupation','subshellOccupation',[n,p,o],'nats')
r=Path('work/constants-recovery').resolve()
header='''import SFT.Chemistry.GBlockOperations
open SFT.Chemistry.GBlockOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
 def output {α : Type} (fmt : α → String) : Except String α → String
 | .error e => e
 | .ok x => "ok:" ++ fmt x
 def pairs (xs : List (Nat × Nat)) := String.intercalate ";" (xs.map (fun (p,o) => s!"{p},{o}"))
 def nats (xs : List Nat) := String.intercalate ";" (xs.map toString)
 def rows (xs : List OccupiedSubshell) := String.intercalate ";" (xs.map (fun r => s!"{r.principalRank},{r.orbitRank},{r.occupied},{r.capacity}"))
 def main : IO Unit := do
'''
driver=Path('work/GBlockComparison654.lean');driver.write_text(header+'\n'.join('  IO.println (output '+('toString' if c['kind']=='nat' else c['kind'])+' ('+c['expression']+'))' for c in cases)+'\n')
Path('work/gblock654_expected.json').write_text(json.dumps(cases,indent=2))
env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
with open('work/gblock654_actual.txt','w') as out:
 result=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run',str(driver)],env=env,stdout=out,stderr=subprocess.STDOUT)
actual=Path('work/gblock654_actual.txt').read_text().splitlines()
errors=[dict(index=i,case=c,actual=actual[i] if i<len(actual) else None) for i,c in enumerate(cases) if i>=len(actual) or actual[i]!=c['expected']]
report=dict(passed=result.returncode==0 and len(actual)==len(cases) and not errors,cases=len(cases),returncode=result.returncode,output_lines=len(actual),errors=errors[:10],source_pin=pin)
Path('work/gblock654_comparison.json').write_text(json.dumps(report,indent=2));print(json.dumps(report));assert report['passed']
