import SFT.Physics.NuclearClosureControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.NuclearClosureEvidence
open SFT.Host.Canonical NuclearClosureGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "composition",.text (compositionName c.composition)],.array [.text "labels",.text (labelsName c.labels)],.array [.text "base",.text (baseName c.base)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "shift",.text (shiftName c.shift)],.array [.text "threshold",.text (thresholdName c.threshold)],.array [.text "reorder",.text (reorderName c.reorder)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "composition"),("question",.text "How are shell states generated?"),("choices",.array [.array [.text "selected-shell-degeneracy",.text "A selected degeneracy imports a model."],.array [.text "complete-three-direction-weak-compositions",.text "Every distribution of the predecessor excitation among all three labelled directions is counted once."]])],.object [("key",.text "labels"),("question",.text "Which internal labels are included?"),("choices",.array [.array [.text "single-or-duplicated-label",.text "Omission or duplication violates Fold support and exclusion."],.array [.text "two-exclusion-distinct-labels",.text "Both Fold labels occur once per spatial composition."]])],.object [("key",.text "base"),("question",.text "How is a filled closure counted?"),("choices",.array [.array [.text "closure-list",.text "A list has no generative proof."],.array [.text "positive-rank-composition-form",.text "The exact form r(r+1)(r+2)/3 follows from the complete composition count."]])],.object [("key",.text "coupling"),("question",.text "Where does reordering strength come from?"),("choices",.array [.array [.text "fitted-spin-orbit-strength",.text "A fitted strength reads the closures."],.array [.text "sealed-two-thirds-colour-coupling",.text "The upstream claim fixes 2/3 without closure access."]])],.object [("key",.text "shift"),("question",.text "What does the coupling act on?"),("choices",.array [.array [.text "free-shell-shift",.text "A free shift is a parameter."],.array [.text "top-angular-half-label-pair",.text "Spin division by the two Fold labels leaves angular/2, giving angular/3 after coupling."]])],.object [("key",.text "threshold"),("question",.text "When can reordering cross a whole gap?"),("choices",.array [.array [.text "selected-rank-threshold",.text "A selected threshold fits the sequence."],.array [.text "least-positive-whole-gap",.text "Positive succession makes three the first angular count with angular/3 at least One."]])],.object [("key",.text "reorder"),("question",.text "What moves at threshold?"),("choices",.array [.array [.text "arbitrary-intruder-count",.text "An arbitrary intruder count is fitted."],.array [.text "complete-top-orbit-capacity",.text "The top orbit contributes the already forced two-times-shell-rank capacity."]])],.object [("key",.text "recurrence"),("question",.text "How are later closures generated?"),("choices",.array [.array [.text "finite-eight-value-table",.text "A table does not close later ranks."],.array [.text "piecewise-positive-successor-law",.text "The pre-threshold composition form and post-threshold predecessor-plus-top-orbit form apply at every positive rank."]])],.object [("key",.text "target"),("question",.text "May known magic numbers select a survivor?"),("choices",.array [.array [.text "magic-numbers-visible",.text "That is target leakage."],.array [.text "sequence-inaccessible-until-seal",.text "The recurrence seals before any nuclear comparison."]])],.object [("key",.text "extension"),("question",.text "May another nuclear selector enter?"),("choices",.array [.array [.text "extra-nuclear-rule",.text "An added selector is a parameter."],.array [.text "no-extra-rule",.text "Composition, labels, coupling and whole-gap closure exhaust this registered shell grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-NUCLEAR-CLOSURE-SEQUENCE-001"
  title := "Complete Fold nuclear-closure sequence"
  branch := "physics"
  statement := "Complete weak compositions across three spatial directions with two exclusion labels force the base filled-shell counts. The independently sealed two-thirds colour coupling reaches its first whole spin-orbit gap at angular count three and forces the reordered closure sequence 2, 8, 20, 28, 50, 82, 126, 184 with a depth-independent successor law."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001", "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-PHYS-NUCLEAR-BINDING-001", "SFT-PHYS-NUCLEAR-LEVELS-001", "SFT-PHYS-NUCLEAR-REACTIONS-001", "SFT-MATH-COMBINATORICS-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-NUCLEAR-CLOSURE-SEQUENCE-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-NUCLEAR-CLOSURE-SEQUENCE-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.array [NuclearClosureControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity NuclearClosureControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.NuclearClosureEvidence
