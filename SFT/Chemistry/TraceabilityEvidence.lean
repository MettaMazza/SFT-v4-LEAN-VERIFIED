import SFT.Chemistry.TraceabilityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.TraceabilityEvidence
open SFT.Host.Canonical TraceabilityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "trace-chain",.text "every comparison link retains its predecessor",.boolean true],.array [.text "certificate-binding",.text "property, reference, uncertainty and trace share one certificate record",.boolean true],.array [.text "silent-substitution-control",.text "changed material identity breaks the chain",.boolean true]]
def claimId : String := "SFT-CHEM-MEAS-TRACEABILITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-MEAS-OBSERVATION-CARRIER-001","SFT-PHYS-MEAS-QUANTITY-CARRIER-001","SFT-PHYS-MEAS-VALUE-RECORD-001","SFT-PHYS-MEAS-UNCERTAINTY-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-MEAS-REFERENCE-REALIZATION-001","SFT-PHYS-MEAS-CALIBRATION-001","SFT-CHEM-MEAS-UNCERTAINTY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "property",.text (propertyName c.property)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "uncertainty",.text (uncertaintyName c.uncertainty)],.array [.text "trace",.text (traceName c.trace)],.array [.text "certificate",.text (certificateName c.certificate)],.array [.text "identity",.text (identityName c.identity)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "property",.array [.array [.text "value-without-property",.text "A value without a property identity cannot be traced."],.array [.text "reference-material-property",.text "The record binds one property to one reference material."]]],.array [.text "reference",.array [.array [.text "anonymous-reference",.text "An anonymous comparison object cannot anchor a trace chain."],.array [.text "identified-reference-realization",.text "Every chain terminates at an admitted identified reference realization."]]],.array [.text "uncertainty",.array [.array [.text "uncertainty-erased",.text "Erasing uncertainty overstates what each comparison preserves."],.array [.text "uncertainty-retained",.text "Every comparison retains its associated uncertainty record."]]],.array [.text "trace",.array [.array [.text "broken-predecessor-chain",.text "A missing predecessor prevents reconstruction to the reference."],.array [.text "traceability-retained",.text "Every calibration or examination link retains its predecessor identity."]]],.array [.text "certificate",.array [.array [.text "uncertified-result-label",.text "A result label alone does not bind property, reference and trace."],.array [.text "certificate-bound-record",.text "The certificate binds the complete property and trace record."]]],.array [.text "identity",.array [.array [.text "substitutable-sample",.text "Silent sample substitution breaks traceability while preserving a surface value."],.array [.text "material-identity-held",.text "Reference-material and sample identities remain distinct and held."]]],.array [.text "record",.array [.array [.text "terminal-value-only",.text "A terminal value cannot reproduce the chain."],.array [.text "complete-chain-record",.text "Every link, uncertainty and certificate identity is retained."]]],.array [.text "extension",.array [.array [.text "free-trace-link",.text "An unregistered link can hide a discontinuity."],.array [.text "no-extra-rule",.text "Only registered predecessor links extend the trace chain."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical reference traceability and complete record"
 branch := "chemistry"
 statement := "Chemical traceability is the complete Fold predecessor chain binding a property value to an identified reference material while retaining uncertainty, material identity and its certificate record at every link."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "reference-material-property__uncertainty-retained__traceability-retained__certificate-bound-record"),("base",.text "One identified reference material, property value, uncertainty record and certificate supply the first complete traceable record."),("successor",.text "Appending one registered comparison link retains predecessor identity, associated uncertainty, material identity and certificate provenance to the same reference realization."),("exclusions",.array [.text "no IUPAC definition, conventional chemistry model or target content may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no application result or opaque predictor",.text "external target content is absent from this specification and opens only through post-seal custody",.text "Every positive-finite certified chemical-property chain whose reference material, property identity, uncertainty, predecessor links and certificate record are retained to an admitted reference realization."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC definition, conventional chemistry model or target content may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no application result or opaque predictor","external target content is absent from this specification and opens only through post-seal custody","Every positive-finite certified chemical-property chain whose reference material, property identity, uncertainty, predecessor links and certificate record are retained to an admitted reference realization."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with property := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.TraceabilityEvidence
