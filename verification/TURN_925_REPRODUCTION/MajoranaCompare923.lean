import SFT.Physics.MajoranaStructure
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.MajoranaStructure SFT.Physics.FoldFirstReturn
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def optionalValue : Option Rat → Value | none => .array [] | some r => fraction r
def takeValue (a b : Input) : Value := match positiveTake a b with
 | .error e => .text ("ValueError: " ++ e)
 | .ok r => optionalValue r
#eval do
 let p ← IO.ofExcept majoranaStructure
 let one : Input := .fraction ⟨1,1,by decide,by decide⟩
 let half : Input := .fraction ⟨1,2,by decide,by decide⟩
 let zero : Input := .fraction ⟨0,1,by decide,by decide⟩
 let negative : Input := .fraction ⟨-1,1,by decide,by decide⟩
 let cases := [takeValue one half,takeValue one one,takeValue half one,takeValue one zero,takeValue one negative,takeValue negative half,takeValue .nonFraction half,takeValue one .nonFraction]
 IO.println (render (.object [("record",.object [("left_hand",fraction p.leftHand),("right_hand",fraction p.rightHand),("dirac_pair_separation",optionalValue p.diracPairSeparation),("single_hand_count",.integer (.ofNat p.singleHandCount)),("self_antipodal_lock",.boolean p.selfAntipodalLock),("generic_hand_self_antipodal",.boolean p.genericHandSelfAntipodal),("class",.text p.classification)]),("take_cases",.array cases)]))
