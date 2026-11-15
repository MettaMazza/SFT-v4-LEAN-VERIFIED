import SFT.Physics.AccumulatedSeparationControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.AccumulatedSeparationEvidence
open SFT.Host.Canonical AccumulatedSeparationGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "term",.text (termName c.term)],.array [.text "first",.text (firstName c.first)],.array [.text "contraction",.text (contractionName c.contraction)],.array [.text "envelope",.text (envelopeName c.envelope)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "tolerance",.text (toleranceName c.tolerance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "Which running law supplies the terms?"),("choices",.array [.array [.text "imported-or-selected-coupling-table",.text "A conventional or selected table is not an admitted predecessor."],.array [.text "admitted-common-support-gap-law",.text "The current model-admitted running receipt forces the complete pair-gap family."]])],.object [("key",.text "term"),("question",.text "What is accumulated?"),("choices",.array [.array [.text "unsigned-or-fitted-difference",.text "A fitted difference can encode a target."],.array [.text "exact-adjacent-sector-gap",.text "The generator difference is the One and the paired denominators force 1/((R+2)(R+3))."]])],.object [("key",.text "first"),("question",.text "How is the exceptional first successor handled?"),("choices",.array [.array [.text "assert-half-contraction-from-first-gap",.text "The transition 1/12 to 1/20 shrinks but is not below half."],.array [.text "retain-one-twelfth-and-one-twentieth",.text "The complete first two exact gaps are retained before the general contraction."]])],.object [("key",.text "contraction"),("question",.text "What closes every later successor?"),("choices",.array [.array [.text "visual-or-imported-convergence",.text "Visual approach and an imported series theorem are not Fold proof objects."],.array [.text "exact-strict-half-contraction-after-level-two",.text "For every R at least two, the successor denominator exceeds twice the current denominator."]])],.object [("key",.text "envelope"),("question",.text "Which generated upper envelope is forced?"),("choices",.array [.array [.text "one-sixth",.text "Later exact partial sums exceed this candidate."],.array [.text "eleven-sixtieths",.text "The base 1/12 plus twice the first contracting-tail term 1/20 uniquely gives 11/60."],.array [.text "one-fifth",.text "This is a weaker nonminimal envelope."],.array [.text "target-selected-bound",.text "A target-selected bound violates the direction of proof."]])],.object [("key",.text "boundary"),("question",.text "Is a completed infinite object required?"),("choices",.array [.array [.text "completed-infinite-sum",.text "Completed infinity is outside the SFT domain."],.array [.text "every-positive-finite-partial-support",.text "The induction bounds every generated finite partial accumulation."]])],.object [("key",.text "tolerance"),("question",.text "How is convergence witnessed?"),("choices",.array [.array [.text "limit-symbol-without-witness",.text "A limit label alone supplies no finite certificate."],.array [.text "generated-finite-tail-witness",.text "Binary support eventually makes twice one exact gap smaller than any registered positive rational tolerance."]])],.object [("key",.text "extension"),("question",.text "May another correction or bound be selected?"),("choices",.array [.array [.text "free-tail-correction",.text "A free correction is a parameter."],.array [.text "no-extra-rule",.text "The admitted gap, first two terms, exact contraction and finite induction exhaust the law."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-COUPLING-ACCUMULATED-SEPARATION-TERMINAL-015"
  title := "Finite accumulated Fold-coupling separation"
  branch := "physics"
  statement := "For the admitted binary and generator-three running sectors on the common Fold support R, the exact adjacent gap at positive level n is 1/((R_n+2)(R_n+3)), with R_1=One and R_(n+1)=2R_n.  The first gap is 1/12 and the second is 1/20.  Every successor from the second gap onward is strictly below half its predecessor.  Consequently every positive finite partial accumulation S_N satisfies 1/12 <= S_N < 11/60, and for every positive finite tolerance a generated level supplies a smaller exact remaining-tail envelope.  This is constructive finite convergence, not a completed infinite sum."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006", "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-FOUNDATION-COUNT-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-COUPLING-ACCUMULATED-SEPARATION-TERMINAL-015",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-COUPLING-ACCUMULATED-SEPARATION-TERMINAL-015",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [AccumulatedSeparationControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity AccumulatedSeparationControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.AccumulatedSeparationEvidence
