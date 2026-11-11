import SFT.Chemistry.PeriodicRecurrenceTrace
namespace SFT.Chemistry.GroupPeriodCoordinates
open PeriodicRecurrenceTrace

-- V3 GROUP_PERIOD: each closure-to-reopening step retains its return and
-- subsequent distinct outer class; depth counts these generated witnesses.
structure Reopening (observations : List (Outer → List String)) where
 earlier : Outer
 closed : Outer
 reopened : Outer
 closure : returns observations earlier closed
 successor : PeriodicOrderTrace.coordinate reopened.row = PeriodicOrderTrace.coordinate closed.row + 1
 distinction : ¬ equivalent observations closed reopened

structure Coordinate (observations : List (Outer → List String)) where
 element : Outer
 first : Reopening observations
 further : List (Reopening observations)

def group (observations : List (Outer → List String)) (coordinate : Coordinate observations) (member : Outer) : Prop :=
 equivalent observations coordinate.element member

def depth {observations : List (Outer → List String)} (coordinate : Coordinate observations) : Nat :=
 1 + coordinate.further.length

def extend {observations : List (Outer → List String)} (coordinate : Coordinate observations)
 (next : Reopening observations) : Coordinate observations :=
 { coordinate with element := next.reopened, further := coordinate.further ++ [next] }

theorem groupExactly (observations : List (Outer → List String)) (coordinate : Coordinate observations) (member : Outer) :
 group observations coordinate member ↔ ledger observations coordinate.element = ledger observations member :=
 (completeTraceExactly _ _ _).symm

theorem completeClass (observations : List (Outer → List String)) (coordinate : Coordinate observations) :
 group observations coordinate coordinate.element := equivalentReflexive _ _

theorem positiveDepth {observations : List (Outer → List String)} (coordinate : Coordinate observations) : 0 < depth coordinate :=
 by
 unfold depth
 rw [Nat.add_comm]
 exact Nat.zero_lt_succ _

theorem firstDepth (observations : List (Outer → List String)) (first : Reopening observations) :
 depth (⟨first.reopened,first,[]⟩ : Coordinate observations) = 1 := rfl

theorem successorDepth {observations : List (Outer → List String)} (coordinate : Coordinate observations)
 (next : Reopening observations) : depth (extend coordinate next) = depth coordinate + 1 := by
 unfold depth extend
 rw [SFT.Foundation.CommonRefinement.appendLength]
 exact (Nat.add_assoc _ _ _).symm

theorem preservesClosures {observations : List (Outer → List String)} (coordinate : Coordinate observations)
 (next prior : Reopening observations) (held : prior ∈ coordinate.further) : prior ∈ (extend coordinate next).further :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem retainsFirstClosure {observations : List (Outer → List String)} (coordinate : Coordinate observations)
 (next : Reopening observations) : (extend coordinate next).first = coordinate.first := rfl

theorem predecessorOrder {observations : List (Outer → List String)} (step : Reopening observations) :
 PeriodicOrderTrace.coordinate step.closed.row < PeriodicOrderTrace.coordinate step.reopened.row := by
 rw [step.successor]
 exact Nat.lt_succ_self _

theorem witnessedReturn {observations : List (Outer → List String)} (step : Reopening observations) :
 ledger observations step.earlier = ledger observations step.closed := (completeTraceExactly _ _ _).mpr step.closure.2

theorem reopeningDistinguished {observations : List (Outer → List String)} (step : Reopening observations) :
 ledger observations step.closed ≠ ledger observations step.reopened := fun h => step.distinction ((completeTraceExactly _ _ _).mp h)

-- A page drawing is attached metadata. Neither component reads it.
structure Drawn (observations : List (Outer → List String)) where
 coordinate : Coordinate observations
 page : String

def redraw {observations : List (Outer → List String)} (drawn : Drawn observations) (page : String) : Drawn observations :=
 {drawn with page := page}

theorem layoutIndependent {observations : List (Outer → List String)} (drawn : Drawn observations) (page : String) :
 (redraw drawn page).coordinate = drawn.coordinate := rfl

-- A successor between reopening events changes the element, not the counted depth.
def advance {observations : List (Outer → List String)} (coordinate : Coordinate observations)
 (next : Outer) : Coordinate observations := {coordinate with element := next}

inductive History (observations : List (Outer → List String)) : Coordinate observations → Type where
 | first (opening : Reopening observations) : History observations ⟨opening.reopened,opening,[]⟩
 | next {prior : Coordinate observations} (history : History observations prior) (next : Outer)
   (successor : PeriodicOrderTrace.coordinate next.row = PeriodicOrderTrace.coordinate prior.element.row + 1) :
   History observations (advance prior next)
 | reopen {prior : Coordinate observations} (history : History observations prior) (opening : Reopening observations)
   (linked : opening.closed = prior.element) : History observations (extend prior opening)

def records {observations : List (Outer → List String)} {last : Coordinate observations} :
 History observations last → List (Coordinate observations)
 | .first opening => [⟨opening.reopened,opening,[]⟩]
 | @History.next _ prior history next _ => records history ++ [advance prior next]
 | @History.reopen _ prior history opening _ => records history ++ [extend prior opening]

def pair {observations : List (Outer → List String)} (coordinate : Coordinate observations) :=
 (ledger observations coordinate.element,depth coordinate)

def classifiedPrefix {observations : List (Outer → List String)} {last : Coordinate observations}
 (history : History observations last) := (records history).map (fun c => (c.element,pair c))

theorem everyCoordinateHasBoth {observations : List (Outer → List String)} (coordinate : Coordinate observations) :
 (pair coordinate).1 = ledger observations coordinate.element ∧ (pair coordinate).2 = depth coordinate := ⟨rfl,rfl⟩

theorem unchangedDepthBetweenReopenings {observations : List (Outer → List String)}
 (coordinate : Coordinate observations) (next : Outer) : depth (advance coordinate next) = depth coordinate := rfl

theorem successorClassExactly {observations : List (Outer → List String)} (coordinate : Coordinate observations)
 (next member : Outer) : group observations (advance coordinate next) member ↔ equivalent observations next member := ⟨id,id⟩

theorem everyRecordAssigned {observations : List (Outer → List String)} {last : Coordinate observations}
 (history : History observations last) (coordinate : Coordinate observations) (held : coordinate ∈ records history) :
 (coordinate.element,pair coordinate) ∈ classifiedPrefix history := SFT.Foundation.Count.TraceDerivation.memMap _ coordinate _ held

theorem noRecordLost {observations : List (Outer → List String)} {last : Coordinate observations}
 (history : History observations last) : (classifiedPrefix history).length = (records history).length := SFT.Foundation.CommonRefinement.mapLength _ _

theorem nextRetainsCoordinate {observations : List (Outer → List String)} {last : Coordinate observations}
 (history : History observations last) (next : Outer)
 (successor : PeriodicOrderTrace.coordinate next.row = PeriodicOrderTrace.coordinate last.element.row + 1)
 (old : Coordinate observations) (held : old ∈ records history) : old ∈ records (.next history next successor) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem reopeningRetainsCoordinate {observations : List (Outer → List String)} {last : Coordinate observations}
 (history : History observations last) (opening : Reopening observations) (linked : opening.closed = last.element)
 (old : Coordinate observations) (held : old ∈ records history) : old ∈ records (.reopen history opening linked) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem namedFamilyCannotMerge {observations : List (Outer → List String)} (a b : Coordinate observations)
 (different : ¬ equivalent observations a.element b.element) : (pair a).1 ≠ (pair b).1 :=
 fun equal => different ((completeTraceExactly _ _ _).mp equal)

theorem sharedGroupExactly {observations : List (Outer → List String)} (a b : Coordinate observations) :
 (pair a).1 = (pair b).1 ↔ equivalent observations a.element b.element := completeTraceExactly _ _ _

end SFT.Chemistry.GroupPeriodCoordinates
