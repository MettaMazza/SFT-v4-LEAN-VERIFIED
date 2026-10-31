import SFT.Physics.CosmoSpatialFlatness
import SFT.Physics.LeptonDecimal
namespace SFT.Physics.CosmoSpatialFlatnessIntervals
structure CurvatureRecord where
 sourceId : String
 orientation : String
 confidence : String
 combination : String
 equation : String
 centralMagnitude : String
 uncertaintyMagnitude : String

def containsAbsence (record : CurvatureRecord) : Except String Bool := do
 if !SFT.Host.Text.equal record.sourceId "PLANCK-2018-VI-CURVATURE-47B" ||
    !SFT.Host.Text.equal record.orientation "positive" ||
    !SFT.Host.Text.equal record.confidence "68 percent" ||
    !SFT.Host.Text.equal record.combination "Planck TT,TE,EE+lowE+lensing+BAO" ||
    !SFT.Host.Text.equal record.equation "47b" then
   .error "Planck curvature record identity or boundary changed"
 else do
  let central ← LeptonDecimal.exactDecimal record.centralMagnitude
  let uncertainty ← LeptonDecimal.exactDecimal record.uncertaintyMagnitude
  .ok (!(uncertainty.blt central))

def source : CurvatureRecord := ⟨"PLANCK-2018-VI-CURVATURE-47B","positive","68 percent",
 "Planck TT,TE,EE+lowE+lensing+BAO","47b","0.0007","0.0019"⟩
def witnessCheck : Except String Bool := containsAbsence source
set_option maxRecDepth 20000 in
theorem completeIntervalContainsAbsence : witnessCheck=.ok true := rfl
end SFT.Physics.CosmoSpatialFlatnessIntervals
