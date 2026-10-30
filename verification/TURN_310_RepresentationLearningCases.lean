import SFT.Computation.RepresentationLearning
namespace SFT.Computation.RepresentationLearning
def m0_0_0 : Model := ⟨[],[],[],[]⟩
example : valid m0_0_0 = false := by decide
example : complexityLedger m0_0_0 = [] := by decide
def m0_0_1 : Model := ⟨[],[],[("a",["x"])],[]⟩
example : valid m0_0_1 = false := by decide
example : complexityLedger m0_0_1 = [("a",1)] := by decide
def m0_0_2 : Model := ⟨[],[],[("a",["y"])],[]⟩
example : valid m0_0_2 = false := by decide
example : complexityLedger m0_0_2 = [("a",1)] := by decide
def m0_0_3 : Model := ⟨[],[],[("a",["x"]),("a",["y"])],[]⟩
example : valid m0_0_3 = false := by decide
example : complexityLedger m0_0_3 = [("a",1),("a",1)] := by decide
def m0_0_4 : Model := ⟨[],[],[("b",["x"])],[]⟩
example : valid m0_0_4 = false := by decide
example : complexityLedger m0_0_4 = [("b",1)] := by decide
def m0_0_5 : Model := ⟨[],[],[("a",["x"]),("b",["x"])],[]⟩
example : valid m0_0_5 = false := by decide
example : complexityLedger m0_0_5 = [("a",1),("b",1)] := by decide
def m0_0_6 : Model := ⟨[],[],[("a",["y"]),("b",["x"])],[]⟩
example : valid m0_0_6 = false := by decide
example : complexityLedger m0_0_6 = [("a",1),("b",1)] := by decide
def m0_0_7 : Model := ⟨[],[],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m0_0_7 = false := by decide
example : complexityLedger m0_0_7 = [("a",1),("a",1),("b",1)] := by decide
def m0_0_8 : Model := ⟨[],[],[("b",["y"])],[]⟩
example : valid m0_0_8 = false := by decide
example : complexityLedger m0_0_8 = [("b",1)] := by decide
def m0_0_9 : Model := ⟨[],[],[("a",["x"]),("b",["y"])],[]⟩
example : valid m0_0_9 = false := by decide
example : complexityLedger m0_0_9 = [("a",1),("b",1)] := by decide
def m0_0_10 : Model := ⟨[],[],[("a",["y"]),("b",["y"])],[]⟩
example : valid m0_0_10 = false := by decide
example : complexityLedger m0_0_10 = [("a",1),("b",1)] := by decide
def m0_0_11 : Model := ⟨[],[],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m0_0_11 = false := by decide
example : complexityLedger m0_0_11 = [("a",1),("a",1),("b",1)] := by decide
def m0_0_12 : Model := ⟨[],[],[("b",["x"]),("b",["y"])],[]⟩
example : valid m0_0_12 = false := by decide
example : complexityLedger m0_0_12 = [("b",1),("b",1)] := by decide
def m0_0_13 : Model := ⟨[],[],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_0_13 = false := by decide
example : complexityLedger m0_0_13 = [("a",1),("b",1),("b",1)] := by decide
def m0_0_14 : Model := ⟨[],[],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_0_14 = false := by decide
example : complexityLedger m0_0_14 = [("a",1),("b",1),("b",1)] := by decide
def m0_0_15 : Model := ⟨[],[],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_0_15 = false := by decide
example : complexityLedger m0_0_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m0_1_0 : Model := ⟨[],[["x"]],[],[]⟩
example : valid m0_1_0 = false := by decide
example : complexityLedger m0_1_0 = [] := by decide
def m0_1_1 : Model := ⟨[],[["x"]],[("a",["x"])],[]⟩
example : valid m0_1_1 = false := by decide
example : complexityLedger m0_1_1 = [("a",1)] := by decide
def m0_1_2 : Model := ⟨[],[["x"]],[("a",["y"])],[]⟩
example : valid m0_1_2 = false := by decide
example : complexityLedger m0_1_2 = [("a",1)] := by decide
def m0_1_3 : Model := ⟨[],[["x"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m0_1_3 = false := by decide
example : complexityLedger m0_1_3 = [("a",1),("a",1)] := by decide
def m0_1_4 : Model := ⟨[],[["x"]],[("b",["x"])],[]⟩
example : valid m0_1_4 = false := by decide
example : complexityLedger m0_1_4 = [("b",1)] := by decide
def m0_1_5 : Model := ⟨[],[["x"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m0_1_5 = false := by decide
example : complexityLedger m0_1_5 = [("a",1),("b",1)] := by decide
def m0_1_6 : Model := ⟨[],[["x"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m0_1_6 = false := by decide
example : complexityLedger m0_1_6 = [("a",1),("b",1)] := by decide
def m0_1_7 : Model := ⟨[],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m0_1_7 = false := by decide
example : complexityLedger m0_1_7 = [("a",1),("a",1),("b",1)] := by decide
def m0_1_8 : Model := ⟨[],[["x"]],[("b",["y"])],[]⟩
example : valid m0_1_8 = false := by decide
example : complexityLedger m0_1_8 = [("b",1)] := by decide
def m0_1_9 : Model := ⟨[],[["x"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m0_1_9 = false := by decide
example : complexityLedger m0_1_9 = [("a",1),("b",1)] := by decide
def m0_1_10 : Model := ⟨[],[["x"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m0_1_10 = false := by decide
example : complexityLedger m0_1_10 = [("a",1),("b",1)] := by decide
def m0_1_11 : Model := ⟨[],[["x"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m0_1_11 = false := by decide
example : complexityLedger m0_1_11 = [("a",1),("a",1),("b",1)] := by decide
def m0_1_12 : Model := ⟨[],[["x"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m0_1_12 = false := by decide
example : complexityLedger m0_1_12 = [("b",1),("b",1)] := by decide
def m0_1_13 : Model := ⟨[],[["x"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_1_13 = false := by decide
example : complexityLedger m0_1_13 = [("a",1),("b",1),("b",1)] := by decide
def m0_1_14 : Model := ⟨[],[["x"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_1_14 = false := by decide
example : complexityLedger m0_1_14 = [("a",1),("b",1),("b",1)] := by decide
def m0_1_15 : Model := ⟨[],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_1_15 = false := by decide
example : complexityLedger m0_1_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m0_2_0 : Model := ⟨[],[["y"]],[],[]⟩
example : valid m0_2_0 = false := by decide
example : complexityLedger m0_2_0 = [] := by decide
def m0_2_1 : Model := ⟨[],[["y"]],[("a",["x"])],[]⟩
example : valid m0_2_1 = false := by decide
example : complexityLedger m0_2_1 = [("a",1)] := by decide
def m0_2_2 : Model := ⟨[],[["y"]],[("a",["y"])],[]⟩
example : valid m0_2_2 = false := by decide
example : complexityLedger m0_2_2 = [("a",1)] := by decide
def m0_2_3 : Model := ⟨[],[["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m0_2_3 = false := by decide
example : complexityLedger m0_2_3 = [("a",1),("a",1)] := by decide
def m0_2_4 : Model := ⟨[],[["y"]],[("b",["x"])],[]⟩
example : valid m0_2_4 = false := by decide
example : complexityLedger m0_2_4 = [("b",1)] := by decide
def m0_2_5 : Model := ⟨[],[["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m0_2_5 = false := by decide
example : complexityLedger m0_2_5 = [("a",1),("b",1)] := by decide
def m0_2_6 : Model := ⟨[],[["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m0_2_6 = false := by decide
example : complexityLedger m0_2_6 = [("a",1),("b",1)] := by decide
def m0_2_7 : Model := ⟨[],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m0_2_7 = false := by decide
example : complexityLedger m0_2_7 = [("a",1),("a",1),("b",1)] := by decide
def m0_2_8 : Model := ⟨[],[["y"]],[("b",["y"])],[]⟩
example : valid m0_2_8 = false := by decide
example : complexityLedger m0_2_8 = [("b",1)] := by decide
def m0_2_9 : Model := ⟨[],[["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m0_2_9 = false := by decide
example : complexityLedger m0_2_9 = [("a",1),("b",1)] := by decide
def m0_2_10 : Model := ⟨[],[["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m0_2_10 = false := by decide
example : complexityLedger m0_2_10 = [("a",1),("b",1)] := by decide
def m0_2_11 : Model := ⟨[],[["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m0_2_11 = false := by decide
example : complexityLedger m0_2_11 = [("a",1),("a",1),("b",1)] := by decide
def m0_2_12 : Model := ⟨[],[["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m0_2_12 = false := by decide
example : complexityLedger m0_2_12 = [("b",1),("b",1)] := by decide
def m0_2_13 : Model := ⟨[],[["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_2_13 = false := by decide
example : complexityLedger m0_2_13 = [("a",1),("b",1),("b",1)] := by decide
def m0_2_14 : Model := ⟨[],[["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_2_14 = false := by decide
example : complexityLedger m0_2_14 = [("a",1),("b",1),("b",1)] := by decide
def m0_2_15 : Model := ⟨[],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_2_15 = false := by decide
example : complexityLedger m0_2_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m0_3_0 : Model := ⟨[],[["x"],["y"]],[],[]⟩
example : valid m0_3_0 = false := by decide
example : complexityLedger m0_3_0 = [] := by decide
def m0_3_1 : Model := ⟨[],[["x"],["y"]],[("a",["x"])],[]⟩
example : valid m0_3_1 = false := by decide
example : complexityLedger m0_3_1 = [("a",1)] := by decide
def m0_3_2 : Model := ⟨[],[["x"],["y"]],[("a",["y"])],[]⟩
example : valid m0_3_2 = false := by decide
example : complexityLedger m0_3_2 = [("a",1)] := by decide
def m0_3_3 : Model := ⟨[],[["x"],["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m0_3_3 = false := by decide
example : complexityLedger m0_3_3 = [("a",1),("a",1)] := by decide
def m0_3_4 : Model := ⟨[],[["x"],["y"]],[("b",["x"])],[]⟩
example : valid m0_3_4 = false := by decide
example : complexityLedger m0_3_4 = [("b",1)] := by decide
def m0_3_5 : Model := ⟨[],[["x"],["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m0_3_5 = false := by decide
example : complexityLedger m0_3_5 = [("a",1),("b",1)] := by decide
def m0_3_6 : Model := ⟨[],[["x"],["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m0_3_6 = false := by decide
example : complexityLedger m0_3_6 = [("a",1),("b",1)] := by decide
def m0_3_7 : Model := ⟨[],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m0_3_7 = false := by decide
example : complexityLedger m0_3_7 = [("a",1),("a",1),("b",1)] := by decide
def m0_3_8 : Model := ⟨[],[["x"],["y"]],[("b",["y"])],[]⟩
example : valid m0_3_8 = false := by decide
example : complexityLedger m0_3_8 = [("b",1)] := by decide
def m0_3_9 : Model := ⟨[],[["x"],["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m0_3_9 = false := by decide
example : complexityLedger m0_3_9 = [("a",1),("b",1)] := by decide
def m0_3_10 : Model := ⟨[],[["x"],["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m0_3_10 = false := by decide
example : complexityLedger m0_3_10 = [("a",1),("b",1)] := by decide
def m0_3_11 : Model := ⟨[],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m0_3_11 = false := by decide
example : complexityLedger m0_3_11 = [("a",1),("a",1),("b",1)] := by decide
def m0_3_12 : Model := ⟨[],[["x"],["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m0_3_12 = false := by decide
example : complexityLedger m0_3_12 = [("b",1),("b",1)] := by decide
def m0_3_13 : Model := ⟨[],[["x"],["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_3_13 = false := by decide
example : complexityLedger m0_3_13 = [("a",1),("b",1),("b",1)] := by decide
def m0_3_14 : Model := ⟨[],[["x"],["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_3_14 = false := by decide
example : complexityLedger m0_3_14 = [("a",1),("b",1),("b",1)] := by decide
def m0_3_15 : Model := ⟨[],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m0_3_15 = false := by decide
example : complexityLedger m0_3_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m1_0_0 : Model := ⟨["a"],[],[],[]⟩
example : valid m1_0_0 = false := by decide
example : complexityLedger m1_0_0 = [] := by decide
def m1_0_1 : Model := ⟨["a"],[],[("a",["x"])],[]⟩
example : valid m1_0_1 = false := by decide
example : complexityLedger m1_0_1 = [("a",1)] := by decide
def m1_0_2 : Model := ⟨["a"],[],[("a",["y"])],[]⟩
example : valid m1_0_2 = false := by decide
example : complexityLedger m1_0_2 = [("a",1)] := by decide
def m1_0_3 : Model := ⟨["a"],[],[("a",["x"]),("a",["y"])],[]⟩
example : valid m1_0_3 = false := by decide
example : complexityLedger m1_0_3 = [("a",1),("a",1)] := by decide
def m1_0_4 : Model := ⟨["a"],[],[("b",["x"])],[]⟩
example : valid m1_0_4 = false := by decide
example : complexityLedger m1_0_4 = [("b",1)] := by decide
def m1_0_5 : Model := ⟨["a"],[],[("a",["x"]),("b",["x"])],[]⟩
example : valid m1_0_5 = false := by decide
example : complexityLedger m1_0_5 = [("a",1),("b",1)] := by decide
def m1_0_6 : Model := ⟨["a"],[],[("a",["y"]),("b",["x"])],[]⟩
example : valid m1_0_6 = false := by decide
example : complexityLedger m1_0_6 = [("a",1),("b",1)] := by decide
def m1_0_7 : Model := ⟨["a"],[],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m1_0_7 = false := by decide
example : complexityLedger m1_0_7 = [("a",1),("a",1),("b",1)] := by decide
def m1_0_8 : Model := ⟨["a"],[],[("b",["y"])],[]⟩
example : valid m1_0_8 = false := by decide
example : complexityLedger m1_0_8 = [("b",1)] := by decide
def m1_0_9 : Model := ⟨["a"],[],[("a",["x"]),("b",["y"])],[]⟩
example : valid m1_0_9 = false := by decide
example : complexityLedger m1_0_9 = [("a",1),("b",1)] := by decide
def m1_0_10 : Model := ⟨["a"],[],[("a",["y"]),("b",["y"])],[]⟩
example : valid m1_0_10 = false := by decide
example : complexityLedger m1_0_10 = [("a",1),("b",1)] := by decide
def m1_0_11 : Model := ⟨["a"],[],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m1_0_11 = false := by decide
example : complexityLedger m1_0_11 = [("a",1),("a",1),("b",1)] := by decide
def m1_0_12 : Model := ⟨["a"],[],[("b",["x"]),("b",["y"])],[]⟩
example : valid m1_0_12 = false := by decide
example : complexityLedger m1_0_12 = [("b",1),("b",1)] := by decide
def m1_0_13 : Model := ⟨["a"],[],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_0_13 = false := by decide
example : complexityLedger m1_0_13 = [("a",1),("b",1),("b",1)] := by decide
def m1_0_14 : Model := ⟨["a"],[],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_0_14 = false := by decide
example : complexityLedger m1_0_14 = [("a",1),("b",1),("b",1)] := by decide
def m1_0_15 : Model := ⟨["a"],[],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_0_15 = false := by decide
example : complexityLedger m1_0_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m1_1_0 : Model := ⟨["a"],[["x"]],[],[]⟩
example : valid m1_1_0 = false := by decide
example : complexityLedger m1_1_0 = [] := by decide
def m1_1_1 : Model := ⟨["a"],[["x"]],[("a",["x"])],[]⟩
example : valid m1_1_1 = true := by decide
example : complexityLedger m1_1_1 = [("a",1)] := by decide
def m1_1_2 : Model := ⟨["a"],[["x"]],[("a",["y"])],[]⟩
example : valid m1_1_2 = false := by decide
example : complexityLedger m1_1_2 = [("a",1)] := by decide
def m1_1_3 : Model := ⟨["a"],[["x"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m1_1_3 = false := by decide
example : complexityLedger m1_1_3 = [("a",1),("a",1)] := by decide
def m1_1_4 : Model := ⟨["a"],[["x"]],[("b",["x"])],[]⟩
example : valid m1_1_4 = false := by decide
example : complexityLedger m1_1_4 = [("b",1)] := by decide
def m1_1_5 : Model := ⟨["a"],[["x"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m1_1_5 = false := by decide
example : complexityLedger m1_1_5 = [("a",1),("b",1)] := by decide
def m1_1_6 : Model := ⟨["a"],[["x"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m1_1_6 = false := by decide
example : complexityLedger m1_1_6 = [("a",1),("b",1)] := by decide
def m1_1_7 : Model := ⟨["a"],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m1_1_7 = false := by decide
example : complexityLedger m1_1_7 = [("a",1),("a",1),("b",1)] := by decide
def m1_1_8 : Model := ⟨["a"],[["x"]],[("b",["y"])],[]⟩
example : valid m1_1_8 = false := by decide
example : complexityLedger m1_1_8 = [("b",1)] := by decide
def m1_1_9 : Model := ⟨["a"],[["x"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m1_1_9 = false := by decide
example : complexityLedger m1_1_9 = [("a",1),("b",1)] := by decide
def m1_1_10 : Model := ⟨["a"],[["x"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m1_1_10 = false := by decide
example : complexityLedger m1_1_10 = [("a",1),("b",1)] := by decide
def m1_1_11 : Model := ⟨["a"],[["x"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m1_1_11 = false := by decide
example : complexityLedger m1_1_11 = [("a",1),("a",1),("b",1)] := by decide
def m1_1_12 : Model := ⟨["a"],[["x"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m1_1_12 = false := by decide
example : complexityLedger m1_1_12 = [("b",1),("b",1)] := by decide
def m1_1_13 : Model := ⟨["a"],[["x"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_1_13 = false := by decide
example : complexityLedger m1_1_13 = [("a",1),("b",1),("b",1)] := by decide
def m1_1_14 : Model := ⟨["a"],[["x"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_1_14 = false := by decide
example : complexityLedger m1_1_14 = [("a",1),("b",1),("b",1)] := by decide
def m1_1_15 : Model := ⟨["a"],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_1_15 = false := by decide
example : complexityLedger m1_1_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m1_2_0 : Model := ⟨["a"],[["y"]],[],[]⟩
example : valid m1_2_0 = false := by decide
example : complexityLedger m1_2_0 = [] := by decide
def m1_2_1 : Model := ⟨["a"],[["y"]],[("a",["x"])],[]⟩
example : valid m1_2_1 = false := by decide
example : complexityLedger m1_2_1 = [("a",1)] := by decide
def m1_2_2 : Model := ⟨["a"],[["y"]],[("a",["y"])],[]⟩
example : valid m1_2_2 = true := by decide
example : complexityLedger m1_2_2 = [("a",1)] := by decide
def m1_2_3 : Model := ⟨["a"],[["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m1_2_3 = false := by decide
example : complexityLedger m1_2_3 = [("a",1),("a",1)] := by decide
def m1_2_4 : Model := ⟨["a"],[["y"]],[("b",["x"])],[]⟩
example : valid m1_2_4 = false := by decide
example : complexityLedger m1_2_4 = [("b",1)] := by decide
def m1_2_5 : Model := ⟨["a"],[["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m1_2_5 = false := by decide
example : complexityLedger m1_2_5 = [("a",1),("b",1)] := by decide
def m1_2_6 : Model := ⟨["a"],[["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m1_2_6 = false := by decide
example : complexityLedger m1_2_6 = [("a",1),("b",1)] := by decide
def m1_2_7 : Model := ⟨["a"],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m1_2_7 = false := by decide
example : complexityLedger m1_2_7 = [("a",1),("a",1),("b",1)] := by decide
def m1_2_8 : Model := ⟨["a"],[["y"]],[("b",["y"])],[]⟩
example : valid m1_2_8 = false := by decide
example : complexityLedger m1_2_8 = [("b",1)] := by decide
def m1_2_9 : Model := ⟨["a"],[["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m1_2_9 = false := by decide
example : complexityLedger m1_2_9 = [("a",1),("b",1)] := by decide
def m1_2_10 : Model := ⟨["a"],[["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m1_2_10 = false := by decide
example : complexityLedger m1_2_10 = [("a",1),("b",1)] := by decide
def m1_2_11 : Model := ⟨["a"],[["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m1_2_11 = false := by decide
example : complexityLedger m1_2_11 = [("a",1),("a",1),("b",1)] := by decide
def m1_2_12 : Model := ⟨["a"],[["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m1_2_12 = false := by decide
example : complexityLedger m1_2_12 = [("b",1),("b",1)] := by decide
def m1_2_13 : Model := ⟨["a"],[["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_2_13 = false := by decide
example : complexityLedger m1_2_13 = [("a",1),("b",1),("b",1)] := by decide
def m1_2_14 : Model := ⟨["a"],[["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_2_14 = false := by decide
example : complexityLedger m1_2_14 = [("a",1),("b",1),("b",1)] := by decide
def m1_2_15 : Model := ⟨["a"],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_2_15 = false := by decide
example : complexityLedger m1_2_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m1_3_0 : Model := ⟨["a"],[["x"],["y"]],[],[]⟩
example : valid m1_3_0 = false := by decide
example : complexityLedger m1_3_0 = [] := by decide
def m1_3_1 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"])],[]⟩
example : valid m1_3_1 = true := by decide
example : complexityLedger m1_3_1 = [("a",1)] := by decide
def m1_3_2 : Model := ⟨["a"],[["x"],["y"]],[("a",["y"])],[]⟩
example : valid m1_3_2 = true := by decide
example : complexityLedger m1_3_2 = [("a",1)] := by decide
def m1_3_3 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m1_3_3 = false := by decide
example : complexityLedger m1_3_3 = [("a",1),("a",1)] := by decide
def m1_3_4 : Model := ⟨["a"],[["x"],["y"]],[("b",["x"])],[]⟩
example : valid m1_3_4 = false := by decide
example : complexityLedger m1_3_4 = [("b",1)] := by decide
def m1_3_5 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m1_3_5 = false := by decide
example : complexityLedger m1_3_5 = [("a",1),("b",1)] := by decide
def m1_3_6 : Model := ⟨["a"],[["x"],["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m1_3_6 = false := by decide
example : complexityLedger m1_3_6 = [("a",1),("b",1)] := by decide
def m1_3_7 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m1_3_7 = false := by decide
example : complexityLedger m1_3_7 = [("a",1),("a",1),("b",1)] := by decide
def m1_3_8 : Model := ⟨["a"],[["x"],["y"]],[("b",["y"])],[]⟩
example : valid m1_3_8 = false := by decide
example : complexityLedger m1_3_8 = [("b",1)] := by decide
def m1_3_9 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m1_3_9 = false := by decide
example : complexityLedger m1_3_9 = [("a",1),("b",1)] := by decide
def m1_3_10 : Model := ⟨["a"],[["x"],["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m1_3_10 = false := by decide
example : complexityLedger m1_3_10 = [("a",1),("b",1)] := by decide
def m1_3_11 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m1_3_11 = false := by decide
example : complexityLedger m1_3_11 = [("a",1),("a",1),("b",1)] := by decide
def m1_3_12 : Model := ⟨["a"],[["x"],["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m1_3_12 = false := by decide
example : complexityLedger m1_3_12 = [("b",1),("b",1)] := by decide
def m1_3_13 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_3_13 = false := by decide
example : complexityLedger m1_3_13 = [("a",1),("b",1),("b",1)] := by decide
def m1_3_14 : Model := ⟨["a"],[["x"],["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_3_14 = false := by decide
example : complexityLedger m1_3_14 = [("a",1),("b",1),("b",1)] := by decide
def m1_3_15 : Model := ⟨["a"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m1_3_15 = false := by decide
example : complexityLedger m1_3_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m2_0_0 : Model := ⟨["b"],[],[],[]⟩
example : valid m2_0_0 = false := by decide
example : complexityLedger m2_0_0 = [] := by decide
def m2_0_1 : Model := ⟨["b"],[],[("a",["x"])],[]⟩
example : valid m2_0_1 = false := by decide
example : complexityLedger m2_0_1 = [("a",1)] := by decide
def m2_0_2 : Model := ⟨["b"],[],[("a",["y"])],[]⟩
example : valid m2_0_2 = false := by decide
example : complexityLedger m2_0_2 = [("a",1)] := by decide
def m2_0_3 : Model := ⟨["b"],[],[("a",["x"]),("a",["y"])],[]⟩
example : valid m2_0_3 = false := by decide
example : complexityLedger m2_0_3 = [("a",1),("a",1)] := by decide
def m2_0_4 : Model := ⟨["b"],[],[("b",["x"])],[]⟩
example : valid m2_0_4 = false := by decide
example : complexityLedger m2_0_4 = [("b",1)] := by decide
def m2_0_5 : Model := ⟨["b"],[],[("a",["x"]),("b",["x"])],[]⟩
example : valid m2_0_5 = false := by decide
example : complexityLedger m2_0_5 = [("a",1),("b",1)] := by decide
def m2_0_6 : Model := ⟨["b"],[],[("a",["y"]),("b",["x"])],[]⟩
example : valid m2_0_6 = false := by decide
example : complexityLedger m2_0_6 = [("a",1),("b",1)] := by decide
def m2_0_7 : Model := ⟨["b"],[],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m2_0_7 = false := by decide
example : complexityLedger m2_0_7 = [("a",1),("a",1),("b",1)] := by decide
def m2_0_8 : Model := ⟨["b"],[],[("b",["y"])],[]⟩
example : valid m2_0_8 = false := by decide
example : complexityLedger m2_0_8 = [("b",1)] := by decide
def m2_0_9 : Model := ⟨["b"],[],[("a",["x"]),("b",["y"])],[]⟩
example : valid m2_0_9 = false := by decide
example : complexityLedger m2_0_9 = [("a",1),("b",1)] := by decide
def m2_0_10 : Model := ⟨["b"],[],[("a",["y"]),("b",["y"])],[]⟩
example : valid m2_0_10 = false := by decide
example : complexityLedger m2_0_10 = [("a",1),("b",1)] := by decide
def m2_0_11 : Model := ⟨["b"],[],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m2_0_11 = false := by decide
example : complexityLedger m2_0_11 = [("a",1),("a",1),("b",1)] := by decide
def m2_0_12 : Model := ⟨["b"],[],[("b",["x"]),("b",["y"])],[]⟩
example : valid m2_0_12 = false := by decide
example : complexityLedger m2_0_12 = [("b",1),("b",1)] := by decide
def m2_0_13 : Model := ⟨["b"],[],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_0_13 = false := by decide
example : complexityLedger m2_0_13 = [("a",1),("b",1),("b",1)] := by decide
def m2_0_14 : Model := ⟨["b"],[],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_0_14 = false := by decide
example : complexityLedger m2_0_14 = [("a",1),("b",1),("b",1)] := by decide
def m2_0_15 : Model := ⟨["b"],[],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_0_15 = false := by decide
example : complexityLedger m2_0_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m2_1_0 : Model := ⟨["b"],[["x"]],[],[]⟩
example : valid m2_1_0 = false := by decide
example : complexityLedger m2_1_0 = [] := by decide
def m2_1_1 : Model := ⟨["b"],[["x"]],[("a",["x"])],[]⟩
example : valid m2_1_1 = false := by decide
example : complexityLedger m2_1_1 = [("a",1)] := by decide
def m2_1_2 : Model := ⟨["b"],[["x"]],[("a",["y"])],[]⟩
example : valid m2_1_2 = false := by decide
example : complexityLedger m2_1_2 = [("a",1)] := by decide
def m2_1_3 : Model := ⟨["b"],[["x"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m2_1_3 = false := by decide
example : complexityLedger m2_1_3 = [("a",1),("a",1)] := by decide
def m2_1_4 : Model := ⟨["b"],[["x"]],[("b",["x"])],[]⟩
example : valid m2_1_4 = true := by decide
example : complexityLedger m2_1_4 = [("b",1)] := by decide
def m2_1_5 : Model := ⟨["b"],[["x"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m2_1_5 = false := by decide
example : complexityLedger m2_1_5 = [("a",1),("b",1)] := by decide
def m2_1_6 : Model := ⟨["b"],[["x"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m2_1_6 = false := by decide
example : complexityLedger m2_1_6 = [("a",1),("b",1)] := by decide
def m2_1_7 : Model := ⟨["b"],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m2_1_7 = false := by decide
example : complexityLedger m2_1_7 = [("a",1),("a",1),("b",1)] := by decide
def m2_1_8 : Model := ⟨["b"],[["x"]],[("b",["y"])],[]⟩
example : valid m2_1_8 = false := by decide
example : complexityLedger m2_1_8 = [("b",1)] := by decide
def m2_1_9 : Model := ⟨["b"],[["x"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m2_1_9 = false := by decide
example : complexityLedger m2_1_9 = [("a",1),("b",1)] := by decide
def m2_1_10 : Model := ⟨["b"],[["x"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m2_1_10 = false := by decide
example : complexityLedger m2_1_10 = [("a",1),("b",1)] := by decide
def m2_1_11 : Model := ⟨["b"],[["x"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m2_1_11 = false := by decide
example : complexityLedger m2_1_11 = [("a",1),("a",1),("b",1)] := by decide
def m2_1_12 : Model := ⟨["b"],[["x"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m2_1_12 = false := by decide
example : complexityLedger m2_1_12 = [("b",1),("b",1)] := by decide
def m2_1_13 : Model := ⟨["b"],[["x"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_1_13 = false := by decide
example : complexityLedger m2_1_13 = [("a",1),("b",1),("b",1)] := by decide
def m2_1_14 : Model := ⟨["b"],[["x"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_1_14 = false := by decide
example : complexityLedger m2_1_14 = [("a",1),("b",1),("b",1)] := by decide
def m2_1_15 : Model := ⟨["b"],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_1_15 = false := by decide
example : complexityLedger m2_1_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m2_2_0 : Model := ⟨["b"],[["y"]],[],[]⟩
example : valid m2_2_0 = false := by decide
example : complexityLedger m2_2_0 = [] := by decide
def m2_2_1 : Model := ⟨["b"],[["y"]],[("a",["x"])],[]⟩
example : valid m2_2_1 = false := by decide
example : complexityLedger m2_2_1 = [("a",1)] := by decide
def m2_2_2 : Model := ⟨["b"],[["y"]],[("a",["y"])],[]⟩
example : valid m2_2_2 = false := by decide
example : complexityLedger m2_2_2 = [("a",1)] := by decide
def m2_2_3 : Model := ⟨["b"],[["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m2_2_3 = false := by decide
example : complexityLedger m2_2_3 = [("a",1),("a",1)] := by decide
def m2_2_4 : Model := ⟨["b"],[["y"]],[("b",["x"])],[]⟩
example : valid m2_2_4 = false := by decide
example : complexityLedger m2_2_4 = [("b",1)] := by decide
def m2_2_5 : Model := ⟨["b"],[["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m2_2_5 = false := by decide
example : complexityLedger m2_2_5 = [("a",1),("b",1)] := by decide
def m2_2_6 : Model := ⟨["b"],[["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m2_2_6 = false := by decide
example : complexityLedger m2_2_6 = [("a",1),("b",1)] := by decide
def m2_2_7 : Model := ⟨["b"],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m2_2_7 = false := by decide
example : complexityLedger m2_2_7 = [("a",1),("a",1),("b",1)] := by decide
def m2_2_8 : Model := ⟨["b"],[["y"]],[("b",["y"])],[]⟩
example : valid m2_2_8 = true := by decide
example : complexityLedger m2_2_8 = [("b",1)] := by decide
def m2_2_9 : Model := ⟨["b"],[["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m2_2_9 = false := by decide
example : complexityLedger m2_2_9 = [("a",1),("b",1)] := by decide
def m2_2_10 : Model := ⟨["b"],[["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m2_2_10 = false := by decide
example : complexityLedger m2_2_10 = [("a",1),("b",1)] := by decide
def m2_2_11 : Model := ⟨["b"],[["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m2_2_11 = false := by decide
example : complexityLedger m2_2_11 = [("a",1),("a",1),("b",1)] := by decide
def m2_2_12 : Model := ⟨["b"],[["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m2_2_12 = false := by decide
example : complexityLedger m2_2_12 = [("b",1),("b",1)] := by decide
def m2_2_13 : Model := ⟨["b"],[["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_2_13 = false := by decide
example : complexityLedger m2_2_13 = [("a",1),("b",1),("b",1)] := by decide
def m2_2_14 : Model := ⟨["b"],[["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_2_14 = false := by decide
example : complexityLedger m2_2_14 = [("a",1),("b",1),("b",1)] := by decide
def m2_2_15 : Model := ⟨["b"],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_2_15 = false := by decide
example : complexityLedger m2_2_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m2_3_0 : Model := ⟨["b"],[["x"],["y"]],[],[]⟩
example : valid m2_3_0 = false := by decide
example : complexityLedger m2_3_0 = [] := by decide
def m2_3_1 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"])],[]⟩
example : valid m2_3_1 = false := by decide
example : complexityLedger m2_3_1 = [("a",1)] := by decide
def m2_3_2 : Model := ⟨["b"],[["x"],["y"]],[("a",["y"])],[]⟩
example : valid m2_3_2 = false := by decide
example : complexityLedger m2_3_2 = [("a",1)] := by decide
def m2_3_3 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m2_3_3 = false := by decide
example : complexityLedger m2_3_3 = [("a",1),("a",1)] := by decide
def m2_3_4 : Model := ⟨["b"],[["x"],["y"]],[("b",["x"])],[]⟩
example : valid m2_3_4 = true := by decide
example : complexityLedger m2_3_4 = [("b",1)] := by decide
def m2_3_5 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m2_3_5 = false := by decide
example : complexityLedger m2_3_5 = [("a",1),("b",1)] := by decide
def m2_3_6 : Model := ⟨["b"],[["x"],["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m2_3_6 = false := by decide
example : complexityLedger m2_3_6 = [("a",1),("b",1)] := by decide
def m2_3_7 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m2_3_7 = false := by decide
example : complexityLedger m2_3_7 = [("a",1),("a",1),("b",1)] := by decide
def m2_3_8 : Model := ⟨["b"],[["x"],["y"]],[("b",["y"])],[]⟩
example : valid m2_3_8 = true := by decide
example : complexityLedger m2_3_8 = [("b",1)] := by decide
def m2_3_9 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m2_3_9 = false := by decide
example : complexityLedger m2_3_9 = [("a",1),("b",1)] := by decide
def m2_3_10 : Model := ⟨["b"],[["x"],["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m2_3_10 = false := by decide
example : complexityLedger m2_3_10 = [("a",1),("b",1)] := by decide
def m2_3_11 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m2_3_11 = false := by decide
example : complexityLedger m2_3_11 = [("a",1),("a",1),("b",1)] := by decide
def m2_3_12 : Model := ⟨["b"],[["x"],["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m2_3_12 = false := by decide
example : complexityLedger m2_3_12 = [("b",1),("b",1)] := by decide
def m2_3_13 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_3_13 = false := by decide
example : complexityLedger m2_3_13 = [("a",1),("b",1),("b",1)] := by decide
def m2_3_14 : Model := ⟨["b"],[["x"],["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_3_14 = false := by decide
example : complexityLedger m2_3_14 = [("a",1),("b",1),("b",1)] := by decide
def m2_3_15 : Model := ⟨["b"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m2_3_15 = false := by decide
example : complexityLedger m2_3_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m3_0_0 : Model := ⟨["a","b"],[],[],[]⟩
example : valid m3_0_0 = false := by decide
example : complexityLedger m3_0_0 = [] := by decide
def m3_0_1 : Model := ⟨["a","b"],[],[("a",["x"])],[]⟩
example : valid m3_0_1 = false := by decide
example : complexityLedger m3_0_1 = [("a",1)] := by decide
def m3_0_2 : Model := ⟨["a","b"],[],[("a",["y"])],[]⟩
example : valid m3_0_2 = false := by decide
example : complexityLedger m3_0_2 = [("a",1)] := by decide
def m3_0_3 : Model := ⟨["a","b"],[],[("a",["x"]),("a",["y"])],[]⟩
example : valid m3_0_3 = false := by decide
example : complexityLedger m3_0_3 = [("a",1),("a",1)] := by decide
def m3_0_4 : Model := ⟨["a","b"],[],[("b",["x"])],[]⟩
example : valid m3_0_4 = false := by decide
example : complexityLedger m3_0_4 = [("b",1)] := by decide
def m3_0_5 : Model := ⟨["a","b"],[],[("a",["x"]),("b",["x"])],[]⟩
example : valid m3_0_5 = false := by decide
example : complexityLedger m3_0_5 = [("a",1),("b",1)] := by decide
def m3_0_6 : Model := ⟨["a","b"],[],[("a",["y"]),("b",["x"])],[]⟩
example : valid m3_0_6 = false := by decide
example : complexityLedger m3_0_6 = [("a",1),("b",1)] := by decide
def m3_0_7 : Model := ⟨["a","b"],[],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m3_0_7 = false := by decide
example : complexityLedger m3_0_7 = [("a",1),("a",1),("b",1)] := by decide
def m3_0_8 : Model := ⟨["a","b"],[],[("b",["y"])],[]⟩
example : valid m3_0_8 = false := by decide
example : complexityLedger m3_0_8 = [("b",1)] := by decide
def m3_0_9 : Model := ⟨["a","b"],[],[("a",["x"]),("b",["y"])],[]⟩
example : valid m3_0_9 = false := by decide
example : complexityLedger m3_0_9 = [("a",1),("b",1)] := by decide
def m3_0_10 : Model := ⟨["a","b"],[],[("a",["y"]),("b",["y"])],[]⟩
example : valid m3_0_10 = false := by decide
example : complexityLedger m3_0_10 = [("a",1),("b",1)] := by decide
def m3_0_11 : Model := ⟨["a","b"],[],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m3_0_11 = false := by decide
example : complexityLedger m3_0_11 = [("a",1),("a",1),("b",1)] := by decide
def m3_0_12 : Model := ⟨["a","b"],[],[("b",["x"]),("b",["y"])],[]⟩
example : valid m3_0_12 = false := by decide
example : complexityLedger m3_0_12 = [("b",1),("b",1)] := by decide
def m3_0_13 : Model := ⟨["a","b"],[],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_0_13 = false := by decide
example : complexityLedger m3_0_13 = [("a",1),("b",1),("b",1)] := by decide
def m3_0_14 : Model := ⟨["a","b"],[],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_0_14 = false := by decide
example : complexityLedger m3_0_14 = [("a",1),("b",1),("b",1)] := by decide
def m3_0_15 : Model := ⟨["a","b"],[],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_0_15 = false := by decide
example : complexityLedger m3_0_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m3_1_0 : Model := ⟨["a","b"],[["x"]],[],[]⟩
example : valid m3_1_0 = false := by decide
example : complexityLedger m3_1_0 = [] := by decide
def m3_1_1 : Model := ⟨["a","b"],[["x"]],[("a",["x"])],[]⟩
example : valid m3_1_1 = false := by decide
example : complexityLedger m3_1_1 = [("a",1)] := by decide
def m3_1_2 : Model := ⟨["a","b"],[["x"]],[("a",["y"])],[]⟩
example : valid m3_1_2 = false := by decide
example : complexityLedger m3_1_2 = [("a",1)] := by decide
def m3_1_3 : Model := ⟨["a","b"],[["x"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m3_1_3 = false := by decide
example : complexityLedger m3_1_3 = [("a",1),("a",1)] := by decide
def m3_1_4 : Model := ⟨["a","b"],[["x"]],[("b",["x"])],[]⟩
example : valid m3_1_4 = false := by decide
example : complexityLedger m3_1_4 = [("b",1)] := by decide
def m3_1_5 : Model := ⟨["a","b"],[["x"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m3_1_5 = true := by decide
example : complexityLedger m3_1_5 = [("a",1),("b",1)] := by decide
def m3_1_6 : Model := ⟨["a","b"],[["x"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m3_1_6 = false := by decide
example : complexityLedger m3_1_6 = [("a",1),("b",1)] := by decide
def m3_1_7 : Model := ⟨["a","b"],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m3_1_7 = false := by decide
example : complexityLedger m3_1_7 = [("a",1),("a",1),("b",1)] := by decide
def m3_1_8 : Model := ⟨["a","b"],[["x"]],[("b",["y"])],[]⟩
example : valid m3_1_8 = false := by decide
example : complexityLedger m3_1_8 = [("b",1)] := by decide
def m3_1_9 : Model := ⟨["a","b"],[["x"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m3_1_9 = false := by decide
example : complexityLedger m3_1_9 = [("a",1),("b",1)] := by decide
def m3_1_10 : Model := ⟨["a","b"],[["x"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m3_1_10 = false := by decide
example : complexityLedger m3_1_10 = [("a",1),("b",1)] := by decide
def m3_1_11 : Model := ⟨["a","b"],[["x"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m3_1_11 = false := by decide
example : complexityLedger m3_1_11 = [("a",1),("a",1),("b",1)] := by decide
def m3_1_12 : Model := ⟨["a","b"],[["x"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m3_1_12 = false := by decide
example : complexityLedger m3_1_12 = [("b",1),("b",1)] := by decide
def m3_1_13 : Model := ⟨["a","b"],[["x"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_1_13 = false := by decide
example : complexityLedger m3_1_13 = [("a",1),("b",1),("b",1)] := by decide
def m3_1_14 : Model := ⟨["a","b"],[["x"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_1_14 = false := by decide
example : complexityLedger m3_1_14 = [("a",1),("b",1),("b",1)] := by decide
def m3_1_15 : Model := ⟨["a","b"],[["x"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_1_15 = false := by decide
example : complexityLedger m3_1_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m3_2_0 : Model := ⟨["a","b"],[["y"]],[],[]⟩
example : valid m3_2_0 = false := by decide
example : complexityLedger m3_2_0 = [] := by decide
def m3_2_1 : Model := ⟨["a","b"],[["y"]],[("a",["x"])],[]⟩
example : valid m3_2_1 = false := by decide
example : complexityLedger m3_2_1 = [("a",1)] := by decide
def m3_2_2 : Model := ⟨["a","b"],[["y"]],[("a",["y"])],[]⟩
example : valid m3_2_2 = false := by decide
example : complexityLedger m3_2_2 = [("a",1)] := by decide
def m3_2_3 : Model := ⟨["a","b"],[["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m3_2_3 = false := by decide
example : complexityLedger m3_2_3 = [("a",1),("a",1)] := by decide
def m3_2_4 : Model := ⟨["a","b"],[["y"]],[("b",["x"])],[]⟩
example : valid m3_2_4 = false := by decide
example : complexityLedger m3_2_4 = [("b",1)] := by decide
def m3_2_5 : Model := ⟨["a","b"],[["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m3_2_5 = false := by decide
example : complexityLedger m3_2_5 = [("a",1),("b",1)] := by decide
def m3_2_6 : Model := ⟨["a","b"],[["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m3_2_6 = false := by decide
example : complexityLedger m3_2_6 = [("a",1),("b",1)] := by decide
def m3_2_7 : Model := ⟨["a","b"],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m3_2_7 = false := by decide
example : complexityLedger m3_2_7 = [("a",1),("a",1),("b",1)] := by decide
def m3_2_8 : Model := ⟨["a","b"],[["y"]],[("b",["y"])],[]⟩
example : valid m3_2_8 = false := by decide
example : complexityLedger m3_2_8 = [("b",1)] := by decide
def m3_2_9 : Model := ⟨["a","b"],[["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m3_2_9 = false := by decide
example : complexityLedger m3_2_9 = [("a",1),("b",1)] := by decide
def m3_2_10 : Model := ⟨["a","b"],[["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m3_2_10 = true := by decide
example : complexityLedger m3_2_10 = [("a",1),("b",1)] := by decide
def m3_2_11 : Model := ⟨["a","b"],[["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m3_2_11 = false := by decide
example : complexityLedger m3_2_11 = [("a",1),("a",1),("b",1)] := by decide
def m3_2_12 : Model := ⟨["a","b"],[["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m3_2_12 = false := by decide
example : complexityLedger m3_2_12 = [("b",1),("b",1)] := by decide
def m3_2_13 : Model := ⟨["a","b"],[["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_2_13 = false := by decide
example : complexityLedger m3_2_13 = [("a",1),("b",1),("b",1)] := by decide
def m3_2_14 : Model := ⟨["a","b"],[["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_2_14 = false := by decide
example : complexityLedger m3_2_14 = [("a",1),("b",1),("b",1)] := by decide
def m3_2_15 : Model := ⟨["a","b"],[["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_2_15 = false := by decide
example : complexityLedger m3_2_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def m3_3_0 : Model := ⟨["a","b"],[["x"],["y"]],[],[]⟩
example : valid m3_3_0 = false := by decide
example : complexityLedger m3_3_0 = [] := by decide
def m3_3_1 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"])],[]⟩
example : valid m3_3_1 = false := by decide
example : complexityLedger m3_3_1 = [("a",1)] := by decide
def m3_3_2 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["y"])],[]⟩
example : valid m3_3_2 = false := by decide
example : complexityLedger m3_3_2 = [("a",1)] := by decide
def m3_3_3 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("a",["y"])],[]⟩
example : valid m3_3_3 = false := by decide
example : complexityLedger m3_3_3 = [("a",1),("a",1)] := by decide
def m3_3_4 : Model := ⟨["a","b"],[["x"],["y"]],[("b",["x"])],[]⟩
example : valid m3_3_4 = false := by decide
example : complexityLedger m3_3_4 = [("b",1)] := by decide
def m3_3_5 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("b",["x"])],[]⟩
example : valid m3_3_5 = true := by decide
example : complexityLedger m3_3_5 = [("a",1),("b",1)] := by decide
def m3_3_6 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["y"]),("b",["x"])],[]⟩
example : valid m3_3_6 = true := by decide
example : complexityLedger m3_3_6 = [("a",1),("b",1)] := by decide
def m3_3_7 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"])],[]⟩
example : valid m3_3_7 = false := by decide
example : complexityLedger m3_3_7 = [("a",1),("a",1),("b",1)] := by decide
def m3_3_8 : Model := ⟨["a","b"],[["x"],["y"]],[("b",["y"])],[]⟩
example : valid m3_3_8 = false := by decide
example : complexityLedger m3_3_8 = [("b",1)] := by decide
def m3_3_9 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("b",["y"])],[]⟩
example : valid m3_3_9 = true := by decide
example : complexityLedger m3_3_9 = [("a",1),("b",1)] := by decide
def m3_3_10 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["y"]),("b",["y"])],[]⟩
example : valid m3_3_10 = true := by decide
example : complexityLedger m3_3_10 = [("a",1),("b",1)] := by decide
def m3_3_11 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["y"])],[]⟩
example : valid m3_3_11 = false := by decide
example : complexityLedger m3_3_11 = [("a",1),("a",1),("b",1)] := by decide
def m3_3_12 : Model := ⟨["a","b"],[["x"],["y"]],[("b",["x"]),("b",["y"])],[]⟩
example : valid m3_3_12 = false := by decide
example : complexityLedger m3_3_12 = [("b",1),("b",1)] := by decide
def m3_3_13 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_3_13 = false := by decide
example : complexityLedger m3_3_13 = [("a",1),("b",1),("b",1)] := by decide
def m3_3_14 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_3_14 = false := by decide
example : complexityLedger m3_3_14 = [("a",1),("b",1),("b",1)] := by decide
def m3_3_15 : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("a",["y"]),("b",["x"]),("b",["y"])],[]⟩
example : valid m3_3_15 = false := by decide
example : complexityLedger m3_3_15 = [("a",1),("a",1),("b",1),("b",1)] := by decide
def fixture : Model := ⟨["a","b"],[["x"],["y"]],[("a",["x"]),("b",["x"])],[(["x"],"task")]⟩
def leftTrace : Transformation fixture := ⟨"a",["x"],.head _,.head _,.head _⟩
def rightTrace : Transformation fixture := ⟨"b",["x"],.tail _ (.head _),.head _,.tail _ (.head _)⟩
def nativeTask : TaskTrace fixture := ⟨leftTrace,"task",.head _⟩
theorem nativeClosed : SFT.InformationScience.EncodingLoss.closedPair fixture.encoding "a" "b" = .ok true := commonWordCloses fixture (by decide) leftTrace rightTrace rfl
example : closedLedger fixture = .ok [("a","b")] := rfl
example : retainedLedger fixture = [] := by decide
example : compose fixture [(["x"],["y"])] = .ok [("a",["y"]),("b",["y"])] := rfl
example : compose fixture [] = .error "encoding composition requires a complete exact interface map" := rfl
example : tasks fixture ["x"] = ["task"] := by decide
example : tasks fixture ["y"] = [] := by decide
#print axioms nativeTask
#print axioms nativeClosed
end SFT.Computation.RepresentationLearning
