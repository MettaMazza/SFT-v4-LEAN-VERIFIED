import SFT.Physics.LandauerDemonLedgerWitnesses
namespace SFT.Physics.LandauerValidationWitnesses
open LandauerDemonLedgerWitnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def witnesses : List Witness := [⟨"one-distinction","The admitted reset closes exactly one predecessor label.",distinctionCheck⟩,⟨"native-throw","The native two-preimage separation is exact half-One.",throwCheck⟩,⟨"closed-ledger","The demon cycle exports the distinction it gains.",ledgerCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.LandauerValidationWitnesses
