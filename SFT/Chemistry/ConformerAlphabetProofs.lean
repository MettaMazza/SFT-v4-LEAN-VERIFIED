import SFT.Chemistry.ConformerCarrier
import SFT.Foundation.CountTrace
namespace SFT.Chemistry.ConformerAlphabetProofs
open SFT.Host SFT.Physics.CapabilityValues ConformerCarrier
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

-- Derive distinctness from the actual source constructor's deduplication guard.
theorem checkedStatesDistinct (states : List HeldLabel)
 (checked : MulticentreSupport.distinct states = true) :
 states.Pairwise (fun x y => x ≠ y) := by
 let add := fun (acc : List HeldLabel) (x : HeldLabel) =>
  if MulticentreSupport.contains acc x then acc else acc++[x]
 have listReflexive (xs : List Nat) : (xs==xs)=true := by
  induction xs with
  | nil => rfl
  | cons n xs ih =>
   change ((n==n) && (xs==xs))=true
   have naturalReflexive : ∀ k : Nat, (k==k)=true := by
    intro k
    induction k with
    | zero => rfl
    | succ k ih => exact ih
   rw [naturalReflexive,ih]
   rfl
 have reflexive (x : HeldLabel) : MulticentreSupport.sameLabel x x = true := by
  unfold MulticentreSupport.sameLabel Text.equal
  rw [listReflexive,listReflexive]
  rfl
 have containsMember (acc : List HeldLabel) (x : HeldLabel) (member : x ∈ acc) :
  MulticentreSupport.contains acc x = true := by
  induction acc with
  | nil => cases member
  | cons first rest ih =>
   cases member with
   | head =>
    change MulticentreSupport.sameLabel x x || MulticentreSupport.contains rest x = true
    rw [reflexive]
    rfl
   | tail _ present =>
    change MulticentreSupport.sameLabel x first || MulticentreSupport.contains rest x = true
    rw [ih present]
    cases MulticentreSupport.sameLabel x first <;> rfl
 have bound (xs acc : List HeldLabel) : (xs.foldl add acc).length ≤ acc.length+xs.length := by
  induction xs generalizing acc with
  | nil => exact Nat.le_refl _
  | cons x xs ih =>
   change (xs.foldl add (add acc x)).length ≤ acc.length+(xs.length+1)
   cases found : MulticentreSupport.contains acc x with
   | true =>
    have step := ih acc
    have dedupStep : add acc x=acc := by dsimp only [add]; rw [found]; rfl
    rw [dedupStep]
    exact Nat.le_trans step (Nat.le_succ _)
   | false =>
    have step := ih (acc++[x])
    have dedupStep : add acc x=acc++[x] := by dsimp only [add]; rw [found]; rfl
    rw [dedupStep]
    rw [appendLength] at step
    change (xs.foldl add (acc++[x])).length ≤ (acc.length+1)+xs.length at step
    rw [Nat.add_assoc,Nat.add_comm 1 xs.length] at step
    exact step
 have noLoss (xs acc : List HeldLabel)
  (full : (xs.foldl add acc).length=acc.length+xs.length) : xs.foldl add acc=acc++xs := by
  induction xs generalizing acc with
  | nil =>
   have emptyAppend : ∀ ys : List HeldLabel, ys++[]=ys := by
    intro ys
    induction ys with
    | nil => rfl
    | cons y ys ih => exact congrArg (List.cons y) ih
   exact (emptyAppend acc).symm
  | cons x xs ih =>
   change (xs.foldl add (add acc x)).length=acc.length+(xs.length+1) at full
   change xs.foldl add (add acc x)=acc++(x::xs)
   cases found : MulticentreSupport.contains acc x with
   | true =>
    have step : add acc x=acc := by dsimp only [add]; rw [found]; rfl
    rw [step] at full
    have smaller := bound xs acc
    rw [full] at smaller
    exact False.elim (Nat.not_succ_le_self _ smaller)
   | false =>
    have step : add acc x=acc++[x] := by dsimp only [add]; rw [found]; rfl
    rw [step] at full ⊢
    have next : (xs.foldl add (acc++[x])).length=(acc++[x]).length+xs.length := by
     rw [appendLength]
     change (xs.foldl add (acc++[x])).length=(acc.length+1)+xs.length
     rw [Nat.add_assoc,Nat.add_comm 1 xs.length]
     exact full
    rw [ih (acc++[x]) next]
    have grouped : ∀ (ys : List HeldLabel), (ys++[x])++xs=ys++(x::xs) := by
     intro ys
     induction ys with
     | nil => rfl
     | cons a rest ih => exact congrArg (List.cons a) ih
    exact grouped acc
 have appendFresh (acc : List HeldLabel) (x : HeldLabel)
  (unique : acc.Pairwise (fun a b => a ≠ b)) (fresh : x ∉ acc) :
  (acc++[x]).Pairwise (fun a b => a ≠ b) := by
  induction unique with
  | nil => exact List.Pairwise.cons (fun _ impossible => by cases impossible) List.Pairwise.nil
  | @cons first rest separated unique ih =>
   refine List.Pairwise.cons ?_ (ih (fun present => fresh (List.Mem.tail first present)))
   intro y member
   cases memAppendCases y rest [x] member with
   | inl present => exact separated y present
   | inr present =>
    cases present with
    | head => intro same; cases same; exact fresh (List.Mem.head rest)
    | tail _ impossible => cases impossible
 have uniqueFold (xs acc : List HeldLabel) (unique : acc.Pairwise (fun a b => a ≠ b)) :
  (xs.foldl add acc).Pairwise (fun a b => a ≠ b) := by
  induction xs generalizing acc with
  | nil => exact unique
  | cons x xs ih =>
   change (xs.foldl add (add acc x)).Pairwise (fun a b => a ≠ b)
   cases found : MulticentreSupport.contains acc x with
   | true =>
    have dedupStep : add acc x=acc := by dsimp only [add]; rw [found]; rfl
    rw [dedupStep]
    exact ih acc unique
   | false =>
    have dedupStep : add acc x=acc++[x] := by dsimp only [add]; rw [found]; rfl
    rw [dedupStep]
    apply ih
    apply appendFresh acc x unique
    intro member
    have yes := containsMember acc x member
    rw [found] at yes
    cases yes
 have full : (states.foldl add []).length=0+states.length := by
  have same : (states.foldl add []).length=states.length := Nat.eq_of_beq_eq_true checked
  exact same.trans (Nat.zero_add _).symm
 have unchanged := noLoss states [] full
 have unique := uniqueFold states [] List.Pairwise.nil
 rw [unchanged] at unique
 exact unique
theorem acceptedInputStatesDistinct (states : List HeldLabel) (reversal : List (HeldLabel × HeldLabel))
 (out : Alphabet) (accepted : alphabet states reversal = .ok out) :
 states.Pairwise (fun x y => x ≠ y) := by
 apply checkedStatesDistinct states
 cases unique : MulticentreSupport.distinct states with
 | true => rfl
 | false =>
  have invalid : (states.isEmpty || !MulticentreSupport.distinct states ||
   !(states.all fun state => Text.equal state.family "torsion-state"))=true := by
   rw [unique]
   cases states.isEmpty <;> cases (states.all fun state => Text.equal state.family "torsion-state") <;> rfl
  unfold alphabet at accepted
  rw [invalid] at accepted
  cases accepted

theorem acceptedStatesRetained (states : List HeldLabel) (reversal : List (HeldLabel × HeldLabel))
 (out : Alphabet) (accepted : alphabet states reversal = .ok out) : out.states=states := by
 change (if states.isEmpty || !MulticentreSupport.distinct states || !(states.all fun s => Text.equal s.family "torsion-state") then Except.error "each rotor requires a complete positive finite held-state alphabet"
  else if !(states.all fun s => (reversal.map Prod.fst).any (MulticentreSupport.sameLabel s)) || !(reversal.map Prod.fst).all (fun k => states.any (MulticentreSupport.sameLabel k)) || !(states.all fun state => match reversalLookup reversal state with | none => false | some value => states.any (MulticentreSupport.sameLabel value)) then Except.error "torsion reversal must cover every held state exactly once"
  else if !(states.all fun state => match reversalLookup reversal state with | none => false | some value => match reversalLookup reversal value with | none => false | some twice => MulticentreSupport.sameLabel twice state) then Except.error "torsion reversal must be an exact involution"
  else Except.ok (Alphabet.mk states reversal)) = Except.ok out at accepted
 split at accepted
 · cases accepted
 · split at accepted
   · cases accepted
   · split at accepted
     · cases accepted
     · cases accepted; rfl
end SFT.Chemistry.ConformerAlphabetProofs
