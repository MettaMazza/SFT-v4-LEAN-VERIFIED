import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularElectronicGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "state-without-molecular-carrier"
  | .admitted => "identified-molecular-carrier"

inductive Occurrences where
  | rejected | admitted

def occurrencesName : Occurrences → String
  | .rejected => "anonymous-electron-number"
  | .admitted => "electron-occurrences-retained"

inductive Arrangement where
  | rejected | admitted

def arrangementName : Arrangement → String
  | .rejected => "energy-name-only"
  | .admitted => "complete-joint-arrangement"

inductive Admissibility where
  | rejected | admitted

def admissibilityName : Admissibility → String
  | .rejected => "arbitrary-electron-arrangement"
  | .admitted => "admitted-quantum-constraints"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "independent-electron-list"
  | .admitted => "molecular-composition-retained"

inductive Distinction where
  | rejected | admitted

def distinctionName : Distinction → String
  | .rejected => "state-name-without-observation"
  | .admitted => "observation-distinguishable-state"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "electronic-result-without-trace"
  | .admitted => "held-state-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-electronic-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  occurrences : Occurrences
  arrangement : Arrangement
  admissibility : Admissibility
  composition : Composition
  distinction : Distinction
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, occurrencesName c.occurrences, arrangementName c.arrangement, admissibilityName c.admissibility, compositionName c.composition, distinctionName c.distinction, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "occurrences=" (occurrencesName c.occurrences), SFT.Host.Text.append "arrangement=" (arrangementName c.arrangement), SFT.Host.Text.append "admissibility=" (admissibilityName c.admissibility), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "distinction=" (distinctionName c.distinction), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "identified-molecular-carrier__electron-occurrences-retained__complete-joint-arrangement__admitted-quantum-constraints__molecular-composition-retained__observation-distinguishable-state__held-state-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "identified-molecular-carrier" &&
  SFT.Host.Text.equal (occurrencesName c.occurrences) "electron-occurrences-retained" &&
  SFT.Host.Text.equal (arrangementName c.arrangement) "complete-joint-arrangement" &&
  SFT.Host.Text.equal (admissibilityName c.admissibility) "admitted-quantum-constraints" &&
  SFT.Host.Text.equal (compositionName c.composition) "molecular-composition-retained" &&
  SFT.Host.Text.equal (distinctionName c.distinction) "observation-distinguishable-state" &&
  SFT.Host.Text.equal (recordName c.record) "held-state-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "identified-molecular-carrier") then "A free state label cannot identify which chemical whole carries it." else
  if !(SFT.Host.Text.equal (occurrencesName c.occurrences) "electron-occurrences-retained") then "A number alone erases the separately retained electron occurrences." else
  if !(SFT.Host.Text.equal (arrangementName c.arrangement) "complete-joint-arrangement") then "An energy or state name cannot reconstruct the electronic organization." else
  if !(SFT.Host.Text.equal (admissibilityName c.admissibility) "admitted-quantum-constraints") then "An arbitrary arrangement can violate admitted spin, indistinguishability and exclusion laws." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "molecular-composition-retained") then "Independent labels omit the composed molecular state." else
  if !(SFT.Host.Text.equal (distinctionName c.distinction) "observation-distinguishable-state") then "A name without a retained observation class supplies no state distinction." else
  if !(SFT.Host.Text.equal (recordName c.record) "held-state-record") then "A result without carrier, occurrences and support cannot be reproduced." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A free exception can manufacture a desired state or target match." else
  "identified-molecular-carrier__electron-occurrences-retained__complete-joint-arrangement__admitted-quantum-constraints__molecular-composition-retained__observation-distinguishable-state__held-state-record__no-extra-rule"

def generationRule : String := "Generate the literal Cartesian product of carrier, occurrence, arrangement, admissibility, composition, distinction, record and extension choices; decide every product by preservation of admitted molecular, quantum, information and observation dependencies."
def grammarBoundary : String := "Every exact positive-finite molecular carrier and its generated finite electron-occurrence support at a declared chemical observation resolution. The certificate is depth-independent because adding one electron occurrence repeats the same required occurrence, support, held-label and record checks."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Occurrences.rejected,Occurrences.admitted]).flatMap fun occurrences =>
  ([Arrangement.rejected,Arrangement.admitted]).flatMap fun arrangement =>
  ([Admissibility.rejected,Admissibility.admitted]).flatMap fun admissibility =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Distinction.rejected,Distinction.admitted]).flatMap fun distinction =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,occurrences,arrangement,admissibility,composition,distinction,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier occurrences arrangement admissibility composition distinction record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoccurrences : occurrences ∈ [Occurrences.rejected,Occurrences.admitted] := by
      cases occurrences <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have harrangement : arrangement ∈ [Arrangement.rejected,Arrangement.admitted] := by
      cases arrangement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadmissibility : admissibility ∈ [Admissibility.rejected,Admissibility.admitted] := by
      cases admissibility <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinction : distinction ∈ [Distinction.rejected,Distinction.admitted] := by
      cases distinction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ occurrences _ hoccurrences
    apply CommonRefinement.memFlatMap _ _ arrangement _ harrangement
    apply CommonRefinement.memFlatMap _ _ admissibility _ hadmissibility
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ distinction _ hdistinction
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier occurrences arrangement admissibility composition distinction record extension =>
    cases carrier <;> cases occurrences <;> cases arrangement <;> cases admissibility <;> cases composition <;> cases distinction <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier occurrences arrangement admissibility composition distinction record extension =>
    cases carrier <;> cases occurrences <;> cases arrangement <;> cases admissibility <;> cases composition <;> cases distinction <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.occurrences = .admitted ∧ c.arrangement = .admitted ∧ c.admissibility = .admitted ∧ c.composition = .admitted ∧ c.distinction = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier occurrences arrangement admissibility composition distinction record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem occurrences_rejected_rejected (c : Candidate) (h : c.occurrences = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occurrences eq
    rw [h] at field
    cases field

theorem arrangement_rejected_rejected (c : Candidate) (h : c.arrangement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.arrangement eq
    rw [h] at field
    cases field

theorem admissibility_rejected_rejected (c : Candidate) (h : c.admissibility = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.admissibility eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem distinction_rejected_rejected (c : Candidate) (h : c.distinction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distinction eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.MolecularElectronicGrammar
