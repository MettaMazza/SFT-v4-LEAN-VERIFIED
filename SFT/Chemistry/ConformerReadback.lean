import SFT.Chemistry.ConformerIdentityFold
namespace SFT.Chemistry.ConformerReadback
open SFT.Physics.CapabilityValues ConformerCarrier ConformerAssignments ConformerIdentityFold
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

private theorem appendGrouped {α : Type} (xs ys zs : List α) : (xs++ys)++zs=xs++(ys++zs) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih
private theorem rangeEquivalent (n : Nat) : List.range n=List.range' 0 n := by
 have loop (s k : Nat) : List.range.loop s (List.range' s k)=List.range' 0 (k+s) := by
  induction s generalizing k with
  | zero => rfl
  | succ s ih =>
   rw [←Nat.add_assoc,Nat.add_right_comm k s 1]
   exact ih (k+1)
 exact (loop n 0).trans (congrArg (List.range' 0) (Nat.zero_add n))

private theorem findAtPrefix (before after : Assignment) (state : HeldLabel) (offset : Nat) :
 (((before++state::after).zipIdx offset).map (fun (value,index) => (index,value))).find?
  (fun pair => pair.1==offset+before.length) = some (offset+before.length,state) := by
 induction before generalizing offset with
 | nil =>
  change (match offset==offset with | true => some (offset,state) | false => _) = some (offset,state)
  rw [naturalEqualityReflexive]
 | cons first rest ih =>
  change (match offset==offset+(rest.length+1) with
   | true => some (offset,first)
   | false => (((rest++state::after).zipIdx (offset+1)).map (fun (value,index) => (index,value))).find? (fun pair => pair.1==offset+(rest.length+1))) = some (offset+(rest.length+1),state)
  have different : (offset==offset+(rest.length+1))=false := by
   cases test : (offset==offset+(rest.length+1)) with
   | false => rfl
   | true =>
    have impossible := Nat.eq_of_beq_eq_true test
    have strict := Nat.lt_add_of_pos_right (Nat.zero_lt_succ rest.length) (n:=offset)
    rw [←impossible] at strict
    exact False.elim (Nat.lt_irrefl _ strict)
  rw [different]
  have tail := ih (offset+1)
  have indexEq : (offset+1)+rest.length=offset+(rest.length+1) := by rw [Nat.add_assoc,Nat.add_comm 1 rest.length]
  rw [indexEq] at tail
  exact tail

theorem completeIndexedReadback (states : Assignment) :
 readback states.length (states.zipIdx.map (fun (state,index) => (index,state)))=.ok states := by
 let lookup := fun (entries : List (Nat×HeldLabel)) (i : Nat) =>
  match entries.find? (fun pair => pair.1==i) with
  | none => (Except.error "target rotor index not found" : Except String HeldLabel)
  | some pair => .ok pair.2
 have loop (remaining before acc : Assignment) :
  List.mapM.loop (m:=Except String)
   (lookup (((before++remaining).zipIdx).map (fun (state,index) => (index,state))))
   (List.range' before.length remaining.length) acc = .ok (List.reverseAux acc remaining) := by
  induction remaining generalizing before acc with
  | nil => rfl
  | cons state rest ih =>
   have found := findAtPrefix before rest state 0
   rw [Nat.zero_add] at found
   have value : lookup (((before++state::rest).zipIdx).map (fun (state,index) => (index,state))) before.length=.ok state := by
    dsimp only [lookup]
    rw [found]
   change (do
    let value ← lookup (((before++state::rest).zipIdx).map (fun (state,index) => (index,state))) before.length
    List.mapM.loop (m:=Except String)
     (lookup (((before++state::rest).zipIdx).map (fun (state,index) => (index,state))))
     (List.range' (before.length+1) rest.length) (value::acc)) = .ok (List.reverseAux acc (state::rest))
   rw [value]
   have next := ih (before++[state]) (state::acc)
   rw [appendGrouped,appendLength] at next
   exact next
 unfold readback
 rw [rangeEquivalent]
 exact loop states [] []

-- The original action's input/output length guards are retained, and its
-- successful identity result is the complete original assignment.
theorem successfulIdentityAction (size : Nat) (rotors : List Rotor) (assignment : Assignment)
 (alphabets : List Alphabet) (out : Assignment)
 (inside : ∀ rotor, rotor∈rotors → ∀ site, site∈rotor.orderedSites → site.value≤size)
 (accepted : applyAction assignment ⟨positions size⟩ rotors alphabets=.ok out) : out=assignment := by
 unfold applyAction at accepted
 split at accepted
 · cases accepted
 · rename_i alignedGuard
   have aligned : assignment.length=rotors.length := by
    cases equal : (assignment.length==rotors.length) with
    | false => exact False.elim (alignedGuard (by change (!(assignment.length==rotors.length))=true; rw [equal]; rfl))
    | true => exact Nat.eq_of_beq_eq_true equal
   dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
   cases folded : ((rotors.zip assignment).zip alphabets).foldlM
     (transformRotor ⟨positions size⟩ rotors alphabets) [] with
   | error message => rw [folded] at accepted; cases accepted
   | ok transformed =>
    rw [folded] at accepted
    dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at accepted
    split at accepted
    · cases accepted
    · rename_i completeGuard
      have complete : transformed.length=rotors.length := by
       cases equal : (transformed.length==rotors.length) with
       | false => exact False.elim (completeGuard (by change (!(transformed.length==rotors.length))=true; rw [equal]; rfl))
       | true => exact Nat.eq_of_beq_eq_true equal
      have retained := identityCompleteFold size rotors assignment alphabets transformed inside aligned complete folded
      rw [retained,←aligned,completeIndexedReadback] at accepted
      exact (Except.ok.inj accepted).symm
end SFT.Chemistry.ConformerReadback
