import SFT.Mathematics.CalculatorBrowserCensus0
import SFT.Mathematics.CalculatorBrowserCensus1
import SFT.Mathematics.CalculatorBrowserCensus2
import SFT.Mathematics.CalculatorBrowserCensus3
import SFT.Mathematics.CalculatorBrowserCensus4
import SFT.Mathematics.CalculatorBrowserCensus5
import SFT.Mathematics.CalculatorBrowserCensus6
import SFT.Mathematics.CalculatorBrowserCensus7
import SFT.Mathematics.CalculatorBrowserCensus8
import SFT.Mathematics.CalculatorBrowserCensus9
import SFT.Mathematics.CalculatorBrowserCensus10
import SFT.Mathematics.CalculatorBrowserCensus11
import SFT.Mathematics.CalculatorBrowserCensus12
import SFT.Mathematics.CalculatorBrowserCensus13
import SFT.Mathematics.CalculatorBrowserCensus14
import SFT.Mathematics.CalculatorBrowserCensus15
namespace SFT.Mathematics.CalculatorBrowserGrammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk rendered_surface keypad_organisation value_boundary kernel_route session_state network_reach dependency_boundary validation =>
    cases rendered_surface <;> cases keypad_organisation <;> cases value_boundary <;> cases kernel_route
    · exact sourceDecisionChunk0 _ _ _ _
    · exact sourceDecisionChunk1 _ _ _ _
    · exact sourceDecisionChunk2 _ _ _ _
    · exact sourceDecisionChunk3 _ _ _ _
    · exact sourceDecisionChunk4 _ _ _ _
    · exact sourceDecisionChunk5 _ _ _ _
    · exact sourceDecisionChunk6 _ _ _ _
    · exact sourceDecisionChunk7 _ _ _ _
    · exact sourceDecisionChunk8 _ _ _ _
    · exact sourceDecisionChunk9 _ _ _ _
    · exact sourceDecisionChunk10 _ _ _ _
    · exact sourceDecisionChunk11 _ _ _ _
    · exact sourceDecisionChunk12 _ _ _ _
    · exact sourceDecisionChunk13 _ _ _ _
    · exact sourceDecisionChunk14 _ _ _ _
    · exact sourceDecisionChunk15 _ _ _ _

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk rendered_surface keypad_organisation value_boundary kernel_route session_state network_reach dependency_boundary validation =>
    cases rendered_surface <;> cases keypad_organisation <;> cases value_boundary <;> cases kernel_route
    · exact uniqueCriteriaChunk0 _ _ _ _
    · exact uniqueCriteriaChunk1 _ _ _ _
    · exact uniqueCriteriaChunk2 _ _ _ _
    · exact uniqueCriteriaChunk3 _ _ _ _
    · exact uniqueCriteriaChunk4 _ _ _ _
    · exact uniqueCriteriaChunk5 _ _ _ _
    · exact uniqueCriteriaChunk6 _ _ _ _
    · exact uniqueCriteriaChunk7 _ _ _ _
    · exact uniqueCriteriaChunk8 _ _ _ _
    · exact uniqueCriteriaChunk9 _ _ _ _
    · exact uniqueCriteriaChunk10 _ _ _ _
    · exact uniqueCriteriaChunk11 _ _ _ _
    · exact uniqueCriteriaChunk12 _ _ _ _
    · exact uniqueCriteriaChunk13 _ _ _ _
    · exact uniqueCriteriaChunk14 _ _ _ _
    · exact uniqueCriteriaChunk15 _ _ _ _

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.rendered_surface = .admitted ∧ c.keypad_organisation = .admitted ∧ c.value_boundary = .admitted ∧ c.kernel_route = .admitted ∧ c.session_state = .admitted ∧ c.network_reach = .admitted ∧ c.dependency_boundary = .admitted ∧ c.validation = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk rendered_surface keypad_organisation value_boundary kernel_route session_state network_reach dependency_boundary validation =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem rendered_surface_rejected_rejected (c : Candidate) (h : c.rendered_surface = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.rendered_surface eq
    rw [h] at field
    cases field

theorem keypad_organisation_rejected_rejected (c : Candidate) (h : c.keypad_organisation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.keypad_organisation eq
    rw [h] at field
    cases field

theorem value_boundary_rejected_rejected (c : Candidate) (h : c.value_boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.value_boundary eq
    rw [h] at field
    cases field

theorem kernel_route_rejected_rejected (c : Candidate) (h : c.kernel_route = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.kernel_route eq
    rw [h] at field
    cases field

theorem session_state_rejected_rejected (c : Candidate) (h : c.session_state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.session_state eq
    rw [h] at field
    cases field

theorem network_reach_rejected_rejected (c : Candidate) (h : c.network_reach = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.network_reach eq
    rw [h] at field
    cases field

theorem dependency_boundary_rejected_rejected (c : Candidate) (h : c.dependency_boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dependency_boundary eq
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

end SFT.Mathematics.CalculatorBrowserGrammar
