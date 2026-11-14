from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import MAGNETIC_RELATIVITY_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/MagneticCorrection'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'magnetic889_spec.json').write_text(json.dumps(asdict(MAGNETIC_RELATIVITY_SPEC),indent=2))
s='''import SFT.Physics.MagneticRelativity
namespace SFT.Physics.MagneticCorrectionWitnesses
open MagneticRelativity
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def innerCheck : Bool := match magneticRelativisticFactor (.fraction ⟨1,2,by decide,by decide⟩) with
 | .error _ => false
 | .ok x => same x.electricRemainder ⟨3,4,by decide,by decide⟩ && same x.foldedRemainder ⟨1,2,by decide,by decide⟩
def outerCheck : Bool := match magneticRelativisticFactor (.fraction ⟨1,3,by decide,by decide⟩) with
 | .error _ => false
 | .ok x => same x.foldedRemainder ⟨7,9,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem innerCheckPassed : innerCheck=true := by unfold innerCheck;rw [halfSpeedSource];rfl
theorem outerCheckPassed : outerCheck=true := by unfold outerCheck;rw [thirdSpeedSource];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (innerCheck && outerCheck && true)=true
 rw [innerCheckPassed,outerCheckPassed]
 rfl
end SFT.Physics.MagneticCorrectionWitnesses
''';(w/'magnetic_witness889.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','magnetic889_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','MagneticRelativity')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','MagneticCorrection')").replace('work/freephase_witness883.txt','work/magnetic_witness889.txt').replace("['dispersionCheck','routeCheck']","['innerCheck','outerCheck']");exec(compile(s,'magnetic889','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'MagneticCorrection{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['MagneticRelativity']+['MagneticCorrection'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
