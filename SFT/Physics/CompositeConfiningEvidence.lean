import SFT.Physics.CompositeConfiningControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CompositeConfiningEvidence
open SFT.Host.Canonical CompositeConfiningGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "scope",.text (scopeName c.scope)],.array [.text "support",.text (supportName c.support)],.array [.text "modes",.text (modesName c.modes)],.array [.text "action",.text (actionName c.action)],.array [.text "confinement",.text (confinementName c.confinement)],.array [.text "orbits",.text (orbitsName c.orbits)],.array [.text "antipodes",.text (antipodesName c.antipodes)],.array [.text "pair_count",.text (pair_countName c.pair_count)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "scope"),("question",.text "Which sector cases does the law cover?"),("choices",.array [.array [.text "five-selected-case-table",.text "A selected table does not prove the next even sector."],.array [.text "every-generated-even-sector",.text "The odd-predecessor argument applies to every positive finite even successor beyond two."]])],.object [("key",.text "support"),("question",.text "What support does a sector hold?"),("choices",.array [.array [.text "borrowed-or-measured-denominator",.text "A named or measured denominator can select the orbit."],.array [.text "positive-predecessor-denominator",.text "The unique predecessor d followed by One reassembles sector s."]])],.object [("key",.text "modes"),("question",.text "Which standing modes enter?"),("choices",.array [.array [.text "selected-mode-subset",.text "A subset cannot establish exhaustive confinement."],.array [.text "all-nonempty-predecessor-labels",.text "Every positive label from One through the predecessor of d is generated once."]])],.object [("key",.text "action"),("question",.text "How does Fold move a mode?"),("choices",.array [.array [.text "selected-orbit-permutation",.text "A listed permutation imports its answer."],.array [.text "double-and-cast-denominator-wholes",.text "Fold pairs the label and casts only complete held denominators."]])],.object [("key",.text "confinement"),("question",.text "Why can no mode escape?"),("choices",.array [.array [.text "finite-table-assertion",.text "A table alone does not close arbitrary successor depth."],.array [.text "odd-support-exact-inverse",.text "The half-successor (d+1)/2 is an exact inverse of doubling on odd support."]])],.object [("key",.text "orbits"),("question",.text "How is recurrence support organized?"),("choices",.array [.array [.text "named-or-overlapping-orbits",.text "Named or overlapping rows omit a complete partition proof."],.array [.text "complete-disjoint-first-return-partition",.text "Bijection on finite support partitions every label into one first-return orbit."]])],.object [("key",.text "antipodes"),("question",.text "How do complementary modes close?"),("choices",.array [.array [.text "borrowed-pairing-rule",.text "A borrowed pair rule does not prove exhaustiveness."],.array [.text "unique-positive-One-complements",.text "Each k has the unique positive complement d-k and odd d forbids a self-pair."]])],.object [("key",.text "pair_count"),("question",.text "What forces the pair count?"),("choices",.array [.array [.text "ambiguous-sector-minus-one-over-two",.text "That notation is not a whole count for even s."],.array [.text "predecessor-of-denominator-over-two",.text "The d-1 nonempty labels divide exactly into (d-1)/2 pairs, equivalently (s-2)/2."]])],.object [("key",.text "coupling"),("question",.text "What share is held by the sector?"),("choices",.array [.array [.text "measured-or-fitted-coupling",.text "Measurement cannot select a holding law."],.array [.text "all-but-one-predecessor-over-sector",.text "Holding d of the s complete positions forces d/s with no free coefficient."]])],.object [("key",.text "comparison"),("question",.text "What may external evidence establish?"),("choices",.array [.array [.text "unobserved-cases-counted-as-confirmed",.text "A standing prediction is not a measurement."],.array [.text "sealed-eight-anchor-and-explicit-standing-cases",.text "The known eight-carrier anchor is inherited post-derivation; every other case remains explicitly testable."]])],.object [("key",.text "extension"),("question",.text "May another orbit or correction be inserted?"),("choices",.array [.array [.text "free-orbit-or-coupling-correction",.text "An inserted row or correction is a free parameter."],.array [.text "no-extra-rule",.text "Complete labels, Fold action, complements and held support exhaust the construction."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031"
  title := "Depth-independent composite confining-sector orbit law"
  branch := "physics"
  statement := "Every generated even Fold sector s beyond the binary fibre holds the odd positive predecessor d=s-1. Its complete nonempty standing modes are the d-1 labels k/d. Fold doubling has the exact inverse (d+1)/2 and therefore permutes this support without changing denominator, forcing a finite disjoint first-return orbit partition. The modes form exactly (d-1)/2=(s-2)/2 positive antipodal pairs whose members reassemble the One, and the unique all-but-one holding coupling is d/s. Consequently sectors 8, 12, 18, 24 and 30 have respectively 6, 10, 16, 22 and 28 modes; orbit-size partitions (3,3), (10), (8,8), (11,11) and (28); pair counts 3, 5, 8, 11 and 14; and couplings 7/8, 11/12, 17/18, 23/24 and 29/30."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-PHYS-FOLD-UNIVERSE-TRANSPORT-TERMINAL-024", "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003", "SFT-PHYS-VALIDATION-FORCE-SECTOR-ANCHORS-003", "SFT-PHYS-INTERACTION-UNIFICATION-TERMINAL-025"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing,.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [CompositeConfiningControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity CompositeConfiningControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.CompositeConfiningEvidence
