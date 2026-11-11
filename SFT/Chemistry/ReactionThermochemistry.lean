import SFT.Chemistry.ReactionIdentity
import SFT.Physics.ThermoHeatWork
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ReactionThermochemistry
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
structure Raw where
 inputSupport : PositiveCount
 outputSupport : PositiveCount
 orientation : HeldLabel
 conditions : HeldLabel

def admit (r : Raw) : Except String Raw :=
 if !(SFT.Host.Text.equal r.orientation.family "energy-transfer-orientation") ||
    !(SFT.Host.Text.equal r.conditions.family "thermochemical-conditions") then
 .error "energy ledger requires held orientation and conditions"
 else .ok r

inductive Side where | system | surroundings
structure Carrier where
 identity : HeldLabel
 sourceIdentity : String
 actionRecord : SFT.Host.Canonical.Value

def transfer (a b : Side) (c : Carrier) : SFT.Physics.MechanicalConservation.Transfer Side HeldLabel :=
 ⟨a,b,c.identity,c.sourceIdentity,c.actionRecord⟩
-- The partition retains occurrences, including repeated equal labels. Its three
-- lists are the retained, absorbed and released portions of the source ledger.
structure Ledger where
 retained : List Carrier
 absorbed : List Carrier
 released : List Carrier

def input (l : Ledger) := l.retained ++ l.released
def output (l : Ledger) := l.retained ++ l.absorbed
def network (l : Ledger) :=
 l.retained.map (transfer .system .system) ++
 l.absorbed.map (transfer .surroundings .system) ++
 l.released.map (transfer .system .surroundings)

structure Record where
 raw : Raw
 accepted : admit raw=.ok raw
 reaction : ReactionIdentity.Reaction
 ledger : Ledger
 completeInput : raw.inputSupport.value=(input ledger).length
 completeOutput : raw.outputSupport.value=(output ledger).length
 phase : HeldLabel
 reference : HeldLabel

theorem completeEnergyProvenance (l : Ledger) :
 SFT.Physics.MechanicalConservation.outgoingSupport (network l)=
 SFT.Physics.MechanicalConservation.incomingSupport (network l) :=
 SFT.Physics.MechanicalConservation.completeConservation _

theorem everyEnergyOccurrenceRetained (l : Ledger) :
 SFT.Physics.MechanicalConservation.outgoingSupport (network l)=
 (network l).map SFT.Physics.MechanicalConservation.Transfer.carrier :=
 SFT.Physics.MechanicalConservation.eachDepartureRetainsCarrier _

theorem absorbedEndpoints (c : Carrier) :
 (transfer .surroundings .system c).source=Side.surroundings ∧
 (transfer .surroundings .system c).destination=Side.system := ⟨rfl,rfl⟩
theorem releasedEndpoints (c : Carrier) :
 (transfer .system .surroundings c).source=Side.system ∧
 (transfer .system .surroundings c).destination=Side.surroundings := ⟨rfl,rfl⟩
theorem pairedTransferIdentity (a b : Side) (c : Carrier) :
 (transfer a b c).carrier=c.identity ∧ (transfer a b c).sourceIdentity=c.sourceIdentity ∧
 (transfer a b c).actionRecord=c.actionRecord := ⟨rfl,rfl,rfl⟩

theorem systemSurroundingsBalance (l : Ledger) :
 (output l).length+l.released.length=(input l).length+l.absorbed.length := by
 unfold output input
 rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength]
 exact Nat.add_right_comm _ _ _

theorem completeReactionEnergyBalance (r : Record) :
 r.raw.outputSupport.value+r.ledger.released.length=
 r.raw.inputSupport.value+r.ledger.absorbed.length := by
 rw [r.completeInput,r.completeOutput]
 exact systemSurroundingsBalance _

-- Products-minus-reactants is represented by positive support and an
-- orientation; the equation retains both directions without signed energy.
theorem releasedOnly (r : Record) (noneAbsorbed : r.ledger.absorbed=[]) :
 r.raw.outputSupport.value+r.ledger.released.length=r.raw.inputSupport.value := by
 have h := completeReactionEnergyBalance r
 rw [noneAbsorbed] at h
 exact h

theorem absorbedOnly (r : Record) (noneReleased : r.ledger.released=[]) :
 r.raw.outputSupport.value=r.raw.inputSupport.value+r.ledger.absorbed.length := by
 have h := completeReactionEnergyBalance r
 rw [noneReleased] at h
 exact h

theorem reactionCarriersConserved (r : Record) :
 (SFT.Physics.MatterConservedLabels.destinations (ReactionIdentity.flows r.reaction.placements)).map Prod.fst=
 r.reaction.trace.raw.conservedCarriers := ReactionIdentity.everyCarrierReachesOutput _

def appendReleased (l : Ledger) (c : Carrier) : Ledger :=
 { l with released := l.released++[c] }
def appendAbsorbed (l : Ledger) (c : Carrier) : Ledger :=
 { l with absorbed := l.absorbed++[c] }

theorem releasedSuccessorInput (l : Ledger) (c : Carrier) :
 input (appendReleased l c)=input l++[c] := by
 unfold input appendReleased
 exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem releasedSuccessorOutput (l : Ledger) (c : Carrier) :
 output (appendReleased l c)=output l := rfl

theorem absorbedSuccessorOutput (l : Ledger) (c : Carrier) :
 output (appendAbsorbed l c)=output l++[c] := by
 unfold output appendAbsorbed
 exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem absorbedSuccessorInput (l : Ledger) (c : Carrier) :
 input (appendAbsorbed l c)=input l := rfl

theorem releasedSuccessorCloses (l : Ledger) (c : Carrier) :
 (output (appendReleased l c)).length+(appendReleased l c).released.length=
 (input (appendReleased l c)).length+(appendReleased l c).absorbed.length := systemSurroundingsBalance _
theorem absorbedSuccessorCloses (l : Ledger) (c : Carrier) :
 (output (appendAbsorbed l c)).length+(appendAbsorbed l c).released.length=
 (input (appendAbsorbed l c)).length+(appendAbsorbed l c).absorbed.length := systemSurroundingsBalance _

def history (records : List Record) := records.map fun r =>
 (r.reaction.trace,r.raw,r.phase,r.reference,r.ledger)
theorem base (r : Record) : history [r]=[(r.reaction.trace,r.raw,r.phase,r.reference,r.ledger)] := rfl
theorem successorRetainsFullRecord (rs : List Record) (r : Record) :
 history (rs++[r])=history rs++[(r.reaction.trace,r.raw,r.phase,r.reference,r.ledger)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

def originalRaw : Raw := ⟨⟨3,by decide⟩,⟨2,by decide⟩,
 ⟨"energy-transfer-orientation","released",rfl,rfl⟩,
 ⟨"thermochemical-conditions","state-one",rfl,rfl⟩⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
end SFT.Chemistry.ReactionThermochemistry
