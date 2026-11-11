import SFT.Physics.ThermoHeatWork
namespace SFT.Physics.SuperconductivityLabelClosure
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.InformationScience

-- Specialize the existing complete retained/closed distinction ledger to
-- motion records sharing a collective label. No endpoint scalar test occurs.
-- Both projections are computed from the same original source carriers.
-- A retained carrier does not require a transfer; closed paths remain admitted.
-- The first held label is motion; the second is the collective recurrence.
def motionMap (carriers : List (String × (String × String))) :=
 carriers.map (fun row => (row.1,row.2.1))

def collectiveMap (carriers : List (String × (String × String))) :=
 carriers.map (fun row => (row.1,row.2.2))

structure MotionRecord (Node : Type) where
 transfers : ThermoHeatWork.ObservedTransfers Node (String × String)
 carriers : List (String × (String × String))
 motionComplete : ConservationLedger.validateTransformation transfers.sourceSupport (motionMap carriers) = .ok (motionMap carriers)
 collectiveComplete : ConservationLedger.validateTransformation transfers.sourceSupport (collectiveMap carriers) = .ok (collectiveMap carriers)
 transferCarriersBound : ∀ transfer, transfer ∈ transfers.network →
   (transfer.sourceIdentity,transfer.carrier) ∈ carriers

variable {Node : Type}

def motionLabel (r : MotionRecord Node) := image (motionMap r.carriers)
def collectiveLabel (r : MotionRecord Node) := image (collectiveMap r.carriers)

def compatible (r : MotionRecord Node) (pair : String × String) : Bool :=
 decide ((motionLabel r) pair.1 ≠ (motionLabel r) pair.2 ∧
   (collectiveLabel r) pair.1 = (collectiveLabel r) pair.2)

def closedMotionDistinctions (r : MotionRecord Node) :=
 (ThermoHeatWork.closedLabels r.transfers).filter (compatible r)

theorem closedMotionExactly (r : MotionRecord Node) (pair : String × String) :
 pair ∈ closedMotionDistinctions r ↔
 pair ∈ EncodingLoss.sourcePairs r.transfers.sourceSupport ∧
 image r.transfers.receiver pair.1 = image r.transfers.receiver pair.2 ∧
 (motionLabel r) pair.1 ≠ (motionLabel r) pair.2 ∧
 (collectiveLabel r) pair.1 = (collectiveLabel r) pair.2 := by
 constructor
 · intro held
   have selected := (filterMemberIff _ _ _).mp held
   have closed := (ThermoHeatWork.closedMeaning r.transfers pair).mp selected.1
   have labels := of_decide_eq_true selected.2
   exact ⟨closed.1,closed.2,labels⟩
 · intro ⟨held,closed,labels⟩
   exact (filterMemberIff _ _ _).mpr
     ⟨(ThermoHeatWork.closedMeaning r.transfers pair).mpr ⟨held,closed⟩,
      decide_eq_true labels⟩

theorem emptyClosureIffMotionDistinctionsRetained (r : MotionRecord Node) :
 closedMotionDistinctions r = [] ↔
 ∀ pair, pair ∈ EncodingLoss.sourcePairs r.transfers.sourceSupport →
   (collectiveLabel r) pair.1 = (collectiveLabel r) pair.2 →
   image r.transfers.receiver pair.1 = image r.transfers.receiver pair.2 →
   (motionLabel r) pair.1 = (motionLabel r) pair.2 := by
 constructor
 · intro empty pair held collective observed
   by_cases same : (motionLabel r) pair.1 = (motionLabel r) pair.2
   · exact same
   · have member := (closedMotionExactly r pair).mpr ⟨held,observed,same,collective⟩
     rw [empty] at member
     cases member
 · intro recoverable
   cases rows : closedMotionDistinctions r with
   | nil => rfl
   | cons pair rest =>
     have member : pair ∈ closedMotionDistinctions r := by rw [rows]; exact .head _
     have h := (closedMotionExactly r pair).mp member
     exact False.elim (h.2.2.1 (recoverable pair h.1 h.2.2.2 h.2.1))

theorem closedMotionCannotBeDecoded (r : MotionRecord Node)
 (pair : String × String) (closed : pair ∈ closedMotionDistinctions r)
 (decode : Option String → Option String)
 (left : decode (image r.transfers.receiver pair.1) = (motionLabel r) pair.1)
 (right : decode (image r.transfers.receiver pair.2) = (motionLabel r) pair.2) : False := by
 have h := (closedMotionExactly r pair).mp closed
 exact h.2.2.1 (left.symm.trans ((congrArg decode h.2.1).trans right))

theorem completeTransfersRemainConserved (r : MotionRecord Node) :
 MechanicalConservation.outgoingSupport r.transfers.network =
 MechanicalConservation.incomingSupport r.transfers.network :=
 ThermoHeatWork.completeEnergyProvenance r.transfers

-- A closed identity observation is admitted with retained source carriers
-- even when no transfer occurs. This checks the no-transfer source boundary.
def identityRecord : MotionRecord String where
 transfers := {
   network := []
   sourceSupport := ["carrier"]
   receiver := [("carrier","observed")]
   valid := by rfl
   sourceLabelsPresent := by intro transfer held; cases held
 }
 carriers := [("carrier",("motion","collective"))]
 motionComplete := by rfl
 collectiveComplete := by rfl
 transferCarriersBound := by intro transfer held; cases held

theorem noTransferIdentityAdmitted : closedMotionDistinctions identityRecord = [] := rfl

end SFT.Physics.SuperconductivityLabelClosure
