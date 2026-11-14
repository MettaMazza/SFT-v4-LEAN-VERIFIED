from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import FULL_DIRAC_SPEC
(w/'fulldirac887_spec.json').write_text(json.dumps(asdict(FULL_DIRAC_SPEC),indent=2))
s='''import SFT.Physics.FullDiracSquare
namespace SFT.Physics.FullDiracWitnesses
open FullDiracSquare
structure Witness where
 name : String
 statement : String
 passed : Bool
def sameOne (a : Rat) : Bool := !a.blt (⟨1,1,by decide,by decide⟩ : Rat) && !(⟨1,1,by decide,by decide⟩ : Rat).blt a
def directCheck : Bool := match fullDiracSquare with
 | .error _ => false
 | .ok x => sameOne x.directSquare
def polarizedCheck : Bool := match fullDiracSquare with
 | .error _ => false
 | .ok x => sameOne x.polarizedSquare
def absenceCheck : Bool := match fullDiracSquare with
 | .error _ => false
 | .ok x => x.heldEqualDifferences.length == 2 && x.heldEqualDifferences.all (fun d => match d with | .empty => true | .left _ => false | .right _ => false)
def witnesses : List Witness := [WITNESS_ROWS]
theorem directCheckPassed : directCheck=true := by unfold directCheck;rw [sourceAssembly];rfl
theorem polarizedCheckPassed : polarizedCheck=true := by unfold polarizedCheck;rw [sourceAssembly];rfl
theorem absenceCheckPassed : absenceCheck=true := by unfold absenceCheck;rw [sourceAssembly];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (directCheck && polarizedCheck && absenceCheck && true)=true
 rw [directCheckPassed,polarizedCheckPassed,absenceCheckPassed]
 rfl
end SFT.Physics.FullDiracWitnesses
''';(w/'fulldirac_witness887.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','fulldirac887_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','FullDiracSquare')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','FullDirac')").replace('work/freephase_witness883.txt','work/fulldirac_witness887.txt').replace("['dispersionCheck','routeCheck']","['directCheck','polarizedCheck','absenceCheck']");exec(compile(s,'fulldirac887','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'FullDirac{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['FullDiracSquare']+['FullDirac'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
for name in ['prepare_twohand_native886.py','check_twohand_program886.py','check_twohand_independent886.py','check_twohand_original886.py']:
 s=(w/name).read_text().replace('TwoHand','FullDirac').replace('twohand','fulldirac').replace('886','887').replace('TWO_HAND_DIRAC_SPEC','FULL_DIRAC_SPEC').replace('SFT-PHYS-RELATIVITY-TWO-HAND-DIRAC-SQUARE-003','SFT-PHYS-RELATIVITY-FULL-DIRAC-SQUARE-003');(w/name.replace('twohand','fulldirac').replace('886','887')).write_text(s)
s=(r/'TwoHandProgram886.lean').read_text().replace('TwoHand','FullDirac');(r/'FullDiracProgram887.lean').write_text(s)
s=(w/'check_twohand_entry886.py').read_text().replace('TwoHand','FullDirac').replace('twohand','fulldirac').replace('886','887').replace("mods=['FullDiracDirac']","mods=['FullDiracSquare']");(w/'check_fulldirac_entry887.py').write_text(s)
