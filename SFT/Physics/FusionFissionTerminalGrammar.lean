import SFT.Physics.FusionFissionTerminalProofs
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.FusionFissionTerminalGrammar
open FusionFissionTerminal FusionFissionTerminalProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
inductive Fusion where
 | c0
 | c1
 | c2
 deriving DecidableEq
def fusionName : Fusion → String
 | .c0 => "identity"
 | .c1 => "binary-junction"
 | .c2 => "binary-decomposition"
def fusionPassed : Fusion → Bool
 | .c0 => false
 | .c1 => true
 | .c2 => false
theorem fusionComputed (x : Fusion) : fusionOperationIsForced (fusionName x) = .ok (fusionPassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.fusion0
 | c1 => exact FusionFissionTerminalProofs.fusion1
 | c2 => exact FusionFissionTerminalProofs.fusion2
inductive Fission where
 | c0
 | c1
 | c2
 deriving DecidableEq
def fissionName : Fission → String
 | .c0 => "identity"
 | .c1 => "binary-junction"
 | .c2 => "binary-decomposition"
def fissionPassed : Fission → Bool
 | .c0 => false
 | .c1 => false
 | .c2 => true
theorem fissionComputed (x : Fission) : fissionOperationIsForced (fissionName x) = .ok (fissionPassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.fission0
 | c1 => exact FusionFissionTerminalProofs.fission1
 | c2 => exact FusionFissionTerminalProofs.fission2
inductive Direction where
 | c0
 | c1
 deriving DecidableEq
def directionName : Direction → String
 | .c0 => "toward-higher-binding"
 | .c1 => "toward-lower-binding"
def directionPassed : Direction → Bool
 | .c0 => true
 | .c1 => false
theorem directionComputed (x : Direction) : bindingDirectionIsForced (directionName x) = .ok (directionPassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.direction0
 | c1 => exact FusionFissionTerminalProofs.direction1
inductive Barrier where
 | c0
 | c1
 | c2
 | c3
 deriving DecidableEq
def barrierName : Barrier → String
 | .c0 => "quarter-One"
 | .c1 => "half-One"
 | .c2 => "three-quarter-One"
 | .c3 => "One"
def barrierPassed : Barrier → Bool
 | .c0 => false
 | .c1 => true
 | .c2 => false
 | .c3 => false
theorem barrierComputed (x : Barrier) : barrierIsForced (barrierName x) = .ok (barrierPassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.barrier0
 | c1 => exact FusionFissionTerminalProofs.barrier1
 | c2 => exact FusionFissionTerminalProofs.barrier2
 | c3 => exact FusionFissionTerminalProofs.barrier3
inductive Release where
 | c0
 | c1
 deriving DecidableEq
def releaseName : Release → String
 | .c0 => "complete-held-release"
 | .c1 => "unrecorded-release"
def releasePassed : Release → Bool
 | .c0 => true
 | .c1 => false
theorem releaseComputed (x : Release) : releaseAccountingIsForced (releaseName x) = .ok (releasePassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.release0
 | c1 => exact FusionFissionTerminalProofs.release1
inductive Peak where
 | c0
 | c1
 deriving DecidableEq
def peakName : Peak → String
 | .c0 => "unique-unbounded-peak"
 | .c1 => "selected-finite-peak"
def peakPassed : Peak → Bool
 | .c0 => true
 | .c1 => false
theorem peakComputed (x : Peak) : peakClosureIsForced (peakName x) = .ok (peakPassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.peak0
 | c1 => exact FusionFissionTerminalProofs.peak1
inductive Target where
 | c0
 | c1
 deriving DecidableEq
def targetName : Target → String
 | .c0 => "sealed-before-release"
 | .c1 => "readable-before-seal"
def targetPassed : Target → Bool
 | .c0 => true
 | .c1 => false
theorem targetComputed (x : Target) : targetBoundaryIsForced (targetName x) = .ok (targetPassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.target0
 | c1 => exact FusionFissionTerminalProofs.target1
inductive Extension where
 | c0
 | c1
 deriving DecidableEq
def extensionName : Extension → String
 | .c0 => "empty-extension"
 | .c1 => "free-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
theorem extensionComputed (x : Extension) : extensionIsForced (extensionName x) = .ok (extensionPassed x) := by
 cases x with
 | c0 => exact FusionFissionTerminalProofs.extension0
 | c1 => exact FusionFissionTerminalProofs.extension1
structure Candidate where
 fusion : Fusion
 fission : Fission
 direction : Direction
 barrier : Barrier
 release : Release
 peak : Peak
 target : Target
 extension : Extension
 deriving DecidableEq
def sourceFields (c : Candidate) : List String := [fusionName c.fusion,fissionName c.fission,directionName c.direction,barrierName c.barrier,releaseName c.release,peakName c.peak,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let fusion ← fusionOperationIsForced (fusionName c.fusion)
 let fission ← fissionOperationIsForced (fissionName c.fission)
 let direction ← bindingDirectionIsForced (directionName c.direction)
 let barrier ← barrierIsForced (barrierName c.barrier)
 let release ← releaseAccountingIsForced (releaseName c.release)
 let peak ← peakClosureIsForced (peakName c.peak)
 let target ← targetBoundaryIsForced (targetName c.target)
 let extension ← extensionIsForced (extensionName c.extension)
 pure [("fusion_map",fusion),("fission_map",fission),("binding_direction",direction),("barrier",barrier),("energy_accounting",release),("peak_closure",peak),("target_boundary",target),("extension",extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("fusion_map",fusionPassed c.fusion),("fission_map",fissionPassed c.fission),("binding_direction",directionPassed c.direction),("barrier",barrierPassed c.barrier),("energy_accounting",releasePassed c.release),("peak_closure",peakPassed c.peak),("target_boundary",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c = .ok (computedFacts c) := by
 unfold candidateFacts
 rw [fusionComputed,fissionComputed,directionComputed,barrierComputed,releaseComputed,peakComputed,targetComputed,extensionComputed]
 rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do
 pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c = .ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun fusion =>
 [.c0,.c1,.c2].flatMap (fun fission =>
 [.c0,.c1].flatMap (fun direction =>
 [.c0,.c1,.c2,.c3].flatMap (fun barrier =>
 [.c0,.c1].flatMap (fun release =>
 [.c0,.c1].flatMap (fun peak =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨fusion,fission,direction,barrier,release,peak,target,extension⟩))))))))
def survivor : Candidate := ⟨.c1,.c2,.c0,.c1,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length = 1152 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c = true → c = survivor := by
 rcases c with ⟨fusion,fission,direction,barrier,release,peak,target,extension⟩
 cases fusion <;> cases fission <;> cases direction <;> cases barrier <;> cases release <;> cases peak <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor = true := rfl
theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
 rcases c with ⟨fusion,fission,direction,barrier,release,peak,target,extension⟩
 have hfusion : fusion ∈ [Fusion.c0,Fusion.c1,Fusion.c2] := by
  cases fusion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hfission : fission ∈ [Fission.c0,Fission.c1,Fission.c2] := by
  cases fission <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hdirection : direction ∈ [Direction.c0,Direction.c1] := by
  cases direction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hbarrier : barrier ∈ [Barrier.c0,Barrier.c1,Barrier.c2,Barrier.c3] := by
  cases barrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hrelease : release ∈ [Release.c0,Release.c1] := by
  cases release <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hpeak : peak ∈ [Peak.c0,Peak.c1] := by
  cases peak <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target ∈ [Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension ∈ [Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ fusion _ hfusion
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ fission _ hfission
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ direction _ hdirection
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ barrier _ hbarrier
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ release _ hrelease
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ peak _ hpeak
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of three possible fusion maps, three possible fission maps, both binding directions, every first-two-Fold barrier part, both release-record states, both global-peak certificates, both target-custody states and both extension states."
def grammarBoundary : String := "Every identity, least nonidentity binary junction and least nonidentity binary decomposition over the registered two-fibre nuclear word; both exact binding-order orientations; all quarter-grid parts generated by two Fold refinements; complete or missing release records; finite-only or depth-independent peak closure; pre/post-seal target access; and empty or free extensions."
end SFT.Physics.FusionFissionTerminalGrammar
