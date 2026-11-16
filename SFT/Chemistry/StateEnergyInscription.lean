import SFT.Chemistry.OrbitalAssignments
namespace SFT.Chemistry.StateEnergyInscription
open SFT.Host ElectronSpinHtml
-- VALUE_PATTERN is anchored and uses ASCII digits, optional opening bracket,
-- Python whitespace, optional tilde and a decimal suffix containing underscores.
def optionalOpening : List Char → List Char
 | [] => []
 | c::cs => if c.toNat==91 || c.toNat==40 then cs else c::cs
def optionalTilde : List Char → List Char
 | [] => []
 | c::cs => if c.toNat==126 then cs else c::cs
def decimalMatch (text : String) : Option (List Char × List Char) :=
 let cs := (optionalTilde ((optionalOpening (Text.chars text)).dropWhile SFT.Physics.CapabilityValues.whitespace)).dropWhile SFT.Physics.CapabilityValues.whitespace
 let integral := cs.takeWhile decimal
 if integral.isEmpty then none else
 let remaining := cs.drop integral.length
 match remaining with
 | [] => some (integral,[])
 | c::tail => if c.toNat==46 then some (integral,tail.takeWhile (fun d=>decimal d || d.toNat==95)) else some (integral,[])
def exactValue (text : String) : Except String (Nat × Nat) :=
 match decimalMatch text with
 | none => .error "ELEC-004 source row is not orderable in the registered unit"
 | some (integral,fractional) =>
  if Text.contains text "eV" then .error "ELEC-004 source row is not orderable in the registered unit" else
  let digits := fractional.filter (fun c=>c.toNat != 95)
  let denominator := 10^digits.length
  let numerator := number 10 integral * denominator + number 10 digits
  let divisor := Nat.gcd numerator denominator
  .ok (numerator/divisor,denominator/divisor)
#print axioms optionalOpening
#print axioms optionalTilde
#print axioms decimalMatch
#print axioms exactValue
end SFT.Chemistry.StateEnergyInscription
