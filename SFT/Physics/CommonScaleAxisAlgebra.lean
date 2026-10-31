import SFT.Physics.CommonScaleAxisProofs
namespace SFT.Physics.CommonScaleAxis
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
open VacuumLedgerProofs VacuumScaleProofs LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 8000000

def weakNumerator (s : Nat) := (s+2)*(s+2)
def weakDenominator (s : Nat) := 4*(s+1)*(s+1)+weakNumerator s
theorem weakNumeratorPositive (s : Nat) : 0<weakNumerator s := Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _)
theorem weakDenominatorPositive (s : Nat) : 0<weakDenominator s := Nat.add_pos_right _ (weakNumeratorPositive s)
def weakRatio (s : Nat) := natRatio (weakNumerator s) (weakDenominator s) (weakDenominatorPositive s)

theorem scaledRatio (n d scale : Nat) (hd : 0<d) (hs : 0<scale) :
 natRatio n d hd=natRatio (scale*n) (scale*d) (Nat.mul_pos hs hd) := by
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]

theorem squaredSupportFormula (s : Nat) : squaredSupport s=.ok (weakRatio s) := by
 let a := (s+1)*(s+1)
 let b := (s+2)*(s+2)
 have bp : 0<b := weakNumeratorPositive s
 have dp : 0<4*a+b := Nat.add_pos_right _ bp
 have charged : natRatio a b bp=natRatio (4*a) (4*b) (Nat.mul_pos (by decide) bp) := scaledRatio _ _ _ _ (by decide)
 have neutral : natRatio 1 4 (by decide)=natRatio b (4*b) (Nat.mul_pos (by decide) bp) := by
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_comm]
 unfold squaredSupport
 change LeptonRatios.divide (multiply (natRatio 1 2 _) (natRatio 1 2 _))
  (add (multiply (natRatio (s+1) (s+2) _) (natRatio (s+1) (s+2) _))
   (multiply (natRatio 1 2 _) (natRatio 1 2 _)))=.ok (weakRatio s)
 conv => lhs; simp only [multiplyNormalized]
 change LeptonRatios.divide (natRatio 1 4 _) (add (natRatio a b bp) (natRatio 1 4 _))=_
 rw [charged]
 conv => lhs; arg 2; rw [neutral,addNormalized]
 rw [divideNormalized _ _ _ _ _ dp _]
 apply congrArg Except.ok
 unfold weakRatio
 apply natRatioCongruence
 change (1*(4*b))*(4*(s+1)*(s+1)+b)=b*(4*(4*a+b))
 rw [mulAssoc 4 (s+1) (s+1)]
 change (1*(4*b))*(4*a+b)=b*(4*(4*a+b))
 conv => lhs; simp only [Nat.one_mul,mulAssoc,Nat.mul_comm,multiplyLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]

theorem normalizedPositiveAsRat (n d : Nat) (hn : 0<n) (hd : 0<d) :
 BoundaryGrowth.asFraction (normalizePositive n d hn hd)=natRatio n d hd := by
 cases n with
 | zero => cases hn
 | succ n => rfl

theorem existingRunningFormula (n : Nat) :
 (ElectroweakTerminalRatio.runningShare (.integer (.ofNat (n+1)))).map BoundaryGrowth.asFraction=
 .ok (weakRatio (n+1)) := by
 change Except.ok (BoundaryGrowth.asFraction (normalizePositive (weakNumerator (n+1)) (weakDenominator (n+1)) _ _))=_
 exact congrArg Except.ok (normalizedPositiveAsRat _ _ _ _)

theorem rationalNotUnequalSelf (q : Rat) : (q != q)=false := by
 change (!decide (q=q))=false
 rw [show decide (q=q)=true from decide_eq_true rfl]
 rfl

theorem leadingSupportFormula (s : Nat) (positive : 0<s) :
 leadingElectroweakShareAtSupport (.integer (.ofNat s))=.ok (weakRatio s) := by
 cases s with
 | zero => cases positive
 | succ n =>
  unfold leadingElectroweakShareAtSupport
  dsimp only [positiveCountValue]
  rw [squaredSupportFormula]
  change (do
   let existing ← ElectroweakTerminalRatio.runningShare (.integer (.ofNat (n+1)))
   if weakRatio (n+1) != BoundaryGrowth.asFraction existing then
    Except.error "electroweak squared-support identities diverged"
   else Except.ok (weakRatio (n+1)))=_
  change (if weakRatio (n+1) != BoundaryGrowth.asFraction (normalizePositive (weakNumerator (n+1)) (weakDenominator (n+1)) _ _) then
   Except.error "electroweak squared-support identities diverged" else Except.ok (weakRatio (n+1)))=_
  have sameRatio := normalizedPositiveAsRat (weakNumerator (n+1)) (weakDenominator (n+1))
   (weakNumeratorPositive (n+1)) (weakDenominatorPositive (n+1))
  exact (congrArg (fun q : Rat => if weakRatio (n+1) != q then
   Except.error "electroweak squared-support identities diverged" else Except.ok (weakRatio (n+1))) sameRatio).trans (by
    change (if weakRatio (n+1) != weakRatio (n+1) then _ else _)=_
    rw [rationalNotUnequalSelf]
    rfl)

theorem everyLeadingLevel (k : Nat) :
 leadingElectroweakShare (.integer (.ofNat (k+1)))=.ok (weakRatio (2^k)) := by
 unfold leadingElectroweakShare
 rw [RunningConvergence.everyPositiveLevel]
 exact leadingSupportFormula _ (Nat.pow_pos (by decide))

theorem binaryRecognition (n : Nat) (positive : 0<n) :
 isBinarySupport (.integer (.ofNat n))=.ok ((RunningConvergence.reachingPair n).2 == n) := by
 cases n with
 | zero => cases positive
 | succ n => rfl

theorem operationalAnchorUnique (k : Nat)
 (accepted : isBinarySupport (.integer (.ofNat (2+2^k)))=.ok true) : k=1 := by
 rw [binaryRecognition _ (Nat.add_pos_left (by decide) _)] at accepted
 have equality := Nat.eq_of_beq_eq_true (Except.ok.inj accepted)
 exact binarySourceHasOnlyOneAnchor k (RunningConvergence.reachingDepth (2+2^k)) equality.symm

theorem subtractionZeroOfBound (a b : Nat) (bound : a≤b) : a-b=0 := by
 induction b generalizing a with
 | zero =>
  cases a with
  | zero => rfl
  | succ a => cases bound
 | succ b ih =>
  cases a with
  | zero => exact Nat.zero_sub _
  | succ a => exact (Nat.succ_sub_succ_eq_sub a b).trans (ih a (Nat.le_of_succ_le_succ bound))

theorem integerNaturalLess (a b : Nat) (bound : a<b) : (Int.ofNat a)<Int.ofNat b := by
 change Int.NonNeg (Int.subNatNat b (a+1))
 unfold Int.subNatNat
 rw [subtractionZeroOfBound (a+1) b bound]
 exact Int.NonNeg.mk _

theorem normalizedCrossLess (n d m e : Nat) (hd : 0<d) (he : 0<e) (cross : n*e<m*d) :
 (natRatio n d hd).num.natAbs*(natRatio m e he).den <
 (natRatio m e he).num.natAbs*(natRatio n d hd).den := by
 let a := natRatio n d hd
 let b := natRatio m e he
 have av := natRatioValue n d hd
 have bv := natRatioValue m e he
 have left : (a.num.natAbs*b.den)*(d*e)=(n*e)*(a.den*b.den) := by
  calc
   (a.num.natAbs*b.den)*(d*e)=(a.num.natAbs*d)*(b.den*e) := SFT.Foundation.PrimitiveMaps.mulInterchange _ _ _ _
   _ = (n*a.den)*(b.den*e) := congrArg (fun x => x*(b.den*e)) av.symm
   _ = (n*e)*(a.den*b.den) := by
    conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
    conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
 have right : (b.num.natAbs*a.den)*(d*e)=(m*d)*(a.den*b.den) := by
  calc
   (b.num.natAbs*a.den)*(d*e)=(b.num.natAbs*e)*(a.den*d) := by
    conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
    conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
   _ = (m*b.den)*(a.den*d) := congrArg (fun x => x*(a.den*d)) bv.symm
   _ = (m*d)*(a.den*b.den) := by
    conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
    conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm]
 have scaled : (a.num.natAbs*b.den)*(d*e)<(b.num.natAbs*a.den)*(d*e) := by
  rw [left,right]
  exact Nat.mul_lt_mul_of_pos_right cross (Nat.mul_pos (Nat.pos_of_ne_zero a.den_nz) (Nat.pos_of_ne_zero b.den_nz))
 apply Nat.lt_of_not_ge
 intro opposite
 exact Nat.lt_irrefl _ (Nat.lt_of_lt_of_le scaled (Nat.mul_le_mul_right (d*e) opposite))

theorem positiveNormalizedLess (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : n*e<m*d) : (natRatio n d hd).blt (natRatio m e he)=true := by
 have ap := positiveNormalizedNumerator n d hn hd
 have bp := positiveNormalizedNumerator m e hm he
 have less := normalizedCrossLess n d m e hd he cross
 unfold Rat.blt
 rw [natRatioNonnegative n d hd,natRatioNonnegative m e he]
 generalize ha : (natRatio n d hd).num.natAbs=na at ap less ⊢
 generalize hb : (natRatio m e he).num.natAbs=nb at bp less ⊢
 cases na with
 | zero => cases ap
 | succ na =>
  cases nb with
  | zero => cases bp
  | succ nb =>
   have notNeg : ¬Int.ofNat (na+1)<0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (na+2)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   have notZero : Int.ofNat (na+1)≠0 := fun h => Nat.noConfusion (congrArg Int.toNat h)
   have notNonpos : ¬Int.ofNat (nb+1)≤0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (nb+1)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   rw [decide_eq_false notNeg]
   rw [if_neg notZero]
   rw [decide_eq_false notNonpos,Bool.and_false,Bool.false_and]
   change decide (Int.ofNat ((na+1)*(natRatio m e he).den)<Int.ofNat ((nb+1)*(natRatio n d hd).den))=true
   exact decide_eq_true (integerNaturalLess _ _ less)

theorem addLeftComm (a b c : Nat) : a+(b+c)=b+(a+c) := by
 rw [←Nat.add_assoc,Nat.add_comm a b,Nat.add_assoc]
theorem successorMultiply (a b : Nat) : (a+1)*b=a*b+b :=
 (addMul a 1 b).trans (congrArg (fun n => a*b+n) (Nat.one_mul b))

theorem squareDifference (x y : Nat) : (y+x)*(y+x)=y*y+x*(2*y+x) := by
 conv => lhs; simp only [Nat.mul_add,addMul,mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm]
 conv => rhs; simp only [Nat.mul_add,addMul,successorMultiply,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.mul_one,Nat.one_mul,mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm,Nat.zero_add,Nat.add_zero]

theorem descentProductIdentity (s : Nat) : (s+2)*(2*s+1)=(2*s+2)*(s+1)+s := by
 conv => lhs; simp only [Nat.mul_add,addMul,successorMultiply,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.mul_one,Nat.one_mul,mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm,Nat.zero_add,Nat.add_zero]
 conv => rhs; simp only [Nat.mul_add,addMul,successorMultiply,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.mul_one,Nat.one_mul,mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm,Nat.zero_add,Nat.add_zero]

theorem descentMiddleIdentity (s : Nat) : 2*((2*s+2)*(s+1))+s=4*s*s+9*s+4 := by
 conv => lhs; simp only [Nat.mul_add,addMul,successorMultiply,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.mul_one,Nat.one_mul,mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm,Nat.zero_add,Nat.add_zero]
 conv => rhs; simp only [Nat.mul_add,addMul,successorMultiply,Nat.mul_succ,Nat.mul_zero,Nat.zero_mul,Nat.mul_one,Nat.one_mul,mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm,Nat.zero_add,Nat.add_zero]

theorem descentInnerIdentity (s : Nat) :
 ((s+2)*(s+2))*((2*s+1)*(2*s+1))=
 ((2*s+2)*(2*s+2))*((s+1)*(s+1))+s*(4*s*s+9*s+4) := by
 rw [SFT.Foundation.PrimitiveMaps.mulInterchange (s+2) (s+2) (2*s+1) (2*s+1)]
 rw [descentProductIdentity,squareDifference,descentMiddleIdentity]
 exact congrArg (fun n => n+s*(4*s*s+9*s+4))
  (SFT.Foundation.PrimitiveMaps.mulInterchange (2*s+2) (s+1) (2*s+2) (s+1))

theorem denominatorSquare (s : Nat) : weakDenominator s=4*((s+1)*(s+1))+weakNumerator s :=
 congrArg (fun n => n+weakNumerator s) (mulAssoc 4 (s+1) (s+1))

theorem descentCrossIdentity (s : Nat) :
 weakNumerator s*weakDenominator (2*s)=
 weakNumerator (2*s)*weakDenominator s+4*s*(4*s*s+9*s+4) := by
 rw [denominatorSquare,denominatorSquare]
 let a := weakNumerator s
 let b := weakNumerator (2*s)
 let c := (s+1)*(s+1)
 let d := (2*s+1)*(2*s+1)
 let delta := 4*s*s+9*s+4
 have base : a*d=b*c+s*delta := descentInnerIdentity s
 change a*(4*d+b)=b*(4*c+a)+4*s*delta
 rw [Nat.mul_add a (4*d) b,Nat.mul_add b (4*c) a,
  multiplyLeftComm a 4 d,multiplyLeftComm b 4 c,base,Nat.mul_add 4 (b*c) (s*delta)]
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,multiplyLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm]

theorem everySupportDescent (s : Nat) (positive : 0<s) : (weakRatio (2*s)).blt (weakRatio s)=true := by
 apply positiveNormalizedLess _ _ _ _ (weakNumeratorPositive _) (weakDenominatorPositive _) (weakNumeratorPositive _) (weakDenominatorPositive _)
 rw [descentCrossIdentity]
 exact Nat.lt_add_of_pos_right (Nat.mul_pos (Nat.mul_pos (by decide) positive) (Nat.add_pos_right _ (by decide)))

theorem everySuccessiveLevelDescends (k : Nat) : (weakRatio (2^(k+1))).blt (weakRatio (2^k))=true := by
 rw [Nat.pow_succ,Nat.mul_comm (2^k) 2]
 exact everySupportDescent _ (Nat.pow_pos (by decide))

end SFT.Physics.CommonScaleAxis
