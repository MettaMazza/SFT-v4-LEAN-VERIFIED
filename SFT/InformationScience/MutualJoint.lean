import SFT.InformationScience.MutualParts
namespace SFT.InformationScience.MutualJoint
open MutualObservation MutualParts
open SFT.Foundation.ExactOperations SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.ProbabilityObservations

structure JointRow where
  leftLabel : String
  rightLabel : String
  members : List String
  jointPart : ExactCell
  leftPart : PositiveFraction
  rightPart : PositiveFraction
  productPart : PositiveFraction
  relation : Comparison

theorem supportPositive (support : List String) (observation result : Observation)
    (h : validateObservation support observation = .ok result) : 0 < support.length := by
  have ne := ((supportMeaning _).mp ((validationMeaning _ _ _).mp h).1).1
  cases support with
  | nil => cases ne
  | cons first rest => exact Nat.zero_lt_succ _

theorem marginalPositive (support : List String) (observation : Observation) (label : String)
    (h : label ∈ labels support observation) : 0 < (fibre support observation label).length := by
  obtain ⟨state,hs,hi⟩ := (labelsMeaning _ _ _).mp h
  have hm := (fibreMembership _ _ _ _).mpr ⟨hs,hi⟩
  cases hc : fibre support observation label with
  | nil => rw [hc] at hm; cases hm
  | cons first rest => exact Nat.zero_lt_succ _

def marginalPart (support : List String) (positive : 0 < support.length) (observation : Observation)
    (label : String) (present : label ∈ labels support observation) : PositiveFraction :=
  normalizePositive (fibre support observation label).length support.length (marginalPositive _ _ _ present) positive

def makeRow (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) : JointRow :=
  let members := jointMembers support left right a b
  let joint := countPart support.length positive members
  let lp := marginalPart support positive left a ha
  let rp := marginalPart support positive right b hb
  let product := multiply lp rp
  ⟨a,b,presentMembers members,joint,lp,rp,product,MutualParts.compare joint product⟩

def jointRows (support : List String) (positive : 0 < support.length) (left right : Observation) :
    (pairs : List (String × String)) →
    (∀ pair, pair ∈ pairs → pair.1 ∈ labels support left ∧ pair.2 ∈ labels support right) → List JointRow
  | [], _ => []
  | pair :: rest, valid => makeRow support positive left right pair.1 pair.2
      (valid pair (List.Mem.head _)).1 (valid pair (List.Mem.head _)).2 ::
    jointRows support positive left right rest (fun held hm => valid held (List.Mem.tail pair hm))

def completeRows (support : List String) (positive : 0 < support.length) (left right : Observation) : List JointRow :=
  jointRows support positive left right (labelPairs support left right)
    (fun pair hm => (pairsMembership support left right pair.1 pair.2).mp hm)

def jointLedger (support : List String) (left right : Observation) : Except String (List JointRow) :=
  match hl : validateObservation support left with
  | .error e => .error e
  | .ok leftImages => match validateObservation support right with
    | .error e => .error e
    | .ok rightImages => .ok (completeRows support (supportPositive _ _ _ hl) leftImages rightImages)

theorem rowLabels (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) :
    (makeRow support positive left right a b ha hb).leftLabel = a ∧
    (makeRow support positive left right a b ha hb).rightLabel = b := ⟨rfl,rfl⟩

theorem rowMembers (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) :
    (makeRow support positive left right a b ha hb).members = presentMembers (jointMembers support left right a b) := rfl

theorem marginalValue (support : List String) (positive : 0 < support.length) (observation : Observation)
    (label : String) (present : label ∈ labels support observation) :
    (fibre support observation label).length*(marginalPart support positive observation label present).denominator =
      (marginalPart support positive observation label present).numerator*support.length :=
  normalizedValuePreserved _ _ _ _

theorem rowEmpty (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) :
    (makeRow support positive left right a b ha hb).jointPart = .emptyOne ↔ jointMembers support left right a b = [] :=
  countEmpty _ _ _

theorem rowJointValue (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) (part : PositiveFraction)
    (h : (makeRow support positive left right a b ha hb).jointPart = .part part) :
    0 < (jointMembers support left right a b).length ∧
    (jointMembers support left right a b).length*part.denominator = part.numerator*support.length :=
  countFraction _ _ _ _ h

theorem rowComparison (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) :
    (makeRow support positive left right a b ha hb).relation =
      MutualParts.compare (makeRow support positive left right a b ha hb).jointPart
        (makeRow support positive left right a b ha hb).productPart := rfl

theorem rowProduct (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) :
    (makeRow support positive left right a b ha hb).productPart =
      multiply (makeRow support positive left right a b ha hb).leftPart
        (makeRow support positive left right a b ha hb).rightPart := rfl

theorem rowsProjection (support : List String) (positive : 0 < support.length) (left right : Observation)
    (pairs : List (String × String))
    (valid : ∀ pair, pair ∈ pairs → pair.1 ∈ labels support left ∧ pair.2 ∈ labels support right) :
    (jointRows support positive left right pairs valid).map (fun row => (row.leftLabel,row.rightLabel)) = pairs := by
  induction pairs with
  | nil => rfl
  | cons pair rest ih => exact congrArg (List.cons pair) (ih (fun held hm => valid held (List.Mem.tail pair hm)))

theorem completeProjection (support : List String) (positive : 0 < support.length) (left right : Observation) :
    (completeRows support positive left right).map (fun row => (row.leftLabel,row.rightLabel)) = labelPairs support left right :=
  rowsProjection _ _ _ _ _ _

theorem completePair (support : List String) (positive : 0 < support.length) (left right : Observation)
    (a b : String) (ha : a ∈ labels support left) (hb : b ∈ labels support right) :
    ∃ row, row ∈ completeRows support positive left right ∧ row.leftLabel = a ∧ row.rightLabel = b := by
  have hm := (pairsMembership support left right a b).mpr ⟨ha,hb⟩
  rw [← completeProjection support positive left right] at hm
  obtain ⟨row,hr,eq⟩ := memMapPreimage (fun row : JointRow => (row.leftLabel,row.rightLabel)) (a,b) _ hm
  exact ⟨row,hr,congrArg Prod.fst eq,congrArg Prod.snd eq⟩

theorem ledgerAdmitted (support : List String) (left right : Observation)
    (hl : validateObservation support left = .ok left) (hr : validateObservation support right = .ok right) :
    jointLedger support left right = .ok (completeRows support (supportPositive _ _ _ hl) left right) := by
  unfold jointLedger
  split
  · rename_i e he
    rw [hl] at he; cases he
  · rename_i value hv
    have same : value = left := ((MutualObservation.validationMeaning _ _ _).mp hv).2.2
    cases same
    rw [hr]

end SFT.InformationScience.MutualJoint
