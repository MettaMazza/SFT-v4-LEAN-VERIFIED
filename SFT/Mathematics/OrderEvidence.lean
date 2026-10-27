import SFT.Mathematics.OrderControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.OrderEvidence
open SFT.Host.Canonical OrderGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "order",.text (orderName c.order)],.array [.text "comparability",.text (comparabilityName c.comparability)],.array [.text "bounds",.text (boundsName c.bounds)],.array [.text "meet",.text (meetName c.meet)],.array [.text "join",.text (joinName c.join)],.array [.text "maps",.text (mapsName c.maps)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "carrier"),("question",.text "What fixes ordered objects?"),("choices",.array [.array [.text "presentation-carrier",.text "Presentation aliases do not fix exact ordered identity."],.array [.text "canonical-carrier",.text "Every ordered form has canonical generated identity."]])],.object [("key",.text "relation"),("question",.text "What fixes comparison?"),("choices",.array [.array [.text "borrowed-scalar-comparison",.text "A scalar comparison imports an answer-producing order."],.array [.text "held-pair-relation",.text "Each comparison is a retained generated carrier pair."]])],.object [("key",.text "order"),("question",.text "What makes the relation an order?"),("choices",.array [.array [.text "named-order",.text "A name does not establish reflexivity, antisymmetry and transitivity."],.array [.text "exhaustive-partial-order-witness",.text "Every required relation cell and composite is checked."]])],.object [("key",.text "comparability"),("question",.text "When is the order total?"),("choices",.array [.array [.text "assumed-totality",.text "Partial orders can contain incomparable forms."],.array [.text "pairwise-totality-witness",.text "Totality is recorded only when every generated pair is comparable."]])],.object [("key",.text "bounds"),("question",.text "How are bounds found?"),("choices",.array [.array [.text "selected-bound",.text "Selecting a familiar candidate can omit another held condition."],.array [.text "complete-bound-selection",.text "Every carrier form is tested against every held target."]])],.object [("key",.text "meet"),("question",.text "When does a meet exist?"),("choices",.array [.array [.text "assumed-meet",.text "A lower bound need not be greatest or unique."],.array [.text "unique-greatest-lower-witness",.text "Exactly one lower bound is above every other lower bound."]])],.object [("key",.text "join"),("question",.text "When does a join exist?"),("choices",.array [.array [.text "assumed-join",.text "An upper bound need not be least or unique."],.array [.text "unique-least-upper-witness",.text "Exactly one upper bound is below every other upper bound."]])],.object [("key",.text "maps"),("question",.text "What makes an order map lawful?"),("choices",.array [.array [.text "arbitrary-map",.text "An arbitrary map can reverse a retained comparison."],.array [.text "comparison-preserving-map",.text "Every source relation cell maps to a target relation cell."]])],.object [("key",.text "addition"),("question",.text "Is another order axiom added?"),("choices",.array [.array [.text "extra-order-axiom",.text "An extra totality or completeness axiom is not structurally forced."],.array [.text "no-extra-order-axiom",.text "Only exhaustively witnessed order properties are admitted."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-ORDER-LATTICE-001"
  title := "Exact finite order and conditional lattice structure"
  branch := "mathematics"
  statement := "An admitted finite order is a held carrier relation whose reflexive, antisymmetric and transitive cells are exhaustively witnessed. Totality is admitted only when every generated pair is comparable. Lower and upper bounds are complete relation selections; meet and join exist only as unique greatest-lower and least-upper witnesses, and monotone maps preserve every retained comparison."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-ALGEBRA-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-ORDER-LATTICE-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-ORDER-LATTICE-001"),
    ("dependencies",.array [.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-DISCRETE-001",.text "SFT-MATH-ALGEBRA-001"]),
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
  proofHash := identity (.object [("closure",OrderControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-ORDER-LATTICE-001"),
    ("base",.text "The One carrier has its identity relation and One is both unique lower and upper bound of itself."),
    ("successor",.text "Adding one fresh canonical form generates all comparisons to prior forms. Order closure, comparability, bounds and extremal uniqueness are rechecked only for pairs and composites touching the fresh form."),
    ("laws",.array (OrderControls.laws.map Value.text)),
    ("witnesses",.array (OrderWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.OrderEvidence
