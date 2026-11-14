from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_laws_v1 import CKM_PHYSICAL_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/PhysicalCKMEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'ckmphysical918_spec.json').write_text(json.dumps(asdict(CKM_PHYSICAL_SPEC),indent=2))
s='''import SFT.Physics.MatterIdentityGraphs
namespace SFT.Physics.PhysicalCKMEntryWitnesses
open MatterIdentityGraphs
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match ckmPhysicalIdentity with
 | .error _ => false
 | .ok f => decide (f.apexSquared=(⟨1,6,by decide,by decide⟩ : Rat))
def witnesses : List Witness := [WITNESS_ROWS]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.PhysicalCKMEntryWitnesses
''';(w/'ckmphysical_witness918.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','ckmphysical918_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','PhysicalCKMEntry')").replace('work/freephase_witness883.txt','work/ckmphysical_witness918.txt').replace("['dispersionCheck','routeCheck']","['identityCheck']");exec(compile(s,'ckmphysical918','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'PhysicalCKMEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['MatterIdentityGraphs']+['PhysicalCKMEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
