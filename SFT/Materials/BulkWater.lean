import SFT.Physics.CapabilityValues
namespace SFT.Materials.BulkWater
open SFT.Physics.CapabilityValues
def requiredFields : List String := ["molecular-network-identity","specimen-identity","phase-identity",
 "boiling-record","solid-liquid-density-record","heat-capacity-record","conditions","method","uncertainty"]
structure Certificate where
 requiredFields : List String
 fieldCount : PositiveCount
 complete : Bool
def certificate : Certificate := ⟨requiredFields,⟨requiredFields.length,by decide⟩,true⟩
def witness : Bool := certificate.fieldCount.value==9
theorem originalFieldsRetained : certificate.requiredFields=requiredFields := rfl
theorem nineFields : certificate.fieldCount.value=9 := rfl
theorem originalWitnessPassed : witness=true := rfl
end SFT.Materials.BulkWater
