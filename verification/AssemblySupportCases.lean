import SFT
open SFT.Foundation SFT.Host.Canonical

def proposalWords (alphabet : List FoldAssembly.Word) : Nat → List (List FoldAssembly.Word)
  | 0 => [[]]
  | n+1 => alphabet.flatMap fun a => (proposalWords alphabet n).map (List.cons a)

def main : IO Unit := do
  for n in [0,1,2] do
    let support := FoldAssembly.supportAfterExtensions n
    let alphabet := support ++ (if n == 0 then [["held-a"],["outside"]] else [[],["outside"]])
    let proposals := ([0,1,2,3].flatMap (proposalWords alphabet)) ++ (if n == 2 then [support] else [])
    for ws in proposals do
      for coverage in [FoldAssemblyGrammar.Coverage.none,.proper,.complete] do
        for transitions in [FoldAssemblyGrammar.Transitions.absent,.present] do
          for returns in [FoldAssemblyGrammar.Returns.absent,.present] do
            for extra in [false,true] do
              let c := AssemblySupport.classifySupport n ws coverage transitions returns extra
              IO.println (render (.array [.text (FoldAssemblyGrammar.candidateId c),
                .boolean (FoldAssemblyGrammar.survives c),.text (FoldAssemblyGrammar.decisionReason c)]))
