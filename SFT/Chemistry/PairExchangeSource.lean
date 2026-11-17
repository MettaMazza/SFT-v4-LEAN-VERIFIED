import SFT.Chemistry.PairExchange
import SFT.Chemistry.StateSymmetrySource
import SFT.Chemistry.StateEnergyInscription
import SFT.Chemistry.OrbitalSupportTargets
namespace SFT.Chemistry.PairExchangeSource
open SFT.Host SFT.Physics.CapabilityValues
abbrev Configuration := OrbitalAssignments.Configuration
abbrev J := Canonical.Value
-- The original H2 parser and term/suffix grammar are identical to the
-- State Symmetry source operations. OrbitalAssignments implements the same
-- negative-lookbehind and optional-occupancy regex used by this source.
def sourceRows := StateSymmetrySource.sourceRows
def configurationFromState (state : String) : Option Configuration :=
 (OrbitalAssignments.configurations state).head?
def configurationValue : Option Configuration → J
 | none => .text "absence"
 | some c => .object [("positive_radial_recurrence",.integer (.ofNat c.radial)),
  ("source_family_label",.text c.family),("axis_support_symbol",.text c.symbol),
  ("positive_occupancy_count",.integer (.ofNat c.occupancy))]
def configurationWord : Option Configuration → Except String Value
 | none => .ok (.emptyOne "empty-One")
 | some c => do
  return .word [.count (← count c.radial),.label (← heldLabel "source-family-label" c.family),
   .label (← heldLabel "source-support-symbol" c.symbol),.count (← count c.occupancy)]
-- ENERGY_PATTERN uses zero or more opening brackets. ELEC-004's parser allows
-- only one, so preserve this source's exact prefix rather than substituting it.
def energyMatch (text : String) : Option (List Char × List Char) :=
 let openingTail := (Text.chars text).dropWhile (fun c => c.toNat==91 || c.toNat==40)
 let body := (StateEnergyInscription.optionalTilde (openingTail.dropWhile whitespace)).dropWhile whitespace
 let integral := body.takeWhile ElectronSpinHtml.decimal
 if integral.isEmpty then none else
 match body.drop integral.length with
 | [] => some (integral,[])
 | c::tail => if c.toNat==46 then some (integral,tail.takeWhile (fun x => ElectronSpinHtml.decimal x || x.toNat==95))
  else some (integral,[])
def exactEnergy (text : String) : Except String (Nat × Nat) :=
 match energyMatch text with
 | none => .error "ELEC-006 H2 row lacks one common-unit energy record"
 | some (integral,fractional) =>
  if Text.contains text "eV" then .error "ELEC-006 H2 row lacks one common-unit energy record" else
  let digits := fractional.filter (fun c => c.toNat != 95)
  let denominator := 10^digits.length
  let numerator := ElectronSpinHtml.number 10 integral*denominator+ElectronSpinHtml.number 10 digits
  let divisor := Nat.gcd numerator denominator
  .ok (numerator/divisor,denominator/divisor)
def configurationEqual (a b : Configuration) : Bool :=
 a.radial==b.radial && Text.equal a.family b.family && Text.equal a.symbol b.symbol && a.occupancy==b.occupancy
def configurationLE (a b : Configuration) : Bool :=
 if a.radial != b.radial then a.radial < b.radial
 else if !Text.equal a.family b.family then Text.le a.family b.family
 else if !Text.equal a.symbol b.symbol then Text.le a.symbol b.symbol
 else a.occupancy ≤ b.occupancy
def insertConfiguration (c : Configuration) : List Configuration → List Configuration
 | [] => [c]
 | x::xs => if configurationEqual c x then x::xs
  else if configurationLE c x then c::x::xs else x::insertConfiguration c xs
def sortedConfigurations (rows : List Configuration) : List Configuration :=
 rows.foldl (fun out c => insertConfiguration c out) []
def separation (singlet triplet : Nat × Nat) : Except String (Nat × Nat × String) :=
 let a := singlet.1*triplet.2
 let b := triplet.1*singlet.2
 let gap := if a<b then b-a else a-b
 if gap==0 then .error "ELEC-006 registered pair lacks positive measured separation" else
 let denominator := singlet.2*triplet.2
 let divisor := Nat.gcd gap denominator
 .ok (gap/divisor,denominator/divisor,if a<b then "singlet-below-triplet" else "triplet-below-singlet")
def supportIdentity (c : Configuration) : String :=
 Text.intercalate "-" [toString c.radial,c.family,c.symbol,toString c.occupancy]
def paddedOrdinal (ordinal : Nat) : String :=
 let digits := toString ordinal
 Text.append (String.ofList (List.replicate (3-(Text.chars digits).length) '0')) digits

#print axioms sourceRows
#print axioms configurationFromState
#print axioms configurationValue
#print axioms configurationWord
#print axioms energyMatch
#print axioms exactEnergy
#print axioms configurationEqual
#print axioms configurationLE
#print axioms insertConfiguration
#print axioms sortedConfigurations
#print axioms separation
#print axioms supportIdentity
#print axioms paddedOrdinal
end SFT.Chemistry.PairExchangeSource
