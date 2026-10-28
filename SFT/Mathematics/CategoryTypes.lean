import SFT.Mathematics.CategoryPaths
namespace SFT.Mathematics.CategoryTypes
open SFT.Foundation.CommonRefinement OptimizationSelection DiscreteObjects AlgebraOperations SFT.Foundation.Count.TraceDerivation

def typeMembers (carrier : List String) (predicate : Verdicts) : Except String (List String) :=
  if verdictKeysMatch carrier predicate then .ok (carrier.filter (allowed predicate))
  else .error "a type predicate must decide every generated carrier form"

def productForms (left right : List String) : List (String × String) :=
  left.flatMap (fun a => right.map (fun b => (a,b)))

def sumForms (left right : List String) : List (String × String) :=
  left.map (fun a => ("left-held",a)) ++ right.map (fun b => ("right-held",b))

theorem typeAdmitted (carrier : List String) (predicate : Verdicts)
    (h : verdictKeysMatch carrier predicate = true) :
    typeMembers carrier predicate = .ok (carrier.filter (allowed predicate)) := by
  unfold typeMembers; rw [h]; rfl

theorem typeRejected (carrier : List String) (predicate : Verdicts)
    (h : verdictKeysMatch carrier predicate = false) :
    typeMembers carrier predicate = .error "a type predicate must decide every generated carrier form" := by
  unfold typeMembers; rw [h]; rfl

theorem typeResult (carrier : List String) (predicate : Verdicts) (result : List String)
    (h : typeMembers carrier predicate = .ok result) :
    verdictKeysMatch carrier predicate = true ∧ result = carrier.filter (allowed predicate) := by
  unfold typeMembers at h
  cases hk : verdictKeysMatch carrier predicate with
  | false => rw [hk] at h; cases h
  | true => rw [hk] at h; cases h; exact ⟨rfl,rfl⟩

theorem typeMembership (carrier : List String) (predicate : Verdicts) (result : List String)
    (h : typeMembers carrier predicate = .ok result) (item : String) :
    item ∈ result ↔ item ∈ carrier ∧ verdict predicate item = some true := by
  rw [(typeResult _ _ _ h).2]
  exact feasibleMembership _ _ _

theorem productMembership (left right : List String) (a b : String) :
    (a,b) ∈ productForms left right ↔ a ∈ left ∧ b ∈ right := by
  constructor
  · intro h
    obtain ⟨l,hl,branch⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨r,hr,eq⟩ := memMapPreimage (fun r => (l,r)) (a,b) right branch
    have ha := congrArg Prod.fst eq
    have hb := congrArg Prod.snd eq
    cases ha; cases hb
    exact ⟨hl,hr⟩
  · intro h
    exact memFlatMap _ _ a _ h.1 (memMap (fun b => (a,b)) b right h.2)

theorem sumMembership (left right : List String) (tag item : String) :
    (tag,item) ∈ sumForms left right ↔
      (tag = "left-held" ∧ item ∈ left) ∨ (tag = "right-held" ∧ item ∈ right) := by
  constructor
  · intro h
    cases memAppendCases _ _ _ h with
    | inl hl =>
      obtain ⟨value,hv,eq⟩ := memMapPreimage (fun a => ("left-held",a)) (tag,item) left hl
      have ht := congrArg Prod.fst eq
      have hi := congrArg Prod.snd eq
      cases ht; cases hi; exact Or.inl ⟨rfl,hv⟩
    | inr hr =>
      obtain ⟨value,hv,eq⟩ := memMapPreimage (fun a => ("right-held",a)) (tag,item) right hr
      have ht := congrArg Prod.fst eq
      have hi := congrArg Prod.snd eq
      cases ht; cases hi; exact Or.inr ⟨rfl,hv⟩
  · intro h
    cases h with
    | inl hl =>
      cases hl.1
      exact memAppendLeft _ _ _ (memMap (fun a => ("left-held",a)) item left hl.2)
    | inr hr =>
      cases hr.1
      exact memAppendRight _ _ _ (memMap (fun a => ("right-held",a)) item right hr.2)

theorem emptyType : typeMembers [] [] = .ok [] := rfl

theorem duplicateType : typeMembers ["a","a"] [("a",false),("a",true)] = .ok ["a","a"] := rfl

end SFT.Mathematics.CategoryTypes
