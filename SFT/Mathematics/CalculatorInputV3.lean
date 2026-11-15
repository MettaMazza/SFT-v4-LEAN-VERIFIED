import SFT.Mathematics.CalculatorMachineV3
namespace SFT.Mathematics.CalculatorInputV3
open SFT.Mathematics SFT.Host CalculatorValues
-- Original machine_v3.__init__: the lexer admits ASCII names. Python lower
-- has exactly one non-ASCII preimage of an ASCII character: U+212A -> k.
-- Other non-ASCII keys cannot equal an admitted lexer name.
def calculate (input : String) (places : Int := 18) (operationLimit : Int := 10000) (angleMode : String := "rad") (symbols : List (String × Value) := []) : Except String CalculatorMachine.Calculation :=
 CalculatorMachineV3.calculate input places operationLimit angleMode
  (symbols.map (fun (key,value) => (String.ofList ((Text.chars key).map (fun c => if c.toNat == 8490 then 'k' else c)),value)))
end SFT.Mathematics.CalculatorInputV3
