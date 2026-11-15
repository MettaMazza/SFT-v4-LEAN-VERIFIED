import SFT.Mathematics.CalculatorMachineV2
import SFT.Mathematics.CalculatorInverseV3
namespace SFT.Mathematics.CalculatorMachineV3
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure State extends CalculatorMachine.State where
 angleMode : String
 symbols : List (String × Value)
def peek (s : State) (text : Option String := none) : Bool := CalculatorMachine.peek s.toState text
def take (s : State) (text : Option String := none) : Except String (CalculatorLexer.Token × State) := do
 let (token,t) ← CalculatorMachine.take s.toState text
 pure (token,{s with toState := t})
def record (s : State) (operation : String) (value : Value) : Except String (Value × State) := do
 let (v,t) ← CalculatorMachine.record s.toState operation value
 pure (v,{s with toState := t})
def call (state : State) (name : String) (args : List Value) : Except String (Value × State) := do
 if ["asin","acos","atan","sinh","cosh","tanh","asinh","acosh","atanh","log2","log10","exp","sqrt","cbrt","floor","ceil"].any (Text.equal name) then
  CalculatorMachine.arity name args 1
  let x ← CalculatorMachine.argument args 0
  let result ←
   if Text.equal name "asin" then CalculatorFunctionsV3.fromRadians (← CalculatorInverseV3.asinValue x state.places) state.angleMode
   else if Text.equal name "acos" then CalculatorFunctionsV3.fromRadians (← CalculatorInverseV3.acosValue x state.places) state.angleMode
   else if Text.equal name "atan" then CalculatorFunctionsV3.fromRadians (← CalculatorInverseV3.atanValue x state.places) state.angleMode
   else if Text.equal name "sinh" then CalculatorFunctionsV3.sinhValue x state.places
   else if Text.equal name "cosh" then CalculatorFunctionsV3.coshValue x state.places
   else if Text.equal name "tanh" then CalculatorFunctionsV3.tanhValue x state.places
   else if Text.equal name "asinh" then CalculatorFunctionsV3.asinhValue x state.places
   else if Text.equal name "acosh" then CalculatorFunctionsV3.acoshValue x state.places
   else if Text.equal name "atanh" then CalculatorFunctionsV3.atanhValue x state.places
   else if Text.equal name "log2" then CalculatorFunctionsV3.logBase x (.scalar (← forward (CalculatorSeries.natural 2))) state.places
   else if Text.equal name "log10" then CalculatorFunctionsV3.logBase x (.scalar (← forward (CalculatorSeries.natural 10))) state.places
   else if Text.equal name "exp" then CalculatorFunctionsV3.expValue x state.places
   else if Text.equal name "sqrt" then CalculatorStatisticsV3.rootValue x 2
   else if Text.equal name "cbrt" then CalculatorStatisticsV3.rootValue x 3
   else if Text.equal name "floor" then pure (.scalar (← CalculatorStatisticsV3.floorValue x))
   else pure (.scalar (← CalculatorStatisticsV3.ceilValue x))
  record state (Text.append "generated-function:" name) result
 else if ["sin","cos","tan"].any (Text.equal name) then
  CalculatorMachine.arity name args 1
  let radians ← CalculatorFunctionsV3.toRadians (← CalculatorMachine.argument args 0) state.angleMode
  let result ← if Text.equal name "sin" then CalculatorFunctionsV3.sinValue radians state.places else if Text.equal name "cos" then CalculatorFunctionsV3.cosValue radians state.places else CalculatorFunctionsV3.tanValue radians state.places
  record state (Text.join ["generated-function:",name,":",state.angleMode]) result
 else if ["sum","prod","mean","variance","stddev"].any (Text.equal name) then
  if args.isEmpty then throw (Text.append name " requires at least one generated argument")
  let result ← if Text.equal name "sum" then CalculatorStatisticsV3.exactSum args else if Text.equal name "prod" then CalculatorStatisticsV3.exactProduct args else if Text.equal name "mean" then CalculatorStatisticsV3.arithmeticMean args else if Text.equal name "variance" then CalculatorStatisticsV3.populationVariance args else CalculatorStatisticsV3.populationStddev args
  record state (Text.append "generated-function:" name) result
 else if ["gcd","lcm","mod","hypot","pow","root"].any (Text.equal name) then
  CalculatorMachine.arity name args 2
  let a ← CalculatorMachine.argument args 0
  let b ← CalculatorMachine.argument args 1
  let result ←
   if Text.equal name "gcd" then pure (.scalar (← CalculatorStatisticsV3.gcdValue a b))
   else if Text.equal name "lcm" then pure (.scalar (← CalculatorStatisticsV3.lcmValue a b))
   else if Text.equal name "mod" then pure (.scalar (← CalculatorStatisticsV3.moduloValue a b))
   else if Text.equal name "pow" then CalculatorFunctionsV3.rationalPower a b state.places
   else if Text.equal name "root" then CalculatorStatisticsV3.rootValue a (Int.ofNat (← CalculatorOperations.requireWhole b false))
   else CalculatorStatisticsV3.rootValue (← CalculatorOperations.add (← CalculatorOperations.multiply a a) (← CalculatorOperations.multiply b b)) 2
  record state (Text.append "generated-function:" name) result
 else if Text.equal name "log" then
  if args.length == 1 then record state "generated-function:log10" (← CalculatorFunctionsV3.logBase (← CalculatorMachine.argument args 0) (.scalar (← forward (CalculatorSeries.natural 10))) state.places)
  else if args.length == 2 then record state "generated-function:log-base" (← CalculatorFunctionsV3.logBase (← CalculatorMachine.argument args 0) (← CalculatorMachine.argument args 1) state.places)
  else throw "log requires one value or one value and one base"
 else if Text.equal name "ln" then
  CalculatorMachine.arity name args 1
  record state "generated-function:ln" (← CalculatorFunctionsV3.lnValue (← CalculatorMachine.argument args 0) state.places)
 else
  let (value,base) ← CalculatorMachine.call state.toState name args
  pure (value,{state with toState := base})
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
def calculate (input : String) (places : Int := 18) (operationLimit : Int := 10000) (angleMode : String := "rad") (symbols : List (String × Value) := []) : Except String CalculatorMachine.Calculation := do
 if places < 1 || places > 60 then throw "display precision must be a counted value from 1 through 60"
 if operationLimit < 1 then throw "operation limit must be a positive count"
 if !(["rad","deg","grad"].any (Text.equal angleMode)) then throw "angle mode must be rad, deg or grad"
 let stripped := LeptonDecimal.strip (Text.chars input)
 let stripped := if stripped.reverse.head? == some '=' then LeptonDecimal.strip (stripped.take (stripped.length-1)) else stripped
 if stripped.any (fun c => c == '=') then throw "equals is a terminal execute key, not an internal operator"
 let tokens ← CalculatorLexer.lex (String.ofList stripped)
 let initial : State := {toState := ⟨tokens,0,["boundary:decimal-notation-translated-to-exact-Fold-forms"],0,places,operationLimit.toNat⟩,angleMode := angleMode,symbols := symbols.map (fun (k,v) => (Text.lowerAscii k,v))}
 let (value,final) ← expression (8*(tokens.length+1)) initial
 if final.position != tokens.length then
  let (token,_) ← take final
  throw (Text.join ["unexpected token '",token.text,"'"])
 pure ⟨input,value,final.trace++["halt:complete-generated-expression-consumed"],tokens.length,final.operations⟩
end SFT.Mathematics.CalculatorMachineV3
