import SFT.InformationScience.MutualConditional
namespace SFT.InformationScience.MutualDecisions
open MutualObservation MutualParts
open SFT.Mathematics.ProbabilityObservations

-- Compare the presented member list, exactly as the source does.
def counted (row : MutualConditional.ConditionalRow) (label : String) : Bool :=
  decide (row.givenLabel = label) && decide (row.members ≠ ["empty-One"])

def resolvedRows (rows : List MutualConditional.ConditionalRow) (classes : List (String × List String)) : Bool :=
  classes.all (fun c => decide ((rows.filter (fun row => counted row c.1)).length = 1))

def conditionallyResolved (support : List String) (targetMap givenMap : Observation) : Except String Bool :=
  match validateObservation support targetMap with
  | .error e => .error e
  | .ok targetImages => match MutualObservation.observationClasses support givenMap with
    | .error e => .error e
    | .ok classes => match MutualConditional.conditionalLedger support targetMap givenMap with
      | .error e => .error e
      | .ok rows => .ok (resolvedRows rows classes && !targetImages.isEmpty)

def factorCell (row : MutualJoint.JointRow) : Bool :=
  match row.jointPart with
  | .emptyOne => false
  | .part _ => decide (row.relation = .equal)

def factorizes (support : List String) (left right : Observation) : Except String Bool :=
  match MutualJoint.jointLedger support left right with
  | .error e => .error e
  | .ok rows => .ok (rows.all factorCell)

inductive Dependence where
  | emptyOne
  | cells : List MutualJoint.JointRow → Dependence

def responsible (rows : List MutualJoint.JointRow) : List MutualJoint.JointRow :=
  rows.filter (fun row => decide (row.relation ≠ .equal))

def presentDependence : List MutualJoint.JointRow → Dependence
  | [] => .emptyOne
  | row :: rest => .cells (row :: rest)

def dependenceLedger (support : List String) (left right : Observation) : Except String Dependence :=
  match MutualJoint.jointLedger support left right with
  | .error e => .error e
  | .ok rows => .ok (presentDependence (responsible rows))

theorem countedMeaning (row : MutualConditional.ConditionalRow) (label : String) :
    counted row label = true ↔ row.givenLabel = label ∧ row.members ≠ ["empty-One"] := by
  unfold counted
  constructor
  · intro h
    have pair := (SFT.Foundation.Count.Representation.andTrue _ _).mp h
    exact ⟨of_decide_eq_true pair.1,of_decide_eq_true pair.2⟩
  · intro h
    exact (SFT.Foundation.Count.Representation.andTrue _ _).mpr ⟨decide_eq_true h.1,decide_eq_true h.2⟩

theorem allMeaning {α : Type} (p : α → Bool) (xs : List α) :
    xs.all p = true ↔ ∀ x, x ∈ xs → p x = true := by
  induction xs with
  | nil => exact ⟨fun _ x h => False.elim (List.not_mem_nil h),fun _ => rfl⟩
  | cons x xs ih =>
    change (p x && xs.all p) = true ↔ _
    constructor
    · intro h y hy
      have pair := (SFT.Foundation.Count.Representation.andTrue _ _).mp h
      have hx := pair.1
      have ht := ih.mp pair.2
      cases hy with
      | head => exact hx
      | tail _ hm => exact ht y hm
    · intro h
      exact (SFT.Foundation.Count.Representation.andTrue _ _).mpr ⟨h x (List.Mem.head _),ih.mpr (fun y hy => h y (List.Mem.tail _ hy))⟩

theorem resolutionMeaning (rows : List MutualConditional.ConditionalRow) (classes : List (String × List String)) :
    resolvedRows rows classes = true ↔ ∀ c, c ∈ classes →
      (rows.filter (fun row => counted row c.1)).length = 1 := by
  unfold resolvedRows
  constructor
  · intro h c hc; exact of_decide_eq_true ((allMeaning _ _).mp h c hc)
  · intro h; exact (allMeaning _ _).mpr (fun c hc => decide_eq_true (h c hc))

theorem factorCellMeaning (row : MutualJoint.JointRow) :
    factorCell row = true ↔ (∃ part, row.jointPart = .part part) ∧ row.relation = .equal := by
  unfold factorCell
  cases h : row.jointPart with
  | emptyOne =>
    constructor
    · intro bad; cases bad
    · intro ⟨⟨p,bad⟩,_⟩; cases bad
  | part p =>
    constructor
    · intro eq; exact ⟨⟨p,rfl⟩,of_decide_eq_true eq⟩
    · intro eq; exact decide_eq_true eq.2

theorem factorizationMeaning (rows : List MutualJoint.JointRow) :
    rows.all factorCell = true ↔ ∀ row, row ∈ rows →
      (∃ part, row.jointPart = .part part) ∧ row.relation = .equal := by
  exact ⟨fun h row hr => (factorCellMeaning row).mp ((allMeaning _ _).mp h row hr),
    fun h => (allMeaning _ _).mpr (fun row hr => (factorCellMeaning row).mpr (h row hr))⟩

theorem responsibleMeaning (rows : List MutualJoint.JointRow) (row : MutualJoint.JointRow) :
    row ∈ responsible rows ↔ row ∈ rows ∧ row.relation ≠ .equal := by
  unfold responsible
  constructor
  · intro h
    have pair := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp h
    exact ⟨pair.1,of_decide_eq_true pair.2⟩
  · intro h
    exact (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem dependenceEmpty (rows : List MutualJoint.JointRow) :
    presentDependence rows = .emptyOne ↔ rows = [] := by
  cases rows with
  | nil => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | cons row rest => constructor <;> intro h <;> cases h

theorem rawSentinelExcluded (label targetLabel : String) (part : ExactCell) :
    counted ⟨label,targetLabel,["empty-One"],part⟩ label = false := by
  change (decide (label = label) && false) = false
  exact Bool.and_false _

end SFT.InformationScience.MutualDecisions
