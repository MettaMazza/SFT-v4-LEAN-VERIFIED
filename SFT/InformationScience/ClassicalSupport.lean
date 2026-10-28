import SFT.InformationScience.ConservationCardinality
namespace SFT.InformationScience.ClassicalSupport
open MutualObservation
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.ProbabilityObservations
open SFT.Mathematics.GeometryTopology

def canonicalSupport (support : List String) : Except String (List String) :=
  if supportValid support then .ok support
  else .error "ValueError: information support must be nonempty, complete and duplicate-free"

structure ClassicalState where
  heldState : String
  supportProvenance : List String
  deriving DecidableEq

def classicalState (support : List String) (held : String) : Except String ClassicalState :=
  match canonicalSupport support with
  | .error e => .error e
  | .ok _ => if has support held then .ok ⟨held,support⟩
    else .error "ValueError: a classical state must be one held member of registered support"

def validateProbability (support : List String) (observation : Observation) : Except String Observation :=
  match canonicalSupport support with
  | .error e => .error e
  | .ok _ => if mapValid support observation then .ok observation
    else .error "ValueError: a probability ledger requires one observation image per microstate"

-- Python's `or` short-circuits on duplicate keys before canonical_support.
def validatePushforward (support : List String) (mapping : Observation) : Except String Observation :=
  if distinct (mapping.map Prod.fst) then
    match canonicalSupport support with
    | .error e => .error e
    | .ok _ => if keysMatch support mapping then .ok mapping
      else .error "ValueError: pushforward requires a total single-valued deterministic transformation"
  else .error "ValueError: pushforward requires a total single-valued deterministic transformation"

theorem canonicalMeaning (support output : List String) :
    canonicalSupport support = .ok output ↔ supportValid support = true ∧ output = support := by
  unfold canonicalSupport
  cases h : supportValid support
  · constructor
    · intro h; cases h
    · intro h; cases h.1
  · constructor
    · intro h; exact ⟨rfl,(Except.ok.inj h).symm⟩
    · intro h; rw [h.2]; rfl

theorem classicalMeaning (support : List String) (held : String) (state : ClassicalState) :
    classicalState support held = .ok state ↔
      supportValid support = true ∧ held ∈ support ∧ state = ⟨held,support⟩ := by
  unfold classicalState canonicalSupport
  cases hs : supportValid support <;> cases hh : has support held
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  · have yes := (hasIff _ _).mpr h.2.1; rw [hh] at yes; cases yes
  · exact ⟨rfl,(hasIff _ _).mp hh,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem probabilityMeaning (support : List String) (observation output : Observation) :
    validateProbability support observation = .ok output ↔
      supportValid support = true ∧ mapValid support observation = true ∧ output = observation := by
  unfold validateProbability canonicalSupport
  cases hs : supportValid support <;> cases hm : mapValid support observation
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  · exact ⟨rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem pushforwardMeaning (support : List String) (mapping output : Observation) :
    validatePushforward support mapping = .ok output ↔
      supportValid support = true ∧ mapValid support mapping = true ∧ output = mapping := by
  unfold validatePushforward canonicalSupport
  cases hd : distinct (mapping.map Prod.fst) <;> cases hs : supportValid support <;> cases hk : keysMatch support mapping
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { have m := (mapMeaning _ _).mp h.2.1; rw [hd] at m; cases m.1 }
  all_goals try { have m := (mapMeaning _ _).mp h.2.1; rw [hk] at m; cases m.2 }
  · exact ⟨rfl,(mapMeaning _ _).mpr ⟨hd,hk⟩,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem probabilityPartition (support : List String) (observation : Observation)
    (h : validateProbability support observation = .ok observation) :
    EntropyPartition.exactPartition support observation = .ok (classRows support observation) := by
  have valid := (MutualObservation.validationMeaning _ _ _).mpr ((probabilityMeaning _ _ _).mp h)
  unfold EntropyPartition.exactPartition
  rw [partitionValidity _ _ _ valid]
  rfl

theorem pushforwardProbability (support : List String) (mapping : Observation)
    (h : validatePushforward support mapping = .ok mapping) : validateProbability support mapping = .ok mapping :=
  (probabilityMeaning _ _ _).mpr ((pushforwardMeaning _ _ _).mp h)

end SFT.InformationScience.ClassicalSupport
