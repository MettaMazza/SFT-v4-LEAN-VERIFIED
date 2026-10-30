import SFT.Computation.Adversarial
namespace SFT.Computation.Adversarial
def system : StateTransition.System := ⟨["q","good","bad"],["g","b"],[("q","g","good"),("q","b","bad")]⟩
def a : Schedule := ⟨"a","q",["g"],["q","good"],"good"⟩
def b : Schedule := ⟨"b","q",["b"],["q","bad"],"bad"⟩
def c : Schedule := ⟨"a","q",[],["q"],"q"⟩
def m0_0_0_0 : Model := ⟨system,[],[],0,[],["good","bad","q"]⟩
example : rows m0_0_0_0 = [] := by decide
example : favorable m0_0_0_0 = [] := by decide
example : unfavorable m0_0_0_0 = [] := by decide
example : secure m0_0_0_0 = true := by decide
def m0_0_0_1 : Model := ⟨system,[],[],0,["good"],["good","bad","q"]⟩
example : rows m0_0_0_1 = [] := by decide
example : favorable m0_0_0_1 = [] := by decide
example : unfavorable m0_0_0_1 = [] := by decide
example : secure m0_0_0_1 = true := by decide
def m0_0_0_2 : Model := ⟨system,[],[],0,["bad"],["good","bad","q"]⟩
example : rows m0_0_0_2 = [] := by decide
example : favorable m0_0_0_2 = [] := by decide
example : unfavorable m0_0_0_2 = [] := by decide
example : secure m0_0_0_2 = true := by decide
def m0_0_0_3 : Model := ⟨system,[],[],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_0_0_3 = [] := by decide
example : favorable m0_0_0_3 = [] := by decide
example : unfavorable m0_0_0_3 = [] := by decide
example : secure m0_0_0_3 = true := by decide
def m0_0_0_4 : Model := ⟨system,[],[],0,["q"],["good","bad","q"]⟩
example : rows m0_0_0_4 = [] := by decide
example : favorable m0_0_0_4 = [] := by decide
example : unfavorable m0_0_0_4 = [] := by decide
example : secure m0_0_0_4 = true := by decide
def m0_0_0_5 : Model := ⟨system,[],[],0,["good","q"],["good","bad","q"]⟩
example : rows m0_0_0_5 = [] := by decide
example : favorable m0_0_0_5 = [] := by decide
example : unfavorable m0_0_0_5 = [] := by decide
example : secure m0_0_0_5 = true := by decide
def m0_0_0_6 : Model := ⟨system,[],[],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_0_0_6 = [] := by decide
example : favorable m0_0_0_6 = [] := by decide
example : unfavorable m0_0_0_6 = [] := by decide
example : secure m0_0_0_6 = true := by decide
def m0_0_0_7 : Model := ⟨system,[],[],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_0_0_7 = [] := by decide
example : favorable m0_0_0_7 = [] := by decide
example : unfavorable m0_0_0_7 = [] := by decide
example : secure m0_0_0_7 = true := by decide
def m0_0_1_0 : Model := ⟨system,[],[],1,[],["good","bad","q"]⟩
example : rows m0_0_1_0 = [] := by decide
example : favorable m0_0_1_0 = [] := by decide
example : unfavorable m0_0_1_0 = [] := by decide
example : secure m0_0_1_0 = true := by decide
def m0_0_1_1 : Model := ⟨system,[],[],1,["good"],["good","bad","q"]⟩
example : rows m0_0_1_1 = [] := by decide
example : favorable m0_0_1_1 = [] := by decide
example : unfavorable m0_0_1_1 = [] := by decide
example : secure m0_0_1_1 = true := by decide
def m0_0_1_2 : Model := ⟨system,[],[],1,["bad"],["good","bad","q"]⟩
example : rows m0_0_1_2 = [] := by decide
example : favorable m0_0_1_2 = [] := by decide
example : unfavorable m0_0_1_2 = [] := by decide
example : secure m0_0_1_2 = true := by decide
def m0_0_1_3 : Model := ⟨system,[],[],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_0_1_3 = [] := by decide
example : favorable m0_0_1_3 = [] := by decide
example : unfavorable m0_0_1_3 = [] := by decide
example : secure m0_0_1_3 = true := by decide
def m0_0_1_4 : Model := ⟨system,[],[],1,["q"],["good","bad","q"]⟩
example : rows m0_0_1_4 = [] := by decide
example : favorable m0_0_1_4 = [] := by decide
example : unfavorable m0_0_1_4 = [] := by decide
example : secure m0_0_1_4 = true := by decide
def m0_0_1_5 : Model := ⟨system,[],[],1,["good","q"],["good","bad","q"]⟩
example : rows m0_0_1_5 = [] := by decide
example : favorable m0_0_1_5 = [] := by decide
example : unfavorable m0_0_1_5 = [] := by decide
example : secure m0_0_1_5 = true := by decide
def m0_0_1_6 : Model := ⟨system,[],[],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_0_1_6 = [] := by decide
example : favorable m0_0_1_6 = [] := by decide
example : unfavorable m0_0_1_6 = [] := by decide
example : secure m0_0_1_6 = true := by decide
def m0_0_1_7 : Model := ⟨system,[],[],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_0_1_7 = [] := by decide
example : favorable m0_0_1_7 = [] := by decide
example : unfavorable m0_0_1_7 = [] := by decide
example : secure m0_0_1_7 = true := by decide
def m0_1_0_0 : Model := ⟨system,[],[a],0,[],["good","bad","q"]⟩
example : rows m0_1_0_0 = [] := by decide
example : favorable m0_1_0_0 = [] := by decide
example : unfavorable m0_1_0_0 = [] := by decide
example : secure m0_1_0_0 = true := by decide
def m0_1_0_1 : Model := ⟨system,[],[a],0,["good"],["good","bad","q"]⟩
example : rows m0_1_0_1 = [] := by decide
example : favorable m0_1_0_1 = [] := by decide
example : unfavorable m0_1_0_1 = [] := by decide
example : secure m0_1_0_1 = true := by decide
def m0_1_0_2 : Model := ⟨system,[],[a],0,["bad"],["good","bad","q"]⟩
example : rows m0_1_0_2 = [] := by decide
example : favorable m0_1_0_2 = [] := by decide
example : unfavorable m0_1_0_2 = [] := by decide
example : secure m0_1_0_2 = true := by decide
def m0_1_0_3 : Model := ⟨system,[],[a],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_1_0_3 = [] := by decide
example : favorable m0_1_0_3 = [] := by decide
example : unfavorable m0_1_0_3 = [] := by decide
example : secure m0_1_0_3 = true := by decide
def m0_1_0_4 : Model := ⟨system,[],[a],0,["q"],["good","bad","q"]⟩
example : rows m0_1_0_4 = [] := by decide
example : favorable m0_1_0_4 = [] := by decide
example : unfavorable m0_1_0_4 = [] := by decide
example : secure m0_1_0_4 = true := by decide
def m0_1_0_5 : Model := ⟨system,[],[a],0,["good","q"],["good","bad","q"]⟩
example : rows m0_1_0_5 = [] := by decide
example : favorable m0_1_0_5 = [] := by decide
example : unfavorable m0_1_0_5 = [] := by decide
example : secure m0_1_0_5 = true := by decide
def m0_1_0_6 : Model := ⟨system,[],[a],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_1_0_6 = [] := by decide
example : favorable m0_1_0_6 = [] := by decide
example : unfavorable m0_1_0_6 = [] := by decide
example : secure m0_1_0_6 = true := by decide
def m0_1_0_7 : Model := ⟨system,[],[a],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_1_0_7 = [] := by decide
example : favorable m0_1_0_7 = [] := by decide
example : unfavorable m0_1_0_7 = [] := by decide
example : secure m0_1_0_7 = true := by decide
def m0_1_1_0 : Model := ⟨system,[],[a],1,[],["good","bad","q"]⟩
example : rows m0_1_1_0 = [] := by decide
example : favorable m0_1_1_0 = [] := by decide
example : unfavorable m0_1_1_0 = [] := by decide
example : secure m0_1_1_0 = true := by decide
def m0_1_1_1 : Model := ⟨system,[],[a],1,["good"],["good","bad","q"]⟩
example : rows m0_1_1_1 = [] := by decide
example : favorable m0_1_1_1 = [] := by decide
example : unfavorable m0_1_1_1 = [] := by decide
example : secure m0_1_1_1 = true := by decide
def m0_1_1_2 : Model := ⟨system,[],[a],1,["bad"],["good","bad","q"]⟩
example : rows m0_1_1_2 = [] := by decide
example : favorable m0_1_1_2 = [] := by decide
example : unfavorable m0_1_1_2 = [] := by decide
example : secure m0_1_1_2 = true := by decide
def m0_1_1_3 : Model := ⟨system,[],[a],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_1_1_3 = [] := by decide
example : favorable m0_1_1_3 = [] := by decide
example : unfavorable m0_1_1_3 = [] := by decide
example : secure m0_1_1_3 = true := by decide
def m0_1_1_4 : Model := ⟨system,[],[a],1,["q"],["good","bad","q"]⟩
example : rows m0_1_1_4 = [] := by decide
example : favorable m0_1_1_4 = [] := by decide
example : unfavorable m0_1_1_4 = [] := by decide
example : secure m0_1_1_4 = true := by decide
def m0_1_1_5 : Model := ⟨system,[],[a],1,["good","q"],["good","bad","q"]⟩
example : rows m0_1_1_5 = [] := by decide
example : favorable m0_1_1_5 = [] := by decide
example : unfavorable m0_1_1_5 = [] := by decide
example : secure m0_1_1_5 = true := by decide
def m0_1_1_6 : Model := ⟨system,[],[a],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_1_1_6 = [] := by decide
example : favorable m0_1_1_6 = [] := by decide
example : unfavorable m0_1_1_6 = [] := by decide
example : secure m0_1_1_6 = true := by decide
def m0_1_1_7 : Model := ⟨system,[],[a],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_1_1_7 = [] := by decide
example : favorable m0_1_1_7 = [] := by decide
example : unfavorable m0_1_1_7 = [] := by decide
example : secure m0_1_1_7 = true := by decide
def m0_2_0_0 : Model := ⟨system,[],[b],0,[],["good","bad","q"]⟩
example : rows m0_2_0_0 = [] := by decide
example : favorable m0_2_0_0 = [] := by decide
example : unfavorable m0_2_0_0 = [] := by decide
example : secure m0_2_0_0 = true := by decide
def m0_2_0_1 : Model := ⟨system,[],[b],0,["good"],["good","bad","q"]⟩
example : rows m0_2_0_1 = [] := by decide
example : favorable m0_2_0_1 = [] := by decide
example : unfavorable m0_2_0_1 = [] := by decide
example : secure m0_2_0_1 = true := by decide
def m0_2_0_2 : Model := ⟨system,[],[b],0,["bad"],["good","bad","q"]⟩
example : rows m0_2_0_2 = [] := by decide
example : favorable m0_2_0_2 = [] := by decide
example : unfavorable m0_2_0_2 = [] := by decide
example : secure m0_2_0_2 = true := by decide
def m0_2_0_3 : Model := ⟨system,[],[b],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_2_0_3 = [] := by decide
example : favorable m0_2_0_3 = [] := by decide
example : unfavorable m0_2_0_3 = [] := by decide
example : secure m0_2_0_3 = true := by decide
def m0_2_0_4 : Model := ⟨system,[],[b],0,["q"],["good","bad","q"]⟩
example : rows m0_2_0_4 = [] := by decide
example : favorable m0_2_0_4 = [] := by decide
example : unfavorable m0_2_0_4 = [] := by decide
example : secure m0_2_0_4 = true := by decide
def m0_2_0_5 : Model := ⟨system,[],[b],0,["good","q"],["good","bad","q"]⟩
example : rows m0_2_0_5 = [] := by decide
example : favorable m0_2_0_5 = [] := by decide
example : unfavorable m0_2_0_5 = [] := by decide
example : secure m0_2_0_5 = true := by decide
def m0_2_0_6 : Model := ⟨system,[],[b],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_2_0_6 = [] := by decide
example : favorable m0_2_0_6 = [] := by decide
example : unfavorable m0_2_0_6 = [] := by decide
example : secure m0_2_0_6 = true := by decide
def m0_2_0_7 : Model := ⟨system,[],[b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_2_0_7 = [] := by decide
example : favorable m0_2_0_7 = [] := by decide
example : unfavorable m0_2_0_7 = [] := by decide
example : secure m0_2_0_7 = true := by decide
def m0_2_1_0 : Model := ⟨system,[],[b],1,[],["good","bad","q"]⟩
example : rows m0_2_1_0 = [] := by decide
example : favorable m0_2_1_0 = [] := by decide
example : unfavorable m0_2_1_0 = [] := by decide
example : secure m0_2_1_0 = true := by decide
def m0_2_1_1 : Model := ⟨system,[],[b],1,["good"],["good","bad","q"]⟩
example : rows m0_2_1_1 = [] := by decide
example : favorable m0_2_1_1 = [] := by decide
example : unfavorable m0_2_1_1 = [] := by decide
example : secure m0_2_1_1 = true := by decide
def m0_2_1_2 : Model := ⟨system,[],[b],1,["bad"],["good","bad","q"]⟩
example : rows m0_2_1_2 = [] := by decide
example : favorable m0_2_1_2 = [] := by decide
example : unfavorable m0_2_1_2 = [] := by decide
example : secure m0_2_1_2 = true := by decide
def m0_2_1_3 : Model := ⟨system,[],[b],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_2_1_3 = [] := by decide
example : favorable m0_2_1_3 = [] := by decide
example : unfavorable m0_2_1_3 = [] := by decide
example : secure m0_2_1_3 = true := by decide
def m0_2_1_4 : Model := ⟨system,[],[b],1,["q"],["good","bad","q"]⟩
example : rows m0_2_1_4 = [] := by decide
example : favorable m0_2_1_4 = [] := by decide
example : unfavorable m0_2_1_4 = [] := by decide
example : secure m0_2_1_4 = true := by decide
def m0_2_1_5 : Model := ⟨system,[],[b],1,["good","q"],["good","bad","q"]⟩
example : rows m0_2_1_5 = [] := by decide
example : favorable m0_2_1_5 = [] := by decide
example : unfavorable m0_2_1_5 = [] := by decide
example : secure m0_2_1_5 = true := by decide
def m0_2_1_6 : Model := ⟨system,[],[b],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_2_1_6 = [] := by decide
example : favorable m0_2_1_6 = [] := by decide
example : unfavorable m0_2_1_6 = [] := by decide
example : secure m0_2_1_6 = true := by decide
def m0_2_1_7 : Model := ⟨system,[],[b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_2_1_7 = [] := by decide
example : favorable m0_2_1_7 = [] := by decide
example : unfavorable m0_2_1_7 = [] := by decide
example : secure m0_2_1_7 = true := by decide
def m0_3_0_0 : Model := ⟨system,[],[a,b],0,[],["good","bad","q"]⟩
example : rows m0_3_0_0 = [] := by decide
example : favorable m0_3_0_0 = [] := by decide
example : unfavorable m0_3_0_0 = [] := by decide
example : secure m0_3_0_0 = true := by decide
def m0_3_0_1 : Model := ⟨system,[],[a,b],0,["good"],["good","bad","q"]⟩
example : rows m0_3_0_1 = [] := by decide
example : favorable m0_3_0_1 = [] := by decide
example : unfavorable m0_3_0_1 = [] := by decide
example : secure m0_3_0_1 = true := by decide
def m0_3_0_2 : Model := ⟨system,[],[a,b],0,["bad"],["good","bad","q"]⟩
example : rows m0_3_0_2 = [] := by decide
example : favorable m0_3_0_2 = [] := by decide
example : unfavorable m0_3_0_2 = [] := by decide
example : secure m0_3_0_2 = true := by decide
def m0_3_0_3 : Model := ⟨system,[],[a,b],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_3_0_3 = [] := by decide
example : favorable m0_3_0_3 = [] := by decide
example : unfavorable m0_3_0_3 = [] := by decide
example : secure m0_3_0_3 = true := by decide
def m0_3_0_4 : Model := ⟨system,[],[a,b],0,["q"],["good","bad","q"]⟩
example : rows m0_3_0_4 = [] := by decide
example : favorable m0_3_0_4 = [] := by decide
example : unfavorable m0_3_0_4 = [] := by decide
example : secure m0_3_0_4 = true := by decide
def m0_3_0_5 : Model := ⟨system,[],[a,b],0,["good","q"],["good","bad","q"]⟩
example : rows m0_3_0_5 = [] := by decide
example : favorable m0_3_0_5 = [] := by decide
example : unfavorable m0_3_0_5 = [] := by decide
example : secure m0_3_0_5 = true := by decide
def m0_3_0_6 : Model := ⟨system,[],[a,b],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_3_0_6 = [] := by decide
example : favorable m0_3_0_6 = [] := by decide
example : unfavorable m0_3_0_6 = [] := by decide
example : secure m0_3_0_6 = true := by decide
def m0_3_0_7 : Model := ⟨system,[],[a,b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_3_0_7 = [] := by decide
example : favorable m0_3_0_7 = [] := by decide
example : unfavorable m0_3_0_7 = [] := by decide
example : secure m0_3_0_7 = true := by decide
def m0_3_1_0 : Model := ⟨system,[],[a,b],1,[],["good","bad","q"]⟩
example : rows m0_3_1_0 = [] := by decide
example : favorable m0_3_1_0 = [] := by decide
example : unfavorable m0_3_1_0 = [] := by decide
example : secure m0_3_1_0 = true := by decide
def m0_3_1_1 : Model := ⟨system,[],[a,b],1,["good"],["good","bad","q"]⟩
example : rows m0_3_1_1 = [] := by decide
example : favorable m0_3_1_1 = [] := by decide
example : unfavorable m0_3_1_1 = [] := by decide
example : secure m0_3_1_1 = true := by decide
def m0_3_1_2 : Model := ⟨system,[],[a,b],1,["bad"],["good","bad","q"]⟩
example : rows m0_3_1_2 = [] := by decide
example : favorable m0_3_1_2 = [] := by decide
example : unfavorable m0_3_1_2 = [] := by decide
example : secure m0_3_1_2 = true := by decide
def m0_3_1_3 : Model := ⟨system,[],[a,b],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_3_1_3 = [] := by decide
example : favorable m0_3_1_3 = [] := by decide
example : unfavorable m0_3_1_3 = [] := by decide
example : secure m0_3_1_3 = true := by decide
def m0_3_1_4 : Model := ⟨system,[],[a,b],1,["q"],["good","bad","q"]⟩
example : rows m0_3_1_4 = [] := by decide
example : favorable m0_3_1_4 = [] := by decide
example : unfavorable m0_3_1_4 = [] := by decide
example : secure m0_3_1_4 = true := by decide
def m0_3_1_5 : Model := ⟨system,[],[a,b],1,["good","q"],["good","bad","q"]⟩
example : rows m0_3_1_5 = [] := by decide
example : favorable m0_3_1_5 = [] := by decide
example : unfavorable m0_3_1_5 = [] := by decide
example : secure m0_3_1_5 = true := by decide
def m0_3_1_6 : Model := ⟨system,[],[a,b],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_3_1_6 = [] := by decide
example : favorable m0_3_1_6 = [] := by decide
example : unfavorable m0_3_1_6 = [] := by decide
example : secure m0_3_1_6 = true := by decide
def m0_3_1_7 : Model := ⟨system,[],[a,b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_3_1_7 = [] := by decide
example : favorable m0_3_1_7 = [] := by decide
example : unfavorable m0_3_1_7 = [] := by decide
example : secure m0_3_1_7 = true := by decide
def m0_4_0_0 : Model := ⟨system,[],[c],0,[],["good","bad","q"]⟩
example : rows m0_4_0_0 = [] := by decide
example : favorable m0_4_0_0 = [] := by decide
example : unfavorable m0_4_0_0 = [] := by decide
example : secure m0_4_0_0 = true := by decide
def m0_4_0_1 : Model := ⟨system,[],[c],0,["good"],["good","bad","q"]⟩
example : rows m0_4_0_1 = [] := by decide
example : favorable m0_4_0_1 = [] := by decide
example : unfavorable m0_4_0_1 = [] := by decide
example : secure m0_4_0_1 = true := by decide
def m0_4_0_2 : Model := ⟨system,[],[c],0,["bad"],["good","bad","q"]⟩
example : rows m0_4_0_2 = [] := by decide
example : favorable m0_4_0_2 = [] := by decide
example : unfavorable m0_4_0_2 = [] := by decide
example : secure m0_4_0_2 = true := by decide
def m0_4_0_3 : Model := ⟨system,[],[c],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_4_0_3 = [] := by decide
example : favorable m0_4_0_3 = [] := by decide
example : unfavorable m0_4_0_3 = [] := by decide
example : secure m0_4_0_3 = true := by decide
def m0_4_0_4 : Model := ⟨system,[],[c],0,["q"],["good","bad","q"]⟩
example : rows m0_4_0_4 = [] := by decide
example : favorable m0_4_0_4 = [] := by decide
example : unfavorable m0_4_0_4 = [] := by decide
example : secure m0_4_0_4 = true := by decide
def m0_4_0_5 : Model := ⟨system,[],[c],0,["good","q"],["good","bad","q"]⟩
example : rows m0_4_0_5 = [] := by decide
example : favorable m0_4_0_5 = [] := by decide
example : unfavorable m0_4_0_5 = [] := by decide
example : secure m0_4_0_5 = true := by decide
def m0_4_0_6 : Model := ⟨system,[],[c],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_4_0_6 = [] := by decide
example : favorable m0_4_0_6 = [] := by decide
example : unfavorable m0_4_0_6 = [] := by decide
example : secure m0_4_0_6 = true := by decide
def m0_4_0_7 : Model := ⟨system,[],[c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_4_0_7 = [] := by decide
example : favorable m0_4_0_7 = [] := by decide
example : unfavorable m0_4_0_7 = [] := by decide
example : secure m0_4_0_7 = true := by decide
def m0_4_1_0 : Model := ⟨system,[],[c],1,[],["good","bad","q"]⟩
example : rows m0_4_1_0 = [] := by decide
example : favorable m0_4_1_0 = [] := by decide
example : unfavorable m0_4_1_0 = [] := by decide
example : secure m0_4_1_0 = true := by decide
def m0_4_1_1 : Model := ⟨system,[],[c],1,["good"],["good","bad","q"]⟩
example : rows m0_4_1_1 = [] := by decide
example : favorable m0_4_1_1 = [] := by decide
example : unfavorable m0_4_1_1 = [] := by decide
example : secure m0_4_1_1 = true := by decide
def m0_4_1_2 : Model := ⟨system,[],[c],1,["bad"],["good","bad","q"]⟩
example : rows m0_4_1_2 = [] := by decide
example : favorable m0_4_1_2 = [] := by decide
example : unfavorable m0_4_1_2 = [] := by decide
example : secure m0_4_1_2 = true := by decide
def m0_4_1_3 : Model := ⟨system,[],[c],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_4_1_3 = [] := by decide
example : favorable m0_4_1_3 = [] := by decide
example : unfavorable m0_4_1_3 = [] := by decide
example : secure m0_4_1_3 = true := by decide
def m0_4_1_4 : Model := ⟨system,[],[c],1,["q"],["good","bad","q"]⟩
example : rows m0_4_1_4 = [] := by decide
example : favorable m0_4_1_4 = [] := by decide
example : unfavorable m0_4_1_4 = [] := by decide
example : secure m0_4_1_4 = true := by decide
def m0_4_1_5 : Model := ⟨system,[],[c],1,["good","q"],["good","bad","q"]⟩
example : rows m0_4_1_5 = [] := by decide
example : favorable m0_4_1_5 = [] := by decide
example : unfavorable m0_4_1_5 = [] := by decide
example : secure m0_4_1_5 = true := by decide
def m0_4_1_6 : Model := ⟨system,[],[c],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_4_1_6 = [] := by decide
example : favorable m0_4_1_6 = [] := by decide
example : unfavorable m0_4_1_6 = [] := by decide
example : secure m0_4_1_6 = true := by decide
def m0_4_1_7 : Model := ⟨system,[],[c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_4_1_7 = [] := by decide
example : favorable m0_4_1_7 = [] := by decide
example : unfavorable m0_4_1_7 = [] := by decide
example : secure m0_4_1_7 = true := by decide
def m0_5_0_0 : Model := ⟨system,[],[a,c],0,[],["good","bad","q"]⟩
example : rows m0_5_0_0 = [] := by decide
example : favorable m0_5_0_0 = [] := by decide
example : unfavorable m0_5_0_0 = [] := by decide
example : secure m0_5_0_0 = true := by decide
def m0_5_0_1 : Model := ⟨system,[],[a,c],0,["good"],["good","bad","q"]⟩
example : rows m0_5_0_1 = [] := by decide
example : favorable m0_5_0_1 = [] := by decide
example : unfavorable m0_5_0_1 = [] := by decide
example : secure m0_5_0_1 = true := by decide
def m0_5_0_2 : Model := ⟨system,[],[a,c],0,["bad"],["good","bad","q"]⟩
example : rows m0_5_0_2 = [] := by decide
example : favorable m0_5_0_2 = [] := by decide
example : unfavorable m0_5_0_2 = [] := by decide
example : secure m0_5_0_2 = true := by decide
def m0_5_0_3 : Model := ⟨system,[],[a,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_5_0_3 = [] := by decide
example : favorable m0_5_0_3 = [] := by decide
example : unfavorable m0_5_0_3 = [] := by decide
example : secure m0_5_0_3 = true := by decide
def m0_5_0_4 : Model := ⟨system,[],[a,c],0,["q"],["good","bad","q"]⟩
example : rows m0_5_0_4 = [] := by decide
example : favorable m0_5_0_4 = [] := by decide
example : unfavorable m0_5_0_4 = [] := by decide
example : secure m0_5_0_4 = true := by decide
def m0_5_0_5 : Model := ⟨system,[],[a,c],0,["good","q"],["good","bad","q"]⟩
example : rows m0_5_0_5 = [] := by decide
example : favorable m0_5_0_5 = [] := by decide
example : unfavorable m0_5_0_5 = [] := by decide
example : secure m0_5_0_5 = true := by decide
def m0_5_0_6 : Model := ⟨system,[],[a,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_5_0_6 = [] := by decide
example : favorable m0_5_0_6 = [] := by decide
example : unfavorable m0_5_0_6 = [] := by decide
example : secure m0_5_0_6 = true := by decide
def m0_5_0_7 : Model := ⟨system,[],[a,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_5_0_7 = [] := by decide
example : favorable m0_5_0_7 = [] := by decide
example : unfavorable m0_5_0_7 = [] := by decide
example : secure m0_5_0_7 = true := by decide
def m0_5_1_0 : Model := ⟨system,[],[a,c],1,[],["good","bad","q"]⟩
example : rows m0_5_1_0 = [] := by decide
example : favorable m0_5_1_0 = [] := by decide
example : unfavorable m0_5_1_0 = [] := by decide
example : secure m0_5_1_0 = true := by decide
def m0_5_1_1 : Model := ⟨system,[],[a,c],1,["good"],["good","bad","q"]⟩
example : rows m0_5_1_1 = [] := by decide
example : favorable m0_5_1_1 = [] := by decide
example : unfavorable m0_5_1_1 = [] := by decide
example : secure m0_5_1_1 = true := by decide
def m0_5_1_2 : Model := ⟨system,[],[a,c],1,["bad"],["good","bad","q"]⟩
example : rows m0_5_1_2 = [] := by decide
example : favorable m0_5_1_2 = [] := by decide
example : unfavorable m0_5_1_2 = [] := by decide
example : secure m0_5_1_2 = true := by decide
def m0_5_1_3 : Model := ⟨system,[],[a,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_5_1_3 = [] := by decide
example : favorable m0_5_1_3 = [] := by decide
example : unfavorable m0_5_1_3 = [] := by decide
example : secure m0_5_1_3 = true := by decide
def m0_5_1_4 : Model := ⟨system,[],[a,c],1,["q"],["good","bad","q"]⟩
example : rows m0_5_1_4 = [] := by decide
example : favorable m0_5_1_4 = [] := by decide
example : unfavorable m0_5_1_4 = [] := by decide
example : secure m0_5_1_4 = true := by decide
def m0_5_1_5 : Model := ⟨system,[],[a,c],1,["good","q"],["good","bad","q"]⟩
example : rows m0_5_1_5 = [] := by decide
example : favorable m0_5_1_5 = [] := by decide
example : unfavorable m0_5_1_5 = [] := by decide
example : secure m0_5_1_5 = true := by decide
def m0_5_1_6 : Model := ⟨system,[],[a,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_5_1_6 = [] := by decide
example : favorable m0_5_1_6 = [] := by decide
example : unfavorable m0_5_1_6 = [] := by decide
example : secure m0_5_1_6 = true := by decide
def m0_5_1_7 : Model := ⟨system,[],[a,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_5_1_7 = [] := by decide
example : favorable m0_5_1_7 = [] := by decide
example : unfavorable m0_5_1_7 = [] := by decide
example : secure m0_5_1_7 = true := by decide
def m0_6_0_0 : Model := ⟨system,[],[b,c],0,[],["good","bad","q"]⟩
example : rows m0_6_0_0 = [] := by decide
example : favorable m0_6_0_0 = [] := by decide
example : unfavorable m0_6_0_0 = [] := by decide
example : secure m0_6_0_0 = true := by decide
def m0_6_0_1 : Model := ⟨system,[],[b,c],0,["good"],["good","bad","q"]⟩
example : rows m0_6_0_1 = [] := by decide
example : favorable m0_6_0_1 = [] := by decide
example : unfavorable m0_6_0_1 = [] := by decide
example : secure m0_6_0_1 = true := by decide
def m0_6_0_2 : Model := ⟨system,[],[b,c],0,["bad"],["good","bad","q"]⟩
example : rows m0_6_0_2 = [] := by decide
example : favorable m0_6_0_2 = [] := by decide
example : unfavorable m0_6_0_2 = [] := by decide
example : secure m0_6_0_2 = true := by decide
def m0_6_0_3 : Model := ⟨system,[],[b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_6_0_3 = [] := by decide
example : favorable m0_6_0_3 = [] := by decide
example : unfavorable m0_6_0_3 = [] := by decide
example : secure m0_6_0_3 = true := by decide
def m0_6_0_4 : Model := ⟨system,[],[b,c],0,["q"],["good","bad","q"]⟩
example : rows m0_6_0_4 = [] := by decide
example : favorable m0_6_0_4 = [] := by decide
example : unfavorable m0_6_0_4 = [] := by decide
example : secure m0_6_0_4 = true := by decide
def m0_6_0_5 : Model := ⟨system,[],[b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m0_6_0_5 = [] := by decide
example : favorable m0_6_0_5 = [] := by decide
example : unfavorable m0_6_0_5 = [] := by decide
example : secure m0_6_0_5 = true := by decide
def m0_6_0_6 : Model := ⟨system,[],[b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_6_0_6 = [] := by decide
example : favorable m0_6_0_6 = [] := by decide
example : unfavorable m0_6_0_6 = [] := by decide
example : secure m0_6_0_6 = true := by decide
def m0_6_0_7 : Model := ⟨system,[],[b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_6_0_7 = [] := by decide
example : favorable m0_6_0_7 = [] := by decide
example : unfavorable m0_6_0_7 = [] := by decide
example : secure m0_6_0_7 = true := by decide
def m0_6_1_0 : Model := ⟨system,[],[b,c],1,[],["good","bad","q"]⟩
example : rows m0_6_1_0 = [] := by decide
example : favorable m0_6_1_0 = [] := by decide
example : unfavorable m0_6_1_0 = [] := by decide
example : secure m0_6_1_0 = true := by decide
def m0_6_1_1 : Model := ⟨system,[],[b,c],1,["good"],["good","bad","q"]⟩
example : rows m0_6_1_1 = [] := by decide
example : favorable m0_6_1_1 = [] := by decide
example : unfavorable m0_6_1_1 = [] := by decide
example : secure m0_6_1_1 = true := by decide
def m0_6_1_2 : Model := ⟨system,[],[b,c],1,["bad"],["good","bad","q"]⟩
example : rows m0_6_1_2 = [] := by decide
example : favorable m0_6_1_2 = [] := by decide
example : unfavorable m0_6_1_2 = [] := by decide
example : secure m0_6_1_2 = true := by decide
def m0_6_1_3 : Model := ⟨system,[],[b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_6_1_3 = [] := by decide
example : favorable m0_6_1_3 = [] := by decide
example : unfavorable m0_6_1_3 = [] := by decide
example : secure m0_6_1_3 = true := by decide
def m0_6_1_4 : Model := ⟨system,[],[b,c],1,["q"],["good","bad","q"]⟩
example : rows m0_6_1_4 = [] := by decide
example : favorable m0_6_1_4 = [] := by decide
example : unfavorable m0_6_1_4 = [] := by decide
example : secure m0_6_1_4 = true := by decide
def m0_6_1_5 : Model := ⟨system,[],[b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m0_6_1_5 = [] := by decide
example : favorable m0_6_1_5 = [] := by decide
example : unfavorable m0_6_1_5 = [] := by decide
example : secure m0_6_1_5 = true := by decide
def m0_6_1_6 : Model := ⟨system,[],[b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_6_1_6 = [] := by decide
example : favorable m0_6_1_6 = [] := by decide
example : unfavorable m0_6_1_6 = [] := by decide
example : secure m0_6_1_6 = true := by decide
def m0_6_1_7 : Model := ⟨system,[],[b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_6_1_7 = [] := by decide
example : favorable m0_6_1_7 = [] := by decide
example : unfavorable m0_6_1_7 = [] := by decide
example : secure m0_6_1_7 = true := by decide
def m0_7_0_0 : Model := ⟨system,[],[a,b,c],0,[],["good","bad","q"]⟩
example : rows m0_7_0_0 = [] := by decide
example : favorable m0_7_0_0 = [] := by decide
example : unfavorable m0_7_0_0 = [] := by decide
example : secure m0_7_0_0 = true := by decide
def m0_7_0_1 : Model := ⟨system,[],[a,b,c],0,["good"],["good","bad","q"]⟩
example : rows m0_7_0_1 = [] := by decide
example : favorable m0_7_0_1 = [] := by decide
example : unfavorable m0_7_0_1 = [] := by decide
example : secure m0_7_0_1 = true := by decide
def m0_7_0_2 : Model := ⟨system,[],[a,b,c],0,["bad"],["good","bad","q"]⟩
example : rows m0_7_0_2 = [] := by decide
example : favorable m0_7_0_2 = [] := by decide
example : unfavorable m0_7_0_2 = [] := by decide
example : secure m0_7_0_2 = true := by decide
def m0_7_0_3 : Model := ⟨system,[],[a,b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m0_7_0_3 = [] := by decide
example : favorable m0_7_0_3 = [] := by decide
example : unfavorable m0_7_0_3 = [] := by decide
example : secure m0_7_0_3 = true := by decide
def m0_7_0_4 : Model := ⟨system,[],[a,b,c],0,["q"],["good","bad","q"]⟩
example : rows m0_7_0_4 = [] := by decide
example : favorable m0_7_0_4 = [] := by decide
example : unfavorable m0_7_0_4 = [] := by decide
example : secure m0_7_0_4 = true := by decide
def m0_7_0_5 : Model := ⟨system,[],[a,b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m0_7_0_5 = [] := by decide
example : favorable m0_7_0_5 = [] := by decide
example : unfavorable m0_7_0_5 = [] := by decide
example : secure m0_7_0_5 = true := by decide
def m0_7_0_6 : Model := ⟨system,[],[a,b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m0_7_0_6 = [] := by decide
example : favorable m0_7_0_6 = [] := by decide
example : unfavorable m0_7_0_6 = [] := by decide
example : secure m0_7_0_6 = true := by decide
def m0_7_0_7 : Model := ⟨system,[],[a,b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_7_0_7 = [] := by decide
example : favorable m0_7_0_7 = [] := by decide
example : unfavorable m0_7_0_7 = [] := by decide
example : secure m0_7_0_7 = true := by decide
def m0_7_1_0 : Model := ⟨system,[],[a,b,c],1,[],["good","bad","q"]⟩
example : rows m0_7_1_0 = [] := by decide
example : favorable m0_7_1_0 = [] := by decide
example : unfavorable m0_7_1_0 = [] := by decide
example : secure m0_7_1_0 = true := by decide
def m0_7_1_1 : Model := ⟨system,[],[a,b,c],1,["good"],["good","bad","q"]⟩
example : rows m0_7_1_1 = [] := by decide
example : favorable m0_7_1_1 = [] := by decide
example : unfavorable m0_7_1_1 = [] := by decide
example : secure m0_7_1_1 = true := by decide
def m0_7_1_2 : Model := ⟨system,[],[a,b,c],1,["bad"],["good","bad","q"]⟩
example : rows m0_7_1_2 = [] := by decide
example : favorable m0_7_1_2 = [] := by decide
example : unfavorable m0_7_1_2 = [] := by decide
example : secure m0_7_1_2 = true := by decide
def m0_7_1_3 : Model := ⟨system,[],[a,b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m0_7_1_3 = [] := by decide
example : favorable m0_7_1_3 = [] := by decide
example : unfavorable m0_7_1_3 = [] := by decide
example : secure m0_7_1_3 = true := by decide
def m0_7_1_4 : Model := ⟨system,[],[a,b,c],1,["q"],["good","bad","q"]⟩
example : rows m0_7_1_4 = [] := by decide
example : favorable m0_7_1_4 = [] := by decide
example : unfavorable m0_7_1_4 = [] := by decide
example : secure m0_7_1_4 = true := by decide
def m0_7_1_5 : Model := ⟨system,[],[a,b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m0_7_1_5 = [] := by decide
example : favorable m0_7_1_5 = [] := by decide
example : unfavorable m0_7_1_5 = [] := by decide
example : secure m0_7_1_5 = true := by decide
def m0_7_1_6 : Model := ⟨system,[],[a,b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m0_7_1_6 = [] := by decide
example : favorable m0_7_1_6 = [] := by decide
example : unfavorable m0_7_1_6 = [] := by decide
example : secure m0_7_1_6 = true := by decide
def m0_7_1_7 : Model := ⟨system,[],[a,b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m0_7_1_7 = [] := by decide
example : favorable m0_7_1_7 = [] := by decide
example : unfavorable m0_7_1_7 = [] := by decide
example : secure m0_7_1_7 = true := by decide
def m1_0_0_0 : Model := ⟨system,["a"],[],0,[],["good","bad","q"]⟩
example : rows m1_0_0_0 = [] := by decide
example : favorable m1_0_0_0 = [] := by decide
example : unfavorable m1_0_0_0 = [] := by decide
example : secure m1_0_0_0 = true := by decide
def m1_0_0_1 : Model := ⟨system,["a"],[],0,["good"],["good","bad","q"]⟩
example : rows m1_0_0_1 = [] := by decide
example : favorable m1_0_0_1 = [] := by decide
example : unfavorable m1_0_0_1 = [] := by decide
example : secure m1_0_0_1 = true := by decide
def m1_0_0_2 : Model := ⟨system,["a"],[],0,["bad"],["good","bad","q"]⟩
example : rows m1_0_0_2 = [] := by decide
example : favorable m1_0_0_2 = [] := by decide
example : unfavorable m1_0_0_2 = [] := by decide
example : secure m1_0_0_2 = true := by decide
def m1_0_0_3 : Model := ⟨system,["a"],[],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_0_0_3 = [] := by decide
example : favorable m1_0_0_3 = [] := by decide
example : unfavorable m1_0_0_3 = [] := by decide
example : secure m1_0_0_3 = true := by decide
def m1_0_0_4 : Model := ⟨system,["a"],[],0,["q"],["good","bad","q"]⟩
example : rows m1_0_0_4 = [] := by decide
example : favorable m1_0_0_4 = [] := by decide
example : unfavorable m1_0_0_4 = [] := by decide
example : secure m1_0_0_4 = true := by decide
def m1_0_0_5 : Model := ⟨system,["a"],[],0,["good","q"],["good","bad","q"]⟩
example : rows m1_0_0_5 = [] := by decide
example : favorable m1_0_0_5 = [] := by decide
example : unfavorable m1_0_0_5 = [] := by decide
example : secure m1_0_0_5 = true := by decide
def m1_0_0_6 : Model := ⟨system,["a"],[],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_0_0_6 = [] := by decide
example : favorable m1_0_0_6 = [] := by decide
example : unfavorable m1_0_0_6 = [] := by decide
example : secure m1_0_0_6 = true := by decide
def m1_0_0_7 : Model := ⟨system,["a"],[],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_0_0_7 = [] := by decide
example : favorable m1_0_0_7 = [] := by decide
example : unfavorable m1_0_0_7 = [] := by decide
example : secure m1_0_0_7 = true := by decide
def m1_0_1_0 : Model := ⟨system,["a"],[],1,[],["good","bad","q"]⟩
example : rows m1_0_1_0 = [] := by decide
example : favorable m1_0_1_0 = [] := by decide
example : unfavorable m1_0_1_0 = [] := by decide
example : secure m1_0_1_0 = true := by decide
def m1_0_1_1 : Model := ⟨system,["a"],[],1,["good"],["good","bad","q"]⟩
example : rows m1_0_1_1 = [] := by decide
example : favorable m1_0_1_1 = [] := by decide
example : unfavorable m1_0_1_1 = [] := by decide
example : secure m1_0_1_1 = true := by decide
def m1_0_1_2 : Model := ⟨system,["a"],[],1,["bad"],["good","bad","q"]⟩
example : rows m1_0_1_2 = [] := by decide
example : favorable m1_0_1_2 = [] := by decide
example : unfavorable m1_0_1_2 = [] := by decide
example : secure m1_0_1_2 = true := by decide
def m1_0_1_3 : Model := ⟨system,["a"],[],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_0_1_3 = [] := by decide
example : favorable m1_0_1_3 = [] := by decide
example : unfavorable m1_0_1_3 = [] := by decide
example : secure m1_0_1_3 = true := by decide
def m1_0_1_4 : Model := ⟨system,["a"],[],1,["q"],["good","bad","q"]⟩
example : rows m1_0_1_4 = [] := by decide
example : favorable m1_0_1_4 = [] := by decide
example : unfavorable m1_0_1_4 = [] := by decide
example : secure m1_0_1_4 = true := by decide
def m1_0_1_5 : Model := ⟨system,["a"],[],1,["good","q"],["good","bad","q"]⟩
example : rows m1_0_1_5 = [] := by decide
example : favorable m1_0_1_5 = [] := by decide
example : unfavorable m1_0_1_5 = [] := by decide
example : secure m1_0_1_5 = true := by decide
def m1_0_1_6 : Model := ⟨system,["a"],[],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_0_1_6 = [] := by decide
example : favorable m1_0_1_6 = [] := by decide
example : unfavorable m1_0_1_6 = [] := by decide
example : secure m1_0_1_6 = true := by decide
def m1_0_1_7 : Model := ⟨system,["a"],[],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_0_1_7 = [] := by decide
example : favorable m1_0_1_7 = [] := by decide
example : unfavorable m1_0_1_7 = [] := by decide
example : secure m1_0_1_7 = true := by decide
def m1_1_0_0 : Model := ⟨system,["a"],[a],0,[],["good","bad","q"]⟩
example : rows m1_1_0_0 = [] := by decide
example : favorable m1_1_0_0 = [] := by decide
example : unfavorable m1_1_0_0 = [] := by decide
example : secure m1_1_0_0 = true := by decide
def m1_1_0_1 : Model := ⟨system,["a"],[a],0,["good"],["good","bad","q"]⟩
example : rows m1_1_0_1 = [] := by decide
example : favorable m1_1_0_1 = [] := by decide
example : unfavorable m1_1_0_1 = [] := by decide
example : secure m1_1_0_1 = true := by decide
def m1_1_0_2 : Model := ⟨system,["a"],[a],0,["bad"],["good","bad","q"]⟩
example : rows m1_1_0_2 = [] := by decide
example : favorable m1_1_0_2 = [] := by decide
example : unfavorable m1_1_0_2 = [] := by decide
example : secure m1_1_0_2 = true := by decide
def m1_1_0_3 : Model := ⟨system,["a"],[a],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_1_0_3 = [] := by decide
example : favorable m1_1_0_3 = [] := by decide
example : unfavorable m1_1_0_3 = [] := by decide
example : secure m1_1_0_3 = true := by decide
def m1_1_0_4 : Model := ⟨system,["a"],[a],0,["q"],["good","bad","q"]⟩
example : rows m1_1_0_4 = [] := by decide
example : favorable m1_1_0_4 = [] := by decide
example : unfavorable m1_1_0_4 = [] := by decide
example : secure m1_1_0_4 = true := by decide
def m1_1_0_5 : Model := ⟨system,["a"],[a],0,["good","q"],["good","bad","q"]⟩
example : rows m1_1_0_5 = [] := by decide
example : favorable m1_1_0_5 = [] := by decide
example : unfavorable m1_1_0_5 = [] := by decide
example : secure m1_1_0_5 = true := by decide
def m1_1_0_6 : Model := ⟨system,["a"],[a],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_1_0_6 = [] := by decide
example : favorable m1_1_0_6 = [] := by decide
example : unfavorable m1_1_0_6 = [] := by decide
example : secure m1_1_0_6 = true := by decide
def m1_1_0_7 : Model := ⟨system,["a"],[a],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_1_0_7 = [] := by decide
example : favorable m1_1_0_7 = [] := by decide
example : unfavorable m1_1_0_7 = [] := by decide
example : secure m1_1_0_7 = true := by decide
def m1_1_1_0 : Model := ⟨system,["a"],[a],1,[],["good","bad","q"]⟩
example : rows m1_1_1_0 = [a] := by decide
example : favorable m1_1_1_0 = [] := by decide
example : unfavorable m1_1_1_0 = [a] := by decide
example : secure m1_1_1_0 = false := by decide
def m1_1_1_1 : Model := ⟨system,["a"],[a],1,["good"],["good","bad","q"]⟩
example : rows m1_1_1_1 = [a] := by decide
example : favorable m1_1_1_1 = [a] := by decide
example : unfavorable m1_1_1_1 = [] := by decide
example : secure m1_1_1_1 = true := by decide
def m1_1_1_2 : Model := ⟨system,["a"],[a],1,["bad"],["good","bad","q"]⟩
example : rows m1_1_1_2 = [a] := by decide
example : favorable m1_1_1_2 = [] := by decide
example : unfavorable m1_1_1_2 = [a] := by decide
example : secure m1_1_1_2 = false := by decide
def m1_1_1_3 : Model := ⟨system,["a"],[a],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_1_1_3 = [a] := by decide
example : favorable m1_1_1_3 = [a] := by decide
example : unfavorable m1_1_1_3 = [] := by decide
example : secure m1_1_1_3 = true := by decide
def m1_1_1_4 : Model := ⟨system,["a"],[a],1,["q"],["good","bad","q"]⟩
example : rows m1_1_1_4 = [a] := by decide
example : favorable m1_1_1_4 = [] := by decide
example : unfavorable m1_1_1_4 = [a] := by decide
example : secure m1_1_1_4 = false := by decide
def m1_1_1_5 : Model := ⟨system,["a"],[a],1,["good","q"],["good","bad","q"]⟩
example : rows m1_1_1_5 = [a] := by decide
example : favorable m1_1_1_5 = [a] := by decide
example : unfavorable m1_1_1_5 = [] := by decide
example : secure m1_1_1_5 = true := by decide
def m1_1_1_6 : Model := ⟨system,["a"],[a],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_1_1_6 = [a] := by decide
example : favorable m1_1_1_6 = [] := by decide
example : unfavorable m1_1_1_6 = [a] := by decide
example : secure m1_1_1_6 = false := by decide
def m1_1_1_7 : Model := ⟨system,["a"],[a],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_1_1_7 = [a] := by decide
example : favorable m1_1_1_7 = [a] := by decide
example : unfavorable m1_1_1_7 = [] := by decide
example : secure m1_1_1_7 = true := by decide
def m1_2_0_0 : Model := ⟨system,["a"],[b],0,[],["good","bad","q"]⟩
example : rows m1_2_0_0 = [] := by decide
example : favorable m1_2_0_0 = [] := by decide
example : unfavorable m1_2_0_0 = [] := by decide
example : secure m1_2_0_0 = true := by decide
def m1_2_0_1 : Model := ⟨system,["a"],[b],0,["good"],["good","bad","q"]⟩
example : rows m1_2_0_1 = [] := by decide
example : favorable m1_2_0_1 = [] := by decide
example : unfavorable m1_2_0_1 = [] := by decide
example : secure m1_2_0_1 = true := by decide
def m1_2_0_2 : Model := ⟨system,["a"],[b],0,["bad"],["good","bad","q"]⟩
example : rows m1_2_0_2 = [] := by decide
example : favorable m1_2_0_2 = [] := by decide
example : unfavorable m1_2_0_2 = [] := by decide
example : secure m1_2_0_2 = true := by decide
def m1_2_0_3 : Model := ⟨system,["a"],[b],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_2_0_3 = [] := by decide
example : favorable m1_2_0_3 = [] := by decide
example : unfavorable m1_2_0_3 = [] := by decide
example : secure m1_2_0_3 = true := by decide
def m1_2_0_4 : Model := ⟨system,["a"],[b],0,["q"],["good","bad","q"]⟩
example : rows m1_2_0_4 = [] := by decide
example : favorable m1_2_0_4 = [] := by decide
example : unfavorable m1_2_0_4 = [] := by decide
example : secure m1_2_0_4 = true := by decide
def m1_2_0_5 : Model := ⟨system,["a"],[b],0,["good","q"],["good","bad","q"]⟩
example : rows m1_2_0_5 = [] := by decide
example : favorable m1_2_0_5 = [] := by decide
example : unfavorable m1_2_0_5 = [] := by decide
example : secure m1_2_0_5 = true := by decide
def m1_2_0_6 : Model := ⟨system,["a"],[b],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_2_0_6 = [] := by decide
example : favorable m1_2_0_6 = [] := by decide
example : unfavorable m1_2_0_6 = [] := by decide
example : secure m1_2_0_6 = true := by decide
def m1_2_0_7 : Model := ⟨system,["a"],[b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_2_0_7 = [] := by decide
example : favorable m1_2_0_7 = [] := by decide
example : unfavorable m1_2_0_7 = [] := by decide
example : secure m1_2_0_7 = true := by decide
def m1_2_1_0 : Model := ⟨system,["a"],[b],1,[],["good","bad","q"]⟩
example : rows m1_2_1_0 = [] := by decide
example : favorable m1_2_1_0 = [] := by decide
example : unfavorable m1_2_1_0 = [] := by decide
example : secure m1_2_1_0 = true := by decide
def m1_2_1_1 : Model := ⟨system,["a"],[b],1,["good"],["good","bad","q"]⟩
example : rows m1_2_1_1 = [] := by decide
example : favorable m1_2_1_1 = [] := by decide
example : unfavorable m1_2_1_1 = [] := by decide
example : secure m1_2_1_1 = true := by decide
def m1_2_1_2 : Model := ⟨system,["a"],[b],1,["bad"],["good","bad","q"]⟩
example : rows m1_2_1_2 = [] := by decide
example : favorable m1_2_1_2 = [] := by decide
example : unfavorable m1_2_1_2 = [] := by decide
example : secure m1_2_1_2 = true := by decide
def m1_2_1_3 : Model := ⟨system,["a"],[b],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_2_1_3 = [] := by decide
example : favorable m1_2_1_3 = [] := by decide
example : unfavorable m1_2_1_3 = [] := by decide
example : secure m1_2_1_3 = true := by decide
def m1_2_1_4 : Model := ⟨system,["a"],[b],1,["q"],["good","bad","q"]⟩
example : rows m1_2_1_4 = [] := by decide
example : favorable m1_2_1_4 = [] := by decide
example : unfavorable m1_2_1_4 = [] := by decide
example : secure m1_2_1_4 = true := by decide
def m1_2_1_5 : Model := ⟨system,["a"],[b],1,["good","q"],["good","bad","q"]⟩
example : rows m1_2_1_5 = [] := by decide
example : favorable m1_2_1_5 = [] := by decide
example : unfavorable m1_2_1_5 = [] := by decide
example : secure m1_2_1_5 = true := by decide
def m1_2_1_6 : Model := ⟨system,["a"],[b],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_2_1_6 = [] := by decide
example : favorable m1_2_1_6 = [] := by decide
example : unfavorable m1_2_1_6 = [] := by decide
example : secure m1_2_1_6 = true := by decide
def m1_2_1_7 : Model := ⟨system,["a"],[b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_2_1_7 = [] := by decide
example : favorable m1_2_1_7 = [] := by decide
example : unfavorable m1_2_1_7 = [] := by decide
example : secure m1_2_1_7 = true := by decide
def m1_3_0_0 : Model := ⟨system,["a"],[a,b],0,[],["good","bad","q"]⟩
example : rows m1_3_0_0 = [] := by decide
example : favorable m1_3_0_0 = [] := by decide
example : unfavorable m1_3_0_0 = [] := by decide
example : secure m1_3_0_0 = true := by decide
def m1_3_0_1 : Model := ⟨system,["a"],[a,b],0,["good"],["good","bad","q"]⟩
example : rows m1_3_0_1 = [] := by decide
example : favorable m1_3_0_1 = [] := by decide
example : unfavorable m1_3_0_1 = [] := by decide
example : secure m1_3_0_1 = true := by decide
def m1_3_0_2 : Model := ⟨system,["a"],[a,b],0,["bad"],["good","bad","q"]⟩
example : rows m1_3_0_2 = [] := by decide
example : favorable m1_3_0_2 = [] := by decide
example : unfavorable m1_3_0_2 = [] := by decide
example : secure m1_3_0_2 = true := by decide
def m1_3_0_3 : Model := ⟨system,["a"],[a,b],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_3_0_3 = [] := by decide
example : favorable m1_3_0_3 = [] := by decide
example : unfavorable m1_3_0_3 = [] := by decide
example : secure m1_3_0_3 = true := by decide
def m1_3_0_4 : Model := ⟨system,["a"],[a,b],0,["q"],["good","bad","q"]⟩
example : rows m1_3_0_4 = [] := by decide
example : favorable m1_3_0_4 = [] := by decide
example : unfavorable m1_3_0_4 = [] := by decide
example : secure m1_3_0_4 = true := by decide
def m1_3_0_5 : Model := ⟨system,["a"],[a,b],0,["good","q"],["good","bad","q"]⟩
example : rows m1_3_0_5 = [] := by decide
example : favorable m1_3_0_5 = [] := by decide
example : unfavorable m1_3_0_5 = [] := by decide
example : secure m1_3_0_5 = true := by decide
def m1_3_0_6 : Model := ⟨system,["a"],[a,b],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_3_0_6 = [] := by decide
example : favorable m1_3_0_6 = [] := by decide
example : unfavorable m1_3_0_6 = [] := by decide
example : secure m1_3_0_6 = true := by decide
def m1_3_0_7 : Model := ⟨system,["a"],[a,b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_3_0_7 = [] := by decide
example : favorable m1_3_0_7 = [] := by decide
example : unfavorable m1_3_0_7 = [] := by decide
example : secure m1_3_0_7 = true := by decide
def m1_3_1_0 : Model := ⟨system,["a"],[a,b],1,[],["good","bad","q"]⟩
example : rows m1_3_1_0 = [a] := by decide
example : favorable m1_3_1_0 = [] := by decide
example : unfavorable m1_3_1_0 = [a] := by decide
example : secure m1_3_1_0 = false := by decide
def m1_3_1_1 : Model := ⟨system,["a"],[a,b],1,["good"],["good","bad","q"]⟩
example : rows m1_3_1_1 = [a] := by decide
example : favorable m1_3_1_1 = [a] := by decide
example : unfavorable m1_3_1_1 = [] := by decide
example : secure m1_3_1_1 = true := by decide
def m1_3_1_2 : Model := ⟨system,["a"],[a,b],1,["bad"],["good","bad","q"]⟩
example : rows m1_3_1_2 = [a] := by decide
example : favorable m1_3_1_2 = [] := by decide
example : unfavorable m1_3_1_2 = [a] := by decide
example : secure m1_3_1_2 = false := by decide
def m1_3_1_3 : Model := ⟨system,["a"],[a,b],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_3_1_3 = [a] := by decide
example : favorable m1_3_1_3 = [a] := by decide
example : unfavorable m1_3_1_3 = [] := by decide
example : secure m1_3_1_3 = true := by decide
def m1_3_1_4 : Model := ⟨system,["a"],[a,b],1,["q"],["good","bad","q"]⟩
example : rows m1_3_1_4 = [a] := by decide
example : favorable m1_3_1_4 = [] := by decide
example : unfavorable m1_3_1_4 = [a] := by decide
example : secure m1_3_1_4 = false := by decide
def m1_3_1_5 : Model := ⟨system,["a"],[a,b],1,["good","q"],["good","bad","q"]⟩
example : rows m1_3_1_5 = [a] := by decide
example : favorable m1_3_1_5 = [a] := by decide
example : unfavorable m1_3_1_5 = [] := by decide
example : secure m1_3_1_5 = true := by decide
def m1_3_1_6 : Model := ⟨system,["a"],[a,b],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_3_1_6 = [a] := by decide
example : favorable m1_3_1_6 = [] := by decide
example : unfavorable m1_3_1_6 = [a] := by decide
example : secure m1_3_1_6 = false := by decide
def m1_3_1_7 : Model := ⟨system,["a"],[a,b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_3_1_7 = [a] := by decide
example : favorable m1_3_1_7 = [a] := by decide
example : unfavorable m1_3_1_7 = [] := by decide
example : secure m1_3_1_7 = true := by decide
def m1_4_0_0 : Model := ⟨system,["a"],[c],0,[],["good","bad","q"]⟩
example : rows m1_4_0_0 = [c] := by decide
example : favorable m1_4_0_0 = [] := by decide
example : unfavorable m1_4_0_0 = [c] := by decide
example : secure m1_4_0_0 = false := by decide
def m1_4_0_1 : Model := ⟨system,["a"],[c],0,["good"],["good","bad","q"]⟩
example : rows m1_4_0_1 = [c] := by decide
example : favorable m1_4_0_1 = [] := by decide
example : unfavorable m1_4_0_1 = [c] := by decide
example : secure m1_4_0_1 = false := by decide
def m1_4_0_2 : Model := ⟨system,["a"],[c],0,["bad"],["good","bad","q"]⟩
example : rows m1_4_0_2 = [c] := by decide
example : favorable m1_4_0_2 = [] := by decide
example : unfavorable m1_4_0_2 = [c] := by decide
example : secure m1_4_0_2 = false := by decide
def m1_4_0_3 : Model := ⟨system,["a"],[c],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_4_0_3 = [c] := by decide
example : favorable m1_4_0_3 = [] := by decide
example : unfavorable m1_4_0_3 = [c] := by decide
example : secure m1_4_0_3 = false := by decide
def m1_4_0_4 : Model := ⟨system,["a"],[c],0,["q"],["good","bad","q"]⟩
example : rows m1_4_0_4 = [c] := by decide
example : favorable m1_4_0_4 = [c] := by decide
example : unfavorable m1_4_0_4 = [] := by decide
example : secure m1_4_0_4 = true := by decide
def m1_4_0_5 : Model := ⟨system,["a"],[c],0,["good","q"],["good","bad","q"]⟩
example : rows m1_4_0_5 = [c] := by decide
example : favorable m1_4_0_5 = [c] := by decide
example : unfavorable m1_4_0_5 = [] := by decide
example : secure m1_4_0_5 = true := by decide
def m1_4_0_6 : Model := ⟨system,["a"],[c],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_4_0_6 = [c] := by decide
example : favorable m1_4_0_6 = [c] := by decide
example : unfavorable m1_4_0_6 = [] := by decide
example : secure m1_4_0_6 = true := by decide
def m1_4_0_7 : Model := ⟨system,["a"],[c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_4_0_7 = [c] := by decide
example : favorable m1_4_0_7 = [c] := by decide
example : unfavorable m1_4_0_7 = [] := by decide
example : secure m1_4_0_7 = true := by decide
def m1_4_1_0 : Model := ⟨system,["a"],[c],1,[],["good","bad","q"]⟩
example : rows m1_4_1_0 = [c] := by decide
example : favorable m1_4_1_0 = [] := by decide
example : unfavorable m1_4_1_0 = [c] := by decide
example : secure m1_4_1_0 = false := by decide
def m1_4_1_1 : Model := ⟨system,["a"],[c],1,["good"],["good","bad","q"]⟩
example : rows m1_4_1_1 = [c] := by decide
example : favorable m1_4_1_1 = [] := by decide
example : unfavorable m1_4_1_1 = [c] := by decide
example : secure m1_4_1_1 = false := by decide
def m1_4_1_2 : Model := ⟨system,["a"],[c],1,["bad"],["good","bad","q"]⟩
example : rows m1_4_1_2 = [c] := by decide
example : favorable m1_4_1_2 = [] := by decide
example : unfavorable m1_4_1_2 = [c] := by decide
example : secure m1_4_1_2 = false := by decide
def m1_4_1_3 : Model := ⟨system,["a"],[c],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_4_1_3 = [c] := by decide
example : favorable m1_4_1_3 = [] := by decide
example : unfavorable m1_4_1_3 = [c] := by decide
example : secure m1_4_1_3 = false := by decide
def m1_4_1_4 : Model := ⟨system,["a"],[c],1,["q"],["good","bad","q"]⟩
example : rows m1_4_1_4 = [c] := by decide
example : favorable m1_4_1_4 = [c] := by decide
example : unfavorable m1_4_1_4 = [] := by decide
example : secure m1_4_1_4 = true := by decide
def m1_4_1_5 : Model := ⟨system,["a"],[c],1,["good","q"],["good","bad","q"]⟩
example : rows m1_4_1_5 = [c] := by decide
example : favorable m1_4_1_5 = [c] := by decide
example : unfavorable m1_4_1_5 = [] := by decide
example : secure m1_4_1_5 = true := by decide
def m1_4_1_6 : Model := ⟨system,["a"],[c],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_4_1_6 = [c] := by decide
example : favorable m1_4_1_6 = [c] := by decide
example : unfavorable m1_4_1_6 = [] := by decide
example : secure m1_4_1_6 = true := by decide
def m1_4_1_7 : Model := ⟨system,["a"],[c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_4_1_7 = [c] := by decide
example : favorable m1_4_1_7 = [c] := by decide
example : unfavorable m1_4_1_7 = [] := by decide
example : secure m1_4_1_7 = true := by decide
def m1_5_0_0 : Model := ⟨system,["a"],[a,c],0,[],["good","bad","q"]⟩
example : rows m1_5_0_0 = [c] := by decide
example : favorable m1_5_0_0 = [] := by decide
example : unfavorable m1_5_0_0 = [c] := by decide
example : secure m1_5_0_0 = false := by decide
def m1_5_0_1 : Model := ⟨system,["a"],[a,c],0,["good"],["good","bad","q"]⟩
example : rows m1_5_0_1 = [c] := by decide
example : favorable m1_5_0_1 = [] := by decide
example : unfavorable m1_5_0_1 = [c] := by decide
example : secure m1_5_0_1 = false := by decide
def m1_5_0_2 : Model := ⟨system,["a"],[a,c],0,["bad"],["good","bad","q"]⟩
example : rows m1_5_0_2 = [c] := by decide
example : favorable m1_5_0_2 = [] := by decide
example : unfavorable m1_5_0_2 = [c] := by decide
example : secure m1_5_0_2 = false := by decide
def m1_5_0_3 : Model := ⟨system,["a"],[a,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_5_0_3 = [c] := by decide
example : favorable m1_5_0_3 = [] := by decide
example : unfavorable m1_5_0_3 = [c] := by decide
example : secure m1_5_0_3 = false := by decide
def m1_5_0_4 : Model := ⟨system,["a"],[a,c],0,["q"],["good","bad","q"]⟩
example : rows m1_5_0_4 = [c] := by decide
example : favorable m1_5_0_4 = [c] := by decide
example : unfavorable m1_5_0_4 = [] := by decide
example : secure m1_5_0_4 = true := by decide
def m1_5_0_5 : Model := ⟨system,["a"],[a,c],0,["good","q"],["good","bad","q"]⟩
example : rows m1_5_0_5 = [c] := by decide
example : favorable m1_5_0_5 = [c] := by decide
example : unfavorable m1_5_0_5 = [] := by decide
example : secure m1_5_0_5 = true := by decide
def m1_5_0_6 : Model := ⟨system,["a"],[a,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_5_0_6 = [c] := by decide
example : favorable m1_5_0_6 = [c] := by decide
example : unfavorable m1_5_0_6 = [] := by decide
example : secure m1_5_0_6 = true := by decide
def m1_5_0_7 : Model := ⟨system,["a"],[a,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_5_0_7 = [c] := by decide
example : favorable m1_5_0_7 = [c] := by decide
example : unfavorable m1_5_0_7 = [] := by decide
example : secure m1_5_0_7 = true := by decide
def m1_5_1_0 : Model := ⟨system,["a"],[a,c],1,[],["good","bad","q"]⟩
example : rows m1_5_1_0 = [a,c] := by decide
example : favorable m1_5_1_0 = [] := by decide
example : unfavorable m1_5_1_0 = [a,c] := by decide
example : secure m1_5_1_0 = false := by decide
def m1_5_1_1 : Model := ⟨system,["a"],[a,c],1,["good"],["good","bad","q"]⟩
example : rows m1_5_1_1 = [a,c] := by decide
example : favorable m1_5_1_1 = [a] := by decide
example : unfavorable m1_5_1_1 = [c] := by decide
example : secure m1_5_1_1 = false := by decide
def m1_5_1_2 : Model := ⟨system,["a"],[a,c],1,["bad"],["good","bad","q"]⟩
example : rows m1_5_1_2 = [a,c] := by decide
example : favorable m1_5_1_2 = [] := by decide
example : unfavorable m1_5_1_2 = [a,c] := by decide
example : secure m1_5_1_2 = false := by decide
def m1_5_1_3 : Model := ⟨system,["a"],[a,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_5_1_3 = [a,c] := by decide
example : favorable m1_5_1_3 = [a] := by decide
example : unfavorable m1_5_1_3 = [c] := by decide
example : secure m1_5_1_3 = false := by decide
def m1_5_1_4 : Model := ⟨system,["a"],[a,c],1,["q"],["good","bad","q"]⟩
example : rows m1_5_1_4 = [a,c] := by decide
example : favorable m1_5_1_4 = [c] := by decide
example : unfavorable m1_5_1_4 = [a] := by decide
example : secure m1_5_1_4 = false := by decide
def m1_5_1_5 : Model := ⟨system,["a"],[a,c],1,["good","q"],["good","bad","q"]⟩
example : rows m1_5_1_5 = [a,c] := by decide
example : favorable m1_5_1_5 = [a,c] := by decide
example : unfavorable m1_5_1_5 = [] := by decide
example : secure m1_5_1_5 = true := by decide
def m1_5_1_6 : Model := ⟨system,["a"],[a,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_5_1_6 = [a,c] := by decide
example : favorable m1_5_1_6 = [c] := by decide
example : unfavorable m1_5_1_6 = [a] := by decide
example : secure m1_5_1_6 = false := by decide
def m1_5_1_7 : Model := ⟨system,["a"],[a,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_5_1_7 = [a,c] := by decide
example : favorable m1_5_1_7 = [a,c] := by decide
example : unfavorable m1_5_1_7 = [] := by decide
example : secure m1_5_1_7 = true := by decide
def m1_6_0_0 : Model := ⟨system,["a"],[b,c],0,[],["good","bad","q"]⟩
example : rows m1_6_0_0 = [c] := by decide
example : favorable m1_6_0_0 = [] := by decide
example : unfavorable m1_6_0_0 = [c] := by decide
example : secure m1_6_0_0 = false := by decide
def m1_6_0_1 : Model := ⟨system,["a"],[b,c],0,["good"],["good","bad","q"]⟩
example : rows m1_6_0_1 = [c] := by decide
example : favorable m1_6_0_1 = [] := by decide
example : unfavorable m1_6_0_1 = [c] := by decide
example : secure m1_6_0_1 = false := by decide
def m1_6_0_2 : Model := ⟨system,["a"],[b,c],0,["bad"],["good","bad","q"]⟩
example : rows m1_6_0_2 = [c] := by decide
example : favorable m1_6_0_2 = [] := by decide
example : unfavorable m1_6_0_2 = [c] := by decide
example : secure m1_6_0_2 = false := by decide
def m1_6_0_3 : Model := ⟨system,["a"],[b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_6_0_3 = [c] := by decide
example : favorable m1_6_0_3 = [] := by decide
example : unfavorable m1_6_0_3 = [c] := by decide
example : secure m1_6_0_3 = false := by decide
def m1_6_0_4 : Model := ⟨system,["a"],[b,c],0,["q"],["good","bad","q"]⟩
example : rows m1_6_0_4 = [c] := by decide
example : favorable m1_6_0_4 = [c] := by decide
example : unfavorable m1_6_0_4 = [] := by decide
example : secure m1_6_0_4 = true := by decide
def m1_6_0_5 : Model := ⟨system,["a"],[b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m1_6_0_5 = [c] := by decide
example : favorable m1_6_0_5 = [c] := by decide
example : unfavorable m1_6_0_5 = [] := by decide
example : secure m1_6_0_5 = true := by decide
def m1_6_0_6 : Model := ⟨system,["a"],[b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_6_0_6 = [c] := by decide
example : favorable m1_6_0_6 = [c] := by decide
example : unfavorable m1_6_0_6 = [] := by decide
example : secure m1_6_0_6 = true := by decide
def m1_6_0_7 : Model := ⟨system,["a"],[b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_6_0_7 = [c] := by decide
example : favorable m1_6_0_7 = [c] := by decide
example : unfavorable m1_6_0_7 = [] := by decide
example : secure m1_6_0_7 = true := by decide
def m1_6_1_0 : Model := ⟨system,["a"],[b,c],1,[],["good","bad","q"]⟩
example : rows m1_6_1_0 = [c] := by decide
example : favorable m1_6_1_0 = [] := by decide
example : unfavorable m1_6_1_0 = [c] := by decide
example : secure m1_6_1_0 = false := by decide
def m1_6_1_1 : Model := ⟨system,["a"],[b,c],1,["good"],["good","bad","q"]⟩
example : rows m1_6_1_1 = [c] := by decide
example : favorable m1_6_1_1 = [] := by decide
example : unfavorable m1_6_1_1 = [c] := by decide
example : secure m1_6_1_1 = false := by decide
def m1_6_1_2 : Model := ⟨system,["a"],[b,c],1,["bad"],["good","bad","q"]⟩
example : rows m1_6_1_2 = [c] := by decide
example : favorable m1_6_1_2 = [] := by decide
example : unfavorable m1_6_1_2 = [c] := by decide
example : secure m1_6_1_2 = false := by decide
def m1_6_1_3 : Model := ⟨system,["a"],[b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_6_1_3 = [c] := by decide
example : favorable m1_6_1_3 = [] := by decide
example : unfavorable m1_6_1_3 = [c] := by decide
example : secure m1_6_1_3 = false := by decide
def m1_6_1_4 : Model := ⟨system,["a"],[b,c],1,["q"],["good","bad","q"]⟩
example : rows m1_6_1_4 = [c] := by decide
example : favorable m1_6_1_4 = [c] := by decide
example : unfavorable m1_6_1_4 = [] := by decide
example : secure m1_6_1_4 = true := by decide
def m1_6_1_5 : Model := ⟨system,["a"],[b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m1_6_1_5 = [c] := by decide
example : favorable m1_6_1_5 = [c] := by decide
example : unfavorable m1_6_1_5 = [] := by decide
example : secure m1_6_1_5 = true := by decide
def m1_6_1_6 : Model := ⟨system,["a"],[b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_6_1_6 = [c] := by decide
example : favorable m1_6_1_6 = [c] := by decide
example : unfavorable m1_6_1_6 = [] := by decide
example : secure m1_6_1_6 = true := by decide
def m1_6_1_7 : Model := ⟨system,["a"],[b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_6_1_7 = [c] := by decide
example : favorable m1_6_1_7 = [c] := by decide
example : unfavorable m1_6_1_7 = [] := by decide
example : secure m1_6_1_7 = true := by decide
def m1_7_0_0 : Model := ⟨system,["a"],[a,b,c],0,[],["good","bad","q"]⟩
example : rows m1_7_0_0 = [c] := by decide
example : favorable m1_7_0_0 = [] := by decide
example : unfavorable m1_7_0_0 = [c] := by decide
example : secure m1_7_0_0 = false := by decide
def m1_7_0_1 : Model := ⟨system,["a"],[a,b,c],0,["good"],["good","bad","q"]⟩
example : rows m1_7_0_1 = [c] := by decide
example : favorable m1_7_0_1 = [] := by decide
example : unfavorable m1_7_0_1 = [c] := by decide
example : secure m1_7_0_1 = false := by decide
def m1_7_0_2 : Model := ⟨system,["a"],[a,b,c],0,["bad"],["good","bad","q"]⟩
example : rows m1_7_0_2 = [c] := by decide
example : favorable m1_7_0_2 = [] := by decide
example : unfavorable m1_7_0_2 = [c] := by decide
example : secure m1_7_0_2 = false := by decide
def m1_7_0_3 : Model := ⟨system,["a"],[a,b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m1_7_0_3 = [c] := by decide
example : favorable m1_7_0_3 = [] := by decide
example : unfavorable m1_7_0_3 = [c] := by decide
example : secure m1_7_0_3 = false := by decide
def m1_7_0_4 : Model := ⟨system,["a"],[a,b,c],0,["q"],["good","bad","q"]⟩
example : rows m1_7_0_4 = [c] := by decide
example : favorable m1_7_0_4 = [c] := by decide
example : unfavorable m1_7_0_4 = [] := by decide
example : secure m1_7_0_4 = true := by decide
def m1_7_0_5 : Model := ⟨system,["a"],[a,b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m1_7_0_5 = [c] := by decide
example : favorable m1_7_0_5 = [c] := by decide
example : unfavorable m1_7_0_5 = [] := by decide
example : secure m1_7_0_5 = true := by decide
def m1_7_0_6 : Model := ⟨system,["a"],[a,b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m1_7_0_6 = [c] := by decide
example : favorable m1_7_0_6 = [c] := by decide
example : unfavorable m1_7_0_6 = [] := by decide
example : secure m1_7_0_6 = true := by decide
def m1_7_0_7 : Model := ⟨system,["a"],[a,b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_7_0_7 = [c] := by decide
example : favorable m1_7_0_7 = [c] := by decide
example : unfavorable m1_7_0_7 = [] := by decide
example : secure m1_7_0_7 = true := by decide
def m1_7_1_0 : Model := ⟨system,["a"],[a,b,c],1,[],["good","bad","q"]⟩
example : rows m1_7_1_0 = [a,c] := by decide
example : favorable m1_7_1_0 = [] := by decide
example : unfavorable m1_7_1_0 = [a,c] := by decide
example : secure m1_7_1_0 = false := by decide
def m1_7_1_1 : Model := ⟨system,["a"],[a,b,c],1,["good"],["good","bad","q"]⟩
example : rows m1_7_1_1 = [a,c] := by decide
example : favorable m1_7_1_1 = [a] := by decide
example : unfavorable m1_7_1_1 = [c] := by decide
example : secure m1_7_1_1 = false := by decide
def m1_7_1_2 : Model := ⟨system,["a"],[a,b,c],1,["bad"],["good","bad","q"]⟩
example : rows m1_7_1_2 = [a,c] := by decide
example : favorable m1_7_1_2 = [] := by decide
example : unfavorable m1_7_1_2 = [a,c] := by decide
example : secure m1_7_1_2 = false := by decide
def m1_7_1_3 : Model := ⟨system,["a"],[a,b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m1_7_1_3 = [a,c] := by decide
example : favorable m1_7_1_3 = [a] := by decide
example : unfavorable m1_7_1_3 = [c] := by decide
example : secure m1_7_1_3 = false := by decide
def m1_7_1_4 : Model := ⟨system,["a"],[a,b,c],1,["q"],["good","bad","q"]⟩
example : rows m1_7_1_4 = [a,c] := by decide
example : favorable m1_7_1_4 = [c] := by decide
example : unfavorable m1_7_1_4 = [a] := by decide
example : secure m1_7_1_4 = false := by decide
def m1_7_1_5 : Model := ⟨system,["a"],[a,b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m1_7_1_5 = [a,c] := by decide
example : favorable m1_7_1_5 = [a,c] := by decide
example : unfavorable m1_7_1_5 = [] := by decide
example : secure m1_7_1_5 = true := by decide
def m1_7_1_6 : Model := ⟨system,["a"],[a,b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m1_7_1_6 = [a,c] := by decide
example : favorable m1_7_1_6 = [c] := by decide
example : unfavorable m1_7_1_6 = [a] := by decide
example : secure m1_7_1_6 = false := by decide
def m1_7_1_7 : Model := ⟨system,["a"],[a,b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m1_7_1_7 = [a,c] := by decide
example : favorable m1_7_1_7 = [a,c] := by decide
example : unfavorable m1_7_1_7 = [] := by decide
example : secure m1_7_1_7 = true := by decide
def m2_0_0_0 : Model := ⟨system,["b"],[],0,[],["good","bad","q"]⟩
example : rows m2_0_0_0 = [] := by decide
example : favorable m2_0_0_0 = [] := by decide
example : unfavorable m2_0_0_0 = [] := by decide
example : secure m2_0_0_0 = true := by decide
def m2_0_0_1 : Model := ⟨system,["b"],[],0,["good"],["good","bad","q"]⟩
example : rows m2_0_0_1 = [] := by decide
example : favorable m2_0_0_1 = [] := by decide
example : unfavorable m2_0_0_1 = [] := by decide
example : secure m2_0_0_1 = true := by decide
def m2_0_0_2 : Model := ⟨system,["b"],[],0,["bad"],["good","bad","q"]⟩
example : rows m2_0_0_2 = [] := by decide
example : favorable m2_0_0_2 = [] := by decide
example : unfavorable m2_0_0_2 = [] := by decide
example : secure m2_0_0_2 = true := by decide
def m2_0_0_3 : Model := ⟨system,["b"],[],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_0_0_3 = [] := by decide
example : favorable m2_0_0_3 = [] := by decide
example : unfavorable m2_0_0_3 = [] := by decide
example : secure m2_0_0_3 = true := by decide
def m2_0_0_4 : Model := ⟨system,["b"],[],0,["q"],["good","bad","q"]⟩
example : rows m2_0_0_4 = [] := by decide
example : favorable m2_0_0_4 = [] := by decide
example : unfavorable m2_0_0_4 = [] := by decide
example : secure m2_0_0_4 = true := by decide
def m2_0_0_5 : Model := ⟨system,["b"],[],0,["good","q"],["good","bad","q"]⟩
example : rows m2_0_0_5 = [] := by decide
example : favorable m2_0_0_5 = [] := by decide
example : unfavorable m2_0_0_5 = [] := by decide
example : secure m2_0_0_5 = true := by decide
def m2_0_0_6 : Model := ⟨system,["b"],[],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_0_0_6 = [] := by decide
example : favorable m2_0_0_6 = [] := by decide
example : unfavorable m2_0_0_6 = [] := by decide
example : secure m2_0_0_6 = true := by decide
def m2_0_0_7 : Model := ⟨system,["b"],[],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_0_0_7 = [] := by decide
example : favorable m2_0_0_7 = [] := by decide
example : unfavorable m2_0_0_7 = [] := by decide
example : secure m2_0_0_7 = true := by decide
def m2_0_1_0 : Model := ⟨system,["b"],[],1,[],["good","bad","q"]⟩
example : rows m2_0_1_0 = [] := by decide
example : favorable m2_0_1_0 = [] := by decide
example : unfavorable m2_0_1_0 = [] := by decide
example : secure m2_0_1_0 = true := by decide
def m2_0_1_1 : Model := ⟨system,["b"],[],1,["good"],["good","bad","q"]⟩
example : rows m2_0_1_1 = [] := by decide
example : favorable m2_0_1_1 = [] := by decide
example : unfavorable m2_0_1_1 = [] := by decide
example : secure m2_0_1_1 = true := by decide
def m2_0_1_2 : Model := ⟨system,["b"],[],1,["bad"],["good","bad","q"]⟩
example : rows m2_0_1_2 = [] := by decide
example : favorable m2_0_1_2 = [] := by decide
example : unfavorable m2_0_1_2 = [] := by decide
example : secure m2_0_1_2 = true := by decide
def m2_0_1_3 : Model := ⟨system,["b"],[],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_0_1_3 = [] := by decide
example : favorable m2_0_1_3 = [] := by decide
example : unfavorable m2_0_1_3 = [] := by decide
example : secure m2_0_1_3 = true := by decide
def m2_0_1_4 : Model := ⟨system,["b"],[],1,["q"],["good","bad","q"]⟩
example : rows m2_0_1_4 = [] := by decide
example : favorable m2_0_1_4 = [] := by decide
example : unfavorable m2_0_1_4 = [] := by decide
example : secure m2_0_1_4 = true := by decide
def m2_0_1_5 : Model := ⟨system,["b"],[],1,["good","q"],["good","bad","q"]⟩
example : rows m2_0_1_5 = [] := by decide
example : favorable m2_0_1_5 = [] := by decide
example : unfavorable m2_0_1_5 = [] := by decide
example : secure m2_0_1_5 = true := by decide
def m2_0_1_6 : Model := ⟨system,["b"],[],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_0_1_6 = [] := by decide
example : favorable m2_0_1_6 = [] := by decide
example : unfavorable m2_0_1_6 = [] := by decide
example : secure m2_0_1_6 = true := by decide
def m2_0_1_7 : Model := ⟨system,["b"],[],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_0_1_7 = [] := by decide
example : favorable m2_0_1_7 = [] := by decide
example : unfavorable m2_0_1_7 = [] := by decide
example : secure m2_0_1_7 = true := by decide
def m2_1_0_0 : Model := ⟨system,["b"],[a],0,[],["good","bad","q"]⟩
example : rows m2_1_0_0 = [] := by decide
example : favorable m2_1_0_0 = [] := by decide
example : unfavorable m2_1_0_0 = [] := by decide
example : secure m2_1_0_0 = true := by decide
def m2_1_0_1 : Model := ⟨system,["b"],[a],0,["good"],["good","bad","q"]⟩
example : rows m2_1_0_1 = [] := by decide
example : favorable m2_1_0_1 = [] := by decide
example : unfavorable m2_1_0_1 = [] := by decide
example : secure m2_1_0_1 = true := by decide
def m2_1_0_2 : Model := ⟨system,["b"],[a],0,["bad"],["good","bad","q"]⟩
example : rows m2_1_0_2 = [] := by decide
example : favorable m2_1_0_2 = [] := by decide
example : unfavorable m2_1_0_2 = [] := by decide
example : secure m2_1_0_2 = true := by decide
def m2_1_0_3 : Model := ⟨system,["b"],[a],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_1_0_3 = [] := by decide
example : favorable m2_1_0_3 = [] := by decide
example : unfavorable m2_1_0_3 = [] := by decide
example : secure m2_1_0_3 = true := by decide
def m2_1_0_4 : Model := ⟨system,["b"],[a],0,["q"],["good","bad","q"]⟩
example : rows m2_1_0_4 = [] := by decide
example : favorable m2_1_0_4 = [] := by decide
example : unfavorable m2_1_0_4 = [] := by decide
example : secure m2_1_0_4 = true := by decide
def m2_1_0_5 : Model := ⟨system,["b"],[a],0,["good","q"],["good","bad","q"]⟩
example : rows m2_1_0_5 = [] := by decide
example : favorable m2_1_0_5 = [] := by decide
example : unfavorable m2_1_0_5 = [] := by decide
example : secure m2_1_0_5 = true := by decide
def m2_1_0_6 : Model := ⟨system,["b"],[a],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_1_0_6 = [] := by decide
example : favorable m2_1_0_6 = [] := by decide
example : unfavorable m2_1_0_6 = [] := by decide
example : secure m2_1_0_6 = true := by decide
def m2_1_0_7 : Model := ⟨system,["b"],[a],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_1_0_7 = [] := by decide
example : favorable m2_1_0_7 = [] := by decide
example : unfavorable m2_1_0_7 = [] := by decide
example : secure m2_1_0_7 = true := by decide
def m2_1_1_0 : Model := ⟨system,["b"],[a],1,[],["good","bad","q"]⟩
example : rows m2_1_1_0 = [] := by decide
example : favorable m2_1_1_0 = [] := by decide
example : unfavorable m2_1_1_0 = [] := by decide
example : secure m2_1_1_0 = true := by decide
def m2_1_1_1 : Model := ⟨system,["b"],[a],1,["good"],["good","bad","q"]⟩
example : rows m2_1_1_1 = [] := by decide
example : favorable m2_1_1_1 = [] := by decide
example : unfavorable m2_1_1_1 = [] := by decide
example : secure m2_1_1_1 = true := by decide
def m2_1_1_2 : Model := ⟨system,["b"],[a],1,["bad"],["good","bad","q"]⟩
example : rows m2_1_1_2 = [] := by decide
example : favorable m2_1_1_2 = [] := by decide
example : unfavorable m2_1_1_2 = [] := by decide
example : secure m2_1_1_2 = true := by decide
def m2_1_1_3 : Model := ⟨system,["b"],[a],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_1_1_3 = [] := by decide
example : favorable m2_1_1_3 = [] := by decide
example : unfavorable m2_1_1_3 = [] := by decide
example : secure m2_1_1_3 = true := by decide
def m2_1_1_4 : Model := ⟨system,["b"],[a],1,["q"],["good","bad","q"]⟩
example : rows m2_1_1_4 = [] := by decide
example : favorable m2_1_1_4 = [] := by decide
example : unfavorable m2_1_1_4 = [] := by decide
example : secure m2_1_1_4 = true := by decide
def m2_1_1_5 : Model := ⟨system,["b"],[a],1,["good","q"],["good","bad","q"]⟩
example : rows m2_1_1_5 = [] := by decide
example : favorable m2_1_1_5 = [] := by decide
example : unfavorable m2_1_1_5 = [] := by decide
example : secure m2_1_1_5 = true := by decide
def m2_1_1_6 : Model := ⟨system,["b"],[a],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_1_1_6 = [] := by decide
example : favorable m2_1_1_6 = [] := by decide
example : unfavorable m2_1_1_6 = [] := by decide
example : secure m2_1_1_6 = true := by decide
def m2_1_1_7 : Model := ⟨system,["b"],[a],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_1_1_7 = [] := by decide
example : favorable m2_1_1_7 = [] := by decide
example : unfavorable m2_1_1_7 = [] := by decide
example : secure m2_1_1_7 = true := by decide
def m2_2_0_0 : Model := ⟨system,["b"],[b],0,[],["good","bad","q"]⟩
example : rows m2_2_0_0 = [] := by decide
example : favorable m2_2_0_0 = [] := by decide
example : unfavorable m2_2_0_0 = [] := by decide
example : secure m2_2_0_0 = true := by decide
def m2_2_0_1 : Model := ⟨system,["b"],[b],0,["good"],["good","bad","q"]⟩
example : rows m2_2_0_1 = [] := by decide
example : favorable m2_2_0_1 = [] := by decide
example : unfavorable m2_2_0_1 = [] := by decide
example : secure m2_2_0_1 = true := by decide
def m2_2_0_2 : Model := ⟨system,["b"],[b],0,["bad"],["good","bad","q"]⟩
example : rows m2_2_0_2 = [] := by decide
example : favorable m2_2_0_2 = [] := by decide
example : unfavorable m2_2_0_2 = [] := by decide
example : secure m2_2_0_2 = true := by decide
def m2_2_0_3 : Model := ⟨system,["b"],[b],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_2_0_3 = [] := by decide
example : favorable m2_2_0_3 = [] := by decide
example : unfavorable m2_2_0_3 = [] := by decide
example : secure m2_2_0_3 = true := by decide
def m2_2_0_4 : Model := ⟨system,["b"],[b],0,["q"],["good","bad","q"]⟩
example : rows m2_2_0_4 = [] := by decide
example : favorable m2_2_0_4 = [] := by decide
example : unfavorable m2_2_0_4 = [] := by decide
example : secure m2_2_0_4 = true := by decide
def m2_2_0_5 : Model := ⟨system,["b"],[b],0,["good","q"],["good","bad","q"]⟩
example : rows m2_2_0_5 = [] := by decide
example : favorable m2_2_0_5 = [] := by decide
example : unfavorable m2_2_0_5 = [] := by decide
example : secure m2_2_0_5 = true := by decide
def m2_2_0_6 : Model := ⟨system,["b"],[b],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_2_0_6 = [] := by decide
example : favorable m2_2_0_6 = [] := by decide
example : unfavorable m2_2_0_6 = [] := by decide
example : secure m2_2_0_6 = true := by decide
def m2_2_0_7 : Model := ⟨system,["b"],[b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_2_0_7 = [] := by decide
example : favorable m2_2_0_7 = [] := by decide
example : unfavorable m2_2_0_7 = [] := by decide
example : secure m2_2_0_7 = true := by decide
def m2_2_1_0 : Model := ⟨system,["b"],[b],1,[],["good","bad","q"]⟩
example : rows m2_2_1_0 = [b] := by decide
example : favorable m2_2_1_0 = [] := by decide
example : unfavorable m2_2_1_0 = [b] := by decide
example : secure m2_2_1_0 = false := by decide
def m2_2_1_1 : Model := ⟨system,["b"],[b],1,["good"],["good","bad","q"]⟩
example : rows m2_2_1_1 = [b] := by decide
example : favorable m2_2_1_1 = [] := by decide
example : unfavorable m2_2_1_1 = [b] := by decide
example : secure m2_2_1_1 = false := by decide
def m2_2_1_2 : Model := ⟨system,["b"],[b],1,["bad"],["good","bad","q"]⟩
example : rows m2_2_1_2 = [b] := by decide
example : favorable m2_2_1_2 = [b] := by decide
example : unfavorable m2_2_1_2 = [] := by decide
example : secure m2_2_1_2 = true := by decide
def m2_2_1_3 : Model := ⟨system,["b"],[b],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_2_1_3 = [b] := by decide
example : favorable m2_2_1_3 = [b] := by decide
example : unfavorable m2_2_1_3 = [] := by decide
example : secure m2_2_1_3 = true := by decide
def m2_2_1_4 : Model := ⟨system,["b"],[b],1,["q"],["good","bad","q"]⟩
example : rows m2_2_1_4 = [b] := by decide
example : favorable m2_2_1_4 = [] := by decide
example : unfavorable m2_2_1_4 = [b] := by decide
example : secure m2_2_1_4 = false := by decide
def m2_2_1_5 : Model := ⟨system,["b"],[b],1,["good","q"],["good","bad","q"]⟩
example : rows m2_2_1_5 = [b] := by decide
example : favorable m2_2_1_5 = [] := by decide
example : unfavorable m2_2_1_5 = [b] := by decide
example : secure m2_2_1_5 = false := by decide
def m2_2_1_6 : Model := ⟨system,["b"],[b],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_2_1_6 = [b] := by decide
example : favorable m2_2_1_6 = [b] := by decide
example : unfavorable m2_2_1_6 = [] := by decide
example : secure m2_2_1_6 = true := by decide
def m2_2_1_7 : Model := ⟨system,["b"],[b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_2_1_7 = [b] := by decide
example : favorable m2_2_1_7 = [b] := by decide
example : unfavorable m2_2_1_7 = [] := by decide
example : secure m2_2_1_7 = true := by decide
def m2_3_0_0 : Model := ⟨system,["b"],[a,b],0,[],["good","bad","q"]⟩
example : rows m2_3_0_0 = [] := by decide
example : favorable m2_3_0_0 = [] := by decide
example : unfavorable m2_3_0_0 = [] := by decide
example : secure m2_3_0_0 = true := by decide
def m2_3_0_1 : Model := ⟨system,["b"],[a,b],0,["good"],["good","bad","q"]⟩
example : rows m2_3_0_1 = [] := by decide
example : favorable m2_3_0_1 = [] := by decide
example : unfavorable m2_3_0_1 = [] := by decide
example : secure m2_3_0_1 = true := by decide
def m2_3_0_2 : Model := ⟨system,["b"],[a,b],0,["bad"],["good","bad","q"]⟩
example : rows m2_3_0_2 = [] := by decide
example : favorable m2_3_0_2 = [] := by decide
example : unfavorable m2_3_0_2 = [] := by decide
example : secure m2_3_0_2 = true := by decide
def m2_3_0_3 : Model := ⟨system,["b"],[a,b],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_3_0_3 = [] := by decide
example : favorable m2_3_0_3 = [] := by decide
example : unfavorable m2_3_0_3 = [] := by decide
example : secure m2_3_0_3 = true := by decide
def m2_3_0_4 : Model := ⟨system,["b"],[a,b],0,["q"],["good","bad","q"]⟩
example : rows m2_3_0_4 = [] := by decide
example : favorable m2_3_0_4 = [] := by decide
example : unfavorable m2_3_0_4 = [] := by decide
example : secure m2_3_0_4 = true := by decide
def m2_3_0_5 : Model := ⟨system,["b"],[a,b],0,["good","q"],["good","bad","q"]⟩
example : rows m2_3_0_5 = [] := by decide
example : favorable m2_3_0_5 = [] := by decide
example : unfavorable m2_3_0_5 = [] := by decide
example : secure m2_3_0_5 = true := by decide
def m2_3_0_6 : Model := ⟨system,["b"],[a,b],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_3_0_6 = [] := by decide
example : favorable m2_3_0_6 = [] := by decide
example : unfavorable m2_3_0_6 = [] := by decide
example : secure m2_3_0_6 = true := by decide
def m2_3_0_7 : Model := ⟨system,["b"],[a,b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_3_0_7 = [] := by decide
example : favorable m2_3_0_7 = [] := by decide
example : unfavorable m2_3_0_7 = [] := by decide
example : secure m2_3_0_7 = true := by decide
def m2_3_1_0 : Model := ⟨system,["b"],[a,b],1,[],["good","bad","q"]⟩
example : rows m2_3_1_0 = [b] := by decide
example : favorable m2_3_1_0 = [] := by decide
example : unfavorable m2_3_1_0 = [b] := by decide
example : secure m2_3_1_0 = false := by decide
def m2_3_1_1 : Model := ⟨system,["b"],[a,b],1,["good"],["good","bad","q"]⟩
example : rows m2_3_1_1 = [b] := by decide
example : favorable m2_3_1_1 = [] := by decide
example : unfavorable m2_3_1_1 = [b] := by decide
example : secure m2_3_1_1 = false := by decide
def m2_3_1_2 : Model := ⟨system,["b"],[a,b],1,["bad"],["good","bad","q"]⟩
example : rows m2_3_1_2 = [b] := by decide
example : favorable m2_3_1_2 = [b] := by decide
example : unfavorable m2_3_1_2 = [] := by decide
example : secure m2_3_1_2 = true := by decide
def m2_3_1_3 : Model := ⟨system,["b"],[a,b],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_3_1_3 = [b] := by decide
example : favorable m2_3_1_3 = [b] := by decide
example : unfavorable m2_3_1_3 = [] := by decide
example : secure m2_3_1_3 = true := by decide
def m2_3_1_4 : Model := ⟨system,["b"],[a,b],1,["q"],["good","bad","q"]⟩
example : rows m2_3_1_4 = [b] := by decide
example : favorable m2_3_1_4 = [] := by decide
example : unfavorable m2_3_1_4 = [b] := by decide
example : secure m2_3_1_4 = false := by decide
def m2_3_1_5 : Model := ⟨system,["b"],[a,b],1,["good","q"],["good","bad","q"]⟩
example : rows m2_3_1_5 = [b] := by decide
example : favorable m2_3_1_5 = [] := by decide
example : unfavorable m2_3_1_5 = [b] := by decide
example : secure m2_3_1_5 = false := by decide
def m2_3_1_6 : Model := ⟨system,["b"],[a,b],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_3_1_6 = [b] := by decide
example : favorable m2_3_1_6 = [b] := by decide
example : unfavorable m2_3_1_6 = [] := by decide
example : secure m2_3_1_6 = true := by decide
def m2_3_1_7 : Model := ⟨system,["b"],[a,b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_3_1_7 = [b] := by decide
example : favorable m2_3_1_7 = [b] := by decide
example : unfavorable m2_3_1_7 = [] := by decide
example : secure m2_3_1_7 = true := by decide
def m2_4_0_0 : Model := ⟨system,["b"],[c],0,[],["good","bad","q"]⟩
example : rows m2_4_0_0 = [] := by decide
example : favorable m2_4_0_0 = [] := by decide
example : unfavorable m2_4_0_0 = [] := by decide
example : secure m2_4_0_0 = true := by decide
def m2_4_0_1 : Model := ⟨system,["b"],[c],0,["good"],["good","bad","q"]⟩
example : rows m2_4_0_1 = [] := by decide
example : favorable m2_4_0_1 = [] := by decide
example : unfavorable m2_4_0_1 = [] := by decide
example : secure m2_4_0_1 = true := by decide
def m2_4_0_2 : Model := ⟨system,["b"],[c],0,["bad"],["good","bad","q"]⟩
example : rows m2_4_0_2 = [] := by decide
example : favorable m2_4_0_2 = [] := by decide
example : unfavorable m2_4_0_2 = [] := by decide
example : secure m2_4_0_2 = true := by decide
def m2_4_0_3 : Model := ⟨system,["b"],[c],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_4_0_3 = [] := by decide
example : favorable m2_4_0_3 = [] := by decide
example : unfavorable m2_4_0_3 = [] := by decide
example : secure m2_4_0_3 = true := by decide
def m2_4_0_4 : Model := ⟨system,["b"],[c],0,["q"],["good","bad","q"]⟩
example : rows m2_4_0_4 = [] := by decide
example : favorable m2_4_0_4 = [] := by decide
example : unfavorable m2_4_0_4 = [] := by decide
example : secure m2_4_0_4 = true := by decide
def m2_4_0_5 : Model := ⟨system,["b"],[c],0,["good","q"],["good","bad","q"]⟩
example : rows m2_4_0_5 = [] := by decide
example : favorable m2_4_0_5 = [] := by decide
example : unfavorable m2_4_0_5 = [] := by decide
example : secure m2_4_0_5 = true := by decide
def m2_4_0_6 : Model := ⟨system,["b"],[c],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_4_0_6 = [] := by decide
example : favorable m2_4_0_6 = [] := by decide
example : unfavorable m2_4_0_6 = [] := by decide
example : secure m2_4_0_6 = true := by decide
def m2_4_0_7 : Model := ⟨system,["b"],[c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_4_0_7 = [] := by decide
example : favorable m2_4_0_7 = [] := by decide
example : unfavorable m2_4_0_7 = [] := by decide
example : secure m2_4_0_7 = true := by decide
def m2_4_1_0 : Model := ⟨system,["b"],[c],1,[],["good","bad","q"]⟩
example : rows m2_4_1_0 = [] := by decide
example : favorable m2_4_1_0 = [] := by decide
example : unfavorable m2_4_1_0 = [] := by decide
example : secure m2_4_1_0 = true := by decide
def m2_4_1_1 : Model := ⟨system,["b"],[c],1,["good"],["good","bad","q"]⟩
example : rows m2_4_1_1 = [] := by decide
example : favorable m2_4_1_1 = [] := by decide
example : unfavorable m2_4_1_1 = [] := by decide
example : secure m2_4_1_1 = true := by decide
def m2_4_1_2 : Model := ⟨system,["b"],[c],1,["bad"],["good","bad","q"]⟩
example : rows m2_4_1_2 = [] := by decide
example : favorable m2_4_1_2 = [] := by decide
example : unfavorable m2_4_1_2 = [] := by decide
example : secure m2_4_1_2 = true := by decide
def m2_4_1_3 : Model := ⟨system,["b"],[c],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_4_1_3 = [] := by decide
example : favorable m2_4_1_3 = [] := by decide
example : unfavorable m2_4_1_3 = [] := by decide
example : secure m2_4_1_3 = true := by decide
def m2_4_1_4 : Model := ⟨system,["b"],[c],1,["q"],["good","bad","q"]⟩
example : rows m2_4_1_4 = [] := by decide
example : favorable m2_4_1_4 = [] := by decide
example : unfavorable m2_4_1_4 = [] := by decide
example : secure m2_4_1_4 = true := by decide
def m2_4_1_5 : Model := ⟨system,["b"],[c],1,["good","q"],["good","bad","q"]⟩
example : rows m2_4_1_5 = [] := by decide
example : favorable m2_4_1_5 = [] := by decide
example : unfavorable m2_4_1_5 = [] := by decide
example : secure m2_4_1_5 = true := by decide
def m2_4_1_6 : Model := ⟨system,["b"],[c],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_4_1_6 = [] := by decide
example : favorable m2_4_1_6 = [] := by decide
example : unfavorable m2_4_1_6 = [] := by decide
example : secure m2_4_1_6 = true := by decide
def m2_4_1_7 : Model := ⟨system,["b"],[c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_4_1_7 = [] := by decide
example : favorable m2_4_1_7 = [] := by decide
example : unfavorable m2_4_1_7 = [] := by decide
example : secure m2_4_1_7 = true := by decide
def m2_5_0_0 : Model := ⟨system,["b"],[a,c],0,[],["good","bad","q"]⟩
example : rows m2_5_0_0 = [] := by decide
example : favorable m2_5_0_0 = [] := by decide
example : unfavorable m2_5_0_0 = [] := by decide
example : secure m2_5_0_0 = true := by decide
def m2_5_0_1 : Model := ⟨system,["b"],[a,c],0,["good"],["good","bad","q"]⟩
example : rows m2_5_0_1 = [] := by decide
example : favorable m2_5_0_1 = [] := by decide
example : unfavorable m2_5_0_1 = [] := by decide
example : secure m2_5_0_1 = true := by decide
def m2_5_0_2 : Model := ⟨system,["b"],[a,c],0,["bad"],["good","bad","q"]⟩
example : rows m2_5_0_2 = [] := by decide
example : favorable m2_5_0_2 = [] := by decide
example : unfavorable m2_5_0_2 = [] := by decide
example : secure m2_5_0_2 = true := by decide
def m2_5_0_3 : Model := ⟨system,["b"],[a,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_5_0_3 = [] := by decide
example : favorable m2_5_0_3 = [] := by decide
example : unfavorable m2_5_0_3 = [] := by decide
example : secure m2_5_0_3 = true := by decide
def m2_5_0_4 : Model := ⟨system,["b"],[a,c],0,["q"],["good","bad","q"]⟩
example : rows m2_5_0_4 = [] := by decide
example : favorable m2_5_0_4 = [] := by decide
example : unfavorable m2_5_0_4 = [] := by decide
example : secure m2_5_0_4 = true := by decide
def m2_5_0_5 : Model := ⟨system,["b"],[a,c],0,["good","q"],["good","bad","q"]⟩
example : rows m2_5_0_5 = [] := by decide
example : favorable m2_5_0_5 = [] := by decide
example : unfavorable m2_5_0_5 = [] := by decide
example : secure m2_5_0_5 = true := by decide
def m2_5_0_6 : Model := ⟨system,["b"],[a,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_5_0_6 = [] := by decide
example : favorable m2_5_0_6 = [] := by decide
example : unfavorable m2_5_0_6 = [] := by decide
example : secure m2_5_0_6 = true := by decide
def m2_5_0_7 : Model := ⟨system,["b"],[a,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_5_0_7 = [] := by decide
example : favorable m2_5_0_7 = [] := by decide
example : unfavorable m2_5_0_7 = [] := by decide
example : secure m2_5_0_7 = true := by decide
def m2_5_1_0 : Model := ⟨system,["b"],[a,c],1,[],["good","bad","q"]⟩
example : rows m2_5_1_0 = [] := by decide
example : favorable m2_5_1_0 = [] := by decide
example : unfavorable m2_5_1_0 = [] := by decide
example : secure m2_5_1_0 = true := by decide
def m2_5_1_1 : Model := ⟨system,["b"],[a,c],1,["good"],["good","bad","q"]⟩
example : rows m2_5_1_1 = [] := by decide
example : favorable m2_5_1_1 = [] := by decide
example : unfavorable m2_5_1_1 = [] := by decide
example : secure m2_5_1_1 = true := by decide
def m2_5_1_2 : Model := ⟨system,["b"],[a,c],1,["bad"],["good","bad","q"]⟩
example : rows m2_5_1_2 = [] := by decide
example : favorable m2_5_1_2 = [] := by decide
example : unfavorable m2_5_1_2 = [] := by decide
example : secure m2_5_1_2 = true := by decide
def m2_5_1_3 : Model := ⟨system,["b"],[a,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_5_1_3 = [] := by decide
example : favorable m2_5_1_3 = [] := by decide
example : unfavorable m2_5_1_3 = [] := by decide
example : secure m2_5_1_3 = true := by decide
def m2_5_1_4 : Model := ⟨system,["b"],[a,c],1,["q"],["good","bad","q"]⟩
example : rows m2_5_1_4 = [] := by decide
example : favorable m2_5_1_4 = [] := by decide
example : unfavorable m2_5_1_4 = [] := by decide
example : secure m2_5_1_4 = true := by decide
def m2_5_1_5 : Model := ⟨system,["b"],[a,c],1,["good","q"],["good","bad","q"]⟩
example : rows m2_5_1_5 = [] := by decide
example : favorable m2_5_1_5 = [] := by decide
example : unfavorable m2_5_1_5 = [] := by decide
example : secure m2_5_1_5 = true := by decide
def m2_5_1_6 : Model := ⟨system,["b"],[a,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_5_1_6 = [] := by decide
example : favorable m2_5_1_6 = [] := by decide
example : unfavorable m2_5_1_6 = [] := by decide
example : secure m2_5_1_6 = true := by decide
def m2_5_1_7 : Model := ⟨system,["b"],[a,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_5_1_7 = [] := by decide
example : favorable m2_5_1_7 = [] := by decide
example : unfavorable m2_5_1_7 = [] := by decide
example : secure m2_5_1_7 = true := by decide
def m2_6_0_0 : Model := ⟨system,["b"],[b,c],0,[],["good","bad","q"]⟩
example : rows m2_6_0_0 = [] := by decide
example : favorable m2_6_0_0 = [] := by decide
example : unfavorable m2_6_0_0 = [] := by decide
example : secure m2_6_0_0 = true := by decide
def m2_6_0_1 : Model := ⟨system,["b"],[b,c],0,["good"],["good","bad","q"]⟩
example : rows m2_6_0_1 = [] := by decide
example : favorable m2_6_0_1 = [] := by decide
example : unfavorable m2_6_0_1 = [] := by decide
example : secure m2_6_0_1 = true := by decide
def m2_6_0_2 : Model := ⟨system,["b"],[b,c],0,["bad"],["good","bad","q"]⟩
example : rows m2_6_0_2 = [] := by decide
example : favorable m2_6_0_2 = [] := by decide
example : unfavorable m2_6_0_2 = [] := by decide
example : secure m2_6_0_2 = true := by decide
def m2_6_0_3 : Model := ⟨system,["b"],[b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_6_0_3 = [] := by decide
example : favorable m2_6_0_3 = [] := by decide
example : unfavorable m2_6_0_3 = [] := by decide
example : secure m2_6_0_3 = true := by decide
def m2_6_0_4 : Model := ⟨system,["b"],[b,c],0,["q"],["good","bad","q"]⟩
example : rows m2_6_0_4 = [] := by decide
example : favorable m2_6_0_4 = [] := by decide
example : unfavorable m2_6_0_4 = [] := by decide
example : secure m2_6_0_4 = true := by decide
def m2_6_0_5 : Model := ⟨system,["b"],[b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m2_6_0_5 = [] := by decide
example : favorable m2_6_0_5 = [] := by decide
example : unfavorable m2_6_0_5 = [] := by decide
example : secure m2_6_0_5 = true := by decide
def m2_6_0_6 : Model := ⟨system,["b"],[b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_6_0_6 = [] := by decide
example : favorable m2_6_0_6 = [] := by decide
example : unfavorable m2_6_0_6 = [] := by decide
example : secure m2_6_0_6 = true := by decide
def m2_6_0_7 : Model := ⟨system,["b"],[b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_6_0_7 = [] := by decide
example : favorable m2_6_0_7 = [] := by decide
example : unfavorable m2_6_0_7 = [] := by decide
example : secure m2_6_0_7 = true := by decide
def m2_6_1_0 : Model := ⟨system,["b"],[b,c],1,[],["good","bad","q"]⟩
example : rows m2_6_1_0 = [b] := by decide
example : favorable m2_6_1_0 = [] := by decide
example : unfavorable m2_6_1_0 = [b] := by decide
example : secure m2_6_1_0 = false := by decide
def m2_6_1_1 : Model := ⟨system,["b"],[b,c],1,["good"],["good","bad","q"]⟩
example : rows m2_6_1_1 = [b] := by decide
example : favorable m2_6_1_1 = [] := by decide
example : unfavorable m2_6_1_1 = [b] := by decide
example : secure m2_6_1_1 = false := by decide
def m2_6_1_2 : Model := ⟨system,["b"],[b,c],1,["bad"],["good","bad","q"]⟩
example : rows m2_6_1_2 = [b] := by decide
example : favorable m2_6_1_2 = [b] := by decide
example : unfavorable m2_6_1_2 = [] := by decide
example : secure m2_6_1_2 = true := by decide
def m2_6_1_3 : Model := ⟨system,["b"],[b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_6_1_3 = [b] := by decide
example : favorable m2_6_1_3 = [b] := by decide
example : unfavorable m2_6_1_3 = [] := by decide
example : secure m2_6_1_3 = true := by decide
def m2_6_1_4 : Model := ⟨system,["b"],[b,c],1,["q"],["good","bad","q"]⟩
example : rows m2_6_1_4 = [b] := by decide
example : favorable m2_6_1_4 = [] := by decide
example : unfavorable m2_6_1_4 = [b] := by decide
example : secure m2_6_1_4 = false := by decide
def m2_6_1_5 : Model := ⟨system,["b"],[b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m2_6_1_5 = [b] := by decide
example : favorable m2_6_1_5 = [] := by decide
example : unfavorable m2_6_1_5 = [b] := by decide
example : secure m2_6_1_5 = false := by decide
def m2_6_1_6 : Model := ⟨system,["b"],[b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_6_1_6 = [b] := by decide
example : favorable m2_6_1_6 = [b] := by decide
example : unfavorable m2_6_1_6 = [] := by decide
example : secure m2_6_1_6 = true := by decide
def m2_6_1_7 : Model := ⟨system,["b"],[b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_6_1_7 = [b] := by decide
example : favorable m2_6_1_7 = [b] := by decide
example : unfavorable m2_6_1_7 = [] := by decide
example : secure m2_6_1_7 = true := by decide
def m2_7_0_0 : Model := ⟨system,["b"],[a,b,c],0,[],["good","bad","q"]⟩
example : rows m2_7_0_0 = [] := by decide
example : favorable m2_7_0_0 = [] := by decide
example : unfavorable m2_7_0_0 = [] := by decide
example : secure m2_7_0_0 = true := by decide
def m2_7_0_1 : Model := ⟨system,["b"],[a,b,c],0,["good"],["good","bad","q"]⟩
example : rows m2_7_0_1 = [] := by decide
example : favorable m2_7_0_1 = [] := by decide
example : unfavorable m2_7_0_1 = [] := by decide
example : secure m2_7_0_1 = true := by decide
def m2_7_0_2 : Model := ⟨system,["b"],[a,b,c],0,["bad"],["good","bad","q"]⟩
example : rows m2_7_0_2 = [] := by decide
example : favorable m2_7_0_2 = [] := by decide
example : unfavorable m2_7_0_2 = [] := by decide
example : secure m2_7_0_2 = true := by decide
def m2_7_0_3 : Model := ⟨system,["b"],[a,b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m2_7_0_3 = [] := by decide
example : favorable m2_7_0_3 = [] := by decide
example : unfavorable m2_7_0_3 = [] := by decide
example : secure m2_7_0_3 = true := by decide
def m2_7_0_4 : Model := ⟨system,["b"],[a,b,c],0,["q"],["good","bad","q"]⟩
example : rows m2_7_0_4 = [] := by decide
example : favorable m2_7_0_4 = [] := by decide
example : unfavorable m2_7_0_4 = [] := by decide
example : secure m2_7_0_4 = true := by decide
def m2_7_0_5 : Model := ⟨system,["b"],[a,b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m2_7_0_5 = [] := by decide
example : favorable m2_7_0_5 = [] := by decide
example : unfavorable m2_7_0_5 = [] := by decide
example : secure m2_7_0_5 = true := by decide
def m2_7_0_6 : Model := ⟨system,["b"],[a,b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m2_7_0_6 = [] := by decide
example : favorable m2_7_0_6 = [] := by decide
example : unfavorable m2_7_0_6 = [] := by decide
example : secure m2_7_0_6 = true := by decide
def m2_7_0_7 : Model := ⟨system,["b"],[a,b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_7_0_7 = [] := by decide
example : favorable m2_7_0_7 = [] := by decide
example : unfavorable m2_7_0_7 = [] := by decide
example : secure m2_7_0_7 = true := by decide
def m2_7_1_0 : Model := ⟨system,["b"],[a,b,c],1,[],["good","bad","q"]⟩
example : rows m2_7_1_0 = [b] := by decide
example : favorable m2_7_1_0 = [] := by decide
example : unfavorable m2_7_1_0 = [b] := by decide
example : secure m2_7_1_0 = false := by decide
def m2_7_1_1 : Model := ⟨system,["b"],[a,b,c],1,["good"],["good","bad","q"]⟩
example : rows m2_7_1_1 = [b] := by decide
example : favorable m2_7_1_1 = [] := by decide
example : unfavorable m2_7_1_1 = [b] := by decide
example : secure m2_7_1_1 = false := by decide
def m2_7_1_2 : Model := ⟨system,["b"],[a,b,c],1,["bad"],["good","bad","q"]⟩
example : rows m2_7_1_2 = [b] := by decide
example : favorable m2_7_1_2 = [b] := by decide
example : unfavorable m2_7_1_2 = [] := by decide
example : secure m2_7_1_2 = true := by decide
def m2_7_1_3 : Model := ⟨system,["b"],[a,b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m2_7_1_3 = [b] := by decide
example : favorable m2_7_1_3 = [b] := by decide
example : unfavorable m2_7_1_3 = [] := by decide
example : secure m2_7_1_3 = true := by decide
def m2_7_1_4 : Model := ⟨system,["b"],[a,b,c],1,["q"],["good","bad","q"]⟩
example : rows m2_7_1_4 = [b] := by decide
example : favorable m2_7_1_4 = [] := by decide
example : unfavorable m2_7_1_4 = [b] := by decide
example : secure m2_7_1_4 = false := by decide
def m2_7_1_5 : Model := ⟨system,["b"],[a,b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m2_7_1_5 = [b] := by decide
example : favorable m2_7_1_5 = [] := by decide
example : unfavorable m2_7_1_5 = [b] := by decide
example : secure m2_7_1_5 = false := by decide
def m2_7_1_6 : Model := ⟨system,["b"],[a,b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m2_7_1_6 = [b] := by decide
example : favorable m2_7_1_6 = [b] := by decide
example : unfavorable m2_7_1_6 = [] := by decide
example : secure m2_7_1_6 = true := by decide
def m2_7_1_7 : Model := ⟨system,["b"],[a,b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m2_7_1_7 = [b] := by decide
example : favorable m2_7_1_7 = [b] := by decide
example : unfavorable m2_7_1_7 = [] := by decide
example : secure m2_7_1_7 = true := by decide
def m3_0_0_0 : Model := ⟨system,["a","b"],[],0,[],["good","bad","q"]⟩
example : rows m3_0_0_0 = [] := by decide
example : favorable m3_0_0_0 = [] := by decide
example : unfavorable m3_0_0_0 = [] := by decide
example : secure m3_0_0_0 = true := by decide
def m3_0_0_1 : Model := ⟨system,["a","b"],[],0,["good"],["good","bad","q"]⟩
example : rows m3_0_0_1 = [] := by decide
example : favorable m3_0_0_1 = [] := by decide
example : unfavorable m3_0_0_1 = [] := by decide
example : secure m3_0_0_1 = true := by decide
def m3_0_0_2 : Model := ⟨system,["a","b"],[],0,["bad"],["good","bad","q"]⟩
example : rows m3_0_0_2 = [] := by decide
example : favorable m3_0_0_2 = [] := by decide
example : unfavorable m3_0_0_2 = [] := by decide
example : secure m3_0_0_2 = true := by decide
def m3_0_0_3 : Model := ⟨system,["a","b"],[],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_0_0_3 = [] := by decide
example : favorable m3_0_0_3 = [] := by decide
example : unfavorable m3_0_0_3 = [] := by decide
example : secure m3_0_0_3 = true := by decide
def m3_0_0_4 : Model := ⟨system,["a","b"],[],0,["q"],["good","bad","q"]⟩
example : rows m3_0_0_4 = [] := by decide
example : favorable m3_0_0_4 = [] := by decide
example : unfavorable m3_0_0_4 = [] := by decide
example : secure m3_0_0_4 = true := by decide
def m3_0_0_5 : Model := ⟨system,["a","b"],[],0,["good","q"],["good","bad","q"]⟩
example : rows m3_0_0_5 = [] := by decide
example : favorable m3_0_0_5 = [] := by decide
example : unfavorable m3_0_0_5 = [] := by decide
example : secure m3_0_0_5 = true := by decide
def m3_0_0_6 : Model := ⟨system,["a","b"],[],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_0_0_6 = [] := by decide
example : favorable m3_0_0_6 = [] := by decide
example : unfavorable m3_0_0_6 = [] := by decide
example : secure m3_0_0_6 = true := by decide
def m3_0_0_7 : Model := ⟨system,["a","b"],[],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_0_0_7 = [] := by decide
example : favorable m3_0_0_7 = [] := by decide
example : unfavorable m3_0_0_7 = [] := by decide
example : secure m3_0_0_7 = true := by decide
def m3_0_1_0 : Model := ⟨system,["a","b"],[],1,[],["good","bad","q"]⟩
example : rows m3_0_1_0 = [] := by decide
example : favorable m3_0_1_0 = [] := by decide
example : unfavorable m3_0_1_0 = [] := by decide
example : secure m3_0_1_0 = true := by decide
def m3_0_1_1 : Model := ⟨system,["a","b"],[],1,["good"],["good","bad","q"]⟩
example : rows m3_0_1_1 = [] := by decide
example : favorable m3_0_1_1 = [] := by decide
example : unfavorable m3_0_1_1 = [] := by decide
example : secure m3_0_1_1 = true := by decide
def m3_0_1_2 : Model := ⟨system,["a","b"],[],1,["bad"],["good","bad","q"]⟩
example : rows m3_0_1_2 = [] := by decide
example : favorable m3_0_1_2 = [] := by decide
example : unfavorable m3_0_1_2 = [] := by decide
example : secure m3_0_1_2 = true := by decide
def m3_0_1_3 : Model := ⟨system,["a","b"],[],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_0_1_3 = [] := by decide
example : favorable m3_0_1_3 = [] := by decide
example : unfavorable m3_0_1_3 = [] := by decide
example : secure m3_0_1_3 = true := by decide
def m3_0_1_4 : Model := ⟨system,["a","b"],[],1,["q"],["good","bad","q"]⟩
example : rows m3_0_1_4 = [] := by decide
example : favorable m3_0_1_4 = [] := by decide
example : unfavorable m3_0_1_4 = [] := by decide
example : secure m3_0_1_4 = true := by decide
def m3_0_1_5 : Model := ⟨system,["a","b"],[],1,["good","q"],["good","bad","q"]⟩
example : rows m3_0_1_5 = [] := by decide
example : favorable m3_0_1_5 = [] := by decide
example : unfavorable m3_0_1_5 = [] := by decide
example : secure m3_0_1_5 = true := by decide
def m3_0_1_6 : Model := ⟨system,["a","b"],[],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_0_1_6 = [] := by decide
example : favorable m3_0_1_6 = [] := by decide
example : unfavorable m3_0_1_6 = [] := by decide
example : secure m3_0_1_6 = true := by decide
def m3_0_1_7 : Model := ⟨system,["a","b"],[],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_0_1_7 = [] := by decide
example : favorable m3_0_1_7 = [] := by decide
example : unfavorable m3_0_1_7 = [] := by decide
example : secure m3_0_1_7 = true := by decide
def m3_1_0_0 : Model := ⟨system,["a","b"],[a],0,[],["good","bad","q"]⟩
example : rows m3_1_0_0 = [] := by decide
example : favorable m3_1_0_0 = [] := by decide
example : unfavorable m3_1_0_0 = [] := by decide
example : secure m3_1_0_0 = true := by decide
def m3_1_0_1 : Model := ⟨system,["a","b"],[a],0,["good"],["good","bad","q"]⟩
example : rows m3_1_0_1 = [] := by decide
example : favorable m3_1_0_1 = [] := by decide
example : unfavorable m3_1_0_1 = [] := by decide
example : secure m3_1_0_1 = true := by decide
def m3_1_0_2 : Model := ⟨system,["a","b"],[a],0,["bad"],["good","bad","q"]⟩
example : rows m3_1_0_2 = [] := by decide
example : favorable m3_1_0_2 = [] := by decide
example : unfavorable m3_1_0_2 = [] := by decide
example : secure m3_1_0_2 = true := by decide
def m3_1_0_3 : Model := ⟨system,["a","b"],[a],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_1_0_3 = [] := by decide
example : favorable m3_1_0_3 = [] := by decide
example : unfavorable m3_1_0_3 = [] := by decide
example : secure m3_1_0_3 = true := by decide
def m3_1_0_4 : Model := ⟨system,["a","b"],[a],0,["q"],["good","bad","q"]⟩
example : rows m3_1_0_4 = [] := by decide
example : favorable m3_1_0_4 = [] := by decide
example : unfavorable m3_1_0_4 = [] := by decide
example : secure m3_1_0_4 = true := by decide
def m3_1_0_5 : Model := ⟨system,["a","b"],[a],0,["good","q"],["good","bad","q"]⟩
example : rows m3_1_0_5 = [] := by decide
example : favorable m3_1_0_5 = [] := by decide
example : unfavorable m3_1_0_5 = [] := by decide
example : secure m3_1_0_5 = true := by decide
def m3_1_0_6 : Model := ⟨system,["a","b"],[a],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_1_0_6 = [] := by decide
example : favorable m3_1_0_6 = [] := by decide
example : unfavorable m3_1_0_6 = [] := by decide
example : secure m3_1_0_6 = true := by decide
def m3_1_0_7 : Model := ⟨system,["a","b"],[a],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_1_0_7 = [] := by decide
example : favorable m3_1_0_7 = [] := by decide
example : unfavorable m3_1_0_7 = [] := by decide
example : secure m3_1_0_7 = true := by decide
def m3_1_1_0 : Model := ⟨system,["a","b"],[a],1,[],["good","bad","q"]⟩
example : rows m3_1_1_0 = [a] := by decide
example : favorable m3_1_1_0 = [] := by decide
example : unfavorable m3_1_1_0 = [a] := by decide
example : secure m3_1_1_0 = false := by decide
def m3_1_1_1 : Model := ⟨system,["a","b"],[a],1,["good"],["good","bad","q"]⟩
example : rows m3_1_1_1 = [a] := by decide
example : favorable m3_1_1_1 = [a] := by decide
example : unfavorable m3_1_1_1 = [] := by decide
example : secure m3_1_1_1 = true := by decide
def m3_1_1_2 : Model := ⟨system,["a","b"],[a],1,["bad"],["good","bad","q"]⟩
example : rows m3_1_1_2 = [a] := by decide
example : favorable m3_1_1_2 = [] := by decide
example : unfavorable m3_1_1_2 = [a] := by decide
example : secure m3_1_1_2 = false := by decide
def m3_1_1_3 : Model := ⟨system,["a","b"],[a],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_1_1_3 = [a] := by decide
example : favorable m3_1_1_3 = [a] := by decide
example : unfavorable m3_1_1_3 = [] := by decide
example : secure m3_1_1_3 = true := by decide
def m3_1_1_4 : Model := ⟨system,["a","b"],[a],1,["q"],["good","bad","q"]⟩
example : rows m3_1_1_4 = [a] := by decide
example : favorable m3_1_1_4 = [] := by decide
example : unfavorable m3_1_1_4 = [a] := by decide
example : secure m3_1_1_4 = false := by decide
def m3_1_1_5 : Model := ⟨system,["a","b"],[a],1,["good","q"],["good","bad","q"]⟩
example : rows m3_1_1_5 = [a] := by decide
example : favorable m3_1_1_5 = [a] := by decide
example : unfavorable m3_1_1_5 = [] := by decide
example : secure m3_1_1_5 = true := by decide
def m3_1_1_6 : Model := ⟨system,["a","b"],[a],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_1_1_6 = [a] := by decide
example : favorable m3_1_1_6 = [] := by decide
example : unfavorable m3_1_1_6 = [a] := by decide
example : secure m3_1_1_6 = false := by decide
def m3_1_1_7 : Model := ⟨system,["a","b"],[a],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_1_1_7 = [a] := by decide
example : favorable m3_1_1_7 = [a] := by decide
example : unfavorable m3_1_1_7 = [] := by decide
example : secure m3_1_1_7 = true := by decide
def m3_2_0_0 : Model := ⟨system,["a","b"],[b],0,[],["good","bad","q"]⟩
example : rows m3_2_0_0 = [] := by decide
example : favorable m3_2_0_0 = [] := by decide
example : unfavorable m3_2_0_0 = [] := by decide
example : secure m3_2_0_0 = true := by decide
def m3_2_0_1 : Model := ⟨system,["a","b"],[b],0,["good"],["good","bad","q"]⟩
example : rows m3_2_0_1 = [] := by decide
example : favorable m3_2_0_1 = [] := by decide
example : unfavorable m3_2_0_1 = [] := by decide
example : secure m3_2_0_1 = true := by decide
def m3_2_0_2 : Model := ⟨system,["a","b"],[b],0,["bad"],["good","bad","q"]⟩
example : rows m3_2_0_2 = [] := by decide
example : favorable m3_2_0_2 = [] := by decide
example : unfavorable m3_2_0_2 = [] := by decide
example : secure m3_2_0_2 = true := by decide
def m3_2_0_3 : Model := ⟨system,["a","b"],[b],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_2_0_3 = [] := by decide
example : favorable m3_2_0_3 = [] := by decide
example : unfavorable m3_2_0_3 = [] := by decide
example : secure m3_2_0_3 = true := by decide
def m3_2_0_4 : Model := ⟨system,["a","b"],[b],0,["q"],["good","bad","q"]⟩
example : rows m3_2_0_4 = [] := by decide
example : favorable m3_2_0_4 = [] := by decide
example : unfavorable m3_2_0_4 = [] := by decide
example : secure m3_2_0_4 = true := by decide
def m3_2_0_5 : Model := ⟨system,["a","b"],[b],0,["good","q"],["good","bad","q"]⟩
example : rows m3_2_0_5 = [] := by decide
example : favorable m3_2_0_5 = [] := by decide
example : unfavorable m3_2_0_5 = [] := by decide
example : secure m3_2_0_5 = true := by decide
def m3_2_0_6 : Model := ⟨system,["a","b"],[b],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_2_0_6 = [] := by decide
example : favorable m3_2_0_6 = [] := by decide
example : unfavorable m3_2_0_6 = [] := by decide
example : secure m3_2_0_6 = true := by decide
def m3_2_0_7 : Model := ⟨system,["a","b"],[b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_2_0_7 = [] := by decide
example : favorable m3_2_0_7 = [] := by decide
example : unfavorable m3_2_0_7 = [] := by decide
example : secure m3_2_0_7 = true := by decide
def m3_2_1_0 : Model := ⟨system,["a","b"],[b],1,[],["good","bad","q"]⟩
example : rows m3_2_1_0 = [b] := by decide
example : favorable m3_2_1_0 = [] := by decide
example : unfavorable m3_2_1_0 = [b] := by decide
example : secure m3_2_1_0 = false := by decide
def m3_2_1_1 : Model := ⟨system,["a","b"],[b],1,["good"],["good","bad","q"]⟩
example : rows m3_2_1_1 = [b] := by decide
example : favorable m3_2_1_1 = [] := by decide
example : unfavorable m3_2_1_1 = [b] := by decide
example : secure m3_2_1_1 = false := by decide
def m3_2_1_2 : Model := ⟨system,["a","b"],[b],1,["bad"],["good","bad","q"]⟩
example : rows m3_2_1_2 = [b] := by decide
example : favorable m3_2_1_2 = [b] := by decide
example : unfavorable m3_2_1_2 = [] := by decide
example : secure m3_2_1_2 = true := by decide
def m3_2_1_3 : Model := ⟨system,["a","b"],[b],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_2_1_3 = [b] := by decide
example : favorable m3_2_1_3 = [b] := by decide
example : unfavorable m3_2_1_3 = [] := by decide
example : secure m3_2_1_3 = true := by decide
def m3_2_1_4 : Model := ⟨system,["a","b"],[b],1,["q"],["good","bad","q"]⟩
example : rows m3_2_1_4 = [b] := by decide
example : favorable m3_2_1_4 = [] := by decide
example : unfavorable m3_2_1_4 = [b] := by decide
example : secure m3_2_1_4 = false := by decide
def m3_2_1_5 : Model := ⟨system,["a","b"],[b],1,["good","q"],["good","bad","q"]⟩
example : rows m3_2_1_5 = [b] := by decide
example : favorable m3_2_1_5 = [] := by decide
example : unfavorable m3_2_1_5 = [b] := by decide
example : secure m3_2_1_5 = false := by decide
def m3_2_1_6 : Model := ⟨system,["a","b"],[b],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_2_1_6 = [b] := by decide
example : favorable m3_2_1_6 = [b] := by decide
example : unfavorable m3_2_1_6 = [] := by decide
example : secure m3_2_1_6 = true := by decide
def m3_2_1_7 : Model := ⟨system,["a","b"],[b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_2_1_7 = [b] := by decide
example : favorable m3_2_1_7 = [b] := by decide
example : unfavorable m3_2_1_7 = [] := by decide
example : secure m3_2_1_7 = true := by decide
def m3_3_0_0 : Model := ⟨system,["a","b"],[a,b],0,[],["good","bad","q"]⟩
example : rows m3_3_0_0 = [] := by decide
example : favorable m3_3_0_0 = [] := by decide
example : unfavorable m3_3_0_0 = [] := by decide
example : secure m3_3_0_0 = true := by decide
def m3_3_0_1 : Model := ⟨system,["a","b"],[a,b],0,["good"],["good","bad","q"]⟩
example : rows m3_3_0_1 = [] := by decide
example : favorable m3_3_0_1 = [] := by decide
example : unfavorable m3_3_0_1 = [] := by decide
example : secure m3_3_0_1 = true := by decide
def m3_3_0_2 : Model := ⟨system,["a","b"],[a,b],0,["bad"],["good","bad","q"]⟩
example : rows m3_3_0_2 = [] := by decide
example : favorable m3_3_0_2 = [] := by decide
example : unfavorable m3_3_0_2 = [] := by decide
example : secure m3_3_0_2 = true := by decide
def m3_3_0_3 : Model := ⟨system,["a","b"],[a,b],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_3_0_3 = [] := by decide
example : favorable m3_3_0_3 = [] := by decide
example : unfavorable m3_3_0_3 = [] := by decide
example : secure m3_3_0_3 = true := by decide
def m3_3_0_4 : Model := ⟨system,["a","b"],[a,b],0,["q"],["good","bad","q"]⟩
example : rows m3_3_0_4 = [] := by decide
example : favorable m3_3_0_4 = [] := by decide
example : unfavorable m3_3_0_4 = [] := by decide
example : secure m3_3_0_4 = true := by decide
def m3_3_0_5 : Model := ⟨system,["a","b"],[a,b],0,["good","q"],["good","bad","q"]⟩
example : rows m3_3_0_5 = [] := by decide
example : favorable m3_3_0_5 = [] := by decide
example : unfavorable m3_3_0_5 = [] := by decide
example : secure m3_3_0_5 = true := by decide
def m3_3_0_6 : Model := ⟨system,["a","b"],[a,b],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_3_0_6 = [] := by decide
example : favorable m3_3_0_6 = [] := by decide
example : unfavorable m3_3_0_6 = [] := by decide
example : secure m3_3_0_6 = true := by decide
def m3_3_0_7 : Model := ⟨system,["a","b"],[a,b],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_3_0_7 = [] := by decide
example : favorable m3_3_0_7 = [] := by decide
example : unfavorable m3_3_0_7 = [] := by decide
example : secure m3_3_0_7 = true := by decide
def m3_3_1_0 : Model := ⟨system,["a","b"],[a,b],1,[],["good","bad","q"]⟩
example : rows m3_3_1_0 = [a,b] := by decide
example : favorable m3_3_1_0 = [] := by decide
example : unfavorable m3_3_1_0 = [a,b] := by decide
example : secure m3_3_1_0 = false := by decide
def m3_3_1_1 : Model := ⟨system,["a","b"],[a,b],1,["good"],["good","bad","q"]⟩
example : rows m3_3_1_1 = [a,b] := by decide
example : favorable m3_3_1_1 = [a] := by decide
example : unfavorable m3_3_1_1 = [b] := by decide
example : secure m3_3_1_1 = false := by decide
def m3_3_1_2 : Model := ⟨system,["a","b"],[a,b],1,["bad"],["good","bad","q"]⟩
example : rows m3_3_1_2 = [a,b] := by decide
example : favorable m3_3_1_2 = [b] := by decide
example : unfavorable m3_3_1_2 = [a] := by decide
example : secure m3_3_1_2 = false := by decide
def m3_3_1_3 : Model := ⟨system,["a","b"],[a,b],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_3_1_3 = [a,b] := by decide
example : favorable m3_3_1_3 = [a,b] := by decide
example : unfavorable m3_3_1_3 = [] := by decide
example : secure m3_3_1_3 = true := by decide
def m3_3_1_4 : Model := ⟨system,["a","b"],[a,b],1,["q"],["good","bad","q"]⟩
example : rows m3_3_1_4 = [a,b] := by decide
example : favorable m3_3_1_4 = [] := by decide
example : unfavorable m3_3_1_4 = [a,b] := by decide
example : secure m3_3_1_4 = false := by decide
def m3_3_1_5 : Model := ⟨system,["a","b"],[a,b],1,["good","q"],["good","bad","q"]⟩
example : rows m3_3_1_5 = [a,b] := by decide
example : favorable m3_3_1_5 = [a] := by decide
example : unfavorable m3_3_1_5 = [b] := by decide
example : secure m3_3_1_5 = false := by decide
def m3_3_1_6 : Model := ⟨system,["a","b"],[a,b],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_3_1_6 = [a,b] := by decide
example : favorable m3_3_1_6 = [b] := by decide
example : unfavorable m3_3_1_6 = [a] := by decide
example : secure m3_3_1_6 = false := by decide
def m3_3_1_7 : Model := ⟨system,["a","b"],[a,b],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_3_1_7 = [a,b] := by decide
example : favorable m3_3_1_7 = [a,b] := by decide
example : unfavorable m3_3_1_7 = [] := by decide
example : secure m3_3_1_7 = true := by decide
def m3_4_0_0 : Model := ⟨system,["a","b"],[c],0,[],["good","bad","q"]⟩
example : rows m3_4_0_0 = [c] := by decide
example : favorable m3_4_0_0 = [] := by decide
example : unfavorable m3_4_0_0 = [c] := by decide
example : secure m3_4_0_0 = false := by decide
def m3_4_0_1 : Model := ⟨system,["a","b"],[c],0,["good"],["good","bad","q"]⟩
example : rows m3_4_0_1 = [c] := by decide
example : favorable m3_4_0_1 = [] := by decide
example : unfavorable m3_4_0_1 = [c] := by decide
example : secure m3_4_0_1 = false := by decide
def m3_4_0_2 : Model := ⟨system,["a","b"],[c],0,["bad"],["good","bad","q"]⟩
example : rows m3_4_0_2 = [c] := by decide
example : favorable m3_4_0_2 = [] := by decide
example : unfavorable m3_4_0_2 = [c] := by decide
example : secure m3_4_0_2 = false := by decide
def m3_4_0_3 : Model := ⟨system,["a","b"],[c],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_4_0_3 = [c] := by decide
example : favorable m3_4_0_3 = [] := by decide
example : unfavorable m3_4_0_3 = [c] := by decide
example : secure m3_4_0_3 = false := by decide
def m3_4_0_4 : Model := ⟨system,["a","b"],[c],0,["q"],["good","bad","q"]⟩
example : rows m3_4_0_4 = [c] := by decide
example : favorable m3_4_0_4 = [c] := by decide
example : unfavorable m3_4_0_4 = [] := by decide
example : secure m3_4_0_4 = true := by decide
def m3_4_0_5 : Model := ⟨system,["a","b"],[c],0,["good","q"],["good","bad","q"]⟩
example : rows m3_4_0_5 = [c] := by decide
example : favorable m3_4_0_5 = [c] := by decide
example : unfavorable m3_4_0_5 = [] := by decide
example : secure m3_4_0_5 = true := by decide
def m3_4_0_6 : Model := ⟨system,["a","b"],[c],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_4_0_6 = [c] := by decide
example : favorable m3_4_0_6 = [c] := by decide
example : unfavorable m3_4_0_6 = [] := by decide
example : secure m3_4_0_6 = true := by decide
def m3_4_0_7 : Model := ⟨system,["a","b"],[c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_4_0_7 = [c] := by decide
example : favorable m3_4_0_7 = [c] := by decide
example : unfavorable m3_4_0_7 = [] := by decide
example : secure m3_4_0_7 = true := by decide
def m3_4_1_0 : Model := ⟨system,["a","b"],[c],1,[],["good","bad","q"]⟩
example : rows m3_4_1_0 = [c] := by decide
example : favorable m3_4_1_0 = [] := by decide
example : unfavorable m3_4_1_0 = [c] := by decide
example : secure m3_4_1_0 = false := by decide
def m3_4_1_1 : Model := ⟨system,["a","b"],[c],1,["good"],["good","bad","q"]⟩
example : rows m3_4_1_1 = [c] := by decide
example : favorable m3_4_1_1 = [] := by decide
example : unfavorable m3_4_1_1 = [c] := by decide
example : secure m3_4_1_1 = false := by decide
def m3_4_1_2 : Model := ⟨system,["a","b"],[c],1,["bad"],["good","bad","q"]⟩
example : rows m3_4_1_2 = [c] := by decide
example : favorable m3_4_1_2 = [] := by decide
example : unfavorable m3_4_1_2 = [c] := by decide
example : secure m3_4_1_2 = false := by decide
def m3_4_1_3 : Model := ⟨system,["a","b"],[c],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_4_1_3 = [c] := by decide
example : favorable m3_4_1_3 = [] := by decide
example : unfavorable m3_4_1_3 = [c] := by decide
example : secure m3_4_1_3 = false := by decide
def m3_4_1_4 : Model := ⟨system,["a","b"],[c],1,["q"],["good","bad","q"]⟩
example : rows m3_4_1_4 = [c] := by decide
example : favorable m3_4_1_4 = [c] := by decide
example : unfavorable m3_4_1_4 = [] := by decide
example : secure m3_4_1_4 = true := by decide
def m3_4_1_5 : Model := ⟨system,["a","b"],[c],1,["good","q"],["good","bad","q"]⟩
example : rows m3_4_1_5 = [c] := by decide
example : favorable m3_4_1_5 = [c] := by decide
example : unfavorable m3_4_1_5 = [] := by decide
example : secure m3_4_1_5 = true := by decide
def m3_4_1_6 : Model := ⟨system,["a","b"],[c],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_4_1_6 = [c] := by decide
example : favorable m3_4_1_6 = [c] := by decide
example : unfavorable m3_4_1_6 = [] := by decide
example : secure m3_4_1_6 = true := by decide
def m3_4_1_7 : Model := ⟨system,["a","b"],[c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_4_1_7 = [c] := by decide
example : favorable m3_4_1_7 = [c] := by decide
example : unfavorable m3_4_1_7 = [] := by decide
example : secure m3_4_1_7 = true := by decide
def m3_5_0_0 : Model := ⟨system,["a","b"],[a,c],0,[],["good","bad","q"]⟩
example : rows m3_5_0_0 = [c] := by decide
example : favorable m3_5_0_0 = [] := by decide
example : unfavorable m3_5_0_0 = [c] := by decide
example : secure m3_5_0_0 = false := by decide
def m3_5_0_1 : Model := ⟨system,["a","b"],[a,c],0,["good"],["good","bad","q"]⟩
example : rows m3_5_0_1 = [c] := by decide
example : favorable m3_5_0_1 = [] := by decide
example : unfavorable m3_5_0_1 = [c] := by decide
example : secure m3_5_0_1 = false := by decide
def m3_5_0_2 : Model := ⟨system,["a","b"],[a,c],0,["bad"],["good","bad","q"]⟩
example : rows m3_5_0_2 = [c] := by decide
example : favorable m3_5_0_2 = [] := by decide
example : unfavorable m3_5_0_2 = [c] := by decide
example : secure m3_5_0_2 = false := by decide
def m3_5_0_3 : Model := ⟨system,["a","b"],[a,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_5_0_3 = [c] := by decide
example : favorable m3_5_0_3 = [] := by decide
example : unfavorable m3_5_0_3 = [c] := by decide
example : secure m3_5_0_3 = false := by decide
def m3_5_0_4 : Model := ⟨system,["a","b"],[a,c],0,["q"],["good","bad","q"]⟩
example : rows m3_5_0_4 = [c] := by decide
example : favorable m3_5_0_4 = [c] := by decide
example : unfavorable m3_5_0_4 = [] := by decide
example : secure m3_5_0_4 = true := by decide
def m3_5_0_5 : Model := ⟨system,["a","b"],[a,c],0,["good","q"],["good","bad","q"]⟩
example : rows m3_5_0_5 = [c] := by decide
example : favorable m3_5_0_5 = [c] := by decide
example : unfavorable m3_5_0_5 = [] := by decide
example : secure m3_5_0_5 = true := by decide
def m3_5_0_6 : Model := ⟨system,["a","b"],[a,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_5_0_6 = [c] := by decide
example : favorable m3_5_0_6 = [c] := by decide
example : unfavorable m3_5_0_6 = [] := by decide
example : secure m3_5_0_6 = true := by decide
def m3_5_0_7 : Model := ⟨system,["a","b"],[a,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_5_0_7 = [c] := by decide
example : favorable m3_5_0_7 = [c] := by decide
example : unfavorable m3_5_0_7 = [] := by decide
example : secure m3_5_0_7 = true := by decide
def m3_5_1_0 : Model := ⟨system,["a","b"],[a,c],1,[],["good","bad","q"]⟩
example : rows m3_5_1_0 = [a,c] := by decide
example : favorable m3_5_1_0 = [] := by decide
example : unfavorable m3_5_1_0 = [a,c] := by decide
example : secure m3_5_1_0 = false := by decide
def m3_5_1_1 : Model := ⟨system,["a","b"],[a,c],1,["good"],["good","bad","q"]⟩
example : rows m3_5_1_1 = [a,c] := by decide
example : favorable m3_5_1_1 = [a] := by decide
example : unfavorable m3_5_1_1 = [c] := by decide
example : secure m3_5_1_1 = false := by decide
def m3_5_1_2 : Model := ⟨system,["a","b"],[a,c],1,["bad"],["good","bad","q"]⟩
example : rows m3_5_1_2 = [a,c] := by decide
example : favorable m3_5_1_2 = [] := by decide
example : unfavorable m3_5_1_2 = [a,c] := by decide
example : secure m3_5_1_2 = false := by decide
def m3_5_1_3 : Model := ⟨system,["a","b"],[a,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_5_1_3 = [a,c] := by decide
example : favorable m3_5_1_3 = [a] := by decide
example : unfavorable m3_5_1_3 = [c] := by decide
example : secure m3_5_1_3 = false := by decide
def m3_5_1_4 : Model := ⟨system,["a","b"],[a,c],1,["q"],["good","bad","q"]⟩
example : rows m3_5_1_4 = [a,c] := by decide
example : favorable m3_5_1_4 = [c] := by decide
example : unfavorable m3_5_1_4 = [a] := by decide
example : secure m3_5_1_4 = false := by decide
def m3_5_1_5 : Model := ⟨system,["a","b"],[a,c],1,["good","q"],["good","bad","q"]⟩
example : rows m3_5_1_5 = [a,c] := by decide
example : favorable m3_5_1_5 = [a,c] := by decide
example : unfavorable m3_5_1_5 = [] := by decide
example : secure m3_5_1_5 = true := by decide
def m3_5_1_6 : Model := ⟨system,["a","b"],[a,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_5_1_6 = [a,c] := by decide
example : favorable m3_5_1_6 = [c] := by decide
example : unfavorable m3_5_1_6 = [a] := by decide
example : secure m3_5_1_6 = false := by decide
def m3_5_1_7 : Model := ⟨system,["a","b"],[a,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_5_1_7 = [a,c] := by decide
example : favorable m3_5_1_7 = [a,c] := by decide
example : unfavorable m3_5_1_7 = [] := by decide
example : secure m3_5_1_7 = true := by decide
def m3_6_0_0 : Model := ⟨system,["a","b"],[b,c],0,[],["good","bad","q"]⟩
example : rows m3_6_0_0 = [c] := by decide
example : favorable m3_6_0_0 = [] := by decide
example : unfavorable m3_6_0_0 = [c] := by decide
example : secure m3_6_0_0 = false := by decide
def m3_6_0_1 : Model := ⟨system,["a","b"],[b,c],0,["good"],["good","bad","q"]⟩
example : rows m3_6_0_1 = [c] := by decide
example : favorable m3_6_0_1 = [] := by decide
example : unfavorable m3_6_0_1 = [c] := by decide
example : secure m3_6_0_1 = false := by decide
def m3_6_0_2 : Model := ⟨system,["a","b"],[b,c],0,["bad"],["good","bad","q"]⟩
example : rows m3_6_0_2 = [c] := by decide
example : favorable m3_6_0_2 = [] := by decide
example : unfavorable m3_6_0_2 = [c] := by decide
example : secure m3_6_0_2 = false := by decide
def m3_6_0_3 : Model := ⟨system,["a","b"],[b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_6_0_3 = [c] := by decide
example : favorable m3_6_0_3 = [] := by decide
example : unfavorable m3_6_0_3 = [c] := by decide
example : secure m3_6_0_3 = false := by decide
def m3_6_0_4 : Model := ⟨system,["a","b"],[b,c],0,["q"],["good","bad","q"]⟩
example : rows m3_6_0_4 = [c] := by decide
example : favorable m3_6_0_4 = [c] := by decide
example : unfavorable m3_6_0_4 = [] := by decide
example : secure m3_6_0_4 = true := by decide
def m3_6_0_5 : Model := ⟨system,["a","b"],[b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m3_6_0_5 = [c] := by decide
example : favorable m3_6_0_5 = [c] := by decide
example : unfavorable m3_6_0_5 = [] := by decide
example : secure m3_6_0_5 = true := by decide
def m3_6_0_6 : Model := ⟨system,["a","b"],[b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_6_0_6 = [c] := by decide
example : favorable m3_6_0_6 = [c] := by decide
example : unfavorable m3_6_0_6 = [] := by decide
example : secure m3_6_0_6 = true := by decide
def m3_6_0_7 : Model := ⟨system,["a","b"],[b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_6_0_7 = [c] := by decide
example : favorable m3_6_0_7 = [c] := by decide
example : unfavorable m3_6_0_7 = [] := by decide
example : secure m3_6_0_7 = true := by decide
def m3_6_1_0 : Model := ⟨system,["a","b"],[b,c],1,[],["good","bad","q"]⟩
example : rows m3_6_1_0 = [b,c] := by decide
example : favorable m3_6_1_0 = [] := by decide
example : unfavorable m3_6_1_0 = [b,c] := by decide
example : secure m3_6_1_0 = false := by decide
def m3_6_1_1 : Model := ⟨system,["a","b"],[b,c],1,["good"],["good","bad","q"]⟩
example : rows m3_6_1_1 = [b,c] := by decide
example : favorable m3_6_1_1 = [] := by decide
example : unfavorable m3_6_1_1 = [b,c] := by decide
example : secure m3_6_1_1 = false := by decide
def m3_6_1_2 : Model := ⟨system,["a","b"],[b,c],1,["bad"],["good","bad","q"]⟩
example : rows m3_6_1_2 = [b,c] := by decide
example : favorable m3_6_1_2 = [b] := by decide
example : unfavorable m3_6_1_2 = [c] := by decide
example : secure m3_6_1_2 = false := by decide
def m3_6_1_3 : Model := ⟨system,["a","b"],[b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_6_1_3 = [b,c] := by decide
example : favorable m3_6_1_3 = [b] := by decide
example : unfavorable m3_6_1_3 = [c] := by decide
example : secure m3_6_1_3 = false := by decide
def m3_6_1_4 : Model := ⟨system,["a","b"],[b,c],1,["q"],["good","bad","q"]⟩
example : rows m3_6_1_4 = [b,c] := by decide
example : favorable m3_6_1_4 = [c] := by decide
example : unfavorable m3_6_1_4 = [b] := by decide
example : secure m3_6_1_4 = false := by decide
def m3_6_1_5 : Model := ⟨system,["a","b"],[b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m3_6_1_5 = [b,c] := by decide
example : favorable m3_6_1_5 = [c] := by decide
example : unfavorable m3_6_1_5 = [b] := by decide
example : secure m3_6_1_5 = false := by decide
def m3_6_1_6 : Model := ⟨system,["a","b"],[b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_6_1_6 = [b,c] := by decide
example : favorable m3_6_1_6 = [b,c] := by decide
example : unfavorable m3_6_1_6 = [] := by decide
example : secure m3_6_1_6 = true := by decide
def m3_6_1_7 : Model := ⟨system,["a","b"],[b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_6_1_7 = [b,c] := by decide
example : favorable m3_6_1_7 = [b,c] := by decide
example : unfavorable m3_6_1_7 = [] := by decide
example : secure m3_6_1_7 = true := by decide
def m3_7_0_0 : Model := ⟨system,["a","b"],[a,b,c],0,[],["good","bad","q"]⟩
example : rows m3_7_0_0 = [c] := by decide
example : favorable m3_7_0_0 = [] := by decide
example : unfavorable m3_7_0_0 = [c] := by decide
example : secure m3_7_0_0 = false := by decide
def m3_7_0_1 : Model := ⟨system,["a","b"],[a,b,c],0,["good"],["good","bad","q"]⟩
example : rows m3_7_0_1 = [c] := by decide
example : favorable m3_7_0_1 = [] := by decide
example : unfavorable m3_7_0_1 = [c] := by decide
example : secure m3_7_0_1 = false := by decide
def m3_7_0_2 : Model := ⟨system,["a","b"],[a,b,c],0,["bad"],["good","bad","q"]⟩
example : rows m3_7_0_2 = [c] := by decide
example : favorable m3_7_0_2 = [] := by decide
example : unfavorable m3_7_0_2 = [c] := by decide
example : secure m3_7_0_2 = false := by decide
def m3_7_0_3 : Model := ⟨system,["a","b"],[a,b,c],0,["good","bad"],["good","bad","q"]⟩
example : rows m3_7_0_3 = [c] := by decide
example : favorable m3_7_0_3 = [] := by decide
example : unfavorable m3_7_0_3 = [c] := by decide
example : secure m3_7_0_3 = false := by decide
def m3_7_0_4 : Model := ⟨system,["a","b"],[a,b,c],0,["q"],["good","bad","q"]⟩
example : rows m3_7_0_4 = [c] := by decide
example : favorable m3_7_0_4 = [c] := by decide
example : unfavorable m3_7_0_4 = [] := by decide
example : secure m3_7_0_4 = true := by decide
def m3_7_0_5 : Model := ⟨system,["a","b"],[a,b,c],0,["good","q"],["good","bad","q"]⟩
example : rows m3_7_0_5 = [c] := by decide
example : favorable m3_7_0_5 = [c] := by decide
example : unfavorable m3_7_0_5 = [] := by decide
example : secure m3_7_0_5 = true := by decide
def m3_7_0_6 : Model := ⟨system,["a","b"],[a,b,c],0,["bad","q"],["good","bad","q"]⟩
example : rows m3_7_0_6 = [c] := by decide
example : favorable m3_7_0_6 = [c] := by decide
example : unfavorable m3_7_0_6 = [] := by decide
example : secure m3_7_0_6 = true := by decide
def m3_7_0_7 : Model := ⟨system,["a","b"],[a,b,c],0,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_7_0_7 = [c] := by decide
example : favorable m3_7_0_7 = [c] := by decide
example : unfavorable m3_7_0_7 = [] := by decide
example : secure m3_7_0_7 = true := by decide
def m3_7_1_0 : Model := ⟨system,["a","b"],[a,b,c],1,[],["good","bad","q"]⟩
example : rows m3_7_1_0 = [a,b,c] := by decide
example : favorable m3_7_1_0 = [] := by decide
example : unfavorable m3_7_1_0 = [a,b,c] := by decide
example : secure m3_7_1_0 = false := by decide
def m3_7_1_1 : Model := ⟨system,["a","b"],[a,b,c],1,["good"],["good","bad","q"]⟩
example : rows m3_7_1_1 = [a,b,c] := by decide
example : favorable m3_7_1_1 = [a] := by decide
example : unfavorable m3_7_1_1 = [b,c] := by decide
example : secure m3_7_1_1 = false := by decide
def m3_7_1_2 : Model := ⟨system,["a","b"],[a,b,c],1,["bad"],["good","bad","q"]⟩
example : rows m3_7_1_2 = [a,b,c] := by decide
example : favorable m3_7_1_2 = [b] := by decide
example : unfavorable m3_7_1_2 = [a,c] := by decide
example : secure m3_7_1_2 = false := by decide
def m3_7_1_3 : Model := ⟨system,["a","b"],[a,b,c],1,["good","bad"],["good","bad","q"]⟩
example : rows m3_7_1_3 = [a,b,c] := by decide
example : favorable m3_7_1_3 = [a,b] := by decide
example : unfavorable m3_7_1_3 = [c] := by decide
example : secure m3_7_1_3 = false := by decide
def m3_7_1_4 : Model := ⟨system,["a","b"],[a,b,c],1,["q"],["good","bad","q"]⟩
example : rows m3_7_1_4 = [a,b,c] := by decide
example : favorable m3_7_1_4 = [c] := by decide
example : unfavorable m3_7_1_4 = [a,b] := by decide
example : secure m3_7_1_4 = false := by decide
def m3_7_1_5 : Model := ⟨system,["a","b"],[a,b,c],1,["good","q"],["good","bad","q"]⟩
example : rows m3_7_1_5 = [a,b,c] := by decide
example : favorable m3_7_1_5 = [a,c] := by decide
example : unfavorable m3_7_1_5 = [b] := by decide
example : secure m3_7_1_5 = false := by decide
def m3_7_1_6 : Model := ⟨system,["a","b"],[a,b,c],1,["bad","q"],["good","bad","q"]⟩
example : rows m3_7_1_6 = [a,b,c] := by decide
example : favorable m3_7_1_6 = [b,c] := by decide
example : unfavorable m3_7_1_6 = [a] := by decide
example : secure m3_7_1_6 = false := by decide
def m3_7_1_7 : Model := ⟨system,["a","b"],[a,b,c],1,["good","bad","q"],["good","bad","q"]⟩
example : rows m3_7_1_7 = [a,b,c] := by decide
example : favorable m3_7_1_7 = [a,b,c] := by decide
example : unfavorable m3_7_1_7 = [] := by decide
example : secure m3_7_1_7 = true := by decide
def nativeExecution : Execution m1_1_1_1 := ⟨a,(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩,rfl,rfl⟩
def nativeStop : StoppedExecution m1_1_1_1 := ⟨nativeExecution,rfl⟩
theorem nativeSecurity : nativeExecution.schedule.finalState ∈ m1_1_1_1.secureStates := actualSecurity _ (by decide) nativeExecution
#print axioms nativeExecution
#print axioms nativeStop
#print axioms nativeSecurity
end SFT.Computation.Adversarial
