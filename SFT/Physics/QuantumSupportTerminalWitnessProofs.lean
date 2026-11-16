import SFT.Physics.QuantumSupportCertificate
namespace SFT.Physics.QuantumSupportTerminalWitnessProofs
open QuantumSupportPreparation QuantumSupportWalsh QuantumSupportJoint LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def originalSpacingChecks : Except String (List Bool) := do
 let ws ← binaryWords (.integer 3)
 [normalize 1 8 (by decide),normalize 2 9 (by decide),normalize 3 7 (by decide),normalize 5 11 (by decide)].mapM fun spacing => do
  let c ← spacingCancellationCertificate (.integer 3) (ws.take 1) spacing
  pure c.spacingCancelled
theorem originalAllFourSpacings : originalSpacingChecks=.ok [true,true,true,true] := rfl
def originalFloorCheck : Except String Bool := do
 let ws ← binaryWords (.integer 2)
 let c ← walshSupportCertificate (.integer 2) (ws.take 2)
 pure (VelocityComposition.ratEqual c.squaredProduct (normalize 1 16 (by decide)) &&
   VelocityComposition.ratEqual (normalize 1 16 (by decide)) c.squaredFloor)
theorem originalDepthTwoFloor : originalFloorCheck=.ok true := rfl
def originalCoprimeChecks : Except String (Bool × Bool) := do
 let a ← coprimeTraceCensus (.integer 2) (.integer 3)
 let b ← coprimeTraceCensus (.integer 3) (.integer 5)
 pure (a.oneVisit,b.oneVisit)
theorem originalBothCoprimeTraces : originalCoprimeChecks=.ok (true,true) := rfl
end SFT.Physics.QuantumSupportTerminalWitnessProofs
