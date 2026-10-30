import SFT.Physics.CapabilityOperations
namespace SFT.Physics.CapabilityLiterals
open CapabilityPrediction CapabilityValues CapabilityOperations

def input (registered : List (String × Value)) (args : List String) : Except String (Value × List Value) := do
  arity .input args.length 1
  match args with
  | [name] =>
    match register registered name with
    | .ok v => pure (v,[v])
    | .error _ => .error "program requested an unregistered input"
  | [] | _::_::_ => .error "input requires exactly 1 argument(s)"

def emptyLiteral (args : List String) : Except String (Value × List Value) := do
  arity .emptyOne args.length 1
  match args with
  | [name] =>
    if name = "structural-empty-One" then pure (emptyOne,[emptyOne])
    else .error "empty One requires its registered structural literal"
  | [] | _::_::_ => .error "empty_one requires exactly 1 argument(s)"

def labelLiteral (args : List String) : Except String (Value × List Value) := do
  arity .label args.length 2
  match args with
  | [family,name] =>
    let l ← heldLabel family name
    pure (.label l,[.label l])
  | [] | [_] | _::_::_::_ => .error "label requires exactly 2 argument(s)"

-- Decimal blocks from the Python Unicode 13.0.0 runtime used for source comparisons.
def decimalBases : List Nat := [48, 1632, 1776, 1984, 2406, 2534, 2662, 2790, 2918, 3046, 3174, 3302, 3430, 3558, 3664, 3792, 3872, 4160, 4240, 6112, 6160, 6470, 6608, 6784, 6800, 6992, 7088, 7232, 7248, 42528, 43216, 43264, 43472, 43504, 43600, 44016, 65296, 66720, 68912, 69734, 69872, 69942, 70096, 70384, 70736, 70864, 71248, 71360, 71472, 71904, 72016, 72784, 73040, 73120, 92768, 93008, 120782, 120792, 120802, 120812, 120822, 123200, 123632, 125264, 130032]
def decimalDigit (c : Char) : Option Nat :=
  match decimalBases.find? (fun b => b ≤ c.toNat && c.toNat < b+10) with
  | none => none
  | some b => some (c.toNat-b)

def decimalDigits (acc : Nat) : List Char → Option Nat
 | [] => some acc
 | c::rest =>
   match decimalDigit c with
   | none => none
   | some d => decimalDigits (10*acc+d) rest

def positiveLiteral (s : String) : Except String PositiveCount :=
  match SFT.Host.Text.chars s with
  | [] => .error "count literal must be a canonical positive generated count"
  | c::rest =>
    if c.toNat = 48 then .error "count literal must be a canonical positive generated count"
    else match decimalDigits 0 (c::rest) with
    | none => .error "count literal must be a canonical positive generated count"
    | some n => if h : 0 < n then .ok ⟨n,h⟩ else .error "count literal must be positive"

def countLiteral (args : List String) : Except String (Value × List Value) := do
  arity .count args.length 1
  match args with
  | [text] =>
    let n ← positiveLiteral text
    pure (.count n,[.count n])
  | [] | _::_::_ => .error "count requires exactly 1 argument(s)"

def ratioLiteral (args : List String) : Except String (Value × List Value) := do
  arity .ratio args.length 2
  match args with
  | [left,right] =>
    let n ← positiveLiteral left
    let d ← positiveLiteral right
    pure (.ratio n d,[.count n,.count d])
  | [] | [_] | _::_::_::_ => .error "ratio requires exactly 2 argument(s)"

theorem registeredInput (name : String) (v : Value) (rest : List (String × Value)) :
    input ((name,v)::rest) [name] = .ok (v,[v]) := by
  change (match register ((name,v)::rest) name with
    | .ok w => Except.ok (w,[w])
    | .error _ => Except.error "program requested an unregistered input") = _
  rw [heldRegister]

theorem absentInput (name : String) :
    input [] [name] = .error "program requested an unregistered input" := rfl

theorem structuralLiteral : emptyLiteral ["structural-empty-One"] = .ok (emptyOne,[emptyOne]) := rfl
end SFT.Physics.CapabilityLiterals
