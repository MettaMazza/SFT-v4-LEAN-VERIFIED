import SFT.Physics.TerminalFine
namespace SFT.Physics.TerminalFineEntryWitnesses
open TerminalFine LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
def turnSupportCheck : Bool :=
 match TerminalTurn.terminalTurnProjection with
 | .error _ => false
 | .ok turn => match TerminalLamb.terminalBinarySupport with
   | .error _ => false
   | .ok support => turn.den==113 && support==16
def downBoundaryCheck : Bool :=
 match AlphaCovers.positivePower (.integer 2) (.integer 5) with
 | .error _ => false
 | .ok down => match AlphaCovers.positivePower (.integer 3) (.integer 2) with
   | .error _ => false
   | .ok boundary => down*boundary==288
def endpointCheck : Bool := (AtomicBoundary.atomicEndpoint.toOption.getD 0)==137
def carrierCheck : Bool := (normalize 1 (10^6) (by decide)).blt terminalFineExpected && terminalFineExpected.blt (normalize 1 100000 (by decide))
def witnesses : List Witness := [⟨"turn-support","Terminal turn denominator and support are 113 and 16.",turnSupportCheck⟩,⟨"down-boundary","Down support times generator boundary closes at 288.",downBoundaryCheck⟩,⟨"endpoint","The terminal atomic whole endpoint is 137.",endpointCheck⟩,⟨"positive-terminal-carrier","The terminal fine/Rydberg ratio is one exact positive part.",carrierCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.TerminalFineEntryWitnesses
