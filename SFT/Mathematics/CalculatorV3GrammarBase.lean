import SFT.Mathematics.CalculatorMachineV3
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CalculatorV3Grammar
open SFT.Foundation
set_option maxRecDepth 100000

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "host-float"
  | .admitted => "character-exact-part"

inductive Empty where
  | rejected | admitted

def emptyName : Empty → String
  | .rejected => "numeric-zero"
  | .admitted => "structural-empty-One"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-scalar"
  | .admitted => "held-fibre-orientation"

inductive Operations where
  | rejected | admitted

def operationsName : Operations → String
  | .rejected => "host-arithmetic-oracle"
  | .admitted => "generated-exact-kernels"

inductive Nonrational where
  | rejected | admitted

def nonrationalName : Nonrational → String
  | .rejected => "irrational-scalar"
  | .admitted => "rational-balance-enclosure"

inductive Transcendental where
  | rejected | admitted

def transcendentalName : Transcendental → String
  | .rejected => "black-box-library-value"
  | .admitted => "finite-rational-recurrence-bound"

inductive Orthogonal where
  | rejected | admitted

def orthogonalName : Orthogonal → String
  | .rejected => "imaginary-scalar"
  | .admitted => "typed-orthogonal-fibre-pair"

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "nan-infinity-continuation"
  | .admitted => "explicit-lawful-halt"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "answer-only"
  | .admitted => "complete-proof-resource-trace"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "has-extra-rule"
  | .admitted => "no-extra-rule"

inductive Scientific_surface where
  | rejected | admitted

def scientific_surfaceName : Scientific_surface → String
  | .rejected => "partial-basic-function-subset"
  | .admitted => "complete-declared-scientific-surface"

inductive Session where
  | rejected | admitted

def sessionName : Session → String
  | .rejected => "stateless-expression-only"
  | .admitted => "equals-answer-memory-history"

inductive Application where
  | rejected | admitted

def applicationName : Application → String
  | .rejected => "terminal-only-opaque-answer"
  | .admitted => "cross-platform-app-trace-and-guide"

structure Candidate where
  input : Input
  empty : Empty
  orientation : Orientation
  operations : Operations
  nonrational : Nonrational
  transcendental : Transcendental
  orthogonal : Orthogonal
  domain : Domain
  trace : Trace
  addition : Addition
  scientific_surface : Scientific_surface
  session : Session
  application : Application

def sourceFields (c : Candidate) : List String := [inputName c.input, emptyName c.empty, orientationName c.orientation, operationsName c.operations, nonrationalName c.nonrational, transcendentalName c.transcendental, orthogonalName c.orthogonal, domainName c.domain, traceName c.trace, additionName c.addition, scientific_surfaceName c.scientific_surface, sessionName c.session, applicationName c.application]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "empty=" (emptyName c.empty), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "operations=" (operationsName c.operations), SFT.Host.Text.append "nonrational=" (nonrationalName c.nonrational), SFT.Host.Text.append "transcendental=" (transcendentalName c.transcendental), SFT.Host.Text.append "orthogonal=" (orthogonalName c.orthogonal), SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "addition=" (additionName c.addition), SFT.Host.Text.append "scientific_surface=" (scientific_surfaceName c.scientific_surface), SFT.Host.Text.append "session=" (sessionName c.session), SFT.Host.Text.append "application=" (applicationName c.application)]
def survivorId : String := "character-exact-part__structural-empty-One__held-fibre-orientation__generated-exact-kernels__rational-balance-enclosure__finite-rational-recurrence-bound__typed-orthogonal-fibre-pair__explicit-lawful-halt__complete-proof-resource-trace__no-extra-rule__complete-declared-scientific-surface__equals-answer-memory-history__cross-platform-app-trace-and-guide"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (inputName c.input) "character-exact-part" &&
  SFT.Host.Text.equal (emptyName c.empty) "structural-empty-One" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-fibre-orientation" &&
  SFT.Host.Text.equal (operationsName c.operations) "generated-exact-kernels" &&
  SFT.Host.Text.equal (nonrationalName c.nonrational) "rational-balance-enclosure" &&
  SFT.Host.Text.equal (transcendentalName c.transcendental) "finite-rational-recurrence-bound" &&
  SFT.Host.Text.equal (orthogonalName c.orthogonal) "typed-orthogonal-fibre-pair" &&
  SFT.Host.Text.equal (domainName c.domain) "explicit-lawful-halt" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-proof-resource-trace" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule" &&
  SFT.Host.Text.equal (scientific_surfaceName c.scientific_surface) "complete-declared-scientific-surface" &&
  SFT.Host.Text.equal (sessionName c.session) "equals-answer-memory-history" &&
  SFT.Host.Text.equal (applicationName c.application) "cross-platform-app-trace-and-guide"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (inputName c.input) "character-exact-part") then "A host float loses the exact entered part before proof begins." else
  if !(SFT.Host.Text.equal (emptyName c.empty) "structural-empty-One") then "Numerical zero is not an admitted SFT value." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-fibre-orientation") then "A negative scalar imports a forbidden signed field." else
  if !(SFT.Host.Text.equal (operationsName c.operations) "generated-exact-kernels") then "A host arithmetic oracle erases the generated Fold construction." else
  if !(SFT.Host.Text.equal (nonrationalName c.nonrational) "rational-balance-enclosure") then "An irrational scalar is outside the proof domain." else
  if !(SFT.Host.Text.equal (transcendentalName c.transcendental) "finite-rational-recurrence-bound") then "A black-box value supplies no Fold derivation or remainder certificate." else
  if !(SFT.Host.Text.equal (orthogonalName c.orthogonal) "typed-orthogonal-fibre-pair") then "An imaginary scalar is not an admitted proof value." else
  if !(SFT.Host.Text.equal (domainName c.domain) "explicit-lawful-halt") then "NaN or infinity silently continues beyond the admitted domain." else
  if !(SFT.Host.Text.equal (traceName c.trace) "complete-proof-resource-trace") then "An answer without provenance cannot be replayed or independently checked." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-rule") then "A fitted constant or answer-selecting rule is not supplied by the dependencies." else
  if !(SFT.Host.Text.equal (scientific_surfaceName c.scientific_surface) "complete-declared-scientific-surface") then "A basic subset is not the requested scientific calculator." else
  if !(SFT.Host.Text.equal (sessionName c.session) "equals-answer-memory-history") then "A stateless expression evaluator lacks terminal equals, answer, memory and history behavior." else
  if !(SFT.Host.Text.equal (applicationName c.application) "cross-platform-app-trace-and-guide") then "A terminal-only answer surface is not a clean general-user calculator app and hides evidence." else
  "The unique expanded calculator is the exact core plus the complete declared scientific-function surface, terminal equals/Ans/memory/history state, RAD/DEG/GRAD translation, and one cross-platform desktop app whose buttons and keyboard invoke only the same fail-closed evaluator. Every exact result retains its Fold type; every non-rational result remains a certified rational enclosure; decimal output is display only."

def generationRule : String := "Generate the complete product of input-value, empty, orientation, exact-operation, non-rational, transcendental, orthogonal, domain, trace and extra-rule choices. Extend that complete product by declared scientific-function coverage, stateful interaction, and cross-platform application/evidence-surface choices."
def grammarBoundary : String := "The complete thirteen-coordinate product formed by the ten exact core semantics plus the declared mainstream scientific function manifest, session interaction law and standard-library desktop evidence surface."

def candidates : List Candidate :=
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Empty.rejected,Empty.admitted]).flatMap fun empty =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Operations.rejected,Operations.admitted]).flatMap fun operations =>
  ([Nonrational.rejected,Nonrational.admitted]).flatMap fun nonrational =>
  ([Transcendental.rejected,Transcendental.admitted]).flatMap fun transcendental =>
  ([Orthogonal.rejected,Orthogonal.admitted]).flatMap fun orthogonal =>
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Addition.rejected,Addition.admitted]).flatMap fun addition =>
  ([Scientific_surface.rejected,Scientific_surface.admitted]).flatMap fun scientific_surface =>
  ([Session.rejected,Session.admitted]).flatMap fun session =>
  ([Application.rejected,Application.admitted]).map fun application =>
  ⟨input,empty,orientation,operations,nonrational,transcendental,orthogonal,domain,trace,addition,scientific_surface,session,application⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 8192 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk input empty orientation operations nonrational transcendental orthogonal domain trace addition scientific_surface session application =>
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hempty : empty ∈ [Empty.rejected,Empty.admitted] := by
      cases empty <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperations : operations ∈ [Operations.rejected,Operations.admitted] := by
      cases operations <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnonrational : nonrational ∈ [Nonrational.rejected,Nonrational.admitted] := by
      cases nonrational <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htranscendental : transcendental ∈ [Transcendental.rejected,Transcendental.admitted] := by
      cases transcendental <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horthogonal : orthogonal ∈ [Orthogonal.rejected,Orthogonal.admitted] := by
      cases orthogonal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscientific_surface : scientific_surface ∈ [Scientific_surface.rejected,Scientific_surface.admitted] := by
      cases scientific_surface <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsession : session ∈ [Session.rejected,Session.admitted] := by
      cases session <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have happlication : application ∈ [Application.rejected,Application.admitted] := by
      cases application <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ empty _ hempty
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ operations _ hoperations
    apply CommonRefinement.memFlatMap _ _ nonrational _ hnonrational
    apply CommonRefinement.memFlatMap _ _ transcendental _ htranscendental
    apply CommonRefinement.memFlatMap _ _ orthogonal _ horthogonal
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    apply CommonRefinement.memFlatMap _ _ addition _ haddition
    apply CommonRefinement.memFlatMap _ _ scientific_surface _ hscientific_surface
    apply CommonRefinement.memFlatMap _ _ session _ hsession
    exact Count.TraceDerivation.memMap _ application _ happlication

end SFT.Mathematics.CalculatorV3Grammar
