from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import LATTICE_CURVATURE_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/LatticeCurvatureEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'lattice903_spec.json').write_text(json.dumps(asdict(LATTICE_CURVATURE_SPEC),indent=2))
s='''import SFT.Physics.LatticeCurvatureProofs
namespace SFT.Physics.LatticeCurvatureEntryWitnesses
open LatticeCurvature
structure Witness where
 name : String
 statement : String
 passed : Bool
def two (x : Except String Rat) : Bool := match x with
 | .error _ => false
 | .ok q => !q.blt ⟨2,1,by decide,by decide⟩ && !(⟨2,1,by decide,by decide⟩ : Rat).blt q
def spacingCheck : Bool := two (squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,8,by decide,by decide⟩)) &&
 two (squareLatticeCurvature (.fraction ⟨1,2,by decide,by decide⟩) (.fraction ⟨1,16,by decide,by decide⟩))
def count (x : Except String Int) (n : Int) : Bool := match x with
 | .error _ => false
 | .ok q => @decide (q=n) (Int.decEq q n)
def familyCheck : Bool :=
 let family := (latticeLaplacian (.integer 1) (.fraction ⟨1,8,by decide,by decide⟩),latticeLaplacian (.integer 2) (.fraction ⟨1,8,by decide,by decide⟩),latticeLaplacian (.integer 3) (.fraction ⟨1,8,by decide,by decide⟩))
 count family.1 2 && count family.2.1 4 && count family.2.2 6
def witnesses : List Witness := [WITNESS_ROWS]
theorem spacingCheckPassed : spacingCheck=true := by unfold spacingCheck;rw [eighthSpacing,sixteenthSpacing];rfl
theorem familyCheckPassed : familyCheck=true := by unfold familyCheck;rw [originalFamily];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (spacingCheck && familyCheck && true)=true
 rw [spacingCheckPassed,familyCheckPassed]
 rfl
end SFT.Physics.LatticeCurvatureEntryWitnesses
''';(w/'lattice_witness903.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','lattice903_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','LatticeCurvatureEntry')").replace('work/freephase_witness883.txt','work/lattice_witness903.txt').replace("['dispersionCheck','routeCheck']","['spacingCheck','familyCheck']");exec(compile(s,'lattice903','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'LatticeCurvatureEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['LatticeCurvature','LatticeCurvatureProofs']+['LatticeCurvatureEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
