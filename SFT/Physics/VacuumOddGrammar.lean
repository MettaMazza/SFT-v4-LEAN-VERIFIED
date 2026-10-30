import SFT.Physics.VacuumOddCensus0
import SFT.Physics.VacuumOddCensus1
import SFT.Physics.VacuumOddCensus2
import SFT.Physics.VacuumOddCensus3
import SFT.Physics.VacuumOddCensus4
import SFT.Physics.VacuumOddCensus5
import SFT.Physics.VacuumOddCensus6
import SFT.Physics.VacuumOddCensus7
import SFT.Physics.VacuumOddCensus8
import SFT.Physics.VacuumOddCensus9
import SFT.Physics.VacuumOddCensus10
import SFT.Physics.VacuumOddCensus11
import SFT.Physics.VacuumOddCensus12
import SFT.Physics.VacuumOddCensus13
import SFT.Physics.VacuumOddCensus14
import SFT.Physics.VacuumOddCensus15
namespace SFT.Physics.VacuumOddGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier dependency relation enumeration minimality measurement record extension =>
  cases carrier <;> cases dependency <;> cases relation <;> cases enumeration
  · exact decisionCensus0 minimality measurement record extension
  · exact decisionCensus1 minimality measurement record extension
  · exact decisionCensus2 minimality measurement record extension
  · exact decisionCensus3 minimality measurement record extension
  · exact decisionCensus4 minimality measurement record extension
  · exact decisionCensus5 minimality measurement record extension
  · exact decisionCensus6 minimality measurement record extension
  · exact decisionCensus7 minimality measurement record extension
  · exact decisionCensus8 minimality measurement record extension
  · exact decisionCensus9 minimality measurement record extension
  · exact decisionCensus10 minimality measurement record extension
  · exact decisionCensus11 minimality measurement record extension
  · exact decisionCensus12 minimality measurement record extension
  · exact decisionCensus13 minimality measurement record extension
  · exact decisionCensus14 minimality measurement record extension
  · exact decisionCensus15 minimality measurement record extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk carrier dependency relation enumeration minimality measurement record extension =>
  cases carrier <;> cases dependency <;> cases relation <;> cases enumeration
  · exact uniqueCensus0 minimality measurement record extension
  · exact uniqueCensus1 minimality measurement record extension
  · exact uniqueCensus2 minimality measurement record extension
  · exact uniqueCensus3 minimality measurement record extension
  · exact uniqueCensus4 minimality measurement record extension
  · exact uniqueCensus5 minimality measurement record extension
  · exact uniqueCensus6 minimality measurement record extension
  · exact uniqueCensus7 minimality measurement record extension
  · exact uniqueCensus8 minimality measurement record extension
  · exact uniqueCensus9 minimality measurement record extension
  · exact uniqueCensus10 minimality measurement record extension
  · exact uniqueCensus11 minimality measurement record extension
  · exact uniqueCensus12 minimality measurement record extension
  · exact uniqueCensus13 minimality measurement record extension
  · exact uniqueCensus14 minimality measurement record extension
  · exact uniqueCensus15 minimality measurement record extension
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.dependency = .admitted ∧ c.relation = .admitted ∧ c.enumeration = .admitted ∧ c.minimality = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier dependency relation enumeration minimality measurement record extension =>
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

theorem dependency_rejected_rejected (c : Candidate) (h : c.dependency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dependency eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem enumeration_rejected_rejected (c : Candidate) (h : c.enumeration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.enumeration eq
    rw [h] at field
    cases field

theorem minimality_rejected_rejected (c : Candidate) (h : c.minimality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.minimality eq
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

end SFT.Physics.VacuumOddGrammar
