import SFT
open SFT.Host.Canonical SFT.Foundation

def wordsValue (words : List FoldAssembly.Word) : Value :=
  .array (words.map fun w => .array (w.map Value.text))

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  IO.println (render (.object [("controls",FoldControls.runControls sourceHash),("closure",FoldControls.closureValue)]))
  for n in List.range 7 do
    let words := FoldAssembly.supportAfterExtensions n
    IO.println (render (.object [("support",wordsValue words),("returns",.array (words.map fun w =>
      match FoldAssembly.returnWord w with
      | none => .null
      | some p => .array (p.map Value.text)))]))
  for words in [[],[[]],[["x"],["λ","held-a"]],[["x"],["x"]]] do
    IO.println (render (wordsValue (FoldAssembly.extend words)))
  for n in [-2,-1,0,1,2,3] do
    IO.println (render (match FoldAssembly.checkedSupport n with
      | none => .null
      | some words => wordsValue words))
