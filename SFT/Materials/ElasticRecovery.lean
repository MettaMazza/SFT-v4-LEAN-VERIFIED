import SFT.InformationScience.ConservationCardinality
import SFT.Materials.MaterialCarrierRetention
namespace SFT.Materials.ElasticRecovery
open SFT.InformationScience SFT.Mathematics.ProbabilityObservations
open SFT.Mathematics.GeometryTopology

-- The whole displacement path is retained as its finite source-to-loaded
-- transformation. Release is computed from its complete predecessor fibres.
structure Path (Composition : Type) where
 source : List String
 transformation : Observation
 valid : ConservationLedger.validateTransformation source transformation = .ok transformation
 reversible : ConservationReverse.isReversible source transformation = .ok true
 sourceState : String → MaterialCarrier.Record Composition
 loadedState : String → MaterialCarrier.Record Composition
 displacementTrace : SFT.Host.Canonical.Value
 elasticBoundary : SFT.Host.Canonical.Value

def releaseLabel {C : Type} (p : Path C) (loaded : String) : Option String :=
 match ConservationReverse.predecessorRecord (fibre p.source p.transformation loaded) with
 | .unique original => some original
 | .heldLabels _ => none

def release {C : Type} (p : Path C) (loaded : String) : Option (MaterialCarrier.Record C) :=
 (releaseLabel p loaded).map p.sourceState

theorem uniqueOriginalFibre {C : Type} (p : Path C) (original loaded : String)
 (held : original ∈ p.source) (displaced : image p.transformation original = some loaded) :
 fibre p.source p.transformation loaded = [original] := by
 have labels := (SFT.InformationScience.MutualObservation.labelsMeaning _ _ _).mpr ⟨original,held,displaced⟩
 obtain ⟨state,single⟩ := (ConservationCardinality.reversibleIffSingletonFibres _ _ p.valid).mp p.reversible loaded labels
 have member := (fibreMembership _ _ _ _).mpr ⟨held,displaced⟩
 rw [single] at member
 have same : original = state := by
  cases member with
  | head => rfl
  | tail _ absent => cases absent
 rw [same]
 exact single

theorem labelReturns {C : Type} (p : Path C) (original loaded : String)
 (held : original ∈ p.source) (displaced : image p.transformation original = some loaded) :
 releaseLabel p loaded = some original := by
 unfold releaseLabel
 rw [uniqueOriginalFibre p original loaded held displaced]
 rfl

theorem canonicalStateReturns {C : Type} (p : Path C) (original loaded : String)
 (held : original ∈ p.source) (displaced : image p.transformation original = some loaded) :
 release p loaded = some (p.sourceState original) := by
 unfold release
 rw [labelReturns p original loaded held displaced]
 rfl

theorem everyConstituentReturns {C : Type} (p : Path C) (original loaded : String)
 (held : original ∈ p.source) (displaced : image p.transformation original = some loaded) :
 (release p loaded).map MaterialCarrier.Record.constituents = some (p.sourceState original).constituents := by
 rw [canonicalStateReturns p original loaded held displaced]
 rfl

theorem everyAdjacencyReturns {C : Type} (p : Path C) (original loaded : String)
 (held : original ∈ p.source) (displaced : image p.transformation original = some loaded) :
 (release p loaded).map MaterialCarrier.Record.bonding = some (p.sourceState original).bonding := by
 rw [canonicalStateReturns p original loaded held displaced]
 rfl

def record {C : Type} (p : Path C) (original loaded : String) :=
 (p,p.sourceState original,p.loadedState loaded,release p loaded)

theorem displacementTraceRetained {C : Type} (p : Path C) (original loaded : String) :
 (record p original loaded).1.displacementTrace = p.displacementTrace := rfl

theorem elasticBoundaryRetained {C : Type} (p : Path C) (original loaded : String) :
 (record p original loaded).1.elasticBoundary = p.elasticBoundary := rfl

structure Row (C : Type) where
 path : Path C
 original : String
 loaded : String
 held : original ∈ path.source
 displaced : image path.transformation original = some loaded

def records {C : Type} (rows : List (Row C)) := rows.map (fun r => record r.path r.original r.loaded)

theorem allReleaseRowsReturn {C : Type} (rows : List (Row C)) :
 rows.map (fun r => release r.path r.loaded) = rows.map (fun r => some (r.path.sourceState r.original)) := by
 induction rows with
 | nil => rfl
 | cons head rest ih =>
  change release head.path head.loaded :: _ = some (head.path.sourceState head.original) :: _
  rw [canonicalStateReturns head.path head.original head.loaded head.held head.displaced,ih]

theorem base {C : Type} (r : Row C) : records [r] = [record r.path r.original r.loaded] := rfl

theorem successor {C : Type} (rows : List (Row C)) (next : Row C) :
 records (rows ++ [next]) = records rows ++ [record next.path next.original next.loaded] := by
 induction rows with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head.path head.original head.loaded)) ih

end SFT.Materials.ElasticRecovery
