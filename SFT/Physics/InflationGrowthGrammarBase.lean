import SFT.Physics.InflationGrowth
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.InflationGrowthGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Volume where
  | rejected | admitted

def volumeName : Volume → String
  | .rejected => "named-observable-universe-size"
  | .admitted => "generator-three-space-volume"

inductive Cover where
  | rejected | admitted

def coverName : Cover → String
  | .rejected => "selected-sixty-efold-story"
  | .admitted => "least-binary-depth-five-cover"

inductive Duration where
  | rejected | admitted

def durationName : Duration → String
  | .rejected => "irrational-logarithmic-efolds"
  | .admitted => "five-exact-doubling-transitions"

inductive Scalar where
  | rejected | admitted

def scalarName : Scalar → String
  | .rejected => "fitted-spectral-index"
  | .admitted => "one-boundary-record-short-of-complete"

inductive Tensor where
  | rejected | admitted

def tensorName : Tensor → String
  | .rejected => "free-tensor-amplitude"
  | .admitted => "one-tensor-pair-record-in-thirty-two"

inductive Exit where
  | rejected | admitted

def exitName : Exit → String
  | .rejected => "chosen-inflaton-potential-exit"
  | .admitted => "first-complete-generator-volume-cover"

inductive Growth where
  | rejected | admitted

def growthName : Growth → String
  | .rejected => "stochastic-or-decaying-seed"
  | .admitted => "quarter-half-One-two-step-growth"

inductive Transfer where
  | rejected | admitted

def transferName : Transfer → String
  | .rejected => "fitted-transfer-function"
  | .admitted => "third-versus-fourth-power-relative-growth"

structure Candidate where
  volume : Volume
  cover : Cover
  duration : Duration
  scalar : Scalar
  tensor : Tensor
  exit : Exit
  growth : Growth
  transfer : Transfer

def sourceFields (c : Candidate) : List String := [volumeName c.volume, coverName c.cover, durationName c.duration, scalarName c.scalar, tensorName c.tensor, exitName c.exit, growthName c.growth, transferName c.transfer]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "volume=" (volumeName c.volume), SFT.Host.Text.append "cover=" (coverName c.cover), SFT.Host.Text.append "duration=" (durationName c.duration), SFT.Host.Text.append "scalar=" (scalarName c.scalar), SFT.Host.Text.append "tensor=" (tensorName c.tensor), SFT.Host.Text.append "exit=" (exitName c.exit), SFT.Host.Text.append "growth=" (growthName c.growth), SFT.Host.Text.append "transfer=" (transferName c.transfer)]
def survivorId : String := "generator-three-space-volume__least-binary-depth-five-cover__five-exact-doubling-transitions__one-boundary-record-short-of-complete__one-tensor-pair-record-in-thirty-two__first-complete-generator-volume-cover__quarter-half-One-two-step-growth__third-versus-fourth-power-relative-growth"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (volumeName c.volume) "generator-three-space-volume" &&
  SFT.Host.Text.equal (coverName c.cover) "least-binary-depth-five-cover" &&
  SFT.Host.Text.equal (durationName c.duration) "five-exact-doubling-transitions" &&
  SFT.Host.Text.equal (scalarName c.scalar) "one-boundary-record-short-of-complete" &&
  SFT.Host.Text.equal (tensorName c.tensor) "one-tensor-pair-record-in-thirty-two" &&
  SFT.Host.Text.equal (exitName c.exit) "first-complete-generator-volume-cover" &&
  SFT.Host.Text.equal (growthName c.growth) "quarter-half-One-two-step-growth" &&
  SFT.Host.Text.equal (transferName c.transfer) "third-versus-fourth-power-relative-growth"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (volumeName c.volume) "generator-three-space-volume") then "A measured horizon cannot select the support." else
  if !(SFT.Host.Text.equal (coverName c.cover) "least-binary-depth-five-cover") then "A conventional model-dependent duration is not a generated Fold count." else
  if !(SFT.Host.Text.equal (durationName c.duration) "five-exact-doubling-transitions") then "A continuum logarithm is outside exact Fold arithmetic." else
  if !(SFT.Host.Text.equal (scalarName c.scalar) "one-boundary-record-short-of-complete") then "A decimal index selected from CMB data is a fit." else
  if !(SFT.Host.Text.equal (tensorName c.tensor) "one-tensor-pair-record-in-thirty-two") then "A tunable tensor amplitude adds a parameter." else
  if !(SFT.Host.Text.equal (exitName c.exit) "first-complete-generator-volume-cover") then "A chosen potential imports an independent model." else
  if !(SFT.Host.Text.equal (growthName c.growth) "quarter-half-One-two-step-growth") then "Ontic noise or decay is not forced by the Fold." else
  if !(SFT.Host.Text.equal (transferName c.transfer) "third-versus-fourth-power-relative-growth") then "A fitted spectrum is not a law." else
  "The unique generator-volume inflation cover is five Fold doublings with support 32. The complete primordial partition is scalar 31/32 and least tensor-pair 1/32. The structural exit is the first complete cover of volume 27. The least resolved perturbation grows exactly 1/4 to 1/2 to One in two Fold steps. For every exact positive later scale growth g, matter retention is 1/g^3, radiation retention is 1/g^4 and their relative growth is g. A conventional natural-log e-fold count is a comparison label, not an SFT proof scalar."

def generationRule : String := "Generate the complete product of spatial volume, binary cover, duration carrier, scalar support, tensor support, exit boundary, perturbation growth and component-transfer form."
def grammarBoundary : String := "Generator-three volume in stable three-space; every positive binary support until the unique least cover; every exact complete doubling ratio; the complete thirty-two-record primordial partition; the quarter/half/One Fold growth trace; and every exact positive rational later scale-growth carrier under admitted third/fourth transport."

def candidates : List Candidate :=
  ([Volume.rejected,Volume.admitted]).flatMap fun volume =>
  ([Cover.rejected,Cover.admitted]).flatMap fun cover =>
  ([Duration.rejected,Duration.admitted]).flatMap fun duration =>
  ([Scalar.rejected,Scalar.admitted]).flatMap fun scalar =>
  ([Tensor.rejected,Tensor.admitted]).flatMap fun tensor =>
  ([Exit.rejected,Exit.admitted]).flatMap fun exit =>
  ([Growth.rejected,Growth.admitted]).flatMap fun growth =>
  ([Transfer.rejected,Transfer.admitted]).map fun transfer =>
  ⟨volume,cover,duration,scalar,tensor,exit,growth,transfer⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk volume cover duration scalar tensor exit growth transfer =>
    have hvolume : volume ∈ [Volume.rejected,Volume.admitted] := by
      cases volume <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcover : cover ∈ [Cover.rejected,Cover.admitted] := by
      cases cover <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hduration : duration ∈ [Duration.rejected,Duration.admitted] := by
      cases duration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscalar : scalar ∈ [Scalar.rejected,Scalar.admitted] := by
      cases scalar <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htensor : tensor ∈ [Tensor.rejected,Tensor.admitted] := by
      cases tensor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexit : exit ∈ [Exit.rejected,Exit.admitted] := by
      cases exit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgrowth : growth ∈ [Growth.rejected,Growth.admitted] := by
      cases growth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransfer : transfer ∈ [Transfer.rejected,Transfer.admitted] := by
      cases transfer <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ volume _ hvolume
    apply CommonRefinement.memFlatMap _ _ cover _ hcover
    apply CommonRefinement.memFlatMap _ _ duration _ hduration
    apply CommonRefinement.memFlatMap _ _ scalar _ hscalar
    apply CommonRefinement.memFlatMap _ _ tensor _ htensor
    apply CommonRefinement.memFlatMap _ _ exit _ hexit
    apply CommonRefinement.memFlatMap _ _ growth _ hgrowth
    exact Count.TraceDerivation.memMap _ transfer _ htransfer

end SFT.Physics.InflationGrowthGrammar
