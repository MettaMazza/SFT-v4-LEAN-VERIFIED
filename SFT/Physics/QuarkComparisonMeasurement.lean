import SFT.Physics.MatterAuthoritativeRecords
import SFT.Physics.QuarkComparison
namespace SFT.Physics.QuarkComparisonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals QuarkComparison MatterAuthoritativeRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def quarkLabel : String := "dressed-sd-and-bs-inside-complete-PDG-intervals__tc-is-a-sealed-exact-prediction-with-no-registered-direct-scheme-matched-measurement__CKM-hierarchy-and-s12-s13-J-supported-with-s23-three-sigma-tension-retained"
def quarkClassificationRows (quark ckm : Value) : Except String String := do
 let predictions ← quarkPredictionIntervals
 let ms ← field quark "ms_MeV_MSbar_2GeV"
 let md ← field quark "md_MeV_MSbar_2GeV"
 let msv ← decimalField ms "value"
 let msu ← decimalField ms "total_uncertainty"
 let mdv ← decimalField md "value"
 let mdu ← decimalField md "total_uncertainty"
 let sdl ← LeptonRatios.divide (subtract msv msu) (add mdv mdu)
 let sdu ← LeptonRatios.divide (add msv msu) (subtract mdv mdu)
 let mcms ← field quark "mc_over_ms"
 let mbmc ← field quark "mb_over_mc"
 let cv ← decimalField mcms "value"
 let cu ← decimalField mcms "total_uncertainty"
 let bv ← decimalField mbmc "value"
 let bu ← decimalField mbmc "total_uncertainty"
 let bsTarget := (multiply (subtract cv cu) (subtract bv bu),multiply (add cv cu) (add bv bu))
 if !overlaps predictions.sOverD (sdl,sdu) || !overlaps predictions.bOverS bsTarget then
  throw "sealed dressed quark ratios miss complete PDG intervals"
 let tc ← field quark "top_over_charm"
 if !Text.equal (← text (← field tc "measurement_status")) "no exact scheme-matched direct measurement registered" then
  throw "top/charm direct-measurement status changed"
 if !Text.equal (← text (← field tc "formal_status_consequence")) "the independently sealed SFT value remains a prediction" then
  throw "top/charm prediction status changed"
 let cp ← ckmPredictionIntervals
 let checks ← [(cp.s12Squared,"sin_theta12"),(cp.s23Squared,"sin_theta23"),(cp.s13Squared,"sin_theta13"),(cp.jarlskogSquared,"jarlskog")].mapM fun (prediction,key) => do
  let row ← field ckm key
  let centre ← decimalField row "value"
  let low ← decimalField row "lower_uncertainty"
  let high ← decimalField row "upper_uncertainty"
  let three := normalize 3 1 (by decide)
  let target := (square (subtract centre (multiply three low)),square (add centre (multiply three high)))
  pure (overlaps prediction target)
 let s12 ← LeptonRatios.atIndex checks 0
 let s23 ← LeptonRatios.atIndex checks 1
 let s13 ← LeptonRatios.atIndex checks 2
 let j ← LeptonRatios.atIndex checks 3
 if !(s12 && s13 && j && !s23) then throw "complete CKM support/tension pattern changed"
 pure quarkLabel

def quarkClassificationFromRecord (record : Value) : Except String String := do
 let quark ← sourceRowsFromRecord record "PDG-2025-QUARK-MASSES"
 let ckm ← sourceRowsFromRecord record "PDG-2025-CKM-MATRIX"
 quarkClassificationRows quark ckm

def quarkClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 let quark ← sourceRows bytes files payload "PDG-2025-QUARK-MASSES"
 let ckm ← sourceRows bytes files payload "PDG-2025-CKM-MATRIX"
 quarkClassificationRows quark ckm
end SFT.Physics.QuarkComparisonMeasurement
