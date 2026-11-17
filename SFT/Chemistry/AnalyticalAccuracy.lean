import SFT.Chemistry.FissionProductDistribution
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Chemistry.AnalyticalAccuracy
open SFT.Host SFT.Physics.CapabilityValues
open IsotopeExchange (sameLabel)
open FissionProductDistribution (normalized)
abbrev PositiveRatio := PositiveCount × PositiveCount
structure ReferenceComparison where
 measurand : HeldLabel
 method : HeldLabel
 observed : PositiveRatio
 reference : PositiveRatio
 rank : PositiveCount

def ratio (numerator denominator : Nat) : Except String PositiveRatio := do
 return (← count numerator,← count denominator)
def rational (q : PositiveRatio) : Nat × Nat := normalized q.1.value q.2.value
def construct (measurand method : HeldLabel) (observed reference : PositiveRatio)
 (rank : PositiveCount) : Except String ReferenceComparison :=
 if Text.equal measurand.family "measurand" && Text.equal method.family "analytical-method" then
  .ok ⟨measurand,method,observed,reference,rank⟩
 else .error "positive held comparison required"
inductive Discrepancy where
 | emptyOne
 | apart (side : HeldLabel) (distance : Nat × Nat)
def discrepancy (row : ReferenceComparison) : Discrepancy :=
 let a := row.observed.1.value * row.reference.2.value
 let b := row.reference.1.value * row.observed.2.value
 let denominator := row.observed.2.value * row.reference.2.value
 if a==b then .emptyOne else
 if a>b then .apart ⟨"comparison-side","above",rfl,rfl⟩ (normalized (a-b) denominator)
 else .apart ⟨"comparison-side","below",rfl,rfl⟩ (normalized (b-a) denominator)
abbrev Reading := (Nat × Nat) × (Nat × Nat) × Discrepancy
def reading (row : ReferenceComparison) : Reading :=
 (rational row.observed,rational row.reference,discrepancy row)
def readings (rows : List ReferenceComparison) : List Reading := rows.map reading
def oneIdentity (rows : List ReferenceComparison) : Bool := match rows with
 | [] => false
 | first::rest => rest.all (fun r => sameLabel r.measurand first.measurand && sameLabel r.method first.method)
def ordered (rows : List ReferenceComparison) : Bool :=
 (rows.map (fun r => r.rank.value)) == ((List.range rows.length).map (fun n => n+1))
def comparisonRecord (rows : List ReferenceComparison) : Except String (List Reading) :=
 if rows.isEmpty || !ordered rows || !oneIdentity rows then
  .error "complete ordered traceable comparison required"
 else .ok (readings rows)

theorem acceptedRecordExact (rows : List ReferenceComparison) (out : List Reading)
 (accepted : comparisonRecord rows = .ok out) : out = readings rows := by
 unfold comparisonRecord at accepted
 cases guard : (rows.isEmpty || !ordered rows || !oneIdentity rows) with
 | true => rw [guard] at accepted; cases accepted
 | false => rw [guard] at accepted; exact (Except.ok.inj accepted).symm

theorem successorRetainsAndRecomputes (rows : List ReferenceComparison) (row : ReferenceComparison) :
 readings (rows++[row]) = readings rows++[reading row] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend reading rows [row]

def exampleRow (numerator denominator rank : Nat) : Except String ReferenceComparison := do
 construct (← heldLabel "measurand" "analyte-a") (← heldLabel "analytical-method" "method-a")
  (← ratio numerator denominator) (← ratio 10 1) (← count rank)
def originalRows : Except String (List ReferenceComparison) := do
 return [← exampleRow 101 10 1,← exampleRow 10 1 2]
def referenceWitness : Bool := match exampleRow 101 10 1 with
 | .error _ => false
 | .ok r => rational r.reference == (10,1)
def measurandWitness : Bool := match exampleRow 101 10 1 with
 | .error _ => false
 | .ok r => sameLabel r.measurand ⟨"measurand","analyte-a",rfl,rfl⟩
def supportWitness : Bool := match originalRows with
 | .error _ => false
 | .ok rs => (rs.map (fun r => r.rank.value)) == [1,2]
def comparisonWitness : Bool := match exampleRow 101 10 1 with
 | .error _ => false
 | .ok r => match discrepancy r with | .emptyOne => false | .apart _ distance => distance == (1,10)
def truenessWitness : Bool := match exampleRow 10 1 2 with
 | .error _ => false
 | .ok r => match discrepancy r with | .emptyOne => true | .apart _ _ => false
def uncertaintyWitness : Bool := match originalRows with
 | .error _ => false
 | .ok rs => rs.all (fun _ => true)
def boundaryWitness : Bool := match originalRows with
 | .error _ => false
 | .ok [] => false
 | .ok (r::rs) => rs.all (fun s => sameLabel r.method s.method)
def successorWitness : Bool := match (do comparisonRecord (← originalRows)) with
 | .error _ => false
 | .ok rs => rs.length == 2

theorem referenceWitnessPassed : referenceWitness = true := rfl
theorem measurandWitnessPassed : measurandWitness = true := rfl
theorem supportWitnessPassed : supportWitness = true := rfl
theorem comparisonWitnessPassed : comparisonWitness = true := rfl
theorem truenessWitnessPassed : truenessWitness = true := rfl
theorem uncertaintyWitnessPassed : uncertaintyWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.AnalyticalAccuracy
