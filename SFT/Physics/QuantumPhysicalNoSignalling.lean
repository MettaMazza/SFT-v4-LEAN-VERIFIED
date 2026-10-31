import SFT.Physics.QuantumPhysicalClassicalLimit
namespace SFT.Physics.QuantumPhysicalNoSignalling
open SFT.Foundation.CommonRefinement

def relabel {Local Remote Other : Type} (pairing : ExactPairing Remote Other)
    (rows : List (Local × Remote)) := rows.map (fun row => (row.1,pairing.forward row.2))

theorem completeRemoteRelabellingReversible {Local Remote Other : Type}
    (pairing : ExactPairing Remote Other) (rows : List (Local × Remote)) :
    (relabel pairing rows).map (fun row => (row.1,pairing.backward row.2)) = rows := by
  induction rows with
  | nil => rfl
  | cons row rest ih =>
    change (row.1,pairing.backward (pairing.forward row.2)) :: _ = row :: rest
    rw [pairing.leftInverse row.2]
    exact congrArg (List.cons row) ih

theorem entireLocalProjectionUnchanged {Local Remote Other : Type}
    (pairing : ExactPairing Remote Other) (rows : List (Local × Remote)) :
    (relabel pairing rows).map Prod.fst = rows.map Prod.fst := by
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.1) ih

def localCount {Local Remote : Type} (rows : List (Local × Remote)) (observed : Local → Bool) :=
  ((rows.map Prod.fst).filter observed).length

theorem exactLocalFibreCountUnchanged {Local Remote Other : Type}
    (pairing : ExactPairing Remote Other) (rows : List (Local × Remote)) (observed : Local → Bool) :
    localCount (relabel pairing rows) observed = localCount rows observed :=
  congrArg (fun values => (values.filter observed).length) (entireLocalProjectionUnchanged pairing rows)

theorem completeSupportCountUnchanged {Local Remote Other : Type}
    (pairing : ExactPairing Remote Other) (rows : List (Local × Remote)) :
    (relabel pairing rows).length = rows.length := mapLength _ _

theorem exactLocalWeightDataUnchanged {Local Remote Other : Type}
    (pairing : ExactPairing Remote Other) (rows : List (Local × Remote)) (observed : Local → Bool) :
    (localCount (relabel pairing rows) observed,(relabel pairing rows).length) =
      (localCount rows observed,rows.length) := by
  rw [exactLocalFibreCountUnchanged,completeSupportCountUnchanged]

theorem changedArrivalRequiresGeneratedPredecessor {State : Type}
    {adjacent : MechanicalEvents.Event State → MechanicalEvents.Event State → Prop}
    {source destination : MechanicalEvents.Event State}
    (trace : FieldLocality.Propagation adjacent source destination) (changed : source ≠ destination) :
    ∃ predecessor, adjacent predecessor destination := FieldLocality.nonInitialHasPredecessor trace changed

theorem noResponseOutsideCompletedCausalSupport {State : Type}
    {adjacent : MechanicalEvents.Event State → MechanicalEvents.Event State → Prop}
    {source destination : MechanicalEvents.Event State}
    (completed : List (FieldLocality.Arrival adjacent source))
    (outside : destination ∉ FieldLocality.accessible completed) :
    ¬ ∃ arrival ∈ completed, arrival.destination = destination :=
  FieldLocality.inaccessibleOutsideCompleted completed outside
end SFT.Physics.QuantumPhysicalNoSignalling
