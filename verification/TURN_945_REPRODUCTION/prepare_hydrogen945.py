from pathlib import Path
import json,sys,shutil,re
from dataclasses import asdict
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.atomic_spectra_completion_laws_v1 import HYDROGEN_SPEC
(w/'hydrogen945_spec.json').write_text(json.dumps(asdict(HYDROGEN_SPEC),indent=2))
(w/'hydrogen_witness945.txt').write_text('''import SFT.Physics.HydrogenSpectrum
namespace SFT.Physics.HydrogenSpectrumEntryWitnesses
open HydrogenSpectrum LeptonIntervals
structure Witness where
 name : String
 statement : String
 passed : Bool
def groundCheck : Bool := match hydrogenLevel (.integer 1) with
 | .error _ => false
 | .ok q => q == normalize 1 1 (by decide)
def lymanCheck : Bool := match hydrogenTransition (.integer 2) (.integer 1) with
 | .error _ => false
 | .ok q => q == normalize 3 4 (by decide)
def balmerCheck : Bool := match hydrogenTransition (.integer 3) (.integer 2) with
 | .error _ => false
 | .ok q => q == normalize 5 36 (by decide)
def witnesses : List Witness := [WITNESS_ROWS]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.HydrogenSpectrumEntryWitnesses
''')
gen=(w/'generate_freephase883.py').read_text().replace('freephase883_spec.json','hydrogen945_spec.json').replace("replace('SpatialStability','FreePhase')","replace('SpatialStability','GravityFlux')").replace("replace('SpatialThree','FreePhase')","replace('SpatialThree','HydrogenSpectrumEntry')").replace('work/freephase_witness883.txt','work/hydrogen_witness945.txt').replace("['dispersionCheck','routeCheck']","['groundCheck','lymanCheck','balmerCheck']");exec(compile(gen,'original-cubic-eight-axis','exec'))
for suffix in ['Controls','Evidence']:
 p=r/'SFT/Physics'/f'HydrogenSpectrumEntry{suffix}.lean';s='import SFT.Foundation.AdmissionControls\n'+p.read_text();parts=re.split(r'("(?:\\.|[^"\\])*"|--[^\n]*)',s);s=''.join(re.sub(r'\bidentity\b','SFT.Foundation.AdmissionControls.admissionIdentity',x) if i%2==0 else x for i,x in enumerate(parts));p.write_text(s.replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]'))
for m in ['HydrogenSpectrum']+['HydrogenSpectrumEntry'+x for x in ['Witnesses','Grammar','Controls','Evidence']]:shutil.copy2(r/'SFT/Physics'/f'{m}.lean',c/'SFT/Physics'/f'{m}.lean')
