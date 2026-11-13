import SFT.Materials.MaterialCarrier
import SFT.Physics.MechanicalDuration
import SFT.Mathematics.FoldScalar
namespace SFT.Materials.MaterialLoadHistory
open SFT.Physics.MechanicalEvents SFT.Physics.MechanicalDuration
open SFT.Mathematics.FoldScalar

-- MECH-FATIGUE-CREEP: retain the generated material, loading history,
-- damage/defect organization and declared temperature/time observations.
structure State (C : Type) where
 material : MaterialCarrier.Record C
 load : Scalar
 deformation : Scalar
 damageDefects : SFT.Host.Canonical.Value
 temperature : SFT.Host.Canonical.Value

structure Segment (C Clock : Type) where
 first : Event (State C)
 last : Event (State C)
 path : Path first last
 clock : Recurrence Clock
 boundary : SFT.Host.Canonical.Value

structure Cycle (C Clock : Type) extends Segment C Clock where
 nonempty : 0 < count path
 returnsLoad : last.carrier.load = first.carrier.load

structure Sustained (C Clock : Type) extends Segment C Clock where
 heldLoad : ∀ e, e ∈ events path → e.carrier.load = first.carrier.load

inductive Process (C Clock : Type) where
 | cyclic : Cycle C Clock → Process C Clock
 | sustained : Sustained C Clock → Process C Clock

def segment {C Clock : Type} : Process C Clock → Segment C Clock
 | .cyclic c => c.toSegment
 | .sustained s => s.toSegment

def rowChange {C : Type} (r : Row (State C)) : Scalar :=
 subtract r.after.carrier.deformation r.before.carrier.deformation

def transitionTable {C Clock : Type} (s : Segment C Clock) :=
 (changes s.path).map fun r => (r,rowChange r)

theorem completeTransitions {C Clock : Type} (s : Segment C Clock) :
 (transitionTable s).map Prod.fst = changes s.path := by
 unfold transitionTable
 generalize changes s.path = rows
 induction rows with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons head) ih

theorem actualDeformationChange {C : Type} (r : Row (State C)) :
 rowChange r = subtract r.after.carrier.deformation r.before.carrier.deformation := rfl

def duration {C Clock : Type} (s : Segment C Clock) := elapsed s.path s.clock

theorem exactTimeProvenance {C Clock : Type} (s : Segment C Clock)
 (h : 0 < count s.path) :
 count s.path * (positiveRatio s.path s.clock h).denominator =
 (positiveRatio s.path s.clock h).numerator * count s.clock.path :=
 exactRecurrenceRatio s.path s.clock h

theorem cycleReturnsLoad {C Clock : Type} (c : Cycle C Clock) :
 c.last.carrier.load = c.first.carrier.load := c.returnsLoad

theorem sustainedAtEveryEvent {C Clock : Type} (s : Sustained C Clock)
 (e : Event (State C)) (present : e ∈ events s.path) :
 e.carrier.load = s.first.carrier.load := s.heldLoad e present

theorem distinctProcesses {C Clock : Type} (c : Cycle C Clock) (s : Sustained C Clock) :
 Process.cyclic c ≠ Process.sustained s := by intro h; cases h

def record {C Clock : Type} (p : Process C Clock) :=
 (p,events (segment p).path,transitionTable (segment p),duration (segment p))

theorem fullSourceRecord {C Clock : Type} (p : Process C Clock) :
 (record p).1 = p := rfl

theorem allDamageTemperatureRecords {C Clock : Type} (p : Process C Clock) :
 (record p).2.1.map (fun e => (e.carrier.damageDefects,e.carrier.temperature,e.record)) =
 (events (segment p).path).map (fun e => (e.carrier.damageDefects,e.carrier.temperature,e.record)) := rfl

theorem fullEventCount {C Clock : Type} (p : Process C Clock) :
 (record p).2.1.length = count (segment p).path + 1 :=
 completeEventCount (segment p).path

theorem allActionsRetained {C Clock : Type} (p : Process C Clock) :
 (changes (segment p).path).map (fun r => (r.sourceIdentity,r.actionRecord)) =
 sourceRecords (segment p).path := allSourceRecordsRetained (segment p).path

def cycleRecords {C Clock : Type} (cs : List (Cycle C Clock)) :=
 cs.map (fun c => record (Process.cyclic c))

def recurrenceCount {C Clock : Type} (cs : List (Cycle C Clock)) := cs.length

theorem countedDamageHistory {C Clock : Type} (cs : List (Cycle C Clock)) :
 (cycleRecords cs).length = recurrenceCount cs := by
 induction cs with
 | nil => rfl
 | cons c cs ih => exact congrArg Nat.succ ih

theorem recurrenceSuccessor {C Clock : Type} (cs : List (Cycle C Clock)) (c : Cycle C Clock) :
 recurrenceCount (cs ++ [c]) = recurrenceCount cs + 1 :=
 SFT.Physics.ReferenceRealization.lengthAppendOne cs c

def records {C Clock : Type} (ps : List (Process C Clock)) := ps.map record

theorem base {C Clock : Type} (p : Process C Clock) : records [p] = [record p] := rfl

theorem successor {C Clock : Type} (ps : List (Process C Clock)) (p : Process C Clock) :
 records (ps ++ [p]) = records ps ++ [record p] := by
 induction ps with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih

end SFT.Materials.MaterialLoadHistory
