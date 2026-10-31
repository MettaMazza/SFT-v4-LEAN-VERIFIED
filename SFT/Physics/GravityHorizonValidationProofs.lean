import SFT.Physics.GravityHorizonValidation
set_option maxRecDepth 20000
namespace SFT.Physics.GravityHorizonValidation
open SFT.Host.Canonical GravityHorizonExperiment

theorem sourceMismatchRejects (bytes : ByteArray) (derivationSeal host implementation : String)
    (before after : Snapshot) (changed : sourceMatches bytes = false) :
    validate bytes derivationSeal host implementation before after =
      .error "ValueError: external measurement snapshot differs from registration" := by
  unfold validate
  rw [changedSourceRejected bytes changed]
  rfl

theorem sealBindsExecution (derivationSeal : String) (execution : CapabilityExecution.Execution) :
    (sealPrediction none derivationSeal execution).map (fun saved =>
      (saved.experiment,saved.predictionHash,saved.traceHash,saved.envelopeHash)) =
    .ok (experimentId,execution.outputHash,execution.traceHash,identity (envelope derivationSeal)) := rfl

theorem emptyPremiseRejected : inputValues "" = .error "held labels require a named family and label" := rfl

theorem programDocumentRetained : .object programFields = programDocument := rfl

end SFT.Physics.GravityHorizonValidation
