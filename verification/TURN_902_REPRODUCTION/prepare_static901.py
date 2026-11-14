from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.gravity_spacetime_laws_v1 import STATIC_CLOCK_SPEC
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text())
registered={row.get('module') for key in ['modules','evidence_modules'] for row in corr[key]}
for suffix in ['Witnesses','Grammar','Controls','Evidence']:
 assert 'SFT/Physics/StaticFoldClockEntry'+suffix+'.lean' not in registered, 'Refusing to overwrite a registered module'
(w/'static901_spec.json').write_text(json.dumps(asdict(STATIC_CLOCK_SPEC),indent=2))
s='''import SFT.Physics.StaticFoldClock
namespace SFT.Physics.StaticFoldClockEntryWitnesses
open StaticFoldClock
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def covarianceCheck : Bool := match staticClock (.fraction ⟨1,8,by decide,by decide⟩) with
 | .error _ => false
 | .ok .horizon => false
 | .ok (.accessible _ folded) => same folded ⟨3,4,by decide,by decide⟩
def rateCheck : Bool := match exactClockRate with
 | .error _ => false
 | .ok rate => same rate ⟨3,4,by decide,by decide⟩
def horizonCheck : Bool := match staticClock (.fraction ⟨1,1,by decide,by decide⟩) with
 | .error _ => false
 | .ok .horizon => true
 | .ok (.accessible _ _) => false
def witnesses : List Witness := [WITNESS_ROWS]
theorem covarianceCheckPassed : covarianceCheck=true := by unfold covarianceCheck;rw [originalCovariance];rfl
theorem rateCheckPassed : rateCheck=true := by unfold rateCheck;rw [originalRate];rfl
theorem horizonCheckPassed : horizonCheck=true := by unfold horizonCheck;rw [originalHorizon]
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (covarianceCheck && rateCheck && horizonCheck && true)=true
 rw [covarianceCheckPassed,rateCheckPassed,horizonCheckPassed]
 rfl
end SFT.Physics.StaticFoldClockEntryWitnesses
''';(w/'static_witness901.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','static901_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','StaticFoldClockEntry')").replace('work/freephase_witness883.txt','work/static_witness901.txt').replace("['dispersionCheck','routeCheck']","['covarianceCheck','rateCheck','horizonCheck']");exec(compile(s,'static901','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'StaticFoldClockEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['StaticFoldClock']+['StaticFoldClockEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
