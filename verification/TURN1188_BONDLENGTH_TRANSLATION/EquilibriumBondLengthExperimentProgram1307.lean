import SFT.Chemistry.EquilibriumBondLengthExperiment
open SFT.Host.Canonical SFT.Chemistry.EquilibriumBondLengthExperiment
def main : IO Unit := do
 let program ← IO.ofExcept predictionProgramDocument
 let registration ← IO.ofExcept experimentRegistrationRecord
 IO.println (render (.object [("program",program),("registration",registration)]))
