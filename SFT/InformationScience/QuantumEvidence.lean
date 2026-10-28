import SFT.InformationScience.QuantumControls
import SFT.Engine.RegistrationGate
namespace SFT.InformationScience.QuantumEvidence
open SFT.Host.Canonical QuantumGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "unit",.text (unitName c.unit)],.array [.text "support",.text (supportName c.support)],.array [.text "basis",.text (basisName c.basis)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "superposition",.text (superpositionName c.superposition)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "observation",.text (observationName c.observation)],.array [.text "record",.text (recordName c.record)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "unit"),("question",.text "What fixes the quantum information unit?"),("choices",.array [.array [.text "imported-qubit",.text "A conventional qubit premise would select the carrier."],.array [.text "one-Fold-distinction",.text "The minimal Fold's two held labels supply one exact distinction unit."]])],.object [("key",.text "support"),("question",.text "What fixes possible basis alternatives?"),("choices",.array [.array [.text "sampled-branches",.text "Sampling cannot establish complete finite support."],.array [.text "complete-Fold-word-support",.text "Every held-label word over every registered position occurs once."]])],.object [("key",.text "basis"),("question",.text "What fixes correspondence to basis labels?"),("choices",.array [.array [.text "unnamed-state-count",.text "A count erases which Fold word corresponds to which basis state."],.array [.text "bijective-word-basis-trace",.text "Every word has one unique retained basis name and inverse."]])],.object [("key",.text "provenance"),("question",.text "What identifies a branch?"),("choices",.array [.array [.text "amplitude-only-row",.text "A coefficient without a generated word erases branch origin."],.array [.text "position-label-trace",.text "Every branch retains every canonical position and held label."]])],.object [("key",.text "superposition"),("question",.text "What is forced at the information boundary?"),("choices",.array [.array [.text "complex-amplitude-premise",.text "Complex amplitudes, phases and normalization are not derived here."],.array [.text "complete-alternative-support",.text "Superposition-equivalence means the exact complete branch family only."]])],.object [("key",.text "composition"),("question",.text "What fixes joint quantum information support?"),("choices",.array [.array [.text "tensor-symbol-premise",.text "A borrowed symbol does not enumerate joint alternatives."],.array [.text "complete-pair-cell-support",.text "Every left branch pairs exactly once with every right branch and retains both origins."]])],.object [("key",.text "observation"),("question",.text "What fixes a measured information class?"),("choices",.array [.array [.text "stochastic-collapse",.text "A random collapse rule is not generated at this boundary."],.array [.text "exact-observation-class",.text "The observed image retains its complete branch predecessor class."]])],.object [("key",.text "record"),("question",.text "What preserves closed support distinctions?"),("choices",.array [.array [.text "discarded-predecessors",.text "Discarding the record prevents exact support reconstruction."],.array [.text "complete-branch-image-record",.text "Every pre-observation branch and image remains available for reconstruction."]])],.object [("key",.text "generality"),("question",.text "What closes arbitrary finite position depth?"),("choices",.array [.array [.text "small-depth-table",.text "A table does not establish the next support layer."],.array [.text "position-successor",.text "A fresh position appends every held label to every prior branch."]])],.object [("key",.text "addition"),("question",.text "Are operational quantum laws imported?"),("choices",.array [.array [.text "extra-amplitude-phase-or-gate-law",.text "Those structures belong to later forced derivations and would select results here."],.array [.text "no-extra-quantum-operation",.text "Only the exact information-support correspondence is admitted."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-INFO-QUANTUM-CORRESPONDENCE-001"
  title := "Exact quantum-information support correspondence"
  branch := "information_science"
  statement := "One Fold distinction supplies the native information unit. Across k canonical positions, the complete generated held-label word family supplies the exact branch support corresponding to a finite quantum basis support, and complete pair cells supply joint-state support. Calling this support superposition-equivalent asserts equality of enumerated alternatives and provenance only: amplitudes, phase and dynamics are not imported. Observation returns an exact retained branch class and a complete reconstruction record. Thus classical held states, probabilistic observation classes and quantum basis support share one exact information carrier at this boundary."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-ASSEMBLY-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-QUANTITY-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-CLASSICAL-PROBABILISTIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-INFO-QUANTUM-CORRESPONDENCE-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-INFO-QUANTUM-CORRESPONDENCE-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FOLD-ASSEMBLY-001",.text "SFT-MATH-CATEGORY-TYPE-COMPOSITION-001",.text "SFT-INFO-QUANTITY-001",.text "SFT-INFO-CONSERVATION-LOSS-001",.text "SFT-INFO-CLASSICAL-PROBABILISTIC-001"]),
    ("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])

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
  proofHash := identity (.object [("closure",QuantumControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-INFO-QUANTUM-CORRESPONDENCE-001"),
    ("base",.text "The first Fold position has the two held labels, one exact distinction and a two-branch basis correspondence."),
    ("successor",.text "Adding one fresh canonical position appends each held label to every prior word exactly once. Prior branch provenance remains intact, the new position realizes one distinction and joint-support laws remain pairwise."),
    ("laws",.array (QuantumControls.laws.map Value.text)),
    ("witnesses",.array (QuantumWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Quantum information must first establish its exact alternative carrier and its relation to classical and probabilistic information. Operational quantum effects cannot be used to select that foundation."

def derivation : String := "Fold assembly supplies words, information quantity supplies position units, conservation supplies records, classical/probabilistic correspondence supplies held states and observation classes, and composition supplies pair cells."

def check : String := "Execute all 1,024 kernels; exhaust three-position support, unit and basis traces, joint cells and observation reconstruction, verify the support-only boundary and independently regenerate the candidate product."

def limitations : String := "This theorem closes only finite quantum-information support correspondence. Phase, interference, entanglement, measurement dynamics, transformations, gates, circuits and quantum fault tolerance remain quantum-branch obligations."

def correspondenceTerms : List String := ["qubit support","computational basis","superposition support","joint quantum state","measurement record"]

end SFT.InformationScience.QuantumEvidence
