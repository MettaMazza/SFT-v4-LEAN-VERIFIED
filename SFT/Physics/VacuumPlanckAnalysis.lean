import SFT.Physics.VacuumDensity
import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.LeptonRatios
namespace SFT.Physics.VacuumPlanckAnalysis
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Target where
 vacuum : Rat
 vacuumWidth : Rat
 matter : Rat
 matterWidth : Rat
 hubble : Rat
 hubbleWidth : Rat
 speed : Rat
 correctionRetained : Bool
 allRowsRetained : Bool
structure Analysis where
 vacuumInterval : Rat × Rat
 matterInterval : Rat × Rat
 predictedShare : Rat
 shareInsideInterval : Bool
 normalizedInterval : Rat × Rat
 predictedNormalized : Rat
 normalizedInsideInterval : Bool
 centralBudgetCloses : Bool
 hubbleInterval : Rat × Rat
 lambdaInterval : Rat × Rat
 lambdaCentral : Rat
 dimensionalTransportPositive : Bool
 localFloor : Rat
 localFloorOutsideGlobalInterval : Bool
 halfOneModeMeanOutsideGlobalInterval : Bool
 primaryHubbleCorrectionRetained : Bool
 allRowsRetained : Bool

def exactAnalysis (t : Target) : Except String Analysis := do
 let lower := subtract t.vacuum t.vacuumWidth
 let upper := add t.vacuum t.vacuumWidth
 let normalizedLower := multiply (wholeRatio 3) lower
 let normalizedUpper := multiply (wholeRatio 3) upper
 let share := VacuumDensity.terminalVacuumShare
 let coefficient := VacuumDensity.normalizedCosmologicalConstant
 let hubbleLower := subtract t.hubble t.hubbleWidth
 let hubbleUpper := add t.hubble t.hubbleWidth
 let lowerRatio ← LeptonRatios.divide hubbleLower t.speed
 let lambdaLower := multiply coefficient (multiply lowerRatio lowerRatio)
 let centralRatio ← LeptonRatios.divide t.hubble t.speed
 let lambdaCentral := multiply coefficient (multiply centralRatio centralRatio)
 let upperRatio ← LeptonRatios.divide hubbleUpper t.speed
 let lambdaUpper := multiply coefficient (multiply upperRatio upperRatio)
 let floor := natRatio 1 (2^20) (by decide)
 pure ⟨(lower,upper),(subtract t.matter t.matterWidth,add t.matter t.matterWidth),share,
 !share.blt lower && !upper.blt share,(normalizedLower,normalizedUpper),coefficient,
 !coefficient.blt normalizedLower && !normalizedUpper.blt coefficient,
 add t.vacuum t.matter == wholeRatio 1,(hubbleLower,hubbleUpper),
 (lambdaLower,lambdaUpper),lambdaCentral,
 zero.blt lambdaLower && lambdaLower.blt lambdaCentral && lambdaCentral.blt lambdaUpper,
 floor,floor.blt lower,(natRatio 1 2 (by decide)).blt lower,
 t.correctionRetained && t.hubble == natRatio 6768 100 (by decide),t.allRowsRetained⟩

def originalTarget : Target := ⟨natRatio 6889 10000 (by decide),natRatio 56 10000 (by decide),
 natRatio 3111 10000 (by decide),natRatio 56 10000 (by decide),natRatio 6768 100 (by decide),
 natRatio 42 100 (by decide),natRatio 299792458 1000 (by decide),true,true⟩

theorem originalIntervals : (exactAnalysis originalTarget).toOption.map (fun a => (a.vacuumInterval,a.normalizedInterval,a.hubbleInterval)) =
 some ((natRatio 6833 10000 (by decide),natRatio 1389 2000 (by decide)),
 (natRatio 20499 10000 (by decide),natRatio 4167 2000 (by decide)),
 (natRatio 6726 100 (by decide),natRatio 6810 100 (by decide))) := by decide +kernel

theorem originalComparison : (exactAnalysis originalTarget).toOption.map (fun a =>
 a.shareInsideInterval && a.normalizedInsideInterval && a.centralBudgetCloses &&
 a.dimensionalTransportPositive && a.localFloorOutsideGlobalInterval &&
 a.halfOneModeMeanOutsideGlobalInterval && a.primaryHubbleCorrectionRetained && a.allRowsRetained)=some true := by decide +kernel

theorem originalTamperedRejected : (exactAnalysis {originalTarget with vacuum := natRatio 6 10 (by decide)}).toOption.map Analysis.shareInsideInterval=some false := by decide +kernel
end SFT.Physics.VacuumPlanckAnalysis
