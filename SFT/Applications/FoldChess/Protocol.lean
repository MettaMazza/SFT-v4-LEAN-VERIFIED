import SFT.Applications.FoldChess.Driver
namespace SFT.Applications.FoldChess

-- Input contract of the original match harness: decimal integer tokens,
-- depth first, move history next, terminating sentinel 8888.
def protocolIntegers (bytes : ByteArray) : List Int :=
 let (tokens,num,negative,active) := bytes.data.toList.foldl (fun (tokens,num,negative,active) b =>
  let n := b.toNat
  if n = 32 ∨ (9 ≤ n ∧ n ≤ 13) then
   if active then ((if negative then -num else num)::tokens,0,false,false)
   else (tokens,num,negative,false)
  else if n = 45 then (tokens,num,true,true)
  else if n = 43 then (tokens,num,false,true)
  else (tokens,num*10+Int.ofNat n-48,negative,true)) (([],0,false,false) : List Int×Int×Bool×Bool)
 let tokens := bif active then (bif negative then -num else num)::tokens else tokens
 tokens.reverse

structure ProtocolState where
 board : Board := startingState
 seen : String := stateSignature startingState
 context : SearchContext := {}
 answer : Option Int := none

def protocolDecision (tokens : List Int) (kqk krk : Board) : Option Int :=
 match tokens with
 | [] => none
 | depth::history =>
  let result := history.foldl (fun p token =>
   match p.answer with
   | some _ => p
   | none =>
    if token = 8888 then
     let endgame := endgameBestMove p.board kqk krk
     if readSquare endgame 0 = 1 then {p with answer := some (readSquare endgame 1)}
     else
      let (answer,ctx) := searchBestSeen p.board depth p.seen p.context
      {p with answer := some (readSquare answer 0),context := ctx}
    else
     let state := makeMove p.board token
     {p with board := state,seen := SFT.Host.Text.append p.seen (stateSignature state)}) ({} : ProtocolState)
  result.answer
end SFT.Applications.FoldChess
