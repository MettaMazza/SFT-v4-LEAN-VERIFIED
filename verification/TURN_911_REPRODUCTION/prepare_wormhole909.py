from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import WORMHOLE_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/WormholeEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'wormhole909_spec.json').write_text(json.dumps(asdict(WORMHOLE_SPEC),indent=2))
s='''import SFT.Physics.SpacetimeAdmissibility
namespace SFT.Physics.WormholeEntryWitnesses
open SpacetimeAdmissibility
structure Witness where
 name : String
 statement : String
 passed : Bool
def admissibleCheck : Bool := wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) true true
def remoteCheck : Bool := !wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) false true
def witnesses : List Witness := [WITNESS_ROWS]
theorem admissibleCheckPassed : admissibleCheck=true := rfl
theorem remoteCheckPassed : remoteCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (admissibleCheck && remoteCheck && true)=true
 rw [admissibleCheckPassed,remoteCheckPassed]
 rfl
end SFT.Physics.WormholeEntryWitnesses
''';(w/'wormhole_witness909.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','wormhole909_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','WormholeEntry')").replace('work/freephase_witness883.txt','work/wormhole_witness909.txt').replace("['dispersionCheck','routeCheck']","['admissibleCheck', 'remoteCheck']");exec(compile(s,'wormhole909','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'WormholeEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['SpacetimeAdmissibility']+['WormholeEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
