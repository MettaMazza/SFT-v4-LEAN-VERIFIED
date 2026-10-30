import SFT.Computation.LearningOptimization
namespace SFT.Computation.LearningOptimization
open SFT.Computation.OptimizationTrace
def m0_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[],[]⟩
example : feasible m0_0_0_0 = ["h0","h1"] := by decide
example : optima m0_0_0_0 = ["h0","h1"] := by decide
def m0_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[],[("h0","h1")]⟩
example : feasible m0_0_0_1 = ["h0","h1"] := by decide
example : optima m0_0_0_1 = ["h0"] := by decide
def m0_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[],[("h1","h0")]⟩
example : feasible m0_0_0_2 = ["h0","h1"] := by decide
example : optima m0_0_0_2 = ["h1"] := by decide
def m0_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_0_0_3 = ["h0","h1"] := by decide
example : optima m0_0_0_3 = [] := by decide
def m0_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[]⟩
example : feasible m0_0_1_0 = ["h0","h1"] := by decide
example : optima m0_0_1_0 = ["h0","h1"] := by decide
def m0_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : feasible m0_0_1_1 = ["h0","h1"] := by decide
example : optima m0_0_1_1 = ["h0"] := by decide
def m0_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : feasible m0_0_1_2 = ["h0","h1"] := by decide
example : optima m0_0_1_2 = ["h1"] := by decide
def m0_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_0_1_3 = ["h0","h1"] := by decide
example : optima m0_0_1_3 = [] := by decide
def m0_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[]⟩
example : feasible m0_0_2_0 = ["h0","h1"] := by decide
example : optima m0_0_2_0 = ["h0","h1"] := by decide
def m0_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_0_2_1 = ["h0","h1"] := by decide
example : optima m0_0_2_1 = ["h0"] := by decide
def m0_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_0_2_2 = ["h0","h1"] := by decide
example : optima m0_0_2_2 = ["h1"] := by decide
def m0_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_0_2_3 = ["h0","h1"] := by decide
example : optima m0_0_2_3 = [] := by decide
def m0_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : feasible m0_0_3_0 = ["h0","h1"] := by decide
example : optima m0_0_3_0 = ["h0","h1"] := by decide
def m0_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_0_3_1 = ["h0","h1"] := by decide
example : optima m0_0_3_1 = ["h0"] := by decide
def m0_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_0_3_2 = ["h0","h1"] := by decide
example : optima m0_0_3_2 = ["h1"] := by decide
def m0_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_0_3_3 = ["h0","h1"] := by decide
example : optima m0_0_3_3 = [] := by decide
def m0_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[]⟩
example : feasible m0_1_0_0 = ["h0","h1"] := by decide
example : optima m0_1_0_0 = ["h0","h1"] := by decide
def m0_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("h0","h1")]⟩
example : feasible m0_1_0_1 = ["h0","h1"] := by decide
example : optima m0_1_0_1 = ["h0"] := by decide
def m0_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("h1","h0")]⟩
example : feasible m0_1_0_2 = ["h0","h1"] := by decide
example : optima m0_1_0_2 = ["h1"] := by decide
def m0_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_1_0_3 = ["h0","h1"] := by decide
example : optima m0_1_0_3 = [] := by decide
def m0_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[]⟩
example : feasible m0_1_1_0 = ["h0","h1"] := by decide
example : optima m0_1_1_0 = ["h0","h1"] := by decide
def m0_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : feasible m0_1_1_1 = ["h0","h1"] := by decide
example : optima m0_1_1_1 = ["h0"] := by decide
def m0_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : feasible m0_1_1_2 = ["h0","h1"] := by decide
example : optima m0_1_1_2 = ["h1"] := by decide
def m0_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_1_1_3 = ["h0","h1"] := by decide
example : optima m0_1_1_3 = [] := by decide
def m0_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[]⟩
example : feasible m0_1_2_0 = ["h0","h1"] := by decide
example : optima m0_1_2_0 = ["h0","h1"] := by decide
def m0_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_1_2_1 = ["h0","h1"] := by decide
example : optima m0_1_2_1 = ["h0"] := by decide
def m0_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_1_2_2 = ["h0","h1"] := by decide
example : optima m0_1_2_2 = ["h1"] := by decide
def m0_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_1_2_3 = ["h0","h1"] := by decide
example : optima m0_1_2_3 = [] := by decide
def m0_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : feasible m0_1_3_0 = ["h0","h1"] := by decide
example : optima m0_1_3_0 = ["h0","h1"] := by decide
def m0_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_1_3_1 = ["h0","h1"] := by decide
example : optima m0_1_3_1 = ["h0"] := by decide
def m0_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_1_3_2 = ["h0","h1"] := by decide
example : optima m0_1_3_2 = ["h1"] := by decide
def m0_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_1_3_3 = ["h0","h1"] := by decide
example : optima m0_1_3_3 = [] := by decide
def m0_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[]⟩
example : feasible m0_2_0_0 = ["h0","h1"] := by decide
example : optima m0_2_0_0 = ["h0","h1"] := by decide
def m0_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[("h0","h1")]⟩
example : feasible m0_2_0_1 = ["h0","h1"] := by decide
example : optima m0_2_0_1 = ["h0"] := by decide
def m0_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[("h1","h0")]⟩
example : feasible m0_2_0_2 = ["h0","h1"] := by decide
example : optima m0_2_0_2 = ["h1"] := by decide
def m0_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_2_0_3 = ["h0","h1"] := by decide
example : optima m0_2_0_3 = [] := by decide
def m0_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[]⟩
example : feasible m0_2_1_0 = ["h0","h1"] := by decide
example : optima m0_2_1_0 = ["h0","h1"] := by decide
def m0_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : feasible m0_2_1_1 = ["h0","h1"] := by decide
example : optima m0_2_1_1 = ["h0"] := by decide
def m0_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : feasible m0_2_1_2 = ["h0","h1"] := by decide
example : optima m0_2_1_2 = ["h1"] := by decide
def m0_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_2_1_3 = ["h0","h1"] := by decide
example : optima m0_2_1_3 = [] := by decide
def m0_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[]⟩
example : feasible m0_2_2_0 = ["h0","h1"] := by decide
example : optima m0_2_2_0 = ["h0","h1"] := by decide
def m0_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_2_2_1 = ["h0","h1"] := by decide
example : optima m0_2_2_1 = ["h0"] := by decide
def m0_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_2_2_2 = ["h0","h1"] := by decide
example : optima m0_2_2_2 = ["h1"] := by decide
def m0_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_2_2_3 = ["h0","h1"] := by decide
example : optima m0_2_2_3 = [] := by decide
def m0_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : feasible m0_2_3_0 = ["h0","h1"] := by decide
example : optima m0_2_3_0 = ["h0","h1"] := by decide
def m0_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_2_3_1 = ["h0","h1"] := by decide
example : optima m0_2_3_1 = ["h0"] := by decide
def m0_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_2_3_2 = ["h0","h1"] := by decide
example : optima m0_2_3_2 = ["h1"] := by decide
def m0_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_2_3_3 = ["h0","h1"] := by decide
example : optima m0_2_3_3 = [] := by decide
def m0_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[]⟩
example : feasible m0_3_0_0 = ["h0","h1"] := by decide
example : optima m0_3_0_0 = ["h0","h1"] := by decide
def m0_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[("h0","h1")]⟩
example : feasible m0_3_0_1 = ["h0","h1"] := by decide
example : optima m0_3_0_1 = ["h0"] := by decide
def m0_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[("h1","h0")]⟩
example : feasible m0_3_0_2 = ["h0","h1"] := by decide
example : optima m0_3_0_2 = ["h1"] := by decide
def m0_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_3_0_3 = ["h0","h1"] := by decide
example : optima m0_3_0_3 = [] := by decide
def m0_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[]⟩
example : feasible m0_3_1_0 = ["h0","h1"] := by decide
example : optima m0_3_1_0 = ["h0","h1"] := by decide
def m0_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[("h0","h1")]⟩
example : feasible m0_3_1_1 = ["h0","h1"] := by decide
example : optima m0_3_1_1 = ["h0"] := by decide
def m0_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[("h1","h0")]⟩
example : feasible m0_3_1_2 = ["h0","h1"] := by decide
example : optima m0_3_1_2 = ["h1"] := by decide
def m0_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_3_1_3 = ["h0","h1"] := by decide
example : optima m0_3_1_3 = [] := by decide
def m0_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[]⟩
example : feasible m0_3_2_0 = ["h0","h1"] := by decide
example : optima m0_3_2_0 = ["h0","h1"] := by decide
def m0_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_3_2_1 = ["h0","h1"] := by decide
example : optima m0_3_2_1 = ["h0"] := by decide
def m0_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_3_2_2 = ["h0","h1"] := by decide
example : optima m0_3_2_2 = ["h1"] := by decide
def m0_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_3_2_3 = ["h0","h1"] := by decide
example : optima m0_3_2_3 = [] := by decide
def m0_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[]⟩
example : feasible m0_3_3_0 = ["h0","h1"] := by decide
example : optima m0_3_3_0 = ["h0","h1"] := by decide
def m0_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1")]⟩
example : feasible m0_3_3_1 = ["h0","h1"] := by decide
example : optima m0_3_3_1 = ["h0"] := by decide
def m0_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h1","h0")]⟩
example : feasible m0_3_3_2 = ["h0","h1"] := by decide
example : optima m0_3_3_2 = ["h1"] := by decide
def m0_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[],[("h0","h1"),("h1","h0")]⟩
example : feasible m0_3_3_3 = ["h0","h1"] := by decide
example : optima m0_3_3_3 = [] := by decide
def m1_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[]⟩
example : feasible m1_0_0_0 = [] := by decide
example : optima m1_0_0_0 = [] := by decide
def m1_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_0_0_1 = [] := by decide
example : optima m1_0_0_1 = [] := by decide
def m1_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_0_0_2 = [] := by decide
example : optima m1_0_0_2 = [] := by decide
def m1_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_0_0_3 = [] := by decide
example : optima m1_0_0_3 = [] := by decide
def m1_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[]⟩
example : feasible m1_0_1_0 = ["h1"] := by decide
example : optima m1_0_1_0 = ["h1"] := by decide
def m1_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_0_1_1 = ["h1"] := by decide
example : optima m1_0_1_1 = [] := by decide
def m1_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_0_1_2 = ["h1"] := by decide
example : optima m1_0_1_2 = ["h1"] := by decide
def m1_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_0_1_3 = ["h1"] := by decide
example : optima m1_0_1_3 = [] := by decide
def m1_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[]⟩
example : feasible m1_0_2_0 = [] := by decide
example : optima m1_0_2_0 = [] := by decide
def m1_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_0_2_1 = [] := by decide
example : optima m1_0_2_1 = [] := by decide
def m1_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_0_2_2 = [] := by decide
example : optima m1_0_2_2 = [] := by decide
def m1_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_0_2_3 = [] := by decide
example : optima m1_0_2_3 = [] := by decide
def m1_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : feasible m1_0_3_0 = ["h1"] := by decide
example : optima m1_0_3_0 = ["h1"] := by decide
def m1_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_0_3_1 = ["h1"] := by decide
example : optima m1_0_3_1 = [] := by decide
def m1_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_0_3_2 = ["h1"] := by decide
example : optima m1_0_3_2 = ["h1"] := by decide
def m1_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_0_3_3 = ["h1"] := by decide
example : optima m1_0_3_3 = [] := by decide
def m1_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[]⟩
example : feasible m1_1_0_0 = ["h0"] := by decide
example : optima m1_1_0_0 = ["h0"] := by decide
def m1_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_1_0_1 = ["h0"] := by decide
example : optima m1_1_0_1 = ["h0"] := by decide
def m1_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_1_0_2 = ["h0"] := by decide
example : optima m1_1_0_2 = [] := by decide
def m1_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_1_0_3 = ["h0"] := by decide
example : optima m1_1_0_3 = [] := by decide
def m1_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : feasible m1_1_1_0 = ["h0","h1"] := by decide
example : optima m1_1_1_0 = ["h0","h1"] := by decide
def m1_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_1_1_1 = ["h0","h1"] := by decide
example : optima m1_1_1_1 = ["h0"] := by decide
def m1_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_1_1_2 = ["h0","h1"] := by decide
example : optima m1_1_1_2 = ["h1"] := by decide
def m1_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_1_1_3 = ["h0","h1"] := by decide
example : optima m1_1_1_3 = [] := by decide
def m1_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[]⟩
example : feasible m1_1_2_0 = ["h0"] := by decide
example : optima m1_1_2_0 = ["h0"] := by decide
def m1_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_1_2_1 = ["h0"] := by decide
example : optima m1_1_2_1 = ["h0"] := by decide
def m1_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_1_2_2 = ["h0"] := by decide
example : optima m1_1_2_2 = [] := by decide
def m1_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_1_2_3 = ["h0"] := by decide
example : optima m1_1_2_3 = [] := by decide
def m1_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : feasible m1_1_3_0 = ["h0","h1"] := by decide
example : optima m1_1_3_0 = ["h0","h1"] := by decide
def m1_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_1_3_1 = ["h0","h1"] := by decide
example : optima m1_1_3_1 = ["h0"] := by decide
def m1_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_1_3_2 = ["h0","h1"] := by decide
example : optima m1_1_3_2 = ["h1"] := by decide
def m1_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_1_3_3 = ["h0","h1"] := by decide
example : optima m1_1_3_3 = [] := by decide
def m1_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[]⟩
example : feasible m1_2_0_0 = [] := by decide
example : optima m1_2_0_0 = [] := by decide
def m1_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_2_0_1 = [] := by decide
example : optima m1_2_0_1 = [] := by decide
def m1_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_2_0_2 = [] := by decide
example : optima m1_2_0_2 = [] := by decide
def m1_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_2_0_3 = [] := by decide
example : optima m1_2_0_3 = [] := by decide
def m1_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : feasible m1_2_1_0 = ["h1"] := by decide
example : optima m1_2_1_0 = ["h1"] := by decide
def m1_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_2_1_1 = ["h1"] := by decide
example : optima m1_2_1_1 = [] := by decide
def m1_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_2_1_2 = ["h1"] := by decide
example : optima m1_2_1_2 = ["h1"] := by decide
def m1_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_2_1_3 = ["h1"] := by decide
example : optima m1_2_1_3 = [] := by decide
def m1_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[]⟩
example : feasible m1_2_2_0 = [] := by decide
example : optima m1_2_2_0 = [] := by decide
def m1_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_2_2_1 = [] := by decide
example : optima m1_2_2_1 = [] := by decide
def m1_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_2_2_2 = [] := by decide
example : optima m1_2_2_2 = [] := by decide
def m1_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_2_2_3 = [] := by decide
example : optima m1_2_2_3 = [] := by decide
def m1_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : feasible m1_2_3_0 = ["h1"] := by decide
example : optima m1_2_3_0 = ["h1"] := by decide
def m1_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_2_3_1 = ["h1"] := by decide
example : optima m1_2_3_1 = [] := by decide
def m1_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_2_3_2 = ["h1"] := by decide
example : optima m1_2_3_2 = ["h1"] := by decide
def m1_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_2_3_3 = ["h1"] := by decide
example : optima m1_2_3_3 = [] := by decide
def m1_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[]⟩
example : feasible m1_3_0_0 = ["h0"] := by decide
example : optima m1_3_0_0 = ["h0"] := by decide
def m1_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_3_0_1 = ["h0"] := by decide
example : optima m1_3_0_1 = ["h0"] := by decide
def m1_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_3_0_2 = ["h0"] := by decide
example : optima m1_3_0_2 = [] := by decide
def m1_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_3_0_3 = ["h0"] := by decide
example : optima m1_3_0_3 = [] := by decide
def m1_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : feasible m1_3_1_0 = ["h0","h1"] := by decide
example : optima m1_3_1_0 = ["h0","h1"] := by decide
def m1_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_3_1_1 = ["h0","h1"] := by decide
example : optima m1_3_1_1 = ["h0"] := by decide
def m1_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_3_1_2 = ["h0","h1"] := by decide
example : optima m1_3_1_2 = ["h1"] := by decide
def m1_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_3_1_3 = ["h0","h1"] := by decide
example : optima m1_3_1_3 = [] := by decide
def m1_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[]⟩
example : feasible m1_3_2_0 = ["h0"] := by decide
example : optima m1_3_2_0 = ["h0"] := by decide
def m1_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_3_2_1 = ["h0"] := by decide
example : optima m1_3_2_1 = ["h0"] := by decide
def m1_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_3_2_2 = ["h0"] := by decide
example : optima m1_3_2_2 = [] := by decide
def m1_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_3_2_3 = ["h0"] := by decide
example : optima m1_3_2_3 = [] := by decide
def m1_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[]⟩
example : feasible m1_3_3_0 = ["h0","h1"] := by decide
example : optima m1_3_3_0 = ["h0","h1"] := by decide
def m1_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1")]⟩
example : feasible m1_3_3_1 = ["h0","h1"] := by decide
example : optima m1_3_3_1 = ["h0"] := by decide
def m1_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h1","h0")]⟩
example : feasible m1_3_3_2 = ["h0","h1"] := by decide
example : optima m1_3_3_2 = ["h1"] := by decide
def m1_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x")],[("h0","h1"),("h1","h0")]⟩
example : feasible m1_3_3_3 = ["h0","h1"] := by decide
example : optima m1_3_3_3 = [] := by decide
def m2_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[]⟩
example : feasible m2_0_0_0 = [] := by decide
example : optima m2_0_0_0 = [] := by decide
def m2_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_0_0_1 = [] := by decide
example : optima m2_0_0_1 = [] := by decide
def m2_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_0_0_2 = [] := by decide
example : optima m2_0_0_2 = [] := by decide
def m2_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_0_0_3 = [] := by decide
example : optima m2_0_0_3 = [] := by decide
def m2_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[]⟩
example : feasible m2_0_1_0 = [] := by decide
example : optima m2_0_1_0 = [] := by decide
def m2_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_0_1_1 = [] := by decide
example : optima m2_0_1_1 = [] := by decide
def m2_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_0_1_2 = [] := by decide
example : optima m2_0_1_2 = [] := by decide
def m2_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_0_1_3 = [] := by decide
example : optima m2_0_1_3 = [] := by decide
def m2_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[]⟩
example : feasible m2_0_2_0 = ["h1"] := by decide
example : optima m2_0_2_0 = ["h1"] := by decide
def m2_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_0_2_1 = ["h1"] := by decide
example : optima m2_0_2_1 = [] := by decide
def m2_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_0_2_2 = ["h1"] := by decide
example : optima m2_0_2_2 = ["h1"] := by decide
def m2_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_0_2_3 = ["h1"] := by decide
example : optima m2_0_2_3 = [] := by decide
def m2_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : feasible m2_0_3_0 = ["h1"] := by decide
example : optima m2_0_3_0 = ["h1"] := by decide
def m2_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_0_3_1 = ["h1"] := by decide
example : optima m2_0_3_1 = [] := by decide
def m2_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_0_3_2 = ["h1"] := by decide
example : optima m2_0_3_2 = ["h1"] := by decide
def m2_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_0_3_3 = ["h1"] := by decide
example : optima m2_0_3_3 = [] := by decide
def m2_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[]⟩
example : feasible m2_1_0_0 = [] := by decide
example : optima m2_1_0_0 = [] := by decide
def m2_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_1_0_1 = [] := by decide
example : optima m2_1_0_1 = [] := by decide
def m2_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_1_0_2 = [] := by decide
example : optima m2_1_0_2 = [] := by decide
def m2_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_1_0_3 = [] := by decide
example : optima m2_1_0_3 = [] := by decide
def m2_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[]⟩
example : feasible m2_1_1_0 = [] := by decide
example : optima m2_1_1_0 = [] := by decide
def m2_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_1_1_1 = [] := by decide
example : optima m2_1_1_1 = [] := by decide
def m2_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_1_1_2 = [] := by decide
example : optima m2_1_1_2 = [] := by decide
def m2_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_1_1_3 = [] := by decide
example : optima m2_1_1_3 = [] := by decide
def m2_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[]⟩
example : feasible m2_1_2_0 = ["h1"] := by decide
example : optima m2_1_2_0 = ["h1"] := by decide
def m2_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_1_2_1 = ["h1"] := by decide
example : optima m2_1_2_1 = [] := by decide
def m2_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_1_2_2 = ["h1"] := by decide
example : optima m2_1_2_2 = ["h1"] := by decide
def m2_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_1_2_3 = ["h1"] := by decide
example : optima m2_1_2_3 = [] := by decide
def m2_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : feasible m2_1_3_0 = ["h1"] := by decide
example : optima m2_1_3_0 = ["h1"] := by decide
def m2_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_1_3_1 = ["h1"] := by decide
example : optima m2_1_3_1 = [] := by decide
def m2_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_1_3_2 = ["h1"] := by decide
example : optima m2_1_3_2 = ["h1"] := by decide
def m2_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_1_3_3 = ["h1"] := by decide
example : optima m2_1_3_3 = [] := by decide
def m2_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[]⟩
example : feasible m2_2_0_0 = ["h0"] := by decide
example : optima m2_2_0_0 = ["h0"] := by decide
def m2_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_2_0_1 = ["h0"] := by decide
example : optima m2_2_0_1 = ["h0"] := by decide
def m2_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_2_0_2 = ["h0"] := by decide
example : optima m2_2_0_2 = [] := by decide
def m2_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_2_0_3 = ["h0"] := by decide
example : optima m2_2_0_3 = [] := by decide
def m2_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[]⟩
example : feasible m2_2_1_0 = ["h0"] := by decide
example : optima m2_2_1_0 = ["h0"] := by decide
def m2_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_2_1_1 = ["h0"] := by decide
example : optima m2_2_1_1 = ["h0"] := by decide
def m2_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_2_1_2 = ["h0"] := by decide
example : optima m2_2_1_2 = [] := by decide
def m2_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_2_1_3 = ["h0"] := by decide
example : optima m2_2_1_3 = [] := by decide
def m2_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[]⟩
example : feasible m2_2_2_0 = ["h0","h1"] := by decide
example : optima m2_2_2_0 = ["h0","h1"] := by decide
def m2_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_2_2_1 = ["h0","h1"] := by decide
example : optima m2_2_2_1 = ["h0"] := by decide
def m2_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_2_2_2 = ["h0","h1"] := by decide
example : optima m2_2_2_2 = ["h1"] := by decide
def m2_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_2_2_3 = ["h0","h1"] := by decide
example : optima m2_2_2_3 = [] := by decide
def m2_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : feasible m2_2_3_0 = ["h0","h1"] := by decide
example : optima m2_2_3_0 = ["h0","h1"] := by decide
def m2_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_2_3_1 = ["h0","h1"] := by decide
example : optima m2_2_3_1 = ["h0"] := by decide
def m2_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_2_3_2 = ["h0","h1"] := by decide
example : optima m2_2_3_2 = ["h1"] := by decide
def m2_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_2_3_3 = ["h0","h1"] := by decide
example : optima m2_2_3_3 = [] := by decide
def m2_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[]⟩
example : feasible m2_3_0_0 = ["h0"] := by decide
example : optima m2_3_0_0 = ["h0"] := by decide
def m2_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_3_0_1 = ["h0"] := by decide
example : optima m2_3_0_1 = ["h0"] := by decide
def m2_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_3_0_2 = ["h0"] := by decide
example : optima m2_3_0_2 = [] := by decide
def m2_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_3_0_3 = ["h0"] := by decide
example : optima m2_3_0_3 = [] := by decide
def m2_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[]⟩
example : feasible m2_3_1_0 = ["h0"] := by decide
example : optima m2_3_1_0 = ["h0"] := by decide
def m2_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_3_1_1 = ["h0"] := by decide
example : optima m2_3_1_1 = ["h0"] := by decide
def m2_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_3_1_2 = ["h0"] := by decide
example : optima m2_3_1_2 = [] := by decide
def m2_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_3_1_3 = ["h0"] := by decide
example : optima m2_3_1_3 = [] := by decide
def m2_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[]⟩
example : feasible m2_3_2_0 = ["h0","h1"] := by decide
example : optima m2_3_2_0 = ["h0","h1"] := by decide
def m2_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_3_2_1 = ["h0","h1"] := by decide
example : optima m2_3_2_1 = ["h0"] := by decide
def m2_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_3_2_2 = ["h0","h1"] := by decide
example : optima m2_3_2_2 = ["h1"] := by decide
def m2_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_3_2_3 = ["h0","h1"] := by decide
example : optima m2_3_2_3 = [] := by decide
def m2_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[]⟩
example : feasible m2_3_3_0 = ["h0","h1"] := by decide
example : optima m2_3_3_0 = ["h0","h1"] := by decide
def m2_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1")]⟩
example : feasible m2_3_3_1 = ["h0","h1"] := by decide
example : optima m2_3_3_1 = ["h0"] := by decide
def m2_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h1","h0")]⟩
example : feasible m2_3_3_2 = ["h0","h1"] := by decide
example : optima m2_3_3_2 = ["h1"] := by decide
def m2_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m2_3_3_3 = ["h0","h1"] := by decide
example : optima m2_3_3_3 = [] := by decide
def m3_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : feasible m3_0_0_0 = [] := by decide
example : optima m3_0_0_0 = [] := by decide
def m3_0_0_1 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_0_0_1 = [] := by decide
example : optima m3_0_0_1 = [] := by decide
def m3_0_0_2 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_0_0_2 = [] := by decide
example : optima m3_0_0_2 = [] := by decide
def m3_0_0_3 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_0_0_3 = [] := by decide
example : optima m3_0_0_3 = [] := by decide
def m3_0_1_0 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_0_1_0 = [] := by decide
example : optima m3_0_1_0 = [] := by decide
def m3_0_1_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_0_1_1 = [] := by decide
example : optima m3_0_1_1 = [] := by decide
def m3_0_1_2 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_0_1_2 = [] := by decide
example : optima m3_0_1_2 = [] := by decide
def m3_0_1_3 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_0_1_3 = [] := by decide
example : optima m3_0_1_3 = [] := by decide
def m3_0_2_0 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_0_2_0 = [] := by decide
example : optima m3_0_2_0 = [] := by decide
def m3_0_2_1 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_0_2_1 = [] := by decide
example : optima m3_0_2_1 = [] := by decide
def m3_0_2_2 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_0_2_2 = [] := by decide
example : optima m3_0_2_2 = [] := by decide
def m3_0_2_3 : Model := ⟨[("h0",[]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_0_2_3 = [] := by decide
example : optima m3_0_2_3 = [] := by decide
def m3_0_3_0 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_0_3_0 = ["h1"] := by decide
example : optima m3_0_3_0 = ["h1"] := by decide
def m3_0_3_1 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_0_3_1 = ["h1"] := by decide
example : optima m3_0_3_1 = [] := by decide
def m3_0_3_2 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_0_3_2 = ["h1"] := by decide
example : optima m3_0_3_2 = ["h1"] := by decide
def m3_0_3_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_0_3_3 = ["h1"] := by decide
example : optima m3_0_3_3 = [] := by decide
def m3_1_0_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : feasible m3_1_0_0 = [] := by decide
example : optima m3_1_0_0 = [] := by decide
def m3_1_0_1 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_1_0_1 = [] := by decide
example : optima m3_1_0_1 = [] := by decide
def m3_1_0_2 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_1_0_2 = [] := by decide
example : optima m3_1_0_2 = [] := by decide
def m3_1_0_3 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_1_0_3 = [] := by decide
example : optima m3_1_0_3 = [] := by decide
def m3_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_1_1_0 = [] := by decide
example : optima m3_1_1_0 = [] := by decide
def m3_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_1_1_1 = [] := by decide
example : optima m3_1_1_1 = [] := by decide
def m3_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_1_1_2 = [] := by decide
example : optima m3_1_1_2 = [] := by decide
def m3_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_1_1_3 = [] := by decide
example : optima m3_1_1_3 = [] := by decide
def m3_1_2_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_1_2_0 = [] := by decide
example : optima m3_1_2_0 = [] := by decide
def m3_1_2_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_1_2_1 = [] := by decide
example : optima m3_1_2_1 = [] := by decide
def m3_1_2_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_1_2_2 = [] := by decide
example : optima m3_1_2_2 = [] := by decide
def m3_1_2_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_1_2_3 = [] := by decide
example : optima m3_1_2_3 = [] := by decide
def m3_1_3_0 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_1_3_0 = ["h1"] := by decide
example : optima m3_1_3_0 = ["h1"] := by decide
def m3_1_3_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_1_3_1 = ["h1"] := by decide
example : optima m3_1_3_1 = [] := by decide
def m3_1_3_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_1_3_2 = ["h1"] := by decide
example : optima m3_1_3_2 = ["h1"] := by decide
def m3_1_3_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_1_3_3 = ["h1"] := by decide
example : optima m3_1_3_3 = [] := by decide
def m3_2_0_0 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : feasible m3_2_0_0 = [] := by decide
example : optima m3_2_0_0 = [] := by decide
def m3_2_0_1 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_2_0_1 = [] := by decide
example : optima m3_2_0_1 = [] := by decide
def m3_2_0_2 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_2_0_2 = [] := by decide
example : optima m3_2_0_2 = [] := by decide
def m3_2_0_3 : Model := ⟨[("h0",[("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_2_0_3 = [] := by decide
example : optima m3_2_0_3 = [] := by decide
def m3_2_1_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_2_1_0 = [] := by decide
example : optima m3_2_1_0 = [] := by decide
def m3_2_1_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_2_1_1 = [] := by decide
example : optima m3_2_1_1 = [] := by decide
def m3_2_1_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_2_1_2 = [] := by decide
example : optima m3_2_1_2 = [] := by decide
def m3_2_1_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_2_1_3 = [] := by decide
example : optima m3_2_1_3 = [] := by decide
def m3_2_2_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_2_2_0 = [] := by decide
example : optima m3_2_2_0 = [] := by decide
def m3_2_2_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_2_2_1 = [] := by decide
example : optima m3_2_2_1 = [] := by decide
def m3_2_2_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_2_2_2 = [] := by decide
example : optima m3_2_2_2 = [] := by decide
def m3_2_2_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_2_2_3 = [] := by decide
example : optima m3_2_2_3 = [] := by decide
def m3_2_3_0 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_2_3_0 = ["h1"] := by decide
example : optima m3_2_3_0 = ["h1"] := by decide
def m3_2_3_1 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_2_3_1 = ["h1"] := by decide
example : optima m3_2_3_1 = [] := by decide
def m3_2_3_2 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_2_3_2 = ["h1"] := by decide
example : optima m3_2_3_2 = ["h1"] := by decide
def m3_2_3_3 : Model := ⟨[("h0",[("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_2_3_3 = ["h1"] := by decide
example : optima m3_2_3_3 = [] := by decide
def m3_3_0_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[]⟩
example : feasible m3_3_0_0 = ["h0"] := by decide
example : optima m3_3_0_0 = ["h0"] := by decide
def m3_3_0_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_3_0_1 = ["h0"] := by decide
example : optima m3_3_0_1 = ["h0"] := by decide
def m3_3_0_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_3_0_2 = ["h0"] := by decide
example : optima m3_3_0_2 = [] := by decide
def m3_3_0_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_3_0_3 = ["h0"] := by decide
example : optima m3_3_0_3 = [] := by decide
def m3_3_1_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_3_1_0 = ["h0"] := by decide
example : optima m3_3_1_0 = ["h0"] := by decide
def m3_3_1_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_3_1_1 = ["h0"] := by decide
example : optima m3_3_1_1 = ["h0"] := by decide
def m3_3_1_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_3_1_2 = ["h0"] := by decide
example : optima m3_3_1_2 = [] := by decide
def m3_3_1_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_3_1_3 = ["h0"] := by decide
example : optima m3_3_1_3 = [] := by decide
def m3_3_2_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_3_2_0 = ["h0"] := by decide
example : optima m3_3_2_0 = ["h0"] := by decide
def m3_3_2_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_3_2_1 = ["h0"] := by decide
example : optima m3_3_2_1 = ["h0"] := by decide
def m3_3_2_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_3_2_2 = ["h0"] := by decide
example : optima m3_3_2_2 = [] := by decide
def m3_3_2_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_3_2_3 = ["h0"] := by decide
example : optima m3_3_2_3 = [] := by decide
def m3_3_3_0 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[]⟩
example : feasible m3_3_3_0 = ["h0","h1"] := by decide
example : optima m3_3_3_0 = ["h0","h1"] := by decide
def m3_3_3_1 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1")]⟩
example : feasible m3_3_3_1 = ["h0","h1"] := by decide
example : optima m3_3_3_1 = ["h0"] := by decide
def m3_3_3_2 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h1","h0")]⟩
example : feasible m3_3_3_2 = ["h0","h1"] := by decide
example : optima m3_3_3_2 = ["h1"] := by decide
def m3_3_3_3 : Model := ⟨[("h0",[("a","x"),("a","y")]),("h1",[("a","x"),("a","y")])],[("a","x"),("a","y")],[("h0","h1"),("h1","h0")]⟩
example : feasible m3_3_3_3 = ["h0","h1"] := by decide
example : optima m3_3_3_3 = [] := by decide
theorem nativeTrace : Trace m1_1_1_1.objective [] (feasible m1_1_1_1) (updateTrace m1_1_1_1) := completeTrace _
theorem nativeRejected : ∃ better, better ∈ feasible m1_1_1_1 ∧
    (better,"h1") ∈ eliminators m1_1_1_1.objective "h1" ∧ better ≠ "h1" :=
  eliminationEvidence _ _ (by decide) (.tail _ (.head _)) (fun held => ((exactOptima _ _).mp held).2 "h0" (.head _))
#print axioms nativeTrace
#print axioms nativeRejected
end SFT.Computation.LearningOptimization
