import SFT.InformationScience.MutualJoint
namespace SFT.InformationScience.MutualConditional
open MutualObservation MutualParts MutualJoint
open SFT.Foundation.ExactOperations SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.ProbabilityObservations

structure ConditionalRow where
  givenLabel : String
  targetLabel : String
  members : List String
  exactGivenPart : ExactCell

def makeRow (support : List String) (targetMap givenMap : Observation)
    (a b : String) (ha : a ∈ labels support givenMap) : ConditionalRow :=
  let members := conditionalMembers support targetMap givenMap a b
  ⟨a,b,presentMembers members,countPart (fibre support givenMap a).length (marginalPositive _ _ _ ha) members⟩

def rows (support : List String) (targetMap givenMap : Observation) :
    (pairs : List (String × String)) →
    (∀ pair, pair ∈ pairs → pair.1 ∈ labels support givenMap) → List ConditionalRow
  | [], _ => []
  | pair :: rest, valid => makeRow support targetMap givenMap pair.1 pair.2 (valid pair (List.Mem.head _)) ::
    rows support targetMap givenMap rest (fun held hm => valid held (List.Mem.tail pair hm))

def completeRows (support : List String) (targetMap givenMap : Observation) : List ConditionalRow :=
  rows support targetMap givenMap (labelPairs support givenMap targetMap)
    (fun pair hm => ((pairsMembership support givenMap targetMap pair.1 pair.2).mp hm).1)

def conditionalLedger (support : List String) (targetMap givenMap : Observation) : Except String (List ConditionalRow) :=
  match validateObservation support targetMap with
  | .error e => .error e
  | .ok targetImages => match validateObservation support givenMap with
    | .error e => .error e
    | .ok givenImages => .ok (completeRows support targetImages givenImages)

theorem rowMembers (support : List String) (targetMap givenMap : Observation)
    (a b : String) (ha : a ∈ labels support givenMap) :
    (makeRow support targetMap givenMap a b ha).members = presentMembers (conditionalMembers support targetMap givenMap a b) := rfl

theorem rowEmpty (support : List String) (targetMap givenMap : Observation)
    (a b : String) (ha : a ∈ labels support givenMap) :
    (makeRow support targetMap givenMap a b ha).exactGivenPart = .emptyOne ↔ conditionalMembers support targetMap givenMap a b = [] :=
  countEmpty _ _ _

theorem rowValue (support : List String) (targetMap givenMap : Observation)
    (a b : String) (ha : a ∈ labels support givenMap) (part : PositiveFraction)
    (h : (makeRow support targetMap givenMap a b ha).exactGivenPart = .part part) :
    0 < (conditionalMembers support targetMap givenMap a b).length ∧
    (conditionalMembers support targetMap givenMap a b).length*part.denominator =
      part.numerator*(fibre support givenMap a).length := countFraction _ _ _ _ h

theorem rowsProjection (support : List String) (targetMap givenMap : Observation)
    (pairs : List (String × String)) (valid : ∀ pair, pair ∈ pairs → pair.1 ∈ labels support givenMap) :
    (rows support targetMap givenMap pairs valid).map (fun row => (row.givenLabel,row.targetLabel)) = pairs := by
  induction pairs with
  | nil => rfl
  | cons pair rest ih => exact congrArg (List.cons pair) (ih (fun held hm => valid held (List.Mem.tail pair hm)))

theorem completeProjection (support : List String) (targetMap givenMap : Observation) :
    (completeRows support targetMap givenMap).map (fun row => (row.givenLabel,row.targetLabel)) = labelPairs support givenMap targetMap :=
  rowsProjection _ _ _ _ _

theorem completePair (support : List String) (targetMap givenMap : Observation) (a b : String)
    (ha : a ∈ labels support givenMap) (hb : b ∈ labels support targetMap) :
    ∃ row, row ∈ completeRows support targetMap givenMap ∧ row.givenLabel = a ∧ row.targetLabel = b := by
  have hm := (pairsMembership support givenMap targetMap a b).mpr ⟨ha,hb⟩
  rw [← completeProjection support targetMap givenMap] at hm
  obtain ⟨row,hr,eq⟩ := memMapPreimage (fun row : ConditionalRow => (row.givenLabel,row.targetLabel)) (a,b) _ hm
  exact ⟨row,hr,congrArg Prod.fst eq,congrArg Prod.snd eq⟩

theorem ledgerAdmitted (support : List String) (targetMap givenMap : Observation)
    (ht : validateObservation support targetMap = .ok targetMap)
    (hg : validateObservation support givenMap = .ok givenMap) :
    conditionalLedger support targetMap givenMap = .ok (completeRows support targetMap givenMap) := by
  unfold conditionalLedger
  rw [ht,hg]

end SFT.InformationScience.MutualConditional
