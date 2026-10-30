import SFT.Physics.TargetCustodyInputs
open SFT.Physics.TargetCustody SFT.Physics.TargetCustodyInputs SFT.Host.Canonical
set_option maxRecDepth 20000
def resultText : Except String Unit → Value
 | .ok _ => .text "ok"
 | .error e => .text e
def runCase (ex cu : String) (values : List (Value × Value)) (nonce env : String) : Value :=
 match createVaultInput ex cu values nonce env with
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
  IO.println (render (runCase "exp" "custodian" [((.text "z"),(.array [(.text "held"),(.integer (2))])),((.text "a"),(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.text "target"),(.text "record"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "Ω" "custodian" [((.text "β"),(.integer (-4))),((.text "a"),(.text "\n"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "" "custodian" [((.text "z"),(.array [(.text "held"),(.integer (2))])),((.text "a"),(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase " \t" "custodian" [((.text "z"),(.array [(.text "held"),(.integer (2))])),((.text "a"),(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "" [((.text "z"),(.array [(.text "held"),(.integer (2))])),((.text "a"),(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.text "z"),(.array [(.text "held"),(.integer (2))])),((.text "a"),(.object [("exact",(.boolean true)),("empty",(.null))]))] "" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.text "z"),(.array [(.text "held"),(.integer (2))])),((.text "a"),(.object [("exact",(.boolean true)),("empty",(.null))]))] "nonce" "sha256:x"))
  IO.println (render (runCase "exp" "custodian" [] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.text ""),(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.text " \t"),(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.integer (2)),(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.boolean false),(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.null),(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
  IO.println (render (runCase "exp" "custodian" [((.text "ok"),(.text "held")),((.integer (3)),(.text "bad"))] "nonce" "sha256:aff9dd0e644782b6d9bfa7cf2cdf5892a1a7c658ecb4bc6da7dbe13347204434"))
