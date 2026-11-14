import SFT.Physics.PMNSPhysical
namespace SFT.Physics.MajoranaStructure
open GeneratorOperations LeptonIntervals VacuumLedgerProofs VacuumScaleProofs

def positiveTake : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String (Option Rat)
 | .nonFraction,_ | _,.nonFraction => .error "positive take requires exact fractions"
 | .fraction whole,.fraction part =>
  (GravityFlux.positiveTake (.fraction whole) (.fraction part)).mapError
   (fun _ => "positive take requires ordered positive support")

structure Result where
 leftHand : Rat
 rightHand : Rat
 diracPairSeparation : Option Rat
 singleHandCount : Nat
 selfAntipodalLock : Bool
 genericHandSelfAntipodal : Bool
 classification : String

def majoranaStructure : Except String Result := do
 let b ← AlphaCovers.binaryCount
 let square ← AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat b))
 let left ← LeptonRatios.divide (wholeRatio 1) (wholeRatio square)
 let predecessor ← positivePredecessor (.integer (.ofNat square))
 let right ← LeptonRatios.divide (wholeRatio predecessor) (wholeRatio square)
 let lock ← LeptonRatios.divide (wholeRatio 1) (wholeRatio b)
 let genericAntipode ← positiveTake (.fraction (wholeRatio 1)) (.fraction left)
 let lockAntipode ← positiveTake (.fraction (wholeRatio 1)) (.fraction lock)
 let separation ← positiveTake (.fraction right) (.fraction left)
 pure ⟨left,right,separation,1,decide (lockAntipode=some lock),
  decide (genericAntipode=some left),"single-hand-self-antipodal-Majorana"⟩

def originalRecord : Result :=
 ⟨⟨1,4,by decide,by decide⟩,⟨3,4,by decide,by decide⟩,
  some ⟨1,2,by decide,by decide⟩,1,true,false,"single-hand-self-antipodal-Majorana"⟩

theorem completeSourceRecord : majoranaStructure=.ok originalRecord := rfl

theorem genericComplement : positiveTake (.fraction (wholeRatio 1)) (.fraction originalRecord.leftHand)=.ok (some originalRecord.rightHand) := rfl

theorem halfOneLock : positiveTake (.fraction (wholeRatio 1)) (.fraction ⟨1,2,by decide,by decide⟩)=.ok (some ⟨1,2,by decide,by decide⟩) := rfl
end SFT.Physics.MajoranaStructure
