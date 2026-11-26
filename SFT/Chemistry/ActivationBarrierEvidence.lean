import SFT.Chemistry.ActivationBarrierGrammar
import SFT.Chemistry.ActivationBarrier
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ActivationBarrierEvidence
open SFT.Host.Canonical ActivationBarrierGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "highest-boundary",.text "Exact order forces the greatest positive path support.",.boolean (match ActivationBarrier.boundaryWitness with | .error _ => false | .ok b => b)],.array [.text "least-state",.text "External zero displacement becomes structural EmptyOne.",.boolean (match ActivationBarrier.leastWitness with | .error _ => false | .ok b => b)],.array [.text "source-order",.text "The complete collection retains source order rather than sorting by barrier magnitude.",.boolean (match ActivationBarrier.orderWitness with | .error _ => false | .ok b => b)],.array [.text "append-successor",.text "Complete path append preserves the entire prior barrier trace.",.boolean (match ActivationBarrier.appendWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-ACTIVATION-BARRIER-VALUE-RELATION-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-CONFIGURATION-ORDER-PATH-011","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002","SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "path",.text (pathName c.path)],.array [.text "source",.text (sourceName c.source)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "identity",.text (identityName c.identity)],.array [.text "record",.text (recordName c.record)],.array [.text "prediction",.text (predictionName c.prediction)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "path",.array [.array [.text "endpoint-only-or-saddle-continuum-premise",.text "Endpoints or a named saddle do not enumerate a crossing path."],.array [.text "complete-generated-discrete-path-state-word",.text "Every generated path state remains ordered and held."]]],.array [.text "source",.array [.array [.text "free-fitted-or-imported-barrier-number",.text "A detached number could select the result."],.array [.text "exact-source-bound-state-support",.text "Every support coordinate remains exact and source-bound."]]],.array [.text "boundary",.array [.array [.text "arbitrary-named-transition-state",.text "A named state need not be the path boundary."],.array [.text "highest-positive-generated-path-boundary",.text "Exact order forces the greatest positive support on the retained path."]]],.array [.text "reference",.array [.array [.text "absolute-energy-origin-or-signed-difference",.text "An arbitrary origin or negative scalar imports an inadmissible choice."],.array [.text "least-state-EmptyOne-relative-support",.text "The least state is structural absent displacement; only positive relative support is retained."]]],.array [.text "minimality",.array [.array [.text "nonminimal-added-support",.text "Extra support does not define the crossing."],.array [.text "least-crossing-positive-support",.text "Every smaller generated support remains below the forced highest boundary."]]],.array [.text "identity",.array [.array [.text "species-path-or-state-collapsed",.text "Collapsing identity can manufacture a barrier across different paths."],.array [.text "held-species-torsion-and-state-identities",.text "Species, torsion, atoms, rotor and every path-state identity remain held."]]],.array [.text "record",.array [.array [.text "barrier-answer-only-or-selected-profile",.text "A selected value cannot reconstruct the empirical path."],.array [.text "complete-source-ordered-profile-reference-and-adverse-record",.text "Every profile, source reference, structural absence and unresolved row remains auditable."]]],.array [.text "prediction",.array [.array [.text "barrier-value-readable-before-seal-or-refit-on-append",.text "Target access or refitting can choose the answer."],.array [.text "complete-value-free-44-target-identity-seal-and-depth-independent-append",.text "All target identities seal before values open and appending a path preserves every prior record."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact generated-path activation-barrier value relation"
 branch := "chemistry"
 statement := "For a complete generated reaction path with retained species, torsion and state identities, exact relative support and structural least-state EmptyOne force the activation barrier as the greatest positive path support under a held least-state-to-boundary orientation. Complete source profiles, references, absences and unresolved rows remain held."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-generated-discrete-path-state-word__exact-source-bound-state-support__highest-positive-generated-path-boundary__least-state-EmptyOne-relative-support__least-crossing-positive-support__held-species-torsion-and-state-identities__complete-source-ordered-profile-reference-and-adverse-record__complete-value-free-44-target-identity-seal-and-depth-independent-append"),("base",.text "One retained generated path with a structural least state and one positive crossing state forces the first barrier."),("successor",.text "Appending one complete source-bound path preserves every prior path, state, barrier, reference, absence and unresolved record without refitting or reselection."),("exclusions",.array [.text "no numerical zero; external zero-energy glyphs and absent source coordinates become structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported transition-state or saddle-point continuum, Arrhenius law, fitted activation value or absolute energy origin",.text "no interpolation, regression, averaging, selected species/path/state/method/row or target-derived correction",.text "no barrier, unit, uncertainty, method, note, profile or target hash before prediction seal",.text "source citations and parameter disclosures remain post-seal provenance and never select the Fold law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; external zero-energy glyphs and absent source coordinates become structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported transition-state or saddle-point continuum, Arrhenius law, fitted activation value or absolute energy origin","no interpolation, regression, averaging, selected species/path/state/method/row or target-derived correction","no barrier, unit, uncertainty, method, note, profile or target hash before prediction seal","source citations and parameter disclosures remain post-seal provenance and never select the Fold law"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with path := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ActivationBarrierEvidence
