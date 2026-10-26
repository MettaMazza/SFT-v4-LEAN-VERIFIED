import SFT.Foundation.RootEvidence
/-! Root candidate decisions connected to engine.py::_decision_violations.
The altered survivor flags implement the exact tampered_artifact premise. -/
namespace SFT.Foundation.Root.Gate

def censusCandidates : List SFT.Engine.Candidate :=
  candidates.map Evidence.generatedCandidateData

def decisions : List SFT.Engine.CandidateDecision :=
  candidates.map Evidence.candidateDecisionData

def tamperedDecisions : List SFT.Engine.CandidateDecision :=
  decisions.map fun d => { d with survives := true }

theorem originalSurvivorCount : (SFT.Engine.survivors decisions).length = 1 := rfl

theorem tamperedSurvivorCount : (SFT.Engine.survivors tamperedDecisions).length = 2 := rfl

theorem tamperedDecisionGateRejected :
    SFT.Engine.decisionViolations censusCandidates tamperedDecisions ≠ [] := by
  intro h
  have impossible := SFT.Engine.passingDecisionGateHasOneSurvivor _ _ h
  change 2 = 1 at impossible
  exact Nat.noConfusion impossible (fun h => Nat.noConfusion h)

end SFT.Foundation.Root.Gate
