import SFT.Chemistry.MolecularStateTransition
import SFT.QuantumComputation.Measurement
namespace SFT.Chemistry.MolecularMeasurement
open SFT.Host SFT.Physics.CapabilityValues

-- molecular_measurement_law_v1.py: MolecularObservationMap, in original field order.
structure Observation where
 preparedState : HeldLabel
 probeClass : HeldLabel
 retainedCoordinates : List HeldLabel
 closedCoordinates : List HeldLabel
 outcomeRecord : HeldLabel
 postObservationState : HeldLabel
 instrument : HeldLabel
 condition : HeldLabel

def reconstructs (m : Observation) (coordinate : String) : Bool :=
 m.retainedCoordinates.any (fun x => Text.equal x.label coordinate)

def validate (m : Observation) : Except String Observation :=
 if !([(m.preparedState,"prepared-molecular-state"),(m.probeClass,"molecular-observation-class"),
     (m.outcomeRecord,"molecular-readout-record"),(m.postObservationState,"post-observation-molecular-state"),
     (m.instrument,"measurement-instrument"),(m.condition,"measurement-condition")].all
       (fun (x,family) => Text.equal x.family family)) then
  .error "observation boundary lost a required held family"
 else if m.retainedCoordinates.isEmpty then .error "an observation must retain at least one declared coordinate"
 else if !(m.retainedCoordinates.all (fun x => Text.equal x.family "retained-molecular-coordinate")) ||
    !(m.closedCoordinates.all (fun x => Text.equal x.family "closed-molecular-coordinate")) then
  .error "retained and closed coordinates require distinct families"
 else if m.closedCoordinates.any (fun x => reconstructs m x.label) then
  .error "one coordinate cannot be both retained and closed"
 else .ok m

theorem acceptedRecordUnchanged (m result : Observation) (accepted : validate m = .ok result) : result = m := by
 unfold validate at accepted
 split at accepted <;> try { cases accepted }
 split at accepted <;> try { cases accepted }
 split at accepted <;> try { cases accepted }
 split at accepted <;> try { cases accepted }
 exact (Except.ok.inj accepted).symm

theorem acceptedPartition (m result : Observation) (accepted : validate m = .ok result) :
 m.closedCoordinates.any (fun x => reconstructs m x.label) = false := by
 unfold validate at accepted
 split at accepted <;> try { cases accepted }
 split at accepted <;> try { cases accepted }
 split at accepted <;> try { cases accepted }
 split at accepted
 · cases accepted
 · rename_i h
   exact Bool.eq_false_iff.mpr h

theorem acceptedNonempty (m result : Observation) (accepted : validate m = .ok result) :
 m.retainedCoordinates.isEmpty = false := by
 unfold validate at accepted
 split at accepted <;> try { cases accepted }
 split at accepted
 · cases accepted
 · rename_i h
   exact Bool.eq_false_iff.mpr h

theorem reconstructionExact (m : Observation) (coordinate : String) :
 reconstructs m coordinate = m.retainedCoordinates.any (fun x => Text.equal x.label coordinate) := rfl

-- Original induction base/successor retain the whole observation, including adverse records.
def oneObservation (m : Observation) : List Observation := [m]
def appendObservation (prior : List Observation) (m : Observation) : List Observation := prior ++ [m]
theorem leastObservation (m : Observation) : (oneObservation m).length = 1 := rfl
theorem successorLength (prior : List Observation) (m : Observation) :
 (appendObservation prior m).length = prior.length + 1 := by
 induction prior with
 | nil => rfl
 | cons x xs ih =>
  change (xs ++ [m]).length + 1 = (xs.length + 1) + 1
  exact congrArg Nat.succ ih
theorem successorRetains (prior : List Observation) (m x : Observation) (held : x ∈ prior) :
 x ∈ appendObservation prior m := List.mem_append_left [m] held
theorem successorAdds (prior : List Observation) (m : Observation) : m ∈ appendObservation prior m :=
 List.mem_append_right prior (List.Mem.head [])

def witness : Observation :=
 ⟨⟨"prepared-molecular-state","CaH-J-one",by rfl,by rfl⟩,
  ⟨"molecular-observation-class","quantum-logic-projection",by rfl,by rfl⟩,
  [⟨"retained-molecular-coordinate","rotational-manifold",by rfl,by rfl⟩],
  [⟨"closed-molecular-coordinate","unrecorded-pre-probe-path",by rfl,by rfl⟩],
  ⟨"molecular-readout-record","atomic-fluorescence-record",by rfl,by rfl⟩,
  ⟨"post-observation-molecular-state","CaH-J-one-reprojected",by rfl,by rfl⟩,
  ⟨"measurement-instrument","Ca-plus-logic-ion",by rfl,by rfl⟩,
  ⟨"measurement-condition","registered-trap-condition",by rfl,by rfl⟩⟩
def retainedWitness : Bool := reconstructs witness "rotational-manifold"
def closedWitness : Bool := !reconstructs witness "unrecorded-pre-probe-path"
def overlapWitness : Bool := match validate {witness with
 closedCoordinates := [⟨"closed-molecular-coordinate","rotational-manifold",by rfl,by rfl⟩]} with
 | .error _ => true
 | .ok _ => false
theorem witnessAccepted : validate witness = .ok witness := rfl
theorem retainedWitnessPassed : retainedWitness = true := rfl
theorem closedWitnessPassed : closedWitness = true := rfl
theorem overlapWitnessPassed : overlapWitness = true := rfl
end SFT.Chemistry.MolecularMeasurement
