import SFT

def main : IO Unit := do
  for (key, value) in SFT.Foundation.Root.closureRecord do
    IO.println ("closure\t" ++ key ++ "\t" ++ value)
  for record in [SFT.Foundation.Root.falsePremiseControl,
      SFT.Foundation.Root.tamperedArtifactControl,
      SFT.Foundation.Root.boundaryControl] do
    IO.println ("control\t" ++ record.kind ++ "\t" ++ record.premise ++ "\t" ++ record.expected ++ "\t" ++ record.observed ++ "\t" ++ (if record.passed then "true" else "false"))
