import SFT.Materials.FluxWinding
namespace SFT.Materials.SuperflowWinding
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversiblePhase
open SFT.Mathematics.DiscreteObjects

structure Loop where
 graph : SFT.Mathematics.GraphOperations.GeneratedGraph
 path : List String
 valid : SFT.Mathematics.GraphOperations.pathIsValid graph path = true
 closed : path.head? = path.reverse.head?
 chargeSupport : List String
 neutral : chargeSupport = []
 cycle : List String
 unique : distinct cycle = true
 phase : String
 index : Nat
 found : phaseIndex phase cycle = some index
 returns : shiftPhase cycle (SFT.Mathematics.GraphOperations.adjacentPairs path).length phase = some phase
 vortexCoreBoundary : SFT.Host.Canonical.Value
 conditions : SFT.Host.Canonical.Value

def transitionCount (loop : Loop) := (SFT.Mathematics.GraphOperations.adjacentPairs loop.path).length

def winding (loop : Loop) := transitionCount loop / loop.cycle.length

theorem singleValuedReturnExactlyWhole (loop : Loop) (amount : Nat) :
 shiftPhase loop.cycle amount loop.phase = some loop.phase ↔
 ∃ n, amount = loop.cycle.length*n :=
 FluxWinding.returnExactlyWholeWinding loop.cycle loop.unique loop.phase loop.index amount loop.found

theorem closedLoopHasWholeCirculationClass (loop : Loop) :
 ∃ n, transitionCount loop = loop.cycle.length*n :=
 (singleValuedReturnExactlyWhole loop (transitionCount loop)).mp loop.returns

theorem computedWindingExactly (loop : Loop) :
 transitionCount loop = loop.cycle.length*winding loop := by
 obtain ⟨n,shape⟩ := closedLoopHasWholeCirculationClass loop
 have positive : 0 < loop.cycle.length :=
  Nat.lt_of_le_of_lt (Nat.zero_le loop.index)
   (selectedIndexBound loop.cycle loop.index loop.phase (indexReconstructs _ _ _ loop.found))
 unfold winding
 rw [shape,SFT.Foundation.FractionReduction.divisionMultiple loop.cycle.length n positive]

theorem neutralCarrier (loop : Loop) (label : String) : label ∉ loop.chargeSupport := by
 rw [loop.neutral]
 intro absent
 cases absent

def record (loop : Loop) := (loop,winding loop)

theorem vortexCoreRetained (loop : Loop) :
 (record loop).1.vortexCoreBoundary = loop.vortexCoreBoundary := rfl

theorem closedPathRetained (loop : Loop) : (record loop).1.path = loop.path := rfl

theorem conditionsRetained (loop : Loop) : (record loop).1.conditions = loop.conditions := rfl

def records (loops : List Loop) := loops.map record

theorem base (loop : Loop) : records [loop] = [record loop] := rfl

theorem successor (loops : List Loop) (next : Loop) :
 records (loops ++ [next]) = records loops ++ [record next] := by
 induction loops with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head)) ih

end SFT.Materials.SuperflowWinding
