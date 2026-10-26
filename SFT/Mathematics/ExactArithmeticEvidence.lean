import SFT.Mathematics.ExactArithmeticControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.ExactArithmeticEvidence
open SFT.Host.Canonical ExactArithmeticGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "coverage",.text (coverageName c.coverage)],.array [.text "junction",.text (junctionName c.junction)],.array [.text "product",.text (productName c.product)],.array [.text "quotient",.text (quotientName c.quotient)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "difference",.text (differenceName c.difference)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "coverage"),("question",.text "Does the value retain the complete generated trace?"),("choices",.array [.array [.text "partial-trace",.text "A partial trace omits an admitted generated occurrence."],.array [.text "complete-trace",.text "The complete trace retains every generated occurrence once."]])],.object [("key",.text "junction"),("question",.text "How are positive traces combined?"),("choices",.array [.array [.text "overlap-merge",.text "Overlap repeats a shared occurrence and loses disjoint provenance."],.array [.text "disjoint-junction",.text "Disjoint junction preserves both complete positive traces."]])],.object [("key",.text "product"),("question",.text "How is repeated allocation constructed?"),("choices",.array [.array [.text "repeated-unlabelled",.text "Unlabelled repetition erases the two source coordinates."],.array [.text "pair-cell-refinement",.text "Each generated left label is paired once with each generated right label."]])],.object [("key",.text "quotient"),("question",.text "How is an exact division-like relation witnessed?"),("choices",.array [.array [.text "rounded-measure",.text "A rounded or decimal value is measured rather than exact derivational evidence."],.array [.text "common-refinement-pairing",.text "A complete common refinement and bijection witnesses the exact part relation."]])],.object [("key",.text "comparison"),("question",.text "How are magnitudes compared without an imported order?"),("choices",.array [.array [.text "borrowed-scalar-order",.text "A borrowed scalar order imports the answer-producing number model."],.array [.text "complete-trace-pairing",.text "Pairing identifies equality and a held unmatched trace identifies orientation."]])],.object [("key",.text "difference"),("question",.text "How is an unmatched remainder represented?"),("choices",.array [.array [.text "signed-magnitude",.text "A signed magnitude installs forbidden negative quantity."],.array [.text "held-oriented-remainder",.text "A distinct held label records which trace retains the unmatched positive remainder."]])],.object [("key",.text "generality"),("question",.text "What closes all generated finite depths?"),("choices",.array [.array [.text "bounded-answer-table",.text "A finite answer table has no depth-independent arithmetic certificate."],.array [.text "base-successor-induction",.text "The One base and generated successor preserve each operation at every finite depth."]])],.object [("key",.text "addition"),("question",.text "Is any rule added beyond the dependencies?"),("choices",.array [.array [.text "has-extra-rule",.text "An extra scale, constant or field is not supplied by the dependencies."],.array [.text "no-extra-rule",.text "The kernel uses only admitted traces, parts, refinement, pairing and held labels."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-EXACT-ARITHMETIC-001"
  title := "Exact arithmetic and generated number structure"
  branch := "mathematics"
  statement := "Every admitted arithmetic relation on generated positive finite traces and exact parts has one parameter-free structural kernel: disjoint junction for addition, complete pair-cell refinement for product, finite repeated composition for powers, common-refinement pairing for exact quotient and comparison, and held orientation for unmatched remainder; no semantic zero, negative, irrational, floating or completed-infinite value enters the law."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-PART-001","SFT-FOUNDATION-PART-EQUIVALENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-EXACT-ARITHMETIC-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-EXACT-ARITHMETIC-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-COUNT-001",.text "SFT-FOUNDATION-PART-001",.text "SFT-FOUNDATION-PART-EQUIVALENCE-001",.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001"]),
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
  proofHash := identity (.object [("closure",ExactArithmeticControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-EXACT-ARITHMETIC-001"),
    ("base",.text "The structural One supplies the first nonempty trace and exact self-whole."),
    ("successor",.text "Appending one fresh generated occurrence preserves complete trace identity; junction appends it once, pair-cell refinement appends one labelled cell per opposite trace element, and pairing either extends with one mate or records the unmatched held remainder."),
    ("laws",.array (ExactArithmeticControls.laws.map Value.text)),
    ("witnesses",.array (ExactArithmeticWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.ExactArithmeticEvidence
