import SFT.Physics.PostNewtonianFixedPointCertificate
import SFT.Physics.CoupledMapCriticalityGeneral
namespace SFT.Physics.PostNewtonianFixedPointGeneral
open PostNewtonianFixedPoint LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactCast
set_option maxHeartbeats 100000000
private theorem productLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [←mulAssoc,Nat.mul_comm a b,mulAssoc]
theorem originalSuccessorFormula (n d : Nat) (hn : 0<n) (hd : 0<d)
 (within : (normalize 1 1 (by decide)).blt (natRatio n d hd)=false) :
 selfSourceSuccessor (.fraction (natRatio n d hd))=.ok (natRatio (7*(d*d)+16*(n*n)) (32*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd))) := by
 unfold selfSourceSuccessor
 dsimp only
 rw [positiveNormalized n d hn hd,within]
 rw [originalStructuralValues]
 change Except.ok (multiply (natRatio 1 2 (by decide)) (add (natRatio 7 16 (by decide)) (multiply (natRatio n d hd) (natRatio n d hd))))=_
 rw [multiplyNormalized]
 have source : natRatio 7 16 (by decide)=natRatio (7*(d*d)) (16*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) := by
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 have squared : natRatio (n*n) (d*d) (Nat.mul_pos hd hd)=natRatio (16*(n*n)) (16*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) := by
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 rw [source,squared,addNormalized,multiplyNormalized]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul,←mulAssoc 2 16 (d*d)]
private theorem squareCounts (n g : Nat) :
 (4*n+g)*(4*n+g)=16*(n*n)+8*(n*g)+g*g := by
 rw [CommonScaleAxis.squareDifference g (4*n)]
 have first : (4*n)*(4*n)=16*(n*n) := by
  rw [mulAssoc 4 n (4*n),productLeftComm n 4 n,←mulAssoc 4 4 (n*n)]
 have twice : 2*(4*n)=8*n := (mulAssoc 2 4 n).symm
 have mixed : g*(8*n)=8*(n*g) := by
  rw [productLeftComm g 8 n,Nat.mul_comm g n]
 rw [first,twice,Nat.mul_add,mixed]
 exact (Nat.add_assoc _ _ _).symm
private theorem polynomialScale (k a b c x y z : Nat) :
 k*(a*x+b*y+c*z)=(k*a)*x+(k*b)*y+(k*c)*z := by
 rw [Nat.mul_add,Nat.mul_add,←mulAssoc k a x,←mulAssoc k b y,←mulAssoc k c z]
private theorem polynomialAdd (a b c d e f x y z : Nat) :
 (a*x+b*y+c*z)+(d*x+e*y+f*z)=(a+d)*x+(b+e)*y+(c+f)*z := by
 conv => lhs; simp only [Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
 conv => rhs; simp only [addMul,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
private theorem nextNumeratorExpanded (n g : Nat) :
 7*((4*n+g)*(4*n+g))+16*(n*n)=128*(n*n)+56*(n*g)+7*(g*g) := by
 rw [squareCounts]
 have scaled : 7*(16*(n*n)+8*(n*g)+g*g)=112*(n*n)+56*(n*g)+7*(g*g) := by
  have h := polynomialScale 7 16 8 1 (n*n) (n*g) (g*g)
  rw [Nat.one_mul] at h
  exact h
 rw [scaled]
 have added := polynomialAdd 112 56 7 16 0 0 (n*n) (n*g) (g*g)
 rw [Nat.zero_mul,Nat.zero_mul,Nat.add_zero,Nat.add_zero,Nat.add_zero,Nat.add_zero] at added
 exact added
private theorem gapExpanded (n g : Nat) :
 4*g*(8*n+g)=0*(n*n)+32*(n*g)+4*(g*g) := by
 rw [Nat.mul_add,Nat.zero_mul,Nat.zero_add]
 have first : 4*g*(8*n)=32*(n*g) := by
  rw [mulAssoc 4 g (8*n),productLeftComm g 8 n,←mulAssoc 4 8 (g*n),Nat.mul_comm g n]
 rw [first,mulAssoc 4 g g]
private theorem multiplyDifference (n m k : Nat) (bound : m≤n) : (n-m)*k=n*k-m*k := by
 conv => rhs;rw [← subtractAdd n m bound,addMul,Nat.add_comm ((n-m)*k) (m*k),RunningConvergence.addSubtractLeft]

private theorem subtractNormalized (n m d : Nat) (hd : 0<d) (bound : m≤n) :
 subtract (natRatio n d hd) (natRatio m d hd)=natRatio (n-m) d hd := by
 let a := natRatio n d hd
 let b := natRatio m d hd
 have av := natRatioValue n d hd
 have bv := natRatioValue m d hd
 have avc : (a.num.natAbs*b.den)*d=n*(a.den*b.den) := by
  rw [mulRightComm,← av,mulAssoc]
 have bvc : (b.num.natAbs*a.den)*d=m*(a.den*b.den) := by
  rw [mulRightComm,← bv,mulAssoc,Nat.mul_comm b.den a.den]
 have ordered : b.num.natAbs*a.den≤a.num.natAbs*b.den := by
  apply Nat.le_of_mul_le_mul_right _ hd
  rw [avc,bvc]
  exact Nat.mul_le_mul_right _ bound
 have intDiff : Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)=
  Int.ofNat (a.num.natAbs*b.den-b.num.natAbs*a.den) := by
  generalize h : b.num.natAbs*a.den = k at ordered ⊢
  cases k with
  | zero => rw [Nat.sub_zero];rfl
  | succ k =>
   change Int.subNatNat _ _ = _
   unfold Int.subNatNat
   rw [CommonScaleAxis.subtractionZeroOfBound _ _ ordered]
 change subtract a b = _
 unfold subtract
 rw [natRatioNonnegative n d hd,natRatioNonnegative m d hd]
 change normalize (Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)) (a.den*b.den) _ = _
 rw [intDiff]
 apply natRatioCongruence
 rw [multiplyDifference _ _ _ ordered,avc,bvc,multiplyDifference _ _ _ bound]

private theorem nextGapCounts (n g : Nat) :
 4*(7*((4*n+g)*(4*n+g))+16*(n*n))+4*g*(8*n+g)=32*((4*n+g)*(4*n+g)) := by
 rw [nextNumeratorExpanded,gapExpanded,squareCounts]
 have scaled := polynomialScale 4 128 56 7 (n*n) (n*g) (g*g)
 rw [scaled,polynomialAdd]
 have target := polynomialScale 32 16 8 1 (n*n) (n*g) (g*g)
 rw [Nat.one_mul] at target
 exact target.symm
private theorem nextIncreaseCounts (n g : Nat) :
 7*((4*n+g)*(4*n+g))+16*(n*n)=32*n*(4*n+g)+g*(24*n+7*g) := by
 rw [nextNumeratorExpanded,Nat.mul_add,Nat.mul_add]
 have a : 32*n*(4*n)=128*(n*n) := by rw [mulAssoc 32 n (4*n),productLeftComm n 4 n,←mulAssoc 32 4 (n*n)]
 have b : 32*n*g=32*(n*g) := mulAssoc _ _ _
 have c : g*(24*n)=24*(n*g) := by rw [productLeftComm g 24 n,Nat.mul_comm g n]
 have d : g*(7*g)=7*(g*g) := productLeftComm _ _ _
 rw [a,b,c,d]
 have combined : 32*(n*g)+24*(n*g)=56*(n*g) := (addMul 32 24 (n*g)).symm
 conv => rhs; rw [←Nat.add_assoc (128*(n*n)+32*(n*g)) (24*(n*g)) (7*(g*g)),Nat.add_assoc (128*(n*n)) (32*(n*g)) (24*(n*g)),combined]
private theorem integerNotLess (a b : Nat) (bound : b≤a) : ¬Int.ofNat a<Int.ofNat b := by
 intro h
 change Int.NonNeg (Int.subNatNat b (a+1)) at h
 unfold Int.subNatNat at h
 have positive := RunningConvergence.orderedDifferencePositive _ _ (Nat.lt_succ_of_le bound)
 cases hd : (a+1)-b with
 | zero => rw [hd] at positive; cases positive
 | succ n => rw [hd] at h; cases h

private theorem normalizedNotLess (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (cross : m*d<n*e) : (natRatio n d hd).blt (natRatio m e he)=false := by
 have ap := positiveNormalizedNumerator n d hn hd
 have bp := positiveNormalizedNumerator m e hm he
 have less := CommonScaleAxis.normalizedCrossLess m e n d he hd cross
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
   change decide (Int.ofNat ((na+1)*(natRatio m e he).den)<Int.ofNat ((nb+1)*(natRatio n d hd).den))=false
   exact decide_eq_false (integerNotLess _ _ (Nat.le_of_lt less))



theorem originalBelowQuarterSuccessor (n g : Nat) (hn : 0<n) (hg : 0<g) :
 let d := 4*n+g
 let nextN := 7*(d*d)+16*(n*n)
 let nextD := 32*(d*d)
 ∃ next, selfSourceSuccessor (.fraction (natRatio n d (Nat.add_pos_right _ hg)))=.ok next ∧
  zero.blt next=true ∧ next.blt (normalize 1 4 (by decide))=true ∧
  (natRatio n d (Nat.add_pos_right _ hg)).blt next=true := by
 dsimp only
 let d := 4*n+g
 have hd : 0<d := Nat.add_pos_right _ hg
 have below : n<d := Nat.lt_of_le_of_lt (by change n≤(3+1)*n;rw [Nat.succ_mul];exact Nat.le_add_left _ _) (Nat.lt_add_of_pos_right hg)
 have within := normalizedNotLess 1 1 n d (by decide) (by decide) hn hd (by rw [Nat.mul_one,Nat.one_mul];exact below)
 change (normalize 1 1 (by decide)).blt (natRatio n d hd)=false at within
 let nextN := 7*(d*d)+16*(n*n)
 let nextD := 32*(d*d)
 have hnextD : 0<nextD := Nat.mul_pos (by decide) (Nat.mul_pos hd hd)
 have hnextN : 0<nextN := Nat.add_pos_left (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) _
 have gapPositive : 0<4*g*(8*n+g) := Nat.mul_pos (Nat.mul_pos (by decide) hg) (Nat.add_pos_right _ hg)
 have gapIdentity : 4*nextN+4*g*(8*n+g)=nextD := nextGapCounts n g
 have belowQuarter : nextN*4<nextD := by
  rw [Nat.mul_comm nextN 4,←gapIdentity]
  exact Nat.lt_add_of_pos_right gapPositive
 have growthPositive : 0<(g*(24*n+7*g))*d := Nat.mul_pos (Nat.mul_pos hg (Nat.add_pos_right _ (Nat.mul_pos (by decide) hg))) hd
 have cross : n*nextD<nextN*d := by
  have scaled : n*nextD=(32*n*d)*d := by
   change n*(32*(d*d))=(32*n*d)*d
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
   conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  calc
   n*nextD=(32*n*d)*d := scaled
   _<(32*n*d)*d+(g*(24*n+7*g))*d := Nat.lt_add_of_pos_right growthPositive
   _=nextN*d := by rw [←addMul];exact congrArg (fun x => x*d) (nextIncreaseCounts n g).symm
 refine ⟨natRatio nextN nextD hnextD,originalSuccessorFormula n d hn hd within,positiveNormalized _ _ hnextN hnextD,?_,?_⟩
 · exact CommonScaleAxis.positiveNormalizedLess nextN nextD 1 4 hnextN hnextD (by decide) (by decide) (by rw [Nat.one_mul];exact belowQuarter)
 · exact CommonScaleAxis.positiveNormalizedLess n d nextN nextD hn hd hnextN hnextD cross

private def nextN (n g : Nat) : Nat := 7*((4*n+g)*(4*n+g))+16*(n*n)
private def nextG (n g : Nat) : Nat := 4*g*(8*n+g)
private theorem nextNPositive (n g : Nat) (hg : 0<g) : 0<nextN n g :=
 Nat.add_pos_left (Nat.mul_pos (by decide) (Nat.mul_pos (Nat.add_pos_right _ hg) (Nat.add_pos_right _ hg))) _
private theorem nextGPositive (n g : Nat) (hg : 0<g) : 0<nextG n g :=
 Nat.mul_pos (Nat.mul_pos (by decide) hg) (Nat.add_pos_right _ hg)
private def fieldValue (n g : Nat) (hg : 0<g) : Rat := natRatio n (4*n+g) (Nat.add_pos_right _ hg)
private theorem fieldWithin (n g : Nat) (hn : 0<n) (hg : 0<g) :
 (normalize 1 1 (by decide)).blt (fieldValue n g hg)=false := by
 have below : n<4*n+g := Nat.lt_of_le_of_lt (by change n≤(3+1)*n;rw [Nat.succ_mul];exact Nat.le_add_left _ _) (Nat.lt_add_of_pos_right hg)
 exact normalizedNotLess 1 1 n (4*n+g) (by decide) (by decide) hn (Nat.add_pos_right _ hg) (by rw [Nat.mul_one,Nat.one_mul];exact below)
private theorem actualCountSuccessor (n g : Nat) (hn : 0<n) (hg : 0<g) :
 selfSourceSuccessor (.fraction (fieldValue n g hg))=.ok (fieldValue (nextN n g) (nextG n g) (nextGPositive n g hg)) := by
 have actual := originalSuccessorFormula n (4*n+g) hn (Nat.add_pos_right _ hg) (fieldWithin n g hn hg)
 apply actual.trans
 apply congrArg Except.ok
 apply natRatioCongruence
 unfold nextN nextG
 rw [nextGapCounts]
private structure Counts where
 n : Nat
 g : Nat
 hn : 0<n
 hg : 0<g
private def nextCounts (p : Counts) : Counts := ⟨nextN p.n p.g,nextG p.n p.g,nextNPositive p.n p.g p.hg,nextGPositive p.n p.g p.hg⟩
private def sourceCounts : Nat → Counts
 | 0 => ⟨7,4,by decide,by decide⟩
 | k+1 => nextCounts (sourceCounts k)
def generatedField (k : Nat) : Rat := fieldValue (sourceCounts k).n (sourceCounts k).g (sourceCounts k).hg
theorem generatedFieldBase : generatedField 0=normalize 7 32 (by decide) := rfl
theorem generatedFieldSuccessor (k : Nat) : selfSourceSuccessor (.fraction (generatedField k))=.ok (generatedField (k+1)) :=
 actualCountSuccessor (sourceCounts k).n (sourceCounts k).g (sourceCounts k).hn (sourceCounts k).hg
def generatedSequence (start : Nat) : Nat → List Rat
 | 0 => [generatedField start]
 | depth+1 => generatedField start :: generatedSequence (start+1) depth
private theorem originalIterationFrom (start depth : Nat) :
 iterateSteps depth (generatedField start)=.ok (generatedSequence start depth) := by
 induction depth generalizing start with
 | zero => rfl
 | succ depth ih =>
  unfold iterateSteps
  rw [generatedFieldSuccessor]
  dsimp only [Except.bind,Bind.bind]
  rw [ih]
  rfl
theorem originalWholeIteration (depth : Nat) :
 iterate (.integer (.ofNat (depth+1)))=.ok (generatedSequence 0 (depth+1)) := by
 unfold iterate
 rw [originalStructuralValues]
 exact originalIterationFrom 0 (depth+1)
theorem everyGeneratedFieldPositiveBelowQuarter (k : Nat) :
 zero.blt (generatedField k)=true ∧ (generatedField k).blt (normalize 1 4 (by decide))=true := by
 let p := sourceCounts k
 refine ⟨positiveNormalized p.n (4*p.n+p.g) p.hn (Nat.add_pos_right _ p.hg),?_⟩
 exact CommonScaleAxis.positiveNormalizedLess p.n (4*p.n+p.g) 1 4 p.hn (Nat.add_pos_right _ p.hg) (by decide) (by decide) (by rw [Nat.one_mul,Nat.mul_comm p.n 4];exact Nat.lt_add_of_pos_right p.hg)
theorem everyGeneratedSuccessorIncreases (k : Nat) :
 (generatedField k).blt (generatedField (k+1))=true := by
 let p := sourceCounts k
 obtain ⟨next,actual,_,_,increase⟩ := originalBelowQuarterSuccessor p.n p.g p.hn p.hg
 have same := Except.ok.inj (actual.symm.trans (generatedFieldSuccessor k))
 exact same ▸ increase

private theorem sourceGapFormula (n g : Nat) (hg : 0<g) :
 subtract (normalize 1 4 (by decide)) (fieldValue n g hg)=natRatio g (4*(4*n+g)) (Nat.mul_pos (by decide) (Nat.add_pos_right _ hg)) := by
 let d := 4*n+g
 have hd : 0<d := Nat.add_pos_right _ hg
 have quarter : normalize 1 4 (by decide)=natRatio d (4*d) (Nat.mul_pos (by decide) hd) := by
  change natRatio 1 4 (by decide)=_
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_comm d 4]
 have current : fieldValue n g hg=natRatio (4*n) (4*d) (Nat.mul_pos (by decide) hd) := by
  apply natRatioCongruence
  rw [productLeftComm n 4 d,mulAssoc]
 rw [quarter,current,subtractNormalized d (4*n) (4*d) (Nat.mul_pos (by decide) hd) (Nat.le_add_right _ _)]
 change natRatio ((4*n+g)-4*n) _ _=_
 rw [RunningConvergence.addSubtractLeft]
def generatedError (k : Nat) : Rat := subtract (normalize 1 4 (by decide)) (generatedField k)
def generatedErrorFactor (k : Nat) : Rat :=
 multiply (add (normalize 1 4 (by decide)) (generatedField k)) (normalize 1 2 (by decide))
private theorem sourceErrorFactorFormula (n g : Nat) (hg : 0<g) :
 multiply (add (normalize 1 4 (by decide)) (fieldValue n g hg)) (normalize 1 2 (by decide))=
 natRatio (8*n+g) (8*(4*n+g)) (Nat.mul_pos (by decide) (Nat.add_pos_right _ hg)) := by
 let d := 4*n+g
 have hd : 0<d := Nat.add_pos_right _ hg
 have quarter : normalize 1 4 (by decide)=natRatio d (4*d) (Nat.mul_pos (by decide) hd) := by
  change natRatio 1 4 (by decide)=_
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_comm d 4]
 have current : fieldValue n g hg=natRatio (4*n) (4*d) (Nat.mul_pos (by decide) hd) := by
  apply natRatioCongruence
  rw [productLeftComm n 4 d,mulAssoc]
 rw [quarter,current,addNormalized]
 change multiply (natRatio (d+4*n) (4*d) _) (natRatio 1 2 (by decide))=_
 rw [multiplyNormalized]
 have numerator : d+4*n=8*n+g := by
  change (4*n+g)+4*n=8*n+g
  rw [Nat.add_right_comm,←addMul]
 have denominator : (4*d)*2=8*d := by rw [mulRightComm]
 apply natRatioCongruence
 rw [Nat.mul_one,numerator,denominator]
theorem exactGeneratedErrorIdentity (k : Nat) :
 generatedError (k+1)=multiply (generatedError k) (generatedErrorFactor k) := by
 let p := sourceCounts k
 change subtract (normalize 1 4 (by decide)) (fieldValue (nextN p.n p.g) (nextG p.n p.g) (nextGPositive p.n p.g p.hg))=multiply (subtract (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg)) (multiply (add (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg)) (normalize 1 2 (by decide)))
 rw [sourceGapFormula,sourceGapFormula,sourceErrorFactorFormula,multiplyNormalized]
 apply natRatioCongruence
 change (4*p.g*(8*p.n+p.g))*((4*(4*p.n+p.g))*(8*(4*p.n+p.g)))=(p.g*(8*p.n+p.g))*(4*(4*nextN p.n p.g+nextG p.n p.g))
 have den : 4*nextN p.n p.g+nextG p.n p.g=32*((4*p.n+p.g)*(4*p.n+p.g)) := nextGapCounts p.n p.g
 rw [den]
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 rw [←mulAssoc 4 8]
private theorem factorNumeratorBound (n g : Nat) (hg : 0<g) : 8*n+g<2*(4*n+g) := by
 have twice : 2*(4*n+g)=8*n+2*g := by rw [Nat.mul_add,←mulAssoc 2 4 n]
 rw [twice]
 apply Nat.add_lt_add_left
 change g<2*g
 rw [Nat.succ_mul,Nat.one_mul]
 exact Nat.lt_add_of_pos_right hg
theorem everyGeneratedErrorPositive (k : Nat) : zero.blt (generatedError k)=true := by
 let p := sourceCounts k
 change zero.blt (subtract (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg))=true
 rw [sourceGapFormula]
 exact positiveNormalized _ _ p.hg (Nat.mul_pos (by decide) (Nat.add_pos_right _ p.hg))
theorem everyGeneratedErrorFactorPositiveBelowQuarter (k : Nat) :
 zero.blt (generatedErrorFactor k)=true ∧ (generatedErrorFactor k).blt (normalize 1 4 (by decide))=true := by
 let p := sourceCounts k
 change zero.blt (multiply (add (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg)) (normalize 1 2 (by decide)))=true ∧ (multiply (add (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg)) (normalize 1 2 (by decide))).blt (normalize 1 4 (by decide))=true
 rw [sourceErrorFactorFormula]
 have hn : 0<8*p.n+p.g := Nat.add_pos_right _ p.hg
 have hd : 0<8*(4*p.n+p.g) := Nat.mul_pos (by decide) (Nat.add_pos_right _ p.hg)
 refine ⟨positiveNormalized _ _ hn hd,?_⟩
 apply CommonScaleAxis.positiveNormalizedLess _ _ 1 4 hn hd (by decide) (by decide)
 rw [Nat.one_mul]
 have scaled := Nat.mul_lt_mul_of_pos_right (factorNumeratorBound p.n p.g p.hg) (by decide : 0<4)
 rw [mulRightComm 2 (4*p.n+p.g) 4] at scaled
 exact scaled
theorem everyGeneratedErrorStrictlyShrinks (k : Nat) :
 (generatedError (k+1)).blt (generatedError k)=true := by
 rw [exactGeneratedErrorIdentity]
 let p := sourceCounts k
 change (multiply (subtract (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg)) (multiply (add (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg)) (normalize 1 2 (by decide)))).blt (subtract (normalize 1 4 (by decide)) (fieldValue p.n p.g p.hg))=true
 rw [sourceGapFormula,sourceErrorFactorFormula,multiplyNormalized]
 have hd : 0<4*p.n+p.g := Nat.add_pos_right _ p.hg
 have ratioLess : 8*p.n+p.g<8*(4*p.n+p.g) := Nat.lt_of_lt_of_le (factorNumeratorBound p.n p.g p.hg) (Nat.mul_le_mul_right _ (by decide : 2≤8))
 apply CommonScaleAxis.positiveNormalizedLess _ _ _ _ (Nat.mul_pos p.hg (Nat.add_pos_right _ p.hg)) (Nat.mul_pos (Nat.mul_pos (by decide) hd) (Nat.mul_pos (by decide) hd)) p.hg (Nat.mul_pos (by decide) hd)
 have scaled := Nat.mul_lt_mul_of_pos_left (Nat.mul_lt_mul_of_pos_right ratioLess (Nat.mul_pos (by decide : 0<4) hd)) p.hg
 rw [mulAssoc] at ⊢
 rw [Nat.mul_comm (8*(4*p.n+p.g)) (4*(4*p.n+p.g))] at scaled
 exact scaled
private def action (f : Rat) : Rat := multiply (natRatio 1 2 (by decide)) (add (natRatio 7 16 (by decide)) (multiply f f))
private theorem actionFormula (n d : Nat) (hd : 0<d) :
 action (natRatio n d hd)=natRatio (7*(d*d)+16*(n*n)) (32*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) := by
 unfold action
 rw [multiplyNormalized]
 have source : natRatio 7 16 (by decide)=natRatio (7*(d*d)) (16*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) := by
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 have squared : natRatio (n*n) (d*d) (Nat.mul_pos hd hd)=natRatio (16*(n*n)) (16*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) := by
  apply natRatioCongruence
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 rw [source,squared,addNormalized,multiplyNormalized]
 apply natRatioCongruence
 rw [Nat.one_mul,←mulAssoc 2 16 (d*d)]
private theorem correctionSquare (n h d : Nat) :
 7*(d*d)+16*((n+h)*(n+h))=(7*(d*d)+16*(n*n))+16*(h*(2*n+h)) := by
 rw [CommonScaleAxis.squareDifference,Nat.mul_add,Nat.add_assoc]
private theorem actionDifference (n h d : Nat) (hd : 0<d) :
 subtract (action (natRatio (n+h) d hd)) (action (natRatio n d hd))=
 multiply (subtract (natRatio (n+h) d hd) (natRatio n d hd))
 (multiply (add (natRatio (n+h) d hd) (natRatio n d hd)) (natRatio 1 2 (by decide))) := by
 rw [actionFormula,actionFormula,correctionSquare]
 rw [subtractNormalized _ _ _ _ (Nat.le_add_right _ _),RunningConvergence.addSubtractLeft]
 rw [subtractNormalized _ _ _ _ (Nat.le_add_right _ _),RunningConvergence.addSubtractLeft,addNormalized,multiplyNormalized,multiplyNormalized,Nat.mul_one]
 have sum : n+h+n=2*n+h := by rw [Nat.add_right_comm,←Nat.two_mul]
 rw [sum]
 apply natRatioCongruence
 conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 rw [productLeftComm 2 (n*2+h) 16]
private theorem generatedAction (k : Nat) : action (generatedField k)=generatedField (k+1) := by
 have h := generatedFieldSuccessor k
 unfold selfSourceSuccessor at h
 dsimp only at h
 have within := fieldWithin (sourceCounts k).n (sourceCounts k).g (sourceCounts k).hn (sourceCounts k).hg
 change (normalize 1 1 (by decide)).blt (generatedField k)=false at within
 rw [(everyGeneratedFieldPositiveBelowQuarter k).1,within,originalStructuralValues] at h
 exact Except.ok.inj h
def generatedCorrection (k : Nat) : Rat := subtract (generatedField (k+1)) (generatedField k)
def generatedCorrectionFactor (k : Nat) : Rat :=
 multiply (add (generatedField (k+1)) (generatedField k)) (natRatio 1 2 (by decide))
theorem exactGeneratedCorrectionIdentity (k : Nat) :
 generatedCorrection (k+1)=multiply (generatedCorrection k) (generatedCorrectionFactor k) := by
 unfold generatedCorrection generatedCorrectionFactor
 let p := sourceCounts k
 let d := 4*p.n+p.g
 let D := 32*(d*d)
 have hd : 0<d := Nat.add_pos_right _ p.hg
 have hD : 0<D := Nat.mul_pos (by decide) (Nat.mul_pos hd hd)
 have before : generatedField k=natRatio (32*p.n*d) D hD := by
  apply natRatioCongruence
  change p.n*(32*(d*d))=(32*p.n*d)*d
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 have after : action (generatedField k)=natRatio (32*p.n*d+p.g*(24*p.n+7*p.g)) D hD := by
  change action (natRatio p.n d hd)=_
  rw [actionFormula,nextIncreaseCounts]
 have identity := actionDifference (32*p.n*d) (p.g*(24*p.n+7*p.g)) D hD
 rw [←before,←after] at identity
 rw [generatedAction k,generatedAction (k+1)] at identity
 exact identity

private theorem correctionFormula (n g : Nat) (hn : 0<n) (hg : 0<g) :
 subtract (fieldValue (nextN n g) (nextG n g) (nextGPositive n g hg)) (fieldValue n g hg)=
 natRatio (g*(24*n+7*g)) (32*((4*n+g)*(4*n+g))) (Nat.mul_pos (by decide) (Nat.mul_pos (Nat.add_pos_right _ hg) (Nat.add_pos_right _ hg))) := by
 let d := 4*n+g
 have hd : 0<d := Nat.add_pos_right _ hg
 have before : fieldValue n g hg=natRatio (32*n*d) (32*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) := by
  apply natRatioCongruence
  change n*(32*(d*d))=(32*n*d)*d
  conv => lhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
  conv => rhs; simp only [mulAssoc,Nat.mul_comm,productLeftComm]
 have after : fieldValue (nextN n g) (nextG n g) (nextGPositive n g hg)=natRatio (32*n*d+g*(24*n+7*g)) (32*(d*d)) (Nat.mul_pos (by decide) (Nat.mul_pos hd hd)) := by
  have h := actualCountSuccessor n g hn hg
  have f := originalSuccessorFormula n d hn hd (fieldWithin n g hn hg)
  have eq := Except.ok.inj (h.symm.trans f)
  rw [eq,nextIncreaseCounts]
 rw [after,before,subtractNormalized _ _ _ _ (Nat.le_add_right _ _),RunningConvergence.addSubtractLeft]
private theorem pairFactorFormula (n g m h : Nat) (hg : 0<g) (hh : 0<h) :
 multiply (add (fieldValue m h hh) (fieldValue n g hg)) (natRatio 1 2 (by decide))=
 natRatio (m*(4*n+g)+n*(4*m+h)) (2*((4*n+g)*(4*m+h)))
 (Nat.mul_pos (by decide) (Nat.mul_pos (Nat.add_pos_right _ hg) (Nat.add_pos_right _ hh))) := by
 let d := 4*n+g
 let e := 4*m+h
 have hd : 0<d := Nat.add_pos_right _ hg
 have he : 0<e := Nat.add_pos_right _ hh
 have left : fieldValue m h hh=natRatio (m*d) (d*e) (Nat.mul_pos hd he) := by
  apply natRatioCongruence
  rw [mulAssoc]
 have right : fieldValue n g hg=natRatio (n*e) (d*e) (Nat.mul_pos hd he) := by
  apply natRatioCongruence
  change n*(d*e)=(n*e)*d
  rw [mulAssoc,Nat.mul_comm e d]
 rw [left,right,addNormalized,multiplyNormalized,Nat.mul_one]
 apply natRatioCongruence
 rw [Nat.mul_comm (d*e) 2]
private theorem pairFactorBound (n g m h : Nat) (hg : 0<g) (hh : 0<h) :
 4*(m*(4*n+g)+n*(4*m+h))<2*((4*n+g)*(4*m+h)) := by
 have eq : 2*((4*n+g)*(4*m+h))=4*(m*(4*n+g)+n*(4*m+h))+(g*(4*m+h)+h*(4*n+g)) := by
  have left : (4*n+g)*(4*m+h)=4*(n*(4*m+h))+g*(4*m+h) := by rw [addMul,mulAssoc]
  have right : (4*n+g)*(4*m+h)=4*(m*(4*n+g))+h*(4*n+g) := by rw [Nat.mul_comm (4*n+g),addMul,mulAssoc]
  calc
   2*((4*n+g)*(4*m+h))=((4*n+g)*(4*m+h))+((4*n+g)*(4*m+h)) := Nat.two_mul _
   _=(4*(n*(4*m+h))+g*(4*m+h))+(4*(m*(4*n+g))+h*(4*n+g)) := (congrArg (fun x => x+((4*n+g)*(4*m+h))) left).trans (congrArg (fun x => (4*(n*(4*m+h))+g*(4*m+h))+x) right)
   _=_ := by
    conv => lhs; simp only [Nat.mul_add,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]
    conv => rhs; simp only [Nat.mul_add,Nat.add_assoc,Nat.add_comm,CommonScaleAxis.addLeftComm]

 rw [eq]
 exact Nat.lt_add_of_pos_right (Nat.add_pos_left (Nat.mul_pos hg (Nat.add_pos_right _ hh)) _)
theorem everyGeneratedCorrectionPositive (k : Nat) : zero.blt (generatedCorrection k)=true := by
 let p := sourceCounts k
 change zero.blt (subtract (fieldValue (nextN p.n p.g) (nextG p.n p.g) (nextGPositive p.n p.g p.hg)) (fieldValue p.n p.g p.hg))=true
 rw [correctionFormula p.n p.g p.hn p.hg]
 exact positiveNormalized _ _ (Nat.mul_pos p.hg (Nat.add_pos_right _ (Nat.mul_pos (by decide) p.hg))) _
theorem everyGeneratedCorrectionFactorPositiveBelowQuarter (k : Nat) :
 zero.blt (generatedCorrectionFactor k)=true ∧ (generatedCorrectionFactor k).blt (normalize 1 4 (by decide))=true := by
 let p := sourceCounts k
 let q := sourceCounts (k+1)
 change zero.blt (multiply (add (fieldValue q.n q.g q.hg) (fieldValue p.n p.g p.hg)) (natRatio 1 2 (by decide)))=true ∧ (multiply (add (fieldValue q.n q.g q.hg) (fieldValue p.n p.g p.hg)) (natRatio 1 2 (by decide))).blt (normalize 1 4 (by decide))=true
 rw [pairFactorFormula]
 have hn : 0<q.n*(4*p.n+p.g)+p.n*(4*q.n+q.g) := Nat.add_pos_left (Nat.mul_pos q.hn (Nat.add_pos_right _ p.hg)) _
 refine ⟨positiveNormalized _ _ hn _,?_⟩
 apply CommonScaleAxis.positiveNormalizedLess _ _ 1 4 hn _ (by decide) (by decide)
 rw [Nat.one_mul,Nat.mul_comm _ 4]
 exact pairFactorBound _ _ _ _ p.hg q.hg

theorem everyGeneratedCorrectionStrictlyShrinks (k : Nat) :
 (generatedCorrection (k+1)).blt (generatedCorrection k)=true := by
 rw [exactGeneratedCorrectionIdentity]
 let p := sourceCounts k
 let q := sourceCounts (k+1)
 have correction := correctionFormula p.n p.g p.hn p.hg
 change generatedCorrection k=_ at correction
 have factor := pairFactorFormula p.n p.g q.n q.g p.hg q.hg
 change generatedCorrectionFactor k=_ at factor
 rw [correction,factor,multiplyNormalized]
 let a := p.g*(24*p.n+7*p.g)
 let b := 32*((4*p.n+p.g)*(4*p.n+p.g))
 let c := q.n*(4*p.n+p.g)+p.n*(4*q.n+q.g)
 let d := 2*((4*p.n+p.g)*(4*q.n+q.g))
 have ha : 0<a := Nat.mul_pos p.hg (Nat.add_pos_right _ (Nat.mul_pos (by decide) p.hg))
 have hb : 0<b := Nat.mul_pos (by decide) (Nat.mul_pos (Nat.add_pos_right _ p.hg) (Nat.add_pos_right _ p.hg))
 have hc : 0<c := Nat.add_pos_left (Nat.mul_pos q.hn (Nat.add_pos_right _ p.hg)) _
 have hd : 0<d := Nat.mul_pos (by decide) (Nat.mul_pos (Nat.add_pos_right _ p.hg) (Nat.add_pos_right _ q.hg))
 have bound : c<d := Nat.lt_of_le_of_lt (by change c≤(3+1)*c;rw [Nat.succ_mul];exact Nat.le_add_left _ _) (pairFactorBound p.n p.g q.n q.g p.hg q.hg)
 apply CommonScaleAxis.positiveNormalizedLess (a*c) (b*d) a b (Nat.mul_pos ha hc) (Nat.mul_pos hb hd) ha hb
 have scaled := Nat.mul_lt_mul_of_pos_left (Nat.mul_lt_mul_of_pos_right bound hb) ha
 rw [mulAssoc,Nat.mul_comm b d]
 exact scaled

private theorem distinctFixedImpossible (n h d : Nat) (hh : 0<h) (hd : 0<d)
 (factorBound : 2*n+h<2*d)
 (first : action (natRatio n d hd)=natRatio n d hd)
 (second : action (natRatio (n+h) d hd)=natRatio (n+h) d hd) : False := by
 have identity := actionDifference n h d hd
 rw [first,second,subtractNormalized _ _ _ _ (Nat.le_add_right _ _),RunningConvergence.addSubtractLeft,addNormalized,multiplyNormalized,multiplyNormalized,Nat.mul_one] at identity
 have sum : n+h+n=2*n+h := by rw [Nat.add_right_comm,←Nat.two_mul]
 rw [sum] at identity
 have bound : (h*(2*n+h))*d<h*(d*(d*2)) := by
  have scaled := Nat.mul_lt_mul_of_pos_left (Nat.mul_lt_mul_of_pos_right factorBound hd) hh
  rw [mulAssoc]
  rw [mulRightComm 2 d d,mulAssoc] at scaled
  rw [Nat.mul_comm d 2,productLeftComm d 2 d]
  exact scaled
 have less := CommonScaleAxis.normalizedCrossLess (h*(2*n+h)) (d*(d*2)) h d (Nat.mul_pos hd (Nat.mul_pos hd (by decide))) hd bound
 rw [←identity] at less
 exact Nat.lt_irrefl _ less
private theorem fixedAction (n d : Nat) (hn : 0<n) (hd : 0<d) (bound : n≤d)
 (fixed : selfSourceSuccessor (.fraction (natRatio n d hd))=.ok (natRatio n d hd)) : action (natRatio n d hd)=natRatio n d hd := by
 have within : (normalize 1 1 (by decide)).blt (natRatio n d hd)=false := by
  cases Nat.eq_or_lt_of_le bound with
  | inl eq =>
   have one : natRatio n d hd=normalize 1 1 (by decide) := by apply natRatioCongruence;rw [Nat.mul_one,Nat.one_mul,eq]
   rw [one];rfl
  | inr lt => exact normalizedNotLess 1 1 n d (by decide) (by decide) hn hd (by rw [Nat.mul_one,Nat.one_mul];exact lt)
 have f := originalSuccessorFormula n d hn hd within
 rw [actionFormula]
 exact Except.ok.inj (f.symm.trans fixed)
theorem uniqueAdmissibleFixedPoint (n d : Nat) (hn : 0<n) (hd : 0<d) (bound : n≤d)
 (fixed : selfSourceSuccessor (.fraction (natRatio n d hd))=.ok (natRatio n d hd)) : natRatio n d hd=normalize 1 4 (by decide) := by
 have actual := fixedAction n d hn hd bound fixed
 have hD : 0<4*d := Nat.mul_pos (by decide) hd
 have current : natRatio n d hd=natRatio (4*n) (4*d) hD := by apply natRatioCongruence;rw [productLeftComm n 4 d,mulAssoc]
 have quarter : normalize 1 4 (by decide)=natRatio d (4*d) hD := by apply natRatioCongruence;rw [Nat.one_mul,Nat.mul_comm d 4]
 have qfixed : action (natRatio d (4*d) hD)=natRatio d (4*d) hD := by rw [←quarter];rfl
 rw [current] at actual
 have sumBound : 4*n+d<2*(4*d) := by
  have lower : 4*n+d≤4*d+d := Nat.add_le_add_right (Nat.mul_le_mul_left 4 bound) d
  have upper : 4*d+d<2*(4*d) := by
   have eq : 2*(4*d)=(4*d+d)+3*d := by
    rw [←mulAssoc 2 4 d]
    have identity := addMul 5 3 d
    have five := addMul 4 1 d
    rw [Nat.one_mul] at five
    rw [←five]
    exact identity
   rw [eq]
   exact Nat.lt_add_of_pos_right (Nat.mul_pos (by decide) hd)
  exact Nat.lt_of_le_of_lt lower upper
 cases Nat.lt_trichotomy (4*n) d with
 | inl lt =>
  have hh := RunningConvergence.orderedDifferencePositive (4*n) d lt
  have eq : 4*n+(d-4*n)=d := Nat.add_comm _ _ |>.trans (subtractAdd d (4*n) (Nat.le_of_lt lt))
  have fb : 2*(4*n)+(d-4*n)<2*(4*d) := by
   rw [Nat.two_mul,Nat.add_assoc,eq]
   exact sumBound
  have second : action (natRatio (4*n+(d-4*n)) (4*d) hD)=natRatio (4*n+(d-4*n)) (4*d) hD := by rw [eq];exact qfixed
  exact False.elim (distinctFixedImpossible (4*n) (d-4*n) (4*d) hh hD fb actual second)
 | inr rest => cases rest with
  | inl eq =>
   apply natRatioCongruence
   rw [Nat.one_mul,Nat.mul_comm n 4,eq]
  | inr lt =>
   have hh := RunningConvergence.orderedDifferencePositive d (4*n) lt
   have eq : d+(4*n-d)=4*n := Nat.add_comm _ _ |>.trans (subtractAdd (4*n) d (Nat.le_of_lt lt))
   have fb : 2*d+(4*n-d)<2*(4*d) := by
    rw [Nat.two_mul,Nat.add_assoc,eq,Nat.add_comm d (4*n)]
    exact sumBound
   have second : action (natRatio (d+(4*n-d)) (4*d) hD)=natRatio (d+(4*n-d)) (4*d) hD := by rw [eq];exact actual
   exact False.elim (distinctFixedImpossible d (4*n-d) (4*d) hh hD fb qfixed second)

end SFT.Physics.PostNewtonianFixedPointGeneral

