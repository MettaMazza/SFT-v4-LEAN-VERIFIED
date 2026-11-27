import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.EliminationWitnessGraphs.SameSource
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "elim-same-products" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","elim-same-products",held0Family,held0Label⟩
private theorem held0Name : held0.label = "elim-same-products" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "elim-same-left" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-same-left",held1Family,held1Label⟩
private theorem held1Name : held1.label = "elim-same-left" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "elim-same-middle" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-same-middle",held2Family,held2Label⟩
private theorem held2Name : held2.label = "elim-same-middle" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "elim-same-right" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-same-right",held3Family,held3Label⟩
private theorem held3Name : held3.label = "elim-same-right" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "elim-same-enter-left" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-same-enter-left",held4Family,held4Label⟩
private theorem held4Name : held4.label = "elim-same-enter-left" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "elim-same-enter-right" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-same-enter-right",held5Family,held5Label⟩
private theorem held5Name : held5.label = "elim-same-enter-right" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "elim-same-base-left" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-same-base-left",held6Family,held6Label⟩
private theorem held6Name : held6.label = "elim-same-base-left" := rfl
private theorem held7Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held7Label : SFT.Physics.CapabilityValues.nonblank "elim-same-base-right" = true := rfl
private def held7 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-same-base-right",held7Family,held7Label⟩
private theorem held7Name : held7.label = "elim-same-base-right" := rfl
private theorem held8Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held8Label : SFT.Physics.CapabilityValues.nonblank "elim-same-layer-1" = true := rfl
private def held8 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-same-layer-1",held8Family,held8Label⟩
private theorem held8Name : held8.label = "elim-same-layer-1" := rfl
private theorem held9Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held9Label : SFT.Physics.CapabilityValues.nonblank "elim-same-entering" = true := rfl
private def held9 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-same-entering",held9Family,held9Label⟩
private theorem held9Name : held9.label = "elim-same-entering" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3,held4,held5],[⟨held1,held2,held6⟩,⟨held2,held3,held7⟩,⟨held1,held2,held8⟩,⟨held4,held5,held9⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["elim-same-left","elim-same-middle","elim-same-right","elim-same-enter-left","elim-same-enter-right"],[("elim-same-left","elim-same-middle"),("elim-same-middle","elim-same-left"),("elim-same-middle","elim-same-right"),("elim-same-right","elim-same-middle"),("elim-same-left","elim-same-middle"),("elim-same-middle","elim-same-left"),("elim-same-enter-left","elim-same-enter-right"),("elim-same-enter-right","elim-same-enter-left")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "elim-same-enter-left" "elim-same-enter-left" = true := by
 change reachable sourceSameGraph "elim-same-enter-left" "elim-same-enter-left" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "elim-same-enter-left" "elim-same-enter-right" = true := by
 change reachable sourceSameGraph "elim-same-enter-left" "elim-same-enter-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-enter-left"
 change searchLoop sourceSameGraph.edges "elim-same-enter-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-enter-right" s0 "elim-same-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-right" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "elim-same-enter-right" s1 [] (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "elim-same-enter-left" "elim-same-left" = false := by
 change reachable sourceSameGraph "elim-same-enter-left" "elim-same-left" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-enter-left"
 change searchLoop sourceSameGraph.edges "elim-same-left" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-left" s0 "elim-same-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-left" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-left" s1 "elim-same-enter-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-same-enter-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-left" s2 = false
 exact searchEmpty sourceSameGraph.edges "elim-same-left" s2 (by rfl)
#print axioms reach_0_2
private theorem reach_0_3 : reachable (graph sourceSame) "elim-same-enter-left" "elim-same-middle" = false := by
 change reachable sourceSameGraph "elim-same-enter-left" "elim-same-middle" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-enter-left"
 change searchLoop sourceSameGraph.edges "elim-same-middle" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-middle" s0 "elim-same-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-middle" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-middle" s1 "elim-same-enter-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-same-enter-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-middle" s2 = false
 exact searchEmpty sourceSameGraph.edges "elim-same-middle" s2 (by rfl)
#print axioms reach_0_3
private theorem reach_0_4 : reachable (graph sourceSame) "elim-same-enter-left" "elim-same-right" = false := by
 change reachable sourceSameGraph "elim-same-enter-left" "elim-same-right" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-enter-left"
 change searchLoop sourceSameGraph.edges "elim-same-right" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-right" s0 "elim-same-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-right" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-right" s1 "elim-same-enter-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-same-enter-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-right" s2 = false
 exact searchEmpty sourceSameGraph.edges "elim-same-right" s2 (by rfl)
#print axioms reach_0_4
private theorem reach_1_0 : reachable (graph sourceSame) "elim-same-left" "elim-same-enter-left" = false := by
 change reachable sourceSameGraph "elim-same-left" "elim-same-enter-left" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-left"
 change searchLoop sourceSameGraph.edges "elim-same-enter-left" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-enter-left" s0 "elim-same-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-left" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-enter-left" s1 "elim-same-middle" ["elim-same-middle"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-same-middle" ["elim-same-middle"] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-left" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "elim-same-enter-left" s2 "elim-same-middle" ["elim-same-right"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "elim-same-middle" ["elim-same-right"] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-left" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-enter-left" s3 "elim-same-right" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "elim-same-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-left" s4 = false
 exact searchEmpty sourceSameGraph.edges "elim-same-enter-left" s4 (by rfl)
#print axioms reach_1_0
private theorem reach_1_1 : reachable (graph sourceSame) "elim-same-left" "elim-same-enter-right" = false := by
 change reachable sourceSameGraph "elim-same-left" "elim-same-enter-right" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-left"
 change searchLoop sourceSameGraph.edges "elim-same-enter-right" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-enter-right" s0 "elim-same-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-right" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-enter-right" s1 "elim-same-middle" ["elim-same-middle"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-same-middle" ["elim-same-middle"] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-right" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "elim-same-enter-right" s2 "elim-same-middle" ["elim-same-right"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "elim-same-middle" ["elim-same-right"] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-right" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-enter-right" s3 "elim-same-right" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "elim-same-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-enter-right" s4 = false
 exact searchEmpty sourceSameGraph.edges "elim-same-enter-right" s4 (by rfl)
#print axioms reach_1_1
private theorem reach_1_2 : reachable (graph sourceSame) "elim-same-left" "elim-same-left" = true := by
 change reachable sourceSameGraph "elim-same-left" "elim-same-left" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_1_2
private theorem reach_1_3 : reachable (graph sourceSame) "elim-same-left" "elim-same-middle" = true := by
 change reachable sourceSameGraph "elim-same-left" "elim-same-middle" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-left"
 change searchLoop sourceSameGraph.edges "elim-same-middle" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-middle" s0 "elim-same-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-middle" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "elim-same-middle" s1 ["elim-same-middle"] (by rfl)
#print axioms reach_1_3
private theorem reach_1_4 : reachable (graph sourceSame) "elim-same-left" "elim-same-right" = true := by
 change reachable sourceSameGraph "elim-same-left" "elim-same-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-same-left"
 change searchLoop sourceSameGraph.edges "elim-same-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-right" s0 "elim-same-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-same-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-right" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-same-right" s1 "elim-same-middle" ["elim-same-middle"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-same-middle" ["elim-same-middle"] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-right" s2 = true
 rw [searchSkipsVisited sourceSameGraph.edges "elim-same-right" s2 "elim-same-middle" ["elim-same-right"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "elim-same-middle" ["elim-same-right"] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-same-right" s3 = true
 exact searchHitsTarget sourceSameGraph.edges "elim-same-right" s3 [] (by rfl)
#print axioms reach_1_4
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "elim-same-enter-left" b.label) = [held4,held5] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) = (match reachable (graph sourceSame) "elim-same-enter-left" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) | false => ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-left" from rfl,reach_0_2]
 try dsimp only
 rw [show ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) = (match reachable (graph sourceSame) "elim-same-enter-left" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) | false => ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-middle" from rfl,reach_0_3]
 try dsimp only
 rw [show ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) = (match reachable (graph sourceSame) "elim-same-enter-left" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) | false => ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-right" from rfl,reach_0_4]
 try dsimp only
 rw [show ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) = (match reachable (graph sourceSame) "elim-same-enter-left" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) | false => ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-enter-left" from rfl,reach_0_0]
 try dsimp only
 rw [show ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) = (match reachable (graph sourceSame) "elim-same-enter-left" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-enter-left" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-enter-right" from rfl,reach_0_1]
 try dsimp only
 rfl
#print axioms filterSeed0
private theorem filterSeed1 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "elim-same-left" b.label) = [held1,held2,held3] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) = (match reachable (graph sourceSame) "elim-same-left" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) | false => ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-left" from rfl,reach_1_2]
 try dsimp only
 rw [show ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) = (match reachable (graph sourceSame) "elim-same-left" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) | false => ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-middle" from rfl,reach_1_3]
 try dsimp only
 rw [show ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) = (match reachable (graph sourceSame) "elim-same-left" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) | false => ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-right" from rfl,reach_1_4]
 try dsimp only
 rw [show ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) = (match reachable (graph sourceSame) "elim-same-left" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) | false => ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-enter-left" from rfl,reach_1_0]
 try dsimp only
 rw [show ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) = (match reachable (graph sourceSame) "elim-same-left" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-same-left" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-same-enter-right" from rfl,reach_1_1]
 try dsimp only
 rfl
#print axioms filterSeed1
theorem sourceSameComponents : connectedComponents sourceSame = [[held4,held5],[held1,held2,held3]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held4,held5,held1,held2,held3] = [[held4,held5],[held1,held2,held3]]
 have step0 : step [] held4 = [[held4,held5]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "elim-same-enter-left" b.label)] = [[held4,held5]]
  rw [filterSeed0]
  rfl
 rw [List.foldl_cons,step0]
 have step1 : step [[held4,held5]] held5 = [[held4,held5]] := by
  rfl
 rw [List.foldl_cons,step1]
 have step2 : step [[held4,held5]] held1 = [[held4,held5],[held1,held2,held3]] := by
  change [[held4,held5]] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "elim-same-left" b.label)] = [[held4,held5],[held1,held2,held3]]
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
theorem distance0 : shortestDistance sourceSame held1 held1 = .ok (.emptyOne) := by
 rfl
#print axioms distance0
theorem distance1 : shortestDistance sourceSame held4 held5 = .ok (.count ⟨1,by decide⟩) := by
 have search : distanceLoop sourceSameGraph.edges "elim-same-enter-right" (initialSearch sourceSameGraph.edges "elim-same-enter-left") [0] = some 1 := by
  let s0 := initialSearch sourceSameGraph.edges "elim-same-enter-left"
  change distanceLoop sourceSameGraph.edges "elim-same-enter-right" s0 [0] = some 1
  rw [distanceLoopEquation]
  let s1 := expandState sourceSameGraph.edges s0 "elim-same-enter-left" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "elim-same-enter-right" s1 [1] = some 1
  rw [distanceLoopEquation]
  rfl
 unfold shortestDistance
 rw [ite_eq_right (by decide)]
 change (match distanceLoop sourceSameGraph.edges "elim-same-enter-right" (initialSearch sourceSameGraph.edges "elim-same-enter-left") [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok (.count ⟨1,by decide⟩)
 rw [search]
 rfl
#print axioms distance1
end SFT.Chemistry.EliminationWitnessGraphs.SameSource
