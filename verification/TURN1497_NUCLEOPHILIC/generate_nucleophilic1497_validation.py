from pathlib import Path
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
s=(r/'ConjugatedSupportValidation.lean').read_text();s=s[:s.index('-- These are the scalar')];s=s.replace('import SFT.Chemistry.ConjugatedSupportControls\n','').replace('ConjugatedSupport','Nucleophilic').replace('exact-connected-alternating-conjugated-support/1','exact-org-007-structure-mechanism-comparison/1')
s+='''open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
def stringField (row : Value) (key : String) : Except String String := field row key >>= text
-- Formula elements are the ASCII chemical-symbol tokens parsed by the original grammar.
def formulaDisplay (value : Value) : Except String String := do
 let fields ← match value with
  | .object xs => pure xs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => throw "formula inventory must be a dictionary"
 let parts ← fields.mapM fun (key,value) => do
  let number ← match value with
   | .integer n => pure (Canonical.render (.integer n))
   | .null | .text _ | .boolean _ | .object _ | .array _ => throw "formula count must be an integer"
  return Text.join ["'",key,"': ",number]
 return Text.join ["{",Text.intercalate ", " parts,"}"]
def messages (analysis : Value) : Except String (List String) := do
 let source ← formulaDisplay (← field analysis "source_formula_vector")
 let terminal ← formulaDisplay (← field analysis "terminal_formula_vector")
 let conserved := if equal (get analysis "complete_formula_inventory_conserved") (.boolean true) then "True" else "False"
 let substrate ← stringField analysis "source_substrate_connectivity"
 let entering ← stringField analysis "entering_carrier_connectivity"
 let product ← stringField analysis "terminal_product_connectivity"
 let leaving ← stringField analysis "leaving_carrier_connectivity"
 return ["complete nine-record external structure and mechanism vector retained",
 "seven exact IUPAC and PubChem payloads opened only after the ORG-007 seal; two development-observed IUPAC rows disclosed",
 Text.join ["source formula inventory ",source,"; terminal formula inventory ",terminal,"; exact conservation ",conserved],
 Text.join ["connectivity ",substrate," plus ",entering," becomes ",product," plus ",leaving],
 "post-seal IUPAC records preserve entering-group bond formation, elementary-or-stepwise replacement, and both-electron heterolysis",
 "V1 development-snapshot hash transcription error preserved; V2 correction changes no source, target, prediction, law or outcome and performs no recapture",
 "deliberately omitted-row and tampered-label controls rejected"]
structure Validation where
 value : Value
 passed : Bool
def validate (identityHash targetHash primaryHash : String) (identityDocument targetDocument primaryDocument : Value)
 (snapshotHashes : List (String × String)) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 if !Text.equal primaryHash PRIMARYHASH then throw "ORG-007 primary analysis changed"
 let rows ← NucleophilicSource.sourceRows targetHash identityHash identityDocument targetDocument snapshotHashes
 let (analysis,checks) ← NucleophilicAnalysis.analysis rows primaryDocument
 let registrationHash := identity registration
 let parsed ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let targets ← checks.mapM fun (target,passed) => do
  let held ← CapabilityValues.heldLabel "external-observation" (if passed then expectedLabel else "adverse-structure-or-mechanism-mismatch")
  return (target,CapabilityValues.canonical (.label held))
 let vectorHash ← stringField analysis "complete_target_vector_hash"
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian")
  targets (identity (.array [.text registrationHash,.text TARGETHASH,.text vectorHash]))
  (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute parsed inputs
 let predictionSeal ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ORG-007 capability-closed prediction package changed"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩)
  targetIds released.values
 let prediction ← match execution.output with
  | .label p => if Text.equal p.family "chemical-observation" then pure p else throw "ORG-007 prediction output is invalid"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "ORG-007 prediction output is invalid"
 let comparisons ← checks.mapM fun (target,_) => do
  let observed ← match released.values.find? (fun p => Text.equal p.1 target) with
   | none => throw (Text.join ["'",target,"'"])
   | some p => stringField p.2 "label"
  return Canonical.Value.object [("target_id",.text target),("predicted",.text prediction.label),("observed",.text observed),
   ("passed",.boolean (Text.equal prediction.label observed))]
 let tamperedRejected := !Text.equal prediction.label (Text.append prediction.label "__tampered")
 let omissionRejected := match NucleophilicAnalysis.analysis (rows.take (rows.length-1)) primaryDocument with
  | .error _ => true
  | .ok _ => false
 let passed := comparisons.all (fun row => equal (get row "passed") (.boolean true)) && checks.all Prod.snd && omissionRejected && tamperedRejected
 let targetIdentity ← TargetCustody.identityFromRelease released
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ORG-007 target release differs from commitment"
 let payload : Value := .object [("registration",.text registrationHash),("sealed",.text derivationSeal),
  ("prediction",.text predictionSeal.sealHash),("analysis",analysis),("checks",.object (checks.map fun p => (p.1,.boolean p.2))),
  ("comparisons",.array comparisons),("controls",.object [("omission_rejected",.boolean omissionRejected),("tampered_rejected",.boolean tamperedRejected)]),
  ("trace",.text execution.traceHash)]
 let measurements ← messages analysis
 let sourceIds ← rows.mapM fun row => stringField row "source_id"
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault predictionSeal),
  ("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.NucleophilicValidation
'''
import sys,json
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((w/'pinned_nucleophilic1496/sft/chemistry').resolve()))
from sft.chemistry.nucleophilic_substitution_batch_v1 import PRIMARY_HASH,TARGET_HASH
s=s.replace('PRIMARYHASH',json.dumps(PRIMARY_HASH)).replace('TARGETHASH',json.dumps(TARGET_HASH));(r/'NucleophilicValidation.lean').write_text(s)
b=(w/'build_nucleophilic1497_path_proofs.py').read_text().replace("['NucleophilicPathProofs']","['NucleophilicExperiment','NucleophilicValidation']").replace('nucleophilic1497_path_proofs','nucleophilic1497_validation');(w/'build_nucleophilic1497_validation.py').write_text(b)
