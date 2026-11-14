import SFT.Physics.OddLatticeAllRegionCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.OddLatticeAllRegionGrammar
open OddLatticeAllRegionCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Lattice where
 | c0
 | c1
 | c2
def latticeName : Lattice → String
 | .c0 => "every-positive-odd-complete-lattice"
 | .c1 => "selected-historical-lattice-only"
 | .c2 => "target-assigned-lattice-size"
def latticePassed : Lattice → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Fold where
 | c0
 | c1
 | c2
def foldName : Fold → String
 | .c0 => "binary-Fold-permutation-on-positive-residues"
 | .c1 => "noninvertible-selected-residue-map"
 | .c2 => "target-assigned-recurrence"
def foldPassed : Fold → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Support where
 | c0
 | c1
 | c2
def supportName : Support → String
 | .c0 => "complete-positive-lattice-support"
 | .c1 => "selected-orbit-prefix"
 | .c2 => "omitted-One-endpoint"
def supportPassed : Support → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Region where
 | c0
 | c1
 | c2
def regionName : Region → String
 | .c0 => "complete-positive-region-partition-through-the-One"
 | .c1 => "selected-occupied-regions-only"
 | .c2 => "target-assigned-region-edges"
def regionPassed : Region → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Occupancy where
 | c0
 | c1
 | c2
def occupancyName : Occupancy → String
 | .c0 => "permutation-preserves-exact-vector-and-all-region-occupancy"
 | .c1 => "all-region-claim-without-vector"
 | .c2 => "target-assigned-vector"
def occupancyPassed : Occupancy → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
inductive Depth where
 | c0
 | c1
 | c2
def depthName : Depth → String
 | .c0 => "every-positive-finite-Fold-depth-by-successor"
 | .c1 => "historical-depth-only"
 | .c2 => "finite-prefix-without-successor-certificate"
def depthPassed : Depth → Bool
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
 | .c1 => "free-occupancy-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
structure Candidate where
 lattice : Lattice
 fold : Fold
 support : Support
 region : Region
 occupancy : Occupancy
 depth : Depth
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [latticeName c.lattice,foldName c.fold,supportName c.support,regionName c.region,occupancyName c.occupancy,depthName c.depth,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let (permutation,invariant,occupied,retained) ← certificateFacts
 pure [("lattice-domain",(latticePassed c.lattice && (permutation))),("Fold-action",(foldPassed c.fold && (permutation))),("complete-support",(supportPassed c.support && (retained))),("region-partition",(regionPassed c.region && (occupied))),("occupancy-law",(occupancyPassed c.occupancy && (invariant && occupied))),("depth-closure",(depthPassed c.depth && (invariant))),("target-custody",targetPassed c.target),("no-free-extension",extensionPassed c.extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("lattice-domain",latticePassed c.lattice),("Fold-action",foldPassed c.fold),("complete-support",supportPassed c.support),("region-partition",regionPassed c.region),("occupancy-law",occupancyPassed c.occupancy),("depth-closure",depthPassed c.depth),("target-custody",targetPassed c.target),("no-free-extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by
 unfold candidateFacts
 rw [originalComputedFacts]
 cases c with
 | mk lattice fold support region occupancy depth target extension =>
  cases lattice <;> cases fold <;> cases support <;> cases region <;> cases occupancy <;> cases depth <;> cases target <;> cases extension <;> rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun lattice =>
 [.c0,.c1,.c2].flatMap (fun fold =>
 [.c0,.c1,.c2].flatMap (fun support =>
 [.c0,.c1,.c2].flatMap (fun region =>
 [.c0,.c1,.c2].flatMap (fun occupancy =>
 [.c0,.c1,.c2].flatMap (fun depth =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨lattice,fold,support,region,occupancy,depth,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length=2916 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by
 rcases c with ⟨lattice,fold,support,region,occupancy,depth,target,extension⟩
 cases lattice <;> cases fold <;> cases support <;> cases region <;> cases occupancy <;> cases depth <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor=true := rfl
theorem candidatesComplete (c : Candidate) : c∈candidates := by
 rcases c with ⟨lattice,fold,support,region,occupancy,depth,target,extension⟩
 have hlattice : lattice∈[Lattice.c0,Lattice.c1,Lattice.c2] := by
  cases lattice <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hfold : fold∈[Fold.c0,Fold.c1,Fold.c2] := by
  cases fold <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hsupport : support∈[Support.c0,Support.c1,Support.c2] := by
  cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hregion : region∈[Region.c0,Region.c1,Region.c2] := by
  cases region <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hoccupancy : occupancy∈[Occupancy.c0,Occupancy.c1,Occupancy.c2] := by
  cases occupancy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hdepth : depth∈[Depth.c0,Depth.c1,Depth.c2] := by
  cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target∈[Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension∈[Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ lattice _ hlattice
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ fold _ hfold
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ support _ hsupport
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ region _ hregion
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ occupancy _ hoccupancy
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ depth _ hdepth
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of every general, selected or target-assigned lattice domain; every exact, noninvertible or target-assigned Fold action; every complete, prefix or endpoint-omitting support; every complete, selected or target-assigned region partition; every exact-vector, vector-free or target-assigned occupancy law; every successor, historical-only or uncertified depth closure; both target custody states; and both extension states."
def grammarBoundary : String := "Every positive finite odd lattice beyond the One, its complete positive rational support, the binary Fold successor, every positive finite Fold depth, and every complete positive region partition with region count not exceeding member count. Structural absence is an empty support, never a numerical state."
end SFT.Physics.OddLatticeAllRegionGrammar
