import SFT.Computation.NativeBusyEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
 let sourceHash := args.headD ""
 if sourceHash.isEmpty then throw (IO.userError "Pass pinned source hash")
 if args.contains "traces" then
  for word in NativeClosing.wordsThroughDepth 14 do
   IO.println (render (.object [("word",.array (word.map Value.text)),("trace",.array ((NativeClosing.suffixTrace word).map (fun row => .array (row.map Value.text))))]))
 else
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NativeBusyGrammar.candidates do
   match NativeBusyEvidence.decideCandidate (NativeBusyEvidence.generatedCandidateData c) with
   | .ok decision => decisions := decisions ++ [decision]
   | .error e => throw (IO.userError e)
  let unknown := match NativeBusyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
   | .error e => e
   | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
   ("registration",NativeBusyEvidence.registration sourceHash),
   ("census",NativeBusyEvidence.census),
   ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
   ("closure",NativeBusyEvidence.closure decisions),
   ("controls",NativeBusyEvidence.runControls sourceHash),
   ("maxima",.array ((List.range 14).map (fun i => .integer (.ofNat (NativeClosing.nativeBusyBeaver (i+1)))))),
   ("unknown_id",.text unknown)]))
