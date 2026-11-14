from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import NONLINEAR_GRAVITY_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/GravitySelfSourceEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'selfsource904_spec.json').write_text(json.dumps(asdict(NONLINEAR_GRAVITY_SPEC),indent=2))
s='''import SFT.Physics.GravitySelfSource
namespace SFT.Physics.GravitySelfSourceEntryWitnesses
open GravitySelfSource
structure Witness where
 name : String
 statement : String
 passed : Bool
def sourceCheck : Bool := match nonlinearGravity with
 | .error _ => false
 | .ok x => !x.selfSourceCorrection.blt ⟨1,72,by decide,by decide⟩ && !(⟨1,72,by decide,by decide⟩ : Rat).blt x.selfSourceCorrection
def witnesses : List Witness := [WITNESS_ROWS]
theorem sourceCheckPassed : sourceCheck=true := by unfold sourceCheck;rw [completeSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (sourceCheck && true)=true
 rw [sourceCheckPassed]
 rfl
end SFT.Physics.GravitySelfSourceEntryWitnesses
''';(w/'selfsource_witness904.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','selfsource904_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','GravitySelfSourceEntry')").replace('work/freephase_witness883.txt','work/selfsource_witness904.txt').replace("['dispersionCheck','routeCheck']","['sourceCheck']");exec(compile(s,'selfsource904','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'GravitySelfSourceEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['GravitySelfSource']+['GravitySelfSourceEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
