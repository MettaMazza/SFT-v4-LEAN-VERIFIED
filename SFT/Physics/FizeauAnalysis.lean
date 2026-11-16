import SFT.Physics.VelocityComposition
namespace SFT.Physics.FizeauAnalysis
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original exact_fizeau_analysis after Fraction conversion of its five input fields.
structure Target where
 measured : Rat
 uncertainty : Rat
 raw : Rat
 corrected : Rat
 ordinary : Rat
 airOrdinaryRuledOut : Bool
 airRelativisticCompatible : Bool
 limitations : List String
structure Analysis where
 measured : Rat
 uncertainty : Rat
 measuredInterval : Rat × Rat
 rawRelativistic : Rat
 correctedRelativistic : Rat
 ordinaryAddition : Rat
 rawDistance : Rat
 correctedDistance : Rat
 bestRelativisticDistance : Rat
 ordinaryDistance : Rat
 measurementInsideCompleteRelativisticSystematicsBracket : Bool
 relativisticMoreThanTenTimesCloser : Bool
 ordinaryOutsideMeasurementInterval : Bool
 airControlRetained : Bool
 allLimitationsRetained : Bool

def exactAnalysis (t : Target) : Analysis :=
 let lower := subtract t.measured t.uncertainty
 let upper := add t.measured t.uncertainty
 let rawDistance := if t.measured.blt t.raw then subtract t.raw t.measured else subtract t.measured t.raw
 let correctedDistance := if t.measured.blt t.corrected then subtract t.corrected t.measured else subtract t.measured t.corrected
 let ordinaryDistance := if t.measured.blt t.ordinary then subtract t.ordinary t.measured else subtract t.measured t.ordinary
 let best := if correctedDistance.blt rawDistance then correctedDistance else rawDistance
 ⟨t.measured,t.uncertainty,(lower,upper),t.raw,t.corrected,t.ordinary,
 rawDistance,correctedDistance,best,ordinaryDistance,
 !lower.blt t.raw && !t.corrected.blt upper,
 (multiply best (wholeRatio 10)).blt ordinaryDistance,
 upper.blt t.ordinary,t.airOrdinaryRuledOut && t.airRelativisticCompatible,t.limitations.length==4⟩

def originalTarget (limitations : List String) : Target :=
 ⟨natRatio 274 1000 (by decide),natRatio 3 1000 (by decide),
 natRatio 248 1000 (by decide),natRatio 299 1000 (by decide),natRatio 563 1000 (by decide),true,true,limitations⟩

theorem originalMeasuredInterval (limitations : List String) :
 (exactAnalysis (originalTarget limitations)).measuredInterval =
 (natRatio 271 1000 (by decide),natRatio 277 1000 (by decide)) := by
 change  (exactAnalysis (originalTarget ([] : List String))).measuredInterval =
   (natRatio 271 1000 (by decide),natRatio 277 1000 (by decide))
 decide +kernel

theorem originalDistances (limitations : List String) :
 ((exactAnalysis (originalTarget limitations)).rawDistance,
 (exactAnalysis (originalTarget limitations)).correctedDistance,
 (exactAnalysis (originalTarget limitations)).ordinaryDistance)=
 (natRatio 26 1000 (by decide),natRatio 25 1000 (by decide),natRatio 289 1000 (by decide)) := by
 change  ((exactAnalysis (originalTarget ([] : List String))).rawDistance,
   (exactAnalysis (originalTarget ([] : List String))).correctedDistance,
   (exactAnalysis (originalTarget ([] : List String))).ordinaryDistance)=
   (natRatio 26 1000 (by decide),natRatio 25 1000 (by decide),natRatio 289 1000 (by decide))
 decide +kernel

theorem originalBracket (limitations : List String) :
 (exactAnalysis (originalTarget limitations)).measurementInsideCompleteRelativisticSystematicsBracket=true := by
 change  (exactAnalysis (originalTarget ([] : List String))).measurementInsideCompleteRelativisticSystematicsBracket=true
 decide +kernel

theorem originalTenfold (limitations : List String) :
 (exactAnalysis (originalTarget limitations)).relativisticMoreThanTenTimesCloser=true := by
 change  (exactAnalysis (originalTarget ([] : List String))).relativisticMoreThanTenTimesCloser=true
 decide +kernel

theorem originalOrdinaryOutside (limitations : List String) :
 (exactAnalysis (originalTarget limitations)).ordinaryOutsideMeasurementInterval=true := by
 change  (exactAnalysis (originalTarget ([] : List String))).ordinaryOutsideMeasurementInterval=true
 decide +kernel

theorem originalAirControl (limitations : List String) :
 (exactAnalysis (originalTarget limitations)).airControlRetained=true := by
 change  (exactAnalysis (originalTarget ([] : List String))).airControlRetained=true
 decide +kernel

theorem originalLimitationCount (t : Target) :
 (exactAnalysis t).allLimitationsRetained=(t.limitations.length==4) := rfl

theorem originalTamperedControl (limitations : List String) :
 (exactAnalysis {(originalTarget limitations) with ordinary := (originalTarget limitations).measured}).relativisticMoreThanTenTimesCloser=false := by
 change  (exactAnalysis {(originalTarget ([] : List String)) with ordinary := (originalTarget ([] : List String)).measured}).relativisticMoreThanTenTimesCloser=false
 decide +kernel
end SFT.Physics.FizeauAnalysis
