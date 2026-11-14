import SFT.Physics.VacuumBeat
import SFT.Foundation.FoldCastLaws
namespace SFT.Physics.PhaseComposition
open SFT.Foundation ExactOperations ExactPartCarrier ExactCast FoldCastLaws FractionReduction ExactValueIdentity

private theorem distribute (a b c : Nat) : (a+b)*c=a*c+b*c := by
 rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]

private theorem commuteMiddle (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [← mulAssoc,Nat.mul_comm a b,mulAssoc]

private theorem shuffle (a b c d : Nat) : a*b*(c*d)=a*c*(b*d) := by
 rw [mulAssoc,commuteMiddle b c d,← mulAssoc]

private theorem swapEnds (a b c d : Nat) : a*b*(c*d)=a*d*(c*b) := by
 rw [mulAssoc,commuteMiddle b c d,Nat.mul_comm b d,commuteMiddle c d b,← mulAssoc]

def castPair (n d : Nat) (hn : 0<n) (hd : 0<d) : Part :=
 ExactOperations.castPositive (normalizePositive n d hn hd)

theorem pairScale (n d k : Nat) (hn : 0<n) (hd : 0<d) (hk : 0<k) :
 castPair (k*n) (k*d) (Nat.mul_pos hk hn) (Nat.mul_pos hk hd)=castPair n d hn hd := by
 unfold castPair
 rw [normalizedCast,normalizedCast]
 have h := castScale k n d hk hd
 exact normalizationByFactors _ _ _ _ k _ _ _ _ h rfl

theorem pairCross (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : n*e=m*d) : castPair n d hn hd=castPair m e hm he := by
 have h1 := pairScale n d e hn hd he
 have h2 := pairScale m e d hm he hd
 have num : e*n=d*m := (Nat.mul_comm e n).trans (cross.trans (Nat.mul_comm m d))
 have den := Nat.mul_comm e d
 have eq : castPair (e*n) (e*d) (Nat.mul_pos he hn) (Nat.mul_pos he hd)=
  castPair (d*m) (d*e) (Nat.mul_pos hd hm) (Nat.mul_pos hd he) := by
   exact congrArg ExactOperations.castPositive (positiveNormalizationCongr _ _ _ _ _ _ _ _ num den)
 exact h1.symm.trans (eq.trans h2)

theorem castThenAdd (n d m : Nat) (hd : 0<d) (hm : 0<m) :
 castNumerator (castNumerator n d+m) d=castNumerator (n+m) d := by
 have trace := castHasRemovalTrace n d hd
 generalize castNumerator n d = retained at trace ⊢
 induction trace with
 | retain n _ => rfl
 | step n retained h prior ih =>
   have decomp : n=(n-d)+d := (subtractAdd n d (Nat.le_of_lt h)).symm
   have plus : n+m=((n-d)+m)+d := by
    exact (congrArg (fun x => x+m) decomp).trans (Nat.add_right_comm (n-d) d m)
   exact ih.trans ((castAddingOne ((n-d)+m) d (Nat.add_pos_right _ hm) hd).symm.trans
    (congrArg (fun a => castNumerator a d) plus.symm))

theorem pairValue (n d : Nat) (hn : 0<n) (hd : 0<d) :
 castNumerator n d*(castPair n d hn hd).denominator=(castPair n d hn hd).numerator*d := by
 unfold castPair
 rw [normalizedCast]
 exact normalizedValuePreserved (castNumerator n d) d (ExactCast.castPositive n d hn hd) hd

def advancePair (p : Part) (a b : Nat) (ha : 0<a) (hb : 0<b) : Part :=
 castPair (p.numerator*b+a*p.denominator) (p.denominator*b)
  (Nat.add_pos_left (Nat.mul_pos p.positive hb) _) (Nat.mul_pos (denominatorPositive p) hb)

theorem afterCast (n d a b : Nat) (hn : 0<n) (hd : 0<d) (ha : 0<a) (hb : 0<b) :
 advancePair (castPair n d hn hd) a b ha hb=
 castPair (n*b+a*d) (d*b) (Nat.add_pos_left (Nat.mul_pos hn hb) _) (Nat.mul_pos hd hb) := by
 let p := castPair n d hn hd
 have pv := pairValue n d hn hd
 have cross : (p.numerator*b+a*p.denominator)*(d*b)=
  (castNumerator n d*b+a*d)*(p.denominator*b) := by
   rw [distribute,distribute]
   congr 1
   · calc
      p.numerator*b*(d*b)=(p.numerator*d)*(b*b) := shuffle _ _ _ _
      _=(castNumerator n d*p.denominator)*(b*b) := congrArg (fun x => x*(b*b)) pv.symm
      _=castNumerator n d*b*(p.denominator*b) := shuffle _ _ _ _
   · exact shuffle _ _ _ _
 have first := pairCross _ _ _ _
  (Nat.add_pos_left (Nat.mul_pos p.positive hb) _) (Nat.mul_pos (denominatorPositive p) hb)
  (Nat.add_pos_left (Nat.mul_pos (ExactCast.castPositive n d hn hd) hb) _) (Nat.mul_pos hd hb) cross
 have shift : castNumerator (castNumerator n d*b+a*d) (d*b)=castNumerator (n*b+a*d) (d*b) := by
  have scaled : castNumerator (n*b) (d*b)=castNumerator n d*b := by
   rw [Nat.mul_comm n b,Nat.mul_comm d b,castScale b n d hb hd,Nat.mul_comm b]
  rw [← scaled]
  exact castThenAdd (n*b) (d*b) (a*d) (Nat.mul_pos hd hb) (Nat.mul_pos ha hd)
 have second : castPair (castNumerator n d*b+a*d) (d*b)
   (Nat.add_pos_left (Nat.mul_pos (ExactCast.castPositive n d hn hd) hb) _) (Nat.mul_pos hd hb)=
   castPair (n*b+a*d) (d*b) (Nat.add_pos_left (Nat.mul_pos hn hb) _) (Nat.mul_pos hd hb) := by
  unfold castPair
  rw [normalizedCast,normalizedCast]
  apply partEquality
  · exact congrArg (fun x => x / Nat.gcd x (d*b)) shift
  · exact congrArg (fun x => (d*b) / Nat.gcd x (d*b)) shift
 exact first.trans second

theorem twoAdvances (p : Part) (a b c e : Nat) (ha : 0<a) (hb : 0<b)
 (hc : 0<c) (he : 0<e) :
 advancePair (advancePair p a b ha hb) c e hc he=
 advancePair p (a*e+c*b) (b*e) (Nat.add_pos_left (Nat.mul_pos ha he) _) (Nat.mul_pos hb he) := by
 have next := afterCast (p.numerator*b+a*p.denominator) (p.denominator*b) c e
  (Nat.add_pos_left (Nat.mul_pos p.positive hb) _) (Nat.mul_pos (denominatorPositive p) hb) hc he
 have numerator : (p.numerator*b+a*p.denominator)*e+c*(p.denominator*b)=
  p.numerator*(b*e)+(a*e+c*b)*p.denominator := by
   rw [distribute,distribute]
   rw [mulAssoc p.numerator b e,mulAssoc a p.denominator e,
    Nat.mul_comm p.denominator e,← mulAssoc a e p.denominator,
    Nat.mul_comm p.denominator b,← mulAssoc c b p.denominator,Nat.add_assoc]
 have denominator : p.denominator*b*e=p.denominator*(b*e) := mulAssoc _ _ _
 exact next.trans (congrArg ExactOperations.castPositive
  (positiveNormalizationCongr _ _ _ _ _ _ _ _ numerator denominator))

theorem advanceEquivalent (p : Part) (a b c e : Nat) (ha : 0<a) (hb : 0<b)
 (hc : 0<c) (he : 0<e) (cross : a*e=c*b) :
 advancePair p a b ha hb=advancePair p c e hc he := by
 apply pairCross
 rw [distribute,distribute]
 congr 1
 · exact swapEnds _ _ _ _
 · calc
    a*p.denominator*(p.denominator*e)=(a*e)*(p.denominator*p.denominator) := swapEnds _ _ _ _
    _=(c*b)*(p.denominator*p.denominator) := congrArg (fun x => x*(p.denominator*p.denominator)) cross
    _=c*p.denominator*(p.denominator*b) := swapEnds _ _ _ _

theorem foldEqualsTwoAdvances (phase momentum : Part)
 (half : momentum.numerator+momentum.numerator ≤ momentum.denominator) :
 advancePair phase (foldPart momentum).numerator (foldPart momentum).denominator
  (foldPart momentum).positive (denominatorPositive (foldPart momentum))=
 advancePair (advancePair phase momentum.numerator momentum.denominator
  momentum.positive (denominatorPositive momentum)) momentum.numerator momentum.denominator
  momentum.positive (denominatorPositive momentum) := by
 have fold := castNormalizedAdmitted (momentum.numerator+momentum.numerator) momentum.denominator
  (Nat.add_pos_left momentum.positive _) (denominatorPositive momentum) half
 have fraction := normalizedValuePreserved (momentum.numerator+momentum.numerator) momentum.denominator
  (Nat.add_pos_left momentum.positive _) (denominatorPositive momentum)
 have value : (foldPart momentum).numerator*momentum.denominator=
  (momentum.numerator+momentum.numerator)*(foldPart momentum).denominator := by
   unfold foldPart
   rw [fold]
   exact fraction.symm
 have direct := advanceEquivalent phase (foldPart momentum).numerator (foldPart momentum).denominator
  (momentum.numerator+momentum.numerator) momentum.denominator
  (foldPart momentum).positive (denominatorPositive (foldPart momentum))
  (Nat.add_pos_left momentum.positive _) (denominatorPositive momentum) value
 have doubled := twoAdvances phase momentum.numerator momentum.denominator momentum.numerator momentum.denominator
  momentum.positive (denominatorPositive momentum) momentum.positive (denominatorPositive momentum)
 have reduce := advanceEquivalent phase
  (momentum.numerator*momentum.denominator+momentum.numerator*momentum.denominator)
  (momentum.denominator*momentum.denominator)
  (momentum.numerator+momentum.numerator) momentum.denominator
  (Nat.add_pos_left (Nat.mul_pos momentum.positive (denominatorPositive momentum)) _)
  (Nat.mul_pos (denominatorPositive momentum) (denominatorPositive momentum))
  (Nat.add_pos_left momentum.positive _) (denominatorPositive momentum)
  (by rw [distribute,distribute,mulAssoc])
 exact direct.trans (doubled.trans reduce).symm

end SFT.Physics.PhaseComposition
