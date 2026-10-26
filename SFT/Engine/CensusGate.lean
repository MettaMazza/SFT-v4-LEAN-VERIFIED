import SFT.Engine.EvidenceGates
/-! Source engine/model.py CandidateCensus and engine.py::_census_violations.
The signed Int field preserves negative/zero cardinality rejection. Python bool
values injected into int fields require importer validation outside this typed domain. -/
namespace SFT.Engine

structure CandidateCensus where
  generationRule : String
  grammarBoundary : String
  expectedCardinality : Int
  completenessCertificateHash : String
  candidates : List Candidate

def censusValue (c : CandidateCensus) : SFT.Host.Canonical.Value := .object [
  ("generation_rule", .text c.generationRule), ("grammar_boundary", .text c.grammarBoundary),
  ("expected_cardinality", .integer c.expectedCardinality),
  ("completeness_certificate_hash", .text c.completenessCertificateHash),
  ("candidates", .array (c.candidates.map candidateValue))]

def duplicateIdentifiers : List String → Bool
  | [] => false
  | x::xs => xs.any (SFT.Host.Text.equal x) || duplicateIdentifiers xs

def positiveCardinality : Int → Bool
  | .ofNat 0 => false
  | .ofNat (_+1) => true
  | .negSucc _ => false

def cardinalityMatches (n : Nat) : Int → Bool
  | .ofNat k => n == k
  | .negSucc _ => false

def censusViolations (c : CandidateCensus) : List String := collectViolations [
  (blank c.generationRule, "candidate generation rule is missing"),
  (blank c.grammarBoundary, "candidate grammar boundary is missing"),
  (!(positiveCardinality c.expectedCardinality), "expected candidate cardinality must be a positive count"),
  (!(cardinalityMatches c.candidates.length c.expectedCardinality), "generated candidate count does not match the registered cardinality"),
  (duplicateIdentifiers (c.candidates.map Candidate.candidateId), "candidate census contains duplicate identifiers"),
  (c.candidates.any (fun x => blank x.candidateId || blank x.exactForm), "candidate identifiers and exact forms must be named"),
  (c.candidates.any (fun x => !(isSha256Identity x.traceHash)), "every candidate requires a canonical trace hash"),
  (!(isSha256Identity c.completenessCertificateHash), "candidate census lacks a completeness certificate hash")]

theorem passingCensusHasGenerationRule (c : CandidateCensus) (h : censusViolations c = []) :
    blank c.generationRule = false := collectEmptyHeadFalse _ _ _ h

theorem passingCensusHasBoundary (c : CandidateCensus) (h : censusViolations c = []) :
    blank c.grammarBoundary = false := collectEmptyHeadFalse _ _ _ (collectEmptyTail _ _ _ h)

theorem passingCensusHasPositiveCount (c : CandidateCensus) (h : censusViolations c = []) :
    positiveCardinality c.expectedCardinality = true :=
  trueOfNotFalse _ (collectEmptyHeadFalse _ _ _ (collectEmptyTail _ _ _ (collectEmptyTail _ _ _ h)))

theorem passingCensusMatchesCount (c : CandidateCensus) (h : censusViolations c = []) :
    (cardinalityMatches c.candidates.length c.expectedCardinality) = true :=
  trueOfNotFalse _ (collectEmptyHeadFalse _ _ _ (collectEmptyTail _ _ _
    (collectEmptyTail _ _ _ (collectEmptyTail _ _ _ h))))

theorem passingCensusNoDuplicateIdentifiers (c : CandidateCensus) (h : censusViolations c = []) :
    duplicateIdentifiers (c.candidates.map Candidate.candidateId) = false :=
  collectEmptyHeadFalse _ _ _ (collectEmptyTail _ _ _ (collectEmptyTail _ _ _
    (collectEmptyTail _ _ _ (collectEmptyTail _ _ _ h))))

theorem positiveCardinalityHasSuccessor (z : Int) (h : positiveCardinality z = true) :
    ∃ n : Nat, z = Int.ofNat (Nat.succ n) := by
  cases z with
  | negSucc n => cases h
  | ofNat n =>
    cases n with
    | zero => cases h
    | succ n => exact ⟨n, rfl⟩

theorem passingCensusPositiveWitness (c : CandidateCensus) (h : censusViolations c = []) :
    ∃ n : Nat, c.expectedCardinality = Int.ofNat (Nat.succ n) :=
  positiveCardinalityHasSuccessor _ (passingCensusHasPositiveCount c h)

end SFT.Engine
