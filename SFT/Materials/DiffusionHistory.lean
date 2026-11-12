import SFT.Materials.Lattice
import SFT.Physics.ThermoKineticTransport
namespace SFT.Materials.DiffusionHistory
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
variable {Label : Type}
abbrev State (Label : Type) := List (String × Label)

def content (state : State Label) := state.map Prod.snd

def supported (lattice : Lattice.Record) (state : State Label) : Prop :=
 ∀ row, row ∈ state → row.1 ∈ lattice.cells.graph.nodes

-- One retained occurrence moves along an actual generated adjacency.
structure Move (lattice : Lattice.Record) (Label : Type) where
 beforeRows : State Label
 afterRows : State Label
 source : String
 destination : String
 label : Label
 adjacent : (source,destination) ∈ lattice.cells.graph.edges
 destinationHeld : destination ∈ lattice.cells.graph.nodes
 provenance : SFT.Host.Canonical.Value

def before {lattice : Lattice.Record} (move : Move lattice Label) : State Label :=
 move.beforeRows ++ (move.source,move.label)::move.afterRows

def after {lattice : Lattice.Record} (move : Move lattice Label) : State Label :=
 move.beforeRows ++ (move.destination,move.label)::move.afterRows

theorem oneMoveConserves {lattice : Lattice.Record} (move : Move lattice Label) : content (before move)=content (after move) := by
 unfold before after content
 induction move.beforeRows with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons row.2) ih

theorem oneMoveSupported {lattice : Lattice.Record} (move : Move lattice Label)
 (prior : supported lattice (before move)) : supported lattice (after move) := by
 intro row held
 cases memAppendCases row move.beforeRows ((move.destination,move.label)::move.afterRows) held with
 | inl h => exact prior row (memAppendLeft _ _ _ h)
 | inr h =>
   cases h with
   | head => exact move.destinationHeld
   | tail _ h => exact prior row (memAppendRight _ _ _ (.tail _ h))

inductive Run (lattice : Lattice.Record) : State Label → State Label → List (Move lattice Label) → Prop where
 | initial (state : State Label) : Run lattice state state []
 | append {start finish : State Label} {history : List (Move lattice Label)}
     (prior : Run lattice start finish history) (move : Move lattice Label)
     (joined : finish=before move) : Run lattice start (after move) (history++[move])

theorem completeContentConserved {lattice : Lattice.Record} {start finish : State Label}
 {history : List (Move lattice Label)} (run : Run lattice start finish history) : content start=content finish := by
 induction run with
 | initial => rfl
 | append prior move joined ih => exact ih.trans ((congrArg content joined).trans (oneMoveConserves move))

theorem completeSupportRetained {lattice : Lattice.Record} {start finish : State Label}
 {history : List (Move lattice Label)} (run : Run lattice start finish history)
 (initial : supported lattice start) : supported lattice finish := by
 induction run with
 | initial => exact initial
 | append prior move joined ih => exact oneMoveSupported move (joined ▸ ih)

theorem allContentObservationsConserved {lattice : Lattice.Record} {start finish : State Label}
 {history : List (Move lattice Label)} (run : Run lattice start finish history)
 {Result : Type} (observe : List Label → Result) : observe (content start)=observe (content finish) :=
 congrArg observe (completeContentConserved run)

def transitionRecord {lattice : Lattice.Record} (move : Move lattice Label) :=
 (move.source,move.destination,move.label,move.provenance,before move,after move)

def records {lattice : Lattice.Record} (history : List (Move lattice Label)) := history.map transitionRecord

theorem everyTransitionRecorded {lattice : Lattice.Record} (history : List (Move lattice Label))
 (move : Move lattice Label) (held : move ∈ history) : transitionRecord move ∈ records history := memMap _ _ _ held

theorem exactTransitionCount {lattice : Lattice.Record} (history : List (Move lattice Label)) :
 (records history).length=history.length := mapLength _ _

theorem successorRetainsRecords {lattice : Lattice.Record} (history : List (Move lattice Label)) (move : Move lattice Label) :
 records (history++[move])=records history++[transitionRecord move] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem successorCount {lattice : Lattice.Record} (history : List (Move lattice Label)) (move : Move lattice Label) :
 (records (history++[move])).length=history.length+1 := by
 rw [exactTransitionCount,appendLength]
 rfl

structure Observation (Label : Type) where
 lattice : Lattice.Record
 start : State Label
 finish : State Label
 first : Move lattice Label
 rest : List (Move lattice Label)
 run : Run lattice start finish (first::rest)
 initialSupport : supported lattice start
 clock : List String
 clockPresent : 0 < clock.length
 boundary : String
 provenance : SFT.Host.Canonical.Value

def recurrence (o : Observation Label) :=
 SFT.Mathematics.ExactRatioRelations.ratio (o.first::o.rest).length o.clock.length
 (Nat.zero_lt_succ _) o.clockPresent

theorem exactDeclaredRecurrence (o : Observation Label) :
 (o.first::o.rest).length*(recurrence o).denominator=(recurrence o).numerator*o.clock.length :=
 SFT.Mathematics.ExactRatioRelations.ratioValue _ _ _ _

def observationRecord (o : Observation Label) :=
 (o.start,o.finish,records (o.first::o.rest),o.clock,o.boundary,o.provenance)

theorem observationConserves (o : Observation Label) : content o.start=content o.finish := completeContentConserved o.run

theorem observationSupported (o : Observation Label) : supported o.lattice o.finish := completeSupportRetained o.run o.initialSupport
end SFT.Materials.DiffusionHistory
