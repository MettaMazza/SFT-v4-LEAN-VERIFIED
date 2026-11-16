import SFT.Physics.ThermalHistoryTransport
namespace SFT.Physics.ThermalHistoryCertificate
open ThermalHistory LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 temperatureTransport : Bool
 thresholdOrder : Bool
 orbit : List Nat
 freezeoutRatio : Rat
 captureRatio : Rat
 heliumShare : Rat
 hydrogenShare : Rat
 visibility : Bool
 acousticParity : Bool
 soundHorizon : Rat
def ratListsEqual : List Rat → List Rat → Bool
 | [],[] => true
 | [],_::_ => false
 | _::_,[] => false
 | a::as,b::bs => VelocityComposition.ratEqual a b && ratListsEqual as bs
def certificate : Except String Certificate := do
 let ledger ← freezeoutCaptureLedger
 let thresholds := [normalize 7 8 (by decide),normalize 3 4 (by decide),normalize 1 2 (by decide),normalize 1 4 (by decide)]
 let modes ← acousticModeLedger 8
 let temperatures := [normalize 1 4 (by decide),normalize 2 3 (by decide),normalize 5 2 (by decide)]
 let growths := [normalize 1 2 (by decide),wholeRatio 2,normalize 7 3 (by decide)]
 let temperatureChecks ← temperatures.mapM fun t => growths.mapM fun g => temperatureScaleInvariant t g
 let order ← orderedThresholds thresholds.reverse
 let visibilityChecks ← (List.range 8).mapM fun r => do
   let ledger ← visibilityLedger (r+1)
   pure (ledger.complete && ledger.uniqueMidpoint)
 let horizon ← finiteSoundHorizon
   [normalize 1 8 (by decide),normalize 1 4 (by decide),normalize 3 8 (by decide)]
   [normalize 1 2 (by decide),normalize 2 3 (by decide),normalize 3 4 (by decide)]
 pure ⟨temperatureChecks.all (fun xs => xs.all id),ratListsEqual order thresholds,
  liveDepthSevenOrbit,ledger.freezeoutRatio,ledger.captureRatio,ledger.heliumShare,
  ledger.hydrogenShare,visibilityChecks.all id,
  (modes.map AcousticMode.loading).zipWith SFT.Host.Text.equal
    ["compression","rarefaction","compression","rarefaction","compression","rarefaction","compression","rarefaction"] |>.all id,
  horizon⟩
theorem originalCertificateFlags : certificate.toOption.map (fun c =>
 [c.temperatureTransport,c.thresholdOrder,c.visibility,c.acousticParity])=some [true,true,true,true] := by decide +kernel
theorem originalCertificateQuantities : certificate.toOption.map (fun c =>
 [c.freezeoutRatio.num,c.freezeoutRatio.den,c.captureRatio.num,c.captureRatio.den,
 c.heliumShare.num,c.heliumShare.den,c.hydrogenShare.num,c.hydrogenShare.den,
 c.soundHorizon.num,c.soundHorizon.den])=some [1,6,1,7,1,4,3,4,49,96] := by decide +kernel
end SFT.Physics.ThermalHistoryCertificate
