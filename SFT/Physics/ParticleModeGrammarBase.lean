import SFT.Physics.ParticleModeFibres
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.ParticleModeGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Fibre where
  | rejected | admitted

def fibreName : Fibre → String
  | .rejected => "selected-binary-or-colour-count"
  | .admitted => "complete-m-offset-fibre"

inductive Mode where
  | rejected | admitted

def modeName : Mode → String
  | .rejected => "named-three-mode-pattern"
  | .admitted => "complete-fixed-index-range"

inductive Generation where
  | rejected | admitted

def generationName : Generation → String
  | .rejected => "one-coordinate-system-selected-as-mass"
  | .admitted => "three-order-isomorphic-coordinate-systems"

inductive Cover where
  | rejected | admitted

def coverName : Cover → String
  | .rejected => "chosen-depth-five-or-seven"
  | .admitted => "least-cover-of-generator-volume"

inductive Placement where
  | rejected | admitted

def placementName : Placement → String
  | .rejected => "extra-spatial-dimension"
  | .admitted => "internal-recurrent-trace-mode"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "site-fraction-is-mass"
  | .admitted => "order-transport-to-terminal-polynomials"

inductive Dual where
  | rejected | admitted

def dualName : Dual → String
  | .rejected => "lookup-depth-fractions"
  | .admitted => "complete-colour-binary-dual"

inductive Reach where
  | rejected | admitted

def reachName : Reach → String
  | .rejected => "lifetime-equals-mass-ratio-postulate"
  | .admitted => "exact-structural-reach-identity"

inductive Transition where
  | rejected | admitted

def transitionName : Transition → String
  | .rejected => "universal-observed-rate-ratio"
  | .admitted => "structural-separation-multiplicity"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-dimension-or-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  fibre : Fibre
  mode : Mode
  generation : Generation
  cover : Cover
  placement : Placement
  mass : Mass
  dual : Dual
  reach : Reach
  transition : Transition
  extension : Extension

def sourceFields (c : Candidate) : List String := [fibreName c.fibre, modeName c.mode, generationName c.generation, coverName c.cover, placementName c.placement, massName c.mass, dualName c.dual, reachName c.reach, transitionName c.transition, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "fibre=" (fibreName c.fibre), SFT.Host.Text.append "mode=" (modeName c.mode), SFT.Host.Text.append "generation=" (generationName c.generation), SFT.Host.Text.append "cover=" (coverName c.cover), SFT.Host.Text.append "placement=" (placementName c.placement), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "dual=" (dualName c.dual), SFT.Host.Text.append "reach=" (reachName c.reach), SFT.Host.Text.append "transition=" (transitionName c.transition), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-m-offset-fibre__complete-fixed-index-range__three-order-isomorphic-coordinate-systems__least-cover-of-generator-volume__internal-recurrent-trace-mode__order-transport-to-terminal-polynomials__complete-colour-binary-dual__exact-structural-reach-identity__structural-separation-multiplicity__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (fibreName c.fibre) "complete-m-offset-fibre" &&
  SFT.Host.Text.equal (modeName c.mode) "complete-fixed-index-range" &&
  SFT.Host.Text.equal (generationName c.generation) "three-order-isomorphic-coordinate-systems" &&
  SFT.Host.Text.equal (coverName c.cover) "least-cover-of-generator-volume" &&
  SFT.Host.Text.equal (placementName c.placement) "internal-recurrent-trace-mode" &&
  SFT.Host.Text.equal (massName c.mass) "order-transport-to-terminal-polynomials" &&
  SFT.Host.Text.equal (dualName c.dual) "complete-colour-binary-dual" &&
  SFT.Host.Text.equal (reachName c.reach) "exact-structural-reach-identity" &&
  SFT.Host.Text.equal (transitionName c.transition) "structural-separation-multiplicity" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (fibreName c.fibre) "complete-m-offset-fibre") then "A selected special case is not a general law." else
  if !(SFT.Host.Text.equal (modeName c.mode) "complete-fixed-index-range") then "Naming three modes does not force the general count." else
  if !(SFT.Host.Text.equal (generationName c.generation) "three-order-isomorphic-coordinate-systems") then "A coordinate value is not automatically a physical mass." else
  if !(SFT.Host.Text.equal (coverName c.cover) "least-cover-of-generator-volume") then "A selected depth is a free choice." else
  if !(SFT.Host.Text.equal (placementName c.placement) "internal-recurrent-trace-mode") then "An extra spatial coordinate is not generated." else
  if !(SFT.Host.Text.equal (massName c.mass) "order-transport-to-terminal-polynomials") then "This superseded identification conflicts with the terminal spectra." else
  if !(SFT.Host.Text.equal (dualName c.dual) "complete-colour-binary-dual") then "Looked-up fractions are not forced." else
  if !(SFT.Host.Text.equal (reachName c.reach) "exact-structural-reach-identity") then "A dimensional lifetime equality is not forced by the count." else
  if !(SFT.Host.Text.equal (transitionName c.transition) "structural-separation-multiplicity") then "The old 1:1:4 physical-rate claim omits interaction carriers." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "Either addition is an unforced parameter." else
  "For every positive finite m>=2, the m-Fold has exactly m positive preimages and m-2 interior fixed modes. The four generation coordinate records are complete ordered three-label systems and are not masses. The exact 27-cell state volume forces binary cover depth five and colour cover depth three. Every finite recurrent particle class injects into internal Fold modes without adding a spatial dimension. Generation order transports to the admitted terminal lepton, quark and neutrino polynomial carriers; superseded site-as-mass readings are rejected. The exact dual seeds are 1/95, 1/383 and 1/485; at every positive depth the heavy/light ratio equals the subtraction reach N-1; and the quarter-mode 1:1:4 record is a structural squared-separation multiplicity, not a universal measured mixing-rate ratio."

def generationRule : String := "Generate the complete product of fibre, fixed-mode, generation-coordinate, cover-depth, particle-placement, mass-transport, dual, reach, transition and extra-rule forms."
def grammarBoundary : String := "Every positive finite m-Fold by depth-independent index induction; all four complete three-label coordinate systems; the exact 27-cell cover; every finite recurrent particle-trace census; all admitted terminal charged-lepton, quark, neutrino and CKM carriers; and every superseded site-as-mass and separation-as-observed-rate alternative."

def candidates : List Candidate :=
  ([Fibre.rejected,Fibre.admitted]).flatMap fun fibre =>
  ([Mode.rejected,Mode.admitted]).flatMap fun mode =>
  ([Generation.rejected,Generation.admitted]).flatMap fun generation =>
  ([Cover.rejected,Cover.admitted]).flatMap fun cover =>
  ([Placement.rejected,Placement.admitted]).flatMap fun placement =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Dual.rejected,Dual.admitted]).flatMap fun dual =>
  ([Reach.rejected,Reach.admitted]).flatMap fun reach =>
  ([Transition.rejected,Transition.admitted]).flatMap fun transition =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨fibre,mode,generation,cover,placement,mass,dual,reach,transition,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk fibre mode generation cover placement mass dual reach transition extension =>
    have hfibre : fibre ∈ [Fibre.rejected,Fibre.admitted] := by
      cases fibre <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmode : mode ∈ [Mode.rejected,Mode.admitted] := by
      cases mode <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgeneration : generation ∈ [Generation.rejected,Generation.admitted] := by
      cases generation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcover : cover ∈ [Cover.rejected,Cover.admitted] := by
      cases cover <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hplacement : placement ∈ [Placement.rejected,Placement.admitted] := by
      cases placement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdual : dual ∈ [Dual.rejected,Dual.admitted] := by
      cases dual <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreach : reach ∈ [Reach.rejected,Reach.admitted] := by
      cases reach <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransition : transition ∈ [Transition.rejected,Transition.admitted] := by
      cases transition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ fibre _ hfibre
    apply CommonRefinement.memFlatMap _ _ mode _ hmode
    apply CommonRefinement.memFlatMap _ _ generation _ hgeneration
    apply CommonRefinement.memFlatMap _ _ cover _ hcover
    apply CommonRefinement.memFlatMap _ _ placement _ hplacement
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ dual _ hdual
    apply CommonRefinement.memFlatMap _ _ reach _ hreach
    apply CommonRefinement.memFlatMap _ _ transition _ htransition
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.ParticleModeGrammar
