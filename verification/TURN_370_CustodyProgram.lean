import SFT.Physics.TargetCustody
open SFT.Physics.TargetCustody SFT.Host.Canonical
set_option maxRecDepth 20000
def resultText : Except String Unit → Value
 | .ok _ => .text "ok"
 | .error e => .text e
def runCase (ex cu : String) (values : List (String × Value)) (nonce env : String) : Value :=
 match createVault ex cu values nonce env with
 | .error e => .object [("error",.text e)]
 | .ok vault =>
   let prediction : PredictionSeal := ⟨ex,"prediction","trace",env,"seal"⟩
   match release vault prediction with
   | .error e => .object [("error",.text e)]
   | .ok (next,r) => .object [("commitment",commitmentValue vault.commitment),("release",releaseValue r),
       ("verify",resultText (verify vault.commitment r prediction)),
       ("repeat",match release next prediction with | .error e => .text e | .ok _ => .text "ok"),
       ("tamper",resultText (verify vault.commitment {r with custodian := "changed"} prediction)),
       ("tamper_all",.array [
         resultText (verify vault.commitment {r with experiment := "changed"} prediction),
         resultText (verify vault.commitment {r with predictionSealHash := "changed"} prediction),
         resultText (verify vault.commitment r {prediction with envelopeHash := "changed"}),
         resultText (verify vault.commitment {r with values := []} prediction),
         resultText (verify vault.commitment {r with nonce := "changed"} prediction),
         resultText (verify vault.commitment {r with targetHash := "changed"} prediction),
         resultText (verify vault.commitment {r with releaseHash := "changed"} prediction),
         resultText (verify {vault.commitment with targetIds := []} r prediction),
         resultText (verify {vault.commitment with targetHash := "changed"} r prediction),
         resultText (verify vault.commitment {r with experiment := "changed",custodian := "changed",releaseHash := "changed"} prediction)])]
def main : IO Unit := do
  IO.println (render (runCase "exp" "custodian" [("z",(.array [(.text "held"),(.integer (2))])),("a",(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [("target",(.text "record"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "Ω" "custodian" [("β",(.integer (-4))),("a",(.text "\n"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "" "custodian" [("z",(.array [(.text "held"),(.integer (2))])),("a",(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase " \t" "custodian" [("z",(.array [(.text "held"),(.integer (2))])),("a",(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "" [("z",(.array [(.text "held"),(.integer (2))])),("a",(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [("z",(.array [(.text "held"),(.integer (2))])),("a",(.object [("exact",(.boolean true)),("empty",(.null))]))] "" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [("z",(.array [(.text "held"),(.integer (2))])),("a",(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:x"))
  IO.println (render (runCase "exp" "custodian" [] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [("",(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [(" \t",(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
