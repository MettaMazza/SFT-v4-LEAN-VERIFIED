import SFT.Physics.SuperconductivityJointHistory
import SFT.Mathematics.OrderExtrema
namespace SFT.Materials.SuperfluidBoundary
open SFT.Physics SFT.Physics.SuperconductivityJointHistory
open SFT.Physics.SuperconductivityLabelClosure SFT.Mathematics.OrderOperations
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology

-- Retained excitation classes and their generated order determine the first
-- boundary. No borrowed energy scalar or fitted critical value is introduced.
structure Boundary where
 transport : CollectiveSuperconductivity.Transport
 collective : CollectiveBinding transport
 classes : List String
 order : SFT.Mathematics.OrderOperations.Relation
 ordered : isPartialOrder classes order = true
 excitations : List String
 excitationsHeld : ∀ label, label ∈ excitations → label ∈ classes
 firstExcitation : String
 firstChecked : uniqueLeast excitations order = some firstExcitation
 rowClass : Row → String
 rowClassHeld : ∀ row, row ∈ transport.records → rowClass row ∈ classes
 chargeSupport : List String
 neutral : chargeSupport = []
 conditions : SFT.Host.Canonical.Value

def below (b : Boundary) (row : Row) : Bool :=
 if b.rowClass row = b.firstExcitation then false
 else has b.order (b.rowClass row,b.firstExcitation)

def census (b : Boundary) := b.transport.records.filter (below b)

theorem censusExactly (b : Boundary) (row : Row) :
 row ∈ census b ↔ row ∈ b.transport.records ∧ below b row = true :=
 filterMemberIff _ _ _

theorem firstBoundaryIsLeast (b : Boundary) :
 b.firstExcitation ∈ b.excitations ∧
 (∀ other, other ∈ b.excitations → (b.firstExcitation,other) ∈ b.order) ∧
 (∀ rival, rival ∈ b.excitations →
  (∀ other, other ∈ b.excitations → (rival,other) ∈ b.order) → rival = b.firstExcitation) :=
 leastMeaning _ _ _ b.firstChecked

def dissipationClosedBelow (b : Boundary) : Prop :=
 ∀ row, row ∈ census b → closedMotionDistinctions row.2 = []

def bounded {b : Boundary} {first last : Row} (history : History b.transport first last) : Prop :=
 match history with
 | .one _ _ => below b first = true
 | .append prior next _ _ _ _ => bounded prior ∧ below b next = true
termination_by structural history

theorem noLossInBoundedHistory (b : Boundary) {first last : Row}
 (history : History b.transport first last) (inBoundary : bounded history)
 (closed : dissipationClosedBelow b) (pair : String × String)
 (held : pair ∈ SFT.InformationScience.EncodingLoss.sourcePairs first.2.transfers.sourceSupport)
 (sameClass : collectiveLabel first.2 pair.1 = collectiveLabel first.2 pair.2)
 (sameResult : image last.2.transfers.receiver pair.1 = image last.2.transfers.receiver pair.2) :
 motionLabel first.2 pair.1 = motionLabel first.2 pair.2 := by
 induction history with
 | one registered =>
   exact (emptyClosureIffMotionDistinctionsRetained first.2).mp
    (closed first ((censusExactly b first).mpr ⟨registered,inBoundary⟩))
    pair held sameClass sameResult
 | @append previous prior next registered sameSource sameCollective motionContinues ih =>
   have sourceNext : pair ∈ SFT.InformationScience.EncodingLoss.sourcePairs next.2.transfers.sourceSupport := by
    rw [sameSource,sourceRetained prior]
    exact held
   have classNext : collectiveLabel next.2 pair.1 = collectiveLabel next.2 pair.2 := by
    unfold collectiveLabel
    rw [sameCollective,collectiveRetained prior]
    exact sameClass
   have nextEqual := (emptyClosureIffMotionDistinctionsRetained next.2).mp
    (closed next ((censusExactly b next).mpr ⟨registered,inBoundary.2⟩))
    pair sourceNext classNext sameResult
   unfold motionLabel at nextEqual
   rw [motionContinues] at nextEqual
   exact ih inBoundary.1 nextEqual

theorem sharedPhaseReturns (b : Boundary) {first last : Row}
 (history : History b.transport first last) :
 SuperconductivityRecurrenceProofs.runRecurrences b.transport.boundary.preparation.state
  (paths history) = .ok b.transport.boundary.preparation.state :=
 sameHistoryReturnsPhase history

theorem allCellsSharePhaseClass (b : Boundary) (cell : String)
 (held : cell ∈ b.transport.boundary.lattice.cells.graph.nodes) :
 image b.transport.order.cells.observation cell = some b.transport.order.macrostate.label :=
 everyCellHasRetainedCollectiveLabel b.collective cell held

theorem noChargedConstituent (b : Boundary) (label : String) : label ∉ b.chargeSupport := by
 rw [b.neutral]
 intro absent
 cases absent

def records (boundaries : List Boundary) := boundaries.map (fun b => (b,census b))

theorem base (b : Boundary) : records [b] = [(b,census b)] := rfl

theorem successor (boundaries : List Boundary) (next : Boundary) :
 records (boundaries ++ [next]) = records boundaries ++ [(next,census next)] := by
 induction boundaries with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (head,census head)) ih

end SFT.Materials.SuperfluidBoundary
