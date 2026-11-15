import SFT.Physics.GravitySelfSource
import SFT.Physics.CoupledEnsembleSynchronization
namespace SFT.Physics.PostNewtonianFixedPoint
open LeptonIntervals GeneratorOperations FoldFirstReturn VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Structural where
 matter : Rat
 coupling : Rat
 fixed : Rat
def structuralValues : Except String Structural := do
 let binary ← AlphaCovers.binaryCount
 let colour ← generatorPeriod
 let matter ← LeptonRatios.divide (wholeRatio (binary*colour+1)) (wholeRatio (binary^4))
 let coupling ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 pure ⟨matter,coupling,multiply coupling coupling⟩
def selfSourceSuccessor : Input → Except String Rat
 | .nonFraction => .error "field must be an exact positive Fold part"
 | .fraction field => do
  if !zero.blt field || (normalize 1 1 (by decide)).blt field then throw "field must be an exact positive Fold part"
  let v ← structuralValues
  pure (multiply v.coupling (add v.matter (multiply field field)))
def fixedPointCandidates : Except String (List Rat) := do
 let lower ← ((List.range 16).map (fun i => i+1)).filterMapM (fun n => do
  let q := normalize (.ofNat n) 16 (by decide)
  let next ← selfSourceSuccessor (.fraction q)
  pure (if q==next then some q else none))
 let upper := ((List.range 12).map (fun i => i+17)).filterMap (fun n =>
  let q := normalize (.ofNat n) 16 (by decide)
  let next := multiply (normalize 1 2 (by decide)) (add (normalize 7 16 (by decide)) (multiply q q))
  if q==next then some q else none)
 pure (lower++upper)
def admissibleFixedPoints : Except String (List Rat) := do
 pure ((← fixedPointCandidates).filter (fun v => !(normalize 1 1 (by decide)).blt v))
def iterateSteps : Nat → Rat → Except String (List Rat)
 | 0,current => .ok [current]
 | n+1,current => do
  let next ← selfSourceSuccessor (.fraction current)
  pure (current :: (← iterateSteps n next))
def iterate : CountInput → Except String (List Rat)
 | .integer (.ofNat (n+1)) => do
  let v ← structuralValues
  iterateSteps (n+1) (multiply v.coupling v.matter)
 | .integer (.ofNat 0) | .integer (.negSucc _) | .boolean _ => .error "positive depth required"
theorem originalStructuralValues : structuralValues=.ok ⟨normalize 7 16 (by decide),CoupledEnsembleSynchronization.halfOneValue,normalize 1 4 (by decide)⟩ := by
 unfold structuralValues
 rw [AlphaCovers.binaryCountTwo,generatorPeriodThree]
 rfl
theorem originalFixedCandidates : fixedPointCandidates=.ok [normalize 1 4 (by decide),normalize 7 4 (by decide)] := rfl
theorem originalAdmissibleFixedPoints : admissibleFixedPoints=.ok [normalize 1 4 (by decide)] := rfl
end SFT.Physics.PostNewtonianFixedPoint
