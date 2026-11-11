import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SelectivityGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Products where
  | rejected | admitted

def productsName : Products → String
  | .rejected => "one-product-presupposed"
  | .admitted => "all-accessible-products-generated"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "yield-number-imported"
  | .admitted => "complete-product-recurrence-order"

inductive Selection where
  | rejected | admitted

def selectionName : Selection → String
  | .rejected => "all-products-equated"
  | .admitted => "one-product-favored"

inductive Ties where
  | rejected | admitted

def tiesName : Ties → String
  | .rejected => "arbitrary-tie-break"
  | .admitted => "cofavored-class-at-tie"

inductive Reactant where
  | rejected | admitted

def reactantName : Reactant → String
  | .rejected => "consumption-erased"
  | .admitted => "reactant-consumption-held"

inductive Conditions where
  | rejected | admitted

def conditionsName : Conditions → String
  | .rejected => "universal-preference"
  | .admitted => "condition-and-method-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-name-only"
  | .admitted => "complete-competing-product-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-selectivity-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  products : Products
  comparison : Comparison
  selection : Selection
  ties : Ties
  reactant : Reactant
  conditions : Conditions
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [productsName c.products, comparisonName c.comparison, selectionName c.selection, tiesName c.ties, reactantName c.reactant, conditionsName c.conditions, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "products=" (productsName c.products), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "selection=" (selectionName c.selection), SFT.Host.Text.append "ties=" (tiesName c.ties), SFT.Host.Text.append "reactant=" (reactantName c.reactant), SFT.Host.Text.append "conditions=" (conditionsName c.conditions), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "all-accessible-products-generated__complete-product-recurrence-order__one-product-favored__cofavored-class-at-tie__reactant-consumption-held__condition-and-method-bounded__complete-competing-product-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (productsName c.products) "all-accessible-products-generated" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "complete-product-recurrence-order" &&
  SFT.Host.Text.equal (selectionName c.selection) "one-product-favored" &&
  SFT.Host.Text.equal (tiesName c.ties) "cofavored-class-at-tie" &&
  SFT.Host.Text.equal (reactantName c.reactant) "reactant-consumption-held" &&
  SFT.Host.Text.equal (conditionsName c.conditions) "condition-and-method-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "complete-competing-product-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (productsName c.products) "all-accessible-products-generated") then "Alternatives were not generated." else
  if !(SFT.Host.Text.equal (comparisonName c.comparison) "complete-product-recurrence-order") then "A measurement selects the answer." else
  if !(SFT.Host.Text.equal (selectionName c.selection) "one-product-favored") then "No preference is represented." else
  if !(SFT.Host.Text.equal (tiesName c.ties) "cofavored-class-at-tie") then "Equal support cannot force identity." else
  if !(SFT.Host.Text.equal (reactantName c.reactant) "reactant-consumption-held") then "Selectivity lacks a denominator." else
  if !(SFT.Host.Text.equal (conditionsName c.conditions) "condition-and-method-bounded") then "Selectivity can change with context." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-competing-product-trace") then "Competing products are hidden." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fit can choose any product." else
  "all-accessible-products-generated__complete-product-recurrence-order__one-product-favored__cofavored-class-at-tie__reactant-consumption-held"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite complete product census for one retained catalytic input boundary with exact positive recurrence counts and all ties retained."

def candidates : List Candidate :=
  ([Products.rejected,Products.admitted]).flatMap fun products =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Selection.rejected,Selection.admitted]).flatMap fun selection =>
  ([Ties.rejected,Ties.admitted]).flatMap fun ties =>
  ([Reactant.rejected,Reactant.admitted]).flatMap fun reactant =>
  ([Conditions.rejected,Conditions.admitted]).flatMap fun conditions =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨products,comparison,selection,ties,reactant,conditions,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk products comparison selection ties reactant conditions record extra =>
    have hproducts : products ∈ [Products.rejected,Products.admitted] := by
      cases products <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselection : selection ∈ [Selection.rejected,Selection.admitted] := by
      cases selection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hties : ties ∈ [Ties.rejected,Ties.admitted] := by
      cases ties <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreactant : reactant ∈ [Reactant.rejected,Reactant.admitted] := by
      cases reactant <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconditions : conditions ∈ [Conditions.rejected,Conditions.admitted] := by
      cases conditions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ products _ hproducts
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    apply CommonRefinement.memFlatMap _ _ selection _ hselection
    apply CommonRefinement.memFlatMap _ _ ties _ hties
    apply CommonRefinement.memFlatMap _ _ reactant _ hreactant
    apply CommonRefinement.memFlatMap _ _ conditions _ hconditions
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk products comparison selection ties reactant conditions record extra =>
    cases products <;> cases comparison <;> cases selection <;> cases ties <;> cases reactant <;> cases conditions <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk products comparison selection ties reactant conditions record extra =>
    cases products <;> cases comparison <;> cases selection <;> cases ties <;> cases reactant <;> cases conditions <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.products = .admitted ∧ c.comparison = .admitted ∧ c.selection = .admitted ∧ c.ties = .admitted ∧ c.reactant = .admitted ∧ c.conditions = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk products comparison selection ties reactant conditions record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem products_rejected_rejected (c : Candidate) (h : c.products = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.products eq
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

theorem selection_rejected_rejected (c : Candidate) (h : c.selection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selection eq
    rw [h] at field
    cases field

theorem ties_rejected_rejected (c : Candidate) (h : c.ties = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ties eq
    rw [h] at field
    cases field

theorem reactant_rejected_rejected (c : Candidate) (h : c.reactant = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reactant eq
    rw [h] at field
    cases field

theorem conditions_rejected_rejected (c : Candidate) (h : c.conditions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.conditions eq
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

end SFT.Chemistry.SelectivityGrammar
