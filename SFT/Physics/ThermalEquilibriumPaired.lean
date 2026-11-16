import SFT.Physics.ThermalEquilibriumResponse
import SFT.Mathematics.OrbitTilingCount
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.ThermalEquilibriumPaired
open ThermalEquilibriumResponse
open SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000

-- Internal recurrence for the exact math.comb multiplicities used by the source.
-- The source-facing operation remains the original factorial quotient.
private def multiplicity : Nat → Nat → Nat
 | 0 => fun _ => 1
 | a+1 => fun b => Nat.rec 1 (fun k prior => multiplicity a (k+1)+prior) b

private theorem factorialPositive (n : Nat) : 0<factorial n := by
 induction n with
 | zero => exact Nat.zero_lt_succ _
 | succ n ih => exact Nat.mul_pos (Nat.zero_lt_succ _) ih

private theorem multiplicityPositive (a b : Nat) : 0<multiplicity a b := by
 induction a generalizing b with
 | zero => exact Nat.zero_lt_succ _
 | succ a ih =>
   cases b with
   | zero => exact Nat.zero_lt_succ _
   | succ b => exact Nat.add_pos_left (ih (b+1)) _

private theorem factorialMultiplicity (a b : Nat) :
 multiplicity a b * (factorial a * factorial b) = factorial (a+b) := by
 induction a generalizing b with
 | zero => rw [Nat.zero_add]; exact (Nat.one_mul _).trans (Nat.one_mul _)
 | succ a ia =>
   induction b with
   | zero => rw [Nat.add_zero]; exact (Nat.one_mul _).trans (Nat.mul_one _)
   | succ b ib =>
     change (multiplicity a (b+1)+multiplicity (a+1) b) *
       (((a+1)*factorial a)*((b+1)*factorial b)) = factorial ((a+1)+(b+1))
     rw [SFT.Physics.VacuumLedgerProofs.addMul]
     have left : multiplicity a (b+1) * (((a+1)*factorial a)*((b+1)*factorial b)) =
       (a+1)*factorial (a+(b+1)) := by
       rw [mulAssoc,←mulAssoc (multiplicity a (b+1)) (a+1),Nat.mul_comm (multiplicity a (b+1)) (a+1),mulAssoc,←mulAssoc (factorial a)]
       rw [mulAssoc (factorial a) (b+1) (factorial b)]
       exact congrArg (fun n => (a+1)*n) (ia (b+1))
     have right : multiplicity (a+1) b * (((a+1)*factorial a)*((b+1)*factorial b)) =
       (b+1)*factorial ((a+1)+b) := by
       rw [Nat.mul_comm ((a+1)*factorial a) ((b+1)*factorial b),mulAssoc,
         ←mulAssoc (multiplicity (a+1) b) (b+1),Nat.mul_comm (multiplicity (a+1) b) (b+1),mulAssoc]
       rw [Nat.mul_comm (factorial b) ((a+1)*factorial a)]
       exact congrArg (fun n => (b+1)*n) ib
     rw [left,right,Nat.succ_add,←Nat.add_succ,←SFT.Physics.VacuumLedgerProofs.addMul]
     rw [Nat.succ_add]
     rfl

theorem originalSplitMultiplicity (a b : Nat) : binomial (a+b) a = multiplicity a b := by
 unfold binomial
 have sub : a+b-a=b := (congrArg (fun n => n-a) (Nat.add_comm a b)).trans (SFT.Foundation.ExactCast.addSubtract b a)
 rw [sub,←factorialMultiplicity a b]
 rw [Nat.mul_comm (multiplicity a b)]
 exact divisionMultiple _ _ (Nat.mul_pos (factorialPositive a) (factorialPositive b))

private theorem adjacentIdentity (a b : Nat) :
 (a+1)*multiplicity (a+1) b = (b+1)*multiplicity a (b+1) := by
 apply Nat.eq_of_mul_eq_mul_right (Nat.mul_pos (factorialPositive a) (factorialPositive b))
 calc
  ((a+1)*multiplicity (a+1) b)*(factorial a*factorial b) =
    multiplicity (a+1) b*(factorial (a+1)*factorial b) := by
      rw [Nat.mul_comm (a+1),mulAssoc,←mulAssoc (a+1)]
      rfl
  _ = factorial ((a+1)+b) := factorialMultiplicity (a+1) b
  _ = factorial (a+(b+1)) := congrArg factorial (Nat.succ_add a b)
  _ = multiplicity a (b+1)*(factorial a*factorial (b+1)) := (factorialMultiplicity a (b+1)).symm
  _ = ((b+1)*multiplicity a (b+1))*(factorial a*factorial b) := by
    change multiplicity a (b+1)*(factorial a*((b+1)*factorial b)) = _
    rw [←mulAssoc (factorial a),Nat.mul_comm (factorial a) (b+1),mulAssoc,
      ←mulAssoc (multiplicity a (b+1)) (b+1),Nat.mul_comm (multiplicity a (b+1)) (b+1)]

private theorem adjacentIncrease (a b : Nat) (ordered : a<b) :
 multiplicity a (b+1) < multiplicity (a+1) b := by
 have strict := Nat.mul_lt_mul_of_pos_right (Nat.succ_lt_succ ordered) (multiplicityPositive a (b+1))
 rw [←adjacentIdentity] at strict
 cases Nat.lt_or_ge (multiplicity a (b+1)) (multiplicity (a+1) b) with
 | inl h => exact h
 | inr h => exact False.elim (Nat.not_lt_of_ge (Nat.mul_le_mul_left (a+1) h) strict)

theorem originalAdjacentMultiplicity (a b : Nat) (ordered : a<b) :
 binomial (a+(b+1)) a < binomial ((a+1)+b) (a+1) := by
 rw [originalSplitMultiplicity,originalSplitMultiplicity]
 exact adjacentIncrease a b ordered

private theorem centeredIncrease (a d : Nat) :
 multiplicity a (a+2*(d+1)) < multiplicity (a+(d+1)) (a+(d+1)) := by
 induction d generalizing a with
 | zero => exact adjacentIncrease a (a+1) (Nat.lt_succ_self a)
 | succ d ih =>
   have first := adjacentIncrease a ((a+1)+2*(d+1))
     (Nat.lt_add_right (2*(d+1)) (Nat.lt_succ_self a))
   have second := ih (a+1)
   have left : a+2*(d+1+1)=((a+1)+2*(d+1))+1 := by
     rw [Nat.mul_succ]
     change a+(2*(d+1)+(1+1))=((a+1)+2*(d+1))+1
     repeat rw [Nat.add_assoc]
     rw [Nat.add_left_comm 1 (2*(d+1)) 1]
   have centre : a+(d+1+1)=(a+1)+(d+1) := by
     repeat rw [Nat.add_assoc]
     rw [Nat.add_left_comm 1 d 1]
   rw [left,centre]
   exact Nat.lt_trans first second

private theorem symmetricMultiplicity (a b : Nat) : multiplicity a b=multiplicity b a := by
 apply Nat.eq_of_mul_eq_mul_right (Nat.mul_pos (factorialPositive a) (factorialPositive b))
 rw [factorialMultiplicity,Nat.mul_comm (factorial a) (factorial b),factorialMultiplicity,Nat.add_comm]

private theorem differenceWitness (a b : Nat) (h : a≤b) : ∃ d, b=a+d := by
 induction h with
 | refl => exact ⟨0,rfl⟩
 | step h ih =>
   obtain ⟨d,hd⟩ := ih
   exact ⟨d+1,congrArg Nat.succ hd⟩

theorem originalBelowCentral (n k : Nat) (below : k<n) :
 binomial (2*n) k < binomial (2*n) n := by
 obtain ⟨d,hd⟩ := differenceWitness (k+1) n below
 have centre : n=k+(d+1) := hd.trans (Nat.add_right_comm k 1 d)
 have population : 2*n=k+(k+2*(d+1)) := by
   rw [centre,Nat.mul_add,Nat.two_mul]
   rw [Nat.add_assoc]
 rw [population,originalSplitMultiplicity]
 have central : binomial (k+(k+2*(d+1))) n=multiplicity n n := by
   rw [←population,Nat.two_mul,originalSplitMultiplicity]
 rw [central,centre]
 exact centeredIncrease k d

theorem originalAboveCentral (n k : Nat) (above : n<k) (bound : k≤2*n) :
 binomial (2*n) k < binomial (2*n) n := by
 obtain ⟨rest,population⟩ := differenceWitness k (2*n) bound
 have strict := Nat.add_lt_add_right above n
 rw [←Nat.two_mul,population] at strict
 have below : rest<n := by
   cases Nat.lt_or_ge rest n with
   | inl h => exact h
   | inr h => exact False.elim (Nat.not_lt_of_ge (Nat.add_le_add_left h k) strict)
 calc
  binomial (2*n) k = multiplicity k rest := by rw [population,originalSplitMultiplicity]
  _ = multiplicity rest k := symmetricMultiplicity k rest
  _ = binomial (2*n) rest := by rw [population,Nat.add_comm k rest,originalSplitMultiplicity]
  _ < binomial (2*n) n := originalBelowCentral n rest below

theorem originalUniqueCentralMaximum (n k : Nat) (bound : k≤2*n) (different : k≠n) :
 binomial (2*n) k < binomial (2*n) n := by
 cases Nat.lt_or_gt_of_ne different with
 | inl below => exact originalBelowCentral n k below
 | inr above => exact originalAboveCentral n k above bound

theorem originalCentralBoundsEveryRow (n k : Nat) (bound : k≤2*n) :
 binomial (2*n) k ≤ binomial (2*n) n := by
 cases Nat.decEq k n with
 | isTrue eq => rw [eq]; exact Nat.le_refl _
 | isFalse different => exact Nat.le_of_lt (originalUniqueCentralMaximum n k bound different)

private theorem maxLeft (a b : Nat) : a≤max a b := by
 rw [Nat.max_def]
 split
 · assumption
 · exact Nat.le_refl _
private theorem maxRight (a b : Nat) : b≤max a b := by
 rw [Nat.max_def]
 split
 · exact Nat.le_refl _
 · rename_i h
   cases Nat.le_total a b with
   | inl hab => exact False.elim (h hab)
   | inr hba => exact hba
private theorem maxBound (a b c : Nat) (ha : a≤c) (hb : b≤c) : max a b≤c := by
 rw [Nat.max_def]
 split
 · exact hb
 · exact ha
private theorem censusFoldBound (n : Nat) (indices : List Nat)
 (bound : ∀ k ∈ indices, k≤2*n) (acc : Nat) (ha : acc≤binomial (2*n) n) :
 ((indices.map (fun k => (k,binomial (2*n) k))).foldl (fun m r => max m r.2) acc)≤binomial (2*n) n := by
 induction indices generalizing acc with
 | nil => exact ha
 | cons k ks ih =>
   exact ih (fun j hj => bound j (.tail k hj)) _
    (maxBound _ _ _ ha (originalCentralBoundsEveryRow n k (bound k (.head ks))))
private theorem censusFoldRetains (n : Nat) (indices : List Nat) (acc : Nat) :
 acc≤((indices.map (fun k => (k,binomial (2*n) k))).foldl (fun m r => max m r.2) acc) := by
 induction indices generalizing acc with
 | nil => exact Nat.le_refl _
 | cons k ks ih => exact Nat.le_trans (maxLeft acc (binomial (2*n) k)) (ih _)
private theorem censusFoldIncludes (n : Nat) (indices : List Nat) (acc k : Nat) (hk : k∈indices) :
 binomial (2*n) k≤((indices.map (fun k => (k,binomial (2*n) k))).foldl (fun m r => max m r.2) acc) := by
 induction indices generalizing acc with
 | nil => cases hk
 | cons j js ih =>
   cases hk with
   | head => exact Nat.le_trans (maxRight acc (binomial (2*n) k)) (censusFoldRetains n js _)
   | tail _ hk => exact ih _ hk

theorem originalCensusMaximum (n : Nat) :
 (((List.range (2*n+1)).map (fun k => (k,binomial (2*n) k))).foldl (fun m r => max m r.2) 0) = binomial (2*n) n := by
 apply Nat.le_antisymm
 · apply censusFoldBound n _ _ 0 (Nat.zero_le _)
   intro k hk
   exact Nat.le_of_lt_succ ((SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mp hk)
 · apply censusFoldIncludes n _ 0 n
   apply (SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mpr
   rw [Nat.two_mul]
   exact Nat.lt_succ_of_le (Nat.le_add_right n n)

private theorem equalDecision (n : Nat) : (n==n)=true := by
 induction n with
 | zero => rfl
 | succ n ih => exact ih

private theorem unequalDecision (a b : Nat) (different : a≠b) : (a==b)=false := by
 cases h : a==b with
 | false => rfl
 | true => exact False.elim (different (Nat.eq_of_beq_eq_true h))
private theorem centralDecision (n k : Nat) (bound : k≤2*n) :
 (binomial (2*n) k == binomial (2*n) n) = (k==n) := by
 cases Nat.decEq k n with
 | isTrue h =>
   rw [h]
   exact (equalDecision _).trans (equalDecision _).symm
 | isFalse h => rw [unequalDecision k n h,unequalDecision _ _ (Nat.ne_of_lt (originalUniqueCentralMaximum n k bound h))]

private theorem sourceSelection (n : Nat) (indices : List Nat)
 (bound : ∀ k ∈ indices, k≤2*n) :
 (((indices.map (fun k => (k,binomial (2*n) k))).filter
   (fun row => row.2==binomial (2*n) n)).map Prod.fst) = indices.filter (fun k => k==n) := by
 induction indices with
 | nil => rfl
 | cons k ks ih =>
   have decision := centralDecision n k (bound k (.head ks))
   have tail := ih (fun j hj => bound j (.tail k hj))
   change (((k,binomial (2*n) k)::ks.map (fun k => (k,binomial (2*n) k))).filter
    (fun row => row.2==binomial (2*n) n)).map Prod.fst = _
   cases h : k==n with
   | false =>
     have hc := decision.trans h
     rw [List.filter_cons_of_neg (p:=fun row : Nat×Nat => row.2==binomial (2*n) n)
       (fun ht => Bool.noConfusion (hc.symm.trans ht))]
     rw [List.filter_cons_of_neg (p:=fun k => k==n) (fun ht => Bool.noConfusion (h.symm.trans ht))]
     exact tail
   | true =>
     rw [List.filter_cons_of_pos (p:=fun row : Nat×Nat => row.2==binomial (2*n) n) (decision.trans h)]
     rw [List.filter_cons_of_pos (p:=fun k => k==n) h]
     exact congrArg (List.cons k) tail

private theorem absentSelection (n : Nat) (indices : List Nat) (absent : ¬n∈indices) :
 indices.filter (fun k => k==n)=[] := by
 induction indices with
 | nil => rfl
 | cons k ks ih =>
   have ne : k≠n := by intro h; cases h; exact absent (.head ks)
   rw [List.filter_cons_of_neg (p:=fun k => k==n) (fun ht => Bool.noConfusion ((unequalDecision k n ne).symm.trans ht))]
   exact ih (fun h => absent (.tail k h))
private theorem uniqueSelection (n : Nat) (indices : List Nat)
 (unique : SFT.Mathematics.OrbitTilingCount.Unique indices) (present : n∈indices) :
 indices.filter (fun k => k==n)=[n] := by
 induction indices with
 | nil => cases present
 | cons k ks ih =>
   cases Nat.decEq k n with
   | isTrue eq =>
     cases eq
     rw [List.filter_cons_of_pos (p:=fun k => k==n) (equalDecision n)]
     rw [absentSelection n ks unique.1]
   | isFalse ne =>
     rw [List.filter_cons_of_neg (p:=fun k => k==n) (fun ht => Bool.noConfusion ((unequalDecision k n ne).symm.trans ht))]
     apply ih unique.2
     cases present with
     | head => exact False.elim (ne rfl)
     | tail _ h => exact h

theorem originalCensusSurvivors (n : Nat) :
 ((((List.range (2*n+1)).map (fun k => (k,binomial (2*n) k))).filter
   (fun row => row.2==binomial (2*n) n)).map Prod.fst) = [n] := by
 rw [sourceSelection n _ (fun k hk => Nat.le_of_lt_succ ((SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mp hk))]
 apply uniqueSelection n _ (SFT.Mathematics.OrbitTilingCount.uniqueRange _)
 apply (SFT.Mathematics.OrbitCyclotomic.rangeMember _ _).mpr
 rw [Nat.two_mul]
 exact Nat.lt_succ_of_le (Nat.le_add_right n n)

theorem originalEveryPositivePairedCensus (n : Nat) (positive : 0<n) :
 pairedEquilibriumCensus (.integer (.ofNat n)) = .ok
  ⟨2*n,(List.range (2*n+1)).map (fun k => (k,binomial (2*n) k)),[n],
   VacuumLedgerProofs.natRatio 1 2 (by decide)⟩ := by
 have quotient : LeptonRatios.divide (VacuumLedgerProofs.wholeRatio n) (VacuumLedgerProofs.wholeRatio (2*n)) =
   .ok (VacuumLedgerProofs.natRatio 1 2 (by decide)) := by
   rw [←VacuumLedgerProofs.natRatioWhole n,←VacuumLedgerProofs.natRatioWhole (2*n),
     VacuumScaleProofs.divideNormalized _ _ _ _ (by decide) (Nat.mul_pos (by decide) positive) (by decide)]
   apply congrArg Except.ok
   apply VacuumLedgerProofs.natRatioCongruence
   rw [Nat.mul_one,Nat.one_mul,Nat.mul_comm n 2,Nat.one_mul]
 cases n with
 | zero => cases positive
 | succ n =>
   unfold pairedEquilibriumCensus
   dsimp only [CollectiveRadiation.positiveCount,Except.bind,Bind.bind]
   rw [originalCensusMaximum,originalCensusSurvivors]
   change (do let share ← LeptonRatios.divide (VacuumLedgerProofs.wholeRatio (n+1)) (VacuumLedgerProofs.wholeRatio (2*(n+1)))
              pure (⟨2*(n+1),(List.range (2*(n+1)+1)).map (fun k => (k,binomial (2*(n+1)) k)),[n+1],share⟩ : PairedCensus)) = _
   rw [quotient]
   rfl
end SFT.Physics.ThermalEquilibriumPaired
