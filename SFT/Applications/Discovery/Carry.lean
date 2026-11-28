import SFT.Applications.Discovery.Explorer
import SFT.Host.Text
namespace SFT.Applications.Discovery.Carry
open SFT.Host.Text
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Explorer

inductive Family where
 | standingModes | coupling | modeCount | orbitPeriod | tower

def whitespace (c : Char) : Bool := decide (c.toNat = 32 ∨ (9 ≤ c.toNat ∧ c.toNat ≤ 13))
def wordChar (c : Char) : Bool := decide ((65 ≤ c.toNat ∧ c.toNat ≤ 90) ∨ (97 ≤ c.toNat ∧ c.toNat ≤ 122) ∨ (48 ≤ c.toNat ∧ c.toNat ≤ 57) ∨ c.toNat = 95)
def hasPrefixChars : List Char → List Char → Bool
 | [], _ => true
 | _::_, [] => false
 | a::as, b::bs => if a.toNat = b.toNat then hasPrefixChars as bs else false

def wordsRev (s : String) : List String :=
 let (out,current) := (chars s).foldl (fun (out,current) c =>
  bif wordChar c then (out,c::current)
  else if current.isEmpty then (out,[]) else (String.ofList current.reverse::out,[])) (([],[]) : List String×List Char)
 if current.isEmpty then out else String.ofList current.reverse::out

def chainTail : Nat → List Char → Nat × List Char
 | 0, xs => (0,xs)
 | fuel+1, xs =>
  let next := xs.dropWhile whitespace
  if hasPrefixChars ['+'] next then
   let rhs := (next.drop 1).dropWhile whitespace
   if hasPrefixChars (chars "ONE") rhs then
    let (count,tail) := chainTail fuel (rhs.drop 3)
    (count+1,tail)
   else (0,xs)
  else (0,xs)
def chainCounts : Nat → List Char → List Nat
 | 0, _ => []
 | fuel+1, xs =>
  if xs.isEmpty then []
  else if hasPrefixChars (chars "ONE") xs then
   let (count,tail) := chainTail xs.length (xs.drop 3)
   if count > 0 then (count+1)::chainCounts fuel tail else chainCounts fuel (xs.drop 1)
  else chainCounts fuel (xs.drop 1)

def pinnedParam (source : String) : Option Int :=
 let ws := wordsRev (lowerAscii source)
 let names : List (String×Int) := [("two",2),("three",3),("four",4),("five",5),("six",6),("seven",7),("eight",8),("nine",9),("ten",10),("eleven",11),("twelve",12),("thirteen",13)]
 let found := names.filterMap (fun (word,n) => bif ws.any (fun w => SFT.Host.Text.equal word w) then some n else none)
 let cs := chars source
 let all := found++(chainCounts cs.length cs).map Int.ofNat
 all.foldl (fun best n => match best with | none => some n | some old => some (max old n)) none

def family (source : String) : Option Family :=
 let s := lowerAscii source
 let any := fun (needles : List String) => needles.any (fun needle => SFT.Host.Text.contains s needle)
 if any ["standing_modes","fixed point","standing mode","returns to itself"] then some .standingModes
 else if any ["take(m,one)","take(m, one)","coupling","m-less-one over"] then some .coupling
 else if any ["mode count","number of modes","number of interior modes","generation count"] then some .modeCount
 else if any ["orbit","multiplicative order","fold-orbit","period"] then some .orbitPeriod
 else if any ["twotothe","two-tothe","twoto-the","two-to-the","covering tower","binary tower","doubling"] then some .tower
 else none

inductive Probe where
 | modes (values : List Fraction)
 | ratio (value : Fraction)
 | count (value : Int)
 | empty

def probeEqual (a b : Probe) : Bool :=
 match a with
 | .modes xs => match b with
   | .modes ys => xs.all (fun x => Explorer.contains ys x) && ys.all (fun y => Explorer.contains xs y)
   | .ratio _ => false
   | .count _ => false
   | .empty => false
 | .ratio x => match b with
   | .modes _ => false
   | .ratio y => equal x y
   | .count _ => false
   | .empty => false
 | .count x => match b with
   | .modes _ => false
   | .ratio _ => false
   | .count y => decide (x = y)
   | .empty => false
 | .empty => match b with
   | .modes _ => false
   | .ratio _ => false
   | .count _ => false
   | .empty => true

def probe (f : Family) (n : Int) : Probe :=
 match f with
 | .standingModes => .modes (standing n)
 | .coupling => match famCoupling n with | none => .empty | some x => .ratio x
 | .modeCount => .count (Int.ofNat (famModeCount n))
 | .orbitPeriod => .count (Int.ofNat (famOrbit n))
 | .tower => .count (famTower n)

inductive Verdict where
 | noSweep | carriesFurther | resolvesAtPin
structure Result where
 verdict : Verdict
 family : Option Family
 pin : Option Int
 distinctBeyond : Nat := 0

def carryVerdict (source : String) : Result :=
 match family source with
 | none => ⟨.noSweep,none,none,0⟩
 | some f => match pinnedParam source with
  | none => ⟨.noSweep,some f,none,0⟩
  | some pin =>
   let anchor :=  probe f pin
   let bound := max (pin+1) 60
   let beyond := (List.range (bound-pin).toNat).foldl (fun out i =>
    let value := probe f (pin+1+Int.ofNat i)
    if probeEqual value .empty || probeEqual value anchor || out.any (fun old => probeEqual old value) then out else value::out) []
   ⟨if beyond.isEmpty then .resolvesAtPin else .carriesFurther,some f,some pin,beyond.length⟩
end SFT.Applications.Discovery.Carry
