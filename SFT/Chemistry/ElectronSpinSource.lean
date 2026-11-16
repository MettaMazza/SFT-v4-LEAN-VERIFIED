import SFT.Chemistry.ElectronSpinHtml
import SFT.Chemistry.ElectronSpinPrediction
namespace SFT.Chemistry.ElectronSpinSource
open SFT.Host
-- Unicode decimal blocks used by Python's source regex \d and int.
def decimalStarts : List Nat := [48, 1632, 1776, 1984, 2406, 2534, 2662, 2790, 2918, 3046, 3174, 3302, 3430, 3558, 3664, 3792, 3872, 4160, 4240, 6112, 6160, 6470, 6608, 6784, 6800, 6992, 7088, 7232, 7248, 42528, 43216, 43264, 43472, 43504, 43600, 44016, 65296, 66720, 68912, 69734, 69872, 69942, 70096, 70384, 70736, 70864, 71248, 71360, 71472, 71904, 72016, 72784, 73040, 73120, 92768, 93008, 120782, 120792, 120802, 120812, 120822, 123200, 123632, 125264, 130032]
def decimalDigit (c : Char) : Option Nat :=
 match decimalStarts.find? (fun base => base ≤ c.toNat && c.toNat < base+10) with
 | none => none
 | some base => some (c.toNat-base)
def isDecimal (c : Char) : Bool := (decimalDigit c).isSome
def decimalNumber (cs : List Char) : Nat :=
 cs.foldl (fun n c => 10*n+(decimalDigit c).getD 0) 0
def upper (c : Char) : Bool := 65 ≤ c.toNat && c.toNat ≤ 90
def lower (c : Char) : Bool := 97 ≤ c.toNat && c.toNat ≤ 122
def insertCount (rows : List (String × Nat)) (key : String) (value : Nat) : List (String × Nat) :=
 if rows.any (fun p => Text.equal p.1 key) then
  rows.map (fun p => if Text.equal p.1 key then (key,value) else p)
 else rows++[(key,value)]
def formulaParts : Nat → List Char → List (String × Nat) → Except String (List (String × Nat))
 | 0,_,_ => .error "NIST molecular formula is outside the declared finite grammar"
 | _+1,[],rows => if rows.isEmpty then .error "NIST molecular formula is outside the declared finite grammar" else .ok rows
 | fuel+1,c::cs,rows =>
  if !upper c then .error "NIST molecular formula is outside the declared finite grammar" else
  let (symbol,rest) := match cs with
   | [] => ([c],[])
   | d::ds => if lower d then ([c,d],ds) else ([c],cs)
  let digits := rest.takeWhile isDecimal
  formulaParts fuel (rest.drop digits.length)
   (insertCount rows (String.ofList symbol) (if digits.isEmpty then 1 else decimalNumber digits))
def formulaComposition (formula : String) : Except String (List (String × Nat) × String) := do
 let cs := Text.chars formula
 let (body,charge) := match cs.reverse with
  | [] => (cs,"empty-One")
  | c::rest => if c.toNat==43 then (rest.reverse,"remove-electron")
    else if c.toNat==45 then (rest.reverse,"adjoin-electron") else (cs,"empty-One")
 let parts ← formulaParts (body.length+1) body []
 return (parts,charge)
def isXState (s : String) : Bool :=
 match Text.chars s with
 | [] => false
 | x::rest => match rest with
   | [] => false
   | c::_ => x.toNat==88 && (SFT.Physics.CapabilityValues.whitespace c || c.toNat==94)
def multiplicityChars : List Char → Option Nat
 | [] => none
 | c::cs => if c.toNat==94 then
    let digits := cs.takeWhile isDecimal
    if digits.isEmpty then multiplicityChars cs else some (decimalNumber digits)
   else multiplicityChars cs
def stateFromRows (rows : List (List String)) : Except String (String × Nat) :=
 match rows.find? (fun r => match r with | [] => false | s::_ => isXState s) with
 | none => .error "registered NIST source lacks an X-state row"
 | some row =>
  let term := match row with | [] => "" | x::_ => x
  match multiplicityChars (Text.chars term) with
  | none => .error "NIST X-state multiplicity is absent"
  | some width => .ok (term,width)
structure TargetRecord where
 snapshotHash : String
 groundStateTerm : String
 measuredMultiplicity : Nat
structure Resolved where
 rowId : String
 stateTerm : String
 multiplicity : SFT.Physics.CapabilityValues.PositiveCount
 snapshotHash : String
 targetValue : SFT.Physics.CapabilityValues.Value
def sameComposition (a b : List (String × Nat)) : Bool :=
 a.length==b.length && a.all (fun p => b.any (fun q => Text.equal p.1 q.1 && p.2==q.2))
def resolveTarget (row : ElectronSpinPrediction.InputRow) (formula : String)
 (expectedHash actualHash : String) (target : TargetRecord) (sourceRows : List (List String)) :
 Except String Resolved := do
 if !Text.equal actualHash expectedHash || !Text.equal target.snapshotHash expectedHash then
  throw "NIST source byte identity differs from registered target"
 let (term,width) ← stateFromRows sourceRows
 if !Text.equal term target.groundStateTerm || width != target.measuredMultiplicity then
  throw "independent NIST state extraction differs from target registry"
 let (composition,charge) ← formulaComposition formula
 let registered := row.populations.foldl
  (fun acc p => insertCount acc p.elementSymbol.label p.occurrenceCount.value) []
 if !sameComposition composition registered || !Text.equal charge row.transfer.action.label then
  throw "registered Fold input does not reproduce the NIST formula and held charge"
 let label ← SFT.Physics.CapabilityValues.heldLabel "measured-ground-state-term" term
 let count ← SFT.Physics.CapabilityValues.count width
 return ⟨row.rowId,term,count,expectedHash,.word [.label label,.count count]⟩
end SFT.Chemistry.ElectronSpinSource
