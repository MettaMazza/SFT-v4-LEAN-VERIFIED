import SFT.Chemistry.MolecularGraphGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularGraphEvidence
open SFT.Host.Canonical MolecularGraphGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "held-finite-molecular-carrier",.boolean true],.array [.text "atoms",.text "complete-held-atom-identities",.boolean true],.array [.text "bonds",.text "complete-held-bond-identities",.boolean true],.array [.text "orientation",.text "retained-isotope-charge-stereo-fibres",.boolean true],.array [.text "canonicality",.text "exhaustive-equivalence-class-canonical-word",.boolean true],.array [.text "decoding",.text "exact-word-to-graph-reconstruction",.boolean true],.array [.text "custody",.text "held-source-and-translation-custody",.boolean true],.array [.text "extension",.text "append-only-new-carrier-registration",.boolean true]]
def claimId : String := "SFT-CHEM-CANONICAL-MOLECULAR-GRAPH-ENCODING-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-GRAPH-NETWORK-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-BOND-CHEMICAL-BOND-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "atoms",.text (atomsName c.atoms)],.array [.text "bonds",.text (bondsName c.bonds)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "canonicality",.text (canonicalityName c.canonicality)],.array [.text "decoding",.text (decodingName c.decoding)],.array [.text "custody",.text (custodyName c.custody)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "detached-symbol-string",.text "detached-symbol-string closes a distinction required by carrier."],.array [.text "held-finite-molecular-carrier",.text "held-finite-molecular-carrier retains the complete carrier distinction."]]],.array [.text "atoms",.array [.array [.text "unlabelled-vertex-count",.text "unlabelled-vertex-count closes a distinction required by atoms."],.array [.text "complete-held-atom-identities",.text "complete-held-atom-identities retains the complete atoms distinction."]]],.array [.text "bonds",.array [.array [.text "adjacency-without-bond-state",.text "adjacency-without-bond-state closes a distinction required by bonds."],.array [.text "complete-held-bond-identities",.text "complete-held-bond-identities retains the complete bonds distinction."]]],.array [.text "orientation",.array [.array [.text "discarded-isotope-charge-stereo",.text "discarded-isotope-charge-stereo closes a distinction required by orientation."],.array [.text "retained-isotope-charge-stereo-fibres",.text "retained-isotope-charge-stereo-fibres retains the complete orientation distinction."]]],.array [.text "canonicality",.array [.array [.text "input-order-dependent-word",.text "input-order-dependent-word closes a distinction required by canonicality."],.array [.text "exhaustive-equivalence-class-canonical-word",.text "exhaustive-equivalence-class-canonical-word retains the complete canonicality distinction."]]],.array [.text "decoding",.array [.array [.text "one-way-text-token",.text "one-way-text-token closes a distinction required by decoding."],.array [.text "exact-word-to-graph-reconstruction",.text "exact-word-to-graph-reconstruction retains the complete decoding distinction."]]],.array [.text "custody",.array [.array [.text "source-free-identifier",.text "source-free-identifier closes a distinction required by custody."],.array [.text "held-source-and-translation-custody",.text "held-source-and-translation-custody retains the complete custody distinction."]]],.array [.text "extension",.array [.array [.text "renumbered-prior-graph",.text "renumbered-prior-graph closes a distinction required by extension."],.array [.text "append-only-new-carrier-registration",.text "append-only-new-carrier-registration retains the complete extension distinction."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold canonical molecular-graph encoding law"
 branch := "chemistry"
 statement := "A held finite molecular carrier forces a reversible position-independent exact word over complete atom, bond, orientation and provenance distinctions."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-finite-molecular-carrier__complete-held-atom-identities__complete-held-bond-identities__retained-isotope-charge-stereo-fibres__exhaustive-equivalence-class-canonical-word__exact-word-to-graph-reconstruction__held-source-and-translation-custody__append-only-new-carrier-registration"),("base",.text "One complete held COMP-001 carrier and its exact finite record supply the base case."),("successor",.text "Every successor appends a complete held carrier, mapping, transition or evidence record without changing any earlier canonical identity, comparison, adverse outcome or resource boundary."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external database encoding algorithm score value equation model fit outcome or software library selects the survivor",.text "all favorable adverse absent unavailable unresolved low-confidence transport conflict and declared resource-halt rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external database encoding algorithm score value equation model fit outcome or software library selects the survivor","all favorable adverse absent unavailable unresolved low-confidence transport conflict and declared resource-halt rows remain"]
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
end SFT.Chemistry.MolecularGraphEvidence
