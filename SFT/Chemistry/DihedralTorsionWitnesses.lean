import SFT.Chemistry.DihedralTorsionCycle
namespace SFT.Chemistry.DihedralTorsionWitnesses
open SFT.Host SFT.Physics.CapabilityValues DihedralTorsion DihedralTorsionCycle
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def witnessCarrier : Carrier :=
 ⟨⟨"molecular-carrier","synthetic-cycle",rfl,rfl⟩,⟨"molecular-state","witness-state",rfl,rfl⟩,
 [⟨"ordered-torsion-atom","A",rfl,rfl⟩,⟨"ordered-torsion-atom","B",rfl,rfl⟩,
  ⟨"ordered-torsion-atom","C",rfl,rfl⟩,⟨"ordered-torsion-atom","D",rfl,rfl⟩],
 ⟨"rotor-type","witness-rotor",rfl,rfl⟩,⟨"held-orientation","forward-cycle",rfl,rfl⟩⟩
def naturalHeight (n : Nat) : Except String Height := do
 if n==0 then pure .emptyOne
 else pure (.ratio ⟨← count n,⟨1,by decide⟩⟩)
def witnessCycle : Except String Cycle := do
 let carrier ← validateCarrier witnessCarrier
 let heights ← [0,2,5,0,3,6,0].mapM naturalHeight
 let sectors : PositiveCount := ⟨6,by decide⟩
 let nodes ← heights.zipIdx |>.mapM fun (height,index) => do
  let position : PositiveCount := ⟨index+1,Nat.zero_lt_succ index⟩
  let coordinate ← generatedCoordinate (.count position) (.count sectors)
  let record ← heldLabel "torsion-record" (Text.append "witness-" (toString position.value))
  validateNode ⟨carrier,position,coordinate,height,record⟩
 validateCycle (.count sectors) nodes
def coordinateWitness : Bool := (witnessCycle.toOption.map fun cycle =>
 match cycle.nodes.head?,cycle.nodes.getLast? with
 | some first,some last =>
  (match first.coordinate with | .emptyOne => true | .ratio _ | .otherEmptyOne _ | .invalid => false) &&
  (match last.coordinate with | .ratio r => r.numerator.value==r.denominator.value | .emptyOne | .otherEmptyOne _ | .invalid => false)
 | none,none | none,some _ | some _,none => false).getD false
def orderWitness : Bool := ((do
 let cycle ← witnessCycle
 let minima ← localConformerPositions cycle
 let maxima ← localBarrierPositions cycle
 pure (minima.length==2 && maxima.length==2) : Except String Bool).toOption).getD false
def transitionsWitness : Bool := ((do
 let cycle ← witnessCycle
 let paths ← barrierTransitions cycle
 pure (paths.length==4 && paths.all (fun row => row.magnitude.numerator.value>0)) : Except String Bool).toOption).getD false
def reverseWitness : Bool :=
 match barrierTake (.ratio ⟨⟨2,by decide⟩,⟨1,by decide⟩⟩) (.ratio ⟨⟨5,by decide⟩,⟨1,by decide⟩⟩) with
 | .error _ => true
 | .ok _ => false
theorem coordinatePassed : coordinateWitness = true := rfl
theorem orderPassed : orderWitness = true := rfl
theorem transitionsPassed : transitionsWitness = true := rfl
theorem reversePassed : reverseWitness = true := rfl
end SFT.Chemistry.DihedralTorsionWitnesses
