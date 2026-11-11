import SFT.Chemistry.MolecularAssembly
namespace SFT.Chemistry.SupramolecularRelease
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
abbrev Raw := MolecularAssembly.Raw
abbrev Interaction := MolecularAssembly.Interaction

-- The source opening retains both the complete carrier list and its channels.
structure Released where
 carriers : List String
 channels : List Interaction

def release (raw : Raw) : Released := ⟨raw.carriers,raw.interactions⟩
def reconstruct (opened : Released) : Raw := ⟨opened.carriers,opened.channels⟩

theorem exactReconstruction (raw : Raw) : reconstruct (release raw)=raw := by cases raw; rfl
theorem exactRelease (opened : Released) : release (reconstruct opened)=opened := by cases opened; rfl

theorem closingAfterRelease (assembly : MolecularAssembly.Assembly) :
 MolecularAssembly.admit (reconstruct (release assembly.raw))=.ok assembly.raw := by
 rw [exactReconstruction]
 exact assembly.accepted

theorem everyComponentRecovered (raw : Raw) (name : String) (held : name∈raw.carriers) :
 name∈(release raw).carriers := held

theorem everyChannelRecovered (raw : Raw) (row : Interaction) (held : row∈raw.interactions) :
 row∈(release raw).channels := held

structure NamedComponent where
 name : String
 molecule : MolecularCarrier.Carrier
 identity : EntityIdentity.Entity
 identityName : identity.carrier=name

structure Recognition where
 row : Interaction
 family : row.channel.family="recognition"

structure Whole where
 collective : MolecularAssembly.Collective
 components : List NamedComponent
 completeComponents : components.map NamedComponent.name=collective.assembly.raw.carriers
 completeIdentityRecords : components.map NamedComponent.identity=collective.constituents
 recognition : List Recognition
 completeRecognition : recognition.map Recognition.row=collective.assembly.raw.interactions

def releasedComponents (whole : Whole) := whole.components

theorem intactMoleculeRecovered (whole : Whole) (part : NamedComponent) (held : part∈whole.components) :
 part∈releasedComponents whole := held

theorem completeMolecularGraphsRetained (whole : Whole) :
 (releasedComponents whole).map (fun part => part.molecule.raw)=whole.components.map (fun part => part.molecule.raw) := rfl

theorem recognitionTraceRetained (whole : Whole) :
 (release whole.collective.assembly.raw).channels=whole.recognition.map Recognition.row := whole.completeRecognition.symm

theorem collectiveRecurs (whole : Whole) :
 SFT.QuantumComputation.ReversibleModel.phaseAction whole.collective.recurrence.prepared.state
 (whole.collective.actions.flatMap Prod.snd)=.ok whole.collective.recurrence.prepared.state :=
 MolecularAssembly.collectiveRecurrence whole.collective

theorem admittedMultipleSupport (assembly : MolecularAssembly.Assembly) :
 2 ≤ assembly.raw.carriers.length := by
 have accepted := assembly.accepted
 unfold MolecularAssembly.admit at accepted
 split at accepted
 · cases accepted
 · rename_i guard
   apply Nat.le_of_not_gt
   intro small
   have yes : decide (assembly.raw.carriers.length<2)=true := decide_eq_true small
   rw [yes] at guard
   exact guard rfl

theorem wholeSupportDistinctFromComponent (whole : Whole) (name : String) :
 whole.collective.assembly.raw.carriers≠[name] := by
 intro same
 have enough := admittedMultipleSupport whole.collective.assembly
 rw [same] at enough
 exact Nat.not_succ_le_self 1 enough

theorem successorReleaseReconstruction (raw : Raw) (fresh anchor : String) (channel : MolecularAssembly.HeldLabel) :
 reconstruct (release (MolecularAssembly.append raw fresh anchor channel))=
 MolecularAssembly.append raw fresh anchor channel := exactReconstruction _

theorem successorRetainsPriorComponents (raw : Raw) (fresh anchor : String) (channel : MolecularAssembly.HeldLabel)
 (prior : String) (held : prior∈raw.carriers) :
 prior∈(release (MolecularAssembly.append raw fresh anchor channel)).carriers :=
 MolecularAssembly.identitiesRetained raw fresh anchor channel prior held

theorem successorRetainsPriorRecognition (raw : Raw) (fresh anchor : String) (channel : MolecularAssembly.HeldLabel)
 (prior : Interaction) (held : prior∈raw.interactions) :
 prior∈(release (MolecularAssembly.append raw fresh anchor channel)).channels :=
 MolecularAssembly.channelsRetained raw fresh anchor channel prior held

def sourceChannel : MolecularAssembly.HeldLabel := ⟨"recognition","complementary-held-labels",rfl,rfl⟩
def originalHostGuest : Raw := ⟨["host","guest"],[⟨"host","guest",sourceChannel⟩]⟩
theorem originalRecognitionCount : MolecularAssembly.interactionCount originalHostGuest=1 := rfl
theorem originalComponentsRecovered : (release originalHostGuest).carriers=["host","guest"] := rfl

theorem originalHostGuestConnected : MolecularCarrier.connected originalHostGuest.carriers (MolecularAssembly.edges originalHostGuest)=true := by
 apply MolecularCarrier.connectedFromPaths
 · intro target held
   cases held with
   | head => exact ⟨[],by decide,rfl⟩
   | tail _ tail =>
     cases tail with
     | head => exact ⟨["host"],by decide,rfl⟩
     | tail _ impossible => cases impossible
 · intro target path
   apply MolecularCarrier.helperNodesKnown _ _ _ target (pathWitnessTarget _ _ _ path)
   intro edge held
   cases held with
   | head => exact ⟨.head _,.tail _ (.head [])⟩
   | tail _ impossible => cases impossible

theorem originalHostGuestAdmitted : MolecularAssembly.admit originalHostGuest=.ok originalHostGuest := by
 unfold MolecularAssembly.admit
 change (if !MolecularCarrier.connected originalHostGuest.carriers (MolecularAssembly.edges originalHostGuest) then _ else _)=_
 rw [originalHostGuestConnected]
 rfl
end SFT.Chemistry.SupramolecularRelease
