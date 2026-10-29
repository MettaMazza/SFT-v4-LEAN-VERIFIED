import SFT.Physics.LeptonCustody
open SFT.Physics LeptonPrediction LeptonExperiment LeptonCustody SFT.Host.Canonical
set_option maxRecDepth 20000

def must {α : Type} : Except String α → IO α
 | .error e => throw (IO.userError e)
 | .ok x => pure x

def status {α : Type} : Except String α → Value
 | .error e => .text e
 | .ok _ => .text "ok"

def main (args : List String) : IO Unit := do
 let derivationSeal := args.headD ""
 let bytes ← IO.FS.readBinFile ((args.drop 1).headD "")
 let execution ← must (executionValue derivationSeal)
 let prediction ← must (nativeSeal derivationSeal)
 let vault := registeredVault derivationSeal
 let (used,released) ← must (release vault prediction)
 let checks := [
  ("exchange",status (verify vault.commitment released prediction)),
  ("context",status (measurementContext (some prediction) released.values)),
  ("source",status (checkSource bytes)),
  ("tampered_source",status (checkSource (bytes.push 32))),
  ("preseal",status (measurementContext none released.values)),
  ("repeated_release",status (release used prediction)),
  ("reseal",status (sealPrediction (some prediction) derivationSeal (.label "physical-observation" expectedLabel) [])),
  ("wrong_experiment",status (release vault {prediction with experiment := "changed"})),
  ("wrong_envelope",status (release vault {prediction with envelopeHash := "changed"})),
  ("changed_content",status (verify vault.commitment {released with nonce := "changed"} prediction)),
  ("missing_target",status (verify vault.commitment {released with values := []} prediction)),
  ("wrong_custodian",status (verify vault.commitment {released with custodian := "changed"} prediction)),
  ("wrong_release_seal",status (verify vault.commitment {released with predictionSealHash := "changed"} prediction)),
  ("wrong_release_hash",status (verify vault.commitment {released with releaseHash := "changed"} prediction)),
  ("missing_context_target",status (measurementContext (some prediction) []))]
 IO.println (render (.object [
  ("registration",registration),("registration_hash",.text registrationHash),
  ("program_document",programDocument),("execution",execution),
  ("envelope",envelope derivationSeal),("prediction_seal",sealValue prediction),
  ("commitment",commitmentValue vault.commitment),("release",releaseValue released),
  ("checks",.object checks)]))
