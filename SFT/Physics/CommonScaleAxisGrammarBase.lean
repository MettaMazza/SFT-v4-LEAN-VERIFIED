import SFT.Physics.CommonScaleAxis
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CommonScaleAxisGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Origin where
  | rejected | admitted

def originName : Origin → String
  | .rejected => "numerical-zero-origin"
  | .admitted => "One-origin"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "linear-or-continuous-free-step"
  | .admitted => "binary-complete-support-successor"

inductive Spacing where
  | rejected | admitted

def spacingName : Spacing → String
  | .rejected => "untyped-arbitrary-spacing"
  | .admitted => "reciprocal-One-over-support-spacing"

inductive Transport where
  | rejected | admitted

def transportName : Transport → String
  | .rejected => "independent-free-running-axis"
  | .admitted => "one-local-act-per-support-cell"

inductive Sectors where
  | rejected | admitted

def sectorsName : Sectors → String
  | .rejected => "selected-known-sectors"
  | .admitted => "complete-prime-sector-ladder"

inductive Weak_curve where
  | rejected0 | rejected1 | admitted

def weak_curveName : Weak_curve → String
  | .rejected0 => "linear-channel-ratio"
  | .rejected1 => "target-assigned-angle"
  | .admitted => "neutral-square-over-charged-plus-neutral-squares"

inductive Terminal where
  | rejected | admitted

def terminalName : Terminal → String
  | .rejected => "identify-active-level-with-full-support"
  | .admitted => "support-sixteen-hold-three-return-alpha-over-seventeen"

inductive Anchor where
  | rejected | admitted

def anchorName : Anchor → String
  | .rejected => "target-selected-depth"
  | .admitted => "unique-support-two-source-four"

inductive Units where
  | rejected | admitted

def unitsName : Units → String
  | .rejected => "unit-name-changes-dimensionless-law"
  | .admitted => "common-positive-rational-rescaling-cancels"

inductive Placement where
  | rejected | admitted

def placementName : Placement → String
  | .rejected => "measured-rung-or-free-unit-selects-law"
  | .admitted => "forced-ratio-then-postseal-held-reference"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "target-readable-before-seal"
  | .admitted => "capability-closed-before-target-release"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "claim-historical-blindness"
  | .admitted => "observational-development-explicit"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-scale-or-running-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  origin : Origin
  successor : Successor
  spacing : Spacing
  transport : Transport
  sectors : Sectors
  weak_curve : Weak_curve
  terminal : Terminal
  anchor : Anchor
  units : Units
  placement : Placement
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [originName c.origin, successorName c.successor, spacingName c.spacing, transportName c.transport, sectorsName c.sectors, weak_curveName c.weak_curve, terminalName c.terminal, anchorName c.anchor, unitsName c.units, placementName c.placement, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "origin=" (originName c.origin), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "spacing=" (spacingName c.spacing), SFT.Host.Text.append "transport=" (transportName c.transport), SFT.Host.Text.append "sectors=" (sectorsName c.sectors), SFT.Host.Text.append "weak_curve=" (weak_curveName c.weak_curve), SFT.Host.Text.append "terminal=" (terminalName c.terminal), SFT.Host.Text.append "anchor=" (anchorName c.anchor), SFT.Host.Text.append "units=" (unitsName c.units), SFT.Host.Text.append "placement=" (placementName c.placement), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "One-origin__binary-complete-support-successor__reciprocal-One-over-support-spacing__one-local-act-per-support-cell__complete-prime-sector-ladder__neutral-square-over-charged-plus-neutral-squares__support-sixteen-hold-three-return-alpha-over-seventeen__unique-support-two-source-four__common-positive-rational-rescaling-cancels__forced-ratio-then-postseal-held-reference__capability-closed-before-target-release__observational-development-explicit__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (originName c.origin) "One-origin" &&
  SFT.Host.Text.equal (successorName c.successor) "binary-complete-support-successor" &&
  SFT.Host.Text.equal (spacingName c.spacing) "reciprocal-One-over-support-spacing" &&
  SFT.Host.Text.equal (transportName c.transport) "one-local-act-per-support-cell" &&
  SFT.Host.Text.equal (sectorsName c.sectors) "complete-prime-sector-ladder" &&
  SFT.Host.Text.equal (weak_curveName c.weak_curve) "neutral-square-over-charged-plus-neutral-squares" &&
  SFT.Host.Text.equal (terminalName c.terminal) "support-sixteen-hold-three-return-alpha-over-seventeen" &&
  SFT.Host.Text.equal (anchorName c.anchor) "unique-support-two-source-four" &&
  SFT.Host.Text.equal (unitsName c.units) "common-positive-rational-rescaling-cancels" &&
  SFT.Host.Text.equal (placementName c.placement) "forced-ratio-then-postseal-held-reference" &&
  SFT.Host.Text.equal (targetName c.target) "capability-closed-before-target-release" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "observational-development-explicit" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (originName c.origin) "numerical-zero-origin" then "Semantic numerical zero is not an SFT scale carrier." else
  if SFT.Host.Text.equal (successorName c.successor) "linear-or-continuous-free-step" then "A free or continuous step is not generated by Fold." else
  if SFT.Host.Text.equal (spacingName c.spacing) "untyped-arbitrary-spacing" then "Arbitrary spacing loses the common exact ratio." else
  if SFT.Host.Text.equal (transportName c.transport) "independent-free-running-axis" then "A second arbitrary axis breaks one-cell propagation." else
  if SFT.Host.Text.equal (sectorsName c.sectors) "selected-known-sectors" then "Selecting familiar sectors omits forced penta/hepta predictions." else
  if SFT.Host.Text.equal (weak_curveName c.weak_curve) "linear-channel-ratio" then "Channel amplitudes require squared support." else
  if SFT.Host.Text.equal (weak_curveName c.weak_curve) "target-assigned-angle" then "A measured angle cannot select the law." else
  if SFT.Host.Text.equal (terminalName c.terminal) "identify-active-level-with-full-support" then "Three held generator directions would be omitted." else
  if SFT.Host.Text.equal (anchorName c.anchor) "target-selected-depth" then "A measurement cannot assign the internal landmark." else
  if SFT.Host.Text.equal (unitsName c.units) "unit-name-changes-dimensionless-law" then "A held reference cannot change a like-dimension ratio." else
  if SFT.Host.Text.equal (placementName c.placement) "measured-rung-or-free-unit-selects-law" then "A target-selected rung or calibration would be a free parameter." else
  if SFT.Host.Text.equal (targetName c.target) "target-readable-before-seal" then "That would fit the known running vector." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "claim-historical-blindness" then "The V1/V2 observations and physical measurements were known." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-scale-or-running-correction" then "An unforced addition would violate zero parameters." else
  "One exact common scale axis is forced: supports 1,2,4,8,...; spacings One, half-One, quarter-One, eighth-One,...; and every forced prime sector uses the same support. The electroweak leading curve is w(R)=(R+2)^2/[4(R+1)^2+(R+2)^2]. Terminal support sixteen holds three directions, forcing active level thirteen, w(13)=225/1009 and the separately typed alpha/17 return, exactly reproducing the admitted terminal on-shell share. The unique internal power anchor is support two. Common exact unit rescaling leaves every dimensionless result unchanged; physical magnitudes are transported only through sealed exact ratios and a post-seal held reference."

def generationRule : String := "Generate the complete product of foundation origin, scale successor, order/spacing relation, local propagation transport, sector domain, electroweak squared-support form, terminal held-support completion, internal anchor, unit transformation, absolute-ratio placement, target custody, provenance disclosure and extension form."
def grammarBoundary : String := "The One, every positive finite binary support successor, reciprocal exact spacing, one-cell causal transport, all four forced prime sectors, binary charged and neutral Fold fibres, terminal support sixteen with three held directions and one alpha return, every common positive rational unit rescaling, the exact proton-Planck scale ratio and the complete registered post-seal coupling vector."

def candidates : List Candidate :=
  ([Origin.rejected,Origin.admitted]).flatMap fun origin =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Spacing.rejected,Spacing.admitted]).flatMap fun spacing =>
  ([Transport.rejected,Transport.admitted]).flatMap fun transport =>
  ([Sectors.rejected,Sectors.admitted]).flatMap fun sectors =>
  ([Weak_curve.rejected0,Weak_curve.rejected1,Weak_curve.admitted]).flatMap fun weak_curve =>
  ([Terminal.rejected,Terminal.admitted]).flatMap fun terminal =>
  ([Anchor.rejected,Anchor.admitted]).flatMap fun anchor =>
  ([Units.rejected,Units.admitted]).flatMap fun units =>
  ([Placement.rejected,Placement.admitted]).flatMap fun placement =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨origin,successor,spacing,transport,sectors,weak_curve,terminal,anchor,units,placement,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 12288 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk origin successor spacing transport sectors weak_curve terminal anchor units placement target provenance extension =>
    have horigin : origin ∈ [Origin.rejected,Origin.admitted] := by
      cases origin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspacing : spacing ∈ [Spacing.rejected,Spacing.admitted] := by
      cases spacing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransport : transport ∈ [Transport.rejected,Transport.admitted] := by
      cases transport <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsectors : sectors ∈ [Sectors.rejected,Sectors.admitted] := by
      cases sectors <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hweak_curve : weak_curve ∈ [Weak_curve.rejected0,Weak_curve.rejected1,Weak_curve.admitted] := by
      cases weak_curve <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterminal : terminal ∈ [Terminal.rejected,Terminal.admitted] := by
      cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hanchor : anchor ∈ [Anchor.rejected,Anchor.admitted] := by
      cases anchor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunits : units ∈ [Units.rejected,Units.admitted] := by
      cases units <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hplacement : placement ∈ [Placement.rejected,Placement.admitted] := by
      cases placement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ origin _ horigin
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    apply CommonRefinement.memFlatMap _ _ spacing _ hspacing
    apply CommonRefinement.memFlatMap _ _ transport _ htransport
    apply CommonRefinement.memFlatMap _ _ sectors _ hsectors
    apply CommonRefinement.memFlatMap _ _ weak_curve _ hweak_curve
    apply CommonRefinement.memFlatMap _ _ terminal _ hterminal
    apply CommonRefinement.memFlatMap _ _ anchor _ hanchor
    apply CommonRefinement.memFlatMap _ _ units _ hunits
    apply CommonRefinement.memFlatMap _ _ placement _ hplacement
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.CommonScaleAxisGrammar
