import SFT.Applications.FoldChess.Protocol
namespace SFT.Applications.FoldChess

def startIsAtTheLock : Bool := decide (shareDenominator startingState = 2*shareNumerator startingState)
def foolsMateSetup : Board := makeMove (makeMove (makeMove startingState 853) 3364) 926

def findsFoolsMate (ctx : SearchContext) : Int × SearchContext :=
 let (answer,ctx) := searchBest foolsMateSetup 2 ctx
 (readSquare answer 0,ctx)

def foolsMateIsSeenAsMate (ctx : SearchContext) : Bool × SearchContext :=
 let (answer,ctx) := searchBest foolsMateSetup 2 ctx
 (decide (readSquare answer 1*1024 > readSquare answer 2*1000),ctx)

def foolsMateIsReal (ctx : SearchContext) : Bool × SearchContext :=
 let (strike,ctx) := findsFoolsMate ctx
 let final := makeMove foolsMateSetup strike
 (decide ((legalMoves final).size = 0) && sideInCheck final,ctx)

def selfPlayPlies (plies : Int) (ctx : SearchContext) : Int × SearchContext :=
 let (state,played,stopped,ctx) := (List.range plies.toNat).foldl (fun (state,played,stopped,ctx) _ =>
  bif stopped then (state,played,stopped,ctx)
  else if (legalMoves state).size = 0 then (state,played,true,ctx)
  else
   let (answer,ctx) := searchBest state 2 ctx
   (makeMove state (readSquare answer 0),played+1,false,ctx)) ((startingState,0,false,ctx) : Board×Int×Bool×SearchContext)
 bif stopped then (played,ctx)
 else if kingSquare state 0 < 64 ∧ kingSquare state 1 < 64 then
  let probe := writeSquare (copyState state) 64 (1-readSquare state 64)
  bif sideInCheck probe then (-1,ctx) else (played,ctx)
 else (-2,ctx)
end SFT.Applications.FoldChess
