import SFT.Chemistry.ConjugatePair
import SFT.Physics.MatterConservedLabels
namespace SFT.Chemistry.ProtonTransfer
open SFT.Foundation.Count.TraceDerivation
open SFT.Physics.MatterConservedLabels
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 carrier : HeldLabel
 donor : String
 acceptor : String

def admit (raw : Raw) : Except String Raw :=
 if !SourceText.nonblank raw.donor || !SourceText.nonblank raw.acceptor || decide (raw.donor=raw.acceptor) then
  .error "a transfer requires distinct named endpoint occurrences"
 else .ok raw
structure Transfer where
 raw : Raw
 accepted : admit raw=.ok raw

def flow (raw : Raw) : Flow HeldLabel String := ⟨raw.carrier,raw.donor,.output raw.acceptor⟩
def input (raw : Raw) := (raw.carrier,raw.donor)
def output (raw : Raw) := (raw.carrier,raw.acceptor)
def flows (rows : List Raw) := rows.map flow

theorem carrierConserved (raw : Raw) : (input raw).1=(output raw).1 := rfl
theorem donorRecorded (raw : Raw) : (flow raw).input=raw.donor := rfl
theorem acceptorRecorded (raw : Raw) : (flow raw).destination=.output raw.acceptor := rfl
theorem endpointsDistinct (event : Transfer) : event.raw.donor≠event.raw.acceptor := by
 intro equal
 have success := event.accepted
 unfold admit at success
 rw [equal,decide_eq_true rfl] at success
 cases a : SourceText.nonblank event.raw.acceptor <;> rw [a] at success <;> cases success

theorem exactContinuity (test : HeldLabel → Bool) (rows : List Raw) :
 inputCount test (flows rows)=outputCount test (flows rows)+boundaryCount test (flows rows) :=
 exactCompleteLabelContinuity test (flows rows)

theorem closedBoundary (test : HeldLabel → Bool) (rows : List Raw) : boundaryCount test (flows rows)=0 := by
 induction rows with
 | nil => rfl
 | cons first rest ih => exact ih

theorem pairedDonorLossAcceptorGain (test : HeldLabel → Bool) (rows : List Raw) :
 inputCount test (flows rows)=outputCount test (flows rows) := by
 have conserved := exactContinuity test rows
 rw [closedBoundary,Nat.add_zero] at conserved
 exact conserved

theorem fullCarrierSequence (rows : List Raw) :
 (inputs (flows rows)).map Prod.fst=(destinations (flows rows)).map Prod.fst :=
 fullLabelSequenceRetained (flows rows)

def append (rows : List Raw) (event : Raw) := rows++[event]
theorem priorTransferRetained (rows : List Raw) (event prior : Raw) (held : prior∈rows) :
 prior∈append rows event := memAppendLeft _ _ _ held
theorem successorFlow (rows : List Raw) (event : Raw) : flows (append rows event)=flows rows++[flow event] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend flow rows [event]
theorem successorConserved (rows : List Raw) (event : Raw) (test : HeldLabel → Bool) :
 inputCount test (flows (append rows event))=outputCount test (flows (append rows event)) :=
 pairedDonorLossAcceptorGain test (append rows event)

def original : Raw := ⟨ConjugatePair.originalProton,"donor-occurrence","acceptor-occurrence"⟩
theorem originalAdmitted : admit original=.ok original := rfl
theorem originalProtonRetained : original.carrier=ConjugatePair.originalProton := rfl
theorem baseOneTransfer : (flows [original]).length=1 := rfl
end SFT.Chemistry.ProtonTransfer
