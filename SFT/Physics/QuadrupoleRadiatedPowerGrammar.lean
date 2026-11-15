import SFT.Physics.QuadrupoleRadiatedPowerCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.QuadrupoleRadiatedPowerGrammar
open QuadrupoleRadiatedPowerCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Moment where
 | c0
 | c1
 | c2
def momentName : Moment → String
 | .c0 => "held-monopole-and-dipole-leave-quadrupole-first"
 | .c1 => "lower-moment-radiation"
 | .c2 => "target-assigned-moment"
def momentPassed : Moment → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Rate where
 | c0
 | c1
 | c2
def rateName : Rate → String
 | .c0 => "third-generated-quadrupole-difference"
 | .c1 => "free-difference-order"
 | .c2 => "target-assigned-rate"
def ratePassed : Rate → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Energy where
 | c0
 | c1
 | c2
def energyName : Energy → String
 | .c0 => "positive-square-of-third-rate"
 | .c1 => "linear-or-unsigned-rate-energy"
 | .c2 => "target-assigned-energy"
def energyPassed : Energy → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Coupling where
 | c0
 | c1
 | c2
def couplingName : Coupling → String
 | .c0 => "admitted-binary-half-One-coupling"
 | .c1 => "free-radiation-coupling"
 | .c2 => "target-assigned-coupling"
def couplingPassed : Coupling → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Shell where
 | c0
 | c1
 | c2
def shellName : Shell → String
 | .c0 => "rank-two-density-dilution-with-conserved-total-power"
 | .c1 => "unconserved-or-free-shell-power"
 | .c2 => "target-assigned-shell-law"
def shellPassed : Shell → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Control where
 | c0
 | c1
 | c2
def controlName : Control → String
 | .c0 => "static-empty-and-amplitude-square-scaling"
 | .c1 => "numerical-zero-or-linear-scaling"
 | .c2 => "target-assigned-control"
def controlPassed : Control → Bool
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
 | .c1 => "free-radiation-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 moment : Moment
 rate : Rate
 energy : Energy
 coupling : Coupling
 shell : Shell
 control : Control
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [momentName c.moment,rateName c.rate,energyName c.energy,couplingName c.coupling,shellName c.shell,controlName c.control,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let exactFacts ← certificateFacts
 pure [("moment",(momentPassed c.moment && (exactFacts))),("rate",(ratePassed c.rate && (exactFacts))),("energy",(energyPassed c.energy && (exactFacts))),("coupling",(couplingPassed c.coupling && (exactFacts))),("shell",(shellPassed c.shell && (exactFacts))),("control",(controlPassed c.control && (exactFacts))),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("moment",momentPassed c.moment),("rate",ratePassed c.rate),("energy",energyPassed c.energy),("coupling",couplingPassed c.coupling),("shell",shellPassed c.shell),("control",controlPassed c.control),("target",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk moment rate energy coupling shell control target extension =>
  cases moment <;> cases rate <;> cases energy <;> cases coupling <;> cases shell <;> cases control <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun moment =>
 [.c0,.c1,.c2].flatMap (fun rate =>
 [.c0,.c1,.c2].flatMap (fun energy =>
 [.c0,.c1,.c2].flatMap (fun coupling =>
 [.c0,.c1,.c2].flatMap (fun shell =>
 [.c0,.c1,.c2].flatMap (fun control =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨moment,rate,energy,coupling,shell,control,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨moment,rate,energy,coupling,shell,control,target,extension⟩
 cases moment <;> cases rate <;> cases energy <;> cases coupling <;> cases shell <;> cases control <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨moment,rate,energy,coupling,shell,control,target,extension⟩
 have hmoment : moment∈[Moment.c0,Moment.c1,Moment.c2] := by
  cases moment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hrate : rate∈[Rate.c0,Rate.c1,Rate.c2] := by
  cases rate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have henergy : energy∈[Energy.c0,Energy.c1,Energy.c2] := by
  cases energy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcoupling : coupling∈[Coupling.c0,Coupling.c1,Coupling.c2] := by
  cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hshell : shell∈[Shell.c0,Shell.c1,Shell.c2] := by
  cases shell <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcontrol : control∈[Control.c0,Control.c1,Control.c2] := by
  cases control <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ moment _ hmoment
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ rate _ hrate
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ energy _ henergy
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ coupling _ hcoupling
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ shell _ hshell
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ control _ hcontrol
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every quadrupole-first, lower-moment or target-assigned moment law; every third-generated, free-order or target-assigned rate; every squared, linear/free or target-assigned energy carrier; every admitted, free or target-assigned coupling; every rank-two conserved, free or target-assigned shell law; every structural-empty, numerical/linear or target-assigned adverse control; both target custody states; and both extension states."
def grammarBoundary : String := "Every finite exact positive quadrupole-magnitude trace generated by a positive cubic tick carrier and positive amplitude, every positive tick index under the all-positive cubic successor identity, and every finite outward binary shell. Static silence is structural emptiness. The theorem is the leading positive-magnitude quadrupole channel; tensor orientation and physical-unit comparison are retained post-seal."
end SFT.Physics.QuadrupoleRadiatedPowerGrammar
