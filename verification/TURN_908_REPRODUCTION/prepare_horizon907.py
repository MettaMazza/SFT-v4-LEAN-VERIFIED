from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import HORIZON_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/StrongHorizonEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'horizon907_spec.json').write_text(json.dumps(asdict(HORIZON_SPEC),indent=2))
s='''import SFT.Physics.StrongFieldHorizon
namespace SFT.Physics.StrongHorizonEntryWitnesses
open StrongFieldHorizon
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def radiusCheck : Bool := match strongFieldHorizon with
 | .error _ => false
 | .ok x => same x.radius ⟨1,2,by decide,by decide⟩
def areaCheck : Bool := match strongFieldHorizon with
 | .error _ => false
 | .ok x => same x.entropyCells ⟨8,1,by decide,by decide⟩
def positiveAt (n : Nat) : Bool := match finiteDistanceFloor (.integer (.ofNat (n+1))) with
 | .error _ => false
 | .ok q => LeptonIntervals.zero.blt q
def floorCheck : Bool := (List.range 16).all positiveAt
def thermalCheck : Bool := match strongFieldHorizon with
 | .error _ => false
 | .ok x => same x.normalizedThermalCarrier ⟨1,4,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem radiusCheckPassed : radiusCheck=true := by unfold radiusCheck;rw [completeSourceRecord];rfl
theorem areaCheckPassed : areaCheck=true := by unfold areaCheck;rw [completeSourceRecord];rfl
theorem positiveAtPassed (n : Nat) : positiveAt n=true := by unfold positiveAt;rw [everyPositiveDepth];exact everyFiniteFloorPositive n
theorem allDepthsPassed (xs : List Nat) : xs.all positiveAt=true := by
 induction xs with
 | nil => rfl
 | cons x xs ih => change (positiveAt x && xs.all positiveAt)=true;rw [positiveAtPassed,ih];rfl
theorem floorCheckPassed : floorCheck=true := allDepthsPassed _
theorem thermalCheckPassed : thermalCheck=true := by unfold thermalCheck;rw [completeSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (radiusCheck && areaCheck && floorCheck && thermalCheck && true)=true
 rw [radiusCheckPassed,areaCheckPassed,floorCheckPassed,thermalCheckPassed]
 rfl
end SFT.Physics.StrongHorizonEntryWitnesses
''';(w/'horizon_witness907.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','horizon907_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','StrongHorizonEntry')").replace('work/freephase_witness883.txt','work/horizon_witness907.txt').replace("['dispersionCheck','routeCheck']","['radiusCheck','areaCheck','floorCheck','thermalCheck']");exec(compile(s,'horizon907','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'StrongHorizonEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['StrongFieldHorizon']+['StrongHorizonEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
