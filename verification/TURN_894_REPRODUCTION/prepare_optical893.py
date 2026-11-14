from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import OPTICAL_OPERATIONS_SPEC
corr=json.load(open(c/'reference/CORRESPONDENCE.json'))
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert not any(row.get('module')=='SFT/Physics/OpticalEntry'+suffix+'.lean' for key in ['modules','evidence_modules'] for row in corr[key])
(w/'optical893_spec.json').write_text(json.dumps(asdict(OPTICAL_OPERATIONS_SPEC),indent=2))
s='''import SFT.Physics.OpticalOperations
namespace SFT.Physics.OpticalEntryWitnesses
open OpticalOperations
structure Witness where
 name : String
 statement : String
 passed : Bool
def walkCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => x.propagation.length==8 && x.propagation.all (same ⟨1,3,by decide,by decide⟩)
def polarizationCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => x.polarization==["transverse-left","transverse-right"]
def interferenceCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => same x.brightSupport ⟨1,1,by decide,by decide⟩ && x.darkRecord.isEmpty
def mixingCheck : Bool := match exactOpticalOperations with
 | .error _ => false
 | .ok x => same x.mixing.sum ⟨7,12,by decide,by decide⟩ && same x.mixing.positiveDifference ⟨1,12,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem walkCheckPassed : walkCheck=true := by unfold walkCheck;rw [completeSourceRecord];rfl
theorem polarizationCheckPassed : polarizationCheck=true := by unfold polarizationCheck;rw [completeSourceRecord];rfl
theorem interferenceCheckPassed : interferenceCheck=true := by unfold interferenceCheck;rw [completeSourceRecord];rfl
theorem mixingCheckPassed : mixingCheck=true := by unfold mixingCheck;rw [completeSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (walkCheck && (polarizationCheck && (interferenceCheck && (mixingCheck && true))))=true
 rw [walkCheckPassed,polarizationCheckPassed,interferenceCheckPassed,mixingCheckPassed]
 rfl
end SFT.Physics.OpticalEntryWitnesses
''';(w/'optical_witness893.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','optical893_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','OpticalOperations')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','OpticalEntry')").replace('work/freephase_witness883.txt','work/optical_witness893.txt').replace("['dispersionCheck','routeCheck']","['walkCheck','polarizationCheck','interferenceCheck','mixingCheck']");exec(compile(s,'optical893','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'OpticalEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['OpticalOperations']+['OpticalEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
