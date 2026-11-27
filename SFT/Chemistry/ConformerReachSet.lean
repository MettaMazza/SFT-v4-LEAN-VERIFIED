import SFT.Chemistry.ConformerCarrier
import SFT.Foundation.CountTrace
namespace SFT.Chemistry.ConformerReachSet
open SFT.Physics.CapabilityValues ConformerCarrier
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

private theorem positionEqual (a b : PositiveCount) (h : a.value = b.value) : a=b := by
 cases a; cases b; cases h; rfl
private instance : DecidableEq PositiveCount := fun a b =>
 match decEq a.value b.value with
 | isTrue h => isTrue (positionEqual a b h)
 | isFalse h => isFalse (fun same => h (congrArg PositiveCount.value same))

theorem positionMembership (xs : List PositiveCount) (x : PositiveCount) :
 containsPosition xs x = true ↔ x ∈ xs := by
 induction xs with
 | nil =>
  constructor
  · intro h; cases h
  · intro h; cases h
 | cons y ys ih =>
  change ((y.value==x.value) || containsPosition ys x)=true ↔ x∈y::ys
  cases same : (y.value==x.value) with
  | true =>
   have equal := positionEqual y x (Nat.eq_of_beq_eq_true same)
   cases equal
   exact ⟨fun _ => List.Mem.head ys,fun _ => rfl⟩
  | false =>
   constructor
   · intro h
     exact List.Mem.tail y (ih.mp h)
   · intro member
     cases member with
     | head =>
      have eq : (x.value==x.value)=true := by
       have reflexive : ∀ n : Nat, (n==n)=true := by
        intro n
        induction n with
        | zero => rfl
        | succ n ih => exact ih
       exact reflexive _
      rw [same] at eq; cases eq
     | tail _ h => exact ih.mpr h

private def add (acc : List PositiveCount) (x : PositiveCount) : List PositiveCount :=
 if containsPosition acc x then acc else acc++[x]

private theorem appendFresh (acc : List PositiveCount) (x : PositiveCount)
 (unique : acc.Nodup) (fresh : x∉acc) : (acc++[x]).Nodup := by
 induction unique with
 | nil => exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 | @cons first rest separate unique ih =>
  refine List.Pairwise.cons ?_ (ih (fun h => fresh (List.Mem.tail first h)))
  intro y member
  cases memAppendCases y rest [x] member with
  | inl h => exact separate y h
  | inr h =>
   cases h with
   | head => intro equal; cases equal; exact fresh (List.Mem.head rest)
   | tail _ h => cases h

private theorem foldUnique (items acc : List PositiveCount) (unique : acc.Nodup) :
 (items.foldl add acc).Nodup := by
 induction items generalizing acc with
 | nil => exact unique
 | cons x xs ih =>
  change (xs.foldl add (add acc x)).Nodup
  cases seen : containsPosition acc x with
  | true =>
   have step : add acc x=acc := by unfold add; rw [seen]; rfl
   rw [step]; exact ih acc unique
  | false =>
   have step : add acc x=acc++[x] := by unfold add; rw [seen]; rfl
   rw [step]; apply ih; apply appendFresh acc x unique
   intro member
   have yes := (positionMembership acc x).mpr member
   rw [seen] at yes; cases yes

private theorem foldInside (items acc allowed : List PositiveCount)
 (initial : ∀ x, x∈acc → x∈allowed) (inputs : ∀ x, x∈items → x∈allowed) :
 ∀ x, x∈items.foldl add acc → x∈allowed := by
 induction items generalizing acc with
 | nil => exact initial
 | cons a rest ih =>
  apply ih
  · intro x member
    change x∈(if containsPosition acc a then acc else acc++[a]) at member
    cases seen : containsPosition acc a with
    | true => rw [seen] at member; exact initial x member
    | false =>
     rw [seen] at member
     cases memAppendCases x acc [a] member with
     | inl h => exact initial x h
     | inr h =>
      cases h with
      | head => exact inputs a (List.Mem.head rest)
      | tail _ h => cases h
  · intro x member; exact inputs x (List.Mem.tail a member)

private theorem appendEmpty (xs : List PositiveCount) : xs++[]=xs := by
 induction xs with
 | nil => rfl
 | cons a rest ih => exact congrArg (List.cons a) ih
private theorem appendGrouped (xs ys zs : List PositiveCount) : (xs++ys)++zs=xs++(ys++zs) := by
 induction xs with
 | nil => rfl
 | cons a rest ih => exact congrArg (List.cons a) ih

private theorem foldPrefix (items acc : List PositiveCount) :
 ∃ tail, items.foldl add acc=acc++tail := by
 induction items generalizing acc with
 | nil => exact ⟨[],(appendEmpty acc).symm⟩
 | cons x xs ih =>
  change ∃ tail, xs.foldl add (add acc x)=acc++tail
  cases seen : containsPosition acc x with
  | true =>
   have step : add acc x=acc := by unfold add; rw [seen]; rfl
   rw [step]; exact ih acc
  | false =>
   have step : add acc x=acc++[x] := by unfold add; rw [seen]; rfl
   rw [step]
   obtain ⟨tail,eq⟩ := ih (acc++[x])
   exact ⟨x::tail,eq.trans (appendGrouped acc [x] tail)⟩

private theorem foldFresh (items acc : List PositiveCount) (unique : items.Nodup)
 (fresh : ∀ x, x∈items → x∉acc) : items.foldl add acc=acc++items := by
 induction items generalizing acc with
 | nil => exact (appendEmpty acc).symm
 | cons x xs ih =>
  cases unique with
  | cons separated unique =>
   have unseen : containsPosition acc x=false := by
    cases seen : containsPosition acc x with
    | false => rfl
    | true => exact False.elim (fresh x (List.Mem.head xs) ((positionMembership acc x).mp seen))
   have step : add acc x=acc++[x] := by unfold add; rw [unseen]; rfl
   change xs.foldl add (add acc x)=acc++(x::xs)
   rw [step]
   have next : ∀ y, y∈xs → y∉acc++[x] := by
    intro y member joined
    cases memAppendCases y acc [x] joined with
    | inl h => exact fresh y (List.Mem.tail x member) h
    | inr h =>
     cases h with
     | head => exact separated x member rfl
     | tail _ h => cases h
   exact (ih (acc++[x]) unique next).trans (appendGrouped acc [x] xs)

theorem uniquePositionsOfUnique (positions : List PositiveCount) (unique : positions.Nodup) :
 uniquePositions positions=positions :=
 foldFresh positions [] unique (fun _ _ h => by cases h)

theorem expansionUnique (bonds : List Bond) (reached : List PositiveCount) :
 (expand bonds reached).Nodup := foldUnique _ [] List.Pairwise.nil

theorem expansionRetainsPrefix (bonds : List Bond) (reached : List PositiveCount)
 (unique : reached.Nodup) : ∃ tail, expand bonds reached=reached++tail := by
 have replay : reached.foldl add []=reached :=
  foldFresh reached [] unique (fun _ _ h => by cases h)
 unfold expand uniquePositions
 change ∃ tail, (reached ++ bonds.flatMap (fun (a,b) =>
  if containsPosition reached a || containsPosition reached b then [a,b] else [])).foldl add []=reached++tail
 have joined : ∀ (xs ys : List PositiveCount) (seed : List PositiveCount),
   (xs++ys).foldl add seed=ys.foldl add (xs.foldl add seed) := by
  intro xs
  induction xs with
  | nil => intro ys seed; rfl
  | cons a rest ih => intro ys seed; exact ih ys (add seed a)
 rw [joined,replay]
 exact foldPrefix _ reached

theorem expansionInside (bonds : List Bond) (reached allowed : List PositiveCount)
 (custody : ∀ bond, bond∈bonds → bond.1∈allowed ∧ bond.2∈allowed)
 (inside : ∀ x, x∈reached → x∈allowed) :
 ∀ x, x∈expand bonds reached → x∈allowed := by
 apply foldInside _ [] allowed (fun _ h => by cases h)
 intro x member
 cases memAppendCases x reached _ member with
 | inl h => exact inside x h
 | inr h =>
  obtain ⟨bond,present,selected⟩ := memFlatMapOrigin _ _ _ h
  have held := custody bond present
  rcases bond with ⟨left,right⟩
  change x∈(if containsPosition reached left || containsPosition reached right then [left,right] else []) at selected
  cases incident : (containsPosition reached left || containsPosition reached right) with
  | false => rw [incident] at selected; cases selected
  | true =>
   rw [incident] at selected
   cases selected with
   | head => exact held.1
   | tail _ h =>
    cases h with
    | head => exact held.2
    | tail _ h => cases h

theorem expansionStopsExactly (bonds : List Bond) (reached : List PositiveCount)
 (unique : reached.Nodup) (sameSize : (expand bonds reached).length=reached.length) :
 expand bonds reached=reached := by
 obtain ⟨tail,eq⟩ := expansionRetainsPrefix bonds reached unique
 rw [eq,appendLength] at sameSize
 have emptySize : tail.length=0 := by
  cases size : tail.length with
  | zero => rfl
  | succ n =>
   have larger : reached.length < reached.length+(n+1) := Nat.lt_add_of_pos_right (Nat.zero_lt_succ n)
   rw [size] at sameSize
   rw [sameSize] at larger
   exact False.elim (Nat.lt_irrefl _ larger)
 have empty : tail=[] := by
  cases tail with
  | nil => rfl
  | cons a rest => cases emptySize
 rw [eq,empty]
 exact appendEmpty reached

theorem expansionGrows (bonds : List Bond) (reached : List PositiveCount)
 (unique : reached.Nodup) (different : (expand bonds reached).length≠reached.length) :
 reached.length < (expand bonds reached).length := by
 obtain ⟨tail,eq⟩ := expansionRetainsPrefix bonds reached unique
 rw [eq,appendLength] at different ⊢
 cases tail with
 | nil => exact False.elim (different (Nat.add_zero reached.length))
 | cons first rest => exact Nat.lt_add_of_pos_right (Nat.zero_lt_succ _)
end SFT.Chemistry.ConformerReachSet
