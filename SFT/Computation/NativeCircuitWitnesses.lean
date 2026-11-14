import SFT.Computation.NativeCircuitPaths
import SFT.Computation.NativeCircuitCensus
namespace SFT.Computation.NativeCircuitWitnesses
open NativeCircuit NativeCircuitCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000

def resourceWitness : Bool := (List.range 14).all (fun i => decide (circuitResources (i+1)=(i+1,2^(i+1),layeredCount (i+1))))
def subsetWitness : Bool := survivorMasks.length==1
def attainmentWitness : Bool := (List.range 14).all (fun i => SFT.Mathematics.DiscreteObjects.distinct (forcedEdges (i+1)))

theorem allResourceWitnesses (depths : List Nat) : depths.all (fun i => decide (circuitResources (i+1)=(i+1,2^(i+1),layeredCount (i+1))))=true := by
 induction depths with
 | nil => rfl
 | cons n ns ih =>
   rw [List.all_cons,exactResources,decide_eq_true rfl,ih]
   rfl

theorem resourceWitnessPassed : resourceWitness=true := allResourceWitnesses (List.range 14)
theorem subsetWitnessPassed : subsetWitness=true := by
 unfold subsetWitness
 rw [completeSubsetCensus]; rfl

theorem allAttainmentWitnesses (depths : List Nat) :
 depths.all (fun i => SFT.Mathematics.DiscreteObjects.distinct (forcedEdges (i+1)))=true := by
 induction depths with
 | nil => rfl
 | cons n ns ih => rw [List.all_cons,edgesDistinct,ih]; rfl

theorem attainmentWitnessPassed : attainmentWitness=true := allAttainmentWitnesses (List.range 14)
end SFT.Computation.NativeCircuitWitnesses
