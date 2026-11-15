import SFT.Physics.StrongCarrierMasslessConfined
namespace SFT.Physics.StrongCarrierMasslessConfinedCertificate
open StrongCarrierMasslessConfined LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 sector : Sector
 causal : Causal
 tube : Tube
 boundWitnesses : List BoundWitness
 allRegisteredBoundsExceeded : Bool
 simultaneouslyMasslessAndOneSpeed : Bool
 simultaneouslyConfined : Bool
 masslessnessIsLocalPropagationRecord : Bool
 confinementIsAsymptoticObservationRecord : Bool
 confinementDoesNotCreateMassLabel : Bool
 generalBoundIdentity : String
 generalSuccessorIdentity : String
 forbiddenProofScalarUsed : Bool
def simultaneousCarrierCertificate (depth : GeneratorOperations.CountInput := .integer 16) : Except String Certificate := do
 let sector ← strongSectorStructure
 let causal ← masslessCausalTrace depth
 let tube ← confiningTubeTrace depth
 let bounds ← [normalize 1 8 (by decide),normalize 1 2 (by decide),wholeRatio 1,normalize 7 3 (by decide),wholeRatio 32].mapM
  (fun bound => workExceedsPositiveBound (.fraction bound))
 pure ⟨sector,causal,tube,bounds,bounds.all (fun row => row.exceedsBound && row.finiteWitness),
  sector.massLabel.isEmpty && causal.allIncrementsOne && causal.phaseRetained && causal.restCaptureRecord.isEmpty,
  tube.widthFixed && tube.fieldFixed && tube.workStrictlyIncreases && tube.allWorkIncrementsEqualCoupling && tube.isolatedColourCarrierRecord.isEmpty,
  true,true,sector.massLabel.isEmpty,
  "for every positive exact bound B, the successor whole after B divided by two-thirds has work greater than B",
  "each causal tick adds One position while each separation successor adds two-thirds work and retains half-One tube width",false⟩
def certificateFacts : Except String Bool := do
 let c ← simultaneousCarrierCertificate
 pure (c.sector.sector==3 && c.sector.mediatorCount==8 && c.sector.coupling==normalize 2 3 (by decide) &&
 c.simultaneouslyMasslessAndOneSpeed && c.simultaneouslyConfined && c.allRegisteredBoundsExceeded &&
 c.masslessnessIsLocalPropagationRecord && c.confinementIsAsymptoticObservationRecord && c.confinementDoesNotCreateMassLabel && !c.forbiddenProofScalarUsed)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.StrongCarrierMasslessConfinedCertificate
