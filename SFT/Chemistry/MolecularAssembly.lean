import SFT.Mathematics.ExactTraceArithmetic
import SFT.Chemistry.MolecularGeometry
namespace SFT.Chemistry.MolecularAssembly
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
open SFT.Foundation.Count.TraceDerivation
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Interaction where
 left : String
 right : String
 channel : HeldLabel
structure Raw where
 carriers : List String
 interactions : List Interaction

def edge (row : Interaction) : Edge := (row.left,row.right)
def edges (raw : Raw) := raw.interactions.map edge

def checkInteractions (nodes : List String) : List Interaction → Except String Unit
 | [] => .ok ()
 | row::rest =>
   if !has nodes row.left || !has nodes row.right || decide (row.left=row.right) then
    .error "an assembly interaction must join registered distinct carriers"
   else if !has ["intermolecular","recognition","network"] row.channel.family then
    .error "an assembly interaction has an unregistered channel family"
   else checkInteractions nodes rest

def admit (raw : Raw) : Except String Raw :=
 if raw.carriers.length<2 || !distinct raw.carriers then
  .error "an assembly requires multiple distinct molecular carriers"
 else do
  checkInteractions raw.carriers raw.interactions
  if (edges raw).isEmpty || !MolecularCarrier.connected raw.carriers (edges raw) then
   .error "an assembly must be connected at its declared boundary"
  else .ok raw

structure Assembly where
 raw : Raw
 accepted : admit raw=.ok raw

def interactionCount (raw : Raw) := raw.interactions.length

def append (raw : Raw) (fresh anchor : String) (channel : HeldLabel) : Raw :=
 ⟨raw.carriers++[fresh],raw.interactions++[⟨anchor,fresh,channel⟩]⟩

theorem identitiesRetained (raw : Raw) (fresh anchor : String) (channel : HeldLabel)
 (prior : String) (held : prior∈raw.carriers) : prior∈(append raw fresh anchor channel).carriers :=
 memAppendLeft _ _ _ held

theorem channelsRetained (raw : Raw) (fresh anchor : String) (channel : HeldLabel)
 (prior : Interaction) (held : prior∈raw.interactions) : prior∈(append raw fresh anchor channel).interactions :=
 memAppendLeft _ _ _ held

theorem appendEdges (raw : Raw) (fresh anchor : String) (channel : HeldLabel) :
 edges (append raw fresh anchor channel)=edges raw++[(anchor,fresh)] := by
 exact SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem appendConnectivity (raw : Raw) (first : String) (rest : List String)
 (names : raw.carriers=first::rest) (fresh anchor : String) (channel : HeldLabel)
 (covered : ∀ e ∈ edges raw, e.1∈raw.carriers ∧ e.2∈raw.carriers)
 (connected : MolecularCarrier.connected raw.carriers (edges raw)=true)
 (held : anchor∈raw.carriers) :
 MolecularCarrier.connected (append raw fresh anchor channel).carriers (edges (append raw fresh anchor channel))=true := by
 rw [appendEdges]
 change MolecularCarrier.connected (raw.carriers++[fresh]) (edges raw++[(anchor,fresh)])=true
 rw [names] at connected held covered ⊢
 exact MolecularCarrier.adjacentOccurrencePreservesConnectivity first rest (edges raw) anchor fresh covered connected held

def sourceChannel : HeldLabel := ⟨"intermolecular","residual-channel",rfl,rfl⟩
def originalPair : Raw := ⟨["molecule-one","molecule-two"],[⟨"molecule-one","molecule-two",sourceChannel⟩]⟩
theorem originalPairCount : interactionCount originalPair=1 := rfl
theorem acceptedConditions (raw output : Raw) (success : admit raw=.ok output) :
 checkInteractions raw.carriers raw.interactions=.ok () ∧
 (edges raw).isEmpty=false ∧ MolecularCarrier.connected raw.carriers (edges raw)=true ∧ output=raw := by
 unfold admit at success
 split at success
 · cases success
 · cases checks : checkInteractions raw.carriers raw.interactions with
   | error message => rw [checks] at success; cases success
   | ok result =>
     cases result
     rw [checks] at success
     change (if (edges raw).isEmpty || !MolecularCarrier.connected raw.carriers (edges raw) then
      Except.error "an assembly must be connected at its declared boundary" else Except.ok raw)=Except.ok output at success
     cases empty : (edges raw).isEmpty with
     | true => rw [empty] at success; cases success
     | false =>
       rw [empty] at success
       cases connected : MolecularCarrier.connected raw.carriers (edges raw) with
       | false => rw [connected] at success; cases success
       | true =>
         rw [connected] at success
         exact ⟨rfl,rfl,rfl,(Except.ok.inj success).symm⟩

theorem interactionCountPositive (assembly : Assembly) : 0<interactionCount assembly.raw := by
 have nonempty := (acceptedConditions _ _ assembly.accepted).2.1
 cases rows : assembly.raw.interactions with
 | nil => change (assembly.raw.interactions.map edge).isEmpty=false at nonempty; rw [rows] at nonempty; cases nonempty
 | cons first rest => change 0<assembly.raw.interactions.length; rw [rows]; exact Nat.zero_lt_succ _

structure Collective where
 assembly : Assembly
 constituents : List EntityIdentity.Entity
 completeIdentities : constituents.map EntityIdentity.Entity.carrier=assembly.raw.carriers
 actions : List (Interaction × List String)
 completeChannels : actions.map Prod.fst=assembly.raw.interactions
 recurrence : BondClosure.Recurrence
 completeActions : actions.flatMap Prod.snd=recurrence.steps
 observationBoundary : SFT.Host.Canonical.Value

theorem collectiveRecurrence (record : Collective) :
 SFT.QuantumComputation.ReversibleModel.phaseAction record.recurrence.prepared.state
 (record.actions.flatMap Prod.snd)=.ok record.recurrence.prepared.state := by
 rw [record.completeActions]
 exact BondClosure.jointReturn record.recurrence

theorem allMolecularIdentitiesRetained (record : Collective) :
 record.constituents.map EntityIdentity.Entity.carrier=record.assembly.raw.carriers := record.completeIdentities
theorem originalPairConnected : MolecularCarrier.connected originalPair.carriers (edges originalPair)=true := by
 apply MolecularCarrier.connectedFromPaths
 · intro target held
   cases held with
   | head => exact ⟨[],by decide,rfl⟩
   | tail _ tail =>
     cases tail with
     | head => exact ⟨["molecule-one"],by decide,rfl⟩
     | tail _ impossible => cases impossible
 · intro target path
   apply MolecularCarrier.helperNodesKnown _ _ _ target (pathWitnessTarget _ _ _ path)
   intro edge held
   cases held with
   | head => exact ⟨.head _,.tail _ (.head [])⟩
   | tail _ impossible => cases impossible

theorem originalPairAdmitted : admit originalPair=.ok originalPair := by
 unfold admit
 change (if !MolecularCarrier.connected originalPair.carriers (edges originalPair) then _ else _)=_
 rw [originalPairConnected]
 rfl
end SFT.Chemistry.MolecularAssembly
