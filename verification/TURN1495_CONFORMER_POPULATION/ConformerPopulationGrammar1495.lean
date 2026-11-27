import «work».ConformerPopulationCarrier1495
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ConformerPopulationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "selected-conformer-name"
  | .admitted => "complete-conformer-equivalence-census"

inductive Condition where
  | rejected | admitted

def conditionName : Condition → String
  | .rejected => "condition-erased-population"
  | .admitted => "held-observation-condition"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "infinite-or-unspecified-average"
  | .admitted => "positive-finite-observation-boundary"

inductive Population where
  | rejected | admitted

def populationName : Population → String
  | .rejected => "random-or-fitted-probability"
  | .admitted => "exact-recurrence-count-ratio"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-population"
  | .admitted => "unobserved-class-EmptyOne"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "signed-energy-difference-or-imported-distribution"
  | .admitted => "positive-Take-energy-and-count-orders"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "target-readable-condition-or-value"
  | .admitted => "value-free-conditioned-vector-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "recomputed-history-or-extra-rule"
  | .admitted => "one-observation-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  condition : Condition
  boundary : Boundary
  population : Population
  absence : Absence
  order : Order
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, conditionName c.condition, boundaryName c.boundary, populationName c.population, absenceName c.absence, orderName c.order, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "condition=" (conditionName c.condition), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "population=" (populationName c.population), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-conformer-equivalence-census__held-observation-condition__positive-finite-observation-boundary__exact-recurrence-count-ratio__unobserved-class-EmptyOne__positive-Take-energy-and-count-orders__value-free-conditioned-vector-seal__one-observation-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-conformer-equivalence-census" &&
  SFT.Host.Text.equal (conditionName c.condition) "held-observation-condition" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "positive-finite-observation-boundary" &&
  SFT.Host.Text.equal (populationName c.population) "exact-recurrence-count-ratio" &&
  SFT.Host.Text.equal (absenceName c.absence) "unobserved-class-EmptyOne" &&
  SFT.Host.Text.equal (orderName c.order) "positive-Take-energy-and-count-orders" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-conditioned-vector-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "one-observation-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-conformer-equivalence-census") then "A selected name omits the complete derived equivalence quotient." else
  if !(SFT.Host.Text.equal (conditionName c.condition) "held-observation-condition") then "Population without physical condition conflates distinct deterministic traces." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "positive-finite-observation-boundary") then "An unspecified limit imports continuum or unbounded averaging." else
  if !(SFT.Host.Text.equal (populationName c.population) "exact-recurrence-count-ratio") then "A random law or fitted distribution is not forced by the observed process." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "unobserved-class-EmptyOne") then "Numerical zero is not a native Fold form." else
  if !(SFT.Host.Text.equal (orderName c.order) "positive-Take-energy-and-count-orders") then "A signed difference or imported exponential law adds forbidden arithmetic." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-conditioned-vector-seal") then "External temperature, duration, energy or population could select the law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "one-observation-successor-no-extra-rule") then "Discarding history or adding a smoothing rule changes the declared population." else
  "complete-conformer-equivalence-census__held-observation-condition__positive-finite-observation-boundary__exact-recurrence-count-ratio__unobserved-class-EmptyOne__positive-Take-energy-and-count-orders__value-free-conditioned-vector-seal__one-observation-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, condition, finite boundary, population, absence, order, observation and extension alternatives; decide all 256 forms solely from admitted Fold and ORG-005 dependencies."
def grammarBoundary : String := "Every positive finite conformer equivalence census; every positive finite deterministic observation trace; one held condition and timescale; exact occurrence fractions; structural EmptyOne for no occurrence; positive relative-energy magnitudes and ordered Take; all fourteen frozen external target identities and every preserved response."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Condition.rejected,Condition.admitted]).flatMap fun condition =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Population.rejected,Population.admitted]).flatMap fun population =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,condition,boundary,population,absence,order,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier condition boundary population absence order observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcondition : condition ∈ [Condition.rejected,Condition.admitted] := by
      cases condition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpopulation : population ∈ [Population.rejected,Population.admitted] := by
      cases population <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ condition _ hcondition
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ population _ hpopulation
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier condition boundary population absence order observation extension =>
    cases carrier <;> cases condition <;> cases boundary <;> cases population <;> cases absence <;> cases order <;> cases observation <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier condition boundary population absence order observation extension =>
    cases carrier <;> cases condition <;> cases boundary <;> cases population <;> cases absence <;> cases order <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.condition = .admitted ∧ c.boundary = .admitted ∧ c.population = .admitted ∧ c.absence = .admitted ∧ c.order = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier condition boundary population absence order observation extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem condition_rejected_rejected (c : Candidate) (h : c.condition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.condition eq
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

theorem population_rejected_rejected (c : Candidate) (h : c.population = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.population eq
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

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

end SFT.Physics.ConformerPopulationGrammar
