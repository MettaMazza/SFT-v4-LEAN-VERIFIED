from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import CTC_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/TimelikeEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'timelike911_spec.json').write_text(json.dumps(asdict(CTC_SPEC),indent=2))
s='''import SFT.Physics.SpacetimeAdmissibility
namespace SFT.Physics.TimelikeEntryWitnesses
open SpacetimeAdmissibility
structure Witness where
 name : String
 statement : String
 passed : Bool
def cycleCheck : Bool := closedTimelikeAdmissible ["state","proof"] ["state","proof"] true
def paradoxCheck : Bool := !closedTimelikeAdmissible ["state","proof"] ["changed-state","proof"] true
def traceCheck : Bool := !closedTimelikeAdmissible ["state","proof"] ["state","proof"] false
def witnesses : List Witness := [WITNESS_ROWS]
theorem cycleCheckPassed : cycleCheck=true := rfl
theorem paradoxCheckPassed : paradoxCheck=true := rfl
theorem traceCheckPassed : traceCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (cycleCheck && paradoxCheck && traceCheck && true)=true
 rw [cycleCheckPassed,paradoxCheckPassed,traceCheckPassed]
 rfl
end SFT.Physics.TimelikeEntryWitnesses
''';(w/'timelike_witness911.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','timelike911_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','TimelikeEntry')").replace('work/freephase_witness883.txt','work/timelike_witness911.txt').replace("['dispersionCheck','routeCheck']","['cycleCheck', 'paradoxCheck', 'traceCheck']");exec(compile(s,'timelike911','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'TimelikeEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['SpacetimeAdmissibility']+['TimelikeEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
