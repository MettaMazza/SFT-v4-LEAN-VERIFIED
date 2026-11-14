from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_laws_v1 import PMNS_CP_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/PMNSPhysicalEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'pmnsphysical922_spec.json').write_text(json.dumps(asdict(PMNS_CP_SPEC),indent=2))
s='''import SFT.Physics.PMNSPhysical
namespace SFT.Physics.PMNSPhysicalEntryWitnesses
open PMNSPhysical
structure Witness where
 name : String
 statement : String
 passed : Bool
def identityCheck : Bool := match pmnsCPStructure with
 | .error _ => false
 | .ok f => decide (f.electronWeights=originalRecord.electronWeights) && decide (f.cpPhase=(⟨1,2,by decide,by decide⟩ : Rat))
def witnesses : List Witness := [WITNESS_ROWS]
theorem identityCheckPassed : identityCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.PMNSPhysicalEntryWitnesses
''';(w/'pmnsphysical_witness922.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','pmnsphysical922_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','PMNSPhysicalEntry')").replace('work/freephase_witness883.txt','work/pmnsphysical_witness922.txt').replace("['dispersionCheck','routeCheck']","['identityCheck']");exec(compile(s,'pmnsphysical922','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'PMNSPhysicalEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['PMNSPhysical']+['PMNSPhysicalEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
