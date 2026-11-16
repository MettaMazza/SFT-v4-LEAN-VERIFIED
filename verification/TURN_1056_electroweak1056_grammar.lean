import SFT.Physics.ElectroweakMeasuredGrammar
open SFT.Physics.ElectroweakMeasuredGrammar
#eval candidates.map fun c => (candidateId c,exactForm c,survives c,decisionReason c)
