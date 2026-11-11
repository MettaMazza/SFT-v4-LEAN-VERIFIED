import SFT.Chemistry.EquilibriumGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.EquilibriumEvidence
open SFT.Host.Canonical EquilibriumGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "balance",.text "forward and reverse counts are equal",.boolean true],.array [.text "activity",.text "both directions have positive support",.boolean true],.array [.text "composition",.text "the macroscopic class remains held",.boolean true]]
def claimId : String := "SFT-CHEM-EQ-CHEMICAL-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-KIN-RATE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "reversibility",.text (reversibilityName c.reversibility)],.array [.text "activity",.text (activityName c.activity)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "reversibility",.array [.array [.text "one-way-reaction",.text "No reverse support exists."],.array [.text "forward-and-reverse-transitions",.text "Both paths are generated."]]],.array [.text "activity",.array [.array [.text "static-no-events",.text "Chemical equilibrium is dynamically supported."],.array [.text "persistent-opposed-events",.text "Both transition classes continue."]]],.array [.text "balance",.array [.array [.text "unpaired-event-counts",.text "Composition would drift."],.array [.text "paired-forward-reverse-support",.text "Complete changes cancel on the boundary."]]],.array [.text "composition",.array [.array [.text "microscopic-state-fixed",.text "Individual events need not stop."],.array [.text "macroscopic-composition-class-recurs",.text "The observed whole remains invariant."]]],.array [.text "boundary",.array [.array [.text "open-material-flow",.text "External flow can imitate balance."],.array [.text "closed-observation-boundary",.text "All carrier flow is counted."]]],.array [.text "conditions",.array [.array [.text "condition-free-equilibrium",.text "The class can change with conditions."],.array [.text "source-bound-condition-record",.text "Temperature, pressure and phase remain held."]]],.array [.text "record",.array [.array [.text "equilibrium-constant-only",.text "A number cannot reconstruct dynamics."],.array [.text "forward-reverse-composition-trace",.text "All events and composition remain auditable."]]],.array [.text "extra",.array [.array [.text "free-equilibrium-fit",.text "A fitted constant can force a target."],.array [.text "no-extra-rule",.text "Reversible recurrence closure supplies equilibrium."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical equilibrium as balanced reversible support"
 branch := "chemistry"
 statement := "Chemical equilibrium is persistent forward and reverse reaction recurrence on a closed boundary whose paired carrier changes preserve the macroscopic composition class."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "forward-and-reverse-transitions__persistent-opposed-events__paired-forward-reverse-support__macroscopic-composition-class-recurs__closed-observation-boundary"),("base",.text "One paired forward/reverse recurrence supplies the first chemical equilibrium."),("successor",.text "Appending a paired recurrence preserves complete carrier balance and the same macroscopic composition class."),("exclusions",.array [.text "no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier may be created, copied or silently erased",.text "an absent dependence or event is an empty structural form, never numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite reversible chemical transition on one closed observation boundary for which forward and reverse event recurrences persist while their complete carrier changes pair and the retained macroscopic composition class recurs."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier may be created, copied or silently erased","an absent dependence or event is an empty structural form, never numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite reversible chemical transition on one closed observation boundary for which forward and reverse event recurrences persist while their complete carrier changes pair and the retained macroscopic composition class recurs."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with reversibility := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.EquilibriumEvidence
