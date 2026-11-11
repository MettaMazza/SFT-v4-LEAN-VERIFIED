from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/smithium_spec655.py').read_text(),ns);expected=json.loads(json.dumps(ns['namespace']['smithium_record']()))
r=Path('work/constants-recovery').resolve();driver=r/'SmithiumRecord655.lean';driver.write_text('''import SFT.Chemistry.Smithium
import SFT.Host.Canonical
open SFT.Chemistry SFT.Host.Canonical
def main : IO Unit := do
 match Smithium.smithiumRecord with
 | .error e => throw (IO.userError e)
 | .ok r => IO.println (render (.object [
  ("proton",.integer (.ofNat r.proton)),("neutron",.integer (.ofNat r.neutron)),
  ("mass",.integer (.ofNat r.mass)),
  ("configuration",.array (r.configuration.map (fun t => .array [.integer (.ofNat t.1),.integer (.ofNat t.2.1),.integer (.ofNat t.2.2)]))),
  ("valence",.integer (.ofNat r.valence)),
  ("predicted_positive_oxidation_counts",.array (r.predictedPositiveOxidationCounts.map (fun n => .integer (.ofNat n))))]))
''');env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));out=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','--run',driver.name],cwd=r,env=env,text=True);actual=json.loads(out);assert actual==expected,(actual,expected);Path('work/smithium655_record_report.json').write_text(json.dumps({'status':'PASS','actual':actual,'expected':expected,'source_pin':ns['pin'],'source':'sft/chemistry/gblock_predictions.py:smithium_record','all_six_fields_match':True},indent=2));print('PASS six original Smithium fields from fresh Lean execution')
