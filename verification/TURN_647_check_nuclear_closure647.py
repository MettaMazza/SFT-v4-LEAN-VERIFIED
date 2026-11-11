from pathlib import Path
import ast,json,subprocess,os
from fractions import Fraction
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(p):return subprocess.check_output(['git','-C',repo,'show',pin+':'+p],text=True)
ns={'generator_period_three':lambda:3,'Fraction':Fraction}
for path,names in [('sft/physics/structural_constants.py',{'positive_predecessor'}),('sft/physics/atomic_constants.py',{'binary_count','colour_coupling','spin_orbit_threshold','oscillator_closure','nuclear_closure','nuclear_closure_prefix'})]:
 tree=ast.parse(raw(path));exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in names],type_ignores=[]),path,'exec'),ns)
s='import SFT.Physics.NuclearClosure\nset_option maxRecDepth 10000\nopen SFT.Physics.NuclearClosure SFT.Physics.GeneratorOperations SFT.Host.Canonical\ndef display : Except String Nat → String\n | .ok n => toString n\n | .error e => e\ndef displayList : Except String (List Nat) → String\n | .ok ns => render (.array (ns.map (fun n => .integer (.ofNat n))))\n | .error e => e\ndef main : IO Unit := do\n';expected=[]
for source,lean,inputs in [('oscillator_closure','oscillatorClosure',list(range(-3,258))+[False,True]),('nuclear_closure','nuclearClosure',list(range(-3,258))+[False,True]),('nuclear_closure_prefix','closurePrefix',list(range(-3,65))+[False,True])]:
 for x in inputs:
  try:
   v=ns[source](x);expected.append(json.dumps(list(v),separators=(',',':')) if isinstance(v,tuple) else str(v))
  except Exception as e:expected.append(type(e).__name__+': '+str(e))
  arg='.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')';s+=' IO.println ('+('displayList' if source.endswith('prefix') else 'display')+' ('+lean+' ('+arg+')))\n'
r=Path('work/constants-recovery').resolve();(r/'NuclearClosureCases647.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','NuclearClosureCases647.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/nuclear_closure647_cases.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;assert p.stdout.splitlines()==expected;Path('work/nuclear_closure647_cases_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,operation_comparisons=len(expected),source_execution='Actual pinned predecessor, binary count, colour coupling, threshold and all three closure operations; established generator value reused'),indent=2));print('PASS',len(expected),'operation comparisons')
