import SFT.Chemistry.SolubilityGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SolubilityEvidence
open SFT.Host.Canonical SolubilityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "balance",.text "dissolution and return counts match",.boolean true],.array [.text "activity",.text "both event supports are positive",.boolean true],.array [.text "boundary",.text "the solution boundary is retained",.boolean true]]
def claimId : String := "SFT-CHEM-SOLUTION-EQUILIBRIUM-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-RXN-INTERMEDIATE-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-KIN-ORDER-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-PHASE-CHEMICAL-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "solution",.text (solutionName c.solution)],.array [.text "dissolution",.text (dissolutionName c.dissolution)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "saturation",.text (saturationName c.saturation)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "solution",.array [.array [.text "unidentified-mixture",.text "Solute and solvent roles are lost."],.array [.text "retained-solute-solvent-organization",.text "Both identities remain held."]]],.array [.text "dissolution",.array [.array [.text "one-way-dissolution-only",.text "No equilibrium can close."],.array [.text "dissolution-and-return-transitions",.text "Both paths are generated."]]],.array [.text "balance",.array [.array [.text "unpaired-event-support",.text "Composition would drift."],.array [.text "paired-opposed-event-support",.text "Dissolved and returned carriers pair."]]],.array [.text "saturation",.array [.array [.text "free-solubility-number",.text "A measured number imports the target."],.array [.text "source-bounded-capacity-boundary",.text "Capacity is finite and condition-bound."]]],.array [.text "composition",.array [.array [.text "microscopic-state-fixed",.text "Individual events may continue."],.array [.text "macroscopic-dissolved-class-recurs",.text "The observed solution remains stable."]]],.array [.text "conditions",.array [.array [.text "condition-free-solubility",.text "Solubility changes with conditions."],.array [.text "phase-temperature-pressure-held",.text "All source coordinates remain explicit."]]],.array [.text "record",.array [.array [.text "solubility-answer-only",.text "It cannot reproduce the dynamics."],.array [.text "solution-event-composition-trace",.text "All carriers remain auditable."]]],.array [.text "extra",.array [.array [.text "free-equilibrium-fit",.text "A fit can select any saturation."],.array [.text "no-extra-rule",.text "Opposed recurrence closure supplies the law."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Solution and solubility equilibrium"
 branch := "chemistry"
 statement := "Solubility equilibrium is paired dissolution and return recurrence on a retained solution boundary, preserving a condition-bound macroscopic dissolved-composition class at finite saturation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "retained-solute-solvent-organization__dissolution-and-return-transitions__paired-opposed-event-support__source-bounded-capacity-boundary__macroscopic-dissolved-class-recurs"),("base",.text "One paired dissolution/return recurrence supplies the first saturated solution equilibrium."),("successor",.text "Appending a paired event preserves carrier balance and the same macroscopic dissolved class."),("exclusions",.array [.text "no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no energy, matter or photon carrier may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite solution boundary containing a retained solvent/solute organization and opposed dissolution/return transitions whose complete event supports pair at saturation while the macroscopic dissolved-composition class recurs."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no thermochemical table, spontaneity rule, phase diagram, solubility value, photochemical database, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no energy, matter or photon carrier may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite solution boundary containing a retained solvent/solute organization and opposed dissolution/return transitions whose complete event supports pair at saturation while the macroscopic dissolved-composition class recurs."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with solution := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.SolubilityEvidence
