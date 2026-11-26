import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.MolecularDiffusion
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- molecular_diffusion_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure MolecularDiffusionAccount where
 migratingIdentity : HeldLabel
 constituentIdentities : List HeldLabel
 diffusionClass : HeldLabel
 phaseIdentity : HeldLabel
 sourceCell : PositiveCount
 destinationCell : PositiveCount
 transitionCount : PositiveCount
 tickCount : PositiveCount
 conditionSupport : List Height
def makeAccount (migrating : LabelInput) (constituents : List LabelInput) (className phase : LabelInput)
 (source destination transitions ticks : CountInput) (conditions : List Height) : Except String MolecularDiffusionAccount := do
 let migrating ← match migrating with
  | .held l=>if Text.equal l.family "chemical-component" then pure l else throw "diffusion account lost migrating identity"
  | .other=>throw "diffusion account lost migrating identity"
 if constituents.isEmpty then throw "diffusion account requires complete constituent identities"
 let constituents ← constituents.mapM fun row=>match row with
  | .held l=>if Text.equal l.family "chemical-component" then pure l else throw "diffusion account requires complete constituent identities"
  | .other=>throw "diffusion account requires complete constituent identities"
 if !distinctAtoms constituents || !(constituents.any (equalLabel migrating)) then
  throw "migrating identity is not uniquely retained in the constituent carrier"
 let className ← match className with
  | .held l=>if Text.equal l.family "diffusion-class" && ["binary","self","tracer"].any (Text.equal l.label) then pure l else throw "diffusion class is not generated"
  | .other=>throw "diffusion class is not generated"
 let phase ← match phase with
  | .held l=>if Text.equal l.family "chemical-phase" then pure l else throw "diffusion account lost phase identity"
  | .other=>throw "diffusion account lost phase identity"
 let counts ← [source,destination,transitions,ticks].mapM fun row=>match row with
  | .count n=>pure n
  | .other=>throw "diffusion cells, transitions and ticks require exact positive counts"
 match counts with
 | [source,destination,transitions,ticks]=>
  if source.value+1 != destination.value && destination.value+1 != source.value then
   throw "diffusion transition is not between adjacent generated cells"
  if conditions.isEmpty || conditions.any (fun c=>match c with | .invalid=>true | .ratio _ | .emptyOne | .otherEmptyOne _ => false) then
   throw "diffusion condition carrier is incomplete"
  pure ⟨migrating,constituents,className,phase,source,destination,transitions,ticks,conditions⟩
 | [] | [_] | [_,_] | [_,_,_] | _::_::_::_::_::_ => throw "diffusion cells, transitions and ticks require exact positive counts"
inductive AccountInput where
 | account (value : MolecularDiffusionAccount)
 | other
structure CountedDiffusionRelation where
 carrier : HeldLabel
 orientation : HeldLabel
 transitionDensity : Ratio
def forcedCountedDiffusion (input : AccountInput) : Except String CountedDiffusionRelation := do
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "diffusion requires a complete molecular account"
 let carrier ← heldLabel "molecular-diffusion-carrier" (Text.append a.diffusionClass.label "-identity-retained-adjacent-transition")
 let orientation : HeldLabel := if a.sourceCell.value<a.destinationCell.value then
   ⟨"diffusion-orientation","toward-later-generated-cell",rfl,rfl⟩
  else ⟨"diffusion-orientation","toward-earlier-generated-cell",rfl,rfl⟩
 pure ⟨carrier,orientation,⟨a.transitionCount,a.tickCount⟩⟩
def externalDiffusionMagnitude (input : InscriptionInput) : Except String Ratio :=
 match SolvationDissolution.exactSolubilityCapacity input with
 | .ok r=>.ok r
 | .error e=>if Text.equal e "solubility capacity requires an exact positive external inscription" then
   .error "diffusion coefficient requires exact positive external support"
  else .error "diffusion coefficient is not exact positive finite support"
def completeConstituentConservation (before after : List LabelInput) : Except String Bool := do
 if before.isEmpty || after.isEmpty then throw "constituent conservation requires complete held labels"
 let decode := fun (rows : List LabelInput)=>rows.mapM fun row=>match row with
  | .held l=>Except.ok (l.family,l.label)
  | .other=>Except.error "constituent conservation requires complete held labels"
 let before ← decode before
 let after ← decode after
 let sort := fun (rows : List (String×String))=>Canonical.sortFields ((Canonical.sortFields (rows.map fun (f,l)=>(l,f))).map fun (l,f)=>(f,l))
 let a := sort before
 let b := sort after
 pure (a.length==b.length && (a.zip b).all fun ((f,l),(g,m))=>Text.equal f g && Text.equal l m)
def transitionReplicationPreservesRelation (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k=>pure k
  | .other=>throw "diffusion replication requires exact positive support"
 let prior ← forcedCountedDiffusion input
 let a ← match input with
  | .account a=>pure a
  | .other=>throw "diffusion requires a complete molecular account"
 let multiply := fun (n : PositiveCount)=>(⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩ : PositiveCount)
 let next ← makeAccount (.held a.migratingIdentity) (a.constituentIdentities.map MolecularFormationEnergy.LabelInput.held)
  (.held a.diffusionClass) (.held a.phaseIdentity) (.count a.sourceCell) (.count a.destinationCell)
  (.count (multiply a.transitionCount)) (.count (multiply a.tickCount)) a.conditionSupport
 let after ← forcedCountedDiffusion (.account next)
 pure (equalLabel after.carrier prior.carrier && equalLabel after.orientation prior.orientation &&
  after.transitionDensity.numerator.value*prior.transitionDensity.denominator.value==prior.transitionDensity.numerator.value*after.transitionDensity.denominator.value)
def binary : HeldLabel := ⟨"diffusion-class","binary",rfl,rfl⟩
def self : HeldLabel := ⟨"diffusion-class","self",rfl,rfl⟩
def tracer : HeldLabel := ⟨"diffusion-class","tracer",rfl,rfl⟩
def account (className : HeldLabel := binary) (reverse : Bool := false) : MolecularDiffusionAccount :=
 ⟨⟨"chemical-component","migrant",rfl,rfl⟩,[⟨"chemical-component","migrant",rfl,rfl⟩,⟨"chemical-component","medium",rfl,rfl⟩],
  className,⟨"chemical-phase","liquid",rfl,rfl⟩,
  if reverse then ⟨4,by decide⟩ else ⟨3,by decide⟩,if reverse then ⟨3,by decide⟩ else ⟨4,by decide⟩,
  ⟨7,by decide⟩,⟨5,by decide⟩,[.ratio ⟨⟨29815,by decide⟩,⟨100,by decide⟩⟩,.emptyOne]⟩
def classesWitness : Except String Bool := do
 let results ← [binary,self,tracer].mapM fun c=>forcedCountedDiffusion (.account (account c))
 pure ((results.zip ["binary-identity-retained-adjacent-transition","self-identity-retained-adjacent-transition","tracer-identity-retained-adjacent-transition"]).all fun (r,label)=>Text.equal r.carrier.label label)
def orientationWitness : Except String Bool := do
 let a ← forcedCountedDiffusion (.account (account binary false))
 let b ← forcedCountedDiffusion (.account (account binary true))
 pure (Text.equal a.orientation.label "toward-later-generated-cell" && Text.equal b.orientation.label "toward-earlier-generated-cell")
def densityWitness : Except String Bool := do
 let a ← forcedCountedDiffusion (.account (account binary false))
 pure (a.transitionDensity.numerator.value*5==7*a.transitionDensity.denominator.value)
def conservationWitness := completeConstituentConservation
 ((account binary false).constituentIdentities.map MolecularFormationEnergy.LabelInput.held)
 ((account binary false).constituentIdentities.reverse.map MolecularFormationEnergy.LabelInput.held)
def successorWitness := transitionReplicationPreservesRelation (.account (account tracer)) (.count ⟨6,by decide⟩)
theorem threeClasses : classesWitness=.ok true := rfl
theorem adjacentOrientations : orientationWitness=.ok true := rfl
theorem exactDensity : densityWitness=.ok true := rfl
theorem completeConservation : conservationWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.MolecularDiffusion
