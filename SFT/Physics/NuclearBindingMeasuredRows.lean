import SFT.Physics.NuclearBindingRecords
namespace SFT.Physics.NuclearBindingMeasuredRows
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Row where
 mass : Int
 charge : Int
 neutrons : Int
 element : String
 binding : Rat
 uncertainty : Rat
 lower : Rat
 upper : Rat
def segment (line : List Char) (start stop : Nat) : List Char := LeptonDecimal.strip ((line.drop start).take (stop-start))
-- Exact fixed-decimal inscriptions in the identity-bound AME2020 table.
-- Zero uncertainty remains external reported data, not a scientific zero state.
def inscription (chars : List Char) : Option Rat :=
 match LeptonDecimal.coefficient chars with
 | .error _ => none
 | .ok (n,places) => some (normalize (.ofNat n) (10^places) (Nat.pow_pos (by decide)))
def parseLine (line : List Char) : Except String (Option Row) := do
 if line.length < 79 then pure none else
  match LeptonDecimal.exponent (segment line 4 9),LeptonDecimal.exponent (segment line 9 14),LeptonDecimal.exponent (segment line 14 19) with
  | some n,some z,some a =>
    if a < 2 then pure none else
     let bindingRaw := segment line 54 67
     let uncertaintyRaw := segment line 68 78
     if bindingRaw.isEmpty || Text.equal (String.ofList bindingRaw) "*" || Text.contains (String.ofList bindingRaw) "#" then pure none else
      match inscription bindingRaw,inscription uncertaintyRaw with
      | some binding,some uncertainty =>
        let lower ← RunningConvergence.positiveTake binding uncertainty
        pure (some ⟨a,z,n,String.ofList (segment line 20 23),binding,uncertainty,lower,add binding uncertainty⟩)
      | none,none => pure none
      | none,some _ => pure none
      | some _,none => pure none
  | none,_,_ => pure none
  | some _,none,_ => pure none
  | some _,some _,none => pure none
def rowsFromText (raw : String) : Except String (List Row) := do
 let parsed ← (LeptonDecimal.split '\n' (Text.chars raw)).mapM parseLine
 let rows := parsed.flatMap (fun row => match row with | none => [] | some row => [row])
 if rows.length != 2548 then throw "complete AME2020 numeric binding census changed"
 pure rows
def measuredBindingRows (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String (List Row) := do
 let _ ← NuclearBindingRecords.authoritativeRecord bytes files payload
 let raw ← match files.find? (fun p => Text.equal p.1 NuclearBindingRecords.rawPath) with
  | none => .error (Text.append "FileNotFoundError: " NuclearBindingRecords.rawPath)
  | some pair => .ok (String.ofList (Text.decode pair.2.size pair.2.data.toList))
 rowsFromText raw
def rowByCoordinate (rows : List Row) (mass charge : Int) : Except String Row :=
 let found :=  rows.filter (fun row => (@decide (row.mass=mass) (Int.decEq row.mass mass)) && (@decide (row.charge=charge) (Int.decEq row.charge charge)))
 match found with
 | [row] => .ok row
 | [] => .error "AME2020 coordinate is absent or duplicated"
 | _::_::_ => .error "AME2020 coordinate is absent or duplicated"
end SFT.Physics.NuclearBindingMeasuredRows
