import SFT.Chemistry.StateEnergyInscription
namespace SFT.Chemistry.NuclearElectronicCell
open SFT.Host SFT.Physics.CapabilityValues
open ElectronSpinHtml (decimal number)
-- VALUE_PATTERN is copied as operations on the source inscription's prefix;
-- signs are classified as retained source text, never as native proof magnitudes.
def signedPrefix (text : String) : Option (Bool × Nat × Nat) :=
 let cs := (StateEnergyInscription.optionalTilde
  ((StateEnergyInscription.optionalOpening (Text.chars text)).dropWhile whitespace)).dropWhile whitespace
 let (negative,cs) := match cs with
  | [] => (false,[])
  | c::rest => if c.toNat == 45 then (true,rest) else if c.toNat == 43 then (false,rest) else (false,c::rest)
 let integral := cs.takeWhile decimal
 if integral.isEmpty then none else
 let tail := cs.drop integral.length
 let fractional := match tail with
  | [] => []
  | c::rest => if c.toNat == 46 then rest.takeWhile (fun d => decimal d || d.toNat == 95) else []
 let fractional := fractional.filter (fun c => c.toNat != 95)
 let denominator := 10^fractional.length
 let numerator := number 10 integral * denominator + number 10 fractional
 let divisor := Nat.gcd numerator denominator
 some (negative,numerator/divisor,denominator/divisor)

def cellForm (cell : String) : Except String (String × Value) := do
 if cell.isEmpty then return ("blank-EmptyOne",.emptyOne "empty-One")
 match signedPrefix cell with
 | none => return ("held-text",.label (← heldLabel "external-source-inscription" cell))
 | some (negative,n,d) =>
  if n == 0 then return ("source-zero-EmptyOne",.emptyOne "empty-One")
  if negative then return ("held-negative-inscription",.label (← heldLabel "external-signed-inscription" cell))
  return ("positive-exact",.ratio (← count n) (← count d))

theorem blankStructural : cellForm "" = .ok ("blank-EmptyOne",.emptyOne "empty-One") := rfl

theorem signedProvenance (cell : String) (n d : Nat)
 (parsed : signedPrefix cell = some (true,n+1,d)) (nonempty : cell.isEmpty = false)
 (label : HeldLabel) (held : heldLabel "external-signed-inscription" cell = .ok label) :
 cellForm cell = .ok ("held-negative-inscription",.label label) := by
 unfold cellForm
 rw [nonempty,parsed,held]
 rfl
#print axioms signedPrefix
#print axioms cellForm
#print axioms blankStructural
#print axioms signedProvenance
end SFT.Chemistry.NuclearElectronicCell
