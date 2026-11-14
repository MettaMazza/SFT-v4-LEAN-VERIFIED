from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_static901.py').read_text().replace('gravity_spacetime_laws_v1','matter_flavour_laws_v1').replace('STATIC_CLOCK_SPEC','QUARK_DRESSING_SPEC').replace('static901','quarkdressing916').replace('static_witness901','quarkdressing_witness916').replace('StaticFoldClockEntry','QuarkDressingEntry').replace('StaticFoldClock','QuarkDressing')
a=s.index("s='''");b=s.index("''';",a)
witness='''import SFT.Physics.QuarkDressing
namespace SFT.Physics.QuarkDressingEntryWitnesses
open QuarkDressing
structure Witness where
 name : String
 statement : String
 passed : Bool
def factorsCheck : Bool := match quarkDressingFactors with
 | .error _ => false
 | .ok f => (SFT.Foundation.ExactPartCarrier.asFraction SFT.Foundation.ExactOperations.one).blt f.centralDownLift && SFT.Physics.LeptonIntervals.zero.blt f.upperUpRetention && f.upperUpRetention.blt (SFT.Foundation.ExactPartCarrier.asFraction SFT.Foundation.ExactOperations.one)
def witnesses : List Witness := [WITNESS_ROWS]
theorem factorsCheckPassed : factorsCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.QuarkDressingEntryWitnesses
'''
s=s[:a]+"s='''"+witness+s[b:];s=s.replace("['covarianceCheck','rateCheck','horizonCheck']","['factorsCheck']");(w/'prepare_quarkdressing916.py').write_text(s)
for kind in ['entry','program','independent','original']:
 s=(w/f'check_static_{kind}901.py').read_text().replace('901','916').replace('static','quarkdressing').replace('StaticFoldClockEntry','QuarkDressingEntry').replace('StaticFoldClock','QuarkDressing').replace('StaticProgram','QuarkDressingProgram').replace('GRAVITY-STATIC-CLOCK','MATTER-QUARK-DRESSING').replace('STATIC_CLOCK_SPEC','QUARK_DRESSING_SPEC').replace('gravity_spacetime','matter_flavour');(w/f'check_quarkdressing_{kind}916.py').write_text(s)
s=(w/'prepare_static_native901.py').read_text().replace('901','916').replace('StaticFoldClockEntry','QuarkDressingEntry').replace('StaticProgram','QuarkDressingProgram');(w/'prepare_quarkdressing_native916.py').write_text(s)
(r/'QuarkDressingProgram916.lean').write_text((r/'StaticProgram901.lean').read_text().replace('StaticFoldClockEntry','QuarkDressingEntry'))
