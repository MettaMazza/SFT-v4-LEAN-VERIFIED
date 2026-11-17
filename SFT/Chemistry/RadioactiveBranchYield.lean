import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.RadioactiveBranchYield
open SFT.Host SFT.Physics.CapabilityValues
structure BranchYield where
 channel : HeldLabel
 daughterSpecies : HeldLabel
 events : PositiveCount
 recovered : PositiveCount

def admissible (r : BranchYield) : Bool := Text.equal r.channel.family "decay-channel" &&
 Text.equal r.daughterSpecies.family "daughter-species" && decide (r.recovered.value ≤ r.events.value)
def construct (channel daughter : HeldLabel) (events recovered : PositiveCount) : Except String BranchYield :=
 let r := BranchYield.mk channel daughter events recovered
 if admissible r then .ok r else .error "bounded branch recovery required"
def recovery (r : BranchYield) : PositiveCount × PositiveCount := (r.recovered,r.events)
def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def distinctChannels : List BranchYield → Bool
 | [] => true
 | r::rs => !(rs.any (fun s => sameLabel r.channel s.channel)) && distinctChannels rs
def totalEvents (rows : List BranchYield) : Nat := (rows.map (fun r => r.events.value)).sum
def branchPartition (rows : List BranchYield) : Except String (List (PositiveCount × PositiveCount)) := do
 if rows.isEmpty || !distinctChannels rows then throw "complete distinct branch vector required"
 let total ← count (totalEvents rows)
 return rows.map (fun r => (r.events,total))

theorem numeratorSum (rows : List BranchYield) (denominator : PositiveCount) :
 ((rows.map (fun r => (r.events,denominator))).map (fun p => p.1.value)).sum = totalEvents rows := by
 induction rows with
 | nil => rfl
 | cons r rs ih =>
  change r.events.value + ((rs.map (fun r => (r.events,denominator))).map (fun p => p.1.value)).sum = r.events.value + totalEvents rs
  rw [ih]
theorem commonDenominator (r : BranchYield) (total : PositiveCount) :
 (r.events,total).2.value = total.value := rfl

theorem partitionNumeratorConservation (rs : List BranchYield) (ps : List (PositiveCount × PositiveCount))
 (h : branchPartition rs = .ok ps) : (ps.map (fun p => p.1.value)).sum = totalEvents rs := by
 unfold branchPartition at h
 split at h
 · cases h
 · cases hc : count (totalEvents rs) with
   | error e => rw [hc] at h; cases h
   | ok total =>
    rw [hc] at h
    cases h
    exact numeratorSum rs total

theorem partitionDenominator (rs : List BranchYield) (ps : List (PositiveCount × PositiveCount))
 (h : branchPartition rs = .ok ps) (p : PositiveCount × PositiveCount) (hp : p ∈ ps) :
 p.2.value = totalEvents rs := by
 unfold branchPartition at h
 split at h
 · cases h
 · cases hc : count (totalEvents rs) with
   | error e => rw [hc] at h; cases h
   | ok total =>
    rw [hc] at h
    cases h
    have value : total.value = totalEvents rs := by
     unfold count at hc
     split at hc
     · cases hc; rfl
     · cases hc
    have constant : ∀ xs : List BranchYield, ∀ q : PositiveCount × PositiveCount,
      q ∈ xs.map (fun r => (r.events,total)) → q.2.value = total.value := by
     intro xs
     induction xs with
     | nil => intro q hq; cases hq
     | cons x xs ih =>
      intro q hq
      cases hq with
      | head => rfl
      | tail _ hrest => exact ih q hrest
    exact (constant rs p hp).trans value

theorem partitionSumsOne (rs : List BranchYield) (ps : List (PositiveCount × PositiveCount))
 (h : branchPartition rs = .ok ps) (p : PositiveCount × PositiveCount) (hp : p ∈ ps) :
 (ps.map (fun q => q.1.value)).sum = p.2.value :=
 (partitionNumeratorConservation rs ps h).trans (partitionDenominator rs ps h p hp).symm

def reduced (p : PositiveCount × PositiveCount) : Nat × Nat :=
 let g := Nat.gcd p.1.value p.2.value
 (p.1.value/g,p.2.value/g)
def original (n e r : Nat) : Except String BranchYield := do
 construct (← heldLabel "decay-channel" (toString n)) (← heldLabel "daughter-species" (toString n)) (← count e) (← count r)
def rows : Except String (List BranchYield) := do return [← original 1 3 2,← original 2 1 1]
def check (p : List BranchYield → Bool) : Bool := match rows with
 | .error _ => false
 | .ok rs => p rs
def channelWitness : Bool := check distinctChannels
def daughterWitness : Bool := check (fun rs => match rs with
 | [a,b] => !(sameLabel a.daughterSpecies b.daughterSpecies)
 | [] | [_] | _::_::_::_ => false)
def firstCheck (p : BranchYield → Bool) : Bool := check (fun rs => match rs with
 | [] => false
 | r::_ => p r)
def eventsWitness : Bool := firstCheck (fun r => r.events.value==3)
def recoveryWitness : Bool := firstCheck (fun r => r.recovered.value==2)
def yieldWitness : Bool := firstCheck (fun r => let p := reduced (recovery r);p.1==2 && p.2==3)
def partitionWitness : Bool := check (fun rs => match branchPartition rs with
 | .error _ => false
 | .ok [] => false
 | .ok (p::ps) => ((p::ps).map (fun q => q.1.value)).sum == p.2.value)
def completeWitness : Bool := check (fun rs => rs.length==2)
def successorWitness : Bool := match (do
 let rs ← rows
 let extra ← original 3 2 1
 branchPartition (rs++[extra])) with
 | .ok (p::_) => let q := reduced p;q.1==1 && q.2==2
 | .ok [] | .error _ => false
theorem channelWitnessPassed : channelWitness = true := rfl
theorem daughterWitnessPassed : daughterWitness = true := rfl
theorem eventsWitnessPassed : eventsWitness = true := rfl
theorem recoveryWitnessPassed : recoveryWitness = true := rfl
theorem yieldWitnessPassed : yieldWitness = true := rfl
theorem partitionWitnessPassed : partitionWitness = true := rfl
theorem completeWitnessPassed : completeWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.RadioactiveBranchYield
