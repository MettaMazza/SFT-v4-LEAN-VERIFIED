import SFT.Chemistry.AnalyticalPrecision
import SFT.Physics.LeptonIntervals
namespace SFT.Chemistry.AnalyticalSensitivity
open SFT.Host SFT.Physics.CapabilityValues SFT.Physics.LeptonIntervals
set_option maxHeartbeats 100000000
abbrev Pair := Rat × Rat
inductive Side where
 | emptyOne | rises | falls
structure Segment where
 side : Side
 magnitude : Rat
def positive (q : Rat) : Bool := @decide (Int.lt 0 q.num) (Int.decLt _ _)
def less (a b : Rat) : Bool :=
 @decide (Int.lt (a.num * Int.ofNat b.den) (b.num * Int.ofNat a.den)) (Int.decLt _ _)
def adjacent : List Pair → List (Pair × Pair)
 | [] => []
 | first::rest => match rest with
   | [] => []
   | second::tail => (first,second)::adjacent (second::tail)
def strictlyOrdered : List Pair → Bool
 | [] => true
 | first::rest => match rest with
   | [] => true
   | second::tail => less first.1 second.1 && strictlyOrdered (second::tail)
def segment (first second : Pair) : Except String Segment := do
 let dx := subtract second.1 first.1
 let dy := subtract second.2 first.2
 let side := if (@decide (dy.num = 0) (Int.decEq _ _)) then Side.emptyOne else if positive dy then Side.rises else Side.falls
 let denominator := dy.den * dx.num.natAbs
 if h : 0 < denominator then
  pure ⟨side, normalize (Int.ofNat (dy.num.natAbs * dx.den)) denominator h⟩
 else throw "strict ordered input support required"
def sensitivitySegments (analyte method condition : HeldLabel) (pairs : List Pair) : Except String (List Segment) := do
 if !Text.equal analyte.family "analyte" || !Text.equal method.family "analytical-method" ||
    !Text.equal condition.family "analytical-condition" || pairs.length < 2 ||
    !(pairs.all (fun p => positive p.1 && positive p.2)) then
  throw "complete positive response support required"
 if !strictlyOrdered pairs then throw "strict ordered input support required"
 (adjacent pairs).mapM (fun pair => segment pair.1 pair.2)
theorem adjacentNil : adjacent [] = [] := rfl
theorem adjacentSingleton (p : Pair) : adjacent [p] = [] := rfl
theorem adjacentCons (a b : Pair) (tail : List Pair) :
 adjacent (a::b::tail) = (a,b)::adjacent (b::tail) := rfl
theorem adjacentCount (first : Pair) (rest : List Pair) :
 (adjacent (first::rest)).length = rest.length := by
 induction rest generalizing first with
 | nil => rfl
 | cons next tail ih =>
  change (adjacent (next::tail)).length + 1 = tail.length + 1
  exact congrArg Nat.succ (ih next)
theorem successorRetainsSegments (earlier : List Pair) (previous next : Pair) :
 adjacent (earlier++[previous,next]) = adjacent (earlier++[previous]) ++ [(previous,next)] := by
 induction earlier with
 | nil => rfl
 | cons first rest ih =>
  cases rest with
  | nil => rfl
  | cons second tail =>
   change (first,second)::adjacent ((second::tail)++[previous,next]) =
     (first,second)::(adjacent ((second::tail)++[previous])++[(previous,next)])
   exact congrArg (List.cons (first,second)) ih
def analyte : HeldLabel := ⟨"analyte","a",rfl,rfl⟩
def method : HeldLabel := ⟨"analytical-method","m",rfl,rfl⟩
def condition : HeldLabel := ⟨"analytical-condition","c",rfl,rfl⟩
def whole (n : Nat) : Rat := normalize (.ofNat n) 1 (by decide)
def originalPairs : List Pair := [(whole 1,whole 2),(whole 2,whole 5),(whole 3,whole 5)]
def originalSegments := sensitivitySegments analyte method condition originalPairs
def identityWitness : Bool := Text.equal analyte.label "a"
def inputWitness : Bool := (originalPairs.map fun p => (p.1.num.natAbs,p.1.den)) == [(1,1),(2,1),(3,1)]
def responseWitness : Bool := originalPairs.length == 3
def changeWitness : Bool := (originalSegments.toOption.map fun xs =>
 match xs with | [] => false | x::_ => match x.side with | .rises => true | .emptyOne => false | .falls => false).getD false
def relationWitness : Bool := (originalSegments.toOption.map fun xs =>
 match xs with | [] => false | x::_ => (@decide (x.magnitude.num = 3) (Int.decEq _ _)) && x.magnitude.den == 1).getD false
def domainWitness : Bool := (originalSegments.toOption.map fun xs => xs.length == 2).getD false
def noiseWitness : Bool := (originalSegments.toOption.map fun xs =>
 match xs with
 | [] => false
 | _::rest =>
  match rest with
  | [] => false
  | x::_ =>
   match x.side with
   | .emptyOne => true
   | .rises => false
   | .falls => false).getD false
def successorWitness : Bool :=
 ((sensitivitySegments analyte method condition (originalPairs++[(whole 4,whole 6)])).toOption.map fun xs => xs.length==3).getD false
theorem identityPassed : identityWitness = true := rfl
theorem inputPassed : inputWitness = true := rfl
theorem responsePassed : responseWitness = true := rfl
theorem changePassed : changeWitness = true := rfl
theorem relationPassed : relationWitness = true := rfl
theorem domainPassed : domainWitness = true := rfl
theorem noisePassed : noiseWitness = true := rfl
theorem successorPassed : successorWitness = true := rfl
end SFT.Chemistry.AnalyticalSensitivity
