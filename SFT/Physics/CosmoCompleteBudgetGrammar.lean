import SFT.Physics.CosmoCompleteBudgetGrammarBase
import SFT.Physics.CosmoCompleteBudgetCensus0
import SFT.Physics.CosmoCompleteBudgetCensus1
import SFT.Physics.CosmoCompleteBudgetCensus2
import SFT.Physics.CosmoCompleteBudgetCensus3
import SFT.Physics.CosmoCompleteBudgetCensus4
import SFT.Physics.CosmoCompleteBudgetCensus5
import SFT.Physics.CosmoCompleteBudgetCensus6
import SFT.Physics.CosmoCompleteBudgetCensus7
import SFT.Physics.CosmoCompleteBudgetCensus8
import SFT.Physics.CosmoCompleteBudgetCensus9
import SFT.Physics.CosmoCompleteBudgetCensus10
import SFT.Physics.CosmoCompleteBudgetCensus11
import SFT.Physics.CosmoCompleteBudgetCensus12
import SFT.Physics.CosmoCompleteBudgetCensus13
import SFT.Physics.CosmoCompleteBudgetCensus14
import SFT.Physics.CosmoCompleteBudgetCensus15
import SFT.Physics.CosmoCompleteBudgetCensus16
import SFT.Physics.CosmoCompleteBudgetCensus17
import SFT.Physics.CosmoCompleteBudgetCensus18
import SFT.Physics.CosmoCompleteBudgetCensus19
import SFT.Physics.CosmoCompleteBudgetCensus20
import SFT.Physics.CosmoCompleteBudgetCensus21
import SFT.Physics.CosmoCompleteBudgetCensus22
import SFT.Physics.CosmoCompleteBudgetCensus23
import SFT.Physics.CosmoCompleteBudgetCensus24
import SFT.Physics.CosmoCompleteBudgetCensus25
import SFT.Physics.CosmoCompleteBudgetCensus26
import SFT.Physics.CosmoCompleteBudgetCensus27
import SFT.Physics.CosmoCompleteBudgetCensus28
import SFT.Physics.CosmoCompleteBudgetCensus29
import SFT.Physics.CosmoCompleteBudgetCensus30
import SFT.Physics.CosmoCompleteBudgetCensus31
import SFT.Physics.CosmoCompleteBudgetCensus32
import SFT.Physics.CosmoCompleteBudgetCensus33
import SFT.Physics.CosmoCompleteBudgetCensus34
import SFT.Physics.CosmoCompleteBudgetCensus35
import SFT.Physics.CosmoCompleteBudgetCensus36
import SFT.Physics.CosmoCompleteBudgetCensus37
import SFT.Physics.CosmoCompleteBudgetCensus38
import SFT.Physics.CosmoCompleteBudgetCensus39
import SFT.Physics.CosmoCompleteBudgetCensus40
import SFT.Physics.CosmoCompleteBudgetCensus41
import SFT.Physics.CosmoCompleteBudgetCensus42
import SFT.Physics.CosmoCompleteBudgetCensus43
import SFT.Physics.CosmoCompleteBudgetCensus44
import SFT.Physics.CosmoCompleteBudgetCensus45
import SFT.Physics.CosmoCompleteBudgetCensus46
import SFT.Physics.CosmoCompleteBudgetCensus47
import SFT.Physics.CosmoCompleteBudgetCensus48
import SFT.Physics.CosmoCompleteBudgetCensus49
import SFT.Physics.CosmoCompleteBudgetCensus50
import SFT.Physics.CosmoCompleteBudgetCensus51
import SFT.Physics.CosmoCompleteBudgetCensus52
import SFT.Physics.CosmoCompleteBudgetCensus53
import SFT.Physics.CosmoCompleteBudgetCensus54
import SFT.Physics.CosmoCompleteBudgetCensus55
import SFT.Physics.CosmoCompleteBudgetCensus56
import SFT.Physics.CosmoCompleteBudgetCensus57
import SFT.Physics.CosmoCompleteBudgetCensus58
import SFT.Physics.CosmoCompleteBudgetCensus59
import SFT.Physics.CosmoCompleteBudgetCensus60
import SFT.Physics.CosmoCompleteBudgetCensus61
import SFT.Physics.CosmoCompleteBudgetCensus62
import SFT.Physics.CosmoCompleteBudgetCensus63
namespace SFT.Physics.CosmoCompleteBudgetGrammar
open SFT.Foundation
set_option maxRecDepth 20000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk support boundary pinning free global internal composition closure target provenance extension =>
  cases support <;> cases boundary <;> cases pinning <;> cases free <;> cases global <;> cases internal
  · exact decisionCensus0 composition closure target provenance extension
  · exact decisionCensus1 composition closure target provenance extension
  · exact decisionCensus2 composition closure target provenance extension
  · exact decisionCensus3 composition closure target provenance extension
  · exact decisionCensus4 composition closure target provenance extension
  · exact decisionCensus5 composition closure target provenance extension
  · exact decisionCensus6 composition closure target provenance extension
  · exact decisionCensus7 composition closure target provenance extension
  · exact decisionCensus8 composition closure target provenance extension
  · exact decisionCensus9 composition closure target provenance extension
  · exact decisionCensus10 composition closure target provenance extension
  · exact decisionCensus11 composition closure target provenance extension
  · exact decisionCensus12 composition closure target provenance extension
  · exact decisionCensus13 composition closure target provenance extension
  · exact decisionCensus14 composition closure target provenance extension
  · exact decisionCensus15 composition closure target provenance extension
  · exact decisionCensus16 composition closure target provenance extension
  · exact decisionCensus17 composition closure target provenance extension
  · exact decisionCensus18 composition closure target provenance extension
  · exact decisionCensus19 composition closure target provenance extension
  · exact decisionCensus20 composition closure target provenance extension
  · exact decisionCensus21 composition closure target provenance extension
  · exact decisionCensus22 composition closure target provenance extension
  · exact decisionCensus23 composition closure target provenance extension
  · exact decisionCensus24 composition closure target provenance extension
  · exact decisionCensus25 composition closure target provenance extension
  · exact decisionCensus26 composition closure target provenance extension
  · exact decisionCensus27 composition closure target provenance extension
  · exact decisionCensus28 composition closure target provenance extension
  · exact decisionCensus29 composition closure target provenance extension
  · exact decisionCensus30 composition closure target provenance extension
  · exact decisionCensus31 composition closure target provenance extension
  · exact decisionCensus32 composition closure target provenance extension
  · exact decisionCensus33 composition closure target provenance extension
  · exact decisionCensus34 composition closure target provenance extension
  · exact decisionCensus35 composition closure target provenance extension
  · exact decisionCensus36 composition closure target provenance extension
  · exact decisionCensus37 composition closure target provenance extension
  · exact decisionCensus38 composition closure target provenance extension
  · exact decisionCensus39 composition closure target provenance extension
  · exact decisionCensus40 composition closure target provenance extension
  · exact decisionCensus41 composition closure target provenance extension
  · exact decisionCensus42 composition closure target provenance extension
  · exact decisionCensus43 composition closure target provenance extension
  · exact decisionCensus44 composition closure target provenance extension
  · exact decisionCensus45 composition closure target provenance extension
  · exact decisionCensus46 composition closure target provenance extension
  · exact decisionCensus47 composition closure target provenance extension
  · exact decisionCensus48 composition closure target provenance extension
  · exact decisionCensus49 composition closure target provenance extension
  · exact decisionCensus50 composition closure target provenance extension
  · exact decisionCensus51 composition closure target provenance extension
  · exact decisionCensus52 composition closure target provenance extension
  · exact decisionCensus53 composition closure target provenance extension
  · exact decisionCensus54 composition closure target provenance extension
  · exact decisionCensus55 composition closure target provenance extension
  · exact decisionCensus56 composition closure target provenance extension
  · exact decisionCensus57 composition closure target provenance extension
  · exact decisionCensus58 composition closure target provenance extension
  · exact decisionCensus59 composition closure target provenance extension
  · exact decisionCensus60 composition closure target provenance extension
  · exact decisionCensus61 composition closure target provenance extension
  · exact decisionCensus62 composition closure target provenance extension
  · exact decisionCensus63 composition closure target provenance extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk support boundary pinning free global internal composition closure target provenance extension =>
  cases support <;> cases boundary <;> cases pinning <;> cases free <;> cases global <;> cases internal
  · exact uniqueCensus0 composition closure target provenance extension
  · exact uniqueCensus1 composition closure target provenance extension
  · exact uniqueCensus2 composition closure target provenance extension
  · exact uniqueCensus3 composition closure target provenance extension
  · exact uniqueCensus4 composition closure target provenance extension
  · exact uniqueCensus5 composition closure target provenance extension
  · exact uniqueCensus6 composition closure target provenance extension
  · exact uniqueCensus7 composition closure target provenance extension
  · exact uniqueCensus8 composition closure target provenance extension
  · exact uniqueCensus9 composition closure target provenance extension
  · exact uniqueCensus10 composition closure target provenance extension
  · exact uniqueCensus11 composition closure target provenance extension
  · exact uniqueCensus12 composition closure target provenance extension
  · exact uniqueCensus13 composition closure target provenance extension
  · exact uniqueCensus14 composition closure target provenance extension
  · exact uniqueCensus15 composition closure target provenance extension
  · exact uniqueCensus16 composition closure target provenance extension
  · exact uniqueCensus17 composition closure target provenance extension
  · exact uniqueCensus18 composition closure target provenance extension
  · exact uniqueCensus19 composition closure target provenance extension
  · exact uniqueCensus20 composition closure target provenance extension
  · exact uniqueCensus21 composition closure target provenance extension
  · exact uniqueCensus22 composition closure target provenance extension
  · exact uniqueCensus23 composition closure target provenance extension
  · exact uniqueCensus24 composition closure target provenance extension
  · exact uniqueCensus25 composition closure target provenance extension
  · exact uniqueCensus26 composition closure target provenance extension
  · exact uniqueCensus27 composition closure target provenance extension
  · exact uniqueCensus28 composition closure target provenance extension
  · exact uniqueCensus29 composition closure target provenance extension
  · exact uniqueCensus30 composition closure target provenance extension
  · exact uniqueCensus31 composition closure target provenance extension
  · exact uniqueCensus32 composition closure target provenance extension
  · exact uniqueCensus33 composition closure target provenance extension
  · exact uniqueCensus34 composition closure target provenance extension
  · exact uniqueCensus35 composition closure target provenance extension
  · exact uniqueCensus36 composition closure target provenance extension
  · exact uniqueCensus37 composition closure target provenance extension
  · exact uniqueCensus38 composition closure target provenance extension
  · exact uniqueCensus39 composition closure target provenance extension
  · exact uniqueCensus40 composition closure target provenance extension
  · exact uniqueCensus41 composition closure target provenance extension
  · exact uniqueCensus42 composition closure target provenance extension
  · exact uniqueCensus43 composition closure target provenance extension
  · exact uniqueCensus44 composition closure target provenance extension
  · exact uniqueCensus45 composition closure target provenance extension
  · exact uniqueCensus46 composition closure target provenance extension
  · exact uniqueCensus47 composition closure target provenance extension
  · exact uniqueCensus48 composition closure target provenance extension
  · exact uniqueCensus49 composition closure target provenance extension
  · exact uniqueCensus50 composition closure target provenance extension
  · exact uniqueCensus51 composition closure target provenance extension
  · exact uniqueCensus52 composition closure target provenance extension
  · exact uniqueCensus53 composition closure target provenance extension
  · exact uniqueCensus54 composition closure target provenance extension
  · exact uniqueCensus55 composition closure target provenance extension
  · exact uniqueCensus56 composition closure target provenance extension
  · exact uniqueCensus57 composition closure target provenance extension
  · exact uniqueCensus58 composition closure target provenance extension
  · exact uniqueCensus59 composition closure target provenance extension
  · exact uniqueCensus60 composition closure target provenance extension
  · exact uniqueCensus61 composition closure target provenance extension
  · exact uniqueCensus62 composition closure target provenance extension
  · exact uniqueCensus63 composition closure target provenance extension
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.boundary = .admitted ∧ c.pinning = .admitted ∧ c.free = .admitted ∧ c.global = .admitted ∧ c.internal = .admitted ∧ c.composition = .admitted ∧ c.closure = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support boundary pinning free global internal composition closure target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem pinning_rejected_rejected (c : Candidate) (h : c.pinning = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pinning eq
    rw [h] at field
    cases field

theorem free_rejected_rejected (c : Candidate) (h : c.free = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.free eq
    rw [h] at field
    cases field

theorem global_rejected_rejected (c : Candidate) (h : c.global = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.global eq
    rw [h] at field
    cases field

theorem internal_rejected_rejected (c : Candidate) (h : c.internal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.internal eq
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

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
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

end SFT.Physics.CosmoCompleteBudgetGrammar
