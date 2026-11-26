import SFT.Chemistry.CoupledTransportExperiment
import SFT.Chemistry.CoupledTransportAnalysis
namespace SFT.Chemistry.CoupledTransportSource
open SFT.Host SFT.Host.Canonical SFT.Physics CoupledTransportExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := CoupledTransportAnalysis.Analysis
def exactCoupledTransportAnalysis := CoupledTransportAnalysis.exactCoupledTransportAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ CoupledTransportExperiment.sourceFiles.zipIdx.map (fun (row : (String×String)×Nat)=>((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-019 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 232) ||
  !sameValue (get targets "carrier_pair_counts") (.object [("mass-heat",.integer 22),("mass-charge",.integer 146),("heat-charge",.integer 64)]) ||
  !sameValue (get targets "response_role_counts") (.object [("mass-response-under-thermal-forcing",.integer 22),("charge-response",.integer 147),("mass-response-under-charge-probe",.integer 31),("heat-response",.integer 32)]) ||
  !sameValue (get targets "property_counts") (.object [("Binary diffusion coefficient, m2/s",.integer 22),("Electrical conductivity, S/m",.integer 147),("Thermal conductivity, W/m/K",.integer 32),("Tracer diffusion coefficient, m2/s",.integer 31)]) ||
  !sameValue (get targets "mixture_class_counts") (.object [("binary",.integer 137),("ternary",.integer 95)]) ||
  !sameValue (get targets "measurement_method_counts") (.object [("thermal-diffusion forced Rayleigh scattering",.integer 22),("Radiometer CDM 210 Meterlab conductimeter with a CDC 745-9 cell",.integer 115),("Electrochemistry (cyclic voltametry)",.integer 31),("Coaxial cylinder method",.integer 32),("contact method",.integer 32)]) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 232 then
  throw "THERMO-019 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","carrier_pair","dataset_ordinal","property_number","source_point_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "THERMO-019 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-coupled-transport-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.CoupledTransportSource
