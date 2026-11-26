import SFT.Chemistry.SequentialMechanism
namespace SFT.Chemistry.ReactionDynamicsScattering
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SequentialMechanism
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure RetainedIncomingReactionChannel where
 channelIdentity : HeldLabel
 reactionIdentity : HeldLabel
 orderedIncomingCarriers : List HeldLabel
 preparationIdentity : HeldLabel
def makeIncoming (identity reaction : LabelInput) (carriers : List LabelInput) (preparation : LabelInput) : Except String RetainedIncomingReactionChannel := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-incoming-reaction-channel" then pure l else throw "incoming reaction channel must be registered"
  | .other=>throw "incoming reaction channel must be registered"
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "held-scattering-reaction-identity" then pure l else throw "reaction identity must remain held"
  | .other=>throw "reaction identity must remain held"
 if carriers.length<2 then throw "scattering requires finite retained incoming carrier support"
 let carriers ← carriers.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "held-incoming-channel-carrier" then pure l else throw "scattering requires finite retained incoming carrier support"
  | .other=>throw "scattering requires finite retained incoming carrier support"
 if (carriers.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != carriers.length then throw "incoming channel carriers must remain distinct and ordered"
 let preparation ← match preparation with
  | .held l=>if Text.equal l.family "held-incoming-preparation" then pure l else throw "incoming preparation must remain held"
  | .other=>throw "incoming preparation must remain held"
 pure ⟨identity,reaction,carriers,preparation⟩
structure RetainedOutgoingProductState where
 sourceOccurrence : PositiveCount
 channelIdentity : HeldLabel
 reactionIdentity : HeldLabel
 orderedProductCarriers : List HeldLabel
 orderedProductStates : List HeldLabel
 orientationToIncoming : HeldLabel
 completedEvents : PositiveCount
 evidenceStatus : HeldLabel
def makeOutgoing (source : SequentialMechanism.CountInput) (identity reaction : LabelInput) (carriers states : List LabelInput) (orientation : LabelInput) (events : SequentialMechanism.CountInput) (status : LabelInput) : Except String RetainedOutgoingProductState := do
 let source ← match source with
  | .count v=>pure v
  | .other=>throw "product-state occurrence must be exact positive"
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-outgoing-product-channel" then pure l else throw "outgoing product channel must be registered"
  | .other=>throw "outgoing product channel must be registered"
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "held-scattering-reaction-identity" then pure l else throw "outgoing reaction identity must remain held"
  | .other=>throw "outgoing reaction identity must remain held"
 if carriers.length<2 || carriers.length != states.length then throw "outgoing channel requires a complete joint product-state tuple"
 let carriers ← carriers.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "held-outgoing-product-carrier" then pure l else throw "outgoing product carriers and states must remain held"
  | .other=>throw "outgoing product carriers and states must remain held"
 let states ← states.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "held-outgoing-product-state" then pure l else throw "outgoing product carriers and states must remain held"
  | .other=>throw "outgoing product carriers and states must remain held"
 if (carriers.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != carriers.length then throw "outgoing product carriers must remain distinct and ordered"
 let orientation ← match orientation with
  | .held l=>if Text.equal l.family "held-incoming-outgoing-orientation" then pure l else throw "scattering orientation must remain a held relation"
  | .other=>throw "scattering orientation must remain a held relation"
 let events ← match events with
  | .count v=>pure v
  | .other=>throw "retained product-state events must be exact positive"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-scattering-evidence-status" then pure l else throw "product-state evidence status must remain held"
  | .other=>throw "product-state evidence status must remain held"
 pure ⟨source,identity,reaction,carriers,states,orientation,events,status⟩
inductive IncomingInput where
 | incoming (value : RetainedIncomingReactionChannel)
 | other
inductive OutgoingInput where
 | outgoing (value : RetainedOutgoingProductState)
 | other
structure CompleteFiniteProductStateSupport where
 incomingChannel : RetainedIncomingReactionChannel
 orderedOutgoingStates : List RetainedOutgoingProductState
def equalWord (a b : List HeldLabel) : Bool := a.length==b.length && (a.zip b).all (fun (x,y)=>equalLabel x y)
def equalStateWord (a b : RetainedOutgoingProductState) : Bool :=
 equalLabel a.channelIdentity b.channelIdentity && equalWord a.orderedProductCarriers b.orderedProductCarriers &&
 equalWord a.orderedProductStates b.orderedProductStates && equalLabel a.orientationToIncoming b.orientationToIncoming
def makeSupport (incoming : IncomingInput) (states : List OutgoingInput) : Except String CompleteFiniteProductStateSupport := do
 let incoming ← match incoming with
  | .incoming i=>pure i
  | .other=>throw "scattering support requires one retained incoming channel"
 if states.isEmpty then throw "scattering support requires finite positive outgoing support"
 let states ← states.mapM fun state=>match state with
  | .outgoing s=>pure s
  | .other=>throw "scattering support requires finite positive outgoing support"
 if !(states.zipIdx.all fun (s,i)=>s.sourceOccurrence.value==i+1) then throw "outgoing product-state support must be complete and gap-free"
 if states.any (fun s=> !equalLabel s.reactionIdentity incoming.reactionIdentity) then throw "incoming and outgoing channels must retain one reaction identity"
 if (states.foldl (fun found s=>if found.any (equalStateWord s) then found else found++[s]) []).length != states.length then
  throw "complete outgoing support cannot duplicate a joint product-state orientation"
 pure ⟨incoming,states⟩
structure ExactProductStateScatteringRecord where
 incomingChannelIdentity : HeldLabel
 outgoingChannelIdentity : HeldLabel
 orderedProductCarriers : List HeldLabel
 orderedProductStates : List HeldLabel
 orientationToIncoming : HeldLabel
 exactEventShare : Rat
 evidenceStatus : HeldLabel
inductive FractionInput where
 | fraction (value : Rat)
 | other
def makeScatteringRecord (incoming outgoing : HeldLabel) (carriers states : List HeldLabel) (orientation : HeldLabel) (share : FractionInput) (status : HeldLabel) : Except String ExactProductStateScatteringRecord := do
 let share ← match share with
  | .fraction q=>pure q
  | .other=>throw "product-state scattering share must be exact positive"
 if share.num ≤ 0 then throw "product-state scattering share must be exact positive"
 pure ⟨incoming,outgoing,carriers,states,orientation,share,status⟩
inductive SupportInput where
 | support (value : CompleteFiniteProductStateSupport)
 | other
def forcedReactionScatteringProductStateLaw (input : SupportInput) : Except String (List ExactProductStateScatteringRecord) := do
 let support ← match input with
  | .support s=>pure s
  | .other=>throw "reaction scattering law requires complete finite channel support"
 let total ← count (support.orderedOutgoingStates.foldl (fun n s=>n+s.completedEvents.value) 0)
 support.orderedOutgoingStates.mapM fun state=>
  makeScatteringRecord support.incomingChannel.channelIdentity state.channelIdentity state.orderedProductCarriers state.orderedProductStates
   state.orientationToIncoming (.fraction (LeptonIntervals.normalize (.ofNat state.completedEvents.value) total.value total.positive)) state.evidenceStatus
structure RegisteredScatteringOccurrence where
 sourceOccurrence : PositiveCount
 support : CompleteFiniteProductStateSupport
def makeOccurrence (source : SequentialMechanism.CountInput) (input : SupportInput) : Except String RegisteredScatteringOccurrence := do
 let source ← match source with
  | .count v=>pure v
  | .other=>throw "scattering occurrence must be exact positive"
 let _ ← forcedReactionScatteringProductStateLaw input
 let support ← match input with
  | .support s=>pure s
  | .other=>throw "reaction scattering law requires complete finite channel support"
 pure ⟨source,support⟩
inductive OccurrenceInput where
 | occurrence (value : RegisteredScatteringOccurrence)
 | other
structure CompleteScatteringFamily where
 orderedOccurrences : List RegisteredScatteringOccurrence
def makeFamily (rows : List OccurrenceInput) : Except String CompleteScatteringFamily := do
 if rows.isEmpty then throw "scattering family requires at least one complete occurrence"
 let rows ← rows.mapM fun row=>match row with
  | .occurrence o=>pure o
  | .other=>throw "scattering family requires at least one complete occurrence"
 if !(rows.zipIdx.all fun (o,i)=>o.sourceOccurrence.value==i+1) then throw "scattering occurrences must be complete and gap-free"
 pure ⟨rows⟩
def equalResult (a b : ExactProductStateScatteringRecord) : Bool :=
 equalLabel a.incomingChannelIdentity b.incomingChannelIdentity && equalLabel a.outgoingChannelIdentity b.outgoingChannelIdentity &&
 equalWord a.orderedProductCarriers b.orderedProductCarriers && equalWord a.orderedProductStates b.orderedProductStates &&
 equalLabel a.orientationToIncoming b.orientationToIncoming && (@decide (a.exactEventShare.num=b.exactEventShare.num) (Int.decEq _ _)) && a.exactEventShare.den==b.exactEventShare.den && equalLabel a.evidenceStatus b.evidenceStatus
def equalResults (a b : List ExactProductStateScatteringRecord) : Bool := a.length==b.length && (a.zip b).all (fun (x,y)=>equalResult x y)
def appendScatteringOccurrencePreservesCompleteFamily (family : CompleteScatteringFamily) (successor : RegisteredScatteringOccurrence) : Except String Bool := do
 if successor.sourceOccurrence.value != family.orderedOccurrences.length+1 then throw "scattering successor must be the next positive occurrence"
 let prior ← family.orderedOccurrences.mapM fun row=>forcedReactionScatteringProductStateLaw (.support row.support)
 let extended ← makeFamily ((family.orderedOccurrences++[successor]).map OccurrenceInput.occurrence)
 let results ← extended.orderedOccurrences.mapM fun row=>forcedReactionScatteringProductStateLaw (.support row.support)
 let retained := results.take prior.length
 pure (retained.length==prior.length && (retained.zip prior).all (fun (a,b)=>equalResults a b) && results.length==prior.length+1)
def witnessIncoming (label : String := "incoming-a") : Except String RetainedIncomingReactionChannel := do
 makeIncoming (.held (← heldLabel "registered-incoming-reaction-channel" label)) (.held ⟨"held-scattering-reaction-identity","reaction-a",rfl,rfl⟩)
  [.held ⟨"held-incoming-channel-carrier","reactant-a",rfl,rfl⟩,.held ⟨"held-incoming-channel-carrier","reactant-b",rfl,rfl⟩]
  (.held ⟨"held-incoming-preparation","preparation-a",rfl,rfl⟩)
def witnessOutgoing (occurrence : PositiveCount) (orientation : String) (events : PositiveCount) : Except String RetainedOutgoingProductState := do
 let label := toString occurrence.value
 makeOutgoing (.count occurrence) (.held (← heldLabel "registered-outgoing-product-channel" (Text.append "outgoing-" label)))
  (.held ⟨"held-scattering-reaction-identity","reaction-a",rfl,rfl⟩)
  [.held ⟨"held-outgoing-product-carrier","product-a",rfl,rfl⟩,.held ⟨"held-outgoing-product-carrier","product-b",rfl,rfl⟩]
  [.held (← heldLabel "held-outgoing-product-state" (Text.append "state-a-" label)),.held (← heldLabel "held-outgoing-product-state" (Text.append "state-b-" label))]
  (.held (← heldLabel "held-incoming-outgoing-orientation" orientation)) (.count events) (.held ⟨"held-scattering-evidence-status","retained",rfl,rfl⟩)
def base : Except String CompleteFiniteProductStateSupport := do
 makeSupport (.incoming (← witnessIncoming)) [.outgoing (← witnessOutgoing ⟨1,by decide⟩ "same-oriented" ⟨3,by decide⟩),
  .outgoing (← witnessOutgoing ⟨2,by decide⟩ "transverse-oriented" ⟨2,by decide⟩),.outgoing (← witnessOutgoing ⟨3,by decide⟩ "opposed-oriented" ⟨1,by decide⟩)]
def finiteSupportWitness : Except String Bool := do
 let results ← forcedReactionScatteringProductStateLaw (.support (← base))
 let words := results.map ExactProductStateScatteringRecord.orderedProductStates
 pure (results.length==3 && (words.foldl (fun found w=>if found.any (equalWord w) then found else found++[w]) []).length==3)
def exactSharesWitness : Except String Bool := do
 let results ← forcedReactionScatteringProductStateLaw (.support (← base))
 pure (results.length==3 && (results.zip [(1,2),(1,3),(1,6)]).all (fun (r,(n,d))=>(@decide (r.exactEventShare.num=n) (Int.decEq _ _)) && r.exactEventShare.den==d))
def orientationWitness : Except String Bool := do
 let results ← forcedReactionScatteringProductStateLaw (.support (← base))
 pure (results.length==3 && (results.zip ["same-oriented","transverse-oriented","opposed-oriented"]).all (fun (r,l)=>Text.equal r.orientationToIncoming.label l))
def successorWitness : Except String Bool := do
 let support ← base
 let prior ← makeOccurrence (.count ⟨1,by decide⟩) (.support support)
 let family ← makeFamily [.occurrence prior]
 let successor ← makeOccurrence (.count ⟨2,by decide⟩) (.support support)
 appendScatteringOccurrencePreservesCompleteFamily family successor
theorem finiteSupport : finiteSupportWitness=.ok true := rfl
theorem exactShares : exactSharesWitness=.ok true := rfl
theorem heldOrientation : orientationWitness=.ok true := rfl
theorem completeSuccessorFamily : successorWitness=.ok true := rfl
end SFT.Chemistry.ReactionDynamicsScattering
