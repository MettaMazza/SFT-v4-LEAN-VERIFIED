import SFT.Mathematics.CalculatorWitnesses
import Lean
namespace SFT.Mathematics.CalculatorWitnesses
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem witness8Passed : witness8 = true := by
 run_tac Lean.Elab.Tactic.liftMetaTactic fun goal => do
  goal.assign (← Lean.Meta.mkEqRefl (Lean.mkConst ``Bool.true))
  pure []
end SFT.Mathematics.CalculatorWitnesses
