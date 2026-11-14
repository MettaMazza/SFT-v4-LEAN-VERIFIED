import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.TerminalProtonEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

inductive Base where
  | rejected | admitted

def baseName : Base → String
  | .rejected => "replace-or-refit-base-ratio"
  | .admitted => "retain-admitted-proton-graph"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "selected-composite-depth"
  | .admitted => "generator-three-composite-depth"

inductive Complement where
  | rejected | admitted

def complementName : Complement → String
  | .rejected => "free-multiplicity"
  | .admitted => "complete-depth-three-heavy-complement"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "selected-alpha-order"
  | .admitted => "one-alpha-per-charged-Fold-end"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-bulk-or-boundary-support"
  | .admitted => "complete-colour-bulk-plus-carried-boundary"

inductive Terminal where
  | rejected | admitted

def terminalName : Terminal → String
  | .rejected => "leading-order-only-or-extra-series"
  | .admitted => "one-terminal-alpha-successor"

inductive Transport where
  | rejected | admitted

def transportName : Transport → String
  | .rejected => "free-return-weight"
  | .admitted => "both-labels-through-down-depth-and-volume"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "append-unbound-mass"
  | .admitted => "hold-dressing-from-existing-ratio"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measurement-readable-relation"
  | .admitted => "measurement-inaccessible-to-executable-relation"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "unregistered-target-readable-fit"
  | .admitted => "registered-observational-prediction-protocol"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "additional-fit-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  base : Base
  depth : Depth
  complement : Complement
  order : Order
  support : Support
  terminal : Terminal
  transport : Transport
  orientation : Orientation
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [baseName c.base, depthName c.depth, complementName c.complement, orderName c.order, supportName c.support, terminalName c.terminal, transportName c.transport, orientationName c.orientation, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "base=" (baseName c.base), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "complement=" (complementName c.complement), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "terminal=" (terminalName c.terminal), SFT.Host.Text.append "transport=" (transportName c.transport), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retain-admitted-proton-graph__generator-three-composite-depth__complete-depth-three-heavy-complement__one-alpha-per-charged-Fold-end__complete-colour-bulk-plus-carried-boundary__one-terminal-alpha-successor__both-labels-through-down-depth-and-volume__hold-dressing-from-existing-ratio__measurement-inaccessible-to-executable-relation__registered-observational-prediction-protocol__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (baseName c.base) "retain-admitted-proton-graph" &&
  SFT.Host.Text.equal (depthName c.depth) "generator-three-composite-depth" &&
  SFT.Host.Text.equal (complementName c.complement) "complete-depth-three-heavy-complement" &&
  SFT.Host.Text.equal (orderName c.order) "one-alpha-per-charged-Fold-end" &&
  SFT.Host.Text.equal (supportName c.support) "complete-colour-bulk-plus-carried-boundary" &&
  SFT.Host.Text.equal (terminalName c.terminal) "one-terminal-alpha-successor" &&
  SFT.Host.Text.equal (transportName c.transport) "both-labels-through-down-depth-and-volume" &&
  SFT.Host.Text.equal (orientationName c.orientation) "hold-dressing-from-existing-ratio" &&
  SFT.Host.Text.equal (targetName c.target) "measurement-inaccessible-to-executable-relation" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "registered-observational-prediction-protocol" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (baseName c.base) "replace-or-refit-base-ratio" then "Replacing the admitted algebraic graph erases its receipt." else
  if SFT.Host.Text.equal (depthName c.depth) "selected-composite-depth" then "A selected depth can tune the correction." else
  if SFT.Host.Text.equal (complementName c.complement) "free-multiplicity" then "A free multiplicity is a parameter." else
  if SFT.Host.Text.equal (orderName c.order) "selected-alpha-order" then "A selected order can read the mismatch." else
  if SFT.Host.Text.equal (supportName c.support) "partial-bulk-or-boundary-support" then "Omitting either carrier loses part of the composite." else
  if SFT.Host.Text.equal (terminalName c.terminal) "leading-order-only-or-extra-series" then "Leading-only omits the declared terminal carrier; an open series has no closure." else
  if SFT.Host.Text.equal (transportName c.transport) "free-return-weight" then "A free return weight is a fitted coefficient." else
  if SFT.Host.Text.equal (orientationName c.orientation) "append-unbound-mass" then "Appending a new mass carrier breaks the normalized composite ledger." else
  if SFT.Host.Text.equal (targetName c.target) "measurement-readable-relation" then "That would fit the known mismatch." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "unregistered-target-readable-fit" then "Target-readable execution cannot issue an independent prediction seal." else
  if SFT.Host.Text.equal (extensionName c.extension) "additional-fit-term" then "A further term is not supplied by the exhausted first-terminal grammar." else
  "Let R3 be the admitted exact algebraic proton/electron ratio and alpha the reciprocal of the admitted terminal inverse-alpha.  The unique retained successor is R4 = R3 * [1 - delta] in conventional notation, represented only as positive_take(One,delta), where delta = (53/30) alpha^2 [1 + (2/135) alpha]."

def generationRule : String := "Generate the complete eleven-axis product of base graph, composite depth, complement, coupling order, bulk/boundary support, terminal return, transport, orientation, custody, provenance and extension forms."
def grammarBoundary : String := "All first terminal electromagnetic dressings of the admitted proton/electron algebraic graph that use each already admitted composite-depth, colour-volume, boundary-channel, Fold-label, cover-depth and terminal-alpha carrier exactly once in its typed role."

def candidates : List Candidate :=
  ([Base.rejected,Base.admitted]).flatMap fun base =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Complement.rejected,Complement.admitted]).flatMap fun complement =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Terminal.rejected,Terminal.admitted]).flatMap fun terminal =>
  ([Transport.rejected,Transport.admitted]).flatMap fun transport =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨base,depth,complement,order,support,terminal,transport,orientation,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk base depth complement order support terminal transport orientation target provenance extension =>
    have hbase : base ∈ [Base.rejected,Base.admitted] := by
      cases base <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomplement : complement ∈ [Complement.rejected,Complement.admitted] := by
      cases complement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterminal : terminal ∈ [Terminal.rejected,Terminal.admitted] := by
      cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransport : transport ∈ [Transport.rejected,Transport.admitted] := by
      cases transport <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ base _ hbase
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ complement _ hcomplement
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ terminal _ hterminal
    apply CommonRefinement.memFlatMap _ _ transport _ htransport
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk base depth complement order support terminal transport orientation target provenance extension =>
    cases base <;> cases depth <;> cases complement <;> cases order <;> cases support <;> cases terminal <;> cases transport <;> cases orientation <;> cases target <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk base depth complement order support terminal transport orientation target provenance extension =>
    cases base <;> cases depth <;> cases complement <;> cases order <;> cases support <;> cases terminal <;> cases transport <;> cases orientation <;> cases target <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.base = .admitted ∧ c.depth = .admitted ∧ c.complement = .admitted ∧ c.order = .admitted ∧ c.support = .admitted ∧ c.terminal = .admitted ∧ c.transport = .admitted ∧ c.orientation = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk base depth complement order support terminal transport orientation target provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem base_rejected_rejected (c : Candidate) (h : c.base = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.base eq
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

theorem complement_rejected_rejected (c : Candidate) (h : c.complement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.complement eq
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem terminal_rejected_rejected (c : Candidate) (h : c.terminal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.terminal eq
    rw [h] at field
    cases field

theorem transport_rejected_rejected (c : Candidate) (h : c.transport = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transport eq
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

end SFT.Physics.TerminalProtonEntryGrammar
