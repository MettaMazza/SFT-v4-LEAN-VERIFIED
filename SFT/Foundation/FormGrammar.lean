import SFT.Foundation.FormAcceptance
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.FormGrammar
set_option maxRecDepth 20000

inductive Base where
  | excluded | included

def baseName : Base → String
  | .excluded => "base-excluded"
  | .included => "base-included"

inductive Arity where
  | oneChild | twoChildren | laterArity

def arityName : Arity → String
  | .oneChild => "one-child"
  | .twoChildren => "two-children"
  | .laterArity => "later-arity"

inductive Labels where
  | absent | same | distinctHeld

def labelsName : Labels → String
  | .absent => "labels-absent"
  | .same => "labels-same"
  | .distinctHeld => "labels-distinct-held"

inductive Children where
  | ungenerated | generated

def childrenName : Children → String
  | .ungenerated => "children-ungenerated"
  | .generated => "children-generated"

inductive Return where
  | absent | present

def returnsName : Return → String
  | .absent => "return-absent"
  | .present => "return-present"

inductive Termination where
  | absent | finiteLeaf

def terminationName : Termination → String
  | .absent => "termination-absent"
  | .finiteLeaf => "finite-leaf-termination"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  base : Base
  arity : Arity
  labels : Labels
  children : Children
  returns : Return
  termination : Termination
  extra : Extra

def sourceFields (c : Candidate) : List String := [baseName c.base, arityName c.arity, labelsName c.labels, childrenName c.children, returnsName c.returns, terminationName c.termination, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Grammar proposal has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]
def survivorId : String := "base-included__two-children__labels-distinct-held__children-generated__return-present__finite-leaf-termination__no-extra"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (baseName c.base) "base-included" &&
  SFT.Host.Text.equal (arityName c.arity) "two-children" &&
  SFT.Host.Text.equal (labelsName c.labels) "labels-distinct-held" &&
  SFT.Host.Text.equal (childrenName c.children) "children-generated" &&
  SFT.Host.Text.equal (returnsName c.returns) "return-present" &&
  SFT.Host.Text.equal (terminationName c.termination) "finite-leaf-termination" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (baseName c.base) "base-excluded" then "Without the structural One leaf the recursion has no admitted terminal form." else
  if SFT.Host.Text.equal (arityName c.arity) "one-child" then "One child omits a forced Fold fibre." else
  if SFT.Host.Text.equal (arityName c.arity) "later-arity" then "A later arity imports a nonminimal branching rule." else
  if SFT.Host.Text.equal (labelsName c.labels) "labels-absent" then "Unlabelled edges do not retain Fold distinction." else
  if SFT.Host.Text.equal (labelsName c.labels) "labels-same" then "Identical edge labels collapse the two Fold fibres." else
  if SFT.Host.Text.equal (childrenName c.children) "children-ungenerated" then "Ungenerated children introduce forms outside the dependency grammar." else
  if SFT.Host.Text.equal (returnsName c.returns) "return-absent" then "The node lacks its complete return relation to the parent whole." else
  if SFT.Host.Text.equal (terminationName c.termination) "termination-absent" then "The production admits an uncompleted regress instead of a generated finite form." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "The grammar adds a constructor not forced by One or Fold." else
  "It includes the One leaf and only complete two-child held-labelled returning Fold nodes whose children are recursively generated and finitely terminate."

def generationRule : String := "Generate the complete product of One-base inclusion, recursive child arity, edge-label relation, child provenance, return relation, finite termination and unforced-extra-production presence."
def grammarBoundary : String := "All recursive production-rule shapes for finite forms assembled only from the admitted structural One and minimal Fold."

def candidates : List Candidate :=
  ([Base.excluded,Base.included]).flatMap fun base =>
  ([Arity.oneChild,Arity.twoChildren,Arity.laterArity]).flatMap fun arity =>
  ([Labels.absent,Labels.same,Labels.distinctHeld]).flatMap fun labels =>
  ([Children.ungenerated,Children.generated]).flatMap fun children =>
  ([Return.absent,Return.present]).flatMap fun returns =>
  ([Termination.absent,Termination.finiteLeaf]).flatMap fun termination =>
  ([Extra.noExtra,Extra.hasExtra]).map fun extra =>
  ⟨base,arity,labels,children,returns,termination,extra⟩

def survivor : Candidate := ⟨.included,.twoChildren,.distinctHeld,.generated,.present,.finiteLeaf,.noExtra⟩

theorem generatedCardinality : candidates.length = 288 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk base arity labels children returns termination extra =>
    have hbase : base ∈ [Base.excluded,Base.included] := by
      cases base <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have harity : arity ∈ [Arity.oneChild,Arity.twoChildren,Arity.laterArity] := by
      cases arity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlabels : labels ∈ [Labels.absent,Labels.same,Labels.distinctHeld] := by
      cases labels <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchildren : children ∈ [Children.ungenerated,Children.generated] := by
      cases children <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturns : returns ∈ [Return.absent,Return.present] := by
      cases returns <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htermination : termination ∈ [Termination.absent,Termination.finiteLeaf] := by
      cases termination <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,Extra.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ base _ hbase
    apply CommonRefinement.memFlatMap _ _ arity _ harity
    apply CommonRefinement.memFlatMap _ _ labels _ hlabels
    apply CommonRefinement.memFlatMap _ _ children _ hchildren
    apply CommonRefinement.memFlatMap _ _ returns _ hreturns
    apply CommonRefinement.memFlatMap _ _ termination _ htermination
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk base arity labels children returns termination extra =>
    cases base <;> cases arity <;> cases labels <;> cases children <;> cases returns <;> cases termination <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk base arity labels children returns termination extra =>
    cases base <;> cases arity <;> cases labels <;> cases children <;> cases returns <;> cases termination <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.base = .included ∧ c.arity = .twoChildren ∧ c.labels = .distinctHeld ∧ c.children = .generated ∧ c.returns = .present ∧ c.termination = .finiteLeaf ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk base arity labels children returns termination extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem base_excluded_rejected (c : Candidate) (h : c.base = .excluded) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.base eq
    rw [h] at field
    cases field

theorem arity_oneChild_rejected (c : Candidate) (h : c.arity = .oneChild) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.arity eq
    rw [h] at field
    cases field

theorem arity_laterArity_rejected (c : Candidate) (h : c.arity = .laterArity) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.arity eq
    rw [h] at field
    cases field

theorem labels_absent_rejected (c : Candidate) (h : c.labels = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.labels eq
    rw [h] at field
    cases field

theorem labels_same_rejected (c : Candidate) (h : c.labels = .same) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.labels eq
    rw [h] at field
    cases field

theorem children_ungenerated_rejected (c : Candidate) (h : c.children = .ungenerated) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.children eq
    rw [h] at field
    cases field

theorem returns_absent_rejected (c : Candidate) (h : c.returns = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.returns eq
    rw [h] at field
    cases field

theorem termination_absent_rejected (c : Candidate) (h : c.termination = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.termination eq
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

end SFT.Foundation.FormGrammar
