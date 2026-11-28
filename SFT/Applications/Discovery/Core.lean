namespace SFT.Applications.Discovery
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

structure Fraction where
 numerator : Int
 denominator : Int

def fraction (top bottom : Int) : Fraction :=
 let top := if bottom < 0 then -top else top
 let bottom := if bottom < 0 then -bottom else bottom
 let common := Nat.gcd top.natAbs bottom.natAbs
 if common = 0 then ⟨top,bottom⟩
 else ⟨top.tdiv (Int.ofNat common),bottom.tdiv (Int.ofNat common)⟩
def add (a b : Fraction) : Fraction := fraction (a.numerator*b.denominator+b.numerator*a.denominator) (a.denominator*b.denominator)
def subtract (a b : Fraction) : Fraction := fraction (a.numerator*b.denominator-b.numerator*a.denominator) (a.denominator*b.denominator)
def multiply (a b : Fraction) : Fraction := fraction (a.numerator*b.numerator) (a.denominator*b.denominator)
def divide (a b : Fraction) : Fraction := fraction (a.numerator*b.denominator) (a.denominator*b.numerator)
def equal (a b : Fraction) : Bool := decide (a.numerator*b.denominator = b.numerator*a.denominator)
def wholePower (base exponent : Int) : Int := (List.range exponent.toNat).foldl (fun n _ => n*base) 1

-- Remainder descent: after the first step, every positive remainder is
-- strictly smaller than the preceding positive divisor.
def divisorLoop : Nat → Int → Int → Int
 | 0, a, _ => a
 | fuel+1, a, b => if b > 0 then divisorLoop fuel b (a-a.tdiv b*b) else a
def commonDivisor (a b : Int) : Int := divisorLoop (b.toNat+1) a b

def coverLoop (volume : Int) : Nat → Int → Int → Int
 | 0, depth, _ => depth
 | fuel+1, depth, reach => if reach < volume then coverLoop volume fuel (depth+1) (reach*2) else depth
def minimalBinaryCover (volume : Int) : Int := coverLoop volume volume.toNat 1 2

-- The source order operation is used on odd q>1. Its nonzero residues
-- form a finite permutation; its return period is at most q-1.
def orderLoop (q : Int) : Nat → Int → Int → Int
 | 0, k, _ => k
 | fuel+1, k, residue =>
  if residue > 1 then
   let doubled := residue*2
   orderLoop q fuel (k+1) (doubled-doubled.tdiv q*q)
  else k
def orderOfTwo (q : Int) : Int := orderLoop q q.toNat 1 (2-(2 : Int).tdiv q*q)
def eulerPhi (q : Int) : Int := (List.range q.toNat).foldl (fun count n => if commonDivisor (Int.ofNat (n+1)) q = 1 then count+1 else count) 0

structure OrbitWalk where
 seen : Array Bool
 covered : Int
 residue : Int

def orbitWalk (q : Int) : Nat → OrbitWalk → OrbitWalk
 | 0, state => state
 | fuel+1, state =>
  let seen := state.seen.setIfInBounds state.residue.toNat true
  let doubled := state.residue*2
  let residue := doubled-doubled.tdiv q*q
  let next := {seen,covered := state.covered+1,residue : OrbitWalk}
  bif seen.getD residue.toNat false then next else orbitWalk q fuel next

def orbitCensus (q : Int) : Int :=
 let (seen,orbits,covered) := (List.range (q-1).toNat).foldl (fun (seen,orbits,covered) i =>
  let start := Int.ofNat (i+1)
  if commonDivisor start q = 1 ∧ !(seen.getD start.toNat false) then
   let walk := orbitWalk q (q.toNat+1) {seen,covered,residue := start}
   (walk.seen,orbits+1,walk.covered)
  else (seen,orbits,covered)) (((List.replicate q.toNat false).toArray,0,0) : Array Bool×Int×Int)
 let _ := seen
 let phi := eulerPhi q
 let expected := phi.tdiv (orderOfTwo q)
 if phi-expected*orderOfTwo q = 0 ∧ covered = phi ∧ orbits = expected then orbits else -1

def orbitCountLawTo (bound : Int) : Bool :=
 (List.range ((bound-1).tdiv 2).toNat).all fun i => decide (orbitCensus (3+2*Int.ofNat i) > 0)

def smallestFoldPeriodAbove (threshold : Int) : Int :=
 (List.range 15).foldl (fun best i =>
  let period := orderOfTwo (3+2*Int.ofNat i)
  if period > threshold then if best = 0 ∨ period < best then period else best
  else best) 0
def binaryCount : Int := smallestFoldPeriodAbove 1
def colourCount : Int := smallestFoldPeriodAbove binaryCount
end SFT.Applications.Discovery
