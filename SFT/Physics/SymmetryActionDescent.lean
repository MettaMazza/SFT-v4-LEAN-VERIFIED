import SFT.Physics.SymmetryActionDyadic
import SFT.Physics.AccumulatedSeparationTolerance
namespace SFT.Physics.SymmetryActionDescent
open SymmetryAction SymmetryActionDyadic SymmetryActionConservation SymmetryActionOddCore
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open SFT.Mathematics.OrbitBinaryDepth
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalDyadicNextDenominator (p : Part) (depth : Nat) (shape : p.denominator=2^(depth+1)) :
 (SFT.Foundation.ExactOperations.foldPart p).denominator=2^depth := by
 have red : Nat.gcd p.numerator (2^(1+depth)*1)=1 := by
  rw [Nat.mul_one,Nat.add_comm 1 depth,←shape]
  exact p.reduced
 have h := executedDenominatorBeforeDepth p.numerator 1 1 depth (by decide) red
 rw [Nat.mul_one,Nat.mul_one,Nat.add_comm 1 depth,←shape] at h
 rw [originalFoldDenominator]
 exact h
theorem originalDenominatorOneStops (p : Part) (shape : p.denominator=1) :
 (p.numerator==p.denominator)=true := by
 have num : p.numerator=1 := Nat.le_antisymm (shape ▸ p.throughOne) p.positive
 rw [num,shape]
 rfl
theorem originalPositiveDepthContinues (p : Part) (depth : Nat) (shape : p.denominator=2^(depth+1)) :
 (p.numerator==p.denominator)=false := by
 cases h : p.numerator==p.denominator with
 | false => rfl
 | true =>
  have same := Nat.eq_of_beq_eq_true h
  have red : Nat.gcd p.numerator p.denominator=1 := p.reduced
  rw [same,gcdSelf,shape,Nat.pow_succ] at red
  have bound : 2≤2^depth*2 := Nat.mul_le_mul_right 2 (Nat.pow_pos (by decide : 0<2))
  rw [red] at bound
  exact False.elim (Nat.not_succ_le_self 1 bound)
inductive SourceDescent : Part → List Part → Prop where
 | stop (p : Part) (one : p.numerator=p.denominator) : SourceDescent p [p]
 | step (p : Part) (rest : List Part) (nonterminal : p.numerator≠p.denominator)
   (tail : SourceDescent (SFT.Foundation.ExactOperations.foldPart p) rest) : SourceDescent p (p::rest)
theorem originalDyadicTrace (depth fuel : Nat) (p : Part) (shape : p.denominator=2^depth)
 (enough : depth+1≤fuel) : SourceDescent p (traceLoop fuel p) := by
 induction depth generalizing p fuel with
 | zero =>
  cases fuel with
  | zero => exact False.elim (Nat.not_succ_le_zero _ enough)
  | succ fuel =>
   unfold traceLoop
   rw [originalDenominatorOneStops p shape]
   apply SourceDescent.stop
   exact Nat.eq_of_beq_eq_true (originalDenominatorOneStops p shape)
 | succ depth ih =>
  cases fuel with
  | zero => exact False.elim (Nat.not_succ_le_zero _ enough)
  | succ fuel =>
   unfold traceLoop
   rw [originalPositiveDepthContinues p depth shape]
   apply SourceDescent.step
   · intro equal
     have h := originalPositiveDepthContinues p depth shape
     rw [equal] at h
     change Nat.beq p.denominator p.denominator=false at h
     rw [SFT.Mathematics.OrbitLoopCompletion.natBeqSelf] at h
     cases h
   · exact ih fuel (SFT.Foundation.ExactOperations.foldPart p) (originalDyadicNextDenominator p depth shape)
      (Nat.le_of_succ_le_succ enough)
theorem originalTraceLength (depth fuel : Nat) (p : Part) (shape : p.denominator=2^depth)
 (enough : depth+1≤fuel) : (traceLoop fuel p).length=depth+1 := by
 induction depth generalizing p fuel with
 | zero =>
  cases fuel with
  | zero => exact False.elim (Nat.not_succ_le_zero _ enough)
  | succ fuel => unfold traceLoop; rw [originalDenominatorOneStops p shape]; rfl
 | succ depth ih =>
  cases fuel with
  | zero => exact False.elim (Nat.not_succ_le_zero _ enough)
  | succ fuel =>
   unfold traceLoop
   rw [originalPositiveDepthContinues p depth shape]
   change (traceLoop fuel (SFT.Foundation.ExactOperations.foldPart p)).length+1=depth+1+1
   rw [ih fuel _ (originalDyadicNextDenominator p depth shape) (Nat.le_of_succ_le_succ enough)]
theorem originalDyadicDomain (p : Part) :
 reducedOddDenominatorCore (.fraction (asFraction p))=.ok 1 ↔ ∃ depth, p.denominator=2^depth := by
 constructor
 · intro passed
   obtain ⟨depth,core,hc,odd,shape⟩ := SFT.Mathematics.BoundedFoldTransient.denominatorDecomposes p.denominator (denominatorPositive p)
   rw [originalCoreFromDenominatorFactors p depth core odd shape] at passed
   have one := Except.ok.inj passed
   rw [one,Nat.mul_one] at shape
   exact ⟨depth,shape⟩
 · intro h
   obtain ⟨depth,shape⟩ := h
   apply originalCoreFromDenominatorFactors p depth 1 (by decide)
   rw [Nat.mul_one]
   exact shape
theorem originalReturnedTrace (p : Part) (depth : Nat) (shape : p.denominator=2^depth) :
 dyadicFoldDescent (.fraction (asFraction p))=.ok ((traceLoop (p.denominator+1) p).map asFraction) := by
 unfold dyadicFoldDescent
 rw [(originalDyadicDomain p).mpr ⟨depth,shape⟩]
 dsimp only [Except.bind,Bind.bind]
 change (match admitFraction (asFraction p) with
   | none => Except.error "odd-core custody requires one exact positive Fold part"
   | some q => Except.ok ((traceLoop (q.denominator+1) q).map asFraction)) = _
 rw [admittedPartRoundTrip]
theorem originalEveryDyadicTrace (p : Part) (depth : Nat) (shape : p.denominator=2^depth) :
 SourceDescent p (traceLoop (p.denominator+1) p) ∧ (traceLoop (p.denominator+1) p).length=depth+1 := by
 have enough : depth+1≤p.denominator+1 := by
  rw [shape]
  exact Nat.le_trans (AccumulatedSeparationTolerance.sourcePowerCoversCount depth) (Nat.le_succ _)
 exact ⟨originalDyadicTrace depth _ p shape enough,originalTraceLength depth _ p shape enough⟩
theorem originalTraceUnique (p : Part) (a b : List Part) (first : SourceDescent p a)
 (second : SourceDescent p b) : a=b := by
 induction first generalizing b with
 | stop p one =>
  cases second with
  | stop _ _ => rfl
  | step _ _ nonterminal _ => exact False.elim (nonterminal one)
 | step p rest nonterminal tail ih =>
  cases second with
  | stop _ one => exact False.elim (nonterminal one)
  | step _ _ _ later => exact congrArg (List.cons p) (ih _ later)
theorem originalTraceEndsAtOne (p : Part) (trace : List Part) (run : SourceDescent p trace) :
 ∃ before terminal, trace=before++[terminal] ∧ terminal.numerator=terminal.denominator := by
 induction run with
 | stop p one => exact ⟨[],p,rfl,one⟩
 | step p rest nonterminal tail ih =>
  obtain ⟨before,terminal,shape,one⟩ := ih
  exact ⟨p::before,terminal,congrArg (List.cons p) shape,one⟩
end SFT.Physics.SymmetryActionDescent
