import SFT.Mathematics.ExactTracePairing
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.ExactArithmeticGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Coverage where
  | rejected | admitted

def coverageName : Coverage → String
  | .rejected => "partial-trace"
  | .admitted => "complete-trace"

inductive Junction where
  | rejected | admitted

def junctionName : Junction → String
  | .rejected => "overlap-merge"
  | .admitted => "disjoint-junction"

inductive Product where
  | rejected | admitted

def productName : Product → String
  | .rejected => "repeated-unlabelled"
  | .admitted => "pair-cell-refinement"

inductive Quotient where
  | rejected | admitted

def quotientName : Quotient → String
  | .rejected => "rounded-measure"
  | .admitted => "common-refinement-pairing"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "borrowed-scalar-order"
  | .admitted => "complete-trace-pairing"

inductive Difference where
  | rejected | admitted

def differenceName : Difference → String
  | .rejected => "signed-magnitude"
  | .admitted => "held-oriented-remainder"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "bounded-answer-table"
  | .admitted => "base-successor-induction"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "has-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  coverage : Coverage
  junction : Junction
  product : Product
  quotient : Quotient
  comparison : Comparison
  difference : Difference
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [coverageName c.coverage, junctionName c.junction, productName c.product, quotientName c.quotient, comparisonName c.comparison, differenceName c.difference, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "coverage=" (coverageName c.coverage), SFT.Host.Text.append "junction=" (junctionName c.junction), SFT.Host.Text.append "product=" (productName c.product), SFT.Host.Text.append "quotient=" (quotientName c.quotient), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "difference=" (differenceName c.difference), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-trace__disjoint-junction__pair-cell-refinement__common-refinement-pairing__complete-trace-pairing__held-oriented-remainder__base-successor-induction__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (coverageName c.coverage) "complete-trace" &&
  SFT.Host.Text.equal (junctionName c.junction) "disjoint-junction" &&
  SFT.Host.Text.equal (productName c.product) "pair-cell-refinement" &&
  SFT.Host.Text.equal (quotientName c.quotient) "common-refinement-pairing" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "complete-trace-pairing" &&
  SFT.Host.Text.equal (differenceName c.difference) "held-oriented-remainder" &&
  SFT.Host.Text.equal (generalityName c.generality) "base-successor-induction" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (coverageName c.coverage) "complete-trace") then "A partial trace omits an admitted generated occurrence." else
  if !(SFT.Host.Text.equal (junctionName c.junction) "disjoint-junction") then "Overlap repeats a shared occurrence and loses disjoint provenance." else
  if !(SFT.Host.Text.equal (productName c.product) "pair-cell-refinement") then "Unlabelled repetition erases the two source coordinates." else
  if !(SFT.Host.Text.equal (quotientName c.quotient) "common-refinement-pairing") then "A rounded or decimal value is measured rather than exact derivational evidence." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "complete-trace-pairing") then "A borrowed scalar order imports the answer-producing number model." else
  if !(SFT.Host.Text.equal (differenceName c.difference) "held-oriented-remainder") then "A signed magnitude installs forbidden negative quantity." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "base-successor-induction") then "A finite answer table has no depth-independent arithmetic certificate." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "An extra scale, constant or field is not supplied by the dependencies." else
  "The exact arithmetic kernel is complete positive-trace coverage with disjoint junction, pair-cell product, common-refinement quotient, complete pairing comparison, held-oriented remainder, base/successor generality and no extra rule."

def generationRule : String := "Generate the complete product of trace coverage, junction, pair-cell product, exact quotient, comparison, remainder orientation, finite generality and extra-rule status."
def grammarBoundary : String := "All arithmetic kernels constructible from admitted positive finite traces, exact held/whole parts, common refinement, canonical form identity and no imported scalar field."

def candidates : List Candidate :=
  ([Coverage.rejected,Coverage.admitted]).flatMap fun coverage =>
  ([Junction.rejected,Junction.admitted]).flatMap fun junction =>
  ([Product.rejected,Product.admitted]).flatMap fun product =>
  ([Quotient.rejected,Quotient.admitted]).flatMap fun quotient =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Difference.rejected,Difference.admitted]).flatMap fun difference =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨coverage,junction,product,quotient,comparison,difference,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk coverage junction product quotient comparison difference generality addition =>
    have hcoverage : coverage ∈ [Coverage.rejected,Coverage.admitted] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjunction : junction ∈ [Junction.rejected,Junction.admitted] := by
      cases junction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproduct : product ∈ [Product.rejected,Product.admitted] := by
      cases product <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquotient : quotient ∈ [Quotient.rejected,Quotient.admitted] := by
      cases quotient <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdifference : difference ∈ [Difference.rejected,Difference.admitted] := by
      cases difference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ junction _ hjunction
    apply CommonRefinement.memFlatMap _ _ product _ hproduct
    apply CommonRefinement.memFlatMap _ _ quotient _ hquotient
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ difference _ hdifference
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk coverage junction product quotient comparison difference generality addition =>
    cases coverage <;> cases junction <;> cases product <;> cases quotient <;> cases comparison <;> cases difference <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk coverage junction product quotient comparison difference generality addition =>
    cases coverage <;> cases junction <;> cases product <;> cases quotient <;> cases comparison <;> cases difference <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.coverage = .admitted ∧ c.junction = .admitted ∧ c.product = .admitted ∧ c.quotient = .admitted ∧ c.comparison = .admitted ∧ c.difference = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk coverage junction product quotient comparison difference generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem coverage_rejected_rejected (c : Candidate) (h : c.coverage = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem junction_rejected_rejected (c : Candidate) (h : c.junction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.junction eq
    rw [h] at field
    cases field

theorem product_rejected_rejected (c : Candidate) (h : c.product = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.product eq
    rw [h] at field
    cases field

theorem quotient_rejected_rejected (c : Candidate) (h : c.quotient = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.quotient eq
    rw [h] at field
    cases field

theorem comparison_rejected_rejected (c : Candidate) (h : c.comparison = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.comparison eq
    rw [h] at field
    cases field

theorem difference_rejected_rejected (c : Candidate) (h : c.difference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.difference eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.ExactArithmeticGrammar
