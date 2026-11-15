import SFT.Mathematics.CalculatorLexer
import SFT.Mathematics.CalculatorProjection
import SFT.Mathematics.CalculatorTrigonometry
namespace SFT.Mathematics.CalculatorMachine
open SFT.Host SFT.Mathematics CalculatorValues CalculatorLexer
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure State where
 tokens : List Token
 position : Nat
 trace : List String
 operations : Nat
 places : Int
 operationLimit : Nat
structure Calculation where
 expression : String
 value : Value
 trace : List String
 tokensRead : Nat
 operationsExecuted : Nat
def peek (state : State) (text : Option String := none) : Bool :=
 match (state.tokens.drop state.position).head? with
 | none => false
 | some token => match text with
  | none => true
  | some text => Text.equal token.text text
def take (state : State) (text : Option String := none) : Except String (Token × State) := do
 if !peek state text then throw (Text.append "expected " (text.getD "a generated token"))
 match (state.tokens.drop state.position).head? with
 | none => throw "expected a generated token"
 | some token => pure (token,{state with position := state.position+1})
def record (state : State) (operation : String) (value : Value) : Except String (Value × State) := do
 let count := state.operations+1
 if count > state.operationLimit then throw "declared operation bound exhausted"
 let text ← CalculatorProjection.valueText value (min state.places 12)
 pure (value,{state with operations := count,trace := state.trace ++ [Text.join [String.ofList (Nat.toDigits 10 count),":",operation,":",text]]})
def argument (args : List Value) (index : Nat) : Except String Value :=
 match (args.drop index).head? with
 | none => .error "IndexError"
 | some x => .ok x
def arity (name : String) (args : List Value) (expected : Nat) : Except String Unit :=
 if args.length == expected then .ok () else .error (Text.join [name," requires exactly ",String.ofList (Nat.toDigits 10 expected)," generated argument(s)"])
def call (state : State) (name : String) (args : List Value) : Except String (Value × State) := do
 if ["abs","recip","sqrt","exp","ln","log10","sin","cos","tan","conj"].any (Text.equal name) then
  arity name args 1
  let x ← argument args 0
  let result ←
   if Text.equal name "abs" then CalculatorRoots.absolute x
   else if Text.equal name "recip" then CalculatorOperations.reciprocal x
   else if Text.equal name "sqrt" then CalculatorRoots.nthRoot x 2
   else if Text.equal name "exp" then CalculatorSeries.expEnclosure x state.places
   else if Text.equal name "ln" then CalculatorSeries.lnEnclosure x state.places
   else if Text.equal name "log10" then CalculatorSeries.log10Enclosure x state.places
   else if Text.equal name "sin" then CalculatorTrigonometry.sinEnclosure x state.places
   else if Text.equal name "cos" then CalculatorTrigonometry.cosEnclosure x state.places
   else if Text.equal name "tan" then CalculatorTrigonometry.tanEnclosure x state.places
   else pure (CalculatorOperations.conjugate x)
  record state (Text.append "generated-function:" name) result
 else if ["root","pow","ncr","npr","complex","log"].any (Text.equal name) then
  arity name args 2
  let left ← argument args 0
  let right ← argument args 1
  let result ←
   if Text.equal name "root" then CalculatorRoots.nthRoot left (Int.ofNat (← CalculatorOperations.requireWhole right false))
   else if Text.equal name "pow" then CalculatorOperations.wholePower left right
   else if Text.equal name "ncr" then pure (.scalar (← CalculatorOperations.combination left right))
   else if Text.equal name "npr" then pure (.scalar (← CalculatorOperations.permutation left right))
   else if Text.equal name "complex" then pure (.complex ⟨← CalculatorOperations.requireScalar left,← CalculatorOperations.requireScalar right⟩)
   else CalculatorOperations.divide (← CalculatorSeries.lnEnclosure left (state.places+4)) (← CalculatorSeries.lnEnclosure right (state.places+4))
  record state (Text.append "generated-function:" name) result
 else throw (Text.join ["unknown generated function '",name,"'"])
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
     if Text.equal name "pi" then record state "certified-circle-constant" (← CalculatorTrigonometry.circleConstantEnclosure)
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
def render (calculation : Calculation) (places : Int := 18) : Except String String :=
 CalculatorProjection.valueText calculation.value places
end SFT.Mathematics.CalculatorMachine
