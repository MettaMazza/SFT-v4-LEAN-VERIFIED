import SFT.Applications.Discovery.Reports
namespace SFT.Applications.Discovery.MaxCore
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Explorer
open SFT.Applications.Discovery.Reports

structure Trace where
 kind : Resolution
 period : Nat := 0
 transient : Nat := 0

def seenAt (xs : List (Fraction × Nat)) (x : Fraction) : Option Nat :=
 (xs.find? (fun pair => equal pair.1 x)).map Prod.snd

def traceLoop (m : Int) : Nat → Nat → Fraction → List (Fraction × Nat) → Trace
 | 0, _, _, _ => ⟨.unresolved,0,0⟩
 | fuel+1, n, current, seen =>
  let next := mFold current m
  if equal next (fraction 1 1) then ⟨.returnsOne,0,n+1⟩
  else if equal next current then ⟨.fixed,1,n⟩
  else match seenAt seen next with
   | some index => ⟨.cycle,n-index,index⟩
   | none => traceLoop m fuel (n+1) next ((next,n)::seen)

def trace (x : Fraction) (m : Int) : Trace := traceLoop m 50000 0 x []
structure DeepResult where
 tally : Tally := {}
 total : Nat := 0
 longestCycle : Nat := 0

def addTrace (acc : DeepResult) (t : Trace) : DeepResult :=
 {tally := addResolution acc.tally t.kind,total := acc.total+1,longestCycle := match t.kind with | .cycle => max acc.longestCycle t.period | .returnsOne => acc.longestCycle | .fixed => acc.longestCycle | .unresolved => acc.longestCycle}

def deepAxis1 (upTo : Nat := 100) : DeepResult :=
 (List.range (upTo-1)).foldl (fun acc mi =>
  (List.range (upTo-1)).foldl (fun acc di =>
   (List.range (di+1)).foldl (fun acc j => addTrace acc (trace (fraction (Int.ofNat (j+1)) (Int.ofNat (di+2))) (Int.ofNat (mi+2)))) acc) acc) {}

structure CensusRow where
 value : Fraction
 denominator : Nat
 result : Trace

def orbitCensus (denomMax : Nat := 120) : List CensusRow :=
 (List.range (denomMax-1)).flatMap (fun di =>
  (List.range (di+1)).map (fun j =>
   let value := fraction (Int.ofNat (j+1)) (Int.ofNat (di+2))
   {value,denominator := di+2,result := trace value 2}))

def sectorPrimes : List Int := [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
def identityPrimes : List Int := [2,3,5,7,11,13,17,19,23,29,31]
def ladder : List Int := [2,3,5,7]
structure SectorRow where
 prime : Int
 modes : List Fraction
 coupling : Fraction
 shortfall : Fraction
 cumulative : Fraction
 span : Fraction
 inLadder : Bool
 halfShared : Bool

def sectorScan : List SectorRow :=
 ((sectorPrimes.foldl (fun (rows,total,span) p =>
  let modes := sortFractions (standing p)
  let shortfall := fraction 1 (integerFromOne p)
  let total := add total shortfall
  let span := multiply span (fraction (integerFromOne p) 1)
  let row : SectorRow := {prime := p,modes,coupling := fraction (integerFromOne p-1) (integerFromOne p),shortfall,cumulative := total,span,inLadder := ladder.any (fun q => decide (p=q)),halfShared := if p > 2 then contains modes (fraction 1 2) else false}
  (rows++[row],total,span)) (([],fraction 0 1,fraction 1 1) : List SectorRow × Fraction × Fraction)).1)

def ladderShortfall : Fraction := ladder.foldl (fun s p => add s (fraction 1 p)) (fraction 0 1)
def ladderSpan : Fraction := ladder.foldl (fun s p => multiply s (fraction p 1)) (fraction 1 1)
structure IdentityRow where
 first : Int
 second : Int
 shared : List Fraction

def crossIdentities : List IdentityRow :=
 identityPrimes.zipIdx.flatMap (fun (p,i) =>
  (identityPrimes.drop (i+1)).filterMap (fun q =>
   let shared := sortFractions ((standing p).filter (contains (standing q)))
   if shared.isEmpty then none else some {first := p,second := q,shared}))

def universalModes : List Fraction :=
 match identityPrimes.filter (fun p => decide (p > 2)) with
 | [] => []
 | p::ps => sortFractions (ps.foldl (fun modes p => modes.filter (contains (standing p))) (standing p))
def sectorOrbitLengths : List (Int × Nat) :=
 identityPrimes.filterMap (fun p => if p < 2 then none else some (p,(orbitOf (fraction 1 (integerFromOne p)) 2).length))

structure RunningRow where
 depth : Nat
 tower : Fraction
 couplings : List Fraction
 gaps : List Fraction
 em : Fraction
 ordered : Bool

def greater (a b : Fraction) : Bool := decide (a.numerator*b.denominator > b.numerator*a.denominator)
def runningRow (depth : Nat) : RunningRow :=
 let tower := fraction (wholePower 2 (Int.ofNat depth)) 1
 let coupling := fun m => divide (add (fraction (m-1) 1) tower) (add (fraction m 1) tower)
 let couplings := ladder.map coupling
 let em := fraction 1 2
 {depth,tower,couplings,gaps := couplings.map (subtract (fraction 1 1)),em,ordered := greater (coupling 3) (coupling 2) && greater (coupling 2) em}
def runningCurves (maxDepth : Int := 56) : List RunningRow := (List.range (maxDepth+1).toNat).map runningRow
structure OnShellRow where
 depth : Nat
 sineSquared : Fraction
 massRatioSquared : Fraction
 sum : Fraction
 tied : Bool

def onShell : List OnShellRow :=
 (List.range 15).map (fun i =>
  let depth := i+1
  let sineSquared := divide (fraction 1 1) (add (fraction 2 1) (fraction (wholePower 2 (Int.ofNat depth)) 1))
  let massRatioSquared := subtract (fraction 1 1) sineSquared
  let sum := add sineSquared massRatioSquared
  {depth,sineSquared,massRatioSquared,sum,tied := equal sum (fraction 1 1)})
end SFT.Applications.Discovery.MaxCore
