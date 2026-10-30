import SFT.Computation.PostQuantumBoundary
namespace SFT.Computation.PostQuantumBoundary
def system : StateTransition.System := ⟨["q"],["step"],[("q","step","q")]⟩
def c : Oracle := ⟨"c",.classical⟩
def q : Oracle := ⟨"q",.quantumInterface⟩
def a : Query := ⟨c,"in","out",1⟩
def b : Query := ⟨q,"in","out",2⟩
def m0_0_0_0 : Model := ⟨system,[],[],0,0,["d"]⟩
example : ledgerAdmitted m0_0_0_0 [] = true := by decide
example : ledgerAdmitted m0_0_0_0 [a] = false := by decide
example : ledgerAdmitted m0_0_0_0 [b] = false := by decide
example : ledgerAdmitted m0_0_0_0 [a,b] = false := by decide
def m0_0_0_1 : Model := ⟨system,[],[],0,1,["d"]⟩
example : ledgerAdmitted m0_0_0_1 [] = true := by decide
example : ledgerAdmitted m0_0_0_1 [a] = false := by decide
example : ledgerAdmitted m0_0_0_1 [b] = false := by decide
example : ledgerAdmitted m0_0_0_1 [a,b] = false := by decide
def m0_0_0_2 : Model := ⟨system,[],[],0,2,["d"]⟩
example : ledgerAdmitted m0_0_0_2 [] = true := by decide
example : ledgerAdmitted m0_0_0_2 [a] = false := by decide
example : ledgerAdmitted m0_0_0_2 [b] = false := by decide
example : ledgerAdmitted m0_0_0_2 [a,b] = false := by decide
def m0_0_0_3 : Model := ⟨system,[],[],0,3,["d"]⟩
example : ledgerAdmitted m0_0_0_3 [] = true := by decide
example : ledgerAdmitted m0_0_0_3 [a] = false := by decide
example : ledgerAdmitted m0_0_0_3 [b] = false := by decide
example : ledgerAdmitted m0_0_0_3 [a,b] = false := by decide
def m0_0_1_0 : Model := ⟨system,[],[],1,0,["d"]⟩
example : ledgerAdmitted m0_0_1_0 [] = true := by decide
example : ledgerAdmitted m0_0_1_0 [a] = false := by decide
example : ledgerAdmitted m0_0_1_0 [b] = false := by decide
example : ledgerAdmitted m0_0_1_0 [a,b] = false := by decide
def m0_0_1_1 : Model := ⟨system,[],[],1,1,["d"]⟩
example : ledgerAdmitted m0_0_1_1 [] = true := by decide
example : ledgerAdmitted m0_0_1_1 [a] = false := by decide
example : ledgerAdmitted m0_0_1_1 [b] = false := by decide
example : ledgerAdmitted m0_0_1_1 [a,b] = false := by decide
def m0_0_1_2 : Model := ⟨system,[],[],1,2,["d"]⟩
example : ledgerAdmitted m0_0_1_2 [] = true := by decide
example : ledgerAdmitted m0_0_1_2 [a] = false := by decide
example : ledgerAdmitted m0_0_1_2 [b] = false := by decide
example : ledgerAdmitted m0_0_1_2 [a,b] = false := by decide
def m0_0_1_3 : Model := ⟨system,[],[],1,3,["d"]⟩
example : ledgerAdmitted m0_0_1_3 [] = true := by decide
example : ledgerAdmitted m0_0_1_3 [a] = false := by decide
example : ledgerAdmitted m0_0_1_3 [b] = false := by decide
example : ledgerAdmitted m0_0_1_3 [a,b] = false := by decide
def m0_0_2_0 : Model := ⟨system,[],[],2,0,["d"]⟩
example : ledgerAdmitted m0_0_2_0 [] = true := by decide
example : ledgerAdmitted m0_0_2_0 [a] = false := by decide
example : ledgerAdmitted m0_0_2_0 [b] = false := by decide
example : ledgerAdmitted m0_0_2_0 [a,b] = false := by decide
def m0_0_2_1 : Model := ⟨system,[],[],2,1,["d"]⟩
example : ledgerAdmitted m0_0_2_1 [] = true := by decide
example : ledgerAdmitted m0_0_2_1 [a] = false := by decide
example : ledgerAdmitted m0_0_2_1 [b] = false := by decide
example : ledgerAdmitted m0_0_2_1 [a,b] = false := by decide
def m0_0_2_2 : Model := ⟨system,[],[],2,2,["d"]⟩
example : ledgerAdmitted m0_0_2_2 [] = true := by decide
example : ledgerAdmitted m0_0_2_2 [a] = false := by decide
example : ledgerAdmitted m0_0_2_2 [b] = false := by decide
example : ledgerAdmitted m0_0_2_2 [a,b] = false := by decide
def m0_0_2_3 : Model := ⟨system,[],[],2,3,["d"]⟩
example : ledgerAdmitted m0_0_2_3 [] = true := by decide
example : ledgerAdmitted m0_0_2_3 [a] = false := by decide
example : ledgerAdmitted m0_0_2_3 [b] = false := by decide
example : ledgerAdmitted m0_0_2_3 [a,b] = false := by decide
def m0_1_0_0 : Model := ⟨system,[],[a],0,0,["d"]⟩
example : ledgerAdmitted m0_1_0_0 [] = true := by decide
example : ledgerAdmitted m0_1_0_0 [a] = false := by decide
example : ledgerAdmitted m0_1_0_0 [b] = false := by decide
example : ledgerAdmitted m0_1_0_0 [a,b] = false := by decide
def m0_1_0_1 : Model := ⟨system,[],[a],0,1,["d"]⟩
example : ledgerAdmitted m0_1_0_1 [] = true := by decide
example : ledgerAdmitted m0_1_0_1 [a] = false := by decide
example : ledgerAdmitted m0_1_0_1 [b] = false := by decide
example : ledgerAdmitted m0_1_0_1 [a,b] = false := by decide
def m0_1_0_2 : Model := ⟨system,[],[a],0,2,["d"]⟩
example : ledgerAdmitted m0_1_0_2 [] = true := by decide
example : ledgerAdmitted m0_1_0_2 [a] = false := by decide
example : ledgerAdmitted m0_1_0_2 [b] = false := by decide
example : ledgerAdmitted m0_1_0_2 [a,b] = false := by decide
def m0_1_0_3 : Model := ⟨system,[],[a],0,3,["d"]⟩
example : ledgerAdmitted m0_1_0_3 [] = true := by decide
example : ledgerAdmitted m0_1_0_3 [a] = false := by decide
example : ledgerAdmitted m0_1_0_3 [b] = false := by decide
example : ledgerAdmitted m0_1_0_3 [a,b] = false := by decide
def m0_1_1_0 : Model := ⟨system,[],[a],1,0,["d"]⟩
example : ledgerAdmitted m0_1_1_0 [] = true := by decide
example : ledgerAdmitted m0_1_1_0 [a] = false := by decide
example : ledgerAdmitted m0_1_1_0 [b] = false := by decide
example : ledgerAdmitted m0_1_1_0 [a,b] = false := by decide
def m0_1_1_1 : Model := ⟨system,[],[a],1,1,["d"]⟩
example : ledgerAdmitted m0_1_1_1 [] = true := by decide
example : ledgerAdmitted m0_1_1_1 [a] = false := by decide
example : ledgerAdmitted m0_1_1_1 [b] = false := by decide
example : ledgerAdmitted m0_1_1_1 [a,b] = false := by decide
def m0_1_1_2 : Model := ⟨system,[],[a],1,2,["d"]⟩
example : ledgerAdmitted m0_1_1_2 [] = true := by decide
example : ledgerAdmitted m0_1_1_2 [a] = false := by decide
example : ledgerAdmitted m0_1_1_2 [b] = false := by decide
example : ledgerAdmitted m0_1_1_2 [a,b] = false := by decide
def m0_1_1_3 : Model := ⟨system,[],[a],1,3,["d"]⟩
example : ledgerAdmitted m0_1_1_3 [] = true := by decide
example : ledgerAdmitted m0_1_1_3 [a] = false := by decide
example : ledgerAdmitted m0_1_1_3 [b] = false := by decide
example : ledgerAdmitted m0_1_1_3 [a,b] = false := by decide
def m0_1_2_0 : Model := ⟨system,[],[a],2,0,["d"]⟩
example : ledgerAdmitted m0_1_2_0 [] = true := by decide
example : ledgerAdmitted m0_1_2_0 [a] = false := by decide
example : ledgerAdmitted m0_1_2_0 [b] = false := by decide
example : ledgerAdmitted m0_1_2_0 [a,b] = false := by decide
def m0_1_2_1 : Model := ⟨system,[],[a],2,1,["d"]⟩
example : ledgerAdmitted m0_1_2_1 [] = true := by decide
example : ledgerAdmitted m0_1_2_1 [a] = false := by decide
example : ledgerAdmitted m0_1_2_1 [b] = false := by decide
example : ledgerAdmitted m0_1_2_1 [a,b] = false := by decide
def m0_1_2_2 : Model := ⟨system,[],[a],2,2,["d"]⟩
example : ledgerAdmitted m0_1_2_2 [] = true := by decide
example : ledgerAdmitted m0_1_2_2 [a] = false := by decide
example : ledgerAdmitted m0_1_2_2 [b] = false := by decide
example : ledgerAdmitted m0_1_2_2 [a,b] = false := by decide
def m0_1_2_3 : Model := ⟨system,[],[a],2,3,["d"]⟩
example : ledgerAdmitted m0_1_2_3 [] = true := by decide
example : ledgerAdmitted m0_1_2_3 [a] = false := by decide
example : ledgerAdmitted m0_1_2_3 [b] = false := by decide
example : ledgerAdmitted m0_1_2_3 [a,b] = false := by decide
def m0_2_0_0 : Model := ⟨system,[],[b],0,0,["d"]⟩
example : ledgerAdmitted m0_2_0_0 [] = true := by decide
example : ledgerAdmitted m0_2_0_0 [a] = false := by decide
example : ledgerAdmitted m0_2_0_0 [b] = false := by decide
example : ledgerAdmitted m0_2_0_0 [a,b] = false := by decide
def m0_2_0_1 : Model := ⟨system,[],[b],0,1,["d"]⟩
example : ledgerAdmitted m0_2_0_1 [] = true := by decide
example : ledgerAdmitted m0_2_0_1 [a] = false := by decide
example : ledgerAdmitted m0_2_0_1 [b] = false := by decide
example : ledgerAdmitted m0_2_0_1 [a,b] = false := by decide
def m0_2_0_2 : Model := ⟨system,[],[b],0,2,["d"]⟩
example : ledgerAdmitted m0_2_0_2 [] = true := by decide
example : ledgerAdmitted m0_2_0_2 [a] = false := by decide
example : ledgerAdmitted m0_2_0_2 [b] = false := by decide
example : ledgerAdmitted m0_2_0_2 [a,b] = false := by decide
def m0_2_0_3 : Model := ⟨system,[],[b],0,3,["d"]⟩
example : ledgerAdmitted m0_2_0_3 [] = true := by decide
example : ledgerAdmitted m0_2_0_3 [a] = false := by decide
example : ledgerAdmitted m0_2_0_3 [b] = false := by decide
example : ledgerAdmitted m0_2_0_3 [a,b] = false := by decide
def m0_2_1_0 : Model := ⟨system,[],[b],1,0,["d"]⟩
example : ledgerAdmitted m0_2_1_0 [] = true := by decide
example : ledgerAdmitted m0_2_1_0 [a] = false := by decide
example : ledgerAdmitted m0_2_1_0 [b] = false := by decide
example : ledgerAdmitted m0_2_1_0 [a,b] = false := by decide
def m0_2_1_1 : Model := ⟨system,[],[b],1,1,["d"]⟩
example : ledgerAdmitted m0_2_1_1 [] = true := by decide
example : ledgerAdmitted m0_2_1_1 [a] = false := by decide
example : ledgerAdmitted m0_2_1_1 [b] = false := by decide
example : ledgerAdmitted m0_2_1_1 [a,b] = false := by decide
def m0_2_1_2 : Model := ⟨system,[],[b],1,2,["d"]⟩
example : ledgerAdmitted m0_2_1_2 [] = true := by decide
example : ledgerAdmitted m0_2_1_2 [a] = false := by decide
example : ledgerAdmitted m0_2_1_2 [b] = false := by decide
example : ledgerAdmitted m0_2_1_2 [a,b] = false := by decide
def m0_2_1_3 : Model := ⟨system,[],[b],1,3,["d"]⟩
example : ledgerAdmitted m0_2_1_3 [] = true := by decide
example : ledgerAdmitted m0_2_1_3 [a] = false := by decide
example : ledgerAdmitted m0_2_1_3 [b] = false := by decide
example : ledgerAdmitted m0_2_1_3 [a,b] = false := by decide
def m0_2_2_0 : Model := ⟨system,[],[b],2,0,["d"]⟩
example : ledgerAdmitted m0_2_2_0 [] = true := by decide
example : ledgerAdmitted m0_2_2_0 [a] = false := by decide
example : ledgerAdmitted m0_2_2_0 [b] = false := by decide
example : ledgerAdmitted m0_2_2_0 [a,b] = false := by decide
def m0_2_2_1 : Model := ⟨system,[],[b],2,1,["d"]⟩
example : ledgerAdmitted m0_2_2_1 [] = true := by decide
example : ledgerAdmitted m0_2_2_1 [a] = false := by decide
example : ledgerAdmitted m0_2_2_1 [b] = false := by decide
example : ledgerAdmitted m0_2_2_1 [a,b] = false := by decide
def m0_2_2_2 : Model := ⟨system,[],[b],2,2,["d"]⟩
example : ledgerAdmitted m0_2_2_2 [] = true := by decide
example : ledgerAdmitted m0_2_2_2 [a] = false := by decide
example : ledgerAdmitted m0_2_2_2 [b] = false := by decide
example : ledgerAdmitted m0_2_2_2 [a,b] = false := by decide
def m0_2_2_3 : Model := ⟨system,[],[b],2,3,["d"]⟩
example : ledgerAdmitted m0_2_2_3 [] = true := by decide
example : ledgerAdmitted m0_2_2_3 [a] = false := by decide
example : ledgerAdmitted m0_2_2_3 [b] = false := by decide
example : ledgerAdmitted m0_2_2_3 [a,b] = false := by decide
def m0_3_0_0 : Model := ⟨system,[],[a,b],0,0,["d"]⟩
example : ledgerAdmitted m0_3_0_0 [] = true := by decide
example : ledgerAdmitted m0_3_0_0 [a] = false := by decide
example : ledgerAdmitted m0_3_0_0 [b] = false := by decide
example : ledgerAdmitted m0_3_0_0 [a,b] = false := by decide
def m0_3_0_1 : Model := ⟨system,[],[a,b],0,1,["d"]⟩
example : ledgerAdmitted m0_3_0_1 [] = true := by decide
example : ledgerAdmitted m0_3_0_1 [a] = false := by decide
example : ledgerAdmitted m0_3_0_1 [b] = false := by decide
example : ledgerAdmitted m0_3_0_1 [a,b] = false := by decide
def m0_3_0_2 : Model := ⟨system,[],[a,b],0,2,["d"]⟩
example : ledgerAdmitted m0_3_0_2 [] = true := by decide
example : ledgerAdmitted m0_3_0_2 [a] = false := by decide
example : ledgerAdmitted m0_3_0_2 [b] = false := by decide
example : ledgerAdmitted m0_3_0_2 [a,b] = false := by decide
def m0_3_0_3 : Model := ⟨system,[],[a,b],0,3,["d"]⟩
example : ledgerAdmitted m0_3_0_3 [] = true := by decide
example : ledgerAdmitted m0_3_0_3 [a] = false := by decide
example : ledgerAdmitted m0_3_0_3 [b] = false := by decide
example : ledgerAdmitted m0_3_0_3 [a,b] = false := by decide
def m0_3_1_0 : Model := ⟨system,[],[a,b],1,0,["d"]⟩
example : ledgerAdmitted m0_3_1_0 [] = true := by decide
example : ledgerAdmitted m0_3_1_0 [a] = false := by decide
example : ledgerAdmitted m0_3_1_0 [b] = false := by decide
example : ledgerAdmitted m0_3_1_0 [a,b] = false := by decide
def m0_3_1_1 : Model := ⟨system,[],[a,b],1,1,["d"]⟩
example : ledgerAdmitted m0_3_1_1 [] = true := by decide
example : ledgerAdmitted m0_3_1_1 [a] = false := by decide
example : ledgerAdmitted m0_3_1_1 [b] = false := by decide
example : ledgerAdmitted m0_3_1_1 [a,b] = false := by decide
def m0_3_1_2 : Model := ⟨system,[],[a,b],1,2,["d"]⟩
example : ledgerAdmitted m0_3_1_2 [] = true := by decide
example : ledgerAdmitted m0_3_1_2 [a] = false := by decide
example : ledgerAdmitted m0_3_1_2 [b] = false := by decide
example : ledgerAdmitted m0_3_1_2 [a,b] = false := by decide
def m0_3_1_3 : Model := ⟨system,[],[a,b],1,3,["d"]⟩
example : ledgerAdmitted m0_3_1_3 [] = true := by decide
example : ledgerAdmitted m0_3_1_3 [a] = false := by decide
example : ledgerAdmitted m0_3_1_3 [b] = false := by decide
example : ledgerAdmitted m0_3_1_3 [a,b] = false := by decide
def m0_3_2_0 : Model := ⟨system,[],[a,b],2,0,["d"]⟩
example : ledgerAdmitted m0_3_2_0 [] = true := by decide
example : ledgerAdmitted m0_3_2_0 [a] = false := by decide
example : ledgerAdmitted m0_3_2_0 [b] = false := by decide
example : ledgerAdmitted m0_3_2_0 [a,b] = false := by decide
def m0_3_2_1 : Model := ⟨system,[],[a,b],2,1,["d"]⟩
example : ledgerAdmitted m0_3_2_1 [] = true := by decide
example : ledgerAdmitted m0_3_2_1 [a] = false := by decide
example : ledgerAdmitted m0_3_2_1 [b] = false := by decide
example : ledgerAdmitted m0_3_2_1 [a,b] = false := by decide
def m0_3_2_2 : Model := ⟨system,[],[a,b],2,2,["d"]⟩
example : ledgerAdmitted m0_3_2_2 [] = true := by decide
example : ledgerAdmitted m0_3_2_2 [a] = false := by decide
example : ledgerAdmitted m0_3_2_2 [b] = false := by decide
example : ledgerAdmitted m0_3_2_2 [a,b] = false := by decide
def m0_3_2_3 : Model := ⟨system,[],[a,b],2,3,["d"]⟩
example : ledgerAdmitted m0_3_2_3 [] = true := by decide
example : ledgerAdmitted m0_3_2_3 [a] = false := by decide
example : ledgerAdmitted m0_3_2_3 [b] = false := by decide
example : ledgerAdmitted m0_3_2_3 [a,b] = false := by decide
def m1_0_0_0 : Model := ⟨system,[c],[],0,0,["d"]⟩
example : ledgerAdmitted m1_0_0_0 [] = true := by decide
example : ledgerAdmitted m1_0_0_0 [a] = false := by decide
example : ledgerAdmitted m1_0_0_0 [b] = false := by decide
example : ledgerAdmitted m1_0_0_0 [a,b] = false := by decide
def m1_0_0_1 : Model := ⟨system,[c],[],0,1,["d"]⟩
example : ledgerAdmitted m1_0_0_1 [] = true := by decide
example : ledgerAdmitted m1_0_0_1 [a] = false := by decide
example : ledgerAdmitted m1_0_0_1 [b] = false := by decide
example : ledgerAdmitted m1_0_0_1 [a,b] = false := by decide
def m1_0_0_2 : Model := ⟨system,[c],[],0,2,["d"]⟩
example : ledgerAdmitted m1_0_0_2 [] = true := by decide
example : ledgerAdmitted m1_0_0_2 [a] = false := by decide
example : ledgerAdmitted m1_0_0_2 [b] = false := by decide
example : ledgerAdmitted m1_0_0_2 [a,b] = false := by decide
def m1_0_0_3 : Model := ⟨system,[c],[],0,3,["d"]⟩
example : ledgerAdmitted m1_0_0_3 [] = true := by decide
example : ledgerAdmitted m1_0_0_3 [a] = false := by decide
example : ledgerAdmitted m1_0_0_3 [b] = false := by decide
example : ledgerAdmitted m1_0_0_3 [a,b] = false := by decide
def m1_0_1_0 : Model := ⟨system,[c],[],1,0,["d"]⟩
example : ledgerAdmitted m1_0_1_0 [] = true := by decide
example : ledgerAdmitted m1_0_1_0 [a] = false := by decide
example : ledgerAdmitted m1_0_1_0 [b] = false := by decide
example : ledgerAdmitted m1_0_1_0 [a,b] = false := by decide
def m1_0_1_1 : Model := ⟨system,[c],[],1,1,["d"]⟩
example : ledgerAdmitted m1_0_1_1 [] = true := by decide
example : ledgerAdmitted m1_0_1_1 [a] = false := by decide
example : ledgerAdmitted m1_0_1_1 [b] = false := by decide
example : ledgerAdmitted m1_0_1_1 [a,b] = false := by decide
def m1_0_1_2 : Model := ⟨system,[c],[],1,2,["d"]⟩
example : ledgerAdmitted m1_0_1_2 [] = true := by decide
example : ledgerAdmitted m1_0_1_2 [a] = false := by decide
example : ledgerAdmitted m1_0_1_2 [b] = false := by decide
example : ledgerAdmitted m1_0_1_2 [a,b] = false := by decide
def m1_0_1_3 : Model := ⟨system,[c],[],1,3,["d"]⟩
example : ledgerAdmitted m1_0_1_3 [] = true := by decide
example : ledgerAdmitted m1_0_1_3 [a] = false := by decide
example : ledgerAdmitted m1_0_1_3 [b] = false := by decide
example : ledgerAdmitted m1_0_1_3 [a,b] = false := by decide
def m1_0_2_0 : Model := ⟨system,[c],[],2,0,["d"]⟩
example : ledgerAdmitted m1_0_2_0 [] = true := by decide
example : ledgerAdmitted m1_0_2_0 [a] = false := by decide
example : ledgerAdmitted m1_0_2_0 [b] = false := by decide
example : ledgerAdmitted m1_0_2_0 [a,b] = false := by decide
def m1_0_2_1 : Model := ⟨system,[c],[],2,1,["d"]⟩
example : ledgerAdmitted m1_0_2_1 [] = true := by decide
example : ledgerAdmitted m1_0_2_1 [a] = false := by decide
example : ledgerAdmitted m1_0_2_1 [b] = false := by decide
example : ledgerAdmitted m1_0_2_1 [a,b] = false := by decide
def m1_0_2_2 : Model := ⟨system,[c],[],2,2,["d"]⟩
example : ledgerAdmitted m1_0_2_2 [] = true := by decide
example : ledgerAdmitted m1_0_2_2 [a] = false := by decide
example : ledgerAdmitted m1_0_2_2 [b] = false := by decide
example : ledgerAdmitted m1_0_2_2 [a,b] = false := by decide
def m1_0_2_3 : Model := ⟨system,[c],[],2,3,["d"]⟩
example : ledgerAdmitted m1_0_2_3 [] = true := by decide
example : ledgerAdmitted m1_0_2_3 [a] = false := by decide
example : ledgerAdmitted m1_0_2_3 [b] = false := by decide
example : ledgerAdmitted m1_0_2_3 [a,b] = false := by decide
def m1_1_0_0 : Model := ⟨system,[c],[a],0,0,["d"]⟩
example : ledgerAdmitted m1_1_0_0 [] = true := by decide
example : ledgerAdmitted m1_1_0_0 [a] = false := by decide
example : ledgerAdmitted m1_1_0_0 [b] = false := by decide
example : ledgerAdmitted m1_1_0_0 [a,b] = false := by decide
def m1_1_0_1 : Model := ⟨system,[c],[a],0,1,["d"]⟩
example : ledgerAdmitted m1_1_0_1 [] = true := by decide
example : ledgerAdmitted m1_1_0_1 [a] = false := by decide
example : ledgerAdmitted m1_1_0_1 [b] = false := by decide
example : ledgerAdmitted m1_1_0_1 [a,b] = false := by decide
def m1_1_0_2 : Model := ⟨system,[c],[a],0,2,["d"]⟩
example : ledgerAdmitted m1_1_0_2 [] = true := by decide
example : ledgerAdmitted m1_1_0_2 [a] = false := by decide
example : ledgerAdmitted m1_1_0_2 [b] = false := by decide
example : ledgerAdmitted m1_1_0_2 [a,b] = false := by decide
def m1_1_0_3 : Model := ⟨system,[c],[a],0,3,["d"]⟩
example : ledgerAdmitted m1_1_0_3 [] = true := by decide
example : ledgerAdmitted m1_1_0_3 [a] = false := by decide
example : ledgerAdmitted m1_1_0_3 [b] = false := by decide
example : ledgerAdmitted m1_1_0_3 [a,b] = false := by decide
def m1_1_1_0 : Model := ⟨system,[c],[a],1,0,["d"]⟩
example : ledgerAdmitted m1_1_1_0 [] = true := by decide
example : ledgerAdmitted m1_1_1_0 [a] = false := by decide
example : ledgerAdmitted m1_1_1_0 [b] = false := by decide
example : ledgerAdmitted m1_1_1_0 [a,b] = false := by decide
def m1_1_1_1 : Model := ⟨system,[c],[a],1,1,["d"]⟩
example : ledgerAdmitted m1_1_1_1 [] = true := by decide
example : ledgerAdmitted m1_1_1_1 [a] = true := by decide
example : ledgerAdmitted m1_1_1_1 [b] = false := by decide
example : ledgerAdmitted m1_1_1_1 [a,b] = false := by decide
def m1_1_1_2 : Model := ⟨system,[c],[a],1,2,["d"]⟩
example : ledgerAdmitted m1_1_1_2 [] = true := by decide
example : ledgerAdmitted m1_1_1_2 [a] = true := by decide
example : ledgerAdmitted m1_1_1_2 [b] = false := by decide
example : ledgerAdmitted m1_1_1_2 [a,b] = false := by decide
def m1_1_1_3 : Model := ⟨system,[c],[a],1,3,["d"]⟩
example : ledgerAdmitted m1_1_1_3 [] = true := by decide
example : ledgerAdmitted m1_1_1_3 [a] = true := by decide
example : ledgerAdmitted m1_1_1_3 [b] = false := by decide
example : ledgerAdmitted m1_1_1_3 [a,b] = false := by decide
def m1_1_2_0 : Model := ⟨system,[c],[a],2,0,["d"]⟩
example : ledgerAdmitted m1_1_2_0 [] = true := by decide
example : ledgerAdmitted m1_1_2_0 [a] = false := by decide
example : ledgerAdmitted m1_1_2_0 [b] = false := by decide
example : ledgerAdmitted m1_1_2_0 [a,b] = false := by decide
def m1_1_2_1 : Model := ⟨system,[c],[a],2,1,["d"]⟩
example : ledgerAdmitted m1_1_2_1 [] = true := by decide
example : ledgerAdmitted m1_1_2_1 [a] = true := by decide
example : ledgerAdmitted m1_1_2_1 [b] = false := by decide
example : ledgerAdmitted m1_1_2_1 [a,b] = false := by decide
def m1_1_2_2 : Model := ⟨system,[c],[a],2,2,["d"]⟩
example : ledgerAdmitted m1_1_2_2 [] = true := by decide
example : ledgerAdmitted m1_1_2_2 [a] = true := by decide
example : ledgerAdmitted m1_1_2_2 [b] = false := by decide
example : ledgerAdmitted m1_1_2_2 [a,b] = false := by decide
def m1_1_2_3 : Model := ⟨system,[c],[a],2,3,["d"]⟩
example : ledgerAdmitted m1_1_2_3 [] = true := by decide
example : ledgerAdmitted m1_1_2_3 [a] = true := by decide
example : ledgerAdmitted m1_1_2_3 [b] = false := by decide
example : ledgerAdmitted m1_1_2_3 [a,b] = false := by decide
def m1_2_0_0 : Model := ⟨system,[c],[b],0,0,["d"]⟩
example : ledgerAdmitted m1_2_0_0 [] = true := by decide
example : ledgerAdmitted m1_2_0_0 [a] = false := by decide
example : ledgerAdmitted m1_2_0_0 [b] = false := by decide
example : ledgerAdmitted m1_2_0_0 [a,b] = false := by decide
def m1_2_0_1 : Model := ⟨system,[c],[b],0,1,["d"]⟩
example : ledgerAdmitted m1_2_0_1 [] = true := by decide
example : ledgerAdmitted m1_2_0_1 [a] = false := by decide
example : ledgerAdmitted m1_2_0_1 [b] = false := by decide
example : ledgerAdmitted m1_2_0_1 [a,b] = false := by decide
def m1_2_0_2 : Model := ⟨system,[c],[b],0,2,["d"]⟩
example : ledgerAdmitted m1_2_0_2 [] = true := by decide
example : ledgerAdmitted m1_2_0_2 [a] = false := by decide
example : ledgerAdmitted m1_2_0_2 [b] = false := by decide
example : ledgerAdmitted m1_2_0_2 [a,b] = false := by decide
def m1_2_0_3 : Model := ⟨system,[c],[b],0,3,["d"]⟩
example : ledgerAdmitted m1_2_0_3 [] = true := by decide
example : ledgerAdmitted m1_2_0_3 [a] = false := by decide
example : ledgerAdmitted m1_2_0_3 [b] = false := by decide
example : ledgerAdmitted m1_2_0_3 [a,b] = false := by decide
def m1_2_1_0 : Model := ⟨system,[c],[b],1,0,["d"]⟩
example : ledgerAdmitted m1_2_1_0 [] = true := by decide
example : ledgerAdmitted m1_2_1_0 [a] = false := by decide
example : ledgerAdmitted m1_2_1_0 [b] = false := by decide
example : ledgerAdmitted m1_2_1_0 [a,b] = false := by decide
def m1_2_1_1 : Model := ⟨system,[c],[b],1,1,["d"]⟩
example : ledgerAdmitted m1_2_1_1 [] = true := by decide
example : ledgerAdmitted m1_2_1_1 [a] = false := by decide
example : ledgerAdmitted m1_2_1_1 [b] = false := by decide
example : ledgerAdmitted m1_2_1_1 [a,b] = false := by decide
def m1_2_1_2 : Model := ⟨system,[c],[b],1,2,["d"]⟩
example : ledgerAdmitted m1_2_1_2 [] = true := by decide
example : ledgerAdmitted m1_2_1_2 [a] = false := by decide
example : ledgerAdmitted m1_2_1_2 [b] = false := by decide
example : ledgerAdmitted m1_2_1_2 [a,b] = false := by decide
def m1_2_1_3 : Model := ⟨system,[c],[b],1,3,["d"]⟩
example : ledgerAdmitted m1_2_1_3 [] = true := by decide
example : ledgerAdmitted m1_2_1_3 [a] = false := by decide
example : ledgerAdmitted m1_2_1_3 [b] = false := by decide
example : ledgerAdmitted m1_2_1_3 [a,b] = false := by decide
def m1_2_2_0 : Model := ⟨system,[c],[b],2,0,["d"]⟩
example : ledgerAdmitted m1_2_2_0 [] = true := by decide
example : ledgerAdmitted m1_2_2_0 [a] = false := by decide
example : ledgerAdmitted m1_2_2_0 [b] = false := by decide
example : ledgerAdmitted m1_2_2_0 [a,b] = false := by decide
def m1_2_2_1 : Model := ⟨system,[c],[b],2,1,["d"]⟩
example : ledgerAdmitted m1_2_2_1 [] = true := by decide
example : ledgerAdmitted m1_2_2_1 [a] = false := by decide
example : ledgerAdmitted m1_2_2_1 [b] = false := by decide
example : ledgerAdmitted m1_2_2_1 [a,b] = false := by decide
def m1_2_2_2 : Model := ⟨system,[c],[b],2,2,["d"]⟩
example : ledgerAdmitted m1_2_2_2 [] = true := by decide
example : ledgerAdmitted m1_2_2_2 [a] = false := by decide
example : ledgerAdmitted m1_2_2_2 [b] = false := by decide
example : ledgerAdmitted m1_2_2_2 [a,b] = false := by decide
def m1_2_2_3 : Model := ⟨system,[c],[b],2,3,["d"]⟩
example : ledgerAdmitted m1_2_2_3 [] = true := by decide
example : ledgerAdmitted m1_2_2_3 [a] = false := by decide
example : ledgerAdmitted m1_2_2_3 [b] = false := by decide
example : ledgerAdmitted m1_2_2_3 [a,b] = false := by decide
def m1_3_0_0 : Model := ⟨system,[c],[a,b],0,0,["d"]⟩
example : ledgerAdmitted m1_3_0_0 [] = true := by decide
example : ledgerAdmitted m1_3_0_0 [a] = false := by decide
example : ledgerAdmitted m1_3_0_0 [b] = false := by decide
example : ledgerAdmitted m1_3_0_0 [a,b] = false := by decide
def m1_3_0_1 : Model := ⟨system,[c],[a,b],0,1,["d"]⟩
example : ledgerAdmitted m1_3_0_1 [] = true := by decide
example : ledgerAdmitted m1_3_0_1 [a] = false := by decide
example : ledgerAdmitted m1_3_0_1 [b] = false := by decide
example : ledgerAdmitted m1_3_0_1 [a,b] = false := by decide
def m1_3_0_2 : Model := ⟨system,[c],[a,b],0,2,["d"]⟩
example : ledgerAdmitted m1_3_0_2 [] = true := by decide
example : ledgerAdmitted m1_3_0_2 [a] = false := by decide
example : ledgerAdmitted m1_3_0_2 [b] = false := by decide
example : ledgerAdmitted m1_3_0_2 [a,b] = false := by decide
def m1_3_0_3 : Model := ⟨system,[c],[a,b],0,3,["d"]⟩
example : ledgerAdmitted m1_3_0_3 [] = true := by decide
example : ledgerAdmitted m1_3_0_3 [a] = false := by decide
example : ledgerAdmitted m1_3_0_3 [b] = false := by decide
example : ledgerAdmitted m1_3_0_3 [a,b] = false := by decide
def m1_3_1_0 : Model := ⟨system,[c],[a,b],1,0,["d"]⟩
example : ledgerAdmitted m1_3_1_0 [] = true := by decide
example : ledgerAdmitted m1_3_1_0 [a] = false := by decide
example : ledgerAdmitted m1_3_1_0 [b] = false := by decide
example : ledgerAdmitted m1_3_1_0 [a,b] = false := by decide
def m1_3_1_1 : Model := ⟨system,[c],[a,b],1,1,["d"]⟩
example : ledgerAdmitted m1_3_1_1 [] = true := by decide
example : ledgerAdmitted m1_3_1_1 [a] = true := by decide
example : ledgerAdmitted m1_3_1_1 [b] = false := by decide
example : ledgerAdmitted m1_3_1_1 [a,b] = false := by decide
def m1_3_1_2 : Model := ⟨system,[c],[a,b],1,2,["d"]⟩
example : ledgerAdmitted m1_3_1_2 [] = true := by decide
example : ledgerAdmitted m1_3_1_2 [a] = true := by decide
example : ledgerAdmitted m1_3_1_2 [b] = false := by decide
example : ledgerAdmitted m1_3_1_2 [a,b] = false := by decide
def m1_3_1_3 : Model := ⟨system,[c],[a,b],1,3,["d"]⟩
example : ledgerAdmitted m1_3_1_3 [] = true := by decide
example : ledgerAdmitted m1_3_1_3 [a] = true := by decide
example : ledgerAdmitted m1_3_1_3 [b] = false := by decide
example : ledgerAdmitted m1_3_1_3 [a,b] = false := by decide
def m1_3_2_0 : Model := ⟨system,[c],[a,b],2,0,["d"]⟩
example : ledgerAdmitted m1_3_2_0 [] = true := by decide
example : ledgerAdmitted m1_3_2_0 [a] = false := by decide
example : ledgerAdmitted m1_3_2_0 [b] = false := by decide
example : ledgerAdmitted m1_3_2_0 [a,b] = false := by decide
def m1_3_2_1 : Model := ⟨system,[c],[a,b],2,1,["d"]⟩
example : ledgerAdmitted m1_3_2_1 [] = true := by decide
example : ledgerAdmitted m1_3_2_1 [a] = true := by decide
example : ledgerAdmitted m1_3_2_1 [b] = false := by decide
example : ledgerAdmitted m1_3_2_1 [a,b] = false := by decide
def m1_3_2_2 : Model := ⟨system,[c],[a,b],2,2,["d"]⟩
example : ledgerAdmitted m1_3_2_2 [] = true := by decide
example : ledgerAdmitted m1_3_2_2 [a] = true := by decide
example : ledgerAdmitted m1_3_2_2 [b] = false := by decide
example : ledgerAdmitted m1_3_2_2 [a,b] = false := by decide
def m1_3_2_3 : Model := ⟨system,[c],[a,b],2,3,["d"]⟩
example : ledgerAdmitted m1_3_2_3 [] = true := by decide
example : ledgerAdmitted m1_3_2_3 [a] = true := by decide
example : ledgerAdmitted m1_3_2_3 [b] = false := by decide
example : ledgerAdmitted m1_3_2_3 [a,b] = false := by decide
def m2_0_0_0 : Model := ⟨system,[q],[],0,0,["d"]⟩
example : ledgerAdmitted m2_0_0_0 [] = true := by decide
example : ledgerAdmitted m2_0_0_0 [a] = false := by decide
example : ledgerAdmitted m2_0_0_0 [b] = false := by decide
example : ledgerAdmitted m2_0_0_0 [a,b] = false := by decide
def m2_0_0_1 : Model := ⟨system,[q],[],0,1,["d"]⟩
example : ledgerAdmitted m2_0_0_1 [] = true := by decide
example : ledgerAdmitted m2_0_0_1 [a] = false := by decide
example : ledgerAdmitted m2_0_0_1 [b] = false := by decide
example : ledgerAdmitted m2_0_0_1 [a,b] = false := by decide
def m2_0_0_2 : Model := ⟨system,[q],[],0,2,["d"]⟩
example : ledgerAdmitted m2_0_0_2 [] = true := by decide
example : ledgerAdmitted m2_0_0_2 [a] = false := by decide
example : ledgerAdmitted m2_0_0_2 [b] = false := by decide
example : ledgerAdmitted m2_0_0_2 [a,b] = false := by decide
def m2_0_0_3 : Model := ⟨system,[q],[],0,3,["d"]⟩
example : ledgerAdmitted m2_0_0_3 [] = true := by decide
example : ledgerAdmitted m2_0_0_3 [a] = false := by decide
example : ledgerAdmitted m2_0_0_3 [b] = false := by decide
example : ledgerAdmitted m2_0_0_3 [a,b] = false := by decide
def m2_0_1_0 : Model := ⟨system,[q],[],1,0,["d"]⟩
example : ledgerAdmitted m2_0_1_0 [] = true := by decide
example : ledgerAdmitted m2_0_1_0 [a] = false := by decide
example : ledgerAdmitted m2_0_1_0 [b] = false := by decide
example : ledgerAdmitted m2_0_1_0 [a,b] = false := by decide
def m2_0_1_1 : Model := ⟨system,[q],[],1,1,["d"]⟩
example : ledgerAdmitted m2_0_1_1 [] = true := by decide
example : ledgerAdmitted m2_0_1_1 [a] = false := by decide
example : ledgerAdmitted m2_0_1_1 [b] = false := by decide
example : ledgerAdmitted m2_0_1_1 [a,b] = false := by decide
def m2_0_1_2 : Model := ⟨system,[q],[],1,2,["d"]⟩
example : ledgerAdmitted m2_0_1_2 [] = true := by decide
example : ledgerAdmitted m2_0_1_2 [a] = false := by decide
example : ledgerAdmitted m2_0_1_2 [b] = false := by decide
example : ledgerAdmitted m2_0_1_2 [a,b] = false := by decide
def m2_0_1_3 : Model := ⟨system,[q],[],1,3,["d"]⟩
example : ledgerAdmitted m2_0_1_3 [] = true := by decide
example : ledgerAdmitted m2_0_1_3 [a] = false := by decide
example : ledgerAdmitted m2_0_1_3 [b] = false := by decide
example : ledgerAdmitted m2_0_1_3 [a,b] = false := by decide
def m2_0_2_0 : Model := ⟨system,[q],[],2,0,["d"]⟩
example : ledgerAdmitted m2_0_2_0 [] = true := by decide
example : ledgerAdmitted m2_0_2_0 [a] = false := by decide
example : ledgerAdmitted m2_0_2_0 [b] = false := by decide
example : ledgerAdmitted m2_0_2_0 [a,b] = false := by decide
def m2_0_2_1 : Model := ⟨system,[q],[],2,1,["d"]⟩
example : ledgerAdmitted m2_0_2_1 [] = true := by decide
example : ledgerAdmitted m2_0_2_1 [a] = false := by decide
example : ledgerAdmitted m2_0_2_1 [b] = false := by decide
example : ledgerAdmitted m2_0_2_1 [a,b] = false := by decide
def m2_0_2_2 : Model := ⟨system,[q],[],2,2,["d"]⟩
example : ledgerAdmitted m2_0_2_2 [] = true := by decide
example : ledgerAdmitted m2_0_2_2 [a] = false := by decide
example : ledgerAdmitted m2_0_2_2 [b] = false := by decide
example : ledgerAdmitted m2_0_2_2 [a,b] = false := by decide
def m2_0_2_3 : Model := ⟨system,[q],[],2,3,["d"]⟩
example : ledgerAdmitted m2_0_2_3 [] = true := by decide
example : ledgerAdmitted m2_0_2_3 [a] = false := by decide
example : ledgerAdmitted m2_0_2_3 [b] = false := by decide
example : ledgerAdmitted m2_0_2_3 [a,b] = false := by decide
def m2_1_0_0 : Model := ⟨system,[q],[a],0,0,["d"]⟩
example : ledgerAdmitted m2_1_0_0 [] = true := by decide
example : ledgerAdmitted m2_1_0_0 [a] = false := by decide
example : ledgerAdmitted m2_1_0_0 [b] = false := by decide
example : ledgerAdmitted m2_1_0_0 [a,b] = false := by decide
def m2_1_0_1 : Model := ⟨system,[q],[a],0,1,["d"]⟩
example : ledgerAdmitted m2_1_0_1 [] = true := by decide
example : ledgerAdmitted m2_1_0_1 [a] = false := by decide
example : ledgerAdmitted m2_1_0_1 [b] = false := by decide
example : ledgerAdmitted m2_1_0_1 [a,b] = false := by decide
def m2_1_0_2 : Model := ⟨system,[q],[a],0,2,["d"]⟩
example : ledgerAdmitted m2_1_0_2 [] = true := by decide
example : ledgerAdmitted m2_1_0_2 [a] = false := by decide
example : ledgerAdmitted m2_1_0_2 [b] = false := by decide
example : ledgerAdmitted m2_1_0_2 [a,b] = false := by decide
def m2_1_0_3 : Model := ⟨system,[q],[a],0,3,["d"]⟩
example : ledgerAdmitted m2_1_0_3 [] = true := by decide
example : ledgerAdmitted m2_1_0_3 [a] = false := by decide
example : ledgerAdmitted m2_1_0_3 [b] = false := by decide
example : ledgerAdmitted m2_1_0_3 [a,b] = false := by decide
def m2_1_1_0 : Model := ⟨system,[q],[a],1,0,["d"]⟩
example : ledgerAdmitted m2_1_1_0 [] = true := by decide
example : ledgerAdmitted m2_1_1_0 [a] = false := by decide
example : ledgerAdmitted m2_1_1_0 [b] = false := by decide
example : ledgerAdmitted m2_1_1_0 [a,b] = false := by decide
def m2_1_1_1 : Model := ⟨system,[q],[a],1,1,["d"]⟩
example : ledgerAdmitted m2_1_1_1 [] = true := by decide
example : ledgerAdmitted m2_1_1_1 [a] = false := by decide
example : ledgerAdmitted m2_1_1_1 [b] = false := by decide
example : ledgerAdmitted m2_1_1_1 [a,b] = false := by decide
def m2_1_1_2 : Model := ⟨system,[q],[a],1,2,["d"]⟩
example : ledgerAdmitted m2_1_1_2 [] = true := by decide
example : ledgerAdmitted m2_1_1_2 [a] = false := by decide
example : ledgerAdmitted m2_1_1_2 [b] = false := by decide
example : ledgerAdmitted m2_1_1_2 [a,b] = false := by decide
def m2_1_1_3 : Model := ⟨system,[q],[a],1,3,["d"]⟩
example : ledgerAdmitted m2_1_1_3 [] = true := by decide
example : ledgerAdmitted m2_1_1_3 [a] = false := by decide
example : ledgerAdmitted m2_1_1_3 [b] = false := by decide
example : ledgerAdmitted m2_1_1_3 [a,b] = false := by decide
def m2_1_2_0 : Model := ⟨system,[q],[a],2,0,["d"]⟩
example : ledgerAdmitted m2_1_2_0 [] = true := by decide
example : ledgerAdmitted m2_1_2_0 [a] = false := by decide
example : ledgerAdmitted m2_1_2_0 [b] = false := by decide
example : ledgerAdmitted m2_1_2_0 [a,b] = false := by decide
def m2_1_2_1 : Model := ⟨system,[q],[a],2,1,["d"]⟩
example : ledgerAdmitted m2_1_2_1 [] = true := by decide
example : ledgerAdmitted m2_1_2_1 [a] = false := by decide
example : ledgerAdmitted m2_1_2_1 [b] = false := by decide
example : ledgerAdmitted m2_1_2_1 [a,b] = false := by decide
def m2_1_2_2 : Model := ⟨system,[q],[a],2,2,["d"]⟩
example : ledgerAdmitted m2_1_2_2 [] = true := by decide
example : ledgerAdmitted m2_1_2_2 [a] = false := by decide
example : ledgerAdmitted m2_1_2_2 [b] = false := by decide
example : ledgerAdmitted m2_1_2_2 [a,b] = false := by decide
def m2_1_2_3 : Model := ⟨system,[q],[a],2,3,["d"]⟩
example : ledgerAdmitted m2_1_2_3 [] = true := by decide
example : ledgerAdmitted m2_1_2_3 [a] = false := by decide
example : ledgerAdmitted m2_1_2_3 [b] = false := by decide
example : ledgerAdmitted m2_1_2_3 [a,b] = false := by decide
def m2_2_0_0 : Model := ⟨system,[q],[b],0,0,["d"]⟩
example : ledgerAdmitted m2_2_0_0 [] = true := by decide
example : ledgerAdmitted m2_2_0_0 [a] = false := by decide
example : ledgerAdmitted m2_2_0_0 [b] = false := by decide
example : ledgerAdmitted m2_2_0_0 [a,b] = false := by decide
def m2_2_0_1 : Model := ⟨system,[q],[b],0,1,["d"]⟩
example : ledgerAdmitted m2_2_0_1 [] = true := by decide
example : ledgerAdmitted m2_2_0_1 [a] = false := by decide
example : ledgerAdmitted m2_2_0_1 [b] = false := by decide
example : ledgerAdmitted m2_2_0_1 [a,b] = false := by decide
def m2_2_0_2 : Model := ⟨system,[q],[b],0,2,["d"]⟩
example : ledgerAdmitted m2_2_0_2 [] = true := by decide
example : ledgerAdmitted m2_2_0_2 [a] = false := by decide
example : ledgerAdmitted m2_2_0_2 [b] = false := by decide
example : ledgerAdmitted m2_2_0_2 [a,b] = false := by decide
def m2_2_0_3 : Model := ⟨system,[q],[b],0,3,["d"]⟩
example : ledgerAdmitted m2_2_0_3 [] = true := by decide
example : ledgerAdmitted m2_2_0_3 [a] = false := by decide
example : ledgerAdmitted m2_2_0_3 [b] = false := by decide
example : ledgerAdmitted m2_2_0_3 [a,b] = false := by decide
def m2_2_1_0 : Model := ⟨system,[q],[b],1,0,["d"]⟩
example : ledgerAdmitted m2_2_1_0 [] = true := by decide
example : ledgerAdmitted m2_2_1_0 [a] = false := by decide
example : ledgerAdmitted m2_2_1_0 [b] = false := by decide
example : ledgerAdmitted m2_2_1_0 [a,b] = false := by decide
def m2_2_1_1 : Model := ⟨system,[q],[b],1,1,["d"]⟩
example : ledgerAdmitted m2_2_1_1 [] = true := by decide
example : ledgerAdmitted m2_2_1_1 [a] = false := by decide
example : ledgerAdmitted m2_2_1_1 [b] = false := by decide
example : ledgerAdmitted m2_2_1_1 [a,b] = false := by decide
def m2_2_1_2 : Model := ⟨system,[q],[b],1,2,["d"]⟩
example : ledgerAdmitted m2_2_1_2 [] = true := by decide
example : ledgerAdmitted m2_2_1_2 [a] = false := by decide
example : ledgerAdmitted m2_2_1_2 [b] = true := by decide
example : ledgerAdmitted m2_2_1_2 [a,b] = false := by decide
def m2_2_1_3 : Model := ⟨system,[q],[b],1,3,["d"]⟩
example : ledgerAdmitted m2_2_1_3 [] = true := by decide
example : ledgerAdmitted m2_2_1_3 [a] = false := by decide
example : ledgerAdmitted m2_2_1_3 [b] = true := by decide
example : ledgerAdmitted m2_2_1_3 [a,b] = false := by decide
def m2_2_2_0 : Model := ⟨system,[q],[b],2,0,["d"]⟩
example : ledgerAdmitted m2_2_2_0 [] = true := by decide
example : ledgerAdmitted m2_2_2_0 [a] = false := by decide
example : ledgerAdmitted m2_2_2_0 [b] = false := by decide
example : ledgerAdmitted m2_2_2_0 [a,b] = false := by decide
def m2_2_2_1 : Model := ⟨system,[q],[b],2,1,["d"]⟩
example : ledgerAdmitted m2_2_2_1 [] = true := by decide
example : ledgerAdmitted m2_2_2_1 [a] = false := by decide
example : ledgerAdmitted m2_2_2_1 [b] = false := by decide
example : ledgerAdmitted m2_2_2_1 [a,b] = false := by decide
def m2_2_2_2 : Model := ⟨system,[q],[b],2,2,["d"]⟩
example : ledgerAdmitted m2_2_2_2 [] = true := by decide
example : ledgerAdmitted m2_2_2_2 [a] = false := by decide
example : ledgerAdmitted m2_2_2_2 [b] = true := by decide
example : ledgerAdmitted m2_2_2_2 [a,b] = false := by decide
def m2_2_2_3 : Model := ⟨system,[q],[b],2,3,["d"]⟩
example : ledgerAdmitted m2_2_2_3 [] = true := by decide
example : ledgerAdmitted m2_2_2_3 [a] = false := by decide
example : ledgerAdmitted m2_2_2_3 [b] = true := by decide
example : ledgerAdmitted m2_2_2_3 [a,b] = false := by decide
def m2_3_0_0 : Model := ⟨system,[q],[a,b],0,0,["d"]⟩
example : ledgerAdmitted m2_3_0_0 [] = true := by decide
example : ledgerAdmitted m2_3_0_0 [a] = false := by decide
example : ledgerAdmitted m2_3_0_0 [b] = false := by decide
example : ledgerAdmitted m2_3_0_0 [a,b] = false := by decide
def m2_3_0_1 : Model := ⟨system,[q],[a,b],0,1,["d"]⟩
example : ledgerAdmitted m2_3_0_1 [] = true := by decide
example : ledgerAdmitted m2_3_0_1 [a] = false := by decide
example : ledgerAdmitted m2_3_0_1 [b] = false := by decide
example : ledgerAdmitted m2_3_0_1 [a,b] = false := by decide
def m2_3_0_2 : Model := ⟨system,[q],[a,b],0,2,["d"]⟩
example : ledgerAdmitted m2_3_0_2 [] = true := by decide
example : ledgerAdmitted m2_3_0_2 [a] = false := by decide
example : ledgerAdmitted m2_3_0_2 [b] = false := by decide
example : ledgerAdmitted m2_3_0_2 [a,b] = false := by decide
def m2_3_0_3 : Model := ⟨system,[q],[a,b],0,3,["d"]⟩
example : ledgerAdmitted m2_3_0_3 [] = true := by decide
example : ledgerAdmitted m2_3_0_3 [a] = false := by decide
example : ledgerAdmitted m2_3_0_3 [b] = false := by decide
example : ledgerAdmitted m2_3_0_3 [a,b] = false := by decide
def m2_3_1_0 : Model := ⟨system,[q],[a,b],1,0,["d"]⟩
example : ledgerAdmitted m2_3_1_0 [] = true := by decide
example : ledgerAdmitted m2_3_1_0 [a] = false := by decide
example : ledgerAdmitted m2_3_1_0 [b] = false := by decide
example : ledgerAdmitted m2_3_1_0 [a,b] = false := by decide
def m2_3_1_1 : Model := ⟨system,[q],[a,b],1,1,["d"]⟩
example : ledgerAdmitted m2_3_1_1 [] = true := by decide
example : ledgerAdmitted m2_3_1_1 [a] = false := by decide
example : ledgerAdmitted m2_3_1_1 [b] = false := by decide
example : ledgerAdmitted m2_3_1_1 [a,b] = false := by decide
def m2_3_1_2 : Model := ⟨system,[q],[a,b],1,2,["d"]⟩
example : ledgerAdmitted m2_3_1_2 [] = true := by decide
example : ledgerAdmitted m2_3_1_2 [a] = false := by decide
example : ledgerAdmitted m2_3_1_2 [b] = true := by decide
example : ledgerAdmitted m2_3_1_2 [a,b] = false := by decide
def m2_3_1_3 : Model := ⟨system,[q],[a,b],1,3,["d"]⟩
example : ledgerAdmitted m2_3_1_3 [] = true := by decide
example : ledgerAdmitted m2_3_1_3 [a] = false := by decide
example : ledgerAdmitted m2_3_1_3 [b] = true := by decide
example : ledgerAdmitted m2_3_1_3 [a,b] = false := by decide
def m2_3_2_0 : Model := ⟨system,[q],[a,b],2,0,["d"]⟩
example : ledgerAdmitted m2_3_2_0 [] = true := by decide
example : ledgerAdmitted m2_3_2_0 [a] = false := by decide
example : ledgerAdmitted m2_3_2_0 [b] = false := by decide
example : ledgerAdmitted m2_3_2_0 [a,b] = false := by decide
def m2_3_2_1 : Model := ⟨system,[q],[a,b],2,1,["d"]⟩
example : ledgerAdmitted m2_3_2_1 [] = true := by decide
example : ledgerAdmitted m2_3_2_1 [a] = false := by decide
example : ledgerAdmitted m2_3_2_1 [b] = false := by decide
example : ledgerAdmitted m2_3_2_1 [a,b] = false := by decide
def m2_3_2_2 : Model := ⟨system,[q],[a,b],2,2,["d"]⟩
example : ledgerAdmitted m2_3_2_2 [] = true := by decide
example : ledgerAdmitted m2_3_2_2 [a] = false := by decide
example : ledgerAdmitted m2_3_2_2 [b] = true := by decide
example : ledgerAdmitted m2_3_2_2 [a,b] = false := by decide
def m2_3_2_3 : Model := ⟨system,[q],[a,b],2,3,["d"]⟩
example : ledgerAdmitted m2_3_2_3 [] = true := by decide
example : ledgerAdmitted m2_3_2_3 [a] = false := by decide
example : ledgerAdmitted m2_3_2_3 [b] = true := by decide
example : ledgerAdmitted m2_3_2_3 [a,b] = false := by decide
def m3_0_0_0 : Model := ⟨system,[c,q],[],0,0,["d"]⟩
example : ledgerAdmitted m3_0_0_0 [] = true := by decide
example : ledgerAdmitted m3_0_0_0 [a] = false := by decide
example : ledgerAdmitted m3_0_0_0 [b] = false := by decide
example : ledgerAdmitted m3_0_0_0 [a,b] = false := by decide
def m3_0_0_1 : Model := ⟨system,[c,q],[],0,1,["d"]⟩
example : ledgerAdmitted m3_0_0_1 [] = true := by decide
example : ledgerAdmitted m3_0_0_1 [a] = false := by decide
example : ledgerAdmitted m3_0_0_1 [b] = false := by decide
example : ledgerAdmitted m3_0_0_1 [a,b] = false := by decide
def m3_0_0_2 : Model := ⟨system,[c,q],[],0,2,["d"]⟩
example : ledgerAdmitted m3_0_0_2 [] = true := by decide
example : ledgerAdmitted m3_0_0_2 [a] = false := by decide
example : ledgerAdmitted m3_0_0_2 [b] = false := by decide
example : ledgerAdmitted m3_0_0_2 [a,b] = false := by decide
def m3_0_0_3 : Model := ⟨system,[c,q],[],0,3,["d"]⟩
example : ledgerAdmitted m3_0_0_3 [] = true := by decide
example : ledgerAdmitted m3_0_0_3 [a] = false := by decide
example : ledgerAdmitted m3_0_0_3 [b] = false := by decide
example : ledgerAdmitted m3_0_0_3 [a,b] = false := by decide
def m3_0_1_0 : Model := ⟨system,[c,q],[],1,0,["d"]⟩
example : ledgerAdmitted m3_0_1_0 [] = true := by decide
example : ledgerAdmitted m3_0_1_0 [a] = false := by decide
example : ledgerAdmitted m3_0_1_0 [b] = false := by decide
example : ledgerAdmitted m3_0_1_0 [a,b] = false := by decide
def m3_0_1_1 : Model := ⟨system,[c,q],[],1,1,["d"]⟩
example : ledgerAdmitted m3_0_1_1 [] = true := by decide
example : ledgerAdmitted m3_0_1_1 [a] = false := by decide
example : ledgerAdmitted m3_0_1_1 [b] = false := by decide
example : ledgerAdmitted m3_0_1_1 [a,b] = false := by decide
def m3_0_1_2 : Model := ⟨system,[c,q],[],1,2,["d"]⟩
example : ledgerAdmitted m3_0_1_2 [] = true := by decide
example : ledgerAdmitted m3_0_1_2 [a] = false := by decide
example : ledgerAdmitted m3_0_1_2 [b] = false := by decide
example : ledgerAdmitted m3_0_1_2 [a,b] = false := by decide
def m3_0_1_3 : Model := ⟨system,[c,q],[],1,3,["d"]⟩
example : ledgerAdmitted m3_0_1_3 [] = true := by decide
example : ledgerAdmitted m3_0_1_3 [a] = false := by decide
example : ledgerAdmitted m3_0_1_3 [b] = false := by decide
example : ledgerAdmitted m3_0_1_3 [a,b] = false := by decide
def m3_0_2_0 : Model := ⟨system,[c,q],[],2,0,["d"]⟩
example : ledgerAdmitted m3_0_2_0 [] = true := by decide
example : ledgerAdmitted m3_0_2_0 [a] = false := by decide
example : ledgerAdmitted m3_0_2_0 [b] = false := by decide
example : ledgerAdmitted m3_0_2_0 [a,b] = false := by decide
def m3_0_2_1 : Model := ⟨system,[c,q],[],2,1,["d"]⟩
example : ledgerAdmitted m3_0_2_1 [] = true := by decide
example : ledgerAdmitted m3_0_2_1 [a] = false := by decide
example : ledgerAdmitted m3_0_2_1 [b] = false := by decide
example : ledgerAdmitted m3_0_2_1 [a,b] = false := by decide
def m3_0_2_2 : Model := ⟨system,[c,q],[],2,2,["d"]⟩
example : ledgerAdmitted m3_0_2_2 [] = true := by decide
example : ledgerAdmitted m3_0_2_2 [a] = false := by decide
example : ledgerAdmitted m3_0_2_2 [b] = false := by decide
example : ledgerAdmitted m3_0_2_2 [a,b] = false := by decide
def m3_0_2_3 : Model := ⟨system,[c,q],[],2,3,["d"]⟩
example : ledgerAdmitted m3_0_2_3 [] = true := by decide
example : ledgerAdmitted m3_0_2_3 [a] = false := by decide
example : ledgerAdmitted m3_0_2_3 [b] = false := by decide
example : ledgerAdmitted m3_0_2_3 [a,b] = false := by decide
def m3_1_0_0 : Model := ⟨system,[c,q],[a],0,0,["d"]⟩
example : ledgerAdmitted m3_1_0_0 [] = true := by decide
example : ledgerAdmitted m3_1_0_0 [a] = false := by decide
example : ledgerAdmitted m3_1_0_0 [b] = false := by decide
example : ledgerAdmitted m3_1_0_0 [a,b] = false := by decide
def m3_1_0_1 : Model := ⟨system,[c,q],[a],0,1,["d"]⟩
example : ledgerAdmitted m3_1_0_1 [] = true := by decide
example : ledgerAdmitted m3_1_0_1 [a] = false := by decide
example : ledgerAdmitted m3_1_0_1 [b] = false := by decide
example : ledgerAdmitted m3_1_0_1 [a,b] = false := by decide
def m3_1_0_2 : Model := ⟨system,[c,q],[a],0,2,["d"]⟩
example : ledgerAdmitted m3_1_0_2 [] = true := by decide
example : ledgerAdmitted m3_1_0_2 [a] = false := by decide
example : ledgerAdmitted m3_1_0_2 [b] = false := by decide
example : ledgerAdmitted m3_1_0_2 [a,b] = false := by decide
def m3_1_0_3 : Model := ⟨system,[c,q],[a],0,3,["d"]⟩
example : ledgerAdmitted m3_1_0_3 [] = true := by decide
example : ledgerAdmitted m3_1_0_3 [a] = false := by decide
example : ledgerAdmitted m3_1_0_3 [b] = false := by decide
example : ledgerAdmitted m3_1_0_3 [a,b] = false := by decide
def m3_1_1_0 : Model := ⟨system,[c,q],[a],1,0,["d"]⟩
example : ledgerAdmitted m3_1_1_0 [] = true := by decide
example : ledgerAdmitted m3_1_1_0 [a] = false := by decide
example : ledgerAdmitted m3_1_1_0 [b] = false := by decide
example : ledgerAdmitted m3_1_1_0 [a,b] = false := by decide
def m3_1_1_1 : Model := ⟨system,[c,q],[a],1,1,["d"]⟩
example : ledgerAdmitted m3_1_1_1 [] = true := by decide
example : ledgerAdmitted m3_1_1_1 [a] = true := by decide
example : ledgerAdmitted m3_1_1_1 [b] = false := by decide
example : ledgerAdmitted m3_1_1_1 [a,b] = false := by decide
def m3_1_1_2 : Model := ⟨system,[c,q],[a],1,2,["d"]⟩
example : ledgerAdmitted m3_1_1_2 [] = true := by decide
example : ledgerAdmitted m3_1_1_2 [a] = true := by decide
example : ledgerAdmitted m3_1_1_2 [b] = false := by decide
example : ledgerAdmitted m3_1_1_2 [a,b] = false := by decide
def m3_1_1_3 : Model := ⟨system,[c,q],[a],1,3,["d"]⟩
example : ledgerAdmitted m3_1_1_3 [] = true := by decide
example : ledgerAdmitted m3_1_1_3 [a] = true := by decide
example : ledgerAdmitted m3_1_1_3 [b] = false := by decide
example : ledgerAdmitted m3_1_1_3 [a,b] = false := by decide
def m3_1_2_0 : Model := ⟨system,[c,q],[a],2,0,["d"]⟩
example : ledgerAdmitted m3_1_2_0 [] = true := by decide
example : ledgerAdmitted m3_1_2_0 [a] = false := by decide
example : ledgerAdmitted m3_1_2_0 [b] = false := by decide
example : ledgerAdmitted m3_1_2_0 [a,b] = false := by decide
def m3_1_2_1 : Model := ⟨system,[c,q],[a],2,1,["d"]⟩
example : ledgerAdmitted m3_1_2_1 [] = true := by decide
example : ledgerAdmitted m3_1_2_1 [a] = true := by decide
example : ledgerAdmitted m3_1_2_1 [b] = false := by decide
example : ledgerAdmitted m3_1_2_1 [a,b] = false := by decide
def m3_1_2_2 : Model := ⟨system,[c,q],[a],2,2,["d"]⟩
example : ledgerAdmitted m3_1_2_2 [] = true := by decide
example : ledgerAdmitted m3_1_2_2 [a] = true := by decide
example : ledgerAdmitted m3_1_2_2 [b] = false := by decide
example : ledgerAdmitted m3_1_2_2 [a,b] = false := by decide
def m3_1_2_3 : Model := ⟨system,[c,q],[a],2,3,["d"]⟩
example : ledgerAdmitted m3_1_2_3 [] = true := by decide
example : ledgerAdmitted m3_1_2_3 [a] = true := by decide
example : ledgerAdmitted m3_1_2_3 [b] = false := by decide
example : ledgerAdmitted m3_1_2_3 [a,b] = false := by decide
def m3_2_0_0 : Model := ⟨system,[c,q],[b],0,0,["d"]⟩
example : ledgerAdmitted m3_2_0_0 [] = true := by decide
example : ledgerAdmitted m3_2_0_0 [a] = false := by decide
example : ledgerAdmitted m3_2_0_0 [b] = false := by decide
example : ledgerAdmitted m3_2_0_0 [a,b] = false := by decide
def m3_2_0_1 : Model := ⟨system,[c,q],[b],0,1,["d"]⟩
example : ledgerAdmitted m3_2_0_1 [] = true := by decide
example : ledgerAdmitted m3_2_0_1 [a] = false := by decide
example : ledgerAdmitted m3_2_0_1 [b] = false := by decide
example : ledgerAdmitted m3_2_0_1 [a,b] = false := by decide
def m3_2_0_2 : Model := ⟨system,[c,q],[b],0,2,["d"]⟩
example : ledgerAdmitted m3_2_0_2 [] = true := by decide
example : ledgerAdmitted m3_2_0_2 [a] = false := by decide
example : ledgerAdmitted m3_2_0_2 [b] = false := by decide
example : ledgerAdmitted m3_2_0_2 [a,b] = false := by decide
def m3_2_0_3 : Model := ⟨system,[c,q],[b],0,3,["d"]⟩
example : ledgerAdmitted m3_2_0_3 [] = true := by decide
example : ledgerAdmitted m3_2_0_3 [a] = false := by decide
example : ledgerAdmitted m3_2_0_3 [b] = false := by decide
example : ledgerAdmitted m3_2_0_3 [a,b] = false := by decide
def m3_2_1_0 : Model := ⟨system,[c,q],[b],1,0,["d"]⟩
example : ledgerAdmitted m3_2_1_0 [] = true := by decide
example : ledgerAdmitted m3_2_1_0 [a] = false := by decide
example : ledgerAdmitted m3_2_1_0 [b] = false := by decide
example : ledgerAdmitted m3_2_1_0 [a,b] = false := by decide
def m3_2_1_1 : Model := ⟨system,[c,q],[b],1,1,["d"]⟩
example : ledgerAdmitted m3_2_1_1 [] = true := by decide
example : ledgerAdmitted m3_2_1_1 [a] = false := by decide
example : ledgerAdmitted m3_2_1_1 [b] = false := by decide
example : ledgerAdmitted m3_2_1_1 [a,b] = false := by decide
def m3_2_1_2 : Model := ⟨system,[c,q],[b],1,2,["d"]⟩
example : ledgerAdmitted m3_2_1_2 [] = true := by decide
example : ledgerAdmitted m3_2_1_2 [a] = false := by decide
example : ledgerAdmitted m3_2_1_2 [b] = true := by decide
example : ledgerAdmitted m3_2_1_2 [a,b] = false := by decide
def m3_2_1_3 : Model := ⟨system,[c,q],[b],1,3,["d"]⟩
example : ledgerAdmitted m3_2_1_3 [] = true := by decide
example : ledgerAdmitted m3_2_1_3 [a] = false := by decide
example : ledgerAdmitted m3_2_1_3 [b] = true := by decide
example : ledgerAdmitted m3_2_1_3 [a,b] = false := by decide
def m3_2_2_0 : Model := ⟨system,[c,q],[b],2,0,["d"]⟩
example : ledgerAdmitted m3_2_2_0 [] = true := by decide
example : ledgerAdmitted m3_2_2_0 [a] = false := by decide
example : ledgerAdmitted m3_2_2_0 [b] = false := by decide
example : ledgerAdmitted m3_2_2_0 [a,b] = false := by decide
def m3_2_2_1 : Model := ⟨system,[c,q],[b],2,1,["d"]⟩
example : ledgerAdmitted m3_2_2_1 [] = true := by decide
example : ledgerAdmitted m3_2_2_1 [a] = false := by decide
example : ledgerAdmitted m3_2_2_1 [b] = false := by decide
example : ledgerAdmitted m3_2_2_1 [a,b] = false := by decide
def m3_2_2_2 : Model := ⟨system,[c,q],[b],2,2,["d"]⟩
example : ledgerAdmitted m3_2_2_2 [] = true := by decide
example : ledgerAdmitted m3_2_2_2 [a] = false := by decide
example : ledgerAdmitted m3_2_2_2 [b] = true := by decide
example : ledgerAdmitted m3_2_2_2 [a,b] = false := by decide
def m3_2_2_3 : Model := ⟨system,[c,q],[b],2,3,["d"]⟩
example : ledgerAdmitted m3_2_2_3 [] = true := by decide
example : ledgerAdmitted m3_2_2_3 [a] = false := by decide
example : ledgerAdmitted m3_2_2_3 [b] = true := by decide
example : ledgerAdmitted m3_2_2_3 [a,b] = false := by decide
def m3_3_0_0 : Model := ⟨system,[c,q],[a,b],0,0,["d"]⟩
example : ledgerAdmitted m3_3_0_0 [] = true := by decide
example : ledgerAdmitted m3_3_0_0 [a] = false := by decide
example : ledgerAdmitted m3_3_0_0 [b] = false := by decide
example : ledgerAdmitted m3_3_0_0 [a,b] = false := by decide
def m3_3_0_1 : Model := ⟨system,[c,q],[a,b],0,1,["d"]⟩
example : ledgerAdmitted m3_3_0_1 [] = true := by decide
example : ledgerAdmitted m3_3_0_1 [a] = false := by decide
example : ledgerAdmitted m3_3_0_1 [b] = false := by decide
example : ledgerAdmitted m3_3_0_1 [a,b] = false := by decide
def m3_3_0_2 : Model := ⟨system,[c,q],[a,b],0,2,["d"]⟩
example : ledgerAdmitted m3_3_0_2 [] = true := by decide
example : ledgerAdmitted m3_3_0_2 [a] = false := by decide
example : ledgerAdmitted m3_3_0_2 [b] = false := by decide
example : ledgerAdmitted m3_3_0_2 [a,b] = false := by decide
def m3_3_0_3 : Model := ⟨system,[c,q],[a,b],0,3,["d"]⟩
example : ledgerAdmitted m3_3_0_3 [] = true := by decide
example : ledgerAdmitted m3_3_0_3 [a] = false := by decide
example : ledgerAdmitted m3_3_0_3 [b] = false := by decide
example : ledgerAdmitted m3_3_0_3 [a,b] = false := by decide
def m3_3_1_0 : Model := ⟨system,[c,q],[a,b],1,0,["d"]⟩
example : ledgerAdmitted m3_3_1_0 [] = true := by decide
example : ledgerAdmitted m3_3_1_0 [a] = false := by decide
example : ledgerAdmitted m3_3_1_0 [b] = false := by decide
example : ledgerAdmitted m3_3_1_0 [a,b] = false := by decide
def m3_3_1_1 : Model := ⟨system,[c,q],[a,b],1,1,["d"]⟩
example : ledgerAdmitted m3_3_1_1 [] = true := by decide
example : ledgerAdmitted m3_3_1_1 [a] = true := by decide
example : ledgerAdmitted m3_3_1_1 [b] = false := by decide
example : ledgerAdmitted m3_3_1_1 [a,b] = false := by decide
def m3_3_1_2 : Model := ⟨system,[c,q],[a,b],1,2,["d"]⟩
example : ledgerAdmitted m3_3_1_2 [] = true := by decide
example : ledgerAdmitted m3_3_1_2 [a] = true := by decide
example : ledgerAdmitted m3_3_1_2 [b] = true := by decide
example : ledgerAdmitted m3_3_1_2 [a,b] = false := by decide
def m3_3_1_3 : Model := ⟨system,[c,q],[a,b],1,3,["d"]⟩
example : ledgerAdmitted m3_3_1_3 [] = true := by decide
example : ledgerAdmitted m3_3_1_3 [a] = true := by decide
example : ledgerAdmitted m3_3_1_3 [b] = true := by decide
example : ledgerAdmitted m3_3_1_3 [a,b] = false := by decide
def m3_3_2_0 : Model := ⟨system,[c,q],[a,b],2,0,["d"]⟩
example : ledgerAdmitted m3_3_2_0 [] = true := by decide
example : ledgerAdmitted m3_3_2_0 [a] = false := by decide
example : ledgerAdmitted m3_3_2_0 [b] = false := by decide
example : ledgerAdmitted m3_3_2_0 [a,b] = false := by decide
def m3_3_2_1 : Model := ⟨system,[c,q],[a,b],2,1,["d"]⟩
example : ledgerAdmitted m3_3_2_1 [] = true := by decide
example : ledgerAdmitted m3_3_2_1 [a] = true := by decide
example : ledgerAdmitted m3_3_2_1 [b] = false := by decide
example : ledgerAdmitted m3_3_2_1 [a,b] = false := by decide
def m3_3_2_2 : Model := ⟨system,[c,q],[a,b],2,2,["d"]⟩
example : ledgerAdmitted m3_3_2_2 [] = true := by decide
example : ledgerAdmitted m3_3_2_2 [a] = true := by decide
example : ledgerAdmitted m3_3_2_2 [b] = true := by decide
example : ledgerAdmitted m3_3_2_2 [a,b] = false := by decide
def m3_3_2_3 : Model := ⟨system,[c,q],[a,b],2,3,["d"]⟩
example : ledgerAdmitted m3_3_2_3 [] = true := by decide
example : ledgerAdmitted m3_3_2_3 [a] = true := by decide
example : ledgerAdmitted m3_3_2_3 [b] = true := by decide
example : ledgerAdmitted m3_3_2_3 [a,b] = true := by decide
def nativeClassical : ClassicalExecution m3_3_2_3 := ⟨⟨⟨[a],rfl⟩,rfl⟩,"q",["step"],["q","q"],rfl⟩
def nativeDeclaredQuantum : DeclaredLedger m3_3_2_3 := ⟨[b],rfl⟩
theorem quantumDeclarationNotExecution : classical nativeDeclaredQuantum.queries = false := rfl
example : unmetDependencies m3_3_2_3 [] = ["d"] := rfl
example : unmetDependencies m3_3_2_3 ["d"] = [] := rfl
#print axioms nativeClassical
#print axioms nativeDeclaredQuantum
#print axioms quantumDeclarationNotExecution
end SFT.Computation.PostQuantumBoundary
