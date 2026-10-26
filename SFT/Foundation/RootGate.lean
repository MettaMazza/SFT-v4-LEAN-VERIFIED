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

def closure : SFT.Engine.ClosureEvidence :=
  Evidence.closureEvidenceData (candidates.map Evidence.candidateDecision)

def noMinimalityClosure : SFT.Engine.ClosureEvidence := { closure with minimalityPassed := false }

def noGeneralityClosure : SFT.Engine.ClosureEvidence := { closure with generalityCertificateHash := none }

theorem noMinimalityRejected : SFT.Engine.closureViolations noMinimalityClosure ≠ [] := by
  intro h
  have impossible := SFT.Engine.passingClosureHasMinimality _ h
  exact Bool.noConfusion impossible

theorem noGeneralityRejected : SFT.Engine.closureViolations noGeneralityClosure ≠ [] := by
  intro h
  have impossible := SFT.Engine.passingDepthIndependentHasCertificate noGeneralityClosure rfl h
  exact Bool.noConfusion impossible

def failedControls (sourceHash : String) : List SFT.Engine.ControlResult :=
  (Evidence.runControlsData sourceHash).map fun c => { c with passed := false }

theorem failedControlsRejected (sourceHash : String) :
    SFT.Engine.controlViolations (failedControls sourceHash) ≠ [] := by
  intro h
  have impossible := SFT.Engine.passingControlsAllPassed _ h
  exact Bool.noConfusion impossible

end SFT.Foundation.Root.Gate
