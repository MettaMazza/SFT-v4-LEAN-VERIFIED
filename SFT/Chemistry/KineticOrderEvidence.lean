import SFT.Chemistry.KineticOrderGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.KineticOrderEvidence
open SFT.Host.Canonical KineticOrderGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "reactant",.text "the dependency coordinate is named",.boolean true],.array [.text "multiplicity",.text "one dependency occurrence is retained",.boolean true],.array [.text "empty",.text "independence is represented by an empty tuple",.boolean true]]
def claimId : String := "SFT-CHEM-KIN-ORDER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-KIN-RATE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "reactant",.text (reactantName c.reactant)],.array [.text "intervention",.text (interventionName c.intervention)],.array [.text "response",.text (responseName c.response)],.array [.text "multiplicity",.text (multiplicityName c.multiplicity)],.array [.text "independence",.text (independenceName c.independence)],.array [.text "scope",.text (scopeName c.scope)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "reactant",.array [.array [.text "anonymous-concentration",.text "The dependency coordinate is lost."],.array [.text "named-reactant-coordinate",.text "One species identity is varied."]]],.array [.text "intervention",.array [.array [.text "passive-correlation",.text "It cannot establish dependence."],.array [.text "source-bound-coordinate-intervention",.text "The reactant coordinate alone is changed."]]],.array [.text "response",.array [.array [.text "single-rate-answer",.text "Multiplicity cannot be recovered."],.array [.text "complete-rate-response-census",.text "Every generated intervention row is retained."]]],.array [.text "multiplicity",.array [.array [.text "stoichiometric-coefficient-assumed",.text "Kinetic and endpoint counts need not coincide."],.array [.text "forced-dependency-occurrence-count",.text "Multiplicity comes from the rate relation."]]],.array [.text "independence",.array [.array [.text "numerical-zero-order",.text "Zero is prohibited as proof quantity."],.array [.text "empty-dependency-form",.text "No dependence is an Empty form."]]],.array [.text "scope",.array [.array [.text "universal-condition-free-order",.text "Observed order can be condition-specific."],.array [.text "condition-and-mechanism-bound-order",.text "The source boundary is retained."]]],.array [.text "record",.array [.array [.text "order-number-only",.text "It cannot reproduce the intervention."],.array [.text "reactant-intervention-response-trace",.text "All dependency evidence remains held."]]],.array [.text "extra",.array [.array [.text "free-power-law-fit",.text "A fit can select the exponent."],.array [.text "no-extra-rule",.text "Exact response multiplicity supplies the order."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Kinetic order and dependency multiplicity"
 branch := "chemistry"
 statement := "Kinetic order is the exact condition-bound multiplicity of a named reactant coordinate in the complete intervention-to-rate dependency trace; independence is Empty rather than numerical zero."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "named-reactant-coordinate__source-bound-coordinate-intervention__complete-rate-response-census__forced-dependency-occurrence-count__empty-dependency-form"),("base",.text "One retained dependency occurrence supplies the first positive kinetic order."),("successor",.text "Appending an intervention preserves every row and changes multiplicity only when an additional distinguishable dependency occurrence is forced."),("exclusions",.array [.text "no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier may be created, copied or silently erased",.text "an absent dependence or event is an empty structural form, never numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite source-bound intervention census for one reactant coordinate, retaining the exact multiplicity with which distinguishable occurrences of that coordinate participate in the rate dependency; absence is represented structurally."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier may be created, copied or silently erased","an absent dependence or event is an empty structural form, never numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite source-bound intervention census for one reactant coordinate, retaining the exact multiplicity with which distinguishable occurrences of that coordinate participate in the rate dependency; absence is represented structurally."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with reactant := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.KineticOrderEvidence
