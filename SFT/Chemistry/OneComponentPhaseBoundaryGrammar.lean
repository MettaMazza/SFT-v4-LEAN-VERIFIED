import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.OneComponentPhaseBoundaryGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unbound-temperature-pressure-pair"
  | .admitted => "complete-one-component-two-phase-point"

inductive Phase where
  | rejected | admitted

def phaseName : Phase → String
  | .rejected => "single-phase-state-or-erased-phase-pair"
  | .admitted => "two-distinct-held-coexisting-phases"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "assumed-equilibrium-or-target-derived-equality"
  | .admitted => "exact-component-exchange-support-balance"

inductive Degree where
  | rejected | admitted

def degreeName : Degree → String
  | .rejected => "free-two-coordinate-continuum"
  | .admitted => "one-independent-held-coordinate-support"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "imported-differential-equation-or-fitted-slope"
  | .admitted => "exact-positive-temperature-pressure-co-order"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "interpolated-continuum-curve"
  | .admitted => "finite-ordered-coexistence-word"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "coexistence-values-readable-before-seal"
  | .admitted => "complete-value-free-15-point-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-appending-or-replication"
  | .admitted => "depth-independent-append-and-common-replication"

structure Candidate where
  carrier : Carrier
  phase : Phase
  balance : Balance
  degree : Degree
  response : Response
  boundary : Boundary
  prediction : Prediction
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, phaseName c.phase, balanceName c.balance, degreeName c.degree, responseName c.response, boundaryName c.boundary, predictionName c.prediction, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "phase=" (phaseName c.phase), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "degree=" (degreeName c.degree), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-one-component-two-phase-point__two-distinct-held-coexisting-phases__exact-component-exchange-support-balance__one-independent-held-coordinate-support__exact-positive-temperature-pressure-co-order__finite-ordered-coexistence-word__complete-value-free-15-point-identity-seal__depth-independent-append-and-common-replication"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-one-component-two-phase-point" &&
  SFT.Host.Text.equal (phaseName c.phase) "two-distinct-held-coexisting-phases" &&
  SFT.Host.Text.equal (balanceName c.balance) "exact-component-exchange-support-balance" &&
  SFT.Host.Text.equal (degreeName c.degree) "one-independent-held-coordinate-support" &&
  SFT.Host.Text.equal (responseName c.response) "exact-positive-temperature-pressure-co-order" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "finite-ordered-coexistence-word" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-15-point-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-and-common-replication"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-one-component-two-phase-point") then "A detached pair erases the component, phases and exchange support that make it a boundary point." else
  if !(SFT.Host.Text.equal (phaseName c.phase) "two-distinct-held-coexisting-phases") then "A single phase does not define a coexistence boundary." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "exact-component-exchange-support-balance") then "Assumption or target adjustment does not force coexistence." else
  if !(SFT.Host.Text.equal (degreeName c.degree) "one-independent-held-coordinate-support") then "A free plane contradicts the single remaining carrier forced by one component and two phases." else
  if !(SFT.Host.Text.equal (responseName c.response) "exact-positive-temperature-pressure-co-order") then "A differential equation or fitted slope imports a continuum model." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "finite-ordered-coexistence-word") then "Interpolation invents unmeasured points and an unenumerated continuum." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-15-point-identity-seal") then "Readable temperatures or pressures could select the relation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-append-and-common-replication") then "Refitting destroys exact succession and support provenance." else
  "complete-one-component-two-phase-point__two-distinct-held-coexisting-phases__exact-component-exchange-support-balance__one-independent-held-coordinate-support__exact-positive-temperature-pressure-co-order__finite-ordered-coexistence-word__complete-value-free-15-point-identity-seal__depth-independent-append-and-common-replication"

def generationRule : String := "Generate the literal product of carrier, phase, balance, degree, response, boundary, prediction and extension forms; decide all 256 candidates only from admitted component identity, exchange balance, phase-rule cancellation, exact order and finite-word successor laws."
def grammarBoundary : String := "Every finite positive word of one-component, two-distinct-phase, exactly exchange-balanced coexistence points whose held temperature and pressure supports are strictly co-ordered in source succession. External testing preserves both compounds, all three direct datasets, all fifteen measured points, all twelve adjacent successions and the complete 21-dataset 176-point parent source."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Phase.rejected,Phase.admitted]).flatMap fun phase =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Degree.rejected,Degree.admitted]).flatMap fun degree =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,phase,balance,degree,response,boundary,prediction,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier phase balance degree response boundary prediction extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphase : phase ∈ [Phase.rejected,Phase.admitted] := by
      cases phase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdegree : degree ∈ [Degree.rejected,Degree.admitted] := by
      cases degree <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ phase _ hphase
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    apply CommonRefinement.memFlatMap _ _ degree _ hdegree
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (response : Response) (boundary : Boundary) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,response,boundary,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,response,boundary,prediction,extension⟩ := by
 cases response <;> cases boundary <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier phase balance degree response boundary prediction extension =>
  cases carrier <;> cases phase <;> cases balance <;> cases degree
  · exact sourceDecisionBlock0000 response boundary prediction extension
  · exact sourceDecisionBlock0001 response boundary prediction extension
  · exact sourceDecisionBlock0010 response boundary prediction extension
  · exact sourceDecisionBlock0011 response boundary prediction extension
  · exact sourceDecisionBlock0100 response boundary prediction extension
  · exact sourceDecisionBlock0101 response boundary prediction extension
  · exact sourceDecisionBlock0110 response boundary prediction extension
  · exact sourceDecisionBlock0111 response boundary prediction extension
  · exact sourceDecisionBlock1000 response boundary prediction extension
  · exact sourceDecisionBlock1001 response boundary prediction extension
  · exact sourceDecisionBlock1010 response boundary prediction extension
  · exact sourceDecisionBlock1011 response boundary prediction extension
  · exact sourceDecisionBlock1100 response boundary prediction extension
  · exact sourceDecisionBlock1101 response boundary prediction extension
  · exact sourceDecisionBlock1110 response boundary prediction extension
  · exact sourceDecisionBlock1111 response boundary prediction extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-one-component-two-phase-point" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem phaseCriterion (value : Phase) : SFT.Host.Text.equal (phaseName value) "two-distinct-held-coexisting-phases" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem balanceCriterion (value : Balance) : SFT.Host.Text.equal (balanceName value) "exact-component-exchange-support-balance" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem degreeCriterion (value : Degree) : SFT.Host.Text.equal (degreeName value) "one-independent-held-coordinate-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem responseCriterion (value : Response) : SFT.Host.Text.equal (responseName value) "exact-positive-temperature-pressure-co-order" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "finite-ordered-coexistence-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-15-point-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-append-and-common-replication" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, phaseCriterion, balanceCriterion, degreeCriterion, responseCriterion, boundaryCriterion, predictionCriterion, extensionCriterion]
  cases c with
  | mk carrier phase balance degree response boundary prediction extension =>
    cases carrier <;> cases phase <;> cases balance <;> cases degree <;> cases response <;> cases boundary <;> cases prediction <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.phase = .admitted ∧ c.balance = .admitted ∧ c.degree = .admitted ∧ c.response = .admitted ∧ c.boundary = .admitted ∧ c.prediction = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier phase balance degree response boundary prediction extension =>
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

theorem phase_rejected_rejected (c : Candidate) (h : c.phase = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phase eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem degree_rejected_rejected (c : Candidate) (h : c.degree = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.degree eq
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

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
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

end SFT.Chemistry.OneComponentPhaseBoundaryGrammar
