import SFT.Computation.Multiparty
namespace SFT.Computation.Multiparty
def system : StateTransition.System := ⟨["q"],["step"],[("q","step","q")]⟩
def ia : Input := ⟨"alice","0"⟩
def ib : Input := ⟨"bob","0"⟩
def ic : Input := ⟨"bob","1"⟩
def a0 : Row := ⟨[ia,ib],"out",[("alice","v"),("bob","v")]⟩
def b0 : Row := ⟨[ia,ic],"out",[("alice","v"),("bob","v")]⟩
def m0_0_0_0 : Model := ⟨["alice","bob"],[ia],[],system,[[]]⟩
example : rows m0_0_0_0 = [] := by decide
example : leakageLedger m0_0_0_0 [] = [] := by decide
example : secure m0_0_0_0 = true := by decide
def m0_0_0_1 : Model := ⟨["alice","bob"],[ia],[],system,[["alice"]]⟩
example : rows m0_0_0_1 = [] := by decide
example : leakageLedger m0_0_0_1 ["alice"] = [] := by decide
example : secure m0_0_0_1 = true := by decide
def m0_0_0_2 : Model := ⟨["alice","bob"],[ia],[],system,[["bob"]]⟩
example : rows m0_0_0_2 = [] := by decide
example : leakageLedger m0_0_0_2 ["bob"] = [] := by decide
example : secure m0_0_0_2 = true := by decide
def m0_0_0_3 : Model := ⟨["alice","bob"],[ia],[],system,[["alice","bob"]]⟩
example : rows m0_0_0_3 = [] := by decide
example : leakageLedger m0_0_0_3 ["alice","bob"] = [] := by decide
example : secure m0_0_0_3 = true := by decide
def m0_0_1_0 : Model := ⟨["alice","bob"],[ia],[a0],system,[[]]⟩
example : rows m0_0_1_0 = [] := by decide
example : leakageLedger m0_0_1_0 [] = [] := by decide
example : secure m0_0_1_0 = true := by decide
def m0_0_1_1 : Model := ⟨["alice","bob"],[ia],[a0],system,[["alice"]]⟩
example : rows m0_0_1_1 = [] := by decide
example : leakageLedger m0_0_1_1 ["alice"] = [] := by decide
example : secure m0_0_1_1 = true := by decide
def m0_0_1_2 : Model := ⟨["alice","bob"],[ia],[a0],system,[["bob"]]⟩
example : rows m0_0_1_2 = [] := by decide
example : leakageLedger m0_0_1_2 ["bob"] = [] := by decide
example : secure m0_0_1_2 = true := by decide
def m0_0_1_3 : Model := ⟨["alice","bob"],[ia],[a0],system,[["alice","bob"]]⟩
example : rows m0_0_1_3 = [] := by decide
example : leakageLedger m0_0_1_3 ["alice","bob"] = [] := by decide
example : secure m0_0_1_3 = true := by decide
def m0_0_2_0 : Model := ⟨["alice","bob"],[ia],[b0],system,[[]]⟩
example : rows m0_0_2_0 = [] := by decide
example : leakageLedger m0_0_2_0 [] = [] := by decide
example : secure m0_0_2_0 = true := by decide
def m0_0_2_1 : Model := ⟨["alice","bob"],[ia],[b0],system,[["alice"]]⟩
example : rows m0_0_2_1 = [] := by decide
example : leakageLedger m0_0_2_1 ["alice"] = [] := by decide
example : secure m0_0_2_1 = true := by decide
def m0_0_2_2 : Model := ⟨["alice","bob"],[ia],[b0],system,[["bob"]]⟩
example : rows m0_0_2_2 = [] := by decide
example : leakageLedger m0_0_2_2 ["bob"] = [] := by decide
example : secure m0_0_2_2 = true := by decide
def m0_0_2_3 : Model := ⟨["alice","bob"],[ia],[b0],system,[["alice","bob"]]⟩
example : rows m0_0_2_3 = [] := by decide
example : leakageLedger m0_0_2_3 ["alice","bob"] = [] := by decide
example : secure m0_0_2_3 = true := by decide
def m0_0_3_0 : Model := ⟨["alice","bob"],[ia],[a0,b0],system,[[]]⟩
example : rows m0_0_3_0 = [] := by decide
example : leakageLedger m0_0_3_0 [] = [] := by decide
example : secure m0_0_3_0 = true := by decide
def m0_0_3_1 : Model := ⟨["alice","bob"],[ia],[a0,b0],system,[["alice"]]⟩
example : rows m0_0_3_1 = [] := by decide
example : leakageLedger m0_0_3_1 ["alice"] = [] := by decide
example : secure m0_0_3_1 = true := by decide
def m0_0_3_2 : Model := ⟨["alice","bob"],[ia],[a0,b0],system,[["bob"]]⟩
example : rows m0_0_3_2 = [] := by decide
example : leakageLedger m0_0_3_2 ["bob"] = [] := by decide
example : secure m0_0_3_2 = true := by decide
def m0_0_3_3 : Model := ⟨["alice","bob"],[ia],[a0,b0],system,[["alice","bob"]]⟩
example : rows m0_0_3_3 = [] := by decide
example : leakageLedger m0_0_3_3 ["alice","bob"] = [] := by decide
example : secure m0_0_3_3 = true := by decide
def m0_1_0_0 : Model := ⟨["alice","bob"],[ia,ib],[],system,[[]]⟩
example : rows m0_1_0_0 = [] := by decide
example : leakageLedger m0_1_0_0 [] = [] := by decide
example : secure m0_1_0_0 = true := by decide
def m0_1_0_1 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice"]]⟩
example : rows m0_1_0_1 = [] := by decide
example : leakageLedger m0_1_0_1 ["alice"] = [] := by decide
example : secure m0_1_0_1 = true := by decide
def m0_1_0_2 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["bob"]]⟩
example : rows m0_1_0_2 = [] := by decide
example : leakageLedger m0_1_0_2 ["bob"] = [] := by decide
example : secure m0_1_0_2 = true := by decide
def m0_1_0_3 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice","bob"]]⟩
example : rows m0_1_0_3 = [] := by decide
example : leakageLedger m0_1_0_3 ["alice","bob"] = [] := by decide
example : secure m0_1_0_3 = true := by decide
def m0_1_1_0 : Model := ⟨["alice","bob"],[ia,ib],[a0],system,[[]]⟩
example : rows m0_1_1_0 = [a0] := by decide
example : leakageLedger m0_1_1_0 [] = [] := by decide
example : secure m0_1_1_0 = true := by decide
def m0_1_1_1 : Model := ⟨["alice","bob"],[ia,ib],[a0],system,[["alice"]]⟩
example : rows m0_1_1_1 = [a0] := by decide
example : leakageLedger m0_1_1_1 ["alice"] = [] := by decide
example : secure m0_1_1_1 = true := by decide
def m0_1_1_2 : Model := ⟨["alice","bob"],[ia,ib],[a0],system,[["bob"]]⟩
example : rows m0_1_1_2 = [a0] := by decide
example : leakageLedger m0_1_1_2 ["bob"] = [] := by decide
example : secure m0_1_1_2 = true := by decide
def m0_1_1_3 : Model := ⟨["alice","bob"],[ia,ib],[a0],system,[["alice","bob"]]⟩
example : rows m0_1_1_3 = [a0] := by decide
example : leakageLedger m0_1_1_3 ["alice","bob"] = [] := by decide
example : secure m0_1_1_3 = true := by decide
def m0_1_2_0 : Model := ⟨["alice","bob"],[ia,ib],[b0],system,[[]]⟩
example : rows m0_1_2_0 = [] := by decide
example : leakageLedger m0_1_2_0 [] = [] := by decide
example : secure m0_1_2_0 = true := by decide
def m0_1_2_1 : Model := ⟨["alice","bob"],[ia,ib],[b0],system,[["alice"]]⟩
example : rows m0_1_2_1 = [] := by decide
example : leakageLedger m0_1_2_1 ["alice"] = [] := by decide
example : secure m0_1_2_1 = true := by decide
def m0_1_2_2 : Model := ⟨["alice","bob"],[ia,ib],[b0],system,[["bob"]]⟩
example : rows m0_1_2_2 = [] := by decide
example : leakageLedger m0_1_2_2 ["bob"] = [] := by decide
example : secure m0_1_2_2 = true := by decide
def m0_1_2_3 : Model := ⟨["alice","bob"],[ia,ib],[b0],system,[["alice","bob"]]⟩
example : rows m0_1_2_3 = [] := by decide
example : leakageLedger m0_1_2_3 ["alice","bob"] = [] := by decide
example : secure m0_1_2_3 = true := by decide
def m0_1_3_0 : Model := ⟨["alice","bob"],[ia,ib],[a0,b0],system,[[]]⟩
example : rows m0_1_3_0 = [a0] := by decide
example : leakageLedger m0_1_3_0 [] = [] := by decide
example : secure m0_1_3_0 = true := by decide
def m0_1_3_1 : Model := ⟨["alice","bob"],[ia,ib],[a0,b0],system,[["alice"]]⟩
example : rows m0_1_3_1 = [a0] := by decide
example : leakageLedger m0_1_3_1 ["alice"] = [] := by decide
example : secure m0_1_3_1 = true := by decide
def m0_1_3_2 : Model := ⟨["alice","bob"],[ia,ib],[a0,b0],system,[["bob"]]⟩
example : rows m0_1_3_2 = [a0] := by decide
example : leakageLedger m0_1_3_2 ["bob"] = [] := by decide
example : secure m0_1_3_2 = true := by decide
def m0_1_3_3 : Model := ⟨["alice","bob"],[ia,ib],[a0,b0],system,[["alice","bob"]]⟩
example : rows m0_1_3_3 = [a0] := by decide
example : leakageLedger m0_1_3_3 ["alice","bob"] = [] := by decide
example : secure m0_1_3_3 = true := by decide
def m0_2_0_0 : Model := ⟨["alice","bob"],[ia,ic],[],system,[[]]⟩
example : rows m0_2_0_0 = [] := by decide
example : leakageLedger m0_2_0_0 [] = [] := by decide
example : secure m0_2_0_0 = true := by decide
def m0_2_0_1 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice"]]⟩
example : rows m0_2_0_1 = [] := by decide
example : leakageLedger m0_2_0_1 ["alice"] = [] := by decide
example : secure m0_2_0_1 = true := by decide
def m0_2_0_2 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["bob"]]⟩
example : rows m0_2_0_2 = [] := by decide
example : leakageLedger m0_2_0_2 ["bob"] = [] := by decide
example : secure m0_2_0_2 = true := by decide
def m0_2_0_3 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice","bob"]]⟩
example : rows m0_2_0_3 = [] := by decide
example : leakageLedger m0_2_0_3 ["alice","bob"] = [] := by decide
example : secure m0_2_0_3 = true := by decide
def m0_2_1_0 : Model := ⟨["alice","bob"],[ia,ic],[a0],system,[[]]⟩
example : rows m0_2_1_0 = [] := by decide
example : leakageLedger m0_2_1_0 [] = [] := by decide
example : secure m0_2_1_0 = true := by decide
def m0_2_1_1 : Model := ⟨["alice","bob"],[ia,ic],[a0],system,[["alice"]]⟩
example : rows m0_2_1_1 = [] := by decide
example : leakageLedger m0_2_1_1 ["alice"] = [] := by decide
example : secure m0_2_1_1 = true := by decide
def m0_2_1_2 : Model := ⟨["alice","bob"],[ia,ic],[a0],system,[["bob"]]⟩
example : rows m0_2_1_2 = [] := by decide
example : leakageLedger m0_2_1_2 ["bob"] = [] := by decide
example : secure m0_2_1_2 = true := by decide
def m0_2_1_3 : Model := ⟨["alice","bob"],[ia,ic],[a0],system,[["alice","bob"]]⟩
example : rows m0_2_1_3 = [] := by decide
example : leakageLedger m0_2_1_3 ["alice","bob"] = [] := by decide
example : secure m0_2_1_3 = true := by decide
def m0_2_2_0 : Model := ⟨["alice","bob"],[ia,ic],[b0],system,[[]]⟩
example : rows m0_2_2_0 = [b0] := by decide
example : leakageLedger m0_2_2_0 [] = [] := by decide
example : secure m0_2_2_0 = true := by decide
def m0_2_2_1 : Model := ⟨["alice","bob"],[ia,ic],[b0],system,[["alice"]]⟩
example : rows m0_2_2_1 = [b0] := by decide
example : leakageLedger m0_2_2_1 ["alice"] = [] := by decide
example : secure m0_2_2_1 = true := by decide
def m0_2_2_2 : Model := ⟨["alice","bob"],[ia,ic],[b0],system,[["bob"]]⟩
example : rows m0_2_2_2 = [b0] := by decide
example : leakageLedger m0_2_2_2 ["bob"] = [] := by decide
example : secure m0_2_2_2 = true := by decide
def m0_2_2_3 : Model := ⟨["alice","bob"],[ia,ic],[b0],system,[["alice","bob"]]⟩
example : rows m0_2_2_3 = [b0] := by decide
example : leakageLedger m0_2_2_3 ["alice","bob"] = [] := by decide
example : secure m0_2_2_3 = true := by decide
def m0_2_3_0 : Model := ⟨["alice","bob"],[ia,ic],[a0,b0],system,[[]]⟩
example : rows m0_2_3_0 = [b0] := by decide
example : leakageLedger m0_2_3_0 [] = [] := by decide
example : secure m0_2_3_0 = true := by decide
def m0_2_3_1 : Model := ⟨["alice","bob"],[ia,ic],[a0,b0],system,[["alice"]]⟩
example : rows m0_2_3_1 = [b0] := by decide
example : leakageLedger m0_2_3_1 ["alice"] = [] := by decide
example : secure m0_2_3_1 = true := by decide
def m0_2_3_2 : Model := ⟨["alice","bob"],[ia,ic],[a0,b0],system,[["bob"]]⟩
example : rows m0_2_3_2 = [b0] := by decide
example : leakageLedger m0_2_3_2 ["bob"] = [] := by decide
example : secure m0_2_3_2 = true := by decide
def m0_2_3_3 : Model := ⟨["alice","bob"],[ia,ic],[a0,b0],system,[["alice","bob"]]⟩
example : rows m0_2_3_3 = [b0] := by decide
example : leakageLedger m0_2_3_3 ["alice","bob"] = [] := by decide
example : secure m0_2_3_3 = true := by decide
def m0_3_0_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[[]]⟩
example : rows m0_3_0_0 = [] := by decide
example : leakageLedger m0_3_0_0 [] = [] := by decide
example : secure m0_3_0_0 = true := by decide
def m0_3_0_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice"]]⟩
example : rows m0_3_0_1 = [] := by decide
example : leakageLedger m0_3_0_1 ["alice"] = [] := by decide
example : secure m0_3_0_1 = true := by decide
def m0_3_0_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["bob"]]⟩
example : rows m0_3_0_2 = [] := by decide
example : leakageLedger m0_3_0_2 ["bob"] = [] := by decide
example : secure m0_3_0_2 = true := by decide
def m0_3_0_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice","bob"]]⟩
example : rows m0_3_0_3 = [] := by decide
example : leakageLedger m0_3_0_3 ["alice","bob"] = [] := by decide
example : secure m0_3_0_3 = true := by decide
def m0_3_1_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0],system,[[]]⟩
example : rows m0_3_1_0 = [a0] := by decide
example : leakageLedger m0_3_1_0 [] = [] := by decide
example : secure m0_3_1_0 = true := by decide
def m0_3_1_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0],system,[["alice"]]⟩
example : rows m0_3_1_1 = [a0] := by decide
example : leakageLedger m0_3_1_1 ["alice"] = [] := by decide
example : secure m0_3_1_1 = true := by decide
def m0_3_1_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0],system,[["bob"]]⟩
example : rows m0_3_1_2 = [a0] := by decide
example : leakageLedger m0_3_1_2 ["bob"] = [] := by decide
example : secure m0_3_1_2 = true := by decide
def m0_3_1_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0],system,[["alice","bob"]]⟩
example : rows m0_3_1_3 = [a0] := by decide
example : leakageLedger m0_3_1_3 ["alice","bob"] = [] := by decide
example : secure m0_3_1_3 = true := by decide
def m0_3_2_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[b0],system,[[]]⟩
example : rows m0_3_2_0 = [b0] := by decide
example : leakageLedger m0_3_2_0 [] = [] := by decide
example : secure m0_3_2_0 = true := by decide
def m0_3_2_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[b0],system,[["alice"]]⟩
example : rows m0_3_2_1 = [b0] := by decide
example : leakageLedger m0_3_2_1 ["alice"] = [] := by decide
example : secure m0_3_2_1 = true := by decide
def m0_3_2_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[b0],system,[["bob"]]⟩
example : rows m0_3_2_2 = [b0] := by decide
example : leakageLedger m0_3_2_2 ["bob"] = [] := by decide
example : secure m0_3_2_2 = true := by decide
def m0_3_2_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[b0],system,[["alice","bob"]]⟩
example : rows m0_3_2_3 = [b0] := by decide
example : leakageLedger m0_3_2_3 ["alice","bob"] = [] := by decide
example : secure m0_3_2_3 = true := by decide
def m0_3_3_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0,b0],system,[[]]⟩
example : rows m0_3_3_0 = [a0,b0] := by decide
example : leakageLedger m0_3_3_0 [] = [] := by decide
example : secure m0_3_3_0 = true := by decide
def m0_3_3_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0,b0],system,[["alice"]]⟩
example : rows m0_3_3_1 = [a0,b0] := by decide
example : leakageLedger m0_3_3_1 ["alice"] = [] := by decide
example : secure m0_3_3_1 = true := by decide
def m0_3_3_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0,b0],system,[["bob"]]⟩
example : rows m0_3_3_2 = [a0,b0] := by decide
example : leakageLedger m0_3_3_2 ["bob"] = [] := by decide
example : secure m0_3_3_2 = true := by decide
def m0_3_3_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a0,b0],system,[["alice","bob"]]⟩
example : rows m0_3_3_3 = [a0,b0] := by decide
example : leakageLedger m0_3_3_3 ["alice","bob"] = [] := by decide
example : secure m0_3_3_3 = true := by decide
def a1 : Row := ⟨[ia,ib],"out",[("alice","v"),("bob","v")]⟩
def b1 : Row := ⟨[ia,ic],"out",[("alice","u"),("bob","v")]⟩
def m1_0_0_0 : Model := ⟨["alice","bob"],[ia],[],system,[[]]⟩
example : rows m1_0_0_0 = [] := by decide
example : leakageLedger m1_0_0_0 [] = [] := by decide
example : secure m1_0_0_0 = true := by decide
def m1_0_0_1 : Model := ⟨["alice","bob"],[ia],[],system,[["alice"]]⟩
example : rows m1_0_0_1 = [] := by decide
example : leakageLedger m1_0_0_1 ["alice"] = [] := by decide
example : secure m1_0_0_1 = true := by decide
def m1_0_0_2 : Model := ⟨["alice","bob"],[ia],[],system,[["bob"]]⟩
example : rows m1_0_0_2 = [] := by decide
example : leakageLedger m1_0_0_2 ["bob"] = [] := by decide
example : secure m1_0_0_2 = true := by decide
def m1_0_0_3 : Model := ⟨["alice","bob"],[ia],[],system,[["alice","bob"]]⟩
example : rows m1_0_0_3 = [] := by decide
example : leakageLedger m1_0_0_3 ["alice","bob"] = [] := by decide
example : secure m1_0_0_3 = true := by decide
def m1_0_1_0 : Model := ⟨["alice","bob"],[ia],[a1],system,[[]]⟩
example : rows m1_0_1_0 = [] := by decide
example : leakageLedger m1_0_1_0 [] = [] := by decide
example : secure m1_0_1_0 = true := by decide
def m1_0_1_1 : Model := ⟨["alice","bob"],[ia],[a1],system,[["alice"]]⟩
example : rows m1_0_1_1 = [] := by decide
example : leakageLedger m1_0_1_1 ["alice"] = [] := by decide
example : secure m1_0_1_1 = true := by decide
def m1_0_1_2 : Model := ⟨["alice","bob"],[ia],[a1],system,[["bob"]]⟩
example : rows m1_0_1_2 = [] := by decide
example : leakageLedger m1_0_1_2 ["bob"] = [] := by decide
example : secure m1_0_1_2 = true := by decide
def m1_0_1_3 : Model := ⟨["alice","bob"],[ia],[a1],system,[["alice","bob"]]⟩
example : rows m1_0_1_3 = [] := by decide
example : leakageLedger m1_0_1_3 ["alice","bob"] = [] := by decide
example : secure m1_0_1_3 = true := by decide
def m1_0_2_0 : Model := ⟨["alice","bob"],[ia],[b1],system,[[]]⟩
example : rows m1_0_2_0 = [] := by decide
example : leakageLedger m1_0_2_0 [] = [] := by decide
example : secure m1_0_2_0 = true := by decide
def m1_0_2_1 : Model := ⟨["alice","bob"],[ia],[b1],system,[["alice"]]⟩
example : rows m1_0_2_1 = [] := by decide
example : leakageLedger m1_0_2_1 ["alice"] = [] := by decide
example : secure m1_0_2_1 = true := by decide
def m1_0_2_2 : Model := ⟨["alice","bob"],[ia],[b1],system,[["bob"]]⟩
example : rows m1_0_2_2 = [] := by decide
example : leakageLedger m1_0_2_2 ["bob"] = [] := by decide
example : secure m1_0_2_2 = true := by decide
def m1_0_2_3 : Model := ⟨["alice","bob"],[ia],[b1],system,[["alice","bob"]]⟩
example : rows m1_0_2_3 = [] := by decide
example : leakageLedger m1_0_2_3 ["alice","bob"] = [] := by decide
example : secure m1_0_2_3 = true := by decide
def m1_0_3_0 : Model := ⟨["alice","bob"],[ia],[a1,b1],system,[[]]⟩
example : rows m1_0_3_0 = [] := by decide
example : leakageLedger m1_0_3_0 [] = [] := by decide
example : secure m1_0_3_0 = true := by decide
def m1_0_3_1 : Model := ⟨["alice","bob"],[ia],[a1,b1],system,[["alice"]]⟩
example : rows m1_0_3_1 = [] := by decide
example : leakageLedger m1_0_3_1 ["alice"] = [] := by decide
example : secure m1_0_3_1 = true := by decide
def m1_0_3_2 : Model := ⟨["alice","bob"],[ia],[a1,b1],system,[["bob"]]⟩
example : rows m1_0_3_2 = [] := by decide
example : leakageLedger m1_0_3_2 ["bob"] = [] := by decide
example : secure m1_0_3_2 = true := by decide
def m1_0_3_3 : Model := ⟨["alice","bob"],[ia],[a1,b1],system,[["alice","bob"]]⟩
example : rows m1_0_3_3 = [] := by decide
example : leakageLedger m1_0_3_3 ["alice","bob"] = [] := by decide
example : secure m1_0_3_3 = true := by decide
def m1_1_0_0 : Model := ⟨["alice","bob"],[ia,ib],[],system,[[]]⟩
example : rows m1_1_0_0 = [] := by decide
example : leakageLedger m1_1_0_0 [] = [] := by decide
example : secure m1_1_0_0 = true := by decide
def m1_1_0_1 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice"]]⟩
example : rows m1_1_0_1 = [] := by decide
example : leakageLedger m1_1_0_1 ["alice"] = [] := by decide
example : secure m1_1_0_1 = true := by decide
def m1_1_0_2 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["bob"]]⟩
example : rows m1_1_0_2 = [] := by decide
example : leakageLedger m1_1_0_2 ["bob"] = [] := by decide
example : secure m1_1_0_2 = true := by decide
def m1_1_0_3 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice","bob"]]⟩
example : rows m1_1_0_3 = [] := by decide
example : leakageLedger m1_1_0_3 ["alice","bob"] = [] := by decide
example : secure m1_1_0_3 = true := by decide
def m1_1_1_0 : Model := ⟨["alice","bob"],[ia,ib],[a1],system,[[]]⟩
example : rows m1_1_1_0 = [a1] := by decide
example : leakageLedger m1_1_1_0 [] = [] := by decide
example : secure m1_1_1_0 = true := by decide
def m1_1_1_1 : Model := ⟨["alice","bob"],[ia,ib],[a1],system,[["alice"]]⟩
example : rows m1_1_1_1 = [a1] := by decide
example : leakageLedger m1_1_1_1 ["alice"] = [] := by decide
example : secure m1_1_1_1 = true := by decide
def m1_1_1_2 : Model := ⟨["alice","bob"],[ia,ib],[a1],system,[["bob"]]⟩
example : rows m1_1_1_2 = [a1] := by decide
example : leakageLedger m1_1_1_2 ["bob"] = [] := by decide
example : secure m1_1_1_2 = true := by decide
def m1_1_1_3 : Model := ⟨["alice","bob"],[ia,ib],[a1],system,[["alice","bob"]]⟩
example : rows m1_1_1_3 = [a1] := by decide
example : leakageLedger m1_1_1_3 ["alice","bob"] = [] := by decide
example : secure m1_1_1_3 = true := by decide
def m1_1_2_0 : Model := ⟨["alice","bob"],[ia,ib],[b1],system,[[]]⟩
example : rows m1_1_2_0 = [] := by decide
example : leakageLedger m1_1_2_0 [] = [] := by decide
example : secure m1_1_2_0 = true := by decide
def m1_1_2_1 : Model := ⟨["alice","bob"],[ia,ib],[b1],system,[["alice"]]⟩
example : rows m1_1_2_1 = [] := by decide
example : leakageLedger m1_1_2_1 ["alice"] = [] := by decide
example : secure m1_1_2_1 = true := by decide
def m1_1_2_2 : Model := ⟨["alice","bob"],[ia,ib],[b1],system,[["bob"]]⟩
example : rows m1_1_2_2 = [] := by decide
example : leakageLedger m1_1_2_2 ["bob"] = [] := by decide
example : secure m1_1_2_2 = true := by decide
def m1_1_2_3 : Model := ⟨["alice","bob"],[ia,ib],[b1],system,[["alice","bob"]]⟩
example : rows m1_1_2_3 = [] := by decide
example : leakageLedger m1_1_2_3 ["alice","bob"] = [] := by decide
example : secure m1_1_2_3 = true := by decide
def m1_1_3_0 : Model := ⟨["alice","bob"],[ia,ib],[a1,b1],system,[[]]⟩
example : rows m1_1_3_0 = [a1] := by decide
example : leakageLedger m1_1_3_0 [] = [] := by decide
example : secure m1_1_3_0 = true := by decide
def m1_1_3_1 : Model := ⟨["alice","bob"],[ia,ib],[a1,b1],system,[["alice"]]⟩
example : rows m1_1_3_1 = [a1] := by decide
example : leakageLedger m1_1_3_1 ["alice"] = [] := by decide
example : secure m1_1_3_1 = true := by decide
def m1_1_3_2 : Model := ⟨["alice","bob"],[ia,ib],[a1,b1],system,[["bob"]]⟩
example : rows m1_1_3_2 = [a1] := by decide
example : leakageLedger m1_1_3_2 ["bob"] = [] := by decide
example : secure m1_1_3_2 = true := by decide
def m1_1_3_3 : Model := ⟨["alice","bob"],[ia,ib],[a1,b1],system,[["alice","bob"]]⟩
example : rows m1_1_3_3 = [a1] := by decide
example : leakageLedger m1_1_3_3 ["alice","bob"] = [] := by decide
example : secure m1_1_3_3 = true := by decide
def m1_2_0_0 : Model := ⟨["alice","bob"],[ia,ic],[],system,[[]]⟩
example : rows m1_2_0_0 = [] := by decide
example : leakageLedger m1_2_0_0 [] = [] := by decide
example : secure m1_2_0_0 = true := by decide
def m1_2_0_1 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice"]]⟩
example : rows m1_2_0_1 = [] := by decide
example : leakageLedger m1_2_0_1 ["alice"] = [] := by decide
example : secure m1_2_0_1 = true := by decide
def m1_2_0_2 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["bob"]]⟩
example : rows m1_2_0_2 = [] := by decide
example : leakageLedger m1_2_0_2 ["bob"] = [] := by decide
example : secure m1_2_0_2 = true := by decide
def m1_2_0_3 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice","bob"]]⟩
example : rows m1_2_0_3 = [] := by decide
example : leakageLedger m1_2_0_3 ["alice","bob"] = [] := by decide
example : secure m1_2_0_3 = true := by decide
def m1_2_1_0 : Model := ⟨["alice","bob"],[ia,ic],[a1],system,[[]]⟩
example : rows m1_2_1_0 = [] := by decide
example : leakageLedger m1_2_1_0 [] = [] := by decide
example : secure m1_2_1_0 = true := by decide
def m1_2_1_1 : Model := ⟨["alice","bob"],[ia,ic],[a1],system,[["alice"]]⟩
example : rows m1_2_1_1 = [] := by decide
example : leakageLedger m1_2_1_1 ["alice"] = [] := by decide
example : secure m1_2_1_1 = true := by decide
def m1_2_1_2 : Model := ⟨["alice","bob"],[ia,ic],[a1],system,[["bob"]]⟩
example : rows m1_2_1_2 = [] := by decide
example : leakageLedger m1_2_1_2 ["bob"] = [] := by decide
example : secure m1_2_1_2 = true := by decide
def m1_2_1_3 : Model := ⟨["alice","bob"],[ia,ic],[a1],system,[["alice","bob"]]⟩
example : rows m1_2_1_3 = [] := by decide
example : leakageLedger m1_2_1_3 ["alice","bob"] = [] := by decide
example : secure m1_2_1_3 = true := by decide
def m1_2_2_0 : Model := ⟨["alice","bob"],[ia,ic],[b1],system,[[]]⟩
example : rows m1_2_2_0 = [b1] := by decide
example : leakageLedger m1_2_2_0 [] = [] := by decide
example : secure m1_2_2_0 = true := by decide
def m1_2_2_1 : Model := ⟨["alice","bob"],[ia,ic],[b1],system,[["alice"]]⟩
example : rows m1_2_2_1 = [b1] := by decide
example : leakageLedger m1_2_2_1 ["alice"] = [] := by decide
example : secure m1_2_2_1 = true := by decide
def m1_2_2_2 : Model := ⟨["alice","bob"],[ia,ic],[b1],system,[["bob"]]⟩
example : rows m1_2_2_2 = [b1] := by decide
example : leakageLedger m1_2_2_2 ["bob"] = [] := by decide
example : secure m1_2_2_2 = true := by decide
def m1_2_2_3 : Model := ⟨["alice","bob"],[ia,ic],[b1],system,[["alice","bob"]]⟩
example : rows m1_2_2_3 = [b1] := by decide
example : leakageLedger m1_2_2_3 ["alice","bob"] = [] := by decide
example : secure m1_2_2_3 = true := by decide
def m1_2_3_0 : Model := ⟨["alice","bob"],[ia,ic],[a1,b1],system,[[]]⟩
example : rows m1_2_3_0 = [b1] := by decide
example : leakageLedger m1_2_3_0 [] = [] := by decide
example : secure m1_2_3_0 = true := by decide
def m1_2_3_1 : Model := ⟨["alice","bob"],[ia,ic],[a1,b1],system,[["alice"]]⟩
example : rows m1_2_3_1 = [b1] := by decide
example : leakageLedger m1_2_3_1 ["alice"] = [] := by decide
example : secure m1_2_3_1 = true := by decide
def m1_2_3_2 : Model := ⟨["alice","bob"],[ia,ic],[a1,b1],system,[["bob"]]⟩
example : rows m1_2_3_2 = [b1] := by decide
example : leakageLedger m1_2_3_2 ["bob"] = [] := by decide
example : secure m1_2_3_2 = true := by decide
def m1_2_3_3 : Model := ⟨["alice","bob"],[ia,ic],[a1,b1],system,[["alice","bob"]]⟩
example : rows m1_2_3_3 = [b1] := by decide
example : leakageLedger m1_2_3_3 ["alice","bob"] = [] := by decide
example : secure m1_2_3_3 = true := by decide
def m1_3_0_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[[]]⟩
example : rows m1_3_0_0 = [] := by decide
example : leakageLedger m1_3_0_0 [] = [] := by decide
example : secure m1_3_0_0 = true := by decide
def m1_3_0_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice"]]⟩
example : rows m1_3_0_1 = [] := by decide
example : leakageLedger m1_3_0_1 ["alice"] = [] := by decide
example : secure m1_3_0_1 = true := by decide
def m1_3_0_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["bob"]]⟩
example : rows m1_3_0_2 = [] := by decide
example : leakageLedger m1_3_0_2 ["bob"] = [] := by decide
example : secure m1_3_0_2 = true := by decide
def m1_3_0_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice","bob"]]⟩
example : rows m1_3_0_3 = [] := by decide
example : leakageLedger m1_3_0_3 ["alice","bob"] = [] := by decide
example : secure m1_3_0_3 = true := by decide
def m1_3_1_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1],system,[[]]⟩
example : rows m1_3_1_0 = [a1] := by decide
example : leakageLedger m1_3_1_0 [] = [] := by decide
example : secure m1_3_1_0 = true := by decide
def m1_3_1_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1],system,[["alice"]]⟩
example : rows m1_3_1_1 = [a1] := by decide
example : leakageLedger m1_3_1_1 ["alice"] = [] := by decide
example : secure m1_3_1_1 = true := by decide
def m1_3_1_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1],system,[["bob"]]⟩
example : rows m1_3_1_2 = [a1] := by decide
example : leakageLedger m1_3_1_2 ["bob"] = [] := by decide
example : secure m1_3_1_2 = true := by decide
def m1_3_1_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1],system,[["alice","bob"]]⟩
example : rows m1_3_1_3 = [a1] := by decide
example : leakageLedger m1_3_1_3 ["alice","bob"] = [] := by decide
example : secure m1_3_1_3 = true := by decide
def m1_3_2_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[b1],system,[[]]⟩
example : rows m1_3_2_0 = [b1] := by decide
example : leakageLedger m1_3_2_0 [] = [] := by decide
example : secure m1_3_2_0 = true := by decide
def m1_3_2_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[b1],system,[["alice"]]⟩
example : rows m1_3_2_1 = [b1] := by decide
example : leakageLedger m1_3_2_1 ["alice"] = [] := by decide
example : secure m1_3_2_1 = true := by decide
def m1_3_2_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[b1],system,[["bob"]]⟩
example : rows m1_3_2_2 = [b1] := by decide
example : leakageLedger m1_3_2_2 ["bob"] = [] := by decide
example : secure m1_3_2_2 = true := by decide
def m1_3_2_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[b1],system,[["alice","bob"]]⟩
example : rows m1_3_2_3 = [b1] := by decide
example : leakageLedger m1_3_2_3 ["alice","bob"] = [] := by decide
example : secure m1_3_2_3 = true := by decide
def m1_3_3_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1,b1],system,[[]]⟩
example : rows m1_3_3_0 = [a1,b1] := by decide
example : leakageLedger m1_3_3_0 [] = [] := by decide
example : secure m1_3_3_0 = true := by decide
def m1_3_3_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1,b1],system,[["alice"]]⟩
example : rows m1_3_3_1 = [a1,b1] := by decide
example : leakageLedger m1_3_3_1 ["alice"] = [(a1,b1),(b1,a1)] := by decide
example : secure m1_3_3_1 = false := by decide
def m1_3_3_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1,b1],system,[["bob"]]⟩
example : rows m1_3_3_2 = [a1,b1] := by decide
example : leakageLedger m1_3_3_2 ["bob"] = [] := by decide
example : secure m1_3_3_2 = true := by decide
def m1_3_3_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a1,b1],system,[["alice","bob"]]⟩
example : rows m1_3_3_3 = [a1,b1] := by decide
example : leakageLedger m1_3_3_3 ["alice","bob"] = [] := by decide
example : secure m1_3_3_3 = true := by decide
def a2 : Row := ⟨[ia,ib],"out",[("alice","v"),("bob","v")]⟩
def b2 : Row := ⟨[ia,ic],"out",[("alice","v"),("bob","u")]⟩
def m2_0_0_0 : Model := ⟨["alice","bob"],[ia],[],system,[[]]⟩
example : rows m2_0_0_0 = [] := by decide
example : leakageLedger m2_0_0_0 [] = [] := by decide
example : secure m2_0_0_0 = true := by decide
def m2_0_0_1 : Model := ⟨["alice","bob"],[ia],[],system,[["alice"]]⟩
example : rows m2_0_0_1 = [] := by decide
example : leakageLedger m2_0_0_1 ["alice"] = [] := by decide
example : secure m2_0_0_1 = true := by decide
def m2_0_0_2 : Model := ⟨["alice","bob"],[ia],[],system,[["bob"]]⟩
example : rows m2_0_0_2 = [] := by decide
example : leakageLedger m2_0_0_2 ["bob"] = [] := by decide
example : secure m2_0_0_2 = true := by decide
def m2_0_0_3 : Model := ⟨["alice","bob"],[ia],[],system,[["alice","bob"]]⟩
example : rows m2_0_0_3 = [] := by decide
example : leakageLedger m2_0_0_3 ["alice","bob"] = [] := by decide
example : secure m2_0_0_3 = true := by decide
def m2_0_1_0 : Model := ⟨["alice","bob"],[ia],[a2],system,[[]]⟩
example : rows m2_0_1_0 = [] := by decide
example : leakageLedger m2_0_1_0 [] = [] := by decide
example : secure m2_0_1_0 = true := by decide
def m2_0_1_1 : Model := ⟨["alice","bob"],[ia],[a2],system,[["alice"]]⟩
example : rows m2_0_1_1 = [] := by decide
example : leakageLedger m2_0_1_1 ["alice"] = [] := by decide
example : secure m2_0_1_1 = true := by decide
def m2_0_1_2 : Model := ⟨["alice","bob"],[ia],[a2],system,[["bob"]]⟩
example : rows m2_0_1_2 = [] := by decide
example : leakageLedger m2_0_1_2 ["bob"] = [] := by decide
example : secure m2_0_1_2 = true := by decide
def m2_0_1_3 : Model := ⟨["alice","bob"],[ia],[a2],system,[["alice","bob"]]⟩
example : rows m2_0_1_3 = [] := by decide
example : leakageLedger m2_0_1_3 ["alice","bob"] = [] := by decide
example : secure m2_0_1_3 = true := by decide
def m2_0_2_0 : Model := ⟨["alice","bob"],[ia],[b2],system,[[]]⟩
example : rows m2_0_2_0 = [] := by decide
example : leakageLedger m2_0_2_0 [] = [] := by decide
example : secure m2_0_2_0 = true := by decide
def m2_0_2_1 : Model := ⟨["alice","bob"],[ia],[b2],system,[["alice"]]⟩
example : rows m2_0_2_1 = [] := by decide
example : leakageLedger m2_0_2_1 ["alice"] = [] := by decide
example : secure m2_0_2_1 = true := by decide
def m2_0_2_2 : Model := ⟨["alice","bob"],[ia],[b2],system,[["bob"]]⟩
example : rows m2_0_2_2 = [] := by decide
example : leakageLedger m2_0_2_2 ["bob"] = [] := by decide
example : secure m2_0_2_2 = true := by decide
def m2_0_2_3 : Model := ⟨["alice","bob"],[ia],[b2],system,[["alice","bob"]]⟩
example : rows m2_0_2_3 = [] := by decide
example : leakageLedger m2_0_2_3 ["alice","bob"] = [] := by decide
example : secure m2_0_2_3 = true := by decide
def m2_0_3_0 : Model := ⟨["alice","bob"],[ia],[a2,b2],system,[[]]⟩
example : rows m2_0_3_0 = [] := by decide
example : leakageLedger m2_0_3_0 [] = [] := by decide
example : secure m2_0_3_0 = true := by decide
def m2_0_3_1 : Model := ⟨["alice","bob"],[ia],[a2,b2],system,[["alice"]]⟩
example : rows m2_0_3_1 = [] := by decide
example : leakageLedger m2_0_3_1 ["alice"] = [] := by decide
example : secure m2_0_3_1 = true := by decide
def m2_0_3_2 : Model := ⟨["alice","bob"],[ia],[a2,b2],system,[["bob"]]⟩
example : rows m2_0_3_2 = [] := by decide
example : leakageLedger m2_0_3_2 ["bob"] = [] := by decide
example : secure m2_0_3_2 = true := by decide
def m2_0_3_3 : Model := ⟨["alice","bob"],[ia],[a2,b2],system,[["alice","bob"]]⟩
example : rows m2_0_3_3 = [] := by decide
example : leakageLedger m2_0_3_3 ["alice","bob"] = [] := by decide
example : secure m2_0_3_3 = true := by decide
def m2_1_0_0 : Model := ⟨["alice","bob"],[ia,ib],[],system,[[]]⟩
example : rows m2_1_0_0 = [] := by decide
example : leakageLedger m2_1_0_0 [] = [] := by decide
example : secure m2_1_0_0 = true := by decide
def m2_1_0_1 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice"]]⟩
example : rows m2_1_0_1 = [] := by decide
example : leakageLedger m2_1_0_1 ["alice"] = [] := by decide
example : secure m2_1_0_1 = true := by decide
def m2_1_0_2 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["bob"]]⟩
example : rows m2_1_0_2 = [] := by decide
example : leakageLedger m2_1_0_2 ["bob"] = [] := by decide
example : secure m2_1_0_2 = true := by decide
def m2_1_0_3 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice","bob"]]⟩
example : rows m2_1_0_3 = [] := by decide
example : leakageLedger m2_1_0_3 ["alice","bob"] = [] := by decide
example : secure m2_1_0_3 = true := by decide
def m2_1_1_0 : Model := ⟨["alice","bob"],[ia,ib],[a2],system,[[]]⟩
example : rows m2_1_1_0 = [a2] := by decide
example : leakageLedger m2_1_1_0 [] = [] := by decide
example : secure m2_1_1_0 = true := by decide
def m2_1_1_1 : Model := ⟨["alice","bob"],[ia,ib],[a2],system,[["alice"]]⟩
example : rows m2_1_1_1 = [a2] := by decide
example : leakageLedger m2_1_1_1 ["alice"] = [] := by decide
example : secure m2_1_1_1 = true := by decide
def m2_1_1_2 : Model := ⟨["alice","bob"],[ia,ib],[a2],system,[["bob"]]⟩
example : rows m2_1_1_2 = [a2] := by decide
example : leakageLedger m2_1_1_2 ["bob"] = [] := by decide
example : secure m2_1_1_2 = true := by decide
def m2_1_1_3 : Model := ⟨["alice","bob"],[ia,ib],[a2],system,[["alice","bob"]]⟩
example : rows m2_1_1_3 = [a2] := by decide
example : leakageLedger m2_1_1_3 ["alice","bob"] = [] := by decide
example : secure m2_1_1_3 = true := by decide
def m2_1_2_0 : Model := ⟨["alice","bob"],[ia,ib],[b2],system,[[]]⟩
example : rows m2_1_2_0 = [] := by decide
example : leakageLedger m2_1_2_0 [] = [] := by decide
example : secure m2_1_2_0 = true := by decide
def m2_1_2_1 : Model := ⟨["alice","bob"],[ia,ib],[b2],system,[["alice"]]⟩
example : rows m2_1_2_1 = [] := by decide
example : leakageLedger m2_1_2_1 ["alice"] = [] := by decide
example : secure m2_1_2_1 = true := by decide
def m2_1_2_2 : Model := ⟨["alice","bob"],[ia,ib],[b2],system,[["bob"]]⟩
example : rows m2_1_2_2 = [] := by decide
example : leakageLedger m2_1_2_2 ["bob"] = [] := by decide
example : secure m2_1_2_2 = true := by decide
def m2_1_2_3 : Model := ⟨["alice","bob"],[ia,ib],[b2],system,[["alice","bob"]]⟩
example : rows m2_1_2_3 = [] := by decide
example : leakageLedger m2_1_2_3 ["alice","bob"] = [] := by decide
example : secure m2_1_2_3 = true := by decide
def m2_1_3_0 : Model := ⟨["alice","bob"],[ia,ib],[a2,b2],system,[[]]⟩
example : rows m2_1_3_0 = [a2] := by decide
example : leakageLedger m2_1_3_0 [] = [] := by decide
example : secure m2_1_3_0 = true := by decide
def m2_1_3_1 : Model := ⟨["alice","bob"],[ia,ib],[a2,b2],system,[["alice"]]⟩
example : rows m2_1_3_1 = [a2] := by decide
example : leakageLedger m2_1_3_1 ["alice"] = [] := by decide
example : secure m2_1_3_1 = true := by decide
def m2_1_3_2 : Model := ⟨["alice","bob"],[ia,ib],[a2,b2],system,[["bob"]]⟩
example : rows m2_1_3_2 = [a2] := by decide
example : leakageLedger m2_1_3_2 ["bob"] = [] := by decide
example : secure m2_1_3_2 = true := by decide
def m2_1_3_3 : Model := ⟨["alice","bob"],[ia,ib],[a2,b2],system,[["alice","bob"]]⟩
example : rows m2_1_3_3 = [a2] := by decide
example : leakageLedger m2_1_3_3 ["alice","bob"] = [] := by decide
example : secure m2_1_3_3 = true := by decide
def m2_2_0_0 : Model := ⟨["alice","bob"],[ia,ic],[],system,[[]]⟩
example : rows m2_2_0_0 = [] := by decide
example : leakageLedger m2_2_0_0 [] = [] := by decide
example : secure m2_2_0_0 = true := by decide
def m2_2_0_1 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice"]]⟩
example : rows m2_2_0_1 = [] := by decide
example : leakageLedger m2_2_0_1 ["alice"] = [] := by decide
example : secure m2_2_0_1 = true := by decide
def m2_2_0_2 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["bob"]]⟩
example : rows m2_2_0_2 = [] := by decide
example : leakageLedger m2_2_0_2 ["bob"] = [] := by decide
example : secure m2_2_0_2 = true := by decide
def m2_2_0_3 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice","bob"]]⟩
example : rows m2_2_0_3 = [] := by decide
example : leakageLedger m2_2_0_3 ["alice","bob"] = [] := by decide
example : secure m2_2_0_3 = true := by decide
def m2_2_1_0 : Model := ⟨["alice","bob"],[ia,ic],[a2],system,[[]]⟩
example : rows m2_2_1_0 = [] := by decide
example : leakageLedger m2_2_1_0 [] = [] := by decide
example : secure m2_2_1_0 = true := by decide
def m2_2_1_1 : Model := ⟨["alice","bob"],[ia,ic],[a2],system,[["alice"]]⟩
example : rows m2_2_1_1 = [] := by decide
example : leakageLedger m2_2_1_1 ["alice"] = [] := by decide
example : secure m2_2_1_1 = true := by decide
def m2_2_1_2 : Model := ⟨["alice","bob"],[ia,ic],[a2],system,[["bob"]]⟩
example : rows m2_2_1_2 = [] := by decide
example : leakageLedger m2_2_1_2 ["bob"] = [] := by decide
example : secure m2_2_1_2 = true := by decide
def m2_2_1_3 : Model := ⟨["alice","bob"],[ia,ic],[a2],system,[["alice","bob"]]⟩
example : rows m2_2_1_3 = [] := by decide
example : leakageLedger m2_2_1_3 ["alice","bob"] = [] := by decide
example : secure m2_2_1_3 = true := by decide
def m2_2_2_0 : Model := ⟨["alice","bob"],[ia,ic],[b2],system,[[]]⟩
example : rows m2_2_2_0 = [b2] := by decide
example : leakageLedger m2_2_2_0 [] = [] := by decide
example : secure m2_2_2_0 = true := by decide
def m2_2_2_1 : Model := ⟨["alice","bob"],[ia,ic],[b2],system,[["alice"]]⟩
example : rows m2_2_2_1 = [b2] := by decide
example : leakageLedger m2_2_2_1 ["alice"] = [] := by decide
example : secure m2_2_2_1 = true := by decide
def m2_2_2_2 : Model := ⟨["alice","bob"],[ia,ic],[b2],system,[["bob"]]⟩
example : rows m2_2_2_2 = [b2] := by decide
example : leakageLedger m2_2_2_2 ["bob"] = [] := by decide
example : secure m2_2_2_2 = true := by decide
def m2_2_2_3 : Model := ⟨["alice","bob"],[ia,ic],[b2],system,[["alice","bob"]]⟩
example : rows m2_2_2_3 = [b2] := by decide
example : leakageLedger m2_2_2_3 ["alice","bob"] = [] := by decide
example : secure m2_2_2_3 = true := by decide
def m2_2_3_0 : Model := ⟨["alice","bob"],[ia,ic],[a2,b2],system,[[]]⟩
example : rows m2_2_3_0 = [b2] := by decide
example : leakageLedger m2_2_3_0 [] = [] := by decide
example : secure m2_2_3_0 = true := by decide
def m2_2_3_1 : Model := ⟨["alice","bob"],[ia,ic],[a2,b2],system,[["alice"]]⟩
example : rows m2_2_3_1 = [b2] := by decide
example : leakageLedger m2_2_3_1 ["alice"] = [] := by decide
example : secure m2_2_3_1 = true := by decide
def m2_2_3_2 : Model := ⟨["alice","bob"],[ia,ic],[a2,b2],system,[["bob"]]⟩
example : rows m2_2_3_2 = [b2] := by decide
example : leakageLedger m2_2_3_2 ["bob"] = [] := by decide
example : secure m2_2_3_2 = true := by decide
def m2_2_3_3 : Model := ⟨["alice","bob"],[ia,ic],[a2,b2],system,[["alice","bob"]]⟩
example : rows m2_2_3_3 = [b2] := by decide
example : leakageLedger m2_2_3_3 ["alice","bob"] = [] := by decide
example : secure m2_2_3_3 = true := by decide
def m2_3_0_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[[]]⟩
example : rows m2_3_0_0 = [] := by decide
example : leakageLedger m2_3_0_0 [] = [] := by decide
example : secure m2_3_0_0 = true := by decide
def m2_3_0_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice"]]⟩
example : rows m2_3_0_1 = [] := by decide
example : leakageLedger m2_3_0_1 ["alice"] = [] := by decide
example : secure m2_3_0_1 = true := by decide
def m2_3_0_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["bob"]]⟩
example : rows m2_3_0_2 = [] := by decide
example : leakageLedger m2_3_0_2 ["bob"] = [] := by decide
example : secure m2_3_0_2 = true := by decide
def m2_3_0_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice","bob"]]⟩
example : rows m2_3_0_3 = [] := by decide
example : leakageLedger m2_3_0_3 ["alice","bob"] = [] := by decide
example : secure m2_3_0_3 = true := by decide
def m2_3_1_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2],system,[[]]⟩
example : rows m2_3_1_0 = [a2] := by decide
example : leakageLedger m2_3_1_0 [] = [] := by decide
example : secure m2_3_1_0 = true := by decide
def m2_3_1_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2],system,[["alice"]]⟩
example : rows m2_3_1_1 = [a2] := by decide
example : leakageLedger m2_3_1_1 ["alice"] = [] := by decide
example : secure m2_3_1_1 = true := by decide
def m2_3_1_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2],system,[["bob"]]⟩
example : rows m2_3_1_2 = [a2] := by decide
example : leakageLedger m2_3_1_2 ["bob"] = [] := by decide
example : secure m2_3_1_2 = true := by decide
def m2_3_1_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2],system,[["alice","bob"]]⟩
example : rows m2_3_1_3 = [a2] := by decide
example : leakageLedger m2_3_1_3 ["alice","bob"] = [] := by decide
example : secure m2_3_1_3 = true := by decide
def m2_3_2_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[b2],system,[[]]⟩
example : rows m2_3_2_0 = [b2] := by decide
example : leakageLedger m2_3_2_0 [] = [] := by decide
example : secure m2_3_2_0 = true := by decide
def m2_3_2_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[b2],system,[["alice"]]⟩
example : rows m2_3_2_1 = [b2] := by decide
example : leakageLedger m2_3_2_1 ["alice"] = [] := by decide
example : secure m2_3_2_1 = true := by decide
def m2_3_2_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[b2],system,[["bob"]]⟩
example : rows m2_3_2_2 = [b2] := by decide
example : leakageLedger m2_3_2_2 ["bob"] = [] := by decide
example : secure m2_3_2_2 = true := by decide
def m2_3_2_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[b2],system,[["alice","bob"]]⟩
example : rows m2_3_2_3 = [b2] := by decide
example : leakageLedger m2_3_2_3 ["alice","bob"] = [] := by decide
example : secure m2_3_2_3 = true := by decide
def m2_3_3_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2,b2],system,[[]]⟩
example : rows m2_3_3_0 = [a2,b2] := by decide
example : leakageLedger m2_3_3_0 [] = [] := by decide
example : secure m2_3_3_0 = true := by decide
def m2_3_3_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2,b2],system,[["alice"]]⟩
example : rows m2_3_3_1 = [a2,b2] := by decide
example : leakageLedger m2_3_3_1 ["alice"] = [] := by decide
example : secure m2_3_3_1 = true := by decide
def m2_3_3_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2,b2],system,[["bob"]]⟩
example : rows m2_3_3_2 = [a2,b2] := by decide
example : leakageLedger m2_3_3_2 ["bob"] = [] := by decide
example : secure m2_3_3_2 = true := by decide
def m2_3_3_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a2,b2],system,[["alice","bob"]]⟩
example : rows m2_3_3_3 = [a2,b2] := by decide
example : leakageLedger m2_3_3_3 ["alice","bob"] = [] := by decide
example : secure m2_3_3_3 = true := by decide
def a3 : Row := ⟨[ia,ib],"out",[("alice","v"),("bob","v")]⟩
def b3 : Row := ⟨[ia,ic],"out",[("alice","u"),("bob","u")]⟩
def m3_0_0_0 : Model := ⟨["alice","bob"],[ia],[],system,[[]]⟩
example : rows m3_0_0_0 = [] := by decide
example : leakageLedger m3_0_0_0 [] = [] := by decide
example : secure m3_0_0_0 = true := by decide
def m3_0_0_1 : Model := ⟨["alice","bob"],[ia],[],system,[["alice"]]⟩
example : rows m3_0_0_1 = [] := by decide
example : leakageLedger m3_0_0_1 ["alice"] = [] := by decide
example : secure m3_0_0_1 = true := by decide
def m3_0_0_2 : Model := ⟨["alice","bob"],[ia],[],system,[["bob"]]⟩
example : rows m3_0_0_2 = [] := by decide
example : leakageLedger m3_0_0_2 ["bob"] = [] := by decide
example : secure m3_0_0_2 = true := by decide
def m3_0_0_3 : Model := ⟨["alice","bob"],[ia],[],system,[["alice","bob"]]⟩
example : rows m3_0_0_3 = [] := by decide
example : leakageLedger m3_0_0_3 ["alice","bob"] = [] := by decide
example : secure m3_0_0_3 = true := by decide
def m3_0_1_0 : Model := ⟨["alice","bob"],[ia],[a3],system,[[]]⟩
example : rows m3_0_1_0 = [] := by decide
example : leakageLedger m3_0_1_0 [] = [] := by decide
example : secure m3_0_1_0 = true := by decide
def m3_0_1_1 : Model := ⟨["alice","bob"],[ia],[a3],system,[["alice"]]⟩
example : rows m3_0_1_1 = [] := by decide
example : leakageLedger m3_0_1_1 ["alice"] = [] := by decide
example : secure m3_0_1_1 = true := by decide
def m3_0_1_2 : Model := ⟨["alice","bob"],[ia],[a3],system,[["bob"]]⟩
example : rows m3_0_1_2 = [] := by decide
example : leakageLedger m3_0_1_2 ["bob"] = [] := by decide
example : secure m3_0_1_2 = true := by decide
def m3_0_1_3 : Model := ⟨["alice","bob"],[ia],[a3],system,[["alice","bob"]]⟩
example : rows m3_0_1_3 = [] := by decide
example : leakageLedger m3_0_1_3 ["alice","bob"] = [] := by decide
example : secure m3_0_1_3 = true := by decide
def m3_0_2_0 : Model := ⟨["alice","bob"],[ia],[b3],system,[[]]⟩
example : rows m3_0_2_0 = [] := by decide
example : leakageLedger m3_0_2_0 [] = [] := by decide
example : secure m3_0_2_0 = true := by decide
def m3_0_2_1 : Model := ⟨["alice","bob"],[ia],[b3],system,[["alice"]]⟩
example : rows m3_0_2_1 = [] := by decide
example : leakageLedger m3_0_2_1 ["alice"] = [] := by decide
example : secure m3_0_2_1 = true := by decide
def m3_0_2_2 : Model := ⟨["alice","bob"],[ia],[b3],system,[["bob"]]⟩
example : rows m3_0_2_2 = [] := by decide
example : leakageLedger m3_0_2_2 ["bob"] = [] := by decide
example : secure m3_0_2_2 = true := by decide
def m3_0_2_3 : Model := ⟨["alice","bob"],[ia],[b3],system,[["alice","bob"]]⟩
example : rows m3_0_2_3 = [] := by decide
example : leakageLedger m3_0_2_3 ["alice","bob"] = [] := by decide
example : secure m3_0_2_3 = true := by decide
def m3_0_3_0 : Model := ⟨["alice","bob"],[ia],[a3,b3],system,[[]]⟩
example : rows m3_0_3_0 = [] := by decide
example : leakageLedger m3_0_3_0 [] = [] := by decide
example : secure m3_0_3_0 = true := by decide
def m3_0_3_1 : Model := ⟨["alice","bob"],[ia],[a3,b3],system,[["alice"]]⟩
example : rows m3_0_3_1 = [] := by decide
example : leakageLedger m3_0_3_1 ["alice"] = [] := by decide
example : secure m3_0_3_1 = true := by decide
def m3_0_3_2 : Model := ⟨["alice","bob"],[ia],[a3,b3],system,[["bob"]]⟩
example : rows m3_0_3_2 = [] := by decide
example : leakageLedger m3_0_3_2 ["bob"] = [] := by decide
example : secure m3_0_3_2 = true := by decide
def m3_0_3_3 : Model := ⟨["alice","bob"],[ia],[a3,b3],system,[["alice","bob"]]⟩
example : rows m3_0_3_3 = [] := by decide
example : leakageLedger m3_0_3_3 ["alice","bob"] = [] := by decide
example : secure m3_0_3_3 = true := by decide
def m3_1_0_0 : Model := ⟨["alice","bob"],[ia,ib],[],system,[[]]⟩
example : rows m3_1_0_0 = [] := by decide
example : leakageLedger m3_1_0_0 [] = [] := by decide
example : secure m3_1_0_0 = true := by decide
def m3_1_0_1 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice"]]⟩
example : rows m3_1_0_1 = [] := by decide
example : leakageLedger m3_1_0_1 ["alice"] = [] := by decide
example : secure m3_1_0_1 = true := by decide
def m3_1_0_2 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["bob"]]⟩
example : rows m3_1_0_2 = [] := by decide
example : leakageLedger m3_1_0_2 ["bob"] = [] := by decide
example : secure m3_1_0_2 = true := by decide
def m3_1_0_3 : Model := ⟨["alice","bob"],[ia,ib],[],system,[["alice","bob"]]⟩
example : rows m3_1_0_3 = [] := by decide
example : leakageLedger m3_1_0_3 ["alice","bob"] = [] := by decide
example : secure m3_1_0_3 = true := by decide
def m3_1_1_0 : Model := ⟨["alice","bob"],[ia,ib],[a3],system,[[]]⟩
example : rows m3_1_1_0 = [a3] := by decide
example : leakageLedger m3_1_1_0 [] = [] := by decide
example : secure m3_1_1_0 = true := by decide
def m3_1_1_1 : Model := ⟨["alice","bob"],[ia,ib],[a3],system,[["alice"]]⟩
example : rows m3_1_1_1 = [a3] := by decide
example : leakageLedger m3_1_1_1 ["alice"] = [] := by decide
example : secure m3_1_1_1 = true := by decide
def m3_1_1_2 : Model := ⟨["alice","bob"],[ia,ib],[a3],system,[["bob"]]⟩
example : rows m3_1_1_2 = [a3] := by decide
example : leakageLedger m3_1_1_2 ["bob"] = [] := by decide
example : secure m3_1_1_2 = true := by decide
def m3_1_1_3 : Model := ⟨["alice","bob"],[ia,ib],[a3],system,[["alice","bob"]]⟩
example : rows m3_1_1_3 = [a3] := by decide
example : leakageLedger m3_1_1_3 ["alice","bob"] = [] := by decide
example : secure m3_1_1_3 = true := by decide
def m3_1_2_0 : Model := ⟨["alice","bob"],[ia,ib],[b3],system,[[]]⟩
example : rows m3_1_2_0 = [] := by decide
example : leakageLedger m3_1_2_0 [] = [] := by decide
example : secure m3_1_2_0 = true := by decide
def m3_1_2_1 : Model := ⟨["alice","bob"],[ia,ib],[b3],system,[["alice"]]⟩
example : rows m3_1_2_1 = [] := by decide
example : leakageLedger m3_1_2_1 ["alice"] = [] := by decide
example : secure m3_1_2_1 = true := by decide
def m3_1_2_2 : Model := ⟨["alice","bob"],[ia,ib],[b3],system,[["bob"]]⟩
example : rows m3_1_2_2 = [] := by decide
example : leakageLedger m3_1_2_2 ["bob"] = [] := by decide
example : secure m3_1_2_2 = true := by decide
def m3_1_2_3 : Model := ⟨["alice","bob"],[ia,ib],[b3],system,[["alice","bob"]]⟩
example : rows m3_1_2_3 = [] := by decide
example : leakageLedger m3_1_2_3 ["alice","bob"] = [] := by decide
example : secure m3_1_2_3 = true := by decide
def m3_1_3_0 : Model := ⟨["alice","bob"],[ia,ib],[a3,b3],system,[[]]⟩
example : rows m3_1_3_0 = [a3] := by decide
example : leakageLedger m3_1_3_0 [] = [] := by decide
example : secure m3_1_3_0 = true := by decide
def m3_1_3_1 : Model := ⟨["alice","bob"],[ia,ib],[a3,b3],system,[["alice"]]⟩
example : rows m3_1_3_1 = [a3] := by decide
example : leakageLedger m3_1_3_1 ["alice"] = [] := by decide
example : secure m3_1_3_1 = true := by decide
def m3_1_3_2 : Model := ⟨["alice","bob"],[ia,ib],[a3,b3],system,[["bob"]]⟩
example : rows m3_1_3_2 = [a3] := by decide
example : leakageLedger m3_1_3_2 ["bob"] = [] := by decide
example : secure m3_1_3_2 = true := by decide
def m3_1_3_3 : Model := ⟨["alice","bob"],[ia,ib],[a3,b3],system,[["alice","bob"]]⟩
example : rows m3_1_3_3 = [a3] := by decide
example : leakageLedger m3_1_3_3 ["alice","bob"] = [] := by decide
example : secure m3_1_3_3 = true := by decide
def m3_2_0_0 : Model := ⟨["alice","bob"],[ia,ic],[],system,[[]]⟩
example : rows m3_2_0_0 = [] := by decide
example : leakageLedger m3_2_0_0 [] = [] := by decide
example : secure m3_2_0_0 = true := by decide
def m3_2_0_1 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice"]]⟩
example : rows m3_2_0_1 = [] := by decide
example : leakageLedger m3_2_0_1 ["alice"] = [] := by decide
example : secure m3_2_0_1 = true := by decide
def m3_2_0_2 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["bob"]]⟩
example : rows m3_2_0_2 = [] := by decide
example : leakageLedger m3_2_0_2 ["bob"] = [] := by decide
example : secure m3_2_0_2 = true := by decide
def m3_2_0_3 : Model := ⟨["alice","bob"],[ia,ic],[],system,[["alice","bob"]]⟩
example : rows m3_2_0_3 = [] := by decide
example : leakageLedger m3_2_0_3 ["alice","bob"] = [] := by decide
example : secure m3_2_0_3 = true := by decide
def m3_2_1_0 : Model := ⟨["alice","bob"],[ia,ic],[a3],system,[[]]⟩
example : rows m3_2_1_0 = [] := by decide
example : leakageLedger m3_2_1_0 [] = [] := by decide
example : secure m3_2_1_0 = true := by decide
def m3_2_1_1 : Model := ⟨["alice","bob"],[ia,ic],[a3],system,[["alice"]]⟩
example : rows m3_2_1_1 = [] := by decide
example : leakageLedger m3_2_1_1 ["alice"] = [] := by decide
example : secure m3_2_1_1 = true := by decide
def m3_2_1_2 : Model := ⟨["alice","bob"],[ia,ic],[a3],system,[["bob"]]⟩
example : rows m3_2_1_2 = [] := by decide
example : leakageLedger m3_2_1_2 ["bob"] = [] := by decide
example : secure m3_2_1_2 = true := by decide
def m3_2_1_3 : Model := ⟨["alice","bob"],[ia,ic],[a3],system,[["alice","bob"]]⟩
example : rows m3_2_1_3 = [] := by decide
example : leakageLedger m3_2_1_3 ["alice","bob"] = [] := by decide
example : secure m3_2_1_3 = true := by decide
def m3_2_2_0 : Model := ⟨["alice","bob"],[ia,ic],[b3],system,[[]]⟩
example : rows m3_2_2_0 = [b3] := by decide
example : leakageLedger m3_2_2_0 [] = [] := by decide
example : secure m3_2_2_0 = true := by decide
def m3_2_2_1 : Model := ⟨["alice","bob"],[ia,ic],[b3],system,[["alice"]]⟩
example : rows m3_2_2_1 = [b3] := by decide
example : leakageLedger m3_2_2_1 ["alice"] = [] := by decide
example : secure m3_2_2_1 = true := by decide
def m3_2_2_2 : Model := ⟨["alice","bob"],[ia,ic],[b3],system,[["bob"]]⟩
example : rows m3_2_2_2 = [b3] := by decide
example : leakageLedger m3_2_2_2 ["bob"] = [] := by decide
example : secure m3_2_2_2 = true := by decide
def m3_2_2_3 : Model := ⟨["alice","bob"],[ia,ic],[b3],system,[["alice","bob"]]⟩
example : rows m3_2_2_3 = [b3] := by decide
example : leakageLedger m3_2_2_3 ["alice","bob"] = [] := by decide
example : secure m3_2_2_3 = true := by decide
def m3_2_3_0 : Model := ⟨["alice","bob"],[ia,ic],[a3,b3],system,[[]]⟩
example : rows m3_2_3_0 = [b3] := by decide
example : leakageLedger m3_2_3_0 [] = [] := by decide
example : secure m3_2_3_0 = true := by decide
def m3_2_3_1 : Model := ⟨["alice","bob"],[ia,ic],[a3,b3],system,[["alice"]]⟩
example : rows m3_2_3_1 = [b3] := by decide
example : leakageLedger m3_2_3_1 ["alice"] = [] := by decide
example : secure m3_2_3_1 = true := by decide
def m3_2_3_2 : Model := ⟨["alice","bob"],[ia,ic],[a3,b3],system,[["bob"]]⟩
example : rows m3_2_3_2 = [b3] := by decide
example : leakageLedger m3_2_3_2 ["bob"] = [] := by decide
example : secure m3_2_3_2 = true := by decide
def m3_2_3_3 : Model := ⟨["alice","bob"],[ia,ic],[a3,b3],system,[["alice","bob"]]⟩
example : rows m3_2_3_3 = [b3] := by decide
example : leakageLedger m3_2_3_3 ["alice","bob"] = [] := by decide
example : secure m3_2_3_3 = true := by decide
def m3_3_0_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[[]]⟩
example : rows m3_3_0_0 = [] := by decide
example : leakageLedger m3_3_0_0 [] = [] := by decide
example : secure m3_3_0_0 = true := by decide
def m3_3_0_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice"]]⟩
example : rows m3_3_0_1 = [] := by decide
example : leakageLedger m3_3_0_1 ["alice"] = [] := by decide
example : secure m3_3_0_1 = true := by decide
def m3_3_0_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["bob"]]⟩
example : rows m3_3_0_2 = [] := by decide
example : leakageLedger m3_3_0_2 ["bob"] = [] := by decide
example : secure m3_3_0_2 = true := by decide
def m3_3_0_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[],system,[["alice","bob"]]⟩
example : rows m3_3_0_3 = [] := by decide
example : leakageLedger m3_3_0_3 ["alice","bob"] = [] := by decide
example : secure m3_3_0_3 = true := by decide
def m3_3_1_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3],system,[[]]⟩
example : rows m3_3_1_0 = [a3] := by decide
example : leakageLedger m3_3_1_0 [] = [] := by decide
example : secure m3_3_1_0 = true := by decide
def m3_3_1_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3],system,[["alice"]]⟩
example : rows m3_3_1_1 = [a3] := by decide
example : leakageLedger m3_3_1_1 ["alice"] = [] := by decide
example : secure m3_3_1_1 = true := by decide
def m3_3_1_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3],system,[["bob"]]⟩
example : rows m3_3_1_2 = [a3] := by decide
example : leakageLedger m3_3_1_2 ["bob"] = [] := by decide
example : secure m3_3_1_2 = true := by decide
def m3_3_1_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3],system,[["alice","bob"]]⟩
example : rows m3_3_1_3 = [a3] := by decide
example : leakageLedger m3_3_1_3 ["alice","bob"] = [] := by decide
example : secure m3_3_1_3 = true := by decide
def m3_3_2_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[b3],system,[[]]⟩
example : rows m3_3_2_0 = [b3] := by decide
example : leakageLedger m3_3_2_0 [] = [] := by decide
example : secure m3_3_2_0 = true := by decide
def m3_3_2_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[b3],system,[["alice"]]⟩
example : rows m3_3_2_1 = [b3] := by decide
example : leakageLedger m3_3_2_1 ["alice"] = [] := by decide
example : secure m3_3_2_1 = true := by decide
def m3_3_2_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[b3],system,[["bob"]]⟩
example : rows m3_3_2_2 = [b3] := by decide
example : leakageLedger m3_3_2_2 ["bob"] = [] := by decide
example : secure m3_3_2_2 = true := by decide
def m3_3_2_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[b3],system,[["alice","bob"]]⟩
example : rows m3_3_2_3 = [b3] := by decide
example : leakageLedger m3_3_2_3 ["alice","bob"] = [] := by decide
example : secure m3_3_2_3 = true := by decide
def m3_3_3_0 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3,b3],system,[[]]⟩
example : rows m3_3_3_0 = [a3,b3] := by decide
example : leakageLedger m3_3_3_0 [] = [] := by decide
example : secure m3_3_3_0 = true := by decide
def m3_3_3_1 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3,b3],system,[["alice"]]⟩
example : rows m3_3_3_1 = [a3,b3] := by decide
example : leakageLedger m3_3_3_1 ["alice"] = [(a3,b3),(b3,a3)] := by decide
example : secure m3_3_3_1 = false := by decide
def m3_3_3_2 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3,b3],system,[["bob"]]⟩
example : rows m3_3_3_2 = [a3,b3] := by decide
example : leakageLedger m3_3_3_2 ["bob"] = [] := by decide
example : secure m3_3_3_2 = true := by decide
def m3_3_3_3 : Model := ⟨["alice","bob"],[ia,ib,ic],[a3,b3],system,[["alice","bob"]]⟩
example : rows m3_3_3_3 = [a3,b3] := by decide
example : leakageLedger m3_3_3_3 ["alice","bob"] = [] := by decide
example : secure m3_3_3_3 = true := by decide
def fixtureRow : Row := ⟨[],"out",[]⟩
def fixture : Model := ⟨["alice"],[],[fixtureRow],system,[[]]⟩
def nativeExecution : Execution fixture := ⟨fixtureRow,(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩,[],.head _,"q",["step"],["q","q"],rfl⟩
theorem nativePrivacy : privateFor fixture nativeExecution.coalition = true := registeredPrivacy fixture (by decide) nativeExecution
#print axioms nativeExecution
#print axioms nativePrivacy
end SFT.Computation.Multiparty
