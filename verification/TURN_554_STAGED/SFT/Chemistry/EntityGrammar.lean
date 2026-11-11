import SFT.Chemistry.EntityIdentity
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EntityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "ensemble-without-member"
  | .admitted => "singular-carrier"

inductive Constitution where
  | rejected | admitted

def constitutionName : Constitution → String
  | .rejected => "constitution-erased"
  | .admitted => "constitution-retained"

inductive Isotope where
  | rejected | admitted

def isotopeName : Isotope → String
  | .rejected => "isotope-erased"
  | .admitted => "isotope-retained"

inductive Distinction where
  | rejected | admitted

def distinctionName : Distinction → String
  | .rejected => "indistinguishable-answer-label"
  | .admitted => "separately-distinguishable"

inductive Precision where
  | rejected | admitted

def precisionName : Precision → String
  | .rejected => "unbounded-or-fixed-precision"
  | .admitted => "context-bounded-precision"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "result-without-observation-record"
  | .admitted => "held-observation-record"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "unbound-provenance"
  | .admitted => "source-bound-proof-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-identity-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  constitution : Constitution
  isotope : Isotope
  distinction : Distinction
  precision : Precision
  record : Record
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, constitutionName c.constitution, isotopeName c.isotope, distinctionName c.distinction, precisionName c.precision, recordName c.record, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "constitution=" (constitutionName c.constitution), SFT.Host.Text.append "isotope=" (isotopeName c.isotope), SFT.Host.Text.append "distinction=" (distinctionName c.distinction), SFT.Host.Text.append "precision=" (precisionName c.precision), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "singular-carrier__constitution-retained__isotope-retained__separately-distinguishable__context-bounded-precision__held-observation-record__source-bound-proof-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "singular-carrier" &&
  SFT.Host.Text.equal (constitutionName c.constitution) "constitution-retained" &&
  SFT.Host.Text.equal (isotopeName c.isotope) "isotope-retained" &&
  SFT.Host.Text.equal (distinctionName c.distinction) "separately-distinguishable" &&
  SFT.Host.Text.equal (precisionName c.precision) "context-bounded-precision" &&
  SFT.Host.Text.equal (recordName c.record) "held-observation-record" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "singular-carrier") then "An ensemble alone does not identify one chemical entity." else
  if !(SFT.Host.Text.equal (constitutionName c.constitution) "constitution-retained") then "Erasing constitution merges chemically distinct carriers." else
  if !(SFT.Host.Text.equal (isotopeName c.isotope) "isotope-retained") then "Erasing isotopic identity merges distinguishable entities." else
  if !(SFT.Host.Text.equal (distinctionName c.distinction) "separately-distinguishable") then "An answer label without a retained distinction cannot identify an entity." else
  if !(SFT.Host.Text.equal (precisionName c.precision) "context-bounded-precision") then "A fixed universal precision either loses a required distinction or adds an unforced one." else
  if !(SFT.Host.Text.equal (recordName c.record) "held-observation-record") then "Without an observation record the identity boundary cannot be audited." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace") then "Unbound identity cannot be traced to the Fold dependency spine." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An extra identity rule can arbitrarily split or merge entities." else
  "singular-carrier__constitution-and-isotope-retained__separately-distinguishable__context-bounded-precision"

def generationRule : String := "Generate the literal product of the registered entity carrier, constitution, isotope, distinction, precision, record, provenance and extension choices."
def grammarBoundary : String := "Every finite singular chemical carrier formed from admitted distinctions and any generated positive-finite extension of its constitution, isotope, state or contextual precision record."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Constitution.rejected,Constitution.admitted]).flatMap fun constitution =>
  ([Isotope.rejected,Isotope.admitted]).flatMap fun isotope =>
  ([Distinction.rejected,Distinction.admitted]).flatMap fun distinction =>
  ([Precision.rejected,Precision.admitted]).flatMap fun precision =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,constitution,isotope,distinction,precision,record,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier constitution isotope distinction precision record provenance extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstitution : constitution ∈ [Constitution.rejected,Constitution.admitted] := by
      cases constitution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hisotope : isotope ∈ [Isotope.rejected,Isotope.admitted] := by
      cases isotope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinction : distinction ∈ [Distinction.rejected,Distinction.admitted] := by
      cases distinction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprecision : precision ∈ [Precision.rejected,Precision.admitted] := by
      cases precision <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ constitution _ hconstitution
    apply CommonRefinement.memFlatMap _ _ isotope _ hisotope
    apply CommonRefinement.memFlatMap _ _ distinction _ hdistinction
    apply CommonRefinement.memFlatMap _ _ precision _ hprecision
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier constitution isotope distinction precision record provenance extension =>
    cases carrier <;> cases constitution <;> cases isotope <;> cases distinction <;> cases precision <;> cases record <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier constitution isotope distinction precision record provenance extension =>
    cases carrier <;> cases constitution <;> cases isotope <;> cases distinction <;> cases precision <;> cases record <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.constitution = .admitted ∧ c.isotope = .admitted ∧ c.distinction = .admitted ∧ c.precision = .admitted ∧ c.record = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier constitution isotope distinction precision record provenance extension =>
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

theorem constitution_rejected_rejected (c : Candidate) (h : c.constitution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.constitution eq
    rw [h] at field
    cases field

theorem isotope_rejected_rejected (c : Candidate) (h : c.isotope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.isotope eq
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

theorem precision_rejected_rejected (c : Candidate) (h : c.precision = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.precision eq
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

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
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

end SFT.Chemistry.EntityGrammar
