import SFT.Chemistry.ConformerPopulationDerivation
namespace SFT.Chemistry.ConformerPopulationWitnesses
open ConformerPopulation ConformerCensus
open SFT.Physics.CapabilityValues

def condition : HeldLabel := ⟨"observation-condition","fixed-condition-and-timescale",rfl,rfl⟩
def base : Except String PopulationCensus := do
 let c ← butane
 conditioned c condition [[anti],[anti],[gaucheForward],[anti]] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]
def populations : List Row → List (Nat×Nat)
 | [] => []
 | r::rs => match r.population with
  | .ratio q => (q.numerator.value,q.denominator.value)::populations rs
  | .emptyOne | .otherEmptyOne _ | .invalid => populations rs

def populationWitness : Bool := match base with
 | .error _ => false | .ok c => populations c.rows==[(3,4),(1,4)]
def censusWitness : Bool := match base with
 | .error _ => false | .ok c => c.rows.length==2
def energyWitness : Bool := match base with
 | .error _ => false
 | .ok c => match energyOrder c with
  | .error _ => false | .ok groups => sameClasses groups (c.rows.map Row.equivalenceClass)
def orderWitness : Bool := match base with
 | .error _ => false
 | .ok c => match populationOrder c with
  | .error _ => false | .ok groups => sameClasses groups (c.rows.map Row.equivalenceClass)
def successorWitness : Bool := match (do let c ← base; appendObservation c [gaucheReverse]) with
 | .error _ => false | .ok c => populations c.rows==[(3,5),(2,5)]
def reverseTakeWitness : Bool := match orderedTake (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩) with
 | .error _ => true | .ok _ => false
def foreignWitness : Bool := match (do
 let c ← butane
 let foreign : HeldLabel := ⟨"torsion-state","foreign",rfl,rfl⟩
 conditioned c condition [[foreign]] [.emptyOne,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩]) with
 | .error _ => true | .ok _ => false
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem populationPassed : populationWitness=true := rfl
theorem censusPassed : censusWitness=true := rfl
theorem energyPassed : energyWitness=true := rfl
theorem orderPassed : orderWitness=true := rfl
theorem successorPassed : successorWitness=true := rfl
theorem reverseTakePassed : reverseTakeWitness=true := rfl
theorem foreignPassed : foreignWitness=true := rfl
end SFT.Chemistry.ConformerPopulationWitnesses
