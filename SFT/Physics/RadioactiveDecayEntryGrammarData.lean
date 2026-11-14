import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.RadioactiveDecayEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "rewrite-predecessor-laws"
  | .admitted => "compose-immutable-predecessors"

inductive Topology where
  | rejected | admitted

def topologyName : Topology → String
  | .rejected => "three-named-particles-only"
  | .admitted => "three-structural-transition-topologies"

inductive Alpha where
  | rejected | admitted

def alphaName : Alpha → String
  | .rejected => "borrowed-alpha-name"
  | .admitted => "binary-square-cluster-boundary-release"

inductive Beta where
  | rejected | admitted

def betaName : Beta → String
  | .rejected => "stochastic-particle-appearance"
  | .admitted => "held-label-conversion-with-lepton-records"

inductive Gamma where
  | rejected | admitted

def gammaName : Gamma → String
  | .rejected => "continuum-energy-leak"
  | .admitted => "internal-level-lowering-with-radiative-record"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "declare-each-a-new-primitive"
  | .admitted => "compose-the-three-primitive-traces"

inductive Survival where
  | rejected | admitted

def survivalName : Survival → String
  | .rejected => "import-continuum-exponential"
  | .admitted => "positive-rational-binary-geometric"

inductive Determinism where
  | rejected | admitted

def determinismName : Determinism → String
  | .rejected => "unrecorded-random-choice"
  | .admitted => "deterministic-hidden-path-partition"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-target-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-rate-or-extra-primitive"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  topology : Topology
  alpha : Alpha
  beta : Beta
  gamma : Gamma
  composition : Composition
  survival : Survival
  determinism : Determinism
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, topologyName c.topology, alphaName c.alpha, betaName c.beta, gammaName c.gamma, compositionName c.composition, survivalName c.survival, determinismName c.determinism, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "topology=" (topologyName c.topology), SFT.Host.Text.append "alpha=" (alphaName c.alpha), SFT.Host.Text.append "beta=" (betaName c.beta), SFT.Host.Text.append "gamma=" (gammaName c.gamma), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "survival=" (survivalName c.survival), SFT.Host.Text.append "determinism=" (determinismName c.determinism), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-predecessors__three-structural-transition-topologies__binary-square-cluster-boundary-release__held-label-conversion-with-lepton-records__internal-level-lowering-with-radiative-record__compose-the-three-primitive-traces__positive-rational-binary-geometric__deterministic-hidden-path-partition__target-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-predecessors" &&
  SFT.Host.Text.equal (topologyName c.topology) "three-structural-transition-topologies" &&
  SFT.Host.Text.equal (alphaName c.alpha) "binary-square-cluster-boundary-release" &&
  SFT.Host.Text.equal (betaName c.beta) "held-label-conversion-with-lepton-records" &&
  SFT.Host.Text.equal (gammaName c.gamma) "internal-level-lowering-with-radiative-record" &&
  SFT.Host.Text.equal (compositionName c.composition) "compose-the-three-primitive-traces" &&
  SFT.Host.Text.equal (survivalName c.survival) "positive-rational-binary-geometric" &&
  SFT.Host.Text.equal (determinismName c.determinism) "deterministic-hidden-path-partition" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "rewrite-predecessor-laws" then "A successor cannot alter admitted receipts." else
  if SFT.Host.Text.equal (topologyName c.topology) "three-named-particles-only" then "Nuclear data contain additional emissions, capture, fission and composite delayed channels." else
  if SFT.Host.Text.equal (alphaName c.alpha) "borrowed-alpha-name" then "A name alone has no constituent trace." else
  if SFT.Host.Text.equal (betaName c.beta) "stochastic-particle-appearance" then "Unrecorded random appearance violates complete conservation." else
  if SFT.Host.Text.equal (gammaName c.gamma) "continuum-energy-leak" then "An unrecorded energy leak violates recurrence and conservation." else
  if SFT.Host.Text.equal (compositionName c.composition) "declare-each-a-new-primitive" then "Adding a primitive for every code destroys exhaustive topology." else
  if SFT.Host.Text.equal (survivalName c.survival) "import-continuum-exponential" then "A continuum exponential and transcendental value are outside the proof domain." else
  if SFT.Host.Text.equal (determinismName c.determinism) "unrecorded-random-choice" then "An unrecorded choice violates the superdeterministic complete-path census." else
  if SFT.Host.Text.equal (targetName c.target) "external-target-readable" then "Target access could select a topology or rate." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-rate-or-extra-primitive" then "A selected rate or topology is a parameter." else
  "Exactly three primitive radioactive transition topologies exist. Alpha realizes mass-four/charge-two boundary release, beta realizes retained-support held-label conversion with lepton records, and gamma realizes internal level lowering with a radiative record. Every other named decay is one primitive or an ordered composition. Survival after positive half-life count k is exactly 1/2^k and remains positive at every finite k."

def generationRule : String := "Generate the complete ten-axis predecessor, topology, alpha, beta, gamma, composition, survival, determinism, target-custody and extension product."
def grammarBoundary : String := "Every finite nuclear nonidentity transition distinguished by constituent-support release, held charge-label conversion and recurrence lowering; every ordered composition of those primitives; every positive finite half-life count and positive transported time carrier."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Topology.rejected,Topology.admitted]).flatMap fun topology =>
  ([Alpha.rejected,Alpha.admitted]).flatMap fun alpha =>
  ([Beta.rejected,Beta.admitted]).flatMap fun beta =>
  ([Gamma.rejected,Gamma.admitted]).flatMap fun gamma =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Survival.rejected,Survival.admitted]).flatMap fun survival =>
  ([Determinism.rejected,Determinism.admitted]).flatMap fun determinism =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,topology,alpha,beta,gamma,composition,survival,determinism,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor topology alpha beta gamma composition survival determinism target extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htopology : topology ∈ [Topology.rejected,Topology.admitted] := by
      cases topology <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have halpha : alpha ∈ [Alpha.rejected,Alpha.admitted] := by
      cases alpha <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbeta : beta ∈ [Beta.rejected,Beta.admitted] := by
      cases beta <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgamma : gamma ∈ [Gamma.rejected,Gamma.admitted] := by
      cases gamma <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsurvival : survival ∈ [Survival.rejected,Survival.admitted] := by
      cases survival <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdeterminism : determinism ∈ [Determinism.rejected,Determinism.admitted] := by
      cases determinism <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ topology _ htopology
    apply CommonRefinement.memFlatMap _ _ alpha _ halpha
    apply CommonRefinement.memFlatMap _ _ beta _ hbeta
    apply CommonRefinement.memFlatMap _ _ gamma _ hgamma
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ survival _ hsurvival
    apply CommonRefinement.memFlatMap _ _ determinism _ hdeterminism
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.RadioactiveDecayEntryGrammar
