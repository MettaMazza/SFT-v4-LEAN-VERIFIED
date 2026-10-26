import SFT
open SFT.Foundation SFT.Host.Canonical

def finiteLists (alphabet : List FoldAssembly.Word) : Nat → List (List FoldAssembly.Word)
  | 0 => [[]]
  | n+1 => alphabet.flatMap fun a => (finiteLists alphabet n).map (List.cons a)

def main (args : List String) : IO Unit := do
  IO.println (render (.object [("controls",AssemblyControls.runControls (args.headD "")),("closure",AssemblyControls.closureValue)]))
  for n in [0,1,2] do
    let support := FoldAssembly.supportAfterExtensions n
    let alphabet := support ++ (if n == 0 then [["held-a"],["outside"]] else [[],["outside"]])
    let proposals := ([0,1,2,3].flatMap (finiteLists alphabet)) ++ (if n == 2 then [support] else [])
    for ws in proposals do
      IO.println (render (.array [.boolean (AssemblySets.sourceUniquenessCheck ws),
        .array ((AssemblySets.distinctWords ws).map fun w => .array (w.map Value.text))]))
