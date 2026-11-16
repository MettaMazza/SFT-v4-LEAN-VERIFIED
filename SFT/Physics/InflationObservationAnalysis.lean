import SFT.Physics.InflationGrowth
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.InflationObservationAnalysis
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Target where
 centre : Rat
 width : Rat
 bound : Rat
 strict : Bool
 allRowsRetained : Bool
structure Analysis where
 scalarPrediction : Rat
 scalarInterval : Rat × Rat
 scalarInside : Bool
 scalarDistance : Rat
 tensorPrediction : Rat
 tensorBound : Rat
 tensorBelow : Bool
 tensorMargin : Rat
 partitionComplete : Bool
 allRowsRetained : Bool

def exactAnalysis (t : Target) : Analysis :=
 let scalar := natRatio 31 32 (by decide)
 let tensor := natRatio 1 32 (by decide)
 let interval := (subtract t.centre t.width,add t.centre t.width)
 ⟨scalar,interval,!scalar.blt interval.1 && !interval.2.blt scalar,
 if scalar.blt t.centre then subtract t.centre scalar else subtract scalar t.centre,
 tensor,t.bound,t.strict && tensor.blt t.bound,subtract t.bound tensor,
 add scalar tensor == wholeRatio 1,t.allRowsRetained⟩

def originalTarget : Target := ⟨natRatio 9649 10000 (by decide),natRatio 42 10000 (by decide),natRatio 4 125 (by decide),true,true⟩
theorem originalInterval : (exactAnalysis originalTarget).scalarInterval=
 (natRatio 9607 10000 (by decide),natRatio 9691 10000 (by decide)) := by decide +kernel
theorem originalMargin : (exactAnalysis originalTarget).tensorMargin=natRatio 3 4000 (by decide) := by decide +kernel
theorem originalComparison : let a := exactAnalysis originalTarget
 a.scalarInside && a.tensorBelow && a.partitionComplete && a.allRowsRetained=true := by decide +kernel
theorem originalTamperedRejected : (exactAnalysis {originalTarget with centre := natRatio 9 10 (by decide)}).scalarInside=false := by decide +kernel
theorem originalFormalShares :
 (InflationGrowth.scalarSupportShare,InflationGrowth.tensorSupportShare)=
 (.ok (exactAnalysis originalTarget).scalarPrediction,.ok (exactAnalysis originalTarget).tensorPrediction) := InflationGrowth.originalShares
end SFT.Physics.InflationObservationAnalysis
