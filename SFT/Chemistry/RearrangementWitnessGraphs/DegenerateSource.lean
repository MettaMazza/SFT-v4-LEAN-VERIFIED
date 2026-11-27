import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "deg-source" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","deg-source",held0Family,held0Label⟩
private theorem held0Name : held0.label = "deg-source" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "deg-a" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","deg-a",held1Family,held1Label⟩
private theorem held1Name : held1.label = "deg-a" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "deg-b" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","deg-b",held2Family,held2Label⟩
private theorem held2Name : held2.label = "deg-b" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "deg-c" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","deg-c",held3Family,held3Label⟩
private theorem held3Name : held3.label = "deg-c" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "deg-first" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","deg-first",held4Family,held4Label⟩
private theorem held4Name : held4.label = "deg-first" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "deg-second" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","deg-second",held5Family,held5Label⟩
private theorem held5Name : held5.label = "deg-second" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "deg-third" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","deg-third",held6Family,held6Label⟩
private theorem held6Name : held6.label = "deg-third" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3],[⟨held1,held2,held4⟩,⟨held2,held3,held5⟩,⟨held1,held3,held6⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["deg-a","deg-b","deg-c"],[("deg-a","deg-b"),("deg-b","deg-a"),("deg-b","deg-c"),("deg-c","deg-b"),("deg-a","deg-c"),("deg-c","deg-a")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "deg-a" "deg-a" = true := by
 change reachable sourceSameGraph "deg-a" "deg-a" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "deg-a" "deg-b" = true := by
 change reachable sourceSameGraph "deg-a" "deg-b" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "deg-a"
 change searchLoop sourceSameGraph.edges "deg-b" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "deg-b" s0 "deg-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "deg-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "deg-b" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "deg-b" s1 ["deg-c"] (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "deg-a" "deg-c" = true := by
 change reachable sourceSameGraph "deg-a" "deg-c" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "deg-a"
 change searchLoop sourceSameGraph.edges "deg-c" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "deg-c" s0 "deg-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "deg-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "deg-c" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "deg-c" s1 "deg-b" ["deg-c"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "deg-b" ["deg-c"] (by rfl)
 change searchLoop sourceSameGraph.edges "deg-c" s2 = true
 exact searchHitsTarget sourceSameGraph.edges "deg-c" s2 ["deg-c"] (by rfl)
#print axioms reach_0_2
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "deg-a" b.label) = [held1,held2,held3] := by
 have atoms : sourceSame.atoms = [held1,held2,held3] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label) = (match reachable (graph sourceSame) "deg-a" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label) | false => ([held2,held3]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "deg-a" from rfl,reach_0_0]
 try dsimp only
 rw [show ([held2,held3]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label) = (match reachable (graph sourceSame) "deg-a" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label) | false => ([held3]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "deg-b" from rfl,reach_0_1]
 try dsimp only
 rw [show ([held3]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label) = (match reachable (graph sourceSame) "deg-a" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "deg-a" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "deg-c" from rfl,reach_0_2]
 try dsimp only
 rfl
#print axioms filterSeed0
theorem sourceSameComponents : connectedComponents sourceSame = [[held1,held2,held3]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held1,held2,held3] = [[held1,held2,held3]]
 have step0 : step [] held1 = [[held1,held2,held3]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "deg-a" b.label)] = [[held1,held2,held3]]
  rw [filterSeed0]
  rfl
 rw [List.foldl_cons,step0]
 have step1 : step [[held1,held2,held3]] held2 = [[held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step1]
 have step2 : step [[held1,held2,held3]] held3 = [[held1,held2,held3]] := by
  rfl
 rw [List.foldl_cons,step2]
 rfl
#print axioms sourceSameComponents
theorem sourceOrderedComponents : AdditionTransform.sourceComponents sourceSame = [[held1,held2,held3]] := by
 unfold AdditionTransform.sourceComponents
 rw [sourceSameComponents]
 rfl
#print axioms sourceOrderedComponents
end SFT.Chemistry.RearrangementWitnessGraphs.DegenerateSource
