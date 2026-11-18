import SFT.Chemistry.MolecularDipoleMagnitude
import SFT.Physics.CommonScaleAxisProofs
namespace SFT.Chemistry.MolecularPolarizability
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
open SFT.Foundation.ExactOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
-- V3 PositiveRatio.from_pair applied to the normalized result of Fraction arithmetic.
def normalizedRatio (n d : Nat) (hn : 0<n) (hd : 0<d) : Ratio :=
 let p := normalizePositive n d hn hd
 ⟨⟨p.numerator,p.positive⟩,⟨p.denominator,Nat.pos_of_ne_zero p.denominatorNonzero⟩⟩
structure Component where
 axis : HeldLabel
 induced : Ratio
 electric : Ratio
def component (axis : HeldLabel) (induced electric : Height) : Except String Component := do
 if !Text.equal axis.family "molecular-response-axis" then throw "polarizability component requires a held molecular axis"
 let induced ← match induced with
  | .ratio r => pure r
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "induced dipole distinction must be exact and positive"
 let electric ← match electric with
  | .ratio r => pure r
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "electric distinction must be exact and positive"
 pure ⟨axis,induced,electric⟩
def exactResponse (c : Component) : Ratio :=
 normalizedRatio (c.induced.numerator.value*c.electric.denominator.value)
  (c.induced.denominator.value*c.electric.numerator.value)
  (Nat.mul_pos c.induced.numerator.positive c.electric.denominator.positive)
  (Nat.mul_pos c.induced.denominator.positive c.electric.numerator.positive)
inductive ComponentInput where
 | component (value : Component)
 | invalid
inductive CountInput where
 | count (value : PositiveCount)
 | invalid
def repeatedEqualFieldResponse (input : ComponentInput) (times : CountInput) : Except String Component :=
 match input with
 | .invalid => .error "response repetition requires a component and positive count"
 | .component c => match times with
  | .invalid => .error "response repetition requires a component and positive count"
  | .count k => .ok ⟨c.axis,
    normalizedRatio (c.induced.numerator.value*k.value) c.induced.denominator.value
     (Nat.mul_pos c.induced.numerator.positive k.positive) c.induced.denominator.positive,
    normalizedRatio (c.electric.numerator.value*k.value) c.electric.denominator.value
     (Nat.mul_pos c.electric.numerator.positive k.positive) c.electric.denominator.positive⟩
inductive ComponentsInput where
 | tuple (values : List ComponentInput)
 | other
def exactIsotropicResponse (input : ComponentsInput) : Except String Ratio := do
 let values ← match input with
  | .other => throw "isotropic response requires complete three-axis support"
  | .tuple values => pure values
 if values.length != 3 then throw "isotropic response requires complete three-axis support"
 let cs ← values.mapM fun v => match v with
  | .component c => pure c
  | .invalid => throw "isotropic response contains an invalid component"
 match cs with
 | [a,b,c] =>
  if equalLabel a.axis b.axis || equalLabel a.axis c.axis || equalLabel b.axis c.axis then
   throw "each molecular response axis must occur exactly once"
  let x := exactResponse a
  let y := exactResponse b
  let z := exactResponse c
  let xy := normalizedRatio
   (x.numerator.value*y.denominator.value+y.numerator.value*x.denominator.value)
   (x.denominator.value*y.denominator.value)
   (Nat.add_pos_left (Nat.mul_pos x.numerator.positive y.denominator.positive) _)
   (Nat.mul_pos x.denominator.positive y.denominator.positive)
  let xyz := normalizedRatio
   (xy.numerator.value*z.denominator.value+z.numerator.value*xy.denominator.value)
   (xy.denominator.value*z.denominator.value)
   (Nat.add_pos_left (Nat.mul_pos xy.numerator.positive z.denominator.positive) _)
   (Nat.mul_pos xy.denominator.positive z.denominator.positive)
  pure (normalizedRatio xyz.numerator.value (xyz.denominator.value*3)
   xyz.numerator.positive (Nat.mul_pos xyz.denominator.positive (by decide)))
 | [] | [_] | [_,_] | _::_::_::_::_ => throw "isotropic response requires complete three-axis support"
structure Carrier where
 species : HeldLabel
 state : HeldLabel
 conformation : HeldLabel
 field : HeldLabel
 definition : HeldLabel
 method : HeldLabel
 condition : HeldLabel
 units : HeldLabel
def validateCarrier (c : Carrier) : Except String Carrier := do
 if !([(c.species,"molecular-species"),(c.state,"molecular-state"),
   (c.conformation,"molecular-conformation"),(c.field,"external-electric-distinction"),
   (c.definition,"polarizability-definition"),(c.method,"measurement-method"),
   (c.condition,"measurement-condition"),(c.units,"measurement-unit")].all
    fun (value,family) => Text.equal value.family family) then
  throw "molecular polarizability carrier erased a required held field"
 pure c
-- Source _witnesses, retained without substituting these examples for the general law.
def axisA : HeldLabel := ⟨"molecular-response-axis","a",rfl,rfl⟩
def axisB : HeldLabel := ⟨"molecular-response-axis","b",rfl,rfl⟩
def axisC : HeldLabel := ⟨"molecular-response-axis","c",rfl,rfl⟩
def witnessComponent : Component := ⟨axisA,⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩
def firstComponent : Component := ⟨axisA,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩,⟨⟨1,by decide⟩,⟨1,by decide⟩⟩⟩
def secondComponent : Component := ⟨axisB,⟨⟨6,by decide⟩,⟨1,by decide⟩⟩,⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩
def thirdComponent : Component := ⟨axisC,⟨⟨12,by decide⟩,⟨1,by decide⟩⟩,⟨⟨3,by decide⟩,⟨1,by decide⟩⟩⟩
def ratioPair (r : Ratio) : Nat × Nat := (r.numerator.value,r.denominator.value)
theorem responseWitness : ratioPair (exactResponse witnessComponent)=(3,1) := rfl
theorem repetitionWitness : (repeatedEqualFieldResponse (.component witnessComponent) (.count ⟨5,by decide⟩)).map
 (fun c => ratioPair (exactResponse c))=.ok (3,1) := rfl
theorem isotropicWitness : (exactIsotropicResponse (.tuple [.component firstComponent,.component secondComponent,.component thirdComponent])).map ratioPair=.ok (3,1) := rfl
theorem incompleteWitness : exactIsotropicResponse (.tuple [.component firstComponent,.component secondComponent])=
 .error "isotropic response requires complete three-axis support" := rfl
theorem duplicateWitness : exactIsotropicResponse (.tuple [.component firstComponent,.component firstComponent,.component thirdComponent])=
 .error "each molecular response axis must occur exactly once" := rfl
end SFT.Chemistry.MolecularPolarizability
