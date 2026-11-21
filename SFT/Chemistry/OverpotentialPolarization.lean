import SFT.Chemistry.ComponentExchange
namespace SFT.Chemistry.OverpotentialPolarization
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure PolarizationPoint where
 electrode : HeldLabel
 reference : HeldLabel
 condition : HeldLabel
 scanOrdinal : PositiveCount
 potentialSide : HeldLabel
 potentialDistance : Height
 currentDirection : HeldLabel
 currentMagnitude : Height
def makePoint (electrode reference condition : HeldLabel) (ordinal : PositiveCount)
 (side : HeldLabel) (distance : Height) (direction : HeldLabel) (magnitude : Height) : Except String PolarizationPoint := do
 if !Text.equal electrode.family "electrode" || !Text.equal reference.family "equilibrium-reference" ||
  !Text.equal condition.family "electrochemical-condition" || !Text.equal side.family "potential-side" || !Text.equal direction.family "current-direction" then
  throw "complete polarization custody required"
 if Text.equal side.label "equilibrium" then
  if !equalHeight distance .emptyOne || !equalHeight magnitude .emptyOne then throw "equilibrium point closes potential and net current"
 else
  let positive := fun h=>match h with | Height.ratio _ => true | .emptyOne | .otherEmptyOne _ | .invalid => false
  if !positive distance || !positive magnitude then throw "polarized points require positive magnitudes"
 pure ⟨electrode,reference,condition,ordinal,side,distance,direction,magnitude⟩
def polarizationCurve (points : List PolarizationPoint) : Except String (List PolarizationPoint) := do
 if points.isEmpty || !(points.zipIdx.all fun (p,i)=>p.scanOrdinal.value==i+1) then throw "complete ordered finite scan required"
 match points with
 | [] => throw "complete ordered finite scan required"
 | first::_ =>
  if !(points.all fun p=>equalLabel p.electrode first.electrode && equalLabel p.reference first.reference && equalLabel p.condition first.condition) then throw "mixed polarization support"
  pure points
def examplePoint (n : Nat) (side : String := "anodic") : Except String PolarizationPoint := do
 let equilibrium := Text.equal side "equilibrium"
 let distance ← if equilibrium then pure Height.emptyOne else pure (Height.ratio (rawRatio (fraction ⟨← count n,← count 2⟩)))
 let magnitude ← if equilibrium then pure Height.emptyOne else pure (Height.ratio (rawRatio (fraction ⟨← count n,← count 3⟩)))
 makePoint (← heldLabel "electrode" "e") (← heldLabel "equilibrium-reference" "r") (← heldLabel "electrochemical-condition" "c")
  (← count n) (← heldLabel "potential-side" side) distance (← heldLabel "current-direction" (if equilibrium then "balanced" else side)) magnitude
def witnesses : Except String (List Bool) := do
 let c ← polarizationCurve [← examplePoint 1 "equilibrium",← examplePoint 2,← examplePoint 3 "cathodic"]
 let bad := match polarizationCurve [← examplePoint 1,← examplePoint 3] with | .error _ => true | .ok _ => false
 match c with
 | a::b::d::[] =>
  let positive := match b.currentMagnitude with | .ratio _ => true | .emptyOne | .otherEmptyOne _ | .invalid => false
  pure [c.length==3,Text.equal a.reference.label "r",equalHeight a.potentialDistance .emptyOne,Text.equal b.potentialSide.label "anodic",
   Text.equal d.potentialSide.label "cathodic",positive,c.all (fun p=>equalLabel p.condition a.condition),bad]
 | [] => throw "witness curve changed"
 | _::[] => throw "witness curve changed"
 | _::_::[] => throw "witness curve changed"
 | _::_::_::_::_ => throw "witness curve changed"
theorem originalEightWitnesses : witnesses = .ok [true,true,true,true,true,true,true,true] := rfl
end SFT.Chemistry.OverpotentialPolarization
