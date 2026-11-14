import SFT.Physics.MagneticAnomaly
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.MagneticAnomaly
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let p ← IO.ofExcept magneticAnomalyStructure
 IO.println (render (.object [("bare_g",.integer (.ofNat p.bareG)),("terminal_alpha",fraction p.terminalAlpha),("phase_normalized_leading_anomaly",fraction p.phaseNormalizedLeadingAnomaly),("mass_sensitivity_graph",.text p.massSensitivityGraph),("physical_turn_translation",.text p.physicalTurnTranslation)]))
