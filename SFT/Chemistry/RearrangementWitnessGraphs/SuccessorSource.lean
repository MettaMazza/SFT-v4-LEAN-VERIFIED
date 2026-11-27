import SFT.Chemistry.AdditionWitnesses
namespace SFT.Chemistry.RearrangementWitnessGraphs.SuccessorSource
open SFT.Chemistry AdditionCarrier AdditionGraph
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem held0Family : SFT.Physics.CapabilityValues.nonblank "addition-state" = true := rfl
private theorem held0Label : SFT.Physics.CapabilityValues.nonblank "rearr-source-successor" = true := rfl
private def held0 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-state","rearr-source-successor",held0Family,held0Label⟩
private theorem held0Name : held0.label = "rearr-source-successor" := rfl
private theorem held1Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held1Label : SFT.Physics.CapabilityValues.nonblank "rearr-a" = true := rfl
private def held1 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","rearr-a",held1Family,held1Label⟩
private theorem held1Name : held1.label = "rearr-a" := rfl
private theorem held2Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held2Label : SFT.Physics.CapabilityValues.nonblank "rearr-b" = true := rfl
private def held2 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","rearr-b",held2Family,held2Label⟩
private theorem held2Name : held2.label = "rearr-b" := rfl
private theorem held3Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held3Label : SFT.Physics.CapabilityValues.nonblank "rearr-c" = true := rfl
private def held3 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","rearr-c",held3Family,held3Label⟩
private theorem held3Name : held3.label = "rearr-c" := rfl
private theorem held4Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held4Label : SFT.Physics.CapabilityValues.nonblank "rearr-d" = true := rfl
private def held4 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","rearr-d",held4Family,held4Label⟩
private theorem held4Name : held4.label = "rearr-d" := rfl
private theorem held5Family : SFT.Physics.CapabilityValues.nonblank "addition-atom-occurrence" = true := rfl
private theorem held5Label : SFT.Physics.CapabilityValues.nonblank "rearr-successor-atom" = true := rfl
private def held5 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-atom-occurrence","rearr-successor-atom",held5Family,held5Label⟩
private theorem held5Name : held5.label = "rearr-successor-atom" := rfl
private theorem held6Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held6Label : SFT.Physics.CapabilityValues.nonblank "rearr-ab" = true := rfl
private def held6 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","rearr-ab",held6Family,held6Label⟩
private theorem held6Name : held6.label = "rearr-ab" := rfl
private theorem held7Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held7Label : SFT.Physics.CapabilityValues.nonblank "rearr-moving" = true := rfl
private def held7 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","rearr-moving",held7Family,held7Label⟩
private theorem held7Name : held7.label = "rearr-moving" := rfl
private theorem held8Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held8Label : SFT.Physics.CapabilityValues.nonblank "rearr-cd" = true := rfl
private def held8 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","rearr-cd",held8Family,held8Label⟩
private theorem held8Name : held8.label = "rearr-cd" := rfl
private theorem held9Family : SFT.Physics.CapabilityValues.nonblank "addition-held-support" = true := rfl
private theorem held9Label : SFT.Physics.CapabilityValues.nonblank "rearr-successor-support" = true := rfl
private def held9 : SFT.Physics.CapabilityValues.HeldLabel := ⟨"addition-held-support","rearr-successor-support",held9Family,held9Label⟩
private theorem held9Name : held9.label = "rearr-successor-support" := rfl
def sourceSame : State := ⟨held0,[held1,held2,held3,held4,held5],[⟨held1,held2,held6⟩,⟨held2,held3,held7⟩,⟨held3,held4,held8⟩,⟨held1,held5,held9⟩],[]⟩
def sourceSameGraph : GeneratedGraph := ⟨["rearr-a","rearr-b","rearr-c","rearr-d","rearr-successor-atom"],[("rearr-a","rearr-b"),("rearr-b","rearr-a"),("rearr-b","rearr-c"),("rearr-c","rearr-b"),("rearr-c","rearr-d"),("rearr-d","rearr-c"),("rearr-a","rearr-successor-atom"),("rearr-successor-atom","rearr-a")]⟩
private theorem reach_0_0 : reachable (graph sourceSame) "rearr-a" "rearr-a" = true := by
 change reachable sourceSameGraph "rearr-a" "rearr-a" = true
 unfold reachable
 rw [ite_eq_left rfl]
 rfl
#print axioms reach_0_0
private theorem reach_0_1 : reachable (graph sourceSame) "rearr-a" "rearr-b" = true := by
 change reachable sourceSameGraph "rearr-a" "rearr-b" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "rearr-a"
 change searchLoop sourceSameGraph.edges "rearr-b" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-b" s0 "rearr-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "rearr-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-b" s1 = true
 exact searchHitsTarget sourceSameGraph.edges "rearr-b" s1 ["rearr-successor-atom"] (by rfl)
#print axioms reach_0_1
private theorem reach_0_2 : reachable (graph sourceSame) "rearr-a" "rearr-c" = true := by
 change reachable sourceSameGraph "rearr-a" "rearr-c" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "rearr-a"
 change searchLoop sourceSameGraph.edges "rearr-c" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-c" s0 "rearr-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "rearr-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-c" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-c" s1 "rearr-b" ["rearr-successor-atom"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "rearr-b" ["rearr-successor-atom"] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-c" s2 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-c" s2 "rearr-successor-atom" ["rearr-c"] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "rearr-successor-atom" ["rearr-c"] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-c" s3 = true
 exact searchHitsTarget sourceSameGraph.edges "rearr-c" s3 [] (by rfl)
#print axioms reach_0_2
private theorem reach_0_3 : reachable (graph sourceSame) "rearr-a" "rearr-d" = true := by
 change reachable sourceSameGraph "rearr-a" "rearr-d" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "rearr-a"
 change searchLoop sourceSameGraph.edges "rearr-d" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-d" s0 "rearr-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "rearr-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-d" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-d" s1 "rearr-b" ["rearr-successor-atom"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "rearr-b" ["rearr-successor-atom"] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-d" s2 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-d" s2 "rearr-successor-atom" ["rearr-c"] (by rfl) (by decide) (by decide)]
 let s3 := expandState sourceSameGraph.edges s2 "rearr-successor-atom" ["rearr-c"] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-d" s3 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-d" s3 "rearr-c" [] (by rfl) (by decide) (by decide)]
 let s4 := expandState sourceSameGraph.edges s3 "rearr-c" [] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-d" s4 = true
 exact searchHitsTarget sourceSameGraph.edges "rearr-d" s4 [] (by rfl)
#print axioms reach_0_3
private theorem reach_0_4 : reachable (graph sourceSame) "rearr-a" "rearr-successor-atom" = true := by
 change reachable sourceSameGraph "rearr-a" "rearr-successor-atom" = true
 unfold reachable
 rw [ite_eq_right (by decide)]
 let s0 := initialSearch sourceSameGraph.edges "rearr-a"
 change searchLoop sourceSameGraph.edges "rearr-successor-atom" s0 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-successor-atom" s0 "rearr-a" [] (by rfl) (by decide) (by decide)]
 let s1 := expandState sourceSameGraph.edges s0 "rearr-a" [] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-successor-atom" s1 = true
 rw [searchExpandsFresh sourceSameGraph.edges "rearr-successor-atom" s1 "rearr-b" ["rearr-successor-atom"] (by rfl) (by decide) (by decide)]
 let s2 := expandState sourceSameGraph.edges s1 "rearr-b" ["rearr-successor-atom"] (by rfl)
 change searchLoop sourceSameGraph.edges "rearr-successor-atom" s2 = true
 exact searchHitsTarget sourceSameGraph.edges "rearr-successor-atom" s2 ["rearr-c"] (by rfl)
#print axioms reach_0_4
private theorem filterSeed0 : (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "rearr-a" b.label) = [held1,held2,held3,held4,held5] := by
 have atoms : sourceSame.atoms = [held1,held2,held3,held4,held5] := rfl
 rw [atoms]
 rw [show ([held1,held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) = (match reachable (graph sourceSame) "rearr-a" (held1 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held1 :: ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) | false => ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label)) from rfl]
 rw [show (held1 : SFT.Physics.CapabilityValues.HeldLabel).label = "rearr-a" from rfl,reach_0_0]
 try dsimp only
 rw [show ([held2,held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) = (match reachable (graph sourceSame) "rearr-a" (held2 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held2 :: ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) | false => ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label)) from rfl]
 rw [show (held2 : SFT.Physics.CapabilityValues.HeldLabel).label = "rearr-b" from rfl,reach_0_1]
 try dsimp only
 rw [show ([held3,held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) = (match reachable (graph sourceSame) "rearr-a" (held3 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held3 :: ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) | false => ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label)) from rfl]
 rw [show (held3 : SFT.Physics.CapabilityValues.HeldLabel).label = "rearr-c" from rfl,reach_0_2]
 try dsimp only
 rw [show ([held4,held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) = (match reachable (graph sourceSame) "rearr-a" (held4 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held4 :: ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) | false => ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label)) from rfl]
 rw [show (held4 : SFT.Physics.CapabilityValues.HeldLabel).label = "rearr-d" from rfl,reach_0_3]
 try dsimp only
 rw [show ([held5]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) = (match reachable (graph sourceSame) "rearr-a" (held5 : SFT.Physics.CapabilityValues.HeldLabel).label with | true => held5 :: ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label) | false => ([]).filter (fun (b : SFT.Physics.CapabilityValues.HeldLabel) => reachable (graph sourceSame) "rearr-a" b.label)) from rfl]
 rw [show (held5 : SFT.Physics.CapabilityValues.HeldLabel).label = "rearr-successor-atom" from rfl,reach_0_4]
 try dsimp only
 rfl
#print axioms filterSeed0
theorem sourceSameComponents : connectedComponents sourceSame = [[held1,held2,held3,held4,held5]] := by
 let step := fun (cs : List (List SFT.Physics.CapabilityValues.HeldLabel)) (a : SFT.Physics.CapabilityValues.HeldLabel) => if cs.any (fun c => NucleophilicCarrier.contains c a) then cs else cs ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) a.label b.label)]
 change List.foldl step [] [held1,held2,held3,held4,held5] = [[held1,held2,held3,held4,held5]]
 have step0 : step [] held1 = [[held1,held2,held3,held4,held5]] := by
  change [] ++ [sortLabels (sourceSame.atoms.filter fun b => reachable (graph sourceSame) "rearr-a" b.label)] = [[held1,held2,held3,held4,held5]]
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
end SFT.Chemistry.RearrangementWitnessGraphs.SuccessorSource
