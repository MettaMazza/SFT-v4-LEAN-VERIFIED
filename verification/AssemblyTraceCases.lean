import SFT
open SFT.Host.Canonical SFT.Foundation.FoldAssembly SFT.Foundation.FoldAssemblyTrace

def wordValue (w : Word) : Value := .array (w.map Value.text)

def main : IO Unit := do
  for n in List.range 6 do
    IO.println (render (.object [
      ("stages",.array ((generationTrace n).map fun words => .array (words.map wordValue))),
      ("transitions",.array ((transitionTrace n).map fun t => .array [wordValue t.predecessor,.text t.label,wordValue t.successor])),
      ("returns",.array ((returnTrace n).map fun pair => .array [wordValue pair.1,wordValue pair.2]))]))
