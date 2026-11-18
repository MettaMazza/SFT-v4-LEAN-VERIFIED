import SFT.Chemistry.DihedralTorsionExperiment
open SFT.Chemistry.DihedralTorsionExperiment SFT.Host.Canonical
def main : IO Unit := do
 let program ← IO.ofExcept predictionProgramDocument
 let registration ← IO.ofExcept experimentRegistrationRecord
 IO.println (render (.object [("program",program),("registration",registration)]))
