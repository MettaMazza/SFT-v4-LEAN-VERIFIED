import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.ViscousTransport
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- viscous_transport_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure ViscousChemicalAccount where
 componentIdentities : List HeldLabel
 phaseIdentity : HeldLabel
 sourceLayer : PositiveCount
 destinationLayer : PositiveCount
 momentumPacketSupport : PositiveCount
 exchangeCount : PositiveCount
 tickCount : PositiveCount
 conditionSupport : List Height
def makeAccount (components : List LabelInput) (phase : LabelInput) (source destination packets exchanges ticks : CountInput)
 (conditions : List Height) : Except String ViscousChemicalAccount := do
 if components.isEmpty then throw "viscous account requires complete component identities"
 let components ← components.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "chemical-component" then pure l else throw "viscous account requires complete component identities"
  | .other=>throw "viscous account requires complete component identities"
 if !distinctAtoms components then throw "viscous component identities collapsed"
 let phase ← match phase with
  | .held l=>if Text.equal l.family "chemical-phase" then pure l else throw "viscous account lost phase identity"
  | .other=>throw "viscous account lost phase identity"
 let counts ← [source,destination,packets,exchanges,ticks].mapM fun row=>match row with
  | .count n=>pure n
  | .other=>throw "viscous transport requires exact positive counts"
 match counts with
 | [source,destination,packets,exchanges,ticks]=>
  if source.value+1 != destination.value && destination.value+1 != source.value then
   throw "viscous exchange is not between adjacent generated layers"
  if conditions.isEmpty || conditions.any (fun c=>match c with | .invalid=>true | .ratio _ | .emptyOne | .otherEmptyOne _ => false) then
   throw "viscous condition carrier is incomplete"
  pure ⟨components,phase,source,destination,packets,exchanges,ticks,conditions⟩
 | [] | [_] | [_,_] | [_,_,_] | [_,_,_,_] | _::_::_::_::_::_::_ => throw "viscous transport requires exact positive counts"
inductive AccountInput where
 | account (value : ViscousChemicalAccount)
 | other
structure CountedViscousRelation where
 carrier : HeldLabel
 orientation : HeldLabel
 exchangeDensity : Ratio
def forcedViscousTransport (input : AccountInput) : Except String CountedViscousRelation := do
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "viscous transport requires a complete account"
 let mixture := match a.componentIdentities.length with | 1=>"pure" | 2=>"binary" | 3=>"ternary" | 0 | _+4 => "higher-component"
 let carrier ← heldLabel "viscous-chemical-carrier" (Text.append mixture "-composition-retained-momentum-exchange")
 let orientation : HeldLabel := if a.sourceLayer.value<a.destinationLayer.value then
   ⟨"viscous-orientation","toward-later-generated-layer",rfl,rfl⟩
  else ⟨"viscous-orientation","toward-earlier-generated-layer",rfl,rfl⟩
 pure ⟨carrier,orientation,⟨⟨a.momentumPacketSupport.value*a.exchangeCount.value,Nat.mul_pos a.momentumPacketSupport.positive a.exchangeCount.positive⟩,a.tickCount⟩⟩
def externalViscosityMagnitude (input : InscriptionInput) : Except String Ratio :=
 match SolvationDissolution.exactSolubilityCapacity input with
 | .ok r=>.ok r
 | .error e=>if Text.equal e "solubility capacity requires an exact positive external inscription" then
   .error "viscosity requires exact positive external support"
  else .error "viscosity is not exact positive finite support"
def commonExchangeReplicationPreservesRelation (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k=>pure k
  | .other=>throw "viscous replication requires exact positive support"
 let prior ← forcedViscousTransport input
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "viscous transport requires a complete account"
 let multiply := fun (n : PositiveCount)=>(⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩ : PositiveCount)
 let next ← makeAccount (a.componentIdentities.map MolecularFormationEnergy.LabelInput.held) (.held a.phaseIdentity)
  (.count a.sourceLayer) (.count a.destinationLayer) (.count a.momentumPacketSupport) (.count (multiply a.exchangeCount))
  (.count (multiply a.tickCount)) a.conditionSupport
 let after ← forcedViscousTransport (.account next)
 pure (equalLabel after.carrier prior.carrier && equalLabel after.orientation prior.orientation &&
  after.exchangeDensity.numerator.value*prior.exchangeDensity.denominator.value==prior.exchangeDensity.numerator.value*after.exchangeDensity.denominator.value)
def witnessAccount (componentCount : Int := 2) (reverse : Bool := false) : Except String ViscousChemicalAccount := do
 let components ← (List.range componentCount.toNat).mapM fun i=>heldLabel "chemical-component" (Text.append "component-" (toString (i+1)))
 makeAccount (components.map MolecularFormationEnergy.LabelInput.held) (.held ⟨"chemical-phase","liquid",rfl,rfl⟩)
  (.count (if reverse then ⟨5,by decide⟩ else ⟨4,by decide⟩)) (.count (if reverse then ⟨4,by decide⟩ else ⟨5,by decide⟩))
  (.count ⟨3,by decide⟩) (.count ⟨7,by decide⟩) (.count ⟨5,by decide⟩)
  [.ratio ⟨⟨29815,by decide⟩,⟨100,by decide⟩⟩,.emptyOne]
def classesWitness : Except String Bool := do
 let results ← ([1,2,3] : List Int).mapM fun n=>do
  let a ← witnessAccount n
  forcedViscousTransport (.account a)
 pure ((results.zip ["pure-composition-retained-momentum-exchange","binary-composition-retained-momentum-exchange","ternary-composition-retained-momentum-exchange"]).all fun (r,label)=>Text.equal r.carrier.label label)
def orientationWitness : Except String Bool := do
 let forward ← witnessAccount 2 false
 let reverse ← witnessAccount 2 true
 let a ← forcedViscousTransport (.account forward)
 let b ← forcedViscousTransport (.account reverse)
 pure (Text.equal a.orientation.label "toward-later-generated-layer" && Text.equal b.orientation.label "toward-earlier-generated-layer")
def densityWitness : Except String Bool := do
 let a ← witnessAccount
 let r ← forcedViscousTransport (.account a)
 pure (r.exchangeDensity.numerator.value*5==21*r.exchangeDensity.denominator.value)
def successorWitness : Except String Bool := do
 let a ← witnessAccount 3
 commonExchangeReplicationPreservesRelation (.account a) (.count ⟨6,by decide⟩)
theorem threeClasses : classesWitness=.ok true := rfl
theorem adjacentOrientations : orientationWitness=.ok true := rfl
theorem exactDensity : densityWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.ViscousTransport
