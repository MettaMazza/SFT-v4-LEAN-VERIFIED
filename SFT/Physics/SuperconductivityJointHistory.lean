import SFT.Physics.CollectiveSuperconductivity
namespace SFT.Physics.SuperconductivityJointHistory
open SuperconductivityLabelClosure CollectiveSuperconductivity
open SFT.Mathematics.GeometryTopology
open SFT.InformationScience

abbrev Row := List String × MotionRecord String

-- Consecutive records describe the same complete source and collective class;
-- the next motion observation is exactly the preceding receiving observation.
inductive History (t : Transport) : Row → Row → Type where
 | one (row : Row) (held : row ∈ t.records) : History t row row
 | append {first previous : Row} (prior : History t first previous)
   (next : Row) (held : next ∈ t.records)
   (sameSource : next.2.transfers.sourceSupport = previous.2.transfers.sourceSupport)
   (sameCollective : collectiveMap next.2.carriers = collectiveMap previous.2.carriers)
   (motionContinues : motionMap next.2.carriers = previous.2.transfers.receiver) :
   History t first next

variable {t : Transport} {first last : Row}

theorem sourceRetained (history : History t first last) :
 last.2.transfers.sourceSupport = first.2.transfers.sourceSupport := by
 induction history with
 | one => rfl
 | append prior next held sameSource sameCollective motionContinues ih =>
   exact sameSource.trans ih

theorem collectiveRetained (history : History t first last) :
 collectiveMap last.2.carriers = collectiveMap first.2.carriers := by
 induction history with
 | one => rfl
 | append prior next held sameSource sameCollective motionContinues ih =>
   exact sameCollective.trans ih

theorem noMotionDistinctionLost (history : History t first last) (noLoss : closed t)
 (pair : String × String)
 (source : pair ∈ EncodingLoss.sourcePairs first.2.transfers.sourceSupport)
 (sameClass : collectiveLabel first.2 pair.1 = collectiveLabel first.2 pair.2)
 (sameResult : image last.2.transfers.receiver pair.1 = image last.2.transfers.receiver pair.2) :
 motionLabel first.2 pair.1 = motionLabel first.2 pair.2 := by
 induction history with
 | one held =>
   exact (emptyClosureIffMotionDistinctionsRetained first.2).mp (noLoss first held)
     pair source sameClass sameResult
 | @append previous prior next held sameSource sameCollective motionContinues ih =>
   have sourceNext : pair ∈ EncodingLoss.sourcePairs next.2.transfers.sourceSupport := by
     rw [sameSource,sourceRetained prior]
     exact source
   have classNext : collectiveLabel next.2 pair.1 = collectiveLabel next.2 pair.2 := by
     unfold collectiveLabel
     rw [sameCollective,collectiveRetained prior]
     exact sameClass
   have motionNext := (emptyClosureIffMotionDistinctionsRetained next.2).mp (noLoss next held)
     pair sourceNext classNext sameResult
   unfold motionLabel at motionNext
   rw [motionContinues] at motionNext
   exact ih motionNext

def paths {t : Transport} {first last : Row} (history : History t first last) : List (List String) :=
 match history with
 | .one _ _ => [first.1]
 | .append prior next _ _ _ _ => paths prior ++ [next.1]
termination_by structural history

theorem everyPathRegistered (history : History t first last) :
 ∀ path, path ∈ paths history → ∃ record, (path,record) ∈ t.records := by
 induction history with
 | one held =>
   intro path member
   simp only [paths] at member
   cases member with
   | head => exact ⟨first.2,held⟩
   | tail _ h => cases h
 | append prior next held sameSource sameCollective motionContinues ih =>
   intro path member
   simp only [paths] at member
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases _ _ _ member with
   | inl old => exact ih path old
   | inr added => cases added with
     | head => exact ⟨next.2,held⟩
     | tail _ h => cases h

theorem sameHistoryReturnsPhase (history : History t first last) :
 SuperconductivityRecurrenceProofs.runRecurrences t.boundary.preparation.state (paths history) =
 .ok t.boundary.preparation.state :=
 finiteCoherentHistoryReturns t (paths history) (everyPathRegistered history)

-- The ordered support and source carrier records name the same retained
-- collective class; they are not independent labels chosen by a classifier.
structure CollectiveBinding (t : Transport) : Prop where
 completeRegion : t.order.macrostate.members = t.boundary.lattice.cells.graph.nodes
 sameCollective : ∀ row, row ∈ t.records → ∀ carrier, carrier ∈ row.2.carriers →
   carrier.2.2 = t.order.macrostate.label

theorem everyCellHasRetainedCollectiveLabel (binding : CollectiveBinding t)
 (cell : String) (held : cell ∈ t.boundary.lattice.cells.graph.nodes) :
 image t.order.cells.observation cell = some t.order.macrostate.label := by
 apply CollectivePhaseOrder.everyMemberSharesLabel t.order cell
 rw [binding.completeRegion]
 exact held

theorem sourceCarrierAndCellAgree (binding : CollectiveBinding t)
 (row : Row) (rowHeld : row ∈ t.records)
 (carrier : String × (String × String)) (carrierHeld : carrier ∈ row.2.carriers)
 (cell : String) (cellHeld : cell ∈ t.boundary.lattice.cells.graph.nodes) :
 image t.order.cells.observation cell = some carrier.2.2 := by
 rw [binding.sameCollective row rowHeld carrier carrierHeld]
 exact everyCellHasRetainedCollectiveLabel binding cell cellHeld

theorem jointPhaseAndMotionPersistence (history : History t first last) (noLoss : closed t) :
 SuperconductivityRecurrenceProofs.runRecurrences t.boundary.preparation.state (paths history) =
   .ok t.boundary.preparation.state ∧
 (∀ pair, pair ∈ EncodingLoss.sourcePairs first.2.transfers.sourceSupport →
   collectiveLabel first.2 pair.1 = collectiveLabel first.2 pair.2 →
   image last.2.transfers.receiver pair.1 = image last.2.transfers.receiver pair.2 →
   motionLabel first.2 pair.1 = motionLabel first.2 pair.2) :=
 ⟨sameHistoryReturnsPhase history,fun pair held same result =>
   noMotionDistinctionLost history noLoss pair held same result⟩

-- The source class comprises the jointly phase-bound carrier together with
-- absence of compatible closed motion distinctions in its complete census.
structure SuperconductingCarrier where
 transport : Transport
 collective : CollectiveBinding transport
 dissipationClosed : closed transport

theorem coherentPersistence (carrier : SuperconductingCarrier)
 {first last : Row} (history : History carrier.transport first last) :
 SuperconductivityRecurrenceProofs.runRecurrences carrier.transport.boundary.preparation.state (paths history) =
   .ok carrier.transport.boundary.preparation.state ∧
 (∀ pair, pair ∈ EncodingLoss.sourcePairs first.2.transfers.sourceSupport →
   collectiveLabel first.2 pair.1 = collectiveLabel first.2 pair.2 →
   image last.2.transfers.receiver pair.1 = image last.2.transfers.receiver pair.2 →
   motionLabel first.2 pair.1 = motionLabel first.2 pair.2) ∧
 (∀ cell, cell ∈ carrier.transport.boundary.lattice.cells.graph.nodes →
   image carrier.transport.order.cells.observation cell = some carrier.transport.order.macrostate.label) :=
 ⟨sameHistoryReturnsPhase history,
  (jointPhaseAndMotionPersistence history carrier.dissipationClosed).2,
  everyCellHasRetainedCollectiveLabel carrier.collective⟩

end SFT.Physics.SuperconductivityJointHistory
