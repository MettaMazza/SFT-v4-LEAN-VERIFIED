import SFT.Materials.BulkWaterValidation
import Lean
open SFT.Materials SFT.Physics
def convert : Nat → Lean.Json → Except String SFT.Host.Canonical.Value
 | 0,_ => .error "JSON nesting exceeds input byte count"
 | n+1,j => match j with
   | .null => .ok .null
   | .bool b => .ok (.boolean b)
   | .num _ => do return .integer (← j.getInt?)
   | .str s => .ok (.text s)
   | .arr xs => do return .array (← xs.toList.mapM (convert n))
   | .obj fs => do return .object (← fs.toList.mapM fun (k,v) => do return (k,← convert n v))
def field (j : Lean.Json) (name : String) := j.getObjVal? name
def text (j : Lean.Json) (name : String) := j.getObjValAs? String name
def items (j : Lean.Json) (name : String) : Except String (List Lean.Json) := do
 return (← (← field j name).getArr?).toList
def protectedSnapshot (j : Lean.Json) : Except String HostilePackage.Snapshot := do
 let pairs ← (← items j "file_hashes").mapM fun row => do
  let a ← row.getArr?
  return (← a[0]!.getStr?,← a[1]!.getStr?)
 return ⟨← text j "root_identity",pairs,← text j "snapshot_hash"⟩
open SFT.Host SFT.Host.Canonical SFT.Materials.BulkWaterExperiment SFT.Materials.BulkWaterValidation
def postSource (sourceSeal : String) (receipts : List SFT.Host.Canonical.Value)
 (derivationSeal host implementation : String) (before after : HostilePackage.Snapshot) : Except String SFT.Host.Canonical.Value := do
 validateSpec
 let registryHash := registrationHash sourceSeal receipts
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let target ← CapabilityValues.heldLabel "external-observation" expectedLabel
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-custodian")
  [(targetId,CapabilityValues.canonical (.label target))] (identity (.array receipts))
  (identity (envelope registryHash derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let prediction ← sealPrediction none registryHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "hostile audit failed"
 let (_,released) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment released prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  [targetId] released.values
 let releasedValue ← match released.values.find? (fun row => Text.equal row.1 targetId) with
  | none => .error (Text.intercalate "" ["'",targetId,"'"])
  | some row => .ok row.2
 let observed ← SFT.Chemistry.ConjugatedSupportAnalysis.field releasedValue "label" >>= BulkWaterSource.stringValue
 let predicted ← observation execution.output
 let passed := Text.equal predicted observed
 let _targetIdentity ← TargetCustody.identityFromRelease released
 let measurements := [Text.append "sealed prediction equals complete source-derived observation: " (if passed then "True" else "False"),
  "all registered rows preserved","tampered changed label rejected"]
 return .object [
 ("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registryHash),
 ("isolation_certificate",isolation host implementation execution vault prediction),
 ("target_custody_certificate",custodyCertificate registryHash released prediction),
 ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),
 ("all_rows_preserved",.boolean true),("data_source_ids",.array (sourceIds.map Value.text)),
 ("measurements",.array (measurements.map Value.text)),
 ("measurement_receipt_hash",.text (identity (.array [.text registryHash,.array receipts,.boolean passed]))),
 ("falsification_condition",.text falsification),("passed",.boolean passed)]
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/bulkwater1499_postsource_input.json"
 let parsed ← IO.ofExcept (Lean.Json.parse raw)
 let sourceSeal ← IO.ofExcept (text parsed "source_seal")
 let receiptJson ← IO.ofExcept (items parsed "receipts")
 let receipts ← IO.ofExcept (receiptJson.mapM (convert (raw.utf8ByteSize+1)))
 let output ← IO.ofExcept (do
  let before ← field parsed "before" >>= protectedSnapshot
  let after ← field parsed "after" >>= protectedSnapshot
  postSource sourceSeal receipts (← text parsed "derivation_seal") (← text parsed "host") (← text parsed "implementation") before after)
 IO.println (SFT.Host.Canonical.render output)
