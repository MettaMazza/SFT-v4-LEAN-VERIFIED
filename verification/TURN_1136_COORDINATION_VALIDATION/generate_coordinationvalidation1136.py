from pathlib import Path
r=Path('work/turn1064_recovery/SFT/Chemistry')
s=(r/'StateTransitionValidation.lean').read_text().replace('StateTransitionExperiment','CoordinationExperiment').replace('StateTransitionControls','CoordinationComparison').replace('StateTransitionValidation','CoordinationValidation')
s=s[:s.index('def measurement (')]
s=s.replace('"complete-NIST-H2-transition-comparator/1",.text experimentId','"exact-coordination-identity-law/1",.text falsification')
s+='''def measurement (row : Value) : Except String String := do
 return Text.intercalate "" [← rowText row "target_id",": ",← rowText row "source_record_role","=",← rowText row "source_inscription",
  "; target=",← rowText row "target_payload_hash"]
def measurementPayload (registrationHash derivationSeal : String) (prediction : PredictionSeal)
 (analysis : Value) (rows : List Value) (controls : List (String × Bool)) (traceHash : String) : Value :=
 .object [("registration",.text registrationHash),("sealed",.text derivationSeal),
  ("prediction",.text prediction.sealHash),("analysis",analysis),("comparisons",.array rows),
  ("controls",.object (controls.map fun (key,b) => (key,.boolean b))),("trace",.text traceHash)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash : String) (identityDocument targetDocument primary : Value)
 (sourceHashes : List (String × String × String))
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let document ← CoordinationPrediction.predictionDocument actualIdentityHash identityDocument
 let registrationHash := identity (registration document)
 let fields := match document with
  | .object fs => fs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => []
 let program ← CapabilityDocuments.loadProgramFields fields
 let inputs ← inputValues derivationSeal
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram fields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "INORG-001 prediction package changed"
 let predicted ← CoordinationSource.predictionMap execution.output
 let rows ← CoordinationSource.sourceRows sourceHashes actualIdentityHash identityDocument targetDocument
 let targetValues ← rows.mapM fun row => do
  let targetId ← rowText row "target_id"
  let held ← CapabilityValues.heldLabel "external-complete-source-record-hash" (← rowText row "target_payload_hash")
  return (targetId,CapabilityValues.canonical (.label held))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-complete-target-custodian")
  targetValues (identity (.array [.text registrationHash,.text targetRegistryHash])) (identity (envelope registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (references.map SourceExtraction.Reference.targetId) release.values
 let comparisons ← rows.mapM (CoordinationComparison.compare predicted release.values)
 let analysis ← CoordinationAnalysis.analysis rows primary
 let controls ← CoordinationComparison.controls rows primary analysis document release.values targetRegistryHash
 let passed := comparisons.all rowPassed && CoordinationComparison.analysisPassed analysis && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "INORG-001 released target differs from commitment"
 let payload := measurementPayload registrationHash derivationSeal prediction analysis comparisons controls execution.traceHash
 let rowMessages ← rows.mapM measurement
 let messages := rowMessages ++ controls.map (fun (key,b) => Text.intercalate "" ["control ",key,": ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.CoordinationValidation
'''
(r/'CoordinationValidation.lean').write_text(s)
s=Path('work/build_statetransition1134_validation.py').read_text().replace("['StateTransitionExperiment','StateTransitionValidation']","['CoordinationComparison','CoordinationExperiment','CoordinationValidation']").replace('StateTransitionValidationAudit1134','CoordinationValidationAudit1136').replace('statetransition1134','coordination1136').replace("+'1134_build.log'","+'1136_build.log'")
Path('work/build_coordination1136_validation.py').write_text(s)
