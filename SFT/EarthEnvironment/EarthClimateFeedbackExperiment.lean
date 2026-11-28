import SFT.EarthEnvironment.EarthClimateFeedbackEvidence
import SFT.EarthEnvironment.Source
import SFT.Biology.LifeOrganizationSource
namespace SFT.EarthEnvironment.EarthClimateFeedbackExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-EARTH-CLIMATE-FEEDBACK-001"
def experimentId : String := "SFT-EXP-EARTH-CLIMATE-FEEDBACK-001-E1"
def targetId : String := "sft-earth-climate-feedback-001-external-earth-evidence"
def expectedLabel : String := "earth:state-response-return-path-carrier__response-modifies-driver-or-budget-relation__sign-as-orientation-gain-path-delay-and-boundaries-held__process-timescale-bounded"
def falsification : String := "Reject if correlation substitutes for a closed path or if the feedback magnitude is fitted from the same target used to validate it."
def exactResult : String := "state-response-return-path-carrier__process-timescale-bounded__response-modifies-driver-or-budget-relation__sign-as-orientation-gain-path-delay-and-boundaries-held__evidence-class-explicit__root-bound-forward-forcing__positive-finite-successor-retains-all-rows__no-extra-rule"
def sourceIds : List String := ["NOAA-GHCND-001", "NASA-CERES-EBAF-001", "NOAA-GML-CO2-001", "NSIDC-SEA-ICE-INDEX-001", "NOAA-PALEO-001"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-EARTH-CLIMATE-FEEDBACK-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "earth-external-consequence",.text "earth:state-response-return-path-carrier__response-modifies-driver-or-budget-relation__sign-as-orientation-gain-path-delay-and-boundaries-held__process-timescale-bounded"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def requiredField (row : Value) (key : String) : Except String Value :=
 if SFT.Materials.MaterialSource.hasField row key then .ok (SFT.Materials.MaterialSource.field row key)
 else .error (Text.intercalate "" ["'",key,"'"])
def registration (row : Value) (extractionHash preSourceSeal : String) : Except String Value := do
 let sourceEvidence ← requiredField row "source_evidence"
 let numeric ← requiredField row "numeric_comparison"
 return .object [("experiment_id",.text "SFT-EXP-EARTH-CLIMATE-FEEDBACK-001-E1"),("claim_id",.text "SFT-EARTH-CLIMATE-FEEDBACK-001"),("frozen_structural_relation",.text "state-response-return-path-carrier__process-timescale-bounded__response-modifies-driver-or-budget-relation__sign-as-orientation-gain-path-delay-and-boundaries-held__evidence-class-explicit__root-bound-forward-forcing__positive-finite-successor-retains-all-rows__no-extra-rule"),("complete_branch_pre_source_seal",.text preSourceSeal),("target_id",.text "sft-earth-climate-feedback-001-external-earth-evidence"),("source_ids",.array [.text "NOAA-GHCND-001",.text "NASA-CERES-EBAF-001",.text "NOAA-GML-CO2-001",.text "NSIDC-SEA-ICE-INDEX-001",.text "NOAA-PALEO-001"]),("expected_external_consequence",.text "earth:state-response-return-path-carrier__response-modifies-driver-or-budget-relation__sign-as-orientation-gain-path-delay-and-boundaries-held__process-timescale-bounded"),("directness",.text "authoritative_observation_or_primary_measurement_boundary_correspondence"),("empirical_disposition",.text "purpose_matched_authoritative_source_features_present"),("target_row_hash",.text extractionHash),("source_evidence",sourceEvidence),("numeric_comparison",numeric),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-EARTH-CLIMATE-FEEDBACK-001-E1-external-consequence-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "earth-external-consequence",.text "earth:state-response-return-path-carrier__response-modifies-driver-or-budget-relation__sign-as-orientation-gain-path-delay-and-boundaries-held__process-timescale-bounded"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("falsification_condition",.text "Reject if correlation substitutes for a closed path or if the feedback magnitude is fitted from the same target used to validate it."),("all_adverse_absent_failed_and_unresolved_rows_required",.boolean true),("target_inaccessible_before_claim_derivation_seal",.boolean true),("external_evidence_cannot_select_structural_survivor",.boolean true)]
def experimentRegistration (sealValue audit targets bindings first holdout : Value)
 (files : List Source.Snapshot) : Except String Value := do
 let (row,extraction) ← Source.targetRow claimId targetId expectedLabel audit targets bindings first holdout files
 let preSeal ← Source.validatePreSourceSeal sealValue files
 registration row extraction preSeal
def dimensions : List (String × List (String × Bool)) := [("carrier",[("answer-only-or-unbounded-carrier",false),("state-response-return-path-carrier",true)]),("boundary",[("boundary-or-interface-erased",false),("process-timescale-bounded",true)]),("relation",[("imported-fitted-or-missing-relation",false),("response-modifies-driver-or-budget-relation",true)]),("record",[("favourable-output-with-incomplete-record",false),("sign-as-orientation-gain-path-delay-and-boundaries-held",true)]),("evidence",[("model-proxy-forecast-or-observation-conflated",false),("evidence-class-explicit",true)]),("provenance",[("prior-target-consensus-or-application-selected",false),("root-bound-forward-forcing",true)]),("generality",[("one-favourable-case-with-erased-alternatives",false),("positive-finite-successor-retains-all-rows",true)]),("extension",[("free-parameter-exception-or-opaque-oracle",false),("no-extra-rule",true)])]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-EARTH-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-EARTH-").isPrefixOf (Text.chars experimentId) then throw "Earth claim identity is invalid"
 if EarthClimateFeedbackEvidence.dependencies.isEmpty || dimensions.length != 8 then throw "Earth claim lacks dependencies or eight dimensions"
 if !(SFT.Biology.LifeOrganizationSource.distinctIds (dimensions.map Prod.fst)) then throw "Earth dimensions repeat"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "an Earth dimension must have two exhaustive registered forms"
  if !(SFT.Biology.LifeOrganizationSource.distinctIds (d.2.map Prod.fst)) then throw "an Earth dimension repeats a form"
  if (d.2.filter Prod.snd).length != 1 then throw "an Earth dimension must have exactly one structurally preserving form"
  pure ()
 if !([EarthClimateFeedback.carrierWitness,EarthClimateFeedback.relationWitness,EarthClimateFeedback.boundaryWitness,EarthClimateFeedback.exactFoldWitness].all id) then throw "an Earth operational witness failed"
 let survivors := EarthClimateFeedbackGrammar.candidates.filter (fun c => EarthClimateFeedbackGrammar.candidatePreserves EarthClimateFeedbackGrammar.requiredProperties (EarthClimateFeedbackGrammar.sourceProperties c))
 let survivor ← match survivors with
  | [c] => pure c
  | [] | _::_::_ => throw "Earth grammar did not produce one unique preserving form"
 if !Text.equal exactResult (EarthClimateFeedbackGrammar.candidateId survivor) then throw "the registered Earth result differs from the independently filtered preserving form"
 if !Text.equal targetId "sft-earth-climate-feedback-001-external-earth-evidence" || !Text.equal (render (.array (sourceIds.map Value.text))) (render (.array [.text "NOAA-GHCND-001",.text "NASA-CERES-EBAF-001",.text "NOAA-GML-CO2-001",.text "NSIDC-SEA-ICE-INDEX-001",.text "NOAA-PALEO-001"])) then throw "Earth external identity changed"
 if !Text.equal expectedLabel "earth:state-response-return-path-carrier__response-modifies-driver-or-budget-relation__sign-as-orientation-gain-path-delay-and-boundaries-held__process-timescale-bounded" then throw "Earth external consequence changed"
 if dimensions.length != 8 || !(dimensions.all (fun d => d.2.length == 2)) then throw "Earth adapter does not preserve the frozen grammar"
 return ()
end SFT.EarthEnvironment.EarthClimateFeedbackExperiment
