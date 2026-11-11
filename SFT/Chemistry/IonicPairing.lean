import SFT.Chemistry.IonTransfer
import SFT.Chemistry.BondClosure
import SFT.Chemistry.ExactComposition
namespace SFT.Chemistry.IonicPairing
open SFT.Physics

-- One source transfer is viewed at its two retained endpoints.
def otherEndpoint (transfer : IonTransfer.Transfer) : IonTransfer.Transfer :=
 {transfer with direction := match transfer.direction with
  | .incoming => .outgoing
  | .outgoing => .incoming}

theorem pairedOrientation (transfer : IonTransfer.Transfer) :
 IonTransfer.contribution (otherEndpoint transfer) =
 MechanicalLocation.opposite (IonTransfer.contribution transfer) := by
 cases transfer with
 | mk held direction source trace => cases direction <;> cases held <;> rfl

theorem pairedSource (transfer : IonTransfer.Transfer) :
 (otherEndpoint transfer).sourceIdentity=transfer.sourceIdentity ∧
 (otherEndpoint transfer).sourceTrace=transfer.sourceTrace ∧
 (otherEndpoint transfer).held=transfer.held := ⟨rfl,rfl,rfl⟩

theorem endpointReversal (transfer : IonTransfer.Transfer) :
 otherEndpoint (otherEndpoint transfer)=transfer := by
 cases transfer with
 | mk held direction source trace => cases direction <;> rfl

def endpointCharge (transfer : IonTransfer.Transfer) : FieldElectricDistinction.Charge :=
 ⟨⟨1,1,by decide,by decide,by decide⟩,IonTransfer.contribution transfer⟩

theorem endpointChargesOpposed (transfer : IonTransfer.Transfer) :
 FieldElectricDistinction.interaction (endpointCharge transfer) (endpointCharge (otherEndpoint transfer)) =
 .oppositeHeld := by
 cases transfer with
 | mk held direction source trace => cases direction <;> cases held <;> rfl

theorem closedHistory (history : List IonTransfer.Transfer) :
 MechanicalConservation.outgoingSupport (history.map IonTransfer.edge) =
 MechanicalConservation.incomingSupport (history.map IonTransfer.edge) :=
 IonTransfer.closedTransferConservation history

theorem bothCarrierIdentitiesRetained (left right : IonTransfer.State) (transfer : IonTransfer.Transfer) :
 (IonTransfer.append left transfer).carrier=left.carrier ∧
 (IonTransfer.append right (otherEndpoint transfer)).carrier=right.carrier := ⟨rfl,rfl⟩

def firstIon (carrier : IonTransfer.Carrier) (transfer : IonTransfer.Transfer) : IonTransfer.State :=
 ⟨carrier,⟨0,0⟩,[transfer]⟩

theorem firstIonCharge (carrier : IonTransfer.Carrier) (transfer : IonTransfer.Transfer) :
 IonTransfer.charge (firstIon carrier transfer) =
 .charged (IonTransfer.contribution transfer) 1 (by decide) := by
 cases transfer with
 | mk held direction source trace => cases direction <;> cases held <;> rfl

theorem firstIonAdmitted (carrier : IonTransfer.Carrier) (transfer : IonTransfer.Transfer) :
 IonTransfer.isIon (firstIon carrier transfer) := by
 intro neutral
 rw [firstIonCharge] at neutral
 cases neutral

-- The count and orientation are tied to the computed ion ledger, not supplied
-- as an independently selected charge.
structure ChargeRecord where
 occurrence : String
 state : IonTransfer.State
 held : IonTransfer.Held
 count : Nat
 positive : 0 < count
 computed : IonTransfer.charge state = .charged held count positive

def physicalCharge (record : ChargeRecord) : FieldElectricDistinction.Charge :=
 ⟨SFT.Foundation.ExactOperations.normalizePositive record.count 1 record.positive (by decide),record.held⟩

theorem recordedIonAdmitted (record : ChargeRecord) : IonTransfer.isIon record.state := by
 intro neutral
 rw [record.computed] at neutral
 cases neutral

structure Pair where
 left : ChargeRecord
 right : ChargeRecord
 opposed : right.held = MechanicalLocation.opposite left.held
 bond : BondClosure.Record
 leftBinding : left.occurrence = bond.support.raw.left
 rightBinding : right.occurrence = bond.support.raw.right

theorem opposedInteraction (pair : Pair) :
 FieldElectricDistinction.interaction (physicalCharge pair.left) (physicalCharge pair.right) = .oppositeHeld := by
 unfold FieldElectricDistinction.interaction physicalCharge
 rw [pair.opposed]
 cases pair.left.held <;> rfl

theorem pairedIonsRetained (pair : Pair) :
 IonTransfer.isIon pair.left.state ∧ IonTransfer.isIon pair.right.state :=
 ⟨recordedIonAdmitted pair.left,recordedIonAdmitted pair.right⟩

theorem pairRecurs (pair : Pair) :
 SFT.QuantumComputation.ReversibleModel.phaseAction pair.bond.recurrence.prepared.state
 (pair.bond.interactionTrace.flatMap Prod.snd) = .ok pair.bond.recurrence.prepared.state :=
 BondClosure.sourceInteractionReturns pair.bond

def transferLedger (pair : Pair) := (pair.left.state.transfers,pair.right.state.transfers)

theorem completeTransferClosure (pair : Pair) :
 MechanicalConservation.outgoingSupport (pair.left.state.transfers.map IonTransfer.edge) =
 MechanicalConservation.incomingSupport (pair.left.state.transfers.map IonTransfer.edge) ∧
 MechanicalConservation.outgoingSupport (pair.right.state.transfers.map IonTransfer.edge) =
 MechanicalConservation.incomingSupport (pair.right.state.transfers.map IonTransfer.edge) :=
 ⟨closedHistory _,closedHistory _⟩

def interactionLedger (pairs : List Pair) := pairs.map (fun p => p.bond.interactionTrace)

theorem appendInteractionLedger (pairs : List Pair) (next : Pair) :
 interactionLedger (pairs++[next]) = interactionLedger pairs ++ [next.bond.interactionTrace] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem appendedPairRetained (pairs : List Pair) (next prior : Pair) (member : prior ∈ pairs) :
 prior ∈ pairs++[next] := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ member

-- Ionic and shared support may coexist. The original exact composition
-- closes their complete retained parts to One; no fitted cutoff is present.
structure Character where
 firstIonic : ExactComposition.Component
 otherIonic : List ExactComposition.Component
 shared : List ExactComposition.Component
 complete : ExactComposition.exactComposition (firstIonic::otherIonic++shared) =
   .ok (firstIonic::otherIonic++shared)

def ionicComponents (character : Character) := character.firstIonic::character.otherIonic
def wholeComponents (character : Character) := ionicComponents character ++ character.shared

def ionicShare (character : Character) := ExactComposition.total (ionicComponents character)

theorem shareFromCompleteIonicSupport (character : Character) : ionicShare character =
 SFT.Physics.CosmoSpatialFlatness.naturalTotal (ExactComposition.parts (ionicComponents character)) := rfl

theorem completePartitionAssembly (character : Character) :
 ExactComposition.total (wholeComponents character) =
 SFT.Physics.CosmoSpatialFlatness.naturalTotal (ExactComposition.parts character.shared)
 (ionicShare character).1 (ionicShare character).2 := by
 unfold wholeComponents ExactComposition.total
 rw [ExactComposition.partsAppend]
 exact SFT.Physics.CosmoSpatialFlatness.totalAppend _ _ _ _

theorem wholePartitionCloses (character : Character) :
 (ExactComposition.total (wholeComponents character)).1 =
 (ExactComposition.total (wholeComponents character)).2 := by
 have complete := character.complete
 unfold ExactComposition.exactComposition at complete
 split at complete
 · cases complete
 · split at complete
   · rename_i equal; exact equal
   · cases complete

def classRecord (pair : Pair) (character : Character) :=
 (pair.left.state,pair.right.state,pair.bond,wholeComponents character)

theorem observedScaleDoesNotSelect (pair : Pair) (character : Character)
 (first second : SFT.Host.Canonical.Value) :
 ((classRecord pair character),first).1 = ((classRecord pair character),second).1 := rfl

end SFT.Chemistry.IonicPairing

