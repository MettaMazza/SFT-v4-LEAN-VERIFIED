import SFT.InformationScience.ConservationComposition
namespace SFT.InformationScience.ConservationReverse
open ConservationLedger
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

inductive Predecessors where
  | unique : String → Predecessors
  | heldLabels : List String → Predecessors
  deriving DecidableEq

def predecessorRecord : List String → Predecessors
  | [] => .heldLabels []
  | first :: rest => match rest with
    | [] => .unique first
    | next :: tail => .heldLabels (first :: next :: tail)

def reverseRows (fibres : List (String × List String)) : List (String × Predecessors) :=
  fibres.map (fun row => (row.1,predecessorRecord row.2))

def reverseRecord (source : List String) (transformation : Observation) : Except String (List (String × Predecessors)) :=
  match transformationLedger source transformation with
  | .error e => .error e
  | .ok ledger => .ok (reverseRows ledger.predecessorFibres)

def isReversible (source : List String) (transformation : Observation) : Except String Bool :=
  match validateTransformation source transformation with
  | .error e => .error e
  | .ok images => .ok (decide ((firstLabels (images.map Prod.snd)).length = source.length))

theorem uniqueIff (members : List String) (state : String) :
    predecessorRecord members = .unique state ↔ members = [state] := by
  cases members with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil =>
      constructor
      · intro h; have eq := Predecessors.unique.inj h; cases eq; rfl
      · intro h; have eq := List.cons.inj h; cases eq.1; rfl
    | cons next tail => constructor <;> intro h <;> cases h

theorem heldIff (members retained : List String) :
    predecessorRecord members = .heldLabels retained ↔ retained = members ∧ members.length ≠ 1 := by
  cases members with
  | nil =>
    constructor
    · intro h; exact ⟨(Predecessors.heldLabels.inj h).symm,by decide⟩
    · intro h; rw [h.1]; rfl
  | cons first rest =>
    cases rest with
    | nil =>
      constructor
      · intro h; cases h
      · intro h; exact False.elim (h.2 rfl)
    | cons next tail =>
      constructor
      · intro h
        exact ⟨(Predecessors.heldLabels.inj h).symm,by intro eq; exact Nat.noConfusion (Nat.succ.inj eq)⟩
      · intro h; rw [h.1]; rfl

theorem rowMembership (fibres : List (String × List String)) (label : String) (record : Predecessors) :
    (label,record) ∈ reverseRows fibres ↔ ∃ members, (label,members) ∈ fibres ∧ predecessorRecord members = record := by
  constructor
  · intro h
    obtain ⟨row,hm,eq⟩ := memMapPreimage (fun row : String × List String => (row.1,predecessorRecord row.2)) (label,record) fibres h
    have key := congrArg Prod.fst eq
    have val := congrArg Prod.snd eq
    refine ⟨row.2,?_,val⟩
    change row.1 = label at key
    rw [← key]
    exact hm
  · intro ⟨members,hm,eq⟩
    have h := memMap (fun row : String × List String => (row.1,predecessorRecord row.2)) (label,members) fibres hm
    rw [eq] at h
    exact h

theorem reverseAdmitted (source : List String) (transformation : Observation)
    (valid : validateTransformation source transformation = .ok transformation) :
    reverseRecord source transformation = .ok (reverseRows (classRows source transformation)) := by
  unfold reverseRecord
  rw [ledgerAdmitted _ _ valid]
  rfl

theorem uniquePredecessor (source : List String) (transformation : Observation) (label state : String)
    (row : (label,.unique state) ∈ reverseRows (classRows source transformation)) :
    fibre source transformation label = [state] := by
  obtain ⟨members,hm,hr⟩ := (rowMembership _ _ _).mp row
  have same := ((SFT.Mathematics.ProbabilityObservations.rowMembership _ _ _ _).mp hm).2
  exact same.symm.trans ((uniqueIff _ _).mp hr)

theorem uniqueRecovery (source : List String) (transformation : Observation) (label state other : String)
    (row : (label,.unique state) ∈ reverseRows (classRows source transformation))
    (hm : other ∈ source) (hi : image transformation other = some label) : other = state := by
  have hf := (fibreMembership _ _ _ _).mpr ⟨hm,hi⟩
  rw [uniquePredecessor _ _ _ _ row] at hf
  cases hf with
  | head => rfl
  | tail _ h => cases h

theorem heldPredecessors (source : List String) (transformation : Observation) (label : String) (members : List String)
    (row : (label,.heldLabels members) ∈ reverseRows (classRows source transformation)) :
    members = fibre source transformation label ∧ members.length ≠ 1 := by
  obtain ⟨original,hm,hr⟩ := (rowMembership _ _ _).mp row
  have h := (heldIff _ _).mp hr
  have same := ((SFT.Mathematics.ProbabilityObservations.rowMembership _ _ _ _).mp hm).2
  exact ⟨h.1.trans same,h.1 ▸ h.2⟩

theorem heldRecovery (source : List String) (transformation : Observation) (label : String) (members : List String)
    (row : (label,.heldLabels members) ∈ reverseRows (classRows source transformation)) (state : String) :
    state ∈ members ↔ state ∈ source ∧ image transformation state = some label := by
  rw [(heldPredecessors _ _ _ _ row).1]
  exact fibreMembership _ _ _ _

theorem distinctPredecessorsNotUnique (members : List String) (left right : String)
    (hl : left ∈ members) (hr : right ∈ members) (ne : left ≠ right) :
    ∀ state, predecessorRecord members ≠ .unique state := by
  intro state eq
  have singleton := (uniqueIff _ _).mp eq
  rw [singleton] at hl hr
  have el : left = state := by cases hl with | head => rfl | tail _ h => cases h
  have er : right = state := by cases hr with | head => rfl | tail _ h => cases h
  exact ne (el.trans er.symm)

theorem reversibleAdmitted (source : List String) (transformation : Observation)
    (valid : validateTransformation source transformation = .ok transformation) :
    isReversible source transformation = .ok (decide ((firstLabels (transformation.map Prod.snd)).length = source.length)) := by
  unfold isReversible; rw [valid]

end SFT.InformationScience.ConservationReverse
