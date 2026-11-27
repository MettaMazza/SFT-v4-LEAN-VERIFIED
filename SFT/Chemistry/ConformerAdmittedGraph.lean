import SFT.Chemistry.ConformerIdentityFilters
namespace SFT.Chemistry.ConformerAdmittedGraph
open SFT.Physics.CapabilityValues ConformerCarrier ConformerIdentityFilters ConformerIdentityValues ConformerReachSet

private theorem reverseNormalized (pending acc : List Bond)
 (first : ∀ b, b∈pending → orderedBond b.1 b.2=.ok b)
 (second : ∀ b, b∈acc → orderedBond b.1 b.2=.ok b) :
 ∀ b, b∈List.reverseAux pending acc → orderedBond b.1 b.2=.ok b := by
 induction pending generalizing acc with
 | nil => exact second
 | cons b rest ih =>
  apply ih
  · intro x member; exact first x (List.Mem.tail b member)
  · intro x member
    cases member with
    | head => exact first b (List.Mem.head rest)
    | tail _ h => exact second x h

theorem normalizationProducesFixed (raw normalized : List Bond)
 (accepted : raw.mapM (fun (left,right) => orderedBond left right)=.ok normalized) :
 ∀ b, b∈normalized → orderedBond b.1 b.2=.ok b := by
 have loop (pending acc out : List Bond)
  (retained : ∀ b, b∈acc → orderedBond b.1 b.2=.ok b)
  (success : List.mapM.loop (m:=Except String) (fun (left,right) => orderedBond left right) pending acc=.ok out) :
  ∀ b, b∈out → orderedBond b.1 b.2=.ok b := by
  induction pending generalizing acc out with
  | nil =>
   change Except.ok acc.reverse=Except.ok out at success
   cases success
   exact reverseNormalized acc [] retained (fun _ h => by cases h)
  | cons bond rest ih =>
   change (do
    let value ← orderedBond bond.1 bond.2
    List.mapM.loop (m:=Except String) (fun (left,right) => orderedBond left right) rest (value::acc))=.ok out at success
   cases step : orderedBond bond.1 bond.2 with
   | error message => rw [step] at success; cases success
   | ok value =>
    rw [step] at success
    refine ih (value::acc) out ?_ success
    intro b member
    cases member with
    | head => exact normalizedBondFixed bond.1 bond.2 value step
    | tail _ h => exact retained b h
 exact loop raw [] normalized (fun _ h => by cases h) accepted

private theorem insertPreserves (property : Bond→Prop) (bond : Bond) (bonds : List Bond)
 (newBond : property bond) (held : ∀ b, b∈bonds → property b) :
 ∀ b, b∈insertBond bond bonds → property b := by
 induction bonds with
 | nil =>
  intro b member
  cases member with
  | head => exact newBond
  | tail _ h => cases h
 | cons first rest ih =>
  intro b member
  change b∈(if bondLE bond first then bond::first::rest else first::insertBond bond rest) at member
  cases order : bondLE bond first with
  | true =>
   rw [order] at member
   cases member with
   | head => exact newBond
   | tail _ h => exact held b h
  | false =>
   rw [order] at member
   cases member with
   | head => exact held first (List.Mem.head rest)
   | tail _ h => exact ih (fun x hx => held x (List.Mem.tail first hx)) b h

private theorem sortPreserves (property : Bond→Prop) (bonds : List Bond)
 (held : ∀ b, b∈bonds → property b) : ∀ b, b∈sortBonds bonds → property b := by
 induction bonds with
 | nil => intro b h; cases h
 | cons first rest ih =>
  exact insertPreserves property first (sortBonds rest) (held first (List.Mem.head rest))
   (ih (fun b member => held b (List.Mem.tail first member)))

-- Bind both identity-filter premises to the actual successful graph constructor.
-- They are consequences of normalization, endpoint admission and sorting.
theorem acceptedGraphConditions (atoms : List HeldLabel) (raw : List Bond) (g : Graph)
 (accepted : graph atoms raw=.ok g) :
 (∀ b, b∈g.bonds → b.1.value≤g.atomTypes.length ∧ b.2.value≤g.atomTypes.length) ∧
 (∀ b, b∈g.bonds → orderedBond b.1 b.2=.ok b) := by
 unfold graph at accepted
 split at accepted
 · cases accepted
 · dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
   cases normalization : raw.mapM (fun (left,right) => orderedBond left right) with
   | error message => rw [normalization] at accepted; cases accepted
   | ok normalized =>
    rw [normalization] at accepted
    dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
    split at accepted
    · cases accepted
    · rename_i admitted
      have custody : normalized.all (fun (a,b) => containsPosition (positions atoms.length) a &&
       containsPosition (positions atoms.length) b)=true := by
       cases held : normalized.all (fun (a,b) => containsPosition (positions atoms.length) a &&
        containsPosition (positions atoms.length) b) with
       | true => rfl
       | false =>
        apply False.elim
        apply admitted
        rw [held]
        cases normalized.isEmpty <;> cases distinctBonds normalized <;> rfl
      have fixed := normalizationProducesFixed raw normalized normalization
      have bounded : ∀ b, b∈normalized → b.1.value≤atoms.length ∧ b.2.value≤atoms.length := by
       intro bond member
       have each : containsPosition (positions atoms.length) bond.1 &&
        containsPosition (positions atoms.length) bond.2=true := by
        have allHeld (pending : List Bond)
         (all : pending.all (fun b => containsPosition (positions atoms.length) b.1 && containsPosition (positions atoms.length) b.2)=true)
         (b : Bond) (present : b∈pending) :
         (containsPosition (positions atoms.length) b.1 && containsPosition (positions atoms.length) b.2)=true := by
         induction pending with
         | nil => cases present
         | cons first rest ih =>
          change ((containsPosition (positions atoms.length) first.1 && containsPosition (positions atoms.length) first.2) && rest.all (fun b => containsPosition (positions atoms.length) b.1 && containsPosition (positions atoms.length) b.2))=true at all
          cases head : (containsPosition (positions atoms.length) first.1 && containsPosition (positions atoms.length) first.2) with
          | false => rw [head] at all; cases all
          | true =>
           rw [head] at all
           cases present with
           | head => exact head
           | tail _ h => exact ih all h
        exact allHeld normalized custody bond member
       cases left : containsPosition (positions atoms.length) bond.1 with
       | false => rw [left] at each; cases each
       | true =>
        rw [left] at each
        exact ⟨positionWithinSupport atoms.length bond.1 ((positionMembership _ _).mp left),
         positionWithinSupport atoms.length bond.2 ((positionMembership _ _).mp each)⟩
      split at accepted
      · cases accepted
      · cases accepted
        exact ⟨sortPreserves _ normalized bounded,sortPreserves _ normalized fixed⟩
end SFT.Chemistry.ConformerAdmittedGraph
