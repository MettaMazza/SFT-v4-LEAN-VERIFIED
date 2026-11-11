import SFT.Chemistry.MolecularAssembly
namespace SFT.Chemistry.ConjugatePair
open SFT.Foundation.Count.TraceDerivation
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 protonated : String
 deprotonated : String
 proton : HeldLabel

def admit (raw : Raw) : Except String Raw :=
 if !SourceText.nonblank raw.protonated || !SourceText.nonblank raw.deprotonated ||
  decide (raw.protonated=raw.deprotonated) || !(SFT.Host.Text.equal raw.proton.family "proton-carrier") then
  .error "a conjugate pair retains two identities and one proton carrier"
 else .ok raw

structure Pair where
 raw : Raw
 accepted : admit raw=.ok raw

inductive Role where
 | donor | acceptor

def donor (pair : Raw) := (pair.protonated,Role.donor,pair.proton)
def acceptor (pair : Raw) := (pair.deprotonated,Role.acceptor,pair.proton)
def donate (pair : Raw) := (pair.deprotonated,pair.proton)
def accept (pair : Raw) (identity : String) (carrier : HeldLabel) : Option String :=
 if identity=pair.deprotonated ∧ carrier=pair.proton then some pair.protonated else none

theorem donationRetainsProton (pair : Raw) : (donate pair).2=pair.proton := rfl
theorem donationRecoversConjugate (pair : Raw) : (donate pair).1=pair.deprotonated := rfl
theorem uptakeAfterDonation (pair : Raw) : accept pair (donate pair).1 (donate pair).2=some pair.protonated := by
 unfold accept donate
 rw [ite_eq_left (And.intro rfl rfl)]

def labelCount (label : HeldLabel) : List HeldLabel → Nat
 | [] => 0
 | first::rest => if label=first then 1+labelCount label rest else labelCount label rest

theorem countAppend (label : HeldLabel) (before after : List HeldLabel) :
 labelCount label (before++after)=labelCount label before+labelCount label after := by
 induction before with
 | nil => exact (Nat.zero_add _).symm
 | cons first rest ih =>
   change (if label=first then 1+labelCount label (rest++after) else labelCount label (rest++after)) =
    (if label=first then 1+labelCount label rest else labelCount label rest)+labelCount label after
   by_cases same : label=first
   · rw [ite_eq_left same,ite_eq_left same,ih,Nat.add_assoc]
   · rw [ite_eq_right same,ite_eq_right same]; exact ih

def protonatedTrace (common : List HeldLabel) (pair : Raw) := common++[pair.proton]

theorem oneNamedProtonDifference (common : List HeldLabel) (pair : Raw) (label : HeldLabel) :
 labelCount label (protonatedTrace common pair)=labelCount label common+(if label=pair.proton then 1 else 0) := by
 rw [show protonatedTrace common pair=common++[pair.proton] from rfl,countAppend]
 unfold labelCount
 split <;> rfl

theorem matchedCompositionPreservesDifference (common added : List HeldLabel) (pair : Raw) (label : HeldLabel) :
 labelCount label (protonatedTrace common pair++added)=
 labelCount label (common++added)+(if label=pair.proton then 1 else 0) := by
 rw [countAppend,countAppend,oneNamedProtonDifference]
 exact Nat.add_right_comm _ _ _

theorem protonCountIncreasesByOne (common : List HeldLabel) (pair : Raw) :
 labelCount pair.proton (protonatedTrace common pair)=labelCount pair.proton common+1 := by
 rw [oneNamedProtonDifference,ite_eq_left rfl]

theorem everyCommonCarrierRetained (common : List HeldLabel) (pair : Raw) (label : HeldLabel) (held : label∈common) :
 label∈protonatedTrace common pair := memAppendLeft _ _ _ held

structure Record where
 pair : Pair
 common : List HeldLabel
 history : List (List HeldLabel)

def append (record : Record) (added : List HeldLabel) : Record :=
 ⟨record.pair,record.common++added,record.history++[added]⟩

theorem rolesPreserved (record : Record) (added : List HeldLabel) :
 donor (append record added).pair.raw=donor record.pair.raw ∧
 acceptor (append record added).pair.raw=acceptor record.pair.raw := ⟨rfl,rfl⟩

theorem completeHistoryRetained (record : Record) (added prior : List HeldLabel) (held : prior∈record.history) :
 prior∈(append record added).history := memAppendLeft _ _ _ held

def originalProton : HeldLabel := ⟨"proton-carrier","proton-occurrence-one",rfl,rfl⟩
def originalPair : Raw := ⟨"carrier-with-proton","carrier-without-proton",originalProton⟩
theorem originalPairAdmitted : admit originalPair=.ok originalPair := rfl
theorem originalIdentitiesDistinct : originalPair.protonated≠originalPair.deprotonated := by decide
theorem originalProtonFamily : originalPair.proton.family="proton-carrier" := rfl
theorem baseOneDifference (label : HeldLabel) :
 labelCount label (protonatedTrace [] originalPair)=if label=originalProton then 1 else 0 := by
 rw [oneNamedProtonDifference,show labelCount label []=0 from rfl,Nat.zero_add]
 rfl

theorem admittedIdentitiesDistinct (pair : Pair) : pair.raw.protonated≠pair.raw.deprotonated := by
 intro same
 have success := pair.accepted
 unfold admit at success
 rw [same,decide_eq_true rfl] at success
 cases a : SourceText.nonblank pair.raw.deprotonated <;> rw [a] at success <;> cases success

theorem acceptedGuard (pair : Pair) :
 (!SourceText.nonblank pair.raw.protonated || !SourceText.nonblank pair.raw.deprotonated ||
 decide (pair.raw.protonated=pair.raw.deprotonated) || !(SFT.Host.Text.equal pair.raw.proton.family "proton-carrier"))=false := by
 have success := pair.accepted
 unfold admit at success
 split at success
 · cases success
 · rename_i h
   exact Bool.eq_false_iff.mpr h

end SFT.Chemistry.ConjugatePair
