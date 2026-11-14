import SFT.Physics.TerminalCKM
namespace SFT.Physics.TerminalCKMEntryWitnesses
open TerminalCKM
structure Witness where
 name : String
 statement : String
 passed : Bool
def routeCheck : Bool := match slopeContribution with
 | .error _ => false
 | .ok result => result == originalContribution
def witnesses : List Witness := [⟨"two-routes","Transport and direct reduced fractions return the same contribution.",routeCheck⟩]
theorem routeCheckPassed : routeCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalCKMEntryWitnesses
