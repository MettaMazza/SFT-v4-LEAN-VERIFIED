import SFT.Physics.ElectroweakTerminalRatio
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ElectroweakTerminalGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-measured-number"
  | .admitted => "admitted-lower-law-carrier"

inductive Terminal where
  | rejected | admitted

def terminalName : Terminal → String
  | .rejected => "selected-intermediate-stage"
  | .admitted => "complete-promotion-termination"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "free-scale-support"
  | .admitted => "complete-binary-terminal-support"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "free-running-level-or-imported-renormalization"
  | .admitted => "level-thirteen-charged-over-four-neutral-pairs-plus-alpha-over-seventeen"

inductive Correction where
  | rejected | admitted

def correctionName : Correction → String
  | .rejected => "fitted-additive-offset"
  | .admitted => "single-typed-terminal-alpha-transport"

inductive Sign where
  | rejected | admitted

def signName : Sign → String
  | .rejected => "target-selected-orientation"
  | .admitted => "orientation-fixed-by-share-or-retention"

inductive Enumeration where
  | rejected | admitted

def enumerationName : Enumeration → String
  | .rejected => "selected-neighbourhood"
  | .admitted => "complete-registered-product"

inductive Minimality where
  | rejected | admitted

def minimalityName : Minimality → String
  | .rejected => "successor-without-lower-controls"
  | .admitted => "bare-and-intermediate-forms-preserved"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-visible-before-seal"
  | .admitted => "exact-result-sealed-before-target-release"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  terminal : Terminal
  support : Support
  relation : Relation
  correction : Correction
  sign : Sign
  enumeration : Enumeration
  minimality : Minimality
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, terminalName c.terminal, supportName c.support, relationName c.relation, correctionName c.correction, signName c.sign, enumerationName c.enumeration, minimalityName c.minimality, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "terminal=" (terminalName c.terminal), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "correction=" (correctionName c.correction), SFT.Host.Text.append "sign=" (signName c.sign), SFT.Host.Text.append "enumeration=" (enumerationName c.enumeration), SFT.Host.Text.append "minimality=" (minimalityName c.minimality), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "admitted-lower-law-carrier__complete-promotion-termination__complete-binary-terminal-support__level-thirteen-charged-over-four-neutral-pairs-plus-alpha-over-seventeen__single-typed-terminal-alpha-transport__orientation-fixed-by-share-or-retention__complete-registered-product__bare-and-intermediate-forms-preserved__exact-result-sealed-before-target-release__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "admitted-lower-law-carrier" &&
  SFT.Host.Text.equal (terminalName c.terminal) "complete-promotion-termination" &&
  SFT.Host.Text.equal (supportName c.support) "complete-binary-terminal-support" &&
  SFT.Host.Text.equal (relationName c.relation) "level-thirteen-charged-over-four-neutral-pairs-plus-alpha-over-seventeen" &&
  SFT.Host.Text.equal (correctionName c.correction) "single-typed-terminal-alpha-transport" &&
  SFT.Host.Text.equal (signName c.sign) "orientation-fixed-by-share-or-retention" &&
  SFT.Host.Text.equal (enumerationName c.enumeration) "complete-registered-product" &&
  SFT.Host.Text.equal (minimalityName c.minimality) "bare-and-intermediate-forms-preserved" &&
  SFT.Host.Text.equal (measurementName c.measurement) "exact-result-sealed-before-target-release" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "admitted-lower-law-carrier") then "A measured number has no forward Fold dependency trace." else
  if !(SFT.Host.Text.equal (terminalName c.terminal) "complete-promotion-termination") then "An intermediate stage chosen for agreement is a fit." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-binary-terminal-support") then "A free scale is a parameter." else
  if !(SFT.Host.Text.equal (relationName c.relation) "level-thirteen-charged-over-four-neutral-pairs-plus-alpha-over-seventeen") then "The alternative loses a required carrier or adds an unforced operation." else
  if !(SFT.Host.Text.equal (correctionName c.correction) "single-typed-terminal-alpha-transport") then "A fitted offset reads the target." else
  if !(SFT.Host.Text.equal (signName c.sign) "orientation-fixed-by-share-or-retention") then "A target-selected sign is not structural." else
  if !(SFT.Host.Text.equal (enumerationName c.enumeration) "complete-registered-product") then "A selected neighbourhood cannot prove uniqueness." else
  if !(SFT.Host.Text.equal (minimalityName c.minimality) "bare-and-intermediate-forms-preserved") then "A terminal answer alone hides whether the lower form was necessary." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "exact-result-sealed-before-target-release") then "That reverses empirical direction." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An extra term is a free parameter." else
  "The terminal on-shell electroweak share is sin-squared = 1930922298157999/8642477221479757 and its exact One-complement is cos-squared = 6711554923321758/8642477221479757."

def generationRule : String := "Generate the complete ten-axis product of lower carrier, terminal stage, support, running relation, self-coupling transport, orientation, enumeration, minimality, measurement direction and extension."
def grammarBoundary : String := "All type-correct exact channel shares formed from the admitted bare weak fibre, the complete terminal alpha promotion object, its complete binary support, held generator directions and one returning terminal self-coupling."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Terminal.rejected,Terminal.admitted]).flatMap fun terminal =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Correction.rejected,Correction.admitted]).flatMap fun correction =>
  ([Sign.rejected,Sign.admitted]).flatMap fun sign =>
  ([Enumeration.rejected,Enumeration.admitted]).flatMap fun enumeration =>
  ([Minimality.rejected,Minimality.admitted]).flatMap fun minimality =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,terminal,support,relation,correction,sign,enumeration,minimality,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier terminal support relation correction sign enumeration minimality measurement extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterminal : terminal ∈ [Terminal.rejected,Terminal.admitted] := by
      cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcorrection : correction ∈ [Correction.rejected,Correction.admitted] := by
      cases correction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsign : sign ∈ [Sign.rejected,Sign.admitted] := by
      cases sign <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henumeration : enumeration ∈ [Enumeration.rejected,Enumeration.admitted] := by
      cases enumeration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hminimality : minimality ∈ [Minimality.rejected,Minimality.admitted] := by
      cases minimality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ terminal _ hterminal
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ correction _ hcorrection
    apply CommonRefinement.memFlatMap _ _ sign _ hsign
    apply CommonRefinement.memFlatMap _ _ enumeration _ henumeration
    apply CommonRefinement.memFlatMap _ _ minimality _ hminimality
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.ElectroweakTerminalGrammar
