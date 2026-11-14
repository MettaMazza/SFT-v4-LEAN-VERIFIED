from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_magneticanomaly925.py').read_text().replace('matter_flavour_laws_v1','matter_flavour_completion_laws_v1').replace('MAGNETIC_ANOMALY_SPEC','GENERATION_DEPTH_SPEC').replace('magneticanomaly925','generationdepth936').replace('magneticanomaly_witness925','generationdepth_witness936').replace('MagneticAnomalyEntry','GenerationDepthEntry').replace('MagneticAnomaly','GenerationDepth')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.GenerationDepth
namespace SFT.Physics.GenerationDepthEntryWitnesses
open GenerationDepth
structure Witness where
 name : String
 statement : String
 passed : Bool
def depthCheck : Bool := match generationDepth with
 | .error _ => false
 | .ok result => result.generatorSteps == 2
def witnesses : List Witness := [WITNESS_ROWS]
theorem depthCheckPassed : depthCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.GenerationDepthEntryWitnesses
''';s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['leadingCheck','bareCheck']","['depthCheck']");exec(compile(s,'mixing-original-generator','exec'),dict(globals()))
for kind in ['entry','program','independent','original']:
 s=(w/f'check_baryonphoton_{kind}931.py').read_text().replace('931','936').replace('baryonphoton','generationdepth').replace('BaryonPhotonEntry','GenerationDepthEntry').replace('BaryonPhotonTransport','GenerationDepth').replace('MATTER-BARYON-PHOTON','MATTER-GENERATION-DEPTH').replace('BARYON_PHOTON_SPEC','GENERATION_DEPTH_SPEC');(w/f'check_generationdepth_{kind}936.py').write_text(s)
s=(w/'prepare_baryonphoton_native931.py').read_text().replace('931','936').replace('BaryonPhotonEntry','GenerationDepthEntry').replace('BaryonPhotonTransportProgram','GenerationDepthProgram');(w/'prepare_generationdepth_native936.py').write_text(s)
(r/'GenerationDepthProgram936.lean').write_text((r/'BaryonPhotonTransportProgram931.lean').read_text().replace('BaryonPhotonEntry','GenerationDepthEntry'))
