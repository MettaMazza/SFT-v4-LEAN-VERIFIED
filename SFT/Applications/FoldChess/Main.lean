import SFT.Applications.FoldChess.Protocol
open SFT.Applications.FoldChess

def main (args : List String) : IO UInt32 := do
 let base := args.headD "reference/applications/chess-winning-d0b1996/data"
 let kqk ← loadPackedTable (System.FilePath.mk (SFT.Host.Text.append base "/kqk_packed.txt"))
 let krk ← loadPackedTable (System.FilePath.mk (SFT.Host.Text.append base "/krk_packed.txt"))
 let input ← IO.FS.readBinFile "/dev/stdin"
 match protocolDecision (protocolIntegers input) kqk krk with
 | some move => (← IO.getStdout).putStr (SFT.Host.Text.append (integerText move) "\n"); return 0
 | none => (← IO.getStderr).putStr "Expected depth, encoded moves and sentinel 8888.\n"; return 1
