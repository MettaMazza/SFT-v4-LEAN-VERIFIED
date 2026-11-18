import SFT.Chemistry.BondDissociationEnergyExperiment
open SFT.Host.Canonical SFT.Chemistry.BondDissociationEnergyExperiment
def main : IO Unit := IO.println (render (.object [("program",predictionProgramDocument),("registration",experimentRegistrationRecord)]))
