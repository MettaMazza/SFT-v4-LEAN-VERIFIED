import SFT.Physics.MolecularLadders
open SFT.Physics SFT.Host.Canonical MolecularLadders
set_option maxRecDepth 20000
def ri : Except String Int → Value
 | .error e => .object [("error",.text e)]
 | .ok x => .integer x
def rq : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok x => .array [.integer x.num,.integer (.ofNat x.den)]
#eval do
 let ordinals : List OrdinalInput := [.count (.integer (-2)),.count (.integer (0)),.count (.integer (1)),.count (.integer (2)),.count (.integer (3)),.count (.integer (4)),.count (.integer (10)),.count (.boolean true),.count (.boolean false),.nonInteger,.nonInteger]
 let ratios : List FoldFirstReturn.Input := [.fraction (LeptonIntervals.normalize (-1) 1 (by decide)),.fraction (LeptonIntervals.normalize (0) 1 (by decide)),.fraction (LeptonIntervals.normalize (1) 1 (by decide)),.fraction (LeptonIntervals.normalize (1) 100 (by decide)),.fraction (LeptonIntervals.normalize (2) 3 (by decide)),.nonFraction,.nonFraction]
 let rows : List Value := ratios.flatMap fun h => ratios.flatMap fun a => ordinals.map fun n => .array [rq (vibrationalLevel h a n),rq (adjacentVibrationalGap h a n)]
 IO.println (render (.object [("empty",.array (emptyRotationalGround.map (fun _ => .null))),("rotation",.array (ordinals.map (fun n => ri (rotationalLevel n)))),("gaps",.array (ordinals.map (fun n => ri (adjacentRotationalGap n)))),("odd",.array (ordinals.map (fun n => ri (oddVibrationalCarrier n)))),("vibration",.array rows)]))
