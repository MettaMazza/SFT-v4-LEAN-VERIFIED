import SFT.Applications.FoldChess.Ordering
import SFT.Host.Text
namespace SFT.Applications.FoldChess

def parsePackedToken (tok : String) : Int :=
 (SFT.Host.Text.chars tok).foldl (fun n c => n*10+(Int.ofNat c.toNat-48)) 0

def parsePackedChars (chars : List Char) : Array Int :=
 let (out,n) := chars.foldl (fun (out,n) c =>
  if c.toNat = 32 then (out.push n,0)
  else (out,n*10+(Int.ofNat c.toNat-48))) ((#[],0) : Array Int × Int)
 out.push n

def parsePackedTable (text : String) : Array Int :=
 parsePackedChars (SFT.Host.Text.chars text)

def loadPackedTable (path : System.FilePath) : IO (Array Int) := do
 let bytes ← IO.FS.readBinFile path
 return parsePackedChars (SFT.Host.Text.decode bytes.size bytes.data.toList)

def endgameProbe (state kqk krk : Board) : Board :=
 if kqk.size < 2 then #[0,1,2]
 else
  let (count,wk,bk,thirdSq,thirdCode) := (List.range 64).foldl (fun (count,wk,bk,ts,tc) n =>
   if count > 3 then (count,wk,bk,ts,tc)
   else
    let sq := Int.ofNat n
    let code := readSquare state sq
    if code > 0 then
     let count := count+1
     if count > 3 then (count,wk,bk,ts,tc)
     else if code = 6 then (count,sq,bk,ts,tc)
     else if code = 12 then (count,wk,sq,ts,tc)
     else (count,wk,bk,sq,code)
    else (count,wk,bk,ts,tc)) ((0,64,64,64,0) : Int×Int×Int×Int×Int)
  if count > 3 then #[0,1,2]
  else if count = 2 then #[1,1,2]
  else
   let kind := pieceKind thirdCode
   if kind ≠ 5 ∧ kind ≠ 4 then #[0,1,2]
   else
    let stm := readSquare state 64
    let idx := bif pieceIsWhite thirdCode then ((wk*64+thirdSq)*64+bk)*2+stm
      else ((flipRank bk*64+flipRank thirdSq)*64+flipRank wk)*2+(1-stm)
    let table := if kind = 4 then krk else kqk
    let packed := readSquare table idx
    let storedKind := packed.tdiv 64
    let storedPly := packed-storedKind*64
    if storedKind = 1 then #[1,2048-storedPly,2049-storedPly]
    else if storedKind = 2 then #[1,1,2049-storedPly]
    else #[1,1,2]

def endgameBestMove (state kqk krk : Board) : Board :=
 let here := endgameProbe state kqk krk
 if readSquare here 0 = 0 then #[0,0]
 else
  let moves := legalMoves state
  if moves.size = 0 then #[0,0]
  else
   let (bestMove,_,_) := moves.toList.foldl (fun (bestMove,bestNum,bestDen) move =>
    let child := makeMove state move
    let childVal := endgameProbe child kqk krk
    let (myNum,myDen) := if readSquare childVal 0 = 1 then
      let cn := readSquare childVal 1
      let cd := readSquare childVal 2
      (cd-cn,cd)
     else if (legalMoves child).size = 0 then
      bif sideInCheck child then (1,1) else (1,2)
     else (1,2)
    if myNum*bestDen > bestNum*myDen then (move,myNum,myDen)
    else (bestMove,bestNum,bestDen)) ((moves.getD 0 0,0,1) : Int×Int×Int)
   #[1,bestMove]
end SFT.Applications.FoldChess
