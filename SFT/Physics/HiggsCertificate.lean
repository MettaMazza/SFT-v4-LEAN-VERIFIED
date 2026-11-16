import SFT.Physics.HiggsTerminal
namespace SFT.Physics.HiggsCertificate
open LeptonIntervals HiggsGround HiggsTerminal
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 vacuumCensus : List Row
 displacedGround : Rat
 leadingMassRatio : Rat
 leadingSelfCoupling : Rat
 scalarDirectionSupport : Nat
 activeScalarDirections : Nat
 generationCoverDepth : Nat
 terminalReturn : Rat
 terminalMassRatio : Rat
 terminalSelfCoupling : Rat
 routeCrossLock : Routes
 absenceGroundRejected : Bool
def theoremCertificate : Except String Certificate := do
 let (vacuum,mass,coupling) ← leadingHiggsRungs
 let rows ← vacuumGroundCensus
 let first ← match rows with | []=>.error "IndexError" | h::_=>.ok h
 .ok ⟨rows,vacuum,← LeptonRatios.divide mass vacuum,coupling,← HiggsTerminal.scalarDirectionSupport,← HiggsTerminal.activeScalarDirections,← HiggsTerminal.generationCoverDepth,← terminalHiggsReturn,← terminalHiggsMassRatio,← terminalHiggsSelfCoupling,← HiggsTerminal.routeCrossLock,!first.displacedGround⟩
theorem originalReturnedCounts : (theoremCertificate.map (fun c=>(c.vacuumCensus.length,c.scalarDirectionSupport,c.activeScalarDirections,c.generationCoverDepth,c.absenceGroundRejected)))=.ok (3,6,5,5,true) := rfl
#print axioms theoremCertificate
#print axioms originalReturnedCounts
end SFT.Physics.HiggsCertificate
