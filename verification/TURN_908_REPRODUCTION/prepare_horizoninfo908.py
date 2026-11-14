from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import HORIZON_INFORMATION_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/HorizonInformationEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'horizoninfo908_spec.json').write_text(json.dumps(asdict(HORIZON_INFORMATION_SPEC),indent=2))
s='''import SFT.Physics.HorizonInformation
namespace SFT.Physics.HorizonInformationEntryWitnesses
open HorizonInformation
structure Witness where
 name : String
 statement : String
 passed : Bool
def localCheck : Bool := match horizonInformationLedger with
 | .error _ => false
 | .ok x => x.locallyClosedPredecessor.isEmpty
def boundaryCheck : Bool := match horizonInformationLedger with
 | .error _ => false
 | .ok x => x.retainedBoundaryRecords.length==8
def inverseCheck : Bool := match horizonInformationLedger with
 | .error _ => false
 | .ok x => x.reconstructibleWithCompleteInverseRecord
def witnesses : List Witness := [WITNESS_ROWS]
theorem localCheckPassed : localCheck=true := by unfold localCheck;rw [completeSourceRecord] <;> rfl
theorem boundaryCheckPassed : boundaryCheck=true := by unfold boundaryCheck;rw [completeSourceRecord] <;> rfl
theorem inverseCheckPassed : inverseCheck=true := by unfold inverseCheck;rw [completeSourceRecord] <;> rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (localCheck && boundaryCheck && inverseCheck && true)=true
 rw [localCheckPassed,boundaryCheckPassed,inverseCheckPassed]
 rfl
end SFT.Physics.HorizonInformationEntryWitnesses
''';(w/'horizoninfo_witness908.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','horizoninfo908_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','HorizonInformationEntry')").replace('work/freephase_witness883.txt','work/horizoninfo_witness908.txt').replace("['dispersionCheck','routeCheck']","['localCheck','boundaryCheck','inverseCheck']");exec(compile(s,'horizoninfo908','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'HorizonInformationEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['HorizonInformation']+['HorizonInformationEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
