import SFT.Computation.MultiAgent
namespace SFT.Computation.MultiAgent
def m0_0_0_0_0 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_0_0 = [] := by decide
example : localObservations m0_0_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_0_0 "u" "b" = [] := by decide
def m0_0_0_0_1 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_0_1 = [] := by decide
example : localObservations m0_0_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_0_1 "u" "b" = [] := by decide
def m0_0_0_1_0 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_1_0 = [] := by decide
example : localObservations m0_0_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_1_0 "u" "b" = [] := by decide
def m0_0_0_1_1 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_1_1 = [] := by decide
example : localObservations m0_0_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_1_1 "u" "b" = [] := by decide
def m0_0_0_2_0 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_2_0 = [] := by decide
example : localObservations m0_0_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_2_0 "u" "b" = [] := by decide
def m0_0_0_2_1 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_2_1 = [] := by decide
example : localObservations m0_0_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_2_1 "u" "b" = [] := by decide
def m0_0_0_3_0 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_3_0 = [] := by decide
example : localObservations m0_0_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_3_0 "u" "b" = [] := by decide
def m0_0_0_3_1 : Model := ⟨[],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_0_3_1 = [] := by decide
example : localObservations m0_0_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_0_3_1 "u" "b" = [] := by decide
def m0_0_1_0_0 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_0_0 = [] := by decide
example : localObservations m0_0_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_0_0 "u" "b" = [] := by decide
def m0_0_1_0_1 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_0_1 = [] := by decide
example : localObservations m0_0_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_0_1 "u" "b" = [] := by decide
def m0_0_1_1_0 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_1_0 = [] := by decide
example : localObservations m0_0_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_1_0 "u" "b" = [] := by decide
def m0_0_1_1_1 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_1_1 = [] := by decide
example : localObservations m0_0_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_1_1 "u" "b" = [] := by decide
def m0_0_1_2_0 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_2_0 = [] := by decide
example : localObservations m0_0_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_2_0 "u" "b" = [] := by decide
def m0_0_1_2_1 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_2_1 = [] := by decide
example : localObservations m0_0_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_2_1 "u" "b" = [] := by decide
def m0_0_1_3_0 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_3_0 = [] := by decide
example : localObservations m0_0_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_3_0 "u" "b" = [] := by decide
def m0_0_1_3_1 : Model := ⟨[],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_1_3_1 = [] := by decide
example : localObservations m0_0_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_1_3_1 "u" "b" = [] := by decide
def m0_0_2_0_0 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_0_0 = [] := by decide
example : localObservations m0_0_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_0_0 "u" "b" = [] := by decide
def m0_0_2_0_1 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_0_1 = [] := by decide
example : localObservations m0_0_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_0_1 "u" "b" = [] := by decide
def m0_0_2_1_0 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_1_0 = [] := by decide
example : localObservations m0_0_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_1_0 "u" "b" = [] := by decide
def m0_0_2_1_1 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_1_1 = [] := by decide
example : localObservations m0_0_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_1_1 "u" "b" = [] := by decide
def m0_0_2_2_0 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_2_0 = [] := by decide
example : localObservations m0_0_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_2_0 "u" "b" = [] := by decide
def m0_0_2_2_1 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_2_1 = [] := by decide
example : localObservations m0_0_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_2_1 "u" "b" = [] := by decide
def m0_0_2_3_0 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_3_0 = [] := by decide
example : localObservations m0_0_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_3_0 "u" "b" = [] := by decide
def m0_0_2_3_1 : Model := ⟨[],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_2_3_1 = [] := by decide
example : localObservations m0_0_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_2_3_1 "u" "b" = [] := by decide
def m0_0_3_0_0 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_0_0 = [] := by decide
example : localObservations m0_0_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_0_0 "u" "b" = [] := by decide
def m0_0_3_0_1 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_0_1 = [] := by decide
example : localObservations m0_0_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_0_1 "u" "b" = [] := by decide
def m0_0_3_1_0 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_1_0 = [] := by decide
example : localObservations m0_0_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_1_0 "u" "b" = [] := by decide
def m0_0_3_1_1 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_1_1 = [] := by decide
example : localObservations m0_0_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_1_1 "u" "b" = [] := by decide
def m0_0_3_2_0 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_2_0 = [] := by decide
example : localObservations m0_0_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_2_0 "u" "b" = [] := by decide
def m0_0_3_2_1 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_2_1 = [] := by decide
example : localObservations m0_0_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_2_1 "u" "b" = [] := by decide
def m0_0_3_3_0 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_3_0 = [] := by decide
example : localObservations m0_0_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_3_0 "u" "b" = [] := by decide
def m0_0_3_3_1 : Model := ⟨[],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_0_3_3_1 = [] := by decide
example : localObservations m0_0_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_0_3_3_1 "u" "b" = [] := by decide
def m0_1_0_0_0 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_0_0 = [] := by decide
example : localObservations m0_1_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_0_0 "u" "b" = [] := by decide
def m0_1_0_0_1 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_0_1 = [] := by decide
example : localObservations m0_1_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_0_1 "u" "b" = [] := by decide
def m0_1_0_1_0 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_1_0 = [] := by decide
example : localObservations m0_1_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_1_0 "u" "b" = [] := by decide
def m0_1_0_1_1 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_1_1 = [] := by decide
example : localObservations m0_1_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_1_1 "u" "b" = [] := by decide
def m0_1_0_2_0 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_2_0 = [] := by decide
example : localObservations m0_1_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_2_0 "u" "b" = [] := by decide
def m0_1_0_2_1 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_2_1 = [] := by decide
example : localObservations m0_1_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_2_1 "u" "b" = [] := by decide
def m0_1_0_3_0 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_3_0 = [] := by decide
example : localObservations m0_1_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_3_0 "u" "b" = [] := by decide
def m0_1_0_3_1 : Model := ⟨[],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_0_3_1 = [] := by decide
example : localObservations m0_1_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_0_3_1 "u" "b" = [] := by decide
def m0_1_1_0_0 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_0_0 = [] := by decide
example : localObservations m0_1_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_0_0 "u" "b" = [] := by decide
def m0_1_1_0_1 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_0_1 = [] := by decide
example : localObservations m0_1_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_0_1 "u" "b" = [] := by decide
def m0_1_1_1_0 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_1_0 = [] := by decide
example : localObservations m0_1_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_1_0 "u" "b" = [] := by decide
def m0_1_1_1_1 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_1_1 = [] := by decide
example : localObservations m0_1_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_1_1 "u" "b" = [] := by decide
def m0_1_1_2_0 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_2_0 = [] := by decide
example : localObservations m0_1_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_2_0 "u" "b" = [] := by decide
def m0_1_1_2_1 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_2_1 = [] := by decide
example : localObservations m0_1_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_2_1 "u" "b" = [] := by decide
def m0_1_1_3_0 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_3_0 = [] := by decide
example : localObservations m0_1_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_3_0 "u" "b" = [] := by decide
def m0_1_1_3_1 : Model := ⟨[],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_1_3_1 = [] := by decide
example : localObservations m0_1_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_1_3_1 "u" "b" = [] := by decide
def m0_1_2_0_0 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_0_0 = [] := by decide
example : localObservations m0_1_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_0_0 "u" "b" = [] := by decide
def m0_1_2_0_1 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_0_1 = [] := by decide
example : localObservations m0_1_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_0_1 "u" "b" = [] := by decide
def m0_1_2_1_0 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_1_0 = [] := by decide
example : localObservations m0_1_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_1_0 "u" "b" = [] := by decide
def m0_1_2_1_1 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_1_1 = [] := by decide
example : localObservations m0_1_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_1_1 "u" "b" = [] := by decide
def m0_1_2_2_0 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_2_0 = [] := by decide
example : localObservations m0_1_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_2_0 "u" "b" = [] := by decide
def m0_1_2_2_1 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_2_1 = [] := by decide
example : localObservations m0_1_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_2_1 "u" "b" = [] := by decide
def m0_1_2_3_0 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_3_0 = [] := by decide
example : localObservations m0_1_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_3_0 "u" "b" = [] := by decide
def m0_1_2_3_1 : Model := ⟨[],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_2_3_1 = [] := by decide
example : localObservations m0_1_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_2_3_1 "u" "b" = [] := by decide
def m0_1_3_0_0 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_0_0 = [] := by decide
example : localObservations m0_1_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_0_0 "u" "b" = [] := by decide
def m0_1_3_0_1 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_0_1 = [] := by decide
example : localObservations m0_1_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_0_1 "u" "b" = [] := by decide
def m0_1_3_1_0 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_1_0 = [] := by decide
example : localObservations m0_1_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_1_0 "u" "b" = [] := by decide
def m0_1_3_1_1 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_1_1 = [] := by decide
example : localObservations m0_1_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_1_1 "u" "b" = [] := by decide
def m0_1_3_2_0 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_2_0 = [] := by decide
example : localObservations m0_1_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_2_0 "u" "b" = [] := by decide
def m0_1_3_2_1 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_2_1 = [] := by decide
example : localObservations m0_1_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_2_1 "u" "b" = [] := by decide
def m0_1_3_3_0 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_3_0 = [] := by decide
example : localObservations m0_1_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_3_0 "u" "b" = [] := by decide
def m0_1_3_3_1 : Model := ⟨[],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_1_3_3_1 = [] := by decide
example : localObservations m0_1_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_1_3_3_1 "u" "b" = [] := by decide
def m0_2_0_0_0 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_0_0 = [] := by decide
example : localObservations m0_2_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_0_0 "u" "b" = [] := by decide
def m0_2_0_0_1 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_0_1 = [] := by decide
example : localObservations m0_2_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_0_1 "u" "b" = [] := by decide
def m0_2_0_1_0 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_1_0 = [] := by decide
example : localObservations m0_2_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_1_0 "u" "b" = [] := by decide
def m0_2_0_1_1 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_1_1 = [] := by decide
example : localObservations m0_2_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_1_1 "u" "b" = [] := by decide
def m0_2_0_2_0 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_2_0 = [] := by decide
example : localObservations m0_2_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_2_0 "u" "b" = [] := by decide
def m0_2_0_2_1 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_2_1 = [] := by decide
example : localObservations m0_2_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_2_1 "u" "b" = [] := by decide
def m0_2_0_3_0 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_3_0 = [] := by decide
example : localObservations m0_2_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_3_0 "u" "b" = [] := by decide
def m0_2_0_3_1 : Model := ⟨[],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_0_3_1 = [] := by decide
example : localObservations m0_2_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_0_3_1 "u" "b" = [] := by decide
def m0_2_1_0_0 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_0_0 = [] := by decide
example : localObservations m0_2_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_0_0 "u" "b" = [] := by decide
def m0_2_1_0_1 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_0_1 = [] := by decide
example : localObservations m0_2_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_0_1 "u" "b" = [] := by decide
def m0_2_1_1_0 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_1_0 = [] := by decide
example : localObservations m0_2_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_1_0 "u" "b" = [] := by decide
def m0_2_1_1_1 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_1_1 = [] := by decide
example : localObservations m0_2_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_1_1 "u" "b" = [] := by decide
def m0_2_1_2_0 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_2_0 = [] := by decide
example : localObservations m0_2_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_2_0 "u" "b" = [] := by decide
def m0_2_1_2_1 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_2_1 = [] := by decide
example : localObservations m0_2_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_2_1 "u" "b" = [] := by decide
def m0_2_1_3_0 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_3_0 = [] := by decide
example : localObservations m0_2_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_3_0 "u" "b" = [] := by decide
def m0_2_1_3_1 : Model := ⟨[],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_1_3_1 = [] := by decide
example : localObservations m0_2_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_1_3_1 "u" "b" = [] := by decide
def m0_2_2_0_0 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_0_0 = [] := by decide
example : localObservations m0_2_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_0_0 "u" "b" = [] := by decide
def m0_2_2_0_1 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_0_1 = [] := by decide
example : localObservations m0_2_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_0_1 "u" "b" = [] := by decide
def m0_2_2_1_0 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_1_0 = [] := by decide
example : localObservations m0_2_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_1_0 "u" "b" = [] := by decide
def m0_2_2_1_1 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_1_1 = [] := by decide
example : localObservations m0_2_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_1_1 "u" "b" = [] := by decide
def m0_2_2_2_0 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_2_0 = [] := by decide
example : localObservations m0_2_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_2_0 "u" "b" = [] := by decide
def m0_2_2_2_1 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_2_1 = [] := by decide
example : localObservations m0_2_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_2_1 "u" "b" = [] := by decide
def m0_2_2_3_0 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_3_0 = [] := by decide
example : localObservations m0_2_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_3_0 "u" "b" = [] := by decide
def m0_2_2_3_1 : Model := ⟨[],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_2_3_1 = [] := by decide
example : localObservations m0_2_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_2_3_1 "u" "b" = [] := by decide
def m0_2_3_0_0 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_0_0 = [] := by decide
example : localObservations m0_2_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_0_0 "u" "b" = [] := by decide
def m0_2_3_0_1 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_0_1 = [] := by decide
example : localObservations m0_2_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_0_1 "u" "b" = [] := by decide
def m0_2_3_1_0 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_1_0 = [] := by decide
example : localObservations m0_2_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_1_0 "u" "b" = [] := by decide
def m0_2_3_1_1 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_1_1 = [] := by decide
example : localObservations m0_2_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_1_1 "u" "b" = [] := by decide
def m0_2_3_2_0 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_2_0 = [] := by decide
example : localObservations m0_2_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_2_0 "u" "b" = [] := by decide
def m0_2_3_2_1 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_2_1 = [] := by decide
example : localObservations m0_2_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_2_1 "u" "b" = [] := by decide
def m0_2_3_3_0 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_3_0 = [] := by decide
example : localObservations m0_2_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_3_0 "u" "b" = [] := by decide
def m0_2_3_3_1 : Model := ⟨[],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_2_3_3_1 = [] := by decide
example : localObservations m0_2_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_2_3_3_1 "u" "b" = [] := by decide
def m0_3_0_0_0 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_0_0 = [] := by decide
example : localObservations m0_3_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_0_0 "u" "b" = [] := by decide
def m0_3_0_0_1 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m0_3_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_0_1 "u" "b" = [] := by decide
def m0_3_0_1_0 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_1_0 = [] := by decide
example : localObservations m0_3_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_1_0 "u" "b" = [] := by decide
def m0_3_0_1_1 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_1_1 = [] := by decide
example : localObservations m0_3_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_1_1 "u" "b" = [] := by decide
def m0_3_0_2_0 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_2_0 = [] := by decide
example : localObservations m0_3_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_2_0 "u" "b" = [] := by decide
def m0_3_0_2_1 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_2_1 = [] := by decide
example : localObservations m0_3_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_2_1 "u" "b" = [] := by decide
def m0_3_0_3_0 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_3_0 = [] := by decide
example : localObservations m0_3_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_3_0 "u" "b" = [] := by decide
def m0_3_0_3_1 : Model := ⟨[],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_0_3_1 = [] := by decide
example : localObservations m0_3_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_0_3_1 "u" "b" = [] := by decide
def m0_3_1_0_0 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_0_0 = [] := by decide
example : localObservations m0_3_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_0_0 "u" "b" = [] := by decide
def m0_3_1_0_1 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m0_3_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_0_1 "u" "b" = [] := by decide
def m0_3_1_1_0 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_1_0 = [] := by decide
example : localObservations m0_3_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_1_0 "u" "b" = [] := by decide
def m0_3_1_1_1 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_1_1 = [] := by decide
example : localObservations m0_3_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_1_1 "u" "b" = [] := by decide
def m0_3_1_2_0 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_2_0 = [] := by decide
example : localObservations m0_3_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_2_0 "u" "b" = [] := by decide
def m0_3_1_2_1 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_2_1 = [] := by decide
example : localObservations m0_3_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_2_1 "u" "b" = [] := by decide
def m0_3_1_3_0 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_3_0 = [] := by decide
example : localObservations m0_3_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_3_0 "u" "b" = [] := by decide
def m0_3_1_3_1 : Model := ⟨[],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_1_3_1 = [] := by decide
example : localObservations m0_3_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_1_3_1 "u" "b" = [] := by decide
def m0_3_2_0_0 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_0_0 = [] := by decide
example : localObservations m0_3_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_0_0 "u" "b" = [] := by decide
def m0_3_2_0_1 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m0_3_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_0_1 "u" "b" = [] := by decide
def m0_3_2_1_0 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_1_0 = [] := by decide
example : localObservations m0_3_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_1_0 "u" "b" = [] := by decide
def m0_3_2_1_1 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_1_1 = [] := by decide
example : localObservations m0_3_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_1_1 "u" "b" = [] := by decide
def m0_3_2_2_0 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_2_0 = [] := by decide
example : localObservations m0_3_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_2_0 "u" "b" = [] := by decide
def m0_3_2_2_1 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_2_1 = [] := by decide
example : localObservations m0_3_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_2_1 "u" "b" = [] := by decide
def m0_3_2_3_0 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_3_0 = [] := by decide
example : localObservations m0_3_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_3_0 "u" "b" = [] := by decide
def m0_3_2_3_1 : Model := ⟨[],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_2_3_1 = [] := by decide
example : localObservations m0_3_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_2_3_1 "u" "b" = [] := by decide
def m0_3_3_0_0 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_0_0 = [] := by decide
example : localObservations m0_3_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_0_0 "u" "b" = [] := by decide
def m0_3_3_0_1 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m0_3_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_0_1 "u" "b" = [] := by decide
def m0_3_3_1_0 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_1_0 = [] := by decide
example : localObservations m0_3_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_1_0 "u" "b" = [] := by decide
def m0_3_3_1_1 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_1_1 = [] := by decide
example : localObservations m0_3_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_1_1 "u" "b" = [] := by decide
def m0_3_3_2_0 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_2_0 = [] := by decide
example : localObservations m0_3_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_2_0 "u" "b" = [] := by decide
def m0_3_3_2_1 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_2_1 = [] := by decide
example : localObservations m0_3_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_2_1 "u" "b" = [] := by decide
def m0_3_3_3_0 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_3_0 = [] := by decide
example : localObservations m0_3_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_3_0 "u" "b" = [] := by decide
def m0_3_3_3_1 : Model := ⟨[],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m0_3_3_3_1 = [] := by decide
example : localObservations m0_3_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m0_3_3_3_1 "u" "b" = [] := by decide
def m1_0_0_0_0 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_0_0 = [] := by decide
example : localObservations m1_0_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_0_0 "u" "b" = [] := by decide
def m1_0_0_0_1 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_0_1 = [] := by decide
example : localObservations m1_0_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_0_1 "u" "b" = [] := by decide
def m1_0_0_1_0 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_1_0 = [] := by decide
example : localObservations m1_0_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_1_0 "u" "b" = [] := by decide
def m1_0_0_1_1 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_1_1 = [] := by decide
example : localObservations m1_0_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_1_1 "u" "b" = [] := by decide
def m1_0_0_2_0 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_2_0 = [] := by decide
example : localObservations m1_0_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_2_0 "u" "b" = [] := by decide
def m1_0_0_2_1 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_2_1 = [] := by decide
example : localObservations m1_0_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_2_1 "u" "b" = [] := by decide
def m1_0_0_3_0 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_3_0 = [] := by decide
example : localObservations m1_0_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_3_0 "u" "b" = [] := by decide
def m1_0_0_3_1 : Model := ⟨["u"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_0_3_1 = [] := by decide
example : localObservations m1_0_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_0_3_1 "u" "b" = [] := by decide
def m1_0_1_0_0 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_0_0 = [] := by decide
example : localObservations m1_0_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_0_0 "u" "b" = [] := by decide
def m1_0_1_0_1 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_0_1 = [] := by decide
example : localObservations m1_0_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_0_1 "u" "b" = [] := by decide
def m1_0_1_1_0 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_1_0 = [] := by decide
example : localObservations m1_0_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_1_0 "u" "b" = [] := by decide
def m1_0_1_1_1 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_1_1 = [] := by decide
example : localObservations m1_0_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_1_1 "u" "b" = [] := by decide
def m1_0_1_2_0 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_2_0 = [] := by decide
example : localObservations m1_0_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_2_0 "u" "b" = [] := by decide
def m1_0_1_2_1 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_2_1 = [] := by decide
example : localObservations m1_0_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_2_1 "u" "b" = [] := by decide
def m1_0_1_3_0 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_3_0 = [] := by decide
example : localObservations m1_0_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_3_0 "u" "b" = [] := by decide
def m1_0_1_3_1 : Model := ⟨["u"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_1_3_1 = [] := by decide
example : localObservations m1_0_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_1_3_1 "u" "b" = [] := by decide
def m1_0_2_0_0 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_0_0 = [] := by decide
example : localObservations m1_0_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_0_0 "u" "b" = [] := by decide
def m1_0_2_0_1 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_0_1 = [] := by decide
example : localObservations m1_0_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_0_1 "u" "b" = [] := by decide
def m1_0_2_1_0 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_1_0 = [] := by decide
example : localObservations m1_0_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_1_0 "u" "b" = [] := by decide
def m1_0_2_1_1 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_1_1 = [] := by decide
example : localObservations m1_0_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_1_1 "u" "b" = [] := by decide
def m1_0_2_2_0 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_2_0 = [] := by decide
example : localObservations m1_0_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_2_0 "u" "b" = [] := by decide
def m1_0_2_2_1 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_2_1 = [] := by decide
example : localObservations m1_0_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_2_1 "u" "b" = [] := by decide
def m1_0_2_3_0 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_3_0 = [] := by decide
example : localObservations m1_0_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_3_0 "u" "b" = [] := by decide
def m1_0_2_3_1 : Model := ⟨["u"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_2_3_1 = [] := by decide
example : localObservations m1_0_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_2_3_1 "u" "b" = [] := by decide
def m1_0_3_0_0 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_0_0 = [] := by decide
example : localObservations m1_0_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_0_0 "u" "b" = [] := by decide
def m1_0_3_0_1 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_0_1 = [] := by decide
example : localObservations m1_0_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_0_1 "u" "b" = [] := by decide
def m1_0_3_1_0 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_1_0 = [] := by decide
example : localObservations m1_0_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_1_0 "u" "b" = [] := by decide
def m1_0_3_1_1 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_1_1 = [] := by decide
example : localObservations m1_0_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_1_1 "u" "b" = [] := by decide
def m1_0_3_2_0 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_2_0 = [] := by decide
example : localObservations m1_0_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_2_0 "u" "b" = [] := by decide
def m1_0_3_2_1 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_2_1 = [] := by decide
example : localObservations m1_0_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_2_1 "u" "b" = [] := by decide
def m1_0_3_3_0 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_3_0 = [] := by decide
example : localObservations m1_0_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_3_0 "u" "b" = [] := by decide
def m1_0_3_3_1 : Model := ⟨["u"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_0_3_3_1 = [] := by decide
example : localObservations m1_0_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_0_3_3_1 "u" "b" = [] := by decide
def m1_1_0_0_0 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_0_0 = [] := by decide
example : localObservations m1_1_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_0_0 "u" "b" = [] := by decide
def m1_1_0_0_1 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_0_1 = [] := by decide
example : localObservations m1_1_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_0_1 "u" "b" = [] := by decide
def m1_1_0_1_0 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_1_0 = [] := by decide
example : localObservations m1_1_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_1_0 "u" "b" = [] := by decide
def m1_1_0_1_1 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_1_1 = [] := by decide
example : localObservations m1_1_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_1_1 "u" "b" = [] := by decide
def m1_1_0_2_0 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_2_0 = [] := by decide
example : localObservations m1_1_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_2_0 "u" "b" = [] := by decide
def m1_1_0_2_1 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_2_1 = [] := by decide
example : localObservations m1_1_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_2_1 "u" "b" = [] := by decide
def m1_1_0_3_0 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_3_0 = [] := by decide
example : localObservations m1_1_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_3_0 "u" "b" = [] := by decide
def m1_1_0_3_1 : Model := ⟨["u"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_0_3_1 = [] := by decide
example : localObservations m1_1_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_0_3_1 "u" "b" = [] := by decide
def m1_1_1_0_0 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_0_0 = [] := by decide
example : localObservations m1_1_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_0_0 "u" "b" = [] := by decide
def m1_1_1_0_1 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_0_1 = [] := by decide
example : localObservations m1_1_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_0_1 "u" "b" = [] := by decide
def m1_1_1_1_0 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_1_0 = [] := by decide
example : localObservations m1_1_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_1_0 "u" "b" = [] := by decide
def m1_1_1_1_1 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_1_1 = [] := by decide
example : localObservations m1_1_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_1_1 "u" "b" = [] := by decide
def m1_1_1_2_0 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_2_0 = [] := by decide
example : localObservations m1_1_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_2_0 "u" "b" = [] := by decide
def m1_1_1_2_1 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_2_1 = [] := by decide
example : localObservations m1_1_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_2_1 "u" "b" = [] := by decide
def m1_1_1_3_0 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_3_0 = [] := by decide
example : localObservations m1_1_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_3_0 "u" "b" = [] := by decide
def m1_1_1_3_1 : Model := ⟨["u"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_1_3_1 = [] := by decide
example : localObservations m1_1_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_1_3_1 "u" "b" = [] := by decide
def m1_1_2_0_0 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_0_0 = [] := by decide
example : localObservations m1_1_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_0_0 "u" "b" = [] := by decide
def m1_1_2_0_1 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_0_1 = [] := by decide
example : localObservations m1_1_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_0_1 "u" "b" = [] := by decide
def m1_1_2_1_0 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_1_0 = [] := by decide
example : localObservations m1_1_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_1_0 "u" "b" = [] := by decide
def m1_1_2_1_1 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_1_1 = [] := by decide
example : localObservations m1_1_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_1_1 "u" "b" = [] := by decide
def m1_1_2_2_0 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_2_0 = [] := by decide
example : localObservations m1_1_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_2_0 "u" "b" = [] := by decide
def m1_1_2_2_1 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_2_1 = [] := by decide
example : localObservations m1_1_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_2_1 "u" "b" = [] := by decide
def m1_1_2_3_0 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_3_0 = [] := by decide
example : localObservations m1_1_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_3_0 "u" "b" = [] := by decide
def m1_1_2_3_1 : Model := ⟨["u"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_2_3_1 = [] := by decide
example : localObservations m1_1_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_2_3_1 "u" "b" = [] := by decide
def m1_1_3_0_0 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_0_0 = [] := by decide
example : localObservations m1_1_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_0_0 "u" "b" = [] := by decide
def m1_1_3_0_1 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_0_1 = [] := by decide
example : localObservations m1_1_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_0_1 "u" "b" = [] := by decide
def m1_1_3_1_0 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_1_0 = [] := by decide
example : localObservations m1_1_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_1_0 "u" "b" = [] := by decide
def m1_1_3_1_1 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_1_1 = [] := by decide
example : localObservations m1_1_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_1_1 "u" "b" = [] := by decide
def m1_1_3_2_0 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_2_0 = [] := by decide
example : localObservations m1_1_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_2_0 "u" "b" = [] := by decide
def m1_1_3_2_1 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_2_1 = [] := by decide
example : localObservations m1_1_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_2_1 "u" "b" = [] := by decide
def m1_1_3_3_0 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_3_0 = [] := by decide
example : localObservations m1_1_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_3_0 "u" "b" = [] := by decide
def m1_1_3_3_1 : Model := ⟨["u"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_1_3_3_1 = [] := by decide
example : localObservations m1_1_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_1_3_3_1 "u" "b" = [] := by decide
def m1_2_0_0_0 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_0_0 = [] := by decide
example : localObservations m1_2_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_0_0 "u" "b" = [] := by decide
def m1_2_0_0_1 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_0_1 = [] := by decide
example : localObservations m1_2_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_0_1 "u" "b" = [] := by decide
def m1_2_0_1_0 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_1_0 = [] := by decide
example : localObservations m1_2_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_1_0 "u" "b" = [] := by decide
def m1_2_0_1_1 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_1_1 = [] := by decide
example : localObservations m1_2_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_1_1 "u" "b" = [] := by decide
def m1_2_0_2_0 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_2_0 = [] := by decide
example : localObservations m1_2_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_2_0 "u" "b" = [] := by decide
def m1_2_0_2_1 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_2_1 = [] := by decide
example : localObservations m1_2_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_2_1 "u" "b" = [] := by decide
def m1_2_0_3_0 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_3_0 = [] := by decide
example : localObservations m1_2_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_3_0 "u" "b" = [] := by decide
def m1_2_0_3_1 : Model := ⟨["u"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_0_3_1 = [] := by decide
example : localObservations m1_2_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_0_3_1 "u" "b" = [] := by decide
def m1_2_1_0_0 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_0_0 = [] := by decide
example : localObservations m1_2_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_0_0 "u" "b" = [] := by decide
def m1_2_1_0_1 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_0_1 = [] := by decide
example : localObservations m1_2_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_0_1 "u" "b" = [] := by decide
def m1_2_1_1_0 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_1_0 = [] := by decide
example : localObservations m1_2_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_1_0 "u" "b" = [] := by decide
def m1_2_1_1_1 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_1_1 = [] := by decide
example : localObservations m1_2_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_1_1 "u" "b" = [] := by decide
def m1_2_1_2_0 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_2_0 = [] := by decide
example : localObservations m1_2_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_2_0 "u" "b" = [] := by decide
def m1_2_1_2_1 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_2_1 = [] := by decide
example : localObservations m1_2_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_2_1 "u" "b" = [] := by decide
def m1_2_1_3_0 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_3_0 = [] := by decide
example : localObservations m1_2_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_3_0 "u" "b" = [] := by decide
def m1_2_1_3_1 : Model := ⟨["u"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_1_3_1 = [] := by decide
example : localObservations m1_2_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_1_3_1 "u" "b" = [] := by decide
def m1_2_2_0_0 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_0_0 = [] := by decide
example : localObservations m1_2_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_0_0 "u" "b" = [] := by decide
def m1_2_2_0_1 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_0_1 = [] := by decide
example : localObservations m1_2_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_0_1 "u" "b" = [] := by decide
def m1_2_2_1_0 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_1_0 = [] := by decide
example : localObservations m1_2_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_1_0 "u" "b" = [] := by decide
def m1_2_2_1_1 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_1_1 = [] := by decide
example : localObservations m1_2_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_1_1 "u" "b" = [] := by decide
def m1_2_2_2_0 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_2_0 = [] := by decide
example : localObservations m1_2_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_2_0 "u" "b" = [] := by decide
def m1_2_2_2_1 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_2_1 = [] := by decide
example : localObservations m1_2_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_2_1 "u" "b" = [] := by decide
def m1_2_2_3_0 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_3_0 = [] := by decide
example : localObservations m1_2_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_3_0 "u" "b" = [] := by decide
def m1_2_2_3_1 : Model := ⟨["u"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_2_3_1 = [] := by decide
example : localObservations m1_2_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_2_3_1 "u" "b" = [] := by decide
def m1_2_3_0_0 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_0_0 = [] := by decide
example : localObservations m1_2_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_0_0 "u" "b" = [] := by decide
def m1_2_3_0_1 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_0_1 = [] := by decide
example : localObservations m1_2_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_0_1 "u" "b" = [] := by decide
def m1_2_3_1_0 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_1_0 = [] := by decide
example : localObservations m1_2_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_1_0 "u" "b" = [] := by decide
def m1_2_3_1_1 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_1_1 = [] := by decide
example : localObservations m1_2_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_1_1 "u" "b" = [] := by decide
def m1_2_3_2_0 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_2_0 = [] := by decide
example : localObservations m1_2_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_2_0 "u" "b" = [] := by decide
def m1_2_3_2_1 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_2_1 = [] := by decide
example : localObservations m1_2_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_2_1 "u" "b" = [] := by decide
def m1_2_3_3_0 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_3_0 = [] := by decide
example : localObservations m1_2_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_3_0 "u" "b" = [] := by decide
def m1_2_3_3_1 : Model := ⟨["u"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_2_3_3_1 = [] := by decide
example : localObservations m1_2_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_2_3_3_1 "u" "b" = [] := by decide
def m1_3_0_0_0 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_0_0 = [] := by decide
example : localObservations m1_3_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_0_0 "u" "b" = [] := by decide
def m1_3_0_0_1 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m1_3_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_0_1 "u" "b" = [] := by decide
def m1_3_0_1_0 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_1_0 = [] := by decide
example : localObservations m1_3_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_1_0 "u" "b" = [] := by decide
def m1_3_0_1_1 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_1_1 = [] := by decide
example : localObservations m1_3_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_1_1 "u" "b" = [] := by decide
def m1_3_0_2_0 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_2_0 = [] := by decide
example : localObservations m1_3_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_2_0 "u" "b" = [] := by decide
def m1_3_0_2_1 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_2_1 = [] := by decide
example : localObservations m1_3_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_2_1 "u" "b" = [] := by decide
def m1_3_0_3_0 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_3_0 = [] := by decide
example : localObservations m1_3_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_3_0 "u" "b" = [] := by decide
def m1_3_0_3_1 : Model := ⟨["u"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_0_3_1 = [] := by decide
example : localObservations m1_3_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_0_3_1 "u" "b" = [] := by decide
def m1_3_1_0_0 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_0_0 = [] := by decide
example : localObservations m1_3_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_0_0 "u" "b" = [] := by decide
def m1_3_1_0_1 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m1_3_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_0_1 "u" "b" = [] := by decide
def m1_3_1_1_0 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_1_0 = [] := by decide
example : localObservations m1_3_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_1_0 "u" "b" = [] := by decide
def m1_3_1_1_1 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_1_1 = [⟨"a","b",[("u","go")],"held"⟩] := by decide
example : localObservations m1_3_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_1_1 "u" "b" = [] := by decide
def m1_3_1_2_0 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_2_0 = [] := by decide
example : localObservations m1_3_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_2_0 "u" "b" = [] := by decide
def m1_3_1_2_1 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_2_1 = [] := by decide
example : localObservations m1_3_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_2_1 "u" "b" = [] := by decide
def m1_3_1_3_0 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_3_0 = [] := by decide
example : localObservations m1_3_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_3_0 "u" "b" = [] := by decide
def m1_3_1_3_1 : Model := ⟨["u"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_1_3_1 = [] := by decide
example : localObservations m1_3_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_1_3_1 "u" "b" = [] := by decide
def m1_3_2_0_0 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_0_0 = [] := by decide
example : localObservations m1_3_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_0_0 "u" "b" = [] := by decide
def m1_3_2_0_1 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m1_3_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_0_1 "u" "b" = [] := by decide
def m1_3_2_1_0 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_1_0 = [] := by decide
example : localObservations m1_3_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_1_0 "u" "b" = [] := by decide
def m1_3_2_1_1 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_1_1 = [] := by decide
example : localObservations m1_3_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_1_1 "u" "b" = [] := by decide
def m1_3_2_2_0 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_2_0 = [] := by decide
example : localObservations m1_3_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_2_0 "u" "b" = [] := by decide
def m1_3_2_2_1 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_2_1 = [] := by decide
example : localObservations m1_3_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_2_1 "u" "b" = [] := by decide
def m1_3_2_3_0 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_3_0 = [] := by decide
example : localObservations m1_3_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_3_0 "u" "b" = [] := by decide
def m1_3_2_3_1 : Model := ⟨["u"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_2_3_1 = [] := by decide
example : localObservations m1_3_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_2_3_1 "u" "b" = [] := by decide
def m1_3_3_0_0 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_0_0 = [] := by decide
example : localObservations m1_3_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_0_0 "u" "b" = [] := by decide
def m1_3_3_0_1 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m1_3_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_0_1 "u" "b" = [] := by decide
def m1_3_3_1_0 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_1_0 = [] := by decide
example : localObservations m1_3_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_1_0 "u" "b" = [] := by decide
def m1_3_3_1_1 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_1_1 = [⟨"a","b",[("u","go")],"held"⟩] := by decide
example : localObservations m1_3_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_1_1 "u" "b" = [] := by decide
def m1_3_3_2_0 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_2_0 = [] := by decide
example : localObservations m1_3_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_2_0 "u" "b" = [] := by decide
def m1_3_3_2_1 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_2_1 = [] := by decide
example : localObservations m1_3_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_2_1 "u" "b" = [] := by decide
def m1_3_3_3_0 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_3_0 = [] := by decide
example : localObservations m1_3_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_3_0 "u" "b" = [] := by decide
def m1_3_3_3_1 : Model := ⟨["u"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m1_3_3_3_1 = [] := by decide
example : localObservations m1_3_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m1_3_3_3_1 "u" "b" = [] := by decide
def m2_0_0_0_0 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_0_0 = [] := by decide
example : localObservations m2_0_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_0_0 "u" "b" = [] := by decide
def m2_0_0_0_1 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_0_1 = [] := by decide
example : localObservations m2_0_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_0_1 "u" "b" = [] := by decide
def m2_0_0_1_0 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_1_0 = [] := by decide
example : localObservations m2_0_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_1_0 "u" "b" = [] := by decide
def m2_0_0_1_1 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_1_1 = [] := by decide
example : localObservations m2_0_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_1_1 "u" "b" = [] := by decide
def m2_0_0_2_0 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_2_0 = [] := by decide
example : localObservations m2_0_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_2_0 "u" "b" = [] := by decide
def m2_0_0_2_1 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_2_1 = [] := by decide
example : localObservations m2_0_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_2_1 "u" "b" = [] := by decide
def m2_0_0_3_0 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_3_0 = [] := by decide
example : localObservations m2_0_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_3_0 "u" "b" = [] := by decide
def m2_0_0_3_1 : Model := ⟨["v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_0_3_1 = [] := by decide
example : localObservations m2_0_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_0_3_1 "u" "b" = [] := by decide
def m2_0_1_0_0 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_0_0 = [] := by decide
example : localObservations m2_0_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_0_0 "u" "b" = [] := by decide
def m2_0_1_0_1 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_0_1 = [] := by decide
example : localObservations m2_0_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_0_1 "u" "b" = [] := by decide
def m2_0_1_1_0 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_1_0 = [] := by decide
example : localObservations m2_0_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_1_0 "u" "b" = [] := by decide
def m2_0_1_1_1 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_1_1 = [] := by decide
example : localObservations m2_0_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_1_1 "u" "b" = [] := by decide
def m2_0_1_2_0 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_2_0 = [] := by decide
example : localObservations m2_0_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_2_0 "u" "b" = [] := by decide
def m2_0_1_2_1 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_2_1 = [] := by decide
example : localObservations m2_0_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_2_1 "u" "b" = [] := by decide
def m2_0_1_3_0 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_3_0 = [] := by decide
example : localObservations m2_0_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_3_0 "u" "b" = [] := by decide
def m2_0_1_3_1 : Model := ⟨["v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_1_3_1 = [] := by decide
example : localObservations m2_0_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_1_3_1 "u" "b" = [] := by decide
def m2_0_2_0_0 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_0_0 = [] := by decide
example : localObservations m2_0_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_0_0 "u" "b" = [] := by decide
def m2_0_2_0_1 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_0_1 = [] := by decide
example : localObservations m2_0_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_0_1 "u" "b" = [] := by decide
def m2_0_2_1_0 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_1_0 = [] := by decide
example : localObservations m2_0_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_1_0 "u" "b" = [] := by decide
def m2_0_2_1_1 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_1_1 = [] := by decide
example : localObservations m2_0_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_1_1 "u" "b" = [] := by decide
def m2_0_2_2_0 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_2_0 = [] := by decide
example : localObservations m2_0_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_2_0 "u" "b" = [] := by decide
def m2_0_2_2_1 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_2_1 = [] := by decide
example : localObservations m2_0_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_2_1 "u" "b" = [] := by decide
def m2_0_2_3_0 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_3_0 = [] := by decide
example : localObservations m2_0_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_3_0 "u" "b" = [] := by decide
def m2_0_2_3_1 : Model := ⟨["v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_2_3_1 = [] := by decide
example : localObservations m2_0_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_2_3_1 "u" "b" = [] := by decide
def m2_0_3_0_0 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_0_0 = [] := by decide
example : localObservations m2_0_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_0_0 "u" "b" = [] := by decide
def m2_0_3_0_1 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_0_1 = [] := by decide
example : localObservations m2_0_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_0_1 "u" "b" = [] := by decide
def m2_0_3_1_0 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_1_0 = [] := by decide
example : localObservations m2_0_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_1_0 "u" "b" = [] := by decide
def m2_0_3_1_1 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_1_1 = [] := by decide
example : localObservations m2_0_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_1_1 "u" "b" = [] := by decide
def m2_0_3_2_0 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_2_0 = [] := by decide
example : localObservations m2_0_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_2_0 "u" "b" = [] := by decide
def m2_0_3_2_1 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_2_1 = [] := by decide
example : localObservations m2_0_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_2_1 "u" "b" = [] := by decide
def m2_0_3_3_0 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_3_0 = [] := by decide
example : localObservations m2_0_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_3_0 "u" "b" = [] := by decide
def m2_0_3_3_1 : Model := ⟨["v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_0_3_3_1 = [] := by decide
example : localObservations m2_0_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_0_3_3_1 "u" "b" = [] := by decide
def m2_1_0_0_0 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_0_0 = [] := by decide
example : localObservations m2_1_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_0_0 "u" "b" = [] := by decide
def m2_1_0_0_1 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_0_1 = [] := by decide
example : localObservations m2_1_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_0_1 "u" "b" = [] := by decide
def m2_1_0_1_0 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_1_0 = [] := by decide
example : localObservations m2_1_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_1_0 "u" "b" = [] := by decide
def m2_1_0_1_1 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_1_1 = [] := by decide
example : localObservations m2_1_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_1_1 "u" "b" = [] := by decide
def m2_1_0_2_0 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_2_0 = [] := by decide
example : localObservations m2_1_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_2_0 "u" "b" = [] := by decide
def m2_1_0_2_1 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_2_1 = [] := by decide
example : localObservations m2_1_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_2_1 "u" "b" = [] := by decide
def m2_1_0_3_0 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_3_0 = [] := by decide
example : localObservations m2_1_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_3_0 "u" "b" = [] := by decide
def m2_1_0_3_1 : Model := ⟨["v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_0_3_1 = [] := by decide
example : localObservations m2_1_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_0_3_1 "u" "b" = [] := by decide
def m2_1_1_0_0 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_0_0 = [] := by decide
example : localObservations m2_1_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_0_0 "u" "b" = [] := by decide
def m2_1_1_0_1 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_0_1 = [] := by decide
example : localObservations m2_1_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_0_1 "u" "b" = [] := by decide
def m2_1_1_1_0 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_1_0 = [] := by decide
example : localObservations m2_1_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_1_0 "u" "b" = [] := by decide
def m2_1_1_1_1 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_1_1 = [] := by decide
example : localObservations m2_1_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_1_1 "u" "b" = [] := by decide
def m2_1_1_2_0 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_2_0 = [] := by decide
example : localObservations m2_1_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_2_0 "u" "b" = [] := by decide
def m2_1_1_2_1 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_2_1 = [] := by decide
example : localObservations m2_1_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_2_1 "u" "b" = [] := by decide
def m2_1_1_3_0 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_3_0 = [] := by decide
example : localObservations m2_1_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_3_0 "u" "b" = [] := by decide
def m2_1_1_3_1 : Model := ⟨["v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_1_3_1 = [] := by decide
example : localObservations m2_1_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_1_3_1 "u" "b" = [] := by decide
def m2_1_2_0_0 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_0_0 = [] := by decide
example : localObservations m2_1_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_0_0 "u" "b" = [] := by decide
def m2_1_2_0_1 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_0_1 = [] := by decide
example : localObservations m2_1_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_0_1 "u" "b" = [] := by decide
def m2_1_2_1_0 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_1_0 = [] := by decide
example : localObservations m2_1_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_1_0 "u" "b" = [] := by decide
def m2_1_2_1_1 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_1_1 = [] := by decide
example : localObservations m2_1_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_1_1 "u" "b" = [] := by decide
def m2_1_2_2_0 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_2_0 = [] := by decide
example : localObservations m2_1_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_2_0 "u" "b" = [] := by decide
def m2_1_2_2_1 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_2_1 = [] := by decide
example : localObservations m2_1_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_2_1 "u" "b" = [] := by decide
def m2_1_2_3_0 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_3_0 = [] := by decide
example : localObservations m2_1_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_3_0 "u" "b" = [] := by decide
def m2_1_2_3_1 : Model := ⟨["v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_2_3_1 = [] := by decide
example : localObservations m2_1_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_2_3_1 "u" "b" = [] := by decide
def m2_1_3_0_0 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_0_0 = [] := by decide
example : localObservations m2_1_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_0_0 "u" "b" = [] := by decide
def m2_1_3_0_1 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_0_1 = [] := by decide
example : localObservations m2_1_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_0_1 "u" "b" = [] := by decide
def m2_1_3_1_0 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_1_0 = [] := by decide
example : localObservations m2_1_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_1_0 "u" "b" = [] := by decide
def m2_1_3_1_1 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_1_1 = [] := by decide
example : localObservations m2_1_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_1_1 "u" "b" = [] := by decide
def m2_1_3_2_0 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_2_0 = [] := by decide
example : localObservations m2_1_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_2_0 "u" "b" = [] := by decide
def m2_1_3_2_1 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_2_1 = [] := by decide
example : localObservations m2_1_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_2_1 "u" "b" = [] := by decide
def m2_1_3_3_0 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_3_0 = [] := by decide
example : localObservations m2_1_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_3_0 "u" "b" = [] := by decide
def m2_1_3_3_1 : Model := ⟨["v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_1_3_3_1 = [] := by decide
example : localObservations m2_1_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_1_3_3_1 "u" "b" = [] := by decide
def m2_2_0_0_0 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_0_0 = [] := by decide
example : localObservations m2_2_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_0_0 "u" "b" = [] := by decide
def m2_2_0_0_1 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_0_1 = [] := by decide
example : localObservations m2_2_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_0_1 "u" "b" = [] := by decide
def m2_2_0_1_0 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_1_0 = [] := by decide
example : localObservations m2_2_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_1_0 "u" "b" = [] := by decide
def m2_2_0_1_1 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_1_1 = [] := by decide
example : localObservations m2_2_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_1_1 "u" "b" = [] := by decide
def m2_2_0_2_0 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_2_0 = [] := by decide
example : localObservations m2_2_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_2_0 "u" "b" = [] := by decide
def m2_2_0_2_1 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_2_1 = [] := by decide
example : localObservations m2_2_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_2_1 "u" "b" = [] := by decide
def m2_2_0_3_0 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_3_0 = [] := by decide
example : localObservations m2_2_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_3_0 "u" "b" = [] := by decide
def m2_2_0_3_1 : Model := ⟨["v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_0_3_1 = [] := by decide
example : localObservations m2_2_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_0_3_1 "u" "b" = [] := by decide
def m2_2_1_0_0 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_0_0 = [] := by decide
example : localObservations m2_2_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_0_0 "u" "b" = [] := by decide
def m2_2_1_0_1 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_0_1 = [] := by decide
example : localObservations m2_2_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_0_1 "u" "b" = [] := by decide
def m2_2_1_1_0 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_1_0 = [] := by decide
example : localObservations m2_2_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_1_0 "u" "b" = [] := by decide
def m2_2_1_1_1 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_1_1 = [] := by decide
example : localObservations m2_2_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_1_1 "u" "b" = [] := by decide
def m2_2_1_2_0 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_2_0 = [] := by decide
example : localObservations m2_2_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_2_0 "u" "b" = [] := by decide
def m2_2_1_2_1 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_2_1 = [] := by decide
example : localObservations m2_2_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_2_1 "u" "b" = [] := by decide
def m2_2_1_3_0 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_3_0 = [] := by decide
example : localObservations m2_2_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_3_0 "u" "b" = [] := by decide
def m2_2_1_3_1 : Model := ⟨["v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_1_3_1 = [] := by decide
example : localObservations m2_2_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_1_3_1 "u" "b" = [] := by decide
def m2_2_2_0_0 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_0_0 = [] := by decide
example : localObservations m2_2_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_0_0 "u" "b" = [] := by decide
def m2_2_2_0_1 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_0_1 = [] := by decide
example : localObservations m2_2_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_0_1 "u" "b" = [] := by decide
def m2_2_2_1_0 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_1_0 = [] := by decide
example : localObservations m2_2_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_1_0 "u" "b" = [] := by decide
def m2_2_2_1_1 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_1_1 = [] := by decide
example : localObservations m2_2_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_1_1 "u" "b" = [] := by decide
def m2_2_2_2_0 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_2_0 = [] := by decide
example : localObservations m2_2_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_2_0 "u" "b" = [] := by decide
def m2_2_2_2_1 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_2_1 = [] := by decide
example : localObservations m2_2_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_2_1 "u" "b" = [] := by decide
def m2_2_2_3_0 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_3_0 = [] := by decide
example : localObservations m2_2_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_3_0 "u" "b" = [] := by decide
def m2_2_2_3_1 : Model := ⟨["v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_2_3_1 = [] := by decide
example : localObservations m2_2_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_2_3_1 "u" "b" = [] := by decide
def m2_2_3_0_0 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_0_0 = [] := by decide
example : localObservations m2_2_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_0_0 "u" "b" = [] := by decide
def m2_2_3_0_1 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_0_1 = [] := by decide
example : localObservations m2_2_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_0_1 "u" "b" = [] := by decide
def m2_2_3_1_0 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_1_0 = [] := by decide
example : localObservations m2_2_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_1_0 "u" "b" = [] := by decide
def m2_2_3_1_1 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_1_1 = [] := by decide
example : localObservations m2_2_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_1_1 "u" "b" = [] := by decide
def m2_2_3_2_0 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_2_0 = [] := by decide
example : localObservations m2_2_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_2_0 "u" "b" = [] := by decide
def m2_2_3_2_1 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_2_1 = [] := by decide
example : localObservations m2_2_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_2_1 "u" "b" = [] := by decide
def m2_2_3_3_0 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_3_0 = [] := by decide
example : localObservations m2_2_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_3_0 "u" "b" = [] := by decide
def m2_2_3_3_1 : Model := ⟨["v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_2_3_3_1 = [] := by decide
example : localObservations m2_2_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_2_3_3_1 "u" "b" = [] := by decide
def m2_3_0_0_0 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_0_0 = [] := by decide
example : localObservations m2_3_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_0_0 "u" "b" = [] := by decide
def m2_3_0_0_1 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m2_3_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_0_1 "u" "b" = [] := by decide
def m2_3_0_1_0 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_1_0 = [] := by decide
example : localObservations m2_3_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_1_0 "u" "b" = [] := by decide
def m2_3_0_1_1 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_1_1 = [] := by decide
example : localObservations m2_3_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_1_1 "u" "b" = [] := by decide
def m2_3_0_2_0 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_2_0 = [] := by decide
example : localObservations m2_3_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_2_0 "u" "b" = [] := by decide
def m2_3_0_2_1 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_2_1 = [] := by decide
example : localObservations m2_3_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_2_1 "u" "b" = [] := by decide
def m2_3_0_3_0 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_3_0 = [] := by decide
example : localObservations m2_3_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_3_0 "u" "b" = [] := by decide
def m2_3_0_3_1 : Model := ⟨["v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_0_3_1 = [] := by decide
example : localObservations m2_3_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_0_3_1 "u" "b" = [] := by decide
def m2_3_1_0_0 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_0_0 = [] := by decide
example : localObservations m2_3_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_0_0 "u" "b" = [] := by decide
def m2_3_1_0_1 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m2_3_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_0_1 "u" "b" = [] := by decide
def m2_3_1_1_0 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_1_0 = [] := by decide
example : localObservations m2_3_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_1_0 "u" "b" = [] := by decide
def m2_3_1_1_1 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_1_1 = [] := by decide
example : localObservations m2_3_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_1_1 "u" "b" = [] := by decide
def m2_3_1_2_0 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_2_0 = [] := by decide
example : localObservations m2_3_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_2_0 "u" "b" = [] := by decide
def m2_3_1_2_1 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_2_1 = [] := by decide
example : localObservations m2_3_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_2_1 "u" "b" = [] := by decide
def m2_3_1_3_0 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_3_0 = [] := by decide
example : localObservations m2_3_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_3_0 "u" "b" = [] := by decide
def m2_3_1_3_1 : Model := ⟨["v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_1_3_1 = [] := by decide
example : localObservations m2_3_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_1_3_1 "u" "b" = [] := by decide
def m2_3_2_0_0 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_0_0 = [] := by decide
example : localObservations m2_3_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_0_0 "u" "b" = [] := by decide
def m2_3_2_0_1 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m2_3_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_0_1 "u" "b" = [] := by decide
def m2_3_2_1_0 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_1_0 = [] := by decide
example : localObservations m2_3_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_1_0 "u" "b" = [] := by decide
def m2_3_2_1_1 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_1_1 = [] := by decide
example : localObservations m2_3_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_1_1 "u" "b" = [] := by decide
def m2_3_2_2_0 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_2_0 = [] := by decide
example : localObservations m2_3_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_2_0 "u" "b" = [] := by decide
def m2_3_2_2_1 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_2_1 = [⟨"a","b",[("v","wait")],"held"⟩] := by decide
example : localObservations m2_3_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_2_1 "u" "b" = [] := by decide
def m2_3_2_3_0 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_3_0 = [] := by decide
example : localObservations m2_3_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_3_0 "u" "b" = [] := by decide
def m2_3_2_3_1 : Model := ⟨["v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_2_3_1 = [] := by decide
example : localObservations m2_3_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_2_3_1 "u" "b" = [] := by decide
def m2_3_3_0_0 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_0_0 = [] := by decide
example : localObservations m2_3_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_0_0 "u" "b" = [] := by decide
def m2_3_3_0_1 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m2_3_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_0_1 "u" "b" = [] := by decide
def m2_3_3_1_0 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_1_0 = [] := by decide
example : localObservations m2_3_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_1_0 "u" "b" = [] := by decide
def m2_3_3_1_1 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_1_1 = [] := by decide
example : localObservations m2_3_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_1_1 "u" "b" = [] := by decide
def m2_3_3_2_0 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_2_0 = [] := by decide
example : localObservations m2_3_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_2_0 "u" "b" = [] := by decide
def m2_3_3_2_1 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_2_1 = [⟨"a","b",[("v","wait")],"held"⟩] := by decide
example : localObservations m2_3_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_2_1 "u" "b" = [] := by decide
def m2_3_3_3_0 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_3_0 = [] := by decide
example : localObservations m2_3_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_3_0 "u" "b" = [] := by decide
def m2_3_3_3_1 : Model := ⟨["v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m2_3_3_3_1 = [] := by decide
example : localObservations m2_3_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m2_3_3_3_1 "u" "b" = [] := by decide
def m3_0_0_0_0 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_0_0 = [] := by decide
example : localObservations m3_0_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_0_0 "u" "b" = [] := by decide
def m3_0_0_0_1 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_0_1 = [] := by decide
example : localObservations m3_0_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_0_1 "u" "b" = [] := by decide
def m3_0_0_1_0 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_1_0 = [] := by decide
example : localObservations m3_0_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_1_0 "u" "b" = [] := by decide
def m3_0_0_1_1 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_1_1 = [] := by decide
example : localObservations m3_0_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_1_1 "u" "b" = [] := by decide
def m3_0_0_2_0 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_2_0 = [] := by decide
example : localObservations m3_0_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_2_0 "u" "b" = [] := by decide
def m3_0_0_2_1 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_2_1 = [] := by decide
example : localObservations m3_0_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_2_1 "u" "b" = [] := by decide
def m3_0_0_3_0 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_3_0 = [] := by decide
example : localObservations m3_0_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_3_0 "u" "b" = [] := by decide
def m3_0_0_3_1 : Model := ⟨["u","v"],[],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_0_3_1 = [] := by decide
example : localObservations m3_0_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_0_3_1 "u" "b" = [] := by decide
def m3_0_1_0_0 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_0_0 = [] := by decide
example : localObservations m3_0_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_0_0 "u" "b" = [] := by decide
def m3_0_1_0_1 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_0_1 = [] := by decide
example : localObservations m3_0_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_0_1 "u" "b" = [] := by decide
def m3_0_1_1_0 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_1_0 = [] := by decide
example : localObservations m3_0_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_1_0 "u" "b" = [] := by decide
def m3_0_1_1_1 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_1_1 = [] := by decide
example : localObservations m3_0_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_1_1 "u" "b" = [] := by decide
def m3_0_1_2_0 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_2_0 = [] := by decide
example : localObservations m3_0_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_2_0 "u" "b" = [] := by decide
def m3_0_1_2_1 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_2_1 = [] := by decide
example : localObservations m3_0_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_2_1 "u" "b" = [] := by decide
def m3_0_1_3_0 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_3_0 = [] := by decide
example : localObservations m3_0_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_3_0 "u" "b" = [] := by decide
def m3_0_1_3_1 : Model := ⟨["u","v"],[],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_1_3_1 = [] := by decide
example : localObservations m3_0_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_1_3_1 "u" "b" = [] := by decide
def m3_0_2_0_0 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_0_0 = [] := by decide
example : localObservations m3_0_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_0_0 "u" "b" = [] := by decide
def m3_0_2_0_1 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_0_1 = [] := by decide
example : localObservations m3_0_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_0_1 "u" "b" = [] := by decide
def m3_0_2_1_0 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_1_0 = [] := by decide
example : localObservations m3_0_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_1_0 "u" "b" = [] := by decide
def m3_0_2_1_1 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_1_1 = [] := by decide
example : localObservations m3_0_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_1_1 "u" "b" = [] := by decide
def m3_0_2_2_0 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_2_0 = [] := by decide
example : localObservations m3_0_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_2_0 "u" "b" = [] := by decide
def m3_0_2_2_1 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_2_1 = [] := by decide
example : localObservations m3_0_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_2_1 "u" "b" = [] := by decide
def m3_0_2_3_0 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_3_0 = [] := by decide
example : localObservations m3_0_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_3_0 "u" "b" = [] := by decide
def m3_0_2_3_1 : Model := ⟨["u","v"],[],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_2_3_1 = [] := by decide
example : localObservations m3_0_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_2_3_1 "u" "b" = [] := by decide
def m3_0_3_0_0 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_0_0 = [] := by decide
example : localObservations m3_0_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_0_0 "u" "b" = [] := by decide
def m3_0_3_0_1 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_0_1 = [] := by decide
example : localObservations m3_0_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_0_1 "u" "b" = [] := by decide
def m3_0_3_1_0 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_1_0 = [] := by decide
example : localObservations m3_0_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_1_0 "u" "b" = [] := by decide
def m3_0_3_1_1 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_1_1 = [] := by decide
example : localObservations m3_0_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_1_1 "u" "b" = [] := by decide
def m3_0_3_2_0 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_2_0 = [] := by decide
example : localObservations m3_0_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_2_0 "u" "b" = [] := by decide
def m3_0_3_2_1 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_2_1 = [] := by decide
example : localObservations m3_0_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_2_1 "u" "b" = [] := by decide
def m3_0_3_3_0 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_3_0 = [] := by decide
example : localObservations m3_0_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_3_0 "u" "b" = [] := by decide
def m3_0_3_3_1 : Model := ⟨["u","v"],[],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_0_3_3_1 = [] := by decide
example : localObservations m3_0_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_0_3_3_1 "u" "b" = [] := by decide
def m3_1_0_0_0 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_0_0 = [] := by decide
example : localObservations m3_1_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_0_0 "u" "b" = [] := by decide
def m3_1_0_0_1 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_0_1 = [] := by decide
example : localObservations m3_1_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_0_1 "u" "b" = [] := by decide
def m3_1_0_1_0 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_1_0 = [] := by decide
example : localObservations m3_1_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_1_0 "u" "b" = [] := by decide
def m3_1_0_1_1 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_1_1 = [] := by decide
example : localObservations m3_1_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_1_1 "u" "b" = [] := by decide
def m3_1_0_2_0 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_2_0 = [] := by decide
example : localObservations m3_1_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_2_0 "u" "b" = [] := by decide
def m3_1_0_2_1 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_2_1 = [] := by decide
example : localObservations m3_1_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_2_1 "u" "b" = [] := by decide
def m3_1_0_3_0 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_3_0 = [] := by decide
example : localObservations m3_1_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_3_0 "u" "b" = [] := by decide
def m3_1_0_3_1 : Model := ⟨["u","v"],["a"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_0_3_1 = [] := by decide
example : localObservations m3_1_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_0_3_1 "u" "b" = [] := by decide
def m3_1_1_0_0 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_0_0 = [] := by decide
example : localObservations m3_1_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_0_0 "u" "b" = [] := by decide
def m3_1_1_0_1 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_0_1 = [] := by decide
example : localObservations m3_1_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_0_1 "u" "b" = [] := by decide
def m3_1_1_1_0 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_1_0 = [] := by decide
example : localObservations m3_1_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_1_0 "u" "b" = [] := by decide
def m3_1_1_1_1 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_1_1 = [] := by decide
example : localObservations m3_1_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_1_1 "u" "b" = [] := by decide
def m3_1_1_2_0 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_2_0 = [] := by decide
example : localObservations m3_1_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_2_0 "u" "b" = [] := by decide
def m3_1_1_2_1 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_2_1 = [] := by decide
example : localObservations m3_1_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_2_1 "u" "b" = [] := by decide
def m3_1_1_3_0 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_3_0 = [] := by decide
example : localObservations m3_1_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_3_0 "u" "b" = [] := by decide
def m3_1_1_3_1 : Model := ⟨["u","v"],["a"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_1_3_1 = [] := by decide
example : localObservations m3_1_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_1_3_1 "u" "b" = [] := by decide
def m3_1_2_0_0 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_0_0 = [] := by decide
example : localObservations m3_1_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_0_0 "u" "b" = [] := by decide
def m3_1_2_0_1 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_0_1 = [] := by decide
example : localObservations m3_1_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_0_1 "u" "b" = [] := by decide
def m3_1_2_1_0 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_1_0 = [] := by decide
example : localObservations m3_1_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_1_0 "u" "b" = [] := by decide
def m3_1_2_1_1 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_1_1 = [] := by decide
example : localObservations m3_1_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_1_1 "u" "b" = [] := by decide
def m3_1_2_2_0 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_2_0 = [] := by decide
example : localObservations m3_1_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_2_0 "u" "b" = [] := by decide
def m3_1_2_2_1 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_2_1 = [] := by decide
example : localObservations m3_1_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_2_1 "u" "b" = [] := by decide
def m3_1_2_3_0 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_3_0 = [] := by decide
example : localObservations m3_1_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_3_0 "u" "b" = [] := by decide
def m3_1_2_3_1 : Model := ⟨["u","v"],["a"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_2_3_1 = [] := by decide
example : localObservations m3_1_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_2_3_1 "u" "b" = [] := by decide
def m3_1_3_0_0 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_0_0 = [] := by decide
example : localObservations m3_1_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_0_0 "u" "b" = [] := by decide
def m3_1_3_0_1 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_0_1 = [] := by decide
example : localObservations m3_1_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_0_1 "u" "b" = [] := by decide
def m3_1_3_1_0 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_1_0 = [] := by decide
example : localObservations m3_1_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_1_0 "u" "b" = [] := by decide
def m3_1_3_1_1 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_1_1 = [] := by decide
example : localObservations m3_1_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_1_1 "u" "b" = [] := by decide
def m3_1_3_2_0 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_2_0 = [] := by decide
example : localObservations m3_1_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_2_0 "u" "b" = [] := by decide
def m3_1_3_2_1 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_2_1 = [] := by decide
example : localObservations m3_1_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_2_1 "u" "b" = [] := by decide
def m3_1_3_3_0 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_3_0 = [] := by decide
example : localObservations m3_1_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_3_0 "u" "b" = [] := by decide
def m3_1_3_3_1 : Model := ⟨["u","v"],["a"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_1_3_3_1 = [] := by decide
example : localObservations m3_1_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_1_3_3_1 "u" "b" = [] := by decide
def m3_2_0_0_0 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_0_0 = [] := by decide
example : localObservations m3_2_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_0_0 "u" "b" = [] := by decide
def m3_2_0_0_1 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_0_1 = [] := by decide
example : localObservations m3_2_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_0_1 "u" "b" = [] := by decide
def m3_2_0_1_0 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_1_0 = [] := by decide
example : localObservations m3_2_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_1_0 "u" "b" = [] := by decide
def m3_2_0_1_1 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_1_1 = [] := by decide
example : localObservations m3_2_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_1_1 "u" "b" = [] := by decide
def m3_2_0_2_0 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_2_0 = [] := by decide
example : localObservations m3_2_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_2_0 "u" "b" = [] := by decide
def m3_2_0_2_1 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_2_1 = [] := by decide
example : localObservations m3_2_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_2_1 "u" "b" = [] := by decide
def m3_2_0_3_0 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_3_0 = [] := by decide
example : localObservations m3_2_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_3_0 "u" "b" = [] := by decide
def m3_2_0_3_1 : Model := ⟨["u","v"],["b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_0_3_1 = [] := by decide
example : localObservations m3_2_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_0_3_1 "u" "b" = [] := by decide
def m3_2_1_0_0 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_0_0 = [] := by decide
example : localObservations m3_2_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_0_0 "u" "b" = [] := by decide
def m3_2_1_0_1 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_0_1 = [] := by decide
example : localObservations m3_2_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_0_1 "u" "b" = [] := by decide
def m3_2_1_1_0 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_1_0 = [] := by decide
example : localObservations m3_2_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_1_0 "u" "b" = [] := by decide
def m3_2_1_1_1 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_1_1 = [] := by decide
example : localObservations m3_2_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_1_1 "u" "b" = [] := by decide
def m3_2_1_2_0 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_2_0 = [] := by decide
example : localObservations m3_2_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_2_0 "u" "b" = [] := by decide
def m3_2_1_2_1 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_2_1 = [] := by decide
example : localObservations m3_2_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_2_1 "u" "b" = [] := by decide
def m3_2_1_3_0 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_3_0 = [] := by decide
example : localObservations m3_2_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_3_0 "u" "b" = [] := by decide
def m3_2_1_3_1 : Model := ⟨["u","v"],["b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_1_3_1 = [] := by decide
example : localObservations m3_2_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_1_3_1 "u" "b" = [] := by decide
def m3_2_2_0_0 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_0_0 = [] := by decide
example : localObservations m3_2_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_0_0 "u" "b" = [] := by decide
def m3_2_2_0_1 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_0_1 = [] := by decide
example : localObservations m3_2_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_0_1 "u" "b" = [] := by decide
def m3_2_2_1_0 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_1_0 = [] := by decide
example : localObservations m3_2_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_1_0 "u" "b" = [] := by decide
def m3_2_2_1_1 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_1_1 = [] := by decide
example : localObservations m3_2_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_1_1 "u" "b" = [] := by decide
def m3_2_2_2_0 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_2_0 = [] := by decide
example : localObservations m3_2_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_2_0 "u" "b" = [] := by decide
def m3_2_2_2_1 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_2_1 = [] := by decide
example : localObservations m3_2_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_2_1 "u" "b" = [] := by decide
def m3_2_2_3_0 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_3_0 = [] := by decide
example : localObservations m3_2_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_3_0 "u" "b" = [] := by decide
def m3_2_2_3_1 : Model := ⟨["u","v"],["b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_2_3_1 = [] := by decide
example : localObservations m3_2_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_2_3_1 "u" "b" = [] := by decide
def m3_2_3_0_0 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_0_0 = [] := by decide
example : localObservations m3_2_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_0_0 "u" "b" = [] := by decide
def m3_2_3_0_1 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_0_1 = [] := by decide
example : localObservations m3_2_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_0_1 "u" "b" = [] := by decide
def m3_2_3_1_0 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_1_0 = [] := by decide
example : localObservations m3_2_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_1_0 "u" "b" = [] := by decide
def m3_2_3_1_1 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_1_1 = [] := by decide
example : localObservations m3_2_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_1_1 "u" "b" = [] := by decide
def m3_2_3_2_0 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_2_0 = [] := by decide
example : localObservations m3_2_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_2_0 "u" "b" = [] := by decide
def m3_2_3_2_1 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_2_1 = [] := by decide
example : localObservations m3_2_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_2_1 "u" "b" = [] := by decide
def m3_2_3_3_0 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_3_0 = [] := by decide
example : localObservations m3_2_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_3_0 "u" "b" = [] := by decide
def m3_2_3_3_1 : Model := ⟨["u","v"],["b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_2_3_3_1 = [] := by decide
example : localObservations m3_2_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_2_3_3_1 "u" "b" = [] := by decide
def m3_3_0_0_0 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_0_0 = [] := by decide
example : localObservations m3_3_0_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_0_0 "u" "b" = [] := by decide
def m3_3_0_0_1 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m3_3_0_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_0_1 "u" "b" = [] := by decide
def m3_3_0_1_0 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_1_0 = [] := by decide
example : localObservations m3_3_0_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_1_0 "u" "b" = [] := by decide
def m3_3_0_1_1 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_1_1 = [] := by decide
example : localObservations m3_3_0_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_1_1 "u" "b" = [] := by decide
def m3_3_0_2_0 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_2_0 = [] := by decide
example : localObservations m3_3_0_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_2_0 "u" "b" = [] := by decide
def m3_3_0_2_1 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_2_1 = [] := by decide
example : localObservations m3_3_0_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_2_1 "u" "b" = [] := by decide
def m3_3_0_3_0 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_3_0 = [] := by decide
example : localObservations m3_3_0_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_3_0 "u" "b" = [] := by decide
def m3_3_0_3_1 : Model := ⟨["u","v"],["a","b"],[],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_0_3_1 = [] := by decide
example : localObservations m3_3_0_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_0_3_1 "u" "b" = [] := by decide
def m3_3_1_0_0 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_0_0 = [] := by decide
example : localObservations m3_3_1_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_0_0 "u" "b" = [] := by decide
def m3_3_1_0_1 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m3_3_1_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_0_1 "u" "b" = [] := by decide
def m3_3_1_1_0 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_1_0 = [] := by decide
example : localObservations m3_3_1_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_1_0 "u" "b" = [] := by decide
def m3_3_1_1_1 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_1_1 = [⟨"a","b",[("u","go")],"held"⟩] := by decide
example : localObservations m3_3_1_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_1_1 "u" "b" = [] := by decide
def m3_3_1_2_0 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_2_0 = [] := by decide
example : localObservations m3_3_1_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_2_0 "u" "b" = [] := by decide
def m3_3_1_2_1 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_2_1 = [] := by decide
example : localObservations m3_3_1_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_2_1 "u" "b" = [] := by decide
def m3_3_1_3_0 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_3_0 = [] := by decide
example : localObservations m3_3_1_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_3_0 "u" "b" = [] := by decide
def m3_3_1_3_1 : Model := ⟨["u","v"],["a","b"],[("u","go")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_1_3_1 = [] := by decide
example : localObservations m3_3_1_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_1_3_1 "u" "b" = [] := by decide
def m3_3_2_0_0 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_0_0 = [] := by decide
example : localObservations m3_3_2_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_0_0 "u" "b" = [] := by decide
def m3_3_2_0_1 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m3_3_2_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_0_1 "u" "b" = [] := by decide
def m3_3_2_1_0 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_1_0 = [] := by decide
example : localObservations m3_3_2_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_1_0 "u" "b" = [] := by decide
def m3_3_2_1_1 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_1_1 = [] := by decide
example : localObservations m3_3_2_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_1_1 "u" "b" = [] := by decide
def m3_3_2_2_0 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_2_0 = [] := by decide
example : localObservations m3_3_2_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_2_0 "u" "b" = [] := by decide
def m3_3_2_2_1 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_2_1 = [⟨"a","b",[("v","wait")],"held"⟩] := by decide
example : localObservations m3_3_2_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_2_1 "u" "b" = [] := by decide
def m3_3_2_3_0 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_3_0 = [] := by decide
example : localObservations m3_3_2_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_3_0 "u" "b" = [] := by decide
def m3_3_2_3_1 : Model := ⟨["u","v"],["a","b"],[("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_2_3_1 = [] := by decide
example : localObservations m3_3_2_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_2_3_1 "u" "b" = [] := by decide
def m3_3_3_0_0 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_0_0 = [] := by decide
example : localObservations m3_3_3_0_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_0_0 "u" "b" = [] := by decide
def m3_3_3_0_1 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_0_1 = [⟨"a","b",[],"held"⟩] := by decide
example : localObservations m3_3_3_0_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_0_1 "u" "b" = [] := by decide
def m3_3_3_1_0 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_1_0 = [] := by decide
example : localObservations m3_3_3_1_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_1_0 "u" "b" = [] := by decide
def m3_3_3_1_1 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_1_1 = [⟨"a","b",[("u","go")],"held"⟩] := by decide
example : localObservations m3_3_3_1_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_1_1 "u" "b" = [] := by decide
def m3_3_3_2_0 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_2_0 = [] := by decide
example : localObservations m3_3_3_2_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_2_0 "u" "b" = [] := by decide
def m3_3_3_2_1 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_2_1 = [⟨"a","b",[("v","wait")],"held"⟩] := by decide
example : localObservations m3_3_3_2_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_2_1 "u" "b" = [] := by decide
def m3_3_3_3_0 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],[],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_3_0 = [] := by decide
example : localObservations m3_3_3_3_0 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_3_0 "u" "b" = [] := by decide
def m3_3_3_3_1 : Model := ⟨["u","v"],["a","b"],[("u","go"),("v","wait")],[("u","a","seen-u"),("v","b","seen-v")],["held"],[⟨"a","b",[("u","go"),("v","wait")],"held"⟩],⟨[],[],[]⟩⟩
example : rows m3_3_3_3_1 = [⟨"a","b",[("u","go"),("v","wait")],"held"⟩] := by decide
example : localObservations m3_3_3_3_1 "u" "a" = [("u","a","seen-u")] := by decide
example : localObservations m3_3_3_3_1 "u" "b" = [] := by decide


def cycleModel0 : Model := ⟨[],["a","b"],[],[],["held"],[],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel0 "a" [] = true := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [] = true := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel0 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel1 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel1 "a" [] = true := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [] = true := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel1 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel2 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel2 "a" [] = true := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [] = true := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel2 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel3 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel3 "a" [] = true := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [] = true := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel3 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel4 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"b","a",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel4 "a" [] = true := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [] = true := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel4 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel5 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel5 "a" [] = true := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [] = true := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel5 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel6 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel6 "a" [] = true := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel6 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [] = true := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel6 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel7 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel7 "a" [] = true := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel7 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [] = true := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel7 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide

def cycleModel8 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel8 "a" [] = true := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [] = true := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel8 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def cycleModel9 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel9 "a" [] = true := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [] = true := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel9 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def cycleModel10 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel10 "a" [] = true := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [] = true := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel10 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def cycleModel11 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel11 "a" [] = true := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [] = true := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel11 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def cycleModel12 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel12 "a" [] = true := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [] = true := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel12 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def cycleModel13 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel13 "a" [] = true := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [] = true := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel13 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def cycleModel14 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel14 "a" [] = true := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel14 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [] = true := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel14 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def cycleModel15 : Model := ⟨[],["a","b"],[],[],["held"],[⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩],⟨[],[],[]⟩⟩
example : cycleCheck cycleModel15 "a" [] = true := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel15 "a" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "a" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [] = true := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"a","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","a",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","a",[],"held"⟩,⟨"a","b",[],"held"⟩] = true := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","a",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","a",[],"held"⟩,⟨"b","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","b",[],"held"⟩,⟨"a","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","b",[],"held"⟩,⟨"a","b",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","b",[],"held"⟩,⟨"b","a",[],"held"⟩] = false := by decide
example : cycleCheck cycleModel15 "b" [⟨"b","b",[],"held"⟩,⟨"b","b",[],"held"⟩] = true := by decide

def nativeModel : Model := {cycleModel6 with communication := ⟨["a","b"],["message"],[("a","message","b")]⟩}
theorem nativeCycle : JointTrace nativeModel "a" [⟨"a","b",[],"held"⟩,⟨"b","a",[],"held"⟩] "a" :=
  (cycleMeaning _ _ _).mp (by decide)
theorem nativeCommunication : "a" ∈ nativeModel.communication.states ∧
    SFT.Computation.StateTransition.Execution nativeModel.communication "a" ["message"] ["a","b"] :=
  communicationMeaning _ _ _ _ rfl
#print axioms nativeCycle
#print axioms nativeCommunication
end SFT.Computation.MultiAgent
