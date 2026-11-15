import SFT.Physics.ProtonRadius
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ProtonRadiusGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Particle where
  | rejected | admitted

def particleName : Particle → String
  | .rejected => "named-proton-without-composition"
  | .admitted => "admitted-uud-colour-three-proton"

inductive Orbit where
  | rejected | admitted

def orbitName : Orbit → String
  | .rejected => "inner-one-third-as-outer-edge"
  | .admitted => "outer-two-thirds-complement"

inductive Edge where
  | rejected | admitted

def edgeName : Edge → String
  | .rejected => "partial-colour-or-single-fibre-support"
  | .admitted => "all-three-colours-times-both-Fold-labels"

inductive Charge where
  | rejected0 | rejected1 | admitted

def chargeName : Charge → String
  | .rejected0 => "eight-nonreturn-mediators"
  | .rejected1 => "nine-internal-colour-pairs"
  | .admitted => "ten-internal-pairs-plus-unit-charge"

inductive Transport where
  | rejected0 | admitted | rejected2

def transportName : Transport → String
  | .rejected0 => "no-terminal-transport"
  | .admitted => "one-alpha-spatial-traversal"
  | .rejected2 => "alpha-squared-energy-composition"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "append-outward-free-share"
  | .admitted => "hold-inward-share-from-edge"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "full-cycle-or-fitted-length"
  | .admitted => "reduced-proton-Compton-postseal"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "probe-results-readable-before-seal"
  | .admitted => "capability-closed-before-target-release"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "claim-historical-blindness"
  | .admitted => "observational-derivation-explicit"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-form-factor-or-probe-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  particle : Particle
  orbit : Orbit
  edge : Edge
  charge : Charge
  transport : Transport
  orientation : Orientation
  scale : Scale
  target : Target
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [particleName c.particle, orbitName c.orbit, edgeName c.edge, chargeName c.charge, transportName c.transport, orientationName c.orientation, scaleName c.scale, targetName c.target, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "particle=" (particleName c.particle), SFT.Host.Text.append "orbit=" (orbitName c.orbit), SFT.Host.Text.append "edge=" (edgeName c.edge), SFT.Host.Text.append "charge=" (chargeName c.charge), SFT.Host.Text.append "transport=" (transportName c.transport), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "admitted-uud-colour-three-proton__outer-two-thirds-complement__all-three-colours-times-both-Fold-labels__ten-internal-pairs-plus-unit-charge__one-alpha-spatial-traversal__hold-inward-share-from-edge__reduced-proton-Compton-postseal__capability-closed-before-target-release__observational-derivation-explicit__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (particleName c.particle) "admitted-uud-colour-three-proton" &&
  SFT.Host.Text.equal (orbitName c.orbit) "outer-two-thirds-complement" &&
  SFT.Host.Text.equal (edgeName c.edge) "all-three-colours-times-both-Fold-labels" &&
  SFT.Host.Text.equal (chargeName c.charge) "ten-internal-pairs-plus-unit-charge" &&
  SFT.Host.Text.equal (transportName c.transport) "one-alpha-spatial-traversal" &&
  SFT.Host.Text.equal (orientationName c.orientation) "hold-inward-share-from-edge" &&
  SFT.Host.Text.equal (scaleName c.scale) "reduced-proton-Compton-postseal" &&
  SFT.Host.Text.equal (targetName c.target) "capability-closed-before-target-release" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "observational-derivation-explicit" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (particleName c.particle) "named-proton-without-composition" then "A particle name does not generate a radius." else
  if SFT.Host.Text.equal (orbitName c.orbit) "inner-one-third-as-outer-edge" then "The inner constituent site is not the composite edge." else
  if SFT.Host.Text.equal (edgeName c.edge) "partial-colour-or-single-fibre-support" then "Omitting a colour or Fold label loses a charged path." else
  if SFT.Host.Text.equal (chargeName c.charge) "eight-nonreturn-mediators" then "The mediator count omits the return and external charge roles." else
  if SFT.Host.Text.equal (chargeName c.charge) "nine-internal-colour-pairs" then "Internal pair support omits the proton's external unit charge." else
  if SFT.Host.Text.equal (transportName c.transport) "no-terminal-transport" then "This retains only the earlier leading structural radius." else
  if SFT.Host.Text.equal (transportName c.transport) "alpha-squared-energy-composition" then "Two traversals apply to energy self-composition, not a length boundary." else
  if SFT.Host.Text.equal (orientationName c.orientation) "append-outward-free-share" then "Appending a free share breaks the held bound-composite ledger." else
  if SFT.Host.Text.equal (scaleName c.scale) "full-cycle-or-fitted-length" then "A fitted length or full-cycle circumference double-counts the one-action radial carrier." else
  if SFT.Host.Text.equal (targetName c.target) "probe-results-readable-before-seal" then "That would fit the known radius puzzle." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "claim-historical-blindness" then "V1/V2 and the measurements were already known." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-form-factor-or-probe-correction" then "An added term would be a fitted parameter." else
  "The unique terminal dimensionless proton rms charge-radius coefficient is exactly 10069574419808/2519231977345 = 4(One-alpha_terminal/10). A dimensionful radius is obtained only after the seal by composing this coefficient with the registered reduced proton Compton wavelength. The coefficient contains no electron, muon or scattering-probe input."

def generationRule : String := "Generate the complete product of proton carrier, tripling orbit, colour/Fold edge support, internal/external charge support, electromagnetic transport order, retained orientation, one-action scale boundary, target custody, provenance and extension forms."
def grammarBoundary : String := "The admitted colour-three charged proton, its one-third/two-thirds tripling partition, both Fold labels, every ordered colour pair cell, the unique external unit charge, terminal alpha and the post-seal reduced proton Compton carrier."

def candidates : List Candidate :=
  ([Particle.rejected,Particle.admitted]).flatMap fun particle =>
  ([Orbit.rejected,Orbit.admitted]).flatMap fun orbit =>
  ([Edge.rejected,Edge.admitted]).flatMap fun edge =>
  ([Charge.rejected0,Charge.rejected1,Charge.admitted]).flatMap fun charge =>
  ([Transport.rejected0,Transport.admitted,Transport.rejected2]).flatMap fun transport =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨particle,orbit,edge,charge,transport,orientation,scale,target,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2304 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk particle orbit edge charge transport orientation scale target provenance extension =>
    have hparticle : particle ∈ [Particle.rejected,Particle.admitted] := by
      cases particle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horbit : orbit ∈ [Orbit.rejected,Orbit.admitted] := by
      cases orbit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hedge : edge ∈ [Edge.rejected,Edge.admitted] := by
      cases edge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcharge : charge ∈ [Charge.rejected0,Charge.rejected1,Charge.admitted] := by
      cases charge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransport : transport ∈ [Transport.rejected0,Transport.admitted,Transport.rejected2] := by
      cases transport <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ particle _ hparticle
    apply CommonRefinement.memFlatMap _ _ orbit _ horbit
    apply CommonRefinement.memFlatMap _ _ edge _ hedge
    apply CommonRefinement.memFlatMap _ _ charge _ hcharge
    apply CommonRefinement.memFlatMap _ _ transport _ htransport
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.ProtonRadiusGrammar
