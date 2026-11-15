import SFT.Physics.ScatteringPartitionPath
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ScatteringPartitionPathGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Geometry where
  | rejected | admitted

def geometryName : Geometry → String
  | .rejected => "arbitrary-scatterer"
  | .admitted => "registered-one-target-Fold-geometry"

inductive Outcomes where
  | rejected | admitted

def outcomesName : Outcomes → String
  | .rejected => "sampled-or-omitted-channel"
  | .admitted => "complete-scatter-pass-pair"

inductive Exclusivity where
  | rejected | admitted

def exclusivityName : Exclusivity → String
  | .rejected => "overlapping-outcome-cells"
  | .admitted => "mutually-exclusive-held-labels"

inductive Measure where
  | rejected | admitted

def measureName : Measure → String
  | .rejected => "assumed-equal-probability"
  | .admitted => "equipotent-two-cell-support"

inductive Section where
  | rejected | admitted

def sectionName : Section → String
  | .rejected => "fitted-dimensional-number"
  | .admitted => "successful-over-incident-support"

inductive Density where
  | rejected | admitted

def densityName : Density → String
  | .rejected => "density-omitted"
  | .admitted => "positive-density-times-section"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "selected-path-length"
  | .admitted => "reciprocal-encounter-support"

inductive Cause where
  | rejected | admitted

def causeName : Cause → String
  | .rejected => "stochastic-transition-oracle"
  | .admitted => "deterministic-held-outcomes"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-geometry-or-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  geometry : Geometry
  outcomes : Outcomes
  exclusivity : Exclusivity
  measure : Measure
  «section» : Section
  density : Density
  path : Path
  cause : Cause
  extension : Extension

def sourceFields (c : Candidate) : List String := [geometryName c.geometry, outcomesName c.outcomes, exclusivityName c.exclusivity, measureName c.measure, sectionName c.«section», densityName c.density, pathName c.path, causeName c.cause, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "geometry=" (geometryName c.geometry), SFT.Host.Text.append "outcomes=" (outcomesName c.outcomes), SFT.Host.Text.append "exclusivity=" (exclusivityName c.exclusivity), SFT.Host.Text.append "measure=" (measureName c.measure), SFT.Host.Text.append "section=" (sectionName c.«section»), SFT.Host.Text.append "density=" (densityName c.density), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "cause=" (causeName c.cause), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "registered-one-target-Fold-geometry__complete-scatter-pass-pair__mutually-exclusive-held-labels__equipotent-two-cell-support__successful-over-incident-support__positive-density-times-section__reciprocal-encounter-support__deterministic-held-outcomes__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (geometryName c.geometry) "registered-one-target-Fold-geometry" &&
  SFT.Host.Text.equal (outcomesName c.outcomes) "complete-scatter-pass-pair" &&
  SFT.Host.Text.equal (exclusivityName c.exclusivity) "mutually-exclusive-held-labels" &&
  SFT.Host.Text.equal (measureName c.measure) "equipotent-two-cell-support" &&
  SFT.Host.Text.equal (sectionName c.«section») "successful-over-incident-support" &&
  SFT.Host.Text.equal (densityName c.density) "positive-density-times-section" &&
  SFT.Host.Text.equal (pathName c.path) "reciprocal-encounter-support" &&
  SFT.Host.Text.equal (causeName c.cause) "deterministic-held-outcomes" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (geometryName c.geometry) "arbitrary-scatterer" then "Arbitrary geometry does not force equal outcome cells." else
  if SFT.Host.Text.equal (outcomesName c.outcomes) "sampled-or-omitted-channel" then "An omitted channel cannot establish certainty." else
  if SFT.Host.Text.equal (exclusivityName c.exclusivity) "overlapping-outcome-cells" then "Overlap double-counts one event." else
  if SFT.Host.Text.equal (measureName c.measure) "assumed-equal-probability" then "An assumed probability imports the answer." else
  if SFT.Host.Text.equal (sectionName c.«section») "fitted-dimensional-number" then "A fitted number is not the structural measure." else
  if SFT.Host.Text.equal (densityName c.density) "density-omitted" then "Omitting density makes reciprocal path dimensionally incomplete." else
  if SFT.Host.Text.equal (pathName c.path) "selected-path-length" then "A selected length has no encounter trace." else
  if SFT.Host.Text.equal (causeName c.cause) "stochastic-transition-oracle" then "A random cause is not supplied by deterministic Fold structure." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-geometry-or-correction" then "A free correction defeats zero-parameter closure." else
  "The registered one-target Fold support partitions exactly into scatter half-One and pass half-One; cross section is successful/incident support; and mean free path is the exact reciprocal of positive density times cross section, with larger section forcing shorter path."

def generationRule : String := "Generate the complete product of target geometry, outcome support, exclusivity, outcome measure, cross-section measure, density, path, causal interpretation and extension forms."
def grammarBoundary : String := "The one-target geometry with exactly two equipotent Fold outcome cells; all positive finite incident/successful support counts; and all exact positive target densities and cross sections."

def candidates : List Candidate :=
  ([Geometry.rejected,Geometry.admitted]).flatMap fun geometry =>
  ([Outcomes.rejected,Outcomes.admitted]).flatMap fun outcomes =>
  ([Exclusivity.rejected,Exclusivity.admitted]).flatMap fun exclusivity =>
  ([Measure.rejected,Measure.admitted]).flatMap fun measure =>
  ([Section.rejected,Section.admitted]).flatMap fun «section» =>
  ([Density.rejected,Density.admitted]).flatMap fun density =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Cause.rejected,Cause.admitted]).flatMap fun cause =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨geometry,outcomes,exclusivity,measure,«section»,density,path,cause,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk geometry outcomes exclusivity measure «section» density path cause extension =>
    have hgeometry : geometry ∈ [Geometry.rejected,Geometry.admitted] := by
      cases geometry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have houtcomes : outcomes ∈ [Outcomes.rejected,Outcomes.admitted] := by
      cases outcomes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexclusivity : exclusivity ∈ [Exclusivity.rejected,Exclusivity.admitted] := by
      cases exclusivity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasure : measure ∈ [Measure.rejected,Measure.admitted] := by
      cases measure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsection : «section» ∈ [Section.rejected,Section.admitted] := by
      cases «section» <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdensity : density ∈ [Density.rejected,Density.admitted] := by
      cases density <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcause : cause ∈ [Cause.rejected,Cause.admitted] := by
      cases cause <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ geometry _ hgeometry
    apply CommonRefinement.memFlatMap _ _ outcomes _ houtcomes
    apply CommonRefinement.memFlatMap _ _ exclusivity _ hexclusivity
    apply CommonRefinement.memFlatMap _ _ measure _ hmeasure
    apply CommonRefinement.memFlatMap _ _ «section» _ hsection
    apply CommonRefinement.memFlatMap _ _ density _ hdensity
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ cause _ hcause
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.ScatteringPartitionPathGrammar
