import SFT.InformationScience.MutualObservation
import SFT.Host.Text
namespace SFT.Computation.SecurityPartition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

def insert (x : String) : List String → List String
  | [] => [x]
  | y::ys => if SFT.Host.Text.le x y then x::y::ys else y::insert x ys

def ordered : List String → List String
  | [] => []
  | x::xs => insert x (ordered xs)

def rows (support : List String) (observations : Observation) : List (String × List String) :=
  (ordered (SFT.Mathematics.ProbabilityIndependence.firstLabels (observations.map Prod.snd))).map
    (fun view => (view,ordered (fibre support observations view)))

def partition (support : List String) (observations : Observation) : Except String (List (String × List String)) :=
  if !distinct support then .error "ValueError: messages must contain unique generated identities"
  else if !(keysMatch support observations && decide (observations.length = support.length)) then
    .error "ValueError: security observation must cover each message exactly once"
  else .ok (rows support observations)

theorem insertMembership (x q : String) (xs : List String) : q ∈ insert x xs ↔ q = x ∨ q ∈ xs := by
  induction xs with
  | nil =>
    constructor
    · intro h; cases h with
      | head => exact .inl rfl
      | tail _ h => cases h
    · intro h; cases h with
      | inl h => cases h; exact .head _
      | inr h => cases h
  | cons y ys ih =>
    unfold insert
    cases test : SFT.Host.Text.le x y with
    | true =>
      constructor
      · intro h; cases h with
        | head => exact .inl rfl
        | tail _ h => exact .inr h
      · intro h; cases h with
        | inl h => cases h; exact .head _
        | inr h => exact .tail _ h
    | false =>
      constructor
      · intro h; cases h with
        | head => exact .inr (.head _)
        | tail _ h => cases ih.mp h with
          | inl h => exact .inl h
          | inr h => exact .inr (.tail _ h)
      · intro h; cases h with
        | inl h => exact .tail _ (ih.mpr (.inl h))
        | inr h => cases h with
          | head => exact .head _
          | tail _ h => exact .tail _ (ih.mpr (.inr h))

theorem orderedMembership (xs : List String) (q : String) : q ∈ ordered xs ↔ q ∈ xs := by
  induction xs with
  | nil => exact ⟨fun h => h,fun h => h⟩
  | cons x xs ih =>
    constructor
    · intro h; cases (insertMembership x q (ordered xs)).mp h with
      | inl h => cases h; exact .head _
      | inr h => exact .tail _ (ih.mp h)
    · intro h; apply (insertMembership x q (ordered xs)).mpr
      cases h with
      | head => exact .inl rfl
      | tail _ h => exact .inr (ih.mpr h)

theorem sortedFibreMeaning (support : List String) (observations : Observation) (view message : String) :
    message ∈ ordered (fibre support observations view) ↔
    message ∈ support ∧ image observations message = some view :=
  (orderedMembership _ _).trans (fibreMembership _ _ _ _)

theorem partitionMeaning (support : List String) (observations : Observation) (result : List (String × List String)) :
    partition support observations = .ok result ↔
    distinct support = true ∧ keysMatch support observations = true ∧
    observations.length = support.length ∧ result = rows support observations := by
  unfold partition
  cases unique : distinct support with
  | false =>
    constructor
    · intro h; cases h
    · intro h; cases h.1
  | true =>
    cases valid : keysMatch support observations && decide (observations.length = support.length) with
    | false =>
      constructor
      · intro h; cases h
      · intro h
        have yes := (andTrue _ _).mpr ⟨h.2.1,decide_eq_true h.2.2.1⟩
        rw [valid] at yes; cases yes
    | true =>
      have h := (andTrue _ _).mp valid
      constructor
      · intro eq; cases eq; exact ⟨rfl,h.1,of_decide_eq_true h.2,rfl⟩
      · intro eq; cases eq.2.2.2; rfl

theorem classMeaning (support : List String) (observations : Observation) (view : String) (members : List String) :
    (view,members) ∈ rows support observations ↔
    view ∈ observations.map Prod.snd ∧ members = ordered (fibre support observations view) := by
  constructor
  · intro h
    obtain ⟨v,held,eq⟩ := memMapPreimage _ _ _ h
    have id := congrArg Prod.fst eq
    cases id
    exact ⟨(SFT.Mathematics.ProbabilityIndependence.firstLabelsMembership _ _).mp
      ((orderedMembership _ _).mp held),(congrArg Prod.snd eq).symm⟩
  · intro h
    cases h.2
    exact memMap _ view _ ((orderedMembership _ _).mpr
      ((SFT.Mathematics.ProbabilityIndependence.firstLabelsMembership _ _).mpr h.1))

theorem separatedClasses (support : List String) (observations : Observation) (a b x : String)
    (left : x ∈ ordered (fibre support observations a)) (right : x ∈ ordered (fibre support observations b)) : a = b := by
  have ha := (sortedFibreMeaning _ _ _ _).mp left
  have hb := (sortedFibreMeaning _ _ _ _).mp right
  exact Option.some.inj (ha.2.symm.trans hb.2)

end SFT.Computation.SecurityPartition
