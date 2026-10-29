import SFT.Physics.LeptonRefinement
namespace SFT.Physics.LeptonDecimal
open LeptonIntervals SFT.Host

def decimalBases : List Nat := [48, 1632, 1776, 1984, 2406, 2534, 2662, 2790, 2918, 3046, 3174, 3302, 3430, 3558, 3664, 3792, 3872, 4160, 4240, 6112, 6160, 6470, 6608, 6784, 6800, 6992, 7088, 7232, 7248, 42528, 43216, 43264, 43472, 43504, 43600, 44016, 65296, 66720, 68912, 69734, 69872, 69942, 70096, 70384, 70736, 70864, 71248, 71360, 71472, 71904, 72016, 72784, 73040, 73120, 92768, 93008, 120782, 120792, 120802, 120812, 120822, 123200, 123632, 125264, 130032]
def spaceCodes : List Nat := [9, 10, 11, 12, 13, 28, 29, 30, 31, 32, 133, 160, 5760, 8192, 8193, 8194, 8195, 8196, 8197, 8198, 8199, 8200, 8201, 8202, 8232, 8233, 8239, 8287, 12288]
def intSpaceCodes : List Nat := [9, 10, 11, 12, 13, 32, 133, 160, 5760, 8192, 8193, 8194, 8195, 8196, 8197, 8198, 8199, 8200, 8201, 8202, 8232, 8233, 8239, 8287, 12288]

def decimalDigit (c : Char) : Option Nat :=
 match decimalBases.find? (fun base => base ≤ c.toNat && c.toNat < base+10) with
 | none => none
 | some base => some (c.toNat-base)

def trimCodes (codes : List Nat) (cs : List Char) : List Char :=
 ((cs.dropWhile (fun c => codes.contains c.toNat)).reverse.dropWhile (fun c => codes.contains c.toNat)).reverse

def strip (cs : List Char) : List Char := trimCodes spaceCodes cs

def digitsFrom : List Char → Nat → Option Nat
 | [],value => some value
 | c::cs,value => match decimalDigit c with
   | none => none
   | some digit => digitsFrom cs (value*10+digit)

def digits (cs : List Char) : Option Nat := if cs.isEmpty then none else digitsFrom cs 0

def split (separator : Char) : List Char → List (List Char)
 | [] => [[]]
 | c::cs => if c == separator then [] :: split separator cs else
   match split separator cs with
   | [] => [[c]]
   | head::tail => (c::head)::tail

def exponentTail : List Char → Nat → Bool → Option Nat
 | [],value,afterDigit => if afterDigit then some value else none
 | c::cs,value,afterDigit =>
   if c == '_' then if afterDigit then exponentTail cs value false else none
   else match decimalDigit c with
     | none => none
     | some digit => exponentTail cs (value*10+digit) true

def exponent (cs : List Char) : Option Int :=
 let cs := trimCodes intSpaceCodes cs
 match cs with
 | [] => none
 | head::tail =>
   if head == '-' then (exponentTail tail 0 false).map (fun n => -(Int.ofNat n))
   else if head == '+' then (exponentTail tail 0 false).map Int.ofNat
   else (exponentTail cs 0 false).map Int.ofNat

def coefficient (cs : List Char) : Except String (Nat × Nat) :=
 match split '.' cs with
 | [] => .error "ValueError: measurement decimal record is invalid"
 | whole::rest => match rest with
   | [] => match digits whole with
     | none => .error "ValueError: measurement digits are invalid"
     | some n => .ok (n,0)
   | fractional::tail => match tail with
     | _::_ => .error "ValueError: measurement decimal record is invalid"
     | [] => match digits whole with
       | none => .error "ValueError: measurement decimal digits are invalid"
       | some _ => match digits fractional with
         | none => .error "ValueError: measurement decimal digits are invalid"
         | some _ => match digits (whole++fractional) with
           | none => .error "ValueError: measurement decimal digits are invalid"
           | some n => .ok (n,fractional.length)

def exactDecimal (text : String) : Except String Rat := do
 let compact := strip ((Text.chars text).filter (fun c => c != ' '))
 if compact.isEmpty || Text.contains (String.ofList compact) "..." ||
   compact.head? == some '-' || compact.head? == some '+' then
   .error "ValueError: measurement is not a finite positive decimal record"
 else
   let (coefficientChars,exp) ← match split 'e' compact with
    | [] => .error "ValueError: measurement exponent record is invalid"
    | coefficient::rest => match rest with
      | [] => .ok (coefficient,0)
      | expChars::tail => match tail with
        | _::_ => .error "ValueError: measurement exponent record is invalid"
        | [] => match exponent expChars with
          | none => .error "ValueError: invalid integer exponent"
          | some e => .ok (coefficient,e)
   let (n,places) ← coefficient coefficientChars
   if n == 0 then .error "ValueError: measurement record is outside the positive domain"
   else match exp with
    | .ofNat power => .ok (normalize (.ofNat (n*10^power)) (10^places) (Nat.pow_pos (by decide)))
    | .negSucc power => .ok (normalize (.ofNat n) (10^(places+(power+1))) (Nat.pow_pos (by decide)))

end SFT.Physics.LeptonDecimal
