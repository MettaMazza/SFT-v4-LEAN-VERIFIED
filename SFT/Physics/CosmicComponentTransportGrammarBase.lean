import SFT.Physics.CosmicComponentTransport
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CosmicComponentTransportGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Space where
  | rejected | admitted

def spaceName : Space → String
  | .rejected => "borrowed-three-dimensional-volume"
  | .admitted => "admitted-generator-three-volume"

inductive Matter where
  | rejected | admitted

def matterName : Matter → String
  | .rejected => "selected-matter-power"
  | .admitted => "inverse-volume-third-power"

inductive Radiation where
  | rejected | admitted

def radiationName : Radiation → String
  | .rejected => "selected-radiation-power"
  | .admitted => "volume-plus-one-recurrence-power"

inductive Vacuum where
  | rejected | admitted

def vacuumName : Vacuum → String
  | .rejected => "selected-static-density"
  | .admitted => "Fold-invariant-One"

inductive Expansion where
  | rejected | admitted

def expansionName : Expansion → String
  | .rejected => "superseded-two-thirds-curve"
  | .admitted => "terminal-eleven-five-curve"

inductive Fractions where
  | rejected | admitted

def fractionsName : Fractions → String
  | .rejected => "fitted-epoch-density"
  | .admitted => "component-over-complete-rate"

inductive Equality where
  | rejected | admitted

def equalityName : Equality → String
  | .rejected => "decimal-root-selected"
  | .admitted => "exact-cube-eleven-fifths"

inductive Acceleration where
  | rejected | admitted

def accelerationName : Acceleration → String
  | .rejected => "old-half-magnitude-and-four-cube"
  | .admitted => "exact-seventeen-thirty-seconds-and-twenty-two-fifths"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "negative-proof-scalars"
  | .admitted => "positive-magnitude-with-held-orientation"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "fitted-Hubble-normalization"
  | .admitted => "post-seal-held-reference-transport"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measurements-readable-before-seal"
  | .admitted => "all-targets-open-only-after-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-component-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  space : Space
  matter : Matter
  radiation : Radiation
  vacuum : Vacuum
  expansion : Expansion
  fractions : Fractions
  equality : Equality
  acceleration : Acceleration
  orientation : Orientation
  scale : Scale
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [spaceName c.space, matterName c.matter, radiationName c.radiation, vacuumName c.vacuum, expansionName c.expansion, fractionsName c.fractions, equalityName c.equality, accelerationName c.acceleration, orientationName c.orientation, scaleName c.scale, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "space=" (spaceName c.space), SFT.Host.Text.append "matter=" (matterName c.matter), SFT.Host.Text.append "radiation=" (radiationName c.radiation), SFT.Host.Text.append "vacuum=" (vacuumName c.vacuum), SFT.Host.Text.append "expansion=" (expansionName c.expansion), SFT.Host.Text.append "fractions=" (fractionsName c.fractions), SFT.Host.Text.append "equality=" (equalityName c.equality), SFT.Host.Text.append "acceleration=" (accelerationName c.acceleration), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "admitted-generator-three-volume__inverse-volume-third-power__volume-plus-one-recurrence-power__Fold-invariant-One__terminal-eleven-five-curve__component-over-complete-rate__exact-cube-eleven-fifths__exact-seventeen-thirty-seconds-and-twenty-two-fifths__positive-magnitude-with-held-orientation__post-seal-held-reference-transport__all-targets-open-only-after-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (spaceName c.space) "admitted-generator-three-volume" &&
  SFT.Host.Text.equal (matterName c.matter) "inverse-volume-third-power" &&
  SFT.Host.Text.equal (radiationName c.radiation) "volume-plus-one-recurrence-power" &&
  SFT.Host.Text.equal (vacuumName c.vacuum) "Fold-invariant-One" &&
  SFT.Host.Text.equal (expansionName c.expansion) "terminal-eleven-five-curve" &&
  SFT.Host.Text.equal (fractionsName c.fractions) "component-over-complete-rate" &&
  SFT.Host.Text.equal (equalityName c.equality) "exact-cube-eleven-fifths" &&
  SFT.Host.Text.equal (accelerationName c.acceleration) "exact-seventeen-thirty-seconds-and-twenty-two-fifths" &&
  SFT.Host.Text.equal (orientationName c.orientation) "positive-magnitude-with-held-orientation" &&
  SFT.Host.Text.equal (scaleName c.scale) "post-seal-held-reference-transport" &&
  SFT.Host.Text.equal (targetName c.target) "all-targets-open-only-after-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (spaceName c.space) "borrowed-three-dimensional-volume" then "Borrowing the exponent imports a premise." else
  if SFT.Host.Text.equal (matterName c.matter) "selected-matter-power" then "A selected exponent is a free law." else
  if SFT.Host.Text.equal (radiationName c.radiation) "selected-radiation-power" then "A selected fourth power is not derived." else
  if SFT.Host.Text.equal (vacuumName c.vacuum) "selected-static-density" then "A named cosmological constant cannot select invariance." else
  if SFT.Host.Text.equal (expansionName c.expansion) "superseded-two-thirds-curve" then "The leading budget is rejected by the admitted terminal discriminator." else
  if SFT.Host.Text.equal (fractionsName c.fractions) "fitted-epoch-density" then "An epoch fit is a parameter." else
  if SFT.Host.Text.equal (equalityName c.equality) "decimal-root-selected" then "A decimal root may be target-selected and irrational." else
  if SFT.Host.Text.equal (accelerationName c.acceleration) "old-half-magnitude-and-four-cube" then "The old result inherits a superseded budget." else
  if SFT.Host.Text.equal (orientationName c.orientation) "negative-proof-scalars" then "Negative scalars violate the Fold proof language." else
  if SFT.Host.Text.equal (scaleName c.scale) "fitted-Hubble-normalization" then "Fitting H0 to the chronometer rows would select the result." else
  if SFT.Host.Text.equal (targetName c.target) "measurements-readable-before-seal" then "Target access can manufacture the law." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-component-correction" then "An inserted coefficient is a fit." else
  "Matter, radiation and vacuum have respectively third-power, fourth-power and Fold-invariant transport. The terminal late-time law is E2(r)=(11+5r^3)/16; Omega_m(r)=5r^3/(11+5r^3); Omega_v(r)=11/(11+5r^3); matter-vacuum equality is r^3=11/5; acceleration onset is r^3=22/5; and the present accelerating magnitude is 17/32. The static-vacuum correspondence is tension of One magnitude. All quantities are exact positive whole/fractional Fold forms or typed empty/orientation structures."

def generationRule : String := "Generate the complete product of spatial carrier, matter transport, radiation transport, vacuum invariant, terminal expansion, density fractions, equality threshold, acceleration threshold, orientation typing, physical scale transport, target custody, prior-correction and extension forms."
def grammarBoundary : String := "Every positive exact rational stretch; the three matter/radiation/vacuum transport classes; the admitted terminal 5/16 and 11/16 late-time shares; every exact derived fraction and cube threshold; all thirty-two registered cosmic-chronometer rows; the registered acceleration, equation-of-state, Planck-ratio and DESI adverse rows; and no imported continuum or signed proof scalar."

def candidates : List Candidate :=
  ([Space.rejected,Space.admitted]).flatMap fun space =>
  ([Matter.rejected,Matter.admitted]).flatMap fun matter =>
  ([Radiation.rejected,Radiation.admitted]).flatMap fun radiation =>
  ([Vacuum.rejected,Vacuum.admitted]).flatMap fun vacuum =>
  ([Expansion.rejected,Expansion.admitted]).flatMap fun expansion =>
  ([Fractions.rejected,Fractions.admitted]).flatMap fun fractions =>
  ([Equality.rejected,Equality.admitted]).flatMap fun equality =>
  ([Acceleration.rejected,Acceleration.admitted]).flatMap fun acceleration =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨space,matter,radiation,vacuum,expansion,fractions,equality,acceleration,orientation,scale,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 4096 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk space matter radiation vacuum expansion fractions equality acceleration orientation scale target extension =>
    have hspace : space ∈ [Space.rejected,Space.admitted] := by
      cases space <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmatter : matter ∈ [Matter.rejected,Matter.admitted] := by
      cases matter <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hradiation : radiation ∈ [Radiation.rejected,Radiation.admitted] := by
      cases radiation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvacuum : vacuum ∈ [Vacuum.rejected,Vacuum.admitted] := by
      cases vacuum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexpansion : expansion ∈ [Expansion.rejected,Expansion.admitted] := by
      cases expansion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfractions : fractions ∈ [Fractions.rejected,Fractions.admitted] := by
      cases fractions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequality : equality ∈ [Equality.rejected,Equality.admitted] := by
      cases equality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacceleration : acceleration ∈ [Acceleration.rejected,Acceleration.admitted] := by
      cases acceleration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ space _ hspace
    apply CommonRefinement.memFlatMap _ _ matter _ hmatter
    apply CommonRefinement.memFlatMap _ _ radiation _ hradiation
    apply CommonRefinement.memFlatMap _ _ vacuum _ hvacuum
    apply CommonRefinement.memFlatMap _ _ expansion _ hexpansion
    apply CommonRefinement.memFlatMap _ _ fractions _ hfractions
    apply CommonRefinement.memFlatMap _ _ equality _ hequality
    apply CommonRefinement.memFlatMap _ _ acceleration _ hacceleration
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension


end SFT.Physics.CosmicComponentTransportGrammar
