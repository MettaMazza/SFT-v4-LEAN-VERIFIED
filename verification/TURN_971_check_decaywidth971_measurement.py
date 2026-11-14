from pathlib import Path
import json,sys,os,subprocess,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import decay_width_branching_lifetime_terminal_validation_v1 as v
from sft.engine.canonical import canonical_value
root=(w/'v3-runtime500').resolve();row=v.codata_action_row(root);record=v.authoritative_record(root);pdg=v.pdg_analysis(record);lo,hi=pdg['width_interval_GeV']
def rat(x):return f'(LeptonIntervals.normalize {x.numerator} {x.denominator} (by decide))'
s='''import SFT.Physics.DecayWidthMeasurement
open SFT.Physics SFT.Host.Canonical DecayWidthMeasurement
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval do
 let result : Except String Value := do
  let pdg ← pdgAnalysis registeredRecord
  let nist ← nistActionAnalysis '''+json.dumps(row)+' ('+rat(lo)+','+rat(hi)+''')
  let boundary ← payloadBoundary registeredRecord
  pure (.object [("pdg",pdg),("nist",nist),("record",boundary)])
 match result with | .ok x => IO.println (render x) | .error e => IO.println e
'''
p=w/'constants-recovery/DecayWidthMeasurementCompare971.lean';p.write_text(s)
env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')};out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True);a=json.loads(out);e=canonical_value({'pdg':pdg,'nist':v.nist_action_analysis(row,(lo,hi)),'record':record});assert a==e,[(k,a.get(k),x) for k,x in e.items() if a.get(k)!=x]
(w/'decaywidth971_measurement_output.json').write_text(json.dumps(a,indent=2)+'\n');(w/'decaywidth971_measurement_report.json').write_text(json.dumps(dict(status='PASS',all_16_width_rows_13_mode_rows_4_individual_branches=True,entire_pdg_nist_analyses_match=True,record_and_boundary_match=True,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',lean_sha256=hashlib.sha256((c/'SFT/Physics/DecayWidthMeasurement.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS complete PDG/NIST analyses and record/boundary')
