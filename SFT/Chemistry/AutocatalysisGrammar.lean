import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.AutocatalysisGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Product where
  | rejected | admitted

def productName : Product → String
  | .rejected => "external-catalyst-only"
  | .admitted => "reaction-product-is-catalyst"

inductive Feedback where
  | rejected | admitted

def feedbackName : Feedback → String
  | .rejected => "product-inert"
  | .admitted => "product-accelerates-own-formation"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "product-role-erased"
  | .admitted => "same-identity-feedback"

inductive Growth where
  | rejected | admitted

def growthName : Growth → String
  | .rejected => "unbounded-free-copy"
  | .admitted => "resource-consuming-amplification"

inductive Cycle where
  | rejected | admitted

def cycleName : Cycle → String
  | .rejected => "linear-step-only"
  | .admitted => "positive-feedback-cycle"

inductive Limit where
  | rejected | admitted

def limitName : Limit → String
  | .rejected => "infinite-support-assumed"
  | .admitted => "finite-resource-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "growth-label-only"
  | .admitted => "complete-feedback-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-growth-constant"
  | .admitted => "no-extra-rule"

structure Candidate where
  product : Product
  feedback : Feedback
  identity : Identity
  growth : Growth
  cycle : Cycle
  limit : Limit
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [productName c.product, feedbackName c.feedback, identityName c.identity, growthName c.growth, cycleName c.cycle, limitName c.limit, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "product=" (productName c.product), SFT.Host.Text.append "feedback=" (feedbackName c.feedback), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "growth=" (growthName c.growth), SFT.Host.Text.append "cycle=" (cycleName c.cycle), SFT.Host.Text.append "limit=" (limitName c.limit), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "reaction-product-is-catalyst__product-accelerates-own-formation__same-identity-feedback__resource-consuming-amplification__positive-feedback-cycle__finite-resource-bounded__complete-feedback-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (productName c.product) "reaction-product-is-catalyst" &&
  SFT.Host.Text.equal (feedbackName c.feedback) "product-accelerates-own-formation" &&
  SFT.Host.Text.equal (identityName c.identity) "same-identity-feedback" &&
  SFT.Host.Text.equal (growthName c.growth) "resource-consuming-amplification" &&
  SFT.Host.Text.equal (cycleName c.cycle) "positive-feedback-cycle" &&
  SFT.Host.Text.equal (limitName c.limit) "finite-resource-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "complete-feedback-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (productName c.product) "reaction-product-is-catalyst") then "Self-production is absent." else
  if !(SFT.Host.Text.equal (feedbackName c.feedback) "product-accelerates-own-formation") then "Output cannot affect its formation." else
  if !(SFT.Host.Text.equal (identityName c.identity) "same-identity-feedback") then "The feedback carrier is unknown." else
  if !(SFT.Host.Text.equal (growthName c.growth) "resource-consuming-amplification") then "Creation violates closure." else
  if !(SFT.Host.Text.equal (cycleName c.cycle) "positive-feedback-cycle") then "No feedback path closes." else
  if !(SFT.Host.Text.equal (limitName c.limit) "finite-resource-bounded") then "Resources are not counted." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-feedback-trace") then "Carrier balance cannot be checked." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted rate can force behavior." else
  "reaction-product-is-catalyst__product-accelerates-own-formation__same-identity-feedback__resource-consuming-amplification__positive-feedback-cycle"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite reaction network whose product/catalyst identity equality, feedback edge, consumed inputs and stopping boundary are completely recorded."

def candidates : List Candidate :=
  ([Product.rejected,Product.admitted]).flatMap fun product =>
  ([Feedback.rejected,Feedback.admitted]).flatMap fun feedback =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Growth.rejected,Growth.admitted]).flatMap fun growth =>
  ([Cycle.rejected,Cycle.admitted]).flatMap fun cycle =>
  ([Limit.rejected,Limit.admitted]).flatMap fun limit =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨product,feedback,identity,growth,cycle,limit,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk product feedback identity growth cycle limit record extra =>
    have hproduct : product ∈ [Product.rejected,Product.admitted] := by
      cases product <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfeedback : feedback ∈ [Feedback.rejected,Feedback.admitted] := by
      cases feedback <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgrowth : growth ∈ [Growth.rejected,Growth.admitted] := by
      cases growth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcycle : cycle ∈ [Cycle.rejected,Cycle.admitted] := by
      cases cycle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlimit : limit ∈ [Limit.rejected,Limit.admitted] := by
      cases limit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ product _ hproduct
    apply CommonRefinement.memFlatMap _ _ feedback _ hfeedback
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ growth _ hgrowth
    apply CommonRefinement.memFlatMap _ _ cycle _ hcycle
    apply CommonRefinement.memFlatMap _ _ limit _ hlimit
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk product feedback identity growth cycle limit record extra =>
    cases product <;> cases feedback <;> cases identity <;> cases growth <;> cases cycle <;> cases limit <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk product feedback identity growth cycle limit record extra =>
    cases product <;> cases feedback <;> cases identity <;> cases growth <;> cases cycle <;> cases limit <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.product = .admitted ∧ c.feedback = .admitted ∧ c.identity = .admitted ∧ c.growth = .admitted ∧ c.cycle = .admitted ∧ c.limit = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk product feedback identity growth cycle limit record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem product_rejected_rejected (c : Candidate) (h : c.product = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.product eq
    rw [h] at field
    cases field

theorem feedback_rejected_rejected (c : Candidate) (h : c.feedback = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.feedback eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem growth_rejected_rejected (c : Candidate) (h : c.growth = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.growth eq
    rw [h] at field
    cases field

theorem cycle_rejected_rejected (c : Candidate) (h : c.cycle = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cycle eq
    rw [h] at field
    cases field

theorem limit_rejected_rejected (c : Candidate) (h : c.limit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.limit eq
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

end SFT.Chemistry.AutocatalysisGrammar
