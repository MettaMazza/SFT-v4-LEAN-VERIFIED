import SFT.Chemistry.ReactionThermochemistry
import SFT.Chemistry.ReactionMechanism
import SFT.Chemistry.MolecularCarrier
namespace SFT.Chemistry.Photochemistry
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 photon : HeldLabel
 ground : String
 excited : String
 channel : String

def admit (r : Raw) : Except String Raw :=
 if !(SFT.Host.Text.equal r.photon.family "photon-carrier") ||
 !([r.ground,r.excited,r.channel].all SourceText.nonblank) || decide (r.ground=r.excited) then
 .error "photochemical witness is invalid" else .ok r

structure Channel where
 identity : String
 named : SourceText.nonblank identity=true
 endpoint : String
 path : ReactionMechanism.Mechanism
 starts : String
 chain : ReactionMechanism.Chain starts endpoint path.raw.steps
 energy : ReactionThermochemistry.Record
 reactionBinding : energy.reaction.trace=path.raw.overall

structure Event where
 raw : Raw
 accepted : admit raw=.ok raw
 molecule : MolecularCarrier.Carrier
 moleculeIdentity : String
 namedMolecule : SourceText.nonblank moleculeIdentity=true
 photonEnergy : ReactionThermochemistry.Carrier
 photonBinding : photonEnergy.identity=raw.photon
 excitationStep : ReactionMechanism.Step
 groundBinding : excitationStep.raw.inputState=raw.ground
 excitedBinding : excitationStep.raw.outputState=raw.excited
 excitationLedger : ReactionThermochemistry.Ledger
 oneAbsorbed : excitationLedger.absorbed=[photonEnergy]
 generated : List Channel
 selected : Channel
 selectedHeld : selected∈generated
 selectedIdentity : selected.identity=raw.channel
 accessible : ∀ c∈generated, c.starts=raw.excited
 energyContinuity : ∀ c∈generated, ReactionThermochemistry.input c.energy.ledger=
  ReactionThermochemistry.output excitationLedger

-- A single occurrence has exactly one molecular destination; its input label
-- and provenance remain in the absorption transfer.
def absorption (e : Event) : SFT.Physics.MatterConservedLabels.Flow HeldLabel String :=
 ⟨e.raw.photon,e.raw.photon.label,.output e.moleculeIdentity⟩

theorem oneRadiationInput (e : Event) :
 SFT.Physics.MatterConservedLabels.inputs [absorption e]=[(e.raw.photon,e.raw.photon.label)] := rfl

theorem oneMolecularDestination (e : Event) :
 SFT.Physics.MatterConservedLabels.destinations [absorption e]=[(e.raw.photon,.output e.moleculeIdentity)] := rfl

theorem absorptionDoesNotCopy (e : Event) :
 (SFT.Physics.MatterConservedLabels.destinations [absorption e]).length=1 := rfl

theorem absorbedEnergyIsOriginalPhoton (e : Event) :
 e.excitationLedger.absorbed.map ReactionThermochemistry.Carrier.identity=[e.raw.photon] := by
 rw [e.oneAbsorbed]
 change [e.photonEnergy.identity]=[e.raw.photon]
 rw [e.photonBinding]

theorem excitationEnergyCloses (e : Event) :
 (ReactionThermochemistry.output e.excitationLedger).length+e.excitationLedger.released.length=
 (ReactionThermochemistry.input e.excitationLedger).length+1 := by
 have h := ReactionThermochemistry.systemSurroundingsBalance e.excitationLedger
 rw [e.oneAbsorbed] at h
 exact h

theorem excitedStateDistinct (e : Event) : e.raw.ground≠e.raw.excited := by
 intro same
 have h := e.accepted
 unfold admit at h
 rw [decide_eq_true same] at h
 cases first : !(SFT.Host.Text.equal e.raw.photon.family "photon-carrier") ||
  !([e.raw.ground,e.raw.excited,e.raw.channel].all SourceText.nonblank) <;> rw [first] at h <;> cases h

theorem selectedChannelGenerated (e : Event) : e.selected∈e.generated := e.selectedHeld

theorem selectedChannelStartsExcited (e : Event) : e.selected.starts=e.raw.excited :=
 e.accessible _ e.selectedHeld

theorem selectedPathFromExcitation (e : Event) :
 ReactionMechanism.Chain e.raw.excited e.selected.endpoint e.selected.path.raw.steps := by
 rw [← selectedChannelStartsExcited e]
 exact e.selected.chain

theorem completeExcitationAndChannelPath (e : Event) :
 ReactionMechanism.Chain e.raw.ground e.selected.endpoint
  (e.excitationStep::e.selected.path.raw.steps) := by
 rw [← e.groundBinding]
 exact .cons e.excitationStep e.selected.chain
  (e.excitedBinding.trans (selectedChannelStartsExcited e).symm)

theorem selectedEnergyStartsAtExcitation (e : Event) :
 ReactionThermochemistry.input e.selected.energy.ledger=ReactionThermochemistry.output e.excitationLedger :=
 e.energyContinuity _ e.selectedHeld

theorem everyChannelEnergyCloses (e : Event) (c : Channel) (_held : c∈e.generated) :
 c.energy.raw.outputSupport.value+c.energy.ledger.released.length=
 c.energy.raw.inputSupport.value+c.energy.ledger.absorbed.length :=
 ReactionThermochemistry.completeReactionEnergyBalance _

def endpoints (e : Event) := e.generated.map Channel.endpoint

theorem endpointExactlyGenerated (e : Event) (x : String) :
 x∈endpoints e ↔ ∃ c∈e.generated,c.endpoint=x :=
 ⟨fun h => SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ h,
 fun ⟨c,held,same⟩ => same ▸ SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held⟩

def appendChannel (e : Event) (c : Channel) (starts : c.starts=e.raw.excited)
 (energy : ReactionThermochemistry.input c.energy.ledger=ReactionThermochemistry.output e.excitationLedger) : Event :=
 { e with generated := e.generated++[c],
          selectedHeld := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ e.selectedHeld,
          accessible := by
           intro x held
           cases SFT.Foundation.Count.TraceDerivation.memAppendCases x e.generated [c] held with
           | inl old => exact e.accessible x old
           | inr fresh => cases fresh with
             | head => exact starts
             | tail _ h => cases h
          energyContinuity := by
           intro x held
           cases SFT.Foundation.Count.TraceDerivation.memAppendCases x e.generated [c] held with
           | inl old => exact e.energyContinuity x old
           | inr fresh => cases fresh with
             | head => exact energy
             | tail _ h => cases h }

theorem successorRetainsPhoton (e : Event) (c : Channel) (starts : c.starts=e.raw.excited)
 (energy : ReactionThermochemistry.input c.energy.ledger=ReactionThermochemistry.output e.excitationLedger) :
 (appendChannel e c starts energy).raw.photon=e.raw.photon ∧
 (appendChannel e c starts energy).excitationLedger=e.excitationLedger := ⟨rfl,rfl⟩

theorem successorAddsOnlyGeneratedEndpoint (e : Event) (c : Channel) (starts : c.starts=e.raw.excited)
 (energy : ReactionThermochemistry.input c.energy.ledger=ReactionThermochemistry.output e.excitationLedger) :
 endpoints (appendChannel e c starts energy)=endpoints e++[c.endpoint] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem successorPreservesChannelEnergy (e : Event) (c : Channel) (starts : c.starts=e.raw.excited)
 (energy : ReactionThermochemistry.input c.energy.ledger=ReactionThermochemistry.output e.excitationLedger)
 (x : Channel) (held : x∈(appendChannel e c starts energy).generated) :
 x.energy.raw.outputSupport.value+x.energy.ledger.released.length=
 x.energy.raw.inputSupport.value+x.energy.ledger.absorbed.length :=
 everyChannelEnergyCloses _ _ held

def originalRaw : Raw := ⟨⟨"photon-carrier","photon-one",rfl,rfl⟩,"ground","excited","reaction-channel-one"⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
end SFT.Chemistry.Photochemistry
