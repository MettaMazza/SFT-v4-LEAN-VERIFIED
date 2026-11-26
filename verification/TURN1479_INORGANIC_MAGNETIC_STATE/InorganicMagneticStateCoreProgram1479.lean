import SFT.Chemistry.InorganicMagneticState
import SFT.Host.Canonical
open SFT.Chemistry.InorganicMagneticState SFT.Physics.CapabilityValues
open SFT.Chemistry.ComplexSpinState (ExactCount exactCount)
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def countJSON : ExactCount → J
 | .empty identity => .object [("empty",.text identity)]
 | .positive p => .integer (.ofNat p.value)
def supportJSON (s : Support) : J := .object [("complex_identity",labelJSON s.complexIdentity),("electron_occurrences",.array (s.occurrences.map labelJSON)),("spin_fibres",.array (s.fibres.map labelJSON)),("unpaired_count",countJSON (unpairedCount s)),("spin_width",.integer (.ofNat (spinWidth s).value))]
def stateJSON (s : MagneticState) : J := .object [("support",supportJSON s.support),("moment_support",countJSON s.momentSupport),("spin_width",.integer (.ofNat s.spinWidth.value)),("field_relation",labelJSON s.fieldRelation),("magnetic_class",labelJSON s.magneticClass)]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
result ((complete "complex" (exactCount 0)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 0))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 0))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 0)))).map stateJSON),
result ((complete "complex" (exactCount 1)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 1))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 1))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 1)))).map stateJSON),
result ((complete "complex" (exactCount 2)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 2))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 2))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 2)))).map stateJSON),
result ((complete "complex" (exactCount 3)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 3))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 3))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 3)))).map stateJSON),
result ((complete "complex" (exactCount 4)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 4))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 4))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 4)))).map stateJSON),
result ((complete "complex" (exactCount 5)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 5))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 5))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 5)))).map stateJSON),
result ((complete "complex" (exactCount 6)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 6))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 6))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 6)))).map stateJSON),
result ((complete "complex" (exactCount 7)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 7))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 7))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 7)))).map stateJSON),
result ((complete "complex" (exactCount 8)).map supportJSON),
result ((do forced (← complete "complex" (exactCount 8))).map stateJSON),
result ((do appendSuccessor (← complete "complex" (exactCount 8))).map supportJSON),
result ((do forced (← appendSuccessor (← complete "complex" (exactCount 8)))).map stateJSON),
result ((support ⟨"wrong","complex",by decide,by decide⟩ [] []).map supportJSON),
result ((support ⟨"coordination-entity","complex",by decide,by decide⟩ [⟨"electron-occurrence","e",by decide,by decide⟩] []).map supportJSON),
result ((support ⟨"coordination-entity","complex",by decide,by decide⟩ [⟨"electron-occurrence","e",by decide,by decide⟩,⟨"electron-occurrence","e",by decide,by decide⟩] [⟨"electron-spin","fibre-a",by decide,by decide⟩,⟨"electron-spin","fibre-a",by decide,by decide⟩]).map supportJSON),
result ((support ⟨"coordination-entity","complex",by decide,by decide⟩ [⟨"other","e",by decide,by decide⟩] [⟨"electron-spin","fibre-a",by decide,by decide⟩]).map supportJSON),
result ((support ⟨"coordination-entity","complex",by decide,by decide⟩ [⟨"electron-occurrence","e",by decide,by decide⟩] [⟨"electron-spin","invalid",by decide,by decide⟩]).map supportJSON),
result ((support ⟨"coordination-entity","complex",by decide,by decide⟩ [⟨"electron-occurrence","e",by decide,by decide⟩] [⟨"other","fibre-a",by decide,by decide⟩]).map supportJSON),
result ((do appendSuccessor (← support ⟨"coordination-entity","complex",by decide,by decide⟩ [⟨"electron-occurrence","unpaired-2",by decide,by decide⟩] [⟨"electron-spin","fibre-a",by decide,by decide⟩])).map supportJSON),
result ((do magneticState (← complete "complex" (exactCount 0)) (exactCount 1) ⟨1,by decide⟩ ⟨"held-field-relation","repelled-from-field",by decide,by decide⟩ ⟨"inorganic-magnetic-class","diamagnetic",by decide,by decide⟩).map stateJSON),
result ((do magneticState (← complete "complex" (exactCount 1)) (exactCount 1) ⟨3,by decide⟩ ⟨"held-field-relation","drawn-into-field",by decide,by decide⟩ ⟨"inorganic-magnetic-class","paramagnetic",by decide,by decide⟩).map stateJSON),
result ((do magneticState (← complete "complex" (exactCount 1)) (exactCount 1) ⟨2,by decide⟩ ⟨"wrong","drawn-into-field",by decide,by decide⟩ ⟨"inorganic-magnetic-class","paramagnetic",by decide,by decide⟩).map stateJSON),
result ((do magneticState (← complete "complex" (exactCount 1)) (exactCount 1) ⟨2,by decide⟩ ⟨"held-field-relation","drawn-into-field",by decide,by decide⟩ ⟨"wrong","paramagnetic",by decide,by decide⟩).map stateJSON),
result ((do magneticState (← complete "complex" (exactCount 0)) (exactCount 0) ⟨1,by decide⟩ ⟨"held-field-relation","drawn-into-field",by decide,by decide⟩ ⟨"inorganic-magnetic-class","paramagnetic",by decide,by decide⟩).map stateJSON),
result ((do magneticState (← complete "complex" (exactCount 1)) (exactCount 1) ⟨2,by decide⟩ ⟨"held-field-relation","repelled-from-field",by decide,by decide⟩ ⟨"inorganic-magnetic-class","diamagnetic",by decide,by decide⟩).map stateJSON)]))
