from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import STATIONARY_SPEC
(w/'stationary885_spec.json').write_text(json.dumps(asdict(STATIONARY_SPEC),indent=2))
s='''import SFT.Physics.StationarySpectrum
namespace SFT.Physics.StationaryWitnesses
open StationarySpectrum VacuumSpectrum
structure Witness where
 name : String
 statement : String
 passed : Bool
def depthTwoCheck : Bool := match stationarySpectrum (.integer 2) with
 | .error _ => false
 | .ok xs => pairs xs == [(1,8),(3,8),(5,8),(7,8)]
def gapsFrom (prior : SFT.Foundation.ExactOperations.PositiveFraction) : List SFT.Foundation.ExactOperations.PositiveFraction → List Rat
 | [] => []
 | x::xs => LeptonIntervals.subtract (BoundaryGrowth.asFraction x) (BoundaryGrowth.asFraction prior)::gapsFrom x xs
def distinctGaps (xs : List Rat) : List Rat := xs.foldl (fun kept x => if kept.any (fun y => same x y) then kept else kept++[x]) []
def uniformCheck : Bool := ([1,2,3,4,5] : List Nat).all fun depth =>
 match stationarySpectrum (.integer (.ofNat depth)) with
 | .error _ => false
 | .ok values => match values with
  | [] => false
  | first::rest => (distinctGaps (gapsFrom first rest)).length == 1
def witnesses : List Witness := [WITNESS_ROWS]
theorem depthTwoCheckPassed : depthTwoCheck=true := rfl
theorem uniformCheckPassed : uniformCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (depthTwoCheck && uniformCheck && true)=true
 rw [depthTwoCheckPassed,uniformCheckPassed]
 rfl
end SFT.Physics.StationaryWitnesses
''';(w/'stationary_witness885.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','stationary885_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','StationarySpectrum')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','Stationary')").replace('work/freephase_witness883.txt','work/stationary_witness885.txt').replace("['dispersionCheck','routeCheck']","['depthTwoCheck','uniformCheck']");exec(compile(s,'stationary885','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'Stationary{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['StationarySpectrum']+['Stationary'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
