import SFT.Chemistry.ComplexSpinState
import SFT.Chemistry.StateEnergyOrderDerivation
namespace SFT.Chemistry.InorganicColour
open SFT.Host SFT.Physics.CapabilityValues
def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def containsLabel (xs : List HeldLabel) (x : HeldLabel) : Bool := xs.any (sameLabel x)
def distinctLabels : List HeldLabel → Bool
 | [] => true
 | x::xs => !containsLabel xs x && distinctLabels xs
structure State where
 complexIdentity : HeldLabel
 carrierKind : HeldLabel
 stateIdentity : HeldLabel
 orderPosition : PositiveCount
def state (complexIdentity carrierKind stateIdentity : HeldLabel) (position : PositiveCount) : Except String State := do
 if !Text.equal complexIdentity.family "coordination-entity" then
  throw "electronic state requires one retained coordination entity"
 if !Text.equal carrierKind.family "complex-electronic-carrier" || !(Text.equal carrierKind.label "ligand" || Text.equal carrierKind.label "metal") then
  throw "complex electronic support has exactly ligand and metal carrier kinds"
 if !Text.equal stateIdentity.family "complex-electronic-state" then
  throw "electronic transition requires retained state identity"
 return ⟨complexIdentity,carrierKind,stateIdentity,position⟩
def className (source target : String) : String := Text.intercalate "-to-" [source,target]
structure Transition where
 source : State
 target : State
 positiveOrderGap : PositiveCount
 transferClass : HeldLabel
def transition (source target : State) (gap : PositiveCount) (transferClass : HeldLabel) : Except String Transition := do
 if !sameLabel source.complexIdentity target.complexIdentity then
  throw "transition endpoints must remain in one coordination entity"
 if sameLabel source.stateIdentity target.stateIdentity then
  throw "a transition must retain two distinguishable states"
 if target.orderPosition.value<=source.orderPosition.value then
  throw "absorption transition must reach a positive state-order successor"
 if gap.value != target.orderPosition.value-source.orderPosition.value then
  throw "transition gap must equal the exact positive order separation"
 if !Text.equal transferClass.family "complex-transition-class" || !Text.equal transferClass.label (className source.carrierKind.label target.carrierKind.label) then
  throw "transition class must preserve both directed carrier endpoints"
 return ⟨source,target,gap,transferClass⟩
def classes : Except String (List HeldLabel) := do
 let pairs := (["ligand","metal"] : List String).flatMap fun s => ["ligand","metal"].map fun t => (s,t)
 let rows ← pairs.mapM fun (s,t) => heldLabel "complex-transition-class" (className s t)
 if rows.length != 4 || !distinctLabels rows then
  throw "two carrier kinds must force four directed transition classes"
 return rows
def build (complexLabel sourceCarrier targetCarrier sourceState targetState : String)
 (sourcePosition targetPosition : PositiveCount) : Except String Transition := do
 let identity ← heldLabel "coordination-entity" complexLabel
 let source ← state identity (← heldLabel "complex-electronic-carrier" sourceCarrier) (← heldLabel "complex-electronic-state" sourceState) sourcePosition
 let target ← state identity (← heldLabel "complex-electronic-carrier" targetCarrier) (← heldLabel "complex-electronic-state" targetState) targetPosition
 if h : sourcePosition.value<targetPosition.value then
  transition source target ⟨targetPosition.value-sourcePosition.value,StateEnergyOrder.retainedPositiveGap sourcePosition targetPosition h⟩
   (← heldLabel "complex-transition-class" (className sourceCarrier targetCarrier))
 else throw "target position must be a positive successor"
structure Absorption where
 transition : Transition
 incident : List HeldLabel
 absorbed : List HeldLabel
 retained : List HeldLabel
 absorbedPositive : 0<absorbed.length
 retainedPositive : 0<retained.length
def absorption (t : Transition) (incident absorbed retained : List HeldLabel) : Except String Absorption := do
 if incident.isEmpty || !distinctLabels incident then
  throw "incident observation support must be positive and distinct"
 if incident.any (fun x => !Text.equal x.family "observation-distinction") then
  throw "incident support contains an invalid distinction"
 if ha : 0<absorbed.length then
  if hr : 0<retained.length then
   if absorbed.any (containsLabel retained) ||
    !(incident.all (fun x => containsLabel absorbed x || containsLabel retained x)) ||
    !(absorbed.all (containsLabel incident)) || !(retained.all (containsLabel incident)) then
    throw "absorbed and retained classes must partition complete incident support"
   if !distinctLabels absorbed || !distinctLabels retained then
    throw "absorption partition cannot duplicate distinctions"
   return ⟨t,incident,absorbed,retained,ha,hr⟩
  else throw "colour requires both a positive absorbed and retained distinction class"
 else throw "colour requires both a positive absorbed and retained distinction class"
def absorbedCount (a : Absorption) : PositiveCount := ⟨a.absorbed.length,a.absorbedPositive⟩
def retainedCount (a : Absorption) : PositiveCount := ⟨a.retained.length,a.retainedPositive⟩
def complement (incident absorbed : List HeldLabel) : List HeldLabel := incident.filter fun x => !containsLabel absorbed x
def selective (t : Transition) (incident absorbed : List HeldLabel) : Except String Absorption :=
 absorption t incident absorbed (complement incident absorbed)
def witnessTransition := build "complex" "ligand" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨3,by decide⟩
def incident : Except String (List HeldLabel) := [1,2,3].mapM fun n => heldLabel "observation-distinction" (Text.append "distinction-" (toString n))
def secondLabel : List HeldLabel → Except String HeldLabel
 | [] => .error "tuple index out of range"
 | _::[] => .error "tuple index out of range"
 | _::x::_ => .ok x
def witnessAbsorption : Except String Absorption := do
 let t ← witnessTransition
 let xs ← incident
 selective t xs [← secondLabel xs]
def classWitness : Bool := match classes with
 | .error _ => false
 | .ok rows => (rows.map (fun x => x.label))==["ligand-to-ligand","ligand-to-metal","metal-to-ligand","metal-to-metal"]
def gapWitness : Bool := match witnessTransition with
 | .error _ => false | .ok t => t.positiveOrderGap.value==2
def partitionWitness : Bool := match witnessAbsorption with
 | .error _ => false | .ok a => (absorbedCount a).value==1 && (retainedCount a).value==2
def sameStateWitness : Bool := match build "complex" "metal" "metal" "same" "same" ⟨1,by decide⟩ ⟨2,by decide⟩ with
 | .error _ => true | .ok _ => false
def completeAbsorptionWitness : Bool := match (do let t ← witnessTransition; let xs ← incident; selective t xs xs) with
 | .error _ => true | .ok _ => false
theorem classesPassed : classWitness=true := by decide
theorem gapPassed : gapWitness=true := by decide
theorem partitionPassed : partitionWitness=true := by decide
theorem sameStatePassed : sameStateWitness=true := by decide
theorem completeAbsorptionPassed : completeAbsorptionWitness=true := by decide
end SFT.Chemistry.InorganicColour
