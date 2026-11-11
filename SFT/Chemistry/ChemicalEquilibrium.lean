import SFT.Foundation.FoldFibres
import SFT.Chemistry.ReactionRate
import SFT.Physics.ThermoEquilibrium
namespace SFT.Chemistry.ChemicalEquilibrium
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
abbrev Transfer := SFT.Physics.MechanicalConservation.Transfer String HeldLabel
open SFT.Physics.MechanicalConservation SFT.Physics.ThermoEquilibrium
structure Raw where
 forwardEvents : PositiveCount
 reverseEvents : PositiveCount
 composition : HeldLabel

def admit (r : Raw) : Except String Raw :=
 if SFT.Host.Text.equal r.composition.family "equilibrium-composition" then .ok r
 else .error "equilibrium requires a retained composition record"

def reversePlacement (p : ReactionIdentity.Placement) : ReactionIdentity.Placement :=
 ⟨p.carrier,p.product,p.reactant⟩
structure Pair where
 forward : ReactionIdentity.Reaction
 backward : ReactionIdentity.Reaction
 completeReverse : backward.placements=forward.placements.map reversePlacement
 sourceIdentity : String
 actionRecord : SFT.Host.Canonical.Value

def transfer (p : Pair) (row : ReactionIdentity.Placement) : Transfer :=
 ⟨row.reactant,row.product,row.carrier,p.sourceIdentity,p.actionRecord⟩
def forwardTransfers (p : Pair) := p.forward.placements.map (transfer p)
def pairedTransfers (p : Pair) := (forwardTransfers p).flatMap exchanges

theorem actualReverseCarriers (p : Pair) :
 p.backward.placements.map ReactionIdentity.Placement.carrier=p.forward.placements.map ReactionIdentity.Placement.carrier := by
 rw [p.completeReverse]
 have project : ∀ xs : List ReactionIdentity.Placement,
  (xs.map reversePlacement).map ReactionIdentity.Placement.carrier=xs.map ReactionIdentity.Placement.carrier := by
  intro xs
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x.carrier) ih
 exact project _

theorem actualReverseTransfers (p : Pair) :
 p.backward.placements.map (transfer p)=(forwardTransfers p).map reciprocal := by
 rw [p.completeReverse]
 have mapping : ∀ rows : List ReactionIdentity.Placement,
  (rows.map reversePlacement).map (transfer p)=(rows.map (transfer p)).map reciprocal := by
  intro rows
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons (transfer p (reversePlacement row))) ih
 exact mapping _

def departing (test : String → HeldLabel → Bool) : List Transfer → Nat
 | [] => 0
 | t::rest => (if test t.source t.carrier then 1 else 0)+departing test rest
def arriving (test : String → HeldLabel → Bool) : List Transfer → Nat
 | [] => 0
 | t::rest => (if test t.destination t.carrier then 1 else 0)+arriving test rest

theorem pairedNoDrift (test : String → HeldLabel → Bool) (rows : List Transfer) :
 departing test (rows.flatMap exchanges)=arriving test (rows.flatMap exchanges) := by
 induction rows with
 | nil => rfl
 | cons t rest ih =>
  change (if test t.source t.carrier then 1 else 0)+((if test t.destination t.carrier then 1 else 0)+departing test (rest.flatMap exchanges)) =
   (if test t.destination t.carrier then 1 else 0)+((if test t.source t.carrier then 1 else 0)+arriving test (rest.flatMap exchanges))
  rw [ih]
  exact Nat.add_left_comm _ _ _

theorem completePairNoDrift (p : Pair) (test : String → HeldLabel → Bool) :
 departing test (pairedTransfers p)=arriving test (pairedTransfers p) := pairedNoDrift _ _

def fullForwardTransfers (pairs : List Pair) := pairs.flatMap forwardTransfers
def completeTransfers (pairs : List Pair) := (fullForwardTransfers pairs).flatMap exchanges

theorem everyFiniteRecurrenceNoDrift (pairs : List Pair) (test : String → HeldLabel → Bool) :
 departing test (completeTransfers pairs)=arriving test (completeTransfers pairs) := pairedNoDrift _ _

def beforeComposition (tests : List (String → HeldLabel → Bool)) (pairs : List Pair) :=
 tests.map fun test => departing test (completeTransfers pairs)
def afterComposition (tests : List (String → HeldLabel → Bool)) (pairs : List Pair) :=
 tests.map fun test => arriving test (completeTransfers pairs)

theorem completeCompositionRecurs (tests : List (String → HeldLabel → Bool)) (pairs : List Pair) :
 beforeComposition tests pairs=afterComposition tests pairs := by
 induction tests with
 | nil => rfl
 | cons test rest ih =>
  change departing test (completeTransfers pairs)::_=arriving test (completeTransfers pairs)::_
  rw [everyFiniteRecurrenceNoDrift]
  exact congrArg (List.cons _) ih

def stateCount (test : String → HeldLabel → Bool) : List (String × HeldLabel) → Nat
 | [] => 0
 | row::rest => (if test row.1 row.2 then 1 else 0)+stateCount test rest

theorem closedStateRecurs (pairs : List Pair) (before after : List (String × HeldLabel))
 (accounting : ∀ test, stateCount test before+arriving test (completeTransfers pairs)=
  stateCount test after+departing test (completeTransfers pairs)) (test : String → HeldLabel → Bool) :
 stateCount test before=stateCount test after := by
 have h := accounting test
 rw [everyFiniteRecurrenceNoDrift] at h
 exact Nat.le_antisymm
  (SFT.Foundation.FoldFibres.cancelAddedBound _ _ _ (Nat.le_of_eq h))
  (SFT.Foundation.FoldFibres.cancelAddedBound _ _ _ (Nat.le_of_eq h.symm))

def compositionSignature (tests : List (String → HeldLabel → Bool)) (state : List (String × HeldLabel)) :=
 tests.map fun test => stateCount test state

theorem compositionStateRecurs (pairs : List Pair) (before after : List (String × HeldLabel))
 (accounting : ∀ test, stateCount test before+arriving test (completeTransfers pairs)=
  stateCount test after+departing test (completeTransfers pairs)) (tests : List (String → HeldLabel → Bool)) :
 compositionSignature tests before=compositionSignature tests after := by
 induction tests with
 | nil => rfl
 | cons test rest ih =>
  change stateCount test before::_=stateCount test after::_
  rw [closedStateRecurs pairs before after accounting test]
  exact congrArg (List.cons _) ih

structure Recurrence where
 raw : Raw
 accepted : admit raw=.ok raw
 first : Pair
 rest : List Pair
 forwardCount : raw.forwardEvents.value=(first::rest).length
 reverseCount : raw.reverseEvents.value=(first::rest).length
 boundary : HeldLabel
 conditions : SFT.Host.Canonical.Value
 tests : List (String → HeldLabel → Bool)
 compositionClass : List Nat → HeldLabel
 beforeState : List (String × HeldLabel)
 afterState : List (String × HeldLabel)
 closedAccounting : ∀ test, stateCount test beforeState+arriving test (completeTransfers (first::rest))=
  stateCount test afterState+departing test (completeTransfers (first::rest))
 classBinding : raw.composition=compositionClass (compositionSignature tests beforeState)

theorem bothDirectionsPersist (r : Recurrence) : 0<r.raw.forwardEvents.value ∧ 0<r.raw.reverseEvents.value :=
 ⟨r.raw.forwardEvents.positive,r.raw.reverseEvents.positive⟩
theorem completePairedCounts (r : Recurrence) : r.raw.forwardEvents.value=r.raw.reverseEvents.value :=
 r.forwardCount.trans r.reverseCount.symm

theorem retainedCompositionClass (r : Recurrence) :
 r.raw.composition=r.compositionClass (compositionSignature r.tests r.afterState) :=
 r.classBinding.trans (congrArg r.compositionClass (compositionStateRecurs _ _ _ r.closedAccounting _))

def history (pairs : List Pair) := pairs.map fun p => (p.forward.trace,p.backward.trace)
theorem baseTrace (p : Pair) : history [p]=[(p.forward.trace,p.backward.trace)] := rfl
theorem successorTrace (pairs : List Pair) (next : Pair) :
 history (pairs++[next])=history pairs++[(next.forward.trace,next.backward.trace)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem successorNoDrift (pairs : List Pair) (next : Pair) (test : String → HeldLabel → Bool) :
 departing test (completeTransfers (pairs++[next]))=arriving test (completeTransfers (pairs++[next])) :=
 everyFiniteRecurrenceNoDrift _ _

theorem successorComposition (tests : List (String → HeldLabel → Bool)) (pairs : List Pair) (next : Pair) :
 beforeComposition tests (pairs++[next])=afterComposition tests (pairs++[next]) := completeCompositionRecurs _ _

theorem successorStateClass (pairs : List Pair) (next : Pair) (before after : List (String × HeldLabel))
 (accounting : ∀ test, stateCount test before+arriving test (completeTransfers (pairs++[next]))=
  stateCount test after+departing test (completeTransfers (pairs++[next])))
 (tests : List (String → HeldLabel → Bool)) (classify : List Nat → HeldLabel) :
 classify (compositionSignature tests before)=classify (compositionSignature tests after) :=
 congrArg classify (compositionStateRecurs _ _ _ accounting _)

def baseRaw (composition : HeldLabel) : Raw := ⟨⟨1,by decide⟩,⟨1,by decide⟩,composition⟩
theorem basePairedCounts (composition : HeldLabel) :
 (baseRaw composition).forwardEvents.value=(baseRaw composition).reverseEvents.value := rfl

theorem pairedRatesEqual (r : Recurrence) (clock : PositiveCount) :
 SFT.Mathematics.ExactRatioRelations.ratio r.raw.forwardEvents.value clock.value r.raw.forwardEvents.positive clock.positive=
 SFT.Mathematics.ExactRatioRelations.ratio r.raw.reverseEvents.value clock.value r.raw.reverseEvents.positive clock.positive := by
 have samePositive : ∀ a b : PositiveCount, a.value=b.value → a=b := by
  intro a b h
  cases a with
  | mk a ha =>
   cases b with
   | mk b hb =>
    change a=b at h
    cases h
    rfl
 rw [samePositive _ _ (completePairedCounts r)]
end SFT.Chemistry.ChemicalEquilibrium
