import SFT.Physics.TerminalBaryon
namespace SFT.Physics.TerminalBaryonEntryWitnesses
open TerminalBaryon
structure Witness where
 name : String
 statement : String
 passed : Bool
def halfCheck : Bool := terminalBaryonRelation.imbalanceShare == LeptonIntervals.normalize 1 2 (by decide)
def witnesses : List Witness := [⟨"half-One","The terminal successor preserves the exact imbalance share.",halfCheck⟩]
theorem halfCheckPassed : halfCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalBaryonEntryWitnesses
