import SFT.Chemistry.MolecularStateTransition
import SFT.Chemistry.StateEnergyInscription
namespace SFT.Chemistry.StateTransitionInscription
open SFT.Host SFT.Physics.CapabilityValues MolecularStateTransition

def observationClass (s : String) : String :=
 if s.isEmpty then "absent-transition-coordinate"
 else if Text.contains s "→" || Text.contains s "←" || Text.contains s "↔" then "observed-directional-transition"
 else "observed-coupled-state-relation"

-- The source regex searches, rather than anchors, its ASCII decimal capture.
def bandDigits (s : String) : Option (List Char × List Char) :=
 let cs := (Text.chars s).dropWhile (fun c => !ElectronSpinHtml.decimal c)
 let integral := cs.takeWhile ElectronSpinHtml.decimal
 if integral.isEmpty then none else
 match cs.drop integral.length with
 | [] => some (integral,[])
 | c::rest => if c.toNat==46 then
    some (integral,rest.takeWhile (fun d => ElectronSpinHtml.decimal d || d.toNat==95))
   else some (integral,[])

def exactBand (s : String) : Except String Value := do
 if Text.equal s "absence" then return .emptyOne "empty-One"
 match bandDigits s with
 | none => throw "ELEC-009 positive band inscription is unparseable"
 | some (integral,fractional) =>
  let digits := fractional.filter (fun c => c.toNat != 95)
  let denominator := 10^digits.length
  let numerator := ElectronSpinHtml.number 10 integral * denominator + ElectronSpinHtml.number 10 digits
  if numerator==0 then throw "ELEC-009 band record is not exact positive"
  let divisor := Nat.gcd numerator denominator
  return .ratio (← count (numerator/divisor)) (← count (denominator/divisor))

def stripEnds (s : String) (p : Char → Bool) : String :=
 String.ofList (((Text.chars s).dropWhile p).reverse.dropWhile p).reverse

def firstToken (s : String) : Except String String :=
 let words := ((Text.chars (ElectronSpinHtml.normalizeSpace s)).splitOn ' ').filter (fun cs => !cs.isEmpty)
 match words with
 | [] => .error "list index out of range"
 | word::_ => .ok (String.ofList word)

def splitFirst (s : String) (separator : Char) : String × String :=
 let cs := Text.chars s
 let first := cs.takeWhile (fun c => c.toNat != separator.toNat)
 (String.ofList first,String.ofList (cs.drop (first.length+1)))

def endpoints (stateRecord transition : String) : Except String (String × String × HeldLabel) := do
 let rawState ← firstToken stateRecord
 let state := stripEnds rawState (fun c => c.toNat==40 || c.toNat==41)
 let cleaned := stripEnds transition (fun c => c.toNat==40 || c.toNat==41)
 let direction := if Text.contains transition "↔" then some ('↔',bidirectional)
   else if Text.contains transition "→" then some ('→',forward)
   else if Text.contains transition "←" then some ('←',reverse) else none
 match direction with
 | some (arrow,orientation) =>
  let (left,right) := splitFirst cleaned arrow
  let left ← firstToken left
  let right ← firstToken right
  let right := String.ofList ((Text.chars right).reverse.dropWhile (fun c => c.toNat==44)).reverse
  return (left,right,orientation)
 | none =>
  let word ← firstToken cleaned
  if !Text.contains word "-" then throw "ELEC-009 coupled-state inscription lacks two states"
  let (left,right) := splitFirst word '-'
  return (if left.isEmpty then state else left,right,coupled)
end SFT.Chemistry.StateTransitionInscription
