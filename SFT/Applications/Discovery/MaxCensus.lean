import SFT.Applications.Discovery.MaxCore
namespace SFT.Applications.Discovery.MaxCensus
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Explorer
open SFT.Applications.Discovery.Reports

structure DenominatorRow where
 denominator : Int
 members : List Fraction
 sectors : List Int
 orbitLength : Option Nat

def uniqueInts (xs : List Int) : List Int :=
 xs.foldl (fun out x => if out.any (fun y => decide (x=y)) then out else out++[x]) []

def censusRows (unclaimed : List Fraction) : List DenominatorRow :=
 let denominators := sortInts (uniqueInts (unclaimed.map Fraction.denominator))
 denominators.map (fun denominator =>
  let members := sortFractions (unclaimed.filter (fun x => decide (x.denominator=denominator)))
  let sectors := sortInts (uniqueInts ((members.take 5).filterMap foldCount))
  let orbitLength := (members.take 3).findSome? (fun x =>
   let size := (orbitOf x 2).length
   if size > 1 then some size else none)
  {denominator,members,sectors,orbitLength})

def addCount : List (Int × Nat) → Int → Nat → List (Int × Nat)
 | [], sector, count => [(sector,count)]
 | (s,n)::rest, sector, count =>
  if s=sector then (s,n+count)::rest else (s,n)::addCount rest sector count

def sectorSummary (rows : List DenominatorRow) : List (Int × Nat) :=
 let counts := rows.foldl (fun counts row => row.sectors.foldl (fun counts sector => addCount counts sector row.members.length) counts) []
 (sortInts (counts.map Prod.fst)).map (fun s => (s,((counts.find? (fun pair => decide (pair.1=s))).map Prod.snd).getD 0))

def factorLoop (p : Int) : Nat → Int → List Int → Int × List Int
 | 0, n, out => (n,out)
 | fuel+1, n, out =>
  if n%p=0 then factorLoop p fuel (n/p) (out++[p]) else (n,out)
def sourceFactors (sector : Int) : List Int :=
 ([2,3,5,7,11,13,17,19,23,29].foldl (fun (n,out) p => factorLoop p sector.toNat n out) (sector,[])).2

def sectorIsPrime (sector : Int) : Bool :=
 decide (sector>1) && ((List.range sector.toNat).map (fun i => Int.ofNat (i+2))).all (fun i => if i*i≤sector then decide (sector%i≠0) else true)
def sectorIsClaimed (sector : Int) : Bool := [2,3,4,6,8,12,18,24,30].any (fun s => decide (s=sector))
end SFT.Applications.Discovery.MaxCensus
