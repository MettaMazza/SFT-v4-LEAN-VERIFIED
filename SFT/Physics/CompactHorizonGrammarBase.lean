import SFT.Physics.CompactHorizon
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CompactHorizonGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Occupation where
  | rejected | admitted

def occupationName : Occupation → String
  | .rejected => "multiply-occupied-cell"
  | .admitted => "one-fermion-per-generated-cell"

inductive Momentum where
  | rejected | admitted

def momentumName : Momentum → String
  | .rejected => "selected-momentum-scale"
  | .admitted => "cube-side-momentum-depth"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "imported-pressure-equation"
  | .admitted => "occupants-times-forced-depth-q4"

inductive Gravity where
  | rejected | admitted

def gravityName : Gravity → String
  | .rejected => "linear-unpaired-source"
  | .admitted => "paired-source-q6"

inductive Threshold where
  | rejected | admitted

def thresholdName : Threshold → String
  | .rejected => "chosen-dimensional-mass"
  | .admitted => "three-quarter-preimage-to-half-One"

inductive Endpoint where
  | rejected | admitted

def endpointName : Endpoint → String
  | .rejected => "open-ended-remnant-list"
  | .admitted => "exactly-two-binary-fibre-families"

inductive Radius where
  | rejected | admitted

def radiusName : Radius → String
  | .rejected => "imported-metric-radius"
  | .admitted => "one-Fold-mass-doubling"

inductive Area where
  | rejected | admitted

def areaName : Area → String
  | .rejected => "volume-support"
  | .admitted => "rank-two-radius-pair"

inductive Entropy where
  | rejected | admitted

def entropyName : Entropy → String
  | .rejected => "selected-entropy-coefficient"
  | .admitted => "quarter-area-boundary-record"

inductive Thermal where
  | rejected | admitted

def thermalName : Thermal → String
  | .rejected => "constant-or-fitted-temperature"
  | .admitted => "fixed-thermal-mass-product"

inductive Floor where
  | rejected | admitted

def floorName : Floor → String
  | .rejected => "numerical-zero-or-completed-infinity"
  | .admitted => "positive-finite-floor-at-every-reached-depth"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-family-or-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  occupation : Occupation
  momentum : Momentum
  support : Support
  gravity : Gravity
  threshold : Threshold
  endpoint : Endpoint
  radius : Radius
  area : Area
  entropy : Entropy
  thermal : Thermal
  floor : Floor
  extension : Extension

def sourceFields (c : Candidate) : List String := [occupationName c.occupation, momentumName c.momentum, supportName c.support, gravityName c.gravity, thresholdName c.threshold, endpointName c.endpoint, radiusName c.radius, areaName c.area, entropyName c.entropy, thermalName c.thermal, floorName c.floor, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "occupation=" (occupationName c.occupation), SFT.Host.Text.append "momentum=" (momentumName c.momentum), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "gravity=" (gravityName c.gravity), SFT.Host.Text.append "threshold=" (thresholdName c.threshold), SFT.Host.Text.append "endpoint=" (endpointName c.endpoint), SFT.Host.Text.append "radius=" (radiusName c.radius), SFT.Host.Text.append "area=" (areaName c.area), SFT.Host.Text.append "entropy=" (entropyName c.entropy), SFT.Host.Text.append "thermal=" (thermalName c.thermal), SFT.Host.Text.append "floor=" (floorName c.floor), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-fermion-per-generated-cell__cube-side-momentum-depth__occupants-times-forced-depth-q4__paired-source-q6__three-quarter-preimage-to-half-One__exactly-two-binary-fibre-families__one-Fold-mass-doubling__rank-two-radius-pair__quarter-area-boundary-record__fixed-thermal-mass-product__positive-finite-floor-at-every-reached-depth__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (occupationName c.occupation) "one-fermion-per-generated-cell" &&
  SFT.Host.Text.equal (momentumName c.momentum) "cube-side-momentum-depth" &&
  SFT.Host.Text.equal (supportName c.support) "occupants-times-forced-depth-q4" &&
  SFT.Host.Text.equal (gravityName c.gravity) "paired-source-q6" &&
  SFT.Host.Text.equal (thresholdName c.threshold) "three-quarter-preimage-to-half-One" &&
  SFT.Host.Text.equal (endpointName c.endpoint) "exactly-two-binary-fibre-families" &&
  SFT.Host.Text.equal (radiusName c.radius) "one-Fold-mass-doubling" &&
  SFT.Host.Text.equal (areaName c.area) "rank-two-radius-pair" &&
  SFT.Host.Text.equal (entropyName c.entropy) "quarter-area-boundary-record" &&
  SFT.Host.Text.equal (thermalName c.thermal) "fixed-thermal-mass-product" &&
  SFT.Host.Text.equal (floorName c.floor) "positive-finite-floor-at-every-reached-depth" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (occupationName c.occupation) "one-fermion-per-generated-cell") then "That violates the admitted exclusion law." else
  if !(SFT.Host.Text.equal (momentumName c.momentum) "cube-side-momentum-depth") then "A selected scale is a free parameter." else
  if !(SFT.Host.Text.equal (supportName c.support) "occupants-times-forced-depth-q4") then "An imported equation cannot select the Fold law." else
  if !(SFT.Host.Text.equal (gravityName c.gravity) "paired-source-q6") then "Gravity couples the complete source support to itself." else
  if !(SFT.Host.Text.equal (thresholdName c.threshold) "three-quarter-preimage-to-half-One") then "A measured mass cannot choose a structural threshold." else
  if !(SFT.Host.Text.equal (endpointName c.endpoint) "exactly-two-binary-fibre-families") then "An open list is not generated by the binary fibre." else
  if !(SFT.Host.Text.equal (radiusName c.radius) "one-Fold-mass-doubling") then "A conventional metric is not a premise." else
  if !(SFT.Host.Text.equal (areaName c.area) "rank-two-radius-pair") then "A volume count contradicts boundary rank two." else
  if !(SFT.Host.Text.equal (entropyName c.entropy) "quarter-area-boundary-record") then "A selected coefficient is an extra rule." else
  if !(SFT.Host.Text.equal (thermalName c.thermal) "fixed-thermal-mass-product") then "A constant or fitted temperature loses the scale recurrence." else
  if !(SFT.Host.Text.equal (floorName c.floor) "positive-finite-floor-at-every-reached-depth") then "Neither is an admissible Fold proof form." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An ungenerated addition destroys uniqueness." else
  "For every positive whole q, complete exclusion packing has q^3 occupants, forced momentum depth q, relativistic support q^4 and gravitational paired support q^6; q^6 is strictly greater after the exact base. The loaded exclusion threshold is 3/4 and its Fold balance is 1/2. Exactly two pre-horizon support families exist. For every positive exact mass m, horizon radius is 2m, area support is (2m)^2, entropy support is one quarter of that area, and temperature is 1/(16m), preserving exact product mT=1/16. At m=1/4 the admitted radius and temperature are respectively 1/2 and 1/4. Every finite halving emission trace retains positive mass, temperature, area and information support; no numerical zero or completed infinity enters."

def generationRule : String := "Generate the complete twelve-axis product of occupation, momentum, support scaling, gravity scaling, threshold, endpoint-family, horizon-radius, area, entropy, thermal, finite-floor and extension forms."
def grammarBoundary : String := "Every positive finite perfect-cube exclusion support and successor; the complete binary endpoint fibre; the admitted quarter-One horizon witness; every positive exact mass carrier; every finite binary emission depth; and the complete twelve-axis alternative product, with dimensional observations inaccessible."

def candidates : List Candidate :=
  ([Occupation.rejected,Occupation.admitted]).flatMap fun occupation =>
  ([Momentum.rejected,Momentum.admitted]).flatMap fun momentum =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Gravity.rejected,Gravity.admitted]).flatMap fun gravity =>
  ([Threshold.rejected,Threshold.admitted]).flatMap fun threshold =>
  ([Endpoint.rejected,Endpoint.admitted]).flatMap fun endpoint =>
  ([Radius.rejected,Radius.admitted]).flatMap fun radius =>
  ([Area.rejected,Area.admitted]).flatMap fun area =>
  ([Entropy.rejected,Entropy.admitted]).flatMap fun entropy =>
  ([Thermal.rejected,Thermal.admitted]).flatMap fun thermal =>
  ([Floor.rejected,Floor.admitted]).flatMap fun floor =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨occupation,momentum,support,gravity,threshold,endpoint,radius,area,entropy,thermal,floor,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk occupation momentum support gravity threshold endpoint radius area entropy thermal floor extension =>
    have hoccupation : occupation ∈ [Occupation.rejected,Occupation.admitted] := by
      cases occupation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmomentum : momentum ∈ [Momentum.rejected,Momentum.admitted] := by
      cases momentum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgravity : gravity ∈ [Gravity.rejected,Gravity.admitted] := by
      cases gravity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthreshold : threshold ∈ [Threshold.rejected,Threshold.admitted] := by
      cases threshold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hendpoint : endpoint ∈ [Endpoint.rejected,Endpoint.admitted] := by
      cases endpoint <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hradius : radius ∈ [Radius.rejected,Radius.admitted] := by
      cases radius <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have harea : area ∈ [Area.rejected,Area.admitted] := by
      cases area <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hentropy : entropy ∈ [Entropy.rejected,Entropy.admitted] := by
      cases entropy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hthermal : thermal ∈ [Thermal.rejected,Thermal.admitted] := by
      cases thermal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfloor : floor ∈ [Floor.rejected,Floor.admitted] := by
      cases floor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ occupation _ hoccupation
    apply CommonRefinement.memFlatMap _ _ momentum _ hmomentum
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ gravity _ hgravity
    apply CommonRefinement.memFlatMap _ _ threshold _ hthreshold
    apply CommonRefinement.memFlatMap _ _ endpoint _ hendpoint
    apply CommonRefinement.memFlatMap _ _ radius _ hradius
    apply CommonRefinement.memFlatMap _ _ area _ harea
    apply CommonRefinement.memFlatMap _ _ entropy _ hentropy
    apply CommonRefinement.memFlatMap _ _ thermal _ hthermal
    apply CommonRefinement.memFlatMap _ _ floor _ hfloor
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.CompactHorizonGrammar
