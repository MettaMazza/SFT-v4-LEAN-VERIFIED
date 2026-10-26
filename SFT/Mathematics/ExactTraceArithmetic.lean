import SFT.Foundation.FormEquivalenceRaw
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.ExactTraceArithmetic
abbrev Atom := List String
abbrev Trace := List Atom

def atomEqual (a b : Atom) : Bool := decide (a = b)

def contains (atoms : Trace) (atom : Atom) : Bool := atoms.any (atomEqual atom)

def distinctLabels : List String → Bool
  | [] => true
  | a::as => !(as.any (fun b => decide (a = b))) && distinctLabels as

def trace (labels : List String) : Except String Trace :=
  if labels.isEmpty || !distinctLabels labels then
    .error "ValueError: an exact positive trace must contain distinct generated labels"
  else .ok (labels.map fun label => [label])

def disjointJunction (left right : Trace) : Except String Trace :=
  if left.isEmpty || right.isEmpty || left.any (contains right) then
    .error "ValueError: junction requires nonempty disjoint traces"
  else .ok (left ++ right)

def pairCells (left right : Trace) : Trace := left.flatMap (fun a => right.map (fun b => a ++ b))

def pairCellProduct (left right : Trace) : Except String Trace :=
  if left.isEmpty || right.isEmpty then
    .error "ValueError: pair-cell product requires positive traces"
  else .ok (pairCells left right)

def exactPairing (left right : Trace) : Option (List (Atom × Atom)) :=
  if left.length = right.length then some (left.zip right) else none

def orientedRemainder (left right : Trace) : String × Trace :=
  let l := left.filter (fun a => !contains right a)
  let r := right.filter (fun a => !contains left a)
  if !l.isEmpty && !r.isEmpty then ("incomparable-held",l ++ r)
  else if !l.isEmpty then ("left-held",l)
  else if !r.isEmpty then ("right-held",r)
  else ("same-form",[["empty-One"]])

theorem appendAssociative {α : Type} (a b c : List α) : (a ++ b) ++ c = a ++ (b ++ c) := by
  induction a with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih

theorem mapAppend {α β : Type} (f : α → β) (a b : List α) : (a ++ b).map f = a.map f ++ b.map f := by
  induction a with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons (f x)) ih

theorem pairCellsLeftDistribute (a b c : Trace) : pairCells (a ++ b) c = pairCells a c ++ pairCells b c := by
  induction a with
  | nil => rfl
  | cons x xs ih =>
    change (c.map (fun y => x ++ y)) ++ pairCells (xs ++ b) c = ((c.map (fun y => x ++ y)) ++ pairCells xs c) ++ pairCells b c
    rw [ih,appendAssociative]

theorem pairCellProductPositive (left right : Trace) (hl : left.isEmpty = false) (hr : right.isEmpty = false) :
    pairCellProduct left right = .ok (pairCells left right) := by
  unfold pairCellProduct
  rw [hl,hr]
  rfl

theorem disjointJunctionAdmitted (left right : Trace) (hl : left.isEmpty = false) (hr : right.isEmpty = false)
    (hd : left.any (contains right) = false) : disjointJunction left right = .ok (left ++ right) := by
  unfold disjointJunction
  rw [hl,hr,hd]
  rfl

theorem exactPairingEqualLength (left right : Trace) (h : left.length = right.length) :
    exactPairing left right = some (left.zip right) := by
  unfold exactPairing
  rw [ite_eq_left h]

theorem exactPairingUnequalLength (left right : Trace) (h : left.length ≠ right.length) :
    exactPairing left right = none := by
  unfold exactPairing
  rw [ite_eq_right h]

theorem emptyPairingPreserved : exactPairing [] [] = some [] := rfl

theorem emptyTraceRejected : trace [] = .error "ValueError: an exact positive trace must contain distinct generated labels" := rfl

theorem repeatedLabelRejected (label : String) : trace [label,label] = .error "ValueError: an exact positive trace must contain distinct generated labels" := by
  have same : decide (label = label) = true := decide_eq_true rfl
  have bad : ([label,label].isEmpty || !distinctLabels [label,label]) = true := by
    change (false || !(!(decide (label = label) || false) && distinctLabels [label])) = true
    rw [same]
    rfl
  unfold trace
  rw [ite_eq_left bad]

theorem mapFlattenAssociative (a b : Atom) (cs : Trace) :
    (cs.map (fun c => b ++ c)).map (fun bc => a ++ bc) = cs.map (fun c => (a ++ b) ++ c) := by
  induction cs with
  | nil => rfl
  | cons c cs ih =>
    change (a ++ (b ++ c)) :: (cs.map (fun x => b ++ x)).map (fun x => a ++ x) = ((a ++ b) ++ c) :: cs.map (fun x => (a ++ b) ++ x)
    rw [appendAssociative,ih]

theorem mapPairCells (a : Atom) (bs cs : Trace) :
    (pairCells bs cs).map (fun bc => a ++ bc) = pairCells (bs.map (fun b => a ++ b)) cs := by
  induction bs with
  | nil => rfl
  | cons b bs ih =>
    change ((cs.map (fun c => b ++ c)) ++ pairCells bs cs).map (fun x => a ++ x) =
      cs.map (fun c => (a ++ b) ++ c) ++ pairCells (bs.map (fun x => a ++ x)) cs
    rw [mapAppend,mapFlattenAssociative,ih]

theorem pairCellsAssociative (as bs cs : Trace) : pairCells (pairCells as bs) cs = pairCells as (pairCells bs cs) := by
  induction as with
  | nil => rfl
  | cons a as ih =>
    change pairCells ((bs.map (fun b => a ++ b)) ++ pairCells as bs) cs =
      (pairCells bs cs).map (fun bc => a ++ bc) ++ pairCells as (pairCells bs cs)
    rw [pairCellsLeftDistribute,ih,mapPairCells]

theorem junctionAssociativeOutput (a b c : Trace) : (a ++ b) ++ c = a ++ (b ++ c) := appendAssociative a b c

theorem pairCellCardinality (left right : Trace) : (pairCells left right).length = right.length * left.length := by
  induction left with
  | nil => rfl
  | cons a as ih =>
    change ((right.map (fun b => a ++ b)) ++ pairCells as right).length = right.length * (as.length + 1)
    rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.mapLength,ih]
    exact Nat.add_comm _ _

theorem positivePairCells (a b : Atom) (as bs : Trace) : (pairCells (a::as) (b::bs)).isEmpty = false := rfl

theorem remainderTags (left right : Trace) :
    (orientedRemainder left right).1 = "incomparable-held" ∨
    (orientedRemainder left right).1 = "left-held" ∨
    (orientedRemainder left right).1 = "right-held" ∨
    (orientedRemainder left right).1 = "same-form" := by
  unfold orientedRemainder
  dsimp only
  split
  · exact Or.inl rfl
  · split
    · exact Or.inr (Or.inl rfl)
    · split
      · exact Or.inr (Or.inr (Or.inl rfl))
      · exact Or.inr (Or.inr (Or.inr rfl))

end SFT.Mathematics.ExactTraceArithmetic
