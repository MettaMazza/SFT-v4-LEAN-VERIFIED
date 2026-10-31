import SFT.Physics.CosmoCompleteBudget
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CosmoCompleteBudgetGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "selected-density-denominator"
  | .admitted => "least-generator-volume-binary-cover"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "free-pinned-count"
  | .admitted => "complete-two-state-boundary-pair"

inductive Pinning where
  | rejected | admitted

def pinningName : Pinning → String
  | .rejected => "named-matter-share"
  | .admitted => "all-depth-boundary-pairs"

inductive Free where
  | rejected | admitted

def freeName : Free → String
  | .rejected => "selected-vacuum-share"
  | .admitted => "complete-unpinned-complement"

inductive Global where
  | rejected | admitted

def globalName : Global → String
  | .rejected => "leading-one-third-two-thirds-only"
  | .admitted => "five-sixteenths-and-eleven-sixteenths"

inductive Internal where
  | rejected | admitted

def internalName : Internal → String
  | .rejected => "new-baryon-dark-parameter"
  | .admitted => "admitted-five-to-twenty-seven-partition"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "independent-component-normalizations"
  | .admitted => "global-matter-times-internal-shares"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "separate-rounded-total"
  | .admitted => "exact-four-part-One-closure"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "planck-budget-readable-before-seal"
  | .admitted => "all-planck-rows-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "erase-leading-law-or-mislabel-discovery"
  | .admitted => "disclosed-successor-observational-reconstruction"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-budget-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  support : Support
  boundary : Boundary
  pinning : Pinning
  free : Free
  global : Global
  internal : Internal
  composition : Composition
  closure : Closure
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [supportName c.support, boundaryName c.boundary, pinningName c.pinning, freeName c.free, globalName c.global, internalName c.internal, compositionName c.composition, closureName c.closure, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "pinning=" (pinningName c.pinning), SFT.Host.Text.append "free=" (freeName c.free), SFT.Host.Text.append "global=" (globalName c.global), SFT.Host.Text.append "internal=" (internalName c.internal), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "least-generator-volume-binary-cover__complete-two-state-boundary-pair__all-depth-boundary-pairs__complete-unpinned-complement__five-sixteenths-and-eleven-sixteenths__admitted-five-to-twenty-seven-partition__global-matter-times-internal-shares__exact-four-part-One-closure__all-planck-rows-inaccessible-until-seal__disclosed-successor-observational-reconstruction__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "least-generator-volume-binary-cover" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "complete-two-state-boundary-pair" &&
  SFT.Host.Text.equal (pinningName c.pinning) "all-depth-boundary-pairs" &&
  SFT.Host.Text.equal (freeName c.free) "complete-unpinned-complement" &&
  SFT.Host.Text.equal (globalName c.global) "five-sixteenths-and-eleven-sixteenths" &&
  SFT.Host.Text.equal (internalName c.internal) "admitted-five-to-twenty-seven-partition" &&
  SFT.Host.Text.equal (compositionName c.composition) "global-matter-times-internal-shares" &&
  SFT.Host.Text.equal (closureName c.closure) "exact-four-part-One-closure" &&
  SFT.Host.Text.equal (targetName c.target) "all-planck-rows-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "disclosed-successor-observational-reconstruction" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "least-generator-volume-binary-cover") then "A selected denominator fits observations." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "complete-two-state-boundary-pair") then "A free count is a parameter." else
  if !(SFT.Host.Text.equal (pinningName c.pinning) "all-depth-boundary-pairs") then "A name does not construct a share." else
  if !(SFT.Host.Text.equal (freeName c.free) "complete-unpinned-complement") then "A selected share reads the target." else
  if !(SFT.Host.Text.equal (globalName c.global) "five-sixteenths-and-eleven-sixteenths") then "The earlier leading partition ignores the admitted depth-five boundary discriminator." else
  if !(SFT.Host.Text.equal (internalName c.internal) "admitted-five-to-twenty-seven-partition") then "A new ratio is free." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "global-matter-times-internal-shares") then "Independent denominators need not close." else
  if !(SFT.Host.Text.equal (closureName c.closure) "exact-four-part-One-closure") then "Rounded values cannot prove closure." else
  if !(SFT.Host.Text.equal (targetName c.target) "all-planck-rows-inaccessible-until-seal") then "That would fit four targets." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "disclosed-successor-observational-reconstruction") then "The leading law and later observed refinement must both remain visible." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An added rule is a free parameter." else
  "The refined present budget is vacuum 11/16, total matter 5/16, baryon 25/512 and cold dark 135/512; baryon plus cold dark equals matter and vacuum plus matter equals the One."

def generationRule : String := "Generate the complete product of support, boundary incidence, pinning, free complement, global partition, internal matter partition, composition, closure, target custody, provenance and extension forms."
def grammarBoundary : String := "All exact present-budget partitions formed from the least depth-five binary cover, one complete boundary pair per depth and the independently admitted five-to-twenty-seven matter partition."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Pinning.rejected,Pinning.admitted]).flatMap fun pinning =>
  ([Free.rejected,Free.admitted]).flatMap fun free =>
  ([Global.rejected,Global.admitted]).flatMap fun global =>
  ([Internal.rejected,Internal.admitted]).flatMap fun internal =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨support,boundary,pinning,free,global,internal,composition,closure,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support boundary pinning free global internal composition closure target provenance extension =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpinning : pinning ∈ [Pinning.rejected,Pinning.admitted] := by
      cases pinning <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfree : free ∈ [Free.rejected,Free.admitted] := by
      cases free <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hglobal : global ∈ [Global.rejected,Global.admitted] := by
      cases global <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinternal : internal ∈ [Internal.rejected,Internal.admitted] := by
      cases internal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ pinning _ hpinning
    apply CommonRefinement.memFlatMap _ _ free _ hfree
    apply CommonRefinement.memFlatMap _ _ global _ hglobal
    apply CommonRefinement.memFlatMap _ _ internal _ hinternal
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.CosmoCompleteBudgetGrammar
