import SFT.Chemistry.InorganicColour
import SFT.Host.Canonical
open SFT.Chemistry.InorganicColour SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def labelJSON (h : HeldLabel) : J := .object [("family",.text h.family),("label",.text h.label)]
def stateJSON (s : State) : J := .object [("complex_identity",labelJSON s.complexIdentity),("carrier_kind",labelJSON s.carrierKind),("state_identity",labelJSON s.stateIdentity),("order_position",.integer (.ofNat s.orderPosition.value))]
def transitionJSON (t : Transition) : J := .object [("source",stateJSON t.source),("target",stateJSON t.target),("positive_order_gap",.integer (.ofNat t.positiveOrderGap.value)),("transfer_class",labelJSON t.transferClass)]
def absorptionJSON (a : Absorption) : J := .object [("transition",transitionJSON a.transition),("incident_distinctions",.array (a.incident.map labelJSON)),("absorbed_distinctions",.array (a.absorbed.map labelJSON)),("retained_colour_distinctions",.array (a.retained.map labelJSON)),("absorbed_count",.integer (.ofNat (absorbedCount a).value)),("retained_colour_count",.integer (.ofNat (retainedCount a).value))]
def result : Except String J → J
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def main : IO Unit := IO.println (SFT.Host.Canonical.render (.array [
result (classes.map (fun xs => .array (xs.map labelJSON))),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨1,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨1,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨2,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨2,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨2,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨3,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨3,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "ligand" "lower" "upper" ⟨3,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨2,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨2,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨2,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨3,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨3,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "lower" "upper" ⟨3,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨1,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨1,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨2,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨2,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨2,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨3,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨3,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "ligand" "lower" "upper" ⟨3,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨2,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨2,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨2,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨3,by decide⟩ ⟨1,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨3,by decide⟩ ⟨2,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "lower" "upper" ⟨3,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "other" "metal" "a" "b" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "other" "a" "b" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "metal" "metal" "same" "same" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((build "complex" "ligand" "metal" "" "b" ⟨1,by decide⟩ ⟨3,by decide⟩).map transitionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩] [⟨"observation-distinction","d-1",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩] [⟨"observation-distinction","d-2",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩] [⟨"observation-distinction","d-2",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩] [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩] []).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩] [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩] [⟨"observation-distinction","d-1",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩] [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-1",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [⟨"observation-distinction","d-1",by decide,by decide⟩,⟨"observation-distinction","d-2",by decide,by decide⟩,⟨"observation-distinction","d-3",by decide,by decide⟩] [⟨"observation-distinction","d-4",by decide,by decide⟩]).map absorptionJSON),
result ((do let t ← witnessTransition; selective t [] [⟨"observation-distinction","d-1",by decide,by decide⟩]).map absorptionJSON)]))
