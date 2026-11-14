from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import INTERVAL_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/CausalIntervalEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'interval900_spec.json').write_text(json.dumps(asdict(INTERVAL_SPEC),indent=2))
s='''import SFT.Physics.CausalInterval
namespace SFT.Physics.CausalIntervalEntryWitnesses
open CausalInterval
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def massiveCheck : Bool := match intervalWitness with
 | .error _ => false
 | .ok x => (match x.intervalSquare with | none => false | some q => same q ⟨16,25,by decide,by decide⟩) && same x.properTime ⟨4,5,by decide,by decide⟩
def boundaryCheck : Bool := match exactInterval ⟨1,1,by decide,by decide⟩ ⟨1,1,by decide,by decide⟩ with
 | .error _ => false
 | .ok x => x.intervalSquare.isNone
def witnesses : List Witness := [WITNESS_ROWS]
theorem massiveCheckPassed : massiveCheck=true := by unfold massiveCheck;rw [originalMassiveRecord];rfl
theorem boundaryCheckPassed : boundaryCheck=true := by unfold boundaryCheck;rw [originalBoundary];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (massiveCheck && boundaryCheck && true)=true
 rw [massiveCheckPassed,boundaryCheckPassed]
 rfl
end SFT.Physics.CausalIntervalEntryWitnesses
''';(w/'interval_witness900.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','interval900_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','CausalIntervalEntry')").replace('work/freephase_witness883.txt','work/interval_witness900.txt').replace("['dispersionCheck','routeCheck']","['massiveCheck','boundaryCheck']");exec(compile(s,'interval900','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'CausalIntervalEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['CausalInterval']+['CausalIntervalEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
