import SFT.Physics.LatticeOperatorControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.LatticeOperatorEvidence
open SFT.Host.Canonical LatticeOperatorGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "neighbours",.text (neighboursName c.neighbours)],.array [.text "stencil",.text (stencilName c.stencil)],.array [.text "operator",.text (operatorName c.operator)],.array [.text "source",.text (sourceName c.source)],.array [.text "causality",.text (causalityName c.causality)],.array [.text "modes",.text (modesName c.modes)],.array [.text "induction",.text (inductionName c.induction)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What occupies a lattice site?"),("choices",.array [.array [.text "signed-field-number",.text "A signed scalar imports cancellation and an unheld absence value."],.array [.text "positive-held-site-presence",.text "Every site retains one positive exact presence carrier and its source orientation."]])],.object [("key",.text "neighbours"),("question",.text "Which adjacent cells participate?"),("choices",.array [.array [.text "selected-or-remote-neighbours",.text "Selection or remote adjacency breaks locality and completeness."],.array [.text "complete-two-per-generated-axis-ring",.text "Each generated axis supplies its lower and upper adjacent cell exactly once."]])],.object [("key",.text "stencil"),("question",.text "How is presence transferred?"),("choices",.array [.array [.text "free-dimension-specific-weights",.text "Independent weights introduce parameters."],.array [.text "half-One-held-half-One-equally-distributed",.text "The centre retains half-One and the complete neighbour ring partitions the other half exactly."]])],.object [("key",.text "operator"),("question",.text "How is curvature represented?"),("choices",.array [.array [.text "signed-Laplacian-value",.text "A signed result is not a positive Fold record."],.array [.text "positive-peak-with-held-opposition",.text "Peak and ring magnitudes stay positive while a held orientation records opposition."]])],.object [("key",.text "source"),("question",.text "What is the point-source response?"),("choices",.array [.array [.text "chosen-peak-or-partial-ring",.text "A chosen peak or incomplete ring does not conserve the neighbour ledger."],.array [.text "two-dimension-peak-and-complete-ring",.text "Two neighbours per axis force equal peak and ring counts 2d."]])],.object [("key",.text "causality"),("question",.text "Which cells are reached after a tick?"),("choices",.array [.array [.text "continuum-or-selected-front",.text "A continuum or selected sample omits generated cells."],.array [.text "complete-oriented-taxicab-ball",.text "Every cell whose positive oriented step count does not exceed the tick is generated once."]])],.object [("key",.text "modes"),("question",.text "How is cyclic dispersion retained?"),("choices",.array [.array [.text "evaluated-cosine-or-mode-table",.text "An imported cosine or table introduces nonnative and potentially irrational proof values."],.array [.text "complete-exact-phase-mode-carriers",.text "Every cyclic phase label is retained with the exact centre/forward/reverse share relation."]])],.object [("key",.text "induction"),("question",.text "How do dimensions and ticks extend?"),("choices",.array [.array [.text "bounded-count-list",.text "A short list does not close the next generated axis or tick."],.array [.text "axis-and-oriented-step-successor",.text "Adding an axis appends exactly two neighbours; adding a tick appends every oriented boundary cell of that radius."]])],.object [("key",.text "comparison"),("question",.text "How do physical dispersion and cubic support enter?"),("choices",.array [.array [.text "measurement-selects-operator",.text "External targets cannot choose the stencil or cone."],.array [.text "inherit-sealed-dispersion-and-cubic-records",.text "Existing post-seal claims test label-dependent dispersion and six-neighbour cubic support downstream."]])],.object [("key",.text "extension"),("question",.text "May another lattice coefficient enter?"),("choices",.array [.array [.text "free-coefficient-or-extra-neighbour",.text "That changes the generated conservative family."],.array [.text "no-extra-rule",.text "Half retention, complete local adjacency and equal partition exhaust the law."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-LATTICE-OPERATOR-TERMINAL-022"
  title := "Exact Fold lattice operators, causal cones and phase modes"
  branch := "physics"
  statement := "One conservative Fold lattice family covers one, two and three generated directions.  Every site retains half-One and distributes the other half equally over its complete two-per-axis neighbour ring; this gives the one-direction half/quarter/quarter stencil and the planar four-neighbour eighth shares.  A point source has positive peak magnitude two times the dimension and an equally counted opposition ring.  Complete oriented taxicab enumeration forces causal-ball counts 5,13,25 in two directions and 7,25,63 in three.  A cycle of N positive sites has exactly N phase mode carriers with update relation half-One centre plus quarter forward phase plus quarter reverse phase; the identity phase is the unique stationary flat mode.  No irrational mode value is evaluated."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-GRAVITY-LATTICE-CURVATURE-003", "SFT-PHYS-FIELD-MAXWELL-PLANAR-CLOSURE-003", "SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003", "SFT-PHYS-WAVE-DISPERSION-001", "SFT-PHYS-DYNAMICS-FREE-PHASE-DISPERSION-003", "SFT-PHYS-VALIDATION-ATOMIC-CUBIC-SUPPORT-004", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-LATTICE-OPERATOR-TERMINAL-022",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-LATTICE-OPERATOR-TERMINAL-022",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [LatticeOperatorControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity LatticeOperatorControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.LatticeOperatorEvidence
