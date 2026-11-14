from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.atomic_spectra_completion_laws_v1 import CUBIC_SPEC
(w/'cubicatomic944_spec.json').write_text(json.dumps(asdict(CUBIC_SPEC),indent=2))
(w/'cubicatomic_witness944.txt').write_text('''import SFT.Physics.CubicAtomicSupport
namespace SFT.Physics.CubicAtomicSupportEntryWitnesses
open CubicAtomicSupport LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def coordinationCheck : Bool := match cubicCoordination with
 | .error _ => false
 | .ok n => n == 6
def weightCheck : Bool := match cubicNeighbourWeight with
 | .error _ => false
 | .ok q => q == normalize 1 12 (by decide)
def balanceCheck : Bool := match cubicBalance with
 | .error _ => false
 | .ok q => q == normalize 1 2 (by decide)
def witnesses : List Witness := [WITNESS_ROWS]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.CubicAtomicSupportEntryWitnesses
''')
gen=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','cubicatomic944_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','CubicAtomicSupportEntry')").replace('work/freephase_witness883.txt','work/cubicatomic_witness944.txt').replace("['dispersionCheck','routeCheck']","['coordinationCheck','weightCheck','balanceCheck']");exec(compile(gen,'original-cubic-eight-axis','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'CubicAtomicSupportEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s.replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]'))
for m in ['CubicAtomicSupport']+['CubicAtomicSupportEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
