import SFT.Physics.InflationGrowthCertificate
namespace SFT.Physics.InflationObservationWitnesses
open InflationGrowthCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def formalCover : Bool := match certificate with | .error _ => false | .ok c => c.depth == 5 && c.support == 32
def formalPartition : Bool := match certificate with | .error _ => false | .ok c => c.completePrimordialPartition
def formalGrowth : Bool := match certificate with | .error _ => false | .ok c => c.strictGrowth && c.transfer
def witnesses : List Witness := [⟨"cover","The formal cover is depth five and support thirty-two.",formalCover⟩,⟨"partition","The formal scalar/tensor partition closes exactly to One.",formalPartition⟩,⟨"growth","The formal two-step growth and component transfer are exact.",formalGrowth⟩]
theorem formalCoverPassed : formalCover=true := by decide +kernel
theorem formalPartitionPassed : formalPartition=true := by decide +kernel
theorem formalGrowthPassed : formalGrowth=true := by decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed=true := by decide +kernel
end SFT.Physics.InflationObservationWitnesses
