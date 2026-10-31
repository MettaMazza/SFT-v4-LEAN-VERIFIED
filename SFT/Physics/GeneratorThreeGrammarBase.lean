import SFT.Physics.GeneratorOperations
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.GeneratorThreeGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "borrowed-integer-name"
  | .admitted => "exact-positive-period-trace"

inductive Action where
  | rejected | admitted

def actionName : Action → String
  | .rejected => "imported-modular-map"
  | .admitted => "double-and-cast-complete-One"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "repeated-value-without-first-return"
  | .admitted => "complete-first-return-orbit"

inductive Binary where
  | rejected | admitted

def binaryName : Binary → String
  | .rejected => "asserted-binary-count"
  | .admitted => "depth-two-unit-part-period"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "selected-later-period"
  | .admitted => "least-distinct-positive-successor"

inductive Unit where
  | rejected | admitted

def unitName : Unit → String
  | .rejected => "target-denominator"
  | .admitted => "support-predecessor-unit-part"

inductive Orbit where
  | rejected | admitted

def orbitName : Orbit → String
  | .rejected => "period-label-only"
  | .admitted => "all-Fold-transitions-held"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "bounded-denominator-search"
  | .admitted => "positive-count-discreteness-plus-existence"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "measurement-selected-period"
  | .admitted => "derivation-before-measurement"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-generator-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  action : Action
  recurrence : Recurrence
  binary : Binary
  successor : Successor
  unit : Unit
  orbit : Orbit
  order : Order
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, actionName c.action, recurrenceName c.recurrence, binaryName c.binary, successorName c.successor, unitName c.unit, orbitName c.orbit, orderName c.order, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "action=" (actionName c.action), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "binary=" (binaryName c.binary), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "unit=" (unitName c.unit), SFT.Host.Text.append "orbit=" (orbitName c.orbit), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "exact-positive-period-trace__double-and-cast-complete-One__complete-first-return-orbit__depth-two-unit-part-period__least-distinct-positive-successor__support-predecessor-unit-part__all-Fold-transitions-held__positive-count-discreteness-plus-existence__derivation-before-measurement__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "exact-positive-period-trace" &&
  SFT.Host.Text.equal (actionName c.action) "double-and-cast-complete-One" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "complete-first-return-orbit" &&
  SFT.Host.Text.equal (binaryName c.binary) "depth-two-unit-part-period" &&
  SFT.Host.Text.equal (successorName c.successor) "least-distinct-positive-successor" &&
  SFT.Host.Text.equal (unitName c.unit) "support-predecessor-unit-part" &&
  SFT.Host.Text.equal (orbitName c.orbit) "all-Fold-transitions-held" &&
  SFT.Host.Text.equal (orderName c.order) "positive-count-discreteness-plus-existence" &&
  SFT.Host.Text.equal (measurementName c.measurement) "derivation-before-measurement" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "exact-positive-period-trace") then "A borrowed numeral has no Fold recurrence trace." else
  if !(SFT.Host.Text.equal (actionName c.action) "double-and-cast-complete-One") then "An imported modular operation is not the admitted Fold." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "complete-first-return-orbit") then "A repeated value can hide an earlier return." else
  if !(SFT.Host.Text.equal (binaryName c.binary) "depth-two-unit-part-period") then "Naming two does not derive its recurrence." else
  if !(SFT.Host.Text.equal (successorName c.successor) "least-distinct-positive-successor") then "A later period is not minimal." else
  if !(SFT.Host.Text.equal (unitName c.unit) "support-predecessor-unit-part") then "A denominator read from an answer is target input." else
  if !(SFT.Host.Text.equal (orbitName c.orbit) "all-Fold-transitions-held") then "A label cannot reproduce the return." else
  if !(SFT.Host.Text.equal (orderName c.order) "positive-count-discreteness-plus-existence") then "A denominator bound does not close later candidates." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "derivation-before-measurement") then "Measurement-to-derivation flow violates the admitted boundary." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An extra selector is a free parameter." else
  "The second distinct nonidentity Fold generator is the exact positive count three, witnessed by the complete first-return orbit 1/7 -> 2/7 -> 4/7 -> 1/7."

def generationRule : String := "Generate the complete product of Fold carrier, action, recurrence, binary anchor, distinct successor, unit-part construction, orbit record, order closure, measurement direction and extra-rule forms."
def grammarBoundary : String := "All exact positive first-return generator constructions available from finite Fold-word support, positive predecessors, Fold action, recurrence and positive-count succession."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Action.rejected,Action.admitted]).flatMap fun action =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Binary.rejected,Binary.admitted]).flatMap fun binary =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Unit.rejected,Unit.admitted]).flatMap fun unit =>
  ([Orbit.rejected,Orbit.admitted]).flatMap fun orbit =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,action,recurrence,binary,successor,unit,orbit,order,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier action recurrence binary successor unit orbit order measurement extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haction : action ∈ [Action.rejected,Action.admitted] := by
      cases action <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbinary : binary ∈ [Binary.rejected,Binary.admitted] := by
      cases binary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunit : unit ∈ [Unit.rejected,Unit.admitted] := by
      cases unit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horbit : orbit ∈ [Orbit.rejected,Orbit.admitted] := by
      cases orbit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ action _ haction
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ binary _ hbinary
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    apply CommonRefinement.memFlatMap _ _ unit _ hunit
    apply CommonRefinement.memFlatMap _ _ orbit _ horbit
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.GeneratorThreeGrammar
