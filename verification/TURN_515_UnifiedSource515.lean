import SFT.Physics.UnifiedConstants
open SFT.Physics SFT.Host.Canonical UnifiedConstantsCertificate
set_option maxRecDepth 100000
set_option maxHeartbeats 16000000
def outcome {α : Type} (encode : α → Value) : Except String α → Value
 | .ok a => .object [("ok",encode a)]
 | .error e => .object [("error",.text e)]
def main : IO Unit := IO.println (render (.object [
 ("terminal",outcome fieldsValue UnifiedConstantsTerminal.admittedTerminalVector),
 ("certificate",outcome certificateValue theoremCertificate),
 ("graph",.object (UnifiedConstantsGraph.dependencyGraph.map fun (k,vs) => (k,.array (vs.map Value.text)))),
 ("reachable",outcome (fun vs => .array (vs.map Value.text)) UnifiedConstantsGraph.reachableFromOne)]))
