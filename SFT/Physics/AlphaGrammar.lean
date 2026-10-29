import SFT.Physics.AlphaRatio
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AlphaGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Cover where
  | rejected | admitted

def coverName : Cover → String
  | .rejected => "asserted-depths"
  | .admitted => "least-complete-binary-covers"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "single-route-depths"
  | .admitted => "cover-generator-cross-lock"

inductive Tower where
  | rejected | admitted

def towerName : Tower → String
  | .rejected => "free-leading-whole"
  | .admitted => "binary-at-up-depth"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "free-boundary-factor"
  | .admitted => "generator-at-boundary-rank"

inductive Return where
  | rejected | admitted

def returnName : Return → String
  | .rejected => "fitted-small-correction"
  | .admitted => "one-return-over-complete-cover"

inductive Join where
  | rejected | admitted

def joinName : Join → String
  | .rejected => "untyped-arithmetic-permutation"
  | .admitted => "tower-plus-dilated-boundary"

inductive Promotion where
  | rejected | admitted

def promotionName : Promotion → String
  | .rejected => "selected-refinement-series"
  | .admitted => "one-remaining-direction-per-rung"

inductive Termination where
  | rejected | admitted

def terminationName : Termination → String
  | .rejected => "infinite-or-truncated-by-fit"
  | .admitted => "all-three-directions-promoted"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measured-alpha-visible"
  | .admitted => "measurement-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-scale-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  cover : Cover
  depth : Depth
  tower : Tower
  boundary : Boundary
  returns : Return
  join : Join
  promotion : Promotion
  termination : Termination
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [coverName c.cover, depthName c.depth, towerName c.tower, boundaryName c.boundary, returnName c.returns, joinName c.join, promotionName c.promotion, terminationName c.termination, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "cover=" (coverName c.cover), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "tower=" (towerName c.tower), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "return=" (returnName c.returns), SFT.Host.Text.append "join=" (joinName c.join), SFT.Host.Text.append "promotion=" (promotionName c.promotion), SFT.Host.Text.append "termination=" (terminationName c.termination), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "least-complete-binary-covers__cover-generator-cross-lock__binary-at-up-depth__generator-at-boundary-rank__one-return-over-complete-cover__tower-plus-dilated-boundary__one-remaining-direction-per-rung__all-three-directions-promoted__measurement-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (coverName c.cover) "least-complete-binary-covers" &&
  SFT.Host.Text.equal (depthName c.depth) "cover-generator-cross-lock" &&
  SFT.Host.Text.equal (towerName c.tower) "binary-at-up-depth" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "generator-at-boundary-rank" &&
  SFT.Host.Text.equal (returnName c.returns) "one-return-over-complete-cover" &&
  SFT.Host.Text.equal (joinName c.join) "tower-plus-dilated-boundary" &&
  SFT.Host.Text.equal (promotionName c.promotion) "one-remaining-direction-per-rung" &&
  SFT.Host.Text.equal (terminationName c.termination) "all-three-directions-promoted" &&
  SFT.Host.Text.equal (targetName c.target) "measurement-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (coverName c.cover) "asserted-depths" then "Asserted depths have no support census." else
  if SFT.Host.Text.equal (depthName c.depth) "single-route-depths" then "One route cannot expose a changed carrier." else
  if SFT.Host.Text.equal (towerName c.tower) "free-leading-whole" then "A free leading whole is a parameter." else
  if SFT.Host.Text.equal (boundaryName c.boundary) "free-boundary-factor" then "A free coefficient is not structural." else
  if SFT.Host.Text.equal (returnName c.returns) "fitted-small-correction" then "A fitted correction reads the target." else
  if SFT.Host.Text.equal (joinName c.join) "untyped-arithmetic-permutation" then "Permuting typed carriers erases their roles." else
  if SFT.Host.Text.equal (promotionName c.promotion) "selected-refinement-series" then "A selected series adds unfixed terms." else
  if SFT.Host.Text.equal (terminationName c.termination) "infinite-or-truncated-by-fit" then "A fit-selected truncation is not closure." else
  if SFT.Host.Text.equal (targetName c.target) "measured-alpha-visible" then "That makes measurement an answer-bearing premise." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-scale-rule" then "An extra scale is a free parameter." else
  "The terminal inverse fine-structure Fold ratio is exactly 503846395469/3676744786; its leading rung is exactly 34259/250."

def generationRule : String := "Generate the complete typed product of cover, depth, tower, boundary, return, join, promotion, termination, target custody and extension forms."
def grammarBoundary : String := "All type-correct assemblies that use each forced binary/generator cover block in its generated role, admit only the One as recurrence correction, and promote each of the three interchangeable cover directions at most once."

def candidates : List Candidate :=
  ([Cover.rejected,Cover.admitted]).flatMap fun cover =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Tower.rejected,Tower.admitted]).flatMap fun tower =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Return.rejected,Return.admitted]).flatMap fun returns =>
  ([Join.rejected,Join.admitted]).flatMap fun join =>
  ([Promotion.rejected,Promotion.admitted]).flatMap fun promotion =>
  ([Termination.rejected,Termination.admitted]).flatMap fun termination =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨cover,depth,tower,boundary,returns,join,promotion,termination,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk cover depth tower boundary returns join promotion termination target extension =>
    have hcover : cover ∈ [Cover.rejected,Cover.admitted] := by
      cases cover <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htower : tower ∈ [Tower.rejected,Tower.admitted] := by
      cases tower <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturn : returns ∈ [Return.rejected,Return.admitted] := by
      cases returns <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoin : join ∈ [Join.rejected,Join.admitted] := by
      cases join <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpromotion : promotion ∈ [Promotion.rejected,Promotion.admitted] := by
      cases promotion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htermination : termination ∈ [Termination.rejected,Termination.admitted] := by
      cases termination <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ cover _ hcover
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ tower _ htower
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ returns _ hreturn
    apply CommonRefinement.memFlatMap _ _ join _ hjoin
    apply CommonRefinement.memFlatMap _ _ promotion _ hpromotion
    apply CommonRefinement.memFlatMap _ _ termination _ htermination
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk cover depth tower boundary returns join promotion termination target extension =>
    cases cover <;> cases depth <;> cases tower <;> cases boundary <;> cases returns <;> cases join <;> cases promotion <;> cases termination <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk cover depth tower boundary returns join promotion termination target extension =>
    cases cover <;> cases depth <;> cases tower <;> cases boundary <;> cases returns <;> cases join <;> cases promotion <;> cases termination <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.cover = .admitted ∧ c.depth = .admitted ∧ c.tower = .admitted ∧ c.boundary = .admitted ∧ c.returns = .admitted ∧ c.join = .admitted ∧ c.promotion = .admitted ∧ c.termination = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk cover depth tower boundary returns join promotion termination target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem cover_rejected_rejected (c : Candidate) (h : c.cover = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cover eq
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

theorem tower_rejected_rejected (c : Candidate) (h : c.tower = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.tower eq
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

theorem return_rejected_rejected (c : Candidate) (h : c.returns = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returns eq
    rw [h] at field
    cases field

theorem join_rejected_rejected (c : Candidate) (h : c.join = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.join eq
    rw [h] at field
    cases field

theorem promotion_rejected_rejected (c : Candidate) (h : c.promotion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.promotion eq
    rw [h] at field
    cases field

theorem termination_rejected_rejected (c : Candidate) (h : c.termination = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.termination eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.AlphaGrammar
