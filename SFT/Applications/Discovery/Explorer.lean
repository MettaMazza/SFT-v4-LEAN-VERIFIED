import SFT.Applications.Discovery.Core
namespace SFT.Applications.Discovery.Explorer
open SFT.Applications.Discovery

-- pure/discovery.py uses proper interior modes; sftoe/usde.py includes One.
-- Keep these two original surfaces distinct.
def integerFromOne (n : Int) : Int := if n < 1 then 1 else n
def castOut (x : Fraction) : Fraction :=
 if x.numerator ≤ x.denominator then x
 else
  let r := x.numerator % x.denominator
  if r = 0 then fraction 1 1 else fraction r x.denominator
def mFold (x : Fraction) (m : Int) : Fraction := castOut (multiply x (fraction (integerFromOne m) 1))
def contains (xs : List Fraction) (x : Fraction) : Bool := xs.any (fun y => equal x y)
def insert (xs : List Fraction) (x : Fraction) : List Fraction := bif contains xs x then xs else xs++[x]
def standing (mn : Int) : List Fraction :=
 let m := integerFromOne mn
 if m ≤ 1 then [] else
 (List.range (m-2).toNat).foldl (fun out j =>
  let x := fraction (Int.ofNat (j+1)) (m-1)
  bif equal (mFold x m) x then insert out x else out) []
def usdeStanding (m : Int) : List Fraction :=
 if m < 2 then [] else (List.range (m-1).toNat).map (fun k => fraction (Int.ofNat (k+1)) (m-1))
def famCoupling (m : Int) : Option Fraction := if m < 2 then none else some (fraction (m-1) m)
def famModeCount (m : Int) : Nat := (standing m).length
def famTower (k : Int) : Int := wholePower 2 (integerFromOne k)

def famOrbitLoop (start : Fraction) : Nat → Fraction → Nat → List Fraction → Nat
 | 0, _, n, _ => n
 | fuel+1, c, n, seen =>
  if equal c start ∨ n ≥ 200000 ∨ contains seen c then n
  else famOrbitLoop start fuel (mFold c 2) (n+1) (insert seen c)
def famOrbit (m : Int) : Nat :=
 if m < 2 then 0 else
 let x := fraction 1 m
 famOrbitLoop x 200000 (mFold x 2) 1 [x]

def orbitLoop (start : Fraction) (m : Int) : Nat → Fraction → List Fraction → List Fraction
 | 0, _, out => out
 | fuel+1, current, out =>
  if equal current start ∨ equal current (fraction 1 1) then out
  else orbitLoop start m fuel (mFold current m) (out++[current])
def orbitOf (x : Fraction) (m : Int) (cap : Nat := 4000) : List Fraction := orbitLoop x m cap (mFold x m) [x]
def binaryOrbitSet (x : Fraction) (cap : Nat := 4000) : List Fraction := (orbitOf x 2 cap).foldl insert []
def antipode (x : Fraction) : Fraction :=
 if x.numerator < x.denominator then subtract (fraction 1 1) x else x
def foldCount (x : Fraction) : Option Int :=
 ((List.range 58).map (fun i => Int.ofNat (i+2))).find? (fun m => contains (standing m) x)
structure Provenance where
 sectors : List Int
 antipode : Fraction
 foldImage2 : Fraction
 foldImage3 : Fraction
 orbitLength2 : Nat
def provenance (x : Fraction) : Provenance :=
 {sectors := ((List.range 28).map (fun i => Int.ofNat (i+2))).filter (fun m => contains (standing m) x),antipode := antipode x,foldImage2 := mFold x 2,foldImage3 := mFold x 3,orbitLength2 := (orbitOf x 2).length}

def closedLoop (factors : List Int) : Nat → List Fraction → List Fraction → List Fraction
 | 0, closed, _ => closed
 | fuel+1, closed, frontier =>
  let fresh := frontier.foldl (fun fresh x => factors.foldl (fun out mm =>
   let y := mFold x (integerFromOne mm)
   bif contains closed y then out else insert out y) fresh) []
  if fresh.isEmpty then closed else closedLoop factors fuel (fresh.foldl insert closed) fresh

def closedSet (seedTo : Nat := 30) (factors : List Int := [2,3,5,7]) : List Fraction :=
 let parts := (List.range (seedTo-1)).foldl (fun parts i => (standing (Int.ofNat (i+2))).foldl insert parts) []
 -- Every reduced denominator divides a seed denominator. The sum of seed
 -- denominators bounds all possible new members; one final pass detects closure.
 closedLoop factors (seedTo*seedTo+1) parts parts

def placementsTo (sweep : Nat) : Nat := (List.range (sweep-1)).foldl (fun count i => count+(standing (Int.ofNat (i+2))).length) 0

inductive Resolution where
 | returnsOne | fixed | cycle | unresolved

def resolveLoop (m : Int) : Nat → Fraction → List Fraction → Resolution
 | 0, _, _ => .unresolved
 | fuel+1, current, seen =>
  let next := mFold current m
  if equal next (fraction 1 1) then .returnsOne
  else if equal next current then .fixed
  else if contains seen next then .cycle
  else resolveLoop m fuel next (insert seen next)

def resolve (x : Fraction) (m : Int) : Resolution := resolveLoop m 200000 x []
structure Tally where
 returnsOne : Nat := 0
 fixed : Nat := 0
 cycle : Nat := 0
 unresolved : Nat := 0
def addResolution (t : Tally) : Resolution → Tally
 | .returnsOne => {t with returnsOne := t.returnsOne+1}
 | .fixed => {t with fixed := t.fixed+1}
 | .cycle => {t with cycle := t.cycle+1}
 | .unresolved => {t with unresolved := t.unresolved+1}
def axis1 (upTo : Nat := 40) : Tally :=
 (List.range (upTo-1)).foldl (fun tally mi =>
  (List.range (upTo-1)).foldl (fun tally di =>
   let d := di+2
   (List.range (d-1)).foldl (fun tally j =>
    addResolution tally (resolve (fraction (Int.ofNat (j+1)) (Int.ofNat d)) (Int.ofNat (mi+2)))) tally) tally) {}
def groupClosedSet (g : List Fraction) : List Fraction :=
 let base := g.foldl insert []
 closedLoop [2,3,5,7] 50 base base
structure GroupProof where
 t1Confines : Bool
 t2Closed : Bool
 t3Resolves : Bool
 t4SingleSector : Bool
 t5PairLaw : Option Bool
 sector : Option Int
 pairs : Nat
 proves : Bool
def runGroupProof (g : List Fraction) : GroupProof :=
 let gset := g.foldl insert []
 let t1 := g.all fun x => if x.numerator < x.denominator then equal (add x (subtract (fraction 1 1) x)) (fraction 1 1) else true
 let dens := g.map (fun x => x.denominator)
 let closure := groupClosedSet g
 let t2 := closure.all fun y => dens.any (fun d => decide (d = y.denominator)) || equal y (fraction 1 1)
 let t3 := g.all fun x => match resolveLoop 2 20000 x [] with | .unresolved => false | .returnsOne => true | .fixed => true | .cycle => true
 let sectors := g.foldl (fun sectors x => match foldCount x with
  | none => sectors
  | some n => if sectors.any (fun old => decide (old = n)) then sectors else sectors++[n]) []
 let t4 := decide (sectors.length = 1)
 let pairs := g.foldl (fun n x => if 2*x.numerator < x.denominator ∧ contains gset (subtract (fraction 1 1) x) then n+1 else n) 0
 let sector := bif t4 then sectors.head? else none
 let t5 := sector.map (fun n => decide (Int.ofNat pairs = (n-1)/2))
 {t1Confines := t1,t2Closed := t2,t3Resolves := t3,t4SingleSector := t4,t5PairLaw := t5,sector,pairs,proves := t1 && t2 && t3 && t4}
end SFT.Applications.Discovery.Explorer
