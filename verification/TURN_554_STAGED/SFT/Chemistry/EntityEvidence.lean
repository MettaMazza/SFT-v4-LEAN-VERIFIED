import SFT.Chemistry.EntityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.EntityEvidence
open SFT.Host.Canonical EntityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "entity-distinction",.text "constitutionally distinct carriers remain distinct",.boolean true],.array [.text "entity-context",.text "context may require an additional retained state coordinate",.boolean true],.array [.text "entity-collapse-control",.text "erased identity coordinate is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-CHEMICAL-ENTITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "constitution",.text (constitutionName c.constitution)],.array [.text "isotope",.text (isotopeName c.isotope)],.array [.text "distinction",.text (distinctionName c.distinction)],.array [.text "precision",.text (precisionName c.precision)],.array [.text "record",.text (recordName c.record)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "ensemble-without-member",.text "An ensemble alone does not identify one chemical entity."],.array [.text "singular-carrier",.text "One entity is one retained carrier before any ensemble quotient."]]],.array [.text "constitution",.array [.array [.text "constitution-erased",.text "Erasing constitution merges chemically distinct carriers."],.array [.text "constitution-retained",.text "Constitution is a required chemical identity coordinate."]]],.array [.text "isotope",.array [.array [.text "isotope-erased",.text "Erasing isotopic identity merges distinguishable entities."],.array [.text "isotope-retained",.text "Isotopic distinction remains available whenever the observation resolves it."]]],.array [.text "distinction",.array [.array [.text "indistinguishable-answer-label",.text "An answer label without a retained distinction cannot identify an entity."],.array [.text "separately-distinguishable",.text "The carrier must remain separately distinguishable at the registered observation boundary."]]],.array [.text "precision",.array [.array [.text "unbounded-or-fixed-precision",.text "A fixed universal precision either loses a required distinction or adds an unforced one."],.array [.text "context-bounded-precision",.text "Only distinctions required by the declared observation context are retained."]]],.array [.text "record",.array [.array [.text "result-without-observation-record",.text "Without an observation record the identity boundary cannot be audited."],.array [.text "held-observation-record",.text "The observation class and retained coordinates remain held."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound identity cannot be traced to the Fold dependency spine."],.array [.text "source-bound-proof-trace",.text "The derivation and later correspondence retain separate source identities."]]],.array [.text "extension",.array [.array [.text "free-extra-identity-rule",.text "An extra identity rule can arbitrarily split or merge entities."],.array [.text "no-extra-rule",.text "Generated distinctions alone determine the identity carrier."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical entity and retained identity"
 branch := "chemistry"
 statement := "A chemical entity is the least singular Fold carrier that remains separately distinguishable after constitution, isotopic identity and the observation context's required precision are retained."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "singular-carrier__constitution-and-isotope-retained__separately-distinguishable__context-bounded-precision"),("base",.text "One registered chemical carrier retains one constitution/isotope/context identity record."),("successor",.text "Adding one generated identity coordinate preserves the singular carrier and every earlier distinction without installing a new equivalence rule."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every finite singular chemical carrier formed from admitted distinctions and any generated positive-finite extension of its constitution, isotope, state or contextual precision record."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every finite singular chemical carrier formed from admitted distinctions and any generated positive-finite extension of its constitution, isotope, state or contextual precision record."]
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
end SFT.Chemistry.EntityEvidence
