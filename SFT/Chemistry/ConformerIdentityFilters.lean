import SFT.Chemistry.ConformerIdentityValues
import SFT.Chemistry.MulticentreConnectivity
namespace SFT.Chemistry.ConformerIdentityFilters
open SFT.Physics.CapabilityValues ConformerCarrier ConformerIdentity ConformerIdentityValues
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation
open MolecularGraphEnumeration (atIndex)

private theorem indexExists {α : Type} (xs : List α) (index : Nat) (inside : index<xs.length) :
 ∃ value, atIndex xs index=some value := by
 induction xs generalizing index with
 | nil => cases inside
 | cons first rest ih =>
  cases index with
  | zero => exact ⟨first,rfl⟩
  | succ index => exact ih index (Nat.lt_of_succ_lt_succ inside)

theorem identityAtomResults (g : Graph) :
 ((positions g.atomTypes.length).mapM (fun p => do
  let mapped ← ConformerCarrier.apply ⟨positions g.atomTypes.length⟩ p
  match atIndex g.atomTypes (p.value-1),atIndex g.atomTypes (mapped.value-1) with
  | some x,some y => pure (MulticentreSupport.sameLabel x y)
  | none,none | none,some _ | some _,none => throw "tuple index out of range")) =
 .ok ((positions g.atomTypes.length).map (fun _ => true)) := by
 let check := fun p => do
  let mapped ← ConformerCarrier.apply ⟨positions g.atomTypes.length⟩ p
  match atIndex g.atomTypes (p.value-1),atIndex g.atomTypes (mapped.value-1) with
  | some x,some y => (Except.ok (MulticentreSupport.sameLabel x y) : Except String Bool)
  | none,none | none,some _ | some _,none => .error "tuple index out of range"
 have each (p : PositiveCount) (inside : p.value≤g.atomTypes.length) : check p=.ok true := by
  dsimp only [check]
  rw [identityPosition g.atomTypes.length p inside]
  have within : p.value-1<g.atomTypes.length := by
   cases h : p.value with
   | zero => have positive := p.positive; rw [h] at positive; cases positive
   | succ n => rw [h] at inside; exact Nat.lt_of_lt_of_le (Nat.lt_succ_self n) inside
  obtain ⟨value,found⟩ := indexExists g.atomTypes (p.value-1) within
  dsimp only [Bind.bind,Except.bind]
  rw [found]
  have same : MulticentreSupport.sameLabel value value=true := by
   have reflexive (xs : List Nat) : (xs==xs)=true := by
    induction xs with
    | nil => rfl
    | cons x xs ih =>
     change ((x==x) && (xs==xs))=true
     rw [naturalEqualityReflexive,ih]
     rfl
   unfold MulticentreSupport.sameLabel SFT.Host.Text.equal
   rw [reflexive,reflexive]
   rfl
  change Except.ok (MulticentreSupport.sameLabel value value)=Except.ok true
  rw [same]
 have loop (pending : List PositiveCount) (acc : List Bool)
  (inside : ∀ p, p∈pending → p.value≤g.atomTypes.length) :
  List.mapM.loop (m:=Except String) check pending acc=
   .ok (List.reverseAux acc (pending.map (fun _ => true))) := by
  induction pending generalizing acc with
  | nil => rfl
  | cons first rest ih =>
   change (do
    let value ← check first
    List.mapM.loop (m:=Except String) check rest (value::acc)) = _
   rw [each first (inside first (List.Mem.head rest))]
   exact ih (true::acc) (fun p member => inside p (List.Mem.tail first member))
 exact loop (positions g.atomTypes.length) [] (positionWithinSupport g.atomTypes.length)

theorem identityAtomFlagsPass (size : Nat) :
 ((positions size).map (fun _ => true)).all id=true := by
 have allTrue (items : List PositiveCount) : (items.map (fun _ => true)).all id=true := by
  induction items with
  | nil => rfl
  | cons first rest ih => exact ih
 exact allTrue (positions size)

-- Normalizing a successfully admitted undirected bond is idempotent.
theorem normalizedBondFixed (left right : PositiveCount) (bond : Bond)
 (accepted : orderedBond left right=.ok bond) : orderedBond bond.1 bond.2=.ok bond := by
 unfold orderedBond at accepted
 cases equal : (left.value==right.value) with
 | true => rw [equal] at accepted; cases accepted
 | false =>
  rw [equal] at accepted
  by_cases ordered : left.value<right.value
  · rw [if_pos ordered] at accepted
    have retained := Except.ok.inj accepted
    cases retained
    unfold orderedBond
    rw [equal,if_pos ordered]
    rfl
  · rw [if_neg ordered] at accepted
    have retained := Except.ok.inj accepted
    cases retained
    have different : left.value≠right.value := by
     intro eq
     rw [eq,naturalEqualityReflexive] at equal
     cases equal
    have reversed : right.value<left.value := Nat.lt_of_le_of_ne (Nat.le_of_not_gt ordered) (fun eq => different eq.symm)
    have reversedEqual : (right.value==left.value)=false := by
     cases eq : (right.value==left.value) with
     | false => rfl
     | true => exact False.elim (different (Nat.eq_of_beq_eq_true eq).symm)
    unfold orderedBond
    rw [reversedEqual,if_pos reversed]
    rfl

theorem identityBondResults (size : Nat) (bonds : List Bond)
 (inside : ∀ bond, bond∈bonds → bond.1.value≤size ∧ bond.2.value≤size)
 (normalized : ∀ bond, bond∈bonds → orderedBond bond.1 bond.2=.ok bond) :
 (bonds.mapM (fun (left,right) => do
  orderedBond (← ConformerCarrier.apply ⟨positions size⟩ left)
   (← ConformerCarrier.apply ⟨positions size⟩ right))) = .ok bonds := by
 let check := fun (bond : Bond) => do
  orderedBond (← ConformerCarrier.apply ⟨positions size⟩ bond.1)
   (← ConformerCarrier.apply ⟨positions size⟩ bond.2)
 have each (bond : Bond) (member : bond∈bonds) : check bond=.ok bond :=
  (identityBond size bond.1 bond.2 (inside bond member).1 (inside bond member).2).trans
   (normalized bond member)
 have loop (pending acc : List Bond) (retained : ∀ bond, bond∈pending → bond∈bonds) :
  List.mapM.loop (m:=Except String) check pending acc=.ok (List.reverseAux acc pending) := by
  induction pending generalizing acc with
  | nil => rfl
  | cons first rest ih =>
   change (do
    let value ← check first
    List.mapM.loop (m:=Except String) check rest (value::acc)) = _
   rw [each first (retained first (List.Mem.head rest))]
   exact ih (first::acc) (fun bond member => retained bond (List.Mem.tail first member))
 exact loop bonds [] (fun _ h => h)

theorem identityBondFlagsPass (bonds : List Bond) :
 ((bonds.all (fun b => bonds.any (sameBond b))) &&
 (bonds.all (fun b => bonds.any (sameBond b))))=true := by
 have each (bond : Bond) (present : bond∈bonds) : bonds.any (sameBond bond)=true := by
  induction bonds with
  | nil => cases present
  | cons first rest ih =>
   cases present with
   | head =>
    change ((bond.1.value==bond.1.value && bond.2.value==bond.2.value) || rest.any (sameBond bond))=true
    rw [naturalEqualityReflexive,naturalEqualityReflexive]
    rfl
   | tail _ member =>
    change (sameBond bond first || rest.any (sameBond bond))=true
    rw [ih member]
    cases sameBond bond first <;> rfl
 have allInside (pending : List Bond) (included : ∀ bond, bond∈pending → bond∈bonds) :
  pending.all (fun b => bonds.any (sameBond b))=true := by
  induction pending with
  | nil => rfl
  | cons first rest ih =>
   change bonds.any (sameBond first) && rest.all (fun b => bonds.any (sameBond b))=true
   rw [each first (included first (List.Mem.head rest)),ih (fun b h => included b (List.Mem.tail first h))]
   rfl
 rw [allInside bonds (fun _ h => h)]
 rfl

-- This is the exact candidate-check body inside allActions, applied to the
-- generated identity permutation; its tests and result are unchanged.
theorem identityCandidatePassesFilters (g : Graph)
 (inside : ∀ bond, bond∈g.bonds → bond.1.value≤g.atomTypes.length ∧ bond.2.value≤g.atomTypes.length)
 (normalized : ∀ bond, bond∈g.bonds → orderedBond bond.1 bond.2=.ok bond) :
 (do
  let a ← action (← ((positions g.atomTypes.length).map PositiveCount.value).mapM count)
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
  else return none) = .ok (some (⟨positions g.atomTypes.length⟩ : Action)) := by
 rw [reconstructPositions]
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [identityActionAccepted]
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 have atoms := identityAtomResults g
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at atoms
 rw [atoms]
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [identityAtomFlagsPass]
 try dsimp only
 have bonds := identityBondResults g.atomTypes.length g.bonds inside normalized
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at bonds
 rw [bonds]
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [identityBondFlagsPass]
 rfl
end SFT.Chemistry.ConformerIdentityFilters
