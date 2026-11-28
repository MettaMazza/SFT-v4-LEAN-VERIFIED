import SFT.Applications.FoldGo.Evaluation
import SFT.Applications.FoldGo.IndexSet
namespace SFT.Applications.FoldGo

def dynamicSparseMoves (board : GoBoard) (color : Nat) (legal : List Nat) (tacticalOnly : Bool := false) : List Nat :=
 let size := board.size
 let symmetries := boardSymmetries board.cells size
 let reduce := fun moves => indexValues (moves.foldl (fun reps p => indexAdd reps (orbitRepresentative p size symmetries)) ({} : IndexSet))
 if board.cells.toList.all (fun x => decide (x = 0)) then
  let stars := if size = 9 then [20,22,24,38,40,42,56,58,60]
   else if size = 19 then [60,66,72,174,180,186,288,294,300]
   else [size*size/2]
  let valid := stars.filter legal.contains
  if valid.isEmpty then reduce legal else reduce valid
 else
  let (_,fronts,tactical,shape) := (List.range (size*size)).foldl (fun (visited,fronts,tactical,shape) i =>
   if board.cells.getD i 0 ≠ 0 ∧ !(visited.contains i) then
    let (group,libs) := getGroup board i
    let visited := group.foldl insertSquare visited
    let libOrder := indexValues (indexFromList libs)
    let fronts := libOrder.foldl indexAdd fronts
    let shape := if board.cells.getD i 0 = color then libOrder.foldl indexAdd shape else shape
    let tactical := if libs.length ≤ 2 then libOrder.foldl indexAdd tactical else tactical
    (visited,fronts,tactical,shape)
   else (visited,fronts,tactical,shape)) (([],{},{},{}) : List Nat×IndexSet×IndexSet×IndexSet)
  let fs := indexValues fronts
  let ts := indexValues tactical
  let ss := indexValues shape
  let candidates := legal.foldl (fun candidates move =>
   bif ts.contains move || (!tacticalOnly && fs.contains move) || (!tacticalOnly && ss.contains move)
   then indexAdd candidates move else candidates) ({} : IndexSet)
  if candidates.used = 0 then
   bif tacticalOnly then [] else reduce (indexValues (indexFromList legal))
  else reduce (indexValues candidates)
end SFT.Applications.FoldGo
