import SFT.Materials.MaterialCarrier
import SFT.Host.Canonical
namespace SFT.Materials.PropertyContext
open SFT.Host.Canonical

-- MATERIALS_OBLIGATIONS[5]: the entire conditional observation boundary.
structure Boundary (C : Type) where
 material : MaterialCarrier.Record C
 direction : Value
 scale : Value
 history : List Value
 method : Value

structure Record (C : Type) where
 boundary : Boundary C
 relation : List (Value × Value)

variable {C : Type}

theorem boundaryExactly (a b : Boundary C) : a=b ↔
 a.material=b.material ∧ a.direction=b.direction ∧ a.scale=b.scale ∧
 a.history=b.history ∧ a.method=b.method := by
 constructor
 · intro h; cases h; exact ⟨rfl,rfl,rfl,rfl,rfl⟩
 · cases a; cases b
   intro ⟨hm,hd,hs,hh,ht⟩
   cases hm; cases hd; cases hs; cases hh; cases ht; rfl

def append (record : Record C) (observation : Value × Value) : Record C :=
 {record with relation := record.relation++[observation]}

theorem boundaryRetained (record : Record C) (observation : Value × Value) :
 (append record observation).boundary=record.boundary := rfl

theorem relationRetained (record : Record C) (observation prior : Value × Value)
 (held : prior∈record.relation) : prior∈(append record observation).relation := List.mem_append_left _ held

def prior (record : Record C) : Record C :=
 {record with relation := SFT.Chemistry.EntityIdentity.priorCoordinates record.relation}

theorem recovery (record : Record C) (observation : Value × Value) :
 prior (append record observation)=record := by
 cases record with
 | mk boundary relation =>
   change Record.mk boundary (SFT.Chemistry.EntityIdentity.priorCoordinates (relation++[observation])) = _
   rw [SFT.Chemistry.EntityIdentity.priorCoordinatesExact]

def appendMany : Record C → List (Value × Value) → Record C
 | record, [] => record
 | record, observation::rest => appendMany (append record observation) rest

theorem finiteBoundaryRetention (record : Record C) (observations : List (Value × Value)) :
 (appendMany record observations).boundary=record.boundary := by
 induction observations generalizing record with
 | nil => rfl
 | cons first rest ih => exact ih (append record first)

theorem finiteRelationRetention (record : Record C) (observations : List (Value × Value))
 (row : Value × Value) (held : row∈record.relation) : row∈(appendMany record observations).relation := by
 induction observations generalizing record with
 | nil => exact held
 | cons first rest ih => exact ih (append record first) (relationRetained record first row held)

theorem differentBoundaryDistinguished (a b : Record C) (different : a.boundary≠b.boundary) : a≠b :=
 fun same => different (congrArg Record.boundary same)
end SFT.Materials.PropertyContext
