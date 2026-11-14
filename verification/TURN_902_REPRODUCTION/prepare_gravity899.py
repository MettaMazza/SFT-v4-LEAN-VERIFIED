from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import GRAVITY_FLUX_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/GravityFluxEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'gravity899_spec.json').write_text(json.dumps(asdict(GRAVITY_FLUX_SPEC),indent=2))
s='''import SFT.Physics.GravitySourceProofs
namespace SFT.Physics.GravityFluxEntryWitnesses
open GravityFlux
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def innerCheck : Bool := match weakGravity (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) with
 | .error _ => false
 | .ok x => same x.flux ⟨1,8,by decide,by decide⟩ && same x.clockPotential ⟨1,2,by decide,by decide⟩
def outerCheck : Bool := match weakGravity (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩) with
 | .error _ => false
 | .ok x => same x.flux ⟨1,8,by decide,by decide⟩ && same x.clockPotential ⟨3,4,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem innerCheckPassed : innerCheck=true := by unfold innerCheck;rw [innerSourceRecord];rfl
theorem outerCheckPassed : outerCheck=true := by unfold outerCheck;rw [outerSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (innerCheck && outerCheck && true)=true
 rw [innerCheckPassed,outerCheckPassed]
 rfl
end SFT.Physics.GravityFluxEntryWitnesses
''';(w/'gravity_witness899.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','gravity899_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','GravityFluxEntry')").replace('work/freephase_witness883.txt','work/gravity_witness899.txt').replace("['dispersionCheck','routeCheck']","['innerCheck','outerCheck']");exec(compile(s,'gravity899','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'GravityFluxEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['GravityFlux','GravitySourceProofs']+['GravityFluxEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
