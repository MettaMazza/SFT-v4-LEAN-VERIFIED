import SFT.Chemistry.NuclearElectronicAnalysis
import SFT.Chemistry.ConfigurationObservation
namespace SFT.Chemistry.NuclearElectronicWeights
open SFT.Host SFT.Physics
open NuclearElectronicAnalysis (Row groups)
abbrev J := Canonical.Value
-- Applied after the original registry and snapshot hashes bind each inscription.
-- Reuse the exact decimal arithmetic already used for those source values.
def weights (rows : List Row) : Except String (List (String × Rat)) := do
 (groups rows Row.species).mapM fun (species,group) => do
  let first ← NuclearElectronicSource.atNat group 0
  let weight ← ConfigurationObservation.exact first.weight
  let matching ← group.mapM fun row => do
   let current ← ConfigurationObservation.exact row.weight
   return decide (current.num * Int.ofNat weight.den = weight.num * Int.ofNat current.den)
  if !matching.all id then throw "ELEC-012 molecular weight changed within species"
  return (species,weight)

def fractionText (r : Rat) : String :=
 if r.den==1 then ConfigurationObservation.intText r.num
 else Text.intercalate "" [ConfigurationObservation.intText r.num,"/",toString r.den]

def weightAt (weights : List (String × Rat)) (key : String) : Except String Rat :=
 match weights.find? (fun p => Text.equal p.1 key) with
 | none => .error (Text.intercalate "" ["'",key,"'"])
 | some p => .ok p.2

def massOrder (values : List (String × Rat)) : Except String Bool := do
 let h ← weightAt values "H2"
 let hd ← weightAt values "HD"
 let d ← weightAt values "D2"
 return decide (h.num>0) && decide (h.num * Int.ofNat hd.den < hd.num * Int.ofNat h.den) &&
  decide (hd.num * Int.ofNat d.den < d.num * Int.ofNat hd.den)

def supports (rows : List Row) : Except String (List (String × List String)) :=
 (groups rows Row.species).mapM fun (species,group) => do
  let first ← NuclearElectronicSource.atNat group 0
  return (species,first.isotopes)

def distinctSupports (xs : List (String × List String)) : Bool :=
 (xs.foldl (fun acc (_,isotopes) => if acc.any (NuclearElectronic.equalNuclear isotopes) then acc else acc++[isotopes]) []).length==3
end SFT.Chemistry.NuclearElectronicWeights
