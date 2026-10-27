import SFT.Mathematics.CombinatorialLedger
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CombinatoricsGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "partial-carrier"
  | .admitted => "complete-canonical-carrier"

inductive Choice where
  | rejected | admitted

def choiceName : Choice → String
  | .rejected => "sampled-choices"
  | .admitted => "held-choice-recurrence"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "erased-origin"
  | .admitted => "complete-choice-trace"

inductive Duplicates where
  | rejected | admitted

def duplicatesName : Duplicates → String
  | .rejected => "presentation-deduplication"
  | .admitted => "canonical-identity-deduplication"

inductive Symmetry where
  | rejected | admitted

def symmetryName : Symmetry → String
  | .rejected => "assumed-symmetry"
  | .admitted => "generated-bijection-witness"

inductive Accounting where
  | rejected | admitted

def accountingName : Accounting → String
  | .rejected => "signed-inclusion-subtraction"
  | .admitted => "disjoint-provenance-classes"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "finite-size-table"
  | .admitted => "carrier-successor-recurrence"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "imported-formula"
  | .admitted => "no-imported-formula"

structure Candidate where
  carrier : Carrier
  choice : Choice
  provenance : Provenance
  duplicates : Duplicates
  symmetry : Symmetry
  accounting : Accounting
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, choiceName c.choice, provenanceName c.provenance, duplicatesName c.duplicates, symmetryName c.symmetry, accountingName c.accounting, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "choice=" (choiceName c.choice), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "duplicates=" (duplicatesName c.duplicates), SFT.Host.Text.append "symmetry=" (symmetryName c.symmetry), SFT.Host.Text.append "accounting=" (accountingName c.accounting), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-carrier__held-choice-recurrence__complete-choice-trace__canonical-identity-deduplication__generated-bijection-witness__disjoint-provenance-classes__carrier-successor-recurrence__no-imported-formula"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-canonical-carrier" &&
  SFT.Host.Text.equal (choiceName c.choice) "held-choice-recurrence" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-choice-trace" &&
  SFT.Host.Text.equal (duplicatesName c.duplicates) "canonical-identity-deduplication" &&
  SFT.Host.Text.equal (symmetryName c.symmetry) "generated-bijection-witness" &&
  SFT.Host.Text.equal (accountingName c.accounting) "disjoint-provenance-classes" &&
  SFT.Host.Text.equal (generalityName c.generality) "carrier-successor-recurrence" &&
  SFT.Host.Text.equal (additionName c.addition) "no-imported-formula"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-canonical-carrier") then "A partial carrier silently omits possible generated choices." else
  if !(SFT.Host.Text.equal (choiceName c.choice) "held-choice-recurrence") then "Sampling does not exhaust the registered choice positions." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-choice-trace") then "Erasing origin prevents reconstruction and duplicate diagnosis." else
  if !(SFT.Host.Text.equal (duplicatesName c.duplicates) "canonical-identity-deduplication") then "Presentation equality can merge structurally distinct results." else
  if !(SFT.Host.Text.equal (symmetryName c.symmetry) "generated-bijection-witness") then "An assumed quotient may remove distinguishable held labels." else
  if !(SFT.Host.Text.equal (accountingName c.accounting) "disjoint-provenance-classes") then "Signed subtraction imports negative quantities." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "carrier-successor-recurrence") then "A table of small sizes does not force the next recurrence." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-imported-formula") then "A stored factorial, binomial or inclusion formula selects the conventional answer." else
  "The combinatorial kernel is complete canonical carrier generation by held-choice recurrence with complete choice provenance, canonical deduplication, witnessed symmetry, disjoint class accounting, successor generality and no imported formula."

def generationRule : String := "Generate the complete product of carrier coverage, choice rule, provenance, duplication policy, symmetry identity, class accounting, recurrence closure and extra-formula status."
def grammarBoundary : String := "All arrangement, selection and finite classification families produced from a registered canonical finite carrier by held choice, remainder and successor recurrence."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Choice.rejected,Choice.admitted]).flatMap fun choice =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Duplicates.rejected,Duplicates.admitted]).flatMap fun duplicates =>
  ([Symmetry.rejected,Symmetry.admitted]).flatMap fun symmetry =>
  ([Accounting.rejected,Accounting.admitted]).flatMap fun accounting =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨carrier,choice,provenance,duplicates,symmetry,accounting,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier choice provenance duplicates symmetry accounting generality addition =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchoice : choice ∈ [Choice.rejected,Choice.admitted] := by
      cases choice <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hduplicates : duplicates ∈ [Duplicates.rejected,Duplicates.admitted] := by
      cases duplicates <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsymmetry : symmetry ∈ [Symmetry.rejected,Symmetry.admitted] := by
      cases symmetry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haccounting : accounting ∈ [Accounting.rejected,Accounting.admitted] := by
      cases accounting <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ choice _ hchoice
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ duplicates _ hduplicates
    apply CommonRefinement.memFlatMap _ _ symmetry _ hsymmetry
    apply CommonRefinement.memFlatMap _ _ accounting _ haccounting
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier choice provenance duplicates symmetry accounting generality addition =>
    cases carrier <;> cases choice <;> cases provenance <;> cases duplicates <;> cases symmetry <;> cases accounting <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier choice provenance duplicates symmetry accounting generality addition =>
    cases carrier <;> cases choice <;> cases provenance <;> cases duplicates <;> cases symmetry <;> cases accounting <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.choice = .admitted ∧ c.provenance = .admitted ∧ c.duplicates = .admitted ∧ c.symmetry = .admitted ∧ c.accounting = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier choice provenance duplicates symmetry accounting generality addition =>
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

theorem choice_rejected_rejected (c : Candidate) (h : c.choice = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.choice eq
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

theorem duplicates_rejected_rejected (c : Candidate) (h : c.duplicates = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.duplicates eq
    rw [h] at field
    cases field

theorem symmetry_rejected_rejected (c : Candidate) (h : c.symmetry = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.symmetry eq
    rw [h] at field
    cases field

theorem accounting_rejected_rejected (c : Candidate) (h : c.accounting = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.accounting eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.CombinatoricsGrammar
