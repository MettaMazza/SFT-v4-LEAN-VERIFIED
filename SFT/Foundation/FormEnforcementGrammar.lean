import SFT.Foundation.FormCanonicalRaw
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.FormEnforcementGrammar
set_option maxRecDepth 20000

inductive Coverage where
  | none | proper | complete

def coverageName : Coverage → String
  | .none => "none"
  | .proper => "proper"
  | .complete => "complete"

inductive Multiplicity where
  | duplicated | once

def multiplicityName : Multiplicity → String
  | .duplicated => "node-duplicated"
  | .once => "node-once"

inductive Labels where
  | lost | preserved

def labelsName : Labels → String
  | .lost => "labels-lost"
  | .preserved => "labels-preserved"

inductive Children where
  | changed | preserved

def childrenName : Children → String
  | .changed => "children-changed"
  | .preserved => "children-preserved"

inductive Returns where
  | lost | preserved

def returnsName : Returns → String
  | .lost => "returns-lost"
  | .preserved => "returns-preserved"

inductive Trace where
  | noncanonical | canonical

def traceName : Trace → String
  | .noncanonical => "trace-noncanonical"
  | .canonical => "trace-canonical"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  coverage : Coverage
  multiplicity : Multiplicity
  labels : Labels
  children : Children
  returns : Returns
  trace : Trace
  extra : Extra

def sourceFields (c : Candidate) : List String := [coverageName c.coverage, multiplicityName c.multiplicity, labelsName c.labels, childrenName c.children, returnsName c.returns, traceName c.trace, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Form-identity proposal has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]
def survivorId : String := "complete__node-once__labels-preserved__children-preserved__returns-preserved__trace-canonical__no-extra"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (coverageName c.coverage) "complete" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "node-once" &&
  SFT.Host.Text.equal (labelsName c.labels) "labels-preserved" &&
  SFT.Host.Text.equal (childrenName c.children) "children-preserved" &&
  SFT.Host.Text.equal (returnsName c.returns) "returns-preserved" &&
  SFT.Host.Text.equal (traceName c.trace) "trace-canonical" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (coverageName c.coverage) "none" then "It retains none of the generated source form." else
  if SFT.Host.Text.equal (coverageName c.coverage) "proper" then "It omits at least one generated node or relation." else
  if SFT.Host.Text.equal (multiplicityName c.multiplicity) "node-duplicated" then "It repeats a node already supplied by the construction trace." else
  if SFT.Host.Text.equal (labelsName c.labels) "labels-lost" then "It erases a held edge identity." else
  if SFT.Host.Text.equal (childrenName c.children) "children-changed" then "It changes a generated parent-child relation." else
  if SFT.Host.Text.equal (returnsName c.returns) "returns-lost" then "It omits a Fold return relation." else
  if SFT.Host.Text.equal (traceName c.trace) "trace-noncanonical" then "It does not follow the unique recursive production order." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "It adds a node, relation or name not supplied by the form." else
  "It retains the complete generated form once in canonical production order with all held labels, children and returns and no addition."

def generationRule : String := "Generate the complete product of source-form coverage, node multiplicity, held-label preservation, child-relation preservation, return preservation, canonical-trace status and unforced-extra-data presence."
def grammarBoundary : String := "All exact-identity representations of forms admitted by the complete finite One/Fold grammar."

def candidates : List Candidate :=
  ([Coverage.none,Coverage.proper,Coverage.complete]).flatMap fun coverage =>
  ([Multiplicity.duplicated,Multiplicity.once]).flatMap fun multiplicity =>
  ([Labels.lost,Labels.preserved]).flatMap fun labels =>
  ([Children.changed,Children.preserved]).flatMap fun children =>
  ([Returns.lost,Returns.preserved]).flatMap fun returns =>
  ([Trace.noncanonical,Trace.canonical]).flatMap fun trace =>
  ([Extra.noExtra,Extra.hasExtra]).map fun extra =>
  ⟨coverage,multiplicity,labels,children,returns,trace,extra⟩

def survivor : Candidate := ⟨.complete,.once,.preserved,.preserved,.preserved,.canonical,.noExtra⟩

theorem generatedCardinality : candidates.length = 192 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk coverage multiplicity labels children returns trace extra =>
    have hcoverage : coverage ∈ [Coverage.none,Coverage.proper,Coverage.complete] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.duplicated,Multiplicity.once] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlabels : labels ∈ [Labels.lost,Labels.preserved] := by
      cases labels <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchildren : children ∈ [Children.changed,Children.preserved] := by
      cases children <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturns : returns ∈ [Returns.lost,Returns.preserved] := by
      cases returns <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.noncanonical,Trace.canonical] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,Extra.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ labels _ hlabels
    apply CommonRefinement.memFlatMap _ _ children _ hchildren
    apply CommonRefinement.memFlatMap _ _ returns _ hreturns
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk coverage multiplicity labels children returns trace extra =>
    cases coverage <;> cases multiplicity <;> cases labels <;> cases children <;> cases returns <;> cases trace <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk coverage multiplicity labels children returns trace extra =>
    cases coverage <;> cases multiplicity <;> cases labels <;> cases children <;> cases returns <;> cases trace <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.coverage = .complete ∧ c.multiplicity = .once ∧ c.labels = .preserved ∧ c.children = .preserved ∧ c.returns = .preserved ∧ c.trace = .canonical ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk coverage multiplicity labels children returns trace extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem coverage_none_rejected (c : Candidate) (h : c.coverage = .none) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem coverage_proper_rejected (c : Candidate) (h : c.coverage = .proper) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem multiplicity_duplicated_rejected (c : Candidate) (h : c.multiplicity = .duplicated) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem labels_lost_rejected (c : Candidate) (h : c.labels = .lost) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.labels eq
    rw [h] at field
    cases field

theorem children_changed_rejected (c : Candidate) (h : c.children = .changed) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.children eq
    rw [h] at field
    cases field

theorem returns_lost_rejected (c : Candidate) (h : c.returns = .lost) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returns eq
    rw [h] at field
    cases field

theorem trace_noncanonical_rejected (c : Candidate) (h : c.trace = .noncanonical) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem extra_hasExtra_rejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.FormEnforcementGrammar
