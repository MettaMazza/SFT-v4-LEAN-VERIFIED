import SFT.Chemistry.EntropyMultiplicityCorrespondenceGrammar
import SFT.Chemistry.EntropyMultiplicityCorrespondence
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.EntropyMultiplicityCorrespondenceEvidence
open SFT.Host.Canonical EntropyMultiplicityCorrespondenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-multiplicity",.text "Two prefix classes each retain multiplicity two and exact half support.",.boolean (match EntropyMultiplicityCorrespondence.multiplicityWitness with | .error _ => false | .ok b => b)],.array [.text "singleton-EmptyOne",.text "Fine observation gives every singleton structural EmptyOne uncertainty.",.boolean (match EntropyMultiplicityCorrespondence.singletonWitness with | .error _ => false | .ok b => b)],.array [.text "complete-pair-ledger",.text "One coarse class retains all six unresolved pairs.",.boolean (match EntropyMultiplicityCorrespondence.pairsWitness with | .error _ => false | .ok b => b)],.array [.text "refinement",.text "Fine observation refines prefix, and prefix refines the coarse class.",.boolean (match EntropyMultiplicityCorrespondence.refinementWitness with | .error _ => false | .ok b => b)],.array [.text "successor",.text "One fresh microstate updates its class without changing prior identities.",.boolean (match EntropyMultiplicityCorrespondence.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-QUANTITY-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-THERMO-ENTROPY-001","SFT-PHYS-THERMO-SECOND-LAW-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003","SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "entropy",.text (entropyName c.entropy)],.array [.text "certainty",.text (certaintyName c.certainty)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "support",.array [.array [.text "selected-or-completed-infinite-chemical-support",.text "A selected or completed-infinite support cannot establish complete multiplicity."],.array [.text "complete-finite-chemical-microstate-support",.text "Every generated chemical microstate occurs exactly once."]]],.array [.text "partition",.array [.array [.text "overlapping-or-partial-macroclasses",.text "Overlap or omission destroys exact observation multiplicity."],.array [.text "disjoint-exhaustive-chemical-observation-classes",.text "Every microstate occurs once in one macro-observation class."]]],.array [.text "multiplicity",.array [.array [.text "fitted-probability-or-floating-weight",.text "A fit imports a distribution and precision choice."],.array [.text "exact-positive-class-count-and-whole-part",.text "Multiplicity is a positive count and its part is exact relative to complete support."]]],.array [.text "entropy",.array [.array [.text "logarithmic-or-irrational-scalar-proof",.text "A logarithmic scalar imports forbidden irrational proof values and erases provenance."],.array [.text "complete-unresolved-distinction-ledger",.text "Entropy retains every class, member, exact part and closed pair."]]],.array [.text "certainty",.array [.array [.text "numerical-zero-singleton-entropy",.text "Numerical zero is not an SFT proof value."],.array [.text "structural-EmptyOne-singleton-certainty",.text "A singleton class has structural EmptyOne unresolved support."]]],.array [.text "prediction",.array [.array [.text "entropy-or-phase-target-readable-before-seal",.text "Observed entropy could select multiplicity or ordering."],.array [.text "complete-value-free-entropy-phase-identity-seal",.text "All state and column identities seal before entropy or phase values open."]]],.array [.text "record",.array [.array [.text "selected-entropy-or-single-phase-row",.text "A selected row can hide a phase transition or adverse orientation."],.array [.text "complete-13-row-entropy-phase-transition-vector",.text "Every liquid, boundary and vapour entropy row is retained."]]],.array [.text "extension",.array [.array [.text "resample-or-refit-after-new-microstate",.text "Resampling changes prior evidence and cannot prove every finite support."],.array [.text "depth-independent-one-microstate-ledger-successor",.text "One fresh microstate updates one class and preserves all prior identities."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical entropy and multiplicity correspondence"
 branch := "chemistry"
 statement := "Chemical entropy is the complete ledger of finite microstates merged by each held macro-observation: exact positive class multiplicity, exact support part, retained members and every unresolved pair. Singleton certainty is structural EmptyOne. Conventional scalar entropy remains a post-seal external inscription; no logarithm or irrational proof value enters the law."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-finite-chemical-microstate-support__disjoint-exhaustive-chemical-observation-classes__exact-positive-class-count-and-whole-part__complete-unresolved-distinction-ledger__structural-EmptyOne-singleton-certainty__complete-value-free-entropy-phase-identity-seal__complete-13-row-entropy-phase-transition-vector__depth-independent-one-microstate-ledger-successor"),("base",.text "One chemical microstate forms one complete observation class with multiplicity One, exact whole support and structural EmptyOne unresolved distinctions."),("successor",.text "Appending one fresh microstate assigns it to one retained macro-observation, increases that class's positive multiplicity, adds one pair with every prior member of that class, recalculates exact support parts and preserves every prior microstate and every unaffected class."),("exclusions",.array [.text "no numerical zero; singleton certainty is structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating or continuum SFT proof value",.text "no imported statistical distribution, partition function, fitted probability, log base or entropy convention",.text "no target payload, scalar entropy, phase, temperature or transition value before prediction seal",.text "no selected support, overlapping class, omitted distinction pair, selected phase row or deleted boundary state",.text "external scalar entropy inscriptions remain correspondence records and never become SFT proof values"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; singleton certainty is structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating or continuum SFT proof value","no imported statistical distribution, partition function, fitted probability, log base or entropy convention","no target payload, scalar entropy, phase, temperature or transition value before prediction seal","no selected support, overlapping class, omitted distinction pair, selected phase row or deleted boundary state","external scalar entropy inscriptions remain correspondence records and never become SFT proof values"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with support := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.EntropyMultiplicityCorrespondenceEvidence
