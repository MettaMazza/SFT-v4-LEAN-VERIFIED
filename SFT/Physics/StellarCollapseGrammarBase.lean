import SFT.Physics.StellarCollapseCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.StellarCollapseGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Stage where
  | rejected | admitted

def stageName : Stage → String
  | .rejected => "named-stage-list"
  | .admitted => "positive-Fold-stage-successor"

inductive Barrier where
  | rejected | admitted

def barrierName : Barrier → String
  | .rejected => "one-universal-dimensional-temperature"
  | .admitted => "strictly-growing-charged-boundary-paths"

inductive Release where
  | rejected | admitted

def releaseName : Release → String
  | .rejected => "fusion-past-peak-by-assertion"
  | .admitted => "only-toward-higher-binding"

inductive Terminal where
  | rejected | admitted

def terminalName : Terminal → String
  | .rejected => "selected-iron-name"
  | .admitted => "unique-all-mass-62-28-binding-maximum"

inductive Nesting where
  | rejected | admitted

def nestingName : Nesting → String
  | .rejected => "unordered-mixed-shells"
  | .admitted => "strictly-nested-access-support"

inductive Loss where
  | rejected | admitted

def lossName : Loss → String
  | .rejected => "hidden-residual-fusion-energy"
  | .admitted => "empty-One-fusion-support-with-gravity-retained"

inductive Collapse where
  | rejected | admitted

def collapseName : Collapse → String
  | .rejected => "single-selected-remnant"
  | .admitted => "compressed-nuclear-support-or-horizon"

inductive Thermonuclear where
  | rejected | admitted

def thermonuclearName : Thermonuclear → String
  | .rejected => "chosen-partial-burn"
  | .admitted => "runaway-to-finite-fuel-exhaustion"

inductive Capture where
  | rejected | admitted

def captureName : Capture → String
  | .rejected => "charged-fusion-beyond-maximum"
  | .admitted => "neutral-capture-with-empty-charge-path"

inductive Rebalance where
  | rejected | admitted

def rebalanceName : Rebalance → String
  | .rejected => "unrecorded-charge-change"
  | .admitted => "registered-radioactive-label-successor"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-readable-before-seal"
  | .admitted => "all-targets-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-channel-or-energy"
  | .admitted => "no-extra-rule"

structure Candidate where
  stage : Stage
  barrier : Barrier
  release : Release
  terminal : Terminal
  nesting : Nesting
  loss : Loss
  collapse : Collapse
  thermonuclear : Thermonuclear
  capture : Capture
  rebalance : Rebalance
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [stageName c.stage, barrierName c.barrier, releaseName c.release, terminalName c.terminal, nestingName c.nesting, lossName c.loss, collapseName c.collapse, thermonuclearName c.thermonuclear, captureName c.capture, rebalanceName c.rebalance, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "stage=" (stageName c.stage), SFT.Host.Text.append "barrier=" (barrierName c.barrier), SFT.Host.Text.append "release=" (releaseName c.release), SFT.Host.Text.append "terminal=" (terminalName c.terminal), SFT.Host.Text.append "nesting=" (nestingName c.nesting), SFT.Host.Text.append "loss=" (lossName c.loss), SFT.Host.Text.append "collapse=" (collapseName c.collapse), SFT.Host.Text.append "thermonuclear=" (thermonuclearName c.thermonuclear), SFT.Host.Text.append "capture=" (captureName c.capture), SFT.Host.Text.append "rebalance=" (rebalanceName c.rebalance), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "positive-Fold-stage-successor__strictly-growing-charged-boundary-paths__only-toward-higher-binding__unique-all-mass-62-28-binding-maximum__strictly-nested-access-support__empty-One-fusion-support-with-gravity-retained__compressed-nuclear-support-or-horizon__runaway-to-finite-fuel-exhaustion__neutral-capture-with-empty-charge-path__registered-radioactive-label-successor__all-targets-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (stageName c.stage) "positive-Fold-stage-successor" &&
  SFT.Host.Text.equal (barrierName c.barrier) "strictly-growing-charged-boundary-paths" &&
  SFT.Host.Text.equal (releaseName c.release) "only-toward-higher-binding" &&
  SFT.Host.Text.equal (terminalName c.terminal) "unique-all-mass-62-28-binding-maximum" &&
  SFT.Host.Text.equal (nestingName c.nesting) "strictly-nested-access-support" &&
  SFT.Host.Text.equal (lossName c.loss) "empty-One-fusion-support-with-gravity-retained" &&
  SFT.Host.Text.equal (collapseName c.collapse) "compressed-nuclear-support-or-horizon" &&
  SFT.Host.Text.equal (thermonuclearName c.thermonuclear) "runaway-to-finite-fuel-exhaustion" &&
  SFT.Host.Text.equal (captureName c.capture) "neutral-capture-with-empty-charge-path" &&
  SFT.Host.Text.equal (rebalanceName c.rebalance) "registered-radioactive-label-successor" &&
  SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (stageName c.stage) "positive-Fold-stage-successor") then "A named observational list is not a derivation." else
  if !(SFT.Host.Text.equal (barrierName c.barrier) "strictly-growing-charged-boundary-paths") then "One selected temperature erases reaction-specific structure." else
  if !(SFT.Host.Text.equal (releaseName c.release) "only-toward-higher-binding") then "Fusion past the maximum cannot release binding support." else
  if !(SFT.Host.Text.equal (terminalName c.terminal) "unique-all-mass-62-28-binding-maximum") then "A conventional name cannot select the endpoint." else
  if !(SFT.Host.Text.equal (nestingName c.nesting) "strictly-nested-access-support") then "Higher access cannot occupy a larger lower-access support." else
  if !(SFT.Host.Text.equal (lossName c.loss) "empty-One-fusion-support-with-gravity-retained") then "An ungenerated residual is a free source." else
  if !(SFT.Host.Text.equal (collapseName c.collapse) "compressed-nuclear-support-or-horizon") then "Selecting one outcome omits the distinct support boundary." else
  if !(SFT.Host.Text.equal (thermonuclearName c.thermonuclear) "runaway-to-finite-fuel-exhaustion") then "A partial terminal is not fixed under positive feedback." else
  if !(SFT.Host.Text.equal (captureName c.capture) "neutral-capture-with-empty-charge-path") then "That requires inward energy and a Coulomb path." else
  if !(SFT.Host.Text.equal (rebalanceName c.rebalance) "registered-radioactive-label-successor") then "An unrecorded change violates label conservation." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal") then "That would fit the channel census." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An ungenerated term destroys zero-parameter closure." else
  "Charged access paths are exactly n(n+1) and strictly increase for every positive stage successor; finite stage supports are strictly nested. Exothermic ordinary fusion terminates at the independently forced global binding maximum (mass 62, charge 28, neutron count 34), beyond which its release is the empty One form. Retained inward gravity then forces the support-loss collapse channel, with compressed nuclear support and horizon closure as the complete endpoints. The distinct linked-fuel recurrence has no interior fixed point and ends only at finite fuel exhaustion, forcing thermonuclear unbinding. Neutral capture has the empty inter-boundary charge path; repeated capture followed by registered radioactive rebalance forces the heavy-element channel beyond the ordinary-fusion terminal. Dimensional ignition temperatures and observed events remain post-seal checks."

def generationRule : String := "Generate the complete twelve-axis product of stage composition, charged boundary order, release direction, global binding terminal, nested support, fusion-support loss, collapse endpoint, thermonuclear recurrence, neutral capture, radioactive rebalance, target custody and extension forms."
def grammarBoundary : String := "Every positive finite stage count and successor; complete charged boundary paths; the inherited all-mass binding maximum and tail induction; half-One hydrostatic shares; empty-One absence of release; both compressed support and horizon endpoint classes; every finite fuel recurrence; neutral incident capture followed by registered radioactive rebalance; and no stellar or supernova target before seal."

def candidates : List Candidate :=
  ([Stage.rejected,Stage.admitted]).flatMap fun stage =>
  ([Barrier.rejected,Barrier.admitted]).flatMap fun barrier =>
  ([Release.rejected,Release.admitted]).flatMap fun release =>
  ([Terminal.rejected,Terminal.admitted]).flatMap fun terminal =>
  ([Nesting.rejected,Nesting.admitted]).flatMap fun nesting =>
  ([Loss.rejected,Loss.admitted]).flatMap fun loss =>
  ([Collapse.rejected,Collapse.admitted]).flatMap fun collapse =>
  ([Thermonuclear.rejected,Thermonuclear.admitted]).flatMap fun thermonuclear =>
  ([Capture.rejected,Capture.admitted]).flatMap fun capture =>
  ([Rebalance.rejected,Rebalance.admitted]).flatMap fun rebalance =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨stage,barrier,release,terminal,nesting,loss,collapse,thermonuclear,capture,rebalance,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk stage barrier release terminal nesting loss collapse thermonuclear capture rebalance measurement extension =>
    have hstage : stage ∈ [Stage.rejected,Stage.admitted] := by
      cases stage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbarrier : barrier ∈ [Barrier.rejected,Barrier.admitted] := by
      cases barrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelease : release ∈ [Release.rejected,Release.admitted] := by
      cases release <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hterminal : terminal ∈ [Terminal.rejected,Terminal.admitted] := by
      cases terminal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnesting : nesting ∈ [Nesting.rejected,Nesting.admitted] := by
      cases nesting <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hloss : loss ∈ [Loss.rejected,Loss.admitted] := by
      cases loss <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcollapse : collapse ∈ [Collapse.rejected,Collapse.admitted] := by
      cases collapse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthermonuclear : thermonuclear ∈ [Thermonuclear.rejected,Thermonuclear.admitted] := by
      cases thermonuclear <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcapture : capture ∈ [Capture.rejected,Capture.admitted] := by
      cases capture <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrebalance : rebalance ∈ [Rebalance.rejected,Rebalance.admitted] := by
      cases rebalance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ stage _ hstage
    apply CommonRefinement.memFlatMap _ _ barrier _ hbarrier
    apply CommonRefinement.memFlatMap _ _ release _ hrelease
    apply CommonRefinement.memFlatMap _ _ terminal _ hterminal
    apply CommonRefinement.memFlatMap _ _ nesting _ hnesting
    apply CommonRefinement.memFlatMap _ _ loss _ hloss
    apply CommonRefinement.memFlatMap _ _ collapse _ hcollapse
    apply CommonRefinement.memFlatMap _ _ thermonuclear _ hthermonuclear
    apply CommonRefinement.memFlatMap _ _ capture _ hcapture
    apply CommonRefinement.memFlatMap _ _ rebalance _ hrebalance
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.StellarCollapseGrammar
