import SFT.Chemistry.ConformerAdmittedGraph
namespace SFT.Chemistry.ConformerActionEnumeration
open SFT.Physics.CapabilityValues ConformerCarrier ConformerIdentity ConformerIdentityFilters ConformerAdmittedGraph
open MolecularGraphEnumeration (atIndex permutations)

private theorem reverseRetains {α : Type} (pending acc : List α) (value : α)
 (held : value∈pending ∨ value∈acc) : value∈List.reverseAux pending acc := by
 induction pending generalizing acc with
 | nil =>
  cases held with
  | inl h => cases h
  | inr h => exact h
 | cons first rest ih =>
  apply ih
  cases held with
  | inr h => exact Or.inr (List.Mem.tail first h)
  | inl h =>
   cases h with
   | head => exact Or.inr (List.Mem.head acc)
   | tail _ h => exact Or.inl h

theorem mappedResultRetained {α β : Type} (check : α→Except String β)
 (inputs : List α) (input : α) (result : β) (outputs : List β)
 (present : input∈inputs) (evaluated : check input=.ok result)
 (success : inputs.mapM check=.ok outputs) : result∈outputs := by
 have loop (pending : List α) (acc out : List β)
  (wanted : result∈acc ∨ ∃ x, x∈pending ∧ check x=.ok result)
  (done : List.mapM.loop (m:=Except String) check pending acc=.ok out) : result∈out := by
  induction pending generalizing acc out with
  | nil =>
   change Except.ok acc.reverse=Except.ok out at done
   cases done
   apply reverseRetains acc [] result
   cases wanted with
   | inl h => exact Or.inl h
   | inr h => obtain ⟨x,impossible,_⟩ := h; cases impossible
  | cons first rest ih =>
   change (do
    let value ← check first
    List.mapM.loop (m:=Except String) check rest (value::acc))=.ok out at done
   cases step : check first with
   | error message => rw [step] at done; cases done
   | ok value =>
    rw [step] at done
    apply ih (value::acc) out
    · cases wanted with
      | inl h => exact Or.inl (List.Mem.tail value h)
      | inr h =>
       obtain ⟨x,member,evaluated⟩ := h
       cases member with
       | head =>
        rw [step] at evaluated
        have equal : value=result := Except.ok.inj evaluated
        cases equal
        exact Or.inl (List.Mem.head acc)
       | tail _ h => exact Or.inr ⟨x,h,evaluated⟩
    · exact done
 exact loop inputs [] outputs (Or.inr ⟨input,present,evaluated⟩) success

theorem mappedInputSucceeds {α β : Type} (check : α→Except String β)
 (inputs : List α) (input : α) (outputs : List β)
 (present : input∈inputs) (success : inputs.mapM check=.ok outputs) :
 ∃ value, check input=.ok value := by
 have loop (pending : List α) (acc out : List β) (member : input∈pending)
  (done : List.mapM.loop (m:=Except String) check pending acc=.ok out) :
  ∃ value, check input=.ok value := by
  induction pending generalizing acc out with
  | nil => cases member
  | cons first rest ih =>
   change (do
    let value ← check first
    List.mapM.loop (m:=Except String) check rest (value::acc))=.ok out at done
   cases step : check first with
   | error message => rw [step] at done; cases done
   | ok value =>
    rw [step] at done
    cases member with
    | head => exact ⟨value,step⟩
    | tail _ h => exact ih (value::acc) out h done
 exact loop inputs [] outputs present success

private theorem retainedOption (rows : List (Option Action)) (a : Action)
 (present : some a∈rows) : a∈rows.filterMap id := by
 induction rows with
 | nil => cases present
 | cons first rest ih =>
  cases first with
  | none =>
   cases present with
   | tail _ member => exact ih member
  | some first =>
   cases present with
   | head => exact List.Mem.head _
   | tail _ member => exact List.Mem.tail first (ih member)

-- No assumed automorphism is inserted: this retains the generated identity
-- through the original map, candidate checks and final option filtering.
theorem admittedEnumerationRetainsIdentity (atoms : List HeldLabel) (bonds : List Bond)
 (g : Graph) (admitted : graph atoms bonds=.ok g) (actions : List Action)
 (enumerated : allActions g=.ok actions) :
 (⟨positions g.atomTypes.length⟩ : Action)∈actions := by
 let check := fun (values : List Nat) => do
  let a ← action (← values.mapM count)
  let atomMatches ← (positions g.atomTypes.length).mapM fun p => do
   let mapped ← ConformerCarrier.apply a p
   match atIndex g.atomTypes (p.value-1),atIndex g.atomTypes (mapped.value-1) with
   | some x,some y => pure (MulticentreSupport.sameLabel x y)
   | none,none | none,some _ | some _,none => throw "tuple index out of range"
  if !(atomMatches.all id) then return none
  let mapped ← g.bonds.mapM fun (left,right) => do
   orderedBond (← ConformerCarrier.apply a left) (← ConformerCarrier.apply a right)
  if (mapped.all fun b => g.bonds.any (sameBond b)) && (g.bonds.all fun b => mapped.any (sameBond b)) then
   return some a
  else return none
 let identityValues := (positions g.atomTypes.length).map PositiveCount.value
 let candidates := permutations identityValues
 have graphConditions := acceptedGraphConditions atoms bonds g admitted
 have checkedIdentity : check identityValues=.ok (some (⟨positions g.atomTypes.length⟩ : Action)) :=
  identityCandidatePassesFilters g graphConditions.1 graphConditions.2
 have generated : identityValues∈candidates := identityPermutationGenerated identityValues
 change (do
  let checked ← candidates.mapM check
  let retained := checked.filterMap id
  if retained.isEmpty then throw "complete graph-automorphism enumeration returned structural EmptyOne"
  return retained)=.ok actions at enumerated
 cases mapped : candidates.mapM check with
 | error message => rw [mapped] at enumerated; cases enumerated
 | ok checked =>
  rw [mapped] at enumerated
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at enumerated
  have identityPresent := mappedResultRetained check candidates identityValues _ checked generated checkedIdentity mapped
  have retained := retainedOption checked ⟨positions g.atomTypes.length⟩ identityPresent
  split at enumerated
  · cases enumerated
  · cases enumerated
    exact retained
end SFT.Chemistry.ConformerActionEnumeration
