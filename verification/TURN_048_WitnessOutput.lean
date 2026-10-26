import SFT
open SFT.Mathematics.ExactArithmeticWitnesses SFT.Host.Canonical
def main : IO Unit := IO.println (render (.array (witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])))
