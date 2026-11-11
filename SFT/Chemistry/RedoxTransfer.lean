import SFT.Chemistry.ProtonTransfer
import SFT.Chemistry.OxidationAssignment
namespace SFT.Chemistry.RedoxTransfer
open SFT.Foundation.Count.TraceDerivation SFT.Physics.MatterConservedLabels
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 electron : HeldLabel
 donor : String
 acceptor : String

def admit (r : Raw) : Except String Raw :=
 if !(SFT.Host.Text.equal r.electron.family "electron-carrier") ||
 !SourceText.nonblank r.donor || !SourceText.nonblank r.acceptor || decide (r.donor=r.acceptor) then
 .error "redox transfer requires one retained electron and distinct endpoints"
 else .ok r
structure Transfer where
 raw : Raw
 accepted : admit raw = .ok raw

def original : Raw := ⟨⟨"electron-carrier","electron-one",rfl,rfl⟩,"oxidation-site","reduction-site"⟩
theorem originalAdmitted : admit original = .ok original := rfl

def retainedTransfer (r : Raw) : ProtonTransfer.Raw := ⟨r.electron,r.donor,r.acceptor⟩
def flows (rows : List Raw) := ProtonTransfer.flows (rows.map retainedTransfer)
theorem electronIdentityRetained (r : Raw) : (retainedTransfer r).carrier=r.electron := rfl

theorem endpointsDistinct (t : Transfer) : t.raw.donor ≠ t.raw.acceptor := by
 intro same
 have h := t.accepted
 unfold admit at h
 rw [same,decide_eq_true rfl] at h
 cases f : SFT.Host.Text.equal t.raw.electron.family "electron-carrier" <;>
 cases n : SourceText.nonblank t.raw.acceptor <;> rw [f,n] at h <;> cases h

theorem fullElectronSequence (rows : List Raw) :
 (inputs (flows rows)).map Prod.fst=(destinations (flows rows)).map Prod.fst :=
 ProtonTransfer.fullCarrierSequence (rows.map retainedTransfer)

theorem pairedLossGain (test : HeldLabel → Bool) (rows : List Raw) :
 inputCount test (flows rows)=outputCount test (flows rows) :=
 ProtonTransfer.pairedDonorLossAcceptorGain test (rows.map retainedTransfer)

theorem noUnregisteredBoundary (test : HeldLabel → Bool) (rows : List Raw) :
 boundaryCount test (flows rows)=0 := ProtonTransfer.closedBoundary test (rows.map retainedTransfer)

inductive Role where
 | loss | gain
 deriving DecidableEq
structure Half where
 electron : HeldLabel
 site : String
 role : Role

def donorLoss (r : Raw) : Half := ⟨r.electron,r.donor,.loss⟩
def acceptorGain (r : Raw) : Half := ⟨r.electron,r.acceptor,.gain⟩
def coupled (r : Raw) : List Half := [donorLoss r,acceptorGain r]

theorem sameElectronBothHalves (r : Raw) : (donorLoss r).electron=(acceptorGain r).electron := rfl
theorem opposedRoles (r : Raw) : (donorLoss r).role ≠ (acceptorGain r).role := by intro h; cases h
theorem exactlyTwoEndpoints (r : Raw) : (coupled r).length=2 := rfl

def Closes (r : Raw) (halves : List Half) : Prop := halves=coupled r

theorem oneLossCannotClose (r : Raw) : ¬Closes r [donorLoss r] := by
 intro h
 have sizes := congrArg List.length h
 exact (by decide : (1 : Nat) ≠ 2) sizes

theorem oneGainCannotClose (r : Raw) : ¬Closes r [acceptorGain r] := by
 intro h
 have sizes := congrArg List.length h
 exact (by decide : (1 : Nat) ≠ 2) sizes

theorem completePairCloses (r : Raw) : Closes r (coupled r) := rfl

def history (rows : List Raw) := rows.map fun r => (r,coupled r)
theorem base : history [original] = [(original,[donorLoss original,acceptorGain original])] := rfl

theorem completeSourceHistory (rows : List Raw) : (history rows).map Prod.fst=rows := by
 induction rows with
 | nil => rfl
 | cons r rest ih => exact congrArg (List.cons r) ih

theorem successor (rows : List Raw) (next : Raw) :
 history (rows++[next])=history rows++[(next,coupled next)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem priorEventRetained (rows : List Raw) (next prior : Raw) (held : prior∈rows) :
 prior∈(history (rows++[next])).map Prod.fst := by
 rw [completeSourceHistory]; exact memAppendLeft _ _ _ held

theorem successorConserves (rows : List Raw) (next : Raw) (test : HeldLabel → Bool) :
 inputCount test (flows (rows++[next]))=outputCount test (flows (rows++[next])) := pairedLossGain _ _
end SFT.Chemistry.RedoxTransfer
