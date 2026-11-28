import SFT.Applications.Discovery.Explorer
namespace SFT.Applications.Discovery.Extended
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Explorer

structure ExtendedProof where
 base : GroupProof
 t6 : Option Bool
 t7 : Option Bool
 t8 : Bool
 t9 : Option Bool
 t10 : Option Bool
 t11 : Option Bool
 t12 : Option Bool

-- This is discovery_max.py's bounded order loop, including its even-sector behavior.
def orderLoop (sector : Int) : Nat → Int → Nat → Nat
 | 0, _, order => order
 | fuel+1, value, order =>
  if value = 1 ∨ Int.ofNat order ≥ sector then order
  else orderLoop sector fuel ((value*2)%sector) (order+1)
def sourceOrder (sector : Int) : Nat := orderLoop sector sector.toNat (2%sector) 1

-- The source accepts `claimed` but does not use it in this operation.
def runExtendedProof (g : List Fraction) (_claimed : List Fraction) : ExtendedProof :=
 let base := runGroupProof g
 let gset := g.foldl insert []
 let half := fraction 1 2
 let t8 := (g.filter (fun x => decide (x.numerator < x.denominator) && !(equal x half))).all (fun x => contains gset (subtract (fraction 1 1) x))
 let sector := base.sector
 let t6 := sector.map (fun p => decide (210%p = 0))
 let t7 := sector.map (fun p => g.all (fun x => decide (x.denominator%(p-1) = 0 ∨ (p-1)%x.denominator = 0)))
 let t9 := sector.map (fun p => let coupling := fraction (integerFromOne p-1) (integerFromOne p); equal coupling (fraction (integerFromOne p-1) (integerFromOne p)))
 let t10 := sector.map (fun p => if p%2 = 1 then contains (standing p) half else !(contains (standing p) half))
 let t11 := sector.bind (fun p => if p > 1 then some (decide ((orbitOf (fraction 1 (integerFromOne p)) 2).length = sourceOrder p)) else none)
 let t12 := sector.map (fun p => [2,3,5,7].any (fun q => decide (p = q)))
 {base,t6,t7,t8,t9,t10,t11,t12}
end SFT.Applications.Discovery.Extended
