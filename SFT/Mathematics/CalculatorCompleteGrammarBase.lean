import SFT.Mathematics.CalculatorCompleteMachine
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CalculatorCompleteGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Interaction where
  | rejected | admitted

def interactionName : Interaction → String
  | .rejected => "expression-api-only"
  | .admitted => "familiar-keypad-and-result-chaining"

inductive Value_law where
  | rejected | admitted

def value_lawName : Value_law → String
  | .rejected => "projected-host-scalars"
  | .admitted => "exact-SFT-runtime-types"

inductive Scientific_surface where
  | rejected | admitted

def scientific_surfaceName : Scientific_surface → String
  | .rejected => "partial-function-subset"
  | .admitted => "complete-declared-expression-language"

inductive Mathematics_census where
  | rejected | admitted

def mathematics_censusName : Mathematics_census → String
  | .rejected => "calculator-only-scalar-view"
  | .admitted => "all-current-predecessor-families"

inductive Proof_output where
  | rejected | admitted

def proof_outputName : Proof_output → String
  | .rejected => "opaque-friendly-number"
  | .admitted => "typed-certificate-trace-and-resources"

inductive Accessibility where
  | rejected | admitted

def accessibilityName : Accessibility → String
  | .rejected => "all-evidence-visible-at-once"
  | .admitted => "familiar-first-progressive-disclosure"

inductive Portability where
  | rejected | admitted

def portabilityName : Portability → String
  | .rejected => "platform-specific-or-heavy-runtime"
  | .admitted => "standard-library-mac-Windows-Linux"

inductive Periodic_scale where
  | rejected | admitted

def periodic_scaleName : Periodic_scale → String
  | .rejected => "unreduced-direct-series-only"
  | .admitted => "certified-whole-turn-reduction"

inductive Resource_boundary where
  | rejected | admitted

def resource_boundaryName : Resource_boundary → String
  | .rejected => "unbounded-or-silent-failure"
  | .admitted => "counted-early-check-and-mandatory-halt"

inductive Testing where
  | rejected | admitted

def testingName : Testing → String
  | .rejected => "passing-examples-with-gaps"
  | .admitted => "complete-statement-and-branch-coverage"

structure Candidate where
  interaction : Interaction
  value_law : Value_law
  scientific_surface : Scientific_surface
  mathematics_census : Mathematics_census
  proof_output : Proof_output
  accessibility : Accessibility
  portability : Portability
  periodic_scale : Periodic_scale
  resource_boundary : Resource_boundary
  testing : Testing

def sourceFields (c : Candidate) : List String := [interactionName c.interaction, value_lawName c.value_law, scientific_surfaceName c.scientific_surface, mathematics_censusName c.mathematics_census, proof_outputName c.proof_output, accessibilityName c.accessibility, portabilityName c.portability, periodic_scaleName c.periodic_scale, resource_boundaryName c.resource_boundary, testingName c.testing]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "interaction=" (interactionName c.interaction), SFT.Host.Text.append "value_law=" (value_lawName c.value_law), SFT.Host.Text.append "scientific_surface=" (scientific_surfaceName c.scientific_surface), SFT.Host.Text.append "mathematics_census=" (mathematics_censusName c.mathematics_census), SFT.Host.Text.append "proof_output=" (proof_outputName c.proof_output), SFT.Host.Text.append "accessibility=" (accessibilityName c.accessibility), SFT.Host.Text.append "portability=" (portabilityName c.portability), SFT.Host.Text.append "periodic_scale=" (periodic_scaleName c.periodic_scale), SFT.Host.Text.append "resource_boundary=" (resource_boundaryName c.resource_boundary), SFT.Host.Text.append "testing=" (testingName c.testing)]
def survivorId : String := "familiar-keypad-and-result-chaining__exact-SFT-runtime-types__complete-declared-expression-language__all-current-predecessor-families__typed-certificate-trace-and-resources__familiar-first-progressive-disclosure__standard-library-mac-Windows-Linux__certified-whole-turn-reduction__counted-early-check-and-mandatory-halt__complete-statement-and-branch-coverage"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (interactionName c.interaction) "familiar-keypad-and-result-chaining" &&
  SFT.Host.Text.equal (value_lawName c.value_law) "exact-SFT-runtime-types" &&
  SFT.Host.Text.equal (scientific_surfaceName c.scientific_surface) "complete-declared-expression-language" &&
  SFT.Host.Text.equal (mathematics_censusName c.mathematics_census) "all-current-predecessor-families" &&
  SFT.Host.Text.equal (proof_outputName c.proof_output) "typed-certificate-trace-and-resources" &&
  SFT.Host.Text.equal (accessibilityName c.accessibility) "familiar-first-progressive-disclosure" &&
  SFT.Host.Text.equal (portabilityName c.portability) "standard-library-mac-Windows-Linux" &&
  SFT.Host.Text.equal (periodic_scaleName c.periodic_scale) "certified-whole-turn-reduction" &&
  SFT.Host.Text.equal (resource_boundaryName c.resource_boundary) "counted-early-check-and-mandatory-halt" &&
  SFT.Host.Text.equal (testingName c.testing) "complete-statement-and-branch-coverage"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (interactionName c.interaction) "familiar-keypad-and-result-chaining") then "An API alone is not a familiar calculator." else
  if !(SFT.Host.Text.equal (value_lawName c.value_law) "exact-SFT-runtime-types") then "Host zero, negative, irrational, imaginary or floating proof values violate the admitted Mathematics boundary." else
  if !(SFT.Host.Text.equal (scientific_surfaceName c.scientific_surface) "complete-declared-expression-language") then "A partial subset cannot realise the declared scientific calculator." else
  if !(SFT.Host.Text.equal (mathematics_censusName c.mathematics_census) "all-current-predecessor-families") then "A scalar-only view omits registered structured and theorem-level Mathematics families." else
  if !(SFT.Host.Text.equal (proof_outputName c.proof_output) "typed-certificate-trace-and-resources") then "A projected number without exact evidence hides the calculation law." else
  if !(SFT.Host.Text.equal (accessibilityName c.accessibility) "familiar-first-progressive-disclosure") then "Dumping proof detail onto first-time users makes ordinary calculator use inaccessible." else
  if !(SFT.Host.Text.equal (portabilityName c.portability) "standard-library-mac-Windows-Linux") then "A platform-specific or container-dependent app blocks independent access." else
  if !(SFT.Host.Text.equal (periodic_scaleName c.periodic_scale) "certified-whole-turn-reduction") then "A direct series alone exhausts resources on ordinary large circular arguments." else
  if !(SFT.Host.Text.equal (resource_boundaryName c.resource_boundary) "counted-early-check-and-mandatory-halt") then "Unbounded construction or NaN/infinity hides an unclosed computation." else
  if !(SFT.Host.Text.equal (testingName c.testing) "complete-statement-and-branch-coverage") then "Passing examples do not execute every implementation path." else
  "The unique completion is the familiar cross-platform app whose ordinary input invokes only exact SFT runtime types; whose advanced view exposes the complete current Mathematics census and engine-comparable proof; whose large circular inputs are certified by whole-turn reduction; and whose declared active implementation records no missing statement or branch."

def generationRule : String := "Hold all twenty-four admitted predecessor Mathematics claims fixed, then exhaust the ten independent completion choices for interaction, value law, scientific surface, branch census, proof output, accessibility, portability, periodic scale, fail-closed resources and complete testing."
def grammarBoundary : String := "The complete ten-coordinate binary product of application completions over the immutable claim-005 calculator and the exact set of twenty-four registered predecessor Mathematics claims."

def candidates : List Candidate :=
  ([Interaction.rejected,Interaction.admitted]).flatMap fun interaction =>
  ([Value_law.rejected,Value_law.admitted]).flatMap fun value_law =>
  ([Scientific_surface.rejected,Scientific_surface.admitted]).flatMap fun scientific_surface =>
  ([Mathematics_census.rejected,Mathematics_census.admitted]).flatMap fun mathematics_census =>
  ([Proof_output.rejected,Proof_output.admitted]).flatMap fun proof_output =>
  ([Accessibility.rejected,Accessibility.admitted]).flatMap fun accessibility =>
  ([Portability.rejected,Portability.admitted]).flatMap fun portability =>
  ([Periodic_scale.rejected,Periodic_scale.admitted]).flatMap fun periodic_scale =>
  ([Resource_boundary.rejected,Resource_boundary.admitted]).flatMap fun resource_boundary =>
  ([Testing.rejected,Testing.admitted]).map fun testing =>
  ⟨interaction,value_law,scientific_surface,mathematics_census,proof_output,accessibility,portability,periodic_scale,resource_boundary,testing⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk interaction value_law scientific_surface mathematics_census proof_output accessibility portability periodic_scale resource_boundary testing =>
    have hinteraction : interaction ∈ [Interaction.rejected,Interaction.admitted] := by
      cases interaction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvalue_law : value_law ∈ [Value_law.rejected,Value_law.admitted] := by
      cases value_law <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscientific_surface : scientific_surface ∈ [Scientific_surface.rejected,Scientific_surface.admitted] := by
      cases scientific_surface <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmathematics_census : mathematics_census ∈ [Mathematics_census.rejected,Mathematics_census.admitted] := by
      cases mathematics_census <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproof_output : proof_output ∈ [Proof_output.rejected,Proof_output.admitted] := by
      cases proof_output <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haccessibility : accessibility ∈ [Accessibility.rejected,Accessibility.admitted] := by
      cases accessibility <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hportability : portability ∈ [Portability.rejected,Portability.admitted] := by
      cases portability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hperiodic_scale : periodic_scale ∈ [Periodic_scale.rejected,Periodic_scale.admitted] := by
      cases periodic_scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresource_boundary : resource_boundary ∈ [Resource_boundary.rejected,Resource_boundary.admitted] := by
      cases resource_boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htesting : testing ∈ [Testing.rejected,Testing.admitted] := by
      cases testing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ interaction _ hinteraction
    apply CommonRefinement.memFlatMap _ _ value_law _ hvalue_law
    apply CommonRefinement.memFlatMap _ _ scientific_surface _ hscientific_surface
    apply CommonRefinement.memFlatMap _ _ mathematics_census _ hmathematics_census
    apply CommonRefinement.memFlatMap _ _ proof_output _ hproof_output
    apply CommonRefinement.memFlatMap _ _ accessibility _ haccessibility
    apply CommonRefinement.memFlatMap _ _ portability _ hportability
    apply CommonRefinement.memFlatMap _ _ periodic_scale _ hperiodic_scale
    apply CommonRefinement.memFlatMap _ _ resource_boundary _ hresource_boundary
    exact Count.TraceDerivation.memMap _ testing _ htesting

end SFT.Mathematics.CalculatorCompleteGrammar
