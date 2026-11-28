import SFT.Applications.FoldGo.Protocol
namespace SFT.Applications.FoldGo
open SFT.Host.Text

def trim (s : String) : String := String.ofList (((chars s).dropWhile whitespace).reverse.dropWhile whitespace).reverse

def printLine (s : String) : IO Unit := do
 (← IO.getStdout).putStr (append s "\n")

def clientConfig : IO.Process.StdioConfig := {stdin := .piped,stdout := .piped,stderr := .null}
structure Client where
 process : Option (IO.Process.Child clientConfig) := none
 board : GoBoard := emptyBoard 9

def openClient (command : List String) : IO Client :=
 match command with
 | [] => pure {}
 | cmd::args => do
  let process ← IO.Process.spawn {cmd,args := args.toArray,stdin := .piped,stdout := .piped,stderr := .null}
  return {process := some process}

partial def readResponse (handle : IO.FS.Handle) (lines : List String := []) : IO (List String) := do
 let line ← handle.getLine
 let stripped := trim line
 if equal stripped "" then return lines
 readResponse handle (lines++[stripped])

def clientSend (client : Client) (text : String) : IO (String × Client) := do
 match client.process with
 | some process =>
  printLine (append ">>> SEND: " text)
  try
   process.stdin.putStr (append text "\n")
   process.stdin.flush
  catch error =>
   printLine "!!! BROKEN PIPE."
   throw error
  let lines ← readResponse process.stdout
  let shown := append "[" (append (intercalate ", " (lines.map fun s => append "'" (append s "'"))) "]")
  printLine (append "<<< RECV: " shown)
  return (intercalate "\n" lines,client)
 | none =>
  let parts := words text
  if contains text "boardsize" then
   let size := (decimal (parts.toArray.getD 1 "")).getD 9
   return ("= ",{client with board := emptyBoard size})
  else if contains text "clear_board" then return ("= ",{client with board := emptyBoard client.board.size})
  else if contains text "play" then
   let color := if equal (upper (parts.toArray.getD 1 "")) "B" then 1 else 2
   match gtpToIndex (parts.toArray.getD 2 "") client.board.size with
   | .error error => throw (IO.userError error)
   | .ok move => return ("= ",{client with board := (playMove client.board move color).2})
  else if contains text "genmove" then
   let color := if equal (upper (parts.toArray.getD 1 "")) "B" then 1 else 2
   let move := (legalMoves client.board color).head?
   let board := (playMove client.board move color).2
   return (append "= " (indexToGtp move board.size),{client with board})
  else return ("= ",client)

partial def awaitClose (process : IO.Process.Child clientConfig) (deadline : Nat) : IO Unit := do
 if (← process.tryWait).isSome then return ()
 if (← IO.monoMsNow) ≥ deadline then process.kill; return ()
 IO.sleep 1
 awaitClose process deadline

def closeClient (client : Client) : IO Unit := do
 match client.process with
 | none => pure ()
 | some process =>
  try
   let _ ← clientSend client "quit"
   awaitClose process ((← IO.monoMsNow)+2000)
  catch _ => process.kill

structure RoundState where
 board : GoBoard
 search : SearchContext := {}
 passes : Nat := 0
 movesPlayed : Nat := 0

def roundSteps (sftColor : Nat) (depth : Int) : Nat → RoundState → Client → IO (RoundState × Client)
 | 0, state, client => pure (state,client)
 | fuel+1, state, client => do
  if state.passes ≥ 2 then return (state,client)
  let current := if state.movesPlayed%2 = 0 then 1 else 2
  let (move,board,search,client) ← if current = sftColor then do
    let (move,search) := selectMoveWithContext state.board sftColor depth state.search
    let board := (playMove state.board move sftColor).2
    let (_,client) ← clientSend client (join ["play ",(if sftColor = 1 then "B" else "W")," ",indexToGtp move board.size])
    pure (move,board,search,client)
   else do
    let opponent := 3-sftColor
    let (reply,client) ← clientSend client (append "genmove " (if opponent = 1 then "B" else "W"))
    let token := (words reply).toArray.getD 1 "pass"
    match gtpToIndex token state.board.size with
    | .error e => throw (IO.userError e)
    | .ok move => pure (move,(playMove state.board move opponent).2,state.search,client)
  let next : RoundState := {board,search,passes := if move.isNone then state.passes+1 else 0,movesPlayed := state.movesPlayed+1}
  roundSteps sftColor depth fuel next client

structure RoundResult where
 round : Nat
 sftColor : Nat
 black : Nat
 white : Nat
 sftWon : Bool
 movesPlayed : Nat

def runRound (opponent : List String) (size round : Nat) (depth : Int) (search : SearchContext) : IO (RoundResult × SearchContext) := do
 let sftColor := if round%2 = 0 then 1 else 2
 let client ← openClient opponent
 let (_,client) ← clientSend client (append "boardsize " (SFT.Applications.FoldChess.integerText (Int.ofNat size)))
 let (_,client) ← clientSend client "clear_board"
 let (state,client) ← roundSteps sftColor depth 128 {board := emptyBoard size,search} client
 closeClient client
 let (black,white) := areaScore state.board
 let white := white+7
 let winner := if black > white then 1 else 2
 return ({round := round+1,sftColor,black,white,sftWon := decide (winner = sftColor),movesPlayed := state.movesPlayed},state.search)
end SFT.Applications.FoldGo
