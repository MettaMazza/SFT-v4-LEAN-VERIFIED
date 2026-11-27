import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.AdditionWitnessGraphs.CycloSource
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "cyclo-source" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","cyclo-source",held0Family,held0Label⟩
private theorem held0Name : held0.label = "cyclo-source" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "cyclo-a" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","cyclo-a",held1Family,held1Label⟩
private theorem held1Name : held1.label = "cyclo-a" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "cyclo-b" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","cyclo-b",held2Family,held2Label⟩
private theorem held2Name : held2.label = "cyclo-b" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "cyclo-c" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","cyclo-c",held3Family,held3Label⟩
private theorem held3Name : held3.label = "cyclo-c" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "cyclo-d" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","cyclo-d",held4Family,held4Label⟩
private theorem held4Name : held4.label = "cyclo-d" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "cyclo-e" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","cyclo-e",held5Family,held5Label⟩
private theorem held5Name : held5.label = "cyclo-e" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "cyclo-f" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","cyclo-f",held6Family,held6Label⟩
private theorem held6Name : held6.label = "cyclo-f" := rfl
private theorem held7Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held7Label : SFT.Physics.CapabilityValues.nonblank "cyclo-base-ab" = true := rfl
private def held7 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","cyclo-base-ab",held7Family,held7Label⟩
private theorem held7Name : held7.label = "cyclo-base-ab" := rfl
private theorem held8Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held8Label : SFT.Physics.CapabilityValues.nonblank "cyclo-layer-ab" = true := rfl
private def held8 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","cyclo-layer-ab",held8Family,held8Label⟩
private theorem held8Name : held8.label = "cyclo-layer-ab" := rfl
private theorem held9Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held9Label : SFT.Physics.CapabilityValues.nonblank "cyclo-base-bc" = true := rfl
private def held9 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","cyclo-base-bc",held9Family,held9Label⟩
private theorem held9Name : held9.label = "cyclo-base-bc" := rfl
private theorem held10Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held10Label : SFT.Physics.CapabilityValues.nonblank "cyclo-base-cd" = true := rfl
private def held10 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","cyclo-base-cd",held10Family,held10Label⟩
private theorem held10Name : held10.label = "cyclo-base-cd" := rfl
private theorem held11Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held11Label : SFT.Physics.CapabilityValues.nonblank "cyclo-layer-cd" = true := rfl
private def held11 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","cyclo-layer-cd",held11Family,held11Label⟩
private theorem held11Name : held11.label = "cyclo-layer-cd" := rfl
private theorem held12Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held12Label : SFT.Physics.CapabilityValues.nonblank "cyclo-base-ef" = true := rfl
private def held12 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","cyclo-base-ef",held12Family,held12Label⟩
private theorem held12Name : held12.label = "cyclo-base-ef" := rfl
private theorem held13Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held13Label : SFT.Physics.CapabilityValues.nonblank "cyclo-layer-ef" = true := rfl
private def held13 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","cyclo-layer-ef",held13Family,held13Label⟩
private theorem held13Name : held13.label = "cyclo-layer-ef" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3,held4,held5,held6],[⟨held1,held2,held7⟩,⟨held1,held2,held8⟩,⟨held2,held3,held9⟩,⟨held3,held4,held10⟩,⟨held3,held4,held11⟩,⟨held5,held6,held12⟩,⟨held5,held6,held13⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["cyclo-a","cyclo-b","cyclo-c","cyclo-d","cyclo-e","cyclo-f"],[("cyclo-a","cyclo-b"),("cyclo-b","cyclo-a"),("cyclo-a","cyclo-b"),("cyclo-b","cyclo-a"),("cyclo-b","cyclo-c"),("cyclo-c","cyclo-b"),("cyclo-c","cyclo-d"),("cyclo-d","cyclo-c"),("cyclo-c","cyclo-d"),("cyclo-d","cyclo-c"),("cyclo-e","cyclo-f"),("cyclo-f","cyclo-e"),("cyclo-e","cyclo-f"),("cyclo-f","cyclo-e")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "cyclo-a" "cyclo-a" = true := by
 change reachable sourceSameGraph "cyclo-a" "cyclo-a" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "cyclo-a" "cyclo-b" = true := by
 change reachable sourceSameGraph "cyclo-a" "cyclo-b" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-a"
 change searchLoop sourceSameGraph.edges "cyclo-b" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-b" s0 "cyclo-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-b" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "cyclo-b" s1 ["cyclo-b"] (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "cyclo-a" "cyclo-c" = true := by
 change reachable sourceSameGraph "cyclo-a" "cyclo-c" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-a"
 change searchLoop sourceSameGraph.edges "cyclo-c" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-c" s0 "cyclo-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-c" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-c" s1 "cyclo-b" ["cyclo-b"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-b" ["cyclo-b"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-c" s2 = true
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-c" s2 "cyclo-b" ["cyclo-c"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-b" ["cyclo-c"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-c" s3 = true
 exact searchHitsTarget sourceSameGraph.edges "cyclo-c" s3 [] (by rfl)
#print axioms reach_0_2
private theorem reach_0_3 : reachable (graph sourceSame) "cyclo-a" "cyclo-d" = true := by
 change reachable sourceSameGraph "cyclo-a" "cyclo-d" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-a"
 change searchLoop sourceSameGraph.edges "cyclo-d" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-d" s0 "cyclo-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-d" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-d" s1 "cyclo-b" ["cyclo-b"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-b" ["cyclo-b"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-d" s2 = true
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-d" s2 "cyclo-b" ["cyclo-c"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-b" ["cyclo-c"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-d" s3 = true
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-d" s3 "cyclo-c" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "cyclo-c" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-d" s4 = true
 exact searchHitsTarget sourceSameGraph.edges "cyclo-d" s4 ["cyclo-d"] (by rfl)
#print axioms reach_0_3
private theorem reach_0_4 : reachable (graph sourceSame) "cyclo-a" "cyclo-e" = false := by
 change reachable sourceSameGraph "cyclo-a" "cyclo-e" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-a"
 change searchLoop sourceSameGraph.edges "cyclo-e" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-e" s0 "cyclo-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-e" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-e" s1 "cyclo-b" ["cyclo-b"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-b" ["cyclo-b"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-e" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-e" s2 "cyclo-b" ["cyclo-c"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-b" ["cyclo-c"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-e" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-e" s3 "cyclo-c" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "cyclo-c" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-e" s4 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-e" s4 "cyclo-d" ["cyclo-d"] (by rfl) (by decide) (by decide)]
 let s5 := expandState sourceSameGraph.edges s4 "cyclo-d" ["cyclo-d"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-e" s5 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-e" s5 "cyclo-d" [] (by rfl) (by decide) (by decide)]
 let s6 := skipState sourceSameGraph.edges s5 "cyclo-d" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-e" s6 = false
 exact searchEmpty sourceSameGraph.edges "cyclo-e" s6 (by rfl)
#print axioms reach_0_4
private theorem reach_0_5 : reachable (graph sourceSame) "cyclo-a" "cyclo-f" = false := by
 change reachable sourceSameGraph "cyclo-a" "cyclo-f" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-a"
 change searchLoop sourceSameGraph.edges "cyclo-f" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-f" s0 "cyclo-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-f" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-f" s1 "cyclo-b" ["cyclo-b"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-b" ["cyclo-b"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-f" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-f" s2 "cyclo-b" ["cyclo-c"] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-b" ["cyclo-c"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-f" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-f" s3 "cyclo-c" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "cyclo-c" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-f" s4 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-f" s4 "cyclo-d" ["cyclo-d"] (by rfl) (by decide) (by decide)]
 let s5 := expandState sourceSameGraph.edges s4 "cyclo-d" ["cyclo-d"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-f" s5 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-f" s5 "cyclo-d" [] (by rfl) (by decide) (by decide)]
 let s6 := skipState sourceSameGraph.edges s5 "cyclo-d" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-f" s6 = false
 exact searchEmpty sourceSameGraph.edges "cyclo-f" s6 (by rfl)
#print axioms reach_0_5
private theorem reach_1_0 : reachable (graph sourceSame) "cyclo-e" "cyclo-a" = false := by
 change reachable sourceSameGraph "cyclo-e" "cyclo-a" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-e"
 change searchLoop sourceSameGraph.edges "cyclo-a" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-a" s0 "cyclo-e" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-e" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-a" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-a" s1 "cyclo-f" ["cyclo-f"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-f" ["cyclo-f"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-a" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-a" s2 "cyclo-f" [] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-f" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-a" s3 = false
 exact searchEmpty sourceSameGraph.edges "cyclo-a" s3 (by rfl)
#print axioms reach_1_0
private theorem reach_1_1 : reachable (graph sourceSame) "cyclo-e" "cyclo-b" = false := by
 change reachable sourceSameGraph "cyclo-e" "cyclo-b" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-e"
 change searchLoop sourceSameGraph.edges "cyclo-b" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-b" s0 "cyclo-e" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-e" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-b" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-b" s1 "cyclo-f" ["cyclo-f"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-f" ["cyclo-f"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-b" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-b" s2 "cyclo-f" [] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-f" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-b" s3 = false
 exact searchEmpty sourceSameGraph.edges "cyclo-b" s3 (by rfl)
#print axioms reach_1_1
private theorem reach_1_2 : reachable (graph sourceSame) "cyclo-e" "cyclo-c" = false := by
 change reachable sourceSameGraph "cyclo-e" "cyclo-c" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-e"
 change searchLoop sourceSameGraph.edges "cyclo-c" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-c" s0 "cyclo-e" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-e" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-c" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-c" s1 "cyclo-f" ["cyclo-f"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-f" ["cyclo-f"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-c" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-c" s2 "cyclo-f" [] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-f" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-c" s3 = false
 exact searchEmpty sourceSameGraph.edges "cyclo-c" s3 (by rfl)
#print axioms reach_1_2
private theorem reach_1_3 : reachable (graph sourceSame) "cyclo-e" "cyclo-d" = false := by
 change reachable sourceSameGraph "cyclo-e" "cyclo-d" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-e"
 change searchLoop sourceSameGraph.edges "cyclo-d" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-d" s0 "cyclo-e" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-e" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-d" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-d" s1 "cyclo-f" ["cyclo-f"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "cyclo-f" ["cyclo-f"] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-d" s2 = false
 rw [searchSkipsVisited sourceSameGraph.edges "cyclo-d" s2 "cyclo-f" [] (by rfl) (by decide) (by decide)]
 let s3 := skipState sourceSameGraph.edges s2 "cyclo-f" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-d" s3 = false
 exact searchEmpty sourceSameGraph.edges "cyclo-d" s3 (by rfl)
#print axioms reach_1_3
private theorem reach_1_4 : reachable (graph sourceSame) "cyclo-e" "cyclo-e" = true := by
 change reachable sourceSameGraph "cyclo-e" "cyclo-e" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_1_4
private theorem reach_1_5 : reachable (graph sourceSame) "cyclo-e" "cyclo-f" = true := by
 change reachable sourceSameGraph "cyclo-e" "cyclo-f" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "cyclo-e"
 change searchLoop sourceSameGraph.edges "cyclo-f" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "cyclo-f" s0 "cyclo-e" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "cyclo-e" [] (by rfl)
 change searchLoop sourceSameGraph.edges "cyclo-f" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "cyclo-f" s1 ["cyclo-f"] (by rfl)
#print axioms reach_1_5
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "cyclo-a" b.label) = [held1,held2,held3,held4] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5,held6] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) = (match reachable (graph sourceSame) "cyclo-a" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) | false => ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-a" from rfl,reach_0_0]
 try dsimp only
 rw [show ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) = (match reachable (graph sourceSame) "cyclo-a" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) | false => ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-b" from rfl,reach_0_1]
 try dsimp only
 rw [show ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) = (match reachable (graph sourceSame) "cyclo-a" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) | false => ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-c" from rfl,reach_0_2]
 try dsimp only
 rw [show ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) = (match reachable (graph sourceSame) "cyclo-a" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) | false => ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-d" from rfl,reach_0_3]
 try dsimp only
 rw [show ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) = (match reachable (graph sourceSame) "cyclo-a" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) | false => ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-e" from rfl,reach_0_4]
 try dsimp only
 rw [show ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) = (match reachable (graph sourceSame) "cyclo-a" (held6 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held6 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-a" b.label)) from rfl]
 rw [show (held6 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-f" from rfl,reach_0_5]
 try dsimp only
 rfl
#print axioms filterSeed0
private theorem filterSeed1 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "cyclo-e" b.label) = [held5,held6] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5,held6] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) = (match reachable (graph sourceSame) "cyclo-e" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) | false => ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-a" from rfl,reach_1_0]
 try dsimp only
 rw [show ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) = (match reachable (graph sourceSame) "cyclo-e" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) | false => ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-b" from rfl,reach_1_1]
 try dsimp only
 rw [show ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) = (match reachable (graph sourceSame) "cyclo-e" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) | false => ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-c" from rfl,reach_1_2]
 try dsimp only
 rw [show ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) = (match reachable (graph sourceSame) "cyclo-e" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) | false => ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-d" from rfl,reach_1_3]
 try dsimp only
 rw [show ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) = (match reachable (graph sourceSame) "cyclo-e" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) | false => ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-e" from rfl,reach_1_4]
 try dsimp only
 rw [show ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) = (match reachable (graph sourceSame) "cyclo-e" (held6 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held6 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "cyclo-e" b.label)) from rfl]
 rw [show (held6 : SFT.Physics.CapabilityValues.HeldLabel).label = "cyclo-f" from rfl,reach_1_5]
 try dsimp only
 rfl
#print axioms filterSeed1
theorem sourceSameComponents : connectedComponents sourceSame = [[held1,held2,held3,held4],[held5,held6]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held1,held2,held3,held4,held5,held6] = [[held1,held2,held3,held4],[held5,held6]]
 have step0 : step [] held1 = [[held1,held2,held3,held4]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "cyclo-a" b.label)] = [[held1,held2,held3,held4]]
  rw [filterSeed0]
  rfl
 rw [List.foldl_cons,step0]
 have step1 : step [[held1,held2,held3,held4]] held2 = [[held1,held2,held3,held4]] := by
  rfl
 rw [List.foldl_cons,step1]
 have step2 : step [[held1,held2,held3,held4]] held3 = [[held1,held2,held3,held4]] := by
  rfl
 rw [List.foldl_cons,step2]
 have step3 : step [[held1,held2,held3,held4]] held4 = [[held1,held2,held3,held4]] := by
  rfl
 rw [List.foldl_cons,step3]
 have step4 : step [[held1,held2,held3,held4]] held5 = [[held1,held2,held3,held4],[held5,held6]] := by
  change [[held1,held2,held3,held4]] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "cyclo-e" b.label)] = [[held1,held2,held3,held4],[held5,held6]]
  rw [filterSeed1]
  rfl
 rw [List.foldl_cons,step4]
 have step5 : step [[held1,held2,held3,held4],[held5,held6]] held6 = [[held1,held2,held3,held4],[held5,held6]] := by
  rfl
 rw [List.foldl_cons,step5]
 rfl
#print axioms sourceSameComponents
theorem sourceOrderedComponents : AdditionTransform.sourceComponents sourceSame = [[held1,held2,held3,held4],[held5,held6]] := by
 unfold AdditionTransform.sourceComponents
 rw [sourceSameComponents]
 rfl
#print axioms sourceOrderedComponents
theorem distance0 : shortestDistance sourceSame held1 held4 = .ok (.count ⟨3,by decide⟩) := by
 have search : distanceLoop sourceSameGraph.edges "cyclo-d" (initialSearch sourceSameGraph.edges "cyclo-a") [0] = some 3 := by
  let s0 := initialSearch sourceSameGraph.edges "cyclo-a"
  change distanceLoop sourceSameGraph.edges "cyclo-d" s0 [0] = some 3
  rw [distanceLoopEquation]
  let s1 := expandState sourceSameGraph.edges s0 "cyclo-a" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "cyclo-d" s1 [1,1] = some 3
  rw [distanceLoopEquation]
  let s2 := expandState sourceSameGraph.edges s1 "cyclo-b" ["cyclo-b"] (by rfl)
  change distanceLoop sourceSameGraph.edges "cyclo-d" s2 [1,2] = some 3
  rw [distanceLoopEquation]
  let s3 := skipState sourceSameGraph.edges s2 "cyclo-b" ["cyclo-c"] (by rfl)
  change distanceLoop sourceSameGraph.edges "cyclo-d" s3 [2] = some 3
  rw [distanceLoopEquation]
  let s4 := expandState sourceSameGraph.edges s3 "cyclo-c" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "cyclo-d" s4 [3,3] = some 3
  rw [distanceLoopEquation]
  rfl
 unfold shortestDistance
 rw [ite_eq_right (by decide)]
 change (match distanceLoop sourceSameGraph.edges "cyclo-d" (initialSearch sourceSameGraph.edges "cyclo-a") [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok (.count ⟨3,by decide⟩)
 rw [search]
 rfl
#print axioms distance0
theorem distance1 : shortestDistance sourceSame held5 held6 = .ok (.count ⟨1,by decide⟩) := by
 have search : distanceLoop sourceSameGraph.edges "cyclo-f" (initialSearch sourceSameGraph.edges "cyclo-e") [0] = some 1 := by
  let s0 := initialSearch sourceSameGraph.edges "cyclo-e"
  change distanceLoop sourceSameGraph.edges "cyclo-f" s0 [0] = some 1
  rw [distanceLoopEquation]
  let s1 := expandState sourceSameGraph.edges s0 "cyclo-e" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "cyclo-f" s1 [1,1] = some 1
  rw [distanceLoopEquation]
  rfl
 unfold shortestDistance
 rw [ite_eq_right (by decide)]
 change (match distanceLoop sourceSameGraph.edges "cyclo-f" (initialSearch sourceSameGraph.edges "cyclo-e") [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok (.count ⟨1,by decide⟩)
 rw [search]
 rfl
#print axioms distance1
end SFT.Chemistry.AdditionWitnessGraphs.CycloSource
