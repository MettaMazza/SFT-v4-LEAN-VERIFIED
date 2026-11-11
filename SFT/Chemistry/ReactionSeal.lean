import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.ReactionSeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:e9d1d1c9ad3b85bf255ed26366e3b7faca2b13304d8b8902012ce00fd80c2f71"
def payloadHash : String := "sha256:d6086a65f24088d03fba86125405fe384473d645fceea026a0bc0b272d98cdd5"
def predictions : List (String × String × String) := [("SFT-CHEM-RXN-IDENTITY-001","source-bound-transition__complete-reactant-organization__complete-product-organization__all-elemental-carriers-conserved__at-least-one-relation-changed","reactants-transformed-to-products__chemical-identities-change__elemental-carriers-conserved__source-bound-reaction-record"),("SFT-CHEM-RXN-MECHANISM-001","ordered-elementary-step-word__adjacent-state-composition__declared-indivisible-steps__internal-states-held__same-overall-endpoints","overall-reaction-decomposed__ordered-elementary-steps__intermediate-states-retained__step-composition-reproduces-endpoints"),("SFT-CHEM-RXN-INTERMEDIATE-001","named-internal-species__produced-by-one-step__consumed-by-later-step__production-precedes-consumption__cancels-from-net-endpoints","formed-in-one-elementary-step__consumed-in-later-step__absent-from-overall-reaction__retained-in-mechanism-trace"),("SFT-CHEM-KIN-ACTIVATION-001","complete-generated-reaction-path__source-bound-support-account__highest-path-boundary__reactant-relative-support__least-crossing-support","reactants-to-transition-state__minimum-required-energy__barrier-relative-to-reactants__reaction-path-source-bounded"),("SFT-CHEM-KIN-RATE-001","one-registered-reaction-event__positive-completed-event-count__positive-reference-recurrence-count__registered-species-observation-boundary__event-count-per-recurrence","extent-of-reaction-change__per-time-interval__observation-boundary-retained__conditions-and-method-source-bounded"),("SFT-CHEM-KIN-ORDER-001","named-reactant-coordinate__source-bound-coordinate-intervention__complete-rate-response-census__forced-dependency-occurrence-count__empty-dependency-form","rate-law-concentration-dependence__reactant-specific-exponent__experimentally-determined__not-forced-by-stoichiometry"),("SFT-CHEM-EQ-CHEMICAL-001","forward-and-reverse-transitions__persistent-opposed-events__paired-forward-reverse-support__macroscopic-composition-class-recurs__closed-observation-boundary","forward-and-reverse-reactions-continue__rates-equal-at-equilibrium__macroscopic-composition-constant__condition-bound-dynamic-state")]
def objectSize : Value → Nat
 | .object fields => fields.length
 | .text _ | .boolean _ | .integer _ | .null | .array _ => 0

def removeClaimedHash : Value → Value
 | .object fields => .object (fields.filter (fun row => !Text.equal row.1 "sealed_payload_hash"))
 | .text value => .text value
 | .boolean value => .boolean value
 | .integer value => .integer value
 | .null => .null
 | .array value => .array value

def isFalse : Value → Bool
 | .boolean false => true
 | .boolean true | .text _ | .integer _ | .null | .array _ | .object _ => false

def predictionRowsMatch : List Value → List (String × String × String) → Bool
 | [], [] => true
 | row::rest, expected::more => objectSize row == 3 &&
   Text.equal (textField row "claim_id") expected.1 &&
   Text.equal (textField row "exact_result") expected.2.1 &&
   Text.equal (textField row "predicted_observation_label") expected.2.2 && predictionRowsMatch rest more
 | [], _::_ => false
 | _::_, [] => false

def validate (derivationBytes : ByteArray) (sealedRecord : Value) : Except String Unit := do
 if !Text.equal (Text.append "sha256:" (SHA256.digest derivationBytes)) derivationHash then
  throw "reaction/kinetics derivation changed after seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "reaction/kinetics seal invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "reaction/kinetics pre-source boundary invalid"
 if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "reaction/kinetics pre-source boundary invalid"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

end SFT.Chemistry.ReactionSeal
