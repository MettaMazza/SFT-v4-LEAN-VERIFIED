import SFT.Chemistry.NuclearElectronicTargets
namespace SFT.Chemistry.ResolvedRovibronicAnalysis
open SFT.Host
open NuclearElectronicAnalysis (Row)
open NuclearElectronicCell (cellForm signedPrefix)
open NuclearElectronicSource (atNat)
abbrev J := Canonical.Value

def positive (cell : String) : Bool := match signedPrefix cell with
 | none => false
 | some (negative,n,_) => !negative && n > 0

def multiplicityHere : List Char → Option String
 | [] => none
 | c::cs => if c.toNat != 94 then none else
   match cs with
   | [] => none
   | d::_ => if 49 ≤ d.toNat && d.toNat ≤ 57 then
      some (String.ofList (cs.takeWhile ElectronSpinHtml.decimal)) else none

def multiplicity : List Char → Option String
 | [] => none
 | c::cs => match multiplicityHere (c::cs) with
   | some value => some value
   | none => multiplicity cs

def rowComparison (row : Row) (released : List (String × String)) : Except String J := do
 let m ← match multiplicity (Text.chars (← atNat row.stateCells 0)) with
  | none => throw "ELEC-013 multiplicity missing"
  | some value => pure value
 let vibration ← cellForm (← atNat row.stateCells 2)
 let rotation ← cellForm (← atNat row.stateCells 5)
 let band ← cellForm (← atNat row.stateCells 12)
 let release ← match released.find? (fun p => Text.equal p.1 row.targetId) with
  | none => throw "released target missing"
  | some p => pure p.2
 return .object [("target_id",.text row.targetId),("species",.text row.species),
  ("multiplicity",.text m),("vibration",.text vibration.1),("rotation",.text rotation.1),
  ("transition",.text (← atNat row.stateCells 11)),("band",.text band.1),
  ("passed",.boolean (Text.equal release (Canonical.identity row.retained)))]

def counts (rows : List Row) : Except String (List (String × Nat)) := do
 let ms ← rows.mapM fun r => do
  match multiplicity (Text.chars (← atNat r.stateCells 0)) with
  | none => throw "ELEC-013 multiplicity missing"
  | some m => pure m
 let cells := rows.flatMap Row.stateCells
 let negative ← cells.mapM fun c => do
  let (tag,_) ← cellForm c
  return Text.equal tag "held-negative-inscription"
 let column := fun (n : Nat) => rows.mapM fun r => atNat r.stateCells n
 let vibrations ← column 2
 let rotations ← column 5
 let transitions ← column 11
 let bands ← column 12
 let origins ← column 1
 return [("rows",rows.length),("cells",cells.length),
  ("singlet",(ms.filter (Text.equal · "1")).length),
  ("triplet",(ms.filter (Text.equal · "3")).length),
  ("positive_vibration",(vibrations.filter positive).length),
  ("positive_rotation",(rotations.filter positive).length),
  ("joint_vibration_rotation",((vibrations.zip rotations).filter fun (v,r) => positive v && positive r).length),
  ("transition_designation",(transitions.filter fun x => !x.isEmpty).length),
  ("positive_band_origin",(bands.filter positive).length),
  ("source_zero_electronic_origin",(origins.filter (Text.equal · "0")).length),
  ("absent_electronic_origin",(origins.filter String.isEmpty).length),
  ("held_signed_inscriptions",(negative.filter id).length)]
end SFT.Chemistry.ResolvedRovibronicAnalysis
