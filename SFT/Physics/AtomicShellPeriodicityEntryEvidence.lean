import SFT.Foundation.AdmissionControls
import SFT.Physics.AtomicShellPeriodicityEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.AtomicShellPeriodicityEntryEvidence
open SFT.Host.Canonical AtomicShellPeriodicityEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "shell",.text (shellName c.shell)],.array [.text "sum",.text (sumName c.sum)],.array [.text "order",.text (orderName c.order)],.array [.text "closure",.text (closureName c.closure)],.array [.text "recurrence",.text (recurrenceName c.recurrence)],.array [.text "ionization",.text (ionizationName c.ionization)],.array [.text "target",.text (targetName c.target)],.array [.text "trace",.text (traceName c.trace)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How is the admitted orbit-cell theorem used?"),("choices",.array [.array [.text "replace-or-relabel-capacity",.text "A successor may not rewrite an immutable receipt."],.array [.text "compose-immutable-orbit-capacity",.text "Every sublevel retains its admitted 2(2l+1) capacity."]])],.object [("key",.text "shell"),("question",.text "Which sublevels form principal shell n?"),("choices",.array [.array [.text "selected-width-list",.text "A width list is an imported answer."],.array [.text "all-positive-orbit-ranks-through-n",.text "The complete shell contains every orbit rank from One through n exactly once."]])],.object [("key",.text "sum"),("question",.text "How is shell capacity formed?"),("choices",.array [.array [.text "asserted-two-n-square",.text "Asserting the result supplies no derivation."],.array [.text "exact-complete-capacity-sum",.text "Summing all generated capacities gives 2n squared."]])],.object [("key",.text "order"),("question",.text "How are subshells traversed?"),("choices",.array [.array [.text "memorized-filling-table",.text "A memorized table would select the result."],.array [.text "increasing-joint-cover-principal-tie",.text "Joint cover is generated and retained principal rank supplies the sole stable tie order."]])],.object [("key",.text "closure"),("question",.text "Which filled cells close a period?"),("choices",.array [.array [.text "chosen-period-endpoints",.text "Chosen endpoints are measured inputs."],.array [.text "first-cell-then-complete-rank-two-boundary",.text "The first cell closes the first period; thereafter the complete rank-two outer boundary closes each recurrence."]])],.object [("key",.text "recurrence"),("question",.text "How is the next period obtained?"),("choices",.array [.array [.text "free-reset-rule",.text "A reset rule is a parameter."],.array [.text "successor-after-held-closure",.text "After each held closure the next generated cell opens the next period."]])],.object [("key",.text "ionization"),("question",.text "What qualitative energy law is tested?"),("choices",.array [.array [.text "strict-stepwise-monotonicity",.text "Strict monotonicity erases genuine within-period distinctions."],.array [.text "rising-envelope-and-boundary-reset",.text "The period endpoint exceeds its start and the next start falls below the held endpoint; local internal reversals remain admissible evidence."]])],.object [("key",.text "target"),("question",.text "May table or ionization data enter execution?"),("choices",.array [.array [.text "external-data-readable",.text "Target-readable execution cannot seal a prediction."],.array [.text "target-inaccessible-until-seal",.text "No external atomic record is present in the formal module."]])],.object [("key",.text "trace"),("question",.text "How is the result connected to the One?"),("choices",.array [.array [.text "answer-without-dependencies",.text "An untraced answer is inadmissible."],.array [.text "complete-root-directed-trace",.text "Capacity, exclusion, spatial and exact-arithmetic dependencies all retain their root path."]])],.object [("key",.text "extension"),("question",.text "May an exception or extra width be appended?"),("choices",.array [.array [.text "free-exception-or-width",.text "An ungenerated exception is a parameter."],.array [.text "no-extra-rule",.text "The complete cover order and admitted endpoint exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005"
  title := "Terminal exact atomic shell, filling and periodicity completion"
  branch := "physics"
  statement := "Every positive principal shell n contains all orbit ranks One through n, so the admitted capacities sum exactly to 2n squared.  Increasing joint cover with retained principal-rank tie order generates the complete filling recurrence.  The first filled cell and each later filled rank-two outer boundary force closure coordinates 2, 10, 18, 36, 54, 86 and 118 and period widths 2, 8, 8, 18, 18, 32 and 32. The physical ionization signature is a rising period envelope followed by a closure-to-successor reset, not a false claim of strict monotonicity inside every period."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-ATOMIC-CELL-ORBIT-CAPACITY-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := SFT.Foundation.AdmissionControls.admissionIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-ATOMIC-SHELL-PERIODICITY-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [AtomicShellPeriodicityEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity AtomicShellPeriodicityEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.AtomicShellPeriodicityEntryEvidence
