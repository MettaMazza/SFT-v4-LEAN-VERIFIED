import SFT.Physics.MechanicalConservation
namespace SFT.Physics.FieldSourceResponse
open MechanicalEvents

structure Source (Carrier State : Type) where
  observation : QuantityCarrier.Observation Carrier
  location : Event State

structure Response {Carrier State : Type} (source : Source Carrier State) (Cell Value : Type) where
  cell : Cell
  observation : QuantityCarrier.Observation Value
  location : Event State
  propagation : Path source.location location

structure Field {Carrier State : Type} (source : Source Carrier State) (Cell Value : Type) where
  support : List Cell
  responses : List (Response source Cell Value)
  complete : responses.map Response.cell = support

def generated {Carrier State Cell Value : Type} (source : Source Carrier State)
    (support : List Cell) (respond : (cell : Cell) → Response source Cell Value)
    (retains : ∀ cell, (respond cell).cell = cell) : Field source Cell Value :=
  ⟨support,support.map respond,by
    induction support with
    | nil => rfl
    | cons c cs ih =>
      change (respond c).cell :: (cs.map respond).map Response.cell = c :: cs
      rw [retains c,ih]⟩

theorem completeSupport {Carrier State Cell Value : Type} {s : Source Carrier State}
    (f : Field s Cell Value) : f.responses.map Response.cell = f.support := f.complete

theorem responseCount {Carrier State Cell Value : Type} {s : Source Carrier State}
    (f : Field s Cell Value) : f.responses.length = f.support.length := by
  have lengths (rs : List (Response s Cell Value)) : (rs.map Response.cell).length = rs.length := by
    induction rs with
    | nil => rfl
    | cons r rs ih => exact congrArg Nat.succ ih
  exact (lengths f.responses).symm.trans (congrArg List.length f.complete)

def appendResponse {Carrier State Cell Value : Type} {s : Source Carrier State}
    (f : Field s Cell Value) (response : Response s Cell Value) : Field s Cell Value :=
  ⟨f.support ++ [response.cell],f.responses ++ [response],by
    rw [ReferenceRealization.mapAppendOne,f.complete]⟩

theorem successorRetainsAllResponses {Carrier State Cell Value : Type} {s : Source Carrier State}
    (f : Field s Cell Value) (response : Response s Cell Value) :
    (appendResponse f response).responses = f.responses ++ [response] := rfl

theorem successorRetainsSupport {Carrier State Cell Value : Type} {s : Source Carrier State}
    (f : Field s Cell Value) (response : Response s Cell Value) :
    (appendResponse f response).support = f.support ++ [response.cell] := rfl

theorem noOmittedCell {Carrier State Cell Value : Type} {s : Source Carrier State}
    (f : Field s Cell Value) (cell : Cell) (present : cell ∈ f.support) :
    cell ∈ f.responses.map Response.cell := by rw [f.complete]; exact present

theorem noUngeneratedCell {Carrier State Cell Value : Type} {s : Source Carrier State}
    (f : Field s Cell Value) (cell : Cell) (present : cell ∈ f.responses.map Response.cell) :
    cell ∈ f.support := by rw [← f.complete]; exact present

theorem sourceTraceRetained {Carrier State Cell Value : Type} {s : Source Carrier State}
    (r : Response s Cell Value) :
    (changes r.propagation).map (fun row => (row.sourceIdentity,row.actionRecord)) = sourceRecords r.propagation :=
  allSourceRecordsRetained _

theorem fullObservedPropagation {Carrier State Cell Value : Type} {s : Source Carrier State}
    (r : Response s Cell Value) : (events r.propagation).length = count r.propagation + 1 := completeEventCount _

theorem changedResponseDistinguished {Carrier State Cell Value : Type} {s : Source Carrier State}
    (a b : Response s Cell Value) (h : a.observation ≠ b.observation) : a ≠ b :=
  fun same => h (congrArg Response.observation same)

theorem changedCellDistinguished {Carrier State Cell Value : Type} {s : Source Carrier State}
    (a b : Response s Cell Value) (h : a.cell ≠ b.cell) : a ≠ b := fun same => h (congrArg Response.cell same)

end SFT.Physics.FieldSourceResponse
