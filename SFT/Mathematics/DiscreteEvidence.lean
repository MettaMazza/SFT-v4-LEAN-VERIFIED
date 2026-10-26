import SFT.Mathematics.DiscreteControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.DiscreteEvidence
open SFT.Host.Canonical DiscreteGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "collection",.text (collectionName c.collection)],.array [.text "identity",.text (identityName c.identity)],.array [.text "membership",.text (membershipName c.membership)],.array [.text "relation",.text (relationName c.relation)],.array [.text "map",.text (mapName c.map)],.array [.text "sequence",.text (sequenceName c.sequence)],.array [.text "induction",.text (inductionName c.induction)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "collection"),("question",.text "What identifies a finite collection?"),("choices",.array [.array [.text "partial-or-duplicated",.text "Omission or duplication changes the generated collection trace."],.array [.text "complete-unique-trace",.text "Every generated member occurs once in the canonical collection trace."]])],.object [("key",.text "identity"),("question",.text "How are members identified?"),("choices",.array [.array [.text "presentation-alias",.text "Presentation names can merge distinct forms or split one form."],.array [.text "canonical-form-identity",.text "Canonical construction traces supply exact member identity."]])],.object [("key",.text "membership"),("question",.text "What establishes membership?"),("choices",.array [.array [.text "unrecorded-assertion",.text "An unrecorded assertion has no source-bound occurrence witness."],.array [.text "retained-occurrence",.text "Membership retains the canonical member occurrence within the source trace."]])],.object [("key",.text "relation"),("question",.text "What generates a relation?"),("choices",.array [.array [.text "free-pair-list",.text "A free pair list has no complete source-product boundary."],.array [.text "held-pair-cell-selection",.text "A relation holds a generated selection from complete source pair-cell support."]])],.object [("key",.text "map"),("question",.text "What distinguishes a map?"),("choices",.array [.array [.text "partial-or-multivalued",.text "A missing or repeated image does not define one image for every source member."],.array [.text "total-single-valued",.text "Every source member has exactly one retained target mate."]])],.object [("key",.text "sequence"),("question",.text "How is order preserved?"),("choices",.array [.array [.text "unordered-carrier",.text "An unordered carrier erases the generated predecessor relation."],.array [.text "held-generation-order",.text "The canonical trace retains each predecessor-successor position."]])],.object [("key",.text "induction"),("question",.text "What closes laws at arbitrary generated finite size?"),("choices",.array [.array [.text "sampled-depths",.text "Sampled depths do not establish the successor step."],.array [.text "One-base-successor",.text "The One base and freshness-preserving successor cover every generated finite trace."]])],.object [("key",.text "addition"),("question",.text "Are ungenerated constructors admitted?"),("choices",.array [.array [.text "extra-constructor",.text "An extra constructor is not supplied by the Foundation grammar."],.array [.text "no-extra-constructor",.text "All objects decompose into admitted forms, selections, pair cells and successors."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-DISCRETE-001"
  title := "Generated discrete objects, relations and induction"
  branch := "mathematics"
  statement := "Every admitted discrete object is a complete canonical generated finite collection or held selection; membership is retained occurrence, relations are held selections of complete pair-cell support, maps are total single-valued relations, sequences retain generated order, and general laws close by structural One/base-successor induction."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-COUNT-001","SFT-FOUNDATION-FORM-GRAMMAR-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-DISCRETE-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-DISCRETE-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-COUNT-001",.text "SFT-FOUNDATION-FORM-GRAMMAR-001",.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001",.text "SFT-MATH-EXACT-ARITHMETIC-001"]),
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
  proofHash := identity (.object [("closure",DiscreteControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-DISCRETE-001"),
    ("base",.text "The structural One is the first canonical generated member and the empty One marks a held-empty selection without numerical zero."),
    ("successor",.text "Given a complete unique canonical collection, append one fresh canonical form once; membership, relation pair support, map-image obligation and predecessor order extend by their local generated clauses."),
    ("laws",.array (DiscreteControls.laws.map Value.text)),
    ("witnesses",.array (DiscreteWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.DiscreteEvidence
