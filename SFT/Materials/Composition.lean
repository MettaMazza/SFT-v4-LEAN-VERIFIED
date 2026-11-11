import SFT.Chemistry.ExactComposition
import SFT.Chemistry.EntityIdentity
namespace SFT.Materials.Composition
open SFT.Chemistry

-- MATERIALS_OBLIGATIONS[2]: complete component support on one declared basis.
structure Record where
 composition : ExactComposition.Record
 basis : String
 uncertainty : String
 observations : List (String × String)

def admitted (record : Record) : Prop :=
 ExactComposition.exactComposition record.composition.components = .ok record.composition.components

def initial (component : ExactComposition.Component) (source : SFT.Host.Canonical.Value)
 (basis uncertainty : String) : Record := ⟨⟨[component],source,[]⟩,basis,uncertainty,[]⟩

theorem initialAdmitted (component : ExactComposition.Component) (source : SFT.Host.Canonical.Value)
 (basis uncertainty : String) (one : component.part.numerator=component.part.denominator) :
 admitted (initial component source basis uncertainty) := ExactComposition.singletonOne component one

def refine (record : Record) (components : List ExactComposition.Component) : Record :=
 {record with composition := ExactComposition.refineRecord record.composition components}

theorem refinementAdmitted (record : Record) (before tail : List ExactComposition.Component)
 (parent first second : ExactComposition.Component)
 (split : (first.part.numerator*second.part.denominator+second.part.numerator*first.part.denominator)*parent.part.denominator =
 parent.part.numerator*(first.part.denominator*second.part.denominator))
 (original : record.composition.components=before++parent::tail)
 (prior : ExactComposition.closed record.composition.components)
 (unique : ExactComposition.distinct (before++first::second::tail)=true) :
 admitted (refine record (before++first::second::tail)) :=
 by
 rw [original] at prior
 exact ExactComposition.refinedCompositionAdmitted before tail parent first second split prior unique

theorem refinementBoundary (record : Record) (components : List ExactComposition.Component) :
 (refine record components).basis=record.basis ∧
 (refine record components).uncertainty=record.uncertainty ∧
 (refine record components).composition.sourceBoundary=record.composition.sourceBoundary ∧
 (refine record components).observations=record.observations := ⟨rfl,rfl,rfl,rfl⟩

theorem priorComponentsRetained (record : Record) (components : List ExactComposition.Component) :
 record.composition.components ∈ (refine record components).composition.sourceHistory :=
 ExactComposition.parentIdentitiesRetained record.composition components

theorem everyFiniteRefinementCloses {start finish : List ExactComposition.Component}
 (history : ExactComposition.History start finish) (initial : ExactComposition.closed start) :
 ExactComposition.closed finish := ExactComposition.allFiniteRefinementsClose history initial

def appendObservation (record : Record) (row : String × String) : Record :=
 {record with observations := record.observations++[row]}

theorem observationRetainsComposition (record : Record) (row : String × String) :
 (appendObservation record row).composition=record.composition ∧
 (appendObservation record row).basis=record.basis ∧
 (appendObservation record row).uncertainty=record.uncertainty := ⟨rfl,rfl,rfl⟩

theorem observationAdmitted (record : Record) (row : String × String)
 (held : admitted record) : admitted (appendObservation record row) := held

def priorObservation (record : Record) : Record :=
 {record with observations := EntityIdentity.priorCoordinates record.observations}

theorem observationRecovery (record : Record) (row : String × String) :
 priorObservation (appendObservation record row)=record := by
 cases record with
 | mk c b u os =>
   change Record.mk c b u (EntityIdentity.priorCoordinates (os++[row])) = _
   rw [EntityIdentity.priorCoordinatesExact]

theorem observationRetainsDistinctions (a b : Record) (x y : String × String)
 (different : a ≠ b) : appendObservation a x ≠ appendObservation b y := by
 intro same
 exact different ((observationRecovery a x).symm.trans ((congrArg priorObservation same).trans (observationRecovery b y)))
end SFT.Materials.Composition
