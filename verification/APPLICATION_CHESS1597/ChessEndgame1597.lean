import SFT.Applications.FoldChess.Endgame
open SFT.Applications.FoldChess
#print axioms parsePackedToken
#print axioms parsePackedChars
#print axioms parsePackedTable
#print axioms loadPackedTable
#print axioms endgameProbe
#print axioms endgameBestMove
def line (tag : String) (b : Board) : IO Unit :=
 IO.println (tag ++ " " ++ String.intercalate "," (b.toList.map toString))
def main : IO Unit := do
 let kqk ← loadPackedTable "work/engine_sources1594/chess-winning-d0b1996/data/kqk_packed.txt"
 let krk ← loadPackedTable "work/engine_sources1594/chess-winning-d0b1996/data/krk_packed.txt"
 line "kqk" kqk
 line "krk" krk
 for tok in ["", "0", "64", "2049", "12\n", "-1", "0012"] do
  IO.println s!"token {parsePackedToken tok}"
 for kind in ([4,5,10,11] : List Int) do
  for n in List.range 256 do
   for side in ([0,1] : List Int) do
    let wk := Int.ofNat (n%64)
    let bk := Int.ofNat ((n*17+3)%64)
    let third := Int.ofNat ((n/4+7)%64)
    let state := writeSquare (writeSquare (writeSquare (writeSquare emptyState wk 6) bk 12) third kind) 64 side
    line s!"probe {kind} {n} {side}" (endgameProbe state kqk krk)
    if n < 8 then line s!"move {kind} {n} {side}" (endgameBestMove state kqk krk)
 for state in [emptyState, startingState, writeSquare emptyState 0 6, writeSquare (writeSquare emptyState 0 1) 1 7] do
  line "edge" (endgameProbe state kqk krk)
  line "noTable" (endgameProbe state #[] #[])
