import SFT.Physics.NuclearRecurrence
import SFT.Host.Text
namespace SFT.Physics.NuclearSequenceSource
open SFT.Host

-- The source guard treats booleans and every non-integer JSON value alike.
inductive Coordinate where
 | integer : Int → Coordinate
 | other

structure Record where
 sourceId : Option String
 sequence : Option (List Coordinate)

def sourceId := "IAEA-INDC-NDS-0452-MAGIC-NUMBERS"
def invalidSequence := "ValueError: IAEA magic-number sequence is not a positive exact record"

def positiveCoordinates : List Coordinate → Except String (List Nat)
 | [] => .ok []
 | .integer (.ofNat (n+1))::tail => do
   let rest ← positiveCoordinates tail
   pure ((n+1)::rest)
 | .integer (.ofNat 0)::_ => .error invalidSequence
 | .integer (.negSucc _)::_ => .error invalidSequence
 | .other::_ => .error invalidSequence

def magicSequence (record : Record) : Except String (List Nat) :=
 let identityOK := match record.sourceId with
  | none => false
  | some name => Text.equal name sourceId
 if !identityOK then .error "ValueError: IAEA magic-number source identity changed"
 else match record.sequence with
  | none => .error invalidSequence
  | some [] => .error invalidSequence
  | some (first::rest) => positiveCoordinates (first::rest)

def orderedEqual : List Nat → List Nat → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => a==b && orderedEqual as bs

theorem orderedEqualSelf (xs : List Nat) : orderedEqual xs xs=true := by
 induction xs with
 | nil => rfl
 | cons a xs ih =>
   change (a==a && orderedEqual xs xs)=true
   rw [ih]
   have head : (a==a)=true := by
     induction a with
     | zero => rfl
     | succ a ih => exact ih
   rw [head]
   rfl

theorem orderedEqualExact (xs ys : List Nat) (same : orderedEqual xs ys=true) : xs=ys := by
 induction xs generalizing ys with
 | nil => cases ys with
   | nil => rfl
   | cons b bs => cases same
 | cons a as ih => cases ys with
   | nil => cases same
   | cons b bs =>
     change (a==b && orderedEqual as bs)=true at same
     have head : (a==b)=true := by
       cases h : (a==b) with
       | false => rw [h] at same; cases same
       | true => rfl
     have tail : orderedEqual as bs=true := by
       rw [head] at same
       exact same
     have eq : a=b := Nat.eq_of_beq_eq_true head
     cases eq
     exact congrArg (List.cons a) (ih bs tail)

def precheck (record : Record) : Except String Unit := do
 let observed ← magicSequence record
 let derived ← NuclearClosure.closurePrefix (.integer 8)
 if orderedEqual observed derived then .ok ()
 else .error "ValueError: sealed nuclear closure prefix differs from the IAEA record"

def registered : Record := ⟨some sourceId,some ([2,8,20,28,50,82,126,184].map fun n => .integer (.ofNat n))⟩
theorem registeredSequence : magicSequence registered=.ok [2,8,20,28,50,82,126,184] := rfl
theorem registeredPasses : precheck registered=.ok () := rfl

def validateWith {α : Type} (record : Record) (blind : Unit → Except String α) : Except String α := do
 precheck record
 blind ()

theorem registeredDelegates {α : Type} (blind : Unit → Except String α) : validateWith registered blind=blind () := rfl

theorem failedRecordStops {α : Type} (record : Record) (blind : Unit → Except String α)
 (message : String) (failed : precheck record=.error message) : validateWith record blind=.error message := by
 unfold validateWith
 rw [failed]
 rfl

end SFT.Physics.NuclearSequenceSource
