import SFT.Consciousness.SynchronyBoundaryEvidence
import SFT.Consciousness.Source
import SFT.Biology.LifeOrganizationSource
namespace SFT.Consciousness.SynchronyBoundaryExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CONSC-SYNCHRONY-BOUNDARY-001"
def experimentId : String := "SFT-EXP-CONSC-SYNCHRONY-BOUNDARY-001-E1"
def targetId : String := "sft-consc-synchrony-boundary-001-external-consequence"
def expectedLabel : String := "integration-and-unity-evidence-boundary-preserved"
def falsification : String := "Reject if another generated form preserves every registered dimension, if a required structural witness fails, if purpose-matched evidence contradicts the sealed consequence, or if report, behaviour, biology, computation, physical measurement or public colour naming is substituted for phenomenal occurrence without a separately derived bridge."
def exactResult : String := "timed-process-traces__same-time/same-whole__recurrence-alignment-test__phase-and-composition-record__biological-correlate-boundary__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"
def family : String := "binding_unity"
def directness : String := "operational_or_record_constraint"
def empiricalDisposition : String := "mixed_and_adverse_constraint"
def sourceIds : List String := ["CONSC-SPLIT-INTEGRATION-2023", "CONSC-SPLIT-BOUNDARY-2020", "CONSC-COGITATE-RESULT-2025"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CONSC-SYNCHRONY-BOUNDARY-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "consciousness-external-consequence",.text "integration-and-unity-evidence-boundary-preserved"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def registration (row : Value) (extractionHash preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-CONSC-SYNCHRONY-BOUNDARY-001-E1"),("claim_id",.text "SFT-CONSC-SYNCHRONY-BOUNDARY-001"),("frozen_structural_relation",.text "timed-process-traces__same-time/same-whole__recurrence-alignment-test__phase-and-composition-record__biological-correlate-boundary__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"),("complete_branch_pre_source_seal",.text preSourceSeal),("target_id",.text "sft-consc-synchrony-boundary-001-external-consequence"),("source_ids",.array [.text "CONSC-SPLIT-INTEGRATION-2023",.text "CONSC-SPLIT-BOUNDARY-2020",.text "CONSC-COGITATE-RESULT-2025"]),("expected_external_consequence",.text "integration-and-unity-evidence-boundary-preserved"),("evidence_scope",.text "Split-brain and adversarial records test integration while preserving disagreement about whether a single phenomenal whole has been established."),("directness",.text "operational_or_record_constraint"),("empirical_disposition",.text "mixed_and_adverse_constraint"),("target_row_hash",.text extractionHash),("source_evidence",SFT.Materials.MaterialSource.field row "source_evidence"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CONSC-SYNCHRONY-BOUNDARY-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "consciousness-external-consequence",.text "integration-and-unity-evidence-boundary-preserved"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("falsification_condition",.text "Reject if another generated form preserves every registered dimension, if a required structural witness fails, if purpose-matched evidence contradicts the sealed consequence, or if report, behaviour, biology, computation, physical measurement or public colour naming is substituted for phenomenal occurrence without a separately derived bridge."),("all_source_features_adverse_boundaries_absences_and_transport_failures_required",.boolean true),("target_inaccessible_before_claim_derivation_seal",.boolean true),("external_evidence_cannot_select_structural_survivor",.boolean true)]
def experimentRegistration (root : String) (sealValue audit targets : Value) (files : List Source.Snapshot) : Except String Value := do
 let (row,extraction) ← Source.targetRow root claimId targetId expectedLabel audit targets files
 let preSeal ← Source.validatePreSourceSeal sealValue files
 pure (registration row extraction preSeal)
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-absent-or-description-only",false),("timed-process-traces",true)]),("distinction",[("distinction-collapsed-or-conflated",false),("same-time/same-whole",true)]),("operation",[("operation-imported-fitted-or-missing",false),("recurrence-alignment-test",true)]),("record",[("favourable-output-without-complete-trace",false),("phase-and-composition-record",true)]),("evidence",[("report-behaviour-correlation-or-confidence-substituted",false),("biological-correlate-boundary",true)]),("provenance",[("prior-consensus-target-or-application-selected",false),("root-bound-forward-forcing",true)]),("generality",[("one-favourable-instance-with-erased-alternatives",false),("positive-finite-successor-with-all-alternatives",true)]),("extension",[("free-parameter-exception-or-opaque-oracle",false),("no-extra-rule",true)])]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CONSC-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-CONSC-").isPrefixOf (Text.chars experimentId) then throw "Consciousness claim identity is invalid"
 if SynchronyBoundaryEvidence.dependencies.isEmpty || dimensions.length != 8 then throw "Consciousness claim lacks dependencies or eight dimensions"
 if !(SFT.Biology.LifeOrganizationSource.distinctIds (dimensions.map Prod.fst)) then throw "Consciousness dimensions repeat"
 if !(dimensions.all (fun d => d.2.length==2)) then throw "each Consciousness dimension must contain two exhaustive registered forms"
 if !([SynchronyBoundary.carrierWitness,SynchronyBoundary.distinctionWitness,SynchronyBoundary.boundaryWitness,SynchronyBoundary.exactFoldWitness].all id) then throw "a Consciousness operational witness failed"
 let admitted ← dimensions.mapM fun d => match d.2.filter Prod.snd with
  | [(name,_)] => pure name
  | [] | _::_::_ => throw "dimension lacks one admitted choice"
 if !Text.equal exactResult (Text.intercalate "__" admitted) then throw "the registered result differs from the preserving form"
 if sourceIds.isEmpty || !(Text.equal (render (.array (sourceIds.map Value.text))) (render (.array [.text "CONSC-SPLIT-INTEGRATION-2023",.text "CONSC-SPLIT-BOUNDARY-2020",.text "CONSC-COGITATE-RESULT-2025"]))) then throw "Consciousness source identities differ from the registered binding"
 if !Text.equal expectedLabel "integration-and-unity-evidence-boundary-preserved" then throw "Consciousness external consequence differs from its binding"
 if !Text.equal targetId "sft-consc-synchrony-boundary-001-external-consequence" then throw "Consciousness target identity is invalid"
 return ()
end SFT.Consciousness.SynchronyBoundaryExperiment
