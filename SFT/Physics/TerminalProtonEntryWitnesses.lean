import SFT.Physics.TerminalProton
namespace SFT.Physics.TerminalProtonEntryWitnesses
open TerminalProton LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def complementCheck : Bool := originalRecord.heavyComplement == wholeRatio 53
def supportCheck : Bool := match compositeSupport with
 | .error _ => false
 | .ok n => n == 30
def dressingCheck : Bool := (normalize 1 (10^6) (by decide)).blt originalRecord.dressing && originalRecord.dressing.blt (normalize 1 1000 (by decide))
def retentionCheck : Bool := add originalRecord.retention originalRecord.dressing == wholeRatio 1
def witnesses : List Witness := [⟨"depth-three-complement","The complete depth-three binary/generator support forces heavy complement 53.",complementCheck⟩,⟨"bulk-boundary-support","Colour bulk 27 and three carried boundary channels close to 30.",supportCheck⟩,⟨"two-route-dressing","Expanded and typed routes return the same exact positive dressing.",dressingCheck⟩,⟨"positive-retention","The complete dressing is held without exhausting the One.",retentionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalProtonEntryWitnesses
