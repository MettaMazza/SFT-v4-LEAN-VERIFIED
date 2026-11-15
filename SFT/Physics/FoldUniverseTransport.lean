import SFT.Mathematics.OrbitLoopCompletion
import SFT.Physics.FiniteQuantumGravity
namespace SFT.Physics.FoldUniverseTransport
open GeneratorOperations
open SFT.Mathematics.LimitComputations (equalInt)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Python's integer/Boolean input value; only source-explicit guards reject Booleans. -/
def integerValue : CountInput → Int
 | .integer n => n
 | .boolean false => 0
 | .boolean true => 1
def unitResidues (denominator : CountInput) : Except String (List Nat) :=
 match denominator with
 | .boolean _ => .error "a Fold orbit component requires a positive odd denominator"
 | .integer d => if d<3 || !equalInt (d%2) 1 then
    .error "a Fold orbit component requires a positive odd denominator"
   else .ok ((List.range (d.toNat-1)).map (·+1) |>.filter (fun r => Nat.gcd r d.toNat == 1))
def foldResidue (residue denominator : CountInput) : Except String Nat := do
 let units ← unitResidues denominator
 let r := integerValue residue
 if !(units.any (fun n => equalInt (.ofNat n) r)) then
  .error "Fold residue must belong to the denominator unit orbit"
 else
  let folded := (2*r) % integerValue denominator
  if folded<1 then .error "Fold unexpectedly produced an empty residue" else pure folded.toNat
/-- Reuse the proved terminating original orbit; this source starts its trace after the first step. -/
def orbitTrace (residue denominator : CountInput) : Except String (List Nat) := do
 let _ ← foldResidue residue denominator
 let r := (integerValue residue).toNat
 let d := (integerValue denominator).toNat
 match SFT.Mathematics.OrbitNumberWitnesses.orbitWitness r d with
 | none => .error "internal orbit replay incomplete"
 | some trace => trace.mapM (fun x => foldResidue (.integer (.ofNat x)) denominator)
def pythonRemainder (a b : Int) : Int :=
 let r := a % b
 if b<0 && !equalInt r 0 then r+b else r
def crtComponentMap (residue left right : CountInput) : Except String (Int × Int) := do
 let l := integerValue left
 let r := integerValue right
 if Nat.gcd l.natAbs r.natAbs != 1 then
  .error "CRT component map requires coprime odd factors and a composite unit residue"
 else
  let units ← unitResidues (.integer (l*r))
  let x := integerValue residue
  if !(units.any (fun n => equalInt (.ofNat n) x)) then
   .error "CRT component map requires coprime odd factors and a composite unit residue"
  else pure (pythonRemainder x l,pythonRemainder x r)
def equalPair (a b : Int × Int) : Bool := equalInt a.1 b.1 && equalInt a.2 b.2
structure ComponentCensus where
 composite : Int
 source : List Nat
 pairs : List (Int × Int)
 target : List (Int × Int)
 bijection : Bool
 foldCommutes : Bool
def crtComponentCensus (left right : CountInput) : Except String ComponentCensus := do
 let l := integerValue left
 let r := integerValue right
 if Nat.gcd l.natAbs r.natAbs != 1 then .error "component census requires coprime factors"
 else
  let composite := l*r
  let source ← unitResidues (.integer composite)
  let pairs ← source.mapM (fun n => crtComponentMap (.integer (.ofNat n)) left right)
  let ls ← unitResidues left
  let rs ← unitResidues right
  let target := ls.flatMap (fun a => rs.map (fun b => (Int.ofNat a,Int.ofNat b)))
  let checks ← source.mapM fun n => do
   let f ← foldResidue (.integer (.ofNat n)) (.integer composite)
   let pair ← crtComponentMap (.integer (.ofNat f)) left right
   let a ← foldResidue (.integer (pythonRemainder (.ofNat n) l)) left
   let b ← foldResidue (.integer (pythonRemainder (.ofNat n) r)) right
   pure (equalPair pair (.ofNat a,.ofNat b))
  let distinct := pairs.foldl (fun seen p => if seen.any (equalPair p) then seen else seen++[p]) []
  let bijection := distinct.length==source.length && source.length==target.length &&
   pairs.all (fun p => target.any (equalPair p)) && target.all (fun p => pairs.any (equalPair p))
  pure ⟨composite,source,pairs,target,bijection,checks.all id⟩
def leastCommonMultiple (left right : CountInput) : Except String Int :=
 let l := integerValue left
 let r := integerValue right
 let g := Nat.gcd l.natAbs r.natAbs
 if g==0 then .error "integer division or modulo by zero" else .ok ((l*r)/(.ofNat g))
structure CompositePeriod where
 left : Nat
 right : Nat
 composite : Nat
 lcm : Int
 matchesSource : Bool
def compositePeriod (left right : CountInput) : Except String CompositePeriod := do
 let ls ← orbitTrace (.integer 1) left
 let rs ← orbitTrace (.integer 1) right
 let combined ← orbitTrace (.integer 1) (.integer (integerValue left*integerValue right))
 let expected ← leastCommonMultiple (.integer (.ofNat ls.length)) (.integer (.ofNat rs.length))
 pure ⟨ls.length,rs.length,combined.length,expected,equalInt (.ofNat combined.length) expected⟩
def denominatorSteps (denominator : CountInput) : Nat → CountInput → Except String (List Int)
 | 0,_ => .ok []
 | n+1,current => do
  let next ← foldResidue current denominator
  let tail ← denominatorSteps denominator n (.integer (.ofNat next))
  pure (integerValue denominator::tail)
def denominatorTrace (residue denominator depth : CountInput) : Except String (List Int) := do
 let n ← LatticeOperator.positiveCount depth "denominator trace requires positive depth"
 denominatorSteps denominator n residue
def trajectory (denominator : CountInput) : Nat → CountInput → Except String (List Nat)
 | 0,_ => .ok []
 | n+1,current => do
  let next ← foldResidue current denominator
  let tail ← trajectory denominator n (.integer (.ofNat next))
  pure (next::tail)
def pairedTrajectory (left right : CountInput) : Nat → CountInput → CountInput → Except String (List Nat)
 | 0,_,_ => .ok []
 | n+1,a,b => do
  let nextLeft ← foldResidue a left
  let nextRight ← foldResidue b right
  let tail ← pairedTrajectory left right n (.integer (.ofNat nextLeft)) (.integer (.ofNat nextRight))
  pure (nextRight::tail)
def equalTrace : List Nat → List Nat → Bool
 | [],[] => true
 | a::as,b::bs => a==b && equalTrace as bs
 | [],_::_ => false
 | _::_,[] => false
def targetTrajectoryIndependentOfSource (left right targetResidue depth : CountInput) : Except String Bool := do
 let targets ← unitResidues right
 if !(targets.any (fun n => equalInt (.ofNat n) (integerValue targetResidue))) then
  .error "target residue must belong to the target component"
 else
  let n := (integerValue depth).toNat
  let expected ← trajectory right n targetResidue
  let sources ← unitResidues left
  let observations ← sources.mapM (fun a => pairedTrajectory left right n (.integer (.ofNat a)) targetResidue)
  pure (!observations.isEmpty && observations.all (fun row => equalTrace row expected))
end SFT.Physics.FoldUniverseTransport
