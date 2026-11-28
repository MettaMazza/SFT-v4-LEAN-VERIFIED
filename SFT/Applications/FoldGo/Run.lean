import SFT.Applications.FoldGo.Tournament
namespace SFT.Applications.FoldGo
open SFT.Host.Text

def number (n : Nat) : String := SFT.Applications.FoldChess.integerText (Int.ofNat n)
def roundLine (r : RoundResult) : String := join ["Round ",number r.round,": SFT=",(if r.sftColor = 1 then "Black" else "White")," | Score B=",number r.black," W=",number r.white," | Winner: ",(bif r.sftWon then "SFT" else "Opponent")]

def roundsLoop (opponent : List String) (size : Nat) (depth : Int) : Nat → Nat → SearchContext → IO (List RoundResult)
 | 0, _, _ => pure []
 | fuel+1, index, ctx => do
  let (result,ctx) ← runRound opponent size index depth ctx
  printLine (roundLine result)
  let rest ← roundsLoop opponent size depth fuel (index+1) ctx
  return result::rest

def ledger (date : String) (opponent : List String) (size rounds : Nat) (depth : Int) (results : List RoundResult) : String :=
 let wins := results.foldl (fun n r => bif r.sftWon then n+1 else n) 0
 let opponentName := if opponent.isEmpty then "Deterministic Fallback" else intercalate " " opponent
 let rows := results.map fun r => join ["| ",number r.round," | ",(if r.sftColor = 1 then "Black" else "White")," | ",number r.black," | ",number r.white," | ",(bif r.sftWon then "SFT" else "Opponent")," |\n"]
 join ["# SFT Go Engine Match Ledger\n\n**Date:** ",date,"  \n**Engine:** SFT Type Zero Go v2.0 (zero parameters, iterative deepening ceiling ",SFT.Applications.FoldChess.integerText depth,", 2^19 node budget)  \n**Opponent:** ",opponentName,"  \n**Board Size:** ",number size,"×",number size,"  \n\n## Match Results\n\n| Round | SFT Side | Score B | Score W | Winner |\n|---|---|---|---|---|\n",join rows,"|---|---|---|---|---|\n| **Total** | — | — | — | **SFT won ",number wins,"/",number rounds," games** |\n"]

def tournament (opponent : List String) (size rounds : Nat) (depth : Int) : IO Unit := do
 printLine "=== SFT Go Tournament Referee ==="
 printLine (join ["Starting ",number rounds,"-round match on ",number size,"x",number size," board (search ceiling ",SFT.Applications.FoldChess.integerText depth,")..."])
 printLine (if opponent.isEmpty then "No external engine specified; running against deterministic fallback." else append "Opponent command: " (intercalate " " opponent))
 let results ← roundsLoop opponent size depth rounds 0 {}
 let wins := results.foldl (fun n r => bif r.sftWon then n+1 else n) 0
 printLine "\nTournament complete!"
 printLine (join ["Final Score: SFT ",number wins," - ",number (rounds-wins)," Opponent"])
 let dateProcess ← IO.Process.spawn {cmd := "date",args := #["+%B %d, %Y"],stdout := .piped}
 let dateText ← dateProcess.stdout.getLine
 let _ ← dateProcess.wait
 let file ← IO.FS.Handle.mk "tools/GO_MATCHES.md" .write
 file.putStr (ledger (trim dateText) opponent size rounds depth results)
 file.flush
 printLine "Match ledger written to tools/GO_MATCHES.md."

structure Options where
 size : Nat := 9
 depth : Int := 8
 rounds : Nat := 4
 rest : List String := []

def extractOption (flag : String) : List String → Option (String × List String)
 | [] => none
 | x::xs =>
  if equal x flag then match xs with | [] => none | value::rest => some (value,rest)
  else match extractOption flag xs with | none => none | some (value,rest) => some (value,x::rest)

def options (args : List String) : Options :=
 let (size,args) := match extractOption "--size" args with | none => (9,args) | some (v,rest) => ((decimal v).getD 9,rest)
 let (depth,args) := match extractOption "--depth" args with | none => (8,args) | some (v,rest) => ((signedDecimal v).getD 8,rest)
 let (rounds,args) := match extractOption "--rounds" args with | none => (4,args) | some (v,rest) => ((decimal v).getD 4,rest)
 {size,depth,rounds,rest := args}

def opponentArgs : List String → List String
 | [] => []
 | x::xs => if equal x "--engine" then xs else opponentArgs xs
end SFT.Applications.FoldGo
