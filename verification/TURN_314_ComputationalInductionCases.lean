import SFT.Computation.ComputationalInduction
namespace SFT.Computation.ComputationalInduction
def m0_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[],[]⟩
example : (alternatives m0_0_0_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_0_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_0_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[],[("h0","h1")]⟩
example : (alternatives m0_0_0_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_0_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[],[("h1","h0")]⟩
example : (alternatives m0_0_0_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_0_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_0_0_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_0_3 = [] := by decide
example : (alternatives (extendEvidence m0_0_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[]⟩
example : (alternatives m0_0_1_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_1_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_0_1_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : (alternatives m0_0_1_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_0_1_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : (alternatives m0_0_1_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_1_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_0_1_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_1_3 = [] := by decide
example : (alternatives (extendEvidence m0_0_1_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m0_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[]⟩
example : (alternatives m0_0_2_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_2_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_0_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_2_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_0_2_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_0_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_2_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_0_2_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_2_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_0_2_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_2_3 = [] := by decide
example : (alternatives (extendEvidence m0_0_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_0_2_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : (alternatives m0_0_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_0_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_0_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_0_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_0_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_0_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_0_3_3 = [] := by decide
example : (alternatives (extendEvidence m0_0_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_0_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[]⟩
example : (alternatives m0_1_0_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_0_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_0_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("h0","h1")]⟩
example : (alternatives m0_1_0_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_0_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("h1","h0")]⟩
example : (alternatives m0_1_0_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_0_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_1_0_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_1_0_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_0_3 = [] := by decide
example : (alternatives (extendEvidence m0_1_0_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[]⟩
example : (alternatives m0_1_1_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_1_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_1_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : (alternatives m0_1_1_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_1_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : (alternatives m0_1_1_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_1_1_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_1_1_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_1_3 = [] := by decide
example : (alternatives (extendEvidence m0_1_1_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m0_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[]⟩
example : (alternatives m0_1_2_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_2_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_2_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_2_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_1_2_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_2_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_2_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_1_2_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_1_2_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_2_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_1_2_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_2_3 = [] := by decide
example : (alternatives (extendEvidence m0_1_2_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_2_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : (alternatives m0_1_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_3_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_1_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_1_3_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_1_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_1_3_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_1_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_1_3_3 = [] := by decide
example : (alternatives (extendEvidence m0_1_3_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_1_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m0_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[]⟩
example : (alternatives m0_2_0_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_0_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_2_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_0_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[("h0","h1")]⟩
example : (alternatives m0_2_0_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_2_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_0_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[("h1","h0")]⟩
example : (alternatives m0_2_0_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_0_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_0_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_2_0_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_0_3 = [] := by decide
example : (alternatives (extendEvidence m0_2_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_0_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[]⟩
example : (alternatives m0_2_1_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_1_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_2_1_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_1_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : (alternatives m0_2_1_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_2_1_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_1_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : (alternatives m0_2_1_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_1_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_1_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_2_1_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_1_3 = [] := by decide
example : (alternatives (extendEvidence m0_2_1_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_1_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[]⟩
example : (alternatives m0_2_2_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_2_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_2_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_2_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_2_2_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_2_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_2_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_2_2_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_2_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_2_2_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_2_3 = [] := by decide
example : (alternatives (extendEvidence m0_2_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m0_2_2_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : (alternatives m0_2_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_2_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_3_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_2_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_2_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_3_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_2_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_3_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_2_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_2_3_3 = [] := by decide
example : (alternatives (extendEvidence m0_2_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m0_2_3_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[]⟩
example : (alternatives m0_3_0_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_0_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_0_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_0_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[("h0","h1")]⟩
example : (alternatives m0_3_0_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_0_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_0_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[("h1","h0")]⟩
example : (alternatives m0_3_0_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_0_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_3_0_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_0_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_3_0_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_0_3 = [] := by decide
example : (alternatives (extendEvidence m0_3_0_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_0_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[]⟩
example : (alternatives m0_3_1_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_1_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_1_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_1_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : (alternatives m0_3_1_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_1_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_1_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : (alternatives m0_3_1_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_3_1_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_1_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_3_1_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_1_3 = [] := by decide
example : (alternatives (extendEvidence m0_3_1_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_1_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m0_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[]⟩
example : (alternatives m0_3_2_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_2_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_2_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_2_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_3_2_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_2_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_2_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_3_2_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_3_2_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_2_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_3_2_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_2_3 = [] := by decide
example : (alternatives (extendEvidence m0_3_2_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_2_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : (alternatives m0_3_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_3_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_3_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : (alternatives m0_3_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m0_3_3_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_3_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : (alternatives m0_3_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m0_3_3_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_3_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m0_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m0_3_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m0_3_3_3 = [] := by decide
example : (alternatives (extendEvidence m0_3_3_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m0_3_3_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m1_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[]⟩
example : (alternatives m1_0_0_0).map Prod.fst = [] := by decide
example : minimalRules m1_0_0_0 = [] := by decide
example : (alternatives (extendEvidence m1_0_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_0_0_1).map Prod.fst = [] := by decide
example : minimalRules m1_0_0_1 = [] := by decide
example : (alternatives (extendEvidence m1_0_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_0_0_2).map Prod.fst = [] := by decide
example : minimalRules m1_0_0_2 = [] := by decide
example : (alternatives (extendEvidence m1_0_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_0_0_3).map Prod.fst = [] := by decide
example : minimalRules m1_0_0_3 = [] := by decide
example : (alternatives (extendEvidence m1_0_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[]⟩
example : (alternatives m1_0_1_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_1_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_1_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_0_1_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_1_1 = [] := by decide
example : (alternatives (extendEvidence m1_0_1_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_0_1_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_1_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_0_1_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_1_3 = [] := by decide
example : (alternatives (extendEvidence m1_0_1_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_0_2_0).map Prod.fst = [] := by decide
example : minimalRules m1_0_2_0 = [] := by decide
example : (alternatives (extendEvidence m1_0_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_2_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_0_2_1).map Prod.fst = [] := by decide
example : minimalRules m1_0_2_1 = [] := by decide
example : (alternatives (extendEvidence m1_0_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_2_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_0_2_2).map Prod.fst = [] := by decide
example : minimalRules m1_0_2_2 = [] := by decide
example : (alternatives (extendEvidence m1_0_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_2_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_0_2_3).map Prod.fst = [] := by decide
example : minimalRules m1_0_2_3 = [] := by decide
example : (alternatives (extendEvidence m1_0_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_0_2_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_0_3_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_3_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_0_3_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_3_1 = [] := by decide
example : (alternatives (extendEvidence m1_0_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_0_3_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_0_3_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_0_3_3 = [] := by decide
example : (alternatives (extendEvidence m1_0_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_0_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[]⟩
example : (alternatives m1_1_0_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_0_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_0_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_1_0_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_0_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_1_0_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_0_2 = [] := by decide
example : (alternatives (extendEvidence m1_1_0_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_1_0_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_0_3 = [] := by decide
example : (alternatives (extendEvidence m1_1_0_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : (alternatives m1_1_1_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_1_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_1_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_1_1_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_1_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_1_1_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_1_1_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_1_1_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_1_3 = [] := by decide
example : (alternatives (extendEvidence m1_1_1_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_1_2_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_2_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_2_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_2_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_1_2_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_2_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_2_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_1_2_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_2_2 = [] := by decide
example : (alternatives (extendEvidence m1_1_2_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_2_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_1_2_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_1_2_3 = [] := by decide
example : (alternatives (extendEvidence m1_1_2_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_2_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_1_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_3_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_1_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_1_3_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_1_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_1_3_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_1_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_1_3_3 = [] := by decide
example : (alternatives (extendEvidence m1_1_3_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_1_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[]⟩
example : (alternatives m1_2_0_0).map Prod.fst = [] := by decide
example : minimalRules m1_2_0_0 = [] := by decide
example : (alternatives (extendEvidence m1_2_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_2_0_1).map Prod.fst = [] := by decide
example : minimalRules m1_2_0_1 = [] := by decide
example : (alternatives (extendEvidence m1_2_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_2_0_2).map Prod.fst = [] := by decide
example : minimalRules m1_2_0_2 = [] := by decide
example : (alternatives (extendEvidence m1_2_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_2_0_3).map Prod.fst = [] := by decide
example : minimalRules m1_2_0_3 = [] := by decide
example : (alternatives (extendEvidence m1_2_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : (alternatives m1_2_1_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_1_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_1_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_2_1_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_1_1 = [] := by decide
example : (alternatives (extendEvidence m1_2_1_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_2_1_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_1_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_2_1_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_1_3 = [] := by decide
example : (alternatives (extendEvidence m1_2_1_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_2_2_0).map Prod.fst = [] := by decide
example : minimalRules m1_2_2_0 = [] := by decide
example : (alternatives (extendEvidence m1_2_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_2_0 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_2_2_1).map Prod.fst = [] := by decide
example : minimalRules m1_2_2_1 = [] := by decide
example : (alternatives (extendEvidence m1_2_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_2_1 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_2_2_2).map Prod.fst = [] := by decide
example : minimalRules m1_2_2_2 = [] := by decide
example : (alternatives (extendEvidence m1_2_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_2_2 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_2_2_3).map Prod.fst = [] := by decide
example : minimalRules m1_2_2_3 = [] := by decide
example : (alternatives (extendEvidence m1_2_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m1_2_2_3 ("a","y"))).map Prod.fst = [] := by decide
def m1_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_2_3_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_3_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_2_3_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_3_1 = [] := by decide
example : (alternatives (extendEvidence m1_2_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_2_3_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_2_3_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m1_2_3_3 = [] := by decide
example : (alternatives (extendEvidence m1_2_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m1_2_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m1_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[]⟩
example : (alternatives m1_3_0_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_0_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_0_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_0_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_3_0_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_0_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_0_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_3_0_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_0_2 = [] := by decide
example : (alternatives (extendEvidence m1_3_0_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_0_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_3_0_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_0_3 = [] := by decide
example : (alternatives (extendEvidence m1_3_0_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_0_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : (alternatives m1_3_1_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_1_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_1_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_1_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_3_1_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_1_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_1_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_3_1_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_1_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_3_1_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_1_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_3_1_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_1_3 = [] := by decide
example : (alternatives (extendEvidence m1_3_1_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_1_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_3_2_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_2_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_2_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_2_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_3_2_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_2_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_2_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_3_2_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_2_2 = [] := by decide
example : (alternatives (extendEvidence m1_3_2_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_2_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_3_2_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m1_3_2_3 = [] := by decide
example : (alternatives (extendEvidence m1_3_2_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_2_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m1_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : (alternatives m1_3_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_3_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_3_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m1_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : (alternatives m1_3_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m1_3_3_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_3_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m1_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : (alternatives m1_3_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m1_3_3_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_3_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m1_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m1_3_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m1_3_3_3 = [] := by decide
example : (alternatives (extendEvidence m1_3_3_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m1_3_3_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[]⟩
example : (alternatives m2_0_0_0).map Prod.fst = [] := by decide
example : minimalRules m2_0_0_0 = [] := by decide
example : (alternatives (extendEvidence m2_0_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_0_0_1).map Prod.fst = [] := by decide
example : minimalRules m2_0_0_1 = [] := by decide
example : (alternatives (extendEvidence m2_0_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_0_0_2).map Prod.fst = [] := by decide
example : minimalRules m2_0_0_2 = [] := by decide
example : (alternatives (extendEvidence m2_0_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_0_0_3).map Prod.fst = [] := by decide
example : minimalRules m2_0_0_3 = [] := by decide
example : (alternatives (extendEvidence m2_0_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[]⟩
example : (alternatives m2_0_1_0).map Prod.fst = [] := by decide
example : minimalRules m2_0_1_0 = [] := by decide
example : (alternatives (extendEvidence m2_0_1_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_0_1_1).map Prod.fst = [] := by decide
example : minimalRules m2_0_1_1 = [] := by decide
example : (alternatives (extendEvidence m2_0_1_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_0_1_2).map Prod.fst = [] := by decide
example : minimalRules m2_0_1_2 = [] := by decide
example : (alternatives (extendEvidence m2_0_1_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_0_1_3).map Prod.fst = [] := by decide
example : minimalRules m2_0_1_3 = [] := by decide
example : (alternatives (extendEvidence m2_0_1_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m2_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_0_2_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_2_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_2_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_0_2_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_2_1 = [] := by decide
example : (alternatives (extendEvidence m2_0_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_2_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_0_2_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_2_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_0_2_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_2_3 = [] := by decide
example : (alternatives (extendEvidence m2_0_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_0_2_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_0_3_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_3_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_0_3_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_3_1 = [] := by decide
example : (alternatives (extendEvidence m2_0_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_0_3_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_0_3_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_0_3_3 = [] := by decide
example : (alternatives (extendEvidence m2_0_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_0_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[]⟩
example : (alternatives m2_1_0_0).map Prod.fst = [] := by decide
example : minimalRules m2_1_0_0 = [] := by decide
example : (alternatives (extendEvidence m2_1_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_1_0_1).map Prod.fst = [] := by decide
example : minimalRules m2_1_0_1 = [] := by decide
example : (alternatives (extendEvidence m2_1_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_1_0_2).map Prod.fst = [] := by decide
example : minimalRules m2_1_0_2 = [] := by decide
example : (alternatives (extendEvidence m2_1_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_1_0_3).map Prod.fst = [] := by decide
example : minimalRules m2_1_0_3 = [] := by decide
example : (alternatives (extendEvidence m2_1_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[]⟩
example : (alternatives m2_1_1_0).map Prod.fst = [] := by decide
example : minimalRules m2_1_1_0 = [] := by decide
example : (alternatives (extendEvidence m2_1_1_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_1_1_1).map Prod.fst = [] := by decide
example : minimalRules m2_1_1_1 = [] := by decide
example : (alternatives (extendEvidence m2_1_1_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_1_1_2).map Prod.fst = [] := by decide
example : minimalRules m2_1_1_2 = [] := by decide
example : (alternatives (extendEvidence m2_1_1_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_1_1_3).map Prod.fst = [] := by decide
example : minimalRules m2_1_1_3 = [] := by decide
example : (alternatives (extendEvidence m2_1_1_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m2_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_1_2_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_2_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_2_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_1_2_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_2_1 = [] := by decide
example : (alternatives (extendEvidence m2_1_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_2_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_1_2_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_2_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_1_2_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_2_3 = [] := by decide
example : (alternatives (extendEvidence m2_1_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_1_2_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_1_3_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_3_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_1_3_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_3_1 = [] := by decide
example : (alternatives (extendEvidence m2_1_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_1_3_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_1_3_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m2_1_3_3 = [] := by decide
example : (alternatives (extendEvidence m2_1_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_1_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m2_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[]⟩
example : (alternatives m2_2_0_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_0_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_2_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_0_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_2_0_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_2_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_0_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_2_0_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_0_2 = [] := by decide
example : (alternatives (extendEvidence m2_2_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_0_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_2_0_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_0_3 = [] := by decide
example : (alternatives (extendEvidence m2_2_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_0_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[]⟩
example : (alternatives m2_2_1_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_1_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_2_1_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_1_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_2_1_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_2_1_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_1_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_2_1_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_1_2 = [] := by decide
example : (alternatives (extendEvidence m2_2_1_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_1_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_2_1_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_2_1_3 = [] := by decide
example : (alternatives (extendEvidence m2_2_1_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_1_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_2_2_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_2_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_2_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_2_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_2_2_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_2_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_2_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_2_2_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_2_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_2_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_2_2_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_2_3 = [] := by decide
example : (alternatives (extendEvidence m2_2_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m2_2_2_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_2_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_2_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_2_3_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_2_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_2_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_2_3_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_2_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_2_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_2_3_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_2_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_2_3_3 = [] := by decide
example : (alternatives (extendEvidence m2_2_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m2_2_3_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[]⟩
example : (alternatives m2_3_0_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_0_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_0_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_0_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_3_0_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_0_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_0_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_3_0_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_0_2 = [] := by decide
example : (alternatives (extendEvidence m2_3_0_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_0_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_3_0_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_0_3 = [] := by decide
example : (alternatives (extendEvidence m2_3_0_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_0_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[]⟩
example : (alternatives m2_3_1_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_1_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_1_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_1_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_3_1_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_1_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_1_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_3_1_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_1_2 = [] := by decide
example : (alternatives (extendEvidence m2_3_1_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_1_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_3_1_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m2_3_1_3 = [] := by decide
example : (alternatives (extendEvidence m2_3_1_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_1_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m2_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_3_2_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_2_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_3_2_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_2_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_3_2_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_2_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_2_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_3_2_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_2_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_3_2_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_2_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_3_2_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_2_3 = [] := by decide
example : (alternatives (extendEvidence m2_3_2_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_2_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : (alternatives m2_3_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_3_3_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_3_3_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : (alternatives m2_3_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m2_3_3_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_3_3_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : (alternatives m2_3_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m2_3_3_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_3_3_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m2_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m2_3_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m2_3_3_3 = [] := by decide
example : (alternatives (extendEvidence m2_3_3_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m2_3_3_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m3_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_0_0_0).map Prod.fst = [] := by decide
example : minimalRules m3_0_0_0 = [] := by decide
example : (alternatives (extendEvidence m3_0_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_0_0_1).map Prod.fst = [] := by decide
example : minimalRules m3_0_0_1 = [] := by decide
example : (alternatives (extendEvidence m3_0_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_0_0_2).map Prod.fst = [] := by decide
example : minimalRules m3_0_0_2 = [] := by decide
example : (alternatives (extendEvidence m3_0_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_0_0_3).map Prod.fst = [] := by decide
example : minimalRules m3_0_0_3 = [] := by decide
example : (alternatives (extendEvidence m3_0_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_0_1_0).map Prod.fst = [] := by decide
example : minimalRules m3_0_1_0 = [] := by decide
example : (alternatives (extendEvidence m3_0_1_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_0_1_1).map Prod.fst = [] := by decide
example : minimalRules m3_0_1_1 = [] := by decide
example : (alternatives (extendEvidence m3_0_1_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_0_1_2).map Prod.fst = [] := by decide
example : minimalRules m3_0_1_2 = [] := by decide
example : (alternatives (extendEvidence m3_0_1_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_0_1_3).map Prod.fst = [] := by decide
example : minimalRules m3_0_1_3 = [] := by decide
example : (alternatives (extendEvidence m3_0_1_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_0_2_0).map Prod.fst = [] := by decide
example : minimalRules m3_0_2_0 = [] := by decide
example : (alternatives (extendEvidence m3_0_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_2_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_0_2_1).map Prod.fst = [] := by decide
example : minimalRules m3_0_2_1 = [] := by decide
example : (alternatives (extendEvidence m3_0_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_2_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_0_2_2).map Prod.fst = [] := by decide
example : minimalRules m3_0_2_2 = [] := by decide
example : (alternatives (extendEvidence m3_0_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_2_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_0_2_3).map Prod.fst = [] := by decide
example : minimalRules m3_0_2_3 = [] := by decide
example : (alternatives (extendEvidence m3_0_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_0_2_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_0_3_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_0_3_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m3_0_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_0_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_0_3_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_0_3_1 = [] := by decide
example : (alternatives (extendEvidence m3_0_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_0_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_0_3_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_0_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m3_0_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_0_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_0_3_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_0_3_3 = [] := by decide
example : (alternatives (extendEvidence m3_0_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_0_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_1_0_0).map Prod.fst = [] := by decide
example : minimalRules m3_1_0_0 = [] := by decide
example : (alternatives (extendEvidence m3_1_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_1_0_1).map Prod.fst = [] := by decide
example : minimalRules m3_1_0_1 = [] := by decide
example : (alternatives (extendEvidence m3_1_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_1_0_2).map Prod.fst = [] := by decide
example : minimalRules m3_1_0_2 = [] := by decide
example : (alternatives (extendEvidence m3_1_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_1_0_3).map Prod.fst = [] := by decide
example : minimalRules m3_1_0_3 = [] := by decide
example : (alternatives (extendEvidence m3_1_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_1_1_0).map Prod.fst = [] := by decide
example : minimalRules m3_1_1_0 = [] := by decide
example : (alternatives (extendEvidence m3_1_1_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_1_1_1).map Prod.fst = [] := by decide
example : minimalRules m3_1_1_1 = [] := by decide
example : (alternatives (extendEvidence m3_1_1_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_1_1_2).map Prod.fst = [] := by decide
example : minimalRules m3_1_1_2 = [] := by decide
example : (alternatives (extendEvidence m3_1_1_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_1_1_3).map Prod.fst = [] := by decide
example : minimalRules m3_1_1_3 = [] := by decide
example : (alternatives (extendEvidence m3_1_1_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_1_2_0).map Prod.fst = [] := by decide
example : minimalRules m3_1_2_0 = [] := by decide
example : (alternatives (extendEvidence m3_1_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_2_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_1_2_1).map Prod.fst = [] := by decide
example : minimalRules m3_1_2_1 = [] := by decide
example : (alternatives (extendEvidence m3_1_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_2_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_1_2_2).map Prod.fst = [] := by decide
example : minimalRules m3_1_2_2 = [] := by decide
example : (alternatives (extendEvidence m3_1_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_2_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_1_2_3).map Prod.fst = [] := by decide
example : minimalRules m3_1_2_3 = [] := by decide
example : (alternatives (extendEvidence m3_1_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_1_2_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_1_3_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_1_3_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m3_1_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_1_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_1_3_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_1_3_1 = [] := by decide
example : (alternatives (extendEvidence m3_1_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_1_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_1_3_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_1_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m3_1_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_1_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_1_3_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_1_3_3 = [] := by decide
example : (alternatives (extendEvidence m3_1_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_1_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_2_0_0).map Prod.fst = [] := by decide
example : minimalRules m3_2_0_0 = [] := by decide
example : (alternatives (extendEvidence m3_2_0_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_0_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_2_0_1).map Prod.fst = [] := by decide
example : minimalRules m3_2_0_1 = [] := by decide
example : (alternatives (extendEvidence m3_2_0_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_0_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_2_0_2).map Prod.fst = [] := by decide
example : minimalRules m3_2_0_2 = [] := by decide
example : (alternatives (extendEvidence m3_2_0_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_0_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_2_0_3).map Prod.fst = [] := by decide
example : minimalRules m3_2_0_3 = [] := by decide
example : (alternatives (extendEvidence m3_2_0_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_0_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_2_1_0).map Prod.fst = [] := by decide
example : minimalRules m3_2_1_0 = [] := by decide
example : (alternatives (extendEvidence m3_2_1_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_1_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_2_1_1).map Prod.fst = [] := by decide
example : minimalRules m3_2_1_1 = [] := by decide
example : (alternatives (extendEvidence m3_2_1_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_1_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_2_1_2).map Prod.fst = [] := by decide
example : minimalRules m3_2_1_2 = [] := by decide
example : (alternatives (extendEvidence m3_2_1_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_1_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_2_1_3).map Prod.fst = [] := by decide
example : minimalRules m3_2_1_3 = [] := by decide
example : (alternatives (extendEvidence m3_2_1_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_1_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_2_2_0).map Prod.fst = [] := by decide
example : minimalRules m3_2_2_0 = [] := by decide
example : (alternatives (extendEvidence m3_2_2_0 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_2_0 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_2_2_1).map Prod.fst = [] := by decide
example : minimalRules m3_2_2_1 = [] := by decide
example : (alternatives (extendEvidence m3_2_2_1 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_2_1 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_2_2_2).map Prod.fst = [] := by decide
example : minimalRules m3_2_2_2 = [] := by decide
example : (alternatives (extendEvidence m3_2_2_2 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_2_2 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_2_2_3).map Prod.fst = [] := by decide
example : minimalRules m3_2_2_3 = [] := by decide
example : (alternatives (extendEvidence m3_2_2_3 ("a","x"))).map Prod.fst = [] := by decide
example : (alternatives (extendEvidence m3_2_2_3 ("a","y"))).map Prod.fst = [] := by decide
def m3_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_2_3_0).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_2_3_0 = ["h1"] := by decide
example : (alternatives (extendEvidence m3_2_3_0 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_2_3_0 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_2_3_1).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_2_3_1 = [] := by decide
example : (alternatives (extendEvidence m3_2_3_1 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_2_3_1 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_2_3_2).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_2_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m3_2_3_2 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_2_3_2 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_2_3_3).map Prod.fst = ["h1"] := by decide
example : minimalRules m3_2_3_3 = [] := by decide
example : (alternatives (extendEvidence m3_2_3_3 ("a","x"))).map Prod.fst = ["h1"] := by decide
example : (alternatives (extendEvidence m3_2_3_3 ("a","y"))).map Prod.fst = ["h1"] := by decide
def m3_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_3_0_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_0_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_0_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_0_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_3_0_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_0_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_0_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_0_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_3_0_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_0_2 = [] := by decide
example : (alternatives (extendEvidence m3_3_0_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_0_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_3_0_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_0_3 = [] := by decide
example : (alternatives (extendEvidence m3_3_0_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_0_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_3_1_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_1_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_1_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_1_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_3_1_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_1_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_1_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_1_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_3_1_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_1_2 = [] := by decide
example : (alternatives (extendEvidence m3_3_1_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_1_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_3_1_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_1_3 = [] := by decide
example : (alternatives (extendEvidence m3_3_1_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_1_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_3_2_0).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_2_0 = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_2_0 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_2_0 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_3_2_1).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_2_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_2_1 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_2_1 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_3_2_2).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_2_2 = [] := by decide
example : (alternatives (extendEvidence m3_3_2_2 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_2_2 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_3_2_3).map Prod.fst = ["h0"] := by decide
example : minimalRules m3_3_2_3 = [] := by decide
example : (alternatives (extendEvidence m3_3_2_3 ("a","x"))).map Prod.fst = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_2_3 ("a","y"))).map Prod.fst = ["h0"] := by decide
def m3_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : (alternatives m3_3_3_0).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m3_3_3_0 = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m3_3_3_0 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m3_3_3_0 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m3_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : (alternatives m3_3_3_1).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m3_3_3_1 = ["h0"] := by decide
example : (alternatives (extendEvidence m3_3_3_1 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m3_3_3_1 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m3_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : (alternatives m3_3_3_2).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m3_3_3_2 = ["h1"] := by decide
example : (alternatives (extendEvidence m3_3_3_2 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m3_3_3_2 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def m3_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : (alternatives m3_3_3_3).map Prod.fst = ["h0","h1"] := by decide
example : minimalRules m3_3_3_3 = [] := by decide
example : (alternatives (extendEvidence m3_3_3_3 ("a","x"))).map Prod.fst = ["h0","h1"] := by decide
example : (alternatives (extendEvidence m3_3_3_3 ("a","y"))).map Prod.fst = ["h0","h1"] := by decide
def finiteAgreement : Model := ⟨[("h",[("a","x")])],[("a","x")],[]⟩
example : (alternatives finiteAgreement).map Prod.fst = ["h"] := by decide
example : alternatives (extendEvidence finiteAgreement ("a","y")) = [] := by decide
def nativeCertificate : SuccessorCertificate ("h",[("a","x")]) :=
  ⟨fun _ => ("a","x"),.head _,fun _ _ => .head _⟩
theorem nativeContinuation (n : Nat) : nativeCertificate.generated n ∈ [("a","x")] := generatedContinuation _ nativeCertificate n
#print axioms nativeContinuation
end SFT.Computation.ComputationalInduction
