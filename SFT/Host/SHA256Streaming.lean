import SFT.Host.SHA256Window
namespace SFT.Host.SHA256Streaming
open SFT.Host

def byteAt (input : ByteArray) (i : Nat) : Nat :=
 if h : i < input.size then (input.get i h).toNat else 0

theorem getMapped (xs : List UInt8) (i : Nat) (h : i < xs.length) :
 SHA256.get (xs.map UInt8.toNat) i = (xs.get ⟨i,h⟩).toNat := by
 induction xs generalizing i with
 | nil => exact False.elim (Nat.not_lt_zero i h)
 | cons x xs ih =>
  cases i with
  | zero => rfl
  | succ i => exact ih i (Nat.lt_of_succ_lt_succ h)

theorem getBeyond (xs : List UInt8) (i : Nat) (h : xs.length ≤ i) :
 SHA256.get (xs.map UInt8.toNat) i = 0 := by
 induction xs generalizing i with
 | nil => rfl
 | cons x xs ih =>
  cases i with
  | zero => exact False.elim (Nat.not_succ_le_zero xs.length h)
  | succ i => exact ih i (Nat.le_of_succ_le_succ h)

theorem byteAtPreserved (input : ByteArray) (i : Nat) :
 byteAt input i = SHA256.get (input.data.toList.map UInt8.toNat) i := by
 unfold byteAt
 split
 next h => exact (getMapped input.data.toList i h).symm
 next h => exact (getBeyond input.data.toList i (Nat.le_of_not_gt h)).symm



theorem mappedLength {A B : Type} (f : A → B) (xs : List A) :
 (xs.map f).length = xs.length := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg Nat.succ ih

theorem appendAssoc (xs ys zs : List Nat) : (xs ++ ys) ++ zs = xs ++ (ys ++ zs) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih

theorem appendLength (xs ys : List Nat) : (xs ++ ys).length = xs.length + ys.length := by
 induction xs with
 | nil => exact (Nat.zero_add ys.length).symm
 | cons x xs ih =>
  change Nat.succ ((xs ++ ys).length) = (xs.length+1)+ys.length
  rw [ih,Nat.succ_add]

def tail (length : Nat) : List Nat := [128] ++
 List.replicate ((64 - ((length+9)%64))%64) 0 ++
 (List.range 8).map (fun i => (length*8 / 2^(8*(7-i)))%256)

theorem padAsAppend (xs : List Nat) : SHA256.pad xs = xs ++ tail xs.length := by
 unfold SHA256.pad tail
 rw [appendAssoc xs [128], appendAssoc xs]

theorem getAppendLeft (xs ys : List Nat) (i : Nat) (h : i < xs.length) :
 SHA256.get (xs ++ ys) i = SHA256.get xs i := by
 induction xs generalizing i with
 | nil => exact False.elim (Nat.not_lt_zero i h)
 | cons x xs ih =>
  cases i with
  | zero => rfl
  | succ i => exact ih i (Nat.lt_of_succ_lt_succ h)

theorem getAppendRight (xs ys : List Nat) (i : Nat) (h : xs.length ≤ i) :
 SHA256.get (xs ++ ys) i = SHA256.get ys (i-xs.length) := by
 induction xs generalizing i with
 | nil => rfl
 | cons x xs ih =>
  cases i with
  | zero => exact False.elim (Nat.not_succ_le_zero xs.length h)
  | succ i =>
   change SHA256.get (xs ++ ys) i = SHA256.get ys ((i+1)-(xs.length+1))
   rw [Nat.succ_sub_succ_eq_sub]
   exact ih i (Nat.le_of_succ_le_succ h)

def paddedAt (input : ByteArray) (i : Nat) : Nat :=
 if i < input.size then byteAt input i else SHA256.get (tail input.size) (i-input.size)

theorem paddedAtPreserved (input : ByteArray) (i : Nat) :
 paddedAt input i = SHA256.get (SHA256.pad (input.data.toList.map UInt8.toNat)) i := by
 rw [padAsAppend, mappedLength]
 unfold paddedAt
 split
 next h =>
  rw [getAppendLeft _ _ i (by rw [mappedLength]; exact h)]
  exact byteAtPreserved input i
 next h =>
  rw [getAppendRight _ _ i (by rw [mappedLength]; exact Nat.le_of_not_gt h), mappedLength]
  rfl

def schedule (input : ByteArray) (offset : Nat) : List Nat :=
 let first := (List.range 16).map fun i =>
  let j := offset+4*i
  paddedAt input j * 16777216 + paddedAt input (j+1)*65536 + paddedAt input (j+2)*256 + paddedAt input (j+3)
 (List.range 48).foldl (fun w k =>
  let i := k+16
  w ++ [SHA256.add [SHA256.small1 (SHA256.get w (i-2)),SHA256.get w (i-7),SHA256.small0 (SHA256.get w (i-15)),SHA256.get w (i-16)]]) first

theorem schedulePreserved (input : ByteArray) (offset : Nat) :
 schedule input offset = SHA256.schedule (SHA256.pad (input.data.toList.map UInt8.toNat)) offset := by
 have first : (List.range 16).map (fun i => paddedAt input (offset+4*i)*16777216 +
  paddedAt input (offset+4*i+1)*65536 + paddedAt input (offset+4*i+2)*256 + paddedAt input (offset+4*i+3)) =
  (List.range 16).map (fun i => SHA256.get (SHA256.pad (input.data.toList.map UInt8.toNat)) (offset+4*i)*16777216 +
  SHA256.get (SHA256.pad (input.data.toList.map UInt8.toNat)) (offset+4*i+1)*65536 +
  SHA256.get (SHA256.pad (input.data.toList.map UInt8.toNat)) (offset+4*i+2)*256 +
  SHA256.get (SHA256.pad (input.data.toList.map UInt8.toNat)) (offset+4*i+3)) := by
   apply SHA256Window.mapPointwise
   intro i
   rw [paddedAtPreserved,paddedAtPreserved,paddedAtPreserved,paddedAtPreserved]
 unfold schedule SHA256.schedule
 rw [first]

def block (input : ByteArray) (state : List Nat) (offset : Nat) : List Nat :=
 let last := (SHA256.constants.zip (schedule input offset)).foldl SHA256.round state
 (state.zip last).map fun x => SHA256.add [x.1,x.2]

theorem blockPreserved (input : ByteArray) (state : List Nat) (offset : Nat) :
 block input state offset = SHA256.block state (SHA256.pad (input.data.toList.map UInt8.toNat)) offset := by
 unfold block SHA256.block
 rw [schedulePreserved]

theorem padLength (input : ByteArray) :
 (SHA256.pad (input.data.toList.map UInt8.toNat)).length = input.size + (tail input.size).length := by
 rw [padAsAppend,appendLength,mappedLength]
 rfl

def digest (input : ByteArray) : String :=
 let count := (input.size+(tail input.size).length)/64
 let state := (List.range count).foldl (fun h i => block input h (64*i)) SHA256.initial
 Text.join (state.map SHA256.wordHex)

theorem digestPreserved (input : ByteArray) : digest input = SHA256.digest input := by
 unfold digest SHA256.digest
 dsimp only
 rw [padLength]
 have same := SHA256Window.foldPointwise
  (fun h i => block input h (64*i))
  (fun h i => SHA256.block h (SHA256.pad (input.data.toList.map UInt8.toNat)) (64*i))
  (List.range ((input.size+(tail input.size).length)/64))
  (fun h i => blockPreserved input h (64*i)) SHA256.initial
 exact congrArg (fun h => Text.join (h.map SHA256.wordHex)) same

#print axioms mappedLength
#print axioms padAsAppend
#print axioms getAppendLeft
#print axioms getAppendRight
#print axioms padLength
#print axioms byteAtPreserved
#print axioms paddedAtPreserved
#print axioms digestPreserved
#print axioms digest
end SFT.Host.SHA256Streaming
