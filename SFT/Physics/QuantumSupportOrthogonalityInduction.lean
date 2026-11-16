import SFT.Physics.QuantumSupportParity
namespace SFT.Physics.QuantumSupportOrthogonalityInduction
open QuantumSupportPreparation QuantumSupportParity SFT.Foundation.CommonRefinement
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.Count.Representation
set_option maxHeartbeats 100000000
-- These are precisely the agreement labels counted by orthogonality_certificate.
def agreementRows (left right : Word) (modes : List Word) : List Bool :=
 modes.map (fun mode => phaseBit left mode==phaseBit right mode)
def heldCount (rows : List Bool) : Nat := (rows.filter id).length
def returnedCount (rows : List Bool) : Nat := (rows.filter Bool.not).length
def prepend (b : Bool) (word : Word) : Word := (if b then returned else held)::word
private theorem mapAppend {α β : Type} (f : α→β) (xs ys : List α) :
 (xs++ys).map f=xs.map f++ys.map f := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (f x)) ih
private theorem mapPointwise {α β : Type} (xs : List α) (f g : α→β)
 (eq : ∀ x,f x=g x) : xs.map f=xs.map g := by
 induction xs with
 | nil => rfl
 | cons x xs ih => change f x::xs.map f=g x::xs.map g;rw [eq x,ih]
private theorem appendNil {α : Type} (xs : List α) : xs++[]=xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih
private theorem wordSuccessor (d : Nat) :
 words (d+1)=(words d).map (prepend false)++(words d).map (prepend true) := by
 change (words d).map (prepend false)++((words d).map (prepend true)++[]) = _
 rw [appendNil]
private theorem sameModeSuccessor (a b : Bool) (left right mode : Word) :
 (phaseBit (prepend a left) (prepend false mode)==phaseBit (prepend b right) (prepend false mode))=
 (phaseBit left mode==phaseBit right mode) := by
 cases a <;> cases b <;> rfl
private theorem alternatingModeSuccessor (a b : Bool) (left right mode : Word) :
 (phaseBit (prepend a left) (prepend true mode)==phaseBit (prepend b right) (prepend true mode))=
 (if a==b then (phaseBit left mode==phaseBit right mode) else !(phaseBit left mode==phaseBit right mode)) := by
 cases a <;> cases b
 · rfl
 · change (phaseBit left mode==phaseBit (returned::right) (returned::mode))=_
   rw [originalReturnedReturned]
   cases phaseBit left mode <;> cases phaseBit right mode <;> rfl
 · change (phaseBit (returned::left) (returned::mode)==phaseBit right mode)=_
   rw [originalReturnedReturned]
   cases phaseBit left mode <;> cases phaseBit right mode <;> rfl
 · change (phaseBit (returned::left) (returned::mode)==phaseBit (returned::right) (returned::mode))=_
   rw [originalReturnedReturned,originalReturnedReturned]
   cases phaseBit left mode <;> cases phaseBit right mode <;> rfl

theorem originalRowSuccessor (a b : Bool) (left right : Word) (d : Nat) :
 agreementRows (prepend a left) (prepend b right) (words (d+1))=
 agreementRows left right (words d)++
 (agreementRows left right (words d)).map (fun value => if a==b then value else !value) := by
 unfold agreementRows
 rw [wordSuccessor,mapAppend,VacuumLedgerProofs.mapComposition,VacuumLedgerProofs.mapComposition,VacuumLedgerProofs.mapComposition]
 rw [mapPointwise _ _ _ (sameModeSuccessor a b left right),mapPointwise _ _ _ (alternatingModeSuccessor a b left right)]
private theorem heldAppend (xs ys : List Bool) : heldCount (xs++ys)=heldCount xs+heldCount ys := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons x xs ih =>
   cases x with
   | false => exact ih
   | true => change Nat.succ (heldCount (xs++ys))=Nat.succ (heldCount xs)+heldCount ys;rw [ih,Nat.succ_add]
private theorem returnedAppend (xs ys : List Bool) : returnedCount (xs++ys)=returnedCount xs+returnedCount ys := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons x xs ih =>
   cases x with
   | true => exact ih
   | false => change Nat.succ (returnedCount (xs++ys))=Nat.succ (returnedCount xs)+returnedCount ys;rw [ih,Nat.succ_add]
private theorem countsPartition (xs : List Bool) : heldCount xs+returnedCount xs=xs.length := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
   cases x with
   | false => change heldCount xs+Nat.succ (returnedCount xs)=Nat.succ xs.length;exact congrArg Nat.succ ih
   | true => change Nat.succ (heldCount xs)+returnedCount xs=Nat.succ xs.length;rw [Nat.succ_add];exact congrArg Nat.succ ih
private theorem heldNot (xs : List Bool) : heldCount (xs.map Bool.not)=returnedCount xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih => cases x with | false => exact congrArg Nat.succ ih | true => exact ih
private theorem returnedNot (xs : List Bool) : returnedCount (xs.map Bool.not)=heldCount xs := by
 induction xs with
 | nil => rfl
 | cons x xs ih => cases x with | false => exact ih | true => exact congrArg Nat.succ ih
private theorem mapIdentity (xs : List Bool) : xs.map (fun x=>x)=xs := by
 induction xs with | nil => rfl | cons x xs ih => exact congrArg (List.cons x) ih
private theorem generatedCases (d : Nat) (word : Word) (member : word∈words (d+1)) :
 ∃ b tail, tail∈words d ∧ word=prepend b tail := by
 obtain ⟨label,hl,hm⟩ := memFlatMapOrigin (fun label => (words d).map (List.cons label)) [held,returned] word member
 obtain ⟨tail,ht,he⟩ := memMapPreimage (List.cons label) word (words d) hm
 cases hl with
 | head => exact ⟨false,tail,ht,he.symm⟩
 | tail _ hl =>
   cases hl with
   | head => exact ⟨true,tail,ht,he.symm⟩
   | tail _ hl => cases hl

theorem originalOffDiagonalCounts (d : Nat) (left right : Word)
 (hl : left∈words d) (hr : right∈words d) (different : left≠right) :
 heldCount (agreementRows left right (words d))=returnedCount (agreementRows left right (words d)) := by
 induction d generalizing left right with
 | zero =>
   cases hl with
   | head => cases hr with | head => exact False.elim (different rfl) | tail _ h => cases h
   | tail _ h => cases h
 | succ d ih =>
   obtain ⟨a,left,htl,rfl⟩ := generatedCases d left hl
   obtain ⟨b,right,htr,rfl⟩ := generatedCases d right hr
   rw [originalRowSuccessor,heldAppend,returnedAppend]
   cases a <;> cases b
   · change heldCount (agreementRows left right (words d))+heldCount ((agreementRows left right (words d)).map (fun v=>v))=returnedCount (agreementRows left right (words d))+returnedCount ((agreementRows left right (words d)).map (fun v=>v))
     rw [mapIdentity]
     have ne : left≠right := fun h => different (congrArg (prepend false) h)
     rw [ih left right htl htr ne]
   · change heldCount (agreementRows left right (words d))+heldCount ((agreementRows left right (words d)).map Bool.not)=returnedCount (agreementRows left right (words d))+returnedCount ((agreementRows left right (words d)).map Bool.not)
     rw [heldNot,returnedNot,Nat.add_comm]
   · change heldCount (agreementRows left right (words d))+heldCount ((agreementRows left right (words d)).map Bool.not)=returnedCount (agreementRows left right (words d))+returnedCount ((agreementRows left right (words d)).map Bool.not)
     rw [heldNot,returnedNot,Nat.add_comm]
   · change heldCount (agreementRows left right (words d))+heldCount ((agreementRows left right (words d)).map (fun v=>v))=returnedCount (agreementRows left right (words d))+returnedCount ((agreementRows left right (words d)).map (fun v=>v))
     rw [mapIdentity]
     have ne : left≠right := fun h => different (congrArg (prepend true) h)
     rw [ih left right htl htr ne]

theorem originalAllModesRetained (left right : Word) (d : Nat) :
 heldCount (agreementRows left right (words d))+returnedCount (agreementRows left right (words d))=2^d := by
 rw [countsPartition]
 exact (mapLength _ _).trans (QuantumSupportDepth.originalWordCount d)
private theorem diagonalRows (left : Word) (modes : List Word) :
 agreementRows left left modes=modes.map (fun _=>true) := by
 apply mapPointwise
 intro mode
 cases phaseBit left mode <;> rfl
private theorem trueCounts (modes : List Word) :
 heldCount (modes.map (fun _=>true))=modes.length ∧ returnedCount (modes.map (fun _=>true))=0 := by
 induction modes with
 | nil => exact ⟨rfl,rfl⟩
 | cons m ms ih => exact ⟨congrArg Nat.succ ih.1,ih.2⟩

theorem originalDiagonalCounts (left : Word) (d : Nat) :
 heldCount (agreementRows left left (words d))=2^d ∧ returnedCount (agreementRows left left (words d))=0 := by
 rw [diagonalRows]
 exact ⟨(trueCounts (words d)).1.trans (QuantumSupportDepth.originalWordCount d),(trueCounts (words d)).2⟩

theorem originalGeneratedWordLength (d : Nat) (word : Word) (member : word∈words d) : word.length=d := by
 induction d generalizing word with
 | zero => cases member with | head => rfl | tail _ h => cases h
 | succ d ih =>
   obtain ⟨b,tail,ht,rfl⟩ := generatedCases d word member
   exact congrArg Nat.succ (ih tail ht)

theorem originalCompleteOrthogonality (d : Nat) (left right : Word)
 (hl : left∈words d) (hr : right∈words d) :
 (left=right → heldCount (agreementRows left right (words d))=2^d ∧ returnedCount (agreementRows left right (words d))=0) ∧
 (left≠right → heldCount (agreementRows left right (words d))=returnedCount (agreementRows left right (words d)) ∧
  heldCount (agreementRows left right (words d))+returnedCount (agreementRows left right (words d))=2^d) := by
 constructor
 · intro same;rw [same];exact originalDiagonalCounts right d
 · intro different
   exact ⟨originalOffDiagonalCounts d left right hl hr different,originalAllModesRetained left right d⟩
end SFT.Physics.QuantumSupportOrthogonalityInduction
