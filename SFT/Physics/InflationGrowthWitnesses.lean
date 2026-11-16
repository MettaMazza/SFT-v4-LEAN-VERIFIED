import SFT.Physics.InflationGrowthCertificate
namespace SFT.Physics.InflationGrowthWitnesses
open InflationGrowthCertificate LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match certificate with | .error _ => false | .ok c => c.depth == 5 && c.support == 32
theorem witness0Passed : witness0=true := by decide +kernel
def witness1 : Bool := match certificate with | .error _ => false | .ok c => VelocityComposition.ratEqual c.scalar (normalize 31 32 (by decide)) && VelocityComposition.ratEqual c.tensor (normalize 1 32 (by decide)) && c.completePrimordialPartition
theorem witness1Passed : witness1=true := by decide +kernel
def witness2 : Bool := match certificate with | .error _ => false | .ok c => c.exactDuration == 5
theorem witness2Passed : witness2=true := by decide +kernel
def witness3 : Bool := match certificate with | .error _ => false | .ok c => c.growthTrace == [normalize 1 4 (by decide),normalize 1 2 (by decide),VacuumLedgerProofs.wholeRatio 1] && c.strictGrowth
theorem witness3Passed : witness3=true := by decide +kernel
def witness4 : Bool := match certificate with | .error _ => false | .ok c => c.transfer
theorem witness4Passed : witness4=true := by decide +kernel
def witnesses : List Witness := [⟨"cover","Twenty-seven is first covered by depth five support thirty-two.",witness0⟩,⟨"partition","Thirty-one scalar records and one tensor-pair record close exactly to the One.",witness1⟩,⟨"duration","The complete support has exactly five Fold doublings.",witness2⟩,⟨"growth","Quarter-One reaches the One through half-One in exactly two strict steps.",witness3⟩,⟨"transfer","Third/fourth component powers force exact relative matter growth g.",witness4⟩]
end SFT.Physics.InflationGrowthWitnesses
