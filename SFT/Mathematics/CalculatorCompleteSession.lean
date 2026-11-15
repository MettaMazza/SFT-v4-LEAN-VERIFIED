import SFT.Mathematics.CalculatorCompleteMachine
namespace SFT.Mathematics.CalculatorCompleteSession
open SFT.Mathematics SFT.Host CalculatorValues
structure HistoryEntry where
 index : Nat
 expression : String
 angleMode : String
 calculation : CalculatorMachine.Calculation
structure Session where
 places : Int := 18
 angleMode : String := "rad"
 operationLimit : Int := 10000
 memory : Value := .scalar .emptyOne
 answer : Value := .scalar .emptyOne
 history : List HistoryEntry := []
def create (places : Int := 18) (angleMode : String := "rad") (operationLimit : Int := 10000) : Except String Session :=
 if ["rad","deg","grad"].any (Text.equal angleMode) then .ok {places := places,angleMode := angleMode,operationLimit := operationLimit}
 else .error "angle mode must be rad, deg or grad"
def setAngleMode (session : Session) (mode : String) : Except String Session :=
 if ["rad","deg","grad"].any (Text.equal mode) then .ok {session with angleMode := mode}
 else .error "angle mode must be rad, deg or grad"
def evaluate (session : Session) (expression : String) : Except String (CalculatorMachine.Calculation × Session) := do
 let calculation ← CalculatorCompleteMachine.calculateWithSymbols expression session.places session.operationLimit session.angleMode [("ans",session.answer),("mem",session.memory)]
 let entry : HistoryEntry := ⟨session.history.length+1,expression,session.angleMode,calculation⟩
 pure (calculation,{session with answer := calculation.value,history := session.history ++ [entry]})
def memoryStore (session : Session) (value : Option Value := none) : Value × Session :=
 let selected := value.getD session.answer
 (selected,{session with memory := selected})
def memoryClear (session : Session) : Value × Session :=
 (.scalar .emptyOne,{session with memory := .scalar .emptyOne})
def memoryAdd (session : Session) (value : Option Value := none) : Except String (Value × Session) := do
 let selected ← CalculatorOperations.add session.memory (value.getD session.answer)
 pure (selected,{session with memory := selected})
def memorySubtract (session : Session) (value : Option Value := none) : Except String (Value × Session) := do
 let selected ← CalculatorOperations.subtract session.memory (value.getD session.answer)
 pure (selected,{session with memory := selected})
def clearHistory (session : Session) : Session := {session with history := []}
def allClear (session : Session) : Session := {session with answer := .scalar .emptyOne}
end SFT.Mathematics.CalculatorCompleteSession
