import SFT.Chemistry.VibrationalFrequency
import SFT.Chemistry.ElectronCountSpin
namespace SFT.Chemistry.MolecularMagneticResponse
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
inductive LabelInput where
 | held (value : HeldLabel)
 | other
def inFamily (input : LabelInput) (family : String) : Bool := match input with
 | .held value => Text.equal value.family family
 | .other => false
def validOrientations (a b : HeldLabel) : Bool :=
 Text.equal a.family "magnetic-orientation" && Text.equal b.family "magnetic-orientation" && !equalLabel a b
def responseOrientation (a : HeldLabel) : HeldLabel :=
 ⟨"magnetic-response-orientation",a.label,rfl,a.labelHeld⟩
def balancedOrientation : HeldLabel := ⟨"magnetic-response-orientation","balanced-closed",rfl,rfl⟩
structure Response where
 orientation : HeldLabel
 magnitude : ElectronCountSpin.CountOrEmpty
def exactOrientationExcess (sideA sideB : CountInput) (orientationA orientationB : LabelInput) : Except String Response :=
 match sideA,sideB with
 | .other,_ | .count _,.other => .error "magnetic support requires two positive counts"
 | .count a,.count b => match orientationA,orientationB with
  | .other,_ | .held _,.other => .error "two distinct held magnetic orientations are required"
  | .held oa,.held ob =>
   if !validOrientations oa ob then .error "two distinct held magnetic orientations are required"
   else if equal : a.value=b.value then .ok ⟨balancedOrientation,.emptyOne "empty-One"⟩
   else if above : b.value<a.value then
    .ok ⟨responseOrientation oa,.count ⟨a.value-b.value,SFT.Foundation.ExactCast.subtractPositive _ _ above⟩⟩
   else
    .ok ⟨responseOrientation ob,.count ⟨b.value-a.value,SFT.Foundation.ExactCast.subtractPositive _ _
     (Nat.lt_of_le_of_ne (Nat.le_of_not_gt above) equal)⟩⟩
def exactMomentRatio (response recurrence : CountInput) : Except String Ratio :=
 match response,recurrence with
 | .count n,.count d => .ok ⟨n,d⟩
 | .other,_ | .count _,.other => .error "molecular moment requires two positive counts"
def exactSusceptibilityRatio (response : Height) (fieldActs : CountInput) : Except String Ratio :=
 match response,fieldActs with
 | .ratio r,.count f => .ok ⟨r.numerator,⟨r.denominator.value*f.value,Nat.mul_pos r.denominator.positive f.positive⟩⟩
 | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ | .ratio _,.other =>
  .error "susceptibility requires positive response and field acts"
def sameRational (a b : Ratio) : Bool :=
 Nat.beq (a.numerator.value*b.denominator.value) (b.numerator.value*a.denominator.value)
def repeatedResponsePreservesSusceptibility (response : Height) (fieldActs repetition : CountInput) : Except String Bool := do
 let k ← match repetition with
  | .count k => pure k
  | .other => throw "response repetition requires a positive count"
 let original ← exactSusceptibilityRatio response fieldActs
 match response,fieldActs with
 | .ratio r,.count f =>
  let repeated := ⟨⟨r.numerator.value*k.value,Nat.mul_pos r.numerator.positive k.positive⟩,r.denominator⟩
  let repeatedField := ⟨f.value*k.value,Nat.mul_pos f.positive k.positive⟩
  let result ← exactSusceptibilityRatio (.ratio repeated) (.count repeatedField)
  pure (sameRational result original)
 | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ | .ratio _,.other =>
  throw "susceptibility requires positive response and field acts"
structure Carrier where
 molecule : LabelInput
 molecularState : LabelInput
 angularSupport : LabelInput
 spinSupport : LabelInput
 orbitalSupport : LabelInput
 fieldOrientation : LabelInput
 responseOrientation : LabelInput
 responseUnit : LabelInput
 observationCondition : LabelInput
def validateCarrier (c : Carrier) : Except String Carrier :=
 if !([(c.molecule,"molecular-identity"),(c.molecularState,"molecular-state"),
  (c.angularSupport,"angular-support"),(c.spinSupport,"spin-support"),(c.orbitalSupport,"orbital-support"),
  (c.fieldOrientation,"magnetic-field-orientation"),(c.responseOrientation,"magnetic-response-orientation"),
  (c.responseUnit,"held-magnetic-response-unit"),(c.observationCondition,"measurement-condition")].all
  fun (value,family) => inFamily value family) then
  .error "molecular magnetic carrier lost a required held field"
 else .ok c
theorem momentCountsRetained (n d : PositiveCount) :
 exactMomentRatio (.count n) (.count d)=.ok ⟨n,d⟩ := rfl
theorem susceptibilityCountsRetained (r : Ratio) (f : PositiveCount) :
 exactSusceptibilityRatio (.ratio r) (.count f)=
 .ok ⟨r.numerator,⟨r.denominator.value*f.value,Nat.mul_pos r.denominator.positive f.positive⟩⟩ := rfl
theorem everyPositiveRepetition (r : Ratio) (f k : PositiveCount) :
 repeatedResponsePreservesSusceptibility (.ratio r) (.count f) (.count k)=.ok true := by
 change Except.ok (Nat.beq ((r.numerator.value*k.value)*(r.denominator.value*f.value))
   (r.numerator.value*(r.denominator.value*(f.value*k.value))))=.ok true
 have cross : (r.numerator.value*k.value)*(r.denominator.value*f.value)=
   r.numerator.value*(r.denominator.value*(f.value*k.value)) := by
  exact (SFT.Foundation.FractionReduction.mulAssoc r.numerator.value k.value (r.denominator.value*f.value)).trans
   ((congrArg (fun x => r.numerator.value*x) (CommonScaleAxis.multiplyLeftComm k.value r.denominator.value f.value)).trans
    (congrArg (fun x => r.numerator.value*(r.denominator.value*x)) (Nat.mul_comm k.value f.value)))
 have self (n : Nat) : Nat.beq n n=true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih
 exact congrArg Except.ok ((congrArg (fun n => Nat.beq n
   (r.numerator.value*(r.denominator.value*(f.value*k.value)))) cross).trans
    (self (r.numerator.value*(r.denominator.value*(f.value*k.value)))))
theorem equalOpposedSupportCloses (n : PositiveCount) (oa ob : HeldLabel)
 (valid : validOrientations oa ob=true) :
 exactOrientationExcess (.count n) (.count n) (.held oa) (.held ob)=
 .ok ⟨balancedOrientation,.emptyOne "empty-One"⟩ := by
 unfold exactOrientationExcess
 try dsimp only
 rw [valid]
 try dsimp only
 rw [dif_pos rfl]
 rfl
theorem firstOrientationRetainsExcess (a b : PositiveCount) (oa ob : HeldLabel)
 (valid : validOrientations oa ob=true) (order : b.value<a.value) :
 exactOrientationExcess (.count a) (.count b) (.held oa) (.held ob)=
 .ok ⟨responseOrientation oa,.count ⟨a.value-b.value,SFT.Foundation.ExactCast.subtractPositive _ _ order⟩⟩ := by
 unfold exactOrientationExcess
 try dsimp only
 rw [valid]
 try dsimp only
 rw [dif_neg (Nat.ne_of_gt order),dif_pos order]
 rfl
theorem secondOrientationRetainsExcess (a b : PositiveCount) (oa ob : HeldLabel)
 (valid : validOrientations oa ob=true) (order : a.value<b.value) :
 exactOrientationExcess (.count a) (.count b) (.held oa) (.held ob)=
 .ok ⟨responseOrientation ob,.count ⟨b.value-a.value,SFT.Foundation.ExactCast.subtractPositive _ _ order⟩⟩ := by
 unfold exactOrientationExcess
 try dsimp only
 rw [valid]
 try dsimp only
 rw [dif_neg (Nat.ne_of_lt order),dif_neg (Nat.not_lt_of_ge (Nat.le_of_lt order))]
 rfl
theorem repeatedSusceptibilityRationalValue (r : Ratio) (f k : PositiveCount) :
 (exactSusceptibilityRatio
   (.ratio ⟨⟨r.numerator.value*k.value,Nat.mul_pos r.numerator.positive k.positive⟩,r.denominator⟩)
   (.count ⟨f.value*k.value,Nat.mul_pos f.positive k.positive⟩)).map VibrationalFrequency.rationalValue =
 (exactSusceptibilityRatio (.ratio r) (.count f)).map VibrationalFrequency.rationalValue := by
 change Except.ok (VacuumLedgerProofs.natRatio (r.numerator.value*k.value)
   (r.denominator.value*(f.value*k.value)) _) =
   Except.ok (VacuumLedgerProofs.natRatio r.numerator.value (r.denominator.value*f.value) _)
 apply congrArg Except.ok
 apply VacuumLedgerProofs.natRatioCongruence
 exact (SFT.Foundation.FractionReduction.mulAssoc r.numerator.value k.value (r.denominator.value*f.value)).trans
   ((congrArg (fun x => r.numerator.value*x) (CommonScaleAxis.multiplyLeftComm k.value r.denominator.value f.value)).trans
    (congrArg (fun x => r.numerator.value*(r.denominator.value*x)) (Nat.mul_comm k.value f.value)))
theorem excessRetainsOriginalSupport (a b : PositiveCount) (order : b.value<a.value) :
 a.value-b.value+b.value=a.value :=
 SFT.Foundation.FractionReduction.subtractAdd _ _ (Nat.le_of_lt order)
def fibreA : HeldLabel := ⟨"magnetic-orientation","fibre-a",rfl,rfl⟩
def fibreB : HeldLabel := ⟨"magnetic-orientation","fibre-b",rfl,rfl⟩
def responseView (r : Response) : String × Option Nat :=
 (r.orientation.label,match r.magnitude with | .emptyOne _ => none | .count n => some n.value)
def moment : Ratio := ⟨⟨3,by decide⟩,⟨2,by decide⟩⟩
theorem balancedWitness : (exactOrientationExcess (.count ⟨3,by decide⟩) (.count ⟨3,by decide⟩)
 (.held fibreA) (.held fibreB)).map responseView=.ok ("balanced-closed",none) := rfl
theorem unmatchedWitness : (exactOrientationExcess (.count ⟨5,by decide⟩) (.count ⟨2,by decide⟩)
 (.held fibreA) (.held fibreB)).map responseView=.ok ("fibre-a",some 3) := rfl
theorem momentWitness : (exactMomentRatio (.count ⟨3,by decide⟩) (.count ⟨2,by decide⟩)).map
 VibrationalFrequency.ratioPair=.ok (3,2) := rfl
theorem susceptibilityWitness : (exactSusceptibilityRatio (.ratio moment) (.count ⟨5,by decide⟩)).map
 VibrationalFrequency.ratioPair=.ok (3,10) := rfl
theorem repetitionWitness : repeatedResponsePreservesSusceptibility (.ratio moment)
 (.count ⟨5,by decide⟩) (.count ⟨7,by decide⟩)=.ok true := rfl
end SFT.Chemistry.MolecularMagneticResponse
