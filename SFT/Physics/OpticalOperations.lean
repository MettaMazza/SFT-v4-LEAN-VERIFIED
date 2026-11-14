import SFT.Physics.FreePhase
import SFT.Physics.AlphaCovers
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.OpticalOperations
open SFT.Foundation ExactOperations ExactPartCarrier
open LeptonIntervals
structure Mixing where
 sum : Rat
 positiveDifference : Rat
 secondHarmonic : Rat
 kerrSelfAction : Rat
 thirdHarmonic : Rat
structure Result where
 propagation : List Rat
 polarization : List String
 brightSupport : Rat
 darkRecord : List Unit
 mixing : Mixing

def same (a b : Rat) : Bool := !a.blt b && !b.blt a

def exactOpticalOperations : Except String Result := do
 let binary ← AlphaCovers.binaryCount
 let half ← LeptonRatios.divide (asFraction one) (VacuumLedgerProofs.wholeRatio binary)
 let first : Rat := ⟨1,3,by decide,by decide⟩
 let second : Rat := ⟨1,4,by decide,by decide⟩
 let propagation ← (List.range 8).mapM (fun _ => FreePhase.cyclicAdvance (.fraction first) (.fraction (asFraction one)))
 let polarization := ["transverse-left","transverse-right"]
 let bright := add half half
 let dark : List Unit := []
 let secondPart ← fromPair second.num (.ofNat second.den)
 let kerrPart ← fromPair 3 4
 let mixing : Mixing := ⟨add first second,subtract first second,
   asFraction (foldPart secondPart),asFraction (foldPart kerrPart),
   multiply ⟨3,1,by decide,by decide⟩ ⟨1,6,by decide,by decide⟩⟩
 if !(propagation.all (same first)) then throw "One-speed propagation retained a phase residue"
 let values := [mixing.sum,mixing.positiveDifference,mixing.secondHarmonic,mixing.kerrSelfAction,mixing.thirdHarmonic]
 let expected : List Rat := [⟨7,12,by decide,by decide⟩,⟨1,12,by decide,by decide⟩,⟨1,2,by decide,by decide⟩]
 if !(same bright (asFraction one) && dark.isEmpty &&
   values.all (fun x => expected.any (same x)) && expected.all (fun x => values.any (same x))) then
   throw "optical operation ledger failed"
 pure ⟨propagation,polarization,bright,dark,mixing⟩

def originalRecord : Result :=
 ⟨List.replicate 8 ⟨1,3,by decide,by decide⟩,["transverse-left","transverse-right"],
  ⟨1,1,by decide,by decide⟩,[],
  ⟨⟨7,12,by decide,by decide⟩,⟨1,12,by decide,by decide⟩,
    ⟨1,2,by decide,by decide⟩,⟨1,2,by decide,by decide⟩,⟨1,2,by decide,by decide⟩⟩⟩

theorem completeSourceRecord : exactOpticalOperations=.ok originalRecord := by
 unfold exactOpticalOperations
 rw [AlphaCovers.binaryCountTwo]
 rfl
theorem oneSpeedAdvance (p : Part) :
 FreePhase.cyclicAdvance (.fraction (asFraction p)) (.fraction (asFraction one)) = .ok (asFraction p) := by
 rw [FreePhase.sourcePartAdvance]
 have h : PhaseComposition.advancePair p 1 1 (by decide) (by decide)=p := by
  unfold PhaseComposition.advancePair PhaseComposition.castPair
  simp only [Nat.mul_one,Nat.one_mul]
  rw [FoldCastLaws.normalizedCast]
  have hn := ExactCast.castAddingOne p.numerator p.denominator p.positive (denominatorPositive p)
  have hr := ExactCast.castRetains p.numerator p.denominator (denominatorPositive p) p.throughOne
  have he : ExactCast.castNumerator (p.numerator+p.denominator) p.denominator=p.numerator := hn.trans hr
  apply partEquality
  · change ExactCast.castNumerator (p.numerator+p.denominator) p.denominator / Nat.gcd (ExactCast.castNumerator (p.numerator+p.denominator) p.denominator) p.denominator=p.numerator
    rw [he]
    exact congrArg Part.numerator (normalizationStable p)
  · change p.denominator / Nat.gcd (ExactCast.castNumerator (p.numerator+p.denominator) p.denominator) p.denominator=p.denominator
    rw [he]
    exact congrArg Part.denominator (normalizationStable p)
 change Except.ok (asFraction (PhaseComposition.advancePair p 1 1 (by decide) (by decide))) = _
 rw [h]

def oneSpeedTicks : Nat → Part → Except String Rat
 | 0,p => .ok (asFraction p)
 | n+1,p => do
   let prior ← oneSpeedTicks n p
   FreePhase.cyclicAdvance (.fraction prior) (.fraction (asFraction one))

theorem everyFurtherOneSpeedTick (n : Nat) (p : Part) : oneSpeedTicks n p=.ok (asFraction p) := by
 induction n with
 | zero => rfl
 | succ n ih =>
  unfold oneSpeedTicks
  rw [ih]
  exact oneSpeedAdvance p
end SFT.Physics.OpticalOperations
