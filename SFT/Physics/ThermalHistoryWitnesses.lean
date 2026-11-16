import SFT.Physics.ThermalHistoryCertificate
namespace SFT.Physics.ThermalHistoryWitnesses
open ThermalHistoryCertificate LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match certificate with | .error _ => false | .ok c => c.temperatureTransport
theorem witness0Passed : witness0=true := by decide +kernel
def witness1 : Bool := match certificate with | .error _ => false | .ok c => c.thresholdOrder
theorem witness1Passed : witness1=true := by decide +kernel
def witness2 : Bool := match certificate with | .error _ => false | .ok c => c.orbit == [1,2,4]
theorem witness2Passed : witness2=true := by decide +kernel
def witness3 : Bool := match certificate with | .error _ => false | .ok c => VelocityComposition.ratEqual c.freezeoutRatio (normalize 1 6 (by decide)) && VelocityComposition.ratEqual c.captureRatio (normalize 1 7 (by decide))
theorem witness3Passed : witness3=true := by decide +kernel
def witness4 : Bool := match certificate with | .error _ => false | .ok c => VelocityComposition.ratEqual c.heliumShare (normalize 1 4 (by decide)) && VelocityComposition.ratEqual c.hydrogenShare (normalize 3 4 (by decide))
theorem witness4Passed : witness4=true := by decide +kernel
def witness5 : Bool := match certificate with | .error _ => false | .ok c => c.visibility
theorem witness5Passed : witness5=true := by decide +kernel
def witness6 : Bool := match certificate with | .error _ => false | .ok c => c.acousticParity
theorem witness6Passed : witness6=true := by decide +kernel
def witness7 : Bool := match certificate with | .error _ => false | .ok c => VelocityComposition.ratEqual c.soundHorizon (normalize 49 96 (by decide))
theorem witness7Passed : witness7=true := by decide +kernel
def witnesses : List Witness := [⟨"temperature","Exact inverse scale transport preserves temperature times scale.",witness0⟩,⟨"thresholds","Every distinct exact threshold has one descending cooling position.",witness1⟩,⟨"orbit","The complete least-part depth-seven binary orbit is exactly one, two and four.",witness2⟩,⟨"freezeout-correction","Freeze-out share One/seven gives ratio One/six; capture-entry share One/eight gives ratio One/seven.",witness3⟩,⟨"nuclear-partition","Complete retained-neutron pairing forces One/four helium family and three/four hydrogen family.",witness4⟩,⟨"visibility","Every generated finite visibility ledger is complete, positive and uniquely centred.",witness5⟩,⟨"acoustic-parity","Positive whole internal modes alternate compression and rarefaction exactly.",witness6⟩,⟨"finite-horizon","The generated-finite sound horizon remains an exact positive Fold carrier.",witness7⟩]
end SFT.Physics.ThermalHistoryWitnesses
