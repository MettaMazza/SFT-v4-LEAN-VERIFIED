import SFT.QuantumComputation.PhaseInterference
import SFT.Materials.PairedCarrier
import SFT.Physics.FieldElectricDistinction
import SFT.Mathematics.GraphOperations
import SFT.Mathematics.OrbitOrderIdentity
namespace SFT.Materials.FluxWinding
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversiblePhase
open SFT.Mathematics.DiscreteObjects

theorem returnForcesWholeWinding (cycle : List String)
 (unique : distinct cycle = true) (phase : String) (index amount : Nat)
 (found : phaseIndex phase cycle = some index)
 (returns : shiftPhase cycle amount phase = some phase) :
 ∃ winding, amount = cycle.length * winding := by
 have selected : labelAt cycle ((index+amount)%cycle.length) = some phase := by
  unfold shiftPhase at returns
  rw [found] at returns
  exact returns
 have same := indexOfSelected cycle unique _ phase selected
 have position : (index+amount)%cycle.length = index := Option.some.inj (same.symm.trans found)
 have bound := selectedIndexBound cycle index phase (indexReconstructs cycle phase index found)
 have positive := Nat.lt_of_le_of_lt (Nat.zero_le index) bound
 have decomposition := SFT.Foundation.FractionReduction.remainderQuotient (index+amount) cycle.length positive
 rw [position] at decomposition
 have cancelled := congrArg (fun n => n-index) decomposition
 rw [subtractPrefix,subtractPrefix] at cancelled
 exact ⟨(index+amount)/cycle.length,cancelled.symm⟩

theorem wholeWindingReturns (cycle : List String) (phase : String) (index winding : Nat)
 (found : phaseIndex phase cycle = some index) :
 shiftPhase cycle (cycle.length*winding) phase = some phase := by
 have selected := indexReconstructs cycle phase index found
 have bound := selectedIndexBound cycle index phase selected
 unfold shiftPhase
 rw [found]
 change labelAt cycle ((index+cycle.length*winding)%cycle.length) = some phase
 have modulus : (index + cycle.length*winding)%cycle.length = index := by
  have positive := Nat.lt_of_le_of_lt (Nat.zero_le index) bound
  exact (SFT.Mathematics.OrbitOrderIdentity.moduloAddMultiple index cycle.length winding positive).trans
   (SFT.Foundation.ExactValueIdentity.moduloBelow index cycle.length positive bound)
 rw [modulus]
 exact selected

theorem returnExactlyWholeWinding (cycle : List String)
 (unique : distinct cycle = true) (phase : String) (index amount : Nat)
 (found : phaseIndex phase cycle = some index) :
 shiftPhase cycle amount phase = some phase ↔ ∃ winding, amount = cycle.length*winding := by
 constructor
 · exact returnForcesWholeWinding cycle unique phase index amount found
 · intro ⟨winding,same⟩
   rw [same]
   exact wholeWindingReturns cycle phase index winding found


structure Loop where
 graph : SFT.Mathematics.GraphOperations.GeneratedGraph
 path : List String
 valid : SFT.Mathematics.GraphOperations.pathIsValid graph path = true
 closed : path.head? = path.reverse.head?
 pairedLabel : SFT.Physics.MechanicalLocation.Held
 charge : SFT.Physics.FieldElectricDistinction.Charge
 cycle : List String
 unique : distinct cycle = true
 phase : String
 index : Nat
 found : phaseIndex phase cycle = some index
 returns : shiftPhase cycle (SFT.Mathematics.GraphOperations.adjacentPairs path).length phase = some phase

def transitionCount (loop : Loop) := (SFT.Mathematics.GraphOperations.adjacentPairs loop.path).length

def winding (loop : Loop) := transitionCount loop / loop.cycle.length

theorem closedLoopHasWholeFluxClass (loop : Loop) :
 ∃ n, transitionCount loop = loop.cycle.length*n :=
 returnForcesWholeWinding loop.cycle loop.unique loop.phase loop.index
  (transitionCount loop) loop.found loop.returns

theorem computedWindingExactly (loop : Loop) :
 transitionCount loop = loop.cycle.length*winding loop := by
 have whole := closedLoopHasWholeFluxClass loop
 obtain ⟨n,shape⟩ := whole
 have positive : 0 < loop.cycle.length :=
  Nat.lt_of_le_of_lt (Nat.zero_le loop.index)
   (selectedIndexBound loop.cycle loop.index loop.phase (indexReconstructs _ _ _ loop.found))
 unfold winding
 rw [shape,SFT.Foundation.FractionReduction.divisionMultiple loop.cycle.length n positive]

def record (loop : Loop) := (loop,PairedCarrier.pair loop.pairedLabel,winding loop)

theorem pairedChargeRetained (loop : Loop) : (record loop).1.charge = loop.charge := rfl

theorem pairedLabelsRetained (loop : Loop) :
 (record loop).2.1 = PairedCarrier.pair loop.pairedLabel := rfl

def records (loops : List Loop) := loops.map record

theorem base (loop : Loop) : records [loop] = [record loop] := rfl

theorem successor (loops : List Loop) (next : Loop) :
 records (loops ++ [next]) = records loops ++ [record next] := by
 induction loops with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head)) ih

end SFT.Materials.FluxWinding
