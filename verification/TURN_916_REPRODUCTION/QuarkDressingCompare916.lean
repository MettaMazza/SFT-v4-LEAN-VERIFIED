import SFT.Physics.QuarkDressing
#eval match SFT.Physics.QuarkDressing.quarkDressingFactors with
 | .error e => IO.println e
 | .ok f => IO.println ("[[" ++ toString f.centralDownLift.num ++ "," ++ toString f.centralDownLift.den ++ "],[" ++ toString f.upperUpRetention.num ++ "," ++ toString f.upperUpRetention.den ++ "]]")
