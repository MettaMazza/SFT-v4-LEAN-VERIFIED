import SFT.Physics.CommonMeasuredGrammar
open SFT.Physics.CommonMeasuredGrammar
#eval candidates.map fun c => (candidateId c,exactForm c,survives c,decisionReason c)
