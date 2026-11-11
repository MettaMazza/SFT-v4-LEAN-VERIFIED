import SFT.Chemistry.SurfaceAdsorption
namespace SFT.Chemistry.InterfacialTransfer
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
abbrev Raw := SurfaceAdsorption.Raw
abbrev admit := SurfaceAdsorption.admit
abbrev State := SurfaceAdsorption.State
inductive Orientation where
 | firstToSecond | secondToFirst
 deriving DecidableEq
structure Context where
 boundary : SurfaceAdsorption.Boundary
 orientation : Orientation
 species : HeldLabel
 area : PositiveCount
 areaSupport : List HeldLabel
 completeArea : areaSupport.length=area.value
 interval : PositiveCount
 intervalSupport : List HeldLabel
 completeInterval : intervalSupport.length=interval.value
 sourceRecord : SFT.Host.Canonical.Value

def donor (c : Context) : HeldLabel := match c.orientation with
 | .firstToSecond => c.boundary.raw.firstPhase
 | .secondToFirst => c.boundary.raw.secondPhase

def receiver (c : Context) : HeldLabel := match c.orientation with
 | .firstToSecond => c.boundary.raw.secondPhase
 | .secondToFirst => c.boundary.raw.firstPhase

theorem distinctPhases (c : Context) : donor c≠receiver c := by
 unfold donor receiver
 cases h : c.orientation with
 | firstToSecond => exact SurfaceAdsorption.phaseIdentitiesDiffer c.boundary
 | secondToFirst => exact fun same => SurfaceAdsorption.phaseIdentitiesDiffer c.boundary same.symm

structure Crossing (c : Context) where
 carrier : HeldLabel
 sameSpecies : carrier=c.species
 donorBefore : List HeldLabel
 donorAfter : List HeldLabel
 receiverBefore : List HeldLabel
 receiverAfter : List HeldLabel
 interfaceRecord : SFT.Host.Canonical.Value

def before {c : Context} (e : Crossing c) : State := match c.orientation with
 | .firstToSecond => ⟨e.donorBefore++e.carrier::e.donorAfter,e.receiverBefore++e.receiverAfter⟩
 | .secondToFirst => ⟨e.receiverBefore++e.receiverAfter,e.donorBefore++e.carrier::e.donorAfter⟩

def after {c : Context} (e : Crossing c) : State := match c.orientation with
 | .firstToSecond => ⟨e.donorBefore++e.donorAfter,e.receiverBefore++e.carrier::e.receiverAfter⟩
 | .secondToFirst => ⟨e.receiverBefore++e.carrier::e.receiverAfter,e.donorBefore++e.donorAfter⟩

def change {c : Context} (e : Crossing c) : SurfaceAdsorption.Change (before e) (after e) := by
 unfold before after
 cases h : c.orientation with
 | firstToSecond => exact .departureAt e.donorBefore e.donorAfter e.receiverBefore e.receiverAfter e.carrier
 | secondToFirst => exact .arrivalAt e.receiverBefore e.receiverAfter e.donorBefore e.donorAfter e.carrier

theorem everyCrossingBalanced {c : Context} (e : Crossing c) (test : HeldLabel → Bool) :
 SurfaceAdsorption.total test (before e)=SurfaceAdsorption.total test (after e) :=
 SurfaceAdsorption.changeConserves (change e) test

def departureWord {c : Context} (e : Crossing c) := [e.carrier]
def arrivalWord {c : Context} (e : Crossing c) := [e.carrier]

theorem exactDepartureArrivalPair {c : Context} (e : Crossing c) : departureWord e=arrivalWord e := rfl

theorem sameSpeciesCrosses {c : Context} (e : Crossing c) : departureWord e=[c.species] ∧ arrivalWord e=[c.species] := by
 exact ⟨congrArg (fun x => [x]) e.sameSpecies,congrArg (fun x => [x]) e.sameSpecies⟩

def history {c : Context} (events : List (Crossing c)) := events.map fun e =>
 (donor c,before e,e.carrier,e.interfaceRecord,after e,receiver c)

inductive Run (c : Context) : State → State → List (Crossing c) → Prop where
 | empty (s : State) : Run c s s []
 | step (e : Crossing c) (final : State) (rest : List (Crossing c))
   (tail : Run c (after e) final rest) : Run c (before e) final (e::rest)

theorem fullRunBalanced {c : Context} {initial final : State} {events : List (Crossing c)}
 (run : Run c initial final events) (test : HeldLabel → Bool) :
 SurfaceAdsorption.total test initial=SurfaceAdsorption.total test final := by
 induction run with
 | empty => rfl
 | step e final rest tail ih => exact (everyCrossingBalanced e test).trans ih

theorem oneCrossingBase {c : Context} (e : Crossing c) : Run c (before e) (after e) [e] :=
 .step e (after e) [] (.empty (after e))

theorem composeRuns {c : Context} {initial middle final : State} {left right : List (Crossing c)}
 (first : Run c initial middle left) (second : Run c middle final right) : Run c initial final (left++right) := by
 induction first with
 | empty => exact second
 | step e final rest tail ih => exact .step e _ _ (ih second)

theorem appendCrossing {c : Context} {initial : State} {events : List (Crossing c)}
 (e : Crossing c) (prior : Run c initial (before e) events) : Run c initial (after e) (events++[e]) :=
 composeRuns prior (oneCrossingBase e)

def eventCount {c : Context} (first : Crossing c) (rest : List (Crossing c)) : PositiveCount :=
 ⟨(first::rest).length,Nat.zero_lt_succ _⟩

def rate {c : Context} (first : Crossing c) (rest : List (Crossing c)) :=
 SFT.Mathematics.ExactRatioRelations.ratio (eventCount first rest).value c.interval.value
 (eventCount first rest).positive c.interval.positive

def flux {c : Context} (first : Crossing c) (rest : List (Crossing c)) :=
 SFT.Mathematics.ExactRatioRelations.ratio (eventCount first rest).value (c.area.value*c.interval.value)
 (eventCount first rest).positive (Nat.mul_pos c.area.positive c.interval.positive)

theorem exactRate {c : Context} (first : Crossing c) (rest : List (Crossing c)) :
 (first::rest).length*(rate first rest).denominator=(rate first rest).numerator*c.interval.value :=
 SFT.Mathematics.ExactRatioRelations.ratioValue _ _ _ _

theorem exactFlux {c : Context} (first : Crossing c) (rest : List (Crossing c)) :
 (first::rest).length*(flux first rest).denominator=(flux first rest).numerator*(c.area.value*c.interval.value) :=
 SFT.Mathematics.ExactRatioRelations.ratioValue _ _ _ _

structure Observation where
 context : Context
 first : Crossing context
 rest : List (Crossing context)
 initial : State
 final : State
 completeRun : Run context initial final (first::rest)
 sourceCount : context.boundary.raw.carriers.value=(first::rest).length

theorem originalCountIsCrossings (o : Observation) :
 o.context.boundary.raw.carriers.value=(eventCount o.first o.rest).value := o.sourceCount

theorem completeObservationBalanced (o : Observation) (test : HeldLabel → Bool) :
 SurfaceAdsorption.total test o.initial=SurfaceAdsorption.total test o.final := fullRunBalanced o.completeRun test

theorem eventSuccessorCount {c : Context} (first : Crossing c) (rest : List (Crossing c)) (fresh : Crossing c) :
 (first::(rest++[fresh])).length=(first::rest).length+1 := by
 change (rest++[fresh]).length+1=rest.length+1+1
 rw [SFT.Foundation.CommonRefinement.appendLength]
 rfl

theorem successorHistory {c : Context} (events : List (Crossing c)) (fresh : Crossing c) :
 history (events++[fresh])=history events++history [fresh] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem successorExactRate {c : Context} (first : Crossing c) (rest : List (Crossing c)) (fresh : Crossing c) :
 ((first::rest).length+1)*(rate first (rest++[fresh])).denominator=
 (rate first (rest++[fresh])).numerator*c.interval.value := by
 rw [← eventSuccessorCount first rest fresh]
 exact exactRate _ _

def sourceTrace (o : Observation) :=
 (o.context.boundary.raw,o.context.orientation,o.context.species,o.context.areaSupport,
 o.context.intervalSupport,o.context.boundary.conditions,o.context.sourceRecord,history (o.first::o.rest))
end SFT.Chemistry.InterfacialTransfer
