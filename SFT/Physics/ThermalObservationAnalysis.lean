import SFT.Physics.VacuumPlanckAnalysis
namespace SFT.Physics.ThermalObservationAnalysis
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Target where
 exponent : Rat
 exponentWidth : Rat
 helium : Rat
 heliumWidth : Rat
 deuterium : Rat
 deuteriumWidth : Rat
 recombination : Rat
 recombinationWidth : Rat
 peaks : List Rat
 peakWidths : List Rat
 amplitudes : List Rat
 amplitudeWidths : List Rat
 detectedCount : Nat
 freezeoutLabel : String
 captureLabel : String
 heliumLabel : String
 allRowsRetained : Bool
structure Analysis where
 temperatureInterval : Rat × Rat
 oneInside : Bool
 heliumInterval : Rat × Rat
 analyticQuarter : Rat
 quarterExcluded : Bool
 heliumGap : Rat
 deuteriumInterval : Rat × Rat
 deuteriumMinor : Bool
 recombinationInterval : Rat × Rat
 finiteRecombination : Bool
 peakIntervals : List (Rat × Rat)
 completeSeven : Bool
 detectedCount : Nat
 finiteEighteen : Bool
 angularIntegerRejected : Bool
 freezeoutRetained : Bool
 quarterLabelRetained : Bool
 allRowsRetained : Bool

def exactAnalysis (t : Target) : Except String Analysis := do
 let ei := (subtract t.exponent t.exponentWidth,add t.exponent t.exponentWidth)
 let hi := (subtract t.helium t.heliumWidth,add t.helium t.heliumWidth)
 let d := multiply t.deuterium (natRatio 1 100000 (by decide))
 let dw := multiply t.deuteriumWidth (natRatio 1 100000 (by decide))
 let di := (subtract d dw,add d dw)
 let ri := (subtract t.recombination t.recombinationWidth,add t.recombination t.recombinationWidth)
 let pi := (t.peaks.zip t.peakWidths).map (fun (c,w) => (subtract c w,add c w))
 let first ← match pi with | [] => throw "empty peak intervals" | first::_ => pure first
 let overlaps := (pi.drop 1).zipIdx |>.map (fun (interval,index) =>
  let mode := wholeRatio (index+2)
  let scaled := (multiply mode first.1,multiply mode first.2)
  !(scaled.2.blt interval.1 || interval.2.blt scaled.1))
 let quarter := natRatio 1 4 (by decide)
 pure ⟨ei,! (wholeRatio 1).blt ei.1 && !ei.2.blt (wholeRatio 1),hi,quarter,
 hi.2.blt quarter,subtract quarter t.helium,di,zero.blt di.1 && di.2.blt hi.1,
 ri,zero.blt t.recombinationWidth && zero.blt ri.1,pi,
 pi.length == 7 && t.amplitudes.length == 7 && t.amplitudeWidths.length == 7,
 t.detectedCount,t.detectedCount == 18,!overlaps.any id,
 t.freezeoutLabel == "approximately 1/6" && t.captureLabel == "approximately 1/7",
 t.heliumLabel == "approximately 0.25",t.allRowsRetained⟩

def originalTarget : Target := {
 exponent := natRatio 1007 1000 (by decide)
 exponentWidth := natRatio 27 1000 (by decide)
 helium := natRatio 1229 5000 (by decide)
 heliumWidth := natRatio 13 10000 (by decide)
 deuterium := natRatio 2527 1000 (by decide)
 deuteriumWidth := natRatio 3 100 (by decide)
 recombination := natRatio 27248 25 (by decide)
 recombinationWidth := natRatio 1 4 (by decide)
 peaks := [natRatio 1103 5 (by decide),natRatio 5381 10 (by decide),natRatio 4049 5 (by decide),natRatio 5739 5 (by decide),natRatio 7234 5 (by decide),natRatio 1779 1 (by decide),natRatio 2075 1 (by decide)]
 peakWidths := [natRatio 3 5 (by decide),natRatio 13 10 (by decide),natRatio 1 1 (by decide),natRatio 23 10 (by decide),natRatio 8 5 (by decide),natRatio 3 1 (by decide),natRatio 8 1 (by decide)]
 amplitudes := [natRatio 5733 1 (by decide),natRatio 2586 1 (by decide),natRatio 2518 1 (by decide),natRatio 1227 1 (by decide),natRatio 799 1 (by decide),natRatio 378 1 (by decide),natRatio 227 1 (by decide)]
 amplitudeWidths := [natRatio 39 1 (by decide),natRatio 23 1 (by decide),natRatio 17 1 (by decide),natRatio 9 1 (by decide),natRatio 5 1 (by decide),natRatio 3 1 (by decide),natRatio 6 1 (by decide)]
 detectedCount := 18
 freezeoutLabel := "approximately 1/6"
 captureLabel := "approximately 1/7"
 heliumLabel := "approximately 0.25"
 allRowsRetained := true
}
def accepted (a : Analysis) : Bool := a.oneInside && a.quarterExcluded && a.deuteriumMinor &&
 a.finiteRecombination && a.completeSeven && a.finiteEighteen && a.angularIntegerRejected &&
 a.freezeoutRetained && a.quarterLabelRetained && a.allRowsRetained

theorem originalIntervals : (exactAnalysis originalTarget).toOption.map (fun a => (a.temperatureInterval,a.heliumInterval)) =
 some ((natRatio 49 50 (by decide),natRatio 517 500 (by decide)),
 (natRatio 489 2000 (by decide),natRatio 2471 10000 (by decide))) := by decide +kernel

theorem originalComparison : (exactAnalysis originalTarget).toOption.map accepted=some true := by decide +kernel

theorem originalTamperedRejected : (exactAnalysis {originalTarget with exponent := natRatio 11 10 (by decide)}).toOption.map Analysis.oneInside=some false := by decide +kernel
end SFT.Physics.ThermalObservationAnalysis
