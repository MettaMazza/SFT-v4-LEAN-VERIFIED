import SFT.Physics.RadioactiveDecayProofs
namespace SFT.Physics.RadioactiveDecayEntryWitnesses
open RadioactiveDecay LeptonIntervals VacuumLedgerProofs
structure Witness where
 name : String
 statement : String
 passed : Bool
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def topologyCheck : Bool := primitiveTransitionClasses.map PrimitiveTransition.name == ["boundary-release-or-decomposition","held-label-conversion","internal-level-deexcitation"]
def representativeCheck : Bool := match alphaRepresentative,betaRepresentative,gammaRepresentative,FoldFirstReturn.generatorPeriod with
 | .ok a,.ok b,.ok g,.ok period => [a.primitiveClass,b.primitiveClass,g.primitiveClass].eraseDups.length == period
 | .error _,_,_,_ => false
 | .ok _,.error _,_,_ => false
 | .ok _,.ok _,.error _,_ => false
 | .ok _,.ok _,.ok _,.error _ => false
def expectedSurvival : Except String (List Rat) :=
 (List.range 7).mapM (fun rank => do
  let binary ← AlphaCovers.binaryCount
  let paths ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat (rank+1)))
  LeptonRatios.divide (wholeRatio 1) (wholeRatio paths))
def survivalCheck : Bool := match survivalTrace (.integer 7),expectedSurvival with
 | .ok actual,.ok expected => actual==expected && actual.all (fun part => zero.blt part)
 | .error _,_ => false
 | .ok _,.error _ => false
def partitionCheck : Bool := (List.range 7).all (fun n => match deterministicHalvingPartition (.integer (.ofNat (n+1))),NuclearResidualForce.residualBoundarySupport with
 | .ok result,.ok residual => result.retainedShare == add residual residual
 | .error _,_ => false
 | .ok _,.error _ => false)
def witnesses : List Witness := [⟨"three-primitive-topologies","Complete support/label/recurrence classification retains exactly three nonidentity transition classes.",topologyCheck⟩,⟨"canonical-representatives","Alpha, beta and gamma independently realize the three primitive classes.",representativeCheck⟩,⟨"exact-survival","The first seven positive half-life counts give the exact binary geometric trace and remain positive.",survivalCheck⟩,⟨"deterministic-partition","Every tested complete hidden-path support divides into equal retained and released fibres.",partitionCheck⟩]
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.RadioactiveDecayEntryWitnesses
