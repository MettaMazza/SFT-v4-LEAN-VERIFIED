from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import GRAVITON_POLARIZATION_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/GravitonPolarizationEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'graviton905_spec.json').write_text(json.dumps(asdict(GRAVITON_POLARIZATION_SPEC),indent=2))
s='''import SFT.Physics.GravitonPolarization
namespace SFT.Physics.GravitonPolarizationEntryWitnesses
open GravitonPolarization
structure Witness where
 name : String
 statement : String
 passed : Bool
def fourCheck : Bool := match gravitonPolarizations (.integer 4) with
 | .error _ => false
 | .ok x => match x.physicalPolarizations with
   | none => false
   | some n => n==2
def planarCheck : Bool := match gravitonPolarizations (.integer 3) with
 | .error _ => false
 | .ok x => x.physicalPolarizations.isNone
def witnesses : List Witness := [WITNESS_ROWS]
theorem fourCheckPassed : fourCheck=true := by unfold fourCheck;rw [originalFour];rfl
theorem planarCheckPassed : planarCheck=true := by unfold planarCheck;rw [originalPlanar];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (fourCheck && planarCheck && true)=true
 rw [fourCheckPassed,planarCheckPassed]
 rfl
end SFT.Physics.GravitonPolarizationEntryWitnesses
''';(w/'graviton_witness905.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','graviton905_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','GravitonPolarizationEntry')").replace('work/freephase_witness883.txt','work/graviton_witness905.txt').replace("['dispersionCheck','routeCheck']","['fourCheck','planarCheck']");exec(compile(s,'graviton905','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'GravitonPolarizationEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['GravitonPolarization']+['GravitonPolarizationEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
