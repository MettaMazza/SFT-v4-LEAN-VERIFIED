import SFT.Physics.FoldUniverseTransport
namespace SFT.Physics.FoldUniverseTransportDynamics
open FoldUniverseTransport GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Every returned denominator is the held source denominator, at every original tick. -/
theorem originalDenominatorSteps (d : CountInput) (n : Nat) (x : CountInput) (out : List Int)
 (run : denominatorSteps d n x = .ok out) : out = List.replicate n (integerValue d) := by
 induction n generalizing x out with
 | zero => cases run; rfl
 | succ n ih =>
  unfold denominatorSteps at run
  cases step : foldResidue x d with
  | error e => rw [step] at run; cases run
  | ok next =>
   rw [step] at run
   dsimp only [Bind.bind, Except.bind] at run
   cases tail : denominatorSteps d n (.integer (.ofNat next)) with
   | error e => rw [tail] at run; cases run
   | ok xs =>
    rw [tail] at run
    cases run
    exact congrArg (List.cons (integerValue d)) (ih _ xs tail)
/-- The right projection of the actual paired evolution is its own original trajectory. -/
theorem originalTargetProjection (l r : CountInput) (n : Nat) (a b : CountInput)
 (out : List Nat) (run : pairedTrajectory l r n a b = .ok out) :
 trajectory r n b = .ok out := by
 induction n generalizing a b out with
 | zero => exact run
 | succ n ih =>
  unfold pairedTrajectory at run
  cases left : foldResidue a l with
  | error e => rw [left] at run; cases run
  | ok nl =>
   rw [left] at run
   dsimp only [Bind.bind, Except.bind] at run
   cases right : foldResidue b r with
   | error e => rw [right] at run; cases run
   | ok nr =>
    rw [right] at run
    dsimp only [Bind.bind, Except.bind] at run
    cases tail : pairedTrajectory l r n (.integer (.ofNat nl)) (.integer (.ofNat nr)) with
    | error e => rw [tail] at run; cases run
    | ok xs =>
     rw [tail] at run
     cases run
     unfold trajectory
     rw [right]
     dsimp only [Bind.bind, Except.bind]
     rw [ih _ _ xs tail]
     rfl
/-- Changing the source while holding the target cannot change its returned trajectory. -/
theorem originalNoSteering (l r : CountInput) (n : Nat) (a a' b : CountInput)
 (out out' : List Nat) (first : pairedTrajectory l r n a b = .ok out)
 (second : pairedTrajectory l r n a' b = .ok out') : out=out' := by
 have same := (originalTargetProjection l r n a b out first).symm.trans
  (originalTargetProjection l r n a' b out' second)
 cases same
 rfl
end SFT.Physics.FoldUniverseTransportDynamics
