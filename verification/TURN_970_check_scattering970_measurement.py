from pathlib import Path
import json,sys,os,subprocess,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import scattering_rutherford_compton_terminal_validation_v1 as v
from sft.engine.canonical import canonical_value
root=(w/'v3-runtime500').resolve();rows=v.codata_rows(root);record=v.authoritative_record(root)
s='''import SFT.Physics.ScatteringMeasurement
open SFT.Physics SFT.Host.Canonical ScatteringMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval do
 let result : Except String Value := do
  let codata ← codataAnalysis '''+json.dumps(rows)+'''
  let iaea ← iaeaAnalysis registeredRecord
  let boundary ← payloadBoundary registeredRecord
  pure (.object [("codata",codata),("iaea",iaea),("record",boundary)])
 match result with | .ok x => IO.println (render x) | .error e => IO.println e
'''
p=w/'constants-recovery/ScatteringMeasurementCompare970.lean';p.write_text(s)
env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True);a=json.loads(out);e=canonical_value({'codata':v.codata_analysis(rows),'iaea':v.iaea_analysis(record),'record':record});assert a==e,[(k,a.get(k),x) for k,x in e.items() if a.get(k)!=x]
(w/'scattering970_measurement_output.json').write_text(json.dumps(a,indent=2)+'\n');(w/'scattering970_measurement_report.json').write_text(json.dumps(dict(status='PASS',seven_complete_source_rows=True,entire_iaea_and_codata_analyses_match=True,record_and_boundary_match=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',lean_sha256=hashlib.sha256((c/'SFT/Physics/ScatteringMeasurement.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS seven CODATA rows,entire interval/IAEA analyses,record/boundary')
