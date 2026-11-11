from pathlib import Path
import ast,json,subprocess,os
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
def raw(p):return subprocess.check_output(['git','-C',repo,'show',pin+':'+p],text=True)
# Reuse the established generator's derived value, then execute the actual operation bodies.
ns={'generator_period_three':lambda:3}
for path,names in [('sft/physics/structural_constants.py',{'positive_predecessor'}),('sft/physics/atomic_constants.py',{'binary_count','boundary_count','orientation_count','orbit_capacity'})]:
 tree=ast.parse(raw(path));exec(compile(ast.Module(body=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in names],type_ignores=[]),path,'exec'),ns)
inputs=list(range(-3,258))+[False,True];expected=[]
for x in inputs:
 row=[]
 for op in ['orientation_count','orbit_capacity']:
  try:row.append(str(ns[op](x)))
  except Exception as e:row.append(type(e).__name__+': '+str(e))
 expected.append('|'.join(row))
s='import SFT.Physics.AtomicOrbitCapacity\nopen SFT.Physics.AtomicOrbitCapacity SFT.Physics.GeneratorOperations\ndef display : Except String Nat → String\n | .ok n => toString n\n | .error e => e\ndef main : IO Unit := do\n'
for x in inputs:
 arg='.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
 s+=' IO.println ((display (orientationCount ('+arg+'))) ++ "|" ++ (display (orbitCapacity ('+arg+'))))\n'
r=Path('work/constants-recovery').resolve();(r/'AtomicOrbitCases646.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','AtomicOrbitCases646.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/atomic_orbit646_cases.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;assert p.stdout.splitlines()==expected;Path('work/atomic_orbit646_cases_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,input_cases=len(inputs),operation_comparisons=2*len(inputs),source_execution='Actual pinned predecessor, binary/boundary count, orientation and capacity bodies; established generator_period_three value reused; Lean reuses AlphaCovers.binaryCount with proved generator binding'),indent=2));print('PASS',2*len(inputs),'operation comparisons')
