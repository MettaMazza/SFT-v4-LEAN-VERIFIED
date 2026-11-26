import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.CoupledTransport
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- coupled_transport_law_v1.py, pinned 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure CoupledTransportAccount where
 componentIdentities : List HeldLabel
 phaseIdentity : HeldLabel
 carrierIdentities : List HeldLabel
 sourceCell : PositiveCount
 destinationCell : PositiveCount
 carrierPacketSupport : List PositiveCount
 sharedTransitionCount : PositiveCount
 tickCount : PositiveCount
 boundarySupport : PositiveCount
 conditionSupport : List Height
def makeAccount (components : List LabelInput) (phase : LabelInput) (carriers : List LabelInput)
 (source destination : CountInput) (packets : List CountInput) (transitions ticks boundary : CountInput)
 (conditions : List Height) : Except String CoupledTransportAccount := do
 if components.isEmpty then throw "coupled transport requires distinct complete component identities"
 let components ← components.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "chemical-component" then pure l else throw "coupled transport requires distinct complete component identities"
  | .other=>throw "coupled transport requires distinct complete component identities"
 if !distinctAtoms components then throw "coupled transport requires distinct complete component identities"
 let phase ← match phase with
  | .held l=>if Text.equal l.family "chemical-phase" then pure l else throw "coupled transport lost phase identity"
  | .other=>throw "coupled transport lost phase identity"
 if carriers.length != 3 then throw "coupled transport requires the complete ordered mass/heat/charge carrier triad"
 let carriers ← carriers.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "transport-carrier" then pure l else throw "coupled transport requires the complete ordered mass/heat/charge carrier triad"
  | .other=>throw "coupled transport requires the complete ordered mass/heat/charge carrier triad"
 if !((carriers.zip ["mass","heat","charge"]).all fun (l,name)=>Text.equal l.label name) then
  throw "coupled transport requires the complete ordered mass/heat/charge carrier triad"
 let counts ← [source,destination,transitions,ticks,boundary].mapM fun row=>match row with
  | .count n=>pure n
  | .other=>throw "coupled transport requires exact positive transition resources"
 match counts with
 | [source,destination,transitions,ticks,boundary]=>
  if source.value+1 != destination.value && destination.value+1 != source.value then throw "coupled transport is not adjacent"
  if packets.length != 3 then throw "coupled transport lost a carrier packet ledger"
  let packets ← packets.mapM fun row=>match row with
   | .count n=>pure n
   | .other=>throw "coupled transport lost a carrier packet ledger"
  if conditions.isEmpty || conditions.any (fun c=>match c with | .invalid=>true | .emptyOne | .otherEmptyOne _ | .ratio _=>false) then
   throw "coupled transport condition carrier is incomplete"
  pure ⟨components,phase,carriers,source,destination,packets,transitions,ticks,boundary,conditions⟩
 | [] | [_] | [_,_] | [_,_,_] | [_,_,_,_] | _::_::_::_::_::_::_=>throw "coupled transport requires exact positive transition resources"
inductive AccountInput where
 | account (value : CoupledTransportAccount)
 | other
structure CountedCoupledTransportRelation where
 carrierTopology : HeldLabel
 orientations : List HeldLabel
 responseSupport : List Ratio
 pairwiseProjections : List HeldLabel
def forcedCoupledTransport (input : AccountInput) : Except String CountedCoupledTransportRelation := do
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "coupled transport requires a complete account"
 let direction := if a.sourceCell.value<a.destinationCell.value then "source-to-destination" else "destination-to-source"
 let mixture := match a.componentIdentities.length with | 1=>"pure" | 2=>"binary" | 3=>"ternary" | 0 | _+4=>"higher-component"
 let orientations ← a.carrierIdentities.mapM fun c=>heldLabel "transport-orientation" (Text.intercalate ":" [c.label,direction])
 let responses := a.carrierPacketSupport.map fun p=>(⟨
  ⟨p.value*a.sharedTransitionCount.value,Nat.mul_pos p.positive a.sharedTransitionCount.positive⟩,
  ⟨a.tickCount.value*a.boundarySupport.value,Nat.mul_pos a.tickCount.positive a.boundarySupport.positive⟩⟩ : Ratio)
 let topology ← heldLabel "coupled-transport-topology" (Text.append mixture "-composition-phase-shared-mass-heat-charge-event-ledger")
 pure ⟨topology,orientations,responses,[⟨"coupled-carrier-projection","mass-heat",rfl,rfl⟩,
  ⟨"coupled-carrier-projection","mass-charge",rfl,rfl⟩,⟨"coupled-carrier-projection","heat-charge",rfl,rfl⟩]⟩
def commonEventReplicationPreservesRelation (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k=>pure k
  | .other=>throw "coupled-transport replication requires exact positive support"
 let prior ← forcedCoupledTransport input
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "coupled transport requires a complete account"
 let multiply := fun (n : PositiveCount)=>(⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩ : PositiveCount)
 let next ← makeAccount (a.componentIdentities.map MolecularFormationEnergy.LabelInput.held) (.held a.phaseIdentity)
  (a.carrierIdentities.map MolecularFormationEnergy.LabelInput.held) (.count a.sourceCell) (.count a.destinationCell)
  (a.carrierPacketSupport.map SolvationDissolution.CountInput.count) (.count (multiply a.sharedTransitionCount))
  (.count (multiply a.tickCount)) (.count a.boundarySupport) a.conditionSupport
 let after ← forcedCoupledTransport (.account next)
 pure (equalLabel after.carrierTopology prior.carrierTopology && equalLabels after.orientations prior.orientations &&
  equalLabels after.pairwiseProjections prior.pairwiseProjections && after.responseSupport.length==prior.responseSupport.length &&
  (after.responseSupport.zip prior.responseSupport).all fun (x,y)=>x.numerator.value*y.denominator.value==y.numerator.value*x.denominator.value)
def witnessAccount (componentCount : Int := 2) (reverse : Bool := false) : Except String CoupledTransportAccount := do
 let components ← (List.range componentCount.toNat).mapM fun i=>heldLabel "chemical-component" (Text.append "component-" (toString (i+1)))
 makeAccount (components.map MolecularFormationEnergy.LabelInput.held) (.held ⟨"chemical-phase","liquid",rfl,rfl⟩)
  [.held ⟨"transport-carrier","mass",rfl,rfl⟩,.held ⟨"transport-carrier","heat",rfl,rfl⟩,.held ⟨"transport-carrier","charge",rfl,rfl⟩]
  (.count (if reverse then ⟨5,by decide⟩ else ⟨4,by decide⟩)) (.count (if reverse then ⟨4,by decide⟩ else ⟨5,by decide⟩))
  [.count ⟨2,by decide⟩,.count ⟨3,by decide⟩,.count ⟨5,by decide⟩] (.count ⟨7,by decide⟩) (.count ⟨11,by decide⟩) (.count ⟨2,by decide⟩)
  [.ratio ⟨⟨29815,by decide⟩,⟨100,by decide⟩⟩,.emptyOne]
def triadWitness : Except String Bool := do
 let a ← witnessAccount
 pure (a.carrierIdentities.length==3 && (a.carrierIdentities.zip ["mass","heat","charge"]).all fun (x,y)=>Text.equal x.label y)
def projectionsWitness : Except String Bool := do
 let a ← witnessAccount
 let r ← forcedCoupledTransport (.account a)
 pure (r.pairwiseProjections.length==3 && (r.pairwiseProjections.zip ["mass-heat","mass-charge","heat-charge"]).all fun (x,y)=>Text.equal x.label y)
def orientationWitness : Except String Bool := do
 let forward ← witnessAccount 2 false
 let reverse ← witnessAccount 2 true
 let a ← forcedCoupledTransport (.account forward)
 let b ← forcedCoupledTransport (.account reverse)
 pure (!equalLabels a.orientations b.orientations)
def responsesWitness : Except String Bool := do
 let a ← witnessAccount
 let r ← forcedCoupledTransport (.account a)
 pure (r.responseSupport.length==3 && (r.responseSupport.zip [14,21,35]).all fun (x,n)=>x.numerator.value*22==n*x.denominator.value)
def successorWitness : Except String Bool := do
 let a ← witnessAccount 3
 commonEventReplicationPreservesRelation (.account a) (.count ⟨6,by decide⟩)
theorem completeTriad : triadWitness=.ok true := rfl
theorem completeProjections : projectionsWitness=.ok true := rfl
theorem opposedOrientations : orientationWitness=.ok true := rfl
theorem exactResponses : responsesWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.CoupledTransport
