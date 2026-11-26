import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.ElementaryTransitionRate
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- elementary_transition_rate_law_v1.py, pinned 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure ElementaryTransitionAccount where
 reactionIdentity : HeldLabel
 initialState : HeldLabel
 terminalState : HeldLabel
 completedTransitions : PositiveCount
 referenceTicks : PositiveCount
 observationSupport : PositiveCount
 conditions : List Height
def makeAccount (reaction initial terminal : LabelInput) (transitions ticks boundary : CountInput)
 (conditions : List Height) : Except String ElementaryTransitionAccount := do
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "registered-elementary-reaction" then pure l else throw "elementary rate requires one registered reaction identity"
  | .other=>throw "elementary rate requires one registered reaction identity"
 let states ← [initial,terminal].mapM fun row=>match row with
  | .held l=>if Text.equal l.family "molecular-state" then pure l else throw "elementary rate requires distinct retained molecular endpoints"
  | .other=>throw "elementary rate requires distinct retained molecular endpoints"
 match states with
 | [initial,terminal]=>
  if equalLabel initial terminal then throw "elementary rate requires distinct retained molecular endpoints"
  let counts ← [transitions,ticks,boundary].mapM fun row=>match row with
   | .count n=>pure n
   | .other=>throw "elementary rate requires positive exact transition, tick and boundary counts"
  match counts with
  | [transitions,ticks,boundary]=>
   if conditions.isEmpty || conditions.any (fun c=>match c with | .invalid=>true | .emptyOne | .otherEmptyOne _ | .ratio _=>false) then
    throw "elementary rate requires a complete exact condition carrier"
   pure ⟨reaction,initial,terminal,transitions,ticks,boundary,conditions⟩
  | [] | [_] | [_,_] | _::_::_::_::_=>throw "elementary rate requires positive exact transition, tick and boundary counts"
 | [] | [_] | _::_::_::_=>throw "elementary rate requires distinct retained molecular endpoints"
inductive AccountInput where
 | account (value : ElementaryTransitionAccount)
 | other
structure ExactElementaryTransitionRate where
 carrier : HeldLabel
 orientation : HeldLabel
 eventResponse : Ratio
def forcedElementaryTransitionRate (input : AccountInput) : Except String ExactElementaryTransitionRate := do
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "elementary rate requires a complete transition account"
 let carrier ← heldLabel "elementary-rate-carrier" a.reactionIdentity.label
 let orientation ← heldLabel "transition-orientation" (Text.intercalate "-to-" [a.initialState.label,a.terminalState.label])
 pure ⟨carrier,orientation,⟨a.completedTransitions,
  ⟨a.referenceTicks.value*a.observationSupport.value,Nat.mul_pos a.referenceTicks.positive a.observationSupport.positive⟩⟩⟩
def externalRateMagnitude (input : InscriptionInput) : Except String Ratio :=
 match SolvationDissolution.exactSolubilityCapacity input with
 | .ok r=>.ok r
 | .error e=>if Text.equal e "solubility capacity requires an exact positive external inscription" then
   .error "external elementary rate requires exact positive support"
  else .error "external elementary rate is not exact positive finite support"
def commonEventResourceReplicationPreservesRate (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k=>pure k
  | .other=>throw "rate replication requires exact positive support"
 let prior ← forcedElementaryTransitionRate input
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "elementary rate requires a complete transition account"
 let multiply := fun (n : PositiveCount)=>(⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩ : PositiveCount)
 let next ← makeAccount (.held a.reactionIdentity) (.held a.initialState) (.held a.terminalState)
  (.count (multiply a.completedTransitions)) (.count (multiply a.referenceTicks)) (.count a.observationSupport) a.conditions
 let after ← forcedElementaryTransitionRate (.account next)
 pure (equalLabel after.carrier prior.carrier && equalLabel after.orientation prior.orientation &&
  after.eventResponse.numerator.value*prior.eventResponse.denominator.value==prior.eventResponse.numerator.value*after.eventResponse.denominator.value)
def witnessAccount (reverse : Bool := false) : Except String ElementaryTransitionAccount :=
 makeAccount (.held ⟨"registered-elementary-reaction","reaction-one",rfl,rfl⟩)
  (.held (if reverse then ⟨"molecular-state","products",rfl,rfl⟩ else ⟨"molecular-state","reactants",rfl,rfl⟩))
  (.held (if reverse then ⟨"molecular-state","reactants",rfl,rfl⟩ else ⟨"molecular-state","products",rfl,rfl⟩))
  (.count ⟨6,by decide⟩) (.count ⟨4,by decide⟩) (.count ⟨3,by decide⟩)
  [.ratio ⟨⟨638,by decide⟩,⟨1,by decide⟩⟩,.emptyOne]
def responseWitness : Except String Bool := do
 let a ← witnessAccount
 let r ← forcedElementaryTransitionRate (.account a)
 pure (r.eventResponse.numerator.value*2==r.eventResponse.denominator.value)
def orientationWitness : Except String Bool := do
 let a ← witnessAccount false
 let b ← witnessAccount true
 let ra ← forcedElementaryTransitionRate (.account a)
 let rb ← forcedElementaryTransitionRate (.account b)
 pure (!equalLabel ra.orientation rb.orientation)
def absenceWitness : Except String Bool := do
 let a ← witnessAccount
 pure (match (a.conditions.drop 1).head? with | some .emptyOne | some (.otherEmptyOne _)=>true | none | some .invalid | some (.ratio _)=>false)
def successorWitness : Except String Bool := do
 let a ← witnessAccount
 commonEventResourceReplicationPreservesRate (.account a) (.count ⟨7,by decide⟩)
theorem exactResponse : responseWitness=.ok true := rfl
theorem opposedOrientations : orientationWitness=.ok true := rfl
theorem structuralAbsence : absenceWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.ElementaryTransitionRate
