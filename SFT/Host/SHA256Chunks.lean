import SFT.Host.SHA256Window
namespace SFT.Host.SHA256Chunks
open SFT.Host

theorem dropTwice (i j : Nat) (xs : List Nat) : (xs.drop j).drop i=xs.drop (j+i) := by
 induction j generalizing xs with
 | zero => rw [List.drop_zero,Nat.zero_add]
 | succ j ih =>
  cases xs with
  | nil => rw [List.drop_nil,List.drop_nil,List.drop_nil]
  | cons x xs =>
   rw [List.drop_succ_cons,Nat.succ_add,List.drop_succ_cons]
   exact ih xs

theorem foldMapped {A B C : Type} (f : A → B) (g : C → B → C) (xs : List A) (state : C) :
 (xs.map f).foldl g state=xs.foldl (fun h x => g h (f x)) state := by
 induction xs generalizing state with
 | nil => rfl
 | cons x xs ih => exact ih (g state (f x))

theorem rangeLoopShift (n : Nat) (acc : List Nat) :
 List.range.loop (n+1) (acc.map Nat.succ)=0::(List.range.loop n acc).map Nat.succ := by
 induction n generalizing acc with
 | zero => rfl
 | succ n ih => exact ih (n::acc)

theorem rangeShift (n : Nat) : List.range (n+1)=0::(List.range n).map Nat.succ := rangeLoopShift n []

def blocks : Nat → List Nat → List Nat → List Nat
 | 0,_,state => state
 | count+1,bytes,state => blocks count (bytes.drop 64) (SHA256Window.block state bytes 0)

theorem blockAfterDrop (state bytes : List Nat) (offset position : Nat) :
 SHA256Window.block state (bytes.drop offset) position=SHA256Window.block state bytes (offset+position) := by
 unfold SHA256Window.block SHA256Window.schedule
 rw [dropTwice]

theorem everyBlockPreserved (count : Nat) (bytes state : List Nat) :
 blocks count bytes state=(List.range count).foldl (fun h i => SHA256Window.block h bytes (64*i)) state := by
 induction count generalizing bytes state with
 | zero => rfl
 | succ n ih =>
  rw [blocks,ih,rangeShift,List.foldl_cons,foldMapped]
  change (List.range n).foldl (fun h i => SHA256Window.block h (bytes.drop 64) (64*i)) (SHA256Window.block state bytes 0)=
   (List.range n).foldl (fun h i => SHA256Window.block h bytes (64*(i+1))) (SHA256Window.block state bytes 0)
  apply SHA256Window.foldPointwise
  intro h i
  rw [blockAfterDrop,Nat.mul_succ,Nat.add_comm 64 (64*i)]

def digest (input : ByteArray) : String :=
 let bytes := SHA256.pad (input.data.toList.map UInt8.toNat)
 Text.join ((blocks (bytes.length/64) bytes SHA256.initial).map SHA256.wordHex)

theorem digestPreserved (input : ByteArray) : digest input=SHA256.digest input := by
 unfold digest
 dsimp only
 rw [everyBlockPreserved]
 exact SHA256Window.digestPreserved input

#print axioms digestPreserved
end SFT.Host.SHA256Chunks
