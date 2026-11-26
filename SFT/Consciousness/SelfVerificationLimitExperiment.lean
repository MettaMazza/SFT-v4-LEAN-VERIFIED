import SFT.Consciousness.SelfVerificationLimitEvidence
import SFT.Consciousness.Source
import SFT.Biology.LifeOrganizationSource
namespace SFT.Consciousness.SelfVerificationLimitExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-CONSC-SELF-VERIFICATION-LIMIT-001"
def experimentId : String := "SFT-EXP-CONSC-SELF-VERIFICATION-LIMIT-001-E1"
def targetId : String := "sft-consc-self-verification-limit-001-external-consequence"
def expectedLabel : String := "finite-self-model-remains-formal-with-empirical-representation-boundary"
def falsification : String := "Reject if another generated form preserves every registered dimension, if a required structural witness fails, if purpose-matched evidence contradicts the sealed consequence, or if report, behaviour, biology, computation, physical measurement or public colour naming is substituted for phenomenal occurrence without a separately derived bridge."
def exactResult : String := "model-proof-and-observer__verified/verification-premise__finite-proof-trace__unverified-observer-boundary__formal-logical__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"
def family : String := "finite_self_model"
def directness : String := "formal_reconstruction_with_external_boundary_only"
def empiricalDisposition : String := "formal_with_external_boundary"
def sourceIds : List String := ["CONSC-CHOICE-BLINDNESS-2017", "CONSC-COGITATE-DATA-2025"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CONSC-SELF-VERIFICATION-LIMIT-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "consciousness-external-consequence",.text "finite-self-model-remains-formal-with-empirical-representation-boundary"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def registration (row : Value) (extractionHash preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-CONSC-SELF-VERIFICATION-LIMIT-001-E1"),("claim_id",.text "SFT-CONSC-SELF-VERIFICATION-LIMIT-001"),("frozen_structural_relation",.text "model-proof-and-observer__verified/verification-premise__finite-proof-trace__unverified-observer-boundary__formal-logical__root-bound-forward-forcing__positive-finite-successor-with-all-alternatives__no-extra-rule"),("complete_branch_pre_source_seal",.text preSourceSeal),("target_id",.text "sft-consc-self-verification-limit-001-external-consequence"),("source_ids",.array [.text "CONSC-CHOICE-BLINDNESS-2017",.text "CONSC-COGITATE-DATA-2025"]),("expected_external_consequence",.text "finite-self-model-remains-formal-with-empirical-representation-boundary"),("evidence_scope",.text "Choice-blindness and open adversarial datasets constrain self-report and model representation; they do not directly observe a complete internal self-model."),("directness",.text "formal_reconstruction_with_external_boundary_only"),("empirical_disposition",.text "formal_with_external_boundary"),("target_row_hash",.text extractionHash),("source_evidence",SFT.Materials.MaterialSource.field row "source_evidence"),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-CONSC-SELF-VERIFICATION-LIMIT-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "consciousness-external-consequence",.text "finite-self-model-remains-formal-with-empirical-representation-boundary"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("falsification_condition",.text "Reject if another generated form preserves every registered dimension, if a required structural witness fails, if purpose-matched evidence contradicts the sealed consequence, or if report, behaviour, biology, computation, physical measurement or public colour naming is substituted for phenomenal occurrence without a separately derived bridge."),("all_source_features_adverse_boundaries_absences_and_transport_failures_required",.boolean true),("target_inaccessible_before_claim_derivation_seal",.boolean true),("external_evidence_cannot_select_structural_survivor",.boolean true)]
def experimentRegistration (root : String) (sealValue audit targets : Value) (files : List Source.Snapshot) : Except String Value := do
 let (row,extraction) ← Source.targetRow root claimId targetId expectedLabel audit targets files
 let preSeal ← Source.validatePreSourceSeal sealValue files
 pure (registration row extraction preSeal)
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-absent-or-description-only",false),("model-proof-and-observer",true)]),("distinction",[("distinction-collapsed-or-conflated",false),("verified/verification-premise",true)]),("operation",[("operation-imported-fitted-or-missing",false),("finite-proof-trace",true)]),("record",[("favourable-output-without-complete-trace",false),("unverified-observer-boundary",true)]),("evidence",[("report-behaviour-correlation-or-confidence-substituted",false),("formal-logical",true)]),("provenance",[("prior-consensus-target-or-application-selected",false),("root-bound-forward-forcing",true)]),("generality",[("one-favourable-instance-with-erased-alternatives",false),("positive-finite-successor-with-all-alternatives",true)]),("extension",[("free-parameter-exception-or-opaque-oracle",false),("no-extra-rule",true)])]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CONSC-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-CONSC-").isPrefixOf (Text.chars experimentId) then throw "Consciousness claim identity is invalid"
 if SelfVerificationLimitEvidence.dependencies.isEmpty || dimensions.length != 8 then throw "Consciousness claim lacks dependencies or eight dimensions"
 if !(SFT.Biology.LifeOrganizationSource.distinctIds (dimensions.map Prod.fst)) then throw "Consciousness dimensions repeat"
 if !(dimensions.all (fun d => d.2.length==2)) then throw "each Consciousness dimension must contain two exhaustive registered forms"
 if !([SelfVerificationLimit.carrierWitness,SelfVerificationLimit.distinctionWitness,SelfVerificationLimit.boundaryWitness,SelfVerificationLimit.exactFoldWitness].all id) then throw "a Consciousness operational witness failed"
 let admitted ← dimensions.mapM fun d => match d.2.filter Prod.snd with
  | [(name,_)] => pure name
  | [] | _::_::_ => throw "dimension lacks one admitted choice"
 if !Text.equal exactResult (Text.intercalate "__" admitted) then throw "the registered result differs from the preserving form"
 if sourceIds.isEmpty || !(Text.equal (render (.array (sourceIds.map Value.text))) (render (.array [.text "CONSC-CHOICE-BLINDNESS-2017",.text "CONSC-COGITATE-DATA-2025"]))) then throw "Consciousness source identities differ from the registered binding"
 if !Text.equal expectedLabel "finite-self-model-remains-formal-with-empirical-representation-boundary" then throw "Consciousness external consequence differs from its binding"
 if !Text.equal targetId "sft-consc-self-verification-limit-001-external-consequence" then throw "Consciousness target identity is invalid"
 return ()
end SFT.Consciousness.SelfVerificationLimitExperiment
