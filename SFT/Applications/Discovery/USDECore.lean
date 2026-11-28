import SFT.Applications.Discovery.Reports
namespace SFT.Applications.Discovery.USDECore
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Explorer
open SFT.Applications.Discovery.Reports

def castOut (x : Fraction) : Fraction :=
 let remainder := x.numerator % x.denominator
 if remainder = 0 then fraction 1 1 else fraction remainder x.denominator
def foldDirect (x : Fraction) (m : Int) : Fraction := USDECore.castOut (multiply x (fraction m 1))
def closureLoop (factors : List Int) : Nat → List Fraction → List Fraction → List Fraction
 | 0, closed, _ => closed
 | fuel+1, closed, frontier =>
  let fresh := frontier.foldl (fun fresh x => factors.foldl (fun fresh m =>
   let y := foldDirect x m
   if contains closed y then fresh else insert fresh y) fresh) []
  if fresh.isEmpty then closed else closureLoop factors fuel (fresh.foldl insert closed) fresh

def closedSet (seedTo : Nat := 30) (factors : List Int := [2,3,5,7]) : List Fraction :=
 let parts := (List.range (seedTo-1)).foldl (fun out i => (usdeStanding (Int.ofNat (i+2))).foldl insert out) []
 closureLoop factors (seedTo*seedTo+1) parts parts

def binaryOrbitLoop (start : Fraction) : Nat → Fraction → List Fraction → List Fraction
 | 0, _, orbit => orbit
 | fuel+1, current, orbit =>
  if equal current start || equal current (fraction 1 1) then orbit
  else binaryOrbitLoop start fuel (foldDirect current 2) (insert orbit current)
def binaryOrbitSet (x : Fraction) : List Fraction := binaryOrbitLoop x 4000 (foldDirect x 2) [x]

def signedMod (a d : Int) : Int :=
 let r := a % d
 if d < 0 ∧ r ≠ 0 then r+d else r

def orderLoop (d : Int) : Nat → Int → Int → Int
 | 0, _, order => order
 | fuel+1, current, order =>
  if current = 1 ∨ order ≥ 5000000 then order
  else orderLoop d fuel (signedMod (current*2) d) (order+1)
def getOrderOf2 (d : Int) : Int :=
 if d = 1 then 1
 else if d = -1 then -1
 else if d ≥ 0 ∧ 2^(Nat.log2 (d+1).toNat) = (d+1).toNat then Int.ofNat (Nat.log2 (d+1).toNat)
 else orderLoop d 5000000 2 1

def sectorOrbitLoop (d k : Int) : Nat → Int → List Int → List Int
 | 0, _, orbit => orbit
 | fuel+1, current, orbit =>
  if current = k ∨ current = d then orbit
  else
   let orbit := if orbit.any (fun n => decide (n=current)) then orbit else orbit++[current]
   let next := signedMod (current*2) d
   sectorOrbitLoop d k fuel (if next = 0 then d else next) orbit

def resolveSectorGroupsAnalytically (sector : Int) : List (List Fraction) :=
 let d := sector-1
 if d < 1 then []
 else if sector ≥ 100000 then
  let size := if d%2 = 0 then 1 else getOrderOf2 d
  [List.replicate size.toNat (fraction 1 d)]
 else
  let groups := (List.range d.toNat).foldl (fun groups i =>
   let k := Int.ofNat (i+1)
   if d > 1 ∧ Nat.gcd k.natAbs d.natAbs ≠ 1 then groups
   else
    let current := signedMod (k*2) d
    let orbit := sectorOrbitLoop d k 4000 (if current = 0 then d else current) [k]
    insertGroup (fraction k d) (orbit.map (fun x => fraction x d)) groups) []
  (sortGroups groups).map OrbitGroup.members

-- The source's built-in modular pow, expressed by repeated squaring.
def modularPowerLoop (d : Int) : Nat → Nat → Int → Int → Int
 | 0, _, _, result => result
 | fuel+1, exponent, base, result =>
  if exponent = 0 then result
  else modularPowerLoop d fuel (exponent/2) (signedMod (base*base) d) (if exponent%2 = 1 then signedMod (result*base) d else result)
def modularPower (base : Int) (exponent : Nat) (d : Int) : Int := modularPowerLoop d (exponent+1) exponent (signedMod base d) (signedMod 1 d)

structure AnalyticalProof where
 confines : Bool
 closed : Bool
 resolves : Bool
 singleSector : Bool
 pairLaw : Bool
 handedness : Bool
 causality : Bool
 dimension : Bool
 sync : Bool
 curvature : Bool
 scaleIndep : Bool
 cpClosure : Bool
 proves : Bool
 pairs : Int

def runAnalyticalProof (sector : Int) (g : Option (List Fraction) := none) : AnalyticalProof :=
 let d := sector-1
 if d < 1 then ⟨false,false,false,false,false,false,false,false,false,false,false,false,false,0⟩
 else
  let t2 := if d = 2 then true else if d%2 = 0 then false else !([3,5,7].any (fun p => decide (d%p = 0 ∧ d ≠ p)))
  let size := if d%2 = 0 then 1 else match g with | some xs => Int.ofNat xs.length | none => getOrderOf2 d
  let pairs := if d%2 = 0 then 0 else match g with
   | some xs => Int.ofNat (xs.filter (fun x => decide (2*x.numerator < x.denominator) && contains xs (subtract (fraction 1 1) x))).length
   | none => if size%2 = 0 ∧ modularPower 2 (size/2).toNat d = d-1 then size/2 else 0
  ⟨true,t2,true,true,decide (pairs = d/2),true,true,decide (size ≤ sector),true,true,true,decide (sector%2 ≠ 0),t2,pairs⟩
def runAutoProof (g : List Fraction) (sector : Int) : AnalyticalProof := runAnalyticalProof sector (some g)
end SFT.Applications.Discovery.USDECore
