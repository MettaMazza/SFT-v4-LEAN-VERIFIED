from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import TWO_HAND_DIRAC_SPEC
(w/'twohand886_spec.json').write_text(json.dumps(asdict(TWO_HAND_DIRAC_SPEC),indent=2))
s='''import SFT.Physics.TwoHandDirac
namespace SFT.Physics.TwoHandWitnesses
open TwoHandDirac
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def partsCheck : Bool := match twoHandDiracSquare with
 | .error _ => false
 | .ok x => same x.momentum ⟨3,5,by decide,by decide⟩ && same x.mass ⟨4,5,by decide,by decide⟩
def squareCheck : Bool := match twoHandDiracSquare with
 | .error _ => false
 | .ok x => same x.energySquare ⟨1,1,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem partsCheckPassed : partsCheck=true := by unfold partsCheck;rw [sourceAssembly];rfl
theorem squareCheckPassed : squareCheck=true := by unfold squareCheck;rw [sourceAssembly];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (partsCheck && squareCheck && true)=true
 rw [partsCheckPassed,squareCheckPassed]
 rfl
end SFT.Physics.TwoHandWitnesses
''';(w/'twohand_witness886.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','twohand886_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','TwoHandDirac')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','TwoHand')").replace('work/freephase_witness883.txt','work/twohand_witness886.txt').replace("['dispersionCheck','routeCheck']","['partsCheck','squareCheck']");exec(compile(s,'twohand886','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'TwoHand{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['TwoHandDirac']+['TwoHand'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
