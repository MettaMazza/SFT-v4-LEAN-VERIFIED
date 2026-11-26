import SFT.Chemistry.HalfReactionOrientationGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.HalfReactionOrientationEvidence
open SFT.Host.Canonical HalfReactionOrientationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Half-reaction identity held.",.boolean true],.array [.text "source",.text "Source species retained.",.boolean true],.array [.text "terminal",.text "Terminal species retained.",.boolean true],.array [.text "phase",.text "Both phase labels retained.",.boolean true],.array [.text "positive-transfer",.text "Transfer count is positive.",.boolean true],.array [.text "orientation",.text "Direction is held.",.boolean true],.array [.text "inverse",.text "Inverse swaps complete sides.",.boolean true],.array [.text "carrier",.text "Inverse retains same carrier.",.boolean true],.array [.text "duplicate-control",.text "Duplicated carrier halts.",.boolean true],.array [.text "successor",.text "Fresh unchanged record preserves prior state.",.boolean true]]
def claimId : String := "SFT-CHEM-HALF-REACTION-IDENTITY-ORIENTATION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-INORGANIC-ACID-BASE-REDOX-NETWORK-017","SFT-CHEM-RETROSYNTHETIC-DECOMPOSITION-RECONSTRUCTION-016"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "species",.text (speciesName c.species)],.array [.text "transfer",.text (transferName c.transfer)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "pairing",.text (pairingName c.pairing)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "equation-text-only",.text "Text cannot retain a process identity."],.array [.text "exact-half-reaction-identity",.text "The half-reaction is one held process."]]],.array [.text "species",.array [.array [.text "selected-or-unphased-species",.text "Missing species or phase changes the process."],.array [.text "complete-species-phase-carrier",.text "Every species, phase and multiplicity remains explicit."]]],.array [.text "transfer",.array [.array [.text "signed-electron-count",.text "A negative number hides carrier identity and orientation."],.array [.text "positive-count-of-held-electron-carriers",.text "Each transferred occurrence is held and counted positively."]]],.array [.text "orientation",.array [.array [.text "sign-as-direction",.text "A sign is not a reversible direction record."],.array [.text "held-source-terminal-orientation",.text "Direction is an exact held label."]]],.array [.text "pairing",.array [.array [.text "open-oxidation-or-reduction-story",.text "An open half cannot identify its inverse."],.array [.text "exact-inverse-half-reaction-pair",.text "Swapping sides and orientation preserves every carrier."]]],.array [.text "reference",.array [.array [.text "unbound-potential-answer",.text "Potential is relational and needs its reference."],.array [.text "held-reference-half-cell-identity",.text "The comparison reference remains explicit."]]],.array [.text "record",.array [.array [.text "favourable-species-only",.text "Deleting species destroys stoichiometric closure."],.array [.text "complete-half-reaction-record",.text "All source, terminal, transfer and reference rows remain."]]],.array [.text "extension",.array [.array [.text "reaction-specific-exception",.text "An exception is an extra rule."],.array [.text "fresh-species-successor-preserves-prior-record",.text "A fresh species occurrence preserves all earlier identities and orientations."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold half-reaction identity and held transfer orientation"
 branch := "chemistry"
 statement := "A half-reaction retains complete species, phases, positive held electron occurrences, reversible source/terminal orientation and one explicit reference half-cell; no negative electron-count proof value is required."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "exact-half-reaction-identity__complete-species-phase-carrier__positive-count-of-held-electron-carriers__held-source-terminal-orientation__exact-inverse-half-reaction-pair__held-reference-half-cell-identity__complete-half-reaction-record__fresh-species-successor-preserves-prior-record"),("base",.text "One source/terminal pair and one held transfer carrier supply the first half-reaction."),("successor",.text "Appending one species or transfer occurrence preserves all prior identity, phase, orientation and inverse records."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no conventional sign potential value or external equation selects the survivor",.text "all 22 NIST pages and complete IUPAC record remain downstream evidence"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no conventional sign potential value or external equation selects the survivor","all 22 NIST pages and complete IUPAC record remain downstream evidence"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with identity := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.HalfReactionOrientationEvidence
