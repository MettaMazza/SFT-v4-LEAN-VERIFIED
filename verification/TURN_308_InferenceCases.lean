import SFT.Computation.Inference
namespace SFT.Computation.Inference
def hs0_0_0 : List Hypothesis := [("h0",[]),("h1",[])]
example : consistentHypotheses [] hs0_0_0 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_0_0).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_0_0).map Prod.fst = [] := by decide
def hs0_0_1 : List Hypothesis := [("h0",[]),("h1",[("a","x")])]
example : consistentHypotheses [] hs0_0_1 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_0_1).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_0_1).map Prod.fst = [] := by decide
def hs0_0_2 : List Hypothesis := [("h0",[]),("h1",[("b","y")])]
example : consistentHypotheses [] hs0_0_2 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_0_2).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_0_2).map Prod.fst = [] := by decide
def hs0_0_3 : List Hypothesis := [("h0",[]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [] hs0_0_3 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_0_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_0_3).map Prod.fst = [] := by decide
def hs0_1_0 : List Hypothesis := [("h0",[("a","x")]),("h1",[])]
example : consistentHypotheses [] hs0_1_0 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_1_0).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_1_0).map Prod.fst = [] := by decide
def hs0_1_1 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x")])]
example : consistentHypotheses [] hs0_1_1 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_1_1).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_1_1).map Prod.fst = [] := by decide
def hs0_1_2 : List Hypothesis := [("h0",[("a","x")]),("h1",[("b","y")])]
example : consistentHypotheses [] hs0_1_2 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_1_2).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_1_2).map Prod.fst = [] := by decide
def hs0_1_3 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [] hs0_1_3 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_1_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_1_3).map Prod.fst = [] := by decide
def hs0_2_0 : List Hypothesis := [("h0",[("b","y")]),("h1",[])]
example : consistentHypotheses [] hs0_2_0 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_2_0).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_2_0).map Prod.fst = [] := by decide
def hs0_2_1 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [] hs0_2_1 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_2_1).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_2_1).map Prod.fst = [] := by decide
def hs0_2_2 : List Hypothesis := [("h0",[("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [] hs0_2_2 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_2_2).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_2_2).map Prod.fst = [] := by decide
def hs0_2_3 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [] hs0_2_3 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_2_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_2_3).map Prod.fst = [] := by decide
def hs0_3_0 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[])]
example : consistentHypotheses [] hs0_3_0 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_3_0).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_3_0).map Prod.fst = [] := by decide
def hs0_3_1 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [] hs0_3_1 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_3_1).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_3_1).map Prod.fst = [] := by decide
def hs0_3_2 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [] hs0_3_2 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_3_2).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_3_2).map Prod.fst = [] := by decide
def hs0_3_3 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [] hs0_3_3 = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : (retained [] hs0_3_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [] hs0_3_3).map Prod.fst = [] := by decide
def hs1_0_0 : List Hypothesis := [("h0",[]),("h1",[])]
example : consistentHypotheses [("a","x")] hs1_0_0 = .ok [] := rfl
example : (retained [("a","x")] hs1_0_0).map Prod.fst = [] := by decide
example : (eliminated [("a","x")] hs1_0_0).map Prod.fst = ["h0","h1"] := by decide
def hs1_0_1 : List Hypothesis := [("h0",[]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x")] hs1_0_1 = .ok ["h1"] := rfl
example : (retained [("a","x")] hs1_0_1).map Prod.fst = ["h1"] := by decide
example : (eliminated [("a","x")] hs1_0_1).map Prod.fst = ["h0"] := by decide
def hs1_0_2 : List Hypothesis := [("h0",[]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x")] hs1_0_2 = .ok [] := rfl
example : (retained [("a","x")] hs1_0_2).map Prod.fst = [] := by decide
example : (eliminated [("a","x")] hs1_0_2).map Prod.fst = ["h0","h1"] := by decide
def hs1_0_3 : List Hypothesis := [("h0",[]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x")] hs1_0_3 = .ok ["h1"] := rfl
example : (retained [("a","x")] hs1_0_3).map Prod.fst = ["h1"] := by decide
example : (eliminated [("a","x")] hs1_0_3).map Prod.fst = ["h0"] := by decide
def hs1_1_0 : List Hypothesis := [("h0",[("a","x")]),("h1",[])]
example : consistentHypotheses [("a","x")] hs1_1_0 = .ok ["h0"] := rfl
example : (retained [("a","x")] hs1_1_0).map Prod.fst = ["h0"] := by decide
example : (eliminated [("a","x")] hs1_1_0).map Prod.fst = ["h1"] := by decide
def hs1_1_1 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x")] hs1_1_1 = .ok ["h0","h1"] := rfl
example : (retained [("a","x")] hs1_1_1).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("a","x")] hs1_1_1).map Prod.fst = [] := by decide
def hs1_1_2 : List Hypothesis := [("h0",[("a","x")]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x")] hs1_1_2 = .ok ["h0"] := rfl
example : (retained [("a","x")] hs1_1_2).map Prod.fst = ["h0"] := by decide
example : (eliminated [("a","x")] hs1_1_2).map Prod.fst = ["h1"] := by decide
def hs1_1_3 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x")] hs1_1_3 = .ok ["h0","h1"] := rfl
example : (retained [("a","x")] hs1_1_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("a","x")] hs1_1_3).map Prod.fst = [] := by decide
def hs1_2_0 : List Hypothesis := [("h0",[("b","y")]),("h1",[])]
example : consistentHypotheses [("a","x")] hs1_2_0 = .ok [] := rfl
example : (retained [("a","x")] hs1_2_0).map Prod.fst = [] := by decide
example : (eliminated [("a","x")] hs1_2_0).map Prod.fst = ["h0","h1"] := by decide
def hs1_2_1 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x")] hs1_2_1 = .ok ["h1"] := rfl
example : (retained [("a","x")] hs1_2_1).map Prod.fst = ["h1"] := by decide
example : (eliminated [("a","x")] hs1_2_1).map Prod.fst = ["h0"] := by decide
def hs1_2_2 : List Hypothesis := [("h0",[("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x")] hs1_2_2 = .ok [] := rfl
example : (retained [("a","x")] hs1_2_2).map Prod.fst = [] := by decide
example : (eliminated [("a","x")] hs1_2_2).map Prod.fst = ["h0","h1"] := by decide
def hs1_2_3 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x")] hs1_2_3 = .ok ["h1"] := rfl
example : (retained [("a","x")] hs1_2_3).map Prod.fst = ["h1"] := by decide
example : (eliminated [("a","x")] hs1_2_3).map Prod.fst = ["h0"] := by decide
def hs1_3_0 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[])]
example : consistentHypotheses [("a","x")] hs1_3_0 = .ok ["h0"] := rfl
example : (retained [("a","x")] hs1_3_0).map Prod.fst = ["h0"] := by decide
example : (eliminated [("a","x")] hs1_3_0).map Prod.fst = ["h1"] := by decide
def hs1_3_1 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x")] hs1_3_1 = .ok ["h0","h1"] := rfl
example : (retained [("a","x")] hs1_3_1).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("a","x")] hs1_3_1).map Prod.fst = [] := by decide
def hs1_3_2 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x")] hs1_3_2 = .ok ["h0"] := rfl
example : (retained [("a","x")] hs1_3_2).map Prod.fst = ["h0"] := by decide
example : (eliminated [("a","x")] hs1_3_2).map Prod.fst = ["h1"] := by decide
def hs1_3_3 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x")] hs1_3_3 = .ok ["h0","h1"] := rfl
example : (retained [("a","x")] hs1_3_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("a","x")] hs1_3_3).map Prod.fst = [] := by decide
def hs2_0_0 : List Hypothesis := [("h0",[]),("h1",[])]
example : consistentHypotheses [("b","y")] hs2_0_0 = .ok [] := rfl
example : (retained [("b","y")] hs2_0_0).map Prod.fst = [] := by decide
example : (eliminated [("b","y")] hs2_0_0).map Prod.fst = ["h0","h1"] := by decide
def hs2_0_1 : List Hypothesis := [("h0",[]),("h1",[("a","x")])]
example : consistentHypotheses [("b","y")] hs2_0_1 = .ok [] := rfl
example : (retained [("b","y")] hs2_0_1).map Prod.fst = [] := by decide
example : (eliminated [("b","y")] hs2_0_1).map Prod.fst = ["h0","h1"] := by decide
def hs2_0_2 : List Hypothesis := [("h0",[]),("h1",[("b","y")])]
example : consistentHypotheses [("b","y")] hs2_0_2 = .ok ["h1"] := rfl
example : (retained [("b","y")] hs2_0_2).map Prod.fst = ["h1"] := by decide
example : (eliminated [("b","y")] hs2_0_2).map Prod.fst = ["h0"] := by decide
def hs2_0_3 : List Hypothesis := [("h0",[]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("b","y")] hs2_0_3 = .ok ["h1"] := rfl
example : (retained [("b","y")] hs2_0_3).map Prod.fst = ["h1"] := by decide
example : (eliminated [("b","y")] hs2_0_3).map Prod.fst = ["h0"] := by decide
def hs2_1_0 : List Hypothesis := [("h0",[("a","x")]),("h1",[])]
example : consistentHypotheses [("b","y")] hs2_1_0 = .ok [] := rfl
example : (retained [("b","y")] hs2_1_0).map Prod.fst = [] := by decide
example : (eliminated [("b","y")] hs2_1_0).map Prod.fst = ["h0","h1"] := by decide
def hs2_1_1 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x")])]
example : consistentHypotheses [("b","y")] hs2_1_1 = .ok [] := rfl
example : (retained [("b","y")] hs2_1_1).map Prod.fst = [] := by decide
example : (eliminated [("b","y")] hs2_1_1).map Prod.fst = ["h0","h1"] := by decide
def hs2_1_2 : List Hypothesis := [("h0",[("a","x")]),("h1",[("b","y")])]
example : consistentHypotheses [("b","y")] hs2_1_2 = .ok ["h1"] := rfl
example : (retained [("b","y")] hs2_1_2).map Prod.fst = ["h1"] := by decide
example : (eliminated [("b","y")] hs2_1_2).map Prod.fst = ["h0"] := by decide
def hs2_1_3 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("b","y")] hs2_1_3 = .ok ["h1"] := rfl
example : (retained [("b","y")] hs2_1_3).map Prod.fst = ["h1"] := by decide
example : (eliminated [("b","y")] hs2_1_3).map Prod.fst = ["h0"] := by decide
def hs2_2_0 : List Hypothesis := [("h0",[("b","y")]),("h1",[])]
example : consistentHypotheses [("b","y")] hs2_2_0 = .ok ["h0"] := rfl
example : (retained [("b","y")] hs2_2_0).map Prod.fst = ["h0"] := by decide
example : (eliminated [("b","y")] hs2_2_0).map Prod.fst = ["h1"] := by decide
def hs2_2_1 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [("b","y")] hs2_2_1 = .ok ["h0"] := rfl
example : (retained [("b","y")] hs2_2_1).map Prod.fst = ["h0"] := by decide
example : (eliminated [("b","y")] hs2_2_1).map Prod.fst = ["h1"] := by decide
def hs2_2_2 : List Hypothesis := [("h0",[("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [("b","y")] hs2_2_2 = .ok ["h0","h1"] := rfl
example : (retained [("b","y")] hs2_2_2).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("b","y")] hs2_2_2).map Prod.fst = [] := by decide
def hs2_2_3 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("b","y")] hs2_2_3 = .ok ["h0","h1"] := rfl
example : (retained [("b","y")] hs2_2_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("b","y")] hs2_2_3).map Prod.fst = [] := by decide
def hs2_3_0 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[])]
example : consistentHypotheses [("b","y")] hs2_3_0 = .ok ["h0"] := rfl
example : (retained [("b","y")] hs2_3_0).map Prod.fst = ["h0"] := by decide
example : (eliminated [("b","y")] hs2_3_0).map Prod.fst = ["h1"] := by decide
def hs2_3_1 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [("b","y")] hs2_3_1 = .ok ["h0"] := rfl
example : (retained [("b","y")] hs2_3_1).map Prod.fst = ["h0"] := by decide
example : (eliminated [("b","y")] hs2_3_1).map Prod.fst = ["h1"] := by decide
def hs2_3_2 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [("b","y")] hs2_3_2 = .ok ["h0","h1"] := rfl
example : (retained [("b","y")] hs2_3_2).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("b","y")] hs2_3_2).map Prod.fst = [] := by decide
def hs2_3_3 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("b","y")] hs2_3_3 = .ok ["h0","h1"] := rfl
example : (retained [("b","y")] hs2_3_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("b","y")] hs2_3_3).map Prod.fst = [] := by decide
def hs3_0_0 : List Hypothesis := [("h0",[]),("h1",[])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_0_0 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_0_0).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_0_0).map Prod.fst = ["h0","h1"] := by decide
def hs3_0_1 : List Hypothesis := [("h0",[]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_0_1 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_0_1).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_0_1).map Prod.fst = ["h0","h1"] := by decide
def hs3_0_2 : List Hypothesis := [("h0",[]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_0_2 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_0_2).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_0_2).map Prod.fst = ["h0","h1"] := by decide
def hs3_0_3 : List Hypothesis := [("h0",[]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_0_3 = .ok ["h1"] := rfl
example : (retained [("a","x"),("b","y")] hs3_0_3).map Prod.fst = ["h1"] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_0_3).map Prod.fst = ["h0"] := by decide
def hs3_1_0 : List Hypothesis := [("h0",[("a","x")]),("h1",[])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_1_0 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_1_0).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_1_0).map Prod.fst = ["h0","h1"] := by decide
def hs3_1_1 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_1_1 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_1_1).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_1_1).map Prod.fst = ["h0","h1"] := by decide
def hs3_1_2 : List Hypothesis := [("h0",[("a","x")]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_1_2 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_1_2).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_1_2).map Prod.fst = ["h0","h1"] := by decide
def hs3_1_3 : List Hypothesis := [("h0",[("a","x")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_1_3 = .ok ["h1"] := rfl
example : (retained [("a","x"),("b","y")] hs3_1_3).map Prod.fst = ["h1"] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_1_3).map Prod.fst = ["h0"] := by decide
def hs3_2_0 : List Hypothesis := [("h0",[("b","y")]),("h1",[])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_2_0 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_2_0).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_2_0).map Prod.fst = ["h0","h1"] := by decide
def hs3_2_1 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_2_1 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_2_1).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_2_1).map Prod.fst = ["h0","h1"] := by decide
def hs3_2_2 : List Hypothesis := [("h0",[("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_2_2 = .ok [] := rfl
example : (retained [("a","x"),("b","y")] hs3_2_2).map Prod.fst = [] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_2_2).map Prod.fst = ["h0","h1"] := by decide
def hs3_2_3 : List Hypothesis := [("h0",[("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_2_3 = .ok ["h1"] := rfl
example : (retained [("a","x"),("b","y")] hs3_2_3).map Prod.fst = ["h1"] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_2_3).map Prod.fst = ["h0"] := by decide
def hs3_3_0 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_3_0 = .ok ["h0"] := rfl
example : (retained [("a","x"),("b","y")] hs3_3_0).map Prod.fst = ["h0"] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_3_0).map Prod.fst = ["h1"] := by decide
def hs3_3_1 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_3_1 = .ok ["h0"] := rfl
example : (retained [("a","x"),("b","y")] hs3_3_1).map Prod.fst = ["h0"] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_3_1).map Prod.fst = ["h1"] := by decide
def hs3_3_2 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_3_2 = .ok ["h0"] := rfl
example : (retained [("a","x"),("b","y")] hs3_3_2).map Prod.fst = ["h0"] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_3_2).map Prod.fst = ["h1"] := by decide
def hs3_3_3 : List Hypothesis := [("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])]
example : consistentHypotheses [("a","x"),("b","y")] hs3_3_3 = .ok ["h0","h1"] := rfl
example : (retained [("a","x"),("b","y")] hs3_3_3).map Prod.fst = ["h0","h1"] := by decide
example : (eliminated [("a","x"),("b","y")] hs3_3_3).map Prod.fst = [] := by decide
example : consistentHypotheses [("a","x")] [] = .error "ValueError: learning support requires generated examples and hypotheses" := rfl
example : consistentHypotheses [] [("h",[]),("h",[])] = .error "ValueError: hypotheses must contain unique generated identities" := rfl
end SFT.Computation.Inference
