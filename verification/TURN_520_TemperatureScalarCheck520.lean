import SFT.Physics.ThermoTemperatureOrder
import SFT.Host.Canonical
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations
open SFT.Physics.ThermoTemperature SFT.Physics.ThermoTemperatureOrder SFT.Host.Canonical

def testValues : List Scalar := .emptyOne :: (List.range 3).flatMap (fun n =>
  (List.range 3).flatMap (fun d =>
    let q := normalizePositive (n+1) (d+1) (Nat.zero_lt_succ n) (Nat.zero_lt_succ d)
    [.positive .forward q,.positive .counter q]))
def scalarValue : Scalar → Value
  | .emptyOne => .text "empty-One"
  | .positive held q => .array [.text (orientationName held),.integer q.numerator,.integer q.denominator]
def orderValue : Ordering → Value
  | .lt => .integer (-1) | .eq => .integer 0 | .gt => .integer 1

def main : IO Unit := do
  let rows := testValues.flatMap fun a => testValues.map fun b =>
    let result := match divideScalar a b with
      | .error e => .object [("error",.text e)]
      | .ok v => scalarValue v
    Value.array [scalarValue a,scalarValue b,orderValue (compareScalar a b),result]
  IO.println (render (.array rows))
