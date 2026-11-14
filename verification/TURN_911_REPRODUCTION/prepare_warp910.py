from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import WARP_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/WarpEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'warp910_spec.json').write_text(json.dumps(asdict(WARP_SPEC),indent=2))
s='''import SFT.Physics.SpacetimeAdmissibility
namespace SFT.Physics.WarpEntryWitnesses
open SpacetimeAdmissibility
structure Witness where
 name : String
 statement : String
 passed : Bool
def admissibleCheck : Bool := warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) true
def ledgerCheck : Bool := !warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) false
def gainCheck : Bool := !warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩) true
def witnesses : List Witness := [WITNESS_ROWS]
theorem admissibleCheckPassed : admissibleCheck=true := rfl
theorem ledgerCheckPassed : ledgerCheck=true := rfl
theorem gainCheckPassed : gainCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (admissibleCheck && ledgerCheck && gainCheck && true)=true
 rw [admissibleCheckPassed,ledgerCheckPassed,gainCheckPassed]
 rfl
end SFT.Physics.WarpEntryWitnesses
''';(w/'warp_witness910.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','warp910_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','WarpEntry')").replace('work/freephase_witness883.txt','work/warp_witness910.txt').replace("['dispersionCheck','routeCheck']","['admissibleCheck', 'ledgerCheck', 'gainCheck']");exec(compile(s,'warp910','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'WarpEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['SpacetimeAdmissibility']+['WarpEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
