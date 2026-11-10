import SFT.Physics.CollectiveViscosity
import SFT.InformationScience.EntropyRefinement
import SFT.Mathematics.DynamicsReturns
namespace SFT.Physics.CollectiveTurbulence
open SFT.Foundation.ExactPartCarrier SFT.Foundation.FoldDynamics
open SFT.InformationScience.EntropyPartition SFT.InformationScience.EntropyRefinement
open SFT.Mathematics.ProbabilityObservations
open MechanicalConservation GeneratorThreeDerivation

-- The source retains both the complete microscopic flow and each computed
-- observation refinement. No continuum evolution or fitted cascade is added.
structure Refinement (Carrier : Type) where
 flow : CollectiveFlow.Flow Carrier
 fine : Observation
 fineClasses : Partition
 computed : exactPartition flow.cells.graph.nodes fine = .ok fineClasses
 admitted : refines flow.cells.graph.nodes fine flow.cells.observation = true

variable {Carrier : Type}

theorem everyFineClassRetained (r : Refinement Carrier) (label : String) (members : List String)
 (held : (label,members) ∈ r.fineClasses) :
 ∃ coarseLabel coarseMembers, (coarseLabel,coarseMembers) ∈ r.flow.cells.classes ∧
 ∀ state, state ∈ members → state ∈ coarseMembers :=
 classContainment _ _ _ _ _ r.computed r.flow.cells.computed r.admitted label members held

theorem refinementExactlyContainment (r : Refinement Carrier) :
 refines r.flow.cells.graph.nodes r.fine r.flow.cells.observation = true ↔
 ∀ label members, (label,members) ∈ r.fineClasses →
 ∃ coarseLabel coarseMembers, (coarseLabel,coarseMembers) ∈ r.flow.cells.classes ∧
 ∀ state, state ∈ members → state ∈ coarseMembers :=
 refinementIffContainment _ _ _ _ _ r.computed r.flow.cells.computed

theorem refinedCarrierBalance (r : Refinement Carrier) (region : List String) :
 FieldSourceContinuity.departuresInside (CollectiveFlow.inside region) r.flow.transfers +
 (FieldSourceContinuity.inward (CollectiveFlow.inside region) r.flow.transfers).length =
 FieldSourceContinuity.arrivalsInside (CollectiveFlow.inside region) r.flow.transfers +
 (FieldSourceContinuity.outward (CollectiveFlow.inside region) r.flow.transfers).length :=
 CollectiveFlow.completeRegionBalance r.flow region

theorem refinedCarrierIdentity (r : Refinement Carrier) :
 outgoingSupport r.flow.transfers = incomingSupport r.flow.transfers := completeConservation _

def cascadeRecords (scales : List (Refinement Carrier)) := scales.map (fun r => r.flow.transfers)

theorem scaleCensusCount (scales : List (Refinement Carrier)) :
 (cascadeRecords scales).length = scales.length := by
 induction scales with
 | nil => rfl
 | cons r rest ih => exact congrArg Nat.succ ih

theorem cascadeExactlyEnumerated (scales : List (Refinement Carrier)) (records : Network String Carrier) :
 records ∈ cascadeRecords scales ↔ ∃ r, r ∈ scales ∧ records = r.flow.transfers := by
 constructor
 · intro h
   obtain ⟨r,held,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ h
   exact ⟨r,held,eq.symm⟩
 · intro ⟨r,held,eq⟩
   rw [eq]
   exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem noUngeneratedCascade (scales : List (Refinement Carrier)) (records : Network String Carrier)
 (absent : ∀ r, r ∈ scales → records ≠ r.flow.transfers) : records ∉ cascadeRecords scales := by
 intro h
 obtain ⟨r,held,eq⟩ := (cascadeExactlyEnumerated scales records).mp h
 exact absent r held eq

theorem everyCascadeCarrierConserved (scales : List (Refinement Carrier))
 (records : Network String Carrier) (held : records ∈ cascadeRecords scales) :
 outgoingSupport records = incomingSupport records := by
 obtain ⟨r,_,same⟩ := (cascadeExactlyEnumerated scales records).mp held
 rw [same]
 exact refinedCarrierIdentity r

theorem scaleSuccessorRetainsAll (scale : Refinement Carrier) (prior : List (Refinement Carrier)) :
 cascadeRecords (prior ++ [scale]) = cascadeRecords prior ++ [scale.flow.transfers] := by
 induction prior with
 | nil => rfl
 | cons r rest ih => exact congrArg (List.cons r.flow.transfers) ih

structure History (Carrier : Type) where
 source : Part
 trace : List Part
 generated : Steps source trace
 observe : Part → List (Refinement Carrier)

def historyRecords (h : History Carrier) := h.trace.map (fun p => cascadeRecords (h.observe p))

theorem deterministicFlowHistory (source : Part) (left right : List Part)
 (a : Steps source left) (b : Steps source right) (same : left.length = right.length)
 (observe : Part → List (Refinement Carrier)) :
 left.map (fun p => cascadeRecords (observe p)) = right.map (fun p => cascadeRecords (observe p)) :=
 congrArg (fun xs => xs.map (fun p => cascadeRecords (observe p)))
  (ThermoFluctuation.deterministicSteps source left a right b same)

theorem allHistoryRowsRetained (h : History Carrier) : (historyRecords h).length = h.trace.length := by
 unfold historyRecords
 induction h.trace with
 | nil => rfl
 | cons p rest ih => exact congrArg Nat.succ ih

theorem exactFirstRecurrence (source : Part) (trace : List Part)
 (found : FoldFirstReturn.firstReturn source = .ok trace) :
 ∃ before, trace = before ++ [source] ∧ Steps source trace ∧ ∀ p, p ∈ before → p ≠ source :=
 ThermoFluctuation.nativeReturnHistory source trace found

-- The existing dynamical-system census explicitly distinguishes an absent
-- return at the finite boundary from the first observed return.
abbrev nonperiodicCensus := SFT.Mathematics.DynamicsReturns.firstReturnNoneIff
abbrev earliestCensusReturn := SFT.Mathematics.DynamicsReturns.firstReturnEarliest
end SFT.Physics.CollectiveTurbulence
