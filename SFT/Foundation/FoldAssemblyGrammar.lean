import SFT.Foundation.FoldAssembly
namespace SFT.Foundation.FoldAssemblyGrammar
set_option maxRecDepth 20000

inductive Coverage where
  | none | proper | complete

def coverageName : Coverage → String
  | .none => "none"
  | .proper => "proper"
  | .complete => "complete"

inductive Length where
  | inconsistent | consistent

def lengthName : Length → String
  | .inconsistent => "inconsistent-length"
  | .consistent => "consistent-length"

inductive Support where
  | incomplete | complete

def supportName : Support → String
  | .incomplete => "support-incomplete"
  | .complete => "support-complete"

inductive Uniqueness where
  | duplicated | unique

def uniqueName : Uniqueness → String
  | .duplicated => "words-duplicated"
  | .unique => "words-unique"

inductive Transitions where
  | absent | present

def transitionsName : Transitions → String
  | .absent => "transitions-absent"
  | .present => "transitions-present"

inductive Returns where
  | absent | present

def returnsName : Returns → String
  | .absent => "returns-absent"
  | .present => "returns-present"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  coverage : Coverage
  length : Length
  support : Support
  unique : Uniqueness
  transitions : Transitions
  returns : Returns
  extra : Extra

def sourceFields (c : Candidate) : List String := [coverageName c.coverage, lengthName c.length, supportName c.support, uniqueName c.unique, transitionsName c.transitions, returnsName c.returns, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)

def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Assembly representation has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]

def survivorId : String := "complete__consistent-length__support-complete__words-unique__transitions-present__returns-present__no-extra"

def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId

def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (coverageName c.coverage) "complete" &&
  SFT.Host.Text.equal (lengthName c.length) "consistent-length" &&
  SFT.Host.Text.equal (supportName c.support) "support-complete" &&
  SFT.Host.Text.equal (uniqueName c.unique) "words-unique" &&
  SFT.Host.Text.equal (transitionsName c.transitions) "transitions-present" &&
  SFT.Host.Text.equal (returnsName c.returns) "returns-present" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (coverageName c.coverage) "none" then "It retains no generated Fold step." else
  if SFT.Host.Text.equal (coverageName c.coverage) "proper" then "It omits at least one generated Fold step." else
  if SFT.Host.Text.equal (lengthName c.length) "inconsistent-length" then "At least one word does not carry one held label per Fold step." else
  if SFT.Host.Text.equal (supportName c.support) "support-incomplete" then "At least one recursively forced held-label extension is missing." else
  if SFT.Host.Text.equal (uniqueName c.unique) "words-duplicated" then "At least one generated word is repeated." else
  if SFT.Host.Text.equal (transitionsName c.transitions) "transitions-absent" then "The predecessor-to-successor construction trace is missing." else
  if SFT.Host.Text.equal (returnsName c.returns) "returns-absent" then "The assembly lacks the complete return records to the One." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "The representation adds a word, label or rule not supplied by Fold recursion." else
  "It retains every Fold step, every unique equal-length held-label word, every transition and every return without addition."

def generationRule : String := "Generate the complete product of Fold-trace coverage, word-length consistency, support completeness, word uniqueness, transition records, return records and unforced-extra-data presence."
def grammarBoundary : String := "All representations of any generated finite Fold succession, with support formed recursively from the empty One word by appending each of the two held Fold labels at every successor step."

def candidates : List Candidate :=
  ([Coverage.none,.proper,.complete]).flatMap fun coverage =>
  ([Length.inconsistent,.consistent]).flatMap fun length =>
  ([Support.incomplete,.complete]).flatMap fun support =>
  ([Uniqueness.duplicated,.unique]).flatMap fun unique =>
  ([Transitions.absent,.present]).flatMap fun transitions =>
  ([Returns.absent,.present]).flatMap fun returns =>
  ([Extra.noExtra,.hasExtra]).map fun extra =>
  ⟨coverage,length,support,unique,transitions,returns,extra⟩

def survivor : Candidate := ⟨.complete,.consistent,.complete,.unique,.present,.present,.noExtra⟩

theorem generatedCardinality : candidates.length = 192 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk coverage length support unique transitions returns extra =>
    have hcoverage : coverage ∈ [Coverage.none,.proper,.complete] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlength : length ∈ [Length.inconsistent,.consistent] := by
      cases length <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.incomplete,.complete] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunique : unique ∈ [Uniqueness.duplicated,.unique] := by
      cases unique <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransitions : transitions ∈ [Transitions.absent,.present] := by
      cases transitions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturns : returns ∈ [Returns.absent,.present] := by
      cases returns <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ length _ hlength
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ unique _ hunique
    apply CommonRefinement.memFlatMap _ _ transitions _ htransitions
    apply CommonRefinement.memFlatMap _ _ returns _ hreturns
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 10000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk coverage length support unique transitions returns extra =>
    cases coverage <;> cases length <;> cases support <;> cases unique <;> cases transitions <;> cases returns <;> cases extra
    all_goals rfl

set_option maxHeartbeats 4000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk coverage length support unique transitions returns extra =>
    cases coverage <;> cases length <;> cases support <;> cases unique <;> cases transitions <;> cases returns <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.coverage = .complete ∧ c.length = .consistent ∧ c.support = .complete ∧ c.unique = .unique ∧ c.transitions = .present ∧ c.returns = .present ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk coverage length support unique transitions returns extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem coverageNoneRejected (c : Candidate) (h : c.coverage = .none) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem coverageProperRejected (c : Candidate) (h : c.coverage = .proper) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem lengthInconsistentRejected (c : Candidate) (h : c.length = .inconsistent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.length eq
    rw [h] at field
    cases field

theorem supportIncompleteRejected (c : Candidate) (h : c.support = .incomplete) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem uniqueDuplicatedRejected (c : Candidate) (h : c.unique = .duplicated) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unique eq
    rw [h] at field
    cases field

theorem transitionsAbsentRejected (c : Candidate) (h : c.transitions = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.transitions eq
    rw [h] at field
    cases field

theorem returnsAbsentRejected (c : Candidate) (h : c.returns = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returns eq
    rw [h] at field
    cases field

theorem extraHasExtraRejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.FoldAssemblyGrammar
