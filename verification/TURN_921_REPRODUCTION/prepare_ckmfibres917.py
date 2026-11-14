from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_laws_v1 import CKM_FIBRE_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/CKMFibreEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'ckmfibres917_spec.json').write_text(json.dumps(asdict(CKM_FIBRE_SPEC),indent=2))
s='''import SFT.Physics.CKMFibres
namespace SFT.Physics.CKMFibreEntryWitnesses
open CKMFibres
structure Witness where
 name : String
 statement : String
 passed : Bool
def matrixCheck : Bool := match ckmFibres with
 | .error _ => false
 | .ok f => decide (f.matrix=originalRecord.matrix)
def witnesses : List Witness := [WITNESS_ROWS]
theorem matrixCheckPassed : matrixCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.CKMFibreEntryWitnesses
''';(w/'ckmfibres_witness917.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','ckmfibres917_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','CKMFibreEntry')").replace('work/freephase_witness883.txt','work/ckmfibres_witness917.txt').replace("['dispersionCheck','routeCheck']","['matrixCheck']");exec(compile(s,'ckmfibres917','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'CKMFibreEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['CKMFibres']+['CKMFibreEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
