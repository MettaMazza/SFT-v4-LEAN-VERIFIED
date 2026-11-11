import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ActivationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "endpoint-only"
  | .admitted => "complete-generated-reaction-path"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "free-energy-number"
  | .admitted => "source-bound-support-account"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "arbitrary-high-state"
  | .admitted => "highest-path-boundary"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "absolute-energy-origin"
  | .admitted => "reactant-relative-support"

inductive Minimality where
  | rejected | admitted

def minimalityName : Minimality → String
  | .rejected => "nonminimal-added-support"
  | .admitted => "least-crossing-support"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-barrier"
  | .admitted => "held-reactant-to-transition-orientation"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "activation-value-only"
  | .admitted => "path-source-boundary-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-temperature-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  path : Path
  source : Source
  transition : Transition
  reference : Reference
  minimality : Minimality
  orientation : Orientation
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [pathName c.path, sourceName c.source, transitionName c.transition, referenceName c.reference, minimalityName c.minimality, orientationName c.orientation, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "minimality=" (minimalityName c.minimality), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "complete-generated-reaction-path__source-bound-support-account__highest-path-boundary__reactant-relative-support__least-crossing-support__held-reactant-to-transition-orientation__path-source-boundary-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (pathName c.path) "complete-generated-reaction-path" &&
  SFT.Host.Text.equal (sourceName c.source) "source-bound-support-account" &&
  SFT.Host.Text.equal (transitionName c.transition) "highest-path-boundary" &&
  SFT.Host.Text.equal (referenceName c.reference) "reactant-relative-support" &&
  SFT.Host.Text.equal (minimalityName c.minimality) "least-crossing-support" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-reactant-to-transition-orientation" &&
  SFT.Host.Text.equal (recordName c.record) "path-source-boundary-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (pathName c.path) "complete-generated-reaction-path") then "No crossing requirement is represented." else
  if !(SFT.Host.Text.equal (sourceName c.source) "source-bound-support-account") then "An imported number selects the barrier." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "highest-path-boundary") then "It need not lie on the path." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "reactant-relative-support") then "An arbitrary origin imports a parameter." else
  if !(SFT.Host.Text.equal (minimalityName c.minimality) "least-crossing-support") then "Extra support does not define activation." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-reactant-to-transition-orientation") then "A negative scalar is outside the proof domain." else
  if !(SFT.Host.Text.equal (recordName c.record) "path-source-boundary-trace") then "A value cannot reproduce the path." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fitted input can tune the result." else
  "complete-generated-reaction-path__source-bound-support-account__highest-path-boundary__reactant-relative-support__least-crossing-support"

def generationRule : String := "Generate the literal product of path, source, transition, reference, minimality, orientation, record and extension choices."
def grammarBoundary : String := "Every finite generated reaction path from a retained reactant organization to product organization, with the least additional source support needed to reach its unique highest transition boundary recorded relative to the reactant boundary."

def candidates : List Candidate :=
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Minimality.rejected,Minimality.admitted]).flatMap fun minimality =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨path,source,transition,reference,minimality,orientation,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk path source transition reference minimality orientation record extra =>
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hminimality : minimality ∈ [Minimality.rejected,Minimality.admitted] := by
      cases minimality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ minimality _ hminimality
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk path source transition reference minimality orientation record extra =>
    cases path <;> cases source <;> cases transition <;> cases reference <;> cases minimality <;> cases orientation <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk path source transition reference minimality orientation record extra =>
    cases path <;> cases source <;> cases transition <;> cases reference <;> cases minimality <;> cases orientation <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.path = .admitted ∧ c.source = .admitted ∧ c.transition = .admitted ∧ c.reference = .admitted ∧ c.minimality = .admitted ∧ c.orientation = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk path source transition reference minimality orientation record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
    rw [h] at field
    cases field

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
    rw [h] at field
    cases field

theorem transition_rejected_rejected (c : Candidate) (h : c.transition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transition eq
    rw [h] at field
    cases field

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
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

end SFT.Chemistry.ActivationGrammar
