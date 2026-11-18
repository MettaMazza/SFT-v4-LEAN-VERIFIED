from pathlib import Path
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
s='''import SFT.Chemistry.EquilibriumBondLengthSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.EquilibriumBondLengthValidation
open SFT.Host SFT.Host.Canonical SFT.Physics EquilibriumBondLengthExperiment
open SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def inputValues (lower upper : Rat) : Except String (List (String × CapabilityValues.Value)) := do
 return [("atomic-lower",← EquilibriumBondLengthSource.ratio lower),
  ("atomic-upper",← EquilibriumBondLengthSource.ratio upper)]
def envelope (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map fun (key,value) => (key,.text (CapabilityValues.identity value)))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
'''
prior=(r/'ResolvedRovibronicValidation.lean').read_text();a=prior.index('def sealPrediction');b=prior.index('def boolText',a);part=prior[a:b].replace('(prior : Option PredictionSeal) (registrationHash derivationSeal : String)','(prior : Option PredictionSeal) (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String)').replace('identity (envelope registrationHash derivationSeal)','identity (envelope inputs registrationHash derivationSeal)').replace('def isolation (host implementation : String)','def isolation (registrationHash host implementation : String)').replace('.text "complete-resolved-H2-HD-D2-comparator/1",.text experimentId','.text "exact-equilibrium-length-interval-comparator/1",.text registrationHash');s+=part
s+='''def ratValue (value : Rat) : Value := .object [("numerator",.integer value.num),("denominator",.integer (Int.ofNat value.den))]
def ratText (value : Rat) : String := Text.intercalate "" [render (.integer value.num),"/",render (.integer (Int.ofNat value.den))]
def boolText (b : Bool) : String := if b then "True" else "False"
def ratioFraction (value : CapabilityValues.Value) : Except String Rat :=
 match value with
 | .ratio n d => .ok (normalize (Int.ofNat n.value) d.value d.positive)
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "PROP-001 prediction is not an exact interval"
structure Validation where
 value : Value
 passed : Bool
def validate (scaleBytes identityBytes targetBytes sourceBytes : ByteArray)
 (scaleDocument identityDocument targetDocument sourceDocument : Value)
 (files : List (String × ByteArray)) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord
 let registrationHash := identity registration
 let (_,scaleLower,scaleUpper) ← EquilibriumBondLengthSource.loadScale scaleBytes scaleDocument
 let targets ← EquilibriumBondLengthSource.loadTargets identityBytes targetBytes sourceBytes identityDocument targetDocument sourceDocument files
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fs => .ok fs
  | .null | .text _ | .integer _ | .boolean _ | .array _ => .error "PROP-001 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues scaleLower scaleUpper
 let targetValues := targets.map fun row => (row.targetId,CapabilityValues.canonical row.interval)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian") targetValues
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-001 prediction package changed"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let entries ← match execution.output with
  | .table entries => if entries.length==2 then .ok entries else .error "PROP-001 prediction vector is incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => .error "PROP-001 prediction vector is incomplete"
 let results ← targets.mapM fun row => do
  let interval ← match entries.reverse.find? (fun p => match p.1 with
    | .label key => Text.equal key.label row.species
    | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false) with
   | some (_,value) => .ok value
   | none => .error (Text.intercalate "" ["'",row.species,"'"])
  let (lowerValue,upperValue) ← match interval with
   | .pair lower upper => .ok (lower,upper)
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ => .error "PROP-001 prediction is not an exact interval"
  let predictedLower ← ratioFraction lowerValue
  let predictedUpper ← ratioFraction upperValue
  let overlap := !(predictedUpper.blt row.lower || row.upper.blt predictedLower)
  let displacedLower ← EquilibriumBondLengthSource.ratio (add predictedUpper (wholeRatio 1))
  let displacedUpper ← EquilibriumBondLengthSource.ratio (add predictedUpper (wholeRatio 2))
  let displaced := CapabilityValues.Value.pair displacedLower displacedUpper
  let displacedLeft ← match displaced with
   | .pair left _ => ratioFraction left
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ => .error "PROP-001 prediction is not an exact interval"
  let displacedRejected := row.upper.blt displacedLeft
  let comparison : Value := .object [("target_id",.text row.targetId),("species",.text row.species),
   ("predicted_lower",ratValue predictedLower),("predicted_upper",ratValue predictedUpper),
   ("observed_lower",ratValue row.lower),("observed_upper",ratValue row.upper),
   ("source_inscription",.text row.inscription),("overlap",.boolean overlap)]
  let message := Text.intercalate "" [row.species,": exact predicted interval [",ratText predictedLower,", ",ratText predictedUpper,
   "] angstrom; NIST ",row.inscription," within [",ratText row.lower,", ",ratText row.upper,
   "]; overlap ",boolText overlap]
  return (comparison,(row.species,displacedRejected),overlap,message)
 let comparisons := results.map fun r => r.1
 let adverse := results.map fun r => r.2.1
 let passed := (results.all fun r => r.2.2.1) && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-001 released target identity differs"
 let payload : Value := .object [("registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("scale_input_hash",.text scaleHash),("target_registry_hash",.text targetHash),
  ("comparisons",.array comparisons),("adverse",.array (adverse.map fun (name,b) => .array [.text name,.boolean b])),
  ("trace_hash",.text execution.traceHash)]
 let messages := (results.map fun r => r.2.2.2) ++ (adverse.map fun (name,b) => Text.intercalate "" ["adverse displaced ",name," interval rejected: ",boolText b])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CODATA-2022-ALL-CONSTANTS",.text "NIST-WEBBOOK-SRD69-H2-DIATOMIC-CONSTANTS",.text "NIST-WEBBOOK-SRD69-D2-DIATOMIC-CONSTANTS"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.EquilibriumBondLengthValidation
''';(r/'EquilibriumBondLengthValidation.lean').write_text(s)
p=r/'EquilibriumBondLengthExperiment.lean';s=p.read_text().replace('set_option maxRecDepth 20000','set_option maxRecDepth 20000\nset_option maxHeartbeats 100000000');p.write_text(s)
print('Full original empirical-validator composition translated,including both exact intervals,displaced controls,custody and all12fields4messages. Native verification pending.')
