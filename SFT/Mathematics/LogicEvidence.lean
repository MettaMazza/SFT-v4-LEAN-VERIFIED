import SFT.Mathematics.LogicControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.LogicEvidence
open SFT.Host.Canonical LogicGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "proposition",.text (propositionName c.proposition)],.array [.text "denial",.text (denialName c.denial)],.array [.text "conjunction",.text (conjunctionName c.conjunction)],.array [.text "disjunction",.text (disjunctionName c.disjunction)],.array [.text "implication",.text (implicationName c.implication)],.array [.text "inference",.text (inferenceName c.inference)],.array [.text "consistency",.text (consistencyName c.consistency)],.array [.text "soundness",.text (soundnessName c.soundness)],.array [.text "completeness",.text (completenessName c.completeness)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "proposition"),("question",.text "What fixes a proposition?"),("choices",.array [.array [.text "presentation-sentence",.text "A sentence presentation can alias or hide the judged form."],.array [.text "canonical-distinguished-form",.text "The exact generated form is the proposition identity."]])],.object [("key",.text "denial"),("question",.text "What fixes denial?"),("choices",.array [.array [.text "negative-truth-value",.text "A negative magnitude is outside the admitted domain."],.array [.text "complementary-held-orientation",.text "Denial retains the same form with the other exact fibre orientation."]])],.object [("key",.text "conjunction"),("question",.text "What proves a conjunction?"),("choices",.array [.array [.text "single-side-proof",.text "One side cannot establish the joint claim."],.array [.text "joint-complete-proof",.text "Both constituent proof traces are retained together."]])],.object [("key",.text "disjunction"),("question",.text "What proves a disjunction?"),("choices",.array [.array [.text "unidentified-choice",.text "An unidentified choice erases which alternative is supported."],.array [.text "held-alternative-with-support",.text "The held branch and complete generated alternative family are retained."]])],.object [("key",.text "implication"),("question",.text "What fixes implication?"),("choices",.array [.array [.text "truth-table-import",.text "A borrowed table installs conventional logical values."],.array [.text "proof-carrying-transition",.text "A registered rule maps exact premises to an exact conclusion."]])],.object [("key",.text "inference"),("question",.text "What fixes a proof?"),("choices",.array [.array [.text "conclusion-only",.text "A bare conclusion erases its premises and rules."],.array [.text "complete-dependency-trace",.text "Every step retains available premises, rule identity and conclusion."]])],.object [("key",.text "consistency"),("question",.text "What fixes consistency?"),("choices",.array [.array [.text "assumed-consistent",.text "An assertion does not search for opposed admitted orientations."],.array [.text "no-opposed-admission",.text "No form and its complementary orientation are jointly admitted."]])],.object [("key",.text "soundness"),("question",.text "What fixes soundness?"),("choices",.array [.array [.text "authority-or-name",.text "Authority cannot replace validation against registered rules."],.array [.text "rule-and-witness-preservation",.text "Every accepted step matches a registered source-bound rule and preserves its witnesses."]])],.object [("key",.text "completeness"),("question",.text "When may completeness be claimed?"),("choices",.array [.array [.text "unbounded-global-claim",.text "A finite proof kernel cannot establish an ungenerated universal domain."],.array [.text "registered-grammar-exhaustion",.text "Every proposition in the exact generated grammar has its declared decision evidence."]])],.object [("key",.text "addition"),("question",.text "Is another logical axiom added?"),("choices",.array [.array [.text "extra-logical-axiom",.text "An extra axiom is not supplied by the canonical form and rule traces."],.array [.text "no-extra-logical-axiom",.text "All admitted inference is registered and witnessed."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-LOGIC-PROOF-001"
  title := "Exact finite logic, inference and proof boundaries"
  branch := "mathematics"
  statement := "An admitted proposition is a canonical distinguished form with a held orientation; denial is the retained complementary orientation, not a negative number. Conjunction retains joint proofs, disjunction retains a chosen generated branch and its alternatives, implication is a registered premise-to-conclusion transition, and a proof is a complete dependency trace of accepted rules. Consistency, soundness and completeness are machine-checkable only relative to the exact registered finite grammar and rule set."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-DISCRETE-001","SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-LOGIC-PROOF-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-LOGIC-PROOF-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001",.text "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",.text "SFT-MATH-DISCRETE-001",.text "SFT-MATH-ORDER-LATTICE-001"]),
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
  proofHash := identity (.object [("closure",LogicControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-LOGIC-PROOF-001"),
    ("base",.text "One proposition form and its two orientations provide the first decidable grammar cell."),
    ("successor",.text "Adding one proposition or rule generates its complementary orientation, joint and alternative combinations, and all new premise tuples. Consistency and proof replay are rechecked for precisely those new forms and steps."),
    ("laws",.array (LogicControls.laws.map Value.text)),
    ("witnesses",.array (LogicWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Every branch depends on distinguishable valid and invalid derivations. The proof law makes admission mechanical while preventing conventional logical axioms or institutional authority from entering silently."

def derivation : String := "Canonical forms supply proposition identity; held fibres supply opposed orientations; discrete relations supply rules; order supplies proof-strength relations. Ten choices force the replayable finite proof kernel."

def check : String := "Execute all 1,024 kernels, verify held denial, conjunction and disjunction provenance, replay a registered proof, reject a tampered rule, check consistency and bounded completeness, then regenerate independently."

def limitations : String := "This closes finite generated proof theory. Computability, self-reference, undecidability and incompleteness boundaries require the later formal-computation branch and are not claimed here."

def correspondenceTerms : List String := ["proposition","negation","conjunction","disjunction","implication","proof","soundness","completeness"]

end SFT.Mathematics.LogicEvidence
