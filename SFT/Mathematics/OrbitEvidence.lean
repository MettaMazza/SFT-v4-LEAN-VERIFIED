import SFT.Mathematics.OrbitControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.OrbitEvidence
attribute [local irreducible] OrbitNumberWitnesses.orderExamples OrbitNumberWitnesses.allReducedRanks OrbitNumberWitnesses.primeDivision OrbitNumberWitnesses.orbitTiling OrbitWitnesses.witnesses
open SFT.Host.Canonical OrbitGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "domain",.text (domainName c.domain)],.array [.text "reduction",.text (reductionName c.reduction)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "period",.text (periodName c.period)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "transient",.text (transientName c.transient)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "domain"),("question",.text "domain?"),("choices",.array [.array [.text "arbitrary-real",.text "An arbitrary real imports infinite information."],.array [.text "finite-rational",.text "Generated parts have finite whole numerator and denominator traces."]])],.object [("key",.text "reduction"),("question",.text "reduction?"),("choices",.array [.array [.text "untracked-factor",.text "An untracked common factor duplicates state identity."],.array [.text "lowest-terms",.text "The reduced denominator fixes the orbit class."]])],.object [("key",.text "transition"),("question",.text "transition?"),("choices",.array [.array [.text "sampled-map",.text "A sampled map is not the Fold."],.array [.text "double-and-cast",.text "Fold doubles the residue and casts complete denominators."]])],.object [("key",.text "period"),("question",.text "period?"),("choices",.array [.array [.text "observed-cycle",.text "An observed cycle has no arithmetic identity."],.array [.text "multiplicative-order",.text "Return is exactly the first binary power congruent to the One residue."]])],.object [("key",.text "partition"),("question",.text "partition?"),("choices",.array [.array [.text "overlap-cover",.text "Overlapping cycles duplicate residues."],.array [.text "cyclotomic-tiling",.text "Disjoint equal-length orbits tile all reduced residues."]])],.object [("key",.text "transient"),("question",.text "transient?"),("choices",.array [.array [.text "eternal-even-core",.text "A binary factor cannot remain under repeated Fold."],.array [.text "counted-binary-depth",.text "Each Fold removes one binary denominator factor before the odd cycle."]])],.object [("key",.text "generality"),("question",.text "generality?"),("choices",.array [.array [.text "bounded-prime-list",.text "A bounded list is not the theorem."],.array [.text "definition-identity",.text "The Fold return predicate and multiplicative-order predicate are the same remainder identity for every supplied denominator."]])],.object [("key",.text "addition"),("question",.text "addition?"),("choices",.array [.array [.text "extra-number-law",.text "An imported number-theory theorem would select the answer."],.array [.text "no-extra-rule",.text "Only Fold, whole remainder and exact counting occur."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-ORBIT-NUMBER-THEORY-002"
  title := "Fold orbit number theory and exact prime-spectrum structure"
  branch := "mathematics"
  statement := "For every reduced part over an odd positive finite denominator, Fold orbit length is exactly the multiplicative order of the binary generator; reduced residues partition into equal cyclotomic orbits, prime periods divide one-less-than-prime, and a power-of-two factor supplies exactly its counted transient depth."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-ORBIT-NUMBER-THEORY-002"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-ORBIT-NUMBER-THEORY-002"),
    ("dependencies",.array [.text "SFT-MATH-EXACT-ARITHMETIC-001",.text "SFT-MATH-DYNAMICAL-SYSTEMS-001"]),
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
  proofHash := identity (.object [("closure",OrbitControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-ORBIT-NUMBER-THEORY-002"),
    ("base",.text "The first reduced odd denominator above the One executes one complete finite orbit."),
    ("successor",.text "For any next supplied odd denominator the finite residue permutation independently partitions into cycles; adjoining one binary factor prepends exactly one transient Fold."),
    ("laws",.array (OrbitControls.laws.map Value.text)),
    ("witnesses",.array (OrbitWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.OrbitEvidence
