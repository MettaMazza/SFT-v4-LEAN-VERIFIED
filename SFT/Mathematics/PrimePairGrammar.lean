import SFT.Mathematics.PrimePairComplete
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.PrimePairGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Range where
  | rejected | admitted

def rangeName : Range → String
  | .rejected => "sampled-evens"
  | .admitted => "all-declared-evens"

inductive Primality where
  | rejected | admitted

def primalityName : Primality → String
  | .rejected => "borrowed-table"
  | .admitted => "trial-certificate"

inductive Pairs where
  | rejected | admitted

def pairsName : Pairs → String
  | .rejected => "one-guessed-pair"
  | .admitted => "all-complements"

inductive Complement where
  | rejected | admitted

def complementName : Complement → String
  | .rejected => "signed-sum"
  | .admitted => "positive-junction"

inductive Coverage where
  | rejected | admitted

def coverageName : Coverage → String
  | .rejected => "spot-check"
  | .admitted => "exhaustive-census"

inductive Twins where
  | rejected | admitted

def twinsName : Twins → String
  | .rejected => "approximate-density"
  | .admitted => "exact-gap-two"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "unrestricted-conjecture"
  | .admitted => "explicit-ten-thousand"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "external-answer"
  | .admitted => "no-extra-rule"

structure Candidate where
  range : Range
  primality : Primality
  pairs : Pairs
  complement : Complement
  coverage : Coverage
  twins : Twins
  boundary : Boundary
  addition : Addition

def sourceFields (c : Candidate) : List String := [rangeName c.range, primalityName c.primality, pairsName c.pairs, complementName c.complement, coverageName c.coverage, twinsName c.twins, boundaryName c.boundary, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "range=" (rangeName c.range), SFT.Host.Text.append "primality=" (primalityName c.primality), SFT.Host.Text.append "pairs=" (pairsName c.pairs), SFT.Host.Text.append "complement=" (complementName c.complement), SFT.Host.Text.append "coverage=" (coverageName c.coverage), SFT.Host.Text.append "twins=" (twinsName c.twins), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "all-declared-evens__trial-certificate__all-complements__positive-junction__exhaustive-census__exact-gap-two__explicit-ten-thousand__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (rangeName c.range) "all-declared-evens" &&
  SFT.Host.Text.equal (primalityName c.primality) "trial-certificate" &&
  SFT.Host.Text.equal (pairsName c.pairs) "all-complements" &&
  SFT.Host.Text.equal (complementName c.complement) "positive-junction" &&
  SFT.Host.Text.equal (coverageName c.coverage) "exhaustive-census" &&
  SFT.Host.Text.equal (twinsName c.twins) "exact-gap-two" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "explicit-ten-thousand" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (rangeName c.range) "all-declared-evens") then "Sampling cannot close the declared range." else
  if !(SFT.Host.Text.equal (primalityName c.primality) "trial-certificate") then "A borrowed table hides verification." else
  if !(SFT.Host.Text.equal (pairsName c.pairs) "all-complements") then "A guess omits alternatives and failures." else
  if !(SFT.Host.Text.equal (complementName c.complement) "positive-junction") then "Signed arithmetic is unnecessary." else
  if !(SFT.Host.Text.equal (coverageName c.coverage) "exhaustive-census") then "Spot checks do not prove the bounded census." else
  if !(SFT.Host.Text.equal (twinsName c.twins) "exact-gap-two") then "A density estimate is not an exact count." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "explicit-ten-thousand") then "The finite run cannot prove an unrestricted conjecture." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "An external published count cannot enter generation." else
  "The exhaustive 4..10,000 census contains 4,999 even inputs, zero Goldbach failures and exactly 205 twin-prime pairs with upper member at most 10,000."

def generationRule : String := "Exhaust range, primality, pair generation, complement, coverage, twin adjacency, boundary and extra-theorem choices."
def grammarBoundary : String := "Positive finite whole-number census with even inputs four through ten thousand inclusive."

def candidates : List Candidate :=
  ([Range.rejected,Range.admitted]).flatMap fun range =>
  ([Primality.rejected,Primality.admitted]).flatMap fun primality =>
  ([Pairs.rejected,Pairs.admitted]).flatMap fun pairs =>
  ([Complement.rejected,Complement.admitted]).flatMap fun complement =>
  ([Coverage.rejected,Coverage.admitted]).flatMap fun coverage =>
  ([Twins.rejected,Twins.admitted]).flatMap fun twins =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨range,primality,pairs,complement,coverage,twins,boundary,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk range primality pairs complement coverage twins boundary addition =>
    have hrange : range ∈ [Range.rejected,Range.admitted] := by
      cases range <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprimality : primality ∈ [Primality.rejected,Primality.admitted] := by
      cases primality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpairs : pairs ∈ [Pairs.rejected,Pairs.admitted] := by
      cases pairs <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomplement : complement ∈ [Complement.rejected,Complement.admitted] := by
      cases complement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoverage : coverage ∈ [Coverage.rejected,Coverage.admitted] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htwins : twins ∈ [Twins.rejected,Twins.admitted] := by
      cases twins <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ range _ hrange
    apply CommonRefinement.memFlatMap _ _ primality _ hprimality
    apply CommonRefinement.memFlatMap _ _ pairs _ hpairs
    apply CommonRefinement.memFlatMap _ _ complement _ hcomplement
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ twins _ htwins
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk range primality pairs complement coverage twins boundary addition =>
    cases range <;> cases primality <;> cases pairs <;> cases complement <;> cases coverage <;> cases twins <;> cases boundary <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk range primality pairs complement coverage twins boundary addition =>
    cases range <;> cases primality <;> cases pairs <;> cases complement <;> cases coverage <;> cases twins <;> cases boundary <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.range = .admitted ∧ c.primality = .admitted ∧ c.pairs = .admitted ∧ c.complement = .admitted ∧ c.coverage = .admitted ∧ c.twins = .admitted ∧ c.boundary = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk range primality pairs complement coverage twins boundary addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem range_rejected_rejected (c : Candidate) (h : c.range = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.range eq
    rw [h] at field
    cases field

theorem primality_rejected_rejected (c : Candidate) (h : c.primality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.primality eq
    rw [h] at field
    cases field

theorem pairs_rejected_rejected (c : Candidate) (h : c.pairs = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.pairs eq
    rw [h] at field
    cases field

theorem complement_rejected_rejected (c : Candidate) (h : c.complement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.complement eq
    rw [h] at field
    cases field

theorem coverage_rejected_rejected (c : Candidate) (h : c.coverage = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem twins_rejected_rejected (c : Candidate) (h : c.twins = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.twins eq
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

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.PrimePairGrammar
