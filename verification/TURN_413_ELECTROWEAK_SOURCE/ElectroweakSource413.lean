import SFT.Physics.ElectroweakTerminalDomain
open SFT.Physics SFT.Foundation.ExactOperations

def inputs : List GeneratorOperations.CountInput :=
 (List.range 23).map (fun n => .integer (Int.ofNat n - 2)) ++ [.boolean false,.boolean true]
def natText : Except String Nat → String
 | .error e => "error:"++e
 | .ok n => "ok:"++toString n
def ratText : Except String PositiveFraction → String
 | .error e => "error:"++e
 | .ok p => "ok:"++toString p.numerator++"/"++toString p.denominator

def main : IO Unit := do
 for c in inputs do
  for t in inputs do
   IO.println (natText (ElectroweakTerminalDomain.positiveTake c t))
 for level in inputs do
  IO.println (ratText (ElectroweakTerminalRatio.runningShare level))
 for value in [ElectroweakTerminalSupport.promotionCount,ElectroweakTerminalSupport.binarySupport,
   ElectroweakTerminalSupport.runningLevel,ElectroweakTerminalSupport.returnDivisor] do
  IO.println (natText value)
 for value in [ElectroweakTerminalRatio.terminalAlpha,ElectroweakTerminalRatio.selfReturn,
   ElectroweakTerminalRatio.sinSquared,ElectroweakTerminalRatio.cosSquared,ElectroweakTerminalRatio.completeShare] do
  IO.println (ratText value)
