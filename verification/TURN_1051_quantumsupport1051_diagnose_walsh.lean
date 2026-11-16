import SFT.Physics.QuantumSupportWalsh
import Lean
open Lean in run_cmd do
 let info ← getConstInfo `SFT.Physics.QuantumSupportWalsh.walshSupportCertificate
 for n in (info.value! true).getUsedConstants do
  let deps ← collectAxioms n
  unless deps.isEmpty do logInfo m!"{n}: {deps}"
