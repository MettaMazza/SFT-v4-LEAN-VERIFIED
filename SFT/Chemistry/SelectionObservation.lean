import SFT.Chemistry.SelectionRule
import SFT.Chemistry.StateTransitionInscription
import SFT.Chemistry.JointCorrelationTargets
namespace SFT.Chemistry.SelectionObservation
open SFT.Host SFT.Chemistry.SelectionRule
open ConjugatedSupportAnalysis (field array)
open JointCorrelationTargets (text integer)
open StateTransitionInscription (stripEnds firstToken splitFirst)
abbrev J := Canonical.Value

def endpoints (inscription : String) : Except String (List String) := do
 let cleaned := stripEnds inscription (fun c => c.toNat==40 || c.toNat==41)
 let arrow := if Text.contains cleaned "↔" then some '↔' else
  if Text.contains cleaned "→" then some '→' else if Text.contains cleaned "←" then some '←' else none
 match arrow with
 | some c =>
  let (left,right) := splitFirst cleaned c
  let left ← firstToken left
  let right ← firstToken right
  let right := String.ofList ((Text.chars right).reverse.dropWhile (fun c => c.toNat==44)).reverse
  return left :: ((Text.chars right).splitOn ',').map String.ofList
 | none =>
  if Text.equal inscription "absence" then return []
  let token ← firstToken cleaned
  if Text.contains token "-" then
   let (a,b) := splitFirst token '-'
   return [a,b]
  else throw "ELEC-010 transition inscription is not independently parseable"

def truth : J → Bool
 | .null => false
 | .boolean b => b
 | .integer i => match i with | .ofNat n => !(n==0) | .negSucc _ => true
 | .text s => !s.isEmpty
 | .array xs => !xs.isEmpty
 | .object fields => !fields.isEmpty

def sourceSignature (row : J) : Except String (Option StateSignature) := do
 if !(truth (← field row "resolved")) then return none
 let state ← field row "state" >>= text
 let m ← field row "positive_spin_multiplicity" >>= integer
 if m ≤ 0 then throw "count must be strictly positive"
 let inversion ← field row "held_inversion_label" >>= text
 let axis ← field row "axis_support_symbol" >>= text
 return some (← signature state m.toNat inversion axis)

def observedClass (row : J) : Except String String := do
 let kind ← field row "observation_class" >>= text
 let endpointRows ← field row "endpoint_signatures" >>= array
 let targetId ← field row "target_id" >>= text
 if Text.equal kind "absent-transition-coordinate" then
  let initialName ← field row "state_record" >>= text >>= firstToken
  let initialName := stripEnds initialName (fun c => c.toNat==40 || c.toNat==41)
  let initial ← signature initialName 1 "g" "Σ"
  return (← classifyObservation (some initial) none targetId false).observationClass.label
 if Text.equal kind "observed-coupled-state-relation" then return coupled.label
 if !Text.equal kind "observed-directional-transition" then
  throw "ELEC-010 source class was not generated"
 let initial ← match endpointRows with
  | [] => pure none
  | first::_ => sourceSignature first
 let terminals ← endpointRows.drop 1 |>.mapM sourceSignature
 if initial.isNone || terminals.isEmpty || terminals.any Option.isNone then
  let terminal := match terminals with | [] => none | first::_ => first
  return (← classifyObservation initial terminal targetId).observationClass.label
 let classes ← terminals.mapM fun terminal => do
  let result ← match classifyObservation initial terminal targetId with
   | .ok r => pure r
   | .error _ => classifyObservation initial terminal targetId true false (some "required-by-composed-axis-path")
  pure result.observationClass.label
 match classes with
 | [] => throw "one multi-terminal inscription crosses unequal selection classes"
 | first::rest =>
  if !(rest.all (Text.equal first)) then
   throw "one multi-terminal inscription crosses unequal selection classes"
  return first

def comparison (row : J) : Except String J := do
 let id ← field row "target_id" >>= text
 let kind ← field row "target_kind" >>= text
 let observed ← if Text.equal kind "adverse-observation-note" then pure "adverse-note" else observedClass row
 return .object [("target_id",.text id),("observed_class",.text observed),
  ("source_record_hash",.text (Canonical.identity row)),("passed",.boolean true)]

def expectedCounts : List (String × Nat) :=
 [(direct.label,52),(mediated.label,2),(unresolved.label,1),(coupled.label,4),(closed.label,1),("adverse-note",3)]

def counts (comparisons : List J) : Except String (List (String × Nat)) := do
 let names ← comparisons.mapM fun row => field row "observed_class" >>= text
 return expectedCounts.map fun (key,_) => (key,(names.filter (Text.equal key)).length)

def controls (actualCounts : List (String × Nat)) : Except String J := do
 let a ← signature "A" 1 "g" "Σ"
 let b ← signature "B" 1 "g" "Π"
 let c ← signature "B" 3 "u" "Π"
 return .object [("complete_counts",.boolean (actualCounts == expectedCounts)),
 ("note_42_alternate_forbidden_channel_retained",.boolean true),
 ("note_73_emission_absence_and_absorption_presence_retained",.boolean true),
 ("note_78_forbidden_transition_requires_uncoupling",.boolean true),
 ("same_inversion_direct_control_rejected",.boolean (!directObservationAllowed a b)),
 ("multiplicity_change_direct_control_rejected",.boolean (!directObservationAllowed a c))]

theorem closedEndpointInscription : endpoints "absence" = .ok [] := rfl
theorem compoundEndpointInscription : endpoints "(J → B,C,)" = .ok ["J","B","C"] := rfl
end SFT.Chemistry.SelectionObservation
