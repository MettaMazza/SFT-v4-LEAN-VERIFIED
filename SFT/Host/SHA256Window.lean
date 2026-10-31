import SFT.Host.SHA256
namespace SFT.Host.SHA256Window
open SFT.Host.SHA256
theorem getDrop (bytes : List Nat) (offset index : Nat) :
    get (bytes.drop offset) index = get bytes (offset+index) := by
  induction offset generalizing bytes with
  | zero => rw [List.drop_zero,Nat.zero_add]
  | succ offset ih =>
    cases bytes with
    | nil => rfl
    | cons head tail =>
      rw [Nat.succ_add]
      exact ih tail

theorem mapPointwise {A B : Type} (f g : A → B) (xs : List A)
    (same : ∀ x, f x = g x) : xs.map f = xs.map g := by
  induction xs with
  | nil => rfl
  | cons x rest ih =>
    change f x :: rest.map f = g x :: rest.map g
    rw [same x,ih]

def schedule (bytes : List Nat) (offset : Nat) : List Nat :=
 let window := bytes.drop offset
 let first := (List.range 16).map fun i =>
   let j := 4*i
   get window j * 16777216 + get window (j+1)*65536 + get window (j+2)*256 + get window (j+3)
 (List.range 48).foldl (fun w k =>
   let i := k+16
   w ++ [add [small1 (get w (i-2)),get w (i-7),small0 (get w (i-15)),get w (i-16)]]) first

set_option maxHeartbeats 2000000 in
theorem schedulePreservesEveryByte (bytes : List Nat) (offset : Nat) :
    schedule bytes offset = SFT.Host.SHA256.schedule bytes offset := by
  have first :
      (List.range 16).map (fun i =>
        get (bytes.drop offset) (4*i)*16777216 +
        get (bytes.drop offset) (4*i+1)*65536 +
        get (bytes.drop offset) (4*i+2)*256 +
        get (bytes.drop offset) (4*i+3)) =
      (List.range 16).map (fun i =>
        get bytes (offset+4*i)*16777216 +
        get bytes (offset+4*i+1)*65536 +
        get bytes (offset+4*i+2)*256 +
        get bytes (offset+4*i+3)) := by
    apply mapPointwise
    intro i
    rw [getDrop bytes offset (4*i),getDrop bytes offset (4*i+1),
        getDrop bytes offset (4*i+2),getDrop bytes offset (4*i+3),
        Nat.add_assoc offset (4*i) 1,Nat.add_assoc offset (4*i) 2,
        Nat.add_assoc offset (4*i) 3]
  dsimp only [schedule,SFT.Host.SHA256.schedule]
  rw [first]

def block (h bytes : List Nat) (offset : Nat) : List Nat :=
 let last := (constants.zip (schedule bytes offset)).foldl round h
 (h.zip last).map fun x => add [x.1,x.2]

theorem blockPreserved (h bytes : List Nat) (offset : Nat) :
    block h bytes offset = SFT.Host.SHA256.block h bytes offset := by
  unfold block SFT.Host.SHA256.block
  rw [schedulePreservesEveryByte]

theorem foldPointwise {A B : Type} (f g : B → A → B) (xs : List A)
    (same : ∀ state x, f state x = g state x) (state : B) :
    xs.foldl f state = xs.foldl g state := by
  induction xs generalizing state with
  | nil => rfl
  | cons x rest ih =>
    change rest.foldl f (f state x) = rest.foldl g (g state x)
    rw [same state x]
    exact ih _

def digest (input : ByteArray) : String :=
 let bytes := pad (input.data.toList.map UInt8.toNat)
 let h := (List.range (bytes.length/64)).foldl (fun h i => block h bytes (64*i)) initial
 Text.join (h.map wordHex)

theorem digestPreserved (input : ByteArray) :
    digest input = SFT.Host.SHA256.digest input := by
  let bytes := pad (input.data.toList.map UInt8.toNat)
  have h := foldPointwise
    (fun h i => block h bytes (64*i))
    (fun h i => SFT.Host.SHA256.block h bytes (64*i))
    (List.range (bytes.length/64))
    (fun h i => blockPreserved h bytes (64*i)) initial
  exact congrArg (fun words => Text.join (words.map wordHex)) h

end SFT.Host.SHA256Window
