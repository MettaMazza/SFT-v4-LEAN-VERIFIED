import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.EliminationWitnessGraphs.NonadjacentTerminal
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-source" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","elim-nonadjacent-source",held0Family,held0Label⟩
private theorem held0Name : held0.label = "elim-nonadjacent-source" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-left" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-left",held1Family,held1Label⟩
private theorem held1Name : held1.label = "elim-nonadjacent-left" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-middle" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-middle",held2Family,held2Label⟩
private theorem held2Name : held2.label = "elim-nonadjacent-middle" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-right" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-right",held3Family,held3Label⟩
private theorem held3Name : held3.label = "elim-nonadjacent-right" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-enter-left" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-enter-left",held4Family,held4Label⟩
private theorem held4Name : held4.label = "elim-nonadjacent-enter-left" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-enter-right" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","elim-nonadjacent-enter-right",held5Family,held5Label⟩
private theorem held5Name : held5.label = "elim-nonadjacent-enter-right" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-base-left" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-nonadjacent-base-left",held6Family,held6Label⟩
private theorem held6Name : held6.label = "elim-nonadjacent-base-left" := rfl
private theorem held7Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held7Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-base-right" = true := rfl
private def held7 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-nonadjacent-base-right",held7Family,held7Label⟩
private theorem held7Name : held7.label = "elim-nonadjacent-base-right" := rfl
private theorem held8Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held8Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-layer-1" = true := rfl
private def held8 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-nonadjacent-layer-1",held8Family,held8Label⟩
private theorem held8Name : held8.label = "elim-nonadjacent-layer-1" := rfl
private theorem held9Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held9Label : SFT.Physics.CapabilityValues.nonblank "elim-nonadjacent-entering" = true := rfl
private def held9 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","elim-nonadjacent-entering",held9Family,held9Label⟩
private theorem held9Name : held9.label = "elim-nonadjacent-entering" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3,held4,held5],[⟨held1,held2,held6⟩,⟨held2,held3,held7⟩,⟨held1,held4,held8⟩,⟨held3,held5,held9⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["elim-nonadjacent-left","elim-nonadjacent-middle","elim-nonadjacent-right","elim-nonadjacent-enter-left","elim-nonadjacent-enter-right"],[("elim-nonadjacent-left","elim-nonadjacent-middle"),("elim-nonadjacent-middle","elim-nonadjacent-left"),("elim-nonadjacent-middle","elim-nonadjacent-right"),("elim-nonadjacent-right","elim-nonadjacent-middle"),("elim-nonadjacent-left","elim-nonadjacent-enter-left"),("elim-nonadjacent-enter-left","elim-nonadjacent-left"),("elim-nonadjacent-right","elim-nonadjacent-enter-right"),("elim-nonadjacent-enter-right","elim-nonadjacent-right")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "elim-nonadjacent-enter-left" "elim-nonadjacent-enter-left" = true := by
 change reachable sourceSameGraph "elim-nonadjacent-enter-left" "elim-nonadjacent-enter-left" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "elim-nonadjacent-enter-left" "elim-nonadjacent-enter-right" = true := by
 change reachable sourceSameGraph "elim-nonadjacent-enter-left" "elim-nonadjacent-enter-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-nonadjacent-enter-left"
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-enter-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-enter-right" s0 "elim-nonadjacent-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-nonadjacent-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-enter-right" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-enter-right" s1 "elim-nonadjacent-left" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-nonadjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-enter-right" s2 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-enter-right" s2 "elim-nonadjacent-middle" [] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "elim-nonadjacent-middle" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-enter-right" s3 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-enter-right" s3 "elim-nonadjacent-right" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "elim-nonadjacent-right" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-enter-right" s4 = true
 exact searchHitsTarget sourceSameGraph.edges "elim-nonadjacent-enter-right" s4 [] (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "elim-nonadjacent-enter-left" "elim-nonadjacent-left" = true := by
 change reachable sourceSameGraph "elim-nonadjacent-enter-left" "elim-nonadjacent-left" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-nonadjacent-enter-left"
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-left" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-left" s0 "elim-nonadjacent-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-nonadjacent-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-left" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "elim-nonadjacent-left" s1 [] (by rfl)
#print axioms reach_0_2
private theorem reach_0_3 : reachable (graph sourceSame) "elim-nonadjacent-enter-left" "elim-nonadjacent-middle" = true := by
 change reachable sourceSameGraph "elim-nonadjacent-enter-left" "elim-nonadjacent-middle" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-nonadjacent-enter-left"
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-middle" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-middle" s0 "elim-nonadjacent-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-nonadjacent-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-middle" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-middle" s1 "elim-nonadjacent-left" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-nonadjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-middle" s2 = true
 exact searchHitsTarget sourceSameGraph.edges "elim-nonadjacent-middle" s2 [] (by rfl)
#print axioms reach_0_3
private theorem reach_0_4 : reachable (graph sourceSame) "elim-nonadjacent-enter-left" "elim-nonadjacent-right" = true := by
 change reachable sourceSameGraph "elim-nonadjacent-enter-left" "elim-nonadjacent-right" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "elim-nonadjacent-enter-left"
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-right" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-right" s0 "elim-nonadjacent-enter-left" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "elim-nonadjacent-enter-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-right" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-right" s1 "elim-nonadjacent-left" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "elim-nonadjacent-left" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-right" s2 = true
 rw [searchExpandsFresh sourceSameGraph.edges "elim-nonadjacent-right" s2 "elim-nonadjacent-middle" [] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "elim-nonadjacent-middle" [] (by rfl)
 change searchLoop sourceSameGraph.edges "elim-nonadjacent-right" s3 = true
 exact searchHitsTarget sourceSameGraph.edges "elim-nonadjacent-right" s3 [] (by rfl)
#print axioms reach_0_4
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) = [held1,held2,held3,held4,held5] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) = (match reachable (graph sourceSame) "elim-nonadjacent-enter-left" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) | false => ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-nonadjacent-left" from rfl,reach_0_2]
 try dsimp only
 rw [show ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) = (match reachable (graph sourceSame) "elim-nonadjacent-enter-left" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) | false => ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-nonadjacent-middle" from rfl,reach_0_3]
 try dsimp only
 rw [show ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) = (match reachable (graph sourceSame) "elim-nonadjacent-enter-left" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) | false => ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-nonadjacent-right" from rfl,reach_0_4]
 try dsimp only
 rw [show ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) = (match reachable (graph sourceSame) "elim-nonadjacent-enter-left" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) | false => ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-nonadjacent-enter-left" from rfl,reach_0_0]
 try dsimp only
 rw [show ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) = (match reachable (graph sourceSame) "elim-nonadjacent-enter-left" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "elim-nonadjacent-enter-right" from rfl,reach_0_1]
 try dsimp only
 rfl
#print axioms filterSeed0
theorem sourceSameComponents : connectedComponents sourceSame = [[held4,held5,held1,held2,held3]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held4,held5,held1,held2,held3] = [[held4,held5,held1,held2,held3]]
 have step0 : step [] held4 = [[held4,held5,held1,held2,held3]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "elim-nonadjacent-enter-left" b.label)] = [[held4,held5,held1,held2,held3]]
  rw [filterSeed0]
  rfl
 rw [List.foldl_cons,step0]
 have step1 : step [[held4,held5,held1,held2,held3]] held5 = [[held4,held5,held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step1]
 have step2 : step [[held4,held5,held1,held2,held3]] held1 = [[held4,held5,held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step2]
 have step3 : step [[held4,held5,held1,held2,held3]] held2 = [[held4,held5,held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step3]
 have step4 : step [[held4,held5,held1,held2,held3]] held3 = [[held4,held5,held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step4]
 rfl
#print axioms sourceSameComponents
theorem sourceOrderedComponents : AdditionTransform.sourceComponents sourceSame = [[held4,held5,held1,held2,held3]] := by
 unfold AdditionTransform.sourceComponents
 rw [sourceSameComponents]
 rfl
#print axioms sourceOrderedComponents
end SFT.Chemistry.EliminationWitnessGraphs.NonadjacentTerminal
