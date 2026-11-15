import SFT.Physics.StaticExteriorClockCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.StaticExteriorClockGrammar
open StaticExteriorClockCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Horizon where
 | c0
 | c1
 | c2
def horizonName : Horizon → String
 | .c0 => "twice-mass-generated-horizon"
 | .c1 => "free-radius-scale"
 | .c2 => "target-assigned-horizon"
def horizonPassed : Horizon → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Field where
 | c0
 | c1
 | c2
def fieldName : Field → String
 | .c0 => "inverse-square-with-conserved-horizon-flux"
 | .c1 => "free-field-power"
 | .c2 => "target-assigned-field"
def fieldPassed : Field → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Well where
 | c0
 | c1
 | c2
def wellName : Well → String
 | .c0 => "radius-times-field-gives-horizon-over-radius-share"
 | .c1 => "independent-potential-profile"
 | .c2 => "target-assigned-well"
def wellPassed : Well → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Coefficient where
 | c0
 | c1
 | c2
def coefficientName : Coefficient → String
 | .c0 => "positive-One-complement-of-well"
 | .c1 => "signed-subtraction-import"
 | .c2 => "target-assigned-coefficient"
def coefficientPassed : Coefficient → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Clock where
 | c0
 | c1
 | c2
def clockName : Clock → String
 | .c0 => "exact-square-carriers-and-empty-horizon-record"
 | .c1 => "unrestricted-irrational-root"
 | .c2 => "target-assigned-clock"
def clockPassed : Clock → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Boundary where
 | c0
 | c1
 | c2
def boundaryName : Boundary → String
 | .c0 => "finite-successor-flat-boundary-and-vacuum"
 | .c1 => "completed-infinity-or-interior-extension"
 | .c2 => "target-assigned-boundary"
def boundaryPassed : Boundary → Bool
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
 | .c1 => "free-exterior-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 horizon : Horizon
 field : Field
 well : Well
 coefficient : Coefficient
 clock : Clock
 boundary : Boundary
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [horizonName c.horizon,fieldName c.field,wellName c.well,coefficientName c.coefficient,clockName c.clock,boundaryName c.boundary,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("horizon",(horizonPassed c.horizon && (exactFacts))),("field",(fieldPassed c.field && (exactFacts))),("well",(wellPassed c.well && (exactFacts))),("coefficient",(coefficientPassed c.coefficient && (exactFacts))),("clock",(clockPassed c.clock && (exactFacts))),("boundary",(boundaryPassed c.boundary && (exactFacts))),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("horizon",horizonPassed c.horizon),("field",fieldPassed c.field),("well",wellPassed c.well),("coefficient",coefficientPassed c.coefficient),("clock",clockPassed c.clock),("boundary",boundaryPassed c.boundary),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk horizon field well coefficient clock boundary target extension =>
  cases horizon <;> cases field <;> cases well <;> cases coefficient <;> cases clock <;> cases boundary <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun horizon =>
 [.c0,.c1,.c2].flatMap (fun field =>
 [.c0,.c1,.c2].flatMap (fun well =>
 [.c0,.c1,.c2].flatMap (fun coefficient =>
 [.c0,.c1,.c2].flatMap (fun clock =>
 [.c0,.c1,.c2].flatMap (fun boundary =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨horizon,field,well,coefficient,clock,boundary,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨horizon,field,well,coefficient,clock,boundary,target,extension⟩
 cases horizon <;> cases field <;> cases well <;> cases coefficient <;> cases clock <;> cases boundary <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨horizon,field,well,coefficient,clock,boundary,target,extension⟩
 have hhorizon : horizon∈[Horizon.c0,Horizon.c1,Horizon.c2] := by
  cases horizon <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hfield : field∈[Field.c0,Field.c1,Field.c2] := by
  cases field <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hwell : well∈[Well.c0,Well.c1,Well.c2] := by
  cases well <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcoefficient : coefficient∈[Coefficient.c0,Coefficient.c1,Coefficient.c2] := by
  cases coefficient <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hclock : clock∈[Clock.c0,Clock.c1,Clock.c2] := by
  cases clock <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hboundary : boundary∈[Boundary.c0,Boundary.c1,Boundary.c2] := by
  cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ horizon _ hhorizon
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ field _ hfield
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ well _ hwell
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ coefficient _ hcoefficient
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ clock _ hclock
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ boundary _ hboundary
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every generated, free or target-assigned horizon normalization; every conserved inverse-square, free-power or target-assigned field; every radius-derived, independent or target-assigned well; every positive complement, signed import or target-assigned coefficient; every exact-square, unrestricted-root or target-assigned clock; every finite-successor, completed/inward or target-assigned boundary; both target custody states; and both extension states."
def grammarBoundary : String := "Every exact positive mass whose generated doubled boundary does not exceed the One, every exact radius at or outside that boundary, and every finite outward binary successor. The coefficient theorem covers every exact exterior radius; numerical clock rates are evaluated only on generated exact-square carriers, and the boundary is an empty clock record rather than a numerical zero."
end SFT.Physics.StaticExteriorClockGrammar
