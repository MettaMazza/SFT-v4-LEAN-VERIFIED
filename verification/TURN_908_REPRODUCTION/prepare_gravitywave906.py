from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import GRAVITY_WAVE_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/GravityWaveEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'gravitywave906_spec.json').write_text(json.dumps(asdict(GRAVITY_WAVE_SPEC),indent=2))
s='''import SFT.Physics.GravityWaveTrace
namespace SFT.Physics.GravityWaveEntryWitnesses
open GravityWaveTrace
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def speedCheck : Bool := match gravitationalWaveTrace with
 | .error _ => false
 | .ok x => same x.speed ⟨1,1,by decide,by decide⟩
def phaseCheck : Bool := match gravitationalWaveTrace with
 | .error _ => false
 | .ok x => match x.phaseTrace with
   | [] => false
   | h::tail => tail.all (fun q => same q h)
def quadrupoleCheck : Bool := match gravitationalWaveTrace with
 | .error _ => false
 | .ok x => decide (x.firstUnfrozenSecondDifferences=[12,18])
def witnesses : List Witness := [WITNESS_ROWS]
theorem speedCheckPassed : speedCheck=true := by unfold speedCheck;rw [completeSourceRecord];rfl
theorem phaseCheckPassed : phaseCheck=true := by unfold phaseCheck;rw [completeSourceRecord];rfl
theorem quadrupoleCheckPassed : quadrupoleCheck=true := by unfold quadrupoleCheck;rw [completeSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (speedCheck && phaseCheck && quadrupoleCheck && true)=true
 rw [speedCheckPassed,phaseCheckPassed,quadrupoleCheckPassed]
 rfl
end SFT.Physics.GravityWaveEntryWitnesses
''';(w/'gravitywave_witness906.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','gravitywave906_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','GravityWaveEntry')").replace('work/freephase_witness883.txt','work/gravitywave_witness906.txt').replace("['dispersionCheck','routeCheck']","['speedCheck','phaseCheck','quadrupoleCheck']");exec(compile(s,'gravitywave906','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'GravityWaveEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['GravityWaveTrace']+['GravityWaveEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
