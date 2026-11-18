import SFT.Chemistry.DihedralTorsion
import SFT.Physics.AlphaRatio
namespace SFT.Chemistry.IntermolecularBinding
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def exactBindingTake (separated bound : Height) : Except String Ratio :=
 match separated with
 | .emptyOne | .otherEmptyOne _ | .invalid => .error "intermolecular binding requires two exact positive state heights"
 | .ratio h => match bound with
  | .emptyOne | .otherEmptyOne _ | .invalid => .error "intermolecular binding requires two exact positive state heights"
  | .ratio l => match barrierTake (.ratio h) (.ratio l) with
   | .ok value => .ok value
   | .error _ => .error "binding Take requires a strictly higher separated constituent state"
inductive StatesInput where
 | tuple (values : List Height)
 | other
def exactSeparatedState (input : StatesInput) : Except String Ratio := do
 let states ← match input with
  | .other => throw "an intermolecular separated state requires at least two constituents"
  | .tuple values => if values.length<2 then throw "an intermolecular separated state requires at least two constituents" else pure values
 let ratios ← states.mapM fun state => match state with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "every separated constituent state must be an exact positive ratio"
 match ratios with
 | [] => throw "an intermolecular separated state requires at least two constituents"
 | first::rest => pure (rawRatio (rest.foldl AlphaRatio.add first))
def appendSharedConstituentPreservesBinding (separated bound appended : Height) : Except String Bool := do
 let original ← exactBindingTake separated bound
 let extra ← match appended with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "an appended constituent state must be exact and positive"
 match separated,bound with
 | .ratio h,.ratio l =>
  let newSeparated := rawRatio (AlphaRatio.add (fraction h) extra)
  let newBound := rawRatio (AlphaRatio.add (fraction l) extra)
  let extended ← exactBindingTake (.ratio newSeparated) (.ratio newBound)
  pure (equalHeight (.ratio extended) (.ratio original))
 | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ => throw "intermolecular binding requires two exact positive state heights"
 | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid => throw "intermolecular binding requires two exact positive state heights"
def repeatedUnitBinding (separated bound : Height) (repetition : CountInput) : Except String Ratio := do
 let k ← match repetition with
  | .count k => pure k
  | .other => throw "state repetition requires a positive count"
 let h ← match separated with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ => throw "'EmptyOne' object has no attribute 'fraction'"
  | .invalid => throw "'NoneType' object has no attribute 'fraction'"
 let l ← match bound with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ => throw "'EmptyOne' object has no attribute 'fraction'"
  | .invalid => throw "'NoneType' object has no attribute 'fraction'"
 let multiplier := AlphaRatio.whole k.value k.positive
 exactBindingTake (.ratio (rawRatio (BoundaryGrowth.multiply h multiplier)))
  (.ratio (rawRatio (BoundaryGrowth.multiply l multiplier)))
def unboundInteractionForm : Height := .emptyOne
inductive ConstituentsInput where
 | tuple (values : List HeldLabel)
 | other
structure Carrier where
 constituents : ConstituentsInput
 constituentStates : List HeldLabel
 boundComposite : HeldLabel
 boundCompositeState : HeldLabel
 separationOrganization : HeldLabel
 interactionChannel : HeldLabel
 condition : HeldLabel
 energyUnit : HeldLabel
def validateCarrier (c : Carrier) : Except String Carrier := do
 let constituents ← match c.constituents with
  | .other => throw "intermolecular binding requires at least two named constituents"
  | .tuple values => if values.length<2 then throw "intermolecular binding requires at least two named constituents" else pure values
 if constituents.length != c.constituentStates.length then throw "each constituent must retain one named state"
 if !distinctAtoms constituents then throw "constituent identities must remain distinguishable"
 if !(constituents.all fun value => Text.equal value.family "molecular-constituent") then
  throw "a constituent identity was erased or relabelled"
 if !(c.constituentStates.all fun value => Text.equal value.family "constituent-state") then
  throw "a constituent state was erased or relabelled"
 if !([(c.boundComposite,"bound-composite"),(c.boundCompositeState,"bound-composite-state"),
  (c.separationOrganization,"finite-separation-organization"),(c.interactionChannel,"intermolecular-channel"),
  (c.condition,"measurement-condition"),(c.energyUnit,"held-energy-unit")].all
  fun (value,family) => Text.equal value.family family) then
  throw "intermolecular binding carrier lost a required held field"
 pure c
theorem bindingTakeExact (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 exactBindingTake (.ratio higher) (.ratio lower)=
 .ok (rawRatio (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered)) := by
 dsimp only [exactBindingTake]
 rw [barrierTakeExact higher lower ordered]
theorem bindingMagnitude (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 ((fraction higher).numerator*(fraction lower).denominator-(fraction lower).numerator*(fraction higher).denominator)*
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).denominator=
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).numerator*
 ((fraction higher).denominator*(fraction lower).denominator) := barrierMagnitude higher lower ordered
theorem bindingReassembles (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 ((fraction higher).numerator*(fraction lower).denominator-(fraction lower).numerator*(fraction higher).denominator)+
 (fraction lower).numerator*(fraction higher).denominator=(fraction higher).numerator*(fraction lower).denominator :=
 LeptonTake.heldPartReassembles (fraction higher) (fraction lower) ordered
def firstConstituent : Height := .ratio ⟨⟨5,by decide⟩,⟨2,by decide⟩⟩
def secondConstituent : Height := .ratio ⟨⟨7,by decide⟩,⟨3,by decide⟩⟩
def separated : Height := .ratio ⟨⟨29,by decide⟩,⟨6,by decide⟩⟩
def bound : Height := .ratio ⟨⟨4,by decide⟩,⟨1,by decide⟩⟩
def appended : Height := .ratio ⟨⟨11,by decide⟩,⟨5,by decide⟩⟩
def ratioPair (r : Ratio) : Nat × Nat := (r.numerator.value,r.denominator.value)
theorem compositionWitness : (exactSeparatedState (.tuple [firstConstituent,secondConstituent])).map ratioPair=.ok (29,6) := rfl
theorem bindingWitness : (exactBindingTake separated bound).map ratioPair=.ok (5,6) := rfl
theorem orientationWitness : exactBindingTake bound separated=.error "binding Take requires a strictly higher separated constituent state" := rfl
theorem extensionWitness : appendSharedConstituentPreservesBinding separated bound appended=.ok true := rfl
theorem repetitionWitness : (repeatedUnitBinding separated bound (.count ⟨3,by decide⟩)).map ratioPair=.ok (5,2) := rfl
theorem unboundWitness : unboundInteractionForm=.emptyOne := rfl
end SFT.Chemistry.IntermolecularBinding
