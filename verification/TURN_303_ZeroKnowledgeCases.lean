import SFT.Computation.ZeroKnowledge
namespace SFT.Computation.ZeroKnowledge
def system : StateTransition.System := ⟨["q","sim"],["emit"],[("q","emit","sim")]⟩
def a : RealRow := ⟨"s","w0","a"⟩
def b : RealRow := ⟨"s","w1","b"⟩
def sim : SimRow := ⟨"s","q",["emit"],["q","sim"],"sim"⟩
def m0_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[],[]⟩
example : simulations m0_0_0 a = [] := by decide
example : simulations m0_0_0 b = [] := by decide
example : simulationCovered m0_0_0 = false := by decide
example : failures m0_0_0 = [a,b] := by decide
example : correct m0_0_0 = false := by decide
example : closedLedger m0_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_0_0 = [] := by decide
def m0_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[],["a"]⟩
example : simulations m0_0_1 a = [] := by decide
example : simulations m0_0_1 b = [] := by decide
example : simulationCovered m0_0_1 = false := by decide
example : failures m0_0_1 = [a,b] := by decide
example : correct m0_0_1 = false := by decide
example : closedLedger m0_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_0_1 = [] := by decide
def m0_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[],["b"]⟩
example : simulations m0_0_2 a = [] := by decide
example : simulations m0_0_2 b = [] := by decide
example : simulationCovered m0_0_2 = false := by decide
example : failures m0_0_2 = [a,b] := by decide
example : correct m0_0_2 = false := by decide
example : closedLedger m0_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_0_2 = [] := by decide
def m0_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[],["a","b"]⟩
example : simulations m0_0_3 a = [] := by decide
example : simulations m0_0_3 b = [] := by decide
example : simulationCovered m0_0_3 = false := by decide
example : failures m0_0_3 = [a,b] := by decide
example : correct m0_0_3 = true := by decide
example : closedLedger m0_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_0_3 = [] := by decide
def m0_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[],[]⟩
example : simulations m0_1_0 a = [sim] := by decide
example : simulations m0_1_0 b = [sim] := by decide
example : simulationCovered m0_1_0 = true := by decide
example : failures m0_1_0 = [] := by decide
example : correct m0_1_0 = false := by decide
example : closedLedger m0_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_1_0 = [] := by decide
def m0_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[],["a"]⟩
example : simulations m0_1_1 a = [sim] := by decide
example : simulations m0_1_1 b = [sim] := by decide
example : simulationCovered m0_1_1 = true := by decide
example : failures m0_1_1 = [] := by decide
example : correct m0_1_1 = false := by decide
example : closedLedger m0_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_1_1 = [] := by decide
def m0_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[],["b"]⟩
example : simulations m0_1_2 a = [sim] := by decide
example : simulations m0_1_2 b = [sim] := by decide
example : simulationCovered m0_1_2 = true := by decide
example : failures m0_1_2 = [] := by decide
example : correct m0_1_2 = false := by decide
example : closedLedger m0_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_1_2 = [] := by decide
def m0_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[],["a","b"]⟩
example : simulations m0_1_3 a = [sim] := by decide
example : simulations m0_1_3 b = [sim] := by decide
example : simulationCovered m0_1_3 = true := by decide
example : failures m0_1_3 = [] := by decide
example : correct m0_1_3 = true := by decide
example : closedLedger m0_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m0_1_3 = [] := by decide
def m1_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v")],[]⟩
example : simulations m1_0_0 a = [] := by decide
example : simulations m1_0_0 b = [] := by decide
example : simulationCovered m1_0_0 = false := by decide
example : failures m1_0_0 = [a,b] := by decide
example : correct m1_0_0 = false := by decide
example : closedLedger m1_0_0 = [] := by decide
example : retainedLedger m1_0_0 = [(a,b),(b,a)] := by decide
def m1_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v")],["a"]⟩
example : simulations m1_0_1 a = [] := by decide
example : simulations m1_0_1 b = [] := by decide
example : simulationCovered m1_0_1 = false := by decide
example : failures m1_0_1 = [a,b] := by decide
example : correct m1_0_1 = false := by decide
example : closedLedger m1_0_1 = [] := by decide
example : retainedLedger m1_0_1 = [(a,b),(b,a)] := by decide
def m1_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v")],["b"]⟩
example : simulations m1_0_2 a = [] := by decide
example : simulations m1_0_2 b = [] := by decide
example : simulationCovered m1_0_2 = false := by decide
example : failures m1_0_2 = [a,b] := by decide
example : correct m1_0_2 = false := by decide
example : closedLedger m1_0_2 = [] := by decide
example : retainedLedger m1_0_2 = [(a,b),(b,a)] := by decide
def m1_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v")],["a","b"]⟩
example : simulations m1_0_3 a = [] := by decide
example : simulations m1_0_3 b = [] := by decide
example : simulationCovered m1_0_3 = false := by decide
example : failures m1_0_3 = [a,b] := by decide
example : correct m1_0_3 = true := by decide
example : closedLedger m1_0_3 = [] := by decide
example : retainedLedger m1_0_3 = [(a,b),(b,a)] := by decide
def m1_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v")],[]⟩
example : simulations m1_1_0 a = [] := by decide
example : simulations m1_1_0 b = [sim] := by decide
example : simulationCovered m1_1_0 = false := by decide
example : failures m1_1_0 = [a] := by decide
example : correct m1_1_0 = false := by decide
example : closedLedger m1_1_0 = [] := by decide
example : retainedLedger m1_1_0 = [(a,b),(b,a)] := by decide
def m1_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v")],["a"]⟩
example : simulations m1_1_1 a = [] := by decide
example : simulations m1_1_1 b = [sim] := by decide
example : simulationCovered m1_1_1 = false := by decide
example : failures m1_1_1 = [a] := by decide
example : correct m1_1_1 = false := by decide
example : closedLedger m1_1_1 = [] := by decide
example : retainedLedger m1_1_1 = [(a,b),(b,a)] := by decide
def m1_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v")],["b"]⟩
example : simulations m1_1_2 a = [] := by decide
example : simulations m1_1_2 b = [sim] := by decide
example : simulationCovered m1_1_2 = false := by decide
example : failures m1_1_2 = [a] := by decide
example : correct m1_1_2 = false := by decide
example : closedLedger m1_1_2 = [] := by decide
example : retainedLedger m1_1_2 = [(a,b),(b,a)] := by decide
def m1_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v")],["a","b"]⟩
example : simulations m1_1_3 a = [] := by decide
example : simulations m1_1_3 b = [sim] := by decide
example : simulationCovered m1_1_3 = false := by decide
example : failures m1_1_3 = [a] := by decide
example : correct m1_1_3 = true := by decide
example : closedLedger m1_1_3 = [] := by decide
example : retainedLedger m1_1_3 = [(a,b),(b,a)] := by decide
def m2_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u")],[]⟩
example : simulations m2_0_0 a = [] := by decide
example : simulations m2_0_0 b = [] := by decide
example : simulationCovered m2_0_0 = false := by decide
example : failures m2_0_0 = [a,b] := by decide
example : correct m2_0_0 = false := by decide
example : closedLedger m2_0_0 = [] := by decide
example : retainedLedger m2_0_0 = [(a,b),(b,a)] := by decide
def m2_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u")],["a"]⟩
example : simulations m2_0_1 a = [] := by decide
example : simulations m2_0_1 b = [] := by decide
example : simulationCovered m2_0_1 = false := by decide
example : failures m2_0_1 = [a,b] := by decide
example : correct m2_0_1 = false := by decide
example : closedLedger m2_0_1 = [] := by decide
example : retainedLedger m2_0_1 = [(a,b),(b,a)] := by decide
def m2_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u")],["b"]⟩
example : simulations m2_0_2 a = [] := by decide
example : simulations m2_0_2 b = [] := by decide
example : simulationCovered m2_0_2 = false := by decide
example : failures m2_0_2 = [a,b] := by decide
example : correct m2_0_2 = false := by decide
example : closedLedger m2_0_2 = [] := by decide
example : retainedLedger m2_0_2 = [(a,b),(b,a)] := by decide
def m2_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u")],["a","b"]⟩
example : simulations m2_0_3 a = [] := by decide
example : simulations m2_0_3 b = [] := by decide
example : simulationCovered m2_0_3 = false := by decide
example : failures m2_0_3 = [a,b] := by decide
example : correct m2_0_3 = true := by decide
example : closedLedger m2_0_3 = [] := by decide
example : retainedLedger m2_0_3 = [(a,b),(b,a)] := by decide
def m2_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u")],[]⟩
example : simulations m2_1_0 a = [] := by decide
example : simulations m2_1_0 b = [sim] := by decide
example : simulationCovered m2_1_0 = false := by decide
example : failures m2_1_0 = [a] := by decide
example : correct m2_1_0 = false := by decide
example : closedLedger m2_1_0 = [] := by decide
example : retainedLedger m2_1_0 = [(a,b),(b,a)] := by decide
def m2_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u")],["a"]⟩
example : simulations m2_1_1 a = [] := by decide
example : simulations m2_1_1 b = [sim] := by decide
example : simulationCovered m2_1_1 = false := by decide
example : failures m2_1_1 = [a] := by decide
example : correct m2_1_1 = false := by decide
example : closedLedger m2_1_1 = [] := by decide
example : retainedLedger m2_1_1 = [(a,b),(b,a)] := by decide
def m2_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u")],["b"]⟩
example : simulations m2_1_2 a = [] := by decide
example : simulations m2_1_2 b = [sim] := by decide
example : simulationCovered m2_1_2 = false := by decide
example : failures m2_1_2 = [a] := by decide
example : correct m2_1_2 = false := by decide
example : closedLedger m2_1_2 = [] := by decide
example : retainedLedger m2_1_2 = [(a,b),(b,a)] := by decide
def m2_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u")],["a","b"]⟩
example : simulations m2_1_3 a = [] := by decide
example : simulations m2_1_3 b = [sim] := by decide
example : simulationCovered m2_1_3 = false := by decide
example : failures m2_1_3 = [a] := by decide
example : correct m2_1_3 = true := by decide
example : closedLedger m2_1_3 = [] := by decide
example : retainedLedger m2_1_3 = [(a,b),(b,a)] := by decide
def m3_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u")],[]⟩
example : simulations m3_0_0 a = [] := by decide
example : simulations m3_0_0 b = [] := by decide
example : simulationCovered m3_0_0 = false := by decide
example : failures m3_0_0 = [a,b] := by decide
example : correct m3_0_0 = false := by decide
example : closedLedger m3_0_0 = [] := by decide
example : retainedLedger m3_0_0 = [(a,b),(b,a)] := by decide
def m3_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u")],["a"]⟩
example : simulations m3_0_1 a = [] := by decide
example : simulations m3_0_1 b = [] := by decide
example : simulationCovered m3_0_1 = false := by decide
example : failures m3_0_1 = [a,b] := by decide
example : correct m3_0_1 = false := by decide
example : closedLedger m3_0_1 = [] := by decide
example : retainedLedger m3_0_1 = [(a,b),(b,a)] := by decide
def m3_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u")],["b"]⟩
example : simulations m3_0_2 a = [] := by decide
example : simulations m3_0_2 b = [] := by decide
example : simulationCovered m3_0_2 = false := by decide
example : failures m3_0_2 = [a,b] := by decide
example : correct m3_0_2 = false := by decide
example : closedLedger m3_0_2 = [] := by decide
example : retainedLedger m3_0_2 = [(a,b),(b,a)] := by decide
def m3_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u")],["a","b"]⟩
example : simulations m3_0_3 a = [] := by decide
example : simulations m3_0_3 b = [] := by decide
example : simulationCovered m3_0_3 = false := by decide
example : failures m3_0_3 = [a,b] := by decide
example : correct m3_0_3 = true := by decide
example : closedLedger m3_0_3 = [] := by decide
example : retainedLedger m3_0_3 = [(a,b),(b,a)] := by decide
def m3_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u")],[]⟩
example : simulations m3_1_0 a = [] := by decide
example : simulations m3_1_0 b = [sim] := by decide
example : simulationCovered m3_1_0 = false := by decide
example : failures m3_1_0 = [a] := by decide
example : correct m3_1_0 = false := by decide
example : closedLedger m3_1_0 = [] := by decide
example : retainedLedger m3_1_0 = [(a,b),(b,a)] := by decide
def m3_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u")],["a"]⟩
example : simulations m3_1_1 a = [] := by decide
example : simulations m3_1_1 b = [sim] := by decide
example : simulationCovered m3_1_1 = false := by decide
example : failures m3_1_1 = [a] := by decide
example : correct m3_1_1 = false := by decide
example : closedLedger m3_1_1 = [] := by decide
example : retainedLedger m3_1_1 = [(a,b),(b,a)] := by decide
def m3_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u")],["b"]⟩
example : simulations m3_1_2 a = [] := by decide
example : simulations m3_1_2 b = [sim] := by decide
example : simulationCovered m3_1_2 = false := by decide
example : failures m3_1_2 = [a] := by decide
example : correct m3_1_2 = false := by decide
example : closedLedger m3_1_2 = [] := by decide
example : retainedLedger m3_1_2 = [(a,b),(b,a)] := by decide
def m3_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u")],["a","b"]⟩
example : simulations m3_1_3 a = [] := by decide
example : simulations m3_1_3 b = [sim] := by decide
example : simulationCovered m3_1_3 = false := by decide
example : failures m3_1_3 = [a] := by decide
example : correct m3_1_3 = true := by decide
example : closedLedger m3_1_3 = [] := by decide
example : retainedLedger m3_1_3 = [(a,b),(b,a)] := by decide
def m4_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v")],[]⟩
example : simulations m4_0_0 a = [] := by decide
example : simulations m4_0_0 b = [] := by decide
example : simulationCovered m4_0_0 = false := by decide
example : failures m4_0_0 = [a,b] := by decide
example : correct m4_0_0 = false := by decide
example : closedLedger m4_0_0 = [] := by decide
example : retainedLedger m4_0_0 = [(a,b),(b,a)] := by decide
def m4_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v")],["a"]⟩
example : simulations m4_0_1 a = [] := by decide
example : simulations m4_0_1 b = [] := by decide
example : simulationCovered m4_0_1 = false := by decide
example : failures m4_0_1 = [a,b] := by decide
example : correct m4_0_1 = false := by decide
example : closedLedger m4_0_1 = [] := by decide
example : retainedLedger m4_0_1 = [(a,b),(b,a)] := by decide
def m4_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v")],["b"]⟩
example : simulations m4_0_2 a = [] := by decide
example : simulations m4_0_2 b = [] := by decide
example : simulationCovered m4_0_2 = false := by decide
example : failures m4_0_2 = [a,b] := by decide
example : correct m4_0_2 = false := by decide
example : closedLedger m4_0_2 = [] := by decide
example : retainedLedger m4_0_2 = [(a,b),(b,a)] := by decide
def m4_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v")],["a","b"]⟩
example : simulations m4_0_3 a = [] := by decide
example : simulations m4_0_3 b = [] := by decide
example : simulationCovered m4_0_3 = false := by decide
example : failures m4_0_3 = [a,b] := by decide
example : correct m4_0_3 = true := by decide
example : closedLedger m4_0_3 = [] := by decide
example : retainedLedger m4_0_3 = [(a,b),(b,a)] := by decide
def m4_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v")],[]⟩
example : simulations m4_1_0 a = [sim] := by decide
example : simulations m4_1_0 b = [] := by decide
example : simulationCovered m4_1_0 = false := by decide
example : failures m4_1_0 = [b] := by decide
example : correct m4_1_0 = false := by decide
example : closedLedger m4_1_0 = [] := by decide
example : retainedLedger m4_1_0 = [(a,b),(b,a)] := by decide
def m4_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v")],["a"]⟩
example : simulations m4_1_1 a = [sim] := by decide
example : simulations m4_1_1 b = [] := by decide
example : simulationCovered m4_1_1 = false := by decide
example : failures m4_1_1 = [b] := by decide
example : correct m4_1_1 = false := by decide
example : closedLedger m4_1_1 = [] := by decide
example : retainedLedger m4_1_1 = [(a,b),(b,a)] := by decide
def m4_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v")],["b"]⟩
example : simulations m4_1_2 a = [sim] := by decide
example : simulations m4_1_2 b = [] := by decide
example : simulationCovered m4_1_2 = false := by decide
example : failures m4_1_2 = [b] := by decide
example : correct m4_1_2 = false := by decide
example : closedLedger m4_1_2 = [] := by decide
example : retainedLedger m4_1_2 = [(a,b),(b,a)] := by decide
def m4_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v")],["a","b"]⟩
example : simulations m4_1_3 a = [sim] := by decide
example : simulations m4_1_3 b = [] := by decide
example : simulationCovered m4_1_3 = false := by decide
example : failures m4_1_3 = [b] := by decide
example : correct m4_1_3 = true := by decide
example : closedLedger m4_1_3 = [] := by decide
example : retainedLedger m4_1_3 = [(a,b),(b,a)] := by decide
def m5_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v")],[]⟩
example : simulations m5_0_0 a = [] := by decide
example : simulations m5_0_0 b = [] := by decide
example : simulationCovered m5_0_0 = false := by decide
example : failures m5_0_0 = [a,b] := by decide
example : correct m5_0_0 = false := by decide
example : closedLedger m5_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_0_0 = [] := by decide
def m5_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v")],["a"]⟩
example : simulations m5_0_1 a = [] := by decide
example : simulations m5_0_1 b = [] := by decide
example : simulationCovered m5_0_1 = false := by decide
example : failures m5_0_1 = [a,b] := by decide
example : correct m5_0_1 = false := by decide
example : closedLedger m5_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_0_1 = [] := by decide
def m5_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v")],["b"]⟩
example : simulations m5_0_2 a = [] := by decide
example : simulations m5_0_2 b = [] := by decide
example : simulationCovered m5_0_2 = false := by decide
example : failures m5_0_2 = [a,b] := by decide
example : correct m5_0_2 = false := by decide
example : closedLedger m5_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_0_2 = [] := by decide
def m5_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v")],["a","b"]⟩
example : simulations m5_0_3 a = [] := by decide
example : simulations m5_0_3 b = [] := by decide
example : simulationCovered m5_0_3 = false := by decide
example : failures m5_0_3 = [a,b] := by decide
example : correct m5_0_3 = true := by decide
example : closedLedger m5_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_0_3 = [] := by decide
def m5_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v")],[]⟩
example : simulations m5_1_0 a = [] := by decide
example : simulations m5_1_0 b = [] := by decide
example : simulationCovered m5_1_0 = false := by decide
example : failures m5_1_0 = [a,b] := by decide
example : correct m5_1_0 = false := by decide
example : closedLedger m5_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_1_0 = [] := by decide
def m5_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v")],["a"]⟩
example : simulations m5_1_1 a = [] := by decide
example : simulations m5_1_1 b = [] := by decide
example : simulationCovered m5_1_1 = false := by decide
example : failures m5_1_1 = [a,b] := by decide
example : correct m5_1_1 = false := by decide
example : closedLedger m5_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_1_1 = [] := by decide
def m5_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v")],["b"]⟩
example : simulations m5_1_2 a = [] := by decide
example : simulations m5_1_2 b = [] := by decide
example : simulationCovered m5_1_2 = false := by decide
example : failures m5_1_2 = [a,b] := by decide
example : correct m5_1_2 = false := by decide
example : closedLedger m5_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_1_2 = [] := by decide
def m5_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v")],["a","b"]⟩
example : simulations m5_1_3 a = [] := by decide
example : simulations m5_1_3 b = [] := by decide
example : simulationCovered m5_1_3 = false := by decide
example : failures m5_1_3 = [a,b] := by decide
example : correct m5_1_3 = true := by decide
example : closedLedger m5_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m5_1_3 = [] := by decide
def m6_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v")],[]⟩
example : simulations m6_0_0 a = [] := by decide
example : simulations m6_0_0 b = [] := by decide
example : simulationCovered m6_0_0 = false := by decide
example : failures m6_0_0 = [a,b] := by decide
example : correct m6_0_0 = false := by decide
example : closedLedger m6_0_0 = [] := by decide
example : retainedLedger m6_0_0 = [(a,b),(b,a)] := by decide
def m6_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v")],["a"]⟩
example : simulations m6_0_1 a = [] := by decide
example : simulations m6_0_1 b = [] := by decide
example : simulationCovered m6_0_1 = false := by decide
example : failures m6_0_1 = [a,b] := by decide
example : correct m6_0_1 = false := by decide
example : closedLedger m6_0_1 = [] := by decide
example : retainedLedger m6_0_1 = [(a,b),(b,a)] := by decide
def m6_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v")],["b"]⟩
example : simulations m6_0_2 a = [] := by decide
example : simulations m6_0_2 b = [] := by decide
example : simulationCovered m6_0_2 = false := by decide
example : failures m6_0_2 = [a,b] := by decide
example : correct m6_0_2 = false := by decide
example : closedLedger m6_0_2 = [] := by decide
example : retainedLedger m6_0_2 = [(a,b),(b,a)] := by decide
def m6_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v")],["a","b"]⟩
example : simulations m6_0_3 a = [] := by decide
example : simulations m6_0_3 b = [] := by decide
example : simulationCovered m6_0_3 = false := by decide
example : failures m6_0_3 = [a,b] := by decide
example : correct m6_0_3 = true := by decide
example : closedLedger m6_0_3 = [] := by decide
example : retainedLedger m6_0_3 = [(a,b),(b,a)] := by decide
def m6_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v")],[]⟩
example : simulations m6_1_0 a = [] := by decide
example : simulations m6_1_0 b = [] := by decide
example : simulationCovered m6_1_0 = false := by decide
example : failures m6_1_0 = [a,b] := by decide
example : correct m6_1_0 = false := by decide
example : closedLedger m6_1_0 = [] := by decide
example : retainedLedger m6_1_0 = [(a,b),(b,a)] := by decide
def m6_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v")],["a"]⟩
example : simulations m6_1_1 a = [] := by decide
example : simulations m6_1_1 b = [] := by decide
example : simulationCovered m6_1_1 = false := by decide
example : failures m6_1_1 = [a,b] := by decide
example : correct m6_1_1 = false := by decide
example : closedLedger m6_1_1 = [] := by decide
example : retainedLedger m6_1_1 = [(a,b),(b,a)] := by decide
def m6_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v")],["b"]⟩
example : simulations m6_1_2 a = [] := by decide
example : simulations m6_1_2 b = [] := by decide
example : simulationCovered m6_1_2 = false := by decide
example : failures m6_1_2 = [a,b] := by decide
example : correct m6_1_2 = false := by decide
example : closedLedger m6_1_2 = [] := by decide
example : retainedLedger m6_1_2 = [(a,b),(b,a)] := by decide
def m6_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v")],["a","b"]⟩
example : simulations m6_1_3 a = [] := by decide
example : simulations m6_1_3 b = [] := by decide
example : simulationCovered m6_1_3 = false := by decide
example : failures m6_1_3 = [a,b] := by decide
example : correct m6_1_3 = true := by decide
example : closedLedger m6_1_3 = [] := by decide
example : retainedLedger m6_1_3 = [(a,b),(b,a)] := by decide
def m7_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v")],[]⟩
example : simulations m7_0_0 a = [] := by decide
example : simulations m7_0_0 b = [] := by decide
example : simulationCovered m7_0_0 = false := by decide
example : failures m7_0_0 = [a,b] := by decide
example : correct m7_0_0 = false := by decide
example : closedLedger m7_0_0 = [] := by decide
example : retainedLedger m7_0_0 = [(a,b),(b,a)] := by decide
def m7_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v")],["a"]⟩
example : simulations m7_0_1 a = [] := by decide
example : simulations m7_0_1 b = [] := by decide
example : simulationCovered m7_0_1 = false := by decide
example : failures m7_0_1 = [a,b] := by decide
example : correct m7_0_1 = false := by decide
example : closedLedger m7_0_1 = [] := by decide
example : retainedLedger m7_0_1 = [(a,b),(b,a)] := by decide
def m7_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v")],["b"]⟩
example : simulations m7_0_2 a = [] := by decide
example : simulations m7_0_2 b = [] := by decide
example : simulationCovered m7_0_2 = false := by decide
example : failures m7_0_2 = [a,b] := by decide
example : correct m7_0_2 = false := by decide
example : closedLedger m7_0_2 = [] := by decide
example : retainedLedger m7_0_2 = [(a,b),(b,a)] := by decide
def m7_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v")],["a","b"]⟩
example : simulations m7_0_3 a = [] := by decide
example : simulations m7_0_3 b = [] := by decide
example : simulationCovered m7_0_3 = false := by decide
example : failures m7_0_3 = [a,b] := by decide
example : correct m7_0_3 = true := by decide
example : closedLedger m7_0_3 = [] := by decide
example : retainedLedger m7_0_3 = [(a,b),(b,a)] := by decide
def m7_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v")],[]⟩
example : simulations m7_1_0 a = [] := by decide
example : simulations m7_1_0 b = [] := by decide
example : simulationCovered m7_1_0 = false := by decide
example : failures m7_1_0 = [a,b] := by decide
example : correct m7_1_0 = false := by decide
example : closedLedger m7_1_0 = [] := by decide
example : retainedLedger m7_1_0 = [(a,b),(b,a)] := by decide
def m7_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v")],["a"]⟩
example : simulations m7_1_1 a = [] := by decide
example : simulations m7_1_1 b = [] := by decide
example : simulationCovered m7_1_1 = false := by decide
example : failures m7_1_1 = [a,b] := by decide
example : correct m7_1_1 = false := by decide
example : closedLedger m7_1_1 = [] := by decide
example : retainedLedger m7_1_1 = [(a,b),(b,a)] := by decide
def m7_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v")],["b"]⟩
example : simulations m7_1_2 a = [] := by decide
example : simulations m7_1_2 b = [] := by decide
example : simulationCovered m7_1_2 = false := by decide
example : failures m7_1_2 = [a,b] := by decide
example : correct m7_1_2 = false := by decide
example : closedLedger m7_1_2 = [] := by decide
example : retainedLedger m7_1_2 = [(a,b),(b,a)] := by decide
def m7_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v")],["a","b"]⟩
example : simulations m7_1_3 a = [] := by decide
example : simulations m7_1_3 b = [] := by decide
example : simulationCovered m7_1_3 = false := by decide
example : failures m7_1_3 = [a,b] := by decide
example : correct m7_1_3 = true := by decide
example : closedLedger m7_1_3 = [] := by decide
example : retainedLedger m7_1_3 = [(a,b),(b,a)] := by decide
def m8_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u")],[]⟩
example : simulations m8_0_0 a = [] := by decide
example : simulations m8_0_0 b = [] := by decide
example : simulationCovered m8_0_0 = false := by decide
example : failures m8_0_0 = [a,b] := by decide
example : correct m8_0_0 = false := by decide
example : closedLedger m8_0_0 = [] := by decide
example : retainedLedger m8_0_0 = [(a,b),(b,a)] := by decide
def m8_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u")],["a"]⟩
example : simulations m8_0_1 a = [] := by decide
example : simulations m8_0_1 b = [] := by decide
example : simulationCovered m8_0_1 = false := by decide
example : failures m8_0_1 = [a,b] := by decide
example : correct m8_0_1 = false := by decide
example : closedLedger m8_0_1 = [] := by decide
example : retainedLedger m8_0_1 = [(a,b),(b,a)] := by decide
def m8_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u")],["b"]⟩
example : simulations m8_0_2 a = [] := by decide
example : simulations m8_0_2 b = [] := by decide
example : simulationCovered m8_0_2 = false := by decide
example : failures m8_0_2 = [a,b] := by decide
example : correct m8_0_2 = false := by decide
example : closedLedger m8_0_2 = [] := by decide
example : retainedLedger m8_0_2 = [(a,b),(b,a)] := by decide
def m8_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u")],["a","b"]⟩
example : simulations m8_0_3 a = [] := by decide
example : simulations m8_0_3 b = [] := by decide
example : simulationCovered m8_0_3 = false := by decide
example : failures m8_0_3 = [a,b] := by decide
example : correct m8_0_3 = true := by decide
example : closedLedger m8_0_3 = [] := by decide
example : retainedLedger m8_0_3 = [(a,b),(b,a)] := by decide
def m8_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u")],[]⟩
example : simulations m8_1_0 a = [sim] := by decide
example : simulations m8_1_0 b = [] := by decide
example : simulationCovered m8_1_0 = false := by decide
example : failures m8_1_0 = [b] := by decide
example : correct m8_1_0 = false := by decide
example : closedLedger m8_1_0 = [] := by decide
example : retainedLedger m8_1_0 = [(a,b),(b,a)] := by decide
def m8_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u")],["a"]⟩
example : simulations m8_1_1 a = [sim] := by decide
example : simulations m8_1_1 b = [] := by decide
example : simulationCovered m8_1_1 = false := by decide
example : failures m8_1_1 = [b] := by decide
example : correct m8_1_1 = false := by decide
example : closedLedger m8_1_1 = [] := by decide
example : retainedLedger m8_1_1 = [(a,b),(b,a)] := by decide
def m8_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u")],["b"]⟩
example : simulations m8_1_2 a = [sim] := by decide
example : simulations m8_1_2 b = [] := by decide
example : simulationCovered m8_1_2 = false := by decide
example : failures m8_1_2 = [b] := by decide
example : correct m8_1_2 = false := by decide
example : closedLedger m8_1_2 = [] := by decide
example : retainedLedger m8_1_2 = [(a,b),(b,a)] := by decide
def m8_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u")],["a","b"]⟩
example : simulations m8_1_3 a = [sim] := by decide
example : simulations m8_1_3 b = [] := by decide
example : simulationCovered m8_1_3 = false := by decide
example : failures m8_1_3 = [b] := by decide
example : correct m8_1_3 = true := by decide
example : closedLedger m8_1_3 = [] := by decide
example : retainedLedger m8_1_3 = [(a,b),(b,a)] := by decide
def m9_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u")],[]⟩
example : simulations m9_0_0 a = [] := by decide
example : simulations m9_0_0 b = [] := by decide
example : simulationCovered m9_0_0 = false := by decide
example : failures m9_0_0 = [a,b] := by decide
example : correct m9_0_0 = false := by decide
example : closedLedger m9_0_0 = [] := by decide
example : retainedLedger m9_0_0 = [(a,b),(b,a)] := by decide
def m9_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u")],["a"]⟩
example : simulations m9_0_1 a = [] := by decide
example : simulations m9_0_1 b = [] := by decide
example : simulationCovered m9_0_1 = false := by decide
example : failures m9_0_1 = [a,b] := by decide
example : correct m9_0_1 = false := by decide
example : closedLedger m9_0_1 = [] := by decide
example : retainedLedger m9_0_1 = [(a,b),(b,a)] := by decide
def m9_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u")],["b"]⟩
example : simulations m9_0_2 a = [] := by decide
example : simulations m9_0_2 b = [] := by decide
example : simulationCovered m9_0_2 = false := by decide
example : failures m9_0_2 = [a,b] := by decide
example : correct m9_0_2 = false := by decide
example : closedLedger m9_0_2 = [] := by decide
example : retainedLedger m9_0_2 = [(a,b),(b,a)] := by decide
def m9_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u")],["a","b"]⟩
example : simulations m9_0_3 a = [] := by decide
example : simulations m9_0_3 b = [] := by decide
example : simulationCovered m9_0_3 = false := by decide
example : failures m9_0_3 = [a,b] := by decide
example : correct m9_0_3 = true := by decide
example : closedLedger m9_0_3 = [] := by decide
example : retainedLedger m9_0_3 = [(a,b),(b,a)] := by decide
def m9_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u")],[]⟩
example : simulations m9_1_0 a = [] := by decide
example : simulations m9_1_0 b = [] := by decide
example : simulationCovered m9_1_0 = false := by decide
example : failures m9_1_0 = [a,b] := by decide
example : correct m9_1_0 = false := by decide
example : closedLedger m9_1_0 = [] := by decide
example : retainedLedger m9_1_0 = [(a,b),(b,a)] := by decide
def m9_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u")],["a"]⟩
example : simulations m9_1_1 a = [] := by decide
example : simulations m9_1_1 b = [] := by decide
example : simulationCovered m9_1_1 = false := by decide
example : failures m9_1_1 = [a,b] := by decide
example : correct m9_1_1 = false := by decide
example : closedLedger m9_1_1 = [] := by decide
example : retainedLedger m9_1_1 = [(a,b),(b,a)] := by decide
def m9_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u")],["b"]⟩
example : simulations m9_1_2 a = [] := by decide
example : simulations m9_1_2 b = [] := by decide
example : simulationCovered m9_1_2 = false := by decide
example : failures m9_1_2 = [a,b] := by decide
example : correct m9_1_2 = false := by decide
example : closedLedger m9_1_2 = [] := by decide
example : retainedLedger m9_1_2 = [(a,b),(b,a)] := by decide
def m9_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u")],["a","b"]⟩
example : simulations m9_1_3 a = [] := by decide
example : simulations m9_1_3 b = [] := by decide
example : simulationCovered m9_1_3 = false := by decide
example : failures m9_1_3 = [a,b] := by decide
example : correct m9_1_3 = true := by decide
example : closedLedger m9_1_3 = [] := by decide
example : retainedLedger m9_1_3 = [(a,b),(b,a)] := by decide
def m10_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u")],[]⟩
example : simulations m10_0_0 a = [] := by decide
example : simulations m10_0_0 b = [] := by decide
example : simulationCovered m10_0_0 = false := by decide
example : failures m10_0_0 = [a,b] := by decide
example : correct m10_0_0 = false := by decide
example : closedLedger m10_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_0_0 = [] := by decide
def m10_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u")],["a"]⟩
example : simulations m10_0_1 a = [] := by decide
example : simulations m10_0_1 b = [] := by decide
example : simulationCovered m10_0_1 = false := by decide
example : failures m10_0_1 = [a,b] := by decide
example : correct m10_0_1 = false := by decide
example : closedLedger m10_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_0_1 = [] := by decide
def m10_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u")],["b"]⟩
example : simulations m10_0_2 a = [] := by decide
example : simulations m10_0_2 b = [] := by decide
example : simulationCovered m10_0_2 = false := by decide
example : failures m10_0_2 = [a,b] := by decide
example : correct m10_0_2 = false := by decide
example : closedLedger m10_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_0_2 = [] := by decide
def m10_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u")],["a","b"]⟩
example : simulations m10_0_3 a = [] := by decide
example : simulations m10_0_3 b = [] := by decide
example : simulationCovered m10_0_3 = false := by decide
example : failures m10_0_3 = [a,b] := by decide
example : correct m10_0_3 = true := by decide
example : closedLedger m10_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_0_3 = [] := by decide
def m10_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u")],[]⟩
example : simulations m10_1_0 a = [] := by decide
example : simulations m10_1_0 b = [] := by decide
example : simulationCovered m10_1_0 = false := by decide
example : failures m10_1_0 = [a,b] := by decide
example : correct m10_1_0 = false := by decide
example : closedLedger m10_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_1_0 = [] := by decide
def m10_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u")],["a"]⟩
example : simulations m10_1_1 a = [] := by decide
example : simulations m10_1_1 b = [] := by decide
example : simulationCovered m10_1_1 = false := by decide
example : failures m10_1_1 = [a,b] := by decide
example : correct m10_1_1 = false := by decide
example : closedLedger m10_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_1_1 = [] := by decide
def m10_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u")],["b"]⟩
example : simulations m10_1_2 a = [] := by decide
example : simulations m10_1_2 b = [] := by decide
example : simulationCovered m10_1_2 = false := by decide
example : failures m10_1_2 = [a,b] := by decide
example : correct m10_1_2 = false := by decide
example : closedLedger m10_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_1_2 = [] := by decide
def m10_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u")],["a","b"]⟩
example : simulations m10_1_3 a = [] := by decide
example : simulations m10_1_3 b = [] := by decide
example : simulationCovered m10_1_3 = false := by decide
example : failures m10_1_3 = [a,b] := by decide
example : correct m10_1_3 = true := by decide
example : closedLedger m10_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m10_1_3 = [] := by decide
def m11_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u")],[]⟩
example : simulations m11_0_0 a = [] := by decide
example : simulations m11_0_0 b = [] := by decide
example : simulationCovered m11_0_0 = false := by decide
example : failures m11_0_0 = [a,b] := by decide
example : correct m11_0_0 = false := by decide
example : closedLedger m11_0_0 = [] := by decide
example : retainedLedger m11_0_0 = [(a,b),(b,a)] := by decide
def m11_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u")],["a"]⟩
example : simulations m11_0_1 a = [] := by decide
example : simulations m11_0_1 b = [] := by decide
example : simulationCovered m11_0_1 = false := by decide
example : failures m11_0_1 = [a,b] := by decide
example : correct m11_0_1 = false := by decide
example : closedLedger m11_0_1 = [] := by decide
example : retainedLedger m11_0_1 = [(a,b),(b,a)] := by decide
def m11_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u")],["b"]⟩
example : simulations m11_0_2 a = [] := by decide
example : simulations m11_0_2 b = [] := by decide
example : simulationCovered m11_0_2 = false := by decide
example : failures m11_0_2 = [a,b] := by decide
example : correct m11_0_2 = false := by decide
example : closedLedger m11_0_2 = [] := by decide
example : retainedLedger m11_0_2 = [(a,b),(b,a)] := by decide
def m11_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u")],["a","b"]⟩
example : simulations m11_0_3 a = [] := by decide
example : simulations m11_0_3 b = [] := by decide
example : simulationCovered m11_0_3 = false := by decide
example : failures m11_0_3 = [a,b] := by decide
example : correct m11_0_3 = true := by decide
example : closedLedger m11_0_3 = [] := by decide
example : retainedLedger m11_0_3 = [(a,b),(b,a)] := by decide
def m11_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u")],[]⟩
example : simulations m11_1_0 a = [] := by decide
example : simulations m11_1_0 b = [] := by decide
example : simulationCovered m11_1_0 = false := by decide
example : failures m11_1_0 = [a,b] := by decide
example : correct m11_1_0 = false := by decide
example : closedLedger m11_1_0 = [] := by decide
example : retainedLedger m11_1_0 = [(a,b),(b,a)] := by decide
def m11_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u")],["a"]⟩
example : simulations m11_1_1 a = [] := by decide
example : simulations m11_1_1 b = [] := by decide
example : simulationCovered m11_1_1 = false := by decide
example : failures m11_1_1 = [a,b] := by decide
example : correct m11_1_1 = false := by decide
example : closedLedger m11_1_1 = [] := by decide
example : retainedLedger m11_1_1 = [(a,b),(b,a)] := by decide
def m11_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u")],["b"]⟩
example : simulations m11_1_2 a = [] := by decide
example : simulations m11_1_2 b = [] := by decide
example : simulationCovered m11_1_2 = false := by decide
example : failures m11_1_2 = [a,b] := by decide
example : correct m11_1_2 = false := by decide
example : closedLedger m11_1_2 = [] := by decide
example : retainedLedger m11_1_2 = [(a,b),(b,a)] := by decide
def m11_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u")],["a","b"]⟩
example : simulations m11_1_3 a = [] := by decide
example : simulations m11_1_3 b = [] := by decide
example : simulationCovered m11_1_3 = false := by decide
example : failures m11_1_3 = [a,b] := by decide
example : correct m11_1_3 = true := by decide
example : closedLedger m11_1_3 = [] := by decide
example : retainedLedger m11_1_3 = [(a,b),(b,a)] := by decide
def m12_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u")],[]⟩
example : simulations m12_0_0 a = [] := by decide
example : simulations m12_0_0 b = [] := by decide
example : simulationCovered m12_0_0 = false := by decide
example : failures m12_0_0 = [a,b] := by decide
example : correct m12_0_0 = false := by decide
example : closedLedger m12_0_0 = [] := by decide
example : retainedLedger m12_0_0 = [(a,b),(b,a)] := by decide
def m12_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u")],["a"]⟩
example : simulations m12_0_1 a = [] := by decide
example : simulations m12_0_1 b = [] := by decide
example : simulationCovered m12_0_1 = false := by decide
example : failures m12_0_1 = [a,b] := by decide
example : correct m12_0_1 = false := by decide
example : closedLedger m12_0_1 = [] := by decide
example : retainedLedger m12_0_1 = [(a,b),(b,a)] := by decide
def m12_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u")],["b"]⟩
example : simulations m12_0_2 a = [] := by decide
example : simulations m12_0_2 b = [] := by decide
example : simulationCovered m12_0_2 = false := by decide
example : failures m12_0_2 = [a,b] := by decide
example : correct m12_0_2 = false := by decide
example : closedLedger m12_0_2 = [] := by decide
example : retainedLedger m12_0_2 = [(a,b),(b,a)] := by decide
def m12_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u")],["a","b"]⟩
example : simulations m12_0_3 a = [] := by decide
example : simulations m12_0_3 b = [] := by decide
example : simulationCovered m12_0_3 = false := by decide
example : failures m12_0_3 = [a,b] := by decide
example : correct m12_0_3 = true := by decide
example : closedLedger m12_0_3 = [] := by decide
example : retainedLedger m12_0_3 = [(a,b),(b,a)] := by decide
def m12_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u")],[]⟩
example : simulations m12_1_0 a = [sim] := by decide
example : simulations m12_1_0 b = [] := by decide
example : simulationCovered m12_1_0 = false := by decide
example : failures m12_1_0 = [b] := by decide
example : correct m12_1_0 = false := by decide
example : closedLedger m12_1_0 = [] := by decide
example : retainedLedger m12_1_0 = [(a,b),(b,a)] := by decide
def m12_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u")],["a"]⟩
example : simulations m12_1_1 a = [sim] := by decide
example : simulations m12_1_1 b = [] := by decide
example : simulationCovered m12_1_1 = false := by decide
example : failures m12_1_1 = [b] := by decide
example : correct m12_1_1 = false := by decide
example : closedLedger m12_1_1 = [] := by decide
example : retainedLedger m12_1_1 = [(a,b),(b,a)] := by decide
def m12_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u")],["b"]⟩
example : simulations m12_1_2 a = [sim] := by decide
example : simulations m12_1_2 b = [] := by decide
example : simulationCovered m12_1_2 = false := by decide
example : failures m12_1_2 = [b] := by decide
example : correct m12_1_2 = false := by decide
example : closedLedger m12_1_2 = [] := by decide
example : retainedLedger m12_1_2 = [(a,b),(b,a)] := by decide
def m12_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u")],["a","b"]⟩
example : simulations m12_1_3 a = [sim] := by decide
example : simulations m12_1_3 b = [] := by decide
example : simulationCovered m12_1_3 = false := by decide
example : failures m12_1_3 = [b] := by decide
example : correct m12_1_3 = true := by decide
example : closedLedger m12_1_3 = [] := by decide
example : retainedLedger m12_1_3 = [(a,b),(b,a)] := by decide
def m13_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u")],[]⟩
example : simulations m13_0_0 a = [] := by decide
example : simulations m13_0_0 b = [] := by decide
example : simulationCovered m13_0_0 = false := by decide
example : failures m13_0_0 = [a,b] := by decide
example : correct m13_0_0 = false := by decide
example : closedLedger m13_0_0 = [] := by decide
example : retainedLedger m13_0_0 = [(a,b),(b,a)] := by decide
def m13_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u")],["a"]⟩
example : simulations m13_0_1 a = [] := by decide
example : simulations m13_0_1 b = [] := by decide
example : simulationCovered m13_0_1 = false := by decide
example : failures m13_0_1 = [a,b] := by decide
example : correct m13_0_1 = false := by decide
example : closedLedger m13_0_1 = [] := by decide
example : retainedLedger m13_0_1 = [(a,b),(b,a)] := by decide
def m13_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u")],["b"]⟩
example : simulations m13_0_2 a = [] := by decide
example : simulations m13_0_2 b = [] := by decide
example : simulationCovered m13_0_2 = false := by decide
example : failures m13_0_2 = [a,b] := by decide
example : correct m13_0_2 = false := by decide
example : closedLedger m13_0_2 = [] := by decide
example : retainedLedger m13_0_2 = [(a,b),(b,a)] := by decide
def m13_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u")],["a","b"]⟩
example : simulations m13_0_3 a = [] := by decide
example : simulations m13_0_3 b = [] := by decide
example : simulationCovered m13_0_3 = false := by decide
example : failures m13_0_3 = [a,b] := by decide
example : correct m13_0_3 = true := by decide
example : closedLedger m13_0_3 = [] := by decide
example : retainedLedger m13_0_3 = [(a,b),(b,a)] := by decide
def m13_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u")],[]⟩
example : simulations m13_1_0 a = [] := by decide
example : simulations m13_1_0 b = [] := by decide
example : simulationCovered m13_1_0 = false := by decide
example : failures m13_1_0 = [a,b] := by decide
example : correct m13_1_0 = false := by decide
example : closedLedger m13_1_0 = [] := by decide
example : retainedLedger m13_1_0 = [(a,b),(b,a)] := by decide
def m13_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u")],["a"]⟩
example : simulations m13_1_1 a = [] := by decide
example : simulations m13_1_1 b = [] := by decide
example : simulationCovered m13_1_1 = false := by decide
example : failures m13_1_1 = [a,b] := by decide
example : correct m13_1_1 = false := by decide
example : closedLedger m13_1_1 = [] := by decide
example : retainedLedger m13_1_1 = [(a,b),(b,a)] := by decide
def m13_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u")],["b"]⟩
example : simulations m13_1_2 a = [] := by decide
example : simulations m13_1_2 b = [] := by decide
example : simulationCovered m13_1_2 = false := by decide
example : failures m13_1_2 = [a,b] := by decide
example : correct m13_1_2 = false := by decide
example : closedLedger m13_1_2 = [] := by decide
example : retainedLedger m13_1_2 = [(a,b),(b,a)] := by decide
def m13_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u")],["a","b"]⟩
example : simulations m13_1_3 a = [] := by decide
example : simulations m13_1_3 b = [] := by decide
example : simulationCovered m13_1_3 = false := by decide
example : failures m13_1_3 = [a,b] := by decide
example : correct m13_1_3 = true := by decide
example : closedLedger m13_1_3 = [] := by decide
example : retainedLedger m13_1_3 = [(a,b),(b,a)] := by decide
def m14_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u")],[]⟩
example : simulations m14_0_0 a = [] := by decide
example : simulations m14_0_0 b = [] := by decide
example : simulationCovered m14_0_0 = false := by decide
example : failures m14_0_0 = [a,b] := by decide
example : correct m14_0_0 = false := by decide
example : closedLedger m14_0_0 = [] := by decide
example : retainedLedger m14_0_0 = [(a,b),(b,a)] := by decide
def m14_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u")],["a"]⟩
example : simulations m14_0_1 a = [] := by decide
example : simulations m14_0_1 b = [] := by decide
example : simulationCovered m14_0_1 = false := by decide
example : failures m14_0_1 = [a,b] := by decide
example : correct m14_0_1 = false := by decide
example : closedLedger m14_0_1 = [] := by decide
example : retainedLedger m14_0_1 = [(a,b),(b,a)] := by decide
def m14_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u")],["b"]⟩
example : simulations m14_0_2 a = [] := by decide
example : simulations m14_0_2 b = [] := by decide
example : simulationCovered m14_0_2 = false := by decide
example : failures m14_0_2 = [a,b] := by decide
example : correct m14_0_2 = false := by decide
example : closedLedger m14_0_2 = [] := by decide
example : retainedLedger m14_0_2 = [(a,b),(b,a)] := by decide
def m14_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u")],["a","b"]⟩
example : simulations m14_0_3 a = [] := by decide
example : simulations m14_0_3 b = [] := by decide
example : simulationCovered m14_0_3 = false := by decide
example : failures m14_0_3 = [a,b] := by decide
example : correct m14_0_3 = true := by decide
example : closedLedger m14_0_3 = [] := by decide
example : retainedLedger m14_0_3 = [(a,b),(b,a)] := by decide
def m14_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u")],[]⟩
example : simulations m14_1_0 a = [] := by decide
example : simulations m14_1_0 b = [] := by decide
example : simulationCovered m14_1_0 = false := by decide
example : failures m14_1_0 = [a,b] := by decide
example : correct m14_1_0 = false := by decide
example : closedLedger m14_1_0 = [] := by decide
example : retainedLedger m14_1_0 = [(a,b),(b,a)] := by decide
def m14_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u")],["a"]⟩
example : simulations m14_1_1 a = [] := by decide
example : simulations m14_1_1 b = [] := by decide
example : simulationCovered m14_1_1 = false := by decide
example : failures m14_1_1 = [a,b] := by decide
example : correct m14_1_1 = false := by decide
example : closedLedger m14_1_1 = [] := by decide
example : retainedLedger m14_1_1 = [(a,b),(b,a)] := by decide
def m14_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u")],["b"]⟩
example : simulations m14_1_2 a = [] := by decide
example : simulations m14_1_2 b = [] := by decide
example : simulationCovered m14_1_2 = false := by decide
example : failures m14_1_2 = [a,b] := by decide
example : correct m14_1_2 = false := by decide
example : closedLedger m14_1_2 = [] := by decide
example : retainedLedger m14_1_2 = [(a,b),(b,a)] := by decide
def m14_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u")],["a","b"]⟩
example : simulations m14_1_3 a = [] := by decide
example : simulations m14_1_3 b = [] := by decide
example : simulationCovered m14_1_3 = false := by decide
example : failures m14_1_3 = [a,b] := by decide
example : correct m14_1_3 = true := by decide
example : closedLedger m14_1_3 = [] := by decide
example : retainedLedger m14_1_3 = [(a,b),(b,a)] := by decide
def m15_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u")],[]⟩
example : simulations m15_0_0 a = [] := by decide
example : simulations m15_0_0 b = [] := by decide
example : simulationCovered m15_0_0 = false := by decide
example : failures m15_0_0 = [a,b] := by decide
example : correct m15_0_0 = false := by decide
example : closedLedger m15_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_0_0 = [] := by decide
def m15_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u")],["a"]⟩
example : simulations m15_0_1 a = [] := by decide
example : simulations m15_0_1 b = [] := by decide
example : simulationCovered m15_0_1 = false := by decide
example : failures m15_0_1 = [a,b] := by decide
example : correct m15_0_1 = false := by decide
example : closedLedger m15_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_0_1 = [] := by decide
def m15_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u")],["b"]⟩
example : simulations m15_0_2 a = [] := by decide
example : simulations m15_0_2 b = [] := by decide
example : simulationCovered m15_0_2 = false := by decide
example : failures m15_0_2 = [a,b] := by decide
example : correct m15_0_2 = false := by decide
example : closedLedger m15_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_0_2 = [] := by decide
def m15_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u")],["a","b"]⟩
example : simulations m15_0_3 a = [] := by decide
example : simulations m15_0_3 b = [] := by decide
example : simulationCovered m15_0_3 = false := by decide
example : failures m15_0_3 = [a,b] := by decide
example : correct m15_0_3 = true := by decide
example : closedLedger m15_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_0_3 = [] := by decide
def m15_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u")],[]⟩
example : simulations m15_1_0 a = [] := by decide
example : simulations m15_1_0 b = [] := by decide
example : simulationCovered m15_1_0 = false := by decide
example : failures m15_1_0 = [a,b] := by decide
example : correct m15_1_0 = false := by decide
example : closedLedger m15_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_1_0 = [] := by decide
def m15_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u")],["a"]⟩
example : simulations m15_1_1 a = [] := by decide
example : simulations m15_1_1 b = [] := by decide
example : simulationCovered m15_1_1 = false := by decide
example : failures m15_1_1 = [a,b] := by decide
example : correct m15_1_1 = false := by decide
example : closedLedger m15_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_1_1 = [] := by decide
def m15_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u")],["b"]⟩
example : simulations m15_1_2 a = [] := by decide
example : simulations m15_1_2 b = [] := by decide
example : simulationCovered m15_1_2 = false := by decide
example : failures m15_1_2 = [a,b] := by decide
example : correct m15_1_2 = false := by decide
example : closedLedger m15_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_1_2 = [] := by decide
def m15_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u")],["a","b"]⟩
example : simulations m15_1_3 a = [] := by decide
example : simulations m15_1_3 b = [] := by decide
example : simulationCovered m15_1_3 = false := by decide
example : failures m15_1_3 = [a,b] := by decide
example : correct m15_1_3 = true := by decide
example : closedLedger m15_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m15_1_3 = [] := by decide
def m16_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v")],[]⟩
example : simulations m16_0_0 a = [] := by decide
example : simulations m16_0_0 b = [] := by decide
example : simulationCovered m16_0_0 = false := by decide
example : failures m16_0_0 = [a,b] := by decide
example : correct m16_0_0 = false := by decide
example : closedLedger m16_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_0_0 = [] := by decide
def m16_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v")],["a"]⟩
example : simulations m16_0_1 a = [] := by decide
example : simulations m16_0_1 b = [] := by decide
example : simulationCovered m16_0_1 = false := by decide
example : failures m16_0_1 = [a,b] := by decide
example : correct m16_0_1 = false := by decide
example : closedLedger m16_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_0_1 = [] := by decide
def m16_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v")],["b"]⟩
example : simulations m16_0_2 a = [] := by decide
example : simulations m16_0_2 b = [] := by decide
example : simulationCovered m16_0_2 = false := by decide
example : failures m16_0_2 = [a,b] := by decide
example : correct m16_0_2 = false := by decide
example : closedLedger m16_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_0_2 = [] := by decide
def m16_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v")],["a","b"]⟩
example : simulations m16_0_3 a = [] := by decide
example : simulations m16_0_3 b = [] := by decide
example : simulationCovered m16_0_3 = false := by decide
example : failures m16_0_3 = [a,b] := by decide
example : correct m16_0_3 = true := by decide
example : closedLedger m16_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_0_3 = [] := by decide
def m16_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v")],[]⟩
example : simulations m16_1_0 a = [] := by decide
example : simulations m16_1_0 b = [] := by decide
example : simulationCovered m16_1_0 = false := by decide
example : failures m16_1_0 = [a,b] := by decide
example : correct m16_1_0 = false := by decide
example : closedLedger m16_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_1_0 = [] := by decide
def m16_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v")],["a"]⟩
example : simulations m16_1_1 a = [] := by decide
example : simulations m16_1_1 b = [] := by decide
example : simulationCovered m16_1_1 = false := by decide
example : failures m16_1_1 = [a,b] := by decide
example : correct m16_1_1 = false := by decide
example : closedLedger m16_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_1_1 = [] := by decide
def m16_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v")],["b"]⟩
example : simulations m16_1_2 a = [] := by decide
example : simulations m16_1_2 b = [] := by decide
example : simulationCovered m16_1_2 = false := by decide
example : failures m16_1_2 = [a,b] := by decide
example : correct m16_1_2 = false := by decide
example : closedLedger m16_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_1_2 = [] := by decide
def m16_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v")],["a","b"]⟩
example : simulations m16_1_3 a = [] := by decide
example : simulations m16_1_3 b = [] := by decide
example : simulationCovered m16_1_3 = false := by decide
example : failures m16_1_3 = [a,b] := by decide
example : correct m16_1_3 = true := by decide
example : closedLedger m16_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m16_1_3 = [] := by decide
def m17_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v")],[]⟩
example : simulations m17_0_0 a = [] := by decide
example : simulations m17_0_0 b = [] := by decide
example : simulationCovered m17_0_0 = false := by decide
example : failures m17_0_0 = [a,b] := by decide
example : correct m17_0_0 = false := by decide
example : closedLedger m17_0_0 = [] := by decide
example : retainedLedger m17_0_0 = [(a,b),(b,a)] := by decide
def m17_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v")],["a"]⟩
example : simulations m17_0_1 a = [] := by decide
example : simulations m17_0_1 b = [] := by decide
example : simulationCovered m17_0_1 = false := by decide
example : failures m17_0_1 = [a,b] := by decide
example : correct m17_0_1 = false := by decide
example : closedLedger m17_0_1 = [] := by decide
example : retainedLedger m17_0_1 = [(a,b),(b,a)] := by decide
def m17_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v")],["b"]⟩
example : simulations m17_0_2 a = [] := by decide
example : simulations m17_0_2 b = [] := by decide
example : simulationCovered m17_0_2 = false := by decide
example : failures m17_0_2 = [a,b] := by decide
example : correct m17_0_2 = false := by decide
example : closedLedger m17_0_2 = [] := by decide
example : retainedLedger m17_0_2 = [(a,b),(b,a)] := by decide
def m17_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v")],["a","b"]⟩
example : simulations m17_0_3 a = [] := by decide
example : simulations m17_0_3 b = [] := by decide
example : simulationCovered m17_0_3 = false := by decide
example : failures m17_0_3 = [a,b] := by decide
example : correct m17_0_3 = true := by decide
example : closedLedger m17_0_3 = [] := by decide
example : retainedLedger m17_0_3 = [(a,b),(b,a)] := by decide
def m17_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v")],[]⟩
example : simulations m17_1_0 a = [sim] := by decide
example : simulations m17_1_0 b = [] := by decide
example : simulationCovered m17_1_0 = false := by decide
example : failures m17_1_0 = [b] := by decide
example : correct m17_1_0 = false := by decide
example : closedLedger m17_1_0 = [] := by decide
example : retainedLedger m17_1_0 = [(a,b),(b,a)] := by decide
def m17_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v")],["a"]⟩
example : simulations m17_1_1 a = [sim] := by decide
example : simulations m17_1_1 b = [] := by decide
example : simulationCovered m17_1_1 = false := by decide
example : failures m17_1_1 = [b] := by decide
example : correct m17_1_1 = false := by decide
example : closedLedger m17_1_1 = [] := by decide
example : retainedLedger m17_1_1 = [(a,b),(b,a)] := by decide
def m17_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v")],["b"]⟩
example : simulations m17_1_2 a = [sim] := by decide
example : simulations m17_1_2 b = [] := by decide
example : simulationCovered m17_1_2 = false := by decide
example : failures m17_1_2 = [b] := by decide
example : correct m17_1_2 = false := by decide
example : closedLedger m17_1_2 = [] := by decide
example : retainedLedger m17_1_2 = [(a,b),(b,a)] := by decide
def m17_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v")],["a","b"]⟩
example : simulations m17_1_3 a = [sim] := by decide
example : simulations m17_1_3 b = [] := by decide
example : simulationCovered m17_1_3 = false := by decide
example : failures m17_1_3 = [b] := by decide
example : correct m17_1_3 = true := by decide
example : closedLedger m17_1_3 = [] := by decide
example : retainedLedger m17_1_3 = [(a,b),(b,a)] := by decide
def m18_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v")],[]⟩
example : simulations m18_0_0 a = [] := by decide
example : simulations m18_0_0 b = [] := by decide
example : simulationCovered m18_0_0 = false := by decide
example : failures m18_0_0 = [a,b] := by decide
example : correct m18_0_0 = false := by decide
example : closedLedger m18_0_0 = [] := by decide
example : retainedLedger m18_0_0 = [(a,b),(b,a)] := by decide
def m18_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v")],["a"]⟩
example : simulations m18_0_1 a = [] := by decide
example : simulations m18_0_1 b = [] := by decide
example : simulationCovered m18_0_1 = false := by decide
example : failures m18_0_1 = [a,b] := by decide
example : correct m18_0_1 = false := by decide
example : closedLedger m18_0_1 = [] := by decide
example : retainedLedger m18_0_1 = [(a,b),(b,a)] := by decide
def m18_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v")],["b"]⟩
example : simulations m18_0_2 a = [] := by decide
example : simulations m18_0_2 b = [] := by decide
example : simulationCovered m18_0_2 = false := by decide
example : failures m18_0_2 = [a,b] := by decide
example : correct m18_0_2 = false := by decide
example : closedLedger m18_0_2 = [] := by decide
example : retainedLedger m18_0_2 = [(a,b),(b,a)] := by decide
def m18_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v")],["a","b"]⟩
example : simulations m18_0_3 a = [] := by decide
example : simulations m18_0_3 b = [] := by decide
example : simulationCovered m18_0_3 = false := by decide
example : failures m18_0_3 = [a,b] := by decide
example : correct m18_0_3 = true := by decide
example : closedLedger m18_0_3 = [] := by decide
example : retainedLedger m18_0_3 = [(a,b),(b,a)] := by decide
def m18_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v")],[]⟩
example : simulations m18_1_0 a = [] := by decide
example : simulations m18_1_0 b = [] := by decide
example : simulationCovered m18_1_0 = false := by decide
example : failures m18_1_0 = [a,b] := by decide
example : correct m18_1_0 = false := by decide
example : closedLedger m18_1_0 = [] := by decide
example : retainedLedger m18_1_0 = [(a,b),(b,a)] := by decide
def m18_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v")],["a"]⟩
example : simulations m18_1_1 a = [] := by decide
example : simulations m18_1_1 b = [] := by decide
example : simulationCovered m18_1_1 = false := by decide
example : failures m18_1_1 = [a,b] := by decide
example : correct m18_1_1 = false := by decide
example : closedLedger m18_1_1 = [] := by decide
example : retainedLedger m18_1_1 = [(a,b),(b,a)] := by decide
def m18_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v")],["b"]⟩
example : simulations m18_1_2 a = [] := by decide
example : simulations m18_1_2 b = [] := by decide
example : simulationCovered m18_1_2 = false := by decide
example : failures m18_1_2 = [a,b] := by decide
example : correct m18_1_2 = false := by decide
example : closedLedger m18_1_2 = [] := by decide
example : retainedLedger m18_1_2 = [(a,b),(b,a)] := by decide
def m18_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v")],["a","b"]⟩
example : simulations m18_1_3 a = [] := by decide
example : simulations m18_1_3 b = [] := by decide
example : simulationCovered m18_1_3 = false := by decide
example : failures m18_1_3 = [a,b] := by decide
example : correct m18_1_3 = true := by decide
example : closedLedger m18_1_3 = [] := by decide
example : retainedLedger m18_1_3 = [(a,b),(b,a)] := by decide
def m19_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v")],[]⟩
example : simulations m19_0_0 a = [] := by decide
example : simulations m19_0_0 b = [] := by decide
example : simulationCovered m19_0_0 = false := by decide
example : failures m19_0_0 = [a,b] := by decide
example : correct m19_0_0 = false := by decide
example : closedLedger m19_0_0 = [] := by decide
example : retainedLedger m19_0_0 = [(a,b),(b,a)] := by decide
def m19_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v")],["a"]⟩
example : simulations m19_0_1 a = [] := by decide
example : simulations m19_0_1 b = [] := by decide
example : simulationCovered m19_0_1 = false := by decide
example : failures m19_0_1 = [a,b] := by decide
example : correct m19_0_1 = false := by decide
example : closedLedger m19_0_1 = [] := by decide
example : retainedLedger m19_0_1 = [(a,b),(b,a)] := by decide
def m19_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v")],["b"]⟩
example : simulations m19_0_2 a = [] := by decide
example : simulations m19_0_2 b = [] := by decide
example : simulationCovered m19_0_2 = false := by decide
example : failures m19_0_2 = [a,b] := by decide
example : correct m19_0_2 = false := by decide
example : closedLedger m19_0_2 = [] := by decide
example : retainedLedger m19_0_2 = [(a,b),(b,a)] := by decide
def m19_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v")],["a","b"]⟩
example : simulations m19_0_3 a = [] := by decide
example : simulations m19_0_3 b = [] := by decide
example : simulationCovered m19_0_3 = false := by decide
example : failures m19_0_3 = [a,b] := by decide
example : correct m19_0_3 = true := by decide
example : closedLedger m19_0_3 = [] := by decide
example : retainedLedger m19_0_3 = [(a,b),(b,a)] := by decide
def m19_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v")],[]⟩
example : simulations m19_1_0 a = [] := by decide
example : simulations m19_1_0 b = [] := by decide
example : simulationCovered m19_1_0 = false := by decide
example : failures m19_1_0 = [a,b] := by decide
example : correct m19_1_0 = false := by decide
example : closedLedger m19_1_0 = [] := by decide
example : retainedLedger m19_1_0 = [(a,b),(b,a)] := by decide
def m19_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v")],["a"]⟩
example : simulations m19_1_1 a = [] := by decide
example : simulations m19_1_1 b = [] := by decide
example : simulationCovered m19_1_1 = false := by decide
example : failures m19_1_1 = [a,b] := by decide
example : correct m19_1_1 = false := by decide
example : closedLedger m19_1_1 = [] := by decide
example : retainedLedger m19_1_1 = [(a,b),(b,a)] := by decide
def m19_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v")],["b"]⟩
example : simulations m19_1_2 a = [] := by decide
example : simulations m19_1_2 b = [] := by decide
example : simulationCovered m19_1_2 = false := by decide
example : failures m19_1_2 = [a,b] := by decide
example : correct m19_1_2 = false := by decide
example : closedLedger m19_1_2 = [] := by decide
example : retainedLedger m19_1_2 = [(a,b),(b,a)] := by decide
def m19_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v")],["a","b"]⟩
example : simulations m19_1_3 a = [] := by decide
example : simulations m19_1_3 b = [] := by decide
example : simulationCovered m19_1_3 = false := by decide
example : failures m19_1_3 = [a,b] := by decide
example : correct m19_1_3 = true := by decide
example : closedLedger m19_1_3 = [] := by decide
example : retainedLedger m19_1_3 = [(a,b),(b,a)] := by decide
def m20_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v")],[]⟩
example : simulations m20_0_0 a = [] := by decide
example : simulations m20_0_0 b = [] := by decide
example : simulationCovered m20_0_0 = false := by decide
example : failures m20_0_0 = [a,b] := by decide
example : correct m20_0_0 = false := by decide
example : closedLedger m20_0_0 = [] := by decide
example : retainedLedger m20_0_0 = [(a,b),(b,a)] := by decide
def m20_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v")],["a"]⟩
example : simulations m20_0_1 a = [] := by decide
example : simulations m20_0_1 b = [] := by decide
example : simulationCovered m20_0_1 = false := by decide
example : failures m20_0_1 = [a,b] := by decide
example : correct m20_0_1 = false := by decide
example : closedLedger m20_0_1 = [] := by decide
example : retainedLedger m20_0_1 = [(a,b),(b,a)] := by decide
def m20_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v")],["b"]⟩
example : simulations m20_0_2 a = [] := by decide
example : simulations m20_0_2 b = [] := by decide
example : simulationCovered m20_0_2 = false := by decide
example : failures m20_0_2 = [a,b] := by decide
example : correct m20_0_2 = false := by decide
example : closedLedger m20_0_2 = [] := by decide
example : retainedLedger m20_0_2 = [(a,b),(b,a)] := by decide
def m20_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v")],["a","b"]⟩
example : simulations m20_0_3 a = [] := by decide
example : simulations m20_0_3 b = [] := by decide
example : simulationCovered m20_0_3 = false := by decide
example : failures m20_0_3 = [a,b] := by decide
example : correct m20_0_3 = true := by decide
example : closedLedger m20_0_3 = [] := by decide
example : retainedLedger m20_0_3 = [(a,b),(b,a)] := by decide
def m20_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v")],[]⟩
example : simulations m20_1_0 a = [] := by decide
example : simulations m20_1_0 b = [sim] := by decide
example : simulationCovered m20_1_0 = false := by decide
example : failures m20_1_0 = [a] := by decide
example : correct m20_1_0 = false := by decide
example : closedLedger m20_1_0 = [] := by decide
example : retainedLedger m20_1_0 = [(a,b),(b,a)] := by decide
def m20_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v")],["a"]⟩
example : simulations m20_1_1 a = [] := by decide
example : simulations m20_1_1 b = [sim] := by decide
example : simulationCovered m20_1_1 = false := by decide
example : failures m20_1_1 = [a] := by decide
example : correct m20_1_1 = false := by decide
example : closedLedger m20_1_1 = [] := by decide
example : retainedLedger m20_1_1 = [(a,b),(b,a)] := by decide
def m20_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v")],["b"]⟩
example : simulations m20_1_2 a = [] := by decide
example : simulations m20_1_2 b = [sim] := by decide
example : simulationCovered m20_1_2 = false := by decide
example : failures m20_1_2 = [a] := by decide
example : correct m20_1_2 = false := by decide
example : closedLedger m20_1_2 = [] := by decide
example : retainedLedger m20_1_2 = [(a,b),(b,a)] := by decide
def m20_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v")],["a","b"]⟩
example : simulations m20_1_3 a = [] := by decide
example : simulations m20_1_3 b = [sim] := by decide
example : simulationCovered m20_1_3 = false := by decide
example : failures m20_1_3 = [a] := by decide
example : correct m20_1_3 = true := by decide
example : closedLedger m20_1_3 = [] := by decide
example : retainedLedger m20_1_3 = [(a,b),(b,a)] := by decide
def m21_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v")],[]⟩
example : simulations m21_0_0 a = [] := by decide
example : simulations m21_0_0 b = [] := by decide
example : simulationCovered m21_0_0 = false := by decide
example : failures m21_0_0 = [a,b] := by decide
example : correct m21_0_0 = false := by decide
example : closedLedger m21_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_0_0 = [] := by decide
def m21_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v")],["a"]⟩
example : simulations m21_0_1 a = [] := by decide
example : simulations m21_0_1 b = [] := by decide
example : simulationCovered m21_0_1 = false := by decide
example : failures m21_0_1 = [a,b] := by decide
example : correct m21_0_1 = false := by decide
example : closedLedger m21_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_0_1 = [] := by decide
def m21_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v")],["b"]⟩
example : simulations m21_0_2 a = [] := by decide
example : simulations m21_0_2 b = [] := by decide
example : simulationCovered m21_0_2 = false := by decide
example : failures m21_0_2 = [a,b] := by decide
example : correct m21_0_2 = false := by decide
example : closedLedger m21_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_0_2 = [] := by decide
def m21_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v")],["a","b"]⟩
example : simulations m21_0_3 a = [] := by decide
example : simulations m21_0_3 b = [] := by decide
example : simulationCovered m21_0_3 = false := by decide
example : failures m21_0_3 = [a,b] := by decide
example : correct m21_0_3 = true := by decide
example : closedLedger m21_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_0_3 = [] := by decide
def m21_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v")],[]⟩
example : simulations m21_1_0 a = [sim] := by decide
example : simulations m21_1_0 b = [sim] := by decide
example : simulationCovered m21_1_0 = true := by decide
example : failures m21_1_0 = [] := by decide
example : correct m21_1_0 = false := by decide
example : closedLedger m21_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_1_0 = [] := by decide
def m21_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v")],["a"]⟩
example : simulations m21_1_1 a = [sim] := by decide
example : simulations m21_1_1 b = [sim] := by decide
example : simulationCovered m21_1_1 = true := by decide
example : failures m21_1_1 = [] := by decide
example : correct m21_1_1 = false := by decide
example : closedLedger m21_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_1_1 = [] := by decide
def m21_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v")],["b"]⟩
example : simulations m21_1_2 a = [sim] := by decide
example : simulations m21_1_2 b = [sim] := by decide
example : simulationCovered m21_1_2 = true := by decide
example : failures m21_1_2 = [] := by decide
example : correct m21_1_2 = false := by decide
example : closedLedger m21_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_1_2 = [] := by decide
def m21_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v")],["a","b"]⟩
example : simulations m21_1_3 a = [sim] := by decide
example : simulations m21_1_3 b = [sim] := by decide
example : simulationCovered m21_1_3 = true := by decide
example : failures m21_1_3 = [] := by decide
example : correct m21_1_3 = true := by decide
example : closedLedger m21_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m21_1_3 = [] := by decide
def m22_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v")],[]⟩
example : simulations m22_0_0 a = [] := by decide
example : simulations m22_0_0 b = [] := by decide
example : simulationCovered m22_0_0 = false := by decide
example : failures m22_0_0 = [a,b] := by decide
example : correct m22_0_0 = false := by decide
example : closedLedger m22_0_0 = [] := by decide
example : retainedLedger m22_0_0 = [(a,b),(b,a)] := by decide
def m22_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v")],["a"]⟩
example : simulations m22_0_1 a = [] := by decide
example : simulations m22_0_1 b = [] := by decide
example : simulationCovered m22_0_1 = false := by decide
example : failures m22_0_1 = [a,b] := by decide
example : correct m22_0_1 = false := by decide
example : closedLedger m22_0_1 = [] := by decide
example : retainedLedger m22_0_1 = [(a,b),(b,a)] := by decide
def m22_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v")],["b"]⟩
example : simulations m22_0_2 a = [] := by decide
example : simulations m22_0_2 b = [] := by decide
example : simulationCovered m22_0_2 = false := by decide
example : failures m22_0_2 = [a,b] := by decide
example : correct m22_0_2 = false := by decide
example : closedLedger m22_0_2 = [] := by decide
example : retainedLedger m22_0_2 = [(a,b),(b,a)] := by decide
def m22_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v")],["a","b"]⟩
example : simulations m22_0_3 a = [] := by decide
example : simulations m22_0_3 b = [] := by decide
example : simulationCovered m22_0_3 = false := by decide
example : failures m22_0_3 = [a,b] := by decide
example : correct m22_0_3 = true := by decide
example : closedLedger m22_0_3 = [] := by decide
example : retainedLedger m22_0_3 = [(a,b),(b,a)] := by decide
def m22_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v")],[]⟩
example : simulations m22_1_0 a = [] := by decide
example : simulations m22_1_0 b = [sim] := by decide
example : simulationCovered m22_1_0 = false := by decide
example : failures m22_1_0 = [a] := by decide
example : correct m22_1_0 = false := by decide
example : closedLedger m22_1_0 = [] := by decide
example : retainedLedger m22_1_0 = [(a,b),(b,a)] := by decide
def m22_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v")],["a"]⟩
example : simulations m22_1_1 a = [] := by decide
example : simulations m22_1_1 b = [sim] := by decide
example : simulationCovered m22_1_1 = false := by decide
example : failures m22_1_1 = [a] := by decide
example : correct m22_1_1 = false := by decide
example : closedLedger m22_1_1 = [] := by decide
example : retainedLedger m22_1_1 = [(a,b),(b,a)] := by decide
def m22_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v")],["b"]⟩
example : simulations m22_1_2 a = [] := by decide
example : simulations m22_1_2 b = [sim] := by decide
example : simulationCovered m22_1_2 = false := by decide
example : failures m22_1_2 = [a] := by decide
example : correct m22_1_2 = false := by decide
example : closedLedger m22_1_2 = [] := by decide
example : retainedLedger m22_1_2 = [(a,b),(b,a)] := by decide
def m22_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v")],["a","b"]⟩
example : simulations m22_1_3 a = [] := by decide
example : simulations m22_1_3 b = [sim] := by decide
example : simulationCovered m22_1_3 = false := by decide
example : failures m22_1_3 = [a] := by decide
example : correct m22_1_3 = true := by decide
example : closedLedger m22_1_3 = [] := by decide
example : retainedLedger m22_1_3 = [(a,b),(b,a)] := by decide
def m23_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v")],[]⟩
example : simulations m23_0_0 a = [] := by decide
example : simulations m23_0_0 b = [] := by decide
example : simulationCovered m23_0_0 = false := by decide
example : failures m23_0_0 = [a,b] := by decide
example : correct m23_0_0 = false := by decide
example : closedLedger m23_0_0 = [] := by decide
example : retainedLedger m23_0_0 = [(a,b),(b,a)] := by decide
def m23_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v")],["a"]⟩
example : simulations m23_0_1 a = [] := by decide
example : simulations m23_0_1 b = [] := by decide
example : simulationCovered m23_0_1 = false := by decide
example : failures m23_0_1 = [a,b] := by decide
example : correct m23_0_1 = false := by decide
example : closedLedger m23_0_1 = [] := by decide
example : retainedLedger m23_0_1 = [(a,b),(b,a)] := by decide
def m23_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v")],["b"]⟩
example : simulations m23_0_2 a = [] := by decide
example : simulations m23_0_2 b = [] := by decide
example : simulationCovered m23_0_2 = false := by decide
example : failures m23_0_2 = [a,b] := by decide
example : correct m23_0_2 = false := by decide
example : closedLedger m23_0_2 = [] := by decide
example : retainedLedger m23_0_2 = [(a,b),(b,a)] := by decide
def m23_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v")],["a","b"]⟩
example : simulations m23_0_3 a = [] := by decide
example : simulations m23_0_3 b = [] := by decide
example : simulationCovered m23_0_3 = false := by decide
example : failures m23_0_3 = [a,b] := by decide
example : correct m23_0_3 = true := by decide
example : closedLedger m23_0_3 = [] := by decide
example : retainedLedger m23_0_3 = [(a,b),(b,a)] := by decide
def m23_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v")],[]⟩
example : simulations m23_1_0 a = [] := by decide
example : simulations m23_1_0 b = [sim] := by decide
example : simulationCovered m23_1_0 = false := by decide
example : failures m23_1_0 = [a] := by decide
example : correct m23_1_0 = false := by decide
example : closedLedger m23_1_0 = [] := by decide
example : retainedLedger m23_1_0 = [(a,b),(b,a)] := by decide
def m23_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v")],["a"]⟩
example : simulations m23_1_1 a = [] := by decide
example : simulations m23_1_1 b = [sim] := by decide
example : simulationCovered m23_1_1 = false := by decide
example : failures m23_1_1 = [a] := by decide
example : correct m23_1_1 = false := by decide
example : closedLedger m23_1_1 = [] := by decide
example : retainedLedger m23_1_1 = [(a,b),(b,a)] := by decide
def m23_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v")],["b"]⟩
example : simulations m23_1_2 a = [] := by decide
example : simulations m23_1_2 b = [sim] := by decide
example : simulationCovered m23_1_2 = false := by decide
example : failures m23_1_2 = [a] := by decide
example : correct m23_1_2 = false := by decide
example : closedLedger m23_1_2 = [] := by decide
example : retainedLedger m23_1_2 = [(a,b),(b,a)] := by decide
def m23_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v")],["a","b"]⟩
example : simulations m23_1_3 a = [] := by decide
example : simulations m23_1_3 b = [sim] := by decide
example : simulationCovered m23_1_3 = false := by decide
example : failures m23_1_3 = [a] := by decide
example : correct m23_1_3 = true := by decide
example : closedLedger m23_1_3 = [] := by decide
example : retainedLedger m23_1_3 = [(a,b),(b,a)] := by decide
def m24_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v")],[]⟩
example : simulations m24_0_0 a = [] := by decide
example : simulations m24_0_0 b = [] := by decide
example : simulationCovered m24_0_0 = false := by decide
example : failures m24_0_0 = [a,b] := by decide
example : correct m24_0_0 = false := by decide
example : closedLedger m24_0_0 = [] := by decide
example : retainedLedger m24_0_0 = [(a,b),(b,a)] := by decide
def m24_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v")],["a"]⟩
example : simulations m24_0_1 a = [] := by decide
example : simulations m24_0_1 b = [] := by decide
example : simulationCovered m24_0_1 = false := by decide
example : failures m24_0_1 = [a,b] := by decide
example : correct m24_0_1 = false := by decide
example : closedLedger m24_0_1 = [] := by decide
example : retainedLedger m24_0_1 = [(a,b),(b,a)] := by decide
def m24_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v")],["b"]⟩
example : simulations m24_0_2 a = [] := by decide
example : simulations m24_0_2 b = [] := by decide
example : simulationCovered m24_0_2 = false := by decide
example : failures m24_0_2 = [a,b] := by decide
example : correct m24_0_2 = false := by decide
example : closedLedger m24_0_2 = [] := by decide
example : retainedLedger m24_0_2 = [(a,b),(b,a)] := by decide
def m24_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v")],["a","b"]⟩
example : simulations m24_0_3 a = [] := by decide
example : simulations m24_0_3 b = [] := by decide
example : simulationCovered m24_0_3 = false := by decide
example : failures m24_0_3 = [a,b] := by decide
example : correct m24_0_3 = true := by decide
example : closedLedger m24_0_3 = [] := by decide
example : retainedLedger m24_0_3 = [(a,b),(b,a)] := by decide
def m24_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v")],[]⟩
example : simulations m24_1_0 a = [] := by decide
example : simulations m24_1_0 b = [] := by decide
example : simulationCovered m24_1_0 = false := by decide
example : failures m24_1_0 = [a,b] := by decide
example : correct m24_1_0 = false := by decide
example : closedLedger m24_1_0 = [] := by decide
example : retainedLedger m24_1_0 = [(a,b),(b,a)] := by decide
def m24_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v")],["a"]⟩
example : simulations m24_1_1 a = [] := by decide
example : simulations m24_1_1 b = [] := by decide
example : simulationCovered m24_1_1 = false := by decide
example : failures m24_1_1 = [a,b] := by decide
example : correct m24_1_1 = false := by decide
example : closedLedger m24_1_1 = [] := by decide
example : retainedLedger m24_1_1 = [(a,b),(b,a)] := by decide
def m24_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v")],["b"]⟩
example : simulations m24_1_2 a = [] := by decide
example : simulations m24_1_2 b = [] := by decide
example : simulationCovered m24_1_2 = false := by decide
example : failures m24_1_2 = [a,b] := by decide
example : correct m24_1_2 = false := by decide
example : closedLedger m24_1_2 = [] := by decide
example : retainedLedger m24_1_2 = [(a,b),(b,a)] := by decide
def m24_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v")],["a","b"]⟩
example : simulations m24_1_3 a = [] := by decide
example : simulations m24_1_3 b = [] := by decide
example : simulationCovered m24_1_3 = false := by decide
example : failures m24_1_3 = [a,b] := by decide
example : correct m24_1_3 = true := by decide
example : closedLedger m24_1_3 = [] := by decide
example : retainedLedger m24_1_3 = [(a,b),(b,a)] := by decide
def m25_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v")],[]⟩
example : simulations m25_0_0 a = [] := by decide
example : simulations m25_0_0 b = [] := by decide
example : simulationCovered m25_0_0 = false := by decide
example : failures m25_0_0 = [a,b] := by decide
example : correct m25_0_0 = false := by decide
example : closedLedger m25_0_0 = [] := by decide
example : retainedLedger m25_0_0 = [(a,b),(b,a)] := by decide
def m25_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m25_0_1 a = [] := by decide
example : simulations m25_0_1 b = [] := by decide
example : simulationCovered m25_0_1 = false := by decide
example : failures m25_0_1 = [a,b] := by decide
example : correct m25_0_1 = false := by decide
example : closedLedger m25_0_1 = [] := by decide
example : retainedLedger m25_0_1 = [(a,b),(b,a)] := by decide
def m25_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m25_0_2 a = [] := by decide
example : simulations m25_0_2 b = [] := by decide
example : simulationCovered m25_0_2 = false := by decide
example : failures m25_0_2 = [a,b] := by decide
example : correct m25_0_2 = false := by decide
example : closedLedger m25_0_2 = [] := by decide
example : retainedLedger m25_0_2 = [(a,b),(b,a)] := by decide
def m25_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m25_0_3 a = [] := by decide
example : simulations m25_0_3 b = [] := by decide
example : simulationCovered m25_0_3 = false := by decide
example : failures m25_0_3 = [a,b] := by decide
example : correct m25_0_3 = true := by decide
example : closedLedger m25_0_3 = [] := by decide
example : retainedLedger m25_0_3 = [(a,b),(b,a)] := by decide
def m25_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v")],[]⟩
example : simulations m25_1_0 a = [sim] := by decide
example : simulations m25_1_0 b = [] := by decide
example : simulationCovered m25_1_0 = false := by decide
example : failures m25_1_0 = [b] := by decide
example : correct m25_1_0 = false := by decide
example : closedLedger m25_1_0 = [] := by decide
example : retainedLedger m25_1_0 = [(a,b),(b,a)] := by decide
def m25_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m25_1_1 a = [sim] := by decide
example : simulations m25_1_1 b = [] := by decide
example : simulationCovered m25_1_1 = false := by decide
example : failures m25_1_1 = [b] := by decide
example : correct m25_1_1 = false := by decide
example : closedLedger m25_1_1 = [] := by decide
example : retainedLedger m25_1_1 = [(a,b),(b,a)] := by decide
def m25_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m25_1_2 a = [sim] := by decide
example : simulations m25_1_2 b = [] := by decide
example : simulationCovered m25_1_2 = false := by decide
example : failures m25_1_2 = [b] := by decide
example : correct m25_1_2 = false := by decide
example : closedLedger m25_1_2 = [] := by decide
example : retainedLedger m25_1_2 = [(a,b),(b,a)] := by decide
def m25_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m25_1_3 a = [sim] := by decide
example : simulations m25_1_3 b = [] := by decide
example : simulationCovered m25_1_3 = false := by decide
example : failures m25_1_3 = [b] := by decide
example : correct m25_1_3 = true := by decide
example : closedLedger m25_1_3 = [] := by decide
example : retainedLedger m25_1_3 = [(a,b),(b,a)] := by decide
def m26_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v")],[]⟩
example : simulations m26_0_0 a = [] := by decide
example : simulations m26_0_0 b = [] := by decide
example : simulationCovered m26_0_0 = false := by decide
example : failures m26_0_0 = [a,b] := by decide
example : correct m26_0_0 = false := by decide
example : closedLedger m26_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_0_0 = [] := by decide
def m26_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v")],["a"]⟩
example : simulations m26_0_1 a = [] := by decide
example : simulations m26_0_1 b = [] := by decide
example : simulationCovered m26_0_1 = false := by decide
example : failures m26_0_1 = [a,b] := by decide
example : correct m26_0_1 = false := by decide
example : closedLedger m26_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_0_1 = [] := by decide
def m26_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v")],["b"]⟩
example : simulations m26_0_2 a = [] := by decide
example : simulations m26_0_2 b = [] := by decide
example : simulationCovered m26_0_2 = false := by decide
example : failures m26_0_2 = [a,b] := by decide
example : correct m26_0_2 = false := by decide
example : closedLedger m26_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_0_2 = [] := by decide
def m26_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m26_0_3 a = [] := by decide
example : simulations m26_0_3 b = [] := by decide
example : simulationCovered m26_0_3 = false := by decide
example : failures m26_0_3 = [a,b] := by decide
example : correct m26_0_3 = true := by decide
example : closedLedger m26_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_0_3 = [] := by decide
def m26_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v")],[]⟩
example : simulations m26_1_0 a = [] := by decide
example : simulations m26_1_0 b = [] := by decide
example : simulationCovered m26_1_0 = false := by decide
example : failures m26_1_0 = [a,b] := by decide
example : correct m26_1_0 = false := by decide
example : closedLedger m26_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_1_0 = [] := by decide
def m26_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v")],["a"]⟩
example : simulations m26_1_1 a = [] := by decide
example : simulations m26_1_1 b = [] := by decide
example : simulationCovered m26_1_1 = false := by decide
example : failures m26_1_1 = [a,b] := by decide
example : correct m26_1_1 = false := by decide
example : closedLedger m26_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_1_1 = [] := by decide
def m26_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v")],["b"]⟩
example : simulations m26_1_2 a = [] := by decide
example : simulations m26_1_2 b = [] := by decide
example : simulationCovered m26_1_2 = false := by decide
example : failures m26_1_2 = [a,b] := by decide
example : correct m26_1_2 = false := by decide
example : closedLedger m26_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_1_2 = [] := by decide
def m26_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m26_1_3 a = [] := by decide
example : simulations m26_1_3 b = [] := by decide
example : simulationCovered m26_1_3 = false := by decide
example : failures m26_1_3 = [a,b] := by decide
example : correct m26_1_3 = true := by decide
example : closedLedger m26_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m26_1_3 = [] := by decide
def m27_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v")],[]⟩
example : simulations m27_0_0 a = [] := by decide
example : simulations m27_0_0 b = [] := by decide
example : simulationCovered m27_0_0 = false := by decide
example : failures m27_0_0 = [a,b] := by decide
example : correct m27_0_0 = false := by decide
example : closedLedger m27_0_0 = [] := by decide
example : retainedLedger m27_0_0 = [(a,b),(b,a)] := by decide
def m27_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v")],["a"]⟩
example : simulations m27_0_1 a = [] := by decide
example : simulations m27_0_1 b = [] := by decide
example : simulationCovered m27_0_1 = false := by decide
example : failures m27_0_1 = [a,b] := by decide
example : correct m27_0_1 = false := by decide
example : closedLedger m27_0_1 = [] := by decide
example : retainedLedger m27_0_1 = [(a,b),(b,a)] := by decide
def m27_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v")],["b"]⟩
example : simulations m27_0_2 a = [] := by decide
example : simulations m27_0_2 b = [] := by decide
example : simulationCovered m27_0_2 = false := by decide
example : failures m27_0_2 = [a,b] := by decide
example : correct m27_0_2 = false := by decide
example : closedLedger m27_0_2 = [] := by decide
example : retainedLedger m27_0_2 = [(a,b),(b,a)] := by decide
def m27_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m27_0_3 a = [] := by decide
example : simulations m27_0_3 b = [] := by decide
example : simulationCovered m27_0_3 = false := by decide
example : failures m27_0_3 = [a,b] := by decide
example : correct m27_0_3 = true := by decide
example : closedLedger m27_0_3 = [] := by decide
example : retainedLedger m27_0_3 = [(a,b),(b,a)] := by decide
def m27_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v")],[]⟩
example : simulations m27_1_0 a = [] := by decide
example : simulations m27_1_0 b = [] := by decide
example : simulationCovered m27_1_0 = false := by decide
example : failures m27_1_0 = [a,b] := by decide
example : correct m27_1_0 = false := by decide
example : closedLedger m27_1_0 = [] := by decide
example : retainedLedger m27_1_0 = [(a,b),(b,a)] := by decide
def m27_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v")],["a"]⟩
example : simulations m27_1_1 a = [] := by decide
example : simulations m27_1_1 b = [] := by decide
example : simulationCovered m27_1_1 = false := by decide
example : failures m27_1_1 = [a,b] := by decide
example : correct m27_1_1 = false := by decide
example : closedLedger m27_1_1 = [] := by decide
example : retainedLedger m27_1_1 = [(a,b),(b,a)] := by decide
def m27_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v")],["b"]⟩
example : simulations m27_1_2 a = [] := by decide
example : simulations m27_1_2 b = [] := by decide
example : simulationCovered m27_1_2 = false := by decide
example : failures m27_1_2 = [a,b] := by decide
example : correct m27_1_2 = false := by decide
example : closedLedger m27_1_2 = [] := by decide
example : retainedLedger m27_1_2 = [(a,b),(b,a)] := by decide
def m27_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m27_1_3 a = [] := by decide
example : simulations m27_1_3 b = [] := by decide
example : simulationCovered m27_1_3 = false := by decide
example : failures m27_1_3 = [a,b] := by decide
example : correct m27_1_3 = true := by decide
example : closedLedger m27_1_3 = [] := by decide
example : retainedLedger m27_1_3 = [(a,b),(b,a)] := by decide
def m28_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m28_0_0 a = [] := by decide
example : simulations m28_0_0 b = [] := by decide
example : simulationCovered m28_0_0 = false := by decide
example : failures m28_0_0 = [a,b] := by decide
example : correct m28_0_0 = false := by decide
example : closedLedger m28_0_0 = [] := by decide
example : retainedLedger m28_0_0 = [(a,b),(b,a)] := by decide
def m28_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m28_0_1 a = [] := by decide
example : simulations m28_0_1 b = [] := by decide
example : simulationCovered m28_0_1 = false := by decide
example : failures m28_0_1 = [a,b] := by decide
example : correct m28_0_1 = false := by decide
example : closedLedger m28_0_1 = [] := by decide
example : retainedLedger m28_0_1 = [(a,b),(b,a)] := by decide
def m28_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m28_0_2 a = [] := by decide
example : simulations m28_0_2 b = [] := by decide
example : simulationCovered m28_0_2 = false := by decide
example : failures m28_0_2 = [a,b] := by decide
example : correct m28_0_2 = false := by decide
example : closedLedger m28_0_2 = [] := by decide
example : retainedLedger m28_0_2 = [(a,b),(b,a)] := by decide
def m28_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m28_0_3 a = [] := by decide
example : simulations m28_0_3 b = [] := by decide
example : simulationCovered m28_0_3 = false := by decide
example : failures m28_0_3 = [a,b] := by decide
example : correct m28_0_3 = true := by decide
example : closedLedger m28_0_3 = [] := by decide
example : retainedLedger m28_0_3 = [(a,b),(b,a)] := by decide
def m28_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m28_1_0 a = [] := by decide
example : simulations m28_1_0 b = [] := by decide
example : simulationCovered m28_1_0 = false := by decide
example : failures m28_1_0 = [a,b] := by decide
example : correct m28_1_0 = false := by decide
example : closedLedger m28_1_0 = [] := by decide
example : retainedLedger m28_1_0 = [(a,b),(b,a)] := by decide
def m28_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m28_1_1 a = [] := by decide
example : simulations m28_1_1 b = [] := by decide
example : simulationCovered m28_1_1 = false := by decide
example : failures m28_1_1 = [a,b] := by decide
example : correct m28_1_1 = false := by decide
example : closedLedger m28_1_1 = [] := by decide
example : retainedLedger m28_1_1 = [(a,b),(b,a)] := by decide
def m28_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m28_1_2 a = [] := by decide
example : simulations m28_1_2 b = [] := by decide
example : simulationCovered m28_1_2 = false := by decide
example : failures m28_1_2 = [a,b] := by decide
example : correct m28_1_2 = false := by decide
example : closedLedger m28_1_2 = [] := by decide
example : retainedLedger m28_1_2 = [(a,b),(b,a)] := by decide
def m28_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m28_1_3 a = [] := by decide
example : simulations m28_1_3 b = [] := by decide
example : simulationCovered m28_1_3 = false := by decide
example : failures m28_1_3 = [a,b] := by decide
example : correct m28_1_3 = true := by decide
example : closedLedger m28_1_3 = [] := by decide
example : retainedLedger m28_1_3 = [(a,b),(b,a)] := by decide
def m29_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m29_0_0 a = [] := by decide
example : simulations m29_0_0 b = [] := by decide
example : simulationCovered m29_0_0 = false := by decide
example : failures m29_0_0 = [a,b] := by decide
example : correct m29_0_0 = false := by decide
example : closedLedger m29_0_0 = [] := by decide
example : retainedLedger m29_0_0 = [(a,b),(b,a)] := by decide
def m29_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m29_0_1 a = [] := by decide
example : simulations m29_0_1 b = [] := by decide
example : simulationCovered m29_0_1 = false := by decide
example : failures m29_0_1 = [a,b] := by decide
example : correct m29_0_1 = false := by decide
example : closedLedger m29_0_1 = [] := by decide
example : retainedLedger m29_0_1 = [(a,b),(b,a)] := by decide
def m29_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m29_0_2 a = [] := by decide
example : simulations m29_0_2 b = [] := by decide
example : simulationCovered m29_0_2 = false := by decide
example : failures m29_0_2 = [a,b] := by decide
example : correct m29_0_2 = false := by decide
example : closedLedger m29_0_2 = [] := by decide
example : retainedLedger m29_0_2 = [(a,b),(b,a)] := by decide
def m29_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m29_0_3 a = [] := by decide
example : simulations m29_0_3 b = [] := by decide
example : simulationCovered m29_0_3 = false := by decide
example : failures m29_0_3 = [a,b] := by decide
example : correct m29_0_3 = true := by decide
example : closedLedger m29_0_3 = [] := by decide
example : retainedLedger m29_0_3 = [(a,b),(b,a)] := by decide
def m29_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m29_1_0 a = [sim] := by decide
example : simulations m29_1_0 b = [] := by decide
example : simulationCovered m29_1_0 = false := by decide
example : failures m29_1_0 = [b] := by decide
example : correct m29_1_0 = false := by decide
example : closedLedger m29_1_0 = [] := by decide
example : retainedLedger m29_1_0 = [(a,b),(b,a)] := by decide
def m29_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m29_1_1 a = [sim] := by decide
example : simulations m29_1_1 b = [] := by decide
example : simulationCovered m29_1_1 = false := by decide
example : failures m29_1_1 = [b] := by decide
example : correct m29_1_1 = false := by decide
example : closedLedger m29_1_1 = [] := by decide
example : retainedLedger m29_1_1 = [(a,b),(b,a)] := by decide
def m29_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m29_1_2 a = [sim] := by decide
example : simulations m29_1_2 b = [] := by decide
example : simulationCovered m29_1_2 = false := by decide
example : failures m29_1_2 = [b] := by decide
example : correct m29_1_2 = false := by decide
example : closedLedger m29_1_2 = [] := by decide
example : retainedLedger m29_1_2 = [(a,b),(b,a)] := by decide
def m29_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m29_1_3 a = [sim] := by decide
example : simulations m29_1_3 b = [] := by decide
example : simulationCovered m29_1_3 = false := by decide
example : failures m29_1_3 = [b] := by decide
example : correct m29_1_3 = true := by decide
example : closedLedger m29_1_3 = [] := by decide
example : retainedLedger m29_1_3 = [(a,b),(b,a)] := by decide
def m30_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m30_0_0 a = [] := by decide
example : simulations m30_0_0 b = [] := by decide
example : simulationCovered m30_0_0 = false := by decide
example : failures m30_0_0 = [a,b] := by decide
example : correct m30_0_0 = false := by decide
example : closedLedger m30_0_0 = [] := by decide
example : retainedLedger m30_0_0 = [(a,b),(b,a)] := by decide
def m30_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m30_0_1 a = [] := by decide
example : simulations m30_0_1 b = [] := by decide
example : simulationCovered m30_0_1 = false := by decide
example : failures m30_0_1 = [a,b] := by decide
example : correct m30_0_1 = false := by decide
example : closedLedger m30_0_1 = [] := by decide
example : retainedLedger m30_0_1 = [(a,b),(b,a)] := by decide
def m30_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m30_0_2 a = [] := by decide
example : simulations m30_0_2 b = [] := by decide
example : simulationCovered m30_0_2 = false := by decide
example : failures m30_0_2 = [a,b] := by decide
example : correct m30_0_2 = false := by decide
example : closedLedger m30_0_2 = [] := by decide
example : retainedLedger m30_0_2 = [(a,b),(b,a)] := by decide
def m30_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m30_0_3 a = [] := by decide
example : simulations m30_0_3 b = [] := by decide
example : simulationCovered m30_0_3 = false := by decide
example : failures m30_0_3 = [a,b] := by decide
example : correct m30_0_3 = true := by decide
example : closedLedger m30_0_3 = [] := by decide
example : retainedLedger m30_0_3 = [(a,b),(b,a)] := by decide
def m30_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m30_1_0 a = [] := by decide
example : simulations m30_1_0 b = [] := by decide
example : simulationCovered m30_1_0 = false := by decide
example : failures m30_1_0 = [a,b] := by decide
example : correct m30_1_0 = false := by decide
example : closedLedger m30_1_0 = [] := by decide
example : retainedLedger m30_1_0 = [(a,b),(b,a)] := by decide
def m30_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m30_1_1 a = [] := by decide
example : simulations m30_1_1 b = [] := by decide
example : simulationCovered m30_1_1 = false := by decide
example : failures m30_1_1 = [a,b] := by decide
example : correct m30_1_1 = false := by decide
example : closedLedger m30_1_1 = [] := by decide
example : retainedLedger m30_1_1 = [(a,b),(b,a)] := by decide
def m30_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m30_1_2 a = [] := by decide
example : simulations m30_1_2 b = [] := by decide
example : simulationCovered m30_1_2 = false := by decide
example : failures m30_1_2 = [a,b] := by decide
example : correct m30_1_2 = false := by decide
example : closedLedger m30_1_2 = [] := by decide
example : retainedLedger m30_1_2 = [(a,b),(b,a)] := by decide
def m30_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m30_1_3 a = [] := by decide
example : simulations m30_1_3 b = [] := by decide
example : simulationCovered m30_1_3 = false := by decide
example : failures m30_1_3 = [a,b] := by decide
example : correct m30_1_3 = true := by decide
example : closedLedger m30_1_3 = [] := by decide
example : retainedLedger m30_1_3 = [(a,b),(b,a)] := by decide
def m31_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m31_0_0 a = [] := by decide
example : simulations m31_0_0 b = [] := by decide
example : simulationCovered m31_0_0 = false := by decide
example : failures m31_0_0 = [a,b] := by decide
example : correct m31_0_0 = false := by decide
example : closedLedger m31_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_0_0 = [] := by decide
def m31_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m31_0_1 a = [] := by decide
example : simulations m31_0_1 b = [] := by decide
example : simulationCovered m31_0_1 = false := by decide
example : failures m31_0_1 = [a,b] := by decide
example : correct m31_0_1 = false := by decide
example : closedLedger m31_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_0_1 = [] := by decide
def m31_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m31_0_2 a = [] := by decide
example : simulations m31_0_2 b = [] := by decide
example : simulationCovered m31_0_2 = false := by decide
example : failures m31_0_2 = [a,b] := by decide
example : correct m31_0_2 = false := by decide
example : closedLedger m31_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_0_2 = [] := by decide
def m31_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m31_0_3 a = [] := by decide
example : simulations m31_0_3 b = [] := by decide
example : simulationCovered m31_0_3 = false := by decide
example : failures m31_0_3 = [a,b] := by decide
example : correct m31_0_3 = true := by decide
example : closedLedger m31_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_0_3 = [] := by decide
def m31_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],[]⟩
example : simulations m31_1_0 a = [] := by decide
example : simulations m31_1_0 b = [] := by decide
example : simulationCovered m31_1_0 = false := by decide
example : failures m31_1_0 = [a,b] := by decide
example : correct m31_1_0 = false := by decide
example : closedLedger m31_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_1_0 = [] := by decide
def m31_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],["a"]⟩
example : simulations m31_1_1 a = [] := by decide
example : simulations m31_1_1 b = [] := by decide
example : simulationCovered m31_1_1 = false := by decide
example : failures m31_1_1 = [a,b] := by decide
example : correct m31_1_1 = false := by decide
example : closedLedger m31_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_1_1 = [] := by decide
def m31_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],["b"]⟩
example : simulations m31_1_2 a = [] := by decide
example : simulations m31_1_2 b = [] := by decide
example : simulationCovered m31_1_2 = false := by decide
example : failures m31_1_2 = [a,b] := by decide
example : correct m31_1_2 = false := by decide
example : closedLedger m31_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_1_2 = [] := by decide
def m31_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v")],["a","b"]⟩
example : simulations m31_1_3 a = [] := by decide
example : simulations m31_1_3 b = [] := by decide
example : simulationCovered m31_1_3 = false := by decide
example : failures m31_1_3 = [a,b] := by decide
example : correct m31_1_3 = true := by decide
example : closedLedger m31_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m31_1_3 = [] := by decide
def m32_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","u")],[]⟩
example : simulations m32_0_0 a = [] := by decide
example : simulations m32_0_0 b = [] := by decide
example : simulationCovered m32_0_0 = false := by decide
example : failures m32_0_0 = [a,b] := by decide
example : correct m32_0_0 = false := by decide
example : closedLedger m32_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_0_0 = [] := by decide
def m32_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","u")],["a"]⟩
example : simulations m32_0_1 a = [] := by decide
example : simulations m32_0_1 b = [] := by decide
example : simulationCovered m32_0_1 = false := by decide
example : failures m32_0_1 = [a,b] := by decide
example : correct m32_0_1 = false := by decide
example : closedLedger m32_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_0_1 = [] := by decide
def m32_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","u")],["b"]⟩
example : simulations m32_0_2 a = [] := by decide
example : simulations m32_0_2 b = [] := by decide
example : simulationCovered m32_0_2 = false := by decide
example : failures m32_0_2 = [a,b] := by decide
example : correct m32_0_2 = false := by decide
example : closedLedger m32_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_0_2 = [] := by decide
def m32_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","u")],["a","b"]⟩
example : simulations m32_0_3 a = [] := by decide
example : simulations m32_0_3 b = [] := by decide
example : simulationCovered m32_0_3 = false := by decide
example : failures m32_0_3 = [a,b] := by decide
example : correct m32_0_3 = true := by decide
example : closedLedger m32_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_0_3 = [] := by decide
def m32_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","u")],[]⟩
example : simulations m32_1_0 a = [] := by decide
example : simulations m32_1_0 b = [] := by decide
example : simulationCovered m32_1_0 = false := by decide
example : failures m32_1_0 = [a,b] := by decide
example : correct m32_1_0 = false := by decide
example : closedLedger m32_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_1_0 = [] := by decide
def m32_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","u")],["a"]⟩
example : simulations m32_1_1 a = [] := by decide
example : simulations m32_1_1 b = [] := by decide
example : simulationCovered m32_1_1 = false := by decide
example : failures m32_1_1 = [a,b] := by decide
example : correct m32_1_1 = false := by decide
example : closedLedger m32_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_1_1 = [] := by decide
def m32_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","u")],["b"]⟩
example : simulations m32_1_2 a = [] := by decide
example : simulations m32_1_2 b = [] := by decide
example : simulationCovered m32_1_2 = false := by decide
example : failures m32_1_2 = [a,b] := by decide
example : correct m32_1_2 = false := by decide
example : closedLedger m32_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_1_2 = [] := by decide
def m32_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","u")],["a","b"]⟩
example : simulations m32_1_3 a = [] := by decide
example : simulations m32_1_3 b = [] := by decide
example : simulationCovered m32_1_3 = false := by decide
example : failures m32_1_3 = [a,b] := by decide
example : correct m32_1_3 = true := by decide
example : closedLedger m32_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m32_1_3 = [] := by decide
def m33_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","u")],[]⟩
example : simulations m33_0_0 a = [] := by decide
example : simulations m33_0_0 b = [] := by decide
example : simulationCovered m33_0_0 = false := by decide
example : failures m33_0_0 = [a,b] := by decide
example : correct m33_0_0 = false := by decide
example : closedLedger m33_0_0 = [] := by decide
example : retainedLedger m33_0_0 = [(a,b),(b,a)] := by decide
def m33_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","u")],["a"]⟩
example : simulations m33_0_1 a = [] := by decide
example : simulations m33_0_1 b = [] := by decide
example : simulationCovered m33_0_1 = false := by decide
example : failures m33_0_1 = [a,b] := by decide
example : correct m33_0_1 = false := by decide
example : closedLedger m33_0_1 = [] := by decide
example : retainedLedger m33_0_1 = [(a,b),(b,a)] := by decide
def m33_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","u")],["b"]⟩
example : simulations m33_0_2 a = [] := by decide
example : simulations m33_0_2 b = [] := by decide
example : simulationCovered m33_0_2 = false := by decide
example : failures m33_0_2 = [a,b] := by decide
example : correct m33_0_2 = false := by decide
example : closedLedger m33_0_2 = [] := by decide
example : retainedLedger m33_0_2 = [(a,b),(b,a)] := by decide
def m33_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","u")],["a","b"]⟩
example : simulations m33_0_3 a = [] := by decide
example : simulations m33_0_3 b = [] := by decide
example : simulationCovered m33_0_3 = false := by decide
example : failures m33_0_3 = [a,b] := by decide
example : correct m33_0_3 = true := by decide
example : closedLedger m33_0_3 = [] := by decide
example : retainedLedger m33_0_3 = [(a,b),(b,a)] := by decide
def m33_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","u")],[]⟩
example : simulations m33_1_0 a = [] := by decide
example : simulations m33_1_0 b = [] := by decide
example : simulationCovered m33_1_0 = false := by decide
example : failures m33_1_0 = [a,b] := by decide
example : correct m33_1_0 = false := by decide
example : closedLedger m33_1_0 = [] := by decide
example : retainedLedger m33_1_0 = [(a,b),(b,a)] := by decide
def m33_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","u")],["a"]⟩
example : simulations m33_1_1 a = [] := by decide
example : simulations m33_1_1 b = [] := by decide
example : simulationCovered m33_1_1 = false := by decide
example : failures m33_1_1 = [a,b] := by decide
example : correct m33_1_1 = false := by decide
example : closedLedger m33_1_1 = [] := by decide
example : retainedLedger m33_1_1 = [(a,b),(b,a)] := by decide
def m33_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","u")],["b"]⟩
example : simulations m33_1_2 a = [] := by decide
example : simulations m33_1_2 b = [] := by decide
example : simulationCovered m33_1_2 = false := by decide
example : failures m33_1_2 = [a,b] := by decide
example : correct m33_1_2 = false := by decide
example : closedLedger m33_1_2 = [] := by decide
example : retainedLedger m33_1_2 = [(a,b),(b,a)] := by decide
def m33_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","u")],["a","b"]⟩
example : simulations m33_1_3 a = [] := by decide
example : simulations m33_1_3 b = [] := by decide
example : simulationCovered m33_1_3 = false := by decide
example : failures m33_1_3 = [a,b] := by decide
example : correct m33_1_3 = true := by decide
example : closedLedger m33_1_3 = [] := by decide
example : retainedLedger m33_1_3 = [(a,b),(b,a)] := by decide
def m34_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","u")],[]⟩
example : simulations m34_0_0 a = [] := by decide
example : simulations m34_0_0 b = [] := by decide
example : simulationCovered m34_0_0 = false := by decide
example : failures m34_0_0 = [a,b] := by decide
example : correct m34_0_0 = false := by decide
example : closedLedger m34_0_0 = [] := by decide
example : retainedLedger m34_0_0 = [(a,b),(b,a)] := by decide
def m34_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","u")],["a"]⟩
example : simulations m34_0_1 a = [] := by decide
example : simulations m34_0_1 b = [] := by decide
example : simulationCovered m34_0_1 = false := by decide
example : failures m34_0_1 = [a,b] := by decide
example : correct m34_0_1 = false := by decide
example : closedLedger m34_0_1 = [] := by decide
example : retainedLedger m34_0_1 = [(a,b),(b,a)] := by decide
def m34_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","u")],["b"]⟩
example : simulations m34_0_2 a = [] := by decide
example : simulations m34_0_2 b = [] := by decide
example : simulationCovered m34_0_2 = false := by decide
example : failures m34_0_2 = [a,b] := by decide
example : correct m34_0_2 = false := by decide
example : closedLedger m34_0_2 = [] := by decide
example : retainedLedger m34_0_2 = [(a,b),(b,a)] := by decide
def m34_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","u")],["a","b"]⟩
example : simulations m34_0_3 a = [] := by decide
example : simulations m34_0_3 b = [] := by decide
example : simulationCovered m34_0_3 = false := by decide
example : failures m34_0_3 = [a,b] := by decide
example : correct m34_0_3 = true := by decide
example : closedLedger m34_0_3 = [] := by decide
example : retainedLedger m34_0_3 = [(a,b),(b,a)] := by decide
def m34_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","u")],[]⟩
example : simulations m34_1_0 a = [sim] := by decide
example : simulations m34_1_0 b = [] := by decide
example : simulationCovered m34_1_0 = false := by decide
example : failures m34_1_0 = [b] := by decide
example : correct m34_1_0 = false := by decide
example : closedLedger m34_1_0 = [] := by decide
example : retainedLedger m34_1_0 = [(a,b),(b,a)] := by decide
def m34_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","u")],["a"]⟩
example : simulations m34_1_1 a = [sim] := by decide
example : simulations m34_1_1 b = [] := by decide
example : simulationCovered m34_1_1 = false := by decide
example : failures m34_1_1 = [b] := by decide
example : correct m34_1_1 = false := by decide
example : closedLedger m34_1_1 = [] := by decide
example : retainedLedger m34_1_1 = [(a,b),(b,a)] := by decide
def m34_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","u")],["b"]⟩
example : simulations m34_1_2 a = [sim] := by decide
example : simulations m34_1_2 b = [] := by decide
example : simulationCovered m34_1_2 = false := by decide
example : failures m34_1_2 = [b] := by decide
example : correct m34_1_2 = false := by decide
example : closedLedger m34_1_2 = [] := by decide
example : retainedLedger m34_1_2 = [(a,b),(b,a)] := by decide
def m34_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","u")],["a","b"]⟩
example : simulations m34_1_3 a = [sim] := by decide
example : simulations m34_1_3 b = [] := by decide
example : simulationCovered m34_1_3 = false := by decide
example : failures m34_1_3 = [b] := by decide
example : correct m34_1_3 = true := by decide
example : closedLedger m34_1_3 = [] := by decide
example : retainedLedger m34_1_3 = [(a,b),(b,a)] := by decide
def m35_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","u")],[]⟩
example : simulations m35_0_0 a = [] := by decide
example : simulations m35_0_0 b = [] := by decide
example : simulationCovered m35_0_0 = false := by decide
example : failures m35_0_0 = [a,b] := by decide
example : correct m35_0_0 = false := by decide
example : closedLedger m35_0_0 = [] := by decide
example : retainedLedger m35_0_0 = [(a,b),(b,a)] := by decide
def m35_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","u")],["a"]⟩
example : simulations m35_0_1 a = [] := by decide
example : simulations m35_0_1 b = [] := by decide
example : simulationCovered m35_0_1 = false := by decide
example : failures m35_0_1 = [a,b] := by decide
example : correct m35_0_1 = false := by decide
example : closedLedger m35_0_1 = [] := by decide
example : retainedLedger m35_0_1 = [(a,b),(b,a)] := by decide
def m35_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","u")],["b"]⟩
example : simulations m35_0_2 a = [] := by decide
example : simulations m35_0_2 b = [] := by decide
example : simulationCovered m35_0_2 = false := by decide
example : failures m35_0_2 = [a,b] := by decide
example : correct m35_0_2 = false := by decide
example : closedLedger m35_0_2 = [] := by decide
example : retainedLedger m35_0_2 = [(a,b),(b,a)] := by decide
def m35_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","u")],["a","b"]⟩
example : simulations m35_0_3 a = [] := by decide
example : simulations m35_0_3 b = [] := by decide
example : simulationCovered m35_0_3 = false := by decide
example : failures m35_0_3 = [a,b] := by decide
example : correct m35_0_3 = true := by decide
example : closedLedger m35_0_3 = [] := by decide
example : retainedLedger m35_0_3 = [(a,b),(b,a)] := by decide
def m35_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","u")],[]⟩
example : simulations m35_1_0 a = [] := by decide
example : simulations m35_1_0 b = [] := by decide
example : simulationCovered m35_1_0 = false := by decide
example : failures m35_1_0 = [a,b] := by decide
example : correct m35_1_0 = false := by decide
example : closedLedger m35_1_0 = [] := by decide
example : retainedLedger m35_1_0 = [(a,b),(b,a)] := by decide
def m35_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","u")],["a"]⟩
example : simulations m35_1_1 a = [] := by decide
example : simulations m35_1_1 b = [] := by decide
example : simulationCovered m35_1_1 = false := by decide
example : failures m35_1_1 = [a,b] := by decide
example : correct m35_1_1 = false := by decide
example : closedLedger m35_1_1 = [] := by decide
example : retainedLedger m35_1_1 = [(a,b),(b,a)] := by decide
def m35_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","u")],["b"]⟩
example : simulations m35_1_2 a = [] := by decide
example : simulations m35_1_2 b = [] := by decide
example : simulationCovered m35_1_2 = false := by decide
example : failures m35_1_2 = [a,b] := by decide
example : correct m35_1_2 = false := by decide
example : closedLedger m35_1_2 = [] := by decide
example : retainedLedger m35_1_2 = [(a,b),(b,a)] := by decide
def m35_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","u")],["a","b"]⟩
example : simulations m35_1_3 a = [] := by decide
example : simulations m35_1_3 b = [] := by decide
example : simulationCovered m35_1_3 = false := by decide
example : failures m35_1_3 = [a,b] := by decide
example : correct m35_1_3 = true := by decide
example : closedLedger m35_1_3 = [] := by decide
example : retainedLedger m35_1_3 = [(a,b),(b,a)] := by decide
def m36_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","u")],[]⟩
example : simulations m36_0_0 a = [] := by decide
example : simulations m36_0_0 b = [] := by decide
example : simulationCovered m36_0_0 = false := by decide
example : failures m36_0_0 = [a,b] := by decide
example : correct m36_0_0 = false := by decide
example : closedLedger m36_0_0 = [] := by decide
example : retainedLedger m36_0_0 = [(a,b),(b,a)] := by decide
def m36_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","u")],["a"]⟩
example : simulations m36_0_1 a = [] := by decide
example : simulations m36_0_1 b = [] := by decide
example : simulationCovered m36_0_1 = false := by decide
example : failures m36_0_1 = [a,b] := by decide
example : correct m36_0_1 = false := by decide
example : closedLedger m36_0_1 = [] := by decide
example : retainedLedger m36_0_1 = [(a,b),(b,a)] := by decide
def m36_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","u")],["b"]⟩
example : simulations m36_0_2 a = [] := by decide
example : simulations m36_0_2 b = [] := by decide
example : simulationCovered m36_0_2 = false := by decide
example : failures m36_0_2 = [a,b] := by decide
example : correct m36_0_2 = false := by decide
example : closedLedger m36_0_2 = [] := by decide
example : retainedLedger m36_0_2 = [(a,b),(b,a)] := by decide
def m36_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","u")],["a","b"]⟩
example : simulations m36_0_3 a = [] := by decide
example : simulations m36_0_3 b = [] := by decide
example : simulationCovered m36_0_3 = false := by decide
example : failures m36_0_3 = [a,b] := by decide
example : correct m36_0_3 = true := by decide
example : closedLedger m36_0_3 = [] := by decide
example : retainedLedger m36_0_3 = [(a,b),(b,a)] := by decide
def m36_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","u")],[]⟩
example : simulations m36_1_0 a = [] := by decide
example : simulations m36_1_0 b = [] := by decide
example : simulationCovered m36_1_0 = false := by decide
example : failures m36_1_0 = [a,b] := by decide
example : correct m36_1_0 = false := by decide
example : closedLedger m36_1_0 = [] := by decide
example : retainedLedger m36_1_0 = [(a,b),(b,a)] := by decide
def m36_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","u")],["a"]⟩
example : simulations m36_1_1 a = [] := by decide
example : simulations m36_1_1 b = [] := by decide
example : simulationCovered m36_1_1 = false := by decide
example : failures m36_1_1 = [a,b] := by decide
example : correct m36_1_1 = false := by decide
example : closedLedger m36_1_1 = [] := by decide
example : retainedLedger m36_1_1 = [(a,b),(b,a)] := by decide
def m36_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","u")],["b"]⟩
example : simulations m36_1_2 a = [] := by decide
example : simulations m36_1_2 b = [] := by decide
example : simulationCovered m36_1_2 = false := by decide
example : failures m36_1_2 = [a,b] := by decide
example : correct m36_1_2 = false := by decide
example : closedLedger m36_1_2 = [] := by decide
example : retainedLedger m36_1_2 = [(a,b),(b,a)] := by decide
def m36_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","u")],["a","b"]⟩
example : simulations m36_1_3 a = [] := by decide
example : simulations m36_1_3 b = [] := by decide
example : simulationCovered m36_1_3 = false := by decide
example : failures m36_1_3 = [a,b] := by decide
example : correct m36_1_3 = true := by decide
example : closedLedger m36_1_3 = [] := by decide
example : retainedLedger m36_1_3 = [(a,b),(b,a)] := by decide
def m37_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","u")],[]⟩
example : simulations m37_0_0 a = [] := by decide
example : simulations m37_0_0 b = [] := by decide
example : simulationCovered m37_0_0 = false := by decide
example : failures m37_0_0 = [a,b] := by decide
example : correct m37_0_0 = false := by decide
example : closedLedger m37_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_0_0 = [] := by decide
def m37_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","u")],["a"]⟩
example : simulations m37_0_1 a = [] := by decide
example : simulations m37_0_1 b = [] := by decide
example : simulationCovered m37_0_1 = false := by decide
example : failures m37_0_1 = [a,b] := by decide
example : correct m37_0_1 = false := by decide
example : closedLedger m37_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_0_1 = [] := by decide
def m37_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","u")],["b"]⟩
example : simulations m37_0_2 a = [] := by decide
example : simulations m37_0_2 b = [] := by decide
example : simulationCovered m37_0_2 = false := by decide
example : failures m37_0_2 = [a,b] := by decide
example : correct m37_0_2 = false := by decide
example : closedLedger m37_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_0_2 = [] := by decide
def m37_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","u")],["a","b"]⟩
example : simulations m37_0_3 a = [] := by decide
example : simulations m37_0_3 b = [] := by decide
example : simulationCovered m37_0_3 = false := by decide
example : failures m37_0_3 = [a,b] := by decide
example : correct m37_0_3 = true := by decide
example : closedLedger m37_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_0_3 = [] := by decide
def m37_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","u")],[]⟩
example : simulations m37_1_0 a = [] := by decide
example : simulations m37_1_0 b = [] := by decide
example : simulationCovered m37_1_0 = false := by decide
example : failures m37_1_0 = [a,b] := by decide
example : correct m37_1_0 = false := by decide
example : closedLedger m37_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_1_0 = [] := by decide
def m37_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","u")],["a"]⟩
example : simulations m37_1_1 a = [] := by decide
example : simulations m37_1_1 b = [] := by decide
example : simulationCovered m37_1_1 = false := by decide
example : failures m37_1_1 = [a,b] := by decide
example : correct m37_1_1 = false := by decide
example : closedLedger m37_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_1_1 = [] := by decide
def m37_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","u")],["b"]⟩
example : simulations m37_1_2 a = [] := by decide
example : simulations m37_1_2 b = [] := by decide
example : simulationCovered m37_1_2 = false := by decide
example : failures m37_1_2 = [a,b] := by decide
example : correct m37_1_2 = false := by decide
example : closedLedger m37_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_1_2 = [] := by decide
def m37_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","u")],["a","b"]⟩
example : simulations m37_1_3 a = [] := by decide
example : simulations m37_1_3 b = [] := by decide
example : simulationCovered m37_1_3 = false := by decide
example : failures m37_1_3 = [a,b] := by decide
example : correct m37_1_3 = true := by decide
example : closedLedger m37_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m37_1_3 = [] := by decide
def m38_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","u")],[]⟩
example : simulations m38_0_0 a = [] := by decide
example : simulations m38_0_0 b = [] := by decide
example : simulationCovered m38_0_0 = false := by decide
example : failures m38_0_0 = [a,b] := by decide
example : correct m38_0_0 = false := by decide
example : closedLedger m38_0_0 = [] := by decide
example : retainedLedger m38_0_0 = [(a,b),(b,a)] := by decide
def m38_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","u")],["a"]⟩
example : simulations m38_0_1 a = [] := by decide
example : simulations m38_0_1 b = [] := by decide
example : simulationCovered m38_0_1 = false := by decide
example : failures m38_0_1 = [a,b] := by decide
example : correct m38_0_1 = false := by decide
example : closedLedger m38_0_1 = [] := by decide
example : retainedLedger m38_0_1 = [(a,b),(b,a)] := by decide
def m38_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","u")],["b"]⟩
example : simulations m38_0_2 a = [] := by decide
example : simulations m38_0_2 b = [] := by decide
example : simulationCovered m38_0_2 = false := by decide
example : failures m38_0_2 = [a,b] := by decide
example : correct m38_0_2 = false := by decide
example : closedLedger m38_0_2 = [] := by decide
example : retainedLedger m38_0_2 = [(a,b),(b,a)] := by decide
def m38_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","u")],["a","b"]⟩
example : simulations m38_0_3 a = [] := by decide
example : simulations m38_0_3 b = [] := by decide
example : simulationCovered m38_0_3 = false := by decide
example : failures m38_0_3 = [a,b] := by decide
example : correct m38_0_3 = true := by decide
example : closedLedger m38_0_3 = [] := by decide
example : retainedLedger m38_0_3 = [(a,b),(b,a)] := by decide
def m38_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","u")],[]⟩
example : simulations m38_1_0 a = [sim] := by decide
example : simulations m38_1_0 b = [] := by decide
example : simulationCovered m38_1_0 = false := by decide
example : failures m38_1_0 = [b] := by decide
example : correct m38_1_0 = false := by decide
example : closedLedger m38_1_0 = [] := by decide
example : retainedLedger m38_1_0 = [(a,b),(b,a)] := by decide
def m38_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","u")],["a"]⟩
example : simulations m38_1_1 a = [sim] := by decide
example : simulations m38_1_1 b = [] := by decide
example : simulationCovered m38_1_1 = false := by decide
example : failures m38_1_1 = [b] := by decide
example : correct m38_1_1 = false := by decide
example : closedLedger m38_1_1 = [] := by decide
example : retainedLedger m38_1_1 = [(a,b),(b,a)] := by decide
def m38_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","u")],["b"]⟩
example : simulations m38_1_2 a = [sim] := by decide
example : simulations m38_1_2 b = [] := by decide
example : simulationCovered m38_1_2 = false := by decide
example : failures m38_1_2 = [b] := by decide
example : correct m38_1_2 = false := by decide
example : closedLedger m38_1_2 = [] := by decide
example : retainedLedger m38_1_2 = [(a,b),(b,a)] := by decide
def m38_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","u")],["a","b"]⟩
example : simulations m38_1_3 a = [sim] := by decide
example : simulations m38_1_3 b = [] := by decide
example : simulationCovered m38_1_3 = false := by decide
example : failures m38_1_3 = [b] := by decide
example : correct m38_1_3 = true := by decide
example : closedLedger m38_1_3 = [] := by decide
example : retainedLedger m38_1_3 = [(a,b),(b,a)] := by decide
def m39_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","u")],[]⟩
example : simulations m39_0_0 a = [] := by decide
example : simulations m39_0_0 b = [] := by decide
example : simulationCovered m39_0_0 = false := by decide
example : failures m39_0_0 = [a,b] := by decide
example : correct m39_0_0 = false := by decide
example : closedLedger m39_0_0 = [] := by decide
example : retainedLedger m39_0_0 = [(a,b),(b,a)] := by decide
def m39_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","u")],["a"]⟩
example : simulations m39_0_1 a = [] := by decide
example : simulations m39_0_1 b = [] := by decide
example : simulationCovered m39_0_1 = false := by decide
example : failures m39_0_1 = [a,b] := by decide
example : correct m39_0_1 = false := by decide
example : closedLedger m39_0_1 = [] := by decide
example : retainedLedger m39_0_1 = [(a,b),(b,a)] := by decide
def m39_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","u")],["b"]⟩
example : simulations m39_0_2 a = [] := by decide
example : simulations m39_0_2 b = [] := by decide
example : simulationCovered m39_0_2 = false := by decide
example : failures m39_0_2 = [a,b] := by decide
example : correct m39_0_2 = false := by decide
example : closedLedger m39_0_2 = [] := by decide
example : retainedLedger m39_0_2 = [(a,b),(b,a)] := by decide
def m39_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","u")],["a","b"]⟩
example : simulations m39_0_3 a = [] := by decide
example : simulations m39_0_3 b = [] := by decide
example : simulationCovered m39_0_3 = false := by decide
example : failures m39_0_3 = [a,b] := by decide
example : correct m39_0_3 = true := by decide
example : closedLedger m39_0_3 = [] := by decide
example : retainedLedger m39_0_3 = [(a,b),(b,a)] := by decide
def m39_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","u")],[]⟩
example : simulations m39_1_0 a = [] := by decide
example : simulations m39_1_0 b = [] := by decide
example : simulationCovered m39_1_0 = false := by decide
example : failures m39_1_0 = [a,b] := by decide
example : correct m39_1_0 = false := by decide
example : closedLedger m39_1_0 = [] := by decide
example : retainedLedger m39_1_0 = [(a,b),(b,a)] := by decide
def m39_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","u")],["a"]⟩
example : simulations m39_1_1 a = [] := by decide
example : simulations m39_1_1 b = [] := by decide
example : simulationCovered m39_1_1 = false := by decide
example : failures m39_1_1 = [a,b] := by decide
example : correct m39_1_1 = false := by decide
example : closedLedger m39_1_1 = [] := by decide
example : retainedLedger m39_1_1 = [(a,b),(b,a)] := by decide
def m39_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","u")],["b"]⟩
example : simulations m39_1_2 a = [] := by decide
example : simulations m39_1_2 b = [] := by decide
example : simulationCovered m39_1_2 = false := by decide
example : failures m39_1_2 = [a,b] := by decide
example : correct m39_1_2 = false := by decide
example : closedLedger m39_1_2 = [] := by decide
example : retainedLedger m39_1_2 = [(a,b),(b,a)] := by decide
def m39_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","u")],["a","b"]⟩
example : simulations m39_1_3 a = [] := by decide
example : simulations m39_1_3 b = [] := by decide
example : simulationCovered m39_1_3 = false := by decide
example : failures m39_1_3 = [a,b] := by decide
example : correct m39_1_3 = true := by decide
example : closedLedger m39_1_3 = [] := by decide
example : retainedLedger m39_1_3 = [(a,b),(b,a)] := by decide
def m40_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","u")],[]⟩
example : simulations m40_0_0 a = [] := by decide
example : simulations m40_0_0 b = [] := by decide
example : simulationCovered m40_0_0 = false := by decide
example : failures m40_0_0 = [a,b] := by decide
example : correct m40_0_0 = false := by decide
example : closedLedger m40_0_0 = [] := by decide
example : retainedLedger m40_0_0 = [(a,b),(b,a)] := by decide
def m40_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","u")],["a"]⟩
example : simulations m40_0_1 a = [] := by decide
example : simulations m40_0_1 b = [] := by decide
example : simulationCovered m40_0_1 = false := by decide
example : failures m40_0_1 = [a,b] := by decide
example : correct m40_0_1 = false := by decide
example : closedLedger m40_0_1 = [] := by decide
example : retainedLedger m40_0_1 = [(a,b),(b,a)] := by decide
def m40_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","u")],["b"]⟩
example : simulations m40_0_2 a = [] := by decide
example : simulations m40_0_2 b = [] := by decide
example : simulationCovered m40_0_2 = false := by decide
example : failures m40_0_2 = [a,b] := by decide
example : correct m40_0_2 = false := by decide
example : closedLedger m40_0_2 = [] := by decide
example : retainedLedger m40_0_2 = [(a,b),(b,a)] := by decide
def m40_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","u")],["a","b"]⟩
example : simulations m40_0_3 a = [] := by decide
example : simulations m40_0_3 b = [] := by decide
example : simulationCovered m40_0_3 = false := by decide
example : failures m40_0_3 = [a,b] := by decide
example : correct m40_0_3 = true := by decide
example : closedLedger m40_0_3 = [] := by decide
example : retainedLedger m40_0_3 = [(a,b),(b,a)] := by decide
def m40_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","u")],[]⟩
example : simulations m40_1_0 a = [] := by decide
example : simulations m40_1_0 b = [sim] := by decide
example : simulationCovered m40_1_0 = false := by decide
example : failures m40_1_0 = [a] := by decide
example : correct m40_1_0 = false := by decide
example : closedLedger m40_1_0 = [] := by decide
example : retainedLedger m40_1_0 = [(a,b),(b,a)] := by decide
def m40_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","u")],["a"]⟩
example : simulations m40_1_1 a = [] := by decide
example : simulations m40_1_1 b = [sim] := by decide
example : simulationCovered m40_1_1 = false := by decide
example : failures m40_1_1 = [a] := by decide
example : correct m40_1_1 = false := by decide
example : closedLedger m40_1_1 = [] := by decide
example : retainedLedger m40_1_1 = [(a,b),(b,a)] := by decide
def m40_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","u")],["b"]⟩
example : simulations m40_1_2 a = [] := by decide
example : simulations m40_1_2 b = [sim] := by decide
example : simulationCovered m40_1_2 = false := by decide
example : failures m40_1_2 = [a] := by decide
example : correct m40_1_2 = false := by decide
example : closedLedger m40_1_2 = [] := by decide
example : retainedLedger m40_1_2 = [(a,b),(b,a)] := by decide
def m40_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","u")],["a","b"]⟩
example : simulations m40_1_3 a = [] := by decide
example : simulations m40_1_3 b = [sim] := by decide
example : simulationCovered m40_1_3 = false := by decide
example : failures m40_1_3 = [a] := by decide
example : correct m40_1_3 = true := by decide
example : closedLedger m40_1_3 = [] := by decide
example : retainedLedger m40_1_3 = [(a,b),(b,a)] := by decide
def m41_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","u")],[]⟩
example : simulations m41_0_0 a = [] := by decide
example : simulations m41_0_0 b = [] := by decide
example : simulationCovered m41_0_0 = false := by decide
example : failures m41_0_0 = [a,b] := by decide
example : correct m41_0_0 = false := by decide
example : closedLedger m41_0_0 = [] := by decide
example : retainedLedger m41_0_0 = [(a,b),(b,a)] := by decide
def m41_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m41_0_1 a = [] := by decide
example : simulations m41_0_1 b = [] := by decide
example : simulationCovered m41_0_1 = false := by decide
example : failures m41_0_1 = [a,b] := by decide
example : correct m41_0_1 = false := by decide
example : closedLedger m41_0_1 = [] := by decide
example : retainedLedger m41_0_1 = [(a,b),(b,a)] := by decide
def m41_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m41_0_2 a = [] := by decide
example : simulations m41_0_2 b = [] := by decide
example : simulationCovered m41_0_2 = false := by decide
example : failures m41_0_2 = [a,b] := by decide
example : correct m41_0_2 = false := by decide
example : closedLedger m41_0_2 = [] := by decide
example : retainedLedger m41_0_2 = [(a,b),(b,a)] := by decide
def m41_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m41_0_3 a = [] := by decide
example : simulations m41_0_3 b = [] := by decide
example : simulationCovered m41_0_3 = false := by decide
example : failures m41_0_3 = [a,b] := by decide
example : correct m41_0_3 = true := by decide
example : closedLedger m41_0_3 = [] := by decide
example : retainedLedger m41_0_3 = [(a,b),(b,a)] := by decide
def m41_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","u")],[]⟩
example : simulations m41_1_0 a = [] := by decide
example : simulations m41_1_0 b = [sim] := by decide
example : simulationCovered m41_1_0 = false := by decide
example : failures m41_1_0 = [a] := by decide
example : correct m41_1_0 = false := by decide
example : closedLedger m41_1_0 = [] := by decide
example : retainedLedger m41_1_0 = [(a,b),(b,a)] := by decide
def m41_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m41_1_1 a = [] := by decide
example : simulations m41_1_1 b = [sim] := by decide
example : simulationCovered m41_1_1 = false := by decide
example : failures m41_1_1 = [a] := by decide
example : correct m41_1_1 = false := by decide
example : closedLedger m41_1_1 = [] := by decide
example : retainedLedger m41_1_1 = [(a,b),(b,a)] := by decide
def m41_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m41_1_2 a = [] := by decide
example : simulations m41_1_2 b = [sim] := by decide
example : simulationCovered m41_1_2 = false := by decide
example : failures m41_1_2 = [a] := by decide
example : correct m41_1_2 = false := by decide
example : closedLedger m41_1_2 = [] := by decide
example : retainedLedger m41_1_2 = [(a,b),(b,a)] := by decide
def m41_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m41_1_3 a = [] := by decide
example : simulations m41_1_3 b = [sim] := by decide
example : simulationCovered m41_1_3 = false := by decide
example : failures m41_1_3 = [a] := by decide
example : correct m41_1_3 = true := by decide
example : closedLedger m41_1_3 = [] := by decide
example : retainedLedger m41_1_3 = [(a,b),(b,a)] := by decide
def m42_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","u")],[]⟩
example : simulations m42_0_0 a = [] := by decide
example : simulations m42_0_0 b = [] := by decide
example : simulationCovered m42_0_0 = false := by decide
example : failures m42_0_0 = [a,b] := by decide
example : correct m42_0_0 = false := by decide
example : closedLedger m42_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_0_0 = [] := by decide
def m42_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","u")],["a"]⟩
example : simulations m42_0_1 a = [] := by decide
example : simulations m42_0_1 b = [] := by decide
example : simulationCovered m42_0_1 = false := by decide
example : failures m42_0_1 = [a,b] := by decide
example : correct m42_0_1 = false := by decide
example : closedLedger m42_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_0_1 = [] := by decide
def m42_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","u")],["b"]⟩
example : simulations m42_0_2 a = [] := by decide
example : simulations m42_0_2 b = [] := by decide
example : simulationCovered m42_0_2 = false := by decide
example : failures m42_0_2 = [a,b] := by decide
example : correct m42_0_2 = false := by decide
example : closedLedger m42_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_0_2 = [] := by decide
def m42_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m42_0_3 a = [] := by decide
example : simulations m42_0_3 b = [] := by decide
example : simulationCovered m42_0_3 = false := by decide
example : failures m42_0_3 = [a,b] := by decide
example : correct m42_0_3 = true := by decide
example : closedLedger m42_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_0_3 = [] := by decide
def m42_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","u")],[]⟩
example : simulations m42_1_0 a = [sim] := by decide
example : simulations m42_1_0 b = [sim] := by decide
example : simulationCovered m42_1_0 = true := by decide
example : failures m42_1_0 = [] := by decide
example : correct m42_1_0 = false := by decide
example : closedLedger m42_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_1_0 = [] := by decide
def m42_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","u")],["a"]⟩
example : simulations m42_1_1 a = [sim] := by decide
example : simulations m42_1_1 b = [sim] := by decide
example : simulationCovered m42_1_1 = true := by decide
example : failures m42_1_1 = [] := by decide
example : correct m42_1_1 = false := by decide
example : closedLedger m42_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_1_1 = [] := by decide
def m42_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","u")],["b"]⟩
example : simulations m42_1_2 a = [sim] := by decide
example : simulations m42_1_2 b = [sim] := by decide
example : simulationCovered m42_1_2 = true := by decide
example : failures m42_1_2 = [] := by decide
example : correct m42_1_2 = false := by decide
example : closedLedger m42_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_1_2 = [] := by decide
def m42_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m42_1_3 a = [sim] := by decide
example : simulations m42_1_3 b = [sim] := by decide
example : simulationCovered m42_1_3 = true := by decide
example : failures m42_1_3 = [] := by decide
example : correct m42_1_3 = true := by decide
example : closedLedger m42_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m42_1_3 = [] := by decide
def m43_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","u")],[]⟩
example : simulations m43_0_0 a = [] := by decide
example : simulations m43_0_0 b = [] := by decide
example : simulationCovered m43_0_0 = false := by decide
example : failures m43_0_0 = [a,b] := by decide
example : correct m43_0_0 = false := by decide
example : closedLedger m43_0_0 = [] := by decide
example : retainedLedger m43_0_0 = [(a,b),(b,a)] := by decide
def m43_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","u")],["a"]⟩
example : simulations m43_0_1 a = [] := by decide
example : simulations m43_0_1 b = [] := by decide
example : simulationCovered m43_0_1 = false := by decide
example : failures m43_0_1 = [a,b] := by decide
example : correct m43_0_1 = false := by decide
example : closedLedger m43_0_1 = [] := by decide
example : retainedLedger m43_0_1 = [(a,b),(b,a)] := by decide
def m43_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","u")],["b"]⟩
example : simulations m43_0_2 a = [] := by decide
example : simulations m43_0_2 b = [] := by decide
example : simulationCovered m43_0_2 = false := by decide
example : failures m43_0_2 = [a,b] := by decide
example : correct m43_0_2 = false := by decide
example : closedLedger m43_0_2 = [] := by decide
example : retainedLedger m43_0_2 = [(a,b),(b,a)] := by decide
def m43_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m43_0_3 a = [] := by decide
example : simulations m43_0_3 b = [] := by decide
example : simulationCovered m43_0_3 = false := by decide
example : failures m43_0_3 = [a,b] := by decide
example : correct m43_0_3 = true := by decide
example : closedLedger m43_0_3 = [] := by decide
example : retainedLedger m43_0_3 = [(a,b),(b,a)] := by decide
def m43_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","u")],[]⟩
example : simulations m43_1_0 a = [] := by decide
example : simulations m43_1_0 b = [sim] := by decide
example : simulationCovered m43_1_0 = false := by decide
example : failures m43_1_0 = [a] := by decide
example : correct m43_1_0 = false := by decide
example : closedLedger m43_1_0 = [] := by decide
example : retainedLedger m43_1_0 = [(a,b),(b,a)] := by decide
def m43_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","u")],["a"]⟩
example : simulations m43_1_1 a = [] := by decide
example : simulations m43_1_1 b = [sim] := by decide
example : simulationCovered m43_1_1 = false := by decide
example : failures m43_1_1 = [a] := by decide
example : correct m43_1_1 = false := by decide
example : closedLedger m43_1_1 = [] := by decide
example : retainedLedger m43_1_1 = [(a,b),(b,a)] := by decide
def m43_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","u")],["b"]⟩
example : simulations m43_1_2 a = [] := by decide
example : simulations m43_1_2 b = [sim] := by decide
example : simulationCovered m43_1_2 = false := by decide
example : failures m43_1_2 = [a] := by decide
example : correct m43_1_2 = false := by decide
example : closedLedger m43_1_2 = [] := by decide
example : retainedLedger m43_1_2 = [(a,b),(b,a)] := by decide
def m43_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m43_1_3 a = [] := by decide
example : simulations m43_1_3 b = [sim] := by decide
example : simulationCovered m43_1_3 = false := by decide
example : failures m43_1_3 = [a] := by decide
example : correct m43_1_3 = true := by decide
example : closedLedger m43_1_3 = [] := by decide
example : retainedLedger m43_1_3 = [(a,b),(b,a)] := by decide
def m44_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m44_0_0 a = [] := by decide
example : simulations m44_0_0 b = [] := by decide
example : simulationCovered m44_0_0 = false := by decide
example : failures m44_0_0 = [a,b] := by decide
example : correct m44_0_0 = false := by decide
example : closedLedger m44_0_0 = [] := by decide
example : retainedLedger m44_0_0 = [(a,b),(b,a)] := by decide
def m44_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m44_0_1 a = [] := by decide
example : simulations m44_0_1 b = [] := by decide
example : simulationCovered m44_0_1 = false := by decide
example : failures m44_0_1 = [a,b] := by decide
example : correct m44_0_1 = false := by decide
example : closedLedger m44_0_1 = [] := by decide
example : retainedLedger m44_0_1 = [(a,b),(b,a)] := by decide
def m44_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m44_0_2 a = [] := by decide
example : simulations m44_0_2 b = [] := by decide
example : simulationCovered m44_0_2 = false := by decide
example : failures m44_0_2 = [a,b] := by decide
example : correct m44_0_2 = false := by decide
example : closedLedger m44_0_2 = [] := by decide
example : retainedLedger m44_0_2 = [(a,b),(b,a)] := by decide
def m44_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m44_0_3 a = [] := by decide
example : simulations m44_0_3 b = [] := by decide
example : simulationCovered m44_0_3 = false := by decide
example : failures m44_0_3 = [a,b] := by decide
example : correct m44_0_3 = true := by decide
example : closedLedger m44_0_3 = [] := by decide
example : retainedLedger m44_0_3 = [(a,b),(b,a)] := by decide
def m44_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m44_1_0 a = [] := by decide
example : simulations m44_1_0 b = [] := by decide
example : simulationCovered m44_1_0 = false := by decide
example : failures m44_1_0 = [a,b] := by decide
example : correct m44_1_0 = false := by decide
example : closedLedger m44_1_0 = [] := by decide
example : retainedLedger m44_1_0 = [(a,b),(b,a)] := by decide
def m44_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m44_1_1 a = [] := by decide
example : simulations m44_1_1 b = [] := by decide
example : simulationCovered m44_1_1 = false := by decide
example : failures m44_1_1 = [a,b] := by decide
example : correct m44_1_1 = false := by decide
example : closedLedger m44_1_1 = [] := by decide
example : retainedLedger m44_1_1 = [(a,b),(b,a)] := by decide
def m44_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m44_1_2 a = [] := by decide
example : simulations m44_1_2 b = [] := by decide
example : simulationCovered m44_1_2 = false := by decide
example : failures m44_1_2 = [a,b] := by decide
example : correct m44_1_2 = false := by decide
example : closedLedger m44_1_2 = [] := by decide
example : retainedLedger m44_1_2 = [(a,b),(b,a)] := by decide
def m44_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m44_1_3 a = [] := by decide
example : simulations m44_1_3 b = [] := by decide
example : simulationCovered m44_1_3 = false := by decide
example : failures m44_1_3 = [a,b] := by decide
example : correct m44_1_3 = true := by decide
example : closedLedger m44_1_3 = [] := by decide
example : retainedLedger m44_1_3 = [(a,b),(b,a)] := by decide
def m45_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m45_0_0 a = [] := by decide
example : simulations m45_0_0 b = [] := by decide
example : simulationCovered m45_0_0 = false := by decide
example : failures m45_0_0 = [a,b] := by decide
example : correct m45_0_0 = false := by decide
example : closedLedger m45_0_0 = [] := by decide
example : retainedLedger m45_0_0 = [(a,b),(b,a)] := by decide
def m45_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m45_0_1 a = [] := by decide
example : simulations m45_0_1 b = [] := by decide
example : simulationCovered m45_0_1 = false := by decide
example : failures m45_0_1 = [a,b] := by decide
example : correct m45_0_1 = false := by decide
example : closedLedger m45_0_1 = [] := by decide
example : retainedLedger m45_0_1 = [(a,b),(b,a)] := by decide
def m45_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m45_0_2 a = [] := by decide
example : simulations m45_0_2 b = [] := by decide
example : simulationCovered m45_0_2 = false := by decide
example : failures m45_0_2 = [a,b] := by decide
example : correct m45_0_2 = false := by decide
example : closedLedger m45_0_2 = [] := by decide
example : retainedLedger m45_0_2 = [(a,b),(b,a)] := by decide
def m45_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m45_0_3 a = [] := by decide
example : simulations m45_0_3 b = [] := by decide
example : simulationCovered m45_0_3 = false := by decide
example : failures m45_0_3 = [a,b] := by decide
example : correct m45_0_3 = true := by decide
example : closedLedger m45_0_3 = [] := by decide
example : retainedLedger m45_0_3 = [(a,b),(b,a)] := by decide
def m45_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m45_1_0 a = [] := by decide
example : simulations m45_1_0 b = [] := by decide
example : simulationCovered m45_1_0 = false := by decide
example : failures m45_1_0 = [a,b] := by decide
example : correct m45_1_0 = false := by decide
example : closedLedger m45_1_0 = [] := by decide
example : retainedLedger m45_1_0 = [(a,b),(b,a)] := by decide
def m45_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m45_1_1 a = [] := by decide
example : simulations m45_1_1 b = [] := by decide
example : simulationCovered m45_1_1 = false := by decide
example : failures m45_1_1 = [a,b] := by decide
example : correct m45_1_1 = false := by decide
example : closedLedger m45_1_1 = [] := by decide
example : retainedLedger m45_1_1 = [(a,b),(b,a)] := by decide
def m45_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m45_1_2 a = [] := by decide
example : simulations m45_1_2 b = [] := by decide
example : simulationCovered m45_1_2 = false := by decide
example : failures m45_1_2 = [a,b] := by decide
example : correct m45_1_2 = false := by decide
example : closedLedger m45_1_2 = [] := by decide
example : retainedLedger m45_1_2 = [(a,b),(b,a)] := by decide
def m45_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m45_1_3 a = [] := by decide
example : simulations m45_1_3 b = [] := by decide
example : simulationCovered m45_1_3 = false := by decide
example : failures m45_1_3 = [a,b] := by decide
example : correct m45_1_3 = true := by decide
example : closedLedger m45_1_3 = [] := by decide
example : retainedLedger m45_1_3 = [(a,b),(b,a)] := by decide
def m46_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m46_0_0 a = [] := by decide
example : simulations m46_0_0 b = [] := by decide
example : simulationCovered m46_0_0 = false := by decide
example : failures m46_0_0 = [a,b] := by decide
example : correct m46_0_0 = false := by decide
example : closedLedger m46_0_0 = [] := by decide
example : retainedLedger m46_0_0 = [(a,b),(b,a)] := by decide
def m46_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m46_0_1 a = [] := by decide
example : simulations m46_0_1 b = [] := by decide
example : simulationCovered m46_0_1 = false := by decide
example : failures m46_0_1 = [a,b] := by decide
example : correct m46_0_1 = false := by decide
example : closedLedger m46_0_1 = [] := by decide
example : retainedLedger m46_0_1 = [(a,b),(b,a)] := by decide
def m46_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m46_0_2 a = [] := by decide
example : simulations m46_0_2 b = [] := by decide
example : simulationCovered m46_0_2 = false := by decide
example : failures m46_0_2 = [a,b] := by decide
example : correct m46_0_2 = false := by decide
example : closedLedger m46_0_2 = [] := by decide
example : retainedLedger m46_0_2 = [(a,b),(b,a)] := by decide
def m46_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m46_0_3 a = [] := by decide
example : simulations m46_0_3 b = [] := by decide
example : simulationCovered m46_0_3 = false := by decide
example : failures m46_0_3 = [a,b] := by decide
example : correct m46_0_3 = true := by decide
example : closedLedger m46_0_3 = [] := by decide
example : retainedLedger m46_0_3 = [(a,b),(b,a)] := by decide
def m46_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m46_1_0 a = [sim] := by decide
example : simulations m46_1_0 b = [] := by decide
example : simulationCovered m46_1_0 = false := by decide
example : failures m46_1_0 = [b] := by decide
example : correct m46_1_0 = false := by decide
example : closedLedger m46_1_0 = [] := by decide
example : retainedLedger m46_1_0 = [(a,b),(b,a)] := by decide
def m46_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m46_1_1 a = [sim] := by decide
example : simulations m46_1_1 b = [] := by decide
example : simulationCovered m46_1_1 = false := by decide
example : failures m46_1_1 = [b] := by decide
example : correct m46_1_1 = false := by decide
example : closedLedger m46_1_1 = [] := by decide
example : retainedLedger m46_1_1 = [(a,b),(b,a)] := by decide
def m46_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m46_1_2 a = [sim] := by decide
example : simulations m46_1_2 b = [] := by decide
example : simulationCovered m46_1_2 = false := by decide
example : failures m46_1_2 = [b] := by decide
example : correct m46_1_2 = false := by decide
example : closedLedger m46_1_2 = [] := by decide
example : retainedLedger m46_1_2 = [(a,b),(b,a)] := by decide
def m46_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m46_1_3 a = [sim] := by decide
example : simulations m46_1_3 b = [] := by decide
example : simulationCovered m46_1_3 = false := by decide
example : failures m46_1_3 = [b] := by decide
example : correct m46_1_3 = true := by decide
example : closedLedger m46_1_3 = [] := by decide
example : retainedLedger m46_1_3 = [(a,b),(b,a)] := by decide
def m47_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m47_0_0 a = [] := by decide
example : simulations m47_0_0 b = [] := by decide
example : simulationCovered m47_0_0 = false := by decide
example : failures m47_0_0 = [a,b] := by decide
example : correct m47_0_0 = false := by decide
example : closedLedger m47_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_0_0 = [] := by decide
def m47_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m47_0_1 a = [] := by decide
example : simulations m47_0_1 b = [] := by decide
example : simulationCovered m47_0_1 = false := by decide
example : failures m47_0_1 = [a,b] := by decide
example : correct m47_0_1 = false := by decide
example : closedLedger m47_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_0_1 = [] := by decide
def m47_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m47_0_2 a = [] := by decide
example : simulations m47_0_2 b = [] := by decide
example : simulationCovered m47_0_2 = false := by decide
example : failures m47_0_2 = [a,b] := by decide
example : correct m47_0_2 = false := by decide
example : closedLedger m47_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_0_2 = [] := by decide
def m47_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m47_0_3 a = [] := by decide
example : simulations m47_0_3 b = [] := by decide
example : simulationCovered m47_0_3 = false := by decide
example : failures m47_0_3 = [a,b] := by decide
example : correct m47_0_3 = true := by decide
example : closedLedger m47_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_0_3 = [] := by decide
def m47_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],[]⟩
example : simulations m47_1_0 a = [] := by decide
example : simulations m47_1_0 b = [] := by decide
example : simulationCovered m47_1_0 = false := by decide
example : failures m47_1_0 = [a,b] := by decide
example : correct m47_1_0 = false := by decide
example : closedLedger m47_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_1_0 = [] := by decide
def m47_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],["a"]⟩
example : simulations m47_1_1 a = [] := by decide
example : simulations m47_1_1 b = [] := by decide
example : simulationCovered m47_1_1 = false := by decide
example : failures m47_1_1 = [a,b] := by decide
example : correct m47_1_1 = false := by decide
example : closedLedger m47_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_1_1 = [] := by decide
def m47_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],["b"]⟩
example : simulations m47_1_2 a = [] := by decide
example : simulations m47_1_2 b = [] := by decide
example : simulationCovered m47_1_2 = false := by decide
example : failures m47_1_2 = [a,b] := by decide
example : correct m47_1_2 = false := by decide
example : closedLedger m47_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_1_2 = [] := by decide
def m47_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","u")],["a","b"]⟩
example : simulations m47_1_3 a = [] := by decide
example : simulations m47_1_3 b = [] := by decide
example : simulationCovered m47_1_3 = false := by decide
example : failures m47_1_3 = [a,b] := by decide
example : correct m47_1_3 = true := by decide
example : closedLedger m47_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m47_1_3 = [] := by decide
def m48_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v"),("sim","u")],[]⟩
example : simulations m48_0_0 a = [] := by decide
example : simulations m48_0_0 b = [] := by decide
example : simulationCovered m48_0_0 = false := by decide
example : failures m48_0_0 = [a,b] := by decide
example : correct m48_0_0 = false := by decide
example : closedLedger m48_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_0_0 = [] := by decide
def m48_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v"),("sim","u")],["a"]⟩
example : simulations m48_0_1 a = [] := by decide
example : simulations m48_0_1 b = [] := by decide
example : simulationCovered m48_0_1 = false := by decide
example : failures m48_0_1 = [a,b] := by decide
example : correct m48_0_1 = false := by decide
example : closedLedger m48_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_0_1 = [] := by decide
def m48_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v"),("sim","u")],["b"]⟩
example : simulations m48_0_2 a = [] := by decide
example : simulations m48_0_2 b = [] := by decide
example : simulationCovered m48_0_2 = false := by decide
example : failures m48_0_2 = [a,b] := by decide
example : correct m48_0_2 = false := by decide
example : closedLedger m48_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_0_2 = [] := by decide
def m48_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m48_0_3 a = [] := by decide
example : simulations m48_0_3 b = [] := by decide
example : simulationCovered m48_0_3 = false := by decide
example : failures m48_0_3 = [a,b] := by decide
example : correct m48_0_3 = true := by decide
example : closedLedger m48_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_0_3 = [] := by decide
def m48_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v"),("sim","u")],[]⟩
example : simulations m48_1_0 a = [] := by decide
example : simulations m48_1_0 b = [] := by decide
example : simulationCovered m48_1_0 = false := by decide
example : failures m48_1_0 = [a,b] := by decide
example : correct m48_1_0 = false := by decide
example : closedLedger m48_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_1_0 = [] := by decide
def m48_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v"),("sim","u")],["a"]⟩
example : simulations m48_1_1 a = [] := by decide
example : simulations m48_1_1 b = [] := by decide
example : simulationCovered m48_1_1 = false := by decide
example : failures m48_1_1 = [a,b] := by decide
example : correct m48_1_1 = false := by decide
example : closedLedger m48_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_1_1 = [] := by decide
def m48_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v"),("sim","u")],["b"]⟩
example : simulations m48_1_2 a = [] := by decide
example : simulations m48_1_2 b = [] := by decide
example : simulationCovered m48_1_2 = false := by decide
example : failures m48_1_2 = [a,b] := by decide
example : correct m48_1_2 = false := by decide
example : closedLedger m48_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_1_2 = [] := by decide
def m48_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m48_1_3 a = [] := by decide
example : simulations m48_1_3 b = [] := by decide
example : simulationCovered m48_1_3 = false := by decide
example : failures m48_1_3 = [a,b] := by decide
example : correct m48_1_3 = true := by decide
example : closedLedger m48_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m48_1_3 = [] := by decide
def m49_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m49_0_0 a = [] := by decide
example : simulations m49_0_0 b = [] := by decide
example : simulationCovered m49_0_0 = false := by decide
example : failures m49_0_0 = [a,b] := by decide
example : correct m49_0_0 = false := by decide
example : closedLedger m49_0_0 = [] := by decide
example : retainedLedger m49_0_0 = [(a,b),(b,a)] := by decide
def m49_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m49_0_1 a = [] := by decide
example : simulations m49_0_1 b = [] := by decide
example : simulationCovered m49_0_1 = false := by decide
example : failures m49_0_1 = [a,b] := by decide
example : correct m49_0_1 = false := by decide
example : closedLedger m49_0_1 = [] := by decide
example : retainedLedger m49_0_1 = [(a,b),(b,a)] := by decide
def m49_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m49_0_2 a = [] := by decide
example : simulations m49_0_2 b = [] := by decide
example : simulationCovered m49_0_2 = false := by decide
example : failures m49_0_2 = [a,b] := by decide
example : correct m49_0_2 = false := by decide
example : closedLedger m49_0_2 = [] := by decide
example : retainedLedger m49_0_2 = [(a,b),(b,a)] := by decide
def m49_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m49_0_3 a = [] := by decide
example : simulations m49_0_3 b = [] := by decide
example : simulationCovered m49_0_3 = false := by decide
example : failures m49_0_3 = [a,b] := by decide
example : correct m49_0_3 = true := by decide
example : closedLedger m49_0_3 = [] := by decide
example : retainedLedger m49_0_3 = [(a,b),(b,a)] := by decide
def m49_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m49_1_0 a = [] := by decide
example : simulations m49_1_0 b = [] := by decide
example : simulationCovered m49_1_0 = false := by decide
example : failures m49_1_0 = [a,b] := by decide
example : correct m49_1_0 = false := by decide
example : closedLedger m49_1_0 = [] := by decide
example : retainedLedger m49_1_0 = [(a,b),(b,a)] := by decide
def m49_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m49_1_1 a = [] := by decide
example : simulations m49_1_1 b = [] := by decide
example : simulationCovered m49_1_1 = false := by decide
example : failures m49_1_1 = [a,b] := by decide
example : correct m49_1_1 = false := by decide
example : closedLedger m49_1_1 = [] := by decide
example : retainedLedger m49_1_1 = [(a,b),(b,a)] := by decide
def m49_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m49_1_2 a = [] := by decide
example : simulations m49_1_2 b = [] := by decide
example : simulationCovered m49_1_2 = false := by decide
example : failures m49_1_2 = [a,b] := by decide
example : correct m49_1_2 = false := by decide
example : closedLedger m49_1_2 = [] := by decide
example : retainedLedger m49_1_2 = [(a,b),(b,a)] := by decide
def m49_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m49_1_3 a = [] := by decide
example : simulations m49_1_3 b = [] := by decide
example : simulationCovered m49_1_3 = false := by decide
example : failures m49_1_3 = [a,b] := by decide
example : correct m49_1_3 = true := by decide
example : closedLedger m49_1_3 = [] := by decide
example : retainedLedger m49_1_3 = [(a,b),(b,a)] := by decide
def m50_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m50_0_0 a = [] := by decide
example : simulations m50_0_0 b = [] := by decide
example : simulationCovered m50_0_0 = false := by decide
example : failures m50_0_0 = [a,b] := by decide
example : correct m50_0_0 = false := by decide
example : closedLedger m50_0_0 = [] := by decide
example : retainedLedger m50_0_0 = [(a,b),(b,a)] := by decide
def m50_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m50_0_1 a = [] := by decide
example : simulations m50_0_1 b = [] := by decide
example : simulationCovered m50_0_1 = false := by decide
example : failures m50_0_1 = [a,b] := by decide
example : correct m50_0_1 = false := by decide
example : closedLedger m50_0_1 = [] := by decide
example : retainedLedger m50_0_1 = [(a,b),(b,a)] := by decide
def m50_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m50_0_2 a = [] := by decide
example : simulations m50_0_2 b = [] := by decide
example : simulationCovered m50_0_2 = false := by decide
example : failures m50_0_2 = [a,b] := by decide
example : correct m50_0_2 = false := by decide
example : closedLedger m50_0_2 = [] := by decide
example : retainedLedger m50_0_2 = [(a,b),(b,a)] := by decide
def m50_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m50_0_3 a = [] := by decide
example : simulations m50_0_3 b = [] := by decide
example : simulationCovered m50_0_3 = false := by decide
example : failures m50_0_3 = [a,b] := by decide
example : correct m50_0_3 = true := by decide
example : closedLedger m50_0_3 = [] := by decide
example : retainedLedger m50_0_3 = [(a,b),(b,a)] := by decide
def m50_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m50_1_0 a = [] := by decide
example : simulations m50_1_0 b = [] := by decide
example : simulationCovered m50_1_0 = false := by decide
example : failures m50_1_0 = [a,b] := by decide
example : correct m50_1_0 = false := by decide
example : closedLedger m50_1_0 = [] := by decide
example : retainedLedger m50_1_0 = [(a,b),(b,a)] := by decide
def m50_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m50_1_1 a = [] := by decide
example : simulations m50_1_1 b = [] := by decide
example : simulationCovered m50_1_1 = false := by decide
example : failures m50_1_1 = [a,b] := by decide
example : correct m50_1_1 = false := by decide
example : closedLedger m50_1_1 = [] := by decide
example : retainedLedger m50_1_1 = [(a,b),(b,a)] := by decide
def m50_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m50_1_2 a = [] := by decide
example : simulations m50_1_2 b = [] := by decide
example : simulationCovered m50_1_2 = false := by decide
example : failures m50_1_2 = [a,b] := by decide
example : correct m50_1_2 = false := by decide
example : closedLedger m50_1_2 = [] := by decide
example : retainedLedger m50_1_2 = [(a,b),(b,a)] := by decide
def m50_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m50_1_3 a = [] := by decide
example : simulations m50_1_3 b = [] := by decide
example : simulationCovered m50_1_3 = false := by decide
example : failures m50_1_3 = [a,b] := by decide
example : correct m50_1_3 = true := by decide
example : closedLedger m50_1_3 = [] := by decide
example : retainedLedger m50_1_3 = [(a,b),(b,a)] := by decide
def m51_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m51_0_0 a = [] := by decide
example : simulations m51_0_0 b = [] := by decide
example : simulationCovered m51_0_0 = false := by decide
example : failures m51_0_0 = [a,b] := by decide
example : correct m51_0_0 = false := by decide
example : closedLedger m51_0_0 = [] := by decide
example : retainedLedger m51_0_0 = [(a,b),(b,a)] := by decide
def m51_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m51_0_1 a = [] := by decide
example : simulations m51_0_1 b = [] := by decide
example : simulationCovered m51_0_1 = false := by decide
example : failures m51_0_1 = [a,b] := by decide
example : correct m51_0_1 = false := by decide
example : closedLedger m51_0_1 = [] := by decide
example : retainedLedger m51_0_1 = [(a,b),(b,a)] := by decide
def m51_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m51_0_2 a = [] := by decide
example : simulations m51_0_2 b = [] := by decide
example : simulationCovered m51_0_2 = false := by decide
example : failures m51_0_2 = [a,b] := by decide
example : correct m51_0_2 = false := by decide
example : closedLedger m51_0_2 = [] := by decide
example : retainedLedger m51_0_2 = [(a,b),(b,a)] := by decide
def m51_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m51_0_3 a = [] := by decide
example : simulations m51_0_3 b = [] := by decide
example : simulationCovered m51_0_3 = false := by decide
example : failures m51_0_3 = [a,b] := by decide
example : correct m51_0_3 = true := by decide
example : closedLedger m51_0_3 = [] := by decide
example : retainedLedger m51_0_3 = [(a,b),(b,a)] := by decide
def m51_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m51_1_0 a = [sim] := by decide
example : simulations m51_1_0 b = [] := by decide
example : simulationCovered m51_1_0 = false := by decide
example : failures m51_1_0 = [b] := by decide
example : correct m51_1_0 = false := by decide
example : closedLedger m51_1_0 = [] := by decide
example : retainedLedger m51_1_0 = [(a,b),(b,a)] := by decide
def m51_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m51_1_1 a = [sim] := by decide
example : simulations m51_1_1 b = [] := by decide
example : simulationCovered m51_1_1 = false := by decide
example : failures m51_1_1 = [b] := by decide
example : correct m51_1_1 = false := by decide
example : closedLedger m51_1_1 = [] := by decide
example : retainedLedger m51_1_1 = [(a,b),(b,a)] := by decide
def m51_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m51_1_2 a = [sim] := by decide
example : simulations m51_1_2 b = [] := by decide
example : simulationCovered m51_1_2 = false := by decide
example : failures m51_1_2 = [b] := by decide
example : correct m51_1_2 = false := by decide
example : closedLedger m51_1_2 = [] := by decide
example : retainedLedger m51_1_2 = [(a,b),(b,a)] := by decide
def m51_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m51_1_3 a = [sim] := by decide
example : simulations m51_1_3 b = [] := by decide
example : simulationCovered m51_1_3 = false := by decide
example : failures m51_1_3 = [b] := by decide
example : correct m51_1_3 = true := by decide
example : closedLedger m51_1_3 = [] := by decide
example : retainedLedger m51_1_3 = [(a,b),(b,a)] := by decide
def m52_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m52_0_0 a = [] := by decide
example : simulations m52_0_0 b = [] := by decide
example : simulationCovered m52_0_0 = false := by decide
example : failures m52_0_0 = [a,b] := by decide
example : correct m52_0_0 = false := by decide
example : closedLedger m52_0_0 = [] := by decide
example : retainedLedger m52_0_0 = [(a,b),(b,a)] := by decide
def m52_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m52_0_1 a = [] := by decide
example : simulations m52_0_1 b = [] := by decide
example : simulationCovered m52_0_1 = false := by decide
example : failures m52_0_1 = [a,b] := by decide
example : correct m52_0_1 = false := by decide
example : closedLedger m52_0_1 = [] := by decide
example : retainedLedger m52_0_1 = [(a,b),(b,a)] := by decide
def m52_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m52_0_2 a = [] := by decide
example : simulations m52_0_2 b = [] := by decide
example : simulationCovered m52_0_2 = false := by decide
example : failures m52_0_2 = [a,b] := by decide
example : correct m52_0_2 = false := by decide
example : closedLedger m52_0_2 = [] := by decide
example : retainedLedger m52_0_2 = [(a,b),(b,a)] := by decide
def m52_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m52_0_3 a = [] := by decide
example : simulations m52_0_3 b = [] := by decide
example : simulationCovered m52_0_3 = false := by decide
example : failures m52_0_3 = [a,b] := by decide
example : correct m52_0_3 = true := by decide
example : closedLedger m52_0_3 = [] := by decide
example : retainedLedger m52_0_3 = [(a,b),(b,a)] := by decide
def m52_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m52_1_0 a = [] := by decide
example : simulations m52_1_0 b = [] := by decide
example : simulationCovered m52_1_0 = false := by decide
example : failures m52_1_0 = [a,b] := by decide
example : correct m52_1_0 = false := by decide
example : closedLedger m52_1_0 = [] := by decide
example : retainedLedger m52_1_0 = [(a,b),(b,a)] := by decide
def m52_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m52_1_1 a = [] := by decide
example : simulations m52_1_1 b = [] := by decide
example : simulationCovered m52_1_1 = false := by decide
example : failures m52_1_1 = [a,b] := by decide
example : correct m52_1_1 = false := by decide
example : closedLedger m52_1_1 = [] := by decide
example : retainedLedger m52_1_1 = [(a,b),(b,a)] := by decide
def m52_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m52_1_2 a = [] := by decide
example : simulations m52_1_2 b = [] := by decide
example : simulationCovered m52_1_2 = false := by decide
example : failures m52_1_2 = [a,b] := by decide
example : correct m52_1_2 = false := by decide
example : closedLedger m52_1_2 = [] := by decide
example : retainedLedger m52_1_2 = [(a,b),(b,a)] := by decide
def m52_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m52_1_3 a = [] := by decide
example : simulations m52_1_3 b = [] := by decide
example : simulationCovered m52_1_3 = false := by decide
example : failures m52_1_3 = [a,b] := by decide
example : correct m52_1_3 = true := by decide
example : closedLedger m52_1_3 = [] := by decide
example : retainedLedger m52_1_3 = [(a,b),(b,a)] := by decide
def m53_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m53_0_0 a = [] := by decide
example : simulations m53_0_0 b = [] := by decide
example : simulationCovered m53_0_0 = false := by decide
example : failures m53_0_0 = [a,b] := by decide
example : correct m53_0_0 = false := by decide
example : closedLedger m53_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_0_0 = [] := by decide
def m53_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m53_0_1 a = [] := by decide
example : simulations m53_0_1 b = [] := by decide
example : simulationCovered m53_0_1 = false := by decide
example : failures m53_0_1 = [a,b] := by decide
example : correct m53_0_1 = false := by decide
example : closedLedger m53_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_0_1 = [] := by decide
def m53_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m53_0_2 a = [] := by decide
example : simulations m53_0_2 b = [] := by decide
example : simulationCovered m53_0_2 = false := by decide
example : failures m53_0_2 = [a,b] := by decide
example : correct m53_0_2 = false := by decide
example : closedLedger m53_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_0_2 = [] := by decide
def m53_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m53_0_3 a = [] := by decide
example : simulations m53_0_3 b = [] := by decide
example : simulationCovered m53_0_3 = false := by decide
example : failures m53_0_3 = [a,b] := by decide
example : correct m53_0_3 = true := by decide
example : closedLedger m53_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_0_3 = [] := by decide
def m53_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m53_1_0 a = [] := by decide
example : simulations m53_1_0 b = [] := by decide
example : simulationCovered m53_1_0 = false := by decide
example : failures m53_1_0 = [a,b] := by decide
example : correct m53_1_0 = false := by decide
example : closedLedger m53_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_1_0 = [] := by decide
def m53_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m53_1_1 a = [] := by decide
example : simulations m53_1_1 b = [] := by decide
example : simulationCovered m53_1_1 = false := by decide
example : failures m53_1_1 = [a,b] := by decide
example : correct m53_1_1 = false := by decide
example : closedLedger m53_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_1_1 = [] := by decide
def m53_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m53_1_2 a = [] := by decide
example : simulations m53_1_2 b = [] := by decide
example : simulationCovered m53_1_2 = false := by decide
example : failures m53_1_2 = [a,b] := by decide
example : correct m53_1_2 = false := by decide
example : closedLedger m53_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_1_2 = [] := by decide
def m53_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m53_1_3 a = [] := by decide
example : simulations m53_1_3 b = [] := by decide
example : simulationCovered m53_1_3 = false := by decide
example : failures m53_1_3 = [a,b] := by decide
example : correct m53_1_3 = true := by decide
example : closedLedger m53_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m53_1_3 = [] := by decide
def m54_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m54_0_0 a = [] := by decide
example : simulations m54_0_0 b = [] := by decide
example : simulationCovered m54_0_0 = false := by decide
example : failures m54_0_0 = [a,b] := by decide
example : correct m54_0_0 = false := by decide
example : closedLedger m54_0_0 = [] := by decide
example : retainedLedger m54_0_0 = [(a,b),(b,a)] := by decide
def m54_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m54_0_1 a = [] := by decide
example : simulations m54_0_1 b = [] := by decide
example : simulationCovered m54_0_1 = false := by decide
example : failures m54_0_1 = [a,b] := by decide
example : correct m54_0_1 = false := by decide
example : closedLedger m54_0_1 = [] := by decide
example : retainedLedger m54_0_1 = [(a,b),(b,a)] := by decide
def m54_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m54_0_2 a = [] := by decide
example : simulations m54_0_2 b = [] := by decide
example : simulationCovered m54_0_2 = false := by decide
example : failures m54_0_2 = [a,b] := by decide
example : correct m54_0_2 = false := by decide
example : closedLedger m54_0_2 = [] := by decide
example : retainedLedger m54_0_2 = [(a,b),(b,a)] := by decide
def m54_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m54_0_3 a = [] := by decide
example : simulations m54_0_3 b = [] := by decide
example : simulationCovered m54_0_3 = false := by decide
example : failures m54_0_3 = [a,b] := by decide
example : correct m54_0_3 = true := by decide
example : closedLedger m54_0_3 = [] := by decide
example : retainedLedger m54_0_3 = [(a,b),(b,a)] := by decide
def m54_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m54_1_0 a = [] := by decide
example : simulations m54_1_0 b = [] := by decide
example : simulationCovered m54_1_0 = false := by decide
example : failures m54_1_0 = [a,b] := by decide
example : correct m54_1_0 = false := by decide
example : closedLedger m54_1_0 = [] := by decide
example : retainedLedger m54_1_0 = [(a,b),(b,a)] := by decide
def m54_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m54_1_1 a = [] := by decide
example : simulations m54_1_1 b = [] := by decide
example : simulationCovered m54_1_1 = false := by decide
example : failures m54_1_1 = [a,b] := by decide
example : correct m54_1_1 = false := by decide
example : closedLedger m54_1_1 = [] := by decide
example : retainedLedger m54_1_1 = [(a,b),(b,a)] := by decide
def m54_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m54_1_2 a = [] := by decide
example : simulations m54_1_2 b = [] := by decide
example : simulationCovered m54_1_2 = false := by decide
example : failures m54_1_2 = [a,b] := by decide
example : correct m54_1_2 = false := by decide
example : closedLedger m54_1_2 = [] := by decide
example : retainedLedger m54_1_2 = [(a,b),(b,a)] := by decide
def m54_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m54_1_3 a = [] := by decide
example : simulations m54_1_3 b = [] := by decide
example : simulationCovered m54_1_3 = false := by decide
example : failures m54_1_3 = [a,b] := by decide
example : correct m54_1_3 = true := by decide
example : closedLedger m54_1_3 = [] := by decide
example : retainedLedger m54_1_3 = [(a,b),(b,a)] := by decide
def m55_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m55_0_0 a = [] := by decide
example : simulations m55_0_0 b = [] := by decide
example : simulationCovered m55_0_0 = false := by decide
example : failures m55_0_0 = [a,b] := by decide
example : correct m55_0_0 = false := by decide
example : closedLedger m55_0_0 = [] := by decide
example : retainedLedger m55_0_0 = [(a,b),(b,a)] := by decide
def m55_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m55_0_1 a = [] := by decide
example : simulations m55_0_1 b = [] := by decide
example : simulationCovered m55_0_1 = false := by decide
example : failures m55_0_1 = [a,b] := by decide
example : correct m55_0_1 = false := by decide
example : closedLedger m55_0_1 = [] := by decide
example : retainedLedger m55_0_1 = [(a,b),(b,a)] := by decide
def m55_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m55_0_2 a = [] := by decide
example : simulations m55_0_2 b = [] := by decide
example : simulationCovered m55_0_2 = false := by decide
example : failures m55_0_2 = [a,b] := by decide
example : correct m55_0_2 = false := by decide
example : closedLedger m55_0_2 = [] := by decide
example : retainedLedger m55_0_2 = [(a,b),(b,a)] := by decide
def m55_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m55_0_3 a = [] := by decide
example : simulations m55_0_3 b = [] := by decide
example : simulationCovered m55_0_3 = false := by decide
example : failures m55_0_3 = [a,b] := by decide
example : correct m55_0_3 = true := by decide
example : closedLedger m55_0_3 = [] := by decide
example : retainedLedger m55_0_3 = [(a,b),(b,a)] := by decide
def m55_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],[]⟩
example : simulations m55_1_0 a = [sim] := by decide
example : simulations m55_1_0 b = [] := by decide
example : simulationCovered m55_1_0 = false := by decide
example : failures m55_1_0 = [b] := by decide
example : correct m55_1_0 = false := by decide
example : closedLedger m55_1_0 = [] := by decide
example : retainedLedger m55_1_0 = [(a,b),(b,a)] := by decide
def m55_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m55_1_1 a = [sim] := by decide
example : simulations m55_1_1 b = [] := by decide
example : simulationCovered m55_1_1 = false := by decide
example : failures m55_1_1 = [b] := by decide
example : correct m55_1_1 = false := by decide
example : closedLedger m55_1_1 = [] := by decide
example : retainedLedger m55_1_1 = [(a,b),(b,a)] := by decide
def m55_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m55_1_2 a = [sim] := by decide
example : simulations m55_1_2 b = [] := by decide
example : simulationCovered m55_1_2 = false := by decide
example : failures m55_1_2 = [b] := by decide
example : correct m55_1_2 = false := by decide
example : closedLedger m55_1_2 = [] := by decide
example : retainedLedger m55_1_2 = [(a,b),(b,a)] := by decide
def m55_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m55_1_3 a = [sim] := by decide
example : simulations m55_1_3 b = [] := by decide
example : simulationCovered m55_1_3 = false := by decide
example : failures m55_1_3 = [b] := by decide
example : correct m55_1_3 = true := by decide
example : closedLedger m55_1_3 = [] := by decide
example : retainedLedger m55_1_3 = [(a,b),(b,a)] := by decide
def m56_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m56_0_0 a = [] := by decide
example : simulations m56_0_0 b = [] := by decide
example : simulationCovered m56_0_0 = false := by decide
example : failures m56_0_0 = [a,b] := by decide
example : correct m56_0_0 = false := by decide
example : closedLedger m56_0_0 = [] := by decide
example : retainedLedger m56_0_0 = [(a,b),(b,a)] := by decide
def m56_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m56_0_1 a = [] := by decide
example : simulations m56_0_1 b = [] := by decide
example : simulationCovered m56_0_1 = false := by decide
example : failures m56_0_1 = [a,b] := by decide
example : correct m56_0_1 = false := by decide
example : closedLedger m56_0_1 = [] := by decide
example : retainedLedger m56_0_1 = [(a,b),(b,a)] := by decide
def m56_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m56_0_2 a = [] := by decide
example : simulations m56_0_2 b = [] := by decide
example : simulationCovered m56_0_2 = false := by decide
example : failures m56_0_2 = [a,b] := by decide
example : correct m56_0_2 = false := by decide
example : closedLedger m56_0_2 = [] := by decide
example : retainedLedger m56_0_2 = [(a,b),(b,a)] := by decide
def m56_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m56_0_3 a = [] := by decide
example : simulations m56_0_3 b = [] := by decide
example : simulationCovered m56_0_3 = false := by decide
example : failures m56_0_3 = [a,b] := by decide
example : correct m56_0_3 = true := by decide
example : closedLedger m56_0_3 = [] := by decide
example : retainedLedger m56_0_3 = [(a,b),(b,a)] := by decide
def m56_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m56_1_0 a = [] := by decide
example : simulations m56_1_0 b = [] := by decide
example : simulationCovered m56_1_0 = false := by decide
example : failures m56_1_0 = [a,b] := by decide
example : correct m56_1_0 = false := by decide
example : closedLedger m56_1_0 = [] := by decide
example : retainedLedger m56_1_0 = [(a,b),(b,a)] := by decide
def m56_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m56_1_1 a = [] := by decide
example : simulations m56_1_1 b = [] := by decide
example : simulationCovered m56_1_1 = false := by decide
example : failures m56_1_1 = [a,b] := by decide
example : correct m56_1_1 = false := by decide
example : closedLedger m56_1_1 = [] := by decide
example : retainedLedger m56_1_1 = [(a,b),(b,a)] := by decide
def m56_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m56_1_2 a = [] := by decide
example : simulations m56_1_2 b = [] := by decide
example : simulationCovered m56_1_2 = false := by decide
example : failures m56_1_2 = [a,b] := by decide
example : correct m56_1_2 = false := by decide
example : closedLedger m56_1_2 = [] := by decide
example : retainedLedger m56_1_2 = [(a,b),(b,a)] := by decide
def m56_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m56_1_3 a = [] := by decide
example : simulations m56_1_3 b = [] := by decide
example : simulationCovered m56_1_3 = false := by decide
example : failures m56_1_3 = [a,b] := by decide
example : correct m56_1_3 = true := by decide
example : closedLedger m56_1_3 = [] := by decide
example : retainedLedger m56_1_3 = [(a,b),(b,a)] := by decide
def m57_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m57_0_0 a = [] := by decide
example : simulations m57_0_0 b = [] := by decide
example : simulationCovered m57_0_0 = false := by decide
example : failures m57_0_0 = [a,b] := by decide
example : correct m57_0_0 = false := by decide
example : closedLedger m57_0_0 = [] := by decide
example : retainedLedger m57_0_0 = [(a,b),(b,a)] := by decide
def m57_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m57_0_1 a = [] := by decide
example : simulations m57_0_1 b = [] := by decide
example : simulationCovered m57_0_1 = false := by decide
example : failures m57_0_1 = [a,b] := by decide
example : correct m57_0_1 = false := by decide
example : closedLedger m57_0_1 = [] := by decide
example : retainedLedger m57_0_1 = [(a,b),(b,a)] := by decide
def m57_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m57_0_2 a = [] := by decide
example : simulations m57_0_2 b = [] := by decide
example : simulationCovered m57_0_2 = false := by decide
example : failures m57_0_2 = [a,b] := by decide
example : correct m57_0_2 = false := by decide
example : closedLedger m57_0_2 = [] := by decide
example : retainedLedger m57_0_2 = [(a,b),(b,a)] := by decide
def m57_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m57_0_3 a = [] := by decide
example : simulations m57_0_3 b = [] := by decide
example : simulationCovered m57_0_3 = false := by decide
example : failures m57_0_3 = [a,b] := by decide
example : correct m57_0_3 = true := by decide
example : closedLedger m57_0_3 = [] := by decide
example : retainedLedger m57_0_3 = [(a,b),(b,a)] := by decide
def m57_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m57_1_0 a = [] := by decide
example : simulations m57_1_0 b = [] := by decide
example : simulationCovered m57_1_0 = false := by decide
example : failures m57_1_0 = [a,b] := by decide
example : correct m57_1_0 = false := by decide
example : closedLedger m57_1_0 = [] := by decide
example : retainedLedger m57_1_0 = [(a,b),(b,a)] := by decide
def m57_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m57_1_1 a = [] := by decide
example : simulations m57_1_1 b = [] := by decide
example : simulationCovered m57_1_1 = false := by decide
example : failures m57_1_1 = [a,b] := by decide
example : correct m57_1_1 = false := by decide
example : closedLedger m57_1_1 = [] := by decide
example : retainedLedger m57_1_1 = [(a,b),(b,a)] := by decide
def m57_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m57_1_2 a = [] := by decide
example : simulations m57_1_2 b = [] := by decide
example : simulationCovered m57_1_2 = false := by decide
example : failures m57_1_2 = [a,b] := by decide
example : correct m57_1_2 = false := by decide
example : closedLedger m57_1_2 = [] := by decide
example : retainedLedger m57_1_2 = [(a,b),(b,a)] := by decide
def m57_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m57_1_3 a = [] := by decide
example : simulations m57_1_3 b = [] := by decide
example : simulationCovered m57_1_3 = false := by decide
example : failures m57_1_3 = [a,b] := by decide
example : correct m57_1_3 = true := by decide
example : closedLedger m57_1_3 = [] := by decide
example : retainedLedger m57_1_3 = [(a,b),(b,a)] := by decide
def m58_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m58_0_0 a = [] := by decide
example : simulations m58_0_0 b = [] := by decide
example : simulationCovered m58_0_0 = false := by decide
example : failures m58_0_0 = [a,b] := by decide
example : correct m58_0_0 = false := by decide
example : closedLedger m58_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_0_0 = [] := by decide
def m58_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m58_0_1 a = [] := by decide
example : simulations m58_0_1 b = [] := by decide
example : simulationCovered m58_0_1 = false := by decide
example : failures m58_0_1 = [a,b] := by decide
example : correct m58_0_1 = false := by decide
example : closedLedger m58_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_0_1 = [] := by decide
def m58_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m58_0_2 a = [] := by decide
example : simulations m58_0_2 b = [] := by decide
example : simulationCovered m58_0_2 = false := by decide
example : failures m58_0_2 = [a,b] := by decide
example : correct m58_0_2 = false := by decide
example : closedLedger m58_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_0_2 = [] := by decide
def m58_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m58_0_3 a = [] := by decide
example : simulations m58_0_3 b = [] := by decide
example : simulationCovered m58_0_3 = false := by decide
example : failures m58_0_3 = [a,b] := by decide
example : correct m58_0_3 = true := by decide
example : closedLedger m58_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_0_3 = [] := by decide
def m58_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m58_1_0 a = [] := by decide
example : simulations m58_1_0 b = [] := by decide
example : simulationCovered m58_1_0 = false := by decide
example : failures m58_1_0 = [a,b] := by decide
example : correct m58_1_0 = false := by decide
example : closedLedger m58_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_1_0 = [] := by decide
def m58_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m58_1_1 a = [] := by decide
example : simulations m58_1_1 b = [] := by decide
example : simulationCovered m58_1_1 = false := by decide
example : failures m58_1_1 = [a,b] := by decide
example : correct m58_1_1 = false := by decide
example : closedLedger m58_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_1_1 = [] := by decide
def m58_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m58_1_2 a = [] := by decide
example : simulations m58_1_2 b = [] := by decide
example : simulationCovered m58_1_2 = false := by decide
example : failures m58_1_2 = [a,b] := by decide
example : correct m58_1_2 = false := by decide
example : closedLedger m58_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_1_2 = [] := by decide
def m58_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m58_1_3 a = [] := by decide
example : simulations m58_1_3 b = [] := by decide
example : simulationCovered m58_1_3 = false := by decide
example : failures m58_1_3 = [a,b] := by decide
example : correct m58_1_3 = true := by decide
example : closedLedger m58_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m58_1_3 = [] := by decide
def m59_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m59_0_0 a = [] := by decide
example : simulations m59_0_0 b = [] := by decide
example : simulationCovered m59_0_0 = false := by decide
example : failures m59_0_0 = [a,b] := by decide
example : correct m59_0_0 = false := by decide
example : closedLedger m59_0_0 = [] := by decide
example : retainedLedger m59_0_0 = [(a,b),(b,a)] := by decide
def m59_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m59_0_1 a = [] := by decide
example : simulations m59_0_1 b = [] := by decide
example : simulationCovered m59_0_1 = false := by decide
example : failures m59_0_1 = [a,b] := by decide
example : correct m59_0_1 = false := by decide
example : closedLedger m59_0_1 = [] := by decide
example : retainedLedger m59_0_1 = [(a,b),(b,a)] := by decide
def m59_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m59_0_2 a = [] := by decide
example : simulations m59_0_2 b = [] := by decide
example : simulationCovered m59_0_2 = false := by decide
example : failures m59_0_2 = [a,b] := by decide
example : correct m59_0_2 = false := by decide
example : closedLedger m59_0_2 = [] := by decide
example : retainedLedger m59_0_2 = [(a,b),(b,a)] := by decide
def m59_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m59_0_3 a = [] := by decide
example : simulations m59_0_3 b = [] := by decide
example : simulationCovered m59_0_3 = false := by decide
example : failures m59_0_3 = [a,b] := by decide
example : correct m59_0_3 = true := by decide
example : closedLedger m59_0_3 = [] := by decide
example : retainedLedger m59_0_3 = [(a,b),(b,a)] := by decide
def m59_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m59_1_0 a = [sim] := by decide
example : simulations m59_1_0 b = [] := by decide
example : simulationCovered m59_1_0 = false := by decide
example : failures m59_1_0 = [b] := by decide
example : correct m59_1_0 = false := by decide
example : closedLedger m59_1_0 = [] := by decide
example : retainedLedger m59_1_0 = [(a,b),(b,a)] := by decide
def m59_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m59_1_1 a = [sim] := by decide
example : simulations m59_1_1 b = [] := by decide
example : simulationCovered m59_1_1 = false := by decide
example : failures m59_1_1 = [b] := by decide
example : correct m59_1_1 = false := by decide
example : closedLedger m59_1_1 = [] := by decide
example : retainedLedger m59_1_1 = [(a,b),(b,a)] := by decide
def m59_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m59_1_2 a = [sim] := by decide
example : simulations m59_1_2 b = [] := by decide
example : simulationCovered m59_1_2 = false := by decide
example : failures m59_1_2 = [b] := by decide
example : correct m59_1_2 = false := by decide
example : closedLedger m59_1_2 = [] := by decide
example : retainedLedger m59_1_2 = [(a,b),(b,a)] := by decide
def m59_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m59_1_3 a = [sim] := by decide
example : simulations m59_1_3 b = [] := by decide
example : simulationCovered m59_1_3 = false := by decide
example : failures m59_1_3 = [b] := by decide
example : correct m59_1_3 = true := by decide
example : closedLedger m59_1_3 = [] := by decide
example : retainedLedger m59_1_3 = [(a,b),(b,a)] := by decide
def m60_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m60_0_0 a = [] := by decide
example : simulations m60_0_0 b = [] := by decide
example : simulationCovered m60_0_0 = false := by decide
example : failures m60_0_0 = [a,b] := by decide
example : correct m60_0_0 = false := by decide
example : closedLedger m60_0_0 = [] := by decide
example : retainedLedger m60_0_0 = [(a,b),(b,a)] := by decide
def m60_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m60_0_1 a = [] := by decide
example : simulations m60_0_1 b = [] := by decide
example : simulationCovered m60_0_1 = false := by decide
example : failures m60_0_1 = [a,b] := by decide
example : correct m60_0_1 = false := by decide
example : closedLedger m60_0_1 = [] := by decide
example : retainedLedger m60_0_1 = [(a,b),(b,a)] := by decide
def m60_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m60_0_2 a = [] := by decide
example : simulations m60_0_2 b = [] := by decide
example : simulationCovered m60_0_2 = false := by decide
example : failures m60_0_2 = [a,b] := by decide
example : correct m60_0_2 = false := by decide
example : closedLedger m60_0_2 = [] := by decide
example : retainedLedger m60_0_2 = [(a,b),(b,a)] := by decide
def m60_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m60_0_3 a = [] := by decide
example : simulations m60_0_3 b = [] := by decide
example : simulationCovered m60_0_3 = false := by decide
example : failures m60_0_3 = [a,b] := by decide
example : correct m60_0_3 = true := by decide
example : closedLedger m60_0_3 = [] := by decide
example : retainedLedger m60_0_3 = [(a,b),(b,a)] := by decide
def m60_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m60_1_0 a = [] := by decide
example : simulations m60_1_0 b = [sim] := by decide
example : simulationCovered m60_1_0 = false := by decide
example : failures m60_1_0 = [a] := by decide
example : correct m60_1_0 = false := by decide
example : closedLedger m60_1_0 = [] := by decide
example : retainedLedger m60_1_0 = [(a,b),(b,a)] := by decide
def m60_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m60_1_1 a = [] := by decide
example : simulations m60_1_1 b = [sim] := by decide
example : simulationCovered m60_1_1 = false := by decide
example : failures m60_1_1 = [a] := by decide
example : correct m60_1_1 = false := by decide
example : closedLedger m60_1_1 = [] := by decide
example : retainedLedger m60_1_1 = [(a,b),(b,a)] := by decide
def m60_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m60_1_2 a = [] := by decide
example : simulations m60_1_2 b = [sim] := by decide
example : simulationCovered m60_1_2 = false := by decide
example : failures m60_1_2 = [a] := by decide
example : correct m60_1_2 = false := by decide
example : closedLedger m60_1_2 = [] := by decide
example : retainedLedger m60_1_2 = [(a,b),(b,a)] := by decide
def m60_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m60_1_3 a = [] := by decide
example : simulations m60_1_3 b = [sim] := by decide
example : simulationCovered m60_1_3 = false := by decide
example : failures m60_1_3 = [a] := by decide
example : correct m60_1_3 = true := by decide
example : closedLedger m60_1_3 = [] := by decide
example : retainedLedger m60_1_3 = [(a,b),(b,a)] := by decide
def m61_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m61_0_0 a = [] := by decide
example : simulations m61_0_0 b = [] := by decide
example : simulationCovered m61_0_0 = false := by decide
example : failures m61_0_0 = [a,b] := by decide
example : correct m61_0_0 = false := by decide
example : closedLedger m61_0_0 = [] := by decide
example : retainedLedger m61_0_0 = [(a,b),(b,a)] := by decide
def m61_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m61_0_1 a = [] := by decide
example : simulations m61_0_1 b = [] := by decide
example : simulationCovered m61_0_1 = false := by decide
example : failures m61_0_1 = [a,b] := by decide
example : correct m61_0_1 = false := by decide
example : closedLedger m61_0_1 = [] := by decide
example : retainedLedger m61_0_1 = [(a,b),(b,a)] := by decide
def m61_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m61_0_2 a = [] := by decide
example : simulations m61_0_2 b = [] := by decide
example : simulationCovered m61_0_2 = false := by decide
example : failures m61_0_2 = [a,b] := by decide
example : correct m61_0_2 = false := by decide
example : closedLedger m61_0_2 = [] := by decide
example : retainedLedger m61_0_2 = [(a,b),(b,a)] := by decide
def m61_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m61_0_3 a = [] := by decide
example : simulations m61_0_3 b = [] := by decide
example : simulationCovered m61_0_3 = false := by decide
example : failures m61_0_3 = [a,b] := by decide
example : correct m61_0_3 = true := by decide
example : closedLedger m61_0_3 = [] := by decide
example : retainedLedger m61_0_3 = [(a,b),(b,a)] := by decide
def m61_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m61_1_0 a = [] := by decide
example : simulations m61_1_0 b = [sim] := by decide
example : simulationCovered m61_1_0 = false := by decide
example : failures m61_1_0 = [a] := by decide
example : correct m61_1_0 = false := by decide
example : closedLedger m61_1_0 = [] := by decide
example : retainedLedger m61_1_0 = [(a,b),(b,a)] := by decide
def m61_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m61_1_1 a = [] := by decide
example : simulations m61_1_1 b = [sim] := by decide
example : simulationCovered m61_1_1 = false := by decide
example : failures m61_1_1 = [a] := by decide
example : correct m61_1_1 = false := by decide
example : closedLedger m61_1_1 = [] := by decide
example : retainedLedger m61_1_1 = [(a,b),(b,a)] := by decide
def m61_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m61_1_2 a = [] := by decide
example : simulations m61_1_2 b = [sim] := by decide
example : simulationCovered m61_1_2 = false := by decide
example : failures m61_1_2 = [a] := by decide
example : correct m61_1_2 = false := by decide
example : closedLedger m61_1_2 = [] := by decide
example : retainedLedger m61_1_2 = [(a,b),(b,a)] := by decide
def m61_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m61_1_3 a = [] := by decide
example : simulations m61_1_3 b = [sim] := by decide
example : simulationCovered m61_1_3 = false := by decide
example : failures m61_1_3 = [a] := by decide
example : correct m61_1_3 = true := by decide
example : closedLedger m61_1_3 = [] := by decide
example : retainedLedger m61_1_3 = [(a,b),(b,a)] := by decide
def m62_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m62_0_0 a = [] := by decide
example : simulations m62_0_0 b = [] := by decide
example : simulationCovered m62_0_0 = false := by decide
example : failures m62_0_0 = [a,b] := by decide
example : correct m62_0_0 = false := by decide
example : closedLedger m62_0_0 = [] := by decide
example : retainedLedger m62_0_0 = [(a,b),(b,a)] := by decide
def m62_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m62_0_1 a = [] := by decide
example : simulations m62_0_1 b = [] := by decide
example : simulationCovered m62_0_1 = false := by decide
example : failures m62_0_1 = [a,b] := by decide
example : correct m62_0_1 = false := by decide
example : closedLedger m62_0_1 = [] := by decide
example : retainedLedger m62_0_1 = [(a,b),(b,a)] := by decide
def m62_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m62_0_2 a = [] := by decide
example : simulations m62_0_2 b = [] := by decide
example : simulationCovered m62_0_2 = false := by decide
example : failures m62_0_2 = [a,b] := by decide
example : correct m62_0_2 = false := by decide
example : closedLedger m62_0_2 = [] := by decide
example : retainedLedger m62_0_2 = [(a,b),(b,a)] := by decide
def m62_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m62_0_3 a = [] := by decide
example : simulations m62_0_3 b = [] := by decide
example : simulationCovered m62_0_3 = false := by decide
example : failures m62_0_3 = [a,b] := by decide
example : correct m62_0_3 = true := by decide
example : closedLedger m62_0_3 = [] := by decide
example : retainedLedger m62_0_3 = [(a,b),(b,a)] := by decide
def m62_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m62_1_0 a = [] := by decide
example : simulations m62_1_0 b = [sim] := by decide
example : simulationCovered m62_1_0 = false := by decide
example : failures m62_1_0 = [a] := by decide
example : correct m62_1_0 = false := by decide
example : closedLedger m62_1_0 = [] := by decide
example : retainedLedger m62_1_0 = [(a,b),(b,a)] := by decide
def m62_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m62_1_1 a = [] := by decide
example : simulations m62_1_1 b = [sim] := by decide
example : simulationCovered m62_1_1 = false := by decide
example : failures m62_1_1 = [a] := by decide
example : correct m62_1_1 = false := by decide
example : closedLedger m62_1_1 = [] := by decide
example : retainedLedger m62_1_1 = [(a,b),(b,a)] := by decide
def m62_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m62_1_2 a = [] := by decide
example : simulations m62_1_2 b = [sim] := by decide
example : simulationCovered m62_1_2 = false := by decide
example : failures m62_1_2 = [a] := by decide
example : correct m62_1_2 = false := by decide
example : closedLedger m62_1_2 = [] := by decide
example : retainedLedger m62_1_2 = [(a,b),(b,a)] := by decide
def m62_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m62_1_3 a = [] := by decide
example : simulations m62_1_3 b = [sim] := by decide
example : simulationCovered m62_1_3 = false := by decide
example : failures m62_1_3 = [a] := by decide
example : correct m62_1_3 = true := by decide
example : closedLedger m62_1_3 = [] := by decide
example : retainedLedger m62_1_3 = [(a,b),(b,a)] := by decide
def m63_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m63_0_0 a = [] := by decide
example : simulations m63_0_0 b = [] := by decide
example : simulationCovered m63_0_0 = false := by decide
example : failures m63_0_0 = [a,b] := by decide
example : correct m63_0_0 = false := by decide
example : closedLedger m63_0_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_0_0 = [] := by decide
def m63_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m63_0_1 a = [] := by decide
example : simulations m63_0_1 b = [] := by decide
example : simulationCovered m63_0_1 = false := by decide
example : failures m63_0_1 = [a,b] := by decide
example : correct m63_0_1 = false := by decide
example : closedLedger m63_0_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_0_1 = [] := by decide
def m63_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m63_0_2 a = [] := by decide
example : simulations m63_0_2 b = [] := by decide
example : simulationCovered m63_0_2 = false := by decide
example : failures m63_0_2 = [a,b] := by decide
example : correct m63_0_2 = false := by decide
example : closedLedger m63_0_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_0_2 = [] := by decide
def m63_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m63_0_3 a = [] := by decide
example : simulations m63_0_3 b = [] := by decide
example : simulationCovered m63_0_3 = false := by decide
example : failures m63_0_3 = [a,b] := by decide
example : correct m63_0_3 = true := by decide
example : closedLedger m63_0_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_0_3 = [] := by decide
def m63_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],[]⟩
example : simulations m63_1_0 a = [sim] := by decide
example : simulations m63_1_0 b = [sim] := by decide
example : simulationCovered m63_1_0 = true := by decide
example : failures m63_1_0 = [] := by decide
example : correct m63_1_0 = false := by decide
example : closedLedger m63_1_0 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_1_0 = [] := by decide
def m63_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a"]⟩
example : simulations m63_1_1 a = [sim] := by decide
example : simulations m63_1_1 b = [sim] := by decide
example : simulationCovered m63_1_1 = true := by decide
example : failures m63_1_1 = [] := by decide
example : correct m63_1_1 = false := by decide
example : closedLedger m63_1_1 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_1_1 = [] := by decide
def m63_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["b"]⟩
example : simulations m63_1_2 a = [sim] := by decide
example : simulations m63_1_2 b = [sim] := by decide
example : simulationCovered m63_1_2 = true := by decide
example : failures m63_1_2 = [] := by decide
example : correct m63_1_2 = false := by decide
example : closedLedger m63_1_2 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_1_2 = [] := by decide
def m63_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],[a,b],system,[sim],[("a","v"),("a","u"),("b","v"),("b","u"),("sim","v"),("sim","u")],["a","b"]⟩
example : simulations m63_1_3 a = [sim] := by decide
example : simulations m63_1_3 b = [sim] := by decide
example : simulationCovered m63_1_3 = true := by decide
example : failures m63_1_3 = [] := by decide
example : correct m63_1_3 = true := by decide
example : closedLedger m63_1_3 = [(a,b),(b,a)] := by decide
example : retainedLedger m63_1_3 = [] := by decide
def nativeSimulation : SimulationTrace m21_1_3 := ⟨sim,.head _,.head _,rfl,rfl⟩
theorem nativeClosed : closed m21_1_3 a b := commonSimulation _ _ _ sim ((realMeaning _ _).mpr ⟨.head _,.head _,.head _⟩) ((realMeaning _ _).mpr ⟨.tail _ (.head _),.head _,.tail _ (.head _)⟩) (by decide) (by decide) (by decide)
#print axioms nativeClosed
#print axioms nativeSimulation
end SFT.Computation.ZeroKnowledge
