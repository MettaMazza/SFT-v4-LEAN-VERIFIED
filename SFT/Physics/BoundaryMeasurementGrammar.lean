import SFT.Physics.BoundaryMeasurementCensus0
import SFT.Physics.BoundaryMeasurementCensus1
import SFT.Physics.BoundaryMeasurementCensus2
import SFT.Physics.BoundaryMeasurementCensus3
import SFT.Physics.BoundaryMeasurementCensus4
import SFT.Physics.BoundaryMeasurementCensus5
import SFT.Physics.BoundaryMeasurementCensus6
import SFT.Physics.BoundaryMeasurementCensus7
import SFT.Physics.BoundaryMeasurementCensus8
import SFT.Physics.BoundaryMeasurementCensus9
import SFT.Physics.BoundaryMeasurementCensus10
import SFT.Physics.BoundaryMeasurementCensus11
import SFT.Physics.BoundaryMeasurementCensus12
import SFT.Physics.BoundaryMeasurementCensus13
import SFT.Physics.BoundaryMeasurementCensus14
import SFT.Physics.BoundaryMeasurementCensus15
import SFT.Physics.BoundaryMeasurementCensus16
import SFT.Physics.BoundaryMeasurementCensus17
import SFT.Physics.BoundaryMeasurementCensus18
import SFT.Physics.BoundaryMeasurementCensus19
import SFT.Physics.BoundaryMeasurementCensus20
import SFT.Physics.BoundaryMeasurementCensus21
import SFT.Physics.BoundaryMeasurementCensus22
import SFT.Physics.BoundaryMeasurementCensus23
import SFT.Physics.BoundaryMeasurementCensus24
import SFT.Physics.BoundaryMeasurementCensus25
import SFT.Physics.BoundaryMeasurementCensus26
import SFT.Physics.BoundaryMeasurementCensus27
import SFT.Physics.BoundaryMeasurementCensus28
import SFT.Physics.BoundaryMeasurementCensus29
import SFT.Physics.BoundaryMeasurementCensus30
import SFT.Physics.BoundaryMeasurementCensus31
import SFT.Physics.BoundaryMeasurementCensus32
import SFT.Physics.BoundaryMeasurementCensus33
import SFT.Physics.BoundaryMeasurementCensus34
import SFT.Physics.BoundaryMeasurementCensus35
import SFT.Physics.BoundaryMeasurementCensus36
import SFT.Physics.BoundaryMeasurementCensus37
import SFT.Physics.BoundaryMeasurementCensus38
import SFT.Physics.BoundaryMeasurementCensus39
import SFT.Physics.BoundaryMeasurementCensus40
import SFT.Physics.BoundaryMeasurementCensus41
import SFT.Physics.BoundaryMeasurementCensus42
import SFT.Physics.BoundaryMeasurementCensus43
import SFT.Physics.BoundaryMeasurementCensus44
import SFT.Physics.BoundaryMeasurementCensus45
import SFT.Physics.BoundaryMeasurementCensus46
import SFT.Physics.BoundaryMeasurementCensus47
import SFT.Physics.BoundaryMeasurementCensus48
import SFT.Physics.BoundaryMeasurementCensus49
import SFT.Physics.BoundaryMeasurementCensus50
import SFT.Physics.BoundaryMeasurementCensus51
import SFT.Physics.BoundaryMeasurementCensus52
import SFT.Physics.BoundaryMeasurementCensus53
import SFT.Physics.BoundaryMeasurementCensus54
import SFT.Physics.BoundaryMeasurementCensus55
import SFT.Physics.BoundaryMeasurementCensus56
import SFT.Physics.BoundaryMeasurementCensus57
import SFT.Physics.BoundaryMeasurementCensus58
import SFT.Physics.BoundaryMeasurementCensus59
import SFT.Physics.BoundaryMeasurementCensus60
import SFT.Physics.BoundaryMeasurementCensus61
import SFT.Physics.BoundaryMeasurementCensus62
import SFT.Physics.BoundaryMeasurementCensus63
namespace SFT.Physics.BoundaryMeasurementGrammar
open SFT.Foundation
set_option maxRecDepth 20000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk source distance response scale candidates selection stopping target record extension =>
  cases source <;> cases distance <;> cases response <;> cases scale <;> cases candidates <;> cases selection
  · exact decisionCensus0 stopping target record extension
  · exact decisionCensus1 stopping target record extension
  · exact decisionCensus2 stopping target record extension
  · exact decisionCensus3 stopping target record extension
  · exact decisionCensus4 stopping target record extension
  · exact decisionCensus5 stopping target record extension
  · exact decisionCensus6 stopping target record extension
  · exact decisionCensus7 stopping target record extension
  · exact decisionCensus8 stopping target record extension
  · exact decisionCensus9 stopping target record extension
  · exact decisionCensus10 stopping target record extension
  · exact decisionCensus11 stopping target record extension
  · exact decisionCensus12 stopping target record extension
  · exact decisionCensus13 stopping target record extension
  · exact decisionCensus14 stopping target record extension
  · exact decisionCensus15 stopping target record extension
  · exact decisionCensus16 stopping target record extension
  · exact decisionCensus17 stopping target record extension
  · exact decisionCensus18 stopping target record extension
  · exact decisionCensus19 stopping target record extension
  · exact decisionCensus20 stopping target record extension
  · exact decisionCensus21 stopping target record extension
  · exact decisionCensus22 stopping target record extension
  · exact decisionCensus23 stopping target record extension
  · exact decisionCensus24 stopping target record extension
  · exact decisionCensus25 stopping target record extension
  · exact decisionCensus26 stopping target record extension
  · exact decisionCensus27 stopping target record extension
  · exact decisionCensus28 stopping target record extension
  · exact decisionCensus29 stopping target record extension
  · exact decisionCensus30 stopping target record extension
  · exact decisionCensus31 stopping target record extension
  · exact decisionCensus32 stopping target record extension
  · exact decisionCensus33 stopping target record extension
  · exact decisionCensus34 stopping target record extension
  · exact decisionCensus35 stopping target record extension
  · exact decisionCensus36 stopping target record extension
  · exact decisionCensus37 stopping target record extension
  · exact decisionCensus38 stopping target record extension
  · exact decisionCensus39 stopping target record extension
  · exact decisionCensus40 stopping target record extension
  · exact decisionCensus41 stopping target record extension
  · exact decisionCensus42 stopping target record extension
  · exact decisionCensus43 stopping target record extension
  · exact decisionCensus44 stopping target record extension
  · exact decisionCensus45 stopping target record extension
  · exact decisionCensus46 stopping target record extension
  · exact decisionCensus47 stopping target record extension
  · exact decisionCensus48 stopping target record extension
  · exact decisionCensus49 stopping target record extension
  · exact decisionCensus50 stopping target record extension
  · exact decisionCensus51 stopping target record extension
  · exact decisionCensus52 stopping target record extension
  · exact decisionCensus53 stopping target record extension
  · exact decisionCensus54 stopping target record extension
  · exact decisionCensus55 stopping target record extension
  · exact decisionCensus56 stopping target record extension
  · exact decisionCensus57 stopping target record extension
  · exact decisionCensus58 stopping target record extension
  · exact decisionCensus59 stopping target record extension
  · exact decisionCensus60 stopping target record extension
  · exact decisionCensus61 stopping target record extension
  · exact decisionCensus62 stopping target record extension
  · exact decisionCensus63 stopping target record extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk source distance response scale candidates selection stopping target record extension =>
  cases source <;> cases distance <;> cases response <;> cases scale <;> cases candidates <;> cases selection
  · exact uniqueCensus0 stopping target record extension
  · exact uniqueCensus1 stopping target record extension
  · exact uniqueCensus2 stopping target record extension
  · exact uniqueCensus3 stopping target record extension
  · exact uniqueCensus4 stopping target record extension
  · exact uniqueCensus5 stopping target record extension
  · exact uniqueCensus6 stopping target record extension
  · exact uniqueCensus7 stopping target record extension
  · exact uniqueCensus8 stopping target record extension
  · exact uniqueCensus9 stopping target record extension
  · exact uniqueCensus10 stopping target record extension
  · exact uniqueCensus11 stopping target record extension
  · exact uniqueCensus12 stopping target record extension
  · exact uniqueCensus13 stopping target record extension
  · exact uniqueCensus14 stopping target record extension
  · exact uniqueCensus15 stopping target record extension
  · exact uniqueCensus16 stopping target record extension
  · exact uniqueCensus17 stopping target record extension
  · exact uniqueCensus18 stopping target record extension
  · exact uniqueCensus19 stopping target record extension
  · exact uniqueCensus20 stopping target record extension
  · exact uniqueCensus21 stopping target record extension
  · exact uniqueCensus22 stopping target record extension
  · exact uniqueCensus23 stopping target record extension
  · exact uniqueCensus24 stopping target record extension
  · exact uniqueCensus25 stopping target record extension
  · exact uniqueCensus26 stopping target record extension
  · exact uniqueCensus27 stopping target record extension
  · exact uniqueCensus28 stopping target record extension
  · exact uniqueCensus29 stopping target record extension
  · exact uniqueCensus30 stopping target record extension
  · exact uniqueCensus31 stopping target record extension
  · exact uniqueCensus32 stopping target record extension
  · exact uniqueCensus33 stopping target record extension
  · exact uniqueCensus34 stopping target record extension
  · exact uniqueCensus35 stopping target record extension
  · exact uniqueCensus36 stopping target record extension
  · exact uniqueCensus37 stopping target record extension
  · exact uniqueCensus38 stopping target record extension
  · exact uniqueCensus39 stopping target record extension
  · exact uniqueCensus40 stopping target record extension
  · exact uniqueCensus41 stopping target record extension
  · exact uniqueCensus42 stopping target record extension
  · exact uniqueCensus43 stopping target record extension
  · exact uniqueCensus44 stopping target record extension
  · exact uniqueCensus45 stopping target record extension
  · exact uniqueCensus46 stopping target record extension
  · exact uniqueCensus47 stopping target record extension
  · exact uniqueCensus48 stopping target record extension
  · exact uniqueCensus49 stopping target record extension
  · exact uniqueCensus50 stopping target record extension
  · exact uniqueCensus51 stopping target record extension
  · exact uniqueCensus52 stopping target record extension
  · exact uniqueCensus53 stopping target record extension
  · exact uniqueCensus54 stopping target record extension
  · exact uniqueCensus55 stopping target record extension
  · exact uniqueCensus56 stopping target record extension
  · exact uniqueCensus57 stopping target record extension
  · exact uniqueCensus58 stopping target record extension
  · exact uniqueCensus59 stopping target record extension
  · exact uniqueCensus60 stopping target record extension
  · exact uniqueCensus61 stopping target record extension
  · exact uniqueCensus62 stopping target record extension
  · exact uniqueCensus63 stopping target record extension

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.source = .admitted ∧ c.distance = .admitted ∧ c.response = .admitted ∧ c.scale = .admitted ∧ c.candidates = .admitted ∧ c.selection = .admitted ∧ c.stopping = .admitted ∧ c.target = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk source distance response scale candidates selection stopping target record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem distance_rejected_rejected (c : Candidate) (h : c.distance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distance eq
    rw [h] at field
    cases field

theorem response_rejected_rejected (c : Candidate) (h : c.response = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.response eq
    rw [h] at field
    cases field

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
    rw [h] at field
    cases field

theorem candidates_rejected_rejected (c : Candidate) (h : c.candidates = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.candidates eq
    rw [h] at field
    cases field

theorem selection_rejected_rejected (c : Candidate) (h : c.selection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selection eq
    rw [h] at field
    cases field

theorem stopping_rejected_rejected (c : Candidate) (h : c.stopping = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.stopping eq
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

end SFT.Physics.BoundaryMeasurementGrammar
