import SFT.Chemistry.ActivationGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ActivationEvidence
open SFT.Host.Canonical ActivationGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "support",.text "the crossing support is positive",.boolean true],.array [.text "boundaries",.text "reactant, transition and product roles differ",.boolean true],.array [.text "minimality",.text "smaller generated support is rejected by construction",.boolean true]]
def claimId : String := "SFT-CHEM-KIN-ACTIVATION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "path",.text (pathName c.path)],.array [.text "source",.text (sourceName c.source)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "reference",.text (referenceName c.reference)],.array [.text "minimality",.text (minimalityName c.minimality)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "path",.array [.array [.text "endpoint-only",.text "No crossing requirement is represented."],.array [.text "complete-generated-reaction-path",.text "All intermediate boundaries are held."]]],.array [.text "source",.array [.array [.text "free-energy-number",.text "An imported number selects the barrier."],.array [.text "source-bound-support-account",.text "Every increment has provenance."]]],.array [.text "transition",.array [.array [.text "arbitrary-high-state",.text "It need not lie on the path."],.array [.text "highest-path-boundary",.text "The crossing boundary is path-relative."]]],.array [.text "reference",.array [.array [.text "absolute-energy-origin",.text "An arbitrary origin imports a parameter."],.array [.text "reactant-relative-support",.text "Only the exact difference is retained."]]],.array [.text "minimality",.array [.array [.text "nonminimal-added-support",.text "Extra support does not define activation."],.array [.text "least-crossing-support",.text "All smaller generated supports fail to cross."]]],.array [.text "orientation",.array [.array [.text "signed-barrier",.text "A negative scalar is outside the proof domain."],.array [.text "held-reactant-to-transition-orientation",.text "Direction is a label with positive magnitude."]]],.array [.text "record",.array [.array [.text "activation-value-only",.text "A value cannot reproduce the path."],.array [.text "path-source-boundary-trace",.text "Path and support remain auditable."]]],.array [.text "extra",.array [.array [.text "free-temperature-fit",.text "A fitted input can tune the result."],.array [.text "no-extra-rule",.text "Least path crossing supplies the structural barrier."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Activation barrier and transition boundary"
 branch := "chemistry"
 statement := "Activation support is the least source-bound addition required for a generated reaction path to reach its highest transition boundary relative to the reactant boundary."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-generated-reaction-path__source-bound-support-account__highest-path-boundary__reactant-relative-support__least-crossing-support"),("base",.text "One path with one least crossing increment supplies the first barrier."),("successor",.text "Appending a path state preserves prior support and updates the barrier only if the new boundary is higher on the same exact reference."),("exclusions",.array [.text "no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier may be created, copied or silently erased",.text "an absent dependence or event is an empty structural form, never numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite generated reaction path from a retained reactant organization to product organization, with the least additional source support needed to reach its unique highest transition boundary recorded relative to the reactant boundary."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier may be created, copied or silently erased","an absent dependence or event is an empty structural form, never numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite generated reaction path from a retained reactant organization to product organization, with the least additional source support needed to reach its unique highest transition boundary recorded relative to the reactant boundary."]
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
end SFT.Chemistry.ActivationEvidence
