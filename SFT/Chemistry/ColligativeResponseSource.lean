import SFT.Chemistry.ColligativeResponseExperiment
import SFT.Chemistry.ColligativeResponseAnalysis
namespace SFT.Chemistry.ColligativeResponseSource
open SFT.Host SFT.Host.Canonical SFT.Physics ColligativeResponseExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := ColligativeResponseAnalysis.Analysis
def exactColligativeResponseAnalysis := ColligativeResponseAnalysis.exactColligativeAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ ColligativeResponseExperiment.sourceFiles.zipIdx.map (fun (row : (String × String) × Nat) => ((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-014 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 276) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 276 then
  throw "THERMO-014 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") ||
   !sameValue (get id "source_id") (get target "source_id") ||
   !sameValue (get id "response_class") (get target "response_class") ||
   !sameValue (get id "dataset_ordinal") (get target "dataset_ordinal") ||
   !sameValue (get id "source_point_ordinal") (get target "source_point_ordinal") then
   throw "THERMO-014 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-colligative-response-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.ColligativeResponseSource
