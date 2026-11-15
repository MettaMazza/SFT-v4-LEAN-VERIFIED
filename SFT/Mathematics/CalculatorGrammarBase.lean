import SFT.Foundation.FormAcceptance
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CalculatorGrammar
open SFT.Foundation
set_option maxRecDepth 20000

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

def sourceFields (c : Candidate) : List String := [inputName c.input, emptyName c.empty, orientationName c.orientation, operationsName c.operations, nonrationalName c.nonrational, transcendentalName c.transcendental, orthogonalName c.orthogonal, domainName c.domain, traceName c.trace, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "empty=" (emptyName c.empty), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "operations=" (operationsName c.operations), SFT.Host.Text.append "nonrational=" (nonrationalName c.nonrational), SFT.Host.Text.append "transcendental=" (transcendentalName c.transcendental), SFT.Host.Text.append "orthogonal=" (orthogonalName c.orthogonal), SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "character-exact-part__structural-empty-One__held-fibre-orientation__generated-exact-kernels__rational-balance-enclosure__finite-rational-recurrence-bound__typed-orthogonal-fibre-pair__explicit-lawful-halt__complete-proof-resource-trace__no-extra-rule"
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
  SFT.Host.Text.equal (additionName c.addition) "no-extra-rule"

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
  "The unique admitted calculator semantics uses exact character-generated rational parts, structural empty-One, held orientation, generated exact kernels, certified rational enclosures, finite rational recurrences with explicit remainder bounds, typed orthogonal fibres, mandatory domain halts, complete proof/resource traces and no extra rule."

def generationRule : String := "Generate the complete product of input-value, empty, orientation, exact-operation, non-rational, transcendental, orthogonal, domain, trace and extra-rule choices."
def grammarBoundary : String := "All calculator semantics formed from the ten declared binary representation and execution choices, with exact finite rational recurrences and a declared finite resource bound."

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
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨input,empty,orientation,operations,nonrational,transcendental,orthogonal,domain,trace,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk input empty orientation operations nonrational transcendental orthogonal domain trace addition =>
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
    exact Count.TraceDerivation.memMap _ addition _ haddition

end SFT.Mathematics.CalculatorGrammar
