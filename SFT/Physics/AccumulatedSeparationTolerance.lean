import SFT.Physics.AccumulatedSeparationBracket
namespace SFT.Physics.AccumulatedSeparationTolerance
open AccumulatedSeparation AccumulatedSeparationLedger LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
open SFT.Mathematics.SelfSimilarConvergence
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def belowTolerance (d : Nat) (hd : 0<d) (offset : Nat) : Bool :=
 let gap := natRatio 1 (gapDenominator (offset+1))
  (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _))
 (add gap gap).blt (natRatio 1 d hd)
theorem sourceComparisonPasses (d offset : Nat) (hd : 0<d)
 (bound : 2*d<gapDenominator (offset+1)) : belowTolerance d hd offset=true := by
 unfold belowTolerance
 dsimp only
 rw [addNormalized 1 1 (gapDenominator (offset+1)) (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _))]
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (by decide)
  (Nat.mul_pos (Nat.add_pos_left (by decide) _) (Nat.add_pos_left (by decide) _)) (by decide) hd
 rw [Nat.one_mul]
 exact bound
theorem sourcePowerCoversCount (k : Nat) : k+1≤2^k := by
 induction k with
 | zero => exact Nat.le_refl _
 | succ k ih =>
  change k+2≤2^k*2
  rw [Nat.mul_succ,Nat.mul_one]
  change (k+1)+1≤2^k+2^k
  exact Nat.add_le_add ih (Nat.pow_pos (by decide : 0<2))
theorem sourceFiniteSearchBound (d : Nat) : 2*d<gapDenominator (2*d+2+1) := by
 unfold gapDenominator
 have count := sourcePowerCoversCount (2*d+3)
 have first : 2*d<2+2^(2*d+3) :=
  Nat.lt_of_lt_of_le (Nat.lt_add_of_pos_right (by decide : 0<4))
   (Nat.le_trans count (Nat.le_add_left _ _))
 exact Nat.lt_of_lt_of_le first (Nat.le_mul_of_pos_right _ (Nat.add_pos_left (by decide) _))
-- Finite recursion carries an already proved search bound; no selected stopping depth
-- is supplied by the caller. It tests the exact source rational comparison at each level.
def searchOffset (d : Nat) (hd : 0<d) : Nat → Nat → Nat
 | 0,offset => offset
 | fuel+1,offset => if belowTolerance d hd offset then offset else searchOffset d hd fuel (offset+1)
inductive SourceSearchRun (d : Nat) (hd : 0<d) : Nat → Nat → Prop where
 | stop (offset : Nat) (passed : belowTolerance d hd offset=true) : SourceSearchRun d hd offset offset
 | step (offset finish : Nat) (continues : belowTolerance d hd offset=false)
   (later : SourceSearchRun d hd (offset+1) finish) : SourceSearchRun d hd offset finish
theorem originalBoundedSearchRun (d : Nat) (hd : 0<d) (fuel offset : Nat)
 (bound : 2*d<gapDenominator (offset+fuel+1)) :
 SourceSearchRun d hd offset (searchOffset d hd fuel offset) := by
 induction fuel generalizing offset with
 | zero =>
  apply SourceSearchRun.stop
  exact sourceComparisonPasses d offset hd bound
 | succ fuel ih =>
  unfold searchOffset
  cases h : belowTolerance d hd offset with
  | true => exact SourceSearchRun.stop offset h
  | false =>
   apply SourceSearchRun.step offset _ h
   apply ih
   have idx : offset+1+fuel=offset+(fuel+1) := by
    rw [Nat.add_right_comm offset 1 fuel,Nat.add_assoc]
   rw [idx]
   exact bound
theorem originalSearchStops (d : Nat) (hd : 0<d) (start finish : Nat)
 (run : SourceSearchRun d hd start finish) : belowTolerance d hd finish=true := by
 induction run with
 | stop offset passed => exact passed
 | step offset finish continues later ih => exact ih
def toleranceWitness : GeneratorOperations.CountInput → Except String Nat
 | .boolean _ => .error "tolerance denominator must be a positive count"
 | .integer (.negSucc _) => .error "tolerance denominator must be a positive count"
 | .integer (.ofNat 0) => .error "tolerance denominator must be a positive count"
 | .integer (.ofNat (d+1)) => .ok (searchOffset (d+1) (Nat.zero_lt_succ _) (2*(d+1)+2) 0+2)
def toleranceIsWitnessed (input : GeneratorOperations.CountInput) : Except String Bool := do
 let level ← toleranceWitness input
 let denominator := (SectorInventory.countValue input).toNat
 if h : 0<denominator then
  let gap ← adjacentSectorGap (.integer (.ofNat level))
  pure ((add gap gap).blt (natRatio 1 denominator h))
 else .error "tolerance denominator must be a positive count"
theorem originalToleranceTrace (d : Nat) :
 SourceSearchRun (d+1) (Nat.zero_lt_succ _) 0
 (searchOffset (d+1) (Nat.zero_lt_succ _) (2*(d+1)+2) 0) := by
 apply originalBoundedSearchRun
 rw [Nat.zero_add]
 exact sourceFiniteSearchBound (d+1)
theorem originalEveryTolerance (d : Nat) :
 toleranceIsWitnessed (.integer (.ofNat (d+1)))=.ok true := by
 unfold toleranceIsWitnessed toleranceWitness
 dsimp only [Except.bind,Bind.bind,SectorInventory.countValue,Int.toNat]
 rw [dif_pos (Nat.zero_lt_succ d)]
 rw [originalGapLedger]
 dsimp only [Except.bind,Bind.bind]
 change Except.ok (belowTolerance (d+1) (Nat.zero_lt_succ _) (searchOffset (d+1) (Nat.zero_lt_succ _) (2*(d+1)+2) 0))=.ok true
 rw [originalSearchStops _ _ _ _ (originalToleranceTrace d)]
end SFT.Physics.AccumulatedSeparationTolerance
