import SFT.Biology.LifeOrganizationEvidence
import SFT.Biology.LifeOrganizationSeal
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Biology.LifeOrganizationExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-BIO-LIFE-ORGANIZATION-001"
def experimentId : String := "SFT-EXP-BIO-LIFE-ORGANIZATION-001-E1"
def targetId : String := "sft-bio-life-organization-001-authority-correspondence"
def expectedLabel : String := "biology:bounded-process-carrier__self-maintaining-transition-relation__identity-through-turnover__viability-window-declared"
def falsification : String := "Reject if any registered authoritative biological source contradicts a required content relation, if a generated alternative also preserves every dimension, or if any specimen, control, adverse row, condition or provenance distinction is missing."
def exactResult : String := "bounded-process-carrier__self-maintaining-transition-relation__identity-through-turnover__viability-window-declared__complete-state-transition-control-record__root-bound-forward-forcing__positive-finite-successor-and-adverse-closure__no-extra-rule"
def sourceIds : List String := ["SFT-BIO-SRC-NASEM-UNITY-BIOLOGY-2010","SFT-BIO-SRC-NCBI-CELL-ORIGIN-METABOLISM"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-BIO-LIFE-ORGANIZATION-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "biology-observation",.text "biology:bounded-process-carrier__self-maintaining-transition-relation__identity-through-turnover__viability-window-declared"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def registration (preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-BIO-LIFE-ORGANIZATION-001-E1"),("claim_id",.text "SFT-BIO-LIFE-ORGANIZATION-001"),("frozen_relation",.text "bounded-process-carrier__self-maintaining-transition-relation__identity-through-turnover__viability-window-declared__complete-state-transition-control-record__root-bound-forward-forcing__positive-finite-successor-and-adverse-closure__no-extra-rule"),("target_id",.text "sft-bio-life-organization-001-authority-correspondence"),("source_references",.array [.array [.text "SFT-BIO-SRC-NASEM-UNITY-BIOLOGY-2010",.text "https://www.ncbi.nlm.nih.gov/books/NBK32506/?report=printable",.text "experiments/external_sources/biology/snapshots/sft-bio-src-nasem-unity-biology-2010.html",.text "sha256:62b53a959de8aa5b377997063a3a2719a87ff029a99f36225a383c7a4cfad9e6"],.array [.text "SFT-BIO-SRC-NCBI-CELL-ORIGIN-METABOLISM",.text "https://www.ncbi.nlm.nih.gov/books/NBK9841/?report=printable",.text "experiments/external_sources/biology/snapshots/sft-bio-src-ncbi-cell-origin-metabolism.html",.text "sha256:ce64ef3e815f9a4f14dc6938e708f449bfd3a39de108c317aac8a941bff68b6b"]]),("required_fragments",.array [.array [.text "SFT-BIO-SRC-NASEM-UNITY-BIOLOGY-2010",.text "cell is the smallest independent unit of life"],.array [.text "SFT-BIO-SRC-NCBI-CELL-ORIGIN-METABOLISM",.text "metabolic energy"]]),("pre_source_seal_path",.text "experiments/sealed_predictions/biology_foundation_complete_pre_source.json"),("pre_source_seal_hash",.text preSourceSeal),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-BIO-LIFE-ORGANIZATION-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "biology-observation",.text "biology:bounded-process-carrier__self-maintaining-transition-relation__identity-through-turnover__viability-window-declared"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("expected_observation_label",.text "biology:bounded-process-carrier__self-maintaining-transition-relation__identity-through-turnover__viability-window-declared"),("falsification_condition",.text "Reject if any registered authoritative biological source contradicts a required content relation, if a generated alternative also preserves every dimension, or if any specimen, control, adverse row, condition or provenance distinction is missing."),("all_source_rows_required",.boolean true),("source_content_absent_until_after_complete_branch_seal",.boolean true),("target_inaccessible_before_prediction_seal",.boolean true),("failed_source_transports_and_content_responses_preserved",.boolean true)]
def labelValue (family label : String) : Value := .object [("type",.text "HeldLabel"),("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-erased-or-answer-only",false),("bounded-process-carrier",true)]),("relation",[("relation-imported-fitted-or-erased",false),("self-maintaining-transition-relation",true)]),("organization",[("organization-collapsed",false),("identity-through-turnover",true)]),("observation",[("observation-boundary-unrecorded",false),("viability-window-declared",true)]),("record",[("result-without-transition-record",false),("complete-state-transition-control-record",true)]),("provenance",[("authority-target-or-prior-selected-law",false),("root-bound-forward-forcing",true)]),("generality",[("single-specimen-favorable-instance",false),("positive-finite-successor-and-adverse-closure",true)]),("extension",[("free-fit-exception-or-extra-rule",false),("no-extra-rule",true)])]
def witnesses : List Bool := [LifeOrganization.carrierWitness,LifeOrganization.relationWitness,LifeOrganization.boundaryWitness]
def admittedName (d : String × List (String × Bool)) : Except String String :=
 match d.2.filter Prod.snd with
 | [(name,_)] => .ok name
 | [] | _::_::_ => .error (Text.intercalate "" ["dimension ",d.1," requires one preserving form"])
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-BIO-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-BIO-").isPrefixOf (Text.chars experimentId) then
  throw "invalid Biology identity"
 if dimensions.length != 8 || !(LifeOrganizationSource.distinctIds (dimensions.map Prod.fst)) then
  throw "Biology blueprint requires eight distinct dimensions"
 if !(dimensions.all (fun d => d.2.length==2)) then throw "each Biology dimension must exhaust two registered forms"
 let names ← dimensions.mapM admittedName
 if !Text.equal exactResult (Text.intercalate "__" names) then throw "Biology exact result is not the unique preservation survivor"
 if LifeOrganizationEvidence.dependencies.isEmpty || !(LifeOrganizationSource.distinctIds LifeOrganizationEvidence.dependencies) then
  throw "Biology dependencies are empty or repeated"
 if !(witnesses.all id) then throw "Biology operational witness failed"
 let expected := (LifeOrganizationSource.requirements.map LifeOrganizationSource.Requirement.sourceId).foldl
  (fun acc value => if acc.any (Text.equal value) then acc else acc++[value]) []
 if sourceIds.isEmpty || !(Text.equal (Canonical.render (.array (sourceIds.map Value.text))) (Canonical.render (.array (expected.map Value.text)))) then
  throw "Biology source identities differ from the registered binding"
 if !Text.equal targetId "sft-bio-life-organization-001-authority-correspondence" then throw "Biology target identity is invalid"
 return ()
#print axioms claimId
#print axioms experimentId
#print axioms targetId
#print axioms expectedLabel
#print axioms falsification
#print axioms exactResult
#print axioms sourceIds
#print axioms predictionDocument
#print axioms programFields
#print axioms registration
#print axioms labelValue
#print axioms envelope
#print axioms dimensions
#print axioms witnesses
#print axioms admittedName
#print axioms validateSpec
end SFT.Biology.LifeOrganizationExperiment
