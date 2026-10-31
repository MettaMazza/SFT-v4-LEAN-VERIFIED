import SFT.Physics.CosmoSpatialFlatnessGrammarBase
import SFT.Physics.CosmoSpatialFlatnessCensus0
import SFT.Physics.CosmoSpatialFlatnessCensus1
import SFT.Physics.CosmoSpatialFlatnessCensus2
import SFT.Physics.CosmoSpatialFlatnessCensus3
import SFT.Physics.CosmoSpatialFlatnessCensus4
import SFT.Physics.CosmoSpatialFlatnessCensus5
import SFT.Physics.CosmoSpatialFlatnessCensus6
import SFT.Physics.CosmoSpatialFlatnessCensus7
import SFT.Physics.CosmoSpatialFlatnessCensus8
import SFT.Physics.CosmoSpatialFlatnessCensus9
import SFT.Physics.CosmoSpatialFlatnessCensus10
import SFT.Physics.CosmoSpatialFlatnessCensus11
import SFT.Physics.CosmoSpatialFlatnessCensus12
import SFT.Physics.CosmoSpatialFlatnessCensus13
import SFT.Physics.CosmoSpatialFlatnessCensus14
import SFT.Physics.CosmoSpatialFlatnessCensus15
import SFT.Physics.CosmoSpatialFlatnessCensus16
import SFT.Physics.CosmoSpatialFlatnessCensus17
import SFT.Physics.CosmoSpatialFlatnessCensus18
import SFT.Physics.CosmoSpatialFlatnessCensus19
import SFT.Physics.CosmoSpatialFlatnessCensus20
import SFT.Physics.CosmoSpatialFlatnessCensus21
import SFT.Physics.CosmoSpatialFlatnessCensus22
import SFT.Physics.CosmoSpatialFlatnessCensus23
import SFT.Physics.CosmoSpatialFlatnessCensus24
import SFT.Physics.CosmoSpatialFlatnessCensus25
import SFT.Physics.CosmoSpatialFlatnessCensus26
import SFT.Physics.CosmoSpatialFlatnessCensus27
import SFT.Physics.CosmoSpatialFlatnessCensus28
import SFT.Physics.CosmoSpatialFlatnessCensus29
import SFT.Physics.CosmoSpatialFlatnessCensus30
import SFT.Physics.CosmoSpatialFlatnessCensus31
import SFT.Physics.CosmoSpatialFlatnessCensus32
import SFT.Physics.CosmoSpatialFlatnessCensus33
import SFT.Physics.CosmoSpatialFlatnessCensus34
import SFT.Physics.CosmoSpatialFlatnessCensus35
import SFT.Physics.CosmoSpatialFlatnessCensus36
import SFT.Physics.CosmoSpatialFlatnessCensus37
import SFT.Physics.CosmoSpatialFlatnessCensus38
import SFT.Physics.CosmoSpatialFlatnessCensus39
import SFT.Physics.CosmoSpatialFlatnessCensus40
import SFT.Physics.CosmoSpatialFlatnessCensus41
import SFT.Physics.CosmoSpatialFlatnessCensus42
import SFT.Physics.CosmoSpatialFlatnessCensus43
import SFT.Physics.CosmoSpatialFlatnessCensus44
import SFT.Physics.CosmoSpatialFlatnessCensus45
import SFT.Physics.CosmoSpatialFlatnessCensus46
import SFT.Physics.CosmoSpatialFlatnessCensus47
import SFT.Physics.CosmoSpatialFlatnessCensus48
import SFT.Physics.CosmoSpatialFlatnessCensus49
import SFT.Physics.CosmoSpatialFlatnessCensus50
import SFT.Physics.CosmoSpatialFlatnessCensus51
import SFT.Physics.CosmoSpatialFlatnessCensus52
import SFT.Physics.CosmoSpatialFlatnessCensus53
import SFT.Physics.CosmoSpatialFlatnessCensus54
import SFT.Physics.CosmoSpatialFlatnessCensus55
import SFT.Physics.CosmoSpatialFlatnessCensus56
import SFT.Physics.CosmoSpatialFlatnessCensus57
import SFT.Physics.CosmoSpatialFlatnessCensus58
import SFT.Physics.CosmoSpatialFlatnessCensus59
import SFT.Physics.CosmoSpatialFlatnessCensus60
import SFT.Physics.CosmoSpatialFlatnessCensus61
import SFT.Physics.CosmoSpatialFlatnessCensus62
import SFT.Physics.CosmoSpatialFlatnessCensus63
namespace SFT.Physics.CosmoSpatialFlatnessGrammar
open SFT.Foundation
set_option maxRecDepth 20000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier component normalization completeness remainder absence refinement scope target provenance extension =>
  cases carrier <;> cases component <;> cases normalization <;> cases completeness <;> cases remainder <;> cases absence
  · exact decisionCensus0 refinement scope target provenance extension
  · exact decisionCensus1 refinement scope target provenance extension
  · exact decisionCensus2 refinement scope target provenance extension
  · exact decisionCensus3 refinement scope target provenance extension
  · exact decisionCensus4 refinement scope target provenance extension
  · exact decisionCensus5 refinement scope target provenance extension
  · exact decisionCensus6 refinement scope target provenance extension
  · exact decisionCensus7 refinement scope target provenance extension
  · exact decisionCensus8 refinement scope target provenance extension
  · exact decisionCensus9 refinement scope target provenance extension
  · exact decisionCensus10 refinement scope target provenance extension
  · exact decisionCensus11 refinement scope target provenance extension
  · exact decisionCensus12 refinement scope target provenance extension
  · exact decisionCensus13 refinement scope target provenance extension
  · exact decisionCensus14 refinement scope target provenance extension
  · exact decisionCensus15 refinement scope target provenance extension
  · exact decisionCensus16 refinement scope target provenance extension
  · exact decisionCensus17 refinement scope target provenance extension
  · exact decisionCensus18 refinement scope target provenance extension
  · exact decisionCensus19 refinement scope target provenance extension
  · exact decisionCensus20 refinement scope target provenance extension
  · exact decisionCensus21 refinement scope target provenance extension
  · exact decisionCensus22 refinement scope target provenance extension
  · exact decisionCensus23 refinement scope target provenance extension
  · exact decisionCensus24 refinement scope target provenance extension
  · exact decisionCensus25 refinement scope target provenance extension
  · exact decisionCensus26 refinement scope target provenance extension
  · exact decisionCensus27 refinement scope target provenance extension
  · exact decisionCensus28 refinement scope target provenance extension
  · exact decisionCensus29 refinement scope target provenance extension
  · exact decisionCensus30 refinement scope target provenance extension
  · exact decisionCensus31 refinement scope target provenance extension
  · exact decisionCensus32 refinement scope target provenance extension
  · exact decisionCensus33 refinement scope target provenance extension
  · exact decisionCensus34 refinement scope target provenance extension
  · exact decisionCensus35 refinement scope target provenance extension
  · exact decisionCensus36 refinement scope target provenance extension
  · exact decisionCensus37 refinement scope target provenance extension
  · exact decisionCensus38 refinement scope target provenance extension
  · exact decisionCensus39 refinement scope target provenance extension
  · exact decisionCensus40 refinement scope target provenance extension
  · exact decisionCensus41 refinement scope target provenance extension
  · exact decisionCensus42 refinement scope target provenance extension
  · exact decisionCensus43 refinement scope target provenance extension
  · exact decisionCensus44 refinement scope target provenance extension
  · exact decisionCensus45 refinement scope target provenance extension
  · exact decisionCensus46 refinement scope target provenance extension
  · exact decisionCensus47 refinement scope target provenance extension
  · exact decisionCensus48 refinement scope target provenance extension
  · exact decisionCensus49 refinement scope target provenance extension
  · exact decisionCensus50 refinement scope target provenance extension
  · exact decisionCensus51 refinement scope target provenance extension
  · exact decisionCensus52 refinement scope target provenance extension
  · exact decisionCensus53 refinement scope target provenance extension
  · exact decisionCensus54 refinement scope target provenance extension
  · exact decisionCensus55 refinement scope target provenance extension
  · exact decisionCensus56 refinement scope target provenance extension
  · exact decisionCensus57 refinement scope target provenance extension
  · exact decisionCensus58 refinement scope target provenance extension
  · exact decisionCensus59 refinement scope target provenance extension
  · exact decisionCensus60 refinement scope target provenance extension
  · exact decisionCensus61 refinement scope target provenance extension
  · exact decisionCensus62 refinement scope target provenance extension
  · exact decisionCensus63 refinement scope target provenance extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk carrier component normalization completeness remainder absence refinement scope target provenance extension =>
  cases carrier <;> cases component <;> cases normalization <;> cases completeness <;> cases remainder <;> cases absence
  · exact uniqueCensus0 refinement scope target provenance extension
  · exact uniqueCensus1 refinement scope target provenance extension
  · exact uniqueCensus2 refinement scope target provenance extension
  · exact uniqueCensus3 refinement scope target provenance extension
  · exact uniqueCensus4 refinement scope target provenance extension
  · exact uniqueCensus5 refinement scope target provenance extension
  · exact uniqueCensus6 refinement scope target provenance extension
  · exact uniqueCensus7 refinement scope target provenance extension
  · exact uniqueCensus8 refinement scope target provenance extension
  · exact uniqueCensus9 refinement scope target provenance extension
  · exact uniqueCensus10 refinement scope target provenance extension
  · exact uniqueCensus11 refinement scope target provenance extension
  · exact uniqueCensus12 refinement scope target provenance extension
  · exact uniqueCensus13 refinement scope target provenance extension
  · exact uniqueCensus14 refinement scope target provenance extension
  · exact uniqueCensus15 refinement scope target provenance extension
  · exact uniqueCensus16 refinement scope target provenance extension
  · exact uniqueCensus17 refinement scope target provenance extension
  · exact uniqueCensus18 refinement scope target provenance extension
  · exact uniqueCensus19 refinement scope target provenance extension
  · exact uniqueCensus20 refinement scope target provenance extension
  · exact uniqueCensus21 refinement scope target provenance extension
  · exact uniqueCensus22 refinement scope target provenance extension
  · exact uniqueCensus23 refinement scope target provenance extension
  · exact uniqueCensus24 refinement scope target provenance extension
  · exact uniqueCensus25 refinement scope target provenance extension
  · exact uniqueCensus26 refinement scope target provenance extension
  · exact uniqueCensus27 refinement scope target provenance extension
  · exact uniqueCensus28 refinement scope target provenance extension
  · exact uniqueCensus29 refinement scope target provenance extension
  · exact uniqueCensus30 refinement scope target provenance extension
  · exact uniqueCensus31 refinement scope target provenance extension
  · exact uniqueCensus32 refinement scope target provenance extension
  · exact uniqueCensus33 refinement scope target provenance extension
  · exact uniqueCensus34 refinement scope target provenance extension
  · exact uniqueCensus35 refinement scope target provenance extension
  · exact uniqueCensus36 refinement scope target provenance extension
  · exact uniqueCensus37 refinement scope target provenance extension
  · exact uniqueCensus38 refinement scope target provenance extension
  · exact uniqueCensus39 refinement scope target provenance extension
  · exact uniqueCensus40 refinement scope target provenance extension
  · exact uniqueCensus41 refinement scope target provenance extension
  · exact uniqueCensus42 refinement scope target provenance extension
  · exact uniqueCensus43 refinement scope target provenance extension
  · exact uniqueCensus44 refinement scope target provenance extension
  · exact uniqueCensus45 refinement scope target provenance extension
  · exact uniqueCensus46 refinement scope target provenance extension
  · exact uniqueCensus47 refinement scope target provenance extension
  · exact uniqueCensus48 refinement scope target provenance extension
  · exact uniqueCensus49 refinement scope target provenance extension
  · exact uniqueCensus50 refinement scope target provenance extension
  · exact uniqueCensus51 refinement scope target provenance extension
  · exact uniqueCensus52 refinement scope target provenance extension
  · exact uniqueCensus53 refinement scope target provenance extension
  · exact uniqueCensus54 refinement scope target provenance extension
  · exact uniqueCensus55 refinement scope target provenance extension
  · exact uniqueCensus56 refinement scope target provenance extension
  · exact uniqueCensus57 refinement scope target provenance extension
  · exact uniqueCensus58 refinement scope target provenance extension
  · exact uniqueCensus59 refinement scope target provenance extension
  · exact uniqueCensus60 refinement scope target provenance extension
  · exact uniqueCensus61 refinement scope target provenance extension
  · exact uniqueCensus62 refinement scope target provenance extension
  · exact uniqueCensus63 refinement scope target provenance extension
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.component = .admitted ∧ c.normalization = .admitted ∧ c.completeness = .admitted ∧ c.remainder = .admitted ∧ c.absence = .admitted ∧ c.refinement = .admitted ∧ c.scope = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier component normalization completeness remainder absence refinement scope target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem component_rejected_rejected (c : Candidate) (h : c.component = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.component eq
    rw [h] at field
    cases field

theorem normalization_rejected_rejected (c : Candidate) (h : c.normalization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.normalization eq
    rw [h] at field
    cases field

theorem completeness_rejected_rejected (c : Candidate) (h : c.completeness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.completeness eq
    rw [h] at field
    cases field

theorem remainder_rejected_rejected (c : Candidate) (h : c.remainder = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.remainder eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
    rw [h] at field
    cases field

theorem refinement_rejected_rejected (c : Candidate) (h : c.refinement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.refinement eq
    rw [h] at field
    cases field

theorem scope_rejected_rejected (c : Candidate) (h : c.scope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scope eq
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

end SFT.Physics.CosmoSpatialFlatnessGrammar
