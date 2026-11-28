import SFT.Applications.FoldChess.Search
open SFT.Applications.FoldChess
#print axioms storeTT
#print axioms searchValueBounded
#print axioms searchValue
def nz (a : Board) : String :=
 String.intercalate "," ((List.range a.size).filterMap (fun i => if a.getD i 0 = 0 then none else some s!"{i}:{a.getD i 0}"))
def emit (tag : String) (state : Board) : IO Unit := do
 for depth in ([0,1,2,3] : List Int) do
  for budget in ([0,16,256] : List Int) do
   for tt in ([0,1] : List Int) do
    let ctx : SearchContext := if tt = 1 then {ttEnsure {} with nodesLeft := budget, ttGen := 1} else {nodesLeft := budget}
    let (value,ctx) := searchValue state depth 0 1 1 1 ctx
    IO.println s!"{tag} search {depth} {budget} {tt} {value} {ctx.nodesLeft} {ctx.passAborted}"
    IO.println (nz ctx.ttKeys ++ "|" ++ nz ctx.ttMoves ++ "|" ++ nz ctx.ttStamp ++ "|" ++ String.intercalate "," (ctx.killerA.toList.map toString) ++ "|" ++ String.intercalate "," (ctx.killerB.toList.map toString))
def main : IO Unit := do
 emit "fixture 0" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 1" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 2" #[4,2,3,5,6,3,2,4,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,7,7,7,7,7,7,10,8,9,11,12,9,8,10,0,1,1,1,1,64,0]
 emit "fixture 3" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 4" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 5" #[4,0,0,0,6,0,0,4,1,1,1,3,3,1,1,1,0,0,2,0,0,5,0,7,0,7,0,0,1,0,0,0,0,0,0,1,2,0,0,0,9,8,0,0,7,8,7,0,7,0,7,7,11,7,9,0,10,0,0,0,12,0,0,10,0,1,1,1,1,64,0]
 emit "fixture 6" #[0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,4,0,0,0,7,0,12,6,1,0,0,0,0,0,10,0,0,0,7,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0]
 emit "fixture 7" #[0,0,0,0,0,2,0,2,0,0,0,0,6,7,7,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,12,0,0,0,0,8,0,8,0,0,0,0,0,1,0,0,0,0,64,0]
 let mut state := startingState
 for step in List.range 6 do
  emit s!"walk {step}" state
  let moves := legalMoves state
  if moves.size > 0 then state := makeMove state (moves.getD ((step*17+3)%moves.size) 0)
 emit "clock" (writeSquare startingState 70 100)
