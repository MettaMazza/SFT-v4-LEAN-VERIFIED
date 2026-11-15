import SFT.Physics.ParkerProtonEnergy
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ParkerProtonEnergyGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Particle where
  | rejected | admitted

def particleName : Particle → String
  | .rejected => "named-proton-without-composition"
  | .admitted => "admitted-three-colour-proton"

inductive Alpha where
  | rejected | admitted

def alphaName : Alpha → String
  | .rejected => "selected-leading-alpha-rung"
  | .admitted => "complete-terminal-alpha-rung"

inductive Channels where
  | rejected0 | admitted | rejected2 | rejected3

def channelsName : Channels → String
  | .rejected0 => "weak-three-channels"
  | .admitted => "colour-eight-channels"
  | .rejected2 => "penta-twenty-four-channels"
  | .rejected3 => "hepta-forty-eight-channels"

inductive Power where
  | rejected0 | admitted | rejected2

def powerName : Power → String
  | .rejected0 => "linear-alpha-amplitude"
  | .admitted => "alpha-squared-energy"
  | .rejected2 => "alpha-cubed-extra-interaction"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "add-or-average-channel-shares"
  | .admitted => "complete-channel-count-times-energy-share"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "local-plasma-fit-or-free-energy"
  | .admitted => "proton-own-rest-energy-postseal"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "Parker-range-readable-before-seal"
  | .admitted => "capability-closed-before-Parker-release"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "claim-new-blind-discovery"
  | .admitted => "observational-derivation-explicit"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "treat-approximately-400-as-exact-cutoff"
  | .admitted => "complete-reported-range-and-limitations"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-local-factor-or-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  particle : Particle
  alpha : Alpha
  channels : Channels
  power : Power
  composition : Composition
  scale : Scale
  target : Target
  provenance : Provenance
  comparison : Comparison
  extension : Extension

def sourceFields (c : Candidate) : List String := [particleName c.particle, alphaName c.alpha, channelsName c.channels, powerName c.power, compositionName c.composition, scaleName c.scale, targetName c.target, provenanceName c.provenance, comparisonName c.comparison, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "particle=" (particleName c.particle), SFT.Host.Text.append "alpha=" (alphaName c.alpha), SFT.Host.Text.append "channels=" (channelsName c.channels), SFT.Host.Text.append "power=" (powerName c.power), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "admitted-three-colour-proton__complete-terminal-alpha-rung__colour-eight-channels__alpha-squared-energy__complete-channel-count-times-energy-share__proton-own-rest-energy-postseal__capability-closed-before-Parker-release__observational-derivation-explicit__complete-reported-range-and-limitations__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (particleName c.particle) "admitted-three-colour-proton" &&
  SFT.Host.Text.equal (alphaName c.alpha) "complete-terminal-alpha-rung" &&
  SFT.Host.Text.equal (channelsName c.channels) "colour-eight-channels" &&
  SFT.Host.Text.equal (powerName c.power) "alpha-squared-energy" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-channel-count-times-energy-share" &&
  SFT.Host.Text.equal (scaleName c.scale) "proton-own-rest-energy-postseal" &&
  SFT.Host.Text.equal (targetName c.target) "capability-closed-before-Parker-release" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "observational-derivation-explicit" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "complete-reported-range-and-limitations" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (particleName c.particle) "named-proton-without-composition" then "A name does not generate its interaction support." else
  if SFT.Host.Text.equal (alphaName c.alpha) "selected-leading-alpha-rung" then "The leading rung is retained as a historical control but is not the completed promotion object." else
  if SFT.Host.Text.equal (channelsName c.channels) "weak-three-channels" then "The binary-sector mediator count does not match proton colour." else
  if SFT.Host.Text.equal (channelsName c.channels) "penta-twenty-four-channels" then "The penta-sector count belongs to a different forced sector." else
  if SFT.Host.Text.equal (channelsName c.channels) "hepta-forty-eight-channels" then "The hepta-sector count belongs to a different forced sector." else
  if SFT.Host.Text.equal (powerName c.power) "linear-alpha-amplitude" then "A single amplitude is not an energy self-composition." else
  if SFT.Host.Text.equal (powerName c.power) "alpha-cubed-extra-interaction" then "A third coupling is an unforced extra interaction." else
  if SFT.Host.Text.equal (compositionName c.composition) "add-or-average-channel-shares" then "Addition or averaging changes the complete channel multiplicity." else
  if SFT.Host.Text.equal (scaleName c.scale) "local-plasma-fit-or-free-energy" then "A local field or density would be a fitted environmental parameter." else
  if SFT.Host.Text.equal (targetName c.target) "Parker-range-readable-before-seal" then "That would permit formula selection by the observation." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "claim-new-blind-discovery" then "V2 and the Parker report were already known during V3 reconstruction." else
  if SFT.Host.Text.equal (comparisonName c.comparison) "treat-approximately-400-as-exact-cutoff" then "The paper reports an approximate energy reach and no uncertainty on 400 keV." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-local-factor-or-correction" then "A free local factor would fit the event." else
  "The terminal structural proton-energy fraction is exactly 108147617771025486368/253861190227103943729961 = 8 alpha_terminal^2. The superseded leading-rung prediction 500000/1173679081 is retained as an exact historical control.  External proton mass and Parker observations remain inaccessible until the derivation seal."

def generationRule : String := "Generate the complete product of proton identity, alpha stage, all four forced mediator-sector counts, amplitude/energy/cubic powers, typed composition, rest-scale carrier, prediction custody, provenance, external comparison and extension forms."
def grammarBoundary : String := "The admitted proton, all forced sectors two/three/five/seven and their mediator counts, the leading and terminal exact alpha rungs, powers one through three, and a post-seal proton-rest-energy/Parker comparison."

def candidates : List Candidate :=
  ([Particle.rejected,Particle.admitted]).flatMap fun particle =>
  ([Alpha.rejected,Alpha.admitted]).flatMap fun alpha =>
  ([Channels.rejected0,Channels.admitted,Channels.rejected2,Channels.rejected3]).flatMap fun channels =>
  ([Power.rejected0,Power.admitted,Power.rejected2]).flatMap fun power =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨particle,alpha,channels,power,composition,scale,target,provenance,comparison,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 3072 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk particle alpha channels power composition scale target provenance comparison extension =>
    have hparticle : particle ∈ [Particle.rejected,Particle.admitted] := by
      cases particle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have halpha : alpha ∈ [Alpha.rejected,Alpha.admitted] := by
      cases alpha <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchannels : channels ∈ [Channels.rejected0,Channels.admitted,Channels.rejected2,Channels.rejected3] := by
      cases channels <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpower : power ∈ [Power.rejected0,Power.admitted,Power.rejected2] := by
      cases power <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ particle _ hparticle
    apply CommonRefinement.memFlatMap _ _ alpha _ halpha
    apply CommonRefinement.memFlatMap _ _ channels _ hchannels
    apply CommonRefinement.memFlatMap _ _ power _ hpower
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.ParkerProtonEnergyGrammar
