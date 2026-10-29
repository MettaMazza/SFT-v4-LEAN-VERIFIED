import SFT.Computation.Synchronization
open SFT.Computation.Synchronization
def p0 : Participant := ⟨"p0",⟨["ready","released","other"],["go","wait"],[("ready","go","released")]⟩,"ready"⟩
def p1 : Participant := ⟨"p1",⟨["ready","released","other"],["go","wait"],[]⟩,"ready"⟩
def p2 : Participant := ⟨"p2",⟨["ready","released","other"],["go","wait"],[("ready","go","released"),("ready","go","other")]⟩,"ready"⟩
def p3 : Participant := ⟨"p3",⟨["ready","released","other"],["go","wait"],[("ready","wait","released")]⟩,"ready"⟩
example : release "go" [] = some [] := rfl
example : (blocked (ledger "go" [])).length = 0 := rfl
example : release "go" [p0] = some [{p0 with state := "released"}] := rfl
example : (blocked (ledger "go" [p0])).length = 0 := rfl
example : release "go" [p1] = none := rfl
example : (blocked (ledger "go" [p1])).length = 1 := rfl
example : release "go" [p2] = none := rfl
example : (blocked (ledger "go" [p2])).length = 1 := rfl
example : release "go" [p3] = none := rfl
example : (blocked (ledger "go" [p3])).length = 1 := rfl
example : release "go" [p0,p0] = some [{p0 with state := "released"},{p0 with state := "released"}] := rfl
example : (blocked (ledger "go" [p0,p0])).length = 0 := rfl
example : release "go" [p0,p1] = none := rfl
example : (blocked (ledger "go" [p0,p1])).length = 1 := rfl
example : release "go" [p0,p2] = none := rfl
example : (blocked (ledger "go" [p0,p2])).length = 1 := rfl
example : release "go" [p0,p3] = none := rfl
example : (blocked (ledger "go" [p0,p3])).length = 1 := rfl
example : release "go" [p1,p0] = none := rfl
example : (blocked (ledger "go" [p1,p0])).length = 1 := rfl
example : release "go" [p1,p1] = none := rfl
example : (blocked (ledger "go" [p1,p1])).length = 2 := rfl
example : release "go" [p1,p2] = none := rfl
example : (blocked (ledger "go" [p1,p2])).length = 2 := rfl
example : release "go" [p1,p3] = none := rfl
example : (blocked (ledger "go" [p1,p3])).length = 2 := rfl
example : release "go" [p2,p0] = none := rfl
example : (blocked (ledger "go" [p2,p0])).length = 1 := rfl
example : release "go" [p2,p1] = none := rfl
example : (blocked (ledger "go" [p2,p1])).length = 2 := rfl
example : release "go" [p2,p2] = none := rfl
example : (blocked (ledger "go" [p2,p2])).length = 2 := rfl
example : release "go" [p2,p3] = none := rfl
example : (blocked (ledger "go" [p2,p3])).length = 2 := rfl
example : release "go" [p3,p0] = none := rfl
example : (blocked (ledger "go" [p3,p0])).length = 1 := rfl
example : release "go" [p3,p1] = none := rfl
example : (blocked (ledger "go" [p3,p1])).length = 2 := rfl
example : release "go" [p3,p2] = none := rfl
example : (blocked (ledger "go" [p3,p2])).length = 2 := rfl
example : release "go" [p3,p3] = none := rfl
example : (blocked (ledger "go" [p3,p3])).length = 2 := rfl
example : release "go" [p0,p0,p0] = some [{p0 with state := "released"},{p0 with state := "released"},{p0 with state := "released"}] := rfl
example : (blocked (ledger "go" [p0,p0,p0])).length = 0 := rfl
example : release "go" [p0,p0,p1] = none := rfl
example : (blocked (ledger "go" [p0,p0,p1])).length = 1 := rfl
example : release "go" [p0,p0,p2] = none := rfl
example : (blocked (ledger "go" [p0,p0,p2])).length = 1 := rfl
example : release "go" [p0,p0,p3] = none := rfl
example : (blocked (ledger "go" [p0,p0,p3])).length = 1 := rfl
example : release "go" [p0,p1,p0] = none := rfl
example : (blocked (ledger "go" [p0,p1,p0])).length = 1 := rfl
example : release "go" [p0,p1,p1] = none := rfl
example : (blocked (ledger "go" [p0,p1,p1])).length = 2 := rfl
example : release "go" [p0,p1,p2] = none := rfl
example : (blocked (ledger "go" [p0,p1,p2])).length = 2 := rfl
example : release "go" [p0,p1,p3] = none := rfl
example : (blocked (ledger "go" [p0,p1,p3])).length = 2 := rfl
example : release "go" [p0,p2,p0] = none := rfl
example : (blocked (ledger "go" [p0,p2,p0])).length = 1 := rfl
example : release "go" [p0,p2,p1] = none := rfl
example : (blocked (ledger "go" [p0,p2,p1])).length = 2 := rfl
example : release "go" [p0,p2,p2] = none := rfl
example : (blocked (ledger "go" [p0,p2,p2])).length = 2 := rfl
example : release "go" [p0,p2,p3] = none := rfl
example : (blocked (ledger "go" [p0,p2,p3])).length = 2 := rfl
example : release "go" [p0,p3,p0] = none := rfl
example : (blocked (ledger "go" [p0,p3,p0])).length = 1 := rfl
example : release "go" [p0,p3,p1] = none := rfl
example : (blocked (ledger "go" [p0,p3,p1])).length = 2 := rfl
example : release "go" [p0,p3,p2] = none := rfl
example : (blocked (ledger "go" [p0,p3,p2])).length = 2 := rfl
example : release "go" [p0,p3,p3] = none := rfl
example : (blocked (ledger "go" [p0,p3,p3])).length = 2 := rfl
example : release "go" [p1,p0,p0] = none := rfl
example : (blocked (ledger "go" [p1,p0,p0])).length = 1 := rfl
example : release "go" [p1,p0,p1] = none := rfl
example : (blocked (ledger "go" [p1,p0,p1])).length = 2 := rfl
example : release "go" [p1,p0,p2] = none := rfl
example : (blocked (ledger "go" [p1,p0,p2])).length = 2 := rfl
example : release "go" [p1,p0,p3] = none := rfl
example : (blocked (ledger "go" [p1,p0,p3])).length = 2 := rfl
example : release "go" [p1,p1,p0] = none := rfl
example : (blocked (ledger "go" [p1,p1,p0])).length = 2 := rfl
example : release "go" [p1,p1,p1] = none := rfl
example : (blocked (ledger "go" [p1,p1,p1])).length = 3 := rfl
example : release "go" [p1,p1,p2] = none := rfl
example : (blocked (ledger "go" [p1,p1,p2])).length = 3 := rfl
example : release "go" [p1,p1,p3] = none := rfl
example : (blocked (ledger "go" [p1,p1,p3])).length = 3 := rfl
example : release "go" [p1,p2,p0] = none := rfl
example : (blocked (ledger "go" [p1,p2,p0])).length = 2 := rfl
example : release "go" [p1,p2,p1] = none := rfl
example : (blocked (ledger "go" [p1,p2,p1])).length = 3 := rfl
example : release "go" [p1,p2,p2] = none := rfl
example : (blocked (ledger "go" [p1,p2,p2])).length = 3 := rfl
example : release "go" [p1,p2,p3] = none := rfl
example : (blocked (ledger "go" [p1,p2,p3])).length = 3 := rfl
example : release "go" [p1,p3,p0] = none := rfl
example : (blocked (ledger "go" [p1,p3,p0])).length = 2 := rfl
example : release "go" [p1,p3,p1] = none := rfl
example : (blocked (ledger "go" [p1,p3,p1])).length = 3 := rfl
example : release "go" [p1,p3,p2] = none := rfl
example : (blocked (ledger "go" [p1,p3,p2])).length = 3 := rfl
example : release "go" [p1,p3,p3] = none := rfl
example : (blocked (ledger "go" [p1,p3,p3])).length = 3 := rfl
example : release "go" [p2,p0,p0] = none := rfl
example : (blocked (ledger "go" [p2,p0,p0])).length = 1 := rfl
example : release "go" [p2,p0,p1] = none := rfl
example : (blocked (ledger "go" [p2,p0,p1])).length = 2 := rfl
example : release "go" [p2,p0,p2] = none := rfl
example : (blocked (ledger "go" [p2,p0,p2])).length = 2 := rfl
example : release "go" [p2,p0,p3] = none := rfl
example : (blocked (ledger "go" [p2,p0,p3])).length = 2 := rfl
example : release "go" [p2,p1,p0] = none := rfl
example : (blocked (ledger "go" [p2,p1,p0])).length = 2 := rfl
example : release "go" [p2,p1,p1] = none := rfl
example : (blocked (ledger "go" [p2,p1,p1])).length = 3 := rfl
example : release "go" [p2,p1,p2] = none := rfl
example : (blocked (ledger "go" [p2,p1,p2])).length = 3 := rfl
example : release "go" [p2,p1,p3] = none := rfl
example : (blocked (ledger "go" [p2,p1,p3])).length = 3 := rfl
example : release "go" [p2,p2,p0] = none := rfl
example : (blocked (ledger "go" [p2,p2,p0])).length = 2 := rfl
example : release "go" [p2,p2,p1] = none := rfl
example : (blocked (ledger "go" [p2,p2,p1])).length = 3 := rfl
example : release "go" [p2,p2,p2] = none := rfl
example : (blocked (ledger "go" [p2,p2,p2])).length = 3 := rfl
example : release "go" [p2,p2,p3] = none := rfl
example : (blocked (ledger "go" [p2,p2,p3])).length = 3 := rfl
example : release "go" [p2,p3,p0] = none := rfl
example : (blocked (ledger "go" [p2,p3,p0])).length = 2 := rfl
example : release "go" [p2,p3,p1] = none := rfl
example : (blocked (ledger "go" [p2,p3,p1])).length = 3 := rfl
example : release "go" [p2,p3,p2] = none := rfl
example : (blocked (ledger "go" [p2,p3,p2])).length = 3 := rfl
example : release "go" [p2,p3,p3] = none := rfl
example : (blocked (ledger "go" [p2,p3,p3])).length = 3 := rfl
example : release "go" [p3,p0,p0] = none := rfl
example : (blocked (ledger "go" [p3,p0,p0])).length = 1 := rfl
example : release "go" [p3,p0,p1] = none := rfl
example : (blocked (ledger "go" [p3,p0,p1])).length = 2 := rfl
example : release "go" [p3,p0,p2] = none := rfl
example : (blocked (ledger "go" [p3,p0,p2])).length = 2 := rfl
example : release "go" [p3,p0,p3] = none := rfl
example : (blocked (ledger "go" [p3,p0,p3])).length = 2 := rfl
example : release "go" [p3,p1,p0] = none := rfl
example : (blocked (ledger "go" [p3,p1,p0])).length = 2 := rfl
example : release "go" [p3,p1,p1] = none := rfl
example : (blocked (ledger "go" [p3,p1,p1])).length = 3 := rfl
example : release "go" [p3,p1,p2] = none := rfl
example : (blocked (ledger "go" [p3,p1,p2])).length = 3 := rfl
example : release "go" [p3,p1,p3] = none := rfl
example : (blocked (ledger "go" [p3,p1,p3])).length = 3 := rfl
example : release "go" [p3,p2,p0] = none := rfl
example : (blocked (ledger "go" [p3,p2,p0])).length = 2 := rfl
example : release "go" [p3,p2,p1] = none := rfl
example : (blocked (ledger "go" [p3,p2,p1])).length = 3 := rfl
example : release "go" [p3,p2,p2] = none := rfl
example : (blocked (ledger "go" [p3,p2,p2])).length = 3 := rfl
example : release "go" [p3,p2,p3] = none := rfl
example : (blocked (ledger "go" [p3,p2,p3])).length = 3 := rfl
example : release "go" [p3,p3,p0] = none := rfl
example : (blocked (ledger "go" [p3,p3,p0])).length = 2 := rfl
example : release "go" [p3,p3,p1] = none := rfl
example : (blocked (ledger "go" [p3,p3,p1])).length = 3 := rfl
example : release "go" [p3,p3,p2] = none := rfl
example : (blocked (ledger "go" [p3,p3,p2])).length = 3 := rfl
example : release "go" [p3,p3,p3] = none := rfl
example : (blocked (ledger "go" [p3,p3,p3])).length = 3 := rfl
example : release "wait" [] = some [] := rfl
example : (blocked (ledger "wait" [])).length = 0 := rfl
example : release "wait" [p0] = none := rfl
example : (blocked (ledger "wait" [p0])).length = 1 := rfl
example : release "wait" [p1] = none := rfl
example : (blocked (ledger "wait" [p1])).length = 1 := rfl
example : release "wait" [p2] = none := rfl
example : (blocked (ledger "wait" [p2])).length = 1 := rfl
example : release "wait" [p3] = some [{p3 with state := "released"}] := rfl
example : (blocked (ledger "wait" [p3])).length = 0 := rfl
example : release "wait" [p0,p0] = none := rfl
example : (blocked (ledger "wait" [p0,p0])).length = 2 := rfl
example : release "wait" [p0,p1] = none := rfl
example : (blocked (ledger "wait" [p0,p1])).length = 2 := rfl
example : release "wait" [p0,p2] = none := rfl
example : (blocked (ledger "wait" [p0,p2])).length = 2 := rfl
example : release "wait" [p0,p3] = none := rfl
example : (blocked (ledger "wait" [p0,p3])).length = 1 := rfl
example : release "wait" [p1,p0] = none := rfl
example : (blocked (ledger "wait" [p1,p0])).length = 2 := rfl
example : release "wait" [p1,p1] = none := rfl
example : (blocked (ledger "wait" [p1,p1])).length = 2 := rfl
example : release "wait" [p1,p2] = none := rfl
example : (blocked (ledger "wait" [p1,p2])).length = 2 := rfl
example : release "wait" [p1,p3] = none := rfl
example : (blocked (ledger "wait" [p1,p3])).length = 1 := rfl
example : release "wait" [p2,p0] = none := rfl
example : (blocked (ledger "wait" [p2,p0])).length = 2 := rfl
example : release "wait" [p2,p1] = none := rfl
example : (blocked (ledger "wait" [p2,p1])).length = 2 := rfl
example : release "wait" [p2,p2] = none := rfl
example : (blocked (ledger "wait" [p2,p2])).length = 2 := rfl
example : release "wait" [p2,p3] = none := rfl
example : (blocked (ledger "wait" [p2,p3])).length = 1 := rfl
example : release "wait" [p3,p0] = none := rfl
example : (blocked (ledger "wait" [p3,p0])).length = 1 := rfl
example : release "wait" [p3,p1] = none := rfl
example : (blocked (ledger "wait" [p3,p1])).length = 1 := rfl
example : release "wait" [p3,p2] = none := rfl
example : (blocked (ledger "wait" [p3,p2])).length = 1 := rfl
example : release "wait" [p3,p3] = some [{p3 with state := "released"},{p3 with state := "released"}] := rfl
example : (blocked (ledger "wait" [p3,p3])).length = 0 := rfl
example : release "wait" [p0,p0,p0] = none := rfl
example : (blocked (ledger "wait" [p0,p0,p0])).length = 3 := rfl
example : release "wait" [p0,p0,p1] = none := rfl
example : (blocked (ledger "wait" [p0,p0,p1])).length = 3 := rfl
example : release "wait" [p0,p0,p2] = none := rfl
example : (blocked (ledger "wait" [p0,p0,p2])).length = 3 := rfl
example : release "wait" [p0,p0,p3] = none := rfl
example : (blocked (ledger "wait" [p0,p0,p3])).length = 2 := rfl
example : release "wait" [p0,p1,p0] = none := rfl
example : (blocked (ledger "wait" [p0,p1,p0])).length = 3 := rfl
example : release "wait" [p0,p1,p1] = none := rfl
example : (blocked (ledger "wait" [p0,p1,p1])).length = 3 := rfl
example : release "wait" [p0,p1,p2] = none := rfl
example : (blocked (ledger "wait" [p0,p1,p2])).length = 3 := rfl
example : release "wait" [p0,p1,p3] = none := rfl
example : (blocked (ledger "wait" [p0,p1,p3])).length = 2 := rfl
example : release "wait" [p0,p2,p0] = none := rfl
example : (blocked (ledger "wait" [p0,p2,p0])).length = 3 := rfl
example : release "wait" [p0,p2,p1] = none := rfl
example : (blocked (ledger "wait" [p0,p2,p1])).length = 3 := rfl
example : release "wait" [p0,p2,p2] = none := rfl
example : (blocked (ledger "wait" [p0,p2,p2])).length = 3 := rfl
example : release "wait" [p0,p2,p3] = none := rfl
example : (blocked (ledger "wait" [p0,p2,p3])).length = 2 := rfl
example : release "wait" [p0,p3,p0] = none := rfl
example : (blocked (ledger "wait" [p0,p3,p0])).length = 2 := rfl
example : release "wait" [p0,p3,p1] = none := rfl
example : (blocked (ledger "wait" [p0,p3,p1])).length = 2 := rfl
example : release "wait" [p0,p3,p2] = none := rfl
example : (blocked (ledger "wait" [p0,p3,p2])).length = 2 := rfl
example : release "wait" [p0,p3,p3] = none := rfl
example : (blocked (ledger "wait" [p0,p3,p3])).length = 1 := rfl
example : release "wait" [p1,p0,p0] = none := rfl
example : (blocked (ledger "wait" [p1,p0,p0])).length = 3 := rfl
example : release "wait" [p1,p0,p1] = none := rfl
example : (blocked (ledger "wait" [p1,p0,p1])).length = 3 := rfl
example : release "wait" [p1,p0,p2] = none := rfl
example : (blocked (ledger "wait" [p1,p0,p2])).length = 3 := rfl
example : release "wait" [p1,p0,p3] = none := rfl
example : (blocked (ledger "wait" [p1,p0,p3])).length = 2 := rfl
example : release "wait" [p1,p1,p0] = none := rfl
example : (blocked (ledger "wait" [p1,p1,p0])).length = 3 := rfl
example : release "wait" [p1,p1,p1] = none := rfl
example : (blocked (ledger "wait" [p1,p1,p1])).length = 3 := rfl
example : release "wait" [p1,p1,p2] = none := rfl
example : (blocked (ledger "wait" [p1,p1,p2])).length = 3 := rfl
example : release "wait" [p1,p1,p3] = none := rfl
example : (blocked (ledger "wait" [p1,p1,p3])).length = 2 := rfl
example : release "wait" [p1,p2,p0] = none := rfl
example : (blocked (ledger "wait" [p1,p2,p0])).length = 3 := rfl
example : release "wait" [p1,p2,p1] = none := rfl
example : (blocked (ledger "wait" [p1,p2,p1])).length = 3 := rfl
example : release "wait" [p1,p2,p2] = none := rfl
example : (blocked (ledger "wait" [p1,p2,p2])).length = 3 := rfl
example : release "wait" [p1,p2,p3] = none := rfl
example : (blocked (ledger "wait" [p1,p2,p3])).length = 2 := rfl
example : release "wait" [p1,p3,p0] = none := rfl
example : (blocked (ledger "wait" [p1,p3,p0])).length = 2 := rfl
example : release "wait" [p1,p3,p1] = none := rfl
example : (blocked (ledger "wait" [p1,p3,p1])).length = 2 := rfl
example : release "wait" [p1,p3,p2] = none := rfl
example : (blocked (ledger "wait" [p1,p3,p2])).length = 2 := rfl
example : release "wait" [p1,p3,p3] = none := rfl
example : (blocked (ledger "wait" [p1,p3,p3])).length = 1 := rfl
example : release "wait" [p2,p0,p0] = none := rfl
example : (blocked (ledger "wait" [p2,p0,p0])).length = 3 := rfl
example : release "wait" [p2,p0,p1] = none := rfl
example : (blocked (ledger "wait" [p2,p0,p1])).length = 3 := rfl
example : release "wait" [p2,p0,p2] = none := rfl
example : (blocked (ledger "wait" [p2,p0,p2])).length = 3 := rfl
example : release "wait" [p2,p0,p3] = none := rfl
example : (blocked (ledger "wait" [p2,p0,p3])).length = 2 := rfl
example : release "wait" [p2,p1,p0] = none := rfl
example : (blocked (ledger "wait" [p2,p1,p0])).length = 3 := rfl
example : release "wait" [p2,p1,p1] = none := rfl
example : (blocked (ledger "wait" [p2,p1,p1])).length = 3 := rfl
example : release "wait" [p2,p1,p2] = none := rfl
example : (blocked (ledger "wait" [p2,p1,p2])).length = 3 := rfl
example : release "wait" [p2,p1,p3] = none := rfl
example : (blocked (ledger "wait" [p2,p1,p3])).length = 2 := rfl
example : release "wait" [p2,p2,p0] = none := rfl
example : (blocked (ledger "wait" [p2,p2,p0])).length = 3 := rfl
example : release "wait" [p2,p2,p1] = none := rfl
example : (blocked (ledger "wait" [p2,p2,p1])).length = 3 := rfl
example : release "wait" [p2,p2,p2] = none := rfl
example : (blocked (ledger "wait" [p2,p2,p2])).length = 3 := rfl
example : release "wait" [p2,p2,p3] = none := rfl
example : (blocked (ledger "wait" [p2,p2,p3])).length = 2 := rfl
example : release "wait" [p2,p3,p0] = none := rfl
example : (blocked (ledger "wait" [p2,p3,p0])).length = 2 := rfl
example : release "wait" [p2,p3,p1] = none := rfl
example : (blocked (ledger "wait" [p2,p3,p1])).length = 2 := rfl
example : release "wait" [p2,p3,p2] = none := rfl
example : (blocked (ledger "wait" [p2,p3,p2])).length = 2 := rfl
example : release "wait" [p2,p3,p3] = none := rfl
example : (blocked (ledger "wait" [p2,p3,p3])).length = 1 := rfl
example : release "wait" [p3,p0,p0] = none := rfl
example : (blocked (ledger "wait" [p3,p0,p0])).length = 2 := rfl
example : release "wait" [p3,p0,p1] = none := rfl
example : (blocked (ledger "wait" [p3,p0,p1])).length = 2 := rfl
example : release "wait" [p3,p0,p2] = none := rfl
example : (blocked (ledger "wait" [p3,p0,p2])).length = 2 := rfl
example : release "wait" [p3,p0,p3] = none := rfl
example : (blocked (ledger "wait" [p3,p0,p3])).length = 1 := rfl
example : release "wait" [p3,p1,p0] = none := rfl
example : (blocked (ledger "wait" [p3,p1,p0])).length = 2 := rfl
example : release "wait" [p3,p1,p1] = none := rfl
example : (blocked (ledger "wait" [p3,p1,p1])).length = 2 := rfl
example : release "wait" [p3,p1,p2] = none := rfl
example : (blocked (ledger "wait" [p3,p1,p2])).length = 2 := rfl
example : release "wait" [p3,p1,p3] = none := rfl
example : (blocked (ledger "wait" [p3,p1,p3])).length = 1 := rfl
example : release "wait" [p3,p2,p0] = none := rfl
example : (blocked (ledger "wait" [p3,p2,p0])).length = 2 := rfl
example : release "wait" [p3,p2,p1] = none := rfl
example : (blocked (ledger "wait" [p3,p2,p1])).length = 2 := rfl
example : release "wait" [p3,p2,p2] = none := rfl
example : (blocked (ledger "wait" [p3,p2,p2])).length = 2 := rfl
example : release "wait" [p3,p2,p3] = none := rfl
example : (blocked (ledger "wait" [p3,p2,p3])).length = 1 := rfl
example : release "wait" [p3,p3,p0] = none := rfl
example : (blocked (ledger "wait" [p3,p3,p0])).length = 1 := rfl
example : release "wait" [p3,p3,p1] = none := rfl
example : (blocked (ledger "wait" [p3,p3,p1])).length = 1 := rfl
example : release "wait" [p3,p3,p2] = none := rfl
example : (blocked (ledger "wait" [p3,p3,p2])).length = 1 := rfl
example : release "wait" [p3,p3,p3] = some [{p3 with state := "released"},{p3 with state := "released"},{p3 with state := "released"}] := rfl
example : (blocked (ledger "wait" [p3,p3,p3])).length = 0 := rfl
