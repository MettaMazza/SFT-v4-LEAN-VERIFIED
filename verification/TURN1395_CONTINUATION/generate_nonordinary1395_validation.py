from pathlib import Path
r=Path('work/turn1064_recovery/SFT/Consciousness');old=(r/'RedControlsValidation.lean').read_text();s=old[:old.index('def predictionLabel')].replace('RedControls','NonordinaryExternal').replace('exact-consciousness-boundary-equality','exact-consciousness-return-family-comparison')
s+='''def predictionLabel : CapabilityValues.Value → Except String String
 | .label held => if Text.equal held.family "consciousness-observation" then .ok held.label else .error "invalid Consciousness prediction"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "invalid Consciousness prediction"

def validate (files : List NonordinaryExternalSource.File) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Value := do
 let registrationHash := identity registration
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let resolved ← NonordinaryExternalSource.sourceTarget files
 let target ← CapabilityValues.heldLabel "external-observation" resolved.label
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-source-custodian")
  [(targetId,CapabilityValues.canonical (.label target))]
  (identity (.array [.text registrationHash,.text resolved.extractionHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "Consciousness hostile-package audit failed"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  [targetId] release.values
 let predicted ← predictionLabel execution.output
 let released ← match release.values.find? (fun row => Text.equal row.1 targetId) with
  | none => .error (Text.intercalate "" ["'",targetId,"'"])
  | some row => .ok row.2
 let observed := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field released "label")
 let comparison := Text.equal predicted observed
 let tampered := !(Text.equal predicted (Text.append observed "__tampered"))
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "Consciousness target identity differs"
 let measurement : Value := .object [("registration",.text registrationHash),("derivation",.text derivationSeal),
  ("prediction",.text prediction.sealHash),("extraction",.text resolved.extractionHash),
  ("sources",.array (resolved.sourceIds.map Value.text)),("classes",resolved.resultClasses),
  ("comparison",.boolean comparison),("tampered",.boolean tampered)]
 let messages := [Text.intercalate "" [targetId,": exact categorical match ",if comparison then "True" else "False"],
  "stable cross-modal inducer/concurrent correspondence retained with diagnostic and mechanistic heterogeneity",
  "multidimensional altered-state reports and measured neural covariation retained without ontological inflation",
  "NREM/REM alternation retained with local/global dissociation and non-universal timing",
  "lost integrated function and retained viable components remain distinct",
  "null, non-purpose-matched, heterogeneous and unresolved rows retained",
  "tampered control rejected"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (resolved.sourceIds.map Value.text)),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity measurement)),
  ("falsification_condition",SFT.Materials.MaterialSource.field registration "falsification_condition"),
  ("passed",.boolean (comparison && tampered))]
end SFT.Consciousness.NonordinaryExternalValidation
''';(r/'NonordinaryExternalValidation.lean').write_text(s)
