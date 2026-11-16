import SFT.Physics.HeliumIsotope
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.HeliumIsotopeGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Family where
  | rejected | admitted

def familyName : Family → String
  | .rejected => "measured-decimal-called-family-law"
  | .admitted => "admitted-quarter-baryon-family"

inductive Constituents where
  | rejected | admitted

def constituentsName : Constituents → String
  | .rejected => "selected-arity"
  | .admitted => "helium-four-complete-arity"

inductive Subwords where
  | rejected | admitted

def subwordsName : Subwords → String
  | .rejected => "selected-proper-subset"
  | .admitted => "all-fifteen-nonempty-subwords"

inductive Product where
  | rejected | admitted

def productName : Product → String
  | .rejected => "partial-incidence-ledger"
  | .admitted => "complete-four-by-fifteen-product"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "empty-or-multiple-composite-identities"
  | .admitted => "one-global-composite-identity"

inductive Conversion where
  | rejected | admitted

def conversionName : Conversion → String
  | .rejected => "fitted-isotope-correction"
  | .admitted => "fifty-nine-of-sixty-isotope-cells"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "quarter-rubber-stamp-or-decimal-copy"
  | .admitted => "fifty-nine-over-two-forty-and-one-eighty-one-over-two-forty"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "target-readable-candidate-selection"
  | .admitted => "target-closed-until-formal-seal"

structure Candidate where
  family : Family
  constituents : Constituents
  subwords : Subwords
  product : Product
  identity : Identity
  conversion : Conversion
  partition : Partition
  target : Target

def sourceFields (c : Candidate) : List String := [familyName c.family, constituentsName c.constituents, subwordsName c.subwords, productName c.product, identityName c.identity, conversionName c.conversion, partitionName c.partition, targetName c.target]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "family=" (familyName c.family), SFT.Host.Text.append "constituents=" (constituentsName c.constituents), SFT.Host.Text.append "subwords=" (subwordsName c.subwords), SFT.Host.Text.append "product=" (productName c.product), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "conversion=" (conversionName c.conversion), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "target=" (targetName c.target)]
def survivorId : String := "admitted-quarter-baryon-family__helium-four-complete-arity__all-fifteen-nonempty-subwords__complete-four-by-fifteen-product__one-global-composite-identity__fifty-nine-of-sixty-isotope-cells__fifty-nine-over-two-forty-and-one-eighty-one-over-two-forty__target-closed-until-formal-seal"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (familyName c.family) "admitted-quarter-baryon-family" &&
  SFT.Host.Text.equal (constituentsName c.constituents) "helium-four-complete-arity" &&
  SFT.Host.Text.equal (subwordsName c.subwords) "all-fifteen-nonempty-subwords" &&
  SFT.Host.Text.equal (productName c.product) "complete-four-by-fifteen-product" &&
  SFT.Host.Text.equal (identityName c.identity) "one-global-composite-identity" &&
  SFT.Host.Text.equal (conversionName c.conversion) "fifty-nine-of-sixty-isotope-cells" &&
  SFT.Host.Text.equal (partitionName c.partition) "fifty-nine-over-two-forty-and-one-eighty-one-over-two-forty" &&
  SFT.Host.Text.equal (targetName c.target) "target-closed-until-formal-seal"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (familyName c.family) "admitted-quarter-baryon-family") then "A measured decimal cannot select the analytic predecessor." else
  if !(SFT.Host.Text.equal (constituentsName c.constituents) "helium-four-complete-arity") then "A selected isotope arity is an extra premise." else
  if !(SFT.Host.Text.equal (subwordsName c.subwords) "all-fifteen-nonempty-subwords") then "A selected subset erases a physical composition channel." else
  if !(SFT.Host.Text.equal (productName c.product) "complete-four-by-fifteen-product") then "A partial ledger breaks permutation completeness." else
  if !(SFT.Host.Text.equal (identityName c.identity) "one-global-composite-identity") then "No identity leaves the labels unbound; multiple identities add an ungenerated split." else
  if !(SFT.Host.Text.equal (conversionName c.conversion) "fifty-nine-of-sixty-isotope-cells") then "A fitted correction reads the measurement." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "fifty-nine-over-two-forty-and-one-eighty-one-over-two-forty") then "Neither the analytic quarter nor a copied decimal is the completed isotope partition." else
  if !(SFT.Host.Text.equal (targetName c.target) "target-closed-until-formal-seal") then "Target access could manufacture a correction." else
  "The complete four-position by fifteen-nonempty-subword capture ledger has sixty cells and exactly one collective composite-identity record. The unique physical isotope conversion is therefore 59/60. Composed with the admitted analytic helium-family share One/four, this forces primordial physical helium-isotope share 59/240 and complementary hydrogen-family share 181/240, closing exactly to the One."

def generationRule : String := "Generate the complete product of analytic-family, constituent, subword, capture-product, composite-identity, isotope-conversion, physical-partition and target-boundary forms."
def grammarBoundary : String := "The admitted analytic helium family; exactly four helium-four constituent positions; every nonempty subword of those positions; their complete incidence product; the single global composite identity; exact positive rational partitions; and no measurement in candidate selection."

def candidates : List Candidate :=
  ([Family.rejected,Family.admitted]).flatMap fun family =>
  ([Constituents.rejected,Constituents.admitted]).flatMap fun constituents =>
  ([Subwords.rejected,Subwords.admitted]).flatMap fun subwords =>
  ([Product.rejected,Product.admitted]).flatMap fun product =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Conversion.rejected,Conversion.admitted]).flatMap fun conversion =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Target.rejected,Target.admitted]).map fun target =>
  ⟨family,constituents,subwords,product,identity,conversion,partition,target⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk family constituents subwords product identity conversion partition target =>
    have hfamily : family ∈ [Family.rejected,Family.admitted] := by
      cases family <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstituents : constituents ∈ [Constituents.rejected,Constituents.admitted] := by
      cases constituents <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsubwords : subwords ∈ [Subwords.rejected,Subwords.admitted] := by
      cases subwords <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproduct : product ∈ [Product.rejected,Product.admitted] := by
      cases product <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconversion : conversion ∈ [Conversion.rejected,Conversion.admitted] := by
      cases conversion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ family _ hfamily
    apply CommonRefinement.memFlatMap _ _ constituents _ hconstituents
    apply CommonRefinement.memFlatMap _ _ subwords _ hsubwords
    apply CommonRefinement.memFlatMap _ _ product _ hproduct
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ conversion _ hconversion
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    exact Count.TraceDerivation.memMap _ target _ htarget

end SFT.Physics.HeliumIsotopeGrammar
