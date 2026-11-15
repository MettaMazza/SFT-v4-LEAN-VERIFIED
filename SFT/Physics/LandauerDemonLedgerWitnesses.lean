import SFT.Physics.LandauerDemonLedgerDerivation
namespace SFT.Physics.LandauerDemonLedgerWitnesses
open LandauerDemonLedger
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def ratCheck : Except String Rat → Rat → Bool
 | .error _,_ => false
 | .ok x,q => equalRat x q
def preimageCheck : Except String (Rat × Rat) → Bool
 | .error _ => false
 | .ok (a,b) => ratCheck (foldPart (.fraction a)) halfOne && ratCheck (foldPart (.fraction b)) halfOne
def countCheck : Except String Nat → Bool
 | .ok n => n==1
 | .error _ => false
def cycleCheck : Except String CycleLedger → Bool
 | .ok l => l.complete
 | .error _ => false
def resetCheck : Bool := preimageCheck resetPreimages
def distinctionCheck : Bool := countCheck erasedDistinctionCount
def throwCheck : Bool := ratCheck minimumThrow halfOne
def reversalCheck : Bool := reversibleResetLabels.all resetIsReversibleWithRecord
def ledgerCheck : Bool := cycleCheck demonCycleLedger
def witnesses : List Witness := [⟨"two-to-one-reset","Both exact predecessors Fold to the common half-One image.",resetCheck⟩,⟨"one-distinction","The complete reset closes exactly one binary predecessor label.",distinctionCheck⟩,⟨"half-One-throw","The two exact preimages are separated by half-One.",throwCheck⟩,⟨"record-reversal","Either retained fibre label identifies the source class.",reversalCheck⟩,⟨"demon-ledger","One gained distinction equals one exported reverse label.",ledgerCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.LandauerDemonLedgerWitnesses
