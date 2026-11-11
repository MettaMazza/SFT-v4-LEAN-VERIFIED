import SFT.Physics.AtomicOrbitCapacityControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.AtomicOrbitCapacityEvidence
open SFT.Host.Canonical AtomicOrbitCapacityGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "central",.text (centralName c.central)],.array [.text "successor",.text (successorName c.successor)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "label",.text (labelName c.label)],.array [.text "exclusion",.text (exclusionName c.exclusion)],.array [.text "capacity",.text (capacityName c.capacity)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries an orbit cell?"),("choices",.array [.array [.text "unlabelled-cell-count",.text "An unlabelled count loses orientation identity."],.array [.text "held-orientation-cell",.text "Each cell retains its generated orientation."]])],.object [("key",.text "central"),("question",.text "What occurs at rank One?"),("choices",.array [.array [.text "empty-numerical-origin",.text "Numerical zero is not an SFT carrier."],.array [.text "one-central-orientation",.text "Rank One retains exactly the central orientation."]])],.object [("key",.text "successor"),("question",.text "What does a rank successor add?"),("choices",.array [.array [.text "free-rank-increment",.text "A free increment is a parameter."],.array [.text "one-boundary-orientation-pair",.text "Each successor adds the complete two-sided boundary incidence."]])],.object [("key",.text "boundary"),("question",.text "How many new orientations are held?"),("choices",.array [.array [.text "single-or-three-direction-addition",.text "One omits a boundary side and three re-adds the held normal."],.array [.text "forced-rank-two-pair",.text "Boundary rank two supplies exactly one orientation pair."]])],.object [("key",.text "label"),("question",.text "Which internal labels occupy an orientation?"),("choices",.array [.array [.text "label-erased-or-selected",.text "Erasure or selection violates complete Fold support."],.array [.text "both-Fold-labels",.text "Both forced Fold labels are retained."]])],.object [("key",.text "exclusion"),("question",.text "May a label repeat in one cell?"),("choices",.array [.array [.text "duplicate-cell-label",.text "Duplication destroys distinguishability."],.array [.text "one-of-each-label-per-cell",.text "Exclusion retains one state per held label and orientation."]])],.object [("key",.text "capacity"),("question",.text "How is capacity composed?"),("choices",.array [.array [.text "linear-or-doubling-without-boundary",.text "Those former survivors ignore the newly admitted boundary discriminator."],.array [.text "labels-times-complete-orientations",.text "The Cartesian support of labels and orientations is complete."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary rank?"),("choices",.array [.array [.text "finite-width-list",.text "A list has no next-rank proof."],.array [.text "constant-boundary-pair-successor",.text "Every successor adds one pair and therefore four label-orientation states."]])],.object [("key",.text "target"),("question",.text "May known subshell widths select the law?"),("choices",.array [.array [.text "width-list-visible",.text "That reverses derivation and test."],.array [.text "widths-inaccessible-until-seal",.text "The positive-rank law seals before comparison."]])],.object [("key",.text "extension"),("question",.text "May another degeneracy be supplied?"),("choices",.array [.array [.text "extra-degeneracy-rule",.text "An added degeneracy is a parameter."],.array [.text "no-extra-rule",.text "Three-space, boundary rank, Fold labels and exclusion exhaust the cell grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001"
  title := "Atomic orbit-cell capacity from three-space boundary orientation"
  branch := "physics"
  statement := "At positive orbit rank r, three-space supplies one central orientation and the rank-two boundary supplies one held pair for every predecessor step. Two exclusion-distinct Fold labels occupy each orientation, forcing capacity 2(1+2(r-1)) and the sequence 2, 6, 10, 14, 18 without observation."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [AtomicOrbitCapacityControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity AtomicOrbitCapacityControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.AtomicOrbitCapacityEvidence
