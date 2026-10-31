import SFT.Physics.CosmoExpansion
namespace SFT.Physics.CosmoBackground

inductive Contribution (Observation : Type) where
 | foreground : Observation → Contribution Observation
 | background : Observation → Contribution Observation

def observation {Observation : Type} : Contribution Observation → Observation
 | .foreground value => value
 | .background value => value

def foregrounds {Observation : Type} : List (Contribution Observation) → List Observation
 | [] => []
 | .foreground value::rest => value::foregrounds rest
 | .background _::rest => foregrounds rest

def backgrounds {Observation : Type} : List (Contribution Observation) → List Observation
 | [] => []
 | .foreground _::rest => backgrounds rest
 | .background value::rest => value::backgrounds rest

theorem everyObservationAccountedFor {Observation : Type} (rows : List (Contribution Observation)) :
 (foregrounds rows).length+(backgrounds rows).length=rows.length := by
 induction rows with
 | nil => rfl
 | cons row rest ih =>
  cases row with
  | foreground value => exact (Nat.succ_add _ _).trans (congrArg Nat.succ ih)
  | background value => exact (Nat.add_succ _ _).trans (congrArg Nat.succ ih)

theorem backgroundMembership {Observation : Type} (rows : List (Contribution Observation)) (value : Observation) :
 value ∈ backgrounds rows ↔ Contribution.background value ∈ rows := by
 induction rows with
 | nil => constructor <;> intro h <;> cases h
 | cons row rest ih =>
  cases row with
  | foreground other =>
   constructor
   · intro h; exact List.Mem.tail _ (ih.mp h)
   · intro h; cases h with | tail _ h => exact ih.mpr h
  | background other =>
   constructor
   · intro h; cases h with
     | head => exact List.Mem.head _
     | tail _ h => exact List.Mem.tail _ (ih.mp h)
   · intro h; cases h with
     | head => exact List.Mem.head _
     | tail _ h => exact List.Mem.tail _ (ih.mpr h)

structure Cell (Observation : Type) where
 direction : String
 frequency : String
 completeContributions : List (Contribution Observation)
 thermalClass : String

def fullSupport (directions frequencies : List String) := directions.flatMap (fun d => frequencies.map (fun f => (d,f)))

structure Field (Observation : Type) where
 directions : List String
 frequencies : List String
 cells : List (Cell Observation)
 present : cells ≠ []
 complete : cells.map (fun row => (row.direction,row.frequency))=fullSupport directions frequencies

-- The thermal-class reading is retained observation data. The law identifies
-- invariance across the complete declared support; it does not fit that class.
def frequencyInvariant {Observation : Type} (field : Field Observation) (thermal : String) : Prop :=
 ∀ row ∈ field.cells, row.thermalClass=thermal

theorem invariantClassUnique {Observation : Type} (field : Field Observation) (first second : String)
 (hfirst : frequencyInvariant field first) (hsecond : frequencyInvariant field second) : first=second := by
 cases eq : field.cells with
 | nil => exact False.elim (field.present eq)
 | cons row rest =>
  have member : row ∈ field.cells := by rw [eq]; exact List.Mem.head _
  exact (hfirst row member).symm.trans (hsecond row member)

theorem noDeclaredDirectionFrequencyOmitted {Observation : Type} (field : Field Observation) :
 field.cells.map (fun row => (row.direction,row.frequency))=fullSupport field.directions field.frequencies := field.complete

theorem foregroundSeparationKeepsEveryRecord {Observation : Type} (row : Cell Observation) :
 (foregrounds row.completeContributions).length+(backgrounds row.completeContributions).length=row.completeContributions.length :=
 everyObservationAccountedFor _

theorem discordantCellExcludesBackgroundClass {Observation : Type} (field : Field Observation) (thermal : String)
 (row : Cell Observation) (member : row ∈ field.cells) (different : row.thermalClass ≠ thermal) : ¬ frequencyInvariant field thermal :=
 fun same => different (same row member)
abbrev SourceField (Emission Observation SourceClock ObserverClock Cell Carrier : Type) :=
 Field (CosmoRedshift.Record Emission Observation SourceClock ObserverClock Cell Carrier)

theorem sourceObservationCausal {Emission Observation SourceClock ObserverClock Cell Carrier : Type}
 (record : CosmoRedshift.Record Emission Observation SourceClock ObserverClock Cell Carrier) :
 ∀ step ∈ MechanicalEvents.changes (FieldLocality.trace record.path), record.adjacent step.before step.after :=
 CosmoRedshift.everyPathStepCausal record

end SFT.Physics.CosmoBackground
