import SFT.Physics.CriticalObservationGrammar
open SFT.Physics.CriticalObservationGrammar
#eval candidates.map fun c => (candidateId c,exactForm c,survives c,decisionReason c)
