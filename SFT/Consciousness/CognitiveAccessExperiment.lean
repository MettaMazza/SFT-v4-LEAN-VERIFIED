import SFT.Consciousness.CognitiveAccessEvidence
import SFT.Consciousness.Source
import SFT.Biology.LifeOrganizationSource
namespace SFT.Consciousness.CognitiveAccessExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CONSC-COGNITIVE-ACCESS-001"
def experimentId : String := "SFT-EXP-CONSC-COGNITIVE-ACCESS-001-E1"
def targetId : String := "sft-consc-cognitive-access-001-external-consequence"
def expectedLabel : String := "access-report-and-presence-nonidentity-preserved"
def falsification : String := "Reject if another generated form preserves every registered dimension, if a required structural witness fails, if purpose-matched evidence contradicts the sealed consequence, or if report, behaviour, biology, computation, physical measurement or public colour naming is substituted for phenomenal occurrence without a separately derived bridge."
def exactResult : String := "retained-process-content__available/unavailable__lawful-read-and-use__access-trace__operational-cognitive__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"
def family : String := "access_report_presence"
def directness : String := "operational_or_record_constraint"
def empiricalDisposition : String := "mixed_boundary_constraint"
def sourceIds : List String := ["CONSC-NOREPORT-NETWORKS-2022", "CONSC-NOREPORT-CRITIQUE-2022", "CONSC-COGITATE-RESULT-2025"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CONSC-COGNITIVE-ACCESS-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "consciousness-external-consequence",.text "access-report-and-presence-nonidentity-preserved"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def registration (row : Value) (extractionHash preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-CONSC-COGNITIVE-ACCESS-001-E1"),("claim_id",.text "SFT-CONSC-COGNITIVE-ACCESS-001"),("frozen_structural_relation",.text "retained-process-content__available/unavailable__lawful-read-and-use__access-trace__operational-cognitive__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"),("complete_branch_pre_source_seal",.text preSourceSeal),("target_id",.text "sft-consc-cognitive-access-001-external-consequence"),("source_ids",.array [.text "CONSC-NOREPORT-NETWORKS-2022",.text "CONSC-NOREPORT-CRITIQUE-2022",.text "CONSC-COGITATE-RESULT-2025"]),("expected_external_consequence",.text "access-report-and-presence-nonidentity-preserved"),("evidence_scope",.text "Report/no-report and adversarial experiments test access and report correlates; phenomenal occurrence remains a separately named evidential coordinate."),("directness",.text "operational_or_record_constraint"),("empirical_disposition",.text "mixed_boundary_constraint"),("target_row_hash",.text extractionHash),("source_evidence",SFT.Materials.MaterialSource.field row "source_evidence"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CONSC-COGNITIVE-ACCESS-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "consciousness-external-consequence",.text "access-report-and-presence-nonidentity-preserved"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("falsification_condition",.text "Reject if another generated form preserves every registered dimension, if a required structural witness fails, if purpose-matched evidence contradicts the sealed consequence, or if report, behaviour, biology, computation, physical measurement or public colour naming is substituted for phenomenal occurrence without a separately derived bridge."),("all_source_features_adverse_boundaries_absences_and_transport_failures_required",.boolean true),("target_inaccessible_before_claim_derivation_seal",.boolean true),("external_evidence_cannot_select_structural_survivor",.boolean true)]
def experimentRegistration (root : String) (sealValue audit targets : Value) (files : List Source.Snapshot) : Except String Value := do
 let (row,extraction) ← Source.targetRow root claimId targetId expectedLabel audit targets files
 let preSeal ← Source.validatePreSourceSeal sealValue files
 pure (registration row extraction preSeal)
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-absent-or-description-only",false),("retained-process-content",true)]),("distinction",[("distinction-collapsed-or-conflated",false),("available/unavailable",true)]),("operation",[("operation-imported-fitted-or-missing",false),("lawful-read-and-use",true)]),("record",[("favourable-output-without-complete-trace",false),("access-trace",true)]),("evidence",[("report-behaviour-correlation-or-confidence-substituted",false),("operational-cognitive",true)]),("provenance",[("prior-consensus-target-or-application-selected",false),("root-bound-forward-forcing",true)]),("generality",[("one-favourable-instance-with-erased-alternatives",false),("positive-finite-successor-with-all-alternatives",true)]),("extension",[("free-parameter-exception-or-opaque-oracle",false),("no-extra-rule",true)])]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CONSC-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-CONSC-").isPrefixOf (Text.chars experimentId) then throw "Consciousness claim identity is invalid"
 if CognitiveAccessEvidence.dependencies.isEmpty || dimensions.length != 8 then throw "Consciousness claim lacks dependencies or eight dimensions"
 if !(SFT.Biology.LifeOrganizationSource.distinctIds (dimensions.map Prod.fst)) then throw "Consciousness dimensions repeat"
 if !(dimensions.all (fun d => d.2.length==2)) then throw "each Consciousness dimension must contain two exhaustive registered forms"
 if !([CognitiveAccess.carrierWitness,CognitiveAccess.distinctionWitness,CognitiveAccess.boundaryWitness,CognitiveAccess.exactFoldWitness].all id) then throw "a Consciousness operational witness failed"
 let admitted ← dimensions.mapM fun d => match d.2.filter Prod.snd with
  | [(name,_)] => pure name
  | [] | _::_::_ => throw "dimension lacks one admitted choice"
 if !Text.equal exactResult (Text.intercalate "__" admitted) then throw "the registered result differs from the preserving form"
 if sourceIds.isEmpty || !(Text.equal (render (.array (sourceIds.map Value.text))) (render (.array [.text "CONSC-NOREPORT-NETWORKS-2022",.text "CONSC-NOREPORT-CRITIQUE-2022",.text "CONSC-COGITATE-RESULT-2025"]))) then throw "Consciousness source identities differ from the registered binding"
 if !Text.equal expectedLabel "access-report-and-presence-nonidentity-preserved" then throw "Consciousness external consequence differs from its binding"
 if !Text.equal targetId "sft-consc-cognitive-access-001-external-consequence" then throw "Consciousness target identity is invalid"
 return ()
end SFT.Consciousness.CognitiveAccessExperiment
