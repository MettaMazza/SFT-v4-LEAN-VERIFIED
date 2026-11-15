import SFT.Physics.LatticeOperator
namespace SFT.Physics.LatticeOperatorCycleCounts
open SFT.Foundation.ExactValueIdentity
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Count numerators of the original quarter-share update at a common exact denominator.
def sumSites (f : Nat → Nat) : Nat → Nat
 | 0 => 0
 | n+1 => sumSites f n+f n
private theorem sumCongr (n : Nat) (f g : Nat → Nat) (same : ∀ i,i<n → f i=g i) :
 sumSites f n=sumSites g n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change sumSites f n+f n=sumSites g n+g n
  rw [ih (fun i hi => same i (Nat.lt_succ_of_lt hi)),same n (Nat.lt_succ_self n)]
private theorem sumShift (f : Nat → Nat) (n : Nat) :
 sumSites (fun i => f (i+1)) n+f 0=sumSites f (n+1) := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change (sumSites (fun i => f (i+1)) n+f (n+1))+f 0=(sumSites f n+f n)+f (n+1)
  rw [Nat.add_right_comm,ih]
  rfl
private theorem forwardSum (f : Nat → Nat) (k : Nat) :
 sumSites (fun i => f ((i+1)%(k+1))) (k+1)=sumSites f (k+1) := by
 change sumSites (fun i => f ((i+1)%(k+1))) k+f ((k+1)%(k+1))=_
 rw [moduloRemoves (k+1) (k+1) (Nat.zero_lt_succ k) (Nat.le_refl _),CommonScaleAxis.subtractionZeroOfBound (k+1) (k+1) (Nat.le_refl _)]
 rw [sumCongr k _ (fun i => f (i+1)) (fun i hi => congrArg f
  (moduloBelow (i+1) (k+1) (Nat.zero_lt_succ k) (Nat.succ_lt_succ hi)))]
 exact sumShift f k
private theorem backwardSum (f : Nat → Nat) (k : Nat) :
 sumSites (fun i => f ((i+(k+1)-1)%(k+1))) (k+1)=sumSites f (k+1) := by
 rw [← sumShift (fun i => f ((i+(k+1)-1)%(k+1))) k]
 have shift (i : Nat) (hi : i<k) : ((i+1)+(k+1)-1)%(k+1)=i := by
  have take : (i+1)+(k+1)-1=i+(k+1) := by
   rw [Nat.add_right_comm,Nat.succ_sub_succ_eq_sub,Nat.sub_zero]
  rw [take,moduloRemoves (i+(k+1)) (k+1) (Nat.zero_lt_succ k) (Nat.le_add_left _ _),Nat.add_comm i (k+1),RunningConvergence.addSubtractLeft,moduloBelow i (k+1) (Nat.zero_lt_succ k) (Nat.lt_succ_of_lt hi)]
 rw [sumCongr k _ f (fun i hi => congrArg f (shift i hi))]
 have last : (0+(k+1)-1)%(k+1)=k := by
  rw [Nat.zero_add,Nat.succ_sub_succ_eq_sub,Nat.sub_zero,moduloBelow k (k+1) (Nat.zero_lt_succ k) (Nat.lt_succ_self k)]
 rw [last]
 rfl
private theorem sumAdd (f g : Nat → Nat) (n : Nat) :
 sumSites (fun i => f i+g i) n=sumSites f n+sumSites g n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change sumSites (fun i => f i+g i) n+(f n+g n)=_
  rw [ih]
  exact (Nat.add_assoc _ _ _).trans ((congrArg (Nat.add (sumSites f n))
   (Nat.add_left_comm (sumSites g n) (f n) (g n))).trans (Nat.add_assoc _ _ _).symm)
private theorem sumDouble (f : Nat → Nat) (n : Nat) :
 sumSites (fun i => 2*f i) n=2*sumSites f n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change sumSites (fun i => 2*f i) n+2*f n=2*(sumSites f n+f n)
  rw [ih,Nat.mul_add]

theorem originalCyclicNumeratorConservation (f : Nat → Nat) (n : Nat) (hn : 0<n) :
 sumSites (fun i => 2*f i+f ((i+n-1)%n)+f ((i+1)%n)) n=4*sumSites f n := by
 cases n with
 | zero => cases hn
 | succ k =>
  rw [sumAdd,sumAdd,sumDouble,backwardSum,forwardSum]
  rw [← Nat.succ_mul,← Nat.succ_mul]
def countAt : List Nat → Nat → Nat
 | [],_ => 0
 | a::_,0 => a
 | _::xs,i+1 => countAt xs i

def updateNumerators (xs : List Nat) : List Nat :=
 (List.range xs.length).map (fun i => 2*countAt xs i+
  countAt xs ((i+xs.length-1)%xs.length)+countAt xs ((i+1)%xs.length))

private theorem foldAccumulator (xs : List Nat) (acc : Nat) :
 xs.foldl Nat.add acc=acc+xs.foldl Nat.add 0 := by
 induction xs generalizing acc with
 | nil => rfl
 | cons a xs ih =>
  change xs.foldl Nat.add (acc+a)=acc+xs.foldl Nat.add (0+a)
  rw [ih (acc+a),ih (0+a),Nat.zero_add,Nat.add_assoc]

theorem originalIndexSum (xs : List Nat) :
 sumSites (countAt xs) xs.length=xs.foldl Nat.add 0 := by
 induction xs with
 | nil => rfl
 | cons a xs ih =>
  change sumSites (countAt (a::xs)) (xs.length+1)=xs.foldl Nat.add (0+a)
  rw [← sumShift]
  change sumSites (countAt xs) xs.length+a=xs.foldl Nat.add (0+a)
  rw [ih,foldAccumulator xs (0+a),Nat.zero_add,Nat.add_comm]

private theorem rangeFold (f : Nat → Nat) (n : Nat) (acc : List Nat) (k : Nat) :
 ((List.range.loop n acc).map f).foldl Nat.add k=
 (acc.map f).foldl Nat.add (k+sumSites f n) := by
 induction n generalizing acc k with
 | zero => rfl
 | succ n ih =>
  change ((List.range.loop n (n::acc)).map f).foldl Nat.add k=_
  rw [ih]
  change (acc.map f).foldl Nat.add ((k+sumSites f n)+f n)=_
  rw [Nat.add_assoc]
  rfl

theorem originalCountUpdateTotal (xs : List Nat) (hn : 0<xs.length) :
 (updateNumerators xs).foldl Nat.add 0=4*xs.foldl Nat.add 0 := by
 unfold updateNumerators
 rw [show List.range xs.length=List.range.loop xs.length [] from rfl,rangeFold]
 dsimp only [List.map,List.foldl]
 rw [Nat.zero_add]
 change sumSites (fun i => 2*countAt xs i+countAt xs ((i+xs.length-1)%xs.length)+
  countAt xs ((i+1)%xs.length)) xs.length=4*xs.foldl Nat.add 0
 rw [originalCyclicNumeratorConservation _ _ hn,originalIndexSum]
end SFT.Physics.LatticeOperatorCycleCounts
