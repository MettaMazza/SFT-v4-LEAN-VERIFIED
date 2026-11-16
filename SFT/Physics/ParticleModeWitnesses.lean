import SFT.Physics.ParticleModeCertificate
namespace SFT.Physics.ParticleModeWitnesses
open ParticleModeCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def readFlag (field : Certificate → Bool) (result : Except String Certificate) : Bool :=
 match result with | .error _ => false | .ok c => field c
def witness0 : Bool := readFlag Certificate.fibres theoremCertificate
theorem witness0Passed : witness0=true := congrArg (readFlag Certificate.fibres) originalCompleteCertificate
#print axioms witness0Passed
def witness1 : Bool := readFlag Certificate.coordinates theoremCertificate
theorem witness1Passed : witness1=true := congrArg (readFlag Certificate.coordinates) originalCompleteCertificate
#print axioms witness1Passed
def witness2 : Bool := readFlag Certificate.cover theoremCertificate
theorem witness2Passed : witness2=true := congrArg (readFlag Certificate.cover) originalCompleteCertificate
#print axioms witness2Passed
def witness3 : Bool := readFlag Certificate.placement theoremCertificate
theorem witness3Passed : witness3=true := congrArg (readFlag Certificate.placement) originalCompleteCertificate
#print axioms witness3Passed
def witness4 : Bool := readFlag Certificate.mass theoremCertificate
theorem witness4Passed : witness4=true := congrArg (readFlag Certificate.mass) originalCompleteCertificate
#print axioms witness4Passed
def witness5 : Bool := readFlag Certificate.dual theoremCertificate
theorem witness5Passed : witness5=true := congrArg (readFlag Certificate.dual) originalCompleteCertificate
#print axioms witness5Passed
def witness6 : Bool := readFlag Certificate.reach theoremCertificate
theorem witness6Passed : witness6=true := congrArg (readFlag Certificate.reach) originalCompleteCertificate
#print axioms witness6Passed
def witness7 : Bool := readFlag Certificate.transition theoremCertificate
theorem witness7Passed : witness7=true := congrArg (readFlag Certificate.transition) originalCompleteCertificate
#print axioms witness7Passed
def witnesses : List Witness := [⟨"general-fibres","The finite census and index induction force m preimages and m-2 fixed modes.",witness0⟩,⟨"generation-coordinates","All four coordinate records are complete ordered three-label carriers and none is relabelled as mass.",witness1⟩,⟨"cover-depths","The 27-cell volume uniquely forces binary depth five and colour depth three.",witness2⟩,⟨"particle-placement","Every finite recurrent trace census injects into internal stationary modes.",witness3⟩,⟨"terminal-mass-transport","All charged-lepton, quark and positive-neutrino sector carriers are retained while old site-as-mass claims reject.",witness4⟩,⟨"dual-seeds","The complete colour/binary dual reconstructs 1/95, 1/383 and 1/485.",witness5⟩,⟨"reach","Heavy/light equals exact subtraction reach at every checked depth and by the registered induction.",witness6⟩,⟨"transition","Quarter-mode separations close structurally without becoming a universal observed rate.",witness7⟩]
end SFT.Physics.ParticleModeWitnesses
