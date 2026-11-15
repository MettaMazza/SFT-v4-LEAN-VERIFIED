import SFT.Mathematics.CalculatorBrowserSessions
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CalculatorBrowserGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Rendered_surface where
  | rejected | admitted

def rendered_surfaceName : Rendered_surface → String
  | .rejected => "deprecated-widget-geometry-only"
  | .admitted => "standards-rendered-browser-surface"

inductive Keypad_organisation where
  | rejected | admitted

def keypad_organisationName : Keypad_organisation → String
  | .rejected => "flattened-function-grid"
  | .admitted => "standard-pad-plus-scientific-panel"

inductive Value_boundary where
  | rejected | admitted

def value_boundaryName : Value_boundary → String
  | .rejected => "conventional-prohibited-projection"
  | .admitted => "familiar-notation-with-SFT-halt-and-types"

inductive Kernel_route where
  | rejected | admitted

def kernel_routeName : Kernel_route → String
  | .rejected => "client-side-duplicate-arithmetic"
  | .admitted => "server-side-immutable-claim-006-controller"

inductive Session_state where
  | rejected | admitted

def session_stateName : Session_state → String
  | .rejected => "shared-global-visitor-state"
  | .admitted => "fresh-independent-page-session"

inductive Network_reach where
  | rejected | admitted

def network_reachName : Network_reach → String
  | .rejected => "desktop-loopback-only"
  | .admitted => "same-network-default-with-private-option"

inductive Dependency_boundary where
  | rejected | admitted

def dependency_boundaryName : Dependency_boundary → String
  | .rejected => "heavy-GUI-or-container-runtime"
  | .admitted => "Python-standard-library-and-installed-browser"

inductive Validation where
  | rejected | admitted

def validationName : Validation → String
  | .rejected => "hidden-widget-dimensions-only"
  | .admitted => "API-render-responsive-adverse-and-complete-coverage"

structure Candidate where
  rendered_surface : Rendered_surface
  keypad_organisation : Keypad_organisation
  value_boundary : Value_boundary
  kernel_route : Kernel_route
  session_state : Session_state
  network_reach : Network_reach
  dependency_boundary : Dependency_boundary
  validation : Validation

def sourceFields (c : Candidate) : List String := [rendered_surfaceName c.rendered_surface, keypad_organisationName c.keypad_organisation, value_boundaryName c.value_boundary, kernel_routeName c.kernel_route, session_stateName c.session_state, network_reachName c.network_reach, dependency_boundaryName c.dependency_boundary, validationName c.validation]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "rendered_surface=" (rendered_surfaceName c.rendered_surface), SFT.Host.Text.append "keypad_organisation=" (keypad_organisationName c.keypad_organisation), SFT.Host.Text.append "value_boundary=" (value_boundaryName c.value_boundary), SFT.Host.Text.append "kernel_route=" (kernel_routeName c.kernel_route), SFT.Host.Text.append "session_state=" (session_stateName c.session_state), SFT.Host.Text.append "network_reach=" (network_reachName c.network_reach), SFT.Host.Text.append "dependency_boundary=" (dependency_boundaryName c.dependency_boundary), SFT.Host.Text.append "validation=" (validationName c.validation)]
def survivorId : String := "standards-rendered-browser-surface__standard-pad-plus-scientific-panel__familiar-notation-with-SFT-halt-and-types__server-side-immutable-claim-006-controller__fresh-independent-page-session__same-network-default-with-private-option__Python-standard-library-and-installed-browser__API-render-responsive-adverse-and-complete-coverage"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (rendered_surfaceName c.rendered_surface) "standards-rendered-browser-surface" &&
  SFT.Host.Text.equal (keypad_organisationName c.keypad_organisation) "standard-pad-plus-scientific-panel" &&
  SFT.Host.Text.equal (value_boundaryName c.value_boundary) "familiar-notation-with-SFT-halt-and-types" &&
  SFT.Host.Text.equal (kernel_routeName c.kernel_route) "server-side-immutable-claim-006-controller" &&
  SFT.Host.Text.equal (session_stateName c.session_state) "fresh-independent-page-session" &&
  SFT.Host.Text.equal (network_reachName c.network_reach) "same-network-default-with-private-option" &&
  SFT.Host.Text.equal (dependency_boundaryName c.dependency_boundary) "Python-standard-library-and-installed-browser" &&
  SFT.Host.Text.equal (validationName c.validation) "API-render-responsive-adverse-and-complete-coverage"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (rendered_surfaceName c.rendered_surface) "standards-rendered-browser-surface") then "Mapped geometry did not ensure painted controls on the target macOS runtime." else
  if !(SFT.Host.Text.equal (keypad_organisationName c.keypad_organisation) "standard-pad-plus-scientific-panel") then "Arbitrary reflow destroys the familiar four-column calculator grammar." else
  if !(SFT.Host.Text.equal (value_boundaryName c.value_boundary) "familiar-notation-with-SFT-halt-and-types") then "Displaying a negative or irrational-style decimal silently reimports a prohibited scalar." else
  if !(SFT.Host.Text.equal (kernel_routeName c.kernel_route) "server-side-immutable-claim-006-controller") then "A second arithmetic implementation could diverge from the admitted evaluator." else
  if !(SFT.Host.Text.equal (session_stateName c.session_state) "fresh-independent-page-session") then "One visitor or test can contaminate another visitor's landing value." else
  if !(SFT.Host.Text.equal (network_reachName c.network_reach) "same-network-default-with-private-option") then "A computer-only default blocks ordinary same-network phone use." else
  if !(SFT.Host.Text.equal (dependency_boundaryName c.dependency_boundary) "Python-standard-library-and-installed-browser") then "A heavy platform runtime violates the accessibility requirement." else
  if !(SFT.Host.Text.equal (validationName c.validation) "API-render-responsive-adverse-and-complete-coverage") then "Widget dimensions did not detect the observed blank window." else
  "The unique completion is a familiar calculator-first local web application with a coherent standard pad, optional scientific and proof panels, fresh per-page state, same-network default access and one immutable exact SFT evaluation route."

def generationRule : String := "Hold the immutable claim-006 evaluator fixed and exhaust eight independent presentation completions: rendered surface, keypad organisation, value boundary, kernel route, session state, network reach, dependency boundary and validation."
def grammarBoundary : String := "The complete eight-coordinate binary product of presentation adapters over the immutable claim-006 controller; no coordinate may alter arithmetic, value construction, expression parsing, proof law or engine protocol."

def candidates : List Candidate :=
  ([Rendered_surface.rejected,Rendered_surface.admitted]).flatMap fun rendered_surface =>
  ([Keypad_organisation.rejected,Keypad_organisation.admitted]).flatMap fun keypad_organisation =>
  ([Value_boundary.rejected,Value_boundary.admitted]).flatMap fun value_boundary =>
  ([Kernel_route.rejected,Kernel_route.admitted]).flatMap fun kernel_route =>
  ([Session_state.rejected,Session_state.admitted]).flatMap fun session_state =>
  ([Network_reach.rejected,Network_reach.admitted]).flatMap fun network_reach =>
  ([Dependency_boundary.rejected,Dependency_boundary.admitted]).flatMap fun dependency_boundary =>
  ([Validation.rejected,Validation.admitted]).map fun validation =>
  ⟨rendered_surface,keypad_organisation,value_boundary,kernel_route,session_state,network_reach,dependency_boundary,validation⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk rendered_surface keypad_organisation value_boundary kernel_route session_state network_reach dependency_boundary validation =>
    have hrendered_surface : rendered_surface ∈ [Rendered_surface.rejected,Rendered_surface.admitted] := by
      cases rendered_surface <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hkeypad_organisation : keypad_organisation ∈ [Keypad_organisation.rejected,Keypad_organisation.admitted] := by
      cases keypad_organisation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalue_boundary : value_boundary ∈ [Value_boundary.rejected,Value_boundary.admitted] := by
      cases value_boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hkernel_route : kernel_route ∈ [Kernel_route.rejected,Kernel_route.admitted] := by
      cases kernel_route <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsession_state : session_state ∈ [Session_state.rejected,Session_state.admitted] := by
      cases session_state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnetwork_reach : network_reach ∈ [Network_reach.rejected,Network_reach.admitted] := by
      cases network_reach <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdependency_boundary : dependency_boundary ∈ [Dependency_boundary.rejected,Dependency_boundary.admitted] := by
      cases dependency_boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalidation : validation ∈ [Validation.rejected,Validation.admitted] := by
      cases validation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ rendered_surface _ hrendered_surface
    apply CommonRefinement.memFlatMap _ _ keypad_organisation _ hkeypad_organisation
    apply CommonRefinement.memFlatMap _ _ value_boundary _ hvalue_boundary
    apply CommonRefinement.memFlatMap _ _ kernel_route _ hkernel_route
    apply CommonRefinement.memFlatMap _ _ session_state _ hsession_state
    apply CommonRefinement.memFlatMap _ _ network_reach _ hnetwork_reach
    apply CommonRefinement.memFlatMap _ _ dependency_boundary _ hdependency_boundary
    exact Count.TraceDerivation.memMap _ validation _ hvalidation

end SFT.Mathematics.CalculatorBrowserGrammar
