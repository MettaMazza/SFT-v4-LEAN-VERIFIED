import SFT.Applications.FoldGo.Run
open SFT.Applications.FoldGo

partial def serve (state : ProtocolState) : IO Unit := do
 let input ← IO.getStdin
 let line ← input.getLine
 if SFT.Host.Text.equal line "" then return ()
 let (next,reply) := command state line
 let output ← IO.getStdout
 output.putStr reply
 output.flush
 if !next.quit then serve next

def main (args : List String) : IO Unit := do
 let config := options args
 if SFT.Host.Text.equal (config.rest.headD "") "--server" then serve {}
 else if SFT.Host.Text.equal (config.rest.headD "") "--check-gtp" then
  let move := selectMove (emptyBoard config.size) 1 config.depth
  printLine (SFT.Host.Text.append "GTP check passed. SFT plays first move: " (indexToGtp move config.size))
 else tournament (opponentArgs config.rest) config.size config.rounds config.depth
