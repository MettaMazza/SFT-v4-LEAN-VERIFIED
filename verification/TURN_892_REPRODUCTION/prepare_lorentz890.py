from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import LORENTZ_TRANSFER_SPEC
corr=json.load(open(c/'reference/CORRESPONDENCE.json'))
for m in ['LorentzTransferEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:
 for key in ['modules','evidence_modules']:
  for row in corr[key]:
   if row.get('module')=='SFT/Physics/'+m+'.lean':assert row.get('v3_claim')==LORENTZ_TRANSFER_SPEC.claim_id
(w/'lorentz890_spec.json').write_text(json.dumps(asdict(LORENTZ_TRANSFER_SPEC),indent=2))
s='''import SFT.Physics.LorentzTransfer
namespace SFT.Physics.LorentzTransferEntryWitnesses
open LorentzTransfer
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def original := lorentzTransfer (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩)
def retainedCheck : Bool := match original with
 | .error _ => false
 | .ok x => same x.retainedForce ⟨3,16,by decide,by decide⟩
def partitionCheck : Bool := match original with
 | .error _ => false
 | .ok x => same (LeptonIntervals.add x.retainedForce x.motionShare) ⟨1,4,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem retainedCheckPassed : retainedCheck=true := by unfold retainedCheck original;rw [originalSourceRecord];rfl
theorem partitionCheckPassed : partitionCheck=true := by unfold partitionCheck original;rw [originalSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (retainedCheck && partitionCheck && true)=true
 rw [retainedCheckPassed,partitionCheckPassed]
 rfl
end SFT.Physics.LorentzTransferEntryWitnesses
''';(w/'lorentz_witness890.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','lorentz890_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','LorentzTransfer')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','LorentzTransferEntry')").replace('work/freephase_witness883.txt','work/lorentz_witness890.txt').replace("['dispersionCheck','routeCheck']","['retainedCheck','partitionCheck']");exec(compile(s,'lorentz890','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'LorentzTransferEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['LorentzTransfer','LorentzSourceProofs']+['LorentzTransferEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
