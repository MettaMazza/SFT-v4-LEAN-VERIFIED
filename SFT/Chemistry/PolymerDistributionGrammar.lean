import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PolymerDistributionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Population where
  | rejected | admitted

def populationName : Population → String
  | .rejected => "single-representative-chain"
  | .admitted => "all-observed-chain-carriers"

inductive Length where
  | rejected | admitted

def lengthName : Length → String
  | .rejected => "mean-only"
  | .admitted => "exact-chain-length-counts"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "duplicate-chains-collapsed"
  | .admitted => "positive-chain-multiplicities"

inductive Measure where
  | rejected | admitted

def measureName : Measure → String
  | .rejected => "one-universal-average"
  | .admitted => "number-and-mass-support-separated"

inductive Distribution where
  | rejected | admitted

def distributionName : Distribution → String
  | .rejected => "answer-scalar-only"
  | .admitted => "complete-molar-mass-distribution"

inductive Method where
  | rejected | admitted

def methodName : Method → String
  | .rejected => "method-free-census"
  | .admitted => "method-and-sample-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "distribution-name-only"
  | .admitted => "chain-population-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-distribution-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  population : Population
  length : Length
  multiplicity : Multiplicity
  measure : Measure
  distribution : Distribution
  method : Method
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [populationName c.population, lengthName c.length, multiplicityName c.multiplicity, measureName c.measure, distributionName c.distribution, methodName c.method, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "population=" (populationName c.population), SFT.Host.Text.append "length=" (lengthName c.length), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "measure=" (measureName c.measure), SFT.Host.Text.append "distribution=" (distributionName c.distribution), SFT.Host.Text.append "method=" (methodName c.method), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "all-observed-chain-carriers__exact-chain-length-counts__positive-chain-multiplicities__number-and-mass-support-separated__complete-molar-mass-distribution__method-and-sample-bounded__chain-population-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (populationName c.population) "all-observed-chain-carriers" &&
  SFT.Host.Text.equal (lengthName c.length) "exact-chain-length-counts" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "positive-chain-multiplicities" &&
  SFT.Host.Text.equal (measureName c.measure) "number-and-mass-support-separated" &&
  SFT.Host.Text.equal (distributionName c.distribution) "complete-molar-mass-distribution" &&
  SFT.Host.Text.equal (methodName c.method) "method-and-sample-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "chain-population-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (populationName c.population) "all-observed-chain-carriers") then "A sample distribution is erased." else
  if !(SFT.Host.Text.equal (lengthName c.length) "exact-chain-length-counts") then "A mean loses alternatives." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "positive-chain-multiplicities") then "Population frequency is lost." else
  if !(SFT.Host.Text.equal (measureName c.measure) "number-and-mass-support-separated") then "Different summaries retain different information." else
  if !(SFT.Host.Text.equal (distributionName c.distribution) "complete-molar-mass-distribution") then "The population cannot be reconstructed." else
  if !(SFT.Host.Text.equal (methodName c.method) "method-and-sample-bounded") then "Resolution changes the observed population." else
  if !(SFT.Host.Text.equal (recordName c.record) "chain-population-trace") then "The census cannot be audited." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted shape can hide unfavorable chains." else
  "all-observed-chain-carriers__exact-chain-length-counts__positive-chain-multiplicities__number-and-mass-support-separated__complete-molar-mass-distribution"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite observed polymer sample with complete chain identities, repeat counts, positive multiplicities, weighting rule, sample and method boundary."

def candidates : List Candidate :=
  ([Population.rejected,Population.admitted]).flatMap fun population =>
  ([Length.rejected,Length.admitted]).flatMap fun length =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Measure.rejected,Measure.admitted]).flatMap fun measure =>
  ([Distribution.rejected,Distribution.admitted]).flatMap fun distribution =>
  ([Method.rejected,Method.admitted]).flatMap fun method =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨population,length,multiplicity,measure,distribution,method,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk population length multiplicity measure distribution method record extra =>
    have hpopulation : population ∈ [Population.rejected,Population.admitted] := by
      cases population <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlength : length ∈ [Length.rejected,Length.admitted] := by
      cases length <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasure : measure ∈ [Measure.rejected,Measure.admitted] := by
      cases measure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistribution : distribution ∈ [Distribution.rejected,Distribution.admitted] := by
      cases distribution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmethod : method ∈ [Method.rejected,Method.admitted] := by
      cases method <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ population _ hpopulation
    apply CommonRefinement.memFlatMap _ _ length _ hlength
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ measure _ hmeasure
    apply CommonRefinement.memFlatMap _ _ distribution _ hdistribution
    apply CommonRefinement.memFlatMap _ _ method _ hmethod
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk population length multiplicity measure distribution method record extra =>
    cases population <;> cases length <;> cases multiplicity <;> cases measure <;> cases distribution <;> cases method <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk population length multiplicity measure distribution method record extra =>
    cases population <;> cases length <;> cases multiplicity <;> cases measure <;> cases distribution <;> cases method <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.population = .admitted ∧ c.length = .admitted ∧ c.multiplicity = .admitted ∧ c.measure = .admitted ∧ c.distribution = .admitted ∧ c.method = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk population length multiplicity measure distribution method record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem population_rejected_rejected (c : Candidate) (h : c.population = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.population eq
    rw [h] at field
    cases field

theorem length_rejected_rejected (c : Candidate) (h : c.length = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.length eq
    rw [h] at field
    cases field

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem measure_rejected_rejected (c : Candidate) (h : c.measure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measure eq
    rw [h] at field
    cases field

theorem distribution_rejected_rejected (c : Candidate) (h : c.distribution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distribution eq
    rw [h] at field
    cases field

theorem method_rejected_rejected (c : Candidate) (h : c.method = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.method eq
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

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.PolymerDistributionGrammar
