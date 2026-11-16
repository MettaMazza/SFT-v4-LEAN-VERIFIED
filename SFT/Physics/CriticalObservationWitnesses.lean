import SFT.Physics.CriticalityUniversality
namespace SFT.Physics.CriticalObservationWitnesses
open CriticalityUniversality
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalMeanfield : Bool := match theoremCertificate with | .error _ => false | .ok c => c.meanField
def formalIdentities : Bool := match theoremCertificate with | .error _ => false | .ok c => c.identities
def formalCascade : Bool := match theoremCertificate with | .error _ => false | .ok c => c.cascade
def formalClasses : Bool := match theoremCertificate with | .error _ => false | .ok c => c.classes
def witnesses : List Witness := [⟨"critical-powers","The complete exact critical perfect-power census is closed.",formalMeanfield⟩,⟨"identities","All exact critical scaling identities are closed.",formalIdentities⟩,⟨"cascade","The complete cube/square/fifth-power cascade census is closed.",formalCascade⟩,⟨"classes","The declared generated universality classes are distinct and complete.",formalClasses⟩]
theorem formalMeanfieldPassed : formalMeanfield=true := by decide +kernel
theorem formalIdentitiesPassed : formalIdentities=true := by decide +kernel
theorem formalCascadePassed : formalCascade=true := by decide +kernel
theorem formalClassesPassed : formalClasses=true := by decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 unfold witnesses
 change (formalMeanfield && (formalIdentities && (formalCascade && (formalClasses && true)))) = true
 rw [formalMeanfieldPassed,formalIdentitiesPassed,formalCascadePassed,formalClassesPassed]
 rfl
end SFT.Physics.CriticalObservationWitnesses
