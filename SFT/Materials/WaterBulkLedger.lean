import SFT.Host.Canonical
namespace SFT.Materials.WaterBulkLedger
open SFT.Host

def requiredFields : List String := [
 "molecular-network-identity","specimen-identity","phase-identity",
 "boiling-record","solid-liquid-density-record","heat-capacity-record",
 "conditions","method","uncertainty"]

def fieldCount : Nat := requiredFields.length

def certificate : Canonical.Value := .object [
 ("required_fields",.array (requiredFields.map Canonical.Value.text)),
 ("field_count",.object [("value",.integer (.ofNat fieldCount))]),
 ("complete",.boolean true)]

def originalWitness : Bool := Nat.beq fieldCount 9

theorem originalWitnessPassed : originalWitness = true := rfl
#print axioms requiredFields
#print axioms fieldCount
#print axioms certificate
#print axioms originalWitness
#print axioms originalWitnessPassed
end SFT.Materials.WaterBulkLedger
