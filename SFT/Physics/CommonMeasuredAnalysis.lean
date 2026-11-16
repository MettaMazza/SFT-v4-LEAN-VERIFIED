import SFT.Physics.CommonScaleAxis
import SFT.Physics.ElectroweakMeasuredAnalysis
import SFT.Host.Text
namespace SFT.Physics.CommonMeasuredAnalysis
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

structure Row where
 key : String
 center : Rat
 uncertainty : Rat

structure Target where
 schemes : List Row
 lowTransfer : List Row
 displayedClasses : List String
 belowWBoundary : Bool
 thresholdMatching : Bool
 strongEMReceipt : Bool
 nuTeVRetained : Bool
 nuTeVNotMismatch : Bool
 allRowsRetained : Bool

abbrev Bounds := Rat × Rat
abbrev Intervals := List (String × Bounds)

def interval (center uncertainty : Rat) : Except String Bounds :=
 if !uncertainty.blt center || !zero.blt uncertainty then
  .error "common-scale measurement interval must remain positive"
 else .ok (subtract center uncertainty,add center uncertainty)

-- Source dict comprehension: update an existing value in its original slot.
def insertRow (key : String) (value : Bounds) : Intervals → Intervals
 | [] => [(key,value)]
 | (k,v)::rest => if SFT.Host.Text.equal k key then (k,value)::rest
  else (k,v)::insertRow key value rest

def intervalRows : List Row → Intervals → Except String Intervals
 | [],result => .ok result
 | row::rest,result => do
  let bounds ← interval row.center row.uncertainty
  intervalRows rest (insertRow row.key bounds result)

def lookup (key : String) : Intervals → Except String Bounds
 | [] => .error (SFT.Host.Text.append "'" (SFT.Host.Text.append key "'"))
 | (k,v)::rest => if SFT.Host.Text.equal k key then .ok v else lookup key rest

structure Analysis where
 schemeIntervals : Intervals
 lowTransferIntervals : Intervals
 terminalInsideOnShell : Bool
 supportEightInsideAPV : Bool
 e158AboveMSZ : Bool
 apvAboveMSZ : Bool
 edisOverlapsMSZ : Bool
 completeSchemes : Bool
 completeLowTransfer : Bool
 completeDisplayedClasses : Bool
 thresholdBoundary : Bool
 strongEMReceipt : Bool
 nuTeVRetained : Bool
 nuTeVNotMismatch : Bool
 allRowsRetained : Bool

def exactAnalysis (t : Target) : Except String Analysis := do
 let schemes ← intervalRows t.schemes []
 let low ← intervalRows t.lowTransfer []
 let terminal := (← CommonScaleAxis.terminalElectroweakChain).terminalShare
 let supportEight ← CommonScaleAxis.leadingElectroweakShare (.integer 4)
 let ms ← lookup "MS at Z" schemes
 let onShell ← lookup "on-shell" schemes
 let apv ← lookup "Cesium-atomic-parity-violation" low
 let e158 ← lookup "SLAC-E158" low
 let edis ← lookup "Jefferson-Lab-Hall-A-eDIS" low
 .ok ⟨schemes,low,PrecisionValidationOperations.contains onShell terminal,
  PrecisionValidationOperations.contains apv supportEight,
  ms.2.blt e158.1,ms.2.blt apv.1,!(edis.2.blt ms.1 || ms.2.blt edis.1),
  schemes.length == 4,low.length == 4,t.displayedClasses.length == 8,
  t.belowWBoundary && t.thresholdMatching,t.strongEMReceipt,
  t.nuTeVRetained,t.nuTeVNotMismatch,t.allRowsRetained⟩

def empirical (a : Analysis) : Bool :=
 a.terminalInsideOnShell && a.supportEightInsideAPV && a.e158AboveMSZ &&
 a.apvAboveMSZ && a.edisOverlapsMSZ && a.completeSchemes && a.completeLowTransfer &&
 a.completeDisplayedClasses && a.thresholdBoundary && a.strongEMReceipt &&
 a.nuTeVRetained && a.nuTeVNotMismatch && a.allRowsRetained

def originalTarget : Target := ⟨[⟨"on-shell",normalize (11171) 50000 (by decide),normalize (9) 100000 (by decide)⟩,⟨"effective lepton angle",normalize (11577) 50000 (by decide),normalize (3) 50000 (by decide)⟩,⟨"MS at Z",normalize (11561) 50000 (by decide),normalize (3) 50000 (by decide)⟩,⟨"MS non-decoupled",normalize (1157) 5000 (by decide),normalize (3) 50000 (by decide)⟩],[⟨"NuTeV-DIS-on-shell",normalize (2277) 10000 (by decide),normalize (1) 625 (by decide)⟩,⟨"Jefferson-Lab-Hall-A-eDIS",normalize (2299) 10000 (by decide),normalize (43) 10000 (by decide)⟩,⟨"SLAC-E158",normalize (2403) 10000 (by decide),normalize (13) 10000 (by decide)⟩,⟨"Cesium-atomic-parity-violation",normalize (2349) 10000 (by decide),normalize (9) 5000 (by decide)⟩],["APV", "Qweak", "SLAC E158", "eDIS", "LEP I", "SLC", "Tevatron", "LHC"],true,true,true,true,true,true⟩
def measuredPass : Except String Bool := do
 .ok (empirical (← exactAnalysis originalTarget))
theorem originalMeasuredPass : measuredPass = .ok true := rfl

def supportEightWitness : Except String Bool := do
 let q ← CommonScaleAxis.leadingElectroweakShare (.integer 4)
 .ok (q == normalize 25 106 (by decide))
theorem originalSupportEightWitness : supportEightWitness = .ok true := rfl

#print axioms interval
#print axioms insertRow
#print axioms intervalRows
#print axioms lookup
#print axioms exactAnalysis
#print axioms empirical
#print axioms originalMeasuredPass
#print axioms originalSupportEightWitness
end SFT.Physics.CommonMeasuredAnalysis
