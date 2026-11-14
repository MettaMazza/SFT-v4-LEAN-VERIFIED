from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import FINITE_LOOP_SPEC
corr=json.load(open(c/'reference/CORRESPONDENCE.json'))
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert not any(row.get('module')=='SFT/Physics/FiniteLoopEntry'+suffix+'.lean' for key in ['modules','evidence_modules'] for row in corr[key])
(w/'finiteloop894_spec.json').write_text(json.dumps(asdict(FINITE_LOOP_SPEC),indent=2))
s='''import SFT.Physics.FiniteLoopProofs
namespace SFT.Physics.FiniteLoopEntryWitnesses
open FiniteLoop
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def outputs := (List.range 6).map (fun n => finiteLoopSum (.integer (.ofNat (n+1))))
def expected : List Rat := [⟨1,2,by decide,by decide⟩,⟨3,4,by decide,by decide⟩,⟨7,8,by decide,by decide⟩,⟨15,16,by decide,by decide⟩,⟨31,32,by decide,by decide⟩,⟨63,64,by decide,by decide⟩]
def prefixCheck : Bool := (outputs.zip expected).all (fun (a,b) => match a with | .error _ => false | .ok a => same a b)
def boundaryCheck : Bool := (List.range 16).all (fun n => match finiteLoopSum (.integer (.ofNat (n+1))) with | .error _ => false | .ok x => LeptonIntervals.zero.blt x && x.blt ⟨1,1,by decide,by decide⟩)
def witnesses : List Witness := [WITNESS_ROWS]
theorem prefixCheckPassed : prefixCheck=true := by unfold prefixCheck outputs;rw [originalDepths];rfl
set_option maxRecDepth 20000 in
set_option maxHeartbeats 100000000 in
theorem boundaryCheckPassed : boundaryCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (prefixCheck && (boundaryCheck && true))=true
 rw [prefixCheckPassed,boundaryCheckPassed]
 rfl
end SFT.Physics.FiniteLoopEntryWitnesses
''';(w/'finiteloop_witness894.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','finiteloop894_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','FiniteLoopProofs')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','FiniteLoopEntry')").replace('work/freephase_witness883.txt','work/finiteloop_witness894.txt').replace("['dispersionCheck','routeCheck']","['prefixCheck','boundaryCheck']");exec(compile(s,'finiteloop894','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'FiniteLoopEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['FiniteLoop','FiniteLoopProofs']+['FiniteLoopEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
