import SFT.Computation.NativeVerification
namespace SFT.Computation.NativePnpWitnesses
open NativeClosing NativeVerification SFT.InformationScience.QuantitySupport
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000

def completeDepthSeven : Bool := nativePnpEqual 7
def resourcesThroughFourteen : Bool := (List.range 14).all (fun i =>
 match (words labels (i+1)).head? with
 | some word => (suffixTrace word).length-1==i+1
 | none => false)
theorem completeDepthSevenPassed : completeDepthSeven=true := by decide
theorem resourcesThroughFourteenPassed : resourcesThroughFourteen=true := rfl
end SFT.Computation.NativePnpWitnesses
