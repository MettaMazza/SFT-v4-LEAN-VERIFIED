import SFT.Mathematics.CalculatorV3Census0
import SFT.Mathematics.CalculatorV3Census1
import SFT.Mathematics.CalculatorV3Census2
import SFT.Mathematics.CalculatorV3Census3
import SFT.Mathematics.CalculatorV3Census4
import SFT.Mathematics.CalculatorV3Census5
import SFT.Mathematics.CalculatorV3Census6
import SFT.Mathematics.CalculatorV3Census7
import SFT.Mathematics.CalculatorV3Census8
import SFT.Mathematics.CalculatorV3Census9
import SFT.Mathematics.CalculatorV3Census10
import SFT.Mathematics.CalculatorV3Census11
import SFT.Mathematics.CalculatorV3Census12
import SFT.Mathematics.CalculatorV3Census13
import SFT.Mathematics.CalculatorV3Census14
import SFT.Mathematics.CalculatorV3Census15
import SFT.Mathematics.CalculatorV3Census16
import SFT.Mathematics.CalculatorV3Census17
import SFT.Mathematics.CalculatorV3Census18
import SFT.Mathematics.CalculatorV3Census19
import SFT.Mathematics.CalculatorV3Census20
import SFT.Mathematics.CalculatorV3Census21
import SFT.Mathematics.CalculatorV3Census22
import SFT.Mathematics.CalculatorV3Census23
import SFT.Mathematics.CalculatorV3Census24
import SFT.Mathematics.CalculatorV3Census25
import SFT.Mathematics.CalculatorV3Census26
import SFT.Mathematics.CalculatorV3Census27
import SFT.Mathematics.CalculatorV3Census28
import SFT.Mathematics.CalculatorV3Census29
import SFT.Mathematics.CalculatorV3Census30
import SFT.Mathematics.CalculatorV3Census31
import SFT.Mathematics.CalculatorV3Census32
import SFT.Mathematics.CalculatorV3Census33
import SFT.Mathematics.CalculatorV3Census34
import SFT.Mathematics.CalculatorV3Census35
import SFT.Mathematics.CalculatorV3Census36
import SFT.Mathematics.CalculatorV3Census37
import SFT.Mathematics.CalculatorV3Census38
import SFT.Mathematics.CalculatorV3Census39
import SFT.Mathematics.CalculatorV3Census40
import SFT.Mathematics.CalculatorV3Census41
import SFT.Mathematics.CalculatorV3Census42
import SFT.Mathematics.CalculatorV3Census43
import SFT.Mathematics.CalculatorV3Census44
import SFT.Mathematics.CalculatorV3Census45
import SFT.Mathematics.CalculatorV3Census46
import SFT.Mathematics.CalculatorV3Census47
import SFT.Mathematics.CalculatorV3Census48
import SFT.Mathematics.CalculatorV3Census49
import SFT.Mathematics.CalculatorV3Census50
import SFT.Mathematics.CalculatorV3Census51
import SFT.Mathematics.CalculatorV3Census52
import SFT.Mathematics.CalculatorV3Census53
import SFT.Mathematics.CalculatorV3Census54
import SFT.Mathematics.CalculatorV3Census55
import SFT.Mathematics.CalculatorV3Census56
import SFT.Mathematics.CalculatorV3Census57
import SFT.Mathematics.CalculatorV3Census58
import SFT.Mathematics.CalculatorV3Census59
import SFT.Mathematics.CalculatorV3Census60
import SFT.Mathematics.CalculatorV3Census61
import SFT.Mathematics.CalculatorV3Census62
import SFT.Mathematics.CalculatorV3Census63
import SFT.Mathematics.CalculatorV3Census64
import SFT.Mathematics.CalculatorV3Census65
import SFT.Mathematics.CalculatorV3Census66
import SFT.Mathematics.CalculatorV3Census67
import SFT.Mathematics.CalculatorV3Census68
import SFT.Mathematics.CalculatorV3Census69
import SFT.Mathematics.CalculatorV3Census70
import SFT.Mathematics.CalculatorV3Census71
import SFT.Mathematics.CalculatorV3Census72
import SFT.Mathematics.CalculatorV3Census73
import SFT.Mathematics.CalculatorV3Census74
import SFT.Mathematics.CalculatorV3Census75
import SFT.Mathematics.CalculatorV3Census76
import SFT.Mathematics.CalculatorV3Census77
import SFT.Mathematics.CalculatorV3Census78
import SFT.Mathematics.CalculatorV3Census79
import SFT.Mathematics.CalculatorV3Census80
import SFT.Mathematics.CalculatorV3Census81
import SFT.Mathematics.CalculatorV3Census82
import SFT.Mathematics.CalculatorV3Census83
import SFT.Mathematics.CalculatorV3Census84
import SFT.Mathematics.CalculatorV3Census85
import SFT.Mathematics.CalculatorV3Census86
import SFT.Mathematics.CalculatorV3Census87
import SFT.Mathematics.CalculatorV3Census88
import SFT.Mathematics.CalculatorV3Census89
import SFT.Mathematics.CalculatorV3Census90
import SFT.Mathematics.CalculatorV3Census91
import SFT.Mathematics.CalculatorV3Census92
import SFT.Mathematics.CalculatorV3Census93
import SFT.Mathematics.CalculatorV3Census94
import SFT.Mathematics.CalculatorV3Census95
import SFT.Mathematics.CalculatorV3Census96
import SFT.Mathematics.CalculatorV3Census97
import SFT.Mathematics.CalculatorV3Census98
import SFT.Mathematics.CalculatorV3Census99
import SFT.Mathematics.CalculatorV3Census100
import SFT.Mathematics.CalculatorV3Census101
import SFT.Mathematics.CalculatorV3Census102
import SFT.Mathematics.CalculatorV3Census103
import SFT.Mathematics.CalculatorV3Census104
import SFT.Mathematics.CalculatorV3Census105
import SFT.Mathematics.CalculatorV3Census106
import SFT.Mathematics.CalculatorV3Census107
import SFT.Mathematics.CalculatorV3Census108
import SFT.Mathematics.CalculatorV3Census109
import SFT.Mathematics.CalculatorV3Census110
import SFT.Mathematics.CalculatorV3Census111
import SFT.Mathematics.CalculatorV3Census112
import SFT.Mathematics.CalculatorV3Census113
import SFT.Mathematics.CalculatorV3Census114
import SFT.Mathematics.CalculatorV3Census115
import SFT.Mathematics.CalculatorV3Census116
import SFT.Mathematics.CalculatorV3Census117
import SFT.Mathematics.CalculatorV3Census118
import SFT.Mathematics.CalculatorV3Census119
import SFT.Mathematics.CalculatorV3Census120
import SFT.Mathematics.CalculatorV3Census121
import SFT.Mathematics.CalculatorV3Census122
import SFT.Mathematics.CalculatorV3Census123
import SFT.Mathematics.CalculatorV3Census124
import SFT.Mathematics.CalculatorV3Census125
import SFT.Mathematics.CalculatorV3Census126
import SFT.Mathematics.CalculatorV3Census127
namespace SFT.Mathematics.CalculatorV3Grammar
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk input empty orientation operations nonrational transcendental orthogonal domain trace addition scientific_surface session application =>
    cases input <;> cases empty <;> cases orientation <;> cases operations <;> cases nonrational <;> cases transcendental <;> cases orthogonal
    · exact sourceDecisionChunk0 _ _ _ _ _ _
    · exact sourceDecisionChunk1 _ _ _ _ _ _
    · exact sourceDecisionChunk2 _ _ _ _ _ _
    · exact sourceDecisionChunk3 _ _ _ _ _ _
    · exact sourceDecisionChunk4 _ _ _ _ _ _
    · exact sourceDecisionChunk5 _ _ _ _ _ _
    · exact sourceDecisionChunk6 _ _ _ _ _ _
    · exact sourceDecisionChunk7 _ _ _ _ _ _
    · exact sourceDecisionChunk8 _ _ _ _ _ _
    · exact sourceDecisionChunk9 _ _ _ _ _ _
    · exact sourceDecisionChunk10 _ _ _ _ _ _
    · exact sourceDecisionChunk11 _ _ _ _ _ _
    · exact sourceDecisionChunk12 _ _ _ _ _ _
    · exact sourceDecisionChunk13 _ _ _ _ _ _
    · exact sourceDecisionChunk14 _ _ _ _ _ _
    · exact sourceDecisionChunk15 _ _ _ _ _ _
    · exact sourceDecisionChunk16 _ _ _ _ _ _
    · exact sourceDecisionChunk17 _ _ _ _ _ _
    · exact sourceDecisionChunk18 _ _ _ _ _ _
    · exact sourceDecisionChunk19 _ _ _ _ _ _
    · exact sourceDecisionChunk20 _ _ _ _ _ _
    · exact sourceDecisionChunk21 _ _ _ _ _ _
    · exact sourceDecisionChunk22 _ _ _ _ _ _
    · exact sourceDecisionChunk23 _ _ _ _ _ _
    · exact sourceDecisionChunk24 _ _ _ _ _ _
    · exact sourceDecisionChunk25 _ _ _ _ _ _
    · exact sourceDecisionChunk26 _ _ _ _ _ _
    · exact sourceDecisionChunk27 _ _ _ _ _ _
    · exact sourceDecisionChunk28 _ _ _ _ _ _
    · exact sourceDecisionChunk29 _ _ _ _ _ _
    · exact sourceDecisionChunk30 _ _ _ _ _ _
    · exact sourceDecisionChunk31 _ _ _ _ _ _
    · exact sourceDecisionChunk32 _ _ _ _ _ _
    · exact sourceDecisionChunk33 _ _ _ _ _ _
    · exact sourceDecisionChunk34 _ _ _ _ _ _
    · exact sourceDecisionChunk35 _ _ _ _ _ _
    · exact sourceDecisionChunk36 _ _ _ _ _ _
    · exact sourceDecisionChunk37 _ _ _ _ _ _
    · exact sourceDecisionChunk38 _ _ _ _ _ _
    · exact sourceDecisionChunk39 _ _ _ _ _ _
    · exact sourceDecisionChunk40 _ _ _ _ _ _
    · exact sourceDecisionChunk41 _ _ _ _ _ _
    · exact sourceDecisionChunk42 _ _ _ _ _ _
    · exact sourceDecisionChunk43 _ _ _ _ _ _
    · exact sourceDecisionChunk44 _ _ _ _ _ _
    · exact sourceDecisionChunk45 _ _ _ _ _ _
    · exact sourceDecisionChunk46 _ _ _ _ _ _
    · exact sourceDecisionChunk47 _ _ _ _ _ _
    · exact sourceDecisionChunk48 _ _ _ _ _ _
    · exact sourceDecisionChunk49 _ _ _ _ _ _
    · exact sourceDecisionChunk50 _ _ _ _ _ _
    · exact sourceDecisionChunk51 _ _ _ _ _ _
    · exact sourceDecisionChunk52 _ _ _ _ _ _
    · exact sourceDecisionChunk53 _ _ _ _ _ _
    · exact sourceDecisionChunk54 _ _ _ _ _ _
    · exact sourceDecisionChunk55 _ _ _ _ _ _
    · exact sourceDecisionChunk56 _ _ _ _ _ _
    · exact sourceDecisionChunk57 _ _ _ _ _ _
    · exact sourceDecisionChunk58 _ _ _ _ _ _
    · exact sourceDecisionChunk59 _ _ _ _ _ _
    · exact sourceDecisionChunk60 _ _ _ _ _ _
    · exact sourceDecisionChunk61 _ _ _ _ _ _
    · exact sourceDecisionChunk62 _ _ _ _ _ _
    · exact sourceDecisionChunk63 _ _ _ _ _ _
    · exact sourceDecisionChunk64 _ _ _ _ _ _
    · exact sourceDecisionChunk65 _ _ _ _ _ _
    · exact sourceDecisionChunk66 _ _ _ _ _ _
    · exact sourceDecisionChunk67 _ _ _ _ _ _
    · exact sourceDecisionChunk68 _ _ _ _ _ _
    · exact sourceDecisionChunk69 _ _ _ _ _ _
    · exact sourceDecisionChunk70 _ _ _ _ _ _
    · exact sourceDecisionChunk71 _ _ _ _ _ _
    · exact sourceDecisionChunk72 _ _ _ _ _ _
    · exact sourceDecisionChunk73 _ _ _ _ _ _
    · exact sourceDecisionChunk74 _ _ _ _ _ _
    · exact sourceDecisionChunk75 _ _ _ _ _ _
    · exact sourceDecisionChunk76 _ _ _ _ _ _
    · exact sourceDecisionChunk77 _ _ _ _ _ _
    · exact sourceDecisionChunk78 _ _ _ _ _ _
    · exact sourceDecisionChunk79 _ _ _ _ _ _
    · exact sourceDecisionChunk80 _ _ _ _ _ _
    · exact sourceDecisionChunk81 _ _ _ _ _ _
    · exact sourceDecisionChunk82 _ _ _ _ _ _
    · exact sourceDecisionChunk83 _ _ _ _ _ _
    · exact sourceDecisionChunk84 _ _ _ _ _ _
    · exact sourceDecisionChunk85 _ _ _ _ _ _
    · exact sourceDecisionChunk86 _ _ _ _ _ _
    · exact sourceDecisionChunk87 _ _ _ _ _ _
    · exact sourceDecisionChunk88 _ _ _ _ _ _
    · exact sourceDecisionChunk89 _ _ _ _ _ _
    · exact sourceDecisionChunk90 _ _ _ _ _ _
    · exact sourceDecisionChunk91 _ _ _ _ _ _
    · exact sourceDecisionChunk92 _ _ _ _ _ _
    · exact sourceDecisionChunk93 _ _ _ _ _ _
    · exact sourceDecisionChunk94 _ _ _ _ _ _
    · exact sourceDecisionChunk95 _ _ _ _ _ _
    · exact sourceDecisionChunk96 _ _ _ _ _ _
    · exact sourceDecisionChunk97 _ _ _ _ _ _
    · exact sourceDecisionChunk98 _ _ _ _ _ _
    · exact sourceDecisionChunk99 _ _ _ _ _ _
    · exact sourceDecisionChunk100 _ _ _ _ _ _
    · exact sourceDecisionChunk101 _ _ _ _ _ _
    · exact sourceDecisionChunk102 _ _ _ _ _ _
    · exact sourceDecisionChunk103 _ _ _ _ _ _
    · exact sourceDecisionChunk104 _ _ _ _ _ _
    · exact sourceDecisionChunk105 _ _ _ _ _ _
    · exact sourceDecisionChunk106 _ _ _ _ _ _
    · exact sourceDecisionChunk107 _ _ _ _ _ _
    · exact sourceDecisionChunk108 _ _ _ _ _ _
    · exact sourceDecisionChunk109 _ _ _ _ _ _
    · exact sourceDecisionChunk110 _ _ _ _ _ _
    · exact sourceDecisionChunk111 _ _ _ _ _ _
    · exact sourceDecisionChunk112 _ _ _ _ _ _
    · exact sourceDecisionChunk113 _ _ _ _ _ _
    · exact sourceDecisionChunk114 _ _ _ _ _ _
    · exact sourceDecisionChunk115 _ _ _ _ _ _
    · exact sourceDecisionChunk116 _ _ _ _ _ _
    · exact sourceDecisionChunk117 _ _ _ _ _ _
    · exact sourceDecisionChunk118 _ _ _ _ _ _
    · exact sourceDecisionChunk119 _ _ _ _ _ _
    · exact sourceDecisionChunk120 _ _ _ _ _ _
    · exact sourceDecisionChunk121 _ _ _ _ _ _
    · exact sourceDecisionChunk122 _ _ _ _ _ _
    · exact sourceDecisionChunk123 _ _ _ _ _ _
    · exact sourceDecisionChunk124 _ _ _ _ _ _
    · exact sourceDecisionChunk125 _ _ _ _ _ _
    · exact sourceDecisionChunk126 _ _ _ _ _ _
    · exact sourceDecisionChunk127 _ _ _ _ _ _

theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk input empty orientation operations nonrational transcendental orthogonal domain trace addition scientific_surface session application =>
    cases input <;> cases empty <;> cases orientation <;> cases operations <;> cases nonrational <;> cases transcendental <;> cases orthogonal
    · exact uniqueCriteriaChunk0 _ _ _ _ _ _
    · exact uniqueCriteriaChunk1 _ _ _ _ _ _
    · exact uniqueCriteriaChunk2 _ _ _ _ _ _
    · exact uniqueCriteriaChunk3 _ _ _ _ _ _
    · exact uniqueCriteriaChunk4 _ _ _ _ _ _
    · exact uniqueCriteriaChunk5 _ _ _ _ _ _
    · exact uniqueCriteriaChunk6 _ _ _ _ _ _
    · exact uniqueCriteriaChunk7 _ _ _ _ _ _
    · exact uniqueCriteriaChunk8 _ _ _ _ _ _
    · exact uniqueCriteriaChunk9 _ _ _ _ _ _
    · exact uniqueCriteriaChunk10 _ _ _ _ _ _
    · exact uniqueCriteriaChunk11 _ _ _ _ _ _
    · exact uniqueCriteriaChunk12 _ _ _ _ _ _
    · exact uniqueCriteriaChunk13 _ _ _ _ _ _
    · exact uniqueCriteriaChunk14 _ _ _ _ _ _
    · exact uniqueCriteriaChunk15 _ _ _ _ _ _
    · exact uniqueCriteriaChunk16 _ _ _ _ _ _
    · exact uniqueCriteriaChunk17 _ _ _ _ _ _
    · exact uniqueCriteriaChunk18 _ _ _ _ _ _
    · exact uniqueCriteriaChunk19 _ _ _ _ _ _
    · exact uniqueCriteriaChunk20 _ _ _ _ _ _
    · exact uniqueCriteriaChunk21 _ _ _ _ _ _
    · exact uniqueCriteriaChunk22 _ _ _ _ _ _
    · exact uniqueCriteriaChunk23 _ _ _ _ _ _
    · exact uniqueCriteriaChunk24 _ _ _ _ _ _
    · exact uniqueCriteriaChunk25 _ _ _ _ _ _
    · exact uniqueCriteriaChunk26 _ _ _ _ _ _
    · exact uniqueCriteriaChunk27 _ _ _ _ _ _
    · exact uniqueCriteriaChunk28 _ _ _ _ _ _
    · exact uniqueCriteriaChunk29 _ _ _ _ _ _
    · exact uniqueCriteriaChunk30 _ _ _ _ _ _
    · exact uniqueCriteriaChunk31 _ _ _ _ _ _
    · exact uniqueCriteriaChunk32 _ _ _ _ _ _
    · exact uniqueCriteriaChunk33 _ _ _ _ _ _
    · exact uniqueCriteriaChunk34 _ _ _ _ _ _
    · exact uniqueCriteriaChunk35 _ _ _ _ _ _
    · exact uniqueCriteriaChunk36 _ _ _ _ _ _
    · exact uniqueCriteriaChunk37 _ _ _ _ _ _
    · exact uniqueCriteriaChunk38 _ _ _ _ _ _
    · exact uniqueCriteriaChunk39 _ _ _ _ _ _
    · exact uniqueCriteriaChunk40 _ _ _ _ _ _
    · exact uniqueCriteriaChunk41 _ _ _ _ _ _
    · exact uniqueCriteriaChunk42 _ _ _ _ _ _
    · exact uniqueCriteriaChunk43 _ _ _ _ _ _
    · exact uniqueCriteriaChunk44 _ _ _ _ _ _
    · exact uniqueCriteriaChunk45 _ _ _ _ _ _
    · exact uniqueCriteriaChunk46 _ _ _ _ _ _
    · exact uniqueCriteriaChunk47 _ _ _ _ _ _
    · exact uniqueCriteriaChunk48 _ _ _ _ _ _
    · exact uniqueCriteriaChunk49 _ _ _ _ _ _
    · exact uniqueCriteriaChunk50 _ _ _ _ _ _
    · exact uniqueCriteriaChunk51 _ _ _ _ _ _
    · exact uniqueCriteriaChunk52 _ _ _ _ _ _
    · exact uniqueCriteriaChunk53 _ _ _ _ _ _
    · exact uniqueCriteriaChunk54 _ _ _ _ _ _
    · exact uniqueCriteriaChunk55 _ _ _ _ _ _
    · exact uniqueCriteriaChunk56 _ _ _ _ _ _
    · exact uniqueCriteriaChunk57 _ _ _ _ _ _
    · exact uniqueCriteriaChunk58 _ _ _ _ _ _
    · exact uniqueCriteriaChunk59 _ _ _ _ _ _
    · exact uniqueCriteriaChunk60 _ _ _ _ _ _
    · exact uniqueCriteriaChunk61 _ _ _ _ _ _
    · exact uniqueCriteriaChunk62 _ _ _ _ _ _
    · exact uniqueCriteriaChunk63 _ _ _ _ _ _
    · exact uniqueCriteriaChunk64 _ _ _ _ _ _
    · exact uniqueCriteriaChunk65 _ _ _ _ _ _
    · exact uniqueCriteriaChunk66 _ _ _ _ _ _
    · exact uniqueCriteriaChunk67 _ _ _ _ _ _
    · exact uniqueCriteriaChunk68 _ _ _ _ _ _
    · exact uniqueCriteriaChunk69 _ _ _ _ _ _
    · exact uniqueCriteriaChunk70 _ _ _ _ _ _
    · exact uniqueCriteriaChunk71 _ _ _ _ _ _
    · exact uniqueCriteriaChunk72 _ _ _ _ _ _
    · exact uniqueCriteriaChunk73 _ _ _ _ _ _
    · exact uniqueCriteriaChunk74 _ _ _ _ _ _
    · exact uniqueCriteriaChunk75 _ _ _ _ _ _
    · exact uniqueCriteriaChunk76 _ _ _ _ _ _
    · exact uniqueCriteriaChunk77 _ _ _ _ _ _
    · exact uniqueCriteriaChunk78 _ _ _ _ _ _
    · exact uniqueCriteriaChunk79 _ _ _ _ _ _
    · exact uniqueCriteriaChunk80 _ _ _ _ _ _
    · exact uniqueCriteriaChunk81 _ _ _ _ _ _
    · exact uniqueCriteriaChunk82 _ _ _ _ _ _
    · exact uniqueCriteriaChunk83 _ _ _ _ _ _
    · exact uniqueCriteriaChunk84 _ _ _ _ _ _
    · exact uniqueCriteriaChunk85 _ _ _ _ _ _
    · exact uniqueCriteriaChunk86 _ _ _ _ _ _
    · exact uniqueCriteriaChunk87 _ _ _ _ _ _
    · exact uniqueCriteriaChunk88 _ _ _ _ _ _
    · exact uniqueCriteriaChunk89 _ _ _ _ _ _
    · exact uniqueCriteriaChunk90 _ _ _ _ _ _
    · exact uniqueCriteriaChunk91 _ _ _ _ _ _
    · exact uniqueCriteriaChunk92 _ _ _ _ _ _
    · exact uniqueCriteriaChunk93 _ _ _ _ _ _
    · exact uniqueCriteriaChunk94 _ _ _ _ _ _
    · exact uniqueCriteriaChunk95 _ _ _ _ _ _
    · exact uniqueCriteriaChunk96 _ _ _ _ _ _
    · exact uniqueCriteriaChunk97 _ _ _ _ _ _
    · exact uniqueCriteriaChunk98 _ _ _ _ _ _
    · exact uniqueCriteriaChunk99 _ _ _ _ _ _
    · exact uniqueCriteriaChunk100 _ _ _ _ _ _
    · exact uniqueCriteriaChunk101 _ _ _ _ _ _
    · exact uniqueCriteriaChunk102 _ _ _ _ _ _
    · exact uniqueCriteriaChunk103 _ _ _ _ _ _
    · exact uniqueCriteriaChunk104 _ _ _ _ _ _
    · exact uniqueCriteriaChunk105 _ _ _ _ _ _
    · exact uniqueCriteriaChunk106 _ _ _ _ _ _
    · exact uniqueCriteriaChunk107 _ _ _ _ _ _
    · exact uniqueCriteriaChunk108 _ _ _ _ _ _
    · exact uniqueCriteriaChunk109 _ _ _ _ _ _
    · exact uniqueCriteriaChunk110 _ _ _ _ _ _
    · exact uniqueCriteriaChunk111 _ _ _ _ _ _
    · exact uniqueCriteriaChunk112 _ _ _ _ _ _
    · exact uniqueCriteriaChunk113 _ _ _ _ _ _
    · exact uniqueCriteriaChunk114 _ _ _ _ _ _
    · exact uniqueCriteriaChunk115 _ _ _ _ _ _
    · exact uniqueCriteriaChunk116 _ _ _ _ _ _
    · exact uniqueCriteriaChunk117 _ _ _ _ _ _
    · exact uniqueCriteriaChunk118 _ _ _ _ _ _
    · exact uniqueCriteriaChunk119 _ _ _ _ _ _
    · exact uniqueCriteriaChunk120 _ _ _ _ _ _
    · exact uniqueCriteriaChunk121 _ _ _ _ _ _
    · exact uniqueCriteriaChunk122 _ _ _ _ _ _
    · exact uniqueCriteriaChunk123 _ _ _ _ _ _
    · exact uniqueCriteriaChunk124 _ _ _ _ _ _
    · exact uniqueCriteriaChunk125 _ _ _ _ _ _
    · exact uniqueCriteriaChunk126 _ _ _ _ _ _
    · exact uniqueCriteriaChunk127 _ _ _ _ _ _

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.input = .admitted ∧ c.empty = .admitted ∧ c.orientation = .admitted ∧ c.operations = .admitted ∧ c.nonrational = .admitted ∧ c.transcendental = .admitted ∧ c.orthogonal = .admitted ∧ c.domain = .admitted ∧ c.trace = .admitted ∧ c.addition = .admitted ∧ c.scientific_surface = .admitted ∧ c.session = .admitted ∧ c.application = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk input empty orientation operations nonrational transcendental orthogonal domain trace addition scientific_surface session application =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11; cases h12
      rfl

theorem input_rejected_rejected (c : Candidate) (h : c.input = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.input eq
    rw [h] at field
    cases field

theorem empty_rejected_rejected (c : Candidate) (h : c.empty = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.empty eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem operations_rejected_rejected (c : Candidate) (h : c.operations = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operations eq
    rw [h] at field
    cases field

theorem nonrational_rejected_rejected (c : Candidate) (h : c.nonrational = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.nonrational eq
    rw [h] at field
    cases field

theorem transcendental_rejected_rejected (c : Candidate) (h : c.transcendental = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transcendental eq
    rw [h] at field
    cases field

theorem orthogonal_rejected_rejected (c : Candidate) (h : c.orthogonal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orthogonal eq
    rw [h] at field
    cases field

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem trace_rejected_rejected (c : Candidate) (h : c.trace = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
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

theorem scientific_surface_rejected_rejected (c : Candidate) (h : c.scientific_surface = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scientific_surface eq
    rw [h] at field
    cases field

theorem session_rejected_rejected (c : Candidate) (h : c.session = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.session eq
    rw [h] at field
    cases field

theorem application_rejected_rejected (c : Candidate) (h : c.application = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.application eq
    rw [h] at field
    cases field

end SFT.Mathematics.CalculatorV3Grammar
