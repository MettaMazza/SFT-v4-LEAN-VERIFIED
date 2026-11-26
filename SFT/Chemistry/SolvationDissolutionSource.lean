import SFT.Chemistry.SolvationDissolutionExperiment
import SFT.Chemistry.SolvationDissolutionAnalysis
namespace SFT.Chemistry.SolvationDissolutionSource
open SFT.Host SFT.Host.Canonical SFT.Physics SolvationDissolutionExperiment
abbrev Target := InternalEnergyCompositionSource.Target
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := SolvationDissolutionAnalysis.Analysis
def exactSolvationDissolutionAnalysis := SolvationDissolutionAnalysis.exactSolvationDissolutionAnalysis
def sourceRows (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← ([(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash)] ++ SolvationDissolutionExperiment.sourceFiles.zipIdx.map (fun (row : (String × String) × Nat) => ((sourceBytes.drop row.2).head?.getD ByteArray.empty,row.1.1,row.1.2))).mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-015 source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "complete_target_count") (.integer 799) ||
  !sameValue (get targets "source_class_counts") (.object [("solvation",.integer 642),("dissolution",.integer 157)]) ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) || targetRows.length != 799 then
  throw "THERMO-015 target registry changed"
 (ids.zip targetRows).mapM fun (id,target) => do
  let keys := ["target_id","source_id","source_class"] ++
   (if sameValue (get id "source_class") (.text "solvation") then ["source_row_ordinal"] else ["dataset_ordinal","source_point_ordinal"])
  if keys.any (fun key=> !sameValue (get id key) (get target key)) then throw "THERMO-015 identity/target binding changed"
  let hash := identity target
  let targetId ← field id "target_id" >>= identityString
  let held ← CapabilityValues.heldLabel "external-solvation-dissolution-row-hash" hash
  pure (⟨targetId,FiniteMicrostateSupportSource.attachPayload id target hash,.label held⟩ : Target)
end SFT.Chemistry.SolvationDissolutionSource
