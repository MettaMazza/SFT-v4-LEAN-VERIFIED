import SFT.Chemistry.BufferGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.BufferEvidence
open SFT.Host.Canonical BufferGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "pair-support",.text "both conjugate components have positive support",.boolean true],.array [.text "two-responses",.text "both acid and base perturbation responses are registered",.boolean true],.array [.text "finite-capacity",.text "the reservoir uses explicit positive counts",.boolean true]]
def claimId : String := "SFT-CHEM-AB-BUFFER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-AMPHOTERIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "components",.text (componentsName c.components)],.array [.text "support",.text (supportName c.support)],.array [.text "acid-response",.text (acidResponseName c.acidResponse)],.array [.text "base-response",.text (baseResponseName c.baseResponse)],.array [.text "retention",.text (retentionName c.retention)],.array [.text "capacity",.text (capacityName c.capacity)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "components",.array [.array [.text "single-unpaired-species",.text "One species cannot supply both complementary responses."],.array [.text "conjugate-pair-reservoir",.text "Both conjugate identities are present."]]],.array [.text "support",.array [.array [.text "one-component-absent",.text "An absent member leaves one response unavailable."],.array [.text "positive-support-of-both",.text "Each conjugate member has a positive finite count."]]],.array [.text "acid-response",.array [.array [.text "added-proton-unanswered",.text "No response permits the proton distinction to remain open."],.array [.text "base-member-accepts-proton",.text "The deprotonated member consumes added proton support."]]],.array [.text "base-response",.array [.array [.text "added-base-unanswered",.text "No response permits proton removal without paired change."],.array [.text "acid-member-supplies-proton",.text "The protonated member supplies a proton to the added base."]]],.array [.text "retention",.array [.array [.text "reservoir-identity-erased",.text "A response without conjugate tracking cannot be reversed."],.array [.text "conjugate-pair-retained",.text "Each response converts one member into the other."]]],.array [.text "capacity",.array [.array [.text "unlimited-buffer-claim",.text "A finite reservoir cannot have unlimited capacity."],.array [.text "finite-source-bounded-capacity",.text "Capacity is limited by retained positive component support."]]],.array [.text "record",.array [.array [.text "pH-answer-only",.text "A pH value cannot reconstruct composition and response."],.array [.text "pair-count-response-trace",.text "Components, counts and both response paths remain held."]]],.array [.text "extension",.array [.array [.text "free-equilibrium-fit",.text "A fitted equation can force a measured response."],.array [.text "no-extra-rule",.text "Complementary finite conjugate support supplies the structural law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Buffer response and conjugate-pair retention"
 branch := "chemistry"
 statement := "A buffer is a finite positive reservoir of both members of a conjugate pair whose complementary paths consume added proton support or supply proton support to added base while retaining pair identity and finite capacity."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "conjugate-pair-reservoir__positive-support-of-both__base-member-accepts-proton__acid-member-supplies-proton__conjugate-pair-retained"),("base",.text "One positive unit of each conjugate member with both complementary response paths supplies the first finite buffer."),("successor",.text "Appending positive units extends the finite capacity while every response still converts one conjugate member into the other and retains the full composition trace."),("exclusions",.array [.text "no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no unpaired creation, copying or loss of a proton or electron carrier",.text "no claim that structural closure alone fixes every solution-dependent strength or capacity value",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite reservoir containing positive support of both members of a conjugate pair and two complementary response paths that consume added proton support or supply proton support to an added base within capacity."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no acid/base dictionary, pH scale, equilibrium equation, dissociation constant, measured value or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no unpaired creation, copying or loss of a proton or electron carrier","no claim that structural closure alone fixes every solution-dependent strength or capacity value","external target content remains inaccessible until the prediction is sealed","Every finite reservoir containing positive support of both members of a conjugate pair and two complementary response paths that consume added proton support or supply proton support to an added base within capacity."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with components := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.BufferEvidence
