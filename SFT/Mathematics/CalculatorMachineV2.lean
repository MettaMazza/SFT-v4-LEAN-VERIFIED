import SFT.Mathematics.CalculatorMachine
import SFT.Mathematics.CalculatorOperationsV2
namespace SFT.Mathematics.CalculatorMachineV2
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorMachine
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
mutual
 def expression : Nat → State → Except String (Value × State)
 | 0,_ => .error "unreachable parser traversal boundary"
 | fuel+1,state => do
  let (value,state) ← term fuel state
  expressionRest fuel value state
 def expressionRest : Nat → Value → State → Except String (Value × State)
 | 0,_,_ => .error "unreachable parser traversal boundary"
 | fuel+1,value,state => do
  if peek state (some "+") || peek state (some "-") then
   let (operator,state) ← take state
   let (right,state) ← term fuel state
   let isAdd := Text.equal operator.text "+"
   let result ← if isAdd then CalculatorOperations.add value right else CalculatorOperations.subtract value right
   let (value,state) ← record state (if isAdd then "held-junction" else "held-substitution") result
   expressionRest fuel value state
  else pure (value,state)
 def term : Nat → State → Except String (Value × State)
 | 0,_ => .error "unreachable parser traversal boundary"
 | fuel+1,state => do
  let (value,state) ← unary fuel state
  termRest fuel value state
 def termRest : Nat → Value → State → Except String (Value × State)
 | 0,_,_ => .error "unreachable parser traversal boundary"
 | fuel+1,value,state => do
  if peek state (some "*") || peek state (some "/") then
   let (operator,state) ← take state
   let (right,state) ← unary fuel state
   let isProduct := Text.equal operator.text "*"
   let result ← if isProduct then CalculatorOperations.multiply value right else CalculatorOperations.divide value right
   let (value,state) ← record state (if isProduct then "pair-cell-product" else "common-refinement-quotient") result
   termRest fuel value state
  else pure (value,state)
 def unary : Nat → State → Except String (Value × State)
 | 0,_ => .error "unreachable parser traversal boundary"
 | fuel+1,state => do
  if peek state (some "+") then
   let (_,state) ← take state (some "+")
   unary fuel state
  else if peek state (some "-") then
   let (_,state) ← take state (some "-")
   let (value,state) ← unary fuel state
   record state "held-orientation-reversal" (← CalculatorOperations.negate value)
  else power fuel state
 def power : Nat → State → Except String (Value × State)
 | 0,_ => .error "unreachable parser traversal boundary"
 | fuel+1,state => do
  let (value,state) ← parsePostfix fuel state
  if peek state (some "^") then
   let (_,state) ← take state (some "^")
   let (exponent,state) ← unary fuel state
   record state "counted-whole-power" (← CalculatorOperations.wholePower value exponent)
  else pure (value,state)
 def parsePostfix : Nat → State → Except String (Value × State)
 | 0,_ => .error "unreachable parser traversal boundary"
 | fuel+1,state => do
  let (value,state) ← primary fuel state
  postfixRest fuel value state
 def postfixRest : Nat → Value → State → Except String (Value × State)
 | 0,_,_ => .error "unreachable parser traversal boundary"
 | fuel+1,value,state => do
  if peek state (some "!") || peek state (some "%") then
   let (operator,state) ← take state
   let (value,state) ← if Text.equal operator.text "!" then
    record state "generated-factorial-recurrence" (.scalar (← CalculatorOperations.factorial value))
    else record state "exact-hundredth-part" (← CalculatorOperations.divide value (.scalar (← forward (CalculatorSeries.natural 100))))
   postfixRest fuel value state
  else pure (value,state)
 def primary : Nat → State → Except String (Value × State)
 | 0,_ => .error "unreachable parser traversal boundary"
 | fuel+1,state => do
  if peek state (some "(") then
   let (_,state) ← take state (some "(")
   let (value,state) ← expression fuel state
   let (_,state) ← take state (some ")")
   pure (value,state)
  else
   let (token,state) ← take state
   if Text.equal token.kind "number" then
    let value := Value.scalar (← CalculatorNumerals.parseExactNumber token.text)
    let display ← CalculatorProjection.valueText value (min state.places 12)
    pure (value,{state with trace := state.trace ++ [Text.join ["input:",token.text,"->",display]]})
   else if !Text.equal token.kind "name" then throw (Text.join ["unexpected token '",token.text,"'"])
   else
    let name := Text.lowerAscii token.text
    if !peek state (some "(") then
     if Text.equal name "pi" then record state "certified-circle-constant-v2" (← CalculatorOperationsV2.circleConstantEnclosure)
     else if Text.equal name "e" then record state "certified-exp-One" (← CalculatorSeries.expEnclosure (.scalar (← forward (CalculatorSeries.natural 1))) state.places)
     else if Text.equal name "empty" || Text.equal name "empty_one" then pure (.scalar .emptyOne,state)
     else throw (Text.join ["unknown generated name '",token.text,"'"])
    else
     let (_,state) ← take state (some "(")
     let (args,state) ← arguments fuel state
     let (_,state) ← take state (some ")")
     call state name args
 def arguments : Nat → State → Except String (List Value × State)
 | 0,_ => .error "unreachable parser traversal boundary"
 | fuel+1,state => do
  if peek state (some ")") then pure ([],state)
  else
   let (value,state) ← expression fuel state
   argumentsRest fuel [value] state
 def argumentsRest : Nat → List Value → State → Except String (List Value × State)
 | 0,_,_ => .error "unreachable parser traversal boundary"
 | fuel+1,args,state => do
  if peek state (some ",") then
   let (_,state) ← take state (some ",")
   let (value,state) ← expression fuel state
   argumentsRest fuel (args++[value]) state
  else pure (args,state)
end
def calculate (input : String) (places : Int := 18) (operationLimit : Int := 10000) : Except String Calculation := do
 if places < 1 || places > 60 then throw "display precision must be a counted value from 1 through 60"
 if operationLimit < 1 then throw "operation limit must be a positive count"
 let tokens ← CalculatorLexer.lex input
 let initial : State := ⟨tokens,0,["boundary:decimal-notation-translated-to-exact-Fold-forms"],0,places,operationLimit.toNat⟩
 let (value,final) ← expression (8*(tokens.length+1)) initial
 if final.position != tokens.length then
  let (token,_) ← take final
  throw (Text.join ["unexpected token '",token.text,"'"])
 pure ⟨input,value,final.trace++["halt:complete-generated-expression-consumed"],tokens.length,final.operations⟩
end SFT.Mathematics.CalculatorMachineV2
