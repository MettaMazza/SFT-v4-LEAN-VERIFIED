import SFT.Chemistry.ChemicalEquilibrium
import SFT.Chemistry.ChemicalPhase
import SFT.Materials.PhaseHistory
import SFT.Materials.Phase
import SFT.Physics.ThermoStateRelation
namespace SFT.Materials.PhaseMap
open SFT.Foundation.Count.TraceDerivation
open SFT.Chemistry

-- MATERIALS_OBLIGATIONS[69]: complete composition/condition observations.
-- The recurrence class is the existing source-bound composition class;
-- no fitted stability potential or extrapolation rule is introduced.
structure Observation where
 recurrence : ChemicalEquilibrium.Recurrence
 phase : ChemicalPhase.Record
 compositionBinding : phase.boundary.composition = recurrence.raw.composition
 region : SFT.Physics.CollectivePhaseOrder.OrderedRegion
 phaseBinding : ChemicalPhase.phaseView phase = SFT.Physics.CollectivePhaseOrder.fibreView region
 provenance : SFT.Host.Canonical.Value

def stableClass (o : Observation) :=
 (o.recurrence.raw.composition,ChemicalPhase.intensiveIdentity o.phase)

def successorClass (o : Observation) :=
 (o.recurrence.compositionClass
  (ChemicalEquilibrium.compositionSignature o.recurrence.tests o.recurrence.afterState),
  ChemicalPhase.intensiveIdentity o.phase)

theorem recurrencePreservesClass (o : Observation) : stableClass o = successorClass o :=
 congrArg (fun c => (c,ChemicalPhase.intensiveIdentity o.phase))
  (ChemicalEquilibrium.retainedCompositionClass o.recurrence)

structure Record where
 first : Observation
 rest : List Observation
 domainBoundary : SFT.Host.Canonical.Value

def support (r : Record) := r.first::r.rest

def row (o : Observation) : SFT.Physics.ThermoStateRelation.StateRow
 ChemicalPhase.HeldLabel (ChemicalPhase.HeldLabel × ChemicalPhase.HeldLabel × ChemicalPhase.HeldLabel × ChemicalPhase.HeldLabel)
 (ChemicalPhase.HeldLabel × List ChemicalPhase.HeldLabel) ChemicalPhase.Record :=
 ⟨o.phase.boundary.composition,ChemicalPhase.conditions o.phase,stableClass o,o.phase⟩

def domain (r : Record) : SFT.Physics.ThermoStateRelation.RegisteredDomain Observation
 ChemicalPhase.HeldLabel (ChemicalPhase.HeldLabel × ChemicalPhase.HeldLabel × ChemicalPhase.HeldLabel × ChemicalPhase.HeldLabel)
 (ChemicalPhase.HeldLabel × List ChemicalPhase.HeldLabel) ChemicalPhase.Record :=
 ⟨support r,row⟩

def relation (r : Record) := SFT.Physics.ThermoStateRelation.relation (domain r)

theorem generatedRelationComplete (r : Record) :
 SFT.Physics.ThermoStateRelation.covers (domain r) (relation r) :=
 SFT.Physics.ThermoStateRelation.completeClosure _

theorem generatedRelationMinimal (r : Record) (q)
 (complete : SFT.Physics.ThermoStateRelation.covers (domain r) q)
 (x) (held : relation r x) : q x :=
 SFT.Physics.ThermoStateRelation.leastClosedRelation _ q complete x held

theorem noExtrapolation (r : Record) (x) (held : relation r x) :
 ∃ o ∈ support r, row o = x := held

def SameClass (a b : Observation) : Prop :=
 stableClass a = stableClass b ∧ SFT.Physics.CollectivePhaseOrder.stableObservation a.region b.region

def InClass (r : Record) (anchor o : Observation) : Prop :=
 o ∈ support r ∧ SameClass anchor o

theorem everyObservationClassified (r : Record) (o : Observation) (held : o ∈ support r) :
 InClass r o o := ⟨held,rfl,SFT.Materials.Phase.stableReflexive _⟩

theorem overlappingClassesAgree (r : Record) (a b x : Observation)
 (ha : InClass r a x) (hb : InClass r b x) : SameClass a b :=
 ⟨ha.2.1.trans hb.2.1.symm,ha.2.2.1.trans hb.2.2.1.symm,
 fun f g => (ha.2.2.2 f g).trans (hb.2.2.2 f g).symm⟩

theorem sameClassSameMembers (r : Record) (a b x : Observation)
 (same : SameClass a b) : InClass r a x ↔ InClass r b x := by
 constructor
 · intro h
   exact ⟨h.1,same.1.symm.trans h.2.1,same.2.1.symm.trans h.2.2.1,
    fun f g => (same.2.2 f g).symm.trans (h.2.2.2 f g)⟩
 · intro h
   exact ⟨h.1,same.1.trans h.2.1,SFT.Materials.Phase.stableTransitive _ _ _ same.2 h.2.2⟩

theorem distinctClassesDisjoint (r : Record) (a b x : Observation)
 (different : ¬ SameClass a b) : ¬ (InClass r a x ∧ InClass r b x) :=
 fun h => different (overlappingClassesAgree r a b x h.1 h.2)

def append (r : Record) (o : Observation) : Record :=
 { r with rest := r.rest++[o] }

theorem successorSupport (r : Record) (o : Observation) :
 support (append r o) = support r++[o] := rfl

theorem successorClassMembership (r : Record) (fresh anchor o : Observation) :
 InClass (append r fresh) anchor o ↔ InClass r anchor o ∨ (o = fresh ∧ SameClass anchor o) := by
 constructor
 · intro h
   cases memAppendCases o (support r) [fresh] h.1 with
   | inl old => exact Or.inl ⟨old,h.2⟩
   | inr added =>
     cases added with
     | head => exact Or.inr ⟨rfl,h.2⟩
     | tail _ impossible => cases impossible
 · intro h
   cases h with
   | inl old => exact ⟨memAppendLeft _ _ _ old.1,old.2⟩
   | inr freshRow =>
     cases freshRow.1
     exact ⟨memAppendRight fresh (support r) [fresh] (.head _),freshRow.2⟩

theorem phaseMembersShareTrace (o : Observation) (cell : String) (held : cell ∈ o.phase.members) :
 o.phase.boundary.trace cell = ChemicalPhase.intensiveIdentity o.phase :=
 ChemicalPhase.completeIntensiveHomogeneity _ _ held

variable {Part Support State ClockState Clock : Type}
variable {reference : SFT.Physics.ThermoTemperature.Transition Part Support State ClockState Clock}

-- Exact fraction of the complete connected phase in its held support.
def fraction (o : Observation) := SFT.Physics.CollectivePhaseOrder.fraction o.region

theorem fractionExact (o : Observation) :
 o.region.macrostate.members.length * (fraction o).denominator =
 (fraction o).numerator * o.region.cells.graph.nodes.length :=
 SFT.Physics.CollectivePhaseOrder.exactOrderedFraction o.region

theorem fractionBounded (o : Observation) :
 0 < (fraction o).numerator ∧ (fraction o).numerator ≤ (fraction o).denominator :=
 ⟨SFT.Physics.CollectivePhaseOrder.positiveOrderedFraction o.region,
 SFT.Physics.CollectivePhaseOrder.orderedFractionThroughOne o.region⟩

theorem coexistenceRetainsFractions (c : ChemicalPhase.Coexistence reference) :
 c.leftBefore.members.length=c.leftAfter.members.length ∧
 c.rightBefore.members.length=c.rightAfter.members.length := by
 have h := ChemicalPhase.coexistenceRetainsBothPhases c
 exact ⟨congrArg (fun p => p.2.length) h.1,congrArg (fun p => p.2.length) h.2⟩

theorem coexistenceDistinct (c : ChemicalPhase.Coexistence reference) :
 ChemicalPhase.phaseView c.leftAfter ≠ ChemicalPhase.phaseView c.rightAfter :=
 ChemicalPhase.coexistenceRemainsDistinct c

theorem coexistenceBoundary (c : ChemicalPhase.Coexistence reference) :
 ¬ ChemicalPhase.InPhase c.leftBefore.boundary c.leftBefore.root c.rightBefore.root :=
 ChemicalPhase.coexistenceRetainsInterface c

theorem transitionChangesClass {Carrier : Type} (h : SFT.Materials.PhaseHistory.Record Carrier) :
 ¬ SFT.Physics.CollectivePhaseOrder.stableObservation h.first.carrier h.last.carrier :=
 SFT.Materials.PhaseHistory.distinctMacroClasses h

def record (r : Record) := (r,(support r).map row)

theorem wholeInputRetained (r : Record) : (record r).1 = r := rfl

theorem successorRows (r : Record) (o : Observation) :
 (record (append r o)).2 = (record r).2++[row o] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend row (support r) [o]

theorem declaredBoundaryRetained (r : Record) (o : Observation) :
 (append r o).domainBoundary = r.domainBoundary := rfl

def initial (o : Observation) (boundary : SFT.Host.Canonical.Value) : Record := ⟨o,[],boundary⟩

theorem base (o : Observation) (boundary : SFT.Host.Canonical.Value) :
 (record (initial o boundary)).2 = [row o] := rfl
-- The complete map retains coexistence interfaces, exact fractions and
-- provenance-bearing transitions together with its generated observation rows.
structure Diagram (reference : SFT.Physics.ThermoTemperature.Transition Part Support State ClockState Clock)
 (Carrier : Type) where
 observations : Record
 coexistences : List (ChemicalPhase.Coexistence reference)
 transitions : List (SFT.Materials.PhaseHistory.Record Carrier)

variable {Carrier : Type}

def recordDiagram (d : Diagram reference Carrier) :=
 (d,record d.observations,(support d.observations).map fraction,
 d.coexistences.map (fun c => (ChemicalPhase.phaseView c.leftBefore,ChemicalPhase.phaseView c.rightBefore)),
 SFT.Materials.PhaseHistory.records d.transitions)

theorem allDiagramInput (d : Diagram reference Carrier) : (recordDiagram d).1 = d := rfl

theorem allFractions (d : Diagram reference Carrier) (o : Observation)
 (held : o ∈ support d.observations) : fraction o ∈ (support d.observations).map fraction :=
 memMap _ _ _ held

theorem everyCoexistingBoundary (d : Diagram reference Carrier) (c : ChemicalPhase.Coexistence reference)
 (_held : c ∈ d.coexistences) :
 ¬ ChemicalPhase.InPhase c.leftBefore.boundary c.leftBefore.root c.rightBefore.root :=
 coexistenceBoundary c

theorem everyTransitionBoundary (d : Diagram reference Carrier) (t : SFT.Materials.PhaseHistory.Record Carrier)
 (_held : t ∈ d.transitions) :
 ¬ SFT.Physics.CollectivePhaseOrder.stableObservation t.first.carrier t.last.carrier :=
 transitionChangesClass t

def diagrams (ds : List (Diagram reference Carrier)) := ds.map recordDiagram

theorem diagramBase (d : Diagram reference Carrier) : diagrams [d] = [recordDiagram d] := rfl

theorem diagramSuccessor (ds : List (Diagram reference Carrier)) (d : Diagram reference Carrier) :
 diagrams (ds++[d]) = diagrams ds++[recordDiagram d] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.PhaseMap
