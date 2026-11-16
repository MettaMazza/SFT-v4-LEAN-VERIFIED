import SFT.Physics.QuantumSupportOrthogonalityNative
import SFT.Physics.QuantumSupportWalsh
namespace SFT.Physics.QuantumSupportParseval
open QuantumSupportPreparation QuantumSupportParity QuantumSupportOrthogonalityInduction
open SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
private theorem magnitudeShift (h r : Nat) : magnitude (imbalance (h+1) (r+1))=magnitude (imbalance h r) := by
 unfold imbalance
 change magnitude (if h==r then none else some (if r+1<h+1 then (h+1)-(r+1) else (r+1)-(h+1)))=_
 by_cases less : r<h
 · rw [ite_eq_left (Nat.succ_lt_succ less),ite_eq_left less,Nat.succ_sub_succ_eq_sub]
 · have no : ¬ r+1<h+1 := fun h => less (Nat.lt_of_succ_lt_succ h)
   rw [ite_eq_right no,ite_eq_right less,Nat.succ_sub_succ_eq_sub]
private theorem magnitudeRightEmpty (h : Nat) : magnitude (imbalance h 0)=h := by cases h <;> rfl
private theorem magnitudeLeftEmpty (r : Nat) : magnitude (imbalance 0 r)=r := by cases r <;> rfl
private theorem squareSuccessor (n : Nat) : (n+1)^2=n^2+2*n+1 := by
 rw [Nat.pow_succ,Nat.pow_succ,Nat.pow_zero,Nat.one_mul]
 rw [Nat.pow_succ,Nat.pow_succ,Nat.pow_zero,Nat.one_mul]
 rw [Nat.mul_succ,Nat.mul_comm (n+1) n,Nat.mul_succ,Nat.mul_comm 2 n,Nat.mul_succ,Nat.mul_one]
 rw [Nat.add_assoc,Nat.add_assoc,Nat.add_assoc]
private theorem magnitudeIncrement (h r : Nat) :
 (magnitude (imbalance (h+1) r))^2+2*r=(magnitude (imbalance h r))^2+2*h+1 := by
 induction h generalizing r with
 | zero =>
   cases r with
   | zero => rfl
   | succ r =>
     rw [magnitudeShift,magnitudeLeftEmpty,magnitudeLeftEmpty,squareSuccessor,Nat.mul_succ,Nat.mul_zero,Nat.add_zero]
     rw [Nat.add_assoc,Nat.add_assoc]
     rfl
 | succ h ih =>
   cases r with
   | zero =>
     rw [magnitudeRightEmpty,magnitudeRightEmpty,Nat.mul_zero,Nat.add_zero]
     exact squareSuccessor (h+1)
   | succ r =>
     rw [magnitudeShift,magnitudeShift,Nat.mul_succ,Nat.mul_succ]
     have prior := congrArg (fun n=>n+2) (ih r)
     rw [Nat.add_assoc] at prior
     calc
      _ = ((magnitude (imbalance h r))^2+2*h+1)+2 := prior
      _ = _ := by rw [Nat.add_assoc,Nat.add_assoc];rfl
private theorem magnitudeSymmetric (h r : Nat) : magnitude (imbalance h r)=magnitude (imbalance r h) := by
 induction h generalizing r with
 | zero => rw [magnitudeLeftEmpty,magnitudeRightEmpty]
 | succ h ih =>
   cases r with
   | zero => rw [magnitudeLeftEmpty,magnitudeRightEmpty]
   | succ r => rw [magnitudeShift,magnitudeShift,ih]

def heldAt (selected : List Word) (mode : Word) : Nat :=
 (selected.filter (fun point => !phaseBit point mode)).length
def returnedAt (selected : List Word) (mode : Word) : Nat :=
 (selected.filter (fun point => phaseBit point mode)).length
def energyAt (selected : List Word) (mode : Word) : Nat :=
 (magnitude (imbalance (heldAt selected mode) (returnedAt selected mode)))^2
private def sameAt (point : Word) (selected : List Word) (mode : Word) : Nat :=
 (selected.filter (fun other => phaseBit point mode==phaseBit other mode)).length
private def opposedAt (point : Word) (selected : List Word) (mode : Word) : Nat :=
 (selected.filter (fun other => !(phaseBit point mode==phaseBit other mode))).length
private theorem countsAtHeld (point mode : Word) (selected : List Word) (h : phaseBit point mode=false) :
 sameAt point selected mode=heldAt selected mode ∧ opposedAt point selected mode=returnedAt selected mode := by
 induction selected with
 | nil => exact ⟨rfl,rfl⟩
 | cons x xs ih =>
   unfold sameAt opposedAt heldAt returnedAt at ih ⊢
   rw [h] at ih ⊢
   cases hx : phaseBit x mode <;> simp only [List.filter,hx]
   all_goals dsimp only [Bool.beq,BEq.beq,Bool.not,ite_true,ite_false,List.length_cons]
   · exact ⟨congrArg Nat.succ ih.1,ih.2⟩
   · exact ⟨ih.1,congrArg Nat.succ ih.2⟩
private theorem countsAtReturned (point mode : Word) (selected : List Word) (h : phaseBit point mode=true) :
 sameAt point selected mode=returnedAt selected mode ∧ opposedAt point selected mode=heldAt selected mode := by
 induction selected with
 | nil => exact ⟨rfl,rfl⟩
 | cons x xs ih =>
   unfold sameAt opposedAt heldAt returnedAt at ih ⊢
   rw [h] at ih ⊢
   cases hx : phaseBit x mode <;> simp only [List.filter,hx]
   all_goals dsimp only [Bool.beq,BEq.beq,Bool.not,ite_true,ite_false,List.length_cons]
   · exact ⟨ih.1,congrArg Nat.succ ih.2⟩
   · exact ⟨congrArg Nat.succ ih.1,ih.2⟩

theorem originalModeEnergySuccessor (point mode : Word) (selected : List Word) :
 energyAt (point::selected) mode+2*opposedAt point selected mode=
 energyAt selected mode+2*sameAt point selected mode+1 := by
 cases bit : phaseBit point mode with
 | false =>
   have counts := countsAtHeld point mode selected bit
   rw [counts.1,counts.2]
   unfold energyAt heldAt returnedAt
   simp only [List.filter,bit]
   exact magnitudeIncrement _ _
 | true =>
   have counts := countsAtReturned point mode selected bit
   rw [counts.1,counts.2]
   unfold energyAt heldAt returnedAt
   simp only [List.filter,bit]
   change (magnitude (imbalance (heldAt selected mode) (returnedAt selected mode+1)))^2+2*heldAt selected mode=
    (magnitude (imbalance (heldAt selected mode) (returnedAt selected mode)))^2+2*returnedAt selected mode+1
   rw [magnitudeSymmetric (heldAt selected mode) (returnedAt selected mode+1),magnitudeSymmetric (heldAt selected mode) (returnedAt selected mode)]
   exact magnitudeIncrement _ _
private def total (f : Word→Nat) : List Word→Nat
 | [] => 0
 | mode::modes => f mode+total f modes
private theorem shuffle (a b c d : Nat) : (a+b)+(c+d)=(a+c)+(b+d) := by
 rw [Nat.add_assoc a b (c+d),←Nat.add_assoc b c d,Nat.add_comm b c,Nat.add_assoc c b d,←Nat.add_assoc a c (b+d)]
private theorem totalAdd (f g : Word→Nat) (modes : List Word) :
 total (fun k=>f k+g k) modes=total f modes+total g modes := by
 induction modes with
 | nil => rfl
 | cons k ks ih =>
   change (f k+g k)+total (fun k=>f k+g k) ks=(f k+total f ks)+(g k+total g ks)
   rw [ih];exact shuffle _ _ _ _
private theorem totalScale (f : Word→Nat) (modes : List Word) :
 total (fun k=>2*f k) modes=2*total f modes := by
 induction modes with
 | nil => rfl
 | cons k ks ih => change 2*f k+total (fun k=>2*f k) ks=2*(f k+total f ks);rw [ih,Nat.mul_add]
private theorem totalOne (modes : List Word) : total (fun _=>1) modes=modes.length := by
 induction modes with
 | nil => rfl
 | cons k ks ih => change 1+total (fun _=>1) ks=Nat.succ ks.length;rw [ih,Nat.one_add]
private theorem totalCongr (f g : Word→Nat) (modes : List Word)
 (eq : ∀ k,k∈modes → f k=g k) : total f modes=total g modes := by
 induction modes with
 | nil => rfl
 | cons k ks ih =>
   change f k+total f ks=g k+total g ks
   rw [eq k (.head _),ih (fun m hm=>eq m (.tail _ hm))]
private theorem sameCons (point x : Word) (selected : List Word) (mode : Word) :
 sameAt point (x::selected) mode=(if phaseBit point mode==phaseBit x mode then 1 else 0)+sameAt point selected mode := by
 unfold sameAt
 cases b : phaseBit point mode==phaseBit x mode <;> rw [List.filter,b]
 · exact (Nat.zero_add _).symm
 · exact (Nat.one_add _).symm
private theorem opposedCons (point x : Word) (selected : List Word) (mode : Word) :
 opposedAt point (x::selected) mode=(if !(phaseBit point mode==phaseBit x mode) then 1 else 0)+opposedAt point selected mode := by
 unfold opposedAt
 cases b : phaseBit point mode==phaseBit x mode <;> rw [List.filter,b]
 · exact (Nat.one_add _).symm
 · exact (Nat.zero_add _).symm
private theorem agreementTotal (point x : Word) (modes : List Word) :
 total (fun k=>if phaseBit point k==phaseBit x k then 1 else 0) modes=heldCount (agreementRows point x modes) := by
 induction modes with
 | nil => rfl
 | cons k ks ih =>
   unfold agreementRows heldCount at ih ⊢
   change (if phaseBit point k==phaseBit x k then 1 else 0)+total _ ks= _
   cases b : phaseBit point k==phaseBit x k <;> rw [List.map,List.filter,b]
   · change 0+total _ ks=_;rw [Nat.zero_add];exact ih
   · change 1+total _ ks=Nat.succ _;rw [Nat.one_add];exact congrArg Nat.succ ih
private theorem oppositionTotal (point x : Word) (modes : List Word) :
 total (fun k=>if !(phaseBit point k==phaseBit x k) then 1 else 0) modes=returnedCount (agreementRows point x modes) := by
 induction modes with
 | nil => rfl
 | cons k ks ih =>
   unfold agreementRows returnedCount at ih ⊢
   change (if !(phaseBit point k==phaseBit x k) then 1 else 0)+total _ ks= _
   cases b : phaseBit point k==phaseBit x k <;> rw [List.map,List.filter,b]
   · change 1+total _ ks=Nat.succ _;rw [Nat.one_add];exact congrArg Nat.succ ih
   · change 0+total _ ks=_;rw [Nat.zero_add];exact ih
private theorem sourceCrossTermsCancel (d : Nat) (point : Word) (selected : List Word)
 (hp : point∈words d) (hs : ∀ x,x∈selected → x∈words d) (fresh : ¬point∈selected) :
 total (sameAt point selected) (words d)=total (opposedAt point selected) (words d) := by
 induction selected with
 | nil => rfl
 | cons x xs ih =>
   have left := totalCongr _ _ (words d) (fun k _=>sameCons point x xs k)
   have right := totalCongr _ _ (words d) (fun k _=>opposedCons point x xs k)
   rw [left,right,totalAdd,totalAdd,agreementTotal,oppositionTotal]
   have ne : point≠x := fun h=>fresh (h.symm ▸ List.Mem.head xs)
   rw [originalOffDiagonalCounts d point x hp (hs x (.head _)) ne,
    ih (fun y hy=>hs y (.tail _ hy)) (fun h=>fresh (.tail _ h))]

def energySum (selected modes : List Word) : Nat := total (energyAt selected) modes

theorem originalSupportEnergySuccessor (d : Nat) (point : Word) (selected : List Word)
 (hp : point∈words d) (hs : ∀ x,x∈selected → x∈words d) (fresh : ¬point∈selected) :
 energySum (point::selected) (words d)=energySum selected (words d)+2^d := by
 have step := totalCongr _ _ (words d) (fun k _=>originalModeEnergySuccessor point k selected)
 rw [totalAdd,totalAdd,totalAdd,totalScale,totalScale,totalOne,
  sourceCrossTermsCancel d point selected hp hs fresh] at step
 have rearranged : total (energyAt selected) (words d)+2*total (opposedAt point selected) (words d)+(words d).length=
  (total (energyAt selected) (words d)+(words d).length)+2*total (opposedAt point selected) (words d) := by
   rw [Nat.add_right_comm]
 rw [rearranged] at step
 have rightCancel (a b k : Nat) (eq : a+k=b+k) : a=b := by
  induction k with
  | zero => exact eq
  | succ k ih => exact ih (Nat.succ.inj eq)
 have cancel := rightCancel _ _ _ step
 exact cancel.trans (congrArg (fun n=>energySum selected (words d)+n) (QuantumSupportDepth.originalWordCount d))

theorem originalParsevalCounting (d : Nat) (selected : List Word)
 (hs : ∀ x,x∈selected → x∈words d) (unique : selected.Nodup) :
 energySum selected (words d)=2^d*selected.length := by
 induction selected with
 | nil =>
   change total (energyAt []) (words d)=0
   have empty : ∀ modes,total (energyAt []) modes=0 := by
    intro modes;induction modes with | nil => rfl | cons k ks ih => change 0+total (energyAt []) ks=0;rw [Nat.zero_add];exact ih
   exact empty _
 | cons x xs ih =>
   cases unique with
   | cons fresh rest =>
     rw [originalSupportEnergySuccessor d x xs (hs x (.head _)) (fun y hy=>hs y (.tail _ hy)) (fun hx=>fresh x hx rfl),
      ih (fun y hy=>hs y (.tail _ hy)) rest]
     change 2^d*xs.length+2^d=2^d*(xs.length+1)
     rw [Nat.mul_succ]
private theorem magnitudeBound (h r : Nat) : magnitude (imbalance h r)≤h+r := by
 unfold imbalance
 split
 · exact Nat.zero_le _
 · split
   · exact Nat.le_trans (Nat.sub_le h r) (Nat.le_add_right h r)
   · exact Nat.le_trans (Nat.sub_le r h) (Nat.le_add_left r h)
private theorem countsPartition (selected : List Word) (mode : Word) :
 heldAt selected mode+returnedAt selected mode=selected.length := by
 induction selected with
 | nil => rfl
 | cons point xs ih =>
   unfold heldAt returnedAt at ih ⊢
   rw [List.filter,List.filter]
   cases bit : phaseBit point mode
   · change Nat.succ _+_ = Nat.succ xs.length
     rw [Nat.succ_add];exact congrArg Nat.succ ih
   · change _+Nat.succ _ = Nat.succ xs.length
     exact congrArg Nat.succ ih
private theorem energyBound (selected : List Word) (mode : Word) : energyAt selected mode≤selected.length*selected.length := by
 have bound := magnitudeBound (heldAt selected mode) (returnedAt selected mode)
 rw [countsPartition] at bound
 unfold energyAt
 rw [Nat.pow_succ,Nat.pow_succ,Nat.pow_zero,Nat.one_mul]
 exact Nat.le_trans (Nat.mul_le_mul_left _ bound) (Nat.mul_le_mul_right _ bound)
def frequencySupport (selected modes : List Word) : Nat :=
 (modes.filter (fun mode => (imbalance (heldAt selected mode) (returnedAt selected mode)).isSome)).length
private theorem energySupportBound (selected modes : List Word) :
 energySum selected modes≤frequencySupport selected modes*(selected.length*selected.length) := by
 induction modes with
 | nil => exact Nat.zero_le _
 | cons k ks ih =>
   unfold frequencySupport at ih ⊢
   rw [List.filter]
   cases c : imbalance (heldAt selected k) (returnedAt selected k) with
   | none =>
     change energyAt selected k+energySum selected ks≤_
     unfold energyAt
     rw [c]
     change 0+energySum selected ks≤_
     rw [Nat.zero_add]
     exact ih
   | some n =>
     change energyAt selected k+energySum selected ks≤(frequencySupport selected ks+1)*(selected.length*selected.length)
     have bound := Nat.add_le_add (energyBound selected k) ih
     rw [Nat.mul_comm (frequencySupport selected ks+1),Nat.mul_succ,Nat.mul_comm (selected.length*selected.length) (frequencySupport selected ks)]
     exact Nat.le_trans bound (Nat.le_of_eq (Nat.add_comm _ _))

theorem originalSupportProductBound (d : Nat) (selected : List Word)
 (hs : ∀ x,x∈selected → x∈words d) (unique : selected.Nodup) (nonempty : 0<selected.length) :
 2^d≤selected.length*frequencySupport selected (words d) := by
 have bound := energySupportBound selected (words d)
 rw [originalParsevalCounting d selected hs unique] at bound
 have reassociate : frequencySupport selected (words d)*(selected.length*selected.length)=
  (selected.length*frequencySupport selected (words d))*selected.length := by
   rw [←SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm (frequencySupport selected (words d)) selected.length]
 rw [reassociate] at bound
 apply Nat.le_of_not_gt
 intro bad
 exact Nat.not_lt_of_ge bound (Nat.mul_lt_mul_of_pos_right bad nonempty)
end SFT.Physics.QuantumSupportParseval
