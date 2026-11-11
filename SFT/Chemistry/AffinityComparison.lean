import SFT.Chemistry.ProtonTransfer
namespace SFT.Chemistry.AffinityComparison
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 firstAtom : String
 secondAtom : String
 sharedSupport : HeldLabel
 preferredEndpoint : String

def admit (raw : Raw) : Except String Raw :=
 if !SourceText.nonblank raw.firstAtom || !SourceText.nonblank raw.secondAtom ||
 decide (raw.firstAtom=raw.secondAtom) ||
 !(decide (raw.preferredEndpoint=raw.firstAtom) || decide (raw.preferredEndpoint=raw.secondAtom)) ||
 !(SFT.Host.Text.equal raw.sharedSupport.family "shared-electron-support") then
 .error "affinity comparison requires two endpoints and one retained shared support"
 else .ok raw
structure Comparison where
 raw : Raw
 accepted : admit raw=.ok raw

theorem preferredIsEndpoint (comparison : Comparison) :
 comparison.raw.preferredEndpoint=comparison.raw.firstAtom ∨
 comparison.raw.preferredEndpoint=comparison.raw.secondAtom := by
 by_cases first : comparison.raw.preferredEndpoint=comparison.raw.firstAtom
 · exact Or.inl first
 · by_cases second : comparison.raw.preferredEndpoint=comparison.raw.secondAtom
   · exact Or.inr second
   · have h := comparison.accepted
     unfold admit at h
     rw [decide_eq_false first,decide_eq_false second] at h
     cases a : SourceText.nonblank comparison.raw.firstAtom <;>
      cases b : SourceText.nonblank comparison.raw.secondAtom <;>
      cases same : decide (comparison.raw.firstAtom=comparison.raw.secondAtom) <;>
      rw [a,b,same] at h <;> cases h

def originalSupport : HeldLabel := ⟨"shared-electron-support","bond-pair-one",rfl,rfl⟩
def originalRaw : Raw := ⟨"atom-a","atom-b",originalSupport,"atom-b"⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
def original : Comparison := ⟨originalRaw,originalAdmitted⟩
theorem originalPreference : original.raw.preferredEndpoint="atom-b" := rfl
end SFT.Chemistry.AffinityComparison
