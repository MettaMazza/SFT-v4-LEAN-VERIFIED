import SFT.Mathematics.AlgebraProperties
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Mathematics.AlgebraOperations
open DiscreteObjects SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

-- The exact One-carrier base stated in the original algebra LawSpec.
theorem oneCarrierAccepted :
    makeTable ["One"] [("One","One","One")] = .ok ⟨["One"],[("One","One","One")]⟩ := rfl

theorem oneCarrierPair : pairSupport ["One"] = [("One","One")] := rfl

theorem oneCarrierResult :
    applyOperation ⟨["One"],[("One","One","One")]⟩ "One" "One" = .ok "One" := rfl

theorem oneCarrierIdentity : hasIdentity ⟨["One"],[("One","One","One")]⟩ "One" = .ok true := rfl

theorem oneCarrierAssociation : isAssociative ⟨["One"],[("One","One","One")]⟩ = .ok true := rfl

-- Closure forces the unique result for every accepted singleton carrier.
theorem acceptedSingletonResult (one : String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable [one] rows = .ok table) :
    applyOperation table one one = .ok one := by
  obtain ⟨result,applied,member⟩ := acceptedLookupTotal [one] rows table accepted one one
    (List.Mem.head []) (List.Mem.head [])
  cases member with
  | head => exact applied
  | tail _ h => cases h

theorem pairSupportMember (carrier : List String) (a b : String) :
    (a,b) ∈ pairSupport carrier ↔ a ∈ carrier ∧ b ∈ carrier := by
  constructor
  · intro h
    obtain ⟨left,hl,branch⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨right,hr,eq⟩ := memMapPreimage (fun right => (left,right)) (a,b) carrier branch
    have ha := congrArg Prod.fst eq
    have hb := congrArg Prod.snd eq
    cases ha; cases hb
    exact ⟨hl,hr⟩
  · intro h
    exact memFlatMap _ _ a _ h.1 (memMap (fun b => (a,b)) b carrier h.2)

theorem algebraAppendNil {α : Type} (xs : List α) : xs ++ [] = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih

theorem algebraFlatMapAppend {α β : Type} (f : α → List β) (xs ys : List α) :
    (xs ++ ys).flatMap f = xs.flatMap f ++ ys.flatMap f := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    change f x ++ (xs ++ ys).flatMap f = (f x ++ xs.flatMap f) ++ ys.flatMap f
    rw [ih,ExactTraceArithmetic.appendAssociative]

-- Original nested-loop order is retained: each old left row gains its fresh
-- right cell, followed by the fresh left row and its final self cell.
theorem freshPairSupportOrder (carrier : List String) (fresh : String) :
    pairSupport (carrier ++ [fresh]) =
      carrier.flatMap (fun a => carrier.map (fun b => (a,b)) ++ [(a,fresh)]) ++
      (carrier.map (fun b => (fresh,b)) ++ [(fresh,fresh)]) := by
  unfold pairSupport
  rw [algebraFlatMapAppend]
  have distribute (items : List String) :
      items.flatMap (fun a => (carrier ++ [fresh]).map (fun b => (a,b))) =
      items.flatMap (fun a => carrier.map (fun b => (a,b)) ++ [(a,fresh)]) := by
    induction items with
    | nil => rfl
    | cons a items ih =>
      change (carrier ++ [fresh]).map (fun b => (a,b)) ++
        items.flatMap (fun a => (carrier ++ [fresh]).map (fun b => (a,b))) =
        (carrier.map (fun b => (a,b)) ++ [(a,fresh)]) ++
        items.flatMap (fun a => carrier.map (fun b => (a,b)) ++ [(a,fresh)])
      rw [ExactTraceArithmetic.mapAppend,ih]
      rfl
  rw [distribute carrier,distribute [fresh]]
  change _ ++ ((_ ++ _) ++ []) = _
  rw [algebraAppendNil]

theorem freshPairSupportPartition (carrier : List String) (fresh a b : String) :
    (a,b) ∈ pairSupport (carrier ++ [fresh]) ↔
      (a ∈ carrier ∧ b ∈ carrier) ∨
      (a ∈ carrier ∧ b = fresh) ∨
      (a = fresh ∧ b ∈ carrier) ∨ (a = fresh ∧ b = fresh) := by
  constructor
  · intro member
    have h := (pairSupportMember (carrier ++ [fresh]) a b).mp member
    cases memAppendCases a carrier [fresh] h.1 with
    | inl ha =>
      cases memAppendCases b carrier [fresh] h.2 with
      | inl hb => exact Or.inl ⟨ha,hb⟩
      | inr hb =>
        cases hb with
        | head => exact Or.inr (Or.inl ⟨ha,rfl⟩)
        | tail _ h => cases h
    | inr ha =>
      cases ha with
      | tail _ h => cases h
      | head =>
        cases memAppendCases b carrier [fresh] h.2 with
        | inl hb => exact Or.inr (Or.inr (Or.inl ⟨rfl,hb⟩))
        | inr hb =>
          cases hb with
          | head => exact Or.inr (Or.inr (Or.inr ⟨rfl,rfl⟩))
          | tail _ h => cases h
  · intro h
    apply (pairSupportMember (carrier ++ [fresh]) a b).mpr
    have added : fresh ∈ carrier ++ [fresh] := memAppendRight _ _ _ (List.Mem.head [])
    cases h with
    | inl h => exact ⟨memAppendLeft _ _ _ h.1,memAppendLeft _ _ _ h.2⟩
    | inr h =>
      cases h with
      | inl h => exact ⟨memAppendLeft _ _ _ h.1,h.2 ▸ added⟩
      | inr h =>
        cases h with
        | inl h => exact ⟨h.1 ▸ added,memAppendLeft _ _ _ h.2⟩
        | inr h => exact ⟨h.1 ▸ added,h.2 ▸ added⟩

theorem freshPairSupportDistinct (carrier : List String) (fresh : String)
    (unique : distinct carrier = true) (new : fresh ∉ carrier) :
    distinct (pairSupport (carrier ++ [fresh])) = true := by
  have extended := freshAppendDistinct carrier fresh unique ((absentIff carrier fresh).mpr new)
  exact pairProductDistinct _ _ extended extended

theorem acceptedSingletonIdentity (one : String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable [one] rows = .ok table) :
    hasIdentity table one = .ok true := by
  have carrier : table.carrier = [one] := congrArg OperationTable.carrier
    (tableAcceptedData [one] rows table accepted).1
  have result := acceptedSingletonResult one rows table accepted
  apply (hasIdentityTrueIff table one).mpr
  constructor
  · rw [carrier]; exact List.Mem.head []
  · intro item member
    rw [carrier] at member
    cases member with
    | head => exact ⟨result,result⟩
    | tail _ h => cases h

theorem acceptedSingletonAssociation (one : String) (rows : List (String × String × String))
    (table : OperationTable) (accepted : makeTable [one] rows = .ok table) :
    isAssociative table = .ok true := by
  have carrier : table.carrier = [one] := congrArg OperationTable.carrier
    (tableAcceptedData [one] rows table accepted).1
  have result := acceptedSingletonResult one rows table accepted
  apply (associativityExhaustiveIff table).mpr
  intro a ha b hb c hc
  rw [carrier] at ha hb hc
  have only (x : String) (h : x ∈ [one]) : x = one := by
    cases h with
    | head => rfl
    | tail _ h => cases h
  cases only a ha; cases only b hb; cases only c hc
  exact (associationCellExact table one one one one one one one result result result result).mpr rfl

theorem newPairSupportExactly (carrier : List String) (fresh a b : String)
    (new : fresh ∉ carrier) :
    ((a,b) ∈ pairSupport (carrier ++ [fresh]) ∧ (a,b) ∉ pairSupport carrier) ↔
      (a ∈ carrier ∧ b = fresh) ∨
      (a = fresh ∧ b ∈ carrier) ∨ (a = fresh ∧ b = fresh) := by
  constructor
  · intro h
    cases (freshPairSupportPartition carrier fresh a b).mp h.1 with
    | inl old => exact False.elim (h.2 ((pairSupportMember carrier a b).mpr old))
    | inr added => exact added
  · intro added
    refine ⟨(freshPairSupportPartition carrier fresh a b).mpr (Or.inr added),?_⟩
    intro old
    have members := (pairSupportMember carrier a b).mp old
    cases added with
    | inl h => exact new (h.2 ▸ members.2)
    | inr h =>
      cases h with
      | inl h => exact new (h.1 ▸ members.1)
      | inr h => exact new (h.1 ▸ members.1)

end SFT.Mathematics.AlgebraOperations
