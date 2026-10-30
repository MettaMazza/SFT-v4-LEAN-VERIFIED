import SFT.Physics.PrimeSectorLadder
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ForceLadderGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "borrowed-physical-label"
  | .admitted => "generated-exact-carrier"

inductive Dependency where
  | rejected | admitted

def dependencyName : Dependency → String
  | .rejected => "asserted-input-values"
  | .admitted => "admitted-dependency-trace"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "composite-or-unbounded-sector-ladder"
  | .admitted => "prime-through-cover-ceiling-and-p-squared-less-One"

inductive Enumeration where
  | rejected | admitted

def enumerationName : Enumeration → String
  | .rejected => "selected-neighbourhood"
  | .admitted => "complete-registered-product"

inductive Minimality where
  | rejected | admitted

def minimalityName : Minimality → String
  | .rejected => "survivor-without-predecessor-controls"
  | .admitted => "all-predecessor-forms-rejected"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-visible-before-seal"
  | .admitted => "derivation-sealed-before-comparison"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "answer-only-record"
  | .admitted => "complete-trace-controls-and-census"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  dependency : Dependency
  relation : Relation
  enumeration : Enumeration
  minimality : Minimality
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, dependencyName c.dependency, relationName c.relation, enumerationName c.enumeration, minimalityName c.minimality, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "dependency=" (dependencyName c.dependency), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "enumeration=" (enumerationName c.enumeration), SFT.Host.Text.append "minimality=" (minimalityName c.minimality), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "generated-exact-carrier__admitted-dependency-trace__prime-through-cover-ceiling-and-p-squared-less-One__complete-registered-product__all-predecessor-forms-rejected__derivation-sealed-before-comparison__complete-trace-controls-and-census__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "generated-exact-carrier" &&
  SFT.Host.Text.equal (dependencyName c.dependency) "admitted-dependency-trace" &&
  SFT.Host.Text.equal (relationName c.relation) "prime-through-cover-ceiling-and-p-squared-less-One" &&
  SFT.Host.Text.equal (enumerationName c.enumeration) "complete-registered-product" &&
  SFT.Host.Text.equal (minimalityName c.minimality) "all-predecessor-forms-rejected" &&
  SFT.Host.Text.equal (measurementName c.measurement) "derivation-sealed-before-comparison" &&
  SFT.Host.Text.equal (recordName c.record) "complete-trace-controls-and-census" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "generated-exact-carrier") then "A borrowed label has no Fold trace." else
  if !(SFT.Host.Text.equal (dependencyName c.dependency) "admitted-dependency-trace") then "Asserted values are parameters." else
  if !(SFT.Host.Text.equal (relationName c.relation) "prime-through-cover-ceiling-and-p-squared-less-One") then "The alternative loses a required distinction or adds an unforced rule." else
  if !(SFT.Host.Text.equal (enumerationName c.enumeration) "complete-registered-product") then "A selected neighbourhood cannot prove uniqueness." else
  if !(SFT.Host.Text.equal (minimalityName c.minimality) "all-predecessor-forms-rejected") then "A survivor alone does not exclude a shorter form." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "derivation-sealed-before-comparison") then "Target access reverses empirical direction." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-trace-controls-and-census") then "An answer alone cannot reproduce the derivation." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An extra selector is a parameter." else
  "The complete prime-sector ladder is (2,3,5,7), with couplings (1/2,2/3,4/5,6/7), mediator counts (3,8,24,48), and first excluded prime 11."

def generationRule : String := "Generate the complete eight-axis product of sector carrier, dependencies, prime-ceiling relation, enumeration, minimality, measurement direction, evidence and extension forms."
def grammarBoundary : String := "Every positive count through the independently generated upper cover depth, complete proper-divisor tests, complete sector pair cells and the unique colourless return."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Dependency.rejected,Dependency.admitted]).flatMap fun dependency =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Enumeration.rejected,Enumeration.admitted]).flatMap fun enumeration =>
  ([Minimality.rejected,Minimality.admitted]).flatMap fun minimality =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,dependency,relation,enumeration,minimality,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier dependency relation enumeration minimality measurement record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdependency : dependency ∈ [Dependency.rejected,Dependency.admitted] := by
      cases dependency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henumeration : enumeration ∈ [Enumeration.rejected,Enumeration.admitted] := by
      cases enumeration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hminimality : minimality ∈ [Minimality.rejected,Minimality.admitted] := by
      cases minimality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ dependency _ hdependency
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ enumeration _ henumeration
    apply CommonRefinement.memFlatMap _ _ minimality _ hminimality
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.ForceLadderGrammar
