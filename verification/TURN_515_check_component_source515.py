from pathlib import Path
from fractions import Fraction
import sys,json,subprocess,os,hashlib
sys.dont_write_bytecode=True;root=Path('work/v3-runtime500').resolve();sys.path.insert(0,str(root))
from sft.physics import cosmic_component_transport_terminal_law_v1 as source
from sft.engine.canonical import canonical_value
r=Path('work/constants-recovery').resolve();env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
ops=[('matter_transport','matterTransport'),('radiation_transport','radiationTransport'),('vacuum_transport','vacuumTransport'),('late_squared_expansion','lateSquaredExpansion'),('matter_fraction','matterFraction'),('vacuum_fraction','vacuumFraction')]
inputs=[-3,-1,0,False,True,1,Fraction(1,2),Fraction(3,2),2,3,Fraction(37,19),Fraction(10**20,7),'1.25',0.1]
lines=[];expected=[];cases=[]
for py,lean in ops:
 for value in inputs:
  q=Fraction(value)
  try:want={'ok':canonical_value(getattr(source,py)(value))}
  except ValueError as e:want={'error':str(e)}
  expected.append(want);cases.append(dict(operation=py,input=repr(value),converted_exact_fraction=str(q)))
  lines.append(f'outcome ({lean} (LeptonIntervals.normalize ({q.numerator}) {q.denominator} (by decide)))')
for py,lean in [('matter_vacuum_equality_cube','matterVacuumEqualityCube'),('acceleration_onset_cube','accelerationOnsetCube'),('present_acceleration_magnitude','presentAccelerationMagnitude')]:
 expected.append({'ok':canonical_value(getattr(source,py)())});cases.append(dict(operation=py));lines.append('outcome '+lean)
s='''import SFT.Physics.CosmicComponentTransportCertificate
open SFT.Host.Canonical SFT.Physics CosmicComponentTransport
 def outcome : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => .object [("ok",RunningConvergenceCertificate.rat q)]
 def main : IO Unit := IO.println (render (.object [
 ("operations",.array ['''+','.join(lines)+''']),
 ("component_table",CosmicComponentTransportCertificate.componentTable)]))
'''
(r/'ComponentSource515.lean').write_text(s)
subprocess.run(['/Users/dolltrading/.elan/bin/lean','-o','.lake/build/lib/lean/SFT/Physics/CosmicComponentTransportCertificate.olean','-c','.lake/build/ir/SFT/Physics/CosmicComponentTransportCertificate.c','SFT/Physics/CosmicComponentTransportCertificate.lean'],cwd=r,env=env,check=True)
out=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','--run','ComponentSource515.lean'],cwd=r,env=env,text=True);actual=json.loads(out);Path('work/component515_source_output.json').write_text(json.dumps(actual,indent=2)+'\n')
assert actual['operations']==expected,[(cases[i],a,e) for i,(a,e) in enumerate(zip(actual['operations'],expected)) if a!=e]
assert actual['component_table']==canonical_value(source.component_laws())
report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',fresh_lean_execution=True,original_python_operations_executed=True,operation_cases=len(cases),component_rows=3,all_four_fields_each_match=True,cases=cases)
Path('work/component515_source_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(cases),'fresh source operations and complete three-component table')
