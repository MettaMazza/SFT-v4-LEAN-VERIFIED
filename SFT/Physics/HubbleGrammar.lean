import SFT.Physics.HubbleCensus0
import SFT.Physics.HubbleCensus1
import SFT.Physics.HubbleCensus2
import SFT.Physics.HubbleCensus3
import SFT.Physics.HubbleCensus4
import SFT.Physics.HubbleCensus5
import SFT.Physics.HubbleCensus6
import SFT.Physics.HubbleCensus7
import SFT.Physics.HubbleCensus8
import SFT.Physics.HubbleCensus9
import SFT.Physics.HubbleCensus10
import SFT.Physics.HubbleCensus11
import SFT.Physics.HubbleCensus12
import SFT.Physics.HubbleCensus13
import SFT.Physics.HubbleCensus14
import SFT.Physics.HubbleCensus15
import SFT.Physics.HubbleCensus16
import SFT.Physics.HubbleCensus17
import SFT.Physics.HubbleCensus18
import SFT.Physics.HubbleCensus19
import SFT.Physics.HubbleCensus20
import SFT.Physics.HubbleCensus21
import SFT.Physics.HubbleCensus22
import SFT.Physics.HubbleCensus23
import SFT.Physics.HubbleCensus24
import SFT.Physics.HubbleCensus25
import SFT.Physics.HubbleCensus26
import SFT.Physics.HubbleCensus27
import SFT.Physics.HubbleCensus28
import SFT.Physics.HubbleCensus29
import SFT.Physics.HubbleCensus30
import SFT.Physics.HubbleCensus31
import SFT.Physics.HubbleCensus32
import SFT.Physics.HubbleCensus33
import SFT.Physics.HubbleCensus34
import SFT.Physics.HubbleCensus35
import SFT.Physics.HubbleCensus36
import SFT.Physics.HubbleCensus37
import SFT.Physics.HubbleCensus38
import SFT.Physics.HubbleCensus39
import SFT.Physics.HubbleCensus40
import SFT.Physics.HubbleCensus41
import SFT.Physics.HubbleCensus42
import SFT.Physics.HubbleCensus43
import SFT.Physics.HubbleCensus44
import SFT.Physics.HubbleCensus45
import SFT.Physics.HubbleCensus46
import SFT.Physics.HubbleCensus47
import SFT.Physics.HubbleCensus48
import SFT.Physics.HubbleCensus49
import SFT.Physics.HubbleCensus50
import SFT.Physics.HubbleCensus51
import SFT.Physics.HubbleCensus52
import SFT.Physics.HubbleCensus53
import SFT.Physics.HubbleCensus54
import SFT.Physics.HubbleCensus55
import SFT.Physics.HubbleCensus56
import SFT.Physics.HubbleCensus57
import SFT.Physics.HubbleCensus58
import SFT.Physics.HubbleCensus59
import SFT.Physics.HubbleCensus60
import SFT.Physics.HubbleCensus61
import SFT.Physics.HubbleCensus62
import SFT.Physics.HubbleCensus63
import SFT.Physics.HubbleCensus64
import SFT.Physics.HubbleCensus65
import SFT.Physics.HubbleCensus66
import SFT.Physics.HubbleCensus67
import SFT.Physics.HubbleCensus68
import SFT.Physics.HubbleCensus69
import SFT.Physics.HubbleCensus70
import SFT.Physics.HubbleCensus71
import SFT.Physics.HubbleCensus72
import SFT.Physics.HubbleCensus73
import SFT.Physics.HubbleCensus74
import SFT.Physics.HubbleCensus75
import SFT.Physics.HubbleCensus76
import SFT.Physics.HubbleCensus77
import SFT.Physics.HubbleCensus78
import SFT.Physics.HubbleCensus79
import SFT.Physics.HubbleCensus80
import SFT.Physics.HubbleCensus81
import SFT.Physics.HubbleCensus82
import SFT.Physics.HubbleCensus83
import SFT.Physics.HubbleCensus84
import SFT.Physics.HubbleCensus85
import SFT.Physics.HubbleCensus86
import SFT.Physics.HubbleCensus87
import SFT.Physics.HubbleCensus88
import SFT.Physics.HubbleCensus89
import SFT.Physics.HubbleCensus90
import SFT.Physics.HubbleCensus91
import SFT.Physics.HubbleCensus92
import SFT.Physics.HubbleCensus93
import SFT.Physics.HubbleCensus94
import SFT.Physics.HubbleCensus95
import SFT.Physics.HubbleCensus96
import SFT.Physics.HubbleCensus97
import SFT.Physics.HubbleCensus98
import SFT.Physics.HubbleCensus99
import SFT.Physics.HubbleCensus100
import SFT.Physics.HubbleCensus101
import SFT.Physics.HubbleCensus102
import SFT.Physics.HubbleCensus103
import SFT.Physics.HubbleCensus104
import SFT.Physics.HubbleCensus105
import SFT.Physics.HubbleCensus106
import SFT.Physics.HubbleCensus107
import SFT.Physics.HubbleCensus108
import SFT.Physics.HubbleCensus109
import SFT.Physics.HubbleCensus110
import SFT.Physics.HubbleCensus111
import SFT.Physics.HubbleCensus112
import SFT.Physics.HubbleCensus113
import SFT.Physics.HubbleCensus114
import SFT.Physics.HubbleCensus115
import SFT.Physics.HubbleCensus116
import SFT.Physics.HubbleCensus117
import SFT.Physics.HubbleCensus118
import SFT.Physics.HubbleCensus119
import SFT.Physics.HubbleCensus120
import SFT.Physics.HubbleCensus121
import SFT.Physics.HubbleCensus122
import SFT.Physics.HubbleCensus123
import SFT.Physics.HubbleCensus124
import SFT.Physics.HubbleCensus125
import SFT.Physics.HubbleCensus126
import SFT.Physics.HubbleCensus127
namespace SFT.Physics.HubbleGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier occupancy partition support leading depth orbit deepening target provenance extension =>
  cases carrier <;> cases occupancy <;> cases partition <;> cases support <;> cases leading <;> cases depth <;> cases orbit
  · exact decisionCensus0 deepening target provenance extension
  · exact decisionCensus1 deepening target provenance extension
  · exact decisionCensus2 deepening target provenance extension
  · exact decisionCensus3 deepening target provenance extension
  · exact decisionCensus4 deepening target provenance extension
  · exact decisionCensus5 deepening target provenance extension
  · exact decisionCensus6 deepening target provenance extension
  · exact decisionCensus7 deepening target provenance extension
  · exact decisionCensus8 deepening target provenance extension
  · exact decisionCensus9 deepening target provenance extension
  · exact decisionCensus10 deepening target provenance extension
  · exact decisionCensus11 deepening target provenance extension
  · exact decisionCensus12 deepening target provenance extension
  · exact decisionCensus13 deepening target provenance extension
  · exact decisionCensus14 deepening target provenance extension
  · exact decisionCensus15 deepening target provenance extension
  · exact decisionCensus16 deepening target provenance extension
  · exact decisionCensus17 deepening target provenance extension
  · exact decisionCensus18 deepening target provenance extension
  · exact decisionCensus19 deepening target provenance extension
  · exact decisionCensus20 deepening target provenance extension
  · exact decisionCensus21 deepening target provenance extension
  · exact decisionCensus22 deepening target provenance extension
  · exact decisionCensus23 deepening target provenance extension
  · exact decisionCensus24 deepening target provenance extension
  · exact decisionCensus25 deepening target provenance extension
  · exact decisionCensus26 deepening target provenance extension
  · exact decisionCensus27 deepening target provenance extension
  · exact decisionCensus28 deepening target provenance extension
  · exact decisionCensus29 deepening target provenance extension
  · exact decisionCensus30 deepening target provenance extension
  · exact decisionCensus31 deepening target provenance extension
  · exact decisionCensus32 deepening target provenance extension
  · exact decisionCensus33 deepening target provenance extension
  · exact decisionCensus34 deepening target provenance extension
  · exact decisionCensus35 deepening target provenance extension
  · exact decisionCensus36 deepening target provenance extension
  · exact decisionCensus37 deepening target provenance extension
  · exact decisionCensus38 deepening target provenance extension
  · exact decisionCensus39 deepening target provenance extension
  · exact decisionCensus40 deepening target provenance extension
  · exact decisionCensus41 deepening target provenance extension
  · exact decisionCensus42 deepening target provenance extension
  · exact decisionCensus43 deepening target provenance extension
  · exact decisionCensus44 deepening target provenance extension
  · exact decisionCensus45 deepening target provenance extension
  · exact decisionCensus46 deepening target provenance extension
  · exact decisionCensus47 deepening target provenance extension
  · exact decisionCensus48 deepening target provenance extension
  · exact decisionCensus49 deepening target provenance extension
  · exact decisionCensus50 deepening target provenance extension
  · exact decisionCensus51 deepening target provenance extension
  · exact decisionCensus52 deepening target provenance extension
  · exact decisionCensus53 deepening target provenance extension
  · exact decisionCensus54 deepening target provenance extension
  · exact decisionCensus55 deepening target provenance extension
  · exact decisionCensus56 deepening target provenance extension
  · exact decisionCensus57 deepening target provenance extension
  · exact decisionCensus58 deepening target provenance extension
  · exact decisionCensus59 deepening target provenance extension
  · exact decisionCensus60 deepening target provenance extension
  · exact decisionCensus61 deepening target provenance extension
  · exact decisionCensus62 deepening target provenance extension
  · exact decisionCensus63 deepening target provenance extension
  · exact decisionCensus64 deepening target provenance extension
  · exact decisionCensus65 deepening target provenance extension
  · exact decisionCensus66 deepening target provenance extension
  · exact decisionCensus67 deepening target provenance extension
  · exact decisionCensus68 deepening target provenance extension
  · exact decisionCensus69 deepening target provenance extension
  · exact decisionCensus70 deepening target provenance extension
  · exact decisionCensus71 deepening target provenance extension
  · exact decisionCensus72 deepening target provenance extension
  · exact decisionCensus73 deepening target provenance extension
  · exact decisionCensus74 deepening target provenance extension
  · exact decisionCensus75 deepening target provenance extension
  · exact decisionCensus76 deepening target provenance extension
  · exact decisionCensus77 deepening target provenance extension
  · exact decisionCensus78 deepening target provenance extension
  · exact decisionCensus79 deepening target provenance extension
  · exact decisionCensus80 deepening target provenance extension
  · exact decisionCensus81 deepening target provenance extension
  · exact decisionCensus82 deepening target provenance extension
  · exact decisionCensus83 deepening target provenance extension
  · exact decisionCensus84 deepening target provenance extension
  · exact decisionCensus85 deepening target provenance extension
  · exact decisionCensus86 deepening target provenance extension
  · exact decisionCensus87 deepening target provenance extension
  · exact decisionCensus88 deepening target provenance extension
  · exact decisionCensus89 deepening target provenance extension
  · exact decisionCensus90 deepening target provenance extension
  · exact decisionCensus91 deepening target provenance extension
  · exact decisionCensus92 deepening target provenance extension
  · exact decisionCensus93 deepening target provenance extension
  · exact decisionCensus94 deepening target provenance extension
  · exact decisionCensus95 deepening target provenance extension
  · exact decisionCensus96 deepening target provenance extension
  · exact decisionCensus97 deepening target provenance extension
  · exact decisionCensus98 deepening target provenance extension
  · exact decisionCensus99 deepening target provenance extension
  · exact decisionCensus100 deepening target provenance extension
  · exact decisionCensus101 deepening target provenance extension
  · exact decisionCensus102 deepening target provenance extension
  · exact decisionCensus103 deepening target provenance extension
  · exact decisionCensus104 deepening target provenance extension
  · exact decisionCensus105 deepening target provenance extension
  · exact decisionCensus106 deepening target provenance extension
  · exact decisionCensus107 deepening target provenance extension
  · exact decisionCensus108 deepening target provenance extension
  · exact decisionCensus109 deepening target provenance extension
  · exact decisionCensus110 deepening target provenance extension
  · exact decisionCensus111 deepening target provenance extension
  · exact decisionCensus112 deepening target provenance extension
  · exact decisionCensus113 deepening target provenance extension
  · exact decisionCensus114 deepening target provenance extension
  · exact decisionCensus115 deepening target provenance extension
  · exact decisionCensus116 deepening target provenance extension
  · exact decisionCensus117 deepening target provenance extension
  · exact decisionCensus118 deepening target provenance extension
  · exact decisionCensus119 deepening target provenance extension
  · exact decisionCensus120 deepening target provenance extension
  · exact decisionCensus121 deepening target provenance extension
  · exact decisionCensus122 deepening target provenance extension
  · exact decisionCensus123 deepening target provenance extension
  · exact decisionCensus124 deepening target provenance extension
  · exact decisionCensus125 deepening target provenance extension
  · exact decisionCensus126 deepening target provenance extension
  · exact decisionCensus127 deepening target provenance extension
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
 cases c with
 | mk carrier occupancy partition support leading depth orbit deepening target provenance extension =>
  cases carrier <;> cases occupancy <;> cases partition <;> cases support <;> cases leading <;> cases depth <;> cases orbit
  · exact uniqueCensus0 deepening target provenance extension
  · exact uniqueCensus1 deepening target provenance extension
  · exact uniqueCensus2 deepening target provenance extension
  · exact uniqueCensus3 deepening target provenance extension
  · exact uniqueCensus4 deepening target provenance extension
  · exact uniqueCensus5 deepening target provenance extension
  · exact uniqueCensus6 deepening target provenance extension
  · exact uniqueCensus7 deepening target provenance extension
  · exact uniqueCensus8 deepening target provenance extension
  · exact uniqueCensus9 deepening target provenance extension
  · exact uniqueCensus10 deepening target provenance extension
  · exact uniqueCensus11 deepening target provenance extension
  · exact uniqueCensus12 deepening target provenance extension
  · exact uniqueCensus13 deepening target provenance extension
  · exact uniqueCensus14 deepening target provenance extension
  · exact uniqueCensus15 deepening target provenance extension
  · exact uniqueCensus16 deepening target provenance extension
  · exact uniqueCensus17 deepening target provenance extension
  · exact uniqueCensus18 deepening target provenance extension
  · exact uniqueCensus19 deepening target provenance extension
  · exact uniqueCensus20 deepening target provenance extension
  · exact uniqueCensus21 deepening target provenance extension
  · exact uniqueCensus22 deepening target provenance extension
  · exact uniqueCensus23 deepening target provenance extension
  · exact uniqueCensus24 deepening target provenance extension
  · exact uniqueCensus25 deepening target provenance extension
  · exact uniqueCensus26 deepening target provenance extension
  · exact uniqueCensus27 deepening target provenance extension
  · exact uniqueCensus28 deepening target provenance extension
  · exact uniqueCensus29 deepening target provenance extension
  · exact uniqueCensus30 deepening target provenance extension
  · exact uniqueCensus31 deepening target provenance extension
  · exact uniqueCensus32 deepening target provenance extension
  · exact uniqueCensus33 deepening target provenance extension
  · exact uniqueCensus34 deepening target provenance extension
  · exact uniqueCensus35 deepening target provenance extension
  · exact uniqueCensus36 deepening target provenance extension
  · exact uniqueCensus37 deepening target provenance extension
  · exact uniqueCensus38 deepening target provenance extension
  · exact uniqueCensus39 deepening target provenance extension
  · exact uniqueCensus40 deepening target provenance extension
  · exact uniqueCensus41 deepening target provenance extension
  · exact uniqueCensus42 deepening target provenance extension
  · exact uniqueCensus43 deepening target provenance extension
  · exact uniqueCensus44 deepening target provenance extension
  · exact uniqueCensus45 deepening target provenance extension
  · exact uniqueCensus46 deepening target provenance extension
  · exact uniqueCensus47 deepening target provenance extension
  · exact uniqueCensus48 deepening target provenance extension
  · exact uniqueCensus49 deepening target provenance extension
  · exact uniqueCensus50 deepening target provenance extension
  · exact uniqueCensus51 deepening target provenance extension
  · exact uniqueCensus52 deepening target provenance extension
  · exact uniqueCensus53 deepening target provenance extension
  · exact uniqueCensus54 deepening target provenance extension
  · exact uniqueCensus55 deepening target provenance extension
  · exact uniqueCensus56 deepening target provenance extension
  · exact uniqueCensus57 deepening target provenance extension
  · exact uniqueCensus58 deepening target provenance extension
  · exact uniqueCensus59 deepening target provenance extension
  · exact uniqueCensus60 deepening target provenance extension
  · exact uniqueCensus61 deepening target provenance extension
  · exact uniqueCensus62 deepening target provenance extension
  · exact uniqueCensus63 deepening target provenance extension
  · exact uniqueCensus64 deepening target provenance extension
  · exact uniqueCensus65 deepening target provenance extension
  · exact uniqueCensus66 deepening target provenance extension
  · exact uniqueCensus67 deepening target provenance extension
  · exact uniqueCensus68 deepening target provenance extension
  · exact uniqueCensus69 deepening target provenance extension
  · exact uniqueCensus70 deepening target provenance extension
  · exact uniqueCensus71 deepening target provenance extension
  · exact uniqueCensus72 deepening target provenance extension
  · exact uniqueCensus73 deepening target provenance extension
  · exact uniqueCensus74 deepening target provenance extension
  · exact uniqueCensus75 deepening target provenance extension
  · exact uniqueCensus76 deepening target provenance extension
  · exact uniqueCensus77 deepening target provenance extension
  · exact uniqueCensus78 deepening target provenance extension
  · exact uniqueCensus79 deepening target provenance extension
  · exact uniqueCensus80 deepening target provenance extension
  · exact uniqueCensus81 deepening target provenance extension
  · exact uniqueCensus82 deepening target provenance extension
  · exact uniqueCensus83 deepening target provenance extension
  · exact uniqueCensus84 deepening target provenance extension
  · exact uniqueCensus85 deepening target provenance extension
  · exact uniqueCensus86 deepening target provenance extension
  · exact uniqueCensus87 deepening target provenance extension
  · exact uniqueCensus88 deepening target provenance extension
  · exact uniqueCensus89 deepening target provenance extension
  · exact uniqueCensus90 deepening target provenance extension
  · exact uniqueCensus91 deepening target provenance extension
  · exact uniqueCensus92 deepening target provenance extension
  · exact uniqueCensus93 deepening target provenance extension
  · exact uniqueCensus94 deepening target provenance extension
  · exact uniqueCensus95 deepening target provenance extension
  · exact uniqueCensus96 deepening target provenance extension
  · exact uniqueCensus97 deepening target provenance extension
  · exact uniqueCensus98 deepening target provenance extension
  · exact uniqueCensus99 deepening target provenance extension
  · exact uniqueCensus100 deepening target provenance extension
  · exact uniqueCensus101 deepening target provenance extension
  · exact uniqueCensus102 deepening target provenance extension
  · exact uniqueCensus103 deepening target provenance extension
  · exact uniqueCensus104 deepening target provenance extension
  · exact uniqueCensus105 deepening target provenance extension
  · exact uniqueCensus106 deepening target provenance extension
  · exact uniqueCensus107 deepening target provenance extension
  · exact uniqueCensus108 deepening target provenance extension
  · exact uniqueCensus109 deepening target provenance extension
  · exact uniqueCensus110 deepening target provenance extension
  · exact uniqueCensus111 deepening target provenance extension
  · exact uniqueCensus112 deepening target provenance extension
  · exact uniqueCensus113 deepening target provenance extension
  · exact uniqueCensus114 deepening target provenance extension
  · exact uniqueCensus115 deepening target provenance extension
  · exact uniqueCensus116 deepening target provenance extension
  · exact uniqueCensus117 deepening target provenance extension
  · exact uniqueCensus118 deepening target provenance extension
  · exact uniqueCensus119 deepening target provenance extension
  · exact uniqueCensus120 deepening target provenance extension
  · exact uniqueCensus121 deepening target provenance extension
  · exact uniqueCensus122 deepening target provenance extension
  · exact uniqueCensus123 deepening target provenance extension
  · exact uniqueCensus124 deepening target provenance extension
  · exact uniqueCensus125 deepening target provenance extension
  · exact uniqueCensus126 deepening target provenance extension
  · exact uniqueCensus127 deepening target provenance extension
theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.occupancy = .admitted ∧ c.partition = .admitted ∧ c.support = .admitted ∧ c.leading = .admitted ∧ c.depth = .admitted ∧ c.orbit = .admitted ∧ c.deepening = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier occupancy partition support leading depth orbit deepening target provenance extension =>
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

theorem occupancy_rejected_rejected (c : Candidate) (h : c.occupancy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occupancy eq
    rw [h] at field
    cases field

theorem partition_rejected_rejected (c : Candidate) (h : c.partition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.partition eq
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

theorem leading_rejected_rejected (c : Candidate) (h : c.leading = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.leading eq
    rw [h] at field
    cases field

theorem depth_rejected_rejected (c : Candidate) (h : c.depth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.depth eq
    rw [h] at field
    cases field

theorem orbit_rejected_rejected (c : Candidate) (h : c.orbit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orbit eq
    rw [h] at field
    cases field

theorem deepening_rejected_rejected (c : Candidate) (h : c.deepening = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.deepening eq
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

end SFT.Physics.HubbleGrammar
