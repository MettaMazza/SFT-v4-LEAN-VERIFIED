import SFT.Engine.CensusGate

/-! Source: claims/SFT-MAT-SEMI-JUNCTION-001/independent_validator.py,
76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. The input is the source engine's
typed sealed-record domain; JSON loading and Python type errors are not
reinterpreted as validation failures. In particular, repeated decision keys
retain their last value, while repeated control kinds are permitted. -/
namespace SFT.Materials.JunctionIndependentValidator
open SFT.Engine SFT.Host SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def claimId : String := "SFT-MAT-SEMI-JUNCTION-001"

def domains : List (List String) := [
 ["carrier-erased-or-answer-only", "opposed-doped-region-carrier"],
 ["relation-imported-fitted-or-erased", "cross-interface-carrier-transfer"],
 ["organization-collapsed", "space-charge-and-field-retained"],
 ["observation-boundary-unrecorded", "equilibrium-and-bias-bounded"],
 ["result-without-state-transition-record", "complete-state-transition-boundary-trace"],
 ["authority-or-target-selected-law", "root-bound-forward-forcing"],
 ["single-specimen-or-instance-lookup", "positive-finite-successor-closure"],
 ["free-fit-exception-or-extra-rule", "no-extra-rule"]]

def productRows : List (List String) → List (List String)
 | [] => [[]]
 | choices :: rest => choices.flatMap (fun choice => (productRows rest).map (choice :: ·))

def generated : List String := (productRows domains).map (Text.intercalate "__")

def survivor : String := "opposed-doped-region-carrier__cross-interface-carrier-transfer__space-charge-and-field-retained__equilibrium-and-bias-bounded__complete-state-transition-boundary-trace__root-bound-forward-forcing__positive-finite-successor-closure__no-extra-rule"

structure Sealed where
 claim : String
 census : CandidateCensus
 decisions : List CandidateDecision
 closure : ClosureEvidence
 controls : List ControlResult
 sealHash : String

-- Python's dictionary comprehension overwrites an earlier value for the same
-- key. List ordering here is private: dictionary equality ignores key order.
def putDecision (held : List (String × Bool)) (row : CandidateDecision) : List (String × Bool) :=
 (held.filter (fun prior => !Text.equal prior.1 row.candidateId)) ++ [(row.candidateId,row.survives)]

def decisionMap (rows : List CandidateDecision) : List (String × Bool) := rows.foldl putDecision []

def decisionsMatch (held : List (String × Bool)) : Bool :=
 held.length == generated.length && generated.all (fun id =>
  match held.find? (fun row => Text.equal row.1 id) with
  | none => false
  | some row => row.2 == Text.equal id survivor)

def passed (sealed : Sealed) : Bool :=
 let received := sealed.census.candidates.map Candidate.candidateId
 let decisions := decisionMap sealed.decisions
 Text.equal sealed.claim claimId &&
 sameIdentifiers received generated &&
 cardinalityMatches generated.length sealed.census.expectedCardinality &&
 (!duplicateIdentifiers received && received.length == generated.length) &&
 decisionsMatch decisions &&
 (decisions.filter (fun row => row.2)).length == 1 &&
 depthIndependent sealed.closure.scope &&
 sealed.closure.minimalityPassed && sealed.closure.namedShapeUniquenessPassed &&
 ([ControlKind.falsePremise,.tamperedSource,.tamperedArtifact,.boundary].all
   (fun kind => hasKind kind sealed.controls)) &&
 sealed.controls.all ControlResult.passed

def certificate (sealed : Sealed) : Value :=
 let accepted := passed sealed
 .object [
  ("validated_seal_hash",.text sealed.sealHash),
  ("recomputed_from_declared_inputs",.boolean true),
  ("passed",.boolean accepted),
  ("certificate",.object [
   ("claim_id",.text claimId),
   ("candidate_count",.integer (Int.ofNat generated.length)),
   ("survivor",if accepted then .text survivor else .null)])]

theorem generatedCardinality : generated.length = 256 := rfl

theorem wrongClaimRejected (sealed : Sealed)
 (different : Text.equal sealed.claim claimId = false) : passed sealed = false := by
 unfold passed
 rw [different]
 rfl

end SFT.Materials.JunctionIndependentValidator
