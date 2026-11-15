import SFT.Physics.MediatorRangeChannelRanges
import SFT.Physics.StaticExteriorClockGeneral
namespace SFT.Physics.MediatorRangeChannelLedger
open MediatorRangeChannel MediatorRangeChannelTrace LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction SFT.Foundation.ExactPartCarrier
open SFT.Mathematics.LimitComputations (equalRat equalInt)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Retained common-denominator proof body from StaticExteriorClockGeneral;
-- specialized below to the original forward/rest operations.
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
 unfold LeptonIntervals.subtract
 rw [natRatioNonnegative n d hd,natRatioNonnegative m d hd]
 change normalize (Int.ofNat (a.num.natAbs*b.den)-Int.ofNat (b.num.natAbs*a.den)) (a.den*b.den) _ = _
 rw [intDiff]
 apply natRatioCongruence
 rw [multiplyDifference _ _ _ ordered,avc,bvc,multiplyDifference _ _ _ bound]

theorem originalForwardTake (current mass denominator : Nat) (hd : 0<denominator) (continues : mass<current) :
 subtract (natRatio current denominator hd) (natRatio mass denominator hd)=natRatio (current-mass) denominator hd :=
 subtractNormalized current mass denominator hd (Nat.le_of_lt continues)
private theorem equalSelf (q : Rat) : SFT.Mathematics.LimitComputations.equalRat q q=true := by
 unfold SFT.Mathematics.LimitComputations.equalRat SFT.Mathematics.LimitComputations.equalInt
 have same (n : Nat) : (n==n)=true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 cases q.num with
 | ofNat n => change (n==n && q.den==q.den)=true; rw [same,same]; rfl
 | negSucc n => change (n==n && q.den==q.den)=true; rw [same,same]; rfl
theorem originalEveryRestReassemblesOne (n d : Nat) (hd : 0<d) (bound : n≤d) :
 rowConserves (natRatio n d hd,.positive (subtract one (natRatio n d hd)))=true := by
 have whole : one=natRatio d d hd := by
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 change SFT.Mathematics.LimitComputations.equalRat (add (natRatio n d hd) (subtract one (natRatio n d hd))) one=true
 rw [whole,subtractNormalized d n d hd bound,addNormalized]
 have sum : n+(d-n)=d := (Nat.add_comm _ _).trans (subtractAdd d n bound)
 rw [sum]
 exact equalSelf _
theorem originalCountsStayWithinInitial (mass current : Nat) (xs : List Nat) (trace : SourceTrace mass current xs) :
 ∀ x, x ∈ xs → x≤current := by
 induction trace with
 | stop current boundary =>
  intro x hx
  cases hx with
  | head => exact Nat.le_refl _
  | tail _ hx => cases hx
 | step current next tail later ih =>
  intro x hx
  cases hx with
  | head => exact Nat.le_refl _
  | tail _ hx => exact Nat.le_trans (ih x hx) (Nat.sub_le _ _)
theorem originalPartRepresentation (p : Part) :
 asFraction p = natRatio p.numerator p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero) :=
 representedIdentity _ _ _ _ rfl rfl
theorem originalProperTrace (p : Part) (proper : p.numerator<p.denominator) :
 positiveForwardTrace (.fraction (asFraction p))=.ok ((forwardCounts p.numerator p.denominator).map
  (fun n => natRatio n p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero))) := by
 have positive : zero.blt (asFraction p)=true := by
  rw [originalPartRepresentation]
  exact positiveNormalized _ _ p.positive _
 have less : (asFraction p).blt one=true := by
  rw [originalPartRepresentation]
  apply CommonScaleAxis.positiveNormalizedLess _ _ 1 1 p.positive _ (by decide) (by decide)
  rw [Nat.mul_one,Nat.one_mul]
  exact proper
 unfold positiveForwardTrace
 dsimp only
 rw [positive,less]
 rfl
theorem originalTraceStartsAtOneCount (mass current : Nat) :
 ∃ tail, forwardCounts mass current=current::tail := by
 cases current with
 | zero => exact ⟨[],rfl⟩
 | succ n => exact ⟨_,rfl⟩
private theorem allRestRows (xs : List Nat) (d : Nat) (hd : 0<d)
 (bound : ∀ x, x ∈ xs → x≤d) :
 ((xs.map (fun n => natRatio n d hd)).map (fun q => (q,MassRecord.positive (subtract one q)))).all rowConserves=true := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change (rowConserves (natRatio x d hd,.positive (subtract one (natRatio x d hd))) &&
   ((xs.map (fun n => natRatio n d hd)).map (fun q => (q,MassRecord.positive (subtract one q)))).all rowConserves)=true
  rw [originalEveryRestReassemblesOne x d hd (bound x List.mem_cons_self),
      ih (fun y hy => bound y (List.mem_cons_of_mem x hy))]
  rfl
theorem originalEveryReturnedLedgerCloses (p : Part) (proper : p.numerator<p.denominator) :
 ledgerConservesOne (.fraction (asFraction p))=.ok true := by
 obtain ⟨tail,shape⟩ := originalTraceStartsAtOneCount p.numerator p.denominator
 have hd := Nat.pos_of_ne_zero p.denominatorNonzero
 have bounds := originalCountsStayWithinInitial _ _ _ (generatedBoundRetainsEntireTrace p.numerator p.denominator p.positive)
 have tailBound : ∀ x, x ∈ tail → x≤p.denominator := by
  intro x hx
  apply bounds x
  rw [shape]
  exact List.mem_cons_of_mem _ hx
 have fullOne : natRatio p.denominator p.denominator hd=one := by
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 unfold ledgerConservesOne forwardRestLedger
 rw [originalProperTrace p proper,shape]
 change Except.ok (SFT.Mathematics.LimitComputations.equalRat (natRatio p.denominator p.denominator hd) one &&
  ((tail.map (fun n => natRatio n p.denominator hd)).map (fun q => (q,MassRecord.positive (subtract one q)))).all rowConserves)=Except.ok true
 rw [fullOne,equalSelf,allRestRows tail p.denominator hd tailBound]
 rfl
-- Every source count trace has one retained terminal positive carrier at or below the mass count.
theorem originalTraceTerminal (mass current : Nat) (xs : List Nat) (trace : SourceTrace mass current xs) :
 ∃ initial terminal, xs=initial++[terminal] ∧ terminal≤mass := by
 induction trace with
 | stop current boundary => exact ⟨[],current,rfl,boundary⟩
 | step current next tail later ih =>
  obtain ⟨initial,terminal,same,bound⟩ := ih
  exact ⟨current::initial,terminal,congrArg (List.cons current) same,bound⟩
theorem originalActualTraceTerminal (p : Part) (proper : p.numerator<p.denominator) :
 ∃ initial terminal, positiveForwardTrace (.fraction (asFraction p))=
  .ok ((initial++[terminal]).map (fun n => natRatio n p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero))) ∧
  0<terminal ∧ terminal≤p.numerator := by
 have trace := generatedBoundRetainsEntireTrace p.numerator p.denominator p.positive
 obtain ⟨initial,terminal,shape,bound⟩ := originalTraceTerminal _ _ _ trace
 have member : terminal ∈ forwardCounts p.numerator p.denominator := by
  rw [shape]
  clear shape
  induction initial with
  | nil => exact List.mem_cons_self
  | cons x xs ih => exact List.mem_cons_of_mem x ih
 exact ⟨initial,terminal,(originalProperTrace p proper).trans (congrArg (fun xs => Except.ok (xs.map (fun n => natRatio n p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero)))) shape),
  everyRetainedCarrierPositive _ _ p.positive (Nat.pos_of_ne_zero p.denominatorNonzero) _ trace terminal member,bound⟩
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




private theorem equalIntSound (a b : Int) (h : equalInt a b=true) : a=b := by
 cases a with
 | ofNat a =>
  cases b with
  | ofNat b => exact congrArg Int.ofNat (Nat.eq_of_beq_eq_true h)
  | negSucc b => cases h
 | negSucc a =>
  cases b with
  | ofNat b => cases h
  | negSucc b => exact congrArg Int.negSucc (Nat.eq_of_beq_eq_true h)
private theorem equalRatSound (a b : Rat) (h : equalRat a b=true) : a=b := by
 have parts : equalInt a.num b.num=true ∧ (a.den==b.den)=true := by
  cases x : equalInt a.num b.num <;> cases y : a.den==b.den <;> rw [equalRat,x,y] at h
  all_goals try cases h
  all_goals exact ⟨rfl,rfl⟩
 exact Rat.ext (equalIntSound _ _ parts.1) (Nat.eq_of_beq_eq_true parts.2)
theorem originalEveryBrokenShortfall (p : Part) (proper : p.numerator<p.denominator) :
 brokenChannelMass (.fraction (asFraction p))=
 .ok (natRatio (p.denominator-p.numerator) p.denominator (Nat.pos_of_ne_zero p.denominatorNonzero)) := by
 have hd := Nat.pos_of_ne_zero p.denominatorNonzero
 have positive : zero.blt (asFraction p)=true := by
  rw [originalPartRepresentation]
  exact positiveNormalized _ _ p.positive _
 have above : one.blt (asFraction p)=false := by
  rw [originalPartRepresentation]
  apply normalizedNotLess 1 1 p.numerator p.denominator (by decide) (by decide) p.positive hd
  rw [Nat.mul_one,Nat.one_mul]
  exact proper
 have different : SFT.Mathematics.LimitComputations.equalRat (asFraction p) one=false := by
  cases check : SFT.Mathematics.LimitComputations.equalRat (asFraction p) one with
  | false => rfl
  | true =>
   have same := equalRatSound _ _ check
   have n : p.numerator=1 := congrArg (fun q : Rat => q.num.toNat) same
   have d : p.denominator=1 := congrArg Rat.den same
   rw [n,d] at proper
   exact False.elim (Nat.lt_irrefl _ proper)
 unfold brokenChannelMass preservedMassRecord
 dsimp only
 rw [positive,above,different]
 change Except.ok (subtract one (asFraction p))=Except.ok _
 rw [originalPartRepresentation]
 have whole : one=natRatio p.denominator p.denominator hd := by
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 rw [whole,subtractNormalized _ _ _ hd (Nat.le_of_lt proper)]
theorem originalEveryBrokenMassPositive (p : Part) (proper : p.numerator<p.denominator) :
 (brokenChannelMass (.fraction (asFraction p))).map (fun q => zero.blt q)=.ok true := by
 rw [originalEveryBrokenShortfall p proper]
 exact congrArg Except.ok (positiveNormalized _ _ (SFT.Foundation.ExactCast.subtractPositive _ _ proper) _)
private theorem positiveSelfNotLess (n d : Nat) (hn : 0<n) (hd : 0<d) :
 (natRatio n d hd).blt (natRatio n d hd)=false := by
 have positive := positiveNormalizedNumerator n d hn hd
 unfold Rat.blt
 rw [natRatioNonnegative n d hd]
 generalize h : (natRatio n d hd).num.natAbs=k at positive ⊢
 cases k with
 | zero => cases positive
 | succ k =>
  have notNeg : ¬Int.ofNat (k+1)<0 := by
   intro h
   change Int.NonNeg (Int.subNatNat 0 (k+2)) at h
   unfold Int.subNatNat at h
   rw [Nat.sub_zero] at h
   cases h
  have notZero : Int.ofNat (k+1)≠0 := fun h => Nat.noConfusion (congrArg Int.toNat h)
  have notNonpos : ¬Int.ofNat (k+1)≤0 := by
   intro h
   change Int.NonNeg (Int.subNatNat 0 (k+1)) at h
   unfold Int.subNatNat at h
   rw [Nat.sub_zero] at h
   cases h
  rw [decide_eq_false notNeg,ite_eq_right notZero,decide_eq_false notNonpos,Bool.false_and,Bool.and_false]
  change decide (Int.ofNat ((k+1)*(natRatio n d hd).den)<Int.ofNat ((k+1)*(natRatio n d hd).den))=false
  exact decide_eq_false (integerNotLess _ _ (Nat.le_refl _))
theorem originalStoppedGuard (current mass d : Nat) (hc : 0<current) (hm : 0<mass) (hd : 0<d) (stopped : current≤mass) :
 (natRatio mass d hd).blt (natRatio current d hd)=false := by
 by_cases same : current=mass
 · subst current;exact positiveSelfNotLess mass d hm hd
 · apply normalizedNotLess mass d current d hm hd hc hd
   exact Nat.mul_lt_mul_of_pos_right (Nat.lt_of_le_of_ne stopped same) hd
inductive RationalTrace (mass : Rat) : Rat → List Rat → Prop where
 | stop (current : Rat) (stopped : mass.blt current=false) : RationalTrace mass current [current]
 | step (current : Rat) (continues : mass.blt current=true) (tail : List Rat)
   (later : RationalTrace mass (subtract current mass) tail) : RationalTrace mass current (current::tail)
theorem originalEveryRationalTrace (mass current d : Nat) (hm : 0<mass) (hc : 0<current) (hd : 0<d)
 (xs : List Nat) (source : SourceTrace mass current xs) :
 RationalTrace (natRatio mass d hd) (natRatio current d hd) (xs.map (fun n => natRatio n d hd)) := by
 induction source with
 | stop current bound => exact RationalTrace.stop _ (originalStoppedGuard current mass d hc hm hd bound)
 | step current next tail later ih =>
  apply RationalTrace.step
  · apply CommonScaleAxis.positiveNormalizedLess mass d current d hm hd hc hd
    exact Nat.mul_lt_mul_of_pos_right next hd
  · rw [originalForwardTake current mass d hd next]
    exact ih (SFT.Foundation.ExactCast.subtractPositive current mass next)
theorem originalActualRationalLoop (p : Part) (proper : p.numerator<p.denominator) :
 ∃ xs, positiveForwardTrace (.fraction (asFraction p))=.ok xs ∧ RationalTrace (asFraction p) one xs := by
 have hd := Nat.pos_of_ne_zero p.denominatorNonzero
 refine ⟨_,originalProperTrace p proper,?_⟩
 have fullOne : one=natRatio p.denominator p.denominator hd := by
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 rw [originalPartRepresentation,fullOne]
 exact originalEveryRationalTrace _ _ _ p.positive hd hd _ (generatedBoundRetainsEntireTrace _ _ p.positive)
theorem originalSuccessorRestTransfer (current mass d : Nat) (hd : 0<d) (held : current≤d) (continues : mass<current) :
 subtract one (subtract (natRatio current d hd) (natRatio mass d hd))=
 add (subtract one (natRatio current d hd)) (natRatio mass d hd) := by
 have whole : one=natRatio d d hd := by
  apply natRatioCongruence
  rw [Nat.one_mul,Nat.mul_one]
 have arranged : d=(current-mass)+((d-current)+mass) := by
  calc
   d = (d-current)+current := (subtractAdd d current held).symm
   _ = (d-current)+((current-mass)+mass) := congrArg (fun n => (d-current)+n) (subtractAdd current mass (Nat.le_of_lt continues)).symm
   _ = (current-mass)+((d-current)+mass) := Nat.add_left_comm _ _ _
 have rest : d-(current-mass)=(d-current)+mass := by
  exact (congrArg (fun n => n-(current-mass)) arranged).trans (RunningConvergence.addSubtractLeft _ _)
 rw [whole,subtractNormalized current mass d hd (Nat.le_of_lt continues),
     subtractNormalized d (current-mass) d hd (Nat.le_trans (Nat.sub_le _ _) held),
     subtractNormalized d current d hd held,addNormalized,rest]
end SFT.Physics.MediatorRangeChannelLedger
