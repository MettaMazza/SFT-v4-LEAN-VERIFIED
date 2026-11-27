import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.AdditionWitnessGraphs.AdjacentSource
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "adjacent-source" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","adjacent-source",held0Family,held0Label⟩
private theorem held0Name : held0.label = "adjacent-source" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "adjacent-left" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","adjacent-left",held1Family,held1Label⟩
private theorem held1Name : held1.label = "adjacent-left" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "adjacent-middle" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","adjacent-middle",held2Family,held2Label⟩
private theorem held2Name : held2.label = "adjacent-middle" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "adjacent-right" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","adjacent-right",held3Family,held3Label⟩
private theorem held3Name : held3.label = "adjacent-right" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "adjacent-entering-left" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","adjacent-entering-left",held4Family,held4Label⟩
private theorem held4Name : held4.label = "adjacent-entering-left" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "adjacent-entering-right" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","adjacent-entering-right",held5Family,held5Label⟩
private theorem held5Name : held5.label = "adjacent-entering-right" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "adjacent-base-left" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","adjacent-base-left",held6Family,held6Label⟩
private theorem held6Name : held6.label = "adjacent-base-left" := rfl
private theorem held7Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held7Label : SFT.Physics.CapabilityValues.nonblank "adjacent-base-right" = true := rfl
private def held7 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","adjacent-base-right",held7Family,held7Label⟩
private theorem held7Name : held7.label = "adjacent-base-right" := rfl
private theorem held8Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held8Label : SFT.Physics.CapabilityValues.nonblank "adjacent-layer-1" = true := rfl
private def held8 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","adjacent-layer-1",held8Family,held8Label⟩
private theorem held8Name : held8.label = "adjacent-layer-1" := rfl
private theorem held9Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held9Label : SFT.Physics.CapabilityValues.nonblank "adjacent-addend" = true := rfl
private def held9 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","adjacent-addend",held9Family,held9Label⟩
private theorem held9Name : held9.label = "adjacent-addend" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3,held4,held5],[⟨held1,held2,held6⟩,⟨held2,held3,held7⟩,⟨held1,held2,held8⟩,⟨held4,held5,held9⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["adjacent-left","adjacent-middle","adjacent-right","adjacent-entering-left","adjacent-entering-right"],[("adjacent-left","adjacent-middle"),("adjacent-middle","adjacent-left"),("adjacent-middle","adjacent-right"),("adjacent-right","adjacent-middle"),("adjacent-left","adjacent-middle"),("adjacent-middle","adjacent-left"),("adjacent-entering-left","adjacent-entering-right"),("adjacent-entering-right","adjacent-entering-left")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "adjacent-entering-left" "adjacent-entering-left" = true := by
 change reachable sourceSameGraph "adjacent-entering-left" "adjacent-entering-left" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "adjacent-entering-left" "adjacent-entering-right" = true := by
 change reachable sourceSameGraph "adjacent-entering-left" "adjacent-entering-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-entering-left"
 change searchLoop sourceSameGraph.edges "adjacent-entering-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-entering-right" s0 "adjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-right" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "adjacent-entering-right" s1 [] (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "adjacent-entering-left" "adjacent-left" = false := by
 change reachable sourceSameGraph "adjacent-entering-left" "adjacent-left" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-entering-left"
 change searchLoop sourceSameGraph.edges "adjacent-left" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-left" s0 "adjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-left" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-left" s1 "adjacent-entering-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "adjacent-entering-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-left" s2 = false
 exact searchEmpty sourceSameGraph.edges "adjacent-left" s2 (by rfl)
#print axioms reach_0_2
private theorem reach_0_3 : reachable (graph sourceSame) "adjacent-entering-left" "adjacent-middle" = false := by
 change reachable sourceSameGraph "adjacent-entering-left" "adjacent-middle" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-entering-left"
 change searchLoop sourceSameGraph.edges "adjacent-middle" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-middle" s0 "adjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-middle" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-middle" s1 "adjacent-entering-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "adjacent-entering-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-middle" s2 = false
 exact searchEmpty sourceSameGraph.edges "adjacent-middle" s2 (by rfl)
#print axioms reach_0_3
private theorem reach_0_4 : reachable (graph sourceSame) "adjacent-entering-left" "adjacent-right" = false := by
 change reachable sourceSameGraph "adjacent-entering-left" "adjacent-right" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-entering-left"
 change searchLoop sourceSameGraph.edges "adjacent-right" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-right" s0 "adjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-right" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-right" s1 "adjacent-entering-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "adjacent-entering-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-right" s2 = false
 exact searchEmpty sourceSameGraph.edges "adjacent-right" s2 (by rfl)
#print axioms reach_0_4
private theorem reach_1_0 : reachable (graph sourceSame) "adjacent-left" "adjacent-entering-left" = false := by
 change reachable sourceSameGraph "adjacent-left" "adjacent-entering-left" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-left"
 change searchLoop sourceSameGraph.edges "adjacent-entering-left" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-entering-left" s0 "adjacent-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-left" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-entering-left" s1 "adjacent-middle" ["adjacent-middle"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "adjacent-middle" ["adjacent-middle"] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-left" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "adjacent-entering-left" s2 "adjacent-middle" ["adjacent-right"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "adjacent-middle" ["adjacent-right"] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-left" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-entering-left" s3 "adjacent-right" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "adjacent-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-left" s4 = false
 exact searchEmpty sourceSameGraph.edges "adjacent-entering-left" s4 (by rfl)
#print axioms reach_1_0
private theorem reach_1_1 : reachable (graph sourceSame) "adjacent-left" "adjacent-entering-right" = false := by
 change reachable sourceSameGraph "adjacent-left" "adjacent-entering-right" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-left"
 change searchLoop sourceSameGraph.edges "adjacent-entering-right" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-entering-right" s0 "adjacent-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-right" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-entering-right" s1 "adjacent-middle" ["adjacent-middle"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "adjacent-middle" ["adjacent-middle"] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-right" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "adjacent-entering-right" s2 "adjacent-middle" ["adjacent-right"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "adjacent-middle" ["adjacent-right"] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-right" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-entering-right" s3 "adjacent-right" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "adjacent-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-entering-right" s4 = false
 exact searchEmpty sourceSameGraph.edges "adjacent-entering-right" s4 (by rfl)
#print axioms reach_1_1
private theorem reach_1_2 : reachable (graph sourceSame) "adjacent-left" "adjacent-left" = true := by
 change reachable sourceSameGraph "adjacent-left" "adjacent-left" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_1_2
private theorem reach_1_3 : reachable (graph sourceSame) "adjacent-left" "adjacent-middle" = true := by
 change reachable sourceSameGraph "adjacent-left" "adjacent-middle" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-left"
 change searchLoop sourceSameGraph.edges "adjacent-middle" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-middle" s0 "adjacent-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-middle" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "adjacent-middle" s1 ["adjacent-middle"] (by rfl)
#print axioms reach_1_3
private theorem reach_1_4 : reachable (graph sourceSame) "adjacent-left" "adjacent-right" = true := by
 change reachable sourceSameGraph "adjacent-left" "adjacent-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "adjacent-left"
 change searchLoop sourceSameGraph.edges "adjacent-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-right" s0 "adjacent-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "adjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-right" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "adjacent-right" s1 "adjacent-middle" ["adjacent-middle"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "adjacent-middle" ["adjacent-middle"] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-right" s2 = true
 rw [searchSkipsVisited sourceSameGraph.edges "adjacent-right" s2 "adjacent-middle" ["adjacent-right"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "adjacent-middle" ["adjacent-right"] (by rfl)
 change searchLoop sourceSameGraph.edges "adjacent-right" s3 = true
 exact searchHitsTarget sourceSameGraph.edges "adjacent-right" s3 [] (by rfl)
#print axioms reach_1_4
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "adjacent-entering-left" b.label) = [held4,held5] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) = (match reachable (graph sourceSame) "adjacent-entering-left" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) | false => ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-left" from rfl,reach_0_2]
 try dsimp only
 rw [show ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) = (match reachable (graph sourceSame) "adjacent-entering-left" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) | false => ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-middle" from rfl,reach_0_3]
 try dsimp only
 rw [show ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) = (match reachable (graph sourceSame) "adjacent-entering-left" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) | false => ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-right" from rfl,reach_0_4]
 try dsimp only
 rw [show ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) = (match reachable (graph sourceSame) "adjacent-entering-left" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) | false => ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-entering-left" from rfl,reach_0_0]
 try dsimp only
 rw [show ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) = (match reachable (graph sourceSame) "adjacent-entering-left" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-entering-left" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-entering-right" from rfl,reach_0_1]
 try dsimp only
 rfl
#print axioms filterSeed0
private theorem filterSeed1 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "adjacent-left" b.label) = [held1,held2,held3] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) = (match reachable (graph sourceSame) "adjacent-left" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) | false => ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-left" from rfl,reach_1_2]
 try dsimp only
 rw [show ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) = (match reachable (graph sourceSame) "adjacent-left" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) | false => ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-middle" from rfl,reach_1_3]
 try dsimp only
 rw [show ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) = (match reachable (graph sourceSame) "adjacent-left" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) | false => ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-right" from rfl,reach_1_4]
 try dsimp only
 rw [show ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) = (match reachable (graph sourceSame) "adjacent-left" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) | false => ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-entering-left" from rfl,reach_1_0]
 try dsimp only
 rw [show ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) = (match reachable (graph sourceSame) "adjacent-left" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "adjacent-left" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "adjacent-entering-right" from rfl,reach_1_1]
 try dsimp only
 rfl
#print axioms filterSeed1
theorem sourceSameComponents : connectedComponents sourceSame = [[held4,held5],[held1,held2,held3]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held4,held5,held1,held2,held3] = [[held4,held5],[held1,held2,held3]]
 have step0 : step [] held4 = [[held4,held5]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "adjacent-entering-left" b.label)] = [[held4,held5]]
  rw [filterSeed0]
  rfl
 rw [List.foldl_cons,step0]
 have step1 : step [[held4,held5]] held5 = [[held4,held5]] := by
  rfl
 rw [List.foldl_cons,step1]
 have step2 : step [[held4,held5]] held1 = [[held4,held5],[held1,held2,held3]] := by
  change [[held4,held5]] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "adjacent-left" b.label)] = [[held4,held5],[held1,held2,held3]]
  rw [filterSeed1]
  rfl
 rw [List.foldl_cons,step2]
 have step3 : step [[held4,held5],[held1,held2,held3]] held2 = [[held4,held5],[held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step3]
 have step4 : step [[held4,held5],[held1,held2,held3]] held3 = [[held4,held5],[held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step4]
 rfl
#print axioms sourceSameComponents
theorem sourceOrderedComponents : AdditionTransform.sourceComponents sourceSame = [[held1,held2,held3],[held4,held5]] := by
 unfold AdditionTransform.sourceComponents
 rw [sourceSameComponents]
 rfl
#print axioms sourceOrderedComponents
theorem distance0 : shortestDistance sourceSame held1 held2 = .ok (.count ⟨1,by decide⟩) := by
 have search : distanceLoop sourceSameGraph.edges "adjacent-middle" (initialSearch sourceSameGraph.edges "adjacent-left") [0] = some 1 := by
  let s0 := initialSearch sourceSameGraph.edges "adjacent-left"
  change distanceLoop sourceSameGraph.edges "adjacent-middle" s0 [0] = some 1
  rw [distanceLoopEquation]
  let s1 := expandState sourceSameGraph.edges s0 "adjacent-left" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "adjacent-middle" s1 [1,1] = some 1
  rw [distanceLoopEquation]
  rfl
 unfold shortestDistance
 rw [ite_eq_right (by decide)]
 change (match distanceLoop sourceSameGraph.edges "adjacent-middle" (initialSearch sourceSameGraph.edges "adjacent-left") [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok (.count ⟨1,by decide⟩)
 rw [search]
 rfl
#print axioms distance0
theorem distance1 : shortestDistance sourceSame held4 held5 = .ok (.count ⟨1,by decide⟩) := by
 have search : distanceLoop sourceSameGraph.edges "adjacent-entering-right" (initialSearch sourceSameGraph.edges "adjacent-entering-left") [0] = some 1 := by
  let s0 := initialSearch sourceSameGraph.edges "adjacent-entering-left"
  change distanceLoop sourceSameGraph.edges "adjacent-entering-right" s0 [0] = some 1
  rw [distanceLoopEquation]
  let s1 := expandState sourceSameGraph.edges s0 "adjacent-entering-left" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "adjacent-entering-right" s1 [1] = some 1
  rw [distanceLoopEquation]
  rfl
 unfold shortestDistance
 rw [ite_eq_right (by decide)]
 change (match distanceLoop sourceSameGraph.edges "adjacent-entering-right" (initialSearch sourceSameGraph.edges "adjacent-entering-left") [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok (.count ⟨1,by decide⟩)
 rw [search]
 rfl
#print axioms distance1
end SFT.Chemistry.AdditionWitnessGraphs.AdjacentSource
