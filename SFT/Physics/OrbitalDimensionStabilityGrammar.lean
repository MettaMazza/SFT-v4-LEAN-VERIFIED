import SFT.Physics.OrbitalDimensionStabilityCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.OrbitalDimensionStabilityGrammar
open OrbitalDimensionStabilityCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Dimension where
 | c0
 | c1
 | c2
def dimensionName : Dimension → String
 | .c0 => "complete-positive-whole-d-at-least-two"
 | .c1 => "selected-three-space-only"
 | .c2 => "target-assigned-dimensions"
def dimensionPassed : Dimension → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Gravity where
 | c0
 | c1
 | c2
def gravityName : Gravity → String
 | .c0 => "inverse-positive-power-d-minus-one"
 | .c1 => "fixed-inverse-square-all-d"
 | .c2 => "target-assigned-gravity-power"
def gravityPassed : Gravity → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Centrifugal where
 | c0
 | c1
 | c2
def centrifugalName : Centrifugal → String
 | .c0 => "inverse-cube-positive-magnitude"
 | .c1 => "dimension-matched-centrifugal-power"
 | .c2 => "target-assigned-centrifugal-power"
def centrifugalPassed : Centrifugal → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Balance where
 | c0
 | c1
 | c2
def balanceName : Balance → String
 | .c0 => "equal-positive-magnitudes-at-reference-radius"
 | .c1 => "signed-force-import"
 | .c2 => "target-assigned-balance"
def balancePassed : Balance → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Comparison where
 | c0
 | c1
 | c2
def comparisonName : Comparison → String
 | .c0 => "compare-positive-power-denominators"
 | .c1 => "import-negative-exponent-ratio"
 | .c2 => "measurement-selected-order"
def comparisonPassed : Comparison → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Partition where
 | c0
 | c1
 | c2
def partitionName : Partition → String
 | .c0 => "stable-two-three-marginal-four-unstable-above"
 | .c1 => "three-space-only-verdict"
 | .c2 => "all-dimensions-stable"
def partitionPassed : Partition → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Target where
 | c0
 | c1
def targetName : Target → String
 | .c0 => "sealed-before-observation-release"
 | .c1 => "observation-readable-before-seal"
def targetPassed : Target → Bool
 | .c0 => true
 | .c1 => false
inductive Extension where
 | c0
 | c1
def extensionName : Extension → String
 | .c0 => "empty-extension"
 | .c1 => "free-stability-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 dimension : Dimension
 gravity : Gravity
 centrifugal : Centrifugal
 balance : Balance
 comparison : Comparison
 partition : Partition
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [dimensionName c.dimension,gravityName c.gravity,centrifugalName c.centrifugal,balanceName c.balance,comparisonName c.comparison,partitionName c.partition,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("dimension",(dimensionPassed c.dimension && (exactFacts))),("gravity",(gravityPassed c.gravity && (exactFacts))),("centrifugal",(centrifugalPassed c.centrifugal && (exactFacts))),("balance",(balancePassed c.balance && (exactFacts))),("comparison",(comparisonPassed c.comparison && (exactFacts))),("partition",(partitionPassed c.partition && (exactFacts))),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("dimension",dimensionPassed c.dimension),("gravity",gravityPassed c.gravity),("centrifugal",centrifugalPassed c.centrifugal),("balance",balancePassed c.balance),("comparison",comparisonPassed c.comparison),("partition",partitionPassed c.partition),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk dimension gravity centrifugal balance comparison partition target extension =>
  cases dimension <;> cases gravity <;> cases centrifugal <;> cases balance <;> cases comparison <;> cases partition <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun dimension =>
 [.c0,.c1,.c2].flatMap (fun gravity =>
 [.c0,.c1,.c2].flatMap (fun centrifugal =>
 [.c0,.c1,.c2].flatMap (fun balance =>
 [.c0,.c1,.c2].flatMap (fun comparison =>
 [.c0,.c1,.c2].flatMap (fun partition =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨dimension,gravity,centrifugal,balance,comparison,partition,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨dimension,gravity,centrifugal,balance,comparison,partition,target,extension⟩
 cases dimension <;> cases gravity <;> cases centrifugal <;> cases balance <;> cases comparison <;> cases partition <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨dimension,gravity,centrifugal,balance,comparison,partition,target,extension⟩
 have hdimension : dimension∈[Dimension.c0,Dimension.c1,Dimension.c2] := by
  cases dimension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hgravity : gravity∈[Gravity.c0,Gravity.c1,Gravity.c2] := by
  cases gravity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcentrifugal : centrifugal∈[Centrifugal.c0,Centrifugal.c1,Centrifugal.c2] := by
  cases centrifugal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hbalance : balance∈[Balance.c0,Balance.c1,Balance.c2] := by
  cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcomparison : comparison∈[Comparison.c0,Comparison.c1,Comparison.c2] := by
  cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hpartition : partition∈[Partition.c0,Partition.c1,Partition.c2] := by
  cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ dimension _ hdimension
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ gravity _ hgravity
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ centrifugal _ hcentrifugal
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ balance _ hbalance
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ comparison _ hcomparison
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ partition _ hpartition
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every complete, selected or target-assigned dimension domain; every dimension-derived, fixed or target-assigned gravity dilution; every inverse-cube, dimension-matched or target-assigned centrifugal dilution; every positive-magnitude, signed-import or target-assigned balance; every positive-denominator, negative-exponent or measured outward comparison; every complete, selected or universal stability partition; both target custody states; and both extension states."
def grammarBoundary : String := "Every positive whole spatial dimension d of at least two, every exact outward radius ratio q greater than the One, dimension-forced inverse-(d-1) gravity, inverse-cube centrifugal magnitude, and every positive successor displacement. Dimension one is excluded because the registered circular angular-momentum organization is absent there."
end SFT.Physics.OrbitalDimensionStabilityGrammar
