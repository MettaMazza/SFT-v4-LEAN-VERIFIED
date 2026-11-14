from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.relativistic_field_laws_v1 import COULOMB_GAUSS_SPEC
(w/'coulomb888_spec.json').write_text(json.dumps(asdict(COULOMB_GAUSS_SPEC),indent=2))
s='''import SFT.Physics.CoulombGauss
namespace SFT.Physics.CoulombWitnesses
open CoulombGauss
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def innerCheck : Bool := match coulombGaussClosure sourceEighth (.fraction innerRadius) with
 | .error _ => false
 | .ok x => same (BoundaryGrowth.asFraction x.flux) sourceEighth && same x.retainedPotential ⟨1,2,by decide,by decide⟩
def outerCheck : Bool := match coulombGaussClosure sourceEighth (.fraction outerRadius) with
 | .error _ => false
 | .ok x => same (BoundaryGrowth.asFraction x.flux) sourceEighth && same x.retainedPotential ⟨3,4,by decide,by decide⟩
def witnesses : List Witness := [WITNESS_ROWS]
theorem innerCheckPassed : innerCheck=true := by unfold innerCheck;rw [innerSourceRecord];rfl
theorem outerCheckPassed : outerCheck=true := by unfold outerCheck;rw [outerSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (innerCheck && outerCheck && true)=true
 rw [innerCheckPassed,outerCheckPassed]
 rfl
end SFT.Physics.CoulombWitnesses
''';(w/'coulomb_witness888.txt').write_text(s)
s=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','coulomb888_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','CoulombGauss')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','Coulomb')").replace('work/freephase_witness883.txt','work/coulomb_witness888.txt').replace("['dispersionCheck','routeCheck']","['innerCheck','outerCheck']");exec(compile(s,'coulomb888','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'Coulomb{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s)
for m in ['CoulombGauss']+['Coulomb'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
