import SFT.Chemistry.InternalEnergyComposition
import SFT.Physics.LeptonDecimal
namespace SFT.Chemistry.SolvationDissolution
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- solvation_dissolution_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure SolvationDissolutionAccount where
 soluteIdentity : HeldLabel
 solventIdentities : List HeldLabel
 sourceState : HeldLabel
 destinationState : HeldLabel
 conditionSupport : Height
def makeAccount (solute : LabelInput) (solvents : List LabelInput) (source destination : LabelInput)
 (condition : Height) : Except String SolvationDissolutionAccount := do
 let solute ← match solute with
  | .held l => if Text.equal l.family "chemical-component" then pure l else throw "solvation account lost solute identity"
  | .other => throw "solvation account lost solute identity"
 if solvents.isEmpty then throw "solvation account requires at least one held solvent identity"
 let solvents ← solvents.mapM fun row=>match row with
  | .held l => if Text.equal l.family "chemical-component" then pure l else throw "solvation account requires at least one held solvent identity"
  | .other => throw "solvation account requires at least one held solvent identity"
 if !distinctAtoms solvents || solvents.any (equalLabel solute) then throw "solute and solvent identities must remain distinct"
 let source ← match source with
  | .held l => if Text.equal l.family "chemical-state" then pure l else throw "solvation account lost source state"
  | .other => throw "solvation account lost source state"
 let destination ← match destination with
  | .held l => if Text.equal l.family "chemical-state" then pure l else throw "solvation account lost destination state"
  | .other => throw "solvation account lost destination state"
 if equalLabel source destination then throw "transfer requires distinct source and destination states"
 match condition with
 | .invalid => throw "condition is neither exact positive support nor structural EmptyOne"
 | .ratio _ | .emptyOne | .otherEmptyOne _ => pure ⟨solute,solvents,source,destination,condition⟩
structure ExactFreeOrder where
 orientation : HeldLabel
 magnitude : Height
inductive InscriptionInput where
 | text (value : String)
 | other
-- Exact string domain of the original Fraction call in the pinned execution runtime.
-- Unicode decimal digits, optional sign/decimal/exponent or integer ratio are retained.
def strip (cs : List Char) : List Char := LeptonDecimal.trimCodes (LeptonDecimal.intSpaceCodes++[28,29,30,31]) cs
def signedNumerator (negative : Bool) (n : Nat) : Int :=
 if negative then match n with | 0 => .ofNat 0 | k+1 => .negSucc k else .ofNat n
def fractionInscription (text : String) : Except String Rat := do
 let cs := strip (Text.chars text)
 let (negative,body) := match cs with | [] => (false,[]) | c::xs => if c=='-' then (true,xs) else if c=='+' then (false,xs) else (false,cs)
 match LeptonDecimal.split '/' body with
 | [a,b] =>
  let n ← (match LeptonDecimal.digits a with | some n => Except.ok n | none => .error "invalid fraction")
  let d ← (match LeptonDecimal.digits b with | some n => Except.ok n | none => .error "invalid fraction")
  if h : 0<d then pure (LeptonIntervals.normalize (signedNumerator negative n) d h)
  else throw "invalid fraction"
 | [_] =>
  let parts := LeptonDecimal.split 'e' (body.map fun c=>if c=='E' then 'e' else c)
  let (mantissa,expNegative,exponent) ← match parts with
   | [m] => pure (m,false,0)
   | [m,e] => do
    let (neg,ds) := match e with | [] => (false,[]) | c::xs => if c=='-' then (true,xs) else if c=='+' then (false,xs) else (false,e)
    let n ← (match LeptonDecimal.digits ds with | some n => Except.ok n | none => .error "invalid fraction")
    pure (m,neg,n)
   | [] | _::_::_::_ => throw "invalid fraction"
  let (n,places) ← match LeptonDecimal.split '.' mantissa with
   | [whole] => do
    let n ← (match LeptonDecimal.digits whole with | some n => Except.ok n | none => .error "invalid fraction")
    pure (n,0)
   | [whole,decimal] => do
    if whole.isEmpty && decimal.isEmpty then throw "invalid fraction"
    let n ← (match LeptonDecimal.digits (whole++decimal) with | some n => Except.ok n | none => .error "invalid fraction")
    pure (n,decimal.length)
   | [] | _::_::_::_ => throw "invalid fraction"
  if expNegative then pure (LeptonIntervals.normalize (signedNumerator negative n) (10^(places+exponent)) (Nat.pow_pos (by decide)))
  else pure (LeptonIntervals.normalize (signedNumerator negative (n*10^exponent)) (10^places) (Nat.pow_pos (by decide)))
 | [] | _::_::_::_ => throw "invalid fraction"
def positiveRatio (r : Rat) : Except String Ratio := do
 match r.num with
 | .negSucc _ => throw "an SFT count must be a positive counted value"
 | .ofNat n =>
  let n ← count n
  let d ← count r.den
  pure ⟨n,d⟩
def externalOrderAsFoldRelation (input : InscriptionInput) : Except String ExactFreeOrder := do
 let chars ← match input with
  | .other => throw "external order inscription is absent"
  | .text text =>
   let cs := strip (Text.chars text)
   if cs.isEmpty then throw "external order inscription is absent"
   pure cs
 let cs := match chars with | [] => [] | c::rest => if c=='+' then rest else chars
 let (negative,body) := match cs with | [] => (false,[]) | c::rest => if c=='-' then (true,rest) else (false,cs)
 let r ← match fractionInscription (String.ofList body) with
  | .ok r => pure r
  | .error _ => throw "external order inscription is not exact finite decimal support"
 if @decide (r.num=0) (Int.decEq _ _) then
  pure ⟨⟨"free-order","coincident-state-support",rfl,rfl⟩,.emptyOne⟩
 else
  let magnitude ← match positiveRatio r with
   | .ok r => pure r
   | .error _ => throw "external order inscription is not exact finite decimal support"
  if negative then pure ⟨⟨"free-order","destination-solution-retained",rfl,rfl⟩,.ratio magnitude⟩
  else pure ⟨⟨"free-order","source-separated-state-retained",rfl,rfl⟩,.ratio magnitude⟩
inductive AccountInput where
 | account (value : SolvationDissolutionAccount)
 | other
def forcedTransferCarrier (input : AccountInput) : Except String HeldLabel := do
 let a ← match input with
  | .account a => pure a
  | .other => throw "transfer carrier requires a complete account"
 let mixed := a.solventIdentities.length>1
 let reference := match a.conditionSupport with | .emptyOne | .otherEmptyOne _ => true | .ratio _ | .invalid => false
 if mixed then
  if reference then pure ⟨"solvation-dissolution-carrier","distinct-solute-mixed-solvent-reference-condition-state-transfer",rfl,rfl⟩
  else pure ⟨"solvation-dissolution-carrier","distinct-solute-mixed-solvent-condition-bound-state-transfer",rfl,rfl⟩
 else
  if reference then pure ⟨"solvation-dissolution-carrier","distinct-solute-single-solvent-reference-condition-state-transfer",rfl,rfl⟩
  else pure ⟨"solvation-dissolution-carrier","distinct-solute-single-solvent-condition-bound-state-transfer",rfl,rfl⟩
def exactSolubilityCapacity (input : InscriptionInput) : Except String Ratio := do
 let chars ← match input with
  | .other => throw "solubility capacity requires an exact positive external inscription"
  | .text text =>
   let cs := strip (Text.chars text)
   if cs.isEmpty || cs.head?==some '-' then throw "solubility capacity requires an exact positive external inscription"
   pure cs
 let chars := chars.dropWhile (fun c=>c=='+')
 match fractionInscription (String.ofList chars) >>= positiveRatio with
 | .ok r => pure r
 | .error _ => throw "solubility capacity is not exact positive finite support"
inductive CountInput where
 | count (value : PositiveCount)
 | other
def commonSupportReplicationPreservesCarrier (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let k ← match replication with
  | .count k => pure k
  | .other => throw "replication requires exact positive support"
 let prior ← forcedTransferCarrier input
 let a ← match input with
  | .account a => pure a
  | .other => throw "transfer carrier requires a complete account"
 let condition := match a.conditionSupport with
  | .ratio r => Height.ratio ⟨⟨r.numerator.value*k.value,Nat.mul_pos r.numerator.positive k.positive⟩,r.denominator⟩
  | .emptyOne => .emptyOne
  | .otherEmptyOne tag => .otherEmptyOne tag
  | .invalid => .invalid
 let after ← makeAccount (.held a.soluteIdentity) (a.solventIdentities.map MolecularFormationEnergy.LabelInput.held)
  (.held a.sourceState) (.held a.destinationState) condition
 let carrier ← forcedTransferCarrier (.account after)
 pure (equalLabel carrier prior)
def account (mixed reference : Bool := false) : SolvationDissolutionAccount :=
 ⟨⟨"chemical-component","solute",rfl,rfl⟩,
  [⟨"chemical-component","solvent-a",rfl,rfl⟩]++(if mixed then [⟨"chemical-component","solvent-b",rfl,rfl⟩] else []),
  ⟨"chemical-state","separated",rfl,rfl⟩,⟨"chemical-state","solution",rfl,rfl⟩,
  if reference then .emptyOne else .ratio ⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩
def carriersWitness : Except String Bool := do
 let single ← forcedTransferCarrier (.account (account false false))
 let mixed ← forcedTransferCarrier (.account (account true false))
 pure ((Text.chars "distinct-solute-single-solvent").isPrefixOf (Text.chars single.label) &&
  (Text.chars "distinct-solute-mixed-solvent").isPrefixOf (Text.chars mixed.label))
def orderWitness : Except String Bool := do
 let favorable ← externalOrderAsFoldRelation (.text "-2.49")
 let opposed ← externalOrderAsFoldRelation (.text "1.23")
 pure (Text.equal favorable.orientation.label "destination-solution-retained" && Text.equal opposed.orientation.label "source-separated-state-retained" &&
  (match favorable.magnitude with | .ratio _ => true | .emptyOne | .otherEmptyOne _ | .invalid => false) && (match opposed.magnitude with | .ratio _ => true | .emptyOne | .otherEmptyOne _ | .invalid => false))
def absenceWitness : Except String Bool := do
 let a ← externalOrderAsFoldRelation (.text "0")
 pure (Text.equal a.orientation.label "coincident-state-support" && match a.magnitude with | .emptyOne => true | .ratio _ | .otherEmptyOne _ | .invalid => false)
def capacityWitness : Except String Bool := do
 let c ← exactSolubilityCapacity (.text "0.00015")
 pure (c.numerator.value>0)
def successorWitness := commonSupportReplicationPreservesCarrier (.account (account false false)) (.count ⟨5,by decide⟩)
theorem singleAndMixedCarriers : carriersWitness=.ok true := rfl
theorem heldFreeOrder : orderWitness=.ok true := rfl
theorem structuralAbsence : absenceWitness=.ok true := rfl
theorem positiveCapacity : capacityWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.SolvationDissolution
