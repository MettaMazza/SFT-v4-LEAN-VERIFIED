import SFT.Chemistry.ProtonTransfer
namespace SFT.Chemistry.LewisPair
open SFT.Foundation.Count.TraceDerivation
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 donor : String
 acceptor : String
 electrons : List HeldLabel

def invalidEndpoints (raw : Raw) := !SourceText.nonblank raw.donor || !SourceText.nonblank raw.acceptor || decide (raw.donor=raw.acceptor)
def invalidFamily (raw : Raw) := raw.electrons.any (fun e => !(SFT.Host.Text.equal e.family "electron-carrier"))
def message := "a Lewis relation requires distinct endpoints and two retained electron occurrences"
def admit (raw : Raw) : Except String Raw :=
 if invalidEndpoints raw || invalidFamily raw then .error message
 else match raw.electrons with
 | [] | [_] => .error "tuple index out of range"
 | first::second::_rest => if first=second then .error message else .ok raw

-- The declared source tuple has two entries; raw admission retains Python's executable guard.
structure Relation where
 donor : String
 acceptor : String
 first : HeldLabel
 second : HeldLabel
 accepted : admit ⟨donor,acceptor,[first,second]⟩=.ok ⟨donor,acceptor,[first,second]⟩
def raw (pair : Relation) : Raw := ⟨pair.donor,pair.acceptor,[pair.first,pair.second]⟩
def occurrences (pair : Relation) := [pair.first,pair.second]
theorem exactlyTwo (pair : Relation) : (occurrences pair).length=2 := rfl

theorem exclusion (pair : Relation) : pair.first≠pair.second := by
 intro same
 have h := pair.accepted
 unfold admit at h
 split at h
 · cases h
 · change (if pair.first=pair.second then Except.error message else .ok (raw pair))=.ok (raw pair) at h
   rw [ite_eq_left same] at h; cases h

theorem endpointsDistinct (pair : Relation) : pair.donor≠pair.acceptor := by
 intro same
 have h := pair.accepted
 unfold admit invalidEndpoints at h
 rw [same,decide_eq_true rfl] at h
 cases n : SourceText.nonblank pair.acceptor <;> rw [n] at h <;> cases h

def transfers (pair : Relation) : List ProtonTransfer.Raw :=
 [⟨pair.first,pair.donor,pair.acceptor⟩,⟨pair.second,pair.donor,pair.acceptor⟩]
theorem completePairContinuity (pair : Relation) (test : HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ProtonTransfer.flows (transfers pair))=
 SFT.Physics.MatterConservedLabels.outputCount test (ProtonTransfer.flows (transfers pair)) :=
 ProtonTransfer.pairedDonorLossAcceptorGain test (transfers pair)
theorem bothIdentitiesRetained (pair : Relation) :
 (transfers pair).map ProtonTransfer.Raw.carrier=occurrences pair := rfl

def donorSupport (pair : Relation) := (pair.donor,occurrences pair)
def acceptorSupport (pair : Relation) := (pair.acceptor,occurrences pair)
theorem joiningUsesSamePair (pair : Relation) : (donorSupport pair).2=(acceptorSupport pair).2 := rfl

def append (history : List Relation) (pair : Relation) := history++[pair]
theorem allPriorRelationsRetained (history : List Relation) (pair prior : Relation) (held : prior∈history) :
 prior∈append history pair := memAppendLeft _ _ _ held
theorem extendedExclusion (history : List Relation) (pair item : Relation) (_held : item∈append history pair) :
 item.first≠item.second := exclusion item
theorem extendedEndpoints (history : List Relation) (pair item : Relation) (_held : item∈append history pair) :
 item.donor≠item.acceptor := endpointsDistinct item
theorem extendedIdentityRetention (history : List Relation) (pair item : Relation) (_held : item∈append history pair) :
 (transfers item).map ProtonTransfer.Raw.carrier=occurrences item := bothIdentitiesRetained item

def firstElectron : HeldLabel := ⟨"electron-carrier","electron-occurrence-one",rfl,rfl⟩
def secondElectron : HeldLabel := ⟨"electron-carrier","electron-occurrence-two",rfl,rfl⟩
def originalRaw : Raw := ⟨"electron-pair-donor","electron-pair-acceptor",[firstElectron,secondElectron]⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
def original : Relation := ⟨"electron-pair-donor","electron-pair-acceptor",firstElectron,secondElectron,originalAdmitted⟩
theorem originalPairExcludedCopy : original.first≠original.second := exclusion original
end SFT.Chemistry.LewisPair
