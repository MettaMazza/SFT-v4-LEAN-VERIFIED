import SFT.Materials.BoundPolarization
import SFT.InformationScience.ConservationCardinality
namespace SFT.Materials.Piezoelectric
open SFT.InformationScience SFT.Physics
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

-- V3 FUNC-PIEZOELECTRIC: the response is on retained material classes.
-- The first observation may close distinctions; reversibility is tested on
-- its image, not imposed on the unquotiented source carrier.
structure Response where
 source : List String
 materialObservation : Observation
 crossResponse : Observation
 materialAdmitted : ConservationLedger.validateTransformation source materialObservation = .ok materialObservation
 responseAdmitted : ConservationLedger.validateTransformation (MutualObservation.labels source materialObservation) crossResponse = .ok crossResponse
 reversible : ConservationReverse.isReversible (MutualObservation.labels source materialObservation) crossResponse = .ok true
 mechanical : String → MechanicalLocation.Displacement String
 electric : String → BoundPolarization.OrientationRow
 fieldStressConditions : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

def retainedMechanical (r : Response) := MutualObservation.labels r.source r.materialObservation

def responseRows (r : Response) := ConservationComposition.composedRows r.source r.materialObservation r.crossResponse

def reverseRows (r : Response) := ConservationReverse.reverseRecord (retainedMechanical r) r.crossResponse

theorem exactComposition (r : Response) :
 ConservationComposition.compose r.source r.materialObservation r.crossResponse = .ok (responseRows r) :=
 ConservationComposition.composeAdmitted _ _ _ r.materialAdmitted r.responseAdmitted

theorem reversibleOnRetainedClasses (r : Response) :
 ∀ a, a ∈ retainedMechanical r → ∀ b, b ∈ retainedMechanical r →
 ConservationComposition.value r.crossResponse a = ConservationComposition.value r.crossResponse b → a = b :=
 (ConservationCardinality.reversibleIffInjective _ _ r.responseAdmitted).mp r.reversible

theorem uniquePredecessorFibres (r : Response) :
 ∀ label, label ∈ MutualObservation.labels (retainedMechanical r) r.crossResponse →
 ∃ state, SFT.Mathematics.ProbabilityObservations.fibre (retainedMechanical r) r.crossResponse label = [state] :=
 (ConservationCardinality.reversibleIffSingletonFibres _ _ r.responseAdmitted).mp r.reversible

theorem closedOrientationCannotReturn (r : Response) (pair : String × String)
 (closed : pair ∈ ConservationLedger.closed r.source r.materialObservation) :
 pair ∈ ConservationLedger.closed r.source (responseRows r) :=
 ConservationComposition.closedPersists _ _ _ _ closed

theorem electricDistinctionRequiresRetainedOrientation (r : Response) (pair : String × String)
 (held : pair ∈ ConservationLedger.retained r.source (responseRows r)) :
 pair ∈ ConservationLedger.retained r.source r.materialObservation :=
 ConservationComposition.retainedSubset _ _ _ _ held

theorem electricDistinctionExcludesClosure (r : Response) (pair : String × String)
 (held : pair ∈ ConservationLedger.retained r.source (responseRows r)) :
 ¬ pair ∈ ConservationLedger.closed r.source r.materialObservation := by
 intro closed
 have h := (ConservationLedger.retainedMeaning _ _ _).mp held
 have c := (ConservationLedger.closedMeaning _ _ _).mp (closedOrientationCannotReturn r pair closed)
 exact h.2 c.2

theorem downstreamCheck (r : Response) :
 ConservationComposition.downstreamRetentionLaw r.source r.materialObservation r.crossResponse = .ok true :=
 ConservationComposition.downstreamTrue _ _ _ r.materialAdmitted r.responseAdmitted

def mechanicalElectricRow (r : Response) (state : String) :=
 (r.mechanical state,r.electric (ConservationComposition.value r.crossResponse state))

theorem mechanicalComponentExact (r : Response) (state : String) :
 (mechanicalElectricRow r state).1 = r.mechanical state := rfl

theorem electricComponentExact (r : Response) (state : String) :
 (mechanicalElectricRow r state).2 = r.electric (ConservationComposition.value r.crossResponse state) := rfl

theorem electricReorientationRetainsCharge (r : Response) (label : String) :
 (BoundPolarization.reorient (r.electric label)).label.charge = (r.electric label).label.charge :=
 BoundPolarization.reorientationRetainsCharge _

theorem electricReorientationChangesHeld (r : Response) (label : String) :
 (BoundPolarization.reorient (r.electric label)).displacement.held ≠ (r.electric label).displacement.held :=
 BoundPolarization.reorientationChangesHeld _

def appliedElectric (r : Response) (state : String) :=
 r.electric (ConservationComposition.value r.crossResponse
   (ConservationComposition.value r.materialObservation state))

theorem closedMaterialHasSameElectricRecord (r : Response) (a b : String)
 (closed : image r.materialObservation a = image r.materialObservation b) :
 appliedElectric r a = appliedElectric r b := by
 have same : ConservationComposition.value r.materialObservation a =
     ConservationComposition.value r.materialObservation b := congrArg (fun x => x.getD "") closed
 exact congrArg (fun k => r.electric (ConservationComposition.value r.crossResponse k)) same

theorem actualOrientationRequiresNonclosure (r : Response) (a b : String)
 (orientation : (appliedElectric r a).displacement.held ≠ (appliedElectric r b).displacement.held) :
 image r.materialObservation a ≠ image r.materialObservation b := by
 intro closed
 exact orientation (congrArg (fun row => row.displacement.held)
   (closedMaterialHasSameElectricRecord r a b closed))

theorem reverseRestoresMechanicalRecord (r : Response) (a b : String)
 (ha : a ∈ retainedMechanical r) (hb : b ∈ retainedMechanical r)
 (same : ConservationComposition.value r.crossResponse a = ConservationComposition.value r.crossResponse b) :
 r.mechanical a = r.mechanical b :=
 congrArg r.mechanical (reversibleOnRetainedClasses r a ha b hb same)

def record (r : Response) :=
 (r,responseRows r,reverseRows r,(retainedMechanical r).map (mechanicalElectricRow r))

theorem completeInputRetained (r : Response) : (record r).1 = r := rfl

theorem completeResponseCount (r : Response) : (record r).2.2.2.length = (retainedMechanical r).length :=
 SFT.Foundation.CommonRefinement.mapLength _ _

def records (rs : List Response) := rs.map record

theorem base (r : Response) : records [r] = [record r] := rfl

theorem successor (rs : List Response) (r : Response) : records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.Piezoelectric
