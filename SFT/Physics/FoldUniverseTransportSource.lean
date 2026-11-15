import SFT.Physics.FoldUniverseTransportPeriod
namespace SFT.Physics.FoldUniverseTransportSource
open FoldUniverseTransport GeneratorOperations
open SFT.Mathematics.OrbitCycleSupport SFT.Mathematics.OrbitCyclotomic SFT.Mathematics.OrbitTilingCount
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Exact source guard and ordered unit enumeration for each admitted denominator. -/
theorem originalUnitEnumeration (n : Nat) (odd : (n+3)%2=1) :
 unitResidues (.integer (.ofNat (n+3))) =
 .ok (((List.range (n+2)).map (·+1)).filter (fun r => Nat.gcd r (n+3)==1)) := by
 unfold unitResidues
 change (if (decide (n+3<3) || !(Nat.beq ((n+3)%2) 1)) then _ else _) = _
 have above : ¬ n+3<3 := Nat.not_lt_of_ge (Nat.le_add_left 3 n)
 rw [decide_eq_false above,odd]
 rfl
/-- Membership in the ordered source enumeration is exactly positive, below-denominator and reduced. -/
theorem originalUnitMembership (n r : Nat) :
 r ∈ (((List.range (n+2)).map (·+1)).filter (fun x => Nat.gcd x (n+3)==1)) ↔
 0<r ∧ r<n+3 ∧ Nat.gcd r (n+3)=1 := by
 constructor
 · intro h
   have h := (filterMember _ _ _).mp h
   obtain ⟨i,hi,eq⟩ := mapPreimage (fun i => i+1) (List.range (n+2)) r h.1
   have bound := (rangeMember (n+2) i).mp hi
   exact ⟨eq ▸ Nat.zero_lt_succ i,eq ▸ Nat.succ_lt_succ bound,Nat.eq_of_beq_eq_true h.2⟩
 · intro h
   cases r with
   | zero => exact False.elim (Nat.not_lt_zero 0 h.1)
   | succ i =>
    apply (filterMember _ _ _).mpr
    constructor
    · exact mapMember (fun i => i+1) (List.range (n+2)) i
       ((rangeMember (n+2) i).mpr (Nat.lt_of_succ_lt_succ h.2.1))
    · rw [h.2.2]; rfl
open SFT.Mathematics.OrbitBinaryDepth SFT.Mathematics.OrbitOrderIdentity
open SFT.Foundation.FractionReduction
private theorem acceptedMember (xs : List Nat) (r : Nat) (h : r ∈ xs) :
 xs.any (fun x => SFT.Mathematics.LimitComputations.equalInt (.ofNat x) (.ofNat r))=true := by
 induction xs with
 | nil => cases h
 | cons x xs ih =>
  cases h with
  | head =>
   change (Nat.beq r r || _) = true
   rw [SFT.Mathematics.OrbitLoopCompletion.natBeqSelf]
   rfl
  | tail _ h =>
   change (Nat.beq x r || _) = true
   rw [ih h]
   cases Nat.beq x r <;> rfl
/-- The exact guarded source Fold operation stays in the complete unit carrier. -/
theorem originalFoldOnUnit (n r : Nat) (odd : (n+3)%2=1)
 (positive : 0<r) (bound : r<n+3) (reduced : Nat.gcd r (n+3)=1) :
 foldResidue (.integer (.ofNat r)) (.integer (.ofNat (n+3)))=.ok ((2*r)%(n+3)) ∧
 0<(2*r)%(n+3) ∧ (2*r)%(n+3)<n+3 ∧ Nat.gcd ((2*r)%(n+3)) (n+3)=1 := by
 have hq : 0<n+3 := Nat.lt_of_lt_of_le (by decide : 0<3) (Nat.le_add_left 3 n)
 have unit : Nat.gcd ((2*r)%(n+3)) (n+3)=1 :=
  (gcdRemainder (2*r) (n+3) hq).symm.trans
   ((gcdMultiplyReduced 2 (n+3) r hq (binaryCoprimeOdd (n+3) odd)).trans reduced)
 have pos : 0<(2*r)%(n+3) := by
  apply Nat.pos_of_ne_zero
  intro empty
  rw [empty,gcdZero] at unit
  have impossible : 3≤1 := unit ▸ Nat.le_add_left 3 n
  exact Nat.not_succ_le_self 1 (Nat.le_trans (by decide : 2≤3) impossible)
 refine ⟨?_,pos,Nat.mod_lt _ hq,unit⟩
 unfold foldResidue
 rw [originalUnitEnumeration n odd]
 dsimp only [Bind.bind,Except.bind,integerValue]
 have accepted := acceptedMember _ r ((originalUnitMembership n r).mpr ⟨positive,bound,reduced⟩)
 rw [accepted]
 rw [ite_eq_right (by decide : ¬ (!true)=true)]
 have guard : ¬ ((2:Int)*Int.ofNat r % Int.ofNat (n+3)<1) := by
  intro h
  change (Int.ofNat ((2*r)%(n+3)) < (1:Int)) at h
  cases eq : (2*r)%(n+3) with
  | zero => exact Nat.not_lt_zero 0 (eq ▸ pos)
  | succ k =>
   rw [eq] at h
   change Int.NonNeg (Int.negSucc k) at h
   cases h
 rw [ite_eq_right guard]
 rfl

/-- All original positive-depth denominator traces exist and retain exactly the held denominator. -/
theorem originalDenominatorTotal (n depth r : Nat) (odd : (n+3)%2=1)
 (positive : 0<r) (bound : r<n+3) (reduced : Nat.gcd r (n+3)=1) :
 denominatorSteps (.integer (.ofNat (n+3))) depth (.integer (.ofNat r))=
 .ok (List.replicate depth (Int.ofNat (n+3))) := by
 induction depth generalizing r with
 | zero => rfl
 | succ depth ih =>
  have next := originalFoldOnUnit n r odd positive bound reduced
  unfold denominatorSteps
  rw [next.1]
  dsimp only [Bind.bind,Except.bind]
  rw [ih _ next.2.1 next.2.2.1 next.2.2.2]
  rfl
/-- Both original component loops execute at every finite depth, with exactly the independent target trace. -/
theorem originalPairedTotal (m n depth a b : Nat) (om : (m+3)%2=1) (on : (n+3)%2=1)
 (pa : 0<a) (ba : a<m+3) (ua : Nat.gcd a (m+3)=1)
 (pb : 0<b) (bb : b<n+3) (ub : Nat.gcd b (n+3)=1) :
 ∃ out, pairedTrajectory (.integer (.ofNat (m+3))) (.integer (.ofNat (n+3))) depth
  (.integer (.ofNat a)) (.integer (.ofNat b))=.ok out ∧
 trajectory (.integer (.ofNat (n+3))) depth (.integer (.ofNat b))=.ok out := by
 induction depth generalizing a b with
 | zero => exact ⟨[],rfl,rfl⟩
 | succ depth ih =>
  have left := originalFoldOnUnit m a om pa ba ua
  have right := originalFoldOnUnit n b on pb bb ub
  obtain ⟨out,pair,target⟩ := ih _ _ left.2.1 left.2.2.1 left.2.2.2 right.2.1 right.2.2.1 right.2.2.2
  refine ⟨(2*b)%(n+3)::out,?_,?_⟩
  · unfold pairedTrajectory
    rw [left.1]
    dsimp only [Bind.bind,Except.bind]
    rw [right.1]
    dsimp only [Bind.bind,Except.bind]
    rw [pair]
    rfl
  · unfold trajectory
    rw [right.1]
    dsimp only [Bind.bind,Except.bind]
    rw [target]
    rfl

private theorem appendAssociative {α : Type} (xs ys zs : List α) : (xs++ys)++zs=xs++(ys++zs) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons x) ih
private theorem reverseAuxAppend {α : Type} (xs ys zs : List α) :
 xs.reverseAux (ys++zs) = xs.reverseAux ys ++ zs := by
 induction xs generalizing ys with
 | nil => rfl
 | cons a xs ih => exact ih (a::ys)
private theorem reverseCons {α : Type} (x : α) (xs : List α) :
 (x::xs).reverse = xs.reverse ++ [x] := reverseAuxAppend xs [] [x]
private theorem appendNil {α : Type} (xs : List α) : xs++[] = xs := by
 induction xs with
 | nil => rfl
 | cons a xs ih => exact congrArg (List.cons a) ih
private def recMap {α β : Type} (f : α → Except String β) : List α → Except String (List β)
 | [] => .ok []
 | a::xs => do
   let b ← f a
   let bs ← recMap f xs
   pure (b::bs)
private theorem loopRec {α β : Type} (f : α → Except String β) (xs : List α) (acc : List β) :
 List.mapM.loop f xs acc = (recMap f xs).map (fun rows => acc.reverse ++ rows) := by
 induction xs generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons a xs ih =>
   rw [List.mapM.loop.eq_2]
   unfold recMap
   cases hf : f a with
   | error e => rfl
   | ok b =>
     change List.mapM.loop f xs (b::acc) = _
     rw [ih]
     cases hr : recMap f xs with
     | error e => rfl
     | ok bs =>
       change Except.ok ((b::acc).reverse ++ bs) = Except.ok (acc.reverse ++ b::bs)
       rw [reverseCons]
       exact congrArg Except.ok (appendAssociative acc.reverse [b] bs)
private theorem mapRec {α β : Type} (f : α → Except String β) (xs : List α) : xs.mapM f = recMap f xs := by
 change List.mapM.loop f xs [] = _
 rw [loopRec]
 cases recMap f xs <;> rfl

private theorem foldMap (n : Nat) (odd : (n+3)%2=1) (xs : List Nat)
 (units : ∀ r,r ∈ xs → 0<r ∧ r<n+3 ∧ Nat.gcd r (n+3)=1) :
 xs.mapM (fun x => foldResidue (.integer (.ofNat x)) (.integer (.ofNat (n+3))))=
 .ok (xs.map (fun x => (2*x)%(n+3))) := by
 rw [mapRec]
 induction xs with
 | nil => rfl
 | cons r xs ih =>
  have unit := units r (List.Mem.head _)
  unfold recMap
  rw [(originalFoldOnUnit n r odd unit.1 unit.2.1 unit.2.2).1]
  dsimp only [Bind.bind,Except.bind]
  rw [ih (fun x hx => units x (List.Mem.tail _ hx))]
  rfl
open SFT.Mathematics.OrbitOrderExistence SFT.Mathematics.OrbitLoopCompletion
/-- The executable loop returns the complete after-step orbit and its exact first period. -/
theorem originalOrbitTrace (n r : Nat) (odd : (n+3)%2=1)
 (positive : 0<r) (bound : r<n+3) (reduced : Nat.gcd r (n+3)=1) :
 ∃ period, FirstBinaryOrder (n+3) period ∧
 orbitTrace (.integer (.ofNat r)) (.integer (.ofNat (n+3)))=
 .ok ((cycleSupport r (n+3) period).map (fun x => (2*x)%(n+3))) ∧
 ((cycleSupport r (n+3) period).map (fun x => (2*x)%(n+3))).length=period := by
 have hq : 0<n+3 := Nat.lt_of_lt_of_le (by decide : 0<3) (Nat.le_add_left 3 n)
 obtain ⟨period,_,first,small⟩ := firstOrderExists (n+3) hq odd
 have replay := orbitReplayCompletes r (n+3) period (n+3) 0 positive (Nat.le_of_lt bound) odd reduced first
  (Nat.zero_le _) (by rw [Nat.zero_add]; exact small)
 change SFT.Mathematics.OrbitNumberWitnesses.orbitWitness r (n+3)=some (cycleSupport r (n+3) period) at replay
 refine ⟨period,first,?_,(mappedLength _ _).trans (completeCycleCardinality r (n+3) period)⟩
 unfold orbitTrace
 rw [(originalFoldOnUnit n r odd positive bound reduced).1]
 dsimp only [Bind.bind,Except.bind,integerValue,Int.toNat]
 rw [replay]
 apply foldMap n odd
 intro x member
 have unit := cycleMembersReduced (n+3) r x period hq odd positive (Nat.le_of_lt bound) reduced member
 have strict : x<n+3 := Nat.lt_of_le_of_ne unit.2.1 (by
  intro eq
  rw [eq,gcdSelf] at unit
  have bad : 3≤1 := unit.2.2 ▸ Nat.le_add_left 3 n
  exact Nat.not_succ_le_self 1 (Nat.le_trans (by decide : 2≤3) bad))
 exact ⟨unit.1,strict,unit.2.2⟩

private theorem firstOrderUnique (q p r : Nat) (hp : FirstBinaryOrder q p)
 (hr : FirstBinaryOrder q r) : p=r := by
 apply Nat.le_antisymm
 · by_cases h : p≤r
   · exact h
   · exact False.elim (hp.2.2 r hr.1 (Nat.lt_of_not_ge h) hr.2.1)
 · by_cases h : r≤p
   · exact h
   · exact False.elim (hr.2.2 p hp.1 (Nat.lt_of_not_ge h) hp.2.1)
/-- The original composite-period operation returns the proved least common multiple and a true match. -/
theorem originalPeriodOperation (m n : Nat) (om : (m+3)%2=1) (on : (n+3)%2=1)
 (coprime : Nat.gcd (m+3) (n+3)=1) :
 ∃ p q, FirstBinaryOrder (m+3) p ∧ FirstBinaryOrder (n+3) q ∧
 compositePeriod (.integer (.ofNat (m+3))) (.integer (.ofNat (n+3)))=
 .ok ⟨p,q,Nat.lcm p q,Int.ofNat (Nat.lcm p q),true⟩ := by
 have pm : 0<m+3 := Nat.lt_of_lt_of_le (by decide : 0<3) (Nat.le_add_left 3 m)
 have pn : 0<n+3 := Nat.lt_of_lt_of_le (by decide : 0<3) (Nat.le_add_left 3 n)
 have hm : 1<m+3 := Nat.lt_of_lt_of_le (by decide : 1<3) (Nat.le_add_left 3 m)
 have hn : 1<n+3 := Nat.lt_of_lt_of_le (by decide : 1<3) (Nat.le_add_left 3 n)
 obtain ⟨p,fp,lp,sp⟩ := originalOrbitTrace m 1 om (by decide) hm (gcdOneLeft _)
 obtain ⟨q,fq,lq,sq⟩ := originalOrbitTrace n 1 on (by decide) hn (gcdOneLeft _)
 let d := (m+3)*(n+3)
 have pd : 0<d := Nat.mul_pos pm pn
 have above : 3≤d := Nat.le_trans (Nat.le_add_left 3 m) (Nat.le_mul_of_pos_right (m+3) pn)
 have shape : d-3+3=d := subtractAdd d 3 above
 have od : d%2=1 := by
  have h := moduloMulReduce (m+3) (n+3) 2 (by decide)
  rw [om,Nat.one_mul,on] at h
  exact h.symm
 have hd : 1<d-3+3 := Nat.lt_of_lt_of_le (by decide : 1<3) (Nat.le_add_left 3 (d-3))
 have odd : (d-3+3)%2=1 := shape.symm ▸ od
 obtain ⟨c,fc,lc,sc⟩ := originalOrbitTrace (d-3) 1 odd (by decide) hd (gcdOneLeft _)
 rw [shape] at fc lc sc
 have first := FoldUniverseTransportPeriod.originalLeastCompositePeriod (m+3) (n+3) p q hm hn om on coprime fp fq
 have same : c=Nat.lcm p q := firstOrderUnique d c _ fc first
 refine ⟨p,q,fp,fq,?_⟩
 change orbitTrace (.integer 1) (.integer (.ofNat (m+3)))=.ok _ at lp
 change orbitTrace (.integer 1) (.integer (.ofNat (n+3)))=.ok _ at lq
 change orbitTrace (.integer 1) (.integer (.ofNat d))=.ok _ at lc
 unfold compositePeriod
 rw [lp]
 dsimp only [Bind.bind,Except.bind]
 rw [lq]
 dsimp only [Bind.bind,Except.bind,integerValue]
 change (do
  let combined ← orbitTrace (.integer 1) (.integer (.ofNat d))
  let expected ← leastCommonMultiple (.integer (.ofNat _)) (.integer (.ofNat _))
  pure (⟨_,_,combined.length,expected,SFT.Mathematics.LimitComputations.equalInt (.ofNat combined.length) expected⟩ : CompositePeriod))=_
 rw [lc]
 dsimp only [Bind.bind,Except.bind]
 rw [sp,sq,sc,same]
 unfold leastCommonMultiple
 dsimp only [integerValue,Int.natAbs]
 have nonzero : ¬ Nat.gcd p q=0 := Nat.ne_of_gt (gcdPositive p q fq.1)
 have no : (Nat.gcd p q==0)=false := by
  cases h : Nat.gcd p q==0 with
  | false => rfl
  | true => exact False.elim (nonzero (Nat.eq_of_beq_eq_true h))
 rw [no]
 change (Except.ok (⟨p,q,Nat.lcm p q,.ofNat (Nat.lcm p q),Nat.beq (Nat.lcm p q) (Nat.lcm p q)⟩ : CompositePeriod) : Except String CompositePeriod)=_
 rw [SFT.Mathematics.OrbitLoopCompletion.natBeqSelf]

/-- The executable component map is exactly the two proved residue projections on every admitted composite unit. -/
theorem originalComponentOperation (m n r : Nat) (om : (m+3)%2=1) (on : (n+3)%2=1)
 (coprime : Nat.gcd (m+3) (n+3)=1) (positive : 0<r)
 (bound : r<(m+3)*(n+3)) (reduced : Nat.gcd r ((m+3)*(n+3))=1) :
 crtComponentMap (.integer (.ofNat r)) (.integer (.ofNat (m+3))) (.integer (.ofNat (n+3)))=
 .ok (Int.ofNat (r%(m+3)),Int.ofNat (r%(n+3))) := by
 let d := (m+3)*(n+3)
 have pn : 0<n+3 := Nat.lt_of_lt_of_le (by decide : 0<3) (Nat.le_add_left 3 n)
 have above : 3≤d := Nat.le_trans (Nat.le_add_left 3 m) (Nat.le_mul_of_pos_right (m+3) pn)
 have shape : d-3+3=d := subtractAdd d 3 above
 have odd : (d-3+3)%2=1 := by
  have h := moduloMulReduce (m+3) (n+3) 2 (by decide)
  rw [om,Nat.one_mul,on] at h
  exact shape.symm ▸ h.symm
 have enumeration := originalUnitEnumeration (d-3) odd
 have member := (originalUnitMembership (d-3) r).mpr
  ⟨positive,shape.symm ▸ bound,shape.symm ▸ reduced⟩
 have accepted := acceptedMember _ r member
 rw [shape] at enumeration accepted
 unfold crtComponentMap
 dsimp only [integerValue,Int.natAbs]
 change (if (Nat.gcd (m+3) (n+3)!=1) then _ else _) = _
 rw [coprime]
 change (do
  let units ← unitResidues (.integer (.ofNat d))
  if !(units.any (fun x => SFT.Mathematics.LimitComputations.equalInt (.ofNat x) (.ofNat r))) then
   Except.error "CRT component map requires coprime odd factors and a composite unit residue"
  else pure (pythonRemainder (.ofNat r) (.ofNat (m+3)),pythonRemainder (.ofNat r) (.ofNat (n+3))))=_
 rw [enumeration]
 dsimp only [Bind.bind,Except.bind]
 rw [accepted,ite_eq_right (by decide : ¬ (!true)=true)]
 rfl

end SFT.Physics.FoldUniverseTransportSource
