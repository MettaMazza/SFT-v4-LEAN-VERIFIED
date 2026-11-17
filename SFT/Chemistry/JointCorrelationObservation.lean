import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.JointCorrelationObservation
open SFT.Host SFT.Physics.CapabilityValues
structure Observation where
 sourceIdentity : HeldLabel
 speciesIdentity : HeldLabel
 stateIdentity : HeldLabel
 jointSupportRole : HeldLabel
 positiveEnergySeparation : Value
 positiveUncertaintyOrAbsence : Value

def isRatio : Value → Bool
 | .ratio _ _ => true
 | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
def isUncertainty : Value → Bool
 | .emptyOne _ | .ratio _ _ => true
 | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
def validate (s : Observation) : Except String Observation :=
 match Text.equal s.sourceIdentity.family "external-source" with
 | false => .error "dissociation observation requires a retained external source"
 | true => match Text.equal s.speciesIdentity.family "chemical-species" with
  | false => .error "dissociation observation requires a retained species"
  | true => match Text.equal s.stateIdentity.family "molecular-state" with
   | false => .error "dissociation observation requires a retained state"
   | true => match Text.equal s.jointSupportRole.family "joint-support-role" with
    | false => .error "dissociation observation requires a retained joint-support role"
    | true => match isRatio s.positiveEnergySeparation with
     | false => .error "dissociation separation must be an exact positive external record"
     | true => match isUncertainty s.positiveUncertaintyOrAbsence with
      | false => .error "uncertainty must be an exact positive record or structural absence"
      | true => .ok s

theorem acceptedEnergyRatio (s result : Observation) (h : validate s = .ok result) :
 isRatio result.positiveEnergySeparation = true := by
 unfold validate at h
 split at h
 · cases h
 · split at h
   · cases h
   · split at h
     · cases h
     · split at h
       · cases h
       · split at h
         · cases h
         · split at h
           · cases h
           · cases h; assumption

theorem acceptedUncertainty (s result : Observation) (h : validate s = .ok result) :
 isUncertainty result.positiveUncertaintyOrAbsence = true := by
 unfold validate at h
 split at h
 · cases h
 · split at h
   · cases h
   · split at h
     · cases h
     · split at h
       · cases h
       · split at h
         · cases h
         · split at h
           · cases h
           · cases h; assumption
end SFT.Chemistry.JointCorrelationObservation
