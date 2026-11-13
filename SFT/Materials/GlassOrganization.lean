import SFT.Materials.Lattice
import SFT.Chemistry.MolecularCarrier
namespace SFT.Materials.GlassOrganization
open SFT.Physics

-- MATERIALS_OBLIGATIONS[63]: local recurrence and noncrystalline translation
-- are separate source distinctions. Neither is replaced by diffraction order.
structure Carrier where
 cells : CollectiveCoarseGrain.NetworkObservation
 word : String → List String
 connected : SFT.Chemistry.MolecularCarrier.connected cells.graph.nodes cells.graph.edges = true
 localRecurrence : String → MechanicalDuration.Recurrence (List String)
 localBound : ∀ x ∈ cells.graph.nodes, (localRecurrence x).first.carrier = word x

structure CrystallineTranslation (c : Carrier) where
 translation : Lattice.Record
 sameGraph : translation.cells.graph = c.cells.graph
 sameWord : ∀ x, translation.word x = c.word x
 moved : ∃ x ∈ c.cells.graph.nodes, translation.shift x ≠ x

-- Exactly the source's absence of a crystalline translation class.
def noncrystalline (c : Carrier) : Prop := ¬ Nonempty (CrystallineTranslation c)

structure Record (Clock : Type) where
 first : MechanicalEvents.Event Carrier
 last : MechanicalEvents.Event Carrier
 history : MechanicalEvents.Path first last
 glassBoundary : noncrystalline last.carrier
 clock : MechanicalDuration.Recurrence Clock
 preparation : SFT.Host.Canonical.Value
 relaxationObservation : SFT.Host.Canonical.Value

variable {Clock : Type}

theorem localStructureReturns (c : Carrier) (x : String) (held : x ∈ c.cells.graph.nodes) :
 (c.localRecurrence x).last.carrier = c.word x :=
 (c.localRecurrence x).returnsToCarrier.trans (c.localBound x held)

theorem translationWouldPreserveWord (c : Carrier) (t : CrystallineTranslation c)
 (x : String) (held : x ∈ c.cells.graph.nodes) : c.word (t.translation.shift x) = c.word x := by
 have member : x ∈ t.translation.cells.graph.nodes := t.sameGraph.symm ▸ held
 exact (t.sameWord _).symm.trans ((t.translation.wordRecurs x member).trans (t.sameWord x))

theorem noCrystallineClass (r : Record Clock) (t : CrystallineTranslation r.last.carrier) : False :=
 r.glassBoundary ⟨t⟩

theorem sourceClassExactly (c : Carrier) : noncrystalline c ↔ ∀ t : CrystallineTranslation c, False := by
 constructor
 · intro h t; exact h ⟨t⟩
 · intro h ⟨t⟩; exact h t

def elapsed (r : Record Clock) := MechanicalDuration.elapsed r.history r.clock

def macrostate (r : Record Clock) :=
 (r.last.carrier.cells.classes,r.preparation,r.relaxationObservation,elapsed r)

theorem exactObservationTime (r : Record Clock) (present : 0 < MechanicalEvents.count r.history) :
 MechanicalEvents.count r.history * (MechanicalDuration.positiveRatio r.history r.clock present).denominator =
 (MechanicalDuration.positiveRatio r.history r.clock present).numerator * MechanicalEvents.count r.clock.path :=
 MechanicalDuration.exactRecurrenceRatio r.history r.clock present

theorem allHistoryEvents (r : Record Clock) :
 (MechanicalEvents.events r.history).length = MechanicalEvents.count r.history+1 :=
 MechanicalEvents.completeEventCount r.history

theorem allHistoryActions (r : Record Clock) :
 (MechanicalEvents.changes r.history).map (fun row => (row.sourceIdentity,row.actionRecord)) =
 MechanicalEvents.sourceRecords r.history := MechanicalEvents.allSourceRecordsRetained r.history

theorem completeMacroClass (r : Record Clock) (label : String) (members : List String)
 (held : (label,members) ∈ r.last.carrier.cells.classes) :
 members = CollectiveCoarseGrain.region r.last.carrier.cells label :=
 CollectiveCoarseGrain.everyClassIsCompleteFibre r.last.carrier.cells label members held

def record (r : Record Clock) := (r,macrostate r,MechanicalEvents.events r.history,MechanicalEvents.changes r.history)

theorem wholeInputRetained (r : Record Clock) : (record r).1 = r := rfl

theorem preparationDistinguished (r s : Record Clock) (different : r.preparation ≠ s.preparation) :
 macrostate r ≠ macrostate s := fun equal => different (congrArg (fun x => x.2.1) equal)

theorem relaxationDistinguished (r s : Record Clock)
 (different : r.relaxationObservation ≠ s.relaxationObservation) :
 macrostate r ≠ macrostate s := fun equal => different (congrArg (fun x => x.2.2.1) equal)

def records (rs : List (Record Clock)) := rs.map record

theorem base (r : Record Clock) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Clock)) (r : Record Clock) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.GlassOrganization
