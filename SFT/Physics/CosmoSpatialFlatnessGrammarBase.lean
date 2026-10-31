import SFT.Physics.CosmoSpatialFlatness
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CosmoSpatialFlatnessGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "independent-component-totals"
  | .admitted => "one-common-total-carrier"

inductive Component where
  | rejected | admitted

def componentName : Component → String
  | .rejected => "signed-or-unbound-density-number"
  | .admitted => "exact-positive-held-part"

inductive Normalization where
  | rejected | admitted

def normalizationName : Normalization → String
  | .rejected => "separate-normalizations"
  | .admitted => "common-One-normalization"

inductive Completeness where
  | rejected | admitted

def completenessName : Completeness → String
  | .rejected => "selected-visible-components"
  | .admitted => "every-generated-part-exhausts-One"

inductive Remainder where
  | rejected | admitted

def remainderName : Remainder → String
  | .rejected => "extra-curvature-scalar"
  | .admitted => "unassigned-part-remainder"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-curvature"
  | .admitted => "empty-One-form"

inductive Refinement where
  | rejected | admitted

def refinementName : Refinement → String
  | .rejected => "epoch-specific-fraction-table"
  | .admitted => "positive-parent-preserving-split"

inductive Scope where
  | rejected | admitted

def scopeName : Scope → String
  | .rejected => "single-observed-epoch"
  | .admitted => "all-finite-repartitions"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "curvature-record-readable-before-seal"
  | .admitted => "curvature-record-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "mislabel-as-unobserved-discovery"
  | .admitted => "observational-reconstruction-with-independent-runtime"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-cosmological-closure-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  component : Component
  normalization : Normalization
  completeness : Completeness
  remainder : Remainder
  absence : Absence
  refinement : Refinement
  scope : Scope
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, componentName c.component, normalizationName c.normalization, completenessName c.completeness, remainderName c.remainder, absenceName c.absence, refinementName c.refinement, scopeName c.scope, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "component=" (componentName c.component), SFT.Host.Text.append "normalization=" (normalizationName c.normalization), SFT.Host.Text.append "completeness=" (completenessName c.completeness), SFT.Host.Text.append "remainder=" (remainderName c.remainder), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "refinement=" (refinementName c.refinement), SFT.Host.Text.append "scope=" (scopeName c.scope), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-common-total-carrier__exact-positive-held-part__common-One-normalization__every-generated-part-exhausts-One__unassigned-part-remainder__empty-One-form__positive-parent-preserving-split__all-finite-repartitions__curvature-record-inaccessible-until-seal__observational-reconstruction-with-independent-runtime__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-common-total-carrier" &&
  SFT.Host.Text.equal (componentName c.component) "exact-positive-held-part" &&
  SFT.Host.Text.equal (normalizationName c.normalization) "common-One-normalization" &&
  SFT.Host.Text.equal (completenessName c.completeness) "every-generated-part-exhausts-One" &&
  SFT.Host.Text.equal (remainderName c.remainder) "unassigned-part-remainder" &&
  SFT.Host.Text.equal (absenceName c.absence) "empty-One-form" &&
  SFT.Host.Text.equal (refinementName c.refinement) "positive-parent-preserving-split" &&
  SFT.Host.Text.equal (scopeName c.scope) "all-finite-repartitions" &&
  SFT.Host.Text.equal (targetName c.target) "curvature-record-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "observational-reconstruction-with-independent-runtime" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-common-total-carrier") then "Independent totals need not form one conserved whole." else
  if !(SFT.Host.Text.equal (componentName c.component) "exact-positive-held-part") then "An unbound number is not a held part." else
  if !(SFT.Host.Text.equal (normalizationName c.normalization) "common-One-normalization") then "Separate normalizations cannot close jointly." else
  if !(SFT.Host.Text.equal (completenessName c.completeness) "every-generated-part-exhausts-One") then "A selected list can leave an unregistered remainder." else
  if !(SFT.Host.Text.equal (remainderName c.remainder) "unassigned-part-remainder") then "An extra scalar after exhaustion double-counts support." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "empty-One-form") then "Numerical zero is not an SFT proof carrier." else
  if !(SFT.Host.Text.equal (refinementName c.refinement) "positive-parent-preserving-split") then "A table has no general preservation law." else
  if !(SFT.Host.Text.equal (scopeName c.scope) "all-finite-repartitions") then "One epoch cannot force persistence." else
  if !(SFT.Host.Text.equal (targetName c.target) "curvature-record-inaccessible-until-seal") then "That would import the desired result." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "observational-reconstruction-with-independent-runtime") then "The prior flatness result was already observed." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An added rule is a free premise." else
  "Every finite complete exact positive cosmic-component partition closes to the One; the curvature remainder is the empty One form, and every positive parent-preserving refinement retains that result."

def generationRule : String := "Generate the complete product of total carrier, component identity, normalization, completeness, remainder role, absence representation, repartition, temporal scope, target custody, provenance and extension forms."
def grammarBoundary : String := "All finite exact positive cosmic-component partitions of one common total carrier and every finite positive refinement that preserves the parent part."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Component.rejected,Component.admitted]).flatMap fun component =>
  ([Normalization.rejected,Normalization.admitted]).flatMap fun normalization =>
  ([Completeness.rejected,Completeness.admitted]).flatMap fun completeness =>
  ([Remainder.rejected,Remainder.admitted]).flatMap fun remainder =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Refinement.rejected,Refinement.admitted]).flatMap fun refinement =>
  ([Scope.rejected,Scope.admitted]).flatMap fun scope =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,component,normalization,completeness,remainder,absence,refinement,scope,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier component normalization completeness remainder absence refinement scope target provenance extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomponent : component ∈ [Component.rejected,Component.admitted] := by
      cases component <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnormalization : normalization ∈ [Normalization.rejected,Normalization.admitted] := by
      cases normalization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcompleteness : completeness ∈ [Completeness.rejected,Completeness.admitted] := by
      cases completeness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hremainder : remainder ∈ [Remainder.rejected,Remainder.admitted] := by
      cases remainder <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrefinement : refinement ∈ [Refinement.rejected,Refinement.admitted] := by
      cases refinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscope : scope ∈ [Scope.rejected,Scope.admitted] := by
      cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ component _ hcomponent
    apply CommonRefinement.memFlatMap _ _ normalization _ hnormalization
    apply CommonRefinement.memFlatMap _ _ completeness _ hcompleteness
    apply CommonRefinement.memFlatMap _ _ remainder _ hremainder
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ refinement _ hrefinement
    apply CommonRefinement.memFlatMap _ _ scope _ hscope
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.CosmoSpatialFlatnessGrammar
