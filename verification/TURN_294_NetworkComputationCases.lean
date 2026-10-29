import SFT.Computation.NetworkComputation
open SFT.Computation SFT.Computation.NetworkComputation
def machine : StateTransition.System := ⟨["s0","s1"],["go"],[("s0","go","s1")]⟩
def p : LocalMachine := ⟨"p",machine⟩
def q : LocalMachine := ⟨"q",machine⟩
def fault : FaultModel.Fault := ⟨"f",⟨"q","fault","s0","s1"⟩,"alert"⟩
def a : Action := ⟨"p","s0","go","s1",["r"],[]⟩
def b : Action := ⟨"q","s0","go","s1",[],[fault]⟩
def sent : Communication.Event := ⟨"send","p","m","x"⟩
def received : Communication.Event := ⟨"receive","q","m","x"⟩
def channel : Communication.ChannelRow := ⟨"p","q","x","x"⟩
def delivery : Communication.Delivery := ⟨sent,received,channel⟩
def net : Network := ⟨[p,q],[sent],[received],[channel],[a,b],[[a,b],[b,a]],["r"],[fault]⟩
def initial : List Node := [⟨"p","s0"⟩,⟨"q","s0"⟩]
def middle : List Node := [⟨"p","s1"⟩,⟨"q","s0"⟩]
def finalNodes : List Node := [⟨"p","s1"⟩,⟨"q","s1"⟩]
theorem aAdmitted : ActionAdmitted net a := by
  refine ⟨.head _,⟨p,.head _,rfl,rfl⟩,?_,?_⟩
  · intro r held; exact held
  · intro f held; cases held
 theorem bAdmitted : ActionAdmitted net b := by
  refine ⟨.tail _ (.head _),⟨q,.tail _ (.head _),rfl,rfl⟩,?_,?_⟩
  · intro r held; cases held
  · intro f held; exact held
 theorem nativeTrace : Trace net initial [a,b] [initial,middle] finalNodes :=
  .next _ _ _ _ _ _ aAdmitted (.here _) (.next _ _ _ _ _ _ bAdmitted (.later _ _ _ (.here _)) (.identity _))
 theorem nativeDelivery : DeliveryAdmitted net delivery :=
  ⟨⟨.head _,.head _,.head _,rfl⟩,⟨p,.head _,rfl⟩,⟨q,.tail _ (.head _),rfl⟩⟩
def execution : Execution net where
  initial := initial
  actions := [a,b]
  states := [initial,middle]
  result := finalNodes
  messages := [delivery]
  schedule := .head _
  trace := nativeTrace
  deliveries := by
    intro d held; cases held with
    | head => exact nativeDelivery
    | tail _ held => cases held
  initialSupport := by
    intro node held; cases held with
    | head => exact ⟨p,.head _,rfl⟩
    | tail _ held => cases held with
      | head => exact ⟨q,.tail _ (.head _),rfl⟩
      | tail _ held => cases held
example : resourceLedger execution.actions = ["r"] := rfl
example : faultLedger execution.actions = [fault] := rfl
example : execution.result.map Node.process = ["p","q"] := rfl
example : execution.result.map Node.state = ["s1","s1"] := rfl
example : StateTransition.step machine "s1" "go" = .error "ValueError: the requested transition is not exactly generated" := rfl
example : Communication.compatible {delivery with received := {received with message := "other"}} = false := rfl
example : Communication.deliveries [sent] [received] [] = [] := rfl
example : Communication.deliveries [] [received] [channel] = [] := rfl
#print axioms nativeTrace
#print axioms nativeDelivery
#print axioms execution
