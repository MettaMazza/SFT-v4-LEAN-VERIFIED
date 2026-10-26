import SFT
open SFT.Engine SFT.Host.Canonical

def main : IO Unit := do
  let good := "sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  for scope in [ClosureScope.conditionalGrammar,.finiteComplete,.depthIndependent] do
    for boundary in ["operational", "", " \t"] do
      for minimality in [false,true] do
        for uniqueness in [false,true] do
          for proof in [good, "bad", "sha256:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"] do
            for generality in [none, some good, some "", some "bad"] do
              let c : ClosureEvidence := ⟨scope,boundary,minimality,uniqueness,proof,generality⟩
              IO.println (render (.array ((closureViolations c).map Value.text)))
  let kinds := [ControlKind.falsePremise,.tamperedSource,.tamperedArtifact,.boundary]
  let subsets := (List.range 16).map fun n =>
    (kinds.zipIdx).filterMap (fun (k,i) => if n / 2^i % 2 == 1 then some k else none)
  let sequences := subsets ++ [kinds.reverse, kinds ++ [.boundary]]
  for sequence in sequences do
    for mode in [0,1,2,3] do
      for expected in ["reject", " \t"] do
        for observed in ["rejected", ""] do
          for receipt in [good,"invalid"] do
            let cs : List ControlResult := sequence.zipIdx.map fun (k,i) =>
              ⟨k, (if mode == 0 then true else if mode == 1 then i != 0 else if mode == 2 then i+1 != sequence.length else false), expected, observed, receipt⟩
            IO.println (render (.array ((controlViolations cs).map Value.text)))
  IO.println (render (.array ((closureViolations SFT.Foundation.Root.Gate.closure).map Value.text)))
  IO.println (render (.array ((closureViolations SFT.Foundation.Root.Gate.noMinimalityClosure).map Value.text)))
  IO.println (render (.array ((closureViolations SFT.Foundation.Root.Gate.noGeneralityClosure).map Value.text)))
  let sourceHash := "sha256:c3de6a8fc34d927dce243992a5a0de610f0c8701084ae08b3c9828838f75d915"
  IO.println (render (.array ((controlViolations (SFT.Foundation.Root.Evidence.runControlsData sourceHash)).map Value.text)))
  IO.println (render (.array ((controlViolations (SFT.Foundation.Root.Gate.failedControls sourceHash)).map Value.text)))
