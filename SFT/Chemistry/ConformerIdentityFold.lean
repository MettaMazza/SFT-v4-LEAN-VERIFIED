import SFT.Chemistry.ConformerRotorAction
namespace SFT.Chemistry.ConformerIdentityFold
open SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments ConformerRotorAction
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

inductive TrackedRows {α β : Type} (R : α → β → Prop) : List α → List β → Prop where
 | nil : TrackedRows R [] []
 | cons {a b as bs} : R a b → TrackedRows R as bs → TrackedRows R (a::as) (b::bs)

private theorem appendEmpty {α : Type} (xs : List α) : xs++[]=xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih
private theorem appendGrouped {α : Type} (xs ys zs : List α) : (xs++ys)++zs=xs++(ys++zs) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih

-- Compose the proven original update body through the actual monadic fold.
theorem identityFoldRetains (size : Nat) (rotors : List Rotor) (alphabets : List Alphabet)
 (rows : List ((Rotor×HeldLabel)×Alphabet)) (expected : List (Nat×HeldLabel))
 (tracked : TrackedRows (fun row pair => (row.1.1,pair.1)∈rotors.zipIdx ∧ pair.2=row.1.2) rows expected)
 (inside : ∀ row, row∈rows → ∀ site, site∈row.1.1.orderedSites → site.value≤size)
 (acc out : List (Nat×HeldLabel))
 (accepted : rows.foldlM (transformRotor ⟨positions size⟩ rotors alphabets) acc=.ok out) :
 out=acc++expected := by
 induction tracked generalizing acc out with
 | nil =>
  change Except.ok acc=Except.ok out at accepted
  cases accepted
  exact (appendEmpty acc).symm
 | @cons row pair rows pairs relation tracked ih =>
  change (do
   let next ← transformRotor ⟨positions size⟩ rotors alphabets acc row
   rows.foldlM (transformRotor ⟨positions size⟩ rotors alphabets) next) = .ok out at accepted
  cases step : transformRotor ⟨positions size⟩ rotors alphabets acc row with
  | error message => rw [step] at accepted; cases accepted
  | ok next =>
   rw [step] at accepted
   dsimp only [Bind.bind,Except.bind] at accepted
   have changed := identitySuccessfulStep size rotors alphabets row.1.1 row.1.2 row.2 pair.1 acc next
    (inside row (List.Mem.head rows)) relation.1 step
   have samePair : (pair.1,row.1.2)=pair := Prod.ext rfl relation.2.symm
   rw [samePair] at changed
   rw [changed] at accepted
   have rest := ih (fun row member => inside row (List.Mem.tail _ member)) (acc++[pair]) out accepted
   exact rest.trans (appendGrouped acc [pair] pairs)

-- The nested source zip associates each processed rotor with its original
-- generation index, including the original shortest-input zip behavior.
theorem sourceRowIndex (rotors : List Rotor) (assignment : Assignment) (alphabets : List Alphabet)
 (offset : Nat) (row : (Rotor×HeldLabel)×Alphabet) (index : Nat)
 (member : (row,index)∈(((rotors.zip assignment).zip alphabets).zipIdx offset)) :
 (row.1.1,index)∈rotors.zipIdx offset := by
 induction rotors generalizing assignment alphabets offset with
 | nil => cases member
 | cons rotor rest ih =>
  cases assignment with
  | nil => cases member
  | cons state states =>
   cases alphabets with
   | nil => cases member
   | cons alphabet remaining =>
    cases member with
    | head => exact List.Mem.head _
    | tail _ retained => exact List.Mem.tail (rotor,offset) (ih states remaining (offset+1) retained)

theorem identityOriginalFold (size : Nat) (rotors : List Rotor) (assignment : Assignment)
 (alphabets : List Alphabet) (out : List (Nat×HeldLabel))
 (inside : ∀ rotor, rotor∈rotors → ∀ site, site∈rotor.orderedSites → site.value≤size)
 (accepted : ((rotors.zip assignment).zip alphabets).foldlM
  (transformRotor ⟨positions size⟩ rotors alphabets) []=.ok out) :
 out=((((rotors.zip assignment).zip alphabets).zipIdx).map (fun (row,index) => (index,row.1.2))) := by
 let rows := (rotors.zip assignment).zip alphabets
 have track (pending : List ((Rotor×HeldLabel)×Alphabet)) (offset : Nat)
  (retained : ∀ row index, (row,index)∈pending.zipIdx offset → (row.1.1,index)∈rotors.zipIdx) :
  TrackedRows (fun row pair => (row.1.1,pair.1)∈rotors.zipIdx ∧ pair.2=row.1.2)
   pending ((pending.zipIdx offset).map (fun (row,index) => (index,row.1.2))) := by
  induction pending generalizing offset with
  | nil => exact TrackedRows.nil
  | cons row rest ih =>
   refine TrackedRows.cons ⟨retained row offset (List.Mem.head _),rfl⟩ ?_
   exact ih (offset+1) (fun next index present => retained next index (List.Mem.tail (row,offset) present))
 have rotorOfRow (row : (Rotor×HeldLabel)×Alphabet) (present : row∈rows) : row.1.1∈rotors := by
  have project (rs : List Rotor) (states : Assignment) (as : List Alphabet)
   (member : row∈(rs.zip states).zip as) : row.1.1∈rs := by
   induction rs generalizing states as with
   | nil => cases member
   | cons first rest ih =>
    cases states with
    | nil => cases member
    | cons state states =>
     cases as with
     | nil => cases member
     | cons alphabet remaining =>
      cases member with
      | head => exact List.Mem.head _
      | tail _ tail => exact List.Mem.tail first (ih states remaining tail)
  exact project rotors assignment alphabets present
 exact identityFoldRetains size rotors alphabets rows _
  (track rows 0 (sourceRowIndex rotors assignment alphabets 0))
  (fun row present => inside row.1.1 (rotorOfRow row present)) [] out accepted

-- The two existing source length checks exclude truncation of any state.
theorem originalZipCoversAssignment (rotors : List Rotor) (assignment : Assignment)
 (alphabets : List Alphabet) (aligned : assignment.length=rotors.length)
 (complete : ((rotors.zip assignment).zip alphabets).length=rotors.length) :
 (((rotors.zip assignment).zip alphabets).map (fun row => row.1.2))=assignment := by
 induction rotors generalizing assignment alphabets with
 | nil =>
  cases assignment with
  | nil => rfl
  | cons state states => cases aligned
 | cons rotor rest ih =>
  cases assignment with
  | nil => cases aligned
  | cons state states =>
   cases alphabets with
   | nil => cases complete
   | cons alphabet remaining =>
    have alignedTail : states.length=rest.length := Nat.succ.inj aligned
    have completeTail : ((rest.zip states).zip remaining).length=rest.length := Nat.succ.inj complete
    exact congrArg (List.cons state) (ih states remaining alignedTail completeTail)

theorem indexedStateProjection (rows : List ((Rotor×HeldLabel)×Alphabet)) (offset : Nat) :
 (rows.zipIdx offset).map (fun (row,index) => (index,row.1.2)) =
 ((rows.map (fun row => row.1.2)).zipIdx offset).map (fun (state,index) => (index,state)) := by
 induction rows generalizing offset with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons (offset,row.1.2)) (ih (offset+1))

theorem identityCompleteFold (size : Nat) (rotors : List Rotor) (assignment : Assignment)
 (alphabets : List Alphabet) (out : List (Nat×HeldLabel))
 (inside : ∀ rotor, rotor∈rotors → ∀ site, site∈rotor.orderedSites → site.value≤size)
 (aligned : assignment.length=rotors.length) (complete : out.length=rotors.length)
 (accepted : ((rotors.zip assignment).zip alphabets).foldlM
  (transformRotor ⟨positions size⟩ rotors alphabets) []=.ok out) :
 out=(assignment.zipIdx.map (fun (state,index) => (index,state))) := by
 have folded := identityOriginalFold size rotors assignment alphabets out inside accepted
 have indexLength (rows : List ((Rotor×HeldLabel)×Alphabet)) (offset : Nat) :
  ((rows.zipIdx offset).map (fun (row,index) => (index,row.1.2))).length=rows.length := by
  induction rows generalizing offset with
  | nil => rfl
  | cons row rest ih => exact congrArg Nat.succ (ih (offset+1))
 have zipLength : ((rotors.zip assignment).zip alphabets).length=rotors.length := by
  rw [folded,indexLength] at complete
  exact complete
 rw [folded,indexedStateProjection,originalZipCoversAssignment rotors assignment alphabets aligned zipLength]
end SFT.Chemistry.ConformerIdentityFold
