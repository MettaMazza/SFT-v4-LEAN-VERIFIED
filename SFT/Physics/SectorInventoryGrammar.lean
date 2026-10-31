import SFT.Physics.SectorInventoryCensus0
import SFT.Physics.SectorInventoryCensus1
import SFT.Physics.SectorInventoryCensus2
import SFT.Physics.SectorInventoryCensus3
import SFT.Physics.SectorInventoryCensus4
import SFT.Physics.SectorInventoryCensus5
import SFT.Physics.SectorInventoryCensus6
import SFT.Physics.SectorInventoryCensus7
import SFT.Physics.SectorInventoryCensus8
import SFT.Physics.SectorInventoryCensus9
import SFT.Physics.SectorInventoryCensus10
import SFT.Physics.SectorInventoryCensus11
import SFT.Physics.SectorInventoryCensus12
import SFT.Physics.SectorInventoryCensus13
import SFT.Physics.SectorInventoryCensus14
import SFT.Physics.SectorInventoryCensus15
import SFT.Physics.SectorInventoryCensus16
import SFT.Physics.SectorInventoryCensus17
import SFT.Physics.SectorInventoryCensus18
import SFT.Physics.SectorInventoryCensus19
import SFT.Physics.SectorInventoryCensus20
import SFT.Physics.SectorInventoryCensus21
import SFT.Physics.SectorInventoryCensus22
import SFT.Physics.SectorInventoryCensus23
import SFT.Physics.SectorInventoryCensus24
import SFT.Physics.SectorInventoryCensus25
import SFT.Physics.SectorInventoryCensus26
import SFT.Physics.SectorInventoryCensus27
import SFT.Physics.SectorInventoryCensus28
import SFT.Physics.SectorInventoryCensus29
import SFT.Physics.SectorInventoryCensus30
import SFT.Physics.SectorInventoryCensus31
import SFT.Physics.SectorInventoryCensus32
import SFT.Physics.SectorInventoryCensus33
import SFT.Physics.SectorInventoryCensus34
import SFT.Physics.SectorInventoryCensus35
import SFT.Physics.SectorInventoryCensus36
import SFT.Physics.SectorInventoryCensus37
import SFT.Physics.SectorInventoryCensus38
import SFT.Physics.SectorInventoryCensus39
import SFT.Physics.SectorInventoryCensus40
import SFT.Physics.SectorInventoryCensus41
import SFT.Physics.SectorInventoryCensus42
import SFT.Physics.SectorInventoryCensus43
import SFT.Physics.SectorInventoryCensus44
import SFT.Physics.SectorInventoryCensus45
import SFT.Physics.SectorInventoryCensus46
import SFT.Physics.SectorInventoryCensus47
import SFT.Physics.SectorInventoryCensus48
import SFT.Physics.SectorInventoryCensus49
import SFT.Physics.SectorInventoryCensus50
import SFT.Physics.SectorInventoryCensus51
import SFT.Physics.SectorInventoryCensus52
import SFT.Physics.SectorInventoryCensus53
import SFT.Physics.SectorInventoryCensus54
import SFT.Physics.SectorInventoryCensus55
import SFT.Physics.SectorInventoryCensus56
import SFT.Physics.SectorInventoryCensus57
import SFT.Physics.SectorInventoryCensus58
import SFT.Physics.SectorInventoryCensus59
import SFT.Physics.SectorInventoryCensus60
import SFT.Physics.SectorInventoryCensus61
import SFT.Physics.SectorInventoryCensus62
import SFT.Physics.SectorInventoryCensus63
namespace SFT.Physics.SectorInventoryGrammar
open SFT.Foundation
set_option maxRecDepth 20000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk sector charge mediator coupling running singlet mixing mass inventory measurement record extension =>
  cases sector <;> cases charge <;> cases mediator <;> cases coupling <;> cases running <;> cases singlet
  · exact decisionCensus0 mixing mass inventory measurement record extension
  · exact decisionCensus1 mixing mass inventory measurement record extension
  · exact decisionCensus2 mixing mass inventory measurement record extension
  · exact decisionCensus3 mixing mass inventory measurement record extension
  · exact decisionCensus4 mixing mass inventory measurement record extension
  · exact decisionCensus5 mixing mass inventory measurement record extension
  · exact decisionCensus6 mixing mass inventory measurement record extension
  · exact decisionCensus7 mixing mass inventory measurement record extension
  · exact decisionCensus8 mixing mass inventory measurement record extension
  · exact decisionCensus9 mixing mass inventory measurement record extension
  · exact decisionCensus10 mixing mass inventory measurement record extension
  · exact decisionCensus11 mixing mass inventory measurement record extension
  · exact decisionCensus12 mixing mass inventory measurement record extension
  · exact decisionCensus13 mixing mass inventory measurement record extension
  · exact decisionCensus14 mixing mass inventory measurement record extension
  · exact decisionCensus15 mixing mass inventory measurement record extension
  · exact decisionCensus16 mixing mass inventory measurement record extension
  · exact decisionCensus17 mixing mass inventory measurement record extension
  · exact decisionCensus18 mixing mass inventory measurement record extension
  · exact decisionCensus19 mixing mass inventory measurement record extension
  · exact decisionCensus20 mixing mass inventory measurement record extension
  · exact decisionCensus21 mixing mass inventory measurement record extension
  · exact decisionCensus22 mixing mass inventory measurement record extension
  · exact decisionCensus23 mixing mass inventory measurement record extension
  · exact decisionCensus24 mixing mass inventory measurement record extension
  · exact decisionCensus25 mixing mass inventory measurement record extension
  · exact decisionCensus26 mixing mass inventory measurement record extension
  · exact decisionCensus27 mixing mass inventory measurement record extension
  · exact decisionCensus28 mixing mass inventory measurement record extension
  · exact decisionCensus29 mixing mass inventory measurement record extension
  · exact decisionCensus30 mixing mass inventory measurement record extension
  · exact decisionCensus31 mixing mass inventory measurement record extension
  · exact decisionCensus32 mixing mass inventory measurement record extension
  · exact decisionCensus33 mixing mass inventory measurement record extension
  · exact decisionCensus34 mixing mass inventory measurement record extension
  · exact decisionCensus35 mixing mass inventory measurement record extension
  · exact decisionCensus36 mixing mass inventory measurement record extension
  · exact decisionCensus37 mixing mass inventory measurement record extension
  · exact decisionCensus38 mixing mass inventory measurement record extension
  · exact decisionCensus39 mixing mass inventory measurement record extension
  · exact decisionCensus40 mixing mass inventory measurement record extension
  · exact decisionCensus41 mixing mass inventory measurement record extension
  · exact decisionCensus42 mixing mass inventory measurement record extension
  · exact decisionCensus43 mixing mass inventory measurement record extension
  · exact decisionCensus44 mixing mass inventory measurement record extension
  · exact decisionCensus45 mixing mass inventory measurement record extension
  · exact decisionCensus46 mixing mass inventory measurement record extension
  · exact decisionCensus47 mixing mass inventory measurement record extension
  · exact decisionCensus48 mixing mass inventory measurement record extension
  · exact decisionCensus49 mixing mass inventory measurement record extension
  · exact decisionCensus50 mixing mass inventory measurement record extension
  · exact decisionCensus51 mixing mass inventory measurement record extension
  · exact decisionCensus52 mixing mass inventory measurement record extension
  · exact decisionCensus53 mixing mass inventory measurement record extension
  · exact decisionCensus54 mixing mass inventory measurement record extension
  · exact decisionCensus55 mixing mass inventory measurement record extension
  · exact decisionCensus56 mixing mass inventory measurement record extension
  · exact decisionCensus57 mixing mass inventory measurement record extension
  · exact decisionCensus58 mixing mass inventory measurement record extension
  · exact decisionCensus59 mixing mass inventory measurement record extension
  · exact decisionCensus60 mixing mass inventory measurement record extension
  · exact decisionCensus61 mixing mass inventory measurement record extension
  · exact decisionCensus62 mixing mass inventory measurement record extension
  · exact decisionCensus63 mixing mass inventory measurement record extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk sector charge mediator coupling running singlet mixing mass inventory measurement record extension =>
  cases sector <;> cases charge <;> cases mediator <;> cases coupling <;> cases running <;> cases singlet
  · exact uniqueCensus0 mixing mass inventory measurement record extension
  · exact uniqueCensus1 mixing mass inventory measurement record extension
  · exact uniqueCensus2 mixing mass inventory measurement record extension
  · exact uniqueCensus3 mixing mass inventory measurement record extension
  · exact uniqueCensus4 mixing mass inventory measurement record extension
  · exact uniqueCensus5 mixing mass inventory measurement record extension
  · exact uniqueCensus6 mixing mass inventory measurement record extension
  · exact uniqueCensus7 mixing mass inventory measurement record extension
  · exact uniqueCensus8 mixing mass inventory measurement record extension
  · exact uniqueCensus9 mixing mass inventory measurement record extension
  · exact uniqueCensus10 mixing mass inventory measurement record extension
  · exact uniqueCensus11 mixing mass inventory measurement record extension
  · exact uniqueCensus12 mixing mass inventory measurement record extension
  · exact uniqueCensus13 mixing mass inventory measurement record extension
  · exact uniqueCensus14 mixing mass inventory measurement record extension
  · exact uniqueCensus15 mixing mass inventory measurement record extension
  · exact uniqueCensus16 mixing mass inventory measurement record extension
  · exact uniqueCensus17 mixing mass inventory measurement record extension
  · exact uniqueCensus18 mixing mass inventory measurement record extension
  · exact uniqueCensus19 mixing mass inventory measurement record extension
  · exact uniqueCensus20 mixing mass inventory measurement record extension
  · exact uniqueCensus21 mixing mass inventory measurement record extension
  · exact uniqueCensus22 mixing mass inventory measurement record extension
  · exact uniqueCensus23 mixing mass inventory measurement record extension
  · exact uniqueCensus24 mixing mass inventory measurement record extension
  · exact uniqueCensus25 mixing mass inventory measurement record extension
  · exact uniqueCensus26 mixing mass inventory measurement record extension
  · exact uniqueCensus27 mixing mass inventory measurement record extension
  · exact uniqueCensus28 mixing mass inventory measurement record extension
  · exact uniqueCensus29 mixing mass inventory measurement record extension
  · exact uniqueCensus30 mixing mass inventory measurement record extension
  · exact uniqueCensus31 mixing mass inventory measurement record extension
  · exact uniqueCensus32 mixing mass inventory measurement record extension
  · exact uniqueCensus33 mixing mass inventory measurement record extension
  · exact uniqueCensus34 mixing mass inventory measurement record extension
  · exact uniqueCensus35 mixing mass inventory measurement record extension
  · exact uniqueCensus36 mixing mass inventory measurement record extension
  · exact uniqueCensus37 mixing mass inventory measurement record extension
  · exact uniqueCensus38 mixing mass inventory measurement record extension
  · exact uniqueCensus39 mixing mass inventory measurement record extension
  · exact uniqueCensus40 mixing mass inventory measurement record extension
  · exact uniqueCensus41 mixing mass inventory measurement record extension
  · exact uniqueCensus42 mixing mass inventory measurement record extension
  · exact uniqueCensus43 mixing mass inventory measurement record extension
  · exact uniqueCensus44 mixing mass inventory measurement record extension
  · exact uniqueCensus45 mixing mass inventory measurement record extension
  · exact uniqueCensus46 mixing mass inventory measurement record extension
  · exact uniqueCensus47 mixing mass inventory measurement record extension
  · exact uniqueCensus48 mixing mass inventory measurement record extension
  · exact uniqueCensus49 mixing mass inventory measurement record extension
  · exact uniqueCensus50 mixing mass inventory measurement record extension
  · exact uniqueCensus51 mixing mass inventory measurement record extension
  · exact uniqueCensus52 mixing mass inventory measurement record extension
  · exact uniqueCensus53 mixing mass inventory measurement record extension
  · exact uniqueCensus54 mixing mass inventory measurement record extension
  · exact uniqueCensus55 mixing mass inventory measurement record extension
  · exact uniqueCensus56 mixing mass inventory measurement record extension
  · exact uniqueCensus57 mixing mass inventory measurement record extension
  · exact uniqueCensus58 mixing mass inventory measurement record extension
  · exact uniqueCensus59 mixing mass inventory measurement record extension
  · exact uniqueCensus60 mixing mass inventory measurement record extension
  · exact uniqueCensus61 mixing mass inventory measurement record extension
  · exact uniqueCensus62 mixing mass inventory measurement record extension
  · exact uniqueCensus63 mixing mass inventory measurement record extension

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.sector = .admitted ∧ c.charge = .admitted ∧ c.mediator = .admitted ∧ c.coupling = .admitted ∧ c.running = .admitted ∧ c.singlet = .admitted ∧ c.mixing = .admitted ∧ c.mass = .admitted ∧ c.inventory = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk sector charge mediator coupling running singlet mixing mass inventory measurement record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11
      rfl

theorem sector_rejected_rejected (c : Candidate) (h : c.sector = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.sector eq
    rw [h] at field
    cases field

theorem charge_rejected_rejected (c : Candidate) (h : c.charge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.charge eq
    rw [h] at field
    cases field

theorem mediator_rejected_rejected (c : Candidate) (h : c.mediator = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mediator eq
    rw [h] at field
    cases field

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
    rw [h] at field
    cases field

theorem running_rejected_rejected (c : Candidate) (h : c.running = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.running eq
    rw [h] at field
    cases field

theorem singlet_rejected_rejected (c : Candidate) (h : c.singlet = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.singlet eq
    rw [h] at field
    cases field

theorem mixing_rejected_rejected (c : Candidate) (h : c.mixing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mixing eq
    rw [h] at field
    cases field

theorem mass_rejected_rejected (c : Candidate) (h : c.mass = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mass eq
    rw [h] at field
    cases field

theorem inventory_rejected_rejected (c : Candidate) (h : c.inventory = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.inventory eq
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

end SFT.Physics.SectorInventoryGrammar
