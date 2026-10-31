import SFT.Physics.CosmicRatios
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.HubbleGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "independent-density-scalars"
  | .admitted => "one-complete-cosmic-carrier"

inductive Occupancy where
  | rejected | admitted

def occupancyName : Occupancy → String
  | .rejected => "named-matter-and-vacuum"
  | .admitted => "one-formed-class-and-two-fibre-open-complement"

inductive Partition where
  | rejected | admitted

def partitionName : Partition → String
  | .rejected => "selected-or-reversed-shares"
  | .admitted => "one-third-formed-two-thirds-open"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "free-calibration-scale"
  | .admitted => "complete-depth-three-Fold-support"

inductive Leading where
  | rejected | admitted

def leadingName : Leading → String
  | .rejected => "measured-ratio-correction"
  | .admitted => "open-share-over-complete-support"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "selected-cosmological-depth"
  | .admitted => "independently-forced-up-cover-depth"

inductive Orbit where
  | rejected | admitted

def orbitName : Orbit → String
  | .rejected => "arbitrary-denominator"
  | .admitted => "depth-seven-first-return-floor"

inductive Deepening where
  | rejected | admitted

def deepeningName : Deepening → String
  | .rejected => "selected-sign-or-extra-term"
  | .admitted => "one-positive-orbit-part-inside-open-share"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "hubble-values-readable-before-seal"
  | .admitted => "both-routes-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "mislabel-as-unobserved-discovery"
  | .admitted => "observational-reconstruction-with-independent-runtime"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-calibration-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  occupancy : Occupancy
  partition : Partition
  support : Support
  leading : Leading
  depth : Depth
  orbit : Orbit
  deepening : Deepening
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, occupancyName c.occupancy, partitionName c.partition, supportName c.support, leadingName c.leading, depthName c.depth, orbitName c.orbit, deepeningName c.deepening, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "occupancy=" (occupancyName c.occupancy), SFT.Host.Text.append "partition=" (partitionName c.partition), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "leading=" (leadingName c.leading), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "orbit=" (orbitName c.orbit), SFT.Host.Text.append "deepening=" (deepeningName c.deepening), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-complete-cosmic-carrier__one-formed-class-and-two-fibre-open-complement__one-third-formed-two-thirds-open__complete-depth-three-Fold-support__open-share-over-complete-support__independently-forced-up-cover-depth__depth-seven-first-return-floor__one-positive-orbit-part-inside-open-share__both-routes-inaccessible-until-seal__observational-reconstruction-with-independent-runtime__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-complete-cosmic-carrier" &&
  SFT.Host.Text.equal (occupancyName c.occupancy) "one-formed-class-and-two-fibre-open-complement" &&
  SFT.Host.Text.equal (partitionName c.partition) "one-third-formed-two-thirds-open" &&
  SFT.Host.Text.equal (supportName c.support) "complete-depth-three-Fold-support" &&
  SFT.Host.Text.equal (leadingName c.leading) "open-share-over-complete-support" &&
  SFT.Host.Text.equal (depthName c.depth) "independently-forced-up-cover-depth" &&
  SFT.Host.Text.equal (orbitName c.orbit) "depth-seven-first-return-floor" &&
  SFT.Host.Text.equal (deepeningName c.deepening) "one-positive-orbit-part-inside-open-share" &&
  SFT.Host.Text.equal (targetName c.target) "both-routes-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "observational-reconstruction-with-independent-runtime" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-complete-cosmic-carrier") then "Independent scalars do not close one conserved whole." else
  if !(SFT.Host.Text.equal (occupancyName c.occupancy) "one-formed-class-and-two-fibre-open-complement") then "Names do not force multiplicity or orientation." else
  if !(SFT.Host.Text.equal (partitionName c.partition) "one-third-formed-two-thirds-open") then "Selection or reversal loses the formed/open orientation." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-depth-three-Fold-support") then "A free scale is a fitted parameter." else
  if !(SFT.Host.Text.equal (leadingName c.leading) "open-share-over-complete-support") then "A measured correction would select the answer." else
  if !(SFT.Host.Text.equal (depthName c.depth) "independently-forced-up-cover-depth") then "A selected depth is a parameter." else
  if !(SFT.Host.Text.equal (orbitName c.orbit) "depth-seven-first-return-floor") then "An arbitrary denominator fits a correction." else
  if !(SFT.Host.Text.equal (deepeningName c.deepening) "one-positive-orbit-part-inside-open-share") then "A sign choice or external term is not forced." else
  if !(SFT.Host.Text.equal (targetName c.target) "both-routes-inaccessible-until-seal") then "That is fitting." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "observational-reconstruction-with-independent-runtime") then "The prior result was already observed." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An added rule is a free parameter." else
  "The exact matter/vacuum shares are 1/3 and 2/3; the leading correction and late/early ratio are 1/12 and 13/12; the unique registered depth-seven recurrence refinement is 3305/3048."

def generationRule : String := "Generate the complete product of cosmic carrier, occupancy distinction, partition, calibration support, leading correction, deep cover, recurrence floor, recursive correction, target custody, provenance and extension forms."
def grammarBoundary : String := "All exact leading and one-native-recurrence calibration ratios formed from the complete One, the Fold fibres, generator three, depth-three support and the independently forced depth-seven orbit."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Occupancy.rejected,Occupancy.admitted]).flatMap fun occupancy =>
  ([Partition.rejected,Partition.admitted]).flatMap fun partition =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Leading.rejected,Leading.admitted]).flatMap fun leading =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Orbit.rejected,Orbit.admitted]).flatMap fun orbit =>
  ([Deepening.rejected,Deepening.admitted]).flatMap fun deepening =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,occupancy,partition,support,leading,depth,orbit,deepening,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier occupancy partition support leading depth orbit deepening target provenance extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoccupancy : occupancy ∈ [Occupancy.rejected,Occupancy.admitted] := by
      cases occupancy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpartition : partition ∈ [Partition.rejected,Partition.admitted] := by
      cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hleading : leading ∈ [Leading.rejected,Leading.admitted] := by
      cases leading <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horbit : orbit ∈ [Orbit.rejected,Orbit.admitted] := by
      cases orbit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdeepening : deepening ∈ [Deepening.rejected,Deepening.admitted] := by
      cases deepening <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ occupancy _ hoccupancy
    apply CommonRefinement.memFlatMap _ _ partition _ hpartition
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ leading _ hleading
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ orbit _ horbit
    apply CommonRefinement.memFlatMap _ _ deepening _ hdeepening
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.HubbleGrammar
