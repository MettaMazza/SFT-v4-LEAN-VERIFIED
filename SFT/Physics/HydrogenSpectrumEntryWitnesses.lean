import SFT.Physics.HydrogenSpectrum
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
def witnesses : List Witness := [⟨"ground","The first principal support is the One.",groundCheck⟩,⟨"lyman-alpha","The second-to-first gap is three-quarters.",lymanCheck⟩,⟨"balmer-alpha","The third-to-second gap is five-thirty-sixths.",balmerCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.HydrogenSpectrumEntryWitnesses
