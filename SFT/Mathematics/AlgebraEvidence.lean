import SFT.Mathematics.AlgebraControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.AlgebraEvidence
open SFT.Host.Canonical AlgebraGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "operation",.text (operationName c.operation)],.array [.text "closure",.text (closureName c.closure)],.array [.text "identity",.text (identityName c.identity)],.array [.text "association",.text (associationName c.association)],.array [.text "return",.text (returnsName c.returns)],.array [.text "properties",.text (propertiesName c.properties)],.array [.text "maps",.text (mapsName c.maps)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "carrier"),("question",.text "What fixes the algebraic carrier?"),("choices",.array [.array [.text "partial-or-aliased-carrier",.text "Omission or aliasing changes which operation inputs exist."],.array [.text "complete-canonical-carrier",.text "Every generated carrier form occurs once with canonical identity."]])],.object [("key",.text "operation"),("question",.text "What fixes an operation?"),("choices",.array [.array [.text "partial-operation-sample",.text "A partial sample does not assign every generated input pair."],.array [.text "complete-single-valued-table",.text "Every ordered carrier pair has exactly one retained result."]])],.object [("key",.text "closure"),("question",.text "Where may an operation result lie?"),("choices",.array [.array [.text "external-result",.text "An external result silently enlarges the registered carrier."],.array [.text "carrier-closed-result",.text "Every result is a canonical member of the same carrier."]])],.object [("key",.text "identity"),("question",.text "How is identity established?"),("choices",.array [.array [.text "named-identity",.text "A name alone does not prove left and right preservation."],.array [.text "exhaustive-identity-witness",.text "One carrier form preserves every member on both sides."]])],.object [("key",.text "association"),("question",.text "How is association established?"),("choices",.array [.array [.text "assumed-parenthesis-law",.text "An assumed equation imports an algebraic axiom."],.array [.text "complete-triple-witness",.text "Every carrier triple has equal canonical flattened composites."]])],.object [("key",.text "return"),("question",.text "How are inverse-like returns represented?"),("choices",.array [.array [.text "signed-inverse-value",.text "A signed magnitude imports negative quantity."],.array [.text "unique-held-return-mate",.text "A retained complementary carrier mate returns on both sides to identity."]])],.object [("key",.text "properties"),("question",.text "When are special properties admitted?"),("choices",.array [.array [.text "property-by-name",.text "A familiar structure name cannot supply commutation or return."],.array [.text "property-by-exhaustive-witness",.text "Each property is registered only after every required carrier tuple passes."]])],.object [("key",.text "maps"),("question",.text "What makes a structure map lawful?"),("choices",.array [.array [.text "arbitrary-carrier-map",.text "An arbitrary map can erase the operation relation."],.array [.text "operation-preserving-map",.text "The complete image relation commutes with every source operation cell."]])],.object [("key",.text "addition"),("question",.text "Is another algebraic law added?"),("choices",.array [.array [.text "extra-algebraic-axiom",.text "An extra axiom is not forced by the registered operation traces."],.array [.text "no-extra-algebraic-axiom",.text "All admitted properties have explicit generated witnesses."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-ALGEBRA-001"
  title := "Generated finite algebraic structures"
  branch := "mathematics"
  statement := "An admitted finite algebraic structure is a complete canonical carrier with a complete, single-valued, closed pair-cell operation relation. Identity, associative composition, reversible return mates, commutation, substructure and structure-preserving maps are admitted exactly when their exhaustive carrier witnesses pass; none is installed as an ungenerated axiom."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-ALGEBRA-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-ALGEBRA-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001",.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-DISCRETE-001"]),
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
  proofHash := identity (.object [("closure",AlgebraControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-ALGEBRA-001"),
    ("base",.text "The One carrier has one pair cell, its result remains One, and identity and association coincide."),
    ("successor",.text "Adding one fresh carrier form generates exactly its left, right and self pair cells. A proposed extension is admitted only after results remain in the extended carrier and every newly formed identity, triple, return and map obligation is checked."),
    ("laws",.array (AlgebraControls.laws.map Value.text)),
    ("witnesses",.array (AlgebraWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.AlgebraEvidence
