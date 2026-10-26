import SFT
open SFT.Foundation.Count SFT.Foundation.Count.TraceDerivation
open SFT.Foundation.Count.Representation SFT.Host.Canonical

def words {α : Type} (alphabet : List α) : Nat → List (List α)
  | 0 => [[]]
  | n+1 => alphabet.flatMap fun a => (words alphabet n).map (List.cons a)

def main : IO Unit := do
  for t in [Trace.base, .extend .base, .extend (.extend .base)] do
    let alphabet := (complete t).map ProposedOccurrence.generated ++ [.ungenerated]
    for n in List.range 5 do
      for proposal in words alphabet n do
        let c := classifyProposal t proposal
        IO.println (render (.array [.text (candidateId c),.boolean (survives c),.text (decisionReason c)]))
