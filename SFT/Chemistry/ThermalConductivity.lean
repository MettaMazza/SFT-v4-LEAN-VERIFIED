import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.ThermalConductivity
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- thermal_conductivity_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure ThermalConductionAccount where
 componentIdentities : List HeldLabel
 phaseIdentity : HeldLabel
 sourceCell : PositiveCount
 destinationCell : PositiveCount
 sourceThermalOrder : PositiveCount
 destinationThermalOrder : PositiveCount
 energyPacketSupport : PositiveCount
 transferCount : PositiveCount
 tickCount : PositiveCount
 boundarySupport : PositiveCount
 conditionSupport : List Height
def makeAccount (components : List LabelInput) (phase : LabelInput) (source destination sourceOrder destinationOrder packets transfers ticks boundary : CountInput)
 (conditions : List Height) : Except String ThermalConductionAccount := do
 if components.isEmpty then throw "thermal conduction requires complete component identities"
 let components ← components.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "chemical-component" then pure l else throw "thermal conduction requires complete component identities"
  | .other=>throw "thermal conduction requires complete component identities"
 if !distinctAtoms components then throw "thermal-conduction component identities collapsed"
 let phase ← match phase with
  | .held l=>if Text.equal l.family "chemical-phase" then pure l else throw "thermal conduction lost phase identity"
  | .other=>throw "thermal conduction lost phase identity"
 let counts ← [source,destination,sourceOrder,destinationOrder,packets,transfers,ticks,boundary].mapM fun row=>match row with
  | .count n=>pure n
  | .other=>throw "thermal conduction requires exact positive counts"
 match counts with
 | [source,destination,sourceOrder,destinationOrder,packets,transfers,ticks,boundary]=>
  if source.value+1 != destination.value && destination.value+1 != source.value then
   throw "thermal conduction is not between adjacent generated cells"
  if sourceOrder.value==destinationOrder.value then
   throw "thermal-conduction direction is absent at equal thermal order"
  if conditions.isEmpty || conditions.any (fun c=>match c with | .invalid=>true | .ratio _ | .emptyOne | .otherEmptyOne _ => false) then
   throw "thermal-conduction condition carrier is incomplete"
  pure ⟨components,phase,source,destination,sourceOrder,destinationOrder,packets,transfers,ticks,boundary,conditions⟩
 | [] | [_] | [_,_] | [_,_,_] | [_,_,_,_] | [_,_,_,_,_] | [_,_,_,_,_,_] | [_,_,_,_,_,_,_] | _::_::_::_::_::_::_::_::_::_ => throw "thermal conduction requires exact positive counts"
inductive AccountInput where
 | account (value : ThermalConductionAccount)
 | other
structure CountedThermalConductivityRelation where
 carrier : HeldLabel
 orientation : HeldLabel
 transferResponse : Ratio
def forcedThermalConductivity (input : AccountInput) : Except String CountedThermalConductivityRelation := do
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "thermal conductivity requires a complete account"
 let mixture := match a.componentIdentities.length with | 1=>"pure" | 2=>"binary" | 3=>"ternary" | 0 | _+4 => "higher-component"
 let carrier ← heldLabel "thermal-conductivity-chemical-carrier" (Text.append mixture "-composition-phase-energy-packet-transfer")
 let higher := a.sourceThermalOrder.value>a.destinationThermalOrder.value
 let orientation : HeldLabel := if higher then
   ⟨"thermal-transfer-orientation","source-higher-to-destination-lower-thermal-order",rfl,rfl⟩
  else ⟨"thermal-transfer-orientation","destination-higher-to-source-lower-thermal-order",rfl,rfl⟩
 let separation := if higher then a.sourceThermalOrder.value-a.destinationThermalOrder.value
  else a.destinationThermalOrder.value-a.sourceThermalOrder.value
 let numerator ← count (a.energyPacketSupport.value*a.transferCount.value)
 let denominator ← count (a.tickCount.value*a.boundarySupport.value*separation)
 pure ⟨carrier,orientation,⟨numerator,denominator⟩⟩
def externalThermalConductivityMagnitude (input : InscriptionInput) : Except String Ratio :=
 match SolvationDissolution.exactSolubilityCapacity input with
 | .ok r=>.ok r
 | .error e=>if Text.equal e "solubility capacity requires an exact positive external inscription" then
   .error "thermal conductivity requires exact positive external support"
  else .error "thermal conductivity is not exact positive finite support"
def commonTransferReplicationPreservesRelation (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k=>pure k
  | .other=>throw "thermal-conduction replication requires exact positive support"
 let prior ← forcedThermalConductivity input
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "thermal conductivity requires a complete account"
 let multiply := fun (n : PositiveCount)=>(⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩ : PositiveCount)
 let next ← makeAccount (a.componentIdentities.map MolecularFormationEnergy.LabelInput.held) (.held a.phaseIdentity)
  (.count a.sourceCell) (.count a.destinationCell) (.count a.sourceThermalOrder) (.count a.destinationThermalOrder) (.count a.energyPacketSupport) (.count (multiply a.transferCount))
  (.count (multiply a.tickCount)) (.count a.boundarySupport) a.conditionSupport
 let after ← forcedThermalConductivity (.account next)
 pure (equalLabel after.carrier prior.carrier && equalLabel after.orientation prior.orientation &&
  after.transferResponse.numerator.value*prior.transferResponse.denominator.value==prior.transferResponse.numerator.value*after.transferResponse.denominator.value)
def witnessAccount (componentCount : Int := 2) (reverse : Bool := false) : Except String ThermalConductionAccount := do
 let components ← (List.range componentCount.toNat).mapM fun i=>heldLabel "chemical-component" (Text.append "component-" (toString (i+1)))
 makeAccount (components.map MolecularFormationEnergy.LabelInput.held) (.held ⟨"chemical-phase","liquid",rfl,rfl⟩)
  (.count ⟨4,by decide⟩) (.count ⟨5,by decide⟩)
  (.count (if reverse then ⟨3,by decide⟩ else ⟨7,by decide⟩)) (.count (if reverse then ⟨7,by decide⟩ else ⟨3,by decide⟩))
  (.count ⟨5,by decide⟩) (.count ⟨11,by decide⟩) (.count ⟨7,by decide⟩) (.count ⟨2,by decide⟩)
  [.ratio ⟨⟨29815,by decide⟩,⟨100,by decide⟩⟩,.emptyOne]
def classesWitness : Except String Bool := do
 let results ← ([1,2,3] : List Int).mapM fun n=>do
  let a ← witnessAccount n
  forcedThermalConductivity (.account a)
 pure ((results.zip ["pure-composition-phase-energy-packet-transfer","binary-composition-phase-energy-packet-transfer","ternary-composition-phase-energy-packet-transfer"]).all fun (r,label)=>Text.equal r.carrier.label label)
def orientationWitness : Except String Bool := do
 let forward ← witnessAccount 2 false
 let reverse ← witnessAccount 2 true
 let a ← forcedThermalConductivity (.account forward)
 let b ← forcedThermalConductivity (.account reverse)
 pure (Text.equal a.orientation.label "source-higher-to-destination-lower-thermal-order" && Text.equal b.orientation.label "destination-higher-to-source-lower-thermal-order")
def densityWitness : Except String Bool := do
 let a ← witnessAccount
 let r ← forcedThermalConductivity (.account a)
 pure (r.transferResponse.numerator.value*56==55*r.transferResponse.denominator.value)
def successorWitness : Except String Bool := do
 let a ← witnessAccount 3
 commonTransferReplicationPreservesRelation (.account a) (.count ⟨6,by decide⟩)
theorem threeClasses : classesWitness=.ok true := rfl
theorem thermalOrientations : orientationWitness=.ok true := rfl
theorem exactTransferResponse : densityWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.ThermalConductivity
