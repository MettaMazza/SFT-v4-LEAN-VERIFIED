import SFT.Mathematics.CalculatorMachineV3
import SFT.Mathematics.CalculatorCompleteOperations
namespace SFT.Mathematics.CalculatorCompleteMachine
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
abbrev State := CalculatorMachineV3.State
def peek (s : State) (text : Option String := none) : Bool := CalculatorMachineV3.peek s text
def take (s : State) (text : Option String := none) : Except String (CalculatorLexer.Token × State) := CalculatorMachineV3.take s text
def record := CalculatorMachineV3.record
def lex (expression : String) (operationLimit : Nat) : Except String (List CalculatorLexer.Token) := do
 let tokens ← CalculatorLexer.lex expression
 let _ ← tokens.mapM fun token => do
  if Text.equal token.kind "number" then
   let (mantissa,exponent) := CalculatorNumerals.splitFirst 'e' (Text.chars (Text.lowerAscii token.text))
   if (mantissa.filter CalculatorNumerals.digitCharacter).length > operationLimit then throw "numeric token exceeds the declared counted digit bound"
   match exponent with
   | none => pure ()
   | some chars =>
    if !chars.isEmpty then
     match LeptonDecimal.exponent chars with
     | none => throw "ValueError"
     | some e => if e.natAbs > operationLimit then throw "scientific exponent exceeds the declared counted bound"
  pure ()
 pure tokens
def boundedWhole (state : State) (value : Value) (purpose : String) (allowEmpty : Bool := true) : Except String Nat := do
 let count ← CalculatorOperations.requireWhole value allowEmpty
 if count > state.operationLimit then throw (Text.append purpose " exceeds the declared counted operation bound")
 pure count
def call (state : State) (name : String) (args : List Value) : Except String (Value × State) := do
 if ["sin","cos","tan"].any (Text.equal name) then
  CalculatorMachine.arity name args 1
  let radians ← CalculatorFunctionsV3.toRadians (← CalculatorMachine.argument args 0) state.angleMode
  let result ← if Text.equal name "sin" then CalculatorCompleteOperations.sinValue radians state.places else if Text.equal name "cos" then CalculatorCompleteOperations.cosValue radians state.places else CalculatorCompleteOperations.tanValue radians state.places
  record state (Text.join ["generated-function:",name,":",state.angleMode,":periodic-reduction"]) result
 else
  if Text.equal name "root" then
   CalculatorMachine.arity name args 2
   let _ ← boundedWhole state (← CalculatorMachine.argument args 1) "root degree" false
  else if ["ncr","npr"].any (Text.equal name) then
   CalculatorMachine.arity name args 2
   let _ ← boundedWhole state (← CalculatorMachine.argument args 0) (Text.append name " support")
   let _ ← boundedWhole state (← CalculatorMachine.argument args 1) (Text.append name " selection")
  else if ["sum","prod","mean","variance","stddev"].any (Text.equal name) then
   if args.length > state.operationLimit then throw (Text.append name " argument count exceeds the declared operation bound")
  CalculatorMachineV3.call state name args
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
   match exponent with
   | .scalar (.positive _ magnitude) =>
     if magnitude.numerator > state.operationLimit || magnitude.denominator > state.operationLimit then throw "power exponent exceeds the declared counted bound"
   | .scalar .emptyOne => pure ()
   | .interval _ => pure ()
   | .complex _ => pure ()
   record state "exact-or-certified-power" (← CalculatorFunctionsV3.rationalPower value exponent state.places)
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
   let (value,state) ← if Text.equal operator.text "!" then do
    let _ ← boundedWhole state value "factorial count"
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
     let symbol := (state.symbols.reverse.find? (fun kv => Text.equal kv.1 name)).map Prod.snd
     match symbol with
     | some value => record state (Text.append "session-symbol:" name) value
     | none =>
      if Text.equal name "tau" then record state "certified-full-turn" (← CalculatorOperations.multiply (.scalar (← forward (CalculatorSeries.natural 2))) (← CalculatorOperationsV2.circleConstantEnclosure))
      else if Text.equal name "phi" || Text.equal name "golden" then record state "certified-golden-ratio" (← CalculatorStatisticsV3.goldenRatioEnclosure)
      else if Text.equal name "pi" then record state "certified-circle-constant-v2" (← CalculatorOperationsV2.circleConstantEnclosure)
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
def calculateWithSymbols (input : String) (places : Int := 18) (operationLimit : Int := 10000) (angleMode : String := "rad") (symbols : List (String × Value) := []) : Except String CalculatorMachine.Calculation := do
 if places < 1 || places > 60 then throw "display precision must be a counted value from 1 through 60"
 if operationLimit < 1 then throw "operation limit must be a positive count"
 if !(["rad","deg","grad"].any (Text.equal angleMode)) then throw "angle mode must be rad, deg or grad"
 let stripped := LeptonDecimal.strip (Text.chars input)
 let stripped := if stripped.reverse.head? == some '=' then LeptonDecimal.strip (stripped.take (stripped.length-1)) else stripped
 if stripped.any (fun c => c == '=') then throw "equals is a terminal execute key, not an internal operator"
 let tokens ← lex (String.ofList stripped) operationLimit.toNat
 let initial : State := {toState := ⟨tokens,0,["boundary:decimal-notation-translated-to-exact-Fold-forms"],0,places,operationLimit.toNat⟩,angleMode := angleMode,symbols := symbols.map (fun (k,v) => (Text.lowerAscii k,v))}
 let (value,final) ← expression (8*(tokens.length+1)) initial
 if final.position != tokens.length then
  let (token,_) ← take final
  throw (Text.join ["unexpected token '",token.text,"'"])
 pure ⟨input,value,final.trace++["halt:complete-generated-expression-consumed"],tokens.length,final.operations⟩
def calculate (input : String) (places : Int := 18) (operationLimit : Int := 10000) (angleMode : String := "rad") : Except String CalculatorMachine.Calculation :=
 calculateWithSymbols input places operationLimit angleMode []
end SFT.Mathematics.CalculatorCompleteMachine
