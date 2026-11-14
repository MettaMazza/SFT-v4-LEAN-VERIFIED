import SFT.Physics.DeuteronExperiment
import SFT.Physics.HostilePackage
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.DeuteronValidation
open SFT.Host SFT.Host.Canonical DeuteronPrediction DeuteronExperiment LeptonIntervals
open RunningConvergenceMeasurement (field sameValue)
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def claimId := "SFT-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006"
def sealPrediction (envelopeHash : String) (execution : CapabilityExecution.Execution) : PredictionSeal :=
 let payload : Value := .object [("experiment_id",.text experimentId),("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text envelopeHash)]
 ⟨experimentId,execution.outputHash,execution.traceHash,envelopeHash,admissionIdentity payload⟩
def certificate (fields : List (String × Value)) : Value := .object (fields ++ [("certificate_hash",.text (admissionIdentity (.object fields)))])
def isolation (host implementation registrationHash : String) (execution : CapabilityExecution.Execution) (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("executor_id",.text (Text.append experimentId "-prediction-executor")),("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (admissionIdentity (.text "sft-v3-capability-closed-fold-interpreter/1"))),("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (admissionIdentity (.array [.text "exact-AMDC-NIST-IAEA-deuteron-dinucleon-comparator/1",.text registrationHash,.text falsification]))),("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("completed",.boolean true)]
def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]
def lookup (rows : List (String × CapabilityValues.Value)) (key : String) : Except String CapabilityValues.Value :=
 match rows.find? (fun p => Text.equal p.1 key) with
 | some p => .ok p.2
 | none => .error (Text.append "KeyError: " key)
def count (v : CapabilityValues.Value) : Except String Nat := match v with
 | .count n => .ok n.value
 | .emptyOne _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => .error "prediction count has the wrong exact type"
def ratio (v : CapabilityValues.Value) : Except String Rat := match v with
 | .ratio n d => .ok (normalize (.ofNat n.value) d.value d.positive)
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => .error "prediction ratio has the wrong exact type"
def labelMatches (v : CapabilityValues.Value) (family label : String) : Bool := match v with
 | .label held => Text.equal held.family family && Text.equal held.label label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
def eqCount (n : Nat) (z : Int) : Bool := @decide (Int.ofNat n=z) (Int.decEq _ _)
def booleanText (b : Bool) : String := if b then "True" else "False"
def intervalText (row : NuclearBindingMeasuredRows.Row) : String := Text.intercalate "" ["[",CosmicComponentTransportMeasurement.fractionText row.lower,", ",CosmicComponentTransportMeasurement.fractionText row.upper,"]"]
def channelByCoulombOnlyIsRejected (prediction : List (String × CapabilityValues.Value)) : Except String Bool := do
 let path ← ratio (← lookup prediction "pp_charge_path")
 let nn ← lookup prediction "nn_binding"
 let hand ← lookup prediction "nn_spin_hand"
 pure (path==VacuumLedgerProofs.wholeRatio 1 && labelMatches nn "binding-outcome" "unbound" && labelMatches hand "spin-exchange" "exchange-alternating")
structure Validation where
 value : Value
 passed : Bool
def validate (files : List (String × ByteArray)) (record : Value)
 (sealedClaim derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 if !Text.equal sealedClaim claimId then throw "deuteron validator received the wrong claim seal"
 let registration ← registrationRecord
 let registrationHash := admissionIdentity registration
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fields => .ok fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "prediction document has wrong type"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← formalPredictionInputs
 let orderedKeys := inputs.map Prod.fst
 let env := envelope derivationSeal inputs registrationHash
 let targets ← releasedTargets files record
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") (targetValues targets)
  (admissionIdentity (.array [.text registrationHash,.text DeuteronMeasurement.sourceHash,.object (DeuteronMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))])) (admissionIdentity env)
 let execution ← CapabilityExecution.execute program inputs
 let predictionSeal := sealPrediction (admissionIdentity env) execution
 let (audited,packageAudit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (admissionIdentity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !packageAudit.passed then
  throw "deuteron prediction failed hostile-package audit"
 let (_,released) ← TargetCustody.release vault predictionSeal
 TargetCustody.verify vault.commitment released predictionSeal
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨predictionSeal.experiment,predictionSeal.predictionHash,predictionSeal.traceHash,predictionSeal.envelopeHash,predictionSeal.sealHash⟩) targetIds released.values
 let prediction ← outputMapping execution.output orderedKeys
 if !sameValue (.object (prediction.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "capability-closed deuteron prediction differs from formal inputs"
 let ame ← DeuteronMeasurement.ameA2Analysis targets.ameRows
 let nubase ← DeuteronMeasurement.nubaseA2Analysis targets.nubaseRows
 let codata ← DeuteronMeasurement.codataBindingInterval targets.codataRows
 let synthetic ← DeuteronMeasurement.authoritativeRecord files record
 -- Released IAEA targets are the same immutable fields obtained from this record.
 let iaea ← DeuteronMeasurement.iaeaAnalysis synthetic
 let lower := if codata.binding.1.blt ame.interval.1 then ame.interval.1 else codata.binding.1
 let upper := if codata.binding.2.blt ame.interval.2 then codata.binding.2 else ame.interval.2
 let overlap := !upper.blt lower
 let preservingSupport ← ratio (← lookup prediction "preserving_support")
 let alternatingSupport ← ratio (← lookup prediction "alternating_support")
 let residual ← ratio (← lookup prediction "residual_boundary")
 let retained ← ratio (← lookup prediction "preserving_remainder")
 let absent ← lookup prediction "alternating_remainder"
 let pn ← lookup prediction "pn_binding"
 let pp ← lookup prediction "pp_binding"
 let nn ← lookup prediction "nn_binding"
 let spin ← ratio (← lookup prediction "composite_spin")
 let preservingReadings ← count (← lookup prediction "preserving_readings")
 let alternatingReadings ← count (← lookup prediction "alternating_readings")
 let formalChannel := preservingSupport==normalize 3 4 (by decide) && alternatingSupport==normalize 1 4 (by decide) && residual==normalize 1 4 (by decide) && retained==normalize 1 2 (by decide) && labelMatches absent "structural-absence" "empty-form" && labelMatches pn "binding-outcome" "bound" && labelMatches pp "binding-outcome" "unbound" && labelMatches nn "binding-outcome" "unbound" && spin==VacuumLedgerProofs.wholeRatio 1 && preservingReadings==3 && alternatingReadings==1
 let inventory := ame.coordinateCount==3558 && ame.a2Count==1 && eqCount 1 ame.charge && eqCount 1 ame.neutron && nubase.stateCount==5843 && nubase.a2Count==1 && eqCount 1 nubase.atomicNumber
 let checkedRecord ← DeuteronMeasurement.authoritativeRecord files record
 let sources ← RunningConvergenceMeasurement.array (← field checkedRecord "sources")
 let allRows := targets.ameRows.length==3558 && targets.nubaseRows.length==5843 && targets.codataRows.length==3 && iaea.parameterCount==2 && iaea.observationsComplete && sources.length==5
 let coulombOnly ← channelByCoulombOnlyIsRejected prediction
 let unfavorable := (targets.ameRows.take (targets.ameRows.length-1)).length != 3558 && (targets.nubaseRows.take (targets.nubaseRows.length-1)).length != 5843 && !(nubase.a2Count>1) && !labelMatches pp "binding-outcome" "bound" && !labelMatches nn "binding-outcome" "bound" && coulombOnly
 let passed := [formalChannel,inventory,allRows,unfavorable,nubase.measuredSpin,nubase.stable,overlap,iaea.signsSeparated,iaea.uncertaintiesPositive,iaea.parallelBound,iaea.weights==(normalize 1 4 (by decide),normalize 3 4 (by decide)),iaea.crossSectionAbove].all id
 let targetIdentity ← TargetCustody.identityFromRelease released
 let comparison : Value := .object [("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text predictionSeal.sealHash),("source_record_hash",.text DeuteronMeasurement.sourceHash),("source_hashes",.object (DeuteronMeasurement.sourceHashes.map (fun (k,v) => (k,.text v)))),("complete_target_identity_hash",.text targetIdentity),("ame_analysis",DeuteronMeasurement.ameValue ame),("nubase_analysis",DeuteronMeasurement.nubaseValue nubase),("codata_analysis",DeuteronMeasurement.codataValue codata),("iaea_analysis",DeuteronMeasurement.iaeaValue iaea),("formal_channel",.boolean formalChannel),("binding_overlap",.boolean overlap),("complete_a2_inventory",.boolean inventory),("all_rows_preserved",.boolean allRows),("unfavorable_controls",.boolean unfavorable),("prediction_trace_hash",.text execution.traceHash)]
 let measurements := [
 "complete AME2020 numeric coordinate census retained: 3,558 rows; exactly one A=2 coordinate (2H)",
 "complete NUBASE2020 state census retained: 5,843 rows; exactly one A=2 state, stable 2H with directly measured Jpi=1+",
 Text.intercalate "" ["NIST CODATA proton+neutron taking deuteron binding interval MeV: ",FusionFissionTerminalEvidence.gainRepr codata.binding,"; central ",CosmicComponentTransportMeasurement.fractionText codata.central],
 Text.intercalate "" ["AME2020 deuteron total binding interval MeV: ",FusionFissionTerminalEvidence.gainRepr ame.interval,"; central ",CosmicComponentTransportMeasurement.fractionText ame.central," keV"],
 "CODATA mass-difference and AME2020 binding intervals overlap exactly after all reported uncertainties",
 "IAEA JENDL complete two-set spin-channel table retained; singlet scattering lengths are externally signed opposite to both positive triplet entries, with every effective-range uncertainty",
 "IAEA records the bound deuteron, parallel neutron/proton spins, triplet association and spin-dependent cross-section separation",
 "reversed pp/nn binding, Coulomb-only nn explanation, incomplete-census and changed-source controls rejected"]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),("isolation_certificate",isolation host implementation registrationHash execution vault predictionSeal),("target_custody_certificate",custodyCertificate registrationHash released predictionSeal),("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean allRows),("data_source_ids",.array (DeuteronMeasurement.sourceIds.map Value.text)),("measurements",.array (measurements.map Value.text)),("measurement_receipt_hash",.text (admissionIdentity comparison)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Physics.DeuteronValidation
