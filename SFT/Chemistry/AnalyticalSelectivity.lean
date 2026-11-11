import SFT.Chemistry.AnalyticalCalibration
namespace SFT.Chemistry.AnalyticalSelectivity
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects

structure ResponseRow (portion : AnalyticalSample.Portion) (Response : Type) where
 component : AnalyticalSample.Component
 componentHeld : component∈portion.rows
 response : Response
 source : SFT.Host.Canonical.Value

structure Observation (portion : AnalyticalSample.Portion) (Response : Type) where
 analyte : ResponseRow portion Response
 analyteRole : AnalyticalSample.isAnalyte analyte.component=true
 interferents : List (ResponseRow portion Response)
 method : SFT.Physics.CapabilityValues.HeldLabel
 conditions : SFT.Host.Canonical.Value

variable {portion : AnalyticalSample.Portion} {R : Type}

def distinguishable [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) : Bool :=
 decide (o.analyte.response≠row.response)

structure Comparison (portion : AnalyticalSample.Portion) (Response : Type) where
 analyte : ResponseRow portion Response
 interferent : ResponseRow portion Response
 distinguished : Bool
 method : SFT.Physics.CapabilityValues.HeldLabel
 conditions : SFT.Host.Canonical.Value

def compare [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) : Comparison portion R :=
 ⟨o.analyte,row,distinguishable o row,o.method,o.conditions⟩

def comparisons [DecidableEq R] (o : Observation portion R) := o.interferents.map (compare o)
def selective [DecidableEq R] (o : Observation portion R) := o.interferents.all (distinguishable o)
def interference [DecidableEq R] (o : Observation portion R) :=
 o.interferents.filter (fun row => !distinguishable o row)

theorem exactDistinguishability [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) :
 distinguishable o row=true ↔ o.analyte.response≠row.response := by
 constructor
 · exact of_decide_eq_true
 · exact decide_eq_true

theorem mergedExactly [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) :
 (!distinguishable o row)=true ↔ o.analyte.response=row.response := by
 by_cases same : o.analyte.response=row.response
 · have rejected : distinguishable o row=false := by unfold distinguishable; rw [same]; exact decide_eq_false (fun h => h rfl)
   rw [rejected]
   exact ⟨fun _ => same,fun _ => rfl⟩
 · have admitted := (exactDistinguishability o row).mpr same
   rw [admitted]
   constructor
   · intro impossible; cases impossible
   · intro impossible; exact False.elim (same impossible)

theorem selectiveExactly [DecidableEq R] (o : Observation portion R) :
 selective o=true ↔ ∀ row∈o.interferents, o.analyte.response≠row.response := by
 constructor
 · intro checked row held
   exact (exactDistinguishability o row).mp ((allTrueIffMembers _ _).mp checked row held)
 · intro complete
   exact (allTrueIffMembers _ _).mpr (fun row held => (exactDistinguishability o row).mpr (complete row held))

theorem interferenceExactly [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) :
 row∈interference o ↔ row∈o.interferents ∧ o.analyte.response=row.response := by
 constructor
 · intro held
   have h := (filterMemberIff _ _ _).mp held
   exact ⟨h.1,(mergedExactly o row).mp h.2⟩
 · intro held
   exact (filterMemberIff _ _ _).mpr ⟨held.1,(mergedExactly o row).mpr held.2⟩

theorem everyComparisonHeld [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R)
 (held : row∈o.interferents) : compare o row∈comparisons o := memMap _ _ _ held

theorem noInventedComparison [DecidableEq R] (o : Observation portion R) (comparison : Comparison portion R)
 (held : comparison∈comparisons o) : ∃ row∈o.interferents, compare o row=comparison := memMapPreimage _ _ _ held

theorem completeComparisonCount [DecidableEq R] (o : Observation portion R) :
 (comparisons o).length=o.interferents.length := SFT.Foundation.CommonRefinement.mapLength _ _

theorem comparisonBound [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) :
 (compare o row).analyte=o.analyte ∧ (compare o row).interferent=row ∧
 (compare o row).method=o.method ∧ (compare o row).conditions=o.conditions := ⟨rfl,rfl,rfl,rfl⟩

theorem failedComparisonRetained [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R)
 (held : row∈o.interferents) (merged : o.analyte.response=row.response) :
 compare o row∈comparisons o ∧ row∈interference o :=
 ⟨everyComparisonHeld o row held,(interferenceExactly o row).mpr ⟨held,merged⟩⟩

theorem mergedResponseRejectsSelectivity [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R)
 (held : row∈o.interferents) (merged : o.analyte.response=row.response) : selective o≠true :=
 fun selected => (selectiveExactly o).mp selected row held merged

def append (o : Observation portion R) (row : ResponseRow portion R) : Observation portion R :=
 {o with interferents:=o.interferents++[row]}

theorem appendedDecisionUnchanged [DecidableEq R] (o : Observation portion R) (new old : ResponseRow portion R) :
 distinguishable (append o new) old=distinguishable o old := rfl

theorem appendComparisons [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) :
 comparisons (append o row)=comparisons o++[compare o row] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend (compare o) o.interferents [row]

theorem priorComparisonRetained [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R)
 (prior : Comparison portion R) (held : prior∈comparisons o) : prior∈comparisons (append o row) := by
 rw [appendComparisons]
 exact memAppendLeft _ _ _ held

theorem priorInterferenceRetained [DecidableEq R] (o : Observation portion R) (new old : ResponseRow portion R)
 (held : old∈interference o) : old∈interference (append o new) := by
 have h := (interferenceExactly o old).mp held
 exact (interferenceExactly _ _).mpr ⟨memAppendLeft _ _ _ h.1,h.2⟩

theorem appendSelectivityExactly [DecidableEq R] (o : Observation portion R) (row : ResponseRow portion R) :
 selective (append o row)=true ↔ selective o=true ∧ o.analyte.response≠row.response := by
 constructor
 · intro selected
   have all := (selectiveExactly _).mp selected
   exact ⟨(selectiveExactly o).mpr (fun prior held => all prior (memAppendLeft _ _ _ held)),
    all row (memAppendRight _ _ _ (.head []))⟩
 · intro both
   apply (selectiveExactly _).mpr
   intro prior held
   cases memAppendCases prior o.interferents [row] held with
   | inl old => exact (selectiveExactly o).mp both.1 prior old
   | inr new => cases new with
     | head => exact both.2
     | tail _ impossible => cases impossible

def base (analyte interferent : ResponseRow portion R)
 (role : AnalyticalSample.isAnalyte analyte.component=true)
 (method : SFT.Physics.CapabilityValues.HeldLabel) (conditions : SFT.Host.Canonical.Value) : Observation portion R :=
 ⟨analyte,role,[interferent],method,conditions⟩

theorem baseDecision [DecidableEq R] (analyte interferent : ResponseRow portion R)
 (role : AnalyticalSample.isAnalyte analyte.component=true)
 (method : SFT.Physics.CapabilityValues.HeldLabel) (conditions : SFT.Host.Canonical.Value) :
 selective (base analyte interferent role method conditions)=true ↔ analyte.response≠interferent.response := by
 constructor
 · intro h
   exact (selectiveExactly _).mp h interferent (.head [])
 · intro different
   apply (selectiveExactly _).mpr
   intro row held
   cases held with
   | head => exact different
   | tail _ impossible => cases impossible

theorem appendPreservesBoundary (o : Observation portion R) (row : ResponseRow portion R) :
 (append o row).analyte=o.analyte ∧ (append o row).method=o.method ∧
 (append o row).conditions=o.conditions := ⟨rfl,rfl,rfl⟩

end SFT.Chemistry.AnalyticalSelectivity
