import SFT.Foundation.AdmissionGrammarBlock0
import SFT.Foundation.AdmissionGrammarBlock1
import SFT.Foundation.AdmissionGrammarBlock2
import SFT.Foundation.AdmissionGrammarBlock3
import SFT.Foundation.AdmissionGrammarBlock4
import SFT.Foundation.AdmissionGrammarBlock5
import SFT.Foundation.AdmissionGrammarBlock6
import SFT.Foundation.AdmissionGrammarBlock7
import SFT.Foundation.AdmissionGrammarBlock8
import SFT.Foundation.AdmissionGrammarBlock9
import SFT.Foundation.AdmissionGrammarBlock10
import SFT.Foundation.AdmissionGrammarBlock11
import SFT.Foundation.AdmissionGrammarBlock12
import SFT.Foundation.AdmissionGrammarBlock13
import SFT.Foundation.AdmissionGrammarBlock14
import SFT.Foundation.AdmissionGrammarBlock15
import SFT.Foundation.AdmissionGrammarBlock16
import SFT.Foundation.AdmissionGrammarBlock17
import SFT.Foundation.AdmissionGrammarBlock18
import SFT.Foundation.AdmissionGrammarBlock19
import SFT.Foundation.AdmissionGrammarBlock20
import SFT.Foundation.AdmissionGrammarBlock21
import SFT.Foundation.AdmissionGrammarBlock22
import SFT.Foundation.AdmissionGrammarBlock23
import SFT.Foundation.AdmissionGrammarBlock24
import SFT.Foundation.AdmissionGrammarBlock25
import SFT.Foundation.AdmissionGrammarBlock26
import SFT.Foundation.AdmissionGrammarBlock27
import SFT.Foundation.AdmissionGrammarBlock28
import SFT.Foundation.AdmissionGrammarBlock29
import SFT.Foundation.AdmissionGrammarBlock30
import SFT.Foundation.AdmissionGrammarBlock31
namespace SFT.Foundation.AdmissionGrammar
set_option maxRecDepth 20000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk registration premises census forcing closure controls validation measurement receipts dependency extra =>
   cases registration with
   | rejected =>
     cases premises with
     | rejected =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock0 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock1 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock2 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock3 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock4 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock5 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock6 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock7 controls validation measurement receipts dependency extra
     | admitted =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock8 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock9 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock10 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock11 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock12 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock13 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock14 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock15 controls validation measurement receipts dependency extra
   | admitted =>
     cases premises with
     | rejected =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock16 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock17 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock18 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock19 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock20 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock21 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock22 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock23 controls validation measurement receipts dependency extra
     | admitted =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock24 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock25 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock26 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock27 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock28 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock29 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact sourceDecisionBlock30 controls validation measurement receipts dependency extra
           | admitted =>
             exact sourceDecisionBlock31 controls validation measurement receipts dependency extra

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk registration premises census forcing closure controls validation measurement receipts dependency extra =>
   cases registration with
   | rejected =>
     cases premises with
     | rejected =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock0 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock1 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock2 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock3 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock4 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock5 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock6 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock7 controls validation measurement receipts dependency extra
     | admitted =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock8 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock9 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock10 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock11 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock12 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock13 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock14 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock15 controls validation measurement receipts dependency extra
   | admitted =>
     cases premises with
     | rejected =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock16 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock17 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock18 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock19 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock20 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock21 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock22 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock23 controls validation measurement receipts dependency extra
     | admitted =>
       cases census with
       | rejected =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock24 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock25 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock26 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock27 controls validation measurement receipts dependency extra
       | admitted =>
         cases forcing with
         | rejected =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock28 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock29 controls validation measurement receipts dependency extra
         | admitted =>
           cases closure with
           | rejected =>
             exact uniqueCriteriaBlock30 controls validation measurement receipts dependency extra
           | admitted =>
             exact uniqueCriteriaBlock31 controls validation measurement receipts dependency extra

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.registration = .admitted ∧ c.premises = .admitted ∧ c.census = .admitted ∧ c.forcing = .admitted ∧ c.closure = .admitted ∧ c.controls = .admitted ∧ c.validation = .admitted ∧ c.measurement = .admitted ∧ c.receipts = .admitted ∧ c.dependency = .admitted ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk registration premises census forcing closure controls validation measurement receipts dependency extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem registration_rejected_rejected (c : Candidate) (h : c.registration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.registration eq
    rw [h] at field
    cases field

theorem premises_rejected_rejected (c : Candidate) (h : c.premises = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.premises eq
    rw [h] at field
    cases field

theorem census_rejected_rejected (c : Candidate) (h : c.census = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.census eq
    rw [h] at field
    cases field

theorem forcing_rejected_rejected (c : Candidate) (h : c.forcing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.forcing eq
    rw [h] at field
    cases field

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem controls_rejected_rejected (c : Candidate) (h : c.controls = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.controls eq
    rw [h] at field
    cases field

theorem validation_rejected_rejected (c : Candidate) (h : c.validation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.validation eq
    rw [h] at field
    cases field

theorem measurement_rejected_rejected (c : Candidate) (h : c.measurement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurement eq
    rw [h] at field
    cases field

theorem receipts_rejected_rejected (c : Candidate) (h : c.receipts = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.receipts eq
    rw [h] at field
    cases field

theorem dependency_rejected_rejected (c : Candidate) (h : c.dependency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dependency eq
    rw [h] at field
    cases field

theorem extra_hasExtra_rejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.AdmissionGrammar
