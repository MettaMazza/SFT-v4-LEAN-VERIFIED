from pathlib import Path
import json,subprocess,os
w=Path('work');r=w/'constants-recovery';p=r/'NeutrinoMeasurementCompare928.lean';p.write_text('''import SFT.Physics.NeutrinoMeasurementRoots
import SFT.Host.Canonical
open SFT.Physics.NeutrinoMeasurementRoots SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let rows ← ([("lightest",lightestSquare),("middle",middleSquare),("heavy",heavySquare)] : List (String × Rat)).mapM fun (item : String × Rat) => do
  let (l,u) ← IO.ofExcept (sqrtRefined item.2)
  pure (item.1,Value.array [fraction l,fraction u])
 IO.println (render (.object rows))
''');actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=dict(os.environ,LEAN_PATH='/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),text=True));expected=json.loads((w/'neutrinomeasurement928_original.json').read_text());assert actual==expected;(w/'neutrinomeasurement928_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/matter_flavour_validation_v1.py:sqrt_refined',actual=actual,expected=expected,axiom_audit='neutrinomeasurement928_core_audit.log'),indent=2));print('PASS original three exact refined mass intervals')
