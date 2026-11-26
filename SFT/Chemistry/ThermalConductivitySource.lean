import SFT.Chemistry.ThermalConductivityExperiment
import SFT.Chemistry.ThermalConductivityAnalysis
namespace SFT.Chemistry.ThermalConductivitySource
open SFT.Host SFT.Host.Canonical SFT.Physics ThermalConductivityExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ThermalConductivityAnalysis.Analysis
def exactThermalConductivityAnalysis := ThermalConductivityAnalysis.exactThermalConductivityAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ ThermalConductivityExperiment.sourceFiles.zipIdx.map (fun (row : (String × String) × Nat) => ((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-018 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 655) ||
  !sameValue (get targets "mixture_class_counts") (.object [("pure",.integer 123),("binary",.integer 273),("ternary",.integer 259)]) ||
  !sameValue (get targets "phase_counts") (.object [("Gas",.integer 51),("Liquid",.integer 571),("Crystal 2",.integer 33)]) ||
  !sameValue (get targets "measurement_method_counts") (.object [("Hot wire method",.integer 472),("Modified transient plane source method",.integer 71),("THOTW",.integer 112)]) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 655 then
  throw "THERMO-018 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","dataset_ordinal","property_number","source_point_ordinal"]
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "THERMO-018 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-thermal-conductivity-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ThermalConductivitySource
