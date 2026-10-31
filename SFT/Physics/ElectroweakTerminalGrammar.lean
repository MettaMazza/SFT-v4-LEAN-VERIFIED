import SFT.Physics.ElectroweakTerminalCensus0
import SFT.Physics.ElectroweakTerminalCensus1
import SFT.Physics.ElectroweakTerminalCensus2
import SFT.Physics.ElectroweakTerminalCensus3
import SFT.Physics.ElectroweakTerminalCensus4
import SFT.Physics.ElectroweakTerminalCensus5
import SFT.Physics.ElectroweakTerminalCensus6
import SFT.Physics.ElectroweakTerminalCensus7
import SFT.Physics.ElectroweakTerminalCensus8
import SFT.Physics.ElectroweakTerminalCensus9
import SFT.Physics.ElectroweakTerminalCensus10
import SFT.Physics.ElectroweakTerminalCensus11
import SFT.Physics.ElectroweakTerminalCensus12
import SFT.Physics.ElectroweakTerminalCensus13
import SFT.Physics.ElectroweakTerminalCensus14
import SFT.Physics.ElectroweakTerminalCensus15
import SFT.Physics.ElectroweakTerminalCensus16
import SFT.Physics.ElectroweakTerminalCensus17
import SFT.Physics.ElectroweakTerminalCensus18
import SFT.Physics.ElectroweakTerminalCensus19
import SFT.Physics.ElectroweakTerminalCensus20
import SFT.Physics.ElectroweakTerminalCensus21
import SFT.Physics.ElectroweakTerminalCensus22
import SFT.Physics.ElectroweakTerminalCensus23
import SFT.Physics.ElectroweakTerminalCensus24
import SFT.Physics.ElectroweakTerminalCensus25
import SFT.Physics.ElectroweakTerminalCensus26
import SFT.Physics.ElectroweakTerminalCensus27
import SFT.Physics.ElectroweakTerminalCensus28
import SFT.Physics.ElectroweakTerminalCensus29
import SFT.Physics.ElectroweakTerminalCensus30
import SFT.Physics.ElectroweakTerminalCensus31
import SFT.Physics.ElectroweakTerminalCensus32
import SFT.Physics.ElectroweakTerminalCensus33
import SFT.Physics.ElectroweakTerminalCensus34
import SFT.Physics.ElectroweakTerminalCensus35
import SFT.Physics.ElectroweakTerminalCensus36
import SFT.Physics.ElectroweakTerminalCensus37
import SFT.Physics.ElectroweakTerminalCensus38
import SFT.Physics.ElectroweakTerminalCensus39
import SFT.Physics.ElectroweakTerminalCensus40
import SFT.Physics.ElectroweakTerminalCensus41
import SFT.Physics.ElectroweakTerminalCensus42
import SFT.Physics.ElectroweakTerminalCensus43
import SFT.Physics.ElectroweakTerminalCensus44
import SFT.Physics.ElectroweakTerminalCensus45
import SFT.Physics.ElectroweakTerminalCensus46
import SFT.Physics.ElectroweakTerminalCensus47
import SFT.Physics.ElectroweakTerminalCensus48
import SFT.Physics.ElectroweakTerminalCensus49
import SFT.Physics.ElectroweakTerminalCensus50
import SFT.Physics.ElectroweakTerminalCensus51
import SFT.Physics.ElectroweakTerminalCensus52
import SFT.Physics.ElectroweakTerminalCensus53
import SFT.Physics.ElectroweakTerminalCensus54
import SFT.Physics.ElectroweakTerminalCensus55
import SFT.Physics.ElectroweakTerminalCensus56
import SFT.Physics.ElectroweakTerminalCensus57
import SFT.Physics.ElectroweakTerminalCensus58
import SFT.Physics.ElectroweakTerminalCensus59
import SFT.Physics.ElectroweakTerminalCensus60
import SFT.Physics.ElectroweakTerminalCensus61
import SFT.Physics.ElectroweakTerminalCensus62
import SFT.Physics.ElectroweakTerminalCensus63
namespace SFT.Physics.ElectroweakTerminalGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier terminal support relation correction sign enumeration minimality measurement extension =>
  cases carrier <;> cases terminal <;> cases support <;> cases relation <;> cases correction <;> cases sign
  · exact decisionCensus0 enumeration minimality measurement extension
  · exact decisionCensus1 enumeration minimality measurement extension
  · exact decisionCensus2 enumeration minimality measurement extension
  · exact decisionCensus3 enumeration minimality measurement extension
  · exact decisionCensus4 enumeration minimality measurement extension
  · exact decisionCensus5 enumeration minimality measurement extension
  · exact decisionCensus6 enumeration minimality measurement extension
  · exact decisionCensus7 enumeration minimality measurement extension
  · exact decisionCensus8 enumeration minimality measurement extension
  · exact decisionCensus9 enumeration minimality measurement extension
  · exact decisionCensus10 enumeration minimality measurement extension
  · exact decisionCensus11 enumeration minimality measurement extension
  · exact decisionCensus12 enumeration minimality measurement extension
  · exact decisionCensus13 enumeration minimality measurement extension
  · exact decisionCensus14 enumeration minimality measurement extension
  · exact decisionCensus15 enumeration minimality measurement extension
  · exact decisionCensus16 enumeration minimality measurement extension
  · exact decisionCensus17 enumeration minimality measurement extension
  · exact decisionCensus18 enumeration minimality measurement extension
  · exact decisionCensus19 enumeration minimality measurement extension
  · exact decisionCensus20 enumeration minimality measurement extension
  · exact decisionCensus21 enumeration minimality measurement extension
  · exact decisionCensus22 enumeration minimality measurement extension
  · exact decisionCensus23 enumeration minimality measurement extension
  · exact decisionCensus24 enumeration minimality measurement extension
  · exact decisionCensus25 enumeration minimality measurement extension
  · exact decisionCensus26 enumeration minimality measurement extension
  · exact decisionCensus27 enumeration minimality measurement extension
  · exact decisionCensus28 enumeration minimality measurement extension
  · exact decisionCensus29 enumeration minimality measurement extension
  · exact decisionCensus30 enumeration minimality measurement extension
  · exact decisionCensus31 enumeration minimality measurement extension
  · exact decisionCensus32 enumeration minimality measurement extension
  · exact decisionCensus33 enumeration minimality measurement extension
  · exact decisionCensus34 enumeration minimality measurement extension
  · exact decisionCensus35 enumeration minimality measurement extension
  · exact decisionCensus36 enumeration minimality measurement extension
  · exact decisionCensus37 enumeration minimality measurement extension
  · exact decisionCensus38 enumeration minimality measurement extension
  · exact decisionCensus39 enumeration minimality measurement extension
  · exact decisionCensus40 enumeration minimality measurement extension
  · exact decisionCensus41 enumeration minimality measurement extension
  · exact decisionCensus42 enumeration minimality measurement extension
  · exact decisionCensus43 enumeration minimality measurement extension
  · exact decisionCensus44 enumeration minimality measurement extension
  · exact decisionCensus45 enumeration minimality measurement extension
  · exact decisionCensus46 enumeration minimality measurement extension
  · exact decisionCensus47 enumeration minimality measurement extension
  · exact decisionCensus48 enumeration minimality measurement extension
  · exact decisionCensus49 enumeration minimality measurement extension
  · exact decisionCensus50 enumeration minimality measurement extension
  · exact decisionCensus51 enumeration minimality measurement extension
  · exact decisionCensus52 enumeration minimality measurement extension
  · exact decisionCensus53 enumeration minimality measurement extension
  · exact decisionCensus54 enumeration minimality measurement extension
  · exact decisionCensus55 enumeration minimality measurement extension
  · exact decisionCensus56 enumeration minimality measurement extension
  · exact decisionCensus57 enumeration minimality measurement extension
  · exact decisionCensus58 enumeration minimality measurement extension
  · exact decisionCensus59 enumeration minimality measurement extension
  · exact decisionCensus60 enumeration minimality measurement extension
  · exact decisionCensus61 enumeration minimality measurement extension
  · exact decisionCensus62 enumeration minimality measurement extension
  · exact decisionCensus63 enumeration minimality measurement extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk carrier terminal support relation correction sign enumeration minimality measurement extension =>
  cases carrier <;> cases terminal <;> cases support <;> cases relation <;> cases correction <;> cases sign
  · exact uniqueCensus0 enumeration minimality measurement extension
  · exact uniqueCensus1 enumeration minimality measurement extension
  · exact uniqueCensus2 enumeration minimality measurement extension
  · exact uniqueCensus3 enumeration minimality measurement extension
  · exact uniqueCensus4 enumeration minimality measurement extension
  · exact uniqueCensus5 enumeration minimality measurement extension
  · exact uniqueCensus6 enumeration minimality measurement extension
  · exact uniqueCensus7 enumeration minimality measurement extension
  · exact uniqueCensus8 enumeration minimality measurement extension
  · exact uniqueCensus9 enumeration minimality measurement extension
  · exact uniqueCensus10 enumeration minimality measurement extension
  · exact uniqueCensus11 enumeration minimality measurement extension
  · exact uniqueCensus12 enumeration minimality measurement extension
  · exact uniqueCensus13 enumeration minimality measurement extension
  · exact uniqueCensus14 enumeration minimality measurement extension
  · exact uniqueCensus15 enumeration minimality measurement extension
  · exact uniqueCensus16 enumeration minimality measurement extension
  · exact uniqueCensus17 enumeration minimality measurement extension
  · exact uniqueCensus18 enumeration minimality measurement extension
  · exact uniqueCensus19 enumeration minimality measurement extension
  · exact uniqueCensus20 enumeration minimality measurement extension
  · exact uniqueCensus21 enumeration minimality measurement extension
  · exact uniqueCensus22 enumeration minimality measurement extension
  · exact uniqueCensus23 enumeration minimality measurement extension
  · exact uniqueCensus24 enumeration minimality measurement extension
  · exact uniqueCensus25 enumeration minimality measurement extension
  · exact uniqueCensus26 enumeration minimality measurement extension
  · exact uniqueCensus27 enumeration minimality measurement extension
  · exact uniqueCensus28 enumeration minimality measurement extension
  · exact uniqueCensus29 enumeration minimality measurement extension
  · exact uniqueCensus30 enumeration minimality measurement extension
  · exact uniqueCensus31 enumeration minimality measurement extension
  · exact uniqueCensus32 enumeration minimality measurement extension
  · exact uniqueCensus33 enumeration minimality measurement extension
  · exact uniqueCensus34 enumeration minimality measurement extension
  · exact uniqueCensus35 enumeration minimality measurement extension
  · exact uniqueCensus36 enumeration minimality measurement extension
  · exact uniqueCensus37 enumeration minimality measurement extension
  · exact uniqueCensus38 enumeration minimality measurement extension
  · exact uniqueCensus39 enumeration minimality measurement extension
  · exact uniqueCensus40 enumeration minimality measurement extension
  · exact uniqueCensus41 enumeration minimality measurement extension
  · exact uniqueCensus42 enumeration minimality measurement extension
  · exact uniqueCensus43 enumeration minimality measurement extension
  · exact uniqueCensus44 enumeration minimality measurement extension
  · exact uniqueCensus45 enumeration minimality measurement extension
  · exact uniqueCensus46 enumeration minimality measurement extension
  · exact uniqueCensus47 enumeration minimality measurement extension
  · exact uniqueCensus48 enumeration minimality measurement extension
  · exact uniqueCensus49 enumeration minimality measurement extension
  · exact uniqueCensus50 enumeration minimality measurement extension
  · exact uniqueCensus51 enumeration minimality measurement extension
  · exact uniqueCensus52 enumeration minimality measurement extension
  · exact uniqueCensus53 enumeration minimality measurement extension
  · exact uniqueCensus54 enumeration minimality measurement extension
  · exact uniqueCensus55 enumeration minimality measurement extension
  · exact uniqueCensus56 enumeration minimality measurement extension
  · exact uniqueCensus57 enumeration minimality measurement extension
  · exact uniqueCensus58 enumeration minimality measurement extension
  · exact uniqueCensus59 enumeration minimality measurement extension
  · exact uniqueCensus60 enumeration minimality measurement extension
  · exact uniqueCensus61 enumeration minimality measurement extension
  · exact uniqueCensus62 enumeration minimality measurement extension
  · exact uniqueCensus63 enumeration minimality measurement extension
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.terminal = .admitted ∧ c.support = .admitted ∧ c.relation = .admitted ∧ c.correction = .admitted ∧ c.sign = .admitted ∧ c.enumeration = .admitted ∧ c.minimality = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier terminal support relation correction sign enumeration minimality measurement extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem terminal_rejected_rejected (c : Candidate) (h : c.terminal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.terminal eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
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

theorem correction_rejected_rejected (c : Candidate) (h : c.correction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.correction eq
    rw [h] at field
    cases field

theorem sign_rejected_rejected (c : Candidate) (h : c.sign = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sign eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.ElectroweakTerminalGrammar
