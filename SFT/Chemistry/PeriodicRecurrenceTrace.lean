import SFT.Chemistry.PeriodicOrderTrace
import SFT.Physics.QuantumPhysicalSpectra
import SFT.Physics.QuantumPhysicalExclusion
namespace SFT.Chemistry.PeriodicRecurrenceTrace
open SFT.Physics
open QuantumPhysicalIdentity QuantumPhysicalExclusion QuantumPhysicalSpectra

-- elements_periodicity_batch_2.py: boundary-closed outer support retains its
-- generated transition support and the actual exclusion-preserving occupation.
structure Outer where
 row : PeriodicOrderTrace.Row
 prepared : QuantumPhysicalState.Prepared
 generated : List (List String)
 transitions : List (Transition prepared generated)
 occupants : List (Occupant String String)
 orientation : Pair (Occupant String String) → MechanicalLocation.Held
 exchangeTraces : List (Pair (Occupant String String))
 occupation : ∀ pair ∈ exchangeTraces, alternating orientation pair


def support (outer : Outer) := spectrum outer.prepared outer.generated

theorem supportExactly (outer : Outer) (trace : List String) : trace ∈ support outer ↔
 trace ∈ outer.generated ∧ SFT.QuantumComputation.ReversibleModel.phaseAction outer.prepared.state trace = .ok outer.prepared.state :=
 generatedSpectrumExactly _ _ _

theorem transitionsClosed (outer : Outer) (t : Transition outer.prepared outer.generated) :
 SFT.QuantumComputation.ReversibleModel.phaseAction outer.prepared.state t.initial = .ok outer.prepared.state ∧
 SFT.QuantumComputation.ReversibleModel.phaseAction outer.prepared.state t.terminal = .ok outer.prepared.state :=
 transitionBetweenClosedClasses t

theorem duplicateOccupationRejected (outer : Outer) (a b : Occupant String String)
 (sameWord : a.word = b.word) (sameCell : a.cell = b.cell) : ¬ alternating outer.orientation ⟨a,b⟩ :=
 identicalSameCellExcluded _ a b sameWord sameCell

-- The boundary supplies the complete registered observations, not a chosen
-- period or a visual column. Each observation returns its full transition trace.
def equivalent (observations : List (Outer → List String)) (a b : Outer) : Prop :=
 ∀ observe ∈ observations, observe a = observe b

def ledger (observations : List (Outer → List String)) (a : Outer) := observations.map (fun f => f a)

theorem completeTraceExactly (observations : List (Outer → List String)) (a b : Outer) :
 ledger observations a = ledger observations b ↔ equivalent observations a b := by
 induction observations with
 | nil => exact ⟨(fun _ f h => nomatch h),(fun _ => rfl)⟩
 | cons f fs ih =>
   constructor
   · intro h g held
     have both := List.cons.inj h
     cases held with
     | head => exact both.1
     | tail _ hg => exact ih.mp both.2 g hg
   · intro h
     exact (congrArg (List.cons (f a)) (ih.mpr (fun g hg => h g (.tail _ hg)))).trans
       (congrArg (fun x => x :: ledger fs b) (h f (.head _)))

theorem equivalentReflexive (observations : List (Outer → List String)) (a : Outer) : equivalent observations a a := fun _ _ => rfl

theorem equivalentSymmetric (observations : List (Outer → List String)) (a b : Outer)
 (same : equivalent observations a b) : equivalent observations b a := fun f hf => (same f hf).symm

theorem equivalentTransitive (observations : List (Outer → List String)) (a b c : Outer)
 (ab : equivalent observations a b) (bc : equivalent observations b c) : equivalent observations a c :=
 fun f hf => (ab f hf).trans (bc f hf)

def returns (observations : List (Outer → List String)) (earlier later : Outer) : Prop :=
 PeriodicOrderTrace.coordinate earlier.row < PeriodicOrderTrace.coordinate later.row ∧ equivalent observations earlier later

def period (earlier later : Outer) : Nat :=
 PeriodicOrderTrace.coordinate later.row - PeriodicOrderTrace.coordinate earlier.row

theorem returnHasPositivePeriod (observations : List (Outer → List String)) (earlier later : Outer)
 (h : returns observations earlier later) : 0 < period earlier later := SFT.Foundation.ExactCast.subtractPositive _ _ h.1

theorem returnExactly (observations : List (Outer → List String)) (earlier later : Outer) :
 returns observations earlier later ↔ PeriodicOrderTrace.coordinate earlier.row < PeriodicOrderTrace.coordinate later.row ∧
 ledger observations earlier = ledger observations later :=
 ⟨fun h => ⟨h.1,(completeTraceExactly _ _ _).mpr h.2⟩,
 fun h => ⟨h.1,(completeTraceExactly _ _ _).mp h.2⟩⟩

theorem changedTraceRejectsReturn (observations : List (Outer → List String)) (earlier later : Outer)
 (f : Outer → List String) (held : f ∈ observations) (changed : f earlier ≠ f later) :
 ¬ returns observations earlier later := fun h => changed (h.2 f held)

def witnesses (observations : List (Outer → List String)) (history : List Outer) (a b : Outer) : Prop :=
 a ∈ history ∧ b ∈ history ∧ returns observations a b

theorem successorRetainsWitness (observations : List (Outer → List String)) (history : List Outer)
 (fresh a b : Outer) (h : witnesses observations history a b) : witnesses observations (history ++ [fresh]) a b :=
 ⟨SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ h.1,
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ h.2.1,h.2.2⟩

theorem firstReturnWitness (observations : List (Outer → List String)) (a b : Outer)
 (h : returns observations a b) : witnesses observations [a,b] a b :=
 ⟨.head _,.tail _ (.head _),h⟩

-- Constructive finite search: no classical choice and no imported fixed period.
def findReturn (observations : List (Outer → List String)) : List Outer → Outer → Option Outer
 | [], _ => none
 | a :: rest, fresh =>
   if PeriodicOrderTrace.coordinate a.row < PeriodicOrderTrace.coordinate fresh.row ∧
     ledger observations a = ledger observations fresh then some a else findReturn observations rest fresh

theorem foundReturn (observations : List (Outer → List String)) (history : List Outer) (fresh a : Outer)
 (found : findReturn observations history fresh = some a) : a ∈ history ∧ returns observations a fresh := by
 induction history with
 | nil => cases found
 | cons first rest ih =>
   unfold findReturn at found
   split at found
   · rename_i h
     have same := Option.some.inj found
     cases same
     exact ⟨.head _,(returnExactly _ _ _).mpr h⟩
   · have prior := ih found
     exact ⟨.tail _ prior.1,prior.2⟩

theorem noReturnExactly (observations : List (Outer → List String)) (history : List Outer) (fresh : Outer) :
 findReturn observations history fresh = none ↔ ∀ a ∈ history, ¬ returns observations a fresh := by
 induction history with
 | nil => exact ⟨(fun _ a h => nomatch h),(fun _ => rfl)⟩
 | cons first rest ih =>
   unfold findReturn
   split
   · rename_i h
     constructor
     · intro impossible; cases impossible
     · intro absent; exact False.elim (absent first (.head _) ((returnExactly _ _ _).mpr h))
   · rename_i h
     constructor
     · intro none a held
       cases held with
       | head => exact fun ret => h ((returnExactly _ _ _).mp ret)
       | tail _ prior => exact ih.mp none a prior
     · intro absent; exact ih.mpr (fun a ha => absent a (.tail _ ha))

structure OrderedHistory where
 last : PeriodicOrderTrace.Row
 succession : PeriodicOrderTrace.Sequence last
 outer : List Outer
 linked : outer.map (fun x => x.row) = PeriodicOrderTrace.records succession

theorem successorEitherReturnsOrExtends (observations : List (Outer → List String))
 (history : List Outer) (fresh : Outer) :
 (∃ prior, prior ∈ history ∧ returns observations prior fresh) ∨
 (∀ prior ∈ history, ¬ returns observations prior fresh) := by
 cases h : findReturn observations history fresh with
 | none => exact .inr ((noReturnExactly _ _ _).mp h)
 | some prior => exact .inl ⟨prior,foundReturn _ _ _ _ h⟩

theorem periodCountsSuccessors (observations : List (Outer → List String)) (a b : Outer)
 (h : returns observations a b) : period a b + PeriodicOrderTrace.coordinate a.row = PeriodicOrderTrace.coordinate b.row :=
 SFT.Foundation.FractionReduction.subtractAdd _ _ (Nat.le_of_lt h.1)

theorem classIndependentOfRepresentative (observations : List (Outer → List String)) (a b member : Outer)
 (same : equivalent observations a b) : equivalent observations a member ↔ equivalent observations b member :=
 ⟨fun h => equivalentTransitive _ _ _ _ (equivalentSymmetric _ _ _ same) h,
 fun h => equivalentTransitive _ _ _ _ same h⟩

theorem noExtraClassRule (observations : List (Outer → List String))
 (relation : Outer → Outer → Prop)
 (retains : ∀ a b, relation a b → ∀ f ∈ observations, f a = f b)
 (a b : Outer) (h : relation a b) : equivalent observations a b := retains a b h

end SFT.Chemistry.PeriodicRecurrenceTrace
