import SFT.Biology.BioSpecimenSource
import SFT.Biology.BioSpecimenEvidence
import SFT.Biology.LifeOrganizationSeal
import SFT.Physics.MolecularSpectroscopyMeasurement
namespace SFT.Biology.BioSpecimenExperiment
open SFT.Host SFT.Host.Canonical
def claimId : String := "SFT-BIO-BIO-SPECIMEN-001"
def experimentId : String := "SFT-EXP-BIO-BIO-SPECIMEN-001-E1"
def targetId : String := "sft-bio-bio-specimen-001-authority-correspondence"
def expectedLabel : String := "biology:source-bound-biological-part__specimen-to-source-provenance__collection-preservation-and-subselection-held__representativeness-declared"
def falsification : String := "Reject if any registered authoritative biological source contradicts a required content relation, if a generated alternative also preserves every dimension, or if any specimen, control, adverse row, condition or provenance distinction is missing."
def exactResult : String := "source-bound-biological-part__specimen-to-source-provenance__collection-preservation-and-subselection-held__representativeness-declared__complete-state-transition-control-record__root-bound-forward-forcing__positive-finite-successor-and-adverse-closure__no-extra-rule"
def sourceIds : List String := ["SFT-BIO-SRC-GO-ANNOTATION-EVIDENCE","SFT-BIO-SRC-GBIF-DARWIN-CORE-ARCHIVE"]
def predictionDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-BIO-BIO-SPECIMEN-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "biology-observation",.text "biology:source-bound-biological-part__specimen-to-source-provenance__collection-preservation-and-subselection-held__representativeness-declared"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]
def programFields : List (String × Value) := match predictionDocument with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def registration (preSourceSeal : String) : Value := .object [("experiment_id",.text "SFT-EXP-BIO-BIO-SPECIMEN-001-E1"),("claim_id",.text "SFT-BIO-BIO-SPECIMEN-001"),("frozen_relation",.text "source-bound-biological-part__specimen-to-source-provenance__collection-preservation-and-subselection-held__representativeness-declared__complete-state-transition-control-record__root-bound-forward-forcing__positive-finite-successor-and-adverse-closure__no-extra-rule"),("target_id",.text "sft-bio-bio-specimen-001-authority-correspondence"),("source_references",.array [.array [.text "SFT-BIO-SRC-GO-ANNOTATION-EVIDENCE",.text "https://geneontology.org/docs/go-annotations/",.text "experiments/external_sources/biology/snapshots/sft-bio-src-go-annotation-evidence.html",.text "sha256:b16235ab261f6b02afa71826546aad87823680ff267e0bd1c433d54c838b7ebd"],.array [.text "SFT-BIO-SRC-GBIF-DARWIN-CORE-ARCHIVE",.text "https://ipt.gbif.org/manual/en/ipt/latest/dwca-guide",.text "experiments/external_sources/biology/snapshots/sft-bio-src-gbif-darwin-core-archive.html",.text "sha256:89adbe8ba230fd51495154e86843e624d2805d632bc17e55136e88f85c7cad1f"]]),("required_fragments",.array [.array [.text "SFT-BIO-SRC-GO-ANNOTATION-EVIDENCE",.text "evidence code"],.array [.text "SFT-BIO-SRC-GBIF-DARWIN-CORE-ARCHIVE",.text "protocols"]]),("pre_source_seal_path",.text "experiments/sealed_predictions/biology_foundation_complete_pre_source.json"),("pre_source_seal_hash",.text preSourceSeal),("prediction_program",.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text "SFT-EXP-BIO-BIO-SPECIMEN-001-E1-prediction"),("instructions",.array [.object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],.object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "biology-observation",.text "biology:source-bound-biological-part__specimen-to-source-provenance__collection-preservation-and-subselection-held__representativeness-declared"])],.object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],.object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]])]),("expected_observation_label",.text "biology:source-bound-biological-part__specimen-to-source-provenance__collection-preservation-and-subselection-held__representativeness-declared"),("falsification_condition",.text "Reject if any registered authoritative biological source contradicts a required content relation, if a generated alternative also preserves every dimension, or if any specimen, control, adverse row, condition or provenance distinction is missing."),("all_source_rows_required",.boolean true),("source_content_absent_until_after_complete_branch_seal",.boolean true),("target_inaccessible_before_prediction_seal",.boolean true),("failed_source_transports_and_content_responses_preserved",.boolean true)]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registrationHash)]
def dimensions : List (String × List (String × Bool)) := [("carrier",[("carrier-erased-or-answer-only",false),("source-bound-biological-part",true)]),("relation",[("relation-imported-fitted-or-erased",false),("specimen-to-source-provenance",true)]),("organization",[("organization-collapsed",false),("collection-preservation-and-subselection-held",true)]),("observation",[("observation-boundary-unrecorded",false),("representativeness-declared",true)]),("record",[("result-without-transition-record",false),("complete-state-transition-control-record",true)]),("provenance",[("authority-target-or-prior-selected-law",false),("root-bound-forward-forcing",true)]),("generality",[("single-specimen-favorable-instance",false),("positive-finite-successor-and-adverse-closure",true)]),("extension",[("free-fit-exception-or-extra-rule",false),("no-extra-rule",true)])]
def witnesses : List Bool := [BioSpecimen.carrierWitness,BioSpecimen.relationWitness,BioSpecimen.boundaryWitness]
def admittedName (d : String × List (String × Bool)) : Except String String :=
 match d.2.filter Prod.snd with
 | [(name,_)] => .ok name
 | [] | _::_::_ => .error (Text.intercalate "" ["dimension ",d.1," requires one preserving form"])
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-BIO-").isPrefixOf (Text.chars claimId) || !(Text.chars "SFT-EXP-BIO-").isPrefixOf (Text.chars experimentId) then
  throw "invalid Biology identity"
 if dimensions.length != 8 || !(BioSpecimenSource.distinctIds (dimensions.map Prod.fst)) then
  throw "Biology blueprint requires eight distinct dimensions"
 if !(dimensions.all (fun d => d.2.length==2)) then throw "each Biology dimension must exhaust two registered forms"
 let names ← dimensions.mapM admittedName
 if !Text.equal exactResult (Text.intercalate "__" names) then throw "Biology exact result is not the unique preservation survivor"
 if BioSpecimenEvidence.dependencies.isEmpty || !(BioSpecimenSource.distinctIds BioSpecimenEvidence.dependencies) then
  throw "Biology dependencies are empty or repeated"
 if !(witnesses.all id) then throw "Biology operational witness failed"
 let expected := (BioSpecimenSource.requirements.map LifeOrganizationSource.Requirement.sourceId).foldl
  (fun acc value => if acc.any (Text.equal value) then acc else acc++[value]) []
 if sourceIds.isEmpty || !(Text.equal (Canonical.render (.array (sourceIds.map Value.text))) (Canonical.render (.array (expected.map Value.text)))) then
  throw "Biology source identities differ from the registered binding"
 if !Text.equal targetId "sft-bio-bio-specimen-001-authority-correspondence" then throw "Biology target identity is invalid"
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
end SFT.Biology.BioSpecimenExperiment
