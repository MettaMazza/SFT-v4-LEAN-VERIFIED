import SFT.Chemistry.AnalyticalAccuracy
namespace SFT.Chemistry.AnalyticalPrecision
open SFT.Host SFT.Physics.CapabilityValues
open AnalyticalAccuracy (PositiveRatio rational ratio)
open FissionProductDistribution (normalized)
set_option maxHeartbeats 100000000

inductive Distance where
 | emptyOne
 | apart (value : Nat × Nat)
def distance (a b : PositiveRatio) : Distance :=
 let left := a.1.value*b.2.value
 let right := b.1.value*a.2.value
 if left==right then .emptyOne
 else .apart (normalized (if left>right then left-right else right-left) (a.2.value*b.2.value))
def pairRows : List PositiveRatio → List (PositiveRatio × PositiveRatio)
 | [] => []
 | first::rest => rest.map (fun other => (first,other)) ++ pairRows rest
def pairDistances (values : List PositiveRatio) : List Distance :=
 (pairRows values).map (fun row => distance row.1 row.2)
def smaller (a b : PositiveRatio) : PositiveRatio :=
 if a.1.value*b.2.value < b.1.value*a.2.value then a else b
def larger (a b : PositiveRatio) : PositiveRatio :=
 if a.1.value*b.2.value > b.1.value*a.2.value then a else b
def extremes (first : PositiveRatio) (rest : List PositiveRatio) : PositiveRatio × PositiveRatio :=
 (rest.foldl smaller first,rest.foldl larger first)
structure Record where
 values : List PositiveRatio
 distances : List Distance
 spread : Distance

def replicateRecord (sample method condition : HeldLabel) (values : List PositiveRatio) : Except String Record :=
 if !Text.equal sample.family "analytical-sample" || !Text.equal method.family "analytical-method" ||
    !Text.equal condition.family "repeatability-condition" then
  .error "positive same-condition replicate support required"
 else match values with
 | [] => .error "positive same-condition replicate support required"
 | first::rest =>
  let bounds := extremes first rest
  .ok ⟨values,pairDistances values,distance bounds.2 bounds.1⟩

-- The input adapter enforces the source's positivity guard at the record call.
-- The admitted carrier contains exactly positive rational replicates.
def replicateFromCounts (sample method condition : HeldLabel) (values : List (Nat × Nat)) : Except String Record := do
 if values.any (fun q => q.1==0 || q.2==0) then
  throw "positive same-condition replicate support required"
 let readings ← values.mapM (fun q => ratio q.1 q.2)
 replicateRecord sample method condition readings

theorem pairRowsNil : pairRows [] = [] := rfl
theorem pairRowsCons (first : PositiveRatio) (rest : List PositiveRatio) :
 pairRows (first::rest) = rest.map (fun other => (first,other)) ++ pairRows rest := rfl

theorem pairRowsSuccessor (first last : PositiveRatio) (rest : List PositiveRatio) :
 pairRows ((first::rest)++[last]) =
 (rest.map (fun other => (first,other))++[(first,last)]) ++ pairRows (rest++[last]) := by
 change (rest++[last]).map (fun other => (first,other)) ++ pairRows (rest++[last]) = _
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 rfl

def pairCount : Nat → Nat
 | 0 => 0
 | n+1 => n+pairCount n

theorem pairRowsCount (values : List PositiveRatio) :
 (pairRows values).length = pairCount values.length := by
 induction values with
 | nil => rfl
 | cons first rest ih =>
  change ((rest.map (fun other => (first,other))) ++ pairRows rest).length = rest.length + pairCount rest.length
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.mapLength,ih]

theorem pairDistancesExact (values : List PositiveRatio) :
 pairDistances values = (pairRows values).map (fun row => distance row.1 row.2) := rfl

theorem replicateRetainsValues (sample method condition : HeldLabel) (values : List PositiveRatio)
 (record : Record) (accepted : replicateRecord sample method condition values = .ok record) :
 record.values = values ∧ record.distances = pairDistances values := by
 unfold replicateRecord at accepted
 split at accepted
 · cases accepted
 · cases values with
   | nil => cases accepted
   | cons first rest => cases accepted; exact ⟨rfl,rfl⟩

def sample : HeldLabel := ⟨"analytical-sample","s",rfl,rfl⟩
def method : HeldLabel := ⟨"analytical-method","m",rfl,rfl⟩
def condition : HeldLabel := ⟨"repeatability-condition","same",rfl,rfl⟩
def originalValues : Except String (List PositiveRatio) := do
 return [← ratio 10 1,← ratio 101 10,← ratio 99 10]
def originalRecord : Except String Record := do
 replicateRecord sample method condition (← originalValues)
def identityWitness : Bool := Text.equal sample.label "s"
def conditionsWitness : Bool := Text.equal condition.label "same"
def supportWitness : Bool := (originalRecord.toOption.map (fun r => r.values.length==3)).getD false
def comparisonWitness : Bool := (originalRecord.toOption.map (fun r => r.distances.length==3)).getD false
def spreadWitness : Bool := (originalRecord.toOption.map (fun r => match r.spread with
 | .emptyOne => false | .apart q => q==(1,5))).getD false
def distanceValue : Distance → SFT.Host.Canonical.Value
 | .emptyOne => .array [.text "emptyOne"]
 | .apart q => .array [.integer (.ofNat q.1),.integer (.ofNat q.2)]
def recordFields (r : Record) : List SFT.Host.Canonical.Value :=
 [.array (r.values.map fun q => let p := rational q; .array [.integer (.ofNat p.1),.integer (.ofNat p.2)]),
  .array (r.distances.map distanceValue),distanceValue r.spread]
def classWitness : Bool := (originalRecord.toOption.map (fun r => (recordFields r).length==3)).getD false
def adverseWitness : Bool := (originalValues.toOption.map (fun values => match values with
 | [] => false | first::rest => rational (extremes first rest).1 == (99,10))).getD false
def successorWitness : Except String Bool := do
 let values ← originalValues
 let next ← ratio 10 1
 return (← replicateRecord sample method condition (values++[next])).distances.length==6

theorem identityPassed : identityWitness = true := rfl
theorem conditionsPassed : conditionsWitness = true := rfl
theorem supportPassed : supportWitness = true := rfl
theorem comparisonPassed : comparisonWitness = true := rfl
theorem spreadPassed : spreadWitness = true := rfl
theorem classPassed : classWitness = true := rfl
theorem adversePassed : adverseWitness = true := rfl
theorem successorPassed : successorWitness = .ok true := rfl
end SFT.Chemistry.AnalyticalPrecision
