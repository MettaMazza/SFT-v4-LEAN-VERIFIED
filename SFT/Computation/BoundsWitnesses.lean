import SFT.Computation.BoundResources
namespace SFT.Computation.BoundsWitnesses
open ResourceRecord
structure Witness where
  name : String
  statement : String
  passed : Bool

def sourceLedger := resourceLedger ["step-a","step-b"] ["state-a","state-b"]
def timeCheck : Bool := match sourceLedger with
 | .error _ => false
 | .ok ledger => decide (ledger.timeCount = 2)
def spaceCheck : Bool := match sourceLedger with
 | .error _ => false
 | .ok ledger => decide (ledger.spaceCount = 2)
def traceCheck : Bool := match sourceLedger with
 | .error _ => false
 | .ok ledger => decide (ledger.timeTrace.length = 2)
def witnesses : List Witness := [
 ⟨"complexity-witness-1","complexity exact operational witness 1 for SFT-COMP-CPLX-BOUNDS-001",timeCheck⟩,
 ⟨"complexity-witness-2","complexity exact operational witness 2 for SFT-COMP-CPLX-BOUNDS-001",spaceCheck⟩,
 ⟨"complexity-witness-3","complexity exact operational witness 3 for SFT-COMP-CPLX-BOUNDS-001",traceCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl
end SFT.Computation.BoundsWitnesses
