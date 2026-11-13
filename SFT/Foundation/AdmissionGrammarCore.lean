import SFT.Foundation.AdmissionAcceptance
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.AdmissionGrammar
set_option maxRecDepth 20000

inductive Registration where
  | rejected | admitted

def registrationName : Registration → String
  | .rejected => "registration-incomplete"
  | .admitted => "registration-root-bound"

inductive Premises where
  | rejected | admitted

def premisesName : Premises → String
  | .rejected => "axiom-or-parameter-present"
  | .admitted => "no-axiom-zero-parameter"

inductive Census where
  | rejected | admitted

def censusName : Census → String
  | .rejected => "census-selected"
  | .admitted => "census-complete"

inductive Forcing where
  | rejected | admitted

def forcingName : Forcing → String
  | .rejected => "survivor-not-unique"
  | .admitted => "survivor-unique"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "form-open"
  | .admitted => "form-closed"

inductive Controls where
  | rejected | admitted

def controlsName : Controls → String
  | .rejected => "controls-incomplete"
  | .admitted => "controls-complete"

inductive Validation where
  | rejected | admitted

def validationName : Validation → String
  | .rejected => "validation-self-only"
  | .admitted => "validation-independent"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "measurement-before-seal"
  | .admitted => "measurement-after-seal-when-required"

inductive Receipts where
  | rejected | admitted

def receiptsName : Receipts → String
  | .rejected => "failure-discarded"
  | .admitted => "every-receipt-preserved"

inductive Dependency where
  | rejected | admitted

def dependencyName : Dependency → String
  | .rejected => "dependency-before-admission"
  | .admitted => "dependency-after-model-admission"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  registration : Registration
  premises : Premises
  census : Census
  forcing : Forcing
  closure : Closure
  controls : Controls
  validation : Validation
  measurement : Measurement
  receipts : Receipts
  dependency : Dependency
  extra : Extra

def sourceFields (c : Candidate) : List String := [registrationName c.registration, premisesName c.premises, censusName c.census, forcingName c.forcing, closureName c.closure, controlsName c.controls, validationName c.validation, measurementName c.measurement, receiptsName c.receipts, dependencyName c.dependency, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Admission path has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]
def survivorId : String := "registration-root-bound__no-axiom-zero-parameter__census-complete__survivor-unique__form-closed__controls-complete__validation-independent__measurement-after-seal-when-required__every-receipt-preserved__dependency-after-model-admission__no-extra"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (registrationName c.registration) "registration-root-bound" &&
  SFT.Host.Text.equal (premisesName c.premises) "no-axiom-zero-parameter" &&
  SFT.Host.Text.equal (censusName c.census) "census-complete" &&
  SFT.Host.Text.equal (forcingName c.forcing) "survivor-unique" &&
  SFT.Host.Text.equal (closureName c.closure) "form-closed" &&
  SFT.Host.Text.equal (controlsName c.controls) "controls-complete" &&
  SFT.Host.Text.equal (validationName c.validation) "validation-independent" &&
  SFT.Host.Text.equal (measurementName c.measurement) "measurement-after-seal-when-required" &&
  SFT.Host.Text.equal (receiptsName c.receipts) "every-receipt-preserved" &&
  SFT.Host.Text.equal (dependencyName c.dependency) "dependency-after-model-admission" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (registrationName c.registration) "registration-incomplete" then "The claim lacks an exact statement, source identity or root/dependency trace." else
  if SFT.Host.Text.equal (premisesName c.premises) "axiom-or-parameter-present" then "An axiom, fitted value, learned value or free parameter enters the derivation." else
  if SFT.Host.Text.equal (censusName c.census) "census-selected" then "The candidate neighborhood is selected rather than completely generated at its boundary." else
  if SFT.Host.Text.equal (forcingName c.forcing) "survivor-not-unique" then "Forcing leaves none or more than one survivor." else
  if SFT.Host.Text.equal (closureName c.closure) "form-open" then "Minimality, named-shape uniqueness or the exact boundary remains open." else
  if SFT.Host.Text.equal (controlsName c.controls) "controls-incomplete" then "A false-premise, tampered-source, tampered-artifact or boundary control is absent or fails." else
  if SFT.Host.Text.equal (validationName c.validation) "validation-self-only" then "The result is not recomputed by an implementation-distinct validator." else
  if SFT.Host.Text.equal (measurementName c.measurement) "measurement-before-seal" then "Target content can select or mutate the derivation." else
  if SFT.Host.Text.equal (receiptsName c.receipts) "failure-discarded" then "An adverse or rejected receipt is lost." else
  if SFT.Host.Text.equal (dependencyName c.dependency) "dependency-before-admission" then "An unclosed result is used as model authority." else
  if SFT.Host.Text.equal (extraName c.extra) "has-extra" then "The route adds an unregistered bypass or exception." else
  "It is the sole fail-closed route: root-bound, parameter-free, exhaustively forced, closed, controlled, independently checked, post-seal measured when applicable, receipt-preserving and authority-gated."

def generationRule : String := "Generate the complete product of registration, premise/parameter, enumeration, forcing, closure, control, independent-validation, measurement-order, receipt-retention, dependency-authority and added-rule classes."
def grammarBoundary : String := "All admission paths from a proposed V3 derivation to model authority under the single engine, including formal-only and post-seal empirical evidence modes."

def candidates : List Candidate :=
  ([Registration.rejected,Registration.admitted]).flatMap fun registration =>
  ([Premises.rejected,Premises.admitted]).flatMap fun premises =>
  ([Census.rejected,Census.admitted]).flatMap fun census =>
  ([Forcing.rejected,Forcing.admitted]).flatMap fun forcing =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Controls.rejected,Controls.admitted]).flatMap fun controls =>
  ([Validation.rejected,Validation.admitted]).flatMap fun validation =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Receipts.rejected,Receipts.admitted]).flatMap fun receipts =>
  ([Dependency.rejected,Dependency.admitted]).flatMap fun dependency =>
  ([Extra.noExtra,Extra.hasExtra]).map fun extra =>
  ⟨registration,premises,census,forcing,closure,controls,validation,measurement,receipts,dependency,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.noExtra⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk registration premises census forcing closure controls validation measurement receipts dependency extra =>
    have hregistration : registration ∈ [Registration.rejected,Registration.admitted] := by
      cases registration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpremises : premises ∈ [Premises.rejected,Premises.admitted] := by
      cases premises <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcensus : census ∈ [Census.rejected,Census.admitted] := by
      cases census <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hforcing : forcing ∈ [Forcing.rejected,Forcing.admitted] := by
      cases forcing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontrols : controls ∈ [Controls.rejected,Controls.admitted] := by
      cases controls <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalidation : validation ∈ [Validation.rejected,Validation.admitted] := by
      cases validation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreceipts : receipts ∈ [Receipts.rejected,Receipts.admitted] := by
      cases receipts <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdependency : dependency ∈ [Dependency.rejected,Dependency.admitted] := by
      cases dependency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,Extra.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ registration _ hregistration
    apply CommonRefinement.memFlatMap _ _ premises _ hpremises
    apply CommonRefinement.memFlatMap _ _ census _ hcensus
    apply CommonRefinement.memFlatMap _ _ forcing _ hforcing
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ controls _ hcontrols
    apply CommonRefinement.memFlatMap _ _ validation _ hvalidation
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ receipts _ hreceipts
    apply CommonRefinement.memFlatMap _ _ dependency _ hdependency
    exact Count.TraceDerivation.memMap _ extra _ hextra

end SFT.Foundation.AdmissionGrammar
