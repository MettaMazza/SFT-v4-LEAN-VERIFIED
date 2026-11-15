import SFT.Physics.StrongRunning
import SFT.Physics.NuclearResidualForce
import SFT.Physics.QuadrupoleRadiatedPowerGeneral
namespace SFT.Physics.StrongCarrierMasslessConfined
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Sector where
 sector : Nat
 chargeLabels : Nat
 pairCells : Nat
 colourlessReturnCells : Rat
 mediatorCount : Nat
 coupling : Rat
 massLabel : List Rat
 massClass : String
 carrierCharge : String
def strongSectorStructure : Except String Sector := do
 let colour ← FoldFirstReturn.generatorPeriod
 let coupling ← ColourCouplingDerivation.colourCoupling
 let coupling := BoundaryGrowth.asFraction coupling
 let pairCells := colour*colour
 let mediators := pairCells-1
 if mediators != 8 || !(coupling==normalize 2 3 (by decide)) then throw "generated colour-sector structure changed"
 pure ⟨colour,colour,pairCells,wholeRatio 1,mediators,coupling,[],"empty-mass-label","present-colour-and-anticolour"⟩
structure Causal where
 massLabel : List Rat
 positions : List Rat
 increments : List Rat
 allIncrementsOne : Bool
 phaseTrace : List Rat
 phaseRetained : Bool
 restCaptureRecord : List Rat
 causalSpeed : Rat
def masslessCausalTrace (input : GeneratorOperations.CountInput := .integer 12) : Except String Causal := do
 let depth ← match input with
  | .boolean _ => .error "positive causal depth required"
  | .integer (.negSucc _) => .error "positive causal depth required"
  | .integer (.ofNat 0) => .error "positive causal depth required"
  | .integer (.ofNat 1) => .error "positive causal depth required"
  | .integer (.ofNat (n+2)) => .ok (n+2)
 let sector ← strongSectorStructure
 let positions := (List.range (depth+1)).map (fun tick => wholeRatio (tick+1))
 let increments := (StaticExteriorClockCertificate.successivePairs positions).map (fun p => subtract p.2 p.1)
 let phase ← LeptonRatios.divide (wholeRatio 1) (wholeRatio sector.sector)
 let phaseTrace := List.replicate (depth+1) phase
 pure ⟨sector.massLabel,positions,increments,increments.all (fun q => q==wholeRatio 1),phaseTrace,
  !phaseTrace.isEmpty && phaseTrace.all (fun q => q==phaseTrace.headD zero),[],wholeRatio 1⟩
structure TubeRow where
 separation : Rat
 tubeWidth : Rat
 fieldCarrier : Rat
 separationWork : Rat
structure Tube where
 rows : List TubeRow
 tubeWidth : Rat
 fieldCarrier : Rat
 widthFixed : Bool
 fieldFixed : Bool
 workStrictlyIncreases : Bool
 workIncrement : Rat
 allWorkIncrementsEqualCoupling : Bool
 isolatedColourCarrierRecord : List Rat
 completedInfinityUsed : Bool
def confiningTubeTrace (input : GeneratorOperations.CountInput := .integer 12) : Except String Tube := do
 let depth ← match input with
  | .boolean _ => .error "positive separation depth required"
  | .integer (.negSucc _) => .error "positive separation depth required"
  | .integer (.ofNat 0) => .error "positive separation depth required"
  | .integer (.ofNat 1) => .error "positive separation depth required"
  | .integer (.ofNat (n+2)) => .ok (n+2)
 let sector ← strongSectorStructure
 let coupling := sector.coupling
 let width ← NuclearResidualForce.primaryBoundarySupport
 let rows := (List.range depth).map (fun step => (⟨wholeRatio (step+1),width,coupling,multiply coupling (wholeRatio (step+1))⟩ : TubeRow))
 let pairs := StaticExteriorClockCertificate.successivePairs rows
 let increments := pairs.map (fun p => subtract p.2.separationWork p.1.separationWork)
 pure ⟨rows,width,coupling,rows.all (fun row => row.tubeWidth==width),rows.all (fun row => row.fieldCarrier==coupling),
  pairs.all (fun p => p.1.separationWork.blt p.2.separationWork),coupling,
  increments.all (fun q => q==coupling),[],false⟩
structure BoundWitness where
 bound : Rat
 witnessSeparation : Nat
 witnessWork : Rat
 exceedsBound : Bool
 finiteWitness : Bool
def workExceedsPositiveBound (input : FoldFirstReturn.Input) : Except String BoundWitness := do
 let bound ← match input with
  | .nonFraction => .error "positive exact work bound required"
  | .fraction q => if !zero.blt q then .error "positive exact work bound required" else .ok q
 let sector ← strongSectorStructure
 let ratio ← LeptonRatios.divide bound sector.coupling
 let successor := ratio.num.natAbs/ratio.den+1
 let work := multiply sector.coupling (wholeRatio successor)
 pure ⟨bound,successor,work,bound.blt work,decide (1≤successor)⟩
theorem originalSector : strongSectorStructure=.ok ⟨3,3,9,wholeRatio 1,8,normalize 2 3 (by decide),[],"empty-mass-label","present-colour-and-anticolour"⟩ := rfl
theorem originalBound : workExceedsPositiveBound (.fraction (wholeRatio 32))=
 .ok ⟨wholeRatio 32,49,normalize 98 3 (by decide),true,true⟩ := rfl
end SFT.Physics.StrongCarrierMasslessConfined
