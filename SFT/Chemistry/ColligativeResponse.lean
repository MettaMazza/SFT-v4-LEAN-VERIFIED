import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.ColligativeResponse
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- colligative_response_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
inductive CountInput where
 | count (value : PositiveCount)
 | other
structure ColligativeParticleAccount where
 solventIdentity : HeldLabel
 soluteIdentity : HeldLabel
 responseClass : HeldLabel
 compositionCoordinate : Height
 solventTransmissionSupport : PositiveCount
 soluteRetentionSupport : PositiveCount
def responseOrientation (name : String) : Option HeldLabel :=
 if Text.equal name "boiling" then some ⟨"colligative-orientation","temperature-support-expanded-until-liquid-gas-balance",rfl,rfl⟩
 else if Text.equal name "freezing" then some ⟨"colligative-orientation","temperature-support-reduced-until-liquid-crystal-balance",rfl,rfl⟩
 else if Text.equal name "osmotic" then some ⟨"colligative-orientation","pressure-support-directed-toward-solute-holding-solution",rfl,rfl⟩
 else none
def makeAccount (solvent solute response : LabelInput) (composition : Height)
 (solventSupport soluteSupport : CountInput) : Except String ColligativeParticleAccount := do
 let solvent ← match solvent with
  | .held l => if Text.equal l.family "chemical-component" then pure l else throw "colligative account lost solvent identity"
  | .other => throw "colligative account lost solvent identity"
 let solute ← match solute with
  | .held l => if Text.equal l.family "chemical-component" then pure l else throw "colligative account lost solute identity"
  | .other => throw "colligative account lost solute identity"
 if equalLabel solvent solute then throw "colligative account requires distinct solvent and solute identities"
 let response ← match response with
  | .held l =>
   if Text.equal l.family "colligative-response" && (responseOrientation l.label).isSome then pure l
   else throw "colligative response class is not generated"
  | .other => throw "colligative response class is not generated"
 match composition with
 | .invalid => throw "colligative composition requires an exact positive ratio or structural EmptyOne"
 | .ratio _ | .emptyOne | .otherEmptyOne _ => pure ()
 let (solventSupport,soluteSupport) ← match solventSupport,soluteSupport with
  | .count a,.count b => pure (a,b)
  | .other,.other | .other,.count _ | .count _,.other => throw "colligative boundary requires exact positive particle support"
 pure ⟨solvent,solute,response,composition,solventSupport,soluteSupport⟩
inductive AccountInput where
 | account (value : ColligativeParticleAccount)
 | other
structure ColligativeOrientation where
 relation : HeldLabel
 compositionBoundary : Height
def forcedColligativeOrientation (input : AccountInput) : Except String ColligativeOrientation := do
 let a ← match input with
  | .account a => pure a
  | .other => throw "colligative orientation requires a complete particle account"
 match a.compositionCoordinate with
 | .emptyOne | .otherEmptyOne _ => pure ⟨⟨"colligative-orientation","pure-solvent-reference",rfl,rfl⟩,.emptyOne⟩
 | .ratio _ | .invalid =>
  match responseOrientation a.responseClass.label with
  | some relation => pure ⟨relation,a.compositionCoordinate⟩
  | none => throw "colligative response class is not generated"
structure ExactResponseSeparation where
 orientation : HeldLabel
 separation : Height
def exactResponseSeparation (reference response : Height) : Except String ExactResponseSeparation := do
 let (a,b) ← match reference,response with
  | .ratio a,.ratio b => pure (fraction a,fraction b)
  | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_
  | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid => throw "response separation requires two exact positive supports"
 if a.numerator*b.denominator==b.numerator*a.denominator then
  pure ⟨⟨"response-order","coincident",rfl,rfl⟩,.emptyOne⟩
 else if lower : a.numerator*b.denominator<b.numerator*a.denominator then
  pure ⟨⟨"response-order","response-expanded-from-reference",rfl,rfl⟩,.ratio (rawRatio (LeptonTake.heldRemainder b a lower))⟩
 else if higher : b.numerator*a.denominator<a.numerator*b.denominator then
  pure ⟨⟨"response-order","response-reduced-from-reference",rfl,rfl⟩,.ratio (rawRatio (LeptonTake.heldRemainder a b higher))⟩
 else throw "an SFT count must be a positive counted value"
def commonParticleReplicationPreservesOrientation (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k => pure k
  | .other => throw "particle replication requires exact positive support"
 let prior ← forcedColligativeOrientation input
 let a ← match input with
  | .account a => pure a
  | .other => throw "colligative orientation requires a complete particle account"
 let multiply := fun (n : PositiveCount) => (⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩ : PositiveCount)
 let next ← makeAccount (.held a.solventIdentity) (.held a.soluteIdentity) (.held a.responseClass)
  a.compositionCoordinate (.count (multiply a.solventTransmissionSupport)) (.count (multiply a.soluteRetentionSupport))
 let after ← forcedColligativeOrientation (.account next)
 pure (equalLabel after.relation prior.relation)
def exactResponseReplicationPreservesOrder (reference response : Height) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k => pure k
  | .other => throw "response replication requires exact positive support"
 let prior ← exactResponseSeparation reference response
 let multiply := fun (r : Ratio) => (⟨⟨r.numerator.value*k.value,Nat.mul_pos r.numerator.positive k.positive⟩,r.denominator⟩ : Ratio)
 let (a,b) ← match reference,response with
  | .ratio a,.ratio b => pure (multiply a,multiply b)
  | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_
  | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid => throw "response separation requires two exact positive supports"
 let after ← exactResponseSeparation (.ratio a) (.ratio b)
 pure (equalLabel after.orientation prior.orientation)
def account (response : HeldLabel) (present : Bool := true) : ColligativeParticleAccount :=
 ⟨⟨"chemical-component","solvent",rfl,rfl⟩,⟨"chemical-component","solute",rfl,rfl⟩,response,
  if present then .ratio ⟨⟨1,by decide⟩,⟨5,by decide⟩⟩ else .emptyOne,⟨7,by decide⟩,⟨3,by decide⟩⟩
def boiling : HeldLabel := ⟨"colligative-response","boiling",rfl,rfl⟩
def freezing : HeldLabel := ⟨"colligative-response","freezing",rfl,rfl⟩
def osmotic : HeldLabel := ⟨"colligative-response","osmotic",rfl,rfl⟩
def orientationsWitness : Except String Bool := do
 let results ← [boiling,freezing,osmotic].mapM fun label => forcedColligativeOrientation (.account (account label))
 pure (match results with
  | [a,b,c] => Text.equal a.relation.label "temperature-support-expanded-until-liquid-gas-balance" &&
    Text.equal b.relation.label "temperature-support-reduced-until-liquid-crystal-balance" &&
    Text.equal c.relation.label "pressure-support-directed-toward-solute-holding-solution"
  | [] | [_] | [_,_] | _::_::_::_::_ => false)
def absenceWitness : Except String Bool := do
 let a ← forcedColligativeOrientation (.account (account boiling false))
 pure (Text.equal a.relation.label "pure-solvent-reference" && match a.compositionBoundary with | .emptyOne => true | .ratio _ | .otherEmptyOne _ | .invalid => false)
def reference : Height := .ratio ⟨⟨7,by decide⟩,⟨3,by decide⟩⟩
def response : Height := .ratio ⟨⟨8,by decide⟩,⟨3,by decide⟩⟩
def separationWitness : Except String Bool := do
 let s ← exactResponseSeparation reference response
 pure (Text.equal s.orientation.label "response-expanded-from-reference" && match s.separation with
  | .ratio r => r.numerator.value*3==r.denominator.value
  | .emptyOne | .otherEmptyOne _ | .invalid => false)
def successorWitness : Except String Bool := do
 let particle ← commonParticleReplicationPreservesOrientation (.account (account osmotic)) (.count ⟨6,by decide⟩)
 let separation ← exactResponseReplicationPreservesOrder reference response (.count ⟨6,by decide⟩)
 pure (particle && separation)
theorem threeOrientations : orientationsWitness=.ok true := rfl
theorem pureSolvent : absenceWitness=.ok true := rfl
theorem exactSeparation : separationWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.ColligativeResponse
