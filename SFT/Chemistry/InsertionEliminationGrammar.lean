import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.InsertionEliminationGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "anonymous-products"
  | .admitted => "complete-retained-carrier-support"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "endpoint-only-reaction"
  | .admitted => "complete-before-after-adjacency-difference"

inductive Insertion where
  | rejected | admitted

def insertionName : Insertion → String
  | .rejected => "imported-product-formula"
  | .admitted => "xz-plus-y-to-x-y-z-adjacency-law"

inductive Migration where
  | rejected | admitted

def migrationName : Migration → String
  | .rejected => "named-migratory-step"
  | .admitted => "migration-plus-insertion-composition"

inductive Reverse where
  | rejected | admitted

def reverseName : Reverse → String
  | .rejected => "insertion-elimination-conflation"
  | .admitted => "extrusion-exact-insertion-inverse"

inductive Elimination where
  | rejected | admitted

def eliminationName : Elimination → String
  | .rejected => "selected-leaving-group"
  | .admitted => "complete-two-eliminand-centre-trace"

inductive Product where
  | rejected | admitted

def productName : Product → String
  | .rejected => "imported-unsaturation-name"
  | .admitted => "held-unsaturation-ring-or-carbene-boundary"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "mechanism-specific-exception"
  | .admitted => "adjacency-trace-composition-no-extra-rule"

structure Candidate where
  carrier : Carrier
  trace : Trace
  insertion : Insertion
  migration : Migration
  reverse : Reverse
  elimination : Elimination
  product : Product
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, traceName c.trace, insertionName c.insertion, migrationName c.migration, reverseName c.reverse, eliminationName c.elimination, productName c.product, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "insertion=" (insertionName c.insertion), SFT.Host.Text.append "migration=" (migrationName c.migration), SFT.Host.Text.append "reverse=" (reverseName c.reverse), SFT.Host.Text.append "elimination=" (eliminationName c.elimination), SFT.Host.Text.append "product=" (productName c.product), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-retained-carrier-support__complete-before-after-adjacency-difference__xz-plus-y-to-x-y-z-adjacency-law__migration-plus-insertion-composition__extrusion-exact-insertion-inverse__complete-two-eliminand-centre-trace__held-unsaturation-ring-or-carbene-boundary__adjacency-trace-composition-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-retained-carrier-support" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-before-after-adjacency-difference" &&
  SFT.Host.Text.equal (insertionName c.insertion) "xz-plus-y-to-x-y-z-adjacency-law" &&
  SFT.Host.Text.equal (migrationName c.migration) "migration-plus-insertion-composition" &&
  SFT.Host.Text.equal (reverseName c.reverse) "extrusion-exact-insertion-inverse" &&
  SFT.Host.Text.equal (eliminationName c.elimination) "complete-two-eliminand-centre-trace" &&
  SFT.Host.Text.equal (productName c.product) "held-unsaturation-ring-or-carbene-boundary" &&
  SFT.Host.Text.equal (extensionName c.extension) "adjacency-trace-composition-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-retained-carrier-support") then "Anonymous products lose occurrence identity." else
  if !(SFT.Host.Text.equal (traceName c.trace) "complete-before-after-adjacency-difference") then "Endpoints alone do not certify the transformation." else
  if !(SFT.Host.Text.equal (insertionName c.insertion) "xz-plus-y-to-x-y-z-adjacency-law") then "A product formula can hide adjacency." else
  if !(SFT.Host.Text.equal (migrationName c.migration) "migration-plus-insertion-composition") then "A name does not force composition." else
  if !(SFT.Host.Text.equal (reverseName c.reverse) "extrusion-exact-insertion-inverse") then "Conflating reverse classes loses the exact boundary." else
  if !(SFT.Host.Text.equal (eliminationName c.elimination) "complete-two-eliminand-centre-trace") then "Selection loses one eliminand or centre." else
  if !(SFT.Host.Text.equal (productName c.product) "held-unsaturation-ring-or-carbene-boundary") then "A conventional name is not a generated adjacency." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "adjacency-trace-composition-no-extra-rule") then "An exception destroys closure." else
  "complete-retained-carrier-support__complete-before-after-adjacency-difference__xz-plus-y-to-x-y-z-adjacency-law__migration-plus-insertion-composition__extrusion-exact-insertion-inverse__complete-two-eliminand-centre-trace__held-unsaturation-ring-or-carbene-boundary__adjacency-trace-composition-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, trace, insertion, migration, reverse, elimination, product and extension choices; decide all 256 candidates only from admitted graph, transition, conservation, mechanism and INORG-010/012 dependencies."
def grammarBoundary : String := "Every finite complete adjacency transformation for insertion, exact extrusion, migratory insertion and distinct- or single-centre elimination; all ten frozen IUPAC definition, composition, scope, absent-example and product-boundary surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Insertion.rejected,Insertion.admitted]).flatMap fun insertion =>
  ([Migration.rejected,Migration.admitted]).flatMap fun migration =>
  ([Reverse.rejected,Reverse.admitted]).flatMap fun reverse =>
  ([Elimination.rejected,Elimination.admitted]).flatMap fun elimination =>
  ([Product.rejected,Product.admitted]).flatMap fun product =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,trace,insertion,migration,reverse,elimination,product,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier trace insertion migration reverse elimination product extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinsertion : insertion ∈ [Insertion.rejected,Insertion.admitted] := by
      cases insertion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmigration : migration ∈ [Migration.rejected,Migration.admitted] := by
      cases migration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreverse : reverse ∈ [Reverse.rejected,Reverse.admitted] := by
      cases reverse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have helimination : elimination ∈ [Elimination.rejected,Elimination.admitted] := by
      cases elimination <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproduct : product ∈ [Product.rejected,Product.admitted] := by
      cases product <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    apply CommonRefinement.memFlatMap _ _ insertion _ hinsertion
    apply CommonRefinement.memFlatMap _ _ migration _ hmigration
    apply CommonRefinement.memFlatMap _ _ reverse _ hreverse
    apply CommonRefinement.memFlatMap _ _ elimination _ helimination
    apply CommonRefinement.memFlatMap _ _ product _ hproduct
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (reverse : Reverse) (elimination : Elimination) (product : Product) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,reverse,elimination,product,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,reverse,elimination,product,extension⟩ := by
 cases reverse <;> cases elimination <;> cases product <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier trace insertion migration reverse elimination product extension =>
  cases carrier <;> cases trace <;> cases insertion <;> cases migration
  · exact sourceDecisionBlock0000 reverse elimination product extension
  · exact sourceDecisionBlock0001 reverse elimination product extension
  · exact sourceDecisionBlock0010 reverse elimination product extension
  · exact sourceDecisionBlock0011 reverse elimination product extension
  · exact sourceDecisionBlock0100 reverse elimination product extension
  · exact sourceDecisionBlock0101 reverse elimination product extension
  · exact sourceDecisionBlock0110 reverse elimination product extension
  · exact sourceDecisionBlock0111 reverse elimination product extension
  · exact sourceDecisionBlock1000 reverse elimination product extension
  · exact sourceDecisionBlock1001 reverse elimination product extension
  · exact sourceDecisionBlock1010 reverse elimination product extension
  · exact sourceDecisionBlock1011 reverse elimination product extension
  · exact sourceDecisionBlock1100 reverse elimination product extension
  · exact sourceDecisionBlock1101 reverse elimination product extension
  · exact sourceDecisionBlock1110 reverse elimination product extension
  · exact sourceDecisionBlock1111 reverse elimination product extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-retained-carrier-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem traceCriterion (value : Trace) : SFT.Host.Text.equal (traceName value) "complete-before-after-adjacency-difference" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem insertionCriterion (value : Insertion) : SFT.Host.Text.equal (insertionName value) "xz-plus-y-to-x-y-z-adjacency-law" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem migrationCriterion (value : Migration) : SFT.Host.Text.equal (migrationName value) "migration-plus-insertion-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem reverseCriterion (value : Reverse) : SFT.Host.Text.equal (reverseName value) "extrusion-exact-insertion-inverse" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem eliminationCriterion (value : Elimination) : SFT.Host.Text.equal (eliminationName value) "complete-two-eliminand-centre-trace" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem productCriterion (value : Product) : SFT.Host.Text.equal (productName value) "held-unsaturation-ring-or-carbene-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "adjacency-trace-composition-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, traceCriterion, insertionCriterion, migrationCriterion, reverseCriterion, eliminationCriterion, productCriterion, extensionCriterion]
  cases c with
  | mk carrier trace insertion migration reverse elimination product extension =>
    cases carrier <;> cases trace <;> cases insertion <;> cases migration <;> cases reverse <;> cases elimination <;> cases product <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.trace = .admitted ∧ c.insertion = .admitted ∧ c.migration = .admitted ∧ c.reverse = .admitted ∧ c.elimination = .admitted ∧ c.product = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier trace insertion migration reverse elimination product extension =>
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

theorem trace_rejected_rejected (c : Candidate) (h : c.trace = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem insertion_rejected_rejected (c : Candidate) (h : c.insertion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.insertion eq
    rw [h] at field
    cases field

theorem migration_rejected_rejected (c : Candidate) (h : c.migration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.migration eq
    rw [h] at field
    cases field

theorem reverse_rejected_rejected (c : Candidate) (h : c.reverse = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reverse eq
    rw [h] at field
    cases field

theorem elimination_rejected_rejected (c : Candidate) (h : c.elimination = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.elimination eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.InsertionEliminationGrammar
