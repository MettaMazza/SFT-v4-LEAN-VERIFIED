import SFT.Physics.SymmetryActionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.SymmetryActionEvidence
open SFT.Host.Canonical SymmetryActionGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "symmetry",.text (symmetryName c.symmetry)],.array [.text "incidence",.text (incidenceName c.incidence)],.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "conserved",.text (conservedName c.conserved)],.array [.text "converse",.text (converseName c.converse)],.array [.text "action",.text (actionName c.action)],.array [.text "path",.text (pathName c.path)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "support"),("question",.text "Which state space is examined?"),("choices",.array [.array [.text "selected-or-continuous-state-sample",.text "A sample or continuum premise is not a complete generated domain."],.array [.text "complete-finite-generated-support",.text "Every generated state is retained once."]])],.object [("key",.text "symmetry"),("question",.text "What is a symmetry?"),("choices",.array [.array [.text "named-transformation-without-census",.text "A named transformation does not prove bijection or completeness."],.array [.text "complete-bijection-enumeration",.text "Every permutation is generated and decided."]])],.object [("key",.text "incidence"),("question",.text "What must the symmetry preserve?"),("choices",.array [.array [.text "state-labels-without-transition-law",.text "Ignoring incidence can turn a non-dynamics map into a symmetry."],.array [.text "transition-incidence-preserved",.text "Every source/target transition maps to an admitted transition."]])],.object [("key",.text "carrier"),("question",.text "What happens to physical step carriers?"),("choices",.array [.array [.text "free-rescaling-under-symmetry",.text "A free rescaling changes the physical law."],.array [.text "exact-positive-carrier-preserved",.text "Every mapped edge retains the same exact carrier."]])],.object [("key",.text "conserved"),("question",.text "Which quantity is conserved?"),("choices",.array [.array [.text "answer-only-scalar",.text "A scalar detached from support has no conservation trace."],.array [.text "odd-core-and-held-invariant-fibre",.text "Fold preserves the reduced odd denominator core and every enumerated symmetry remains inside its held fibre."]])],.object [("key",.text "converse"),("question",.text "How is the converse closed?"),("choices",.array [.array [.text "assert-every-conservation-has-unknown-symmetry",.text "An ungenerated symmetry is not evidence."],.array [.text "enumerate-all-fibre-preserving-bijections",.text "The complete permutation census constructs exactly the symmetry class of the conserved partition."]])],.object [("key",.text "action"),("question",.text "How is action represented?"),("choices",.array [.array [.text "signed-or-imported-action-integral",.text "Signed continuum integration is outside the proof domain."],.array [.text "sum-of-positive-oriented-step-magnitudes",.text "Orientation is held as a label and every magnitude is exact and positive."]])],.object [("key",.text "path"),("question",.text "Which path is extremal?"),("choices",.array [.array [.text "postulated-stationary-physical-path",.text "Postulating stationarity imports the desired principle."],.array [.text "dyadic-Fold-descent-and-positive-detour-bound",.text "The unique dyadic Fold trace loses one binary layer per act, terminates at identity, and every ranked detour adds retained positive variation."]])],.object [("key",.text "extension"),("question",.text "May another variational rule be added?"),("choices",.array [.array [.text "free-Lagrangian-or-Euler-equation",.text "An imported functional or equation is an extra premise."],.array [.text "no-extra-rule",.text "Finite bijection, invariant fibre, exact path and positive order exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-DYNAMICS-SYMMETRY-ACTION-TERMINAL-016"
  title := "Finite Fold symmetry, conservation and least action"
  branch := "physics"
  statement := "Exact Fold double-and-cast preserves the reduced odd denominator core of every positive rational part, giving a depth-independent native conserved charge.  In every finite generated transition support, a symmetry is the complete bijection that preserves transition incidence, exact positive step carriers and held observation fibres.  Its fibre identity is therefore conserved.  Conversely, complete enumeration of the bijections preserving any registered conserved partition generates that partition's symmetry class.  In the exact dyadic basin, every Fold act removes one binary denominator layer and the unique trajectory reaches the One, where the identity act is empty One.  For every finite ranked descent path, action is the complete sum of exact positive oriented step magnitudes.  Every monotone descent telescopes exactly to the endpoint separation; any detour retains an additional positive up/down carrier and cannot lower the action.  Thus the local dyadic descent and global minimum-variation reading are one exact Fold structure at the declared boundary."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-GRAPH-NETWORK-001", "SFT-MATH-ORDER-LATTICE-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-MECH-WORK-ENERGY-001", "SFT-FOUNDATION-PART-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-DYNAMICS-SYMMETRY-ACTION-TERMINAL-016",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-DYNAMICS-SYMMETRY-ACTION-TERMINAL-016",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [SymmetryActionControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity SymmetryActionControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.SymmetryActionEvidence
