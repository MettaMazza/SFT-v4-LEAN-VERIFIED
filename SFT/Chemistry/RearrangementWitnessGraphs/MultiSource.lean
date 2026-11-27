import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.RearrangementWitnessGraphs.MultiSource
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "multi-source" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","multi-source",held0Family,held0Label⟩
private theorem held0Name : held0.label = "multi-source" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "multi-a" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","multi-a",held1Family,held1Label⟩
private theorem held1Name : held1.label = "multi-a" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "multi-b" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","multi-b",held2Family,held2Label⟩
private theorem held2Name : held2.label = "multi-b" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "multi-c" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","multi-c",held3Family,held3Label⟩
private theorem held3Name : held3.label = "multi-c" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "multi-d" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","multi-d",held4Family,held4Label⟩
private theorem held4Name : held4.label = "multi-d" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "multi-e" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","multi-e",held5Family,held5Label⟩
private theorem held5Name : held5.label = "multi-e" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "multi-base" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","multi-base",held6Family,held6Label⟩
private theorem held6Name : held6.label = "multi-base" := rfl
private theorem held7Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held7Label : SFT.Physics.CapabilityValues.nonblank "multi-first" = true := rfl
private def held7 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","multi-first",held7Family,held7Label⟩
private theorem held7Name : held7.label = "multi-first" := rfl
private theorem held8Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held8Label : SFT.Physics.CapabilityValues.nonblank "multi-second" = true := rfl
private def held8 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","multi-second",held8Family,held8Label⟩
private theorem held8Name : held8.label = "multi-second" := rfl
private theorem held9Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held9Label : SFT.Physics.CapabilityValues.nonblank "multi-third" = true := rfl
private def held9 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","multi-third",held9Family,held9Label⟩
private theorem held9Name : held9.label = "multi-third" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3,held4,held5],[⟨held1,held2,held6⟩,⟨held2,held3,held7⟩,⟨held3,held4,held8⟩,⟨held4,held5,held9⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["multi-a","multi-b","multi-c","multi-d","multi-e"],[("multi-a","multi-b"),("multi-b","multi-a"),("multi-b","multi-c"),("multi-c","multi-b"),("multi-c","multi-d"),("multi-d","multi-c"),("multi-d","multi-e"),("multi-e","multi-d")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "multi-a" "multi-a" = true := by
 change reachable sourceSameGraph "multi-a" "multi-a" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "multi-a" "multi-b" = true := by
 change reachable sourceSameGraph "multi-a" "multi-b" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "multi-a"
 change searchLoop sourceSameGraph.edges "multi-b" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-b" s0 "multi-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "multi-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-b" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "multi-b" s1 [] (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "multi-a" "multi-c" = true := by
 change reachable sourceSameGraph "multi-a" "multi-c" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "multi-a"
 change searchLoop sourceSameGraph.edges "multi-c" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-c" s0 "multi-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "multi-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-c" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-c" s1 "multi-b" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "multi-b" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-c" s2 = true
 exact searchHitsTarget sourceSameGraph.edges "multi-c" s2 [] (by rfl)
#print axioms reach_0_2
private theorem reach_0_3 : reachable (graph sourceSame) "multi-a" "multi-d" = true := by
 change reachable sourceSameGraph "multi-a" "multi-d" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "multi-a"
 change searchLoop sourceSameGraph.edges "multi-d" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-d" s0 "multi-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "multi-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-d" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-d" s1 "multi-b" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "multi-b" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-d" s2 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-d" s2 "multi-c" [] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "multi-c" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-d" s3 = true
 exact searchHitsTarget sourceSameGraph.edges "multi-d" s3 [] (by rfl)
#print axioms reach_0_3
private theorem reach_0_4 : reachable (graph sourceSame) "multi-a" "multi-e" = true := by
 change reachable sourceSameGraph "multi-a" "multi-e" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "multi-a"
 change searchLoop sourceSameGraph.edges "multi-e" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-e" s0 "multi-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "multi-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-e" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-e" s1 "multi-b" [] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "multi-b" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-e" s2 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-e" s2 "multi-c" [] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "multi-c" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-e" s3 = true
 rw [searchExpandsFresh sourceSameGraph.edges "multi-e" s3 "multi-d" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "multi-d" [] (by rfl)
 change searchLoop sourceSameGraph.edges "multi-e" s4 = true
 exact searchHitsTarget sourceSameGraph.edges "multi-e" s4 [] (by rfl)
#print axioms reach_0_4
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "multi-a" b.label) = [held1,held2,held3,held4,held5] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) = (match reachable (graph sourceSame) "multi-a" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) | false => ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "multi-a" from rfl,reach_0_0]
 try dsimp only
 rw [show ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) = (match reachable (graph sourceSame) "multi-a" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) | false => ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "multi-b" from rfl,reach_0_1]
 try dsimp only
 rw [show ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) = (match reachable (graph sourceSame) "multi-a" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) | false => ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "multi-c" from rfl,reach_0_2]
 try dsimp only
 rw [show ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) = (match reachable (graph sourceSame) "multi-a" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) | false => ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "multi-d" from rfl,reach_0_3]
 try dsimp only
 rw [show ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) = (match reachable (graph sourceSame) "multi-a" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "multi-a" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "multi-e" from rfl,reach_0_4]
 try dsimp only
 rfl
#print axioms filterSeed0
theorem sourceSameComponents : connectedComponents sourceSame = [[held1,held2,held3,held4,held5]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held1,held2,held3,held4,held5] = [[held1,held2,held3,held4,held5]]
 have step0 : step [] held1 = [[held1,held2,held3,held4,held5]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "multi-a" b.label)] = [[held1,held2,held3,held4,held5]]
  rw [filterSeed0]
  rfl
 rw [List.foldl_cons,step0]
 have step1 : step [[held1,held2,held3,held4,held5]] held2 = [[held1,held2,held3,held4,held5]] := by
  rfl
 rw [List.foldl_cons,step1]
 have step2 : step [[held1,held2,held3,held4,held5]] held3 = [[held1,held2,held3,held4,held5]] := by
  rfl
 rw [List.foldl_cons,step2]
 have step3 : step [[held1,held2,held3,held4,held5]] held4 = [[held1,held2,held3,held4,held5]] := by
  rfl
 rw [List.foldl_cons,step3]
 have step4 : step [[held1,held2,held3,held4,held5]] held5 = [[held1,held2,held3,held4,held5]] := by
  rfl
 rw [List.foldl_cons,step4]
 rfl
#print axioms sourceSameComponents
theorem sourceOrderedComponents : AdditionTransform.sourceComponents sourceSame = [[held1,held2,held3,held4,held5]] := by
 unfold AdditionTransform.sourceComponents
 rw [sourceSameComponents]
 rfl
#print axioms sourceOrderedComponents
end SFT.Chemistry.RearrangementWitnessGraphs.MultiSource
