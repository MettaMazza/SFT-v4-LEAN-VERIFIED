import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.AdditionWitnessGraphs.SuccessorSource
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-source-successor" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","nonadjacent-source-successor",held0Family,held0Label⟩
private theorem held0Name : held0.label = "nonadjacent-source-successor" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-left" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-left",held1Family,held1Label⟩
private theorem held1Name : held1.label = "nonadjacent-left" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-middle" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-middle",held2Family,held2Label⟩
private theorem held2Name : held2.label = "nonadjacent-middle" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-right" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-right",held3Family,held3Label⟩
private theorem held3Name : held3.label = "nonadjacent-right" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-entering-left" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-entering-left",held4Family,held4Label⟩
private theorem held4Name : held4.label = "nonadjacent-entering-left" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-entering-right" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","nonadjacent-entering-right",held5Family,held5Label⟩
private theorem held5Name : held5.label = "nonadjacent-entering-right" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "complete-successor" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","complete-successor",held6Family,held6Label⟩
private theorem held6Name : held6.label = "complete-successor" := rfl
private theorem held7Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held7Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-base-left" = true := rfl
private def held7 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","nonadjacent-base-left",held7Family,held7Label⟩
private theorem held7Name : held7.label = "nonadjacent-base-left" := rfl
private theorem held8Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held8Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-base-right" = true := rfl
private def held8 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","nonadjacent-base-right",held8Family,held8Label⟩
private theorem held8Name : held8.label = "nonadjacent-base-right" := rfl
private theorem held9Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held9Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-layer-1" = true := rfl
private def held9 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","nonadjacent-layer-1",held9Family,held9Label⟩
private theorem held9Name : held9.label = "nonadjacent-layer-1" := rfl
private theorem held10Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held10Label : SFT.Physics.CapabilityValues.nonblank "nonadjacent-addend" = true := rfl
private def held10 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","nonadjacent-addend",held10Family,held10Label⟩
private theorem held10Name : held10.label = "nonadjacent-addend" := rfl
private theorem held11Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held11Label : SFT.Physics.CapabilityValues.nonblank "complete-successor" = true := rfl
private def held11 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","complete-successor",held11Family,held11Label⟩
private theorem held11Name : held11.label = "complete-successor" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3,held4,held5,held6],[⟨held1,held2,held7⟩,⟨held2,held3,held8⟩,⟨held1,held2,held9⟩,⟨held4,held5,held10⟩,⟨held2,held6,held11⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["nonadjacent-left","nonadjacent-middle","nonadjacent-right","nonadjacent-entering-left","nonadjacent-entering-right","complete-successor"],[("nonadjacent-left","nonadjacent-middle"),("nonadjacent-middle","nonadjacent-left"),("nonadjacent-middle","nonadjacent-right"),("nonadjacent-right","nonadjacent-middle"),("nonadjacent-left","nonadjacent-middle"),("nonadjacent-middle","nonadjacent-left"),("nonadjacent-entering-left","nonadjacent-entering-right"),("nonadjacent-entering-right","nonadjacent-entering-left"),("nonadjacent-middle","complete-successor"),("complete-successor","nonadjacent-middle")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "complete-successor" "complete-successor" = true := by
 change reachable sourceSameGraph "complete-successor" "complete-successor" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "complete-successor" "nonadjacent-entering-left" = false := by
 change reachable sourceSameGraph "complete-successor" "nonadjacent-entering-left" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "complete-successor"
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-left" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-left" s0 "complete-successor" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "complete-successor" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-left" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-left" s1 "nonadjacent-middle" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-middle" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-left" s2 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-left" s2 "nonadjacent-left" ["nonadjacent-right","nonadjacent-left"] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "nonadjacent-left" ["nonadjacent-right","nonadjacent-left"] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-left" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-left" s3 "nonadjacent-right" ["nonadjacent-left"] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "nonadjacent-right" ["nonadjacent-left"] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-left" s4 = false
 rw [searchSkipsVisited sourceSameGraph.edges "nonadjacent-entering-left" s4 "nonadjacent-left" [] (by rfl) (by decide) (by decide)]
 let s5 := skipState sourceSameGraph.edges s4 "nonadjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-left" s5 = false
 exact searchEmpty sourceSameGraph.edges "nonadjacent-entering-left" s5 (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "complete-successor" "nonadjacent-entering-right" = false := by
 change reachable sourceSameGraph "complete-successor" "nonadjacent-entering-right" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "complete-successor"
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-right" s0 "complete-successor" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "complete-successor" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-right" s1 "nonadjacent-middle" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-middle" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s2 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-right" s2 "nonadjacent-left" ["nonadjacent-right","nonadjacent-left"] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "nonadjacent-left" ["nonadjacent-right","nonadjacent-left"] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s3 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-right" s3 "nonadjacent-right" ["nonadjacent-left"] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "nonadjacent-right" ["nonadjacent-left"] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s4 = false
 rw [searchSkipsVisited sourceSameGraph.edges "nonadjacent-entering-right" s4 "nonadjacent-left" [] (by rfl) (by decide) (by decide)]
 let s5 := skipState sourceSameGraph.edges s4 "nonadjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s5 = false
 exact searchEmpty sourceSameGraph.edges "nonadjacent-entering-right" s5 (by rfl)
#print axioms reach_0_2
private theorem reach_0_3 : reachable (graph sourceSame) "complete-successor" "nonadjacent-left" = true := by
 change reachable sourceSameGraph "complete-successor" "nonadjacent-left" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "complete-successor"
 change searchLoop sourceSameGraph.edges "nonadjacent-left" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-left" s0 "complete-successor" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "complete-successor" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-left" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-left" s1 "nonadjacent-middle" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-middle" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-left" s2 = true
 exact searchHitsTarget sourceSameGraph.edges "nonadjacent-left" s2 ["nonadjacent-right","nonadjacent-left"] (by rfl)
#print axioms reach_0_3
private theorem reach_0_4 : reachable (graph sourceSame) "complete-successor" "nonadjacent-middle" = true := by
 change reachable sourceSameGraph "complete-successor" "nonadjacent-middle" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "complete-successor"
 change searchLoop sourceSameGraph.edges "nonadjacent-middle" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-middle" s0 "complete-successor" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "complete-successor" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-middle" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "nonadjacent-middle" s1 [] (by rfl)
#print axioms reach_0_4
private theorem reach_0_5 : reachable (graph sourceSame) "complete-successor" "nonadjacent-right" = true := by
 change reachable sourceSameGraph "complete-successor" "nonadjacent-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "complete-successor"
 change searchLoop sourceSameGraph.edges "nonadjacent-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-right" s0 "complete-successor" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "complete-successor" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-right" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-right" s1 "nonadjacent-middle" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-middle" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-right" s2 = true
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-right" s2 "nonadjacent-left" ["nonadjacent-right","nonadjacent-left"] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "nonadjacent-left" ["nonadjacent-right","nonadjacent-left"] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-right" s3 = true
 exact searchHitsTarget sourceSameGraph.edges "nonadjacent-right" s3 ["nonadjacent-left"] (by rfl)
#print axioms reach_0_5
private theorem reach_1_0 : reachable (graph sourceSame) "nonadjacent-entering-left" "complete-successor" = false := by
 change reachable sourceSameGraph "nonadjacent-entering-left" "complete-successor" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "nonadjacent-entering-left"
 change searchLoop sourceSameGraph.edges "complete-successor" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "complete-successor" s0 "nonadjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "nonadjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "complete-successor" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "complete-successor" s1 "nonadjacent-entering-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-entering-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "complete-successor" s2 = false
 exact searchEmpty sourceSameGraph.edges "complete-successor" s2 (by rfl)
#print axioms reach_1_0
private theorem reach_1_1 : reachable (graph sourceSame) "nonadjacent-entering-left" "nonadjacent-entering-left" = true := by
 change reachable sourceSameGraph "nonadjacent-entering-left" "nonadjacent-entering-left" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_1_1
private theorem reach_1_2 : reachable (graph sourceSame) "nonadjacent-entering-left" "nonadjacent-entering-right" = true := by
 change reachable sourceSameGraph "nonadjacent-entering-left" "nonadjacent-entering-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "nonadjacent-entering-left"
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-entering-right" s0 "nonadjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "nonadjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-entering-right" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "nonadjacent-entering-right" s1 [] (by rfl)
#print axioms reach_1_2
private theorem reach_1_3 : reachable (graph sourceSame) "nonadjacent-entering-left" "nonadjacent-left" = false := by
 change reachable sourceSameGraph "nonadjacent-entering-left" "nonadjacent-left" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "nonadjacent-entering-left"
 change searchLoop sourceSameGraph.edges "nonadjacent-left" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-left" s0 "nonadjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "nonadjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-left" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-left" s1 "nonadjacent-entering-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-entering-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-left" s2 = false
 exact searchEmpty sourceSameGraph.edges "nonadjacent-left" s2 (by rfl)
#print axioms reach_1_3
private theorem reach_1_4 : reachable (graph sourceSame) "nonadjacent-entering-left" "nonadjacent-middle" = false := by
 change reachable sourceSameGraph "nonadjacent-entering-left" "nonadjacent-middle" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "nonadjacent-entering-left"
 change searchLoop sourceSameGraph.edges "nonadjacent-middle" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-middle" s0 "nonadjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "nonadjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-middle" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-middle" s1 "nonadjacent-entering-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-entering-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-middle" s2 = false
 exact searchEmpty sourceSameGraph.edges "nonadjacent-middle" s2 (by rfl)
#print axioms reach_1_4
private theorem reach_1_5 : reachable (graph sourceSame) "nonadjacent-entering-left" "nonadjacent-right" = false := by
 change reachable sourceSameGraph "nonadjacent-entering-left" "nonadjacent-right" = false
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "nonadjacent-entering-left"
 change searchLoop sourceSameGraph.edges "nonadjacent-right" s0 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-right" s0 "nonadjacent-entering-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "nonadjacent-entering-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-right" s1 = false
 rw [searchExpandsFresh sourceSameGraph.edges "nonadjacent-right" s1 "nonadjacent-entering-right" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-entering-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "nonadjacent-right" s2 = false
 exact searchEmpty sourceSameGraph.edges "nonadjacent-right" s2 (by rfl)
#print axioms reach_1_5
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "complete-successor" b.label) = [held1,held2,held3,held6] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5,held6] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) = (match reachable (graph sourceSame) "complete-successor" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) | false => ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-left" from rfl,reach_0_3]
 try dsimp only
 rw [show ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) = (match reachable (graph sourceSame) "complete-successor" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) | false => ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-middle" from rfl,reach_0_4]
 try dsimp only
 rw [show ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) = (match reachable (graph sourceSame) "complete-successor" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) | false => ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-right" from rfl,reach_0_5]
 try dsimp only
 rw [show ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) = (match reachable (graph sourceSame) "complete-successor" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) | false => ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-entering-left" from rfl,reach_0_1]
 try dsimp only
 rw [show ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) = (match reachable (graph sourceSame) "complete-successor" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) | false => ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-entering-right" from rfl,reach_0_2]
 try dsimp only
 rw [show ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) = (match reachable (graph sourceSame) "complete-successor" (held6 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held6 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "complete-successor" b.label)) from rfl]
 rw [show (held6 : SFT.Physics.CapabilityValues.HeldLabel).label = "complete-successor" from rfl,reach_0_0]
 try dsimp only
 rfl
#print axioms filterSeed0
private theorem filterSeed1 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) = [held4,held5] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5,held6] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) = (match reachable (graph sourceSame) "nonadjacent-entering-left" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) | false => ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-left" from rfl,reach_1_3]
 try dsimp only
 rw [show ([held2,held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) = (match reachable (graph sourceSame) "nonadjacent-entering-left" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) | false => ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-middle" from rfl,reach_1_4]
 try dsimp only
 rw [show ([held3,held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) = (match reachable (graph sourceSame) "nonadjacent-entering-left" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) | false => ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-right" from rfl,reach_1_5]
 try dsimp only
 rw [show ([held4,held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) = (match reachable (graph sourceSame) "nonadjacent-entering-left" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) | false => ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-entering-left" from rfl,reach_1_1]
 try dsimp only
 rw [show ([held5,held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) = (match reachable (graph sourceSame) "nonadjacent-entering-left" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) | false => ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "nonadjacent-entering-right" from rfl,reach_1_2]
 try dsimp only
 rw [show ([held6]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) = (match reachable (graph sourceSame) "nonadjacent-entering-left" (held6 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held6 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "nonadjacent-entering-left" b.label)) from rfl]
 rw [show (held6 : SFT.Physics.CapabilityValues.HeldLabel).label = "complete-successor" from rfl,reach_1_0]
 try dsimp only
 rfl
#print axioms filterSeed1
theorem sourceSameComponents : connectedComponents sourceSame = [[held6,held1,held2,held3],[held4,held5]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held6,held4,held5,held1,held2,held3] = [[held6,held1,held2,held3],[held4,held5]]
 have step0 : step [] held6 = [[held6,held1,held2,held3]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "complete-successor" b.label)] = [[held6,held1,held2,held3]]
  rw [filterSeed0]
  rfl
 rw [List.foldl_cons,step0]
 have step1 : step [[held6,held1,held2,held3]] held4 = [[held6,held1,held2,held3],[held4,held5]] := by
  change [[held6,held1,held2,held3]] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "nonadjacent-entering-left" b.label)] = [[held6,held1,held2,held3],[held4,held5]]
  rw [filterSeed1]
  rfl
 rw [List.foldl_cons,step1]
 have step2 : step [[held6,held1,held2,held3],[held4,held5]] held5 = [[held6,held1,held2,held3],[held4,held5]] := by
  rfl
 rw [List.foldl_cons,step2]
 have step3 : step [[held6,held1,held2,held3],[held4,held5]] held1 = [[held6,held1,held2,held3],[held4,held5]] := by
  rfl
 rw [List.foldl_cons,step3]
 have step4 : step [[held6,held1,held2,held3],[held4,held5]] held2 = [[held6,held1,held2,held3],[held4,held5]] := by
  rfl
 rw [List.foldl_cons,step4]
 have step5 : step [[held6,held1,held2,held3],[held4,held5]] held3 = [[held6,held1,held2,held3],[held4,held5]] := by
  rfl
 rw [List.foldl_cons,step5]
 rfl
#print axioms sourceSameComponents
theorem sourceOrderedComponents : AdditionTransform.sourceComponents sourceSame = [[held6,held1,held2,held3],[held4,held5]] := by
 unfold AdditionTransform.sourceComponents
 rw [sourceSameComponents]
 rfl
#print axioms sourceOrderedComponents
theorem distance0 : shortestDistance sourceSame held1 held3 = .ok (.count ⟨2,by decide⟩) := by
 have search : distanceLoop sourceSameGraph.edges "nonadjacent-right" (initialSearch sourceSameGraph.edges "nonadjacent-left") [0] = some 2 := by
  let s0 := initialSearch sourceSameGraph.edges "nonadjacent-left"
  change distanceLoop sourceSameGraph.edges "nonadjacent-right" s0 [0] = some 2
  rw [distanceLoopEquation]
  let s1 := expandState sourceSameGraph.edges s0 "nonadjacent-left" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "nonadjacent-right" s1 [1,1] = some 2
  rw [distanceLoopEquation]
  let s2 := expandState sourceSameGraph.edges s1 "nonadjacent-middle" ["nonadjacent-middle"] (by rfl)
  change distanceLoop sourceSameGraph.edges "nonadjacent-right" s2 [1,2,2] = some 2
  rw [distanceLoopEquation]
  let s3 := skipState sourceSameGraph.edges s2 "nonadjacent-middle" ["nonadjacent-right","complete-successor"] (by rfl)
  change distanceLoop sourceSameGraph.edges "nonadjacent-right" s3 [2,2] = some 2
  rw [distanceLoopEquation]
  rfl
 unfold shortestDistance
 rw [ite_eq_right (by decide)]
 change (match distanceLoop sourceSameGraph.edges "nonadjacent-right" (initialSearch sourceSameGraph.edges "nonadjacent-left") [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok (.count ⟨2,by decide⟩)
 rw [search]
 rfl
#print axioms distance0
theorem distance1 : shortestDistance sourceSame held4 held5 = .ok (.count ⟨1,by decide⟩) := by
 have search : distanceLoop sourceSameGraph.edges "nonadjacent-entering-right" (initialSearch sourceSameGraph.edges "nonadjacent-entering-left") [0] = some 1 := by
  let s0 := initialSearch sourceSameGraph.edges "nonadjacent-entering-left"
  change distanceLoop sourceSameGraph.edges "nonadjacent-entering-right" s0 [0] = some 1
  rw [distanceLoopEquation]
  let s1 := expandState sourceSameGraph.edges s0 "nonadjacent-entering-left" [] (by rfl)
  change distanceLoop sourceSameGraph.edges "nonadjacent-entering-right" s1 [1] = some 1
  rw [distanceLoopEquation]
  rfl
 unfold shortestDistance
 rw [ite_eq_right (by decide)]
 change (match distanceLoop sourceSameGraph.edges "nonadjacent-entering-right" (initialSearch sourceSameGraph.edges "nonadjacent-entering-left") [0] with | none => Except.error "addition sites must belong to one retained source carrier" | some n => do return Separation.count (← SFT.Physics.CapabilityValues.count n)) = .ok (.count ⟨1,by decide⟩)
 rw [search]
 rfl
#print axioms distance1
end SFT.Chemistry.AdditionWitnessGraphs.SuccessorSource
