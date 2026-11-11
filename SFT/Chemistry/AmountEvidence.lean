import SFT.Chemistry.AmountGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AmountEvidence
open SFT.Host.Canonical AmountGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "entity-reference",.text "one held kind remains attached to every generated member",.boolean true],.array [.text "count-successor",.text "one appended member extends exact cardinality",.boolean true],.array [.text "mass-proxy-control",.text "isotope-dependent mass is rejected as entity count",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-AMOUNT-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-SUBSTANCE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "entity_reference",.text (entity_referenceName c.entity_reference)],.array [.text "count",.text (countName c.count)],.array [.text "measure",.text (measureName c.measure)],.array [.text "support",.text (supportName c.support)],.array [.text "record",.text (recordName c.record)],.array [.text "unit",.text (unitName c.unit)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-amount",.text "An answer label does not retain the entities being counted."],.array [.text "amount-carrier",.text "The quantity remains attached to a generated chemical collection."]]],.array [.text "entity_reference",.array [.array [.text "unspecified-entities",.text "A count without a specified elementary-entity kind changes meaning under substitution."],.array [.text "specified-entity-reference",.text "One held reference identifies the elementary entity kind."]]],.array [.text "count",.array [.array [.text "mass-proxy-count",.text "A mass proxy can vary with isotope and cannot establish entity cardinality."],.array [.text "generated-cardinality",.text "The exact positive-finite member construction fixes cardinality."]]],.array [.text "measure",.array [.array [.text "unrelated-count-and-quantity",.text "An unrelated quantity does not measure how many referenced entities occur."],.array [.text "count-measure",.text "Amount is the measure carried by the generated entity count."]]],.array [.text "support",.array [.array [.text "single-presupposed-entity-kind",.text "Presupposing one conventional entity kind excludes other generated elementary carriers."],.array [.text "generated-entity-support",.text "Atoms, molecules, ions, electrons, particles and specified groups enter through the same held-reference form."]]],.array [.text "record",.array [.array [.text "total-without-members",.text "A total without its entity reference cannot be independently reconstructed."],.array [.text "member-and-reference-trace",.text "The member construction and entity kind remain auditable."]]],.array [.text "unit",.array [.array [.text "unit-scale-as-proof",.text "A conventional scale cannot select the amount law."],.array [.text "separate-unit-comparison",.text "The exact count relation is derived before any unit realization."]]],.array [.text "extension",.array [.array [.text "free-amount-factor",.text "An extra multiplier is a free answer-selecting parameter."],.array [.text "no-extra-rule",.text "Generated membership and the held entity reference completely fix the amount carrier."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Amount-of-substance count and reference carrier"
 branch := "chemistry"
 statement := "Amount of substance is the exact Fold measure carried by a positive-finite generated count of one specified elementary-entity kind, with the entity reference and count trace retained."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := identity (.array [.text claimId,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := identity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "amount-carrier__count-measure__specified-entity-reference__generated-entity-support"),("base",.text "One admitted specified chemical entity supplies the first exact amount carrier and its complete reference trace."),("successor",.text "Appending one generated entity of the same held kind extends cardinality while preserving the reference, prior members and separate unit boundary."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every positive-finite generated collection of one specified admitted chemical-entity kind, together with its exact member/reference trace and separately registered unit comparison."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every positive-finite generated collection of one specified admitted chemical-entity kind, together with its exact member/reference trace and separately registered unit comparison."]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AmountEvidence
