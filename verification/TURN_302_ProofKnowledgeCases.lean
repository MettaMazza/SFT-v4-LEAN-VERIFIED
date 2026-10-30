import SFT.Computation.ProofKnowledge
namespace SFT.Computation.ProofKnowledge
def system : StateTransition.System := ⟨["q"],["stay"],[("q","stay","q")]⟩
def a : Transcript := ⟨"s","q",["stay"],["q","q"],"q",["stay"],["q","q"]⟩
def b : Transcript := ⟨"s","q",[],["q"],"q",[],["q"]⟩
def e0 : Extraction := ⟨a,"w0"⟩
def e1 : Extraction := ⟨b,"w1"⟩
def m0_0_0_0 : Model := ⟨["s"],[],system,system,[a,b],[],[],[]⟩
example : extractions m0_0_0_0 a = [] := by decide
example : extractions m0_0_0_0 b = [] := by decide
example : knowledge m0_0_0_0 = true := by decide
example : failures m0_0_0_0 = [] := by decide
def m0_0_0_1 : Model := ⟨["s"],[],system,system,[a,b],[],[],[a]⟩
example : extractions m0_0_0_1 a = [] := by decide
example : extractions m0_0_0_1 b = [] := by decide
example : knowledge m0_0_0_1 = true := by decide
example : failures m0_0_0_1 = [] := by decide
def m0_0_0_2 : Model := ⟨["s"],[],system,system,[a,b],[],[],[b]⟩
example : extractions m0_0_0_2 a = [] := by decide
example : extractions m0_0_0_2 b = [] := by decide
example : knowledge m0_0_0_2 = true := by decide
example : failures m0_0_0_2 = [] := by decide
def m0_0_0_3 : Model := ⟨["s"],[],system,system,[a,b],[],[],[a,b]⟩
example : extractions m0_0_0_3 a = [] := by decide
example : extractions m0_0_0_3 b = [] := by decide
example : knowledge m0_0_0_3 = true := by decide
example : failures m0_0_0_3 = [] := by decide
def m0_0_1_0 : Model := ⟨["s"],[],system,system,[a,b],[a],[],[]⟩
example : extractions m0_0_1_0 a = [] := by decide
example : extractions m0_0_1_0 b = [] := by decide
example : knowledge m0_0_1_0 = true := by decide
example : failures m0_0_1_0 = [] := by decide
def m0_0_1_1 : Model := ⟨["s"],[],system,system,[a,b],[a],[],[a]⟩
example : extractions m0_0_1_1 a = [] := by decide
example : extractions m0_0_1_1 b = [] := by decide
example : knowledge m0_0_1_1 = false := by decide
example : failures m0_0_1_1 = [a] := by decide
def m0_0_1_2 : Model := ⟨["s"],[],system,system,[a,b],[a],[],[b]⟩
example : extractions m0_0_1_2 a = [] := by decide
example : extractions m0_0_1_2 b = [] := by decide
example : knowledge m0_0_1_2 = true := by decide
example : failures m0_0_1_2 = [] := by decide
def m0_0_1_3 : Model := ⟨["s"],[],system,system,[a,b],[a],[],[a,b]⟩
example : extractions m0_0_1_3 a = [] := by decide
example : extractions m0_0_1_3 b = [] := by decide
example : knowledge m0_0_1_3 = false := by decide
example : failures m0_0_1_3 = [a] := by decide
def m0_0_2_0 : Model := ⟨["s"],[],system,system,[a,b],[b],[],[]⟩
example : extractions m0_0_2_0 a = [] := by decide
example : extractions m0_0_2_0 b = [] := by decide
example : knowledge m0_0_2_0 = true := by decide
example : failures m0_0_2_0 = [] := by decide
def m0_0_2_1 : Model := ⟨["s"],[],system,system,[a,b],[b],[],[a]⟩
example : extractions m0_0_2_1 a = [] := by decide
example : extractions m0_0_2_1 b = [] := by decide
example : knowledge m0_0_2_1 = true := by decide
example : failures m0_0_2_1 = [] := by decide
def m0_0_2_2 : Model := ⟨["s"],[],system,system,[a,b],[b],[],[b]⟩
example : extractions m0_0_2_2 a = [] := by decide
example : extractions m0_0_2_2 b = [] := by decide
example : knowledge m0_0_2_2 = false := by decide
example : failures m0_0_2_2 = [b] := by decide
def m0_0_2_3 : Model := ⟨["s"],[],system,system,[a,b],[b],[],[a,b]⟩
example : extractions m0_0_2_3 a = [] := by decide
example : extractions m0_0_2_3 b = [] := by decide
example : knowledge m0_0_2_3 = false := by decide
example : failures m0_0_2_3 = [b] := by decide
def m0_0_3_0 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[],[]⟩
example : extractions m0_0_3_0 a = [] := by decide
example : extractions m0_0_3_0 b = [] := by decide
example : knowledge m0_0_3_0 = true := by decide
example : failures m0_0_3_0 = [] := by decide
def m0_0_3_1 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[],[a]⟩
example : extractions m0_0_3_1 a = [] := by decide
example : extractions m0_0_3_1 b = [] := by decide
example : knowledge m0_0_3_1 = false := by decide
example : failures m0_0_3_1 = [a] := by decide
def m0_0_3_2 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[],[b]⟩
example : extractions m0_0_3_2 a = [] := by decide
example : extractions m0_0_3_2 b = [] := by decide
example : knowledge m0_0_3_2 = false := by decide
example : failures m0_0_3_2 = [b] := by decide
def m0_0_3_3 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[],[a,b]⟩
example : extractions m0_0_3_3 a = [] := by decide
example : extractions m0_0_3_3 b = [] := by decide
example : knowledge m0_0_3_3 = false := by decide
example : failures m0_0_3_3 = [a,b] := by decide
def m0_1_0_0 : Model := ⟨["s"],[],system,system,[a,b],[],[e0],[]⟩
example : extractions m0_1_0_0 a = [] := by decide
example : extractions m0_1_0_0 b = [] := by decide
example : knowledge m0_1_0_0 = true := by decide
example : failures m0_1_0_0 = [] := by decide
def m0_1_0_1 : Model := ⟨["s"],[],system,system,[a,b],[],[e0],[a]⟩
example : extractions m0_1_0_1 a = [] := by decide
example : extractions m0_1_0_1 b = [] := by decide
example : knowledge m0_1_0_1 = true := by decide
example : failures m0_1_0_1 = [] := by decide
def m0_1_0_2 : Model := ⟨["s"],[],system,system,[a,b],[],[e0],[b]⟩
example : extractions m0_1_0_2 a = [] := by decide
example : extractions m0_1_0_2 b = [] := by decide
example : knowledge m0_1_0_2 = true := by decide
example : failures m0_1_0_2 = [] := by decide
def m0_1_0_3 : Model := ⟨["s"],[],system,system,[a,b],[],[e0],[a,b]⟩
example : extractions m0_1_0_3 a = [] := by decide
example : extractions m0_1_0_3 b = [] := by decide
example : knowledge m0_1_0_3 = true := by decide
example : failures m0_1_0_3 = [] := by decide
def m0_1_1_0 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0],[]⟩
example : extractions m0_1_1_0 a = [] := by decide
example : extractions m0_1_1_0 b = [] := by decide
example : knowledge m0_1_1_0 = true := by decide
example : failures m0_1_1_0 = [] := by decide
def m0_1_1_1 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0],[a]⟩
example : extractions m0_1_1_1 a = [] := by decide
example : extractions m0_1_1_1 b = [] := by decide
example : knowledge m0_1_1_1 = false := by decide
example : failures m0_1_1_1 = [a] := by decide
def m0_1_1_2 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0],[b]⟩
example : extractions m0_1_1_2 a = [] := by decide
example : extractions m0_1_1_2 b = [] := by decide
example : knowledge m0_1_1_2 = true := by decide
example : failures m0_1_1_2 = [] := by decide
def m0_1_1_3 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0],[a,b]⟩
example : extractions m0_1_1_3 a = [] := by decide
example : extractions m0_1_1_3 b = [] := by decide
example : knowledge m0_1_1_3 = false := by decide
example : failures m0_1_1_3 = [a] := by decide
def m0_1_2_0 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0],[]⟩
example : extractions m0_1_2_0 a = [] := by decide
example : extractions m0_1_2_0 b = [] := by decide
example : knowledge m0_1_2_0 = true := by decide
example : failures m0_1_2_0 = [] := by decide
def m0_1_2_1 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0],[a]⟩
example : extractions m0_1_2_1 a = [] := by decide
example : extractions m0_1_2_1 b = [] := by decide
example : knowledge m0_1_2_1 = true := by decide
example : failures m0_1_2_1 = [] := by decide
def m0_1_2_2 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0],[b]⟩
example : extractions m0_1_2_2 a = [] := by decide
example : extractions m0_1_2_2 b = [] := by decide
example : knowledge m0_1_2_2 = false := by decide
example : failures m0_1_2_2 = [b] := by decide
def m0_1_2_3 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0],[a,b]⟩
example : extractions m0_1_2_3 a = [] := by decide
example : extractions m0_1_2_3 b = [] := by decide
example : knowledge m0_1_2_3 = false := by decide
example : failures m0_1_2_3 = [b] := by decide
def m0_1_3_0 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0],[]⟩
example : extractions m0_1_3_0 a = [] := by decide
example : extractions m0_1_3_0 b = [] := by decide
example : knowledge m0_1_3_0 = true := by decide
example : failures m0_1_3_0 = [] := by decide
def m0_1_3_1 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0],[a]⟩
example : extractions m0_1_3_1 a = [] := by decide
example : extractions m0_1_3_1 b = [] := by decide
example : knowledge m0_1_3_1 = false := by decide
example : failures m0_1_3_1 = [a] := by decide
def m0_1_3_2 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0],[b]⟩
example : extractions m0_1_3_2 a = [] := by decide
example : extractions m0_1_3_2 b = [] := by decide
example : knowledge m0_1_3_2 = false := by decide
example : failures m0_1_3_2 = [b] := by decide
def m0_1_3_3 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0],[a,b]⟩
example : extractions m0_1_3_3 a = [] := by decide
example : extractions m0_1_3_3 b = [] := by decide
example : knowledge m0_1_3_3 = false := by decide
example : failures m0_1_3_3 = [a,b] := by decide
def m0_2_0_0 : Model := ⟨["s"],[],system,system,[a,b],[],[e1],[]⟩
example : extractions m0_2_0_0 a = [] := by decide
example : extractions m0_2_0_0 b = [] := by decide
example : knowledge m0_2_0_0 = true := by decide
example : failures m0_2_0_0 = [] := by decide
def m0_2_0_1 : Model := ⟨["s"],[],system,system,[a,b],[],[e1],[a]⟩
example : extractions m0_2_0_1 a = [] := by decide
example : extractions m0_2_0_1 b = [] := by decide
example : knowledge m0_2_0_1 = true := by decide
example : failures m0_2_0_1 = [] := by decide
def m0_2_0_2 : Model := ⟨["s"],[],system,system,[a,b],[],[e1],[b]⟩
example : extractions m0_2_0_2 a = [] := by decide
example : extractions m0_2_0_2 b = [] := by decide
example : knowledge m0_2_0_2 = true := by decide
example : failures m0_2_0_2 = [] := by decide
def m0_2_0_3 : Model := ⟨["s"],[],system,system,[a,b],[],[e1],[a,b]⟩
example : extractions m0_2_0_3 a = [] := by decide
example : extractions m0_2_0_3 b = [] := by decide
example : knowledge m0_2_0_3 = true := by decide
example : failures m0_2_0_3 = [] := by decide
def m0_2_1_0 : Model := ⟨["s"],[],system,system,[a,b],[a],[e1],[]⟩
example : extractions m0_2_1_0 a = [] := by decide
example : extractions m0_2_1_0 b = [] := by decide
example : knowledge m0_2_1_0 = true := by decide
example : failures m0_2_1_0 = [] := by decide
def m0_2_1_1 : Model := ⟨["s"],[],system,system,[a,b],[a],[e1],[a]⟩
example : extractions m0_2_1_1 a = [] := by decide
example : extractions m0_2_1_1 b = [] := by decide
example : knowledge m0_2_1_1 = false := by decide
example : failures m0_2_1_1 = [a] := by decide
def m0_2_1_2 : Model := ⟨["s"],[],system,system,[a,b],[a],[e1],[b]⟩
example : extractions m0_2_1_2 a = [] := by decide
example : extractions m0_2_1_2 b = [] := by decide
example : knowledge m0_2_1_2 = true := by decide
example : failures m0_2_1_2 = [] := by decide
def m0_2_1_3 : Model := ⟨["s"],[],system,system,[a,b],[a],[e1],[a,b]⟩
example : extractions m0_2_1_3 a = [] := by decide
example : extractions m0_2_1_3 b = [] := by decide
example : knowledge m0_2_1_3 = false := by decide
example : failures m0_2_1_3 = [a] := by decide
def m0_2_2_0 : Model := ⟨["s"],[],system,system,[a,b],[b],[e1],[]⟩
example : extractions m0_2_2_0 a = [] := by decide
example : extractions m0_2_2_0 b = [] := by decide
example : knowledge m0_2_2_0 = true := by decide
example : failures m0_2_2_0 = [] := by decide
def m0_2_2_1 : Model := ⟨["s"],[],system,system,[a,b],[b],[e1],[a]⟩
example : extractions m0_2_2_1 a = [] := by decide
example : extractions m0_2_2_1 b = [] := by decide
example : knowledge m0_2_2_1 = true := by decide
example : failures m0_2_2_1 = [] := by decide
def m0_2_2_2 : Model := ⟨["s"],[],system,system,[a,b],[b],[e1],[b]⟩
example : extractions m0_2_2_2 a = [] := by decide
example : extractions m0_2_2_2 b = [] := by decide
example : knowledge m0_2_2_2 = false := by decide
example : failures m0_2_2_2 = [b] := by decide
def m0_2_2_3 : Model := ⟨["s"],[],system,system,[a,b],[b],[e1],[a,b]⟩
example : extractions m0_2_2_3 a = [] := by decide
example : extractions m0_2_2_3 b = [] := by decide
example : knowledge m0_2_2_3 = false := by decide
example : failures m0_2_2_3 = [b] := by decide
def m0_2_3_0 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e1],[]⟩
example : extractions m0_2_3_0 a = [] := by decide
example : extractions m0_2_3_0 b = [] := by decide
example : knowledge m0_2_3_0 = true := by decide
example : failures m0_2_3_0 = [] := by decide
def m0_2_3_1 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e1],[a]⟩
example : extractions m0_2_3_1 a = [] := by decide
example : extractions m0_2_3_1 b = [] := by decide
example : knowledge m0_2_3_1 = false := by decide
example : failures m0_2_3_1 = [a] := by decide
def m0_2_3_2 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e1],[b]⟩
example : extractions m0_2_3_2 a = [] := by decide
example : extractions m0_2_3_2 b = [] := by decide
example : knowledge m0_2_3_2 = false := by decide
example : failures m0_2_3_2 = [b] := by decide
def m0_2_3_3 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e1],[a,b]⟩
example : extractions m0_2_3_3 a = [] := by decide
example : extractions m0_2_3_3 b = [] := by decide
example : knowledge m0_2_3_3 = false := by decide
example : failures m0_2_3_3 = [a,b] := by decide
def m0_3_0_0 : Model := ⟨["s"],[],system,system,[a,b],[],[e0,e1],[]⟩
example : extractions m0_3_0_0 a = [] := by decide
example : extractions m0_3_0_0 b = [] := by decide
example : knowledge m0_3_0_0 = true := by decide
example : failures m0_3_0_0 = [] := by decide
def m0_3_0_1 : Model := ⟨["s"],[],system,system,[a,b],[],[e0,e1],[a]⟩
example : extractions m0_3_0_1 a = [] := by decide
example : extractions m0_3_0_1 b = [] := by decide
example : knowledge m0_3_0_1 = true := by decide
example : failures m0_3_0_1 = [] := by decide
def m0_3_0_2 : Model := ⟨["s"],[],system,system,[a,b],[],[e0,e1],[b]⟩
example : extractions m0_3_0_2 a = [] := by decide
example : extractions m0_3_0_2 b = [] := by decide
example : knowledge m0_3_0_2 = true := by decide
example : failures m0_3_0_2 = [] := by decide
def m0_3_0_3 : Model := ⟨["s"],[],system,system,[a,b],[],[e0,e1],[a,b]⟩
example : extractions m0_3_0_3 a = [] := by decide
example : extractions m0_3_0_3 b = [] := by decide
example : knowledge m0_3_0_3 = true := by decide
example : failures m0_3_0_3 = [] := by decide
def m0_3_1_0 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0,e1],[]⟩
example : extractions m0_3_1_0 a = [] := by decide
example : extractions m0_3_1_0 b = [] := by decide
example : knowledge m0_3_1_0 = true := by decide
example : failures m0_3_1_0 = [] := by decide
def m0_3_1_1 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0,e1],[a]⟩
example : extractions m0_3_1_1 a = [] := by decide
example : extractions m0_3_1_1 b = [] := by decide
example : knowledge m0_3_1_1 = false := by decide
example : failures m0_3_1_1 = [a] := by decide
def m0_3_1_2 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0,e1],[b]⟩
example : extractions m0_3_1_2 a = [] := by decide
example : extractions m0_3_1_2 b = [] := by decide
example : knowledge m0_3_1_2 = true := by decide
example : failures m0_3_1_2 = [] := by decide
def m0_3_1_3 : Model := ⟨["s"],[],system,system,[a,b],[a],[e0,e1],[a,b]⟩
example : extractions m0_3_1_3 a = [] := by decide
example : extractions m0_3_1_3 b = [] := by decide
example : knowledge m0_3_1_3 = false := by decide
example : failures m0_3_1_3 = [a] := by decide
def m0_3_2_0 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0,e1],[]⟩
example : extractions m0_3_2_0 a = [] := by decide
example : extractions m0_3_2_0 b = [] := by decide
example : knowledge m0_3_2_0 = true := by decide
example : failures m0_3_2_0 = [] := by decide
def m0_3_2_1 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0,e1],[a]⟩
example : extractions m0_3_2_1 a = [] := by decide
example : extractions m0_3_2_1 b = [] := by decide
example : knowledge m0_3_2_1 = true := by decide
example : failures m0_3_2_1 = [] := by decide
def m0_3_2_2 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0,e1],[b]⟩
example : extractions m0_3_2_2 a = [] := by decide
example : extractions m0_3_2_2 b = [] := by decide
example : knowledge m0_3_2_2 = false := by decide
example : failures m0_3_2_2 = [b] := by decide
def m0_3_2_3 : Model := ⟨["s"],[],system,system,[a,b],[b],[e0,e1],[a,b]⟩
example : extractions m0_3_2_3 a = [] := by decide
example : extractions m0_3_2_3 b = [] := by decide
example : knowledge m0_3_2_3 = false := by decide
example : failures m0_3_2_3 = [b] := by decide
def m0_3_3_0 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0,e1],[]⟩
example : extractions m0_3_3_0 a = [] := by decide
example : extractions m0_3_3_0 b = [] := by decide
example : knowledge m0_3_3_0 = true := by decide
example : failures m0_3_3_0 = [] := by decide
def m0_3_3_1 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0,e1],[a]⟩
example : extractions m0_3_3_1 a = [] := by decide
example : extractions m0_3_3_1 b = [] := by decide
example : knowledge m0_3_3_1 = false := by decide
example : failures m0_3_3_1 = [a] := by decide
def m0_3_3_2 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0,e1],[b]⟩
example : extractions m0_3_3_2 a = [] := by decide
example : extractions m0_3_3_2 b = [] := by decide
example : knowledge m0_3_3_2 = false := by decide
example : failures m0_3_3_2 = [b] := by decide
def m0_3_3_3 : Model := ⟨["s"],[],system,system,[a,b],[a,b],[e0,e1],[a,b]⟩
example : extractions m0_3_3_3 a = [] := by decide
example : extractions m0_3_3_3 b = [] := by decide
example : knowledge m0_3_3_3 = false := by decide
example : failures m0_3_3_3 = [a,b] := by decide
def m1_0_0_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[],[]⟩
example : extractions m1_0_0_0 a = [] := by decide
example : extractions m1_0_0_0 b = [] := by decide
example : knowledge m1_0_0_0 = true := by decide
example : failures m1_0_0_0 = [] := by decide
def m1_0_0_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[],[a]⟩
example : extractions m1_0_0_1 a = [] := by decide
example : extractions m1_0_0_1 b = [] := by decide
example : knowledge m1_0_0_1 = true := by decide
example : failures m1_0_0_1 = [] := by decide
def m1_0_0_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[],[b]⟩
example : extractions m1_0_0_2 a = [] := by decide
example : extractions m1_0_0_2 b = [] := by decide
example : knowledge m1_0_0_2 = true := by decide
example : failures m1_0_0_2 = [] := by decide
def m1_0_0_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[],[a,b]⟩
example : extractions m1_0_0_3 a = [] := by decide
example : extractions m1_0_0_3 b = [] := by decide
example : knowledge m1_0_0_3 = true := by decide
example : failures m1_0_0_3 = [] := by decide
def m1_0_1_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[],[]⟩
example : extractions m1_0_1_0 a = [] := by decide
example : extractions m1_0_1_0 b = [] := by decide
example : knowledge m1_0_1_0 = true := by decide
example : failures m1_0_1_0 = [] := by decide
def m1_0_1_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[],[a]⟩
example : extractions m1_0_1_1 a = [] := by decide
example : extractions m1_0_1_1 b = [] := by decide
example : knowledge m1_0_1_1 = false := by decide
example : failures m1_0_1_1 = [a] := by decide
def m1_0_1_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[],[b]⟩
example : extractions m1_0_1_2 a = [] := by decide
example : extractions m1_0_1_2 b = [] := by decide
example : knowledge m1_0_1_2 = true := by decide
example : failures m1_0_1_2 = [] := by decide
def m1_0_1_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[],[a,b]⟩
example : extractions m1_0_1_3 a = [] := by decide
example : extractions m1_0_1_3 b = [] := by decide
example : knowledge m1_0_1_3 = false := by decide
example : failures m1_0_1_3 = [a] := by decide
def m1_0_2_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[],[]⟩
example : extractions m1_0_2_0 a = [] := by decide
example : extractions m1_0_2_0 b = [] := by decide
example : knowledge m1_0_2_0 = true := by decide
example : failures m1_0_2_0 = [] := by decide
def m1_0_2_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[],[a]⟩
example : extractions m1_0_2_1 a = [] := by decide
example : extractions m1_0_2_1 b = [] := by decide
example : knowledge m1_0_2_1 = true := by decide
example : failures m1_0_2_1 = [] := by decide
def m1_0_2_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[],[b]⟩
example : extractions m1_0_2_2 a = [] := by decide
example : extractions m1_0_2_2 b = [] := by decide
example : knowledge m1_0_2_2 = false := by decide
example : failures m1_0_2_2 = [b] := by decide
def m1_0_2_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[],[a,b]⟩
example : extractions m1_0_2_3 a = [] := by decide
example : extractions m1_0_2_3 b = [] := by decide
example : knowledge m1_0_2_3 = false := by decide
example : failures m1_0_2_3 = [b] := by decide
def m1_0_3_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[],[]⟩
example : extractions m1_0_3_0 a = [] := by decide
example : extractions m1_0_3_0 b = [] := by decide
example : knowledge m1_0_3_0 = true := by decide
example : failures m1_0_3_0 = [] := by decide
def m1_0_3_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[],[a]⟩
example : extractions m1_0_3_1 a = [] := by decide
example : extractions m1_0_3_1 b = [] := by decide
example : knowledge m1_0_3_1 = false := by decide
example : failures m1_0_3_1 = [a] := by decide
def m1_0_3_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[],[b]⟩
example : extractions m1_0_3_2 a = [] := by decide
example : extractions m1_0_3_2 b = [] := by decide
example : knowledge m1_0_3_2 = false := by decide
example : failures m1_0_3_2 = [b] := by decide
def m1_0_3_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[],[a,b]⟩
example : extractions m1_0_3_3 a = [] := by decide
example : extractions m1_0_3_3 b = [] := by decide
example : knowledge m1_0_3_3 = false := by decide
example : failures m1_0_3_3 = [a,b] := by decide
def m1_1_0_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0],[]⟩
example : extractions m1_1_0_0 a = [e0] := by decide
example : extractions m1_1_0_0 b = [] := by decide
example : knowledge m1_1_0_0 = true := by decide
example : failures m1_1_0_0 = [] := by decide
def m1_1_0_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0],[a]⟩
example : extractions m1_1_0_1 a = [e0] := by decide
example : extractions m1_1_0_1 b = [] := by decide
example : knowledge m1_1_0_1 = true := by decide
example : failures m1_1_0_1 = [] := by decide
def m1_1_0_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0],[b]⟩
example : extractions m1_1_0_2 a = [e0] := by decide
example : extractions m1_1_0_2 b = [] := by decide
example : knowledge m1_1_0_2 = true := by decide
example : failures m1_1_0_2 = [] := by decide
def m1_1_0_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0],[a,b]⟩
example : extractions m1_1_0_3 a = [e0] := by decide
example : extractions m1_1_0_3 b = [] := by decide
example : knowledge m1_1_0_3 = true := by decide
example : failures m1_1_0_3 = [] := by decide
def m1_1_1_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0],[]⟩
example : extractions m1_1_1_0 a = [e0] := by decide
example : extractions m1_1_1_0 b = [] := by decide
example : knowledge m1_1_1_0 = true := by decide
example : failures m1_1_1_0 = [] := by decide
def m1_1_1_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0],[a]⟩
example : extractions m1_1_1_1 a = [e0] := by decide
example : extractions m1_1_1_1 b = [] := by decide
example : knowledge m1_1_1_1 = true := by decide
example : failures m1_1_1_1 = [] := by decide
def m1_1_1_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0],[b]⟩
example : extractions m1_1_1_2 a = [e0] := by decide
example : extractions m1_1_1_2 b = [] := by decide
example : knowledge m1_1_1_2 = true := by decide
example : failures m1_1_1_2 = [] := by decide
def m1_1_1_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0],[a,b]⟩
example : extractions m1_1_1_3 a = [e0] := by decide
example : extractions m1_1_1_3 b = [] := by decide
example : knowledge m1_1_1_3 = true := by decide
example : failures m1_1_1_3 = [] := by decide
def m1_1_2_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0],[]⟩
example : extractions m1_1_2_0 a = [e0] := by decide
example : extractions m1_1_2_0 b = [] := by decide
example : knowledge m1_1_2_0 = true := by decide
example : failures m1_1_2_0 = [] := by decide
def m1_1_2_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0],[a]⟩
example : extractions m1_1_2_1 a = [e0] := by decide
example : extractions m1_1_2_1 b = [] := by decide
example : knowledge m1_1_2_1 = true := by decide
example : failures m1_1_2_1 = [] := by decide
def m1_1_2_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0],[b]⟩
example : extractions m1_1_2_2 a = [e0] := by decide
example : extractions m1_1_2_2 b = [] := by decide
example : knowledge m1_1_2_2 = false := by decide
example : failures m1_1_2_2 = [b] := by decide
def m1_1_2_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0],[a,b]⟩
example : extractions m1_1_2_3 a = [e0] := by decide
example : extractions m1_1_2_3 b = [] := by decide
example : knowledge m1_1_2_3 = false := by decide
example : failures m1_1_2_3 = [b] := by decide
def m1_1_3_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0],[]⟩
example : extractions m1_1_3_0 a = [e0] := by decide
example : extractions m1_1_3_0 b = [] := by decide
example : knowledge m1_1_3_0 = true := by decide
example : failures m1_1_3_0 = [] := by decide
def m1_1_3_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0],[a]⟩
example : extractions m1_1_3_1 a = [e0] := by decide
example : extractions m1_1_3_1 b = [] := by decide
example : knowledge m1_1_3_1 = true := by decide
example : failures m1_1_3_1 = [] := by decide
def m1_1_3_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0],[b]⟩
example : extractions m1_1_3_2 a = [e0] := by decide
example : extractions m1_1_3_2 b = [] := by decide
example : knowledge m1_1_3_2 = false := by decide
example : failures m1_1_3_2 = [b] := by decide
def m1_1_3_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0],[a,b]⟩
example : extractions m1_1_3_3 a = [e0] := by decide
example : extractions m1_1_3_3 b = [] := by decide
example : knowledge m1_1_3_3 = false := by decide
example : failures m1_1_3_3 = [b] := by decide
def m1_2_0_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e1],[]⟩
example : extractions m1_2_0_0 a = [] := by decide
example : extractions m1_2_0_0 b = [] := by decide
example : knowledge m1_2_0_0 = true := by decide
example : failures m1_2_0_0 = [] := by decide
def m1_2_0_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e1],[a]⟩
example : extractions m1_2_0_1 a = [] := by decide
example : extractions m1_2_0_1 b = [] := by decide
example : knowledge m1_2_0_1 = true := by decide
example : failures m1_2_0_1 = [] := by decide
def m1_2_0_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e1],[b]⟩
example : extractions m1_2_0_2 a = [] := by decide
example : extractions m1_2_0_2 b = [] := by decide
example : knowledge m1_2_0_2 = true := by decide
example : failures m1_2_0_2 = [] := by decide
def m1_2_0_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e1],[a,b]⟩
example : extractions m1_2_0_3 a = [] := by decide
example : extractions m1_2_0_3 b = [] := by decide
example : knowledge m1_2_0_3 = true := by decide
example : failures m1_2_0_3 = [] := by decide
def m1_2_1_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e1],[]⟩
example : extractions m1_2_1_0 a = [] := by decide
example : extractions m1_2_1_0 b = [] := by decide
example : knowledge m1_2_1_0 = true := by decide
example : failures m1_2_1_0 = [] := by decide
def m1_2_1_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e1],[a]⟩
example : extractions m1_2_1_1 a = [] := by decide
example : extractions m1_2_1_1 b = [] := by decide
example : knowledge m1_2_1_1 = false := by decide
example : failures m1_2_1_1 = [a] := by decide
def m1_2_1_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e1],[b]⟩
example : extractions m1_2_1_2 a = [] := by decide
example : extractions m1_2_1_2 b = [] := by decide
example : knowledge m1_2_1_2 = true := by decide
example : failures m1_2_1_2 = [] := by decide
def m1_2_1_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e1],[a,b]⟩
example : extractions m1_2_1_3 a = [] := by decide
example : extractions m1_2_1_3 b = [] := by decide
example : knowledge m1_2_1_3 = false := by decide
example : failures m1_2_1_3 = [a] := by decide
def m1_2_2_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e1],[]⟩
example : extractions m1_2_2_0 a = [] := by decide
example : extractions m1_2_2_0 b = [] := by decide
example : knowledge m1_2_2_0 = true := by decide
example : failures m1_2_2_0 = [] := by decide
def m1_2_2_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e1],[a]⟩
example : extractions m1_2_2_1 a = [] := by decide
example : extractions m1_2_2_1 b = [] := by decide
example : knowledge m1_2_2_1 = true := by decide
example : failures m1_2_2_1 = [] := by decide
def m1_2_2_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e1],[b]⟩
example : extractions m1_2_2_2 a = [] := by decide
example : extractions m1_2_2_2 b = [] := by decide
example : knowledge m1_2_2_2 = false := by decide
example : failures m1_2_2_2 = [b] := by decide
def m1_2_2_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e1],[a,b]⟩
example : extractions m1_2_2_3 a = [] := by decide
example : extractions m1_2_2_3 b = [] := by decide
example : knowledge m1_2_2_3 = false := by decide
example : failures m1_2_2_3 = [b] := by decide
def m1_2_3_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e1],[]⟩
example : extractions m1_2_3_0 a = [] := by decide
example : extractions m1_2_3_0 b = [] := by decide
example : knowledge m1_2_3_0 = true := by decide
example : failures m1_2_3_0 = [] := by decide
def m1_2_3_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e1],[a]⟩
example : extractions m1_2_3_1 a = [] := by decide
example : extractions m1_2_3_1 b = [] := by decide
example : knowledge m1_2_3_1 = false := by decide
example : failures m1_2_3_1 = [a] := by decide
def m1_2_3_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e1],[b]⟩
example : extractions m1_2_3_2 a = [] := by decide
example : extractions m1_2_3_2 b = [] := by decide
example : knowledge m1_2_3_2 = false := by decide
example : failures m1_2_3_2 = [b] := by decide
def m1_2_3_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e1],[a,b]⟩
example : extractions m1_2_3_3 a = [] := by decide
example : extractions m1_2_3_3 b = [] := by decide
example : knowledge m1_2_3_3 = false := by decide
example : failures m1_2_3_3 = [a,b] := by decide
def m1_3_0_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0,e1],[]⟩
example : extractions m1_3_0_0 a = [e0] := by decide
example : extractions m1_3_0_0 b = [] := by decide
example : knowledge m1_3_0_0 = true := by decide
example : failures m1_3_0_0 = [] := by decide
def m1_3_0_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0,e1],[a]⟩
example : extractions m1_3_0_1 a = [e0] := by decide
example : extractions m1_3_0_1 b = [] := by decide
example : knowledge m1_3_0_1 = true := by decide
example : failures m1_3_0_1 = [] := by decide
def m1_3_0_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0,e1],[b]⟩
example : extractions m1_3_0_2 a = [e0] := by decide
example : extractions m1_3_0_2 b = [] := by decide
example : knowledge m1_3_0_2 = true := by decide
example : failures m1_3_0_2 = [] := by decide
def m1_3_0_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[],[e0,e1],[a,b]⟩
example : extractions m1_3_0_3 a = [e0] := by decide
example : extractions m1_3_0_3 b = [] := by decide
example : knowledge m1_3_0_3 = true := by decide
example : failures m1_3_0_3 = [] := by decide
def m1_3_1_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0,e1],[]⟩
example : extractions m1_3_1_0 a = [e0] := by decide
example : extractions m1_3_1_0 b = [] := by decide
example : knowledge m1_3_1_0 = true := by decide
example : failures m1_3_1_0 = [] := by decide
def m1_3_1_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0,e1],[a]⟩
example : extractions m1_3_1_1 a = [e0] := by decide
example : extractions m1_3_1_1 b = [] := by decide
example : knowledge m1_3_1_1 = true := by decide
example : failures m1_3_1_1 = [] := by decide
def m1_3_1_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0,e1],[b]⟩
example : extractions m1_3_1_2 a = [e0] := by decide
example : extractions m1_3_1_2 b = [] := by decide
example : knowledge m1_3_1_2 = true := by decide
example : failures m1_3_1_2 = [] := by decide
def m1_3_1_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a],[e0,e1],[a,b]⟩
example : extractions m1_3_1_3 a = [e0] := by decide
example : extractions m1_3_1_3 b = [] := by decide
example : knowledge m1_3_1_3 = true := by decide
example : failures m1_3_1_3 = [] := by decide
def m1_3_2_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0,e1],[]⟩
example : extractions m1_3_2_0 a = [e0] := by decide
example : extractions m1_3_2_0 b = [] := by decide
example : knowledge m1_3_2_0 = true := by decide
example : failures m1_3_2_0 = [] := by decide
def m1_3_2_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0,e1],[a]⟩
example : extractions m1_3_2_1 a = [e0] := by decide
example : extractions m1_3_2_1 b = [] := by decide
example : knowledge m1_3_2_1 = true := by decide
example : failures m1_3_2_1 = [] := by decide
def m1_3_2_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0,e1],[b]⟩
example : extractions m1_3_2_2 a = [e0] := by decide
example : extractions m1_3_2_2 b = [] := by decide
example : knowledge m1_3_2_2 = false := by decide
example : failures m1_3_2_2 = [b] := by decide
def m1_3_2_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[b],[e0,e1],[a,b]⟩
example : extractions m1_3_2_3 a = [e0] := by decide
example : extractions m1_3_2_3 b = [] := by decide
example : knowledge m1_3_2_3 = false := by decide
example : failures m1_3_2_3 = [b] := by decide
def m1_3_3_0 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0,e1],[]⟩
example : extractions m1_3_3_0 a = [e0] := by decide
example : extractions m1_3_3_0 b = [] := by decide
example : knowledge m1_3_3_0 = true := by decide
example : failures m1_3_3_0 = [] := by decide
def m1_3_3_1 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0,e1],[a]⟩
example : extractions m1_3_3_1 a = [e0] := by decide
example : extractions m1_3_3_1 b = [] := by decide
example : knowledge m1_3_3_1 = true := by decide
example : failures m1_3_3_1 = [] := by decide
def m1_3_3_2 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0,e1],[b]⟩
example : extractions m1_3_3_2 a = [e0] := by decide
example : extractions m1_3_3_2 b = [] := by decide
example : knowledge m1_3_3_2 = false := by decide
example : failures m1_3_3_2 = [b] := by decide
def m1_3_3_3 : Model := ⟨["s"],[("s","w0")],system,system,[a,b],[a,b],[e0,e1],[a,b]⟩
example : extractions m1_3_3_3 a = [e0] := by decide
example : extractions m1_3_3_3 b = [] := by decide
example : knowledge m1_3_3_3 = false := by decide
example : failures m1_3_3_3 = [b] := by decide
def m2_0_0_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[],[]⟩
example : extractions m2_0_0_0 a = [] := by decide
example : extractions m2_0_0_0 b = [] := by decide
example : knowledge m2_0_0_0 = true := by decide
example : failures m2_0_0_0 = [] := by decide
def m2_0_0_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[],[a]⟩
example : extractions m2_0_0_1 a = [] := by decide
example : extractions m2_0_0_1 b = [] := by decide
example : knowledge m2_0_0_1 = true := by decide
example : failures m2_0_0_1 = [] := by decide
def m2_0_0_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[],[b]⟩
example : extractions m2_0_0_2 a = [] := by decide
example : extractions m2_0_0_2 b = [] := by decide
example : knowledge m2_0_0_2 = true := by decide
example : failures m2_0_0_2 = [] := by decide
def m2_0_0_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[],[a,b]⟩
example : extractions m2_0_0_3 a = [] := by decide
example : extractions m2_0_0_3 b = [] := by decide
example : knowledge m2_0_0_3 = true := by decide
example : failures m2_0_0_3 = [] := by decide
def m2_0_1_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[],[]⟩
example : extractions m2_0_1_0 a = [] := by decide
example : extractions m2_0_1_0 b = [] := by decide
example : knowledge m2_0_1_0 = true := by decide
example : failures m2_0_1_0 = [] := by decide
def m2_0_1_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[],[a]⟩
example : extractions m2_0_1_1 a = [] := by decide
example : extractions m2_0_1_1 b = [] := by decide
example : knowledge m2_0_1_1 = false := by decide
example : failures m2_0_1_1 = [a] := by decide
def m2_0_1_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[],[b]⟩
example : extractions m2_0_1_2 a = [] := by decide
example : extractions m2_0_1_2 b = [] := by decide
example : knowledge m2_0_1_2 = true := by decide
example : failures m2_0_1_2 = [] := by decide
def m2_0_1_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[],[a,b]⟩
example : extractions m2_0_1_3 a = [] := by decide
example : extractions m2_0_1_3 b = [] := by decide
example : knowledge m2_0_1_3 = false := by decide
example : failures m2_0_1_3 = [a] := by decide
def m2_0_2_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[],[]⟩
example : extractions m2_0_2_0 a = [] := by decide
example : extractions m2_0_2_0 b = [] := by decide
example : knowledge m2_0_2_0 = true := by decide
example : failures m2_0_2_0 = [] := by decide
def m2_0_2_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[],[a]⟩
example : extractions m2_0_2_1 a = [] := by decide
example : extractions m2_0_2_1 b = [] := by decide
example : knowledge m2_0_2_1 = true := by decide
example : failures m2_0_2_1 = [] := by decide
def m2_0_2_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[],[b]⟩
example : extractions m2_0_2_2 a = [] := by decide
example : extractions m2_0_2_2 b = [] := by decide
example : knowledge m2_0_2_2 = false := by decide
example : failures m2_0_2_2 = [b] := by decide
def m2_0_2_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[],[a,b]⟩
example : extractions m2_0_2_3 a = [] := by decide
example : extractions m2_0_2_3 b = [] := by decide
example : knowledge m2_0_2_3 = false := by decide
example : failures m2_0_2_3 = [b] := by decide
def m2_0_3_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[],[]⟩
example : extractions m2_0_3_0 a = [] := by decide
example : extractions m2_0_3_0 b = [] := by decide
example : knowledge m2_0_3_0 = true := by decide
example : failures m2_0_3_0 = [] := by decide
def m2_0_3_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[],[a]⟩
example : extractions m2_0_3_1 a = [] := by decide
example : extractions m2_0_3_1 b = [] := by decide
example : knowledge m2_0_3_1 = false := by decide
example : failures m2_0_3_1 = [a] := by decide
def m2_0_3_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[],[b]⟩
example : extractions m2_0_3_2 a = [] := by decide
example : extractions m2_0_3_2 b = [] := by decide
example : knowledge m2_0_3_2 = false := by decide
example : failures m2_0_3_2 = [b] := by decide
def m2_0_3_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[],[a,b]⟩
example : extractions m2_0_3_3 a = [] := by decide
example : extractions m2_0_3_3 b = [] := by decide
example : knowledge m2_0_3_3 = false := by decide
example : failures m2_0_3_3 = [a,b] := by decide
def m2_1_0_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0],[]⟩
example : extractions m2_1_0_0 a = [] := by decide
example : extractions m2_1_0_0 b = [] := by decide
example : knowledge m2_1_0_0 = true := by decide
example : failures m2_1_0_0 = [] := by decide
def m2_1_0_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0],[a]⟩
example : extractions m2_1_0_1 a = [] := by decide
example : extractions m2_1_0_1 b = [] := by decide
example : knowledge m2_1_0_1 = true := by decide
example : failures m2_1_0_1 = [] := by decide
def m2_1_0_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0],[b]⟩
example : extractions m2_1_0_2 a = [] := by decide
example : extractions m2_1_0_2 b = [] := by decide
example : knowledge m2_1_0_2 = true := by decide
example : failures m2_1_0_2 = [] := by decide
def m2_1_0_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0],[a,b]⟩
example : extractions m2_1_0_3 a = [] := by decide
example : extractions m2_1_0_3 b = [] := by decide
example : knowledge m2_1_0_3 = true := by decide
example : failures m2_1_0_3 = [] := by decide
def m2_1_1_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0],[]⟩
example : extractions m2_1_1_0 a = [] := by decide
example : extractions m2_1_1_0 b = [] := by decide
example : knowledge m2_1_1_0 = true := by decide
example : failures m2_1_1_0 = [] := by decide
def m2_1_1_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0],[a]⟩
example : extractions m2_1_1_1 a = [] := by decide
example : extractions m2_1_1_1 b = [] := by decide
example : knowledge m2_1_1_1 = false := by decide
example : failures m2_1_1_1 = [a] := by decide
def m2_1_1_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0],[b]⟩
example : extractions m2_1_1_2 a = [] := by decide
example : extractions m2_1_1_2 b = [] := by decide
example : knowledge m2_1_1_2 = true := by decide
example : failures m2_1_1_2 = [] := by decide
def m2_1_1_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0],[a,b]⟩
example : extractions m2_1_1_3 a = [] := by decide
example : extractions m2_1_1_3 b = [] := by decide
example : knowledge m2_1_1_3 = false := by decide
example : failures m2_1_1_3 = [a] := by decide
def m2_1_2_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0],[]⟩
example : extractions m2_1_2_0 a = [] := by decide
example : extractions m2_1_2_0 b = [] := by decide
example : knowledge m2_1_2_0 = true := by decide
example : failures m2_1_2_0 = [] := by decide
def m2_1_2_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0],[a]⟩
example : extractions m2_1_2_1 a = [] := by decide
example : extractions m2_1_2_1 b = [] := by decide
example : knowledge m2_1_2_1 = true := by decide
example : failures m2_1_2_1 = [] := by decide
def m2_1_2_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0],[b]⟩
example : extractions m2_1_2_2 a = [] := by decide
example : extractions m2_1_2_2 b = [] := by decide
example : knowledge m2_1_2_2 = false := by decide
example : failures m2_1_2_2 = [b] := by decide
def m2_1_2_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0],[a,b]⟩
example : extractions m2_1_2_3 a = [] := by decide
example : extractions m2_1_2_3 b = [] := by decide
example : knowledge m2_1_2_3 = false := by decide
example : failures m2_1_2_3 = [b] := by decide
def m2_1_3_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0],[]⟩
example : extractions m2_1_3_0 a = [] := by decide
example : extractions m2_1_3_0 b = [] := by decide
example : knowledge m2_1_3_0 = true := by decide
example : failures m2_1_3_0 = [] := by decide
def m2_1_3_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0],[a]⟩
example : extractions m2_1_3_1 a = [] := by decide
example : extractions m2_1_3_1 b = [] := by decide
example : knowledge m2_1_3_1 = false := by decide
example : failures m2_1_3_1 = [a] := by decide
def m2_1_3_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0],[b]⟩
example : extractions m2_1_3_2 a = [] := by decide
example : extractions m2_1_3_2 b = [] := by decide
example : knowledge m2_1_3_2 = false := by decide
example : failures m2_1_3_2 = [b] := by decide
def m2_1_3_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0],[a,b]⟩
example : extractions m2_1_3_3 a = [] := by decide
example : extractions m2_1_3_3 b = [] := by decide
example : knowledge m2_1_3_3 = false := by decide
example : failures m2_1_3_3 = [a,b] := by decide
def m2_2_0_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e1],[]⟩
example : extractions m2_2_0_0 a = [] := by decide
example : extractions m2_2_0_0 b = [e1] := by decide
example : knowledge m2_2_0_0 = true := by decide
example : failures m2_2_0_0 = [] := by decide
def m2_2_0_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e1],[a]⟩
example : extractions m2_2_0_1 a = [] := by decide
example : extractions m2_2_0_1 b = [e1] := by decide
example : knowledge m2_2_0_1 = true := by decide
example : failures m2_2_0_1 = [] := by decide
def m2_2_0_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e1],[b]⟩
example : extractions m2_2_0_2 a = [] := by decide
example : extractions m2_2_0_2 b = [e1] := by decide
example : knowledge m2_2_0_2 = true := by decide
example : failures m2_2_0_2 = [] := by decide
def m2_2_0_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e1],[a,b]⟩
example : extractions m2_2_0_3 a = [] := by decide
example : extractions m2_2_0_3 b = [e1] := by decide
example : knowledge m2_2_0_3 = true := by decide
example : failures m2_2_0_3 = [] := by decide
def m2_2_1_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e1],[]⟩
example : extractions m2_2_1_0 a = [] := by decide
example : extractions m2_2_1_0 b = [e1] := by decide
example : knowledge m2_2_1_0 = true := by decide
example : failures m2_2_1_0 = [] := by decide
def m2_2_1_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e1],[a]⟩
example : extractions m2_2_1_1 a = [] := by decide
example : extractions m2_2_1_1 b = [e1] := by decide
example : knowledge m2_2_1_1 = false := by decide
example : failures m2_2_1_1 = [a] := by decide
def m2_2_1_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e1],[b]⟩
example : extractions m2_2_1_2 a = [] := by decide
example : extractions m2_2_1_2 b = [e1] := by decide
example : knowledge m2_2_1_2 = true := by decide
example : failures m2_2_1_2 = [] := by decide
def m2_2_1_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e1],[a,b]⟩
example : extractions m2_2_1_3 a = [] := by decide
example : extractions m2_2_1_3 b = [e1] := by decide
example : knowledge m2_2_1_3 = false := by decide
example : failures m2_2_1_3 = [a] := by decide
def m2_2_2_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e1],[]⟩
example : extractions m2_2_2_0 a = [] := by decide
example : extractions m2_2_2_0 b = [e1] := by decide
example : knowledge m2_2_2_0 = true := by decide
example : failures m2_2_2_0 = [] := by decide
def m2_2_2_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e1],[a]⟩
example : extractions m2_2_2_1 a = [] := by decide
example : extractions m2_2_2_1 b = [e1] := by decide
example : knowledge m2_2_2_1 = true := by decide
example : failures m2_2_2_1 = [] := by decide
def m2_2_2_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e1],[b]⟩
example : extractions m2_2_2_2 a = [] := by decide
example : extractions m2_2_2_2 b = [e1] := by decide
example : knowledge m2_2_2_2 = true := by decide
example : failures m2_2_2_2 = [] := by decide
def m2_2_2_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e1],[a,b]⟩
example : extractions m2_2_2_3 a = [] := by decide
example : extractions m2_2_2_3 b = [e1] := by decide
example : knowledge m2_2_2_3 = true := by decide
example : failures m2_2_2_3 = [] := by decide
def m2_2_3_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e1],[]⟩
example : extractions m2_2_3_0 a = [] := by decide
example : extractions m2_2_3_0 b = [e1] := by decide
example : knowledge m2_2_3_0 = true := by decide
example : failures m2_2_3_0 = [] := by decide
def m2_2_3_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e1],[a]⟩
example : extractions m2_2_3_1 a = [] := by decide
example : extractions m2_2_3_1 b = [e1] := by decide
example : knowledge m2_2_3_1 = false := by decide
example : failures m2_2_3_1 = [a] := by decide
def m2_2_3_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e1],[b]⟩
example : extractions m2_2_3_2 a = [] := by decide
example : extractions m2_2_3_2 b = [e1] := by decide
example : knowledge m2_2_3_2 = true := by decide
example : failures m2_2_3_2 = [] := by decide
def m2_2_3_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e1],[a,b]⟩
example : extractions m2_2_3_3 a = [] := by decide
example : extractions m2_2_3_3 b = [e1] := by decide
example : knowledge m2_2_3_3 = false := by decide
example : failures m2_2_3_3 = [a] := by decide
def m2_3_0_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0,e1],[]⟩
example : extractions m2_3_0_0 a = [] := by decide
example : extractions m2_3_0_0 b = [e1] := by decide
example : knowledge m2_3_0_0 = true := by decide
example : failures m2_3_0_0 = [] := by decide
def m2_3_0_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0,e1],[a]⟩
example : extractions m2_3_0_1 a = [] := by decide
example : extractions m2_3_0_1 b = [e1] := by decide
example : knowledge m2_3_0_1 = true := by decide
example : failures m2_3_0_1 = [] := by decide
def m2_3_0_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0,e1],[b]⟩
example : extractions m2_3_0_2 a = [] := by decide
example : extractions m2_3_0_2 b = [e1] := by decide
example : knowledge m2_3_0_2 = true := by decide
example : failures m2_3_0_2 = [] := by decide
def m2_3_0_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[],[e0,e1],[a,b]⟩
example : extractions m2_3_0_3 a = [] := by decide
example : extractions m2_3_0_3 b = [e1] := by decide
example : knowledge m2_3_0_3 = true := by decide
example : failures m2_3_0_3 = [] := by decide
def m2_3_1_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0,e1],[]⟩
example : extractions m2_3_1_0 a = [] := by decide
example : extractions m2_3_1_0 b = [e1] := by decide
example : knowledge m2_3_1_0 = true := by decide
example : failures m2_3_1_0 = [] := by decide
def m2_3_1_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0,e1],[a]⟩
example : extractions m2_3_1_1 a = [] := by decide
example : extractions m2_3_1_1 b = [e1] := by decide
example : knowledge m2_3_1_1 = false := by decide
example : failures m2_3_1_1 = [a] := by decide
def m2_3_1_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0,e1],[b]⟩
example : extractions m2_3_1_2 a = [] := by decide
example : extractions m2_3_1_2 b = [e1] := by decide
example : knowledge m2_3_1_2 = true := by decide
example : failures m2_3_1_2 = [] := by decide
def m2_3_1_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a],[e0,e1],[a,b]⟩
example : extractions m2_3_1_3 a = [] := by decide
example : extractions m2_3_1_3 b = [e1] := by decide
example : knowledge m2_3_1_3 = false := by decide
example : failures m2_3_1_3 = [a] := by decide
def m2_3_2_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0,e1],[]⟩
example : extractions m2_3_2_0 a = [] := by decide
example : extractions m2_3_2_0 b = [e1] := by decide
example : knowledge m2_3_2_0 = true := by decide
example : failures m2_3_2_0 = [] := by decide
def m2_3_2_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0,e1],[a]⟩
example : extractions m2_3_2_1 a = [] := by decide
example : extractions m2_3_2_1 b = [e1] := by decide
example : knowledge m2_3_2_1 = true := by decide
example : failures m2_3_2_1 = [] := by decide
def m2_3_2_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0,e1],[b]⟩
example : extractions m2_3_2_2 a = [] := by decide
example : extractions m2_3_2_2 b = [e1] := by decide
example : knowledge m2_3_2_2 = true := by decide
example : failures m2_3_2_2 = [] := by decide
def m2_3_2_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[b],[e0,e1],[a,b]⟩
example : extractions m2_3_2_3 a = [] := by decide
example : extractions m2_3_2_3 b = [e1] := by decide
example : knowledge m2_3_2_3 = true := by decide
example : failures m2_3_2_3 = [] := by decide
def m2_3_3_0 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0,e1],[]⟩
example : extractions m2_3_3_0 a = [] := by decide
example : extractions m2_3_3_0 b = [e1] := by decide
example : knowledge m2_3_3_0 = true := by decide
example : failures m2_3_3_0 = [] := by decide
def m2_3_3_1 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0,e1],[a]⟩
example : extractions m2_3_3_1 a = [] := by decide
example : extractions m2_3_3_1 b = [e1] := by decide
example : knowledge m2_3_3_1 = false := by decide
example : failures m2_3_3_1 = [a] := by decide
def m2_3_3_2 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0,e1],[b]⟩
example : extractions m2_3_3_2 a = [] := by decide
example : extractions m2_3_3_2 b = [e1] := by decide
example : knowledge m2_3_3_2 = true := by decide
example : failures m2_3_3_2 = [] := by decide
def m2_3_3_3 : Model := ⟨["s"],[("s","w1")],system,system,[a,b],[a,b],[e0,e1],[a,b]⟩
example : extractions m2_3_3_3 a = [] := by decide
example : extractions m2_3_3_3 b = [e1] := by decide
example : knowledge m2_3_3_3 = false := by decide
example : failures m2_3_3_3 = [a] := by decide
def m3_0_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[],[]⟩
example : extractions m3_0_0_0 a = [] := by decide
example : extractions m3_0_0_0 b = [] := by decide
example : knowledge m3_0_0_0 = true := by decide
example : failures m3_0_0_0 = [] := by decide
def m3_0_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[],[a]⟩
example : extractions m3_0_0_1 a = [] := by decide
example : extractions m3_0_0_1 b = [] := by decide
example : knowledge m3_0_0_1 = true := by decide
example : failures m3_0_0_1 = [] := by decide
def m3_0_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[],[b]⟩
example : extractions m3_0_0_2 a = [] := by decide
example : extractions m3_0_0_2 b = [] := by decide
example : knowledge m3_0_0_2 = true := by decide
example : failures m3_0_0_2 = [] := by decide
def m3_0_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[],[a,b]⟩
example : extractions m3_0_0_3 a = [] := by decide
example : extractions m3_0_0_3 b = [] := by decide
example : knowledge m3_0_0_3 = true := by decide
example : failures m3_0_0_3 = [] := by decide
def m3_0_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[],[]⟩
example : extractions m3_0_1_0 a = [] := by decide
example : extractions m3_0_1_0 b = [] := by decide
example : knowledge m3_0_1_0 = true := by decide
example : failures m3_0_1_0 = [] := by decide
def m3_0_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[],[a]⟩
example : extractions m3_0_1_1 a = [] := by decide
example : extractions m3_0_1_1 b = [] := by decide
example : knowledge m3_0_1_1 = false := by decide
example : failures m3_0_1_1 = [a] := by decide
def m3_0_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[],[b]⟩
example : extractions m3_0_1_2 a = [] := by decide
example : extractions m3_0_1_2 b = [] := by decide
example : knowledge m3_0_1_2 = true := by decide
example : failures m3_0_1_2 = [] := by decide
def m3_0_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[],[a,b]⟩
example : extractions m3_0_1_3 a = [] := by decide
example : extractions m3_0_1_3 b = [] := by decide
example : knowledge m3_0_1_3 = false := by decide
example : failures m3_0_1_3 = [a] := by decide
def m3_0_2_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[],[]⟩
example : extractions m3_0_2_0 a = [] := by decide
example : extractions m3_0_2_0 b = [] := by decide
example : knowledge m3_0_2_0 = true := by decide
example : failures m3_0_2_0 = [] := by decide
def m3_0_2_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[],[a]⟩
example : extractions m3_0_2_1 a = [] := by decide
example : extractions m3_0_2_1 b = [] := by decide
example : knowledge m3_0_2_1 = true := by decide
example : failures m3_0_2_1 = [] := by decide
def m3_0_2_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[],[b]⟩
example : extractions m3_0_2_2 a = [] := by decide
example : extractions m3_0_2_2 b = [] := by decide
example : knowledge m3_0_2_2 = false := by decide
example : failures m3_0_2_2 = [b] := by decide
def m3_0_2_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[],[a,b]⟩
example : extractions m3_0_2_3 a = [] := by decide
example : extractions m3_0_2_3 b = [] := by decide
example : knowledge m3_0_2_3 = false := by decide
example : failures m3_0_2_3 = [b] := by decide
def m3_0_3_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[],[]⟩
example : extractions m3_0_3_0 a = [] := by decide
example : extractions m3_0_3_0 b = [] := by decide
example : knowledge m3_0_3_0 = true := by decide
example : failures m3_0_3_0 = [] := by decide
def m3_0_3_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[],[a]⟩
example : extractions m3_0_3_1 a = [] := by decide
example : extractions m3_0_3_1 b = [] := by decide
example : knowledge m3_0_3_1 = false := by decide
example : failures m3_0_3_1 = [a] := by decide
def m3_0_3_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[],[b]⟩
example : extractions m3_0_3_2 a = [] := by decide
example : extractions m3_0_3_2 b = [] := by decide
example : knowledge m3_0_3_2 = false := by decide
example : failures m3_0_3_2 = [b] := by decide
def m3_0_3_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[],[a,b]⟩
example : extractions m3_0_3_3 a = [] := by decide
example : extractions m3_0_3_3 b = [] := by decide
example : knowledge m3_0_3_3 = false := by decide
example : failures m3_0_3_3 = [a,b] := by decide
def m3_1_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0],[]⟩
example : extractions m3_1_0_0 a = [e0] := by decide
example : extractions m3_1_0_0 b = [] := by decide
example : knowledge m3_1_0_0 = true := by decide
example : failures m3_1_0_0 = [] := by decide
def m3_1_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0],[a]⟩
example : extractions m3_1_0_1 a = [e0] := by decide
example : extractions m3_1_0_1 b = [] := by decide
example : knowledge m3_1_0_1 = true := by decide
example : failures m3_1_0_1 = [] := by decide
def m3_1_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0],[b]⟩
example : extractions m3_1_0_2 a = [e0] := by decide
example : extractions m3_1_0_2 b = [] := by decide
example : knowledge m3_1_0_2 = true := by decide
example : failures m3_1_0_2 = [] := by decide
def m3_1_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0],[a,b]⟩
example : extractions m3_1_0_3 a = [e0] := by decide
example : extractions m3_1_0_3 b = [] := by decide
example : knowledge m3_1_0_3 = true := by decide
example : failures m3_1_0_3 = [] := by decide
def m3_1_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0],[]⟩
example : extractions m3_1_1_0 a = [e0] := by decide
example : extractions m3_1_1_0 b = [] := by decide
example : knowledge m3_1_1_0 = true := by decide
example : failures m3_1_1_0 = [] := by decide
def m3_1_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0],[a]⟩
example : extractions m3_1_1_1 a = [e0] := by decide
example : extractions m3_1_1_1 b = [] := by decide
example : knowledge m3_1_1_1 = true := by decide
example : failures m3_1_1_1 = [] := by decide
def m3_1_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0],[b]⟩
example : extractions m3_1_1_2 a = [e0] := by decide
example : extractions m3_1_1_2 b = [] := by decide
example : knowledge m3_1_1_2 = true := by decide
example : failures m3_1_1_2 = [] := by decide
def m3_1_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0],[a,b]⟩
example : extractions m3_1_1_3 a = [e0] := by decide
example : extractions m3_1_1_3 b = [] := by decide
example : knowledge m3_1_1_3 = true := by decide
example : failures m3_1_1_3 = [] := by decide
def m3_1_2_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0],[]⟩
example : extractions m3_1_2_0 a = [e0] := by decide
example : extractions m3_1_2_0 b = [] := by decide
example : knowledge m3_1_2_0 = true := by decide
example : failures m3_1_2_0 = [] := by decide
def m3_1_2_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0],[a]⟩
example : extractions m3_1_2_1 a = [e0] := by decide
example : extractions m3_1_2_1 b = [] := by decide
example : knowledge m3_1_2_1 = true := by decide
example : failures m3_1_2_1 = [] := by decide
def m3_1_2_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0],[b]⟩
example : extractions m3_1_2_2 a = [e0] := by decide
example : extractions m3_1_2_2 b = [] := by decide
example : knowledge m3_1_2_2 = false := by decide
example : failures m3_1_2_2 = [b] := by decide
def m3_1_2_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0],[a,b]⟩
example : extractions m3_1_2_3 a = [e0] := by decide
example : extractions m3_1_2_3 b = [] := by decide
example : knowledge m3_1_2_3 = false := by decide
example : failures m3_1_2_3 = [b] := by decide
def m3_1_3_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0],[]⟩
example : extractions m3_1_3_0 a = [e0] := by decide
example : extractions m3_1_3_0 b = [] := by decide
example : knowledge m3_1_3_0 = true := by decide
example : failures m3_1_3_0 = [] := by decide
def m3_1_3_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0],[a]⟩
example : extractions m3_1_3_1 a = [e0] := by decide
example : extractions m3_1_3_1 b = [] := by decide
example : knowledge m3_1_3_1 = true := by decide
example : failures m3_1_3_1 = [] := by decide
def m3_1_3_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0],[b]⟩
example : extractions m3_1_3_2 a = [e0] := by decide
example : extractions m3_1_3_2 b = [] := by decide
example : knowledge m3_1_3_2 = false := by decide
example : failures m3_1_3_2 = [b] := by decide
def m3_1_3_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0],[a,b]⟩
example : extractions m3_1_3_3 a = [e0] := by decide
example : extractions m3_1_3_3 b = [] := by decide
example : knowledge m3_1_3_3 = false := by decide
example : failures m3_1_3_3 = [b] := by decide
def m3_2_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e1],[]⟩
example : extractions m3_2_0_0 a = [] := by decide
example : extractions m3_2_0_0 b = [e1] := by decide
example : knowledge m3_2_0_0 = true := by decide
example : failures m3_2_0_0 = [] := by decide
def m3_2_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e1],[a]⟩
example : extractions m3_2_0_1 a = [] := by decide
example : extractions m3_2_0_1 b = [e1] := by decide
example : knowledge m3_2_0_1 = true := by decide
example : failures m3_2_0_1 = [] := by decide
def m3_2_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e1],[b]⟩
example : extractions m3_2_0_2 a = [] := by decide
example : extractions m3_2_0_2 b = [e1] := by decide
example : knowledge m3_2_0_2 = true := by decide
example : failures m3_2_0_2 = [] := by decide
def m3_2_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e1],[a,b]⟩
example : extractions m3_2_0_3 a = [] := by decide
example : extractions m3_2_0_3 b = [e1] := by decide
example : knowledge m3_2_0_3 = true := by decide
example : failures m3_2_0_3 = [] := by decide
def m3_2_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e1],[]⟩
example : extractions m3_2_1_0 a = [] := by decide
example : extractions m3_2_1_0 b = [e1] := by decide
example : knowledge m3_2_1_0 = true := by decide
example : failures m3_2_1_0 = [] := by decide
def m3_2_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e1],[a]⟩
example : extractions m3_2_1_1 a = [] := by decide
example : extractions m3_2_1_1 b = [e1] := by decide
example : knowledge m3_2_1_1 = false := by decide
example : failures m3_2_1_1 = [a] := by decide
def m3_2_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e1],[b]⟩
example : extractions m3_2_1_2 a = [] := by decide
example : extractions m3_2_1_2 b = [e1] := by decide
example : knowledge m3_2_1_2 = true := by decide
example : failures m3_2_1_2 = [] := by decide
def m3_2_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e1],[a,b]⟩
example : extractions m3_2_1_3 a = [] := by decide
example : extractions m3_2_1_3 b = [e1] := by decide
example : knowledge m3_2_1_3 = false := by decide
example : failures m3_2_1_3 = [a] := by decide
def m3_2_2_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e1],[]⟩
example : extractions m3_2_2_0 a = [] := by decide
example : extractions m3_2_2_0 b = [e1] := by decide
example : knowledge m3_2_2_0 = true := by decide
example : failures m3_2_2_0 = [] := by decide
def m3_2_2_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e1],[a]⟩
example : extractions m3_2_2_1 a = [] := by decide
example : extractions m3_2_2_1 b = [e1] := by decide
example : knowledge m3_2_2_1 = true := by decide
example : failures m3_2_2_1 = [] := by decide
def m3_2_2_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e1],[b]⟩
example : extractions m3_2_2_2 a = [] := by decide
example : extractions m3_2_2_2 b = [e1] := by decide
example : knowledge m3_2_2_2 = true := by decide
example : failures m3_2_2_2 = [] := by decide
def m3_2_2_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e1],[a,b]⟩
example : extractions m3_2_2_3 a = [] := by decide
example : extractions m3_2_2_3 b = [e1] := by decide
example : knowledge m3_2_2_3 = true := by decide
example : failures m3_2_2_3 = [] := by decide
def m3_2_3_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e1],[]⟩
example : extractions m3_2_3_0 a = [] := by decide
example : extractions m3_2_3_0 b = [e1] := by decide
example : knowledge m3_2_3_0 = true := by decide
example : failures m3_2_3_0 = [] := by decide
def m3_2_3_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e1],[a]⟩
example : extractions m3_2_3_1 a = [] := by decide
example : extractions m3_2_3_1 b = [e1] := by decide
example : knowledge m3_2_3_1 = false := by decide
example : failures m3_2_3_1 = [a] := by decide
def m3_2_3_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e1],[b]⟩
example : extractions m3_2_3_2 a = [] := by decide
example : extractions m3_2_3_2 b = [e1] := by decide
example : knowledge m3_2_3_2 = true := by decide
example : failures m3_2_3_2 = [] := by decide
def m3_2_3_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e1],[a,b]⟩
example : extractions m3_2_3_3 a = [] := by decide
example : extractions m3_2_3_3 b = [e1] := by decide
example : knowledge m3_2_3_3 = false := by decide
example : failures m3_2_3_3 = [a] := by decide
def m3_3_0_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0,e1],[]⟩
example : extractions m3_3_0_0 a = [e0] := by decide
example : extractions m3_3_0_0 b = [e1] := by decide
example : knowledge m3_3_0_0 = true := by decide
example : failures m3_3_0_0 = [] := by decide
def m3_3_0_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0,e1],[a]⟩
example : extractions m3_3_0_1 a = [e0] := by decide
example : extractions m3_3_0_1 b = [e1] := by decide
example : knowledge m3_3_0_1 = true := by decide
example : failures m3_3_0_1 = [] := by decide
def m3_3_0_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0,e1],[b]⟩
example : extractions m3_3_0_2 a = [e0] := by decide
example : extractions m3_3_0_2 b = [e1] := by decide
example : knowledge m3_3_0_2 = true := by decide
example : failures m3_3_0_2 = [] := by decide
def m3_3_0_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[],[e0,e1],[a,b]⟩
example : extractions m3_3_0_3 a = [e0] := by decide
example : extractions m3_3_0_3 b = [e1] := by decide
example : knowledge m3_3_0_3 = true := by decide
example : failures m3_3_0_3 = [] := by decide
def m3_3_1_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0,e1],[]⟩
example : extractions m3_3_1_0 a = [e0] := by decide
example : extractions m3_3_1_0 b = [e1] := by decide
example : knowledge m3_3_1_0 = true := by decide
example : failures m3_3_1_0 = [] := by decide
def m3_3_1_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0,e1],[a]⟩
example : extractions m3_3_1_1 a = [e0] := by decide
example : extractions m3_3_1_1 b = [e1] := by decide
example : knowledge m3_3_1_1 = true := by decide
example : failures m3_3_1_1 = [] := by decide
def m3_3_1_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0,e1],[b]⟩
example : extractions m3_3_1_2 a = [e0] := by decide
example : extractions m3_3_1_2 b = [e1] := by decide
example : knowledge m3_3_1_2 = true := by decide
example : failures m3_3_1_2 = [] := by decide
def m3_3_1_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a],[e0,e1],[a,b]⟩
example : extractions m3_3_1_3 a = [e0] := by decide
example : extractions m3_3_1_3 b = [e1] := by decide
example : knowledge m3_3_1_3 = true := by decide
example : failures m3_3_1_3 = [] := by decide
def m3_3_2_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0,e1],[]⟩
example : extractions m3_3_2_0 a = [e0] := by decide
example : extractions m3_3_2_0 b = [e1] := by decide
example : knowledge m3_3_2_0 = true := by decide
example : failures m3_3_2_0 = [] := by decide
def m3_3_2_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0,e1],[a]⟩
example : extractions m3_3_2_1 a = [e0] := by decide
example : extractions m3_3_2_1 b = [e1] := by decide
example : knowledge m3_3_2_1 = true := by decide
example : failures m3_3_2_1 = [] := by decide
def m3_3_2_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0,e1],[b]⟩
example : extractions m3_3_2_2 a = [e0] := by decide
example : extractions m3_3_2_2 b = [e1] := by decide
example : knowledge m3_3_2_2 = true := by decide
example : failures m3_3_2_2 = [] := by decide
def m3_3_2_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[b],[e0,e1],[a,b]⟩
example : extractions m3_3_2_3 a = [e0] := by decide
example : extractions m3_3_2_3 b = [e1] := by decide
example : knowledge m3_3_2_3 = true := by decide
example : failures m3_3_2_3 = [] := by decide
def m3_3_3_0 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0,e1],[]⟩
example : extractions m3_3_3_0 a = [e0] := by decide
example : extractions m3_3_3_0 b = [e1] := by decide
example : knowledge m3_3_3_0 = true := by decide
example : failures m3_3_3_0 = [] := by decide
def m3_3_3_1 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0,e1],[a]⟩
example : extractions m3_3_3_1 a = [e0] := by decide
example : extractions m3_3_3_1 b = [e1] := by decide
example : knowledge m3_3_3_1 = true := by decide
example : failures m3_3_3_1 = [] := by decide
def m3_3_3_2 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0,e1],[b]⟩
example : extractions m3_3_3_2 a = [e0] := by decide
example : extractions m3_3_3_2 b = [e1] := by decide
example : knowledge m3_3_3_2 = true := by decide
example : failures m3_3_3_2 = [] := by decide
def m3_3_3_3 : Model := ⟨["s"],[("s","w0"),("s","w1")],system,system,[a,b],[a,b],[e0,e1],[a,b]⟩
example : extractions m3_3_3_3 a = [e0] := by decide
example : extractions m3_3_3_3 b = [e1] := by decide
example : knowledge m3_3_3_3 = true := by decide
example : failures m3_3_3_3 = [] := by decide
def nativeInteraction : AcceptedInteraction m3_3_3_3 := ⟨⟨a,.head _,.head _,by rfl,by rfl,by rfl⟩,by decide⟩
theorem nativeWitness : ∃ e, e ∈ m3_3_3_3.extractor ∧ e.transcript = a ∧ (a.statement,e.witness) ∈ m3_3_3_3.witnesses := acceptedExtraction _ (by decide) nativeInteraction (.head _)
#print axioms nativeWitness
end SFT.Computation.ProofKnowledge
