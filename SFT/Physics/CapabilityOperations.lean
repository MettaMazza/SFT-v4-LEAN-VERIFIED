import SFT.Physics.CapabilityAdmission
import SFT.Foundation.ExactOperations
namespace SFT.Physics.CapabilityOperations
open CapabilityPrediction CapabilityValues
local infixr:65 " +++ " => SFT.Host.Text.append

def emptyOne : Value := .emptyOne "empty-One"
def arity (op : Opcode) (actual expected : Nat) : Except String Unit :=
  if actual = expected then .ok () else
    .error (opcodeName op +++ " requires exactly " +++ String.ofList (Nat.toDigits 10 expected) +++ " argument(s)")

def register (held : List (String × Value)) (name : String) : Except String Value :=
  match held with
  | [] => .error "instruction references an unheld register"
  | (key,value)::rest => if key = name then .ok value else register rest name

def resolve (held : List (String × Value)) : List String → Except String (List Value)
 | [] => .ok []
 | name::rest => do
   let v ← register held name
   let vs ← resolve held rest
   pure (v::vs)

def reduced (n d : Nat) (hn : 0 < n) (hd : 0 < d) : Value :=
  let q := SFT.Foundation.ExactOperations.normalizePositive n d hn hd
  .ratio ⟨q.numerator,q.positive⟩ ⟨q.denominator,Nat.pos_of_ne_zero q.denominatorNonzero⟩

inductive Arithmetic where | junction | product | quotient

def arithmetic (op : Arithmetic) (a b c d : PositiveCount) : Value :=
  match op with
  | .junction => reduced (a.value*d.value+c.value*b.value) (b.value*d.value)
      (Nat.add_pos_left (Nat.mul_pos a.positive d.positive) _) (Nat.mul_pos b.positive d.positive)
  | .product => reduced (a.value*c.value) (b.value*d.value)
      (Nat.mul_pos a.positive c.positive) (Nat.mul_pos b.positive d.positive)
  | .quotient => reduced (a.value*d.value) (b.value*c.value)
      (Nat.mul_pos a.positive d.positive) (Nat.mul_pos b.positive c.positive)

def pairs : List Value → List (Value × Value)
 | [] => []
 | [_] => []
 | a::b::rest => (a,b)::pairs rest

def lookup (entries : List (Value × Value)) (key : Value) : Except String Value :=
  match (entries.filter (fun p => equal p.1 key)).map Prod.snd with
  | [] => .error "lookup must retain exactly one registered image"
  | [v] => .ok v
  | _::_::_ => .error "lookup must retain exactly one registered image"

def comparison (same : Bool) : Value :=
  if same then .label ⟨"comparison","same-form",by decide,by decide⟩
  else .label ⟨"comparison","different-form",by decide,by decide⟩

def ratioFields : Value → Option (PositiveCount × PositiveCount)
 | .ratio a b => some (a,b)
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => none

-- The register-consuming branch; literal/input opcodes are dispatched before this branch.
def resolved (op : Opcode) (vs : List Value) : Except String Value := do
  match op with
  | .word => pure (.word vs)
  | .table =>
    if vs.length < 2 || vs.length % 2 != 0 then
      .error "table requires complete key/value pairs"
    else table (pairs vs)
  | .pair =>
    arity op vs.length 2
    match vs with
    | [a,b] => pure (.pair a b)
    | [] | [_] | _::_::_::_ => .error "pair requires exactly 2 argument(s)"
  | .lookup =>
    arity op vs.length 2
    match vs with
    | [v,key] =>
      match v with
      | .table entries => lookup entries key
      | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => .error "lookup requires a generated Fold table"
    | [] | [_] | _::_::_::_ => .error "lookup requires a generated Fold table"
  | .junction | .product | .quotient =>
    arity op vs.length 2
    match vs with
    | [left,right] =>
      match ratioFields left, ratioFields right with
      | some (a,b),some (c,d) =>
        match op with
        | .junction => pure (arithmetic .junction a b c d)
        | .product => pure (arithmetic .product a b c d)
        | .input | .emptyOne | .label | .count | .ratio | .word | .pair | .table | .lookup | .quotient | .same | .assertSame | .emit => pure (arithmetic .quotient a b c d)
      | none,none | none,some _ | some _,none => .error "exact arithmetic requires two positive ratios"
    | [] | [_] | _::_::_::_ => .error "exact arithmetic requires two positive ratios"
  | .same =>
    arity op vs.length 2
    match vs with
    | [a,b] => pure (comparison (equal a b))
    | [] | [_] | _::_::_::_ => .error "same requires exactly 2 argument(s)"
  | .assertSame =>
    arity op vs.length 2
    match vs with
    | [a,b] => if equal a b then pure emptyOne else .error "asserted Fold forms are not identical"
    | [] | [_] | _::_::_::_ => .error "assert_same requires exactly 2 argument(s)"
  | .emit =>
    arity op vs.length 1
    match vs with
    | [a] => pure a
    | [] | _::_::_ => .error "emit requires exactly 1 argument(s)"
  | .input | .emptyOne | .label | .count | .ratio => .error "unregistered Fold opcode"

theorem resolveEmpty (held : List (String × Value)) : resolve held [] = .ok [] := rfl
theorem heldRegister (name : String) (v : Value) (rest : List (String × Value)) :
    register ((name,v)::rest) name = .ok v := by
  unfold register
  rw [ite_eq_left rfl]

theorem wordExact (vs : List Value) : resolved .word vs = .ok (.word vs) := rfl
theorem pairExact (a b : Value) : resolved .pair [a,b] = .ok (.pair a b) := rfl
theorem emitExact (a : Value) : resolved .emit [a] = .ok a := rfl
theorem assertSameExact (a b : Value) (h : a = b) :
    resolved .assertSame [a,b] = .ok emptyOne := by
  have e := (equalMeaning a b).mpr h
  change (if equal a b then Except.ok emptyOne else Except.error "asserted Fold forms are not identical") = _
  rw [e]
  rfl

theorem assertDifferentRejected (a b : Value) (h : a ≠ b) :
    resolved .assertSame [a,b] = .error "asserted Fold forms are not identical" := by
  have e : equal a b = false := by
    cases eq : equal a b with
    | false => rfl
    | true => exact False.elim (h ((equalMeaning a b).mp eq))
  change (if equal a b then Except.ok emptyOne else Except.error "asserted Fold forms are not identical") = _
  rw [e]
  rfl

theorem reductionValue (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    let q := SFT.Foundation.ExactOperations.normalizePositive n d hn hd
    n * q.denominator = q.numerator * d :=
  SFT.Foundation.ExactOperations.normalizedValuePreserved n d hn hd

end SFT.Physics.CapabilityOperations
