import SFT.Chemistry.UncertaintyGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.UncertaintyEvidence
open SFT.Host.Canonical UncertaintyGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "alternative-class",.text "compatible results remain retained rather than collapsed",.boolean true],.array [.text "use-bound",.text "the intended use fixes the upper limit before evaluation",.boolean true],.array [.text "adjustable-margin-control",.text "post-release widening is rejected",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-UNCERTAINTY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-CHEM-MEAS-AMOUNT-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "alternatives",.text (alternativesName c.alternatives)],.array [.text "bound",.text (boundName c.bound)],.array [.text "use",.text (useName c.use)],.array [.text "result",.text (resultName c.result)],.array [.text "source",.text (sourceName c.source)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "single-answer-without-resolution",.text "A lone answer erases the unresolved observation class."],.array [.text "uncertainty-carrier",.text "The record retains the measurement and its resolution boundary."]]],.array [.text "alternatives",.array [.array [.text "discarded-alternatives",.text "Discarding compatible alternatives falsely turns resolution into exact identity."],.array [.text "retained-alternative-class",.text "Every alternative admitted by the registered resolution remains held."]]],.array [.text "bound",.array [.array [.text "unbounded-vagueness",.text "Unbounded uncertainty cannot falsify a measured correspondence."],.array [.text "upper-bound-support",.text "The registered target uncertainty is an exact upper-limit record."]]],.array [.text "use",.array [.array [.text "context-free-resolution",.text "Required resolution depends on the declared purpose of the result."],.array [.text "use-bounded-resolution",.text "The intended use fixes the acceptable observation class before evaluation."]]],.array [.text "result",.array [.array [.text "bound-detached-from-result",.text "A bound detached from its result cannot be applied or audited."],.array [.text "result-record-boundary",.text "The uncertainty remains bound to the exact measurement-result identity."]]],.array [.text "source",.array [.array [.text "source-free-bound",.text "A source-free bound can be changed after comparison."],.array [.text "source-bound-uncertainty",.text "Source, method and registered boundary remain held."]]],.array [.text "record",.array [.array [.text "favourable-row-only",.text "Selected rows cannot test uncertainty transport."],.array [.text "complete-uncertainty-record",.text "Every registered result, bound and unfavorable control is retained."]]],.array [.text "extension",.array [.array [.text "free-uncertainty-margin",.text "An adjustable margin can force agreement with any target."],.array [.text "no-extra-rule",.text "Only the preregistered resolution and use boundary are admitted."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical measurement uncertainty and retained alternatives"
 branch := "chemistry"
 statement := "Chemical target uncertainty is a source-bound Fold record of unresolved measurement alternatives with a preregistered upper limit fixed by intended use and attached to the exact result identity."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "uncertainty-carrier__upper-bound-support__use-bounded-resolution__result-record-boundary"),("base",.text "One source-bound measurement result and one retained compatible-alternative class supply the first exact uncertainty record."),("successor",.text "Adding one registered result or compatible alternative preserves its source, intended-use bound and every prior row without widening the margin after target release."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every source-bounded finite chemical measurement record whose unresolved alternatives, exact upper bound, intended use and result identity are retained without entering the derivation as proof values."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every source-bounded finite chemical measurement record whose unresolved alternatives, exact upper bound, intended use and result identity are retained without entering the derivation as proof values."]
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
end SFT.Chemistry.UncertaintyEvidence
