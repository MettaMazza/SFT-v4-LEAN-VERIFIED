import SFT.Physics.PhaseComposition
namespace SFT.Physics.FreePhase
open SFT.Foundation ExactPartCarrier ExactOperations
open LeptonIntervals

def cyclicAdvance (phase advance : FoldFirstReturn.Input) : Except String Rat :=
 match phase with
 | .nonFraction => .error "phase advance requires exact fractions"
 | .fraction phase => match advance with
  | .nonFraction => .error "phase advance requires exact fractions"
  | .fraction advance => do
   let p ← (fromPair phase.num (.ofNat phase.den)).mapError
    (fun _ => "phase and advance must be positive Fold carriers")
   match advance with
   | ⟨.negSucc _,_,_,_⟩ => .error "phase and advance must be positive Fold carriers"
   | ⟨.ofNat n,d,hd,_⟩ =>
    if hn : 0<n then
     .ok (asFraction (PhaseComposition.advancePair p n d hn (Nat.pos_of_ne_zero hd)))
    else .error "phase and advance must be positive Fold carriers"

structure Result where
 momentum : Rat
 dispersion : Rat
 phaseAfter : Rat

def freeParticlePhase (phase momentum : FoldFirstReturn.Input) : Except String Result :=
 match momentum with
 | .nonFraction => .error "momentum must be an exact positive part no larger than half-One"
 | .fraction momentum => do
   if !(zero.blt momentum && !half.blt momentum) then
    throw "momentum must be an exact positive part no larger than half-One"
   let p ← fromPair momentum.num (.ofNat momentum.den)
   let dispersion := asFraction (foldPart p)
   let byFold ← cyclicAdvance phase (.fraction dispersion)
   let first ← cyclicAdvance phase (.fraction momentum)
   let byTwo ← cyclicAdvance (.fraction first) (.fraction momentum)
   if !(byFold.blt byTwo) && !(byTwo.blt byFold) then
    pure ⟨momentum,dispersion,byFold⟩
   else throw "free phase failed exact Fold/two-step correspondence"

theorem originalAssembly :
 freeParticlePhase (.fraction ⟨1,3,by decide,by decide⟩)
  (.fraction ⟨1,4,by decide,by decide⟩)=
 .ok ⟨⟨1,4,by decide,by decide⟩,⟨1,2,by decide,by decide⟩,⟨5,6,by decide,by decide⟩⟩ := rfl

theorem originalTwoStep :
 (do let first ← cyclicAdvance (.fraction ⟨1,3,by decide,by decide⟩)
       (.fraction ⟨1,4,by decide,by decide⟩)
     cyclicAdvance (.fraction first) (.fraction ⟨1,4,by decide,by decide⟩))=
 .ok (⟨5,6,by decide,by decide⟩ : Rat) := rfl

def potentialPhaseEvolution (phase kinetic potential : FoldFirstReturn.Input) : Except String (Rat × Rat × Rat × Rat) :=
 match kinetic with
 | .nonFraction => .error "energy carriers must be exact positive fractions"
 | .fraction kinetic => match potential with
  | .nonFraction => .error "energy carriers must be exact positive fractions"
  | .fraction potential => do
   if !(zero.blt kinetic && zero.blt potential) then
    throw "energy carriers must be exact positive fractions"
   let first ← cyclicAdvance phase (.fraction kinetic)
   let sequential ← cyclicAdvance (.fraction first) (.fraction potential)
   let total := add kinetic potential
   let joint ← cyclicAdvance phase (.fraction total)
   if !sequential.blt joint && !joint.blt sequential then
    pure (kinetic,potential,total,joint)
   else throw "sequential and joint exact phase evolution differ"

theorem originalPotentialAssembly :
 potentialPhaseEvolution (.fraction ⟨1,3,by decide,by decide⟩)
  (.fraction ⟨1,8,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩)=
 .ok (⟨1,8,by decide,by decide⟩,⟨1,4,by decide,by decide⟩,
  ⟨3,8,by decide,by decide⟩,⟨17,24,by decide,by decide⟩) := rfl

theorem sourceAdvance (phase : Part) (advance : PositiveFraction) :
 cyclicAdvance (.fraction (asFraction phase)) (.fraction (BoundaryGrowth.asFraction advance))=
 .ok (asFraction (PhaseComposition.advancePair phase advance.numerator advance.denominator
  advance.positive (Nat.pos_of_ne_zero advance.denominatorNonzero))) := by
 unfold cyclicAdvance
 dsimp only [asFraction,BoundaryGrowth.asFraction]
 rw [fromPairAdmitted phase.numerator phase.denominator phase.positive (denominatorPositive phase) phase.throughOne,
  normalizationStable]
 dsimp only [Except.mapError,Except.bind,Bind.bind,Except.pure,Pure.pure]
 rw [dite_eq_left advance.positive]

theorem sourcePartAdvance (phase advance : Part) :
 cyclicAdvance (.fraction (asFraction phase)) (.fraction (asFraction advance))=
 .ok (asFraction (PhaseComposition.advancePair phase advance.numerator advance.denominator
  advance.positive (denominatorPositive advance))) :=
 sourceAdvance phase ⟨advance.numerator,advance.denominator,advance.denominatorNonzero,advance.reduced,advance.positive⟩

theorem originalFoldTwoStepIdentity (phase momentum : Part)
 (halfBound : momentum.numerator+momentum.numerator ≤ momentum.denominator) :
 cyclicAdvance (.fraction (asFraction phase)) (.fraction (asFraction (foldPart momentum)))=
 (do let first ← cyclicAdvance (.fraction (asFraction phase)) (.fraction (asFraction momentum))
     cyclicAdvance (.fraction first) (.fraction (asFraction momentum))) := by
 rw [sourcePartAdvance,sourcePartAdvance]
 dsimp only [Except.bind,Bind.bind]
 rw [sourcePartAdvance]
 exact congrArg (fun p => Except.ok (asFraction p))
  (PhaseComposition.foldEqualsTwoAdvances phase momentum halfBound)

def foldTicks (momentum : Part) : Nat → Part → Part
 | 0,phase => phase
 | n+1,phase => foldTicks momentum n
   (PhaseComposition.advancePair phase (foldPart momentum).numerator (foldPart momentum).denominator
     (foldPart momentum).positive (denominatorPositive (foldPart momentum)))

def twoStepTicks (momentum : Part) : Nat → Part → Part
 | 0,phase => phase
 | n+1,phase => twoStepTicks momentum n
   (PhaseComposition.advancePair
    (PhaseComposition.advancePair phase momentum.numerator momentum.denominator momentum.positive (denominatorPositive momentum))
    momentum.numerator momentum.denominator momentum.positive (denominatorPositive momentum))

theorem everyFurtherTick (momentum : Part)
 (halfBound : momentum.numerator+momentum.numerator ≤ momentum.denominator)
 (n : Nat) (phase : Part) : foldTicks momentum n phase=twoStepTicks momentum n phase := by
 induction n generalizing phase with
 | zero => rfl
 | succ n ih =>
  rw [foldTicks,twoStepTicks,PhaseComposition.foldEqualsTwoAdvances phase momentum halfBound]
  exact ih _

theorem positiveSumRepresentation (left right : PositiveFraction) :
 LeptonIntervals.add (BoundaryGrowth.asFraction left) (BoundaryGrowth.asFraction right)=
 BoundaryGrowth.asFraction (normalizePositive
  (left.numerator*right.denominator+right.numerator*left.denominator)
  (left.denominator*right.denominator)
  (Nat.add_pos_left (Nat.mul_pos left.positive (Nat.pos_of_ne_zero right.denominatorNonzero)) _)
  (Nat.mul_pos (Nat.pos_of_ne_zero left.denominatorNonzero) (Nat.pos_of_ne_zero right.denominatorNonzero))) := by
 have normalized (n d : Nat) (hn : 0<n) (hd : 0<d) :
  LeptonIntervals.normalize (.ofNat n) d hd=BoundaryGrowth.asFraction (normalizePositive n d hn hd) := by
   cases n with
   | zero => exact False.elim (Nat.not_lt_zero _ hn)
   | succ n => rfl
 exact normalized _ _ _ _

theorem originalPotentialComposition (phase : Part) (kinetic potential : PositiveFraction) :
 (do let first ← cyclicAdvance (.fraction (asFraction phase)) (.fraction (BoundaryGrowth.asFraction kinetic))
     cyclicAdvance (.fraction first) (.fraction (BoundaryGrowth.asFraction potential)))=
 cyclicAdvance (.fraction (asFraction phase))
  (.fraction (LeptonIntervals.add (BoundaryGrowth.asFraction kinetic) (BoundaryGrowth.asFraction potential))) := by
 rw [sourceAdvance]
 dsimp only [Except.bind,Bind.bind]
 rw [sourceAdvance,positiveSumRepresentation,sourceAdvance]
 let n := kinetic.numerator*potential.denominator+potential.numerator*kinetic.denominator
 let d := kinetic.denominator*potential.denominator
 have hn : 0<n := Nat.add_pos_left (Nat.mul_pos kinetic.positive (Nat.pos_of_ne_zero potential.denominatorNonzero)) _
 have hd : 0<d := Nat.mul_pos (Nat.pos_of_ne_zero kinetic.denominatorNonzero) (Nat.pos_of_ne_zero potential.denominatorNonzero)
 let total := normalizePositive n d hn hd
 have eq := PhaseComposition.advanceEquivalent phase total.numerator total.denominator n d
  total.positive (Nat.pos_of_ne_zero total.denominatorNonzero) hn hd
  (normalizedValuePreserved n d hn hd).symm
 exact congrArg (fun p => Except.ok (asFraction p))
  ((PhaseComposition.twoAdvances phase kinetic.numerator kinetic.denominator potential.numerator potential.denominator
   kinetic.positive (Nat.pos_of_ne_zero kinetic.denominatorNonzero)
   potential.positive (Nat.pos_of_ne_zero potential.denominatorNonzero)).trans eq.symm)

end SFT.Physics.FreePhase
