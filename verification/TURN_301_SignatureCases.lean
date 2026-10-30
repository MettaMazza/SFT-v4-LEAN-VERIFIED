import SFT.Computation.Signature
namespace SFT.Computation.Signature
def a : Row := ⟨"k0","m0","s0"⟩
def b : Row := ⟨"k0","m1","s1"⟩
def c : Row := ⟨"k1","m0","s0"⟩
def m0_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[]⟩
example : correct m0_0_0 = true := by decide
example : unforgeable m0_0_0 = true := by decide
example : forgeries m0_0_0 = [] := by decide
example : accepted m0_0_0 = [] := by decide
def m0_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[a]⟩
example : correct m0_0_1 = true := by decide
example : unforgeable m0_0_1 = true := by decide
example : forgeries m0_0_1 = [] := by decide
example : accepted m0_0_1 = [] := by decide
def m0_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[b]⟩
example : correct m0_0_2 = true := by decide
example : unforgeable m0_0_2 = true := by decide
example : forgeries m0_0_2 = [] := by decide
example : accepted m0_0_2 = [] := by decide
def m0_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[a,b]⟩
example : correct m0_0_3 = true := by decide
example : unforgeable m0_0_3 = true := by decide
example : forgeries m0_0_3 = [] := by decide
example : accepted m0_0_3 = [] := by decide
def m0_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[c]⟩
example : correct m0_0_4 = true := by decide
example : unforgeable m0_0_4 = true := by decide
example : forgeries m0_0_4 = [] := by decide
example : accepted m0_0_4 = [] := by decide
def m0_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[a,c]⟩
example : correct m0_0_5 = true := by decide
example : unforgeable m0_0_5 = true := by decide
example : forgeries m0_0_5 = [] := by decide
example : accepted m0_0_5 = [] := by decide
def m0_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[b,c]⟩
example : correct m0_0_6 = true := by decide
example : unforgeable m0_0_6 = true := by decide
example : forgeries m0_0_6 = [] := by decide
example : accepted m0_0_6 = [] := by decide
def m0_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[],[a,b,c]⟩
example : correct m0_0_7 = true := by decide
example : unforgeable m0_0_7 = true := by decide
example : forgeries m0_0_7 = [] := by decide
example : accepted m0_0_7 = [] := by decide
def m0_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[]⟩
example : correct m0_1_0 = true := by decide
example : unforgeable m0_1_0 = true := by decide
example : forgeries m0_1_0 = [] := by decide
example : accepted m0_1_0 = [a] := by decide
def m0_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[a]⟩
example : correct m0_1_1 = true := by decide
example : unforgeable m0_1_1 = false := by decide
example : forgeries m0_1_1 = [a] := by decide
example : accepted m0_1_1 = [a] := by decide
def m0_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[b]⟩
example : correct m0_1_2 = true := by decide
example : unforgeable m0_1_2 = true := by decide
example : forgeries m0_1_2 = [] := by decide
example : accepted m0_1_2 = [a] := by decide
def m0_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[a,b]⟩
example : correct m0_1_3 = true := by decide
example : unforgeable m0_1_3 = false := by decide
example : forgeries m0_1_3 = [a] := by decide
example : accepted m0_1_3 = [a] := by decide
def m0_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[c]⟩
example : correct m0_1_4 = true := by decide
example : unforgeable m0_1_4 = true := by decide
example : forgeries m0_1_4 = [] := by decide
example : accepted m0_1_4 = [a] := by decide
def m0_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[a,c]⟩
example : correct m0_1_5 = true := by decide
example : unforgeable m0_1_5 = false := by decide
example : forgeries m0_1_5 = [a] := by decide
example : accepted m0_1_5 = [a] := by decide
def m0_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[b,c]⟩
example : correct m0_1_6 = true := by decide
example : unforgeable m0_1_6 = true := by decide
example : forgeries m0_1_6 = [] := by decide
example : accepted m0_1_6 = [a] := by decide
def m0_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[a],[a,b,c]⟩
example : correct m0_1_7 = true := by decide
example : unforgeable m0_1_7 = false := by decide
example : forgeries m0_1_7 = [a] := by decide
example : accepted m0_1_7 = [a] := by decide
def m0_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[]⟩
example : correct m0_2_0 = true := by decide
example : unforgeable m0_2_0 = true := by decide
example : forgeries m0_2_0 = [] := by decide
example : accepted m0_2_0 = [b] := by decide
def m0_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[a]⟩
example : correct m0_2_1 = true := by decide
example : unforgeable m0_2_1 = true := by decide
example : forgeries m0_2_1 = [] := by decide
example : accepted m0_2_1 = [b] := by decide
def m0_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[b]⟩
example : correct m0_2_2 = true := by decide
example : unforgeable m0_2_2 = false := by decide
example : forgeries m0_2_2 = [b] := by decide
example : accepted m0_2_2 = [b] := by decide
def m0_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[a,b]⟩
example : correct m0_2_3 = true := by decide
example : unforgeable m0_2_3 = false := by decide
example : forgeries m0_2_3 = [b] := by decide
example : accepted m0_2_3 = [b] := by decide
def m0_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[c]⟩
example : correct m0_2_4 = true := by decide
example : unforgeable m0_2_4 = true := by decide
example : forgeries m0_2_4 = [] := by decide
example : accepted m0_2_4 = [b] := by decide
def m0_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[a,c]⟩
example : correct m0_2_5 = true := by decide
example : unforgeable m0_2_5 = true := by decide
example : forgeries m0_2_5 = [] := by decide
example : accepted m0_2_5 = [b] := by decide
def m0_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[b,c]⟩
example : correct m0_2_6 = true := by decide
example : unforgeable m0_2_6 = false := by decide
example : forgeries m0_2_6 = [b] := by decide
example : accepted m0_2_6 = [b] := by decide
def m0_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[b],[a,b,c]⟩
example : correct m0_2_7 = true := by decide
example : unforgeable m0_2_7 = false := by decide
example : forgeries m0_2_7 = [b] := by decide
example : accepted m0_2_7 = [b] := by decide
def m0_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[]⟩
example : correct m0_3_0 = true := by decide
example : unforgeable m0_3_0 = true := by decide
example : forgeries m0_3_0 = [] := by decide
example : accepted m0_3_0 = [a,b] := by decide
def m0_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[a]⟩
example : correct m0_3_1 = true := by decide
example : unforgeable m0_3_1 = false := by decide
example : forgeries m0_3_1 = [a] := by decide
example : accepted m0_3_1 = [a,b] := by decide
def m0_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[b]⟩
example : correct m0_3_2 = true := by decide
example : unforgeable m0_3_2 = false := by decide
example : forgeries m0_3_2 = [b] := by decide
example : accepted m0_3_2 = [a,b] := by decide
def m0_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[a,b]⟩
example : correct m0_3_3 = true := by decide
example : unforgeable m0_3_3 = false := by decide
example : forgeries m0_3_3 = [a,b] := by decide
example : accepted m0_3_3 = [a,b] := by decide
def m0_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[c]⟩
example : correct m0_3_4 = true := by decide
example : unforgeable m0_3_4 = true := by decide
example : forgeries m0_3_4 = [] := by decide
example : accepted m0_3_4 = [a,b] := by decide
def m0_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[a,c]⟩
example : correct m0_3_5 = true := by decide
example : unforgeable m0_3_5 = false := by decide
example : forgeries m0_3_5 = [a] := by decide
example : accepted m0_3_5 = [a,b] := by decide
def m0_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[b,c]⟩
example : correct m0_3_6 = true := by decide
example : unforgeable m0_3_6 = false := by decide
example : forgeries m0_3_6 = [b] := by decide
example : accepted m0_3_6 = [a,b] := by decide
def m0_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b],[a,b,c]⟩
example : correct m0_3_7 = true := by decide
example : unforgeable m0_3_7 = false := by decide
example : forgeries m0_3_7 = [a,b] := by decide
example : accepted m0_3_7 = [a,b] := by decide
def m0_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[]⟩
example : correct m0_4_0 = true := by decide
example : unforgeable m0_4_0 = true := by decide
example : forgeries m0_4_0 = [] := by decide
example : accepted m0_4_0 = [c] := by decide
def m0_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[a]⟩
example : correct m0_4_1 = true := by decide
example : unforgeable m0_4_1 = true := by decide
example : forgeries m0_4_1 = [] := by decide
example : accepted m0_4_1 = [c] := by decide
def m0_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[b]⟩
example : correct m0_4_2 = true := by decide
example : unforgeable m0_4_2 = true := by decide
example : forgeries m0_4_2 = [] := by decide
example : accepted m0_4_2 = [c] := by decide
def m0_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[a,b]⟩
example : correct m0_4_3 = true := by decide
example : unforgeable m0_4_3 = true := by decide
example : forgeries m0_4_3 = [] := by decide
example : accepted m0_4_3 = [c] := by decide
def m0_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[c]⟩
example : correct m0_4_4 = true := by decide
example : unforgeable m0_4_4 = false := by decide
example : forgeries m0_4_4 = [c] := by decide
example : accepted m0_4_4 = [c] := by decide
def m0_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[a,c]⟩
example : correct m0_4_5 = true := by decide
example : unforgeable m0_4_5 = false := by decide
example : forgeries m0_4_5 = [c] := by decide
example : accepted m0_4_5 = [c] := by decide
def m0_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[b,c]⟩
example : correct m0_4_6 = true := by decide
example : unforgeable m0_4_6 = false := by decide
example : forgeries m0_4_6 = [c] := by decide
example : accepted m0_4_6 = [c] := by decide
def m0_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[c],[a,b,c]⟩
example : correct m0_4_7 = true := by decide
example : unforgeable m0_4_7 = false := by decide
example : forgeries m0_4_7 = [c] := by decide
example : accepted m0_4_7 = [c] := by decide
def m0_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[]⟩
example : correct m0_5_0 = true := by decide
example : unforgeable m0_5_0 = true := by decide
example : forgeries m0_5_0 = [] := by decide
example : accepted m0_5_0 = [a,c] := by decide
def m0_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[a]⟩
example : correct m0_5_1 = true := by decide
example : unforgeable m0_5_1 = false := by decide
example : forgeries m0_5_1 = [a] := by decide
example : accepted m0_5_1 = [a,c] := by decide
def m0_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[b]⟩
example : correct m0_5_2 = true := by decide
example : unforgeable m0_5_2 = true := by decide
example : forgeries m0_5_2 = [] := by decide
example : accepted m0_5_2 = [a,c] := by decide
def m0_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[a,b]⟩
example : correct m0_5_3 = true := by decide
example : unforgeable m0_5_3 = false := by decide
example : forgeries m0_5_3 = [a] := by decide
example : accepted m0_5_3 = [a,c] := by decide
def m0_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[c]⟩
example : correct m0_5_4 = true := by decide
example : unforgeable m0_5_4 = false := by decide
example : forgeries m0_5_4 = [c] := by decide
example : accepted m0_5_4 = [a,c] := by decide
def m0_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[a,c]⟩
example : correct m0_5_5 = true := by decide
example : unforgeable m0_5_5 = false := by decide
example : forgeries m0_5_5 = [a,c] := by decide
example : accepted m0_5_5 = [a,c] := by decide
def m0_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[b,c]⟩
example : correct m0_5_6 = true := by decide
example : unforgeable m0_5_6 = false := by decide
example : forgeries m0_5_6 = [c] := by decide
example : accepted m0_5_6 = [a,c] := by decide
def m0_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,c],[a,b,c]⟩
example : correct m0_5_7 = true := by decide
example : unforgeable m0_5_7 = false := by decide
example : forgeries m0_5_7 = [a,c] := by decide
example : accepted m0_5_7 = [a,c] := by decide
def m0_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[]⟩
example : correct m0_6_0 = true := by decide
example : unforgeable m0_6_0 = true := by decide
example : forgeries m0_6_0 = [] := by decide
example : accepted m0_6_0 = [b,c] := by decide
def m0_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[a]⟩
example : correct m0_6_1 = true := by decide
example : unforgeable m0_6_1 = true := by decide
example : forgeries m0_6_1 = [] := by decide
example : accepted m0_6_1 = [b,c] := by decide
def m0_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[b]⟩
example : correct m0_6_2 = true := by decide
example : unforgeable m0_6_2 = false := by decide
example : forgeries m0_6_2 = [b] := by decide
example : accepted m0_6_2 = [b,c] := by decide
def m0_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[a,b]⟩
example : correct m0_6_3 = true := by decide
example : unforgeable m0_6_3 = false := by decide
example : forgeries m0_6_3 = [b] := by decide
example : accepted m0_6_3 = [b,c] := by decide
def m0_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[c]⟩
example : correct m0_6_4 = true := by decide
example : unforgeable m0_6_4 = false := by decide
example : forgeries m0_6_4 = [c] := by decide
example : accepted m0_6_4 = [b,c] := by decide
def m0_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[a,c]⟩
example : correct m0_6_5 = true := by decide
example : unforgeable m0_6_5 = false := by decide
example : forgeries m0_6_5 = [c] := by decide
example : accepted m0_6_5 = [b,c] := by decide
def m0_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[b,c]⟩
example : correct m0_6_6 = true := by decide
example : unforgeable m0_6_6 = false := by decide
example : forgeries m0_6_6 = [b,c] := by decide
example : accepted m0_6_6 = [b,c] := by decide
def m0_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[b,c],[a,b,c]⟩
example : correct m0_6_7 = true := by decide
example : unforgeable m0_6_7 = false := by decide
example : forgeries m0_6_7 = [b,c] := by decide
example : accepted m0_6_7 = [b,c] := by decide
def m0_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[]⟩
example : correct m0_7_0 = true := by decide
example : unforgeable m0_7_0 = true := by decide
example : forgeries m0_7_0 = [] := by decide
example : accepted m0_7_0 = [a,b,c] := by decide
def m0_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[a]⟩
example : correct m0_7_1 = true := by decide
example : unforgeable m0_7_1 = false := by decide
example : forgeries m0_7_1 = [a] := by decide
example : accepted m0_7_1 = [a,b,c] := by decide
def m0_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[b]⟩
example : correct m0_7_2 = true := by decide
example : unforgeable m0_7_2 = false := by decide
example : forgeries m0_7_2 = [b] := by decide
example : accepted m0_7_2 = [a,b,c] := by decide
def m0_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[a,b]⟩
example : correct m0_7_3 = true := by decide
example : unforgeable m0_7_3 = false := by decide
example : forgeries m0_7_3 = [a,b] := by decide
example : accepted m0_7_3 = [a,b,c] := by decide
def m0_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[c]⟩
example : correct m0_7_4 = true := by decide
example : unforgeable m0_7_4 = false := by decide
example : forgeries m0_7_4 = [c] := by decide
example : accepted m0_7_4 = [a,b,c] := by decide
def m0_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[a,c]⟩
example : correct m0_7_5 = true := by decide
example : unforgeable m0_7_5 = false := by decide
example : forgeries m0_7_5 = [a,c] := by decide
example : accepted m0_7_5 = [a,b,c] := by decide
def m0_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[b,c]⟩
example : correct m0_7_6 = true := by decide
example : unforgeable m0_7_6 = false := by decide
example : forgeries m0_7_6 = [b,c] := by decide
example : accepted m0_7_6 = [a,b,c] := by decide
def m0_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[],[a,b,c],[a,b,c]⟩
example : correct m0_7_7 = true := by decide
example : unforgeable m0_7_7 = false := by decide
example : forgeries m0_7_7 = [a,b,c] := by decide
example : accepted m0_7_7 = [a,b,c] := by decide
def m1_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[]⟩
example : correct m1_0_0 = false := by decide
example : unforgeable m1_0_0 = true := by decide
example : forgeries m1_0_0 = [] := by decide
example : accepted m1_0_0 = [] := by decide
def m1_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[a]⟩
example : correct m1_0_1 = false := by decide
example : unforgeable m1_0_1 = true := by decide
example : forgeries m1_0_1 = [] := by decide
example : accepted m1_0_1 = [] := by decide
def m1_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[b]⟩
example : correct m1_0_2 = false := by decide
example : unforgeable m1_0_2 = true := by decide
example : forgeries m1_0_2 = [] := by decide
example : accepted m1_0_2 = [] := by decide
def m1_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[a,b]⟩
example : correct m1_0_3 = false := by decide
example : unforgeable m1_0_3 = true := by decide
example : forgeries m1_0_3 = [] := by decide
example : accepted m1_0_3 = [] := by decide
def m1_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[c]⟩
example : correct m1_0_4 = false := by decide
example : unforgeable m1_0_4 = true := by decide
example : forgeries m1_0_4 = [] := by decide
example : accepted m1_0_4 = [] := by decide
def m1_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[a,c]⟩
example : correct m1_0_5 = false := by decide
example : unforgeable m1_0_5 = true := by decide
example : forgeries m1_0_5 = [] := by decide
example : accepted m1_0_5 = [] := by decide
def m1_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[b,c]⟩
example : correct m1_0_6 = false := by decide
example : unforgeable m1_0_6 = true := by decide
example : forgeries m1_0_6 = [] := by decide
example : accepted m1_0_6 = [] := by decide
def m1_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[],[a,b,c]⟩
example : correct m1_0_7 = false := by decide
example : unforgeable m1_0_7 = true := by decide
example : forgeries m1_0_7 = [] := by decide
example : accepted m1_0_7 = [] := by decide
def m1_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[]⟩
example : correct m1_1_0 = true := by decide
example : unforgeable m1_1_0 = true := by decide
example : forgeries m1_1_0 = [] := by decide
example : accepted m1_1_0 = [a] := by decide
def m1_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[a]⟩
example : correct m1_1_1 = true := by decide
example : unforgeable m1_1_1 = true := by decide
example : forgeries m1_1_1 = [] := by decide
example : accepted m1_1_1 = [a] := by decide
def m1_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[b]⟩
example : correct m1_1_2 = true := by decide
example : unforgeable m1_1_2 = true := by decide
example : forgeries m1_1_2 = [] := by decide
example : accepted m1_1_2 = [a] := by decide
def m1_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[a,b]⟩
example : correct m1_1_3 = true := by decide
example : unforgeable m1_1_3 = true := by decide
example : forgeries m1_1_3 = [] := by decide
example : accepted m1_1_3 = [a] := by decide
def m1_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[c]⟩
example : correct m1_1_4 = true := by decide
example : unforgeable m1_1_4 = true := by decide
example : forgeries m1_1_4 = [] := by decide
example : accepted m1_1_4 = [a] := by decide
def m1_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[a,c]⟩
example : correct m1_1_5 = true := by decide
example : unforgeable m1_1_5 = true := by decide
example : forgeries m1_1_5 = [] := by decide
example : accepted m1_1_5 = [a] := by decide
def m1_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[b,c]⟩
example : correct m1_1_6 = true := by decide
example : unforgeable m1_1_6 = true := by decide
example : forgeries m1_1_6 = [] := by decide
example : accepted m1_1_6 = [a] := by decide
def m1_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a],[a,b,c]⟩
example : correct m1_1_7 = true := by decide
example : unforgeable m1_1_7 = true := by decide
example : forgeries m1_1_7 = [] := by decide
example : accepted m1_1_7 = [a] := by decide
def m1_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[]⟩
example : correct m1_2_0 = false := by decide
example : unforgeable m1_2_0 = true := by decide
example : forgeries m1_2_0 = [] := by decide
example : accepted m1_2_0 = [b] := by decide
def m1_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[a]⟩
example : correct m1_2_1 = false := by decide
example : unforgeable m1_2_1 = true := by decide
example : forgeries m1_2_1 = [] := by decide
example : accepted m1_2_1 = [b] := by decide
def m1_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[b]⟩
example : correct m1_2_2 = false := by decide
example : unforgeable m1_2_2 = false := by decide
example : forgeries m1_2_2 = [b] := by decide
example : accepted m1_2_2 = [b] := by decide
def m1_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[a,b]⟩
example : correct m1_2_3 = false := by decide
example : unforgeable m1_2_3 = false := by decide
example : forgeries m1_2_3 = [b] := by decide
example : accepted m1_2_3 = [b] := by decide
def m1_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[c]⟩
example : correct m1_2_4 = false := by decide
example : unforgeable m1_2_4 = true := by decide
example : forgeries m1_2_4 = [] := by decide
example : accepted m1_2_4 = [b] := by decide
def m1_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[a,c]⟩
example : correct m1_2_5 = false := by decide
example : unforgeable m1_2_5 = true := by decide
example : forgeries m1_2_5 = [] := by decide
example : accepted m1_2_5 = [b] := by decide
def m1_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[b,c]⟩
example : correct m1_2_6 = false := by decide
example : unforgeable m1_2_6 = false := by decide
example : forgeries m1_2_6 = [b] := by decide
example : accepted m1_2_6 = [b] := by decide
def m1_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b],[a,b,c]⟩
example : correct m1_2_7 = false := by decide
example : unforgeable m1_2_7 = false := by decide
example : forgeries m1_2_7 = [b] := by decide
example : accepted m1_2_7 = [b] := by decide
def m1_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[]⟩
example : correct m1_3_0 = true := by decide
example : unforgeable m1_3_0 = true := by decide
example : forgeries m1_3_0 = [] := by decide
example : accepted m1_3_0 = [a,b] := by decide
def m1_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[a]⟩
example : correct m1_3_1 = true := by decide
example : unforgeable m1_3_1 = true := by decide
example : forgeries m1_3_1 = [] := by decide
example : accepted m1_3_1 = [a,b] := by decide
def m1_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[b]⟩
example : correct m1_3_2 = true := by decide
example : unforgeable m1_3_2 = false := by decide
example : forgeries m1_3_2 = [b] := by decide
example : accepted m1_3_2 = [a,b] := by decide
def m1_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[a,b]⟩
example : correct m1_3_3 = true := by decide
example : unforgeable m1_3_3 = false := by decide
example : forgeries m1_3_3 = [b] := by decide
example : accepted m1_3_3 = [a,b] := by decide
def m1_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[c]⟩
example : correct m1_3_4 = true := by decide
example : unforgeable m1_3_4 = true := by decide
example : forgeries m1_3_4 = [] := by decide
example : accepted m1_3_4 = [a,b] := by decide
def m1_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[a,c]⟩
example : correct m1_3_5 = true := by decide
example : unforgeable m1_3_5 = true := by decide
example : forgeries m1_3_5 = [] := by decide
example : accepted m1_3_5 = [a,b] := by decide
def m1_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[b,c]⟩
example : correct m1_3_6 = true := by decide
example : unforgeable m1_3_6 = false := by decide
example : forgeries m1_3_6 = [b] := by decide
example : accepted m1_3_6 = [a,b] := by decide
def m1_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b],[a,b,c]⟩
example : correct m1_3_7 = true := by decide
example : unforgeable m1_3_7 = false := by decide
example : forgeries m1_3_7 = [b] := by decide
example : accepted m1_3_7 = [a,b] := by decide
def m1_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[]⟩
example : correct m1_4_0 = false := by decide
example : unforgeable m1_4_0 = true := by decide
example : forgeries m1_4_0 = [] := by decide
example : accepted m1_4_0 = [c] := by decide
def m1_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[a]⟩
example : correct m1_4_1 = false := by decide
example : unforgeable m1_4_1 = true := by decide
example : forgeries m1_4_1 = [] := by decide
example : accepted m1_4_1 = [c] := by decide
def m1_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[b]⟩
example : correct m1_4_2 = false := by decide
example : unforgeable m1_4_2 = true := by decide
example : forgeries m1_4_2 = [] := by decide
example : accepted m1_4_2 = [c] := by decide
def m1_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[a,b]⟩
example : correct m1_4_3 = false := by decide
example : unforgeable m1_4_3 = true := by decide
example : forgeries m1_4_3 = [] := by decide
example : accepted m1_4_3 = [c] := by decide
def m1_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[c]⟩
example : correct m1_4_4 = false := by decide
example : unforgeable m1_4_4 = false := by decide
example : forgeries m1_4_4 = [c] := by decide
example : accepted m1_4_4 = [c] := by decide
def m1_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[a,c]⟩
example : correct m1_4_5 = false := by decide
example : unforgeable m1_4_5 = false := by decide
example : forgeries m1_4_5 = [c] := by decide
example : accepted m1_4_5 = [c] := by decide
def m1_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[b,c]⟩
example : correct m1_4_6 = false := by decide
example : unforgeable m1_4_6 = false := by decide
example : forgeries m1_4_6 = [c] := by decide
example : accepted m1_4_6 = [c] := by decide
def m1_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[c],[a,b,c]⟩
example : correct m1_4_7 = false := by decide
example : unforgeable m1_4_7 = false := by decide
example : forgeries m1_4_7 = [c] := by decide
example : accepted m1_4_7 = [c] := by decide
def m1_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[]⟩
example : correct m1_5_0 = true := by decide
example : unforgeable m1_5_0 = true := by decide
example : forgeries m1_5_0 = [] := by decide
example : accepted m1_5_0 = [a,c] := by decide
def m1_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[a]⟩
example : correct m1_5_1 = true := by decide
example : unforgeable m1_5_1 = true := by decide
example : forgeries m1_5_1 = [] := by decide
example : accepted m1_5_1 = [a,c] := by decide
def m1_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[b]⟩
example : correct m1_5_2 = true := by decide
example : unforgeable m1_5_2 = true := by decide
example : forgeries m1_5_2 = [] := by decide
example : accepted m1_5_2 = [a,c] := by decide
def m1_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[a,b]⟩
example : correct m1_5_3 = true := by decide
example : unforgeable m1_5_3 = true := by decide
example : forgeries m1_5_3 = [] := by decide
example : accepted m1_5_3 = [a,c] := by decide
def m1_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[c]⟩
example : correct m1_5_4 = true := by decide
example : unforgeable m1_5_4 = false := by decide
example : forgeries m1_5_4 = [c] := by decide
example : accepted m1_5_4 = [a,c] := by decide
def m1_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[a,c]⟩
example : correct m1_5_5 = true := by decide
example : unforgeable m1_5_5 = false := by decide
example : forgeries m1_5_5 = [c] := by decide
example : accepted m1_5_5 = [a,c] := by decide
def m1_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[b,c]⟩
example : correct m1_5_6 = true := by decide
example : unforgeable m1_5_6 = false := by decide
example : forgeries m1_5_6 = [c] := by decide
example : accepted m1_5_6 = [a,c] := by decide
def m1_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,c],[a,b,c]⟩
example : correct m1_5_7 = true := by decide
example : unforgeable m1_5_7 = false := by decide
example : forgeries m1_5_7 = [c] := by decide
example : accepted m1_5_7 = [a,c] := by decide
def m1_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[]⟩
example : correct m1_6_0 = false := by decide
example : unforgeable m1_6_0 = true := by decide
example : forgeries m1_6_0 = [] := by decide
example : accepted m1_6_0 = [b,c] := by decide
def m1_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[a]⟩
example : correct m1_6_1 = false := by decide
example : unforgeable m1_6_1 = true := by decide
example : forgeries m1_6_1 = [] := by decide
example : accepted m1_6_1 = [b,c] := by decide
def m1_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[b]⟩
example : correct m1_6_2 = false := by decide
example : unforgeable m1_6_2 = false := by decide
example : forgeries m1_6_2 = [b] := by decide
example : accepted m1_6_2 = [b,c] := by decide
def m1_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[a,b]⟩
example : correct m1_6_3 = false := by decide
example : unforgeable m1_6_3 = false := by decide
example : forgeries m1_6_3 = [b] := by decide
example : accepted m1_6_3 = [b,c] := by decide
def m1_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[c]⟩
example : correct m1_6_4 = false := by decide
example : unforgeable m1_6_4 = false := by decide
example : forgeries m1_6_4 = [c] := by decide
example : accepted m1_6_4 = [b,c] := by decide
def m1_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[a,c]⟩
example : correct m1_6_5 = false := by decide
example : unforgeable m1_6_5 = false := by decide
example : forgeries m1_6_5 = [c] := by decide
example : accepted m1_6_5 = [b,c] := by decide
def m1_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[b,c]⟩
example : correct m1_6_6 = false := by decide
example : unforgeable m1_6_6 = false := by decide
example : forgeries m1_6_6 = [b,c] := by decide
example : accepted m1_6_6 = [b,c] := by decide
def m1_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[b,c],[a,b,c]⟩
example : correct m1_6_7 = false := by decide
example : unforgeable m1_6_7 = false := by decide
example : forgeries m1_6_7 = [b,c] := by decide
example : accepted m1_6_7 = [b,c] := by decide
def m1_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[]⟩
example : correct m1_7_0 = true := by decide
example : unforgeable m1_7_0 = true := by decide
example : forgeries m1_7_0 = [] := by decide
example : accepted m1_7_0 = [a,b,c] := by decide
def m1_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[a]⟩
example : correct m1_7_1 = true := by decide
example : unforgeable m1_7_1 = true := by decide
example : forgeries m1_7_1 = [] := by decide
example : accepted m1_7_1 = [a,b,c] := by decide
def m1_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[b]⟩
example : correct m1_7_2 = true := by decide
example : unforgeable m1_7_2 = false := by decide
example : forgeries m1_7_2 = [b] := by decide
example : accepted m1_7_2 = [a,b,c] := by decide
def m1_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[a,b]⟩
example : correct m1_7_3 = true := by decide
example : unforgeable m1_7_3 = false := by decide
example : forgeries m1_7_3 = [b] := by decide
example : accepted m1_7_3 = [a,b,c] := by decide
def m1_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[c]⟩
example : correct m1_7_4 = true := by decide
example : unforgeable m1_7_4 = false := by decide
example : forgeries m1_7_4 = [c] := by decide
example : accepted m1_7_4 = [a,b,c] := by decide
def m1_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[a,c]⟩
example : correct m1_7_5 = true := by decide
example : unforgeable m1_7_5 = false := by decide
example : forgeries m1_7_5 = [c] := by decide
example : accepted m1_7_5 = [a,b,c] := by decide
def m1_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[b,c]⟩
example : correct m1_7_6 = true := by decide
example : unforgeable m1_7_6 = false := by decide
example : forgeries m1_7_6 = [b,c] := by decide
example : accepted m1_7_6 = [a,b,c] := by decide
def m1_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[a],[a,b,c],[a,b,c]⟩
example : correct m1_7_7 = true := by decide
example : unforgeable m1_7_7 = false := by decide
example : forgeries m1_7_7 = [b,c] := by decide
example : accepted m1_7_7 = [a,b,c] := by decide
def m2_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[]⟩
example : correct m2_0_0 = false := by decide
example : unforgeable m2_0_0 = true := by decide
example : forgeries m2_0_0 = [] := by decide
example : accepted m2_0_0 = [] := by decide
def m2_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[a]⟩
example : correct m2_0_1 = false := by decide
example : unforgeable m2_0_1 = true := by decide
example : forgeries m2_0_1 = [] := by decide
example : accepted m2_0_1 = [] := by decide
def m2_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[b]⟩
example : correct m2_0_2 = false := by decide
example : unforgeable m2_0_2 = true := by decide
example : forgeries m2_0_2 = [] := by decide
example : accepted m2_0_2 = [] := by decide
def m2_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[a,b]⟩
example : correct m2_0_3 = false := by decide
example : unforgeable m2_0_3 = true := by decide
example : forgeries m2_0_3 = [] := by decide
example : accepted m2_0_3 = [] := by decide
def m2_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[c]⟩
example : correct m2_0_4 = false := by decide
example : unforgeable m2_0_4 = true := by decide
example : forgeries m2_0_4 = [] := by decide
example : accepted m2_0_4 = [] := by decide
def m2_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[a,c]⟩
example : correct m2_0_5 = false := by decide
example : unforgeable m2_0_5 = true := by decide
example : forgeries m2_0_5 = [] := by decide
example : accepted m2_0_5 = [] := by decide
def m2_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[b,c]⟩
example : correct m2_0_6 = false := by decide
example : unforgeable m2_0_6 = true := by decide
example : forgeries m2_0_6 = [] := by decide
example : accepted m2_0_6 = [] := by decide
def m2_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[],[a,b,c]⟩
example : correct m2_0_7 = false := by decide
example : unforgeable m2_0_7 = true := by decide
example : forgeries m2_0_7 = [] := by decide
example : accepted m2_0_7 = [] := by decide
def m2_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[]⟩
example : correct m2_1_0 = false := by decide
example : unforgeable m2_1_0 = true := by decide
example : forgeries m2_1_0 = [] := by decide
example : accepted m2_1_0 = [a] := by decide
def m2_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[a]⟩
example : correct m2_1_1 = false := by decide
example : unforgeable m2_1_1 = false := by decide
example : forgeries m2_1_1 = [a] := by decide
example : accepted m2_1_1 = [a] := by decide
def m2_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[b]⟩
example : correct m2_1_2 = false := by decide
example : unforgeable m2_1_2 = true := by decide
example : forgeries m2_1_2 = [] := by decide
example : accepted m2_1_2 = [a] := by decide
def m2_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[a,b]⟩
example : correct m2_1_3 = false := by decide
example : unforgeable m2_1_3 = false := by decide
example : forgeries m2_1_3 = [a] := by decide
example : accepted m2_1_3 = [a] := by decide
def m2_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[c]⟩
example : correct m2_1_4 = false := by decide
example : unforgeable m2_1_4 = true := by decide
example : forgeries m2_1_4 = [] := by decide
example : accepted m2_1_4 = [a] := by decide
def m2_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[a,c]⟩
example : correct m2_1_5 = false := by decide
example : unforgeable m2_1_5 = false := by decide
example : forgeries m2_1_5 = [a] := by decide
example : accepted m2_1_5 = [a] := by decide
def m2_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[b,c]⟩
example : correct m2_1_6 = false := by decide
example : unforgeable m2_1_6 = true := by decide
example : forgeries m2_1_6 = [] := by decide
example : accepted m2_1_6 = [a] := by decide
def m2_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a],[a,b,c]⟩
example : correct m2_1_7 = false := by decide
example : unforgeable m2_1_7 = false := by decide
example : forgeries m2_1_7 = [a] := by decide
example : accepted m2_1_7 = [a] := by decide
def m2_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[]⟩
example : correct m2_2_0 = true := by decide
example : unforgeable m2_2_0 = true := by decide
example : forgeries m2_2_0 = [] := by decide
example : accepted m2_2_0 = [b] := by decide
def m2_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[a]⟩
example : correct m2_2_1 = true := by decide
example : unforgeable m2_2_1 = true := by decide
example : forgeries m2_2_1 = [] := by decide
example : accepted m2_2_1 = [b] := by decide
def m2_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[b]⟩
example : correct m2_2_2 = true := by decide
example : unforgeable m2_2_2 = true := by decide
example : forgeries m2_2_2 = [] := by decide
example : accepted m2_2_2 = [b] := by decide
def m2_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[a,b]⟩
example : correct m2_2_3 = true := by decide
example : unforgeable m2_2_3 = true := by decide
example : forgeries m2_2_3 = [] := by decide
example : accepted m2_2_3 = [b] := by decide
def m2_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[c]⟩
example : correct m2_2_4 = true := by decide
example : unforgeable m2_2_4 = true := by decide
example : forgeries m2_2_4 = [] := by decide
example : accepted m2_2_4 = [b] := by decide
def m2_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[a,c]⟩
example : correct m2_2_5 = true := by decide
example : unforgeable m2_2_5 = true := by decide
example : forgeries m2_2_5 = [] := by decide
example : accepted m2_2_5 = [b] := by decide
def m2_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[b,c]⟩
example : correct m2_2_6 = true := by decide
example : unforgeable m2_2_6 = true := by decide
example : forgeries m2_2_6 = [] := by decide
example : accepted m2_2_6 = [b] := by decide
def m2_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b],[a,b,c]⟩
example : correct m2_2_7 = true := by decide
example : unforgeable m2_2_7 = true := by decide
example : forgeries m2_2_7 = [] := by decide
example : accepted m2_2_7 = [b] := by decide
def m2_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[]⟩
example : correct m2_3_0 = true := by decide
example : unforgeable m2_3_0 = true := by decide
example : forgeries m2_3_0 = [] := by decide
example : accepted m2_3_0 = [a,b] := by decide
def m2_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[a]⟩
example : correct m2_3_1 = true := by decide
example : unforgeable m2_3_1 = false := by decide
example : forgeries m2_3_1 = [a] := by decide
example : accepted m2_3_1 = [a,b] := by decide
def m2_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[b]⟩
example : correct m2_3_2 = true := by decide
example : unforgeable m2_3_2 = true := by decide
example : forgeries m2_3_2 = [] := by decide
example : accepted m2_3_2 = [a,b] := by decide
def m2_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[a,b]⟩
example : correct m2_3_3 = true := by decide
example : unforgeable m2_3_3 = false := by decide
example : forgeries m2_3_3 = [a] := by decide
example : accepted m2_3_3 = [a,b] := by decide
def m2_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[c]⟩
example : correct m2_3_4 = true := by decide
example : unforgeable m2_3_4 = true := by decide
example : forgeries m2_3_4 = [] := by decide
example : accepted m2_3_4 = [a,b] := by decide
def m2_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[a,c]⟩
example : correct m2_3_5 = true := by decide
example : unforgeable m2_3_5 = false := by decide
example : forgeries m2_3_5 = [a] := by decide
example : accepted m2_3_5 = [a,b] := by decide
def m2_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[b,c]⟩
example : correct m2_3_6 = true := by decide
example : unforgeable m2_3_6 = true := by decide
example : forgeries m2_3_6 = [] := by decide
example : accepted m2_3_6 = [a,b] := by decide
def m2_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b],[a,b,c]⟩
example : correct m2_3_7 = true := by decide
example : unforgeable m2_3_7 = false := by decide
example : forgeries m2_3_7 = [a] := by decide
example : accepted m2_3_7 = [a,b] := by decide
def m2_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[]⟩
example : correct m2_4_0 = false := by decide
example : unforgeable m2_4_0 = true := by decide
example : forgeries m2_4_0 = [] := by decide
example : accepted m2_4_0 = [c] := by decide
def m2_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[a]⟩
example : correct m2_4_1 = false := by decide
example : unforgeable m2_4_1 = true := by decide
example : forgeries m2_4_1 = [] := by decide
example : accepted m2_4_1 = [c] := by decide
def m2_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[b]⟩
example : correct m2_4_2 = false := by decide
example : unforgeable m2_4_2 = true := by decide
example : forgeries m2_4_2 = [] := by decide
example : accepted m2_4_2 = [c] := by decide
def m2_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[a,b]⟩
example : correct m2_4_3 = false := by decide
example : unforgeable m2_4_3 = true := by decide
example : forgeries m2_4_3 = [] := by decide
example : accepted m2_4_3 = [c] := by decide
def m2_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[c]⟩
example : correct m2_4_4 = false := by decide
example : unforgeable m2_4_4 = false := by decide
example : forgeries m2_4_4 = [c] := by decide
example : accepted m2_4_4 = [c] := by decide
def m2_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[a,c]⟩
example : correct m2_4_5 = false := by decide
example : unforgeable m2_4_5 = false := by decide
example : forgeries m2_4_5 = [c] := by decide
example : accepted m2_4_5 = [c] := by decide
def m2_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[b,c]⟩
example : correct m2_4_6 = false := by decide
example : unforgeable m2_4_6 = false := by decide
example : forgeries m2_4_6 = [c] := by decide
example : accepted m2_4_6 = [c] := by decide
def m2_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[c],[a,b,c]⟩
example : correct m2_4_7 = false := by decide
example : unforgeable m2_4_7 = false := by decide
example : forgeries m2_4_7 = [c] := by decide
example : accepted m2_4_7 = [c] := by decide
def m2_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[]⟩
example : correct m2_5_0 = false := by decide
example : unforgeable m2_5_0 = true := by decide
example : forgeries m2_5_0 = [] := by decide
example : accepted m2_5_0 = [a,c] := by decide
def m2_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[a]⟩
example : correct m2_5_1 = false := by decide
example : unforgeable m2_5_1 = false := by decide
example : forgeries m2_5_1 = [a] := by decide
example : accepted m2_5_1 = [a,c] := by decide
def m2_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[b]⟩
example : correct m2_5_2 = false := by decide
example : unforgeable m2_5_2 = true := by decide
example : forgeries m2_5_2 = [] := by decide
example : accepted m2_5_2 = [a,c] := by decide
def m2_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[a,b]⟩
example : correct m2_5_3 = false := by decide
example : unforgeable m2_5_3 = false := by decide
example : forgeries m2_5_3 = [a] := by decide
example : accepted m2_5_3 = [a,c] := by decide
def m2_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[c]⟩
example : correct m2_5_4 = false := by decide
example : unforgeable m2_5_4 = false := by decide
example : forgeries m2_5_4 = [c] := by decide
example : accepted m2_5_4 = [a,c] := by decide
def m2_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[a,c]⟩
example : correct m2_5_5 = false := by decide
example : unforgeable m2_5_5 = false := by decide
example : forgeries m2_5_5 = [a,c] := by decide
example : accepted m2_5_5 = [a,c] := by decide
def m2_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[b,c]⟩
example : correct m2_5_6 = false := by decide
example : unforgeable m2_5_6 = false := by decide
example : forgeries m2_5_6 = [c] := by decide
example : accepted m2_5_6 = [a,c] := by decide
def m2_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,c],[a,b,c]⟩
example : correct m2_5_7 = false := by decide
example : unforgeable m2_5_7 = false := by decide
example : forgeries m2_5_7 = [a,c] := by decide
example : accepted m2_5_7 = [a,c] := by decide
def m2_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[]⟩
example : correct m2_6_0 = true := by decide
example : unforgeable m2_6_0 = true := by decide
example : forgeries m2_6_0 = [] := by decide
example : accepted m2_6_0 = [b,c] := by decide
def m2_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[a]⟩
example : correct m2_6_1 = true := by decide
example : unforgeable m2_6_1 = true := by decide
example : forgeries m2_6_1 = [] := by decide
example : accepted m2_6_1 = [b,c] := by decide
def m2_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[b]⟩
example : correct m2_6_2 = true := by decide
example : unforgeable m2_6_2 = true := by decide
example : forgeries m2_6_2 = [] := by decide
example : accepted m2_6_2 = [b,c] := by decide
def m2_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[a,b]⟩
example : correct m2_6_3 = true := by decide
example : unforgeable m2_6_3 = true := by decide
example : forgeries m2_6_3 = [] := by decide
example : accepted m2_6_3 = [b,c] := by decide
def m2_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[c]⟩
example : correct m2_6_4 = true := by decide
example : unforgeable m2_6_4 = false := by decide
example : forgeries m2_6_4 = [c] := by decide
example : accepted m2_6_4 = [b,c] := by decide
def m2_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[a,c]⟩
example : correct m2_6_5 = true := by decide
example : unforgeable m2_6_5 = false := by decide
example : forgeries m2_6_5 = [c] := by decide
example : accepted m2_6_5 = [b,c] := by decide
def m2_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[b,c]⟩
example : correct m2_6_6 = true := by decide
example : unforgeable m2_6_6 = false := by decide
example : forgeries m2_6_6 = [c] := by decide
example : accepted m2_6_6 = [b,c] := by decide
def m2_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[b,c],[a,b,c]⟩
example : correct m2_6_7 = true := by decide
example : unforgeable m2_6_7 = false := by decide
example : forgeries m2_6_7 = [c] := by decide
example : accepted m2_6_7 = [b,c] := by decide
def m2_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[]⟩
example : correct m2_7_0 = true := by decide
example : unforgeable m2_7_0 = true := by decide
example : forgeries m2_7_0 = [] := by decide
example : accepted m2_7_0 = [a,b,c] := by decide
def m2_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[a]⟩
example : correct m2_7_1 = true := by decide
example : unforgeable m2_7_1 = false := by decide
example : forgeries m2_7_1 = [a] := by decide
example : accepted m2_7_1 = [a,b,c] := by decide
def m2_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[b]⟩
example : correct m2_7_2 = true := by decide
example : unforgeable m2_7_2 = true := by decide
example : forgeries m2_7_2 = [] := by decide
example : accepted m2_7_2 = [a,b,c] := by decide
def m2_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[a,b]⟩
example : correct m2_7_3 = true := by decide
example : unforgeable m2_7_3 = false := by decide
example : forgeries m2_7_3 = [a] := by decide
example : accepted m2_7_3 = [a,b,c] := by decide
def m2_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[c]⟩
example : correct m2_7_4 = true := by decide
example : unforgeable m2_7_4 = false := by decide
example : forgeries m2_7_4 = [c] := by decide
example : accepted m2_7_4 = [a,b,c] := by decide
def m2_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[a,c]⟩
example : correct m2_7_5 = true := by decide
example : unforgeable m2_7_5 = false := by decide
example : forgeries m2_7_5 = [a,c] := by decide
example : accepted m2_7_5 = [a,b,c] := by decide
def m2_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[b,c]⟩
example : correct m2_7_6 = true := by decide
example : unforgeable m2_7_6 = false := by decide
example : forgeries m2_7_6 = [c] := by decide
example : accepted m2_7_6 = [a,b,c] := by decide
def m2_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[b],[a,b,c],[a,b,c]⟩
example : correct m2_7_7 = true := by decide
example : unforgeable m2_7_7 = false := by decide
example : forgeries m2_7_7 = [a,c] := by decide
example : accepted m2_7_7 = [a,b,c] := by decide
def m3_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[]⟩
example : correct m3_0_0 = false := by decide
example : unforgeable m3_0_0 = true := by decide
example : forgeries m3_0_0 = [] := by decide
example : accepted m3_0_0 = [] := by decide
def m3_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[a]⟩
example : correct m3_0_1 = false := by decide
example : unforgeable m3_0_1 = true := by decide
example : forgeries m3_0_1 = [] := by decide
example : accepted m3_0_1 = [] := by decide
def m3_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[b]⟩
example : correct m3_0_2 = false := by decide
example : unforgeable m3_0_2 = true := by decide
example : forgeries m3_0_2 = [] := by decide
example : accepted m3_0_2 = [] := by decide
def m3_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[a,b]⟩
example : correct m3_0_3 = false := by decide
example : unforgeable m3_0_3 = true := by decide
example : forgeries m3_0_3 = [] := by decide
example : accepted m3_0_3 = [] := by decide
def m3_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[c]⟩
example : correct m3_0_4 = false := by decide
example : unforgeable m3_0_4 = true := by decide
example : forgeries m3_0_4 = [] := by decide
example : accepted m3_0_4 = [] := by decide
def m3_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[a,c]⟩
example : correct m3_0_5 = false := by decide
example : unforgeable m3_0_5 = true := by decide
example : forgeries m3_0_5 = [] := by decide
example : accepted m3_0_5 = [] := by decide
def m3_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[b,c]⟩
example : correct m3_0_6 = false := by decide
example : unforgeable m3_0_6 = true := by decide
example : forgeries m3_0_6 = [] := by decide
example : accepted m3_0_6 = [] := by decide
def m3_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[],[a,b,c]⟩
example : correct m3_0_7 = false := by decide
example : unforgeable m3_0_7 = true := by decide
example : forgeries m3_0_7 = [] := by decide
example : accepted m3_0_7 = [] := by decide
def m3_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[]⟩
example : correct m3_1_0 = false := by decide
example : unforgeable m3_1_0 = true := by decide
example : forgeries m3_1_0 = [] := by decide
example : accepted m3_1_0 = [a] := by decide
def m3_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[a]⟩
example : correct m3_1_1 = false := by decide
example : unforgeable m3_1_1 = true := by decide
example : forgeries m3_1_1 = [] := by decide
example : accepted m3_1_1 = [a] := by decide
def m3_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[b]⟩
example : correct m3_1_2 = false := by decide
example : unforgeable m3_1_2 = true := by decide
example : forgeries m3_1_2 = [] := by decide
example : accepted m3_1_2 = [a] := by decide
def m3_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[a,b]⟩
example : correct m3_1_3 = false := by decide
example : unforgeable m3_1_3 = true := by decide
example : forgeries m3_1_3 = [] := by decide
example : accepted m3_1_3 = [a] := by decide
def m3_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[c]⟩
example : correct m3_1_4 = false := by decide
example : unforgeable m3_1_4 = true := by decide
example : forgeries m3_1_4 = [] := by decide
example : accepted m3_1_4 = [a] := by decide
def m3_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[a,c]⟩
example : correct m3_1_5 = false := by decide
example : unforgeable m3_1_5 = true := by decide
example : forgeries m3_1_5 = [] := by decide
example : accepted m3_1_5 = [a] := by decide
def m3_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[b,c]⟩
example : correct m3_1_6 = false := by decide
example : unforgeable m3_1_6 = true := by decide
example : forgeries m3_1_6 = [] := by decide
example : accepted m3_1_6 = [a] := by decide
def m3_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a],[a,b,c]⟩
example : correct m3_1_7 = false := by decide
example : unforgeable m3_1_7 = true := by decide
example : forgeries m3_1_7 = [] := by decide
example : accepted m3_1_7 = [a] := by decide
def m3_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[]⟩
example : correct m3_2_0 = false := by decide
example : unforgeable m3_2_0 = true := by decide
example : forgeries m3_2_0 = [] := by decide
example : accepted m3_2_0 = [b] := by decide
def m3_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[a]⟩
example : correct m3_2_1 = false := by decide
example : unforgeable m3_2_1 = true := by decide
example : forgeries m3_2_1 = [] := by decide
example : accepted m3_2_1 = [b] := by decide
def m3_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[b]⟩
example : correct m3_2_2 = false := by decide
example : unforgeable m3_2_2 = true := by decide
example : forgeries m3_2_2 = [] := by decide
example : accepted m3_2_2 = [b] := by decide
def m3_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[a,b]⟩
example : correct m3_2_3 = false := by decide
example : unforgeable m3_2_3 = true := by decide
example : forgeries m3_2_3 = [] := by decide
example : accepted m3_2_3 = [b] := by decide
def m3_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[c]⟩
example : correct m3_2_4 = false := by decide
example : unforgeable m3_2_4 = true := by decide
example : forgeries m3_2_4 = [] := by decide
example : accepted m3_2_4 = [b] := by decide
def m3_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[a,c]⟩
example : correct m3_2_5 = false := by decide
example : unforgeable m3_2_5 = true := by decide
example : forgeries m3_2_5 = [] := by decide
example : accepted m3_2_5 = [b] := by decide
def m3_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[b,c]⟩
example : correct m3_2_6 = false := by decide
example : unforgeable m3_2_6 = true := by decide
example : forgeries m3_2_6 = [] := by decide
example : accepted m3_2_6 = [b] := by decide
def m3_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b],[a,b,c]⟩
example : correct m3_2_7 = false := by decide
example : unforgeable m3_2_7 = true := by decide
example : forgeries m3_2_7 = [] := by decide
example : accepted m3_2_7 = [b] := by decide
def m3_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[]⟩
example : correct m3_3_0 = true := by decide
example : unforgeable m3_3_0 = true := by decide
example : forgeries m3_3_0 = [] := by decide
example : accepted m3_3_0 = [a,b] := by decide
def m3_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[a]⟩
example : correct m3_3_1 = true := by decide
example : unforgeable m3_3_1 = true := by decide
example : forgeries m3_3_1 = [] := by decide
example : accepted m3_3_1 = [a,b] := by decide
def m3_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[b]⟩
example : correct m3_3_2 = true := by decide
example : unforgeable m3_3_2 = true := by decide
example : forgeries m3_3_2 = [] := by decide
example : accepted m3_3_2 = [a,b] := by decide
def m3_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[a,b]⟩
example : correct m3_3_3 = true := by decide
example : unforgeable m3_3_3 = true := by decide
example : forgeries m3_3_3 = [] := by decide
example : accepted m3_3_3 = [a,b] := by decide
def m3_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[c]⟩
example : correct m3_3_4 = true := by decide
example : unforgeable m3_3_4 = true := by decide
example : forgeries m3_3_4 = [] := by decide
example : accepted m3_3_4 = [a,b] := by decide
def m3_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[a,c]⟩
example : correct m3_3_5 = true := by decide
example : unforgeable m3_3_5 = true := by decide
example : forgeries m3_3_5 = [] := by decide
example : accepted m3_3_5 = [a,b] := by decide
def m3_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[b,c]⟩
example : correct m3_3_6 = true := by decide
example : unforgeable m3_3_6 = true := by decide
example : forgeries m3_3_6 = [] := by decide
example : accepted m3_3_6 = [a,b] := by decide
def m3_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b],[a,b,c]⟩
example : correct m3_3_7 = true := by decide
example : unforgeable m3_3_7 = true := by decide
example : forgeries m3_3_7 = [] := by decide
example : accepted m3_3_7 = [a,b] := by decide
def m3_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[]⟩
example : correct m3_4_0 = false := by decide
example : unforgeable m3_4_0 = true := by decide
example : forgeries m3_4_0 = [] := by decide
example : accepted m3_4_0 = [c] := by decide
def m3_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[a]⟩
example : correct m3_4_1 = false := by decide
example : unforgeable m3_4_1 = true := by decide
example : forgeries m3_4_1 = [] := by decide
example : accepted m3_4_1 = [c] := by decide
def m3_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[b]⟩
example : correct m3_4_2 = false := by decide
example : unforgeable m3_4_2 = true := by decide
example : forgeries m3_4_2 = [] := by decide
example : accepted m3_4_2 = [c] := by decide
def m3_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[a,b]⟩
example : correct m3_4_3 = false := by decide
example : unforgeable m3_4_3 = true := by decide
example : forgeries m3_4_3 = [] := by decide
example : accepted m3_4_3 = [c] := by decide
def m3_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[c]⟩
example : correct m3_4_4 = false := by decide
example : unforgeable m3_4_4 = false := by decide
example : forgeries m3_4_4 = [c] := by decide
example : accepted m3_4_4 = [c] := by decide
def m3_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[a,c]⟩
example : correct m3_4_5 = false := by decide
example : unforgeable m3_4_5 = false := by decide
example : forgeries m3_4_5 = [c] := by decide
example : accepted m3_4_5 = [c] := by decide
def m3_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[b,c]⟩
example : correct m3_4_6 = false := by decide
example : unforgeable m3_4_6 = false := by decide
example : forgeries m3_4_6 = [c] := by decide
example : accepted m3_4_6 = [c] := by decide
def m3_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[c],[a,b,c]⟩
example : correct m3_4_7 = false := by decide
example : unforgeable m3_4_7 = false := by decide
example : forgeries m3_4_7 = [c] := by decide
example : accepted m3_4_7 = [c] := by decide
def m3_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[]⟩
example : correct m3_5_0 = false := by decide
example : unforgeable m3_5_0 = true := by decide
example : forgeries m3_5_0 = [] := by decide
example : accepted m3_5_0 = [a,c] := by decide
def m3_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[a]⟩
example : correct m3_5_1 = false := by decide
example : unforgeable m3_5_1 = true := by decide
example : forgeries m3_5_1 = [] := by decide
example : accepted m3_5_1 = [a,c] := by decide
def m3_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[b]⟩
example : correct m3_5_2 = false := by decide
example : unforgeable m3_5_2 = true := by decide
example : forgeries m3_5_2 = [] := by decide
example : accepted m3_5_2 = [a,c] := by decide
def m3_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[a,b]⟩
example : correct m3_5_3 = false := by decide
example : unforgeable m3_5_3 = true := by decide
example : forgeries m3_5_3 = [] := by decide
example : accepted m3_5_3 = [a,c] := by decide
def m3_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[c]⟩
example : correct m3_5_4 = false := by decide
example : unforgeable m3_5_4 = false := by decide
example : forgeries m3_5_4 = [c] := by decide
example : accepted m3_5_4 = [a,c] := by decide
def m3_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[a,c]⟩
example : correct m3_5_5 = false := by decide
example : unforgeable m3_5_5 = false := by decide
example : forgeries m3_5_5 = [c] := by decide
example : accepted m3_5_5 = [a,c] := by decide
def m3_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[b,c]⟩
example : correct m3_5_6 = false := by decide
example : unforgeable m3_5_6 = false := by decide
example : forgeries m3_5_6 = [c] := by decide
example : accepted m3_5_6 = [a,c] := by decide
def m3_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,c],[a,b,c]⟩
example : correct m3_5_7 = false := by decide
example : unforgeable m3_5_7 = false := by decide
example : forgeries m3_5_7 = [c] := by decide
example : accepted m3_5_7 = [a,c] := by decide
def m3_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[]⟩
example : correct m3_6_0 = false := by decide
example : unforgeable m3_6_0 = true := by decide
example : forgeries m3_6_0 = [] := by decide
example : accepted m3_6_0 = [b,c] := by decide
def m3_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[a]⟩
example : correct m3_6_1 = false := by decide
example : unforgeable m3_6_1 = true := by decide
example : forgeries m3_6_1 = [] := by decide
example : accepted m3_6_1 = [b,c] := by decide
def m3_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[b]⟩
example : correct m3_6_2 = false := by decide
example : unforgeable m3_6_2 = true := by decide
example : forgeries m3_6_2 = [] := by decide
example : accepted m3_6_2 = [b,c] := by decide
def m3_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[a,b]⟩
example : correct m3_6_3 = false := by decide
example : unforgeable m3_6_3 = true := by decide
example : forgeries m3_6_3 = [] := by decide
example : accepted m3_6_3 = [b,c] := by decide
def m3_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[c]⟩
example : correct m3_6_4 = false := by decide
example : unforgeable m3_6_4 = false := by decide
example : forgeries m3_6_4 = [c] := by decide
example : accepted m3_6_4 = [b,c] := by decide
def m3_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[a,c]⟩
example : correct m3_6_5 = false := by decide
example : unforgeable m3_6_5 = false := by decide
example : forgeries m3_6_5 = [c] := by decide
example : accepted m3_6_5 = [b,c] := by decide
def m3_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[b,c]⟩
example : correct m3_6_6 = false := by decide
example : unforgeable m3_6_6 = false := by decide
example : forgeries m3_6_6 = [c] := by decide
example : accepted m3_6_6 = [b,c] := by decide
def m3_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[b,c],[a,b,c]⟩
example : correct m3_6_7 = false := by decide
example : unforgeable m3_6_7 = false := by decide
example : forgeries m3_6_7 = [c] := by decide
example : accepted m3_6_7 = [b,c] := by decide
def m3_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[]⟩
example : correct m3_7_0 = true := by decide
example : unforgeable m3_7_0 = true := by decide
example : forgeries m3_7_0 = [] := by decide
example : accepted m3_7_0 = [a,b,c] := by decide
def m3_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[a]⟩
example : correct m3_7_1 = true := by decide
example : unforgeable m3_7_1 = true := by decide
example : forgeries m3_7_1 = [] := by decide
example : accepted m3_7_1 = [a,b,c] := by decide
def m3_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[b]⟩
example : correct m3_7_2 = true := by decide
example : unforgeable m3_7_2 = true := by decide
example : forgeries m3_7_2 = [] := by decide
example : accepted m3_7_2 = [a,b,c] := by decide
def m3_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[a,b]⟩
example : correct m3_7_3 = true := by decide
example : unforgeable m3_7_3 = true := by decide
example : forgeries m3_7_3 = [] := by decide
example : accepted m3_7_3 = [a,b,c] := by decide
def m3_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[c]⟩
example : correct m3_7_4 = true := by decide
example : unforgeable m3_7_4 = false := by decide
example : forgeries m3_7_4 = [c] := by decide
example : accepted m3_7_4 = [a,b,c] := by decide
def m3_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[a,c]⟩
example : correct m3_7_5 = true := by decide
example : unforgeable m3_7_5 = false := by decide
example : forgeries m3_7_5 = [c] := by decide
example : accepted m3_7_5 = [a,b,c] := by decide
def m3_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[b,c]⟩
example : correct m3_7_6 = true := by decide
example : unforgeable m3_7_6 = false := by decide
example : forgeries m3_7_6 = [c] := by decide
example : accepted m3_7_6 = [a,b,c] := by decide
def m3_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[a,b,c],[a,b,c]⟩
example : correct m3_7_7 = true := by decide
example : unforgeable m3_7_7 = false := by decide
example : forgeries m3_7_7 = [c] := by decide
example : accepted m3_7_7 = [a,b,c] := by decide
def m4_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[]⟩
example : correct m4_0_0 = false := by decide
example : unforgeable m4_0_0 = true := by decide
example : forgeries m4_0_0 = [] := by decide
example : accepted m4_0_0 = [] := by decide
def m4_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[a]⟩
example : correct m4_0_1 = false := by decide
example : unforgeable m4_0_1 = true := by decide
example : forgeries m4_0_1 = [] := by decide
example : accepted m4_0_1 = [] := by decide
def m4_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[b]⟩
example : correct m4_0_2 = false := by decide
example : unforgeable m4_0_2 = true := by decide
example : forgeries m4_0_2 = [] := by decide
example : accepted m4_0_2 = [] := by decide
def m4_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[a,b]⟩
example : correct m4_0_3 = false := by decide
example : unforgeable m4_0_3 = true := by decide
example : forgeries m4_0_3 = [] := by decide
example : accepted m4_0_3 = [] := by decide
def m4_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[c]⟩
example : correct m4_0_4 = false := by decide
example : unforgeable m4_0_4 = true := by decide
example : forgeries m4_0_4 = [] := by decide
example : accepted m4_0_4 = [] := by decide
def m4_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[a,c]⟩
example : correct m4_0_5 = false := by decide
example : unforgeable m4_0_5 = true := by decide
example : forgeries m4_0_5 = [] := by decide
example : accepted m4_0_5 = [] := by decide
def m4_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[b,c]⟩
example : correct m4_0_6 = false := by decide
example : unforgeable m4_0_6 = true := by decide
example : forgeries m4_0_6 = [] := by decide
example : accepted m4_0_6 = [] := by decide
def m4_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[],[a,b,c]⟩
example : correct m4_0_7 = false := by decide
example : unforgeable m4_0_7 = true := by decide
example : forgeries m4_0_7 = [] := by decide
example : accepted m4_0_7 = [] := by decide
def m4_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[]⟩
example : correct m4_1_0 = false := by decide
example : unforgeable m4_1_0 = true := by decide
example : forgeries m4_1_0 = [] := by decide
example : accepted m4_1_0 = [a] := by decide
def m4_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[a]⟩
example : correct m4_1_1 = false := by decide
example : unforgeable m4_1_1 = false := by decide
example : forgeries m4_1_1 = [a] := by decide
example : accepted m4_1_1 = [a] := by decide
def m4_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[b]⟩
example : correct m4_1_2 = false := by decide
example : unforgeable m4_1_2 = true := by decide
example : forgeries m4_1_2 = [] := by decide
example : accepted m4_1_2 = [a] := by decide
def m4_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[a,b]⟩
example : correct m4_1_3 = false := by decide
example : unforgeable m4_1_3 = false := by decide
example : forgeries m4_1_3 = [a] := by decide
example : accepted m4_1_3 = [a] := by decide
def m4_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[c]⟩
example : correct m4_1_4 = false := by decide
example : unforgeable m4_1_4 = true := by decide
example : forgeries m4_1_4 = [] := by decide
example : accepted m4_1_4 = [a] := by decide
def m4_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[a,c]⟩
example : correct m4_1_5 = false := by decide
example : unforgeable m4_1_5 = false := by decide
example : forgeries m4_1_5 = [a] := by decide
example : accepted m4_1_5 = [a] := by decide
def m4_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[b,c]⟩
example : correct m4_1_6 = false := by decide
example : unforgeable m4_1_6 = true := by decide
example : forgeries m4_1_6 = [] := by decide
example : accepted m4_1_6 = [a] := by decide
def m4_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a],[a,b,c]⟩
example : correct m4_1_7 = false := by decide
example : unforgeable m4_1_7 = false := by decide
example : forgeries m4_1_7 = [a] := by decide
example : accepted m4_1_7 = [a] := by decide
def m4_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[]⟩
example : correct m4_2_0 = false := by decide
example : unforgeable m4_2_0 = true := by decide
example : forgeries m4_2_0 = [] := by decide
example : accepted m4_2_0 = [b] := by decide
def m4_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[a]⟩
example : correct m4_2_1 = false := by decide
example : unforgeable m4_2_1 = true := by decide
example : forgeries m4_2_1 = [] := by decide
example : accepted m4_2_1 = [b] := by decide
def m4_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[b]⟩
example : correct m4_2_2 = false := by decide
example : unforgeable m4_2_2 = false := by decide
example : forgeries m4_2_2 = [b] := by decide
example : accepted m4_2_2 = [b] := by decide
def m4_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[a,b]⟩
example : correct m4_2_3 = false := by decide
example : unforgeable m4_2_3 = false := by decide
example : forgeries m4_2_3 = [b] := by decide
example : accepted m4_2_3 = [b] := by decide
def m4_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[c]⟩
example : correct m4_2_4 = false := by decide
example : unforgeable m4_2_4 = true := by decide
example : forgeries m4_2_4 = [] := by decide
example : accepted m4_2_4 = [b] := by decide
def m4_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[a,c]⟩
example : correct m4_2_5 = false := by decide
example : unforgeable m4_2_5 = true := by decide
example : forgeries m4_2_5 = [] := by decide
example : accepted m4_2_5 = [b] := by decide
def m4_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[b,c]⟩
example : correct m4_2_6 = false := by decide
example : unforgeable m4_2_6 = false := by decide
example : forgeries m4_2_6 = [b] := by decide
example : accepted m4_2_6 = [b] := by decide
def m4_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b],[a,b,c]⟩
example : correct m4_2_7 = false := by decide
example : unforgeable m4_2_7 = false := by decide
example : forgeries m4_2_7 = [b] := by decide
example : accepted m4_2_7 = [b] := by decide
def m4_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[]⟩
example : correct m4_3_0 = false := by decide
example : unforgeable m4_3_0 = true := by decide
example : forgeries m4_3_0 = [] := by decide
example : accepted m4_3_0 = [a,b] := by decide
def m4_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[a]⟩
example : correct m4_3_1 = false := by decide
example : unforgeable m4_3_1 = false := by decide
example : forgeries m4_3_1 = [a] := by decide
example : accepted m4_3_1 = [a,b] := by decide
def m4_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[b]⟩
example : correct m4_3_2 = false := by decide
example : unforgeable m4_3_2 = false := by decide
example : forgeries m4_3_2 = [b] := by decide
example : accepted m4_3_2 = [a,b] := by decide
def m4_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[a,b]⟩
example : correct m4_3_3 = false := by decide
example : unforgeable m4_3_3 = false := by decide
example : forgeries m4_3_3 = [a,b] := by decide
example : accepted m4_3_3 = [a,b] := by decide
def m4_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[c]⟩
example : correct m4_3_4 = false := by decide
example : unforgeable m4_3_4 = true := by decide
example : forgeries m4_3_4 = [] := by decide
example : accepted m4_3_4 = [a,b] := by decide
def m4_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[a,c]⟩
example : correct m4_3_5 = false := by decide
example : unforgeable m4_3_5 = false := by decide
example : forgeries m4_3_5 = [a] := by decide
example : accepted m4_3_5 = [a,b] := by decide
def m4_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[b,c]⟩
example : correct m4_3_6 = false := by decide
example : unforgeable m4_3_6 = false := by decide
example : forgeries m4_3_6 = [b] := by decide
example : accepted m4_3_6 = [a,b] := by decide
def m4_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b],[a,b,c]⟩
example : correct m4_3_7 = false := by decide
example : unforgeable m4_3_7 = false := by decide
example : forgeries m4_3_7 = [a,b] := by decide
example : accepted m4_3_7 = [a,b] := by decide
def m4_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[]⟩
example : correct m4_4_0 = true := by decide
example : unforgeable m4_4_0 = true := by decide
example : forgeries m4_4_0 = [] := by decide
example : accepted m4_4_0 = [c] := by decide
def m4_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[a]⟩
example : correct m4_4_1 = true := by decide
example : unforgeable m4_4_1 = true := by decide
example : forgeries m4_4_1 = [] := by decide
example : accepted m4_4_1 = [c] := by decide
def m4_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[b]⟩
example : correct m4_4_2 = true := by decide
example : unforgeable m4_4_2 = true := by decide
example : forgeries m4_4_2 = [] := by decide
example : accepted m4_4_2 = [c] := by decide
def m4_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[a,b]⟩
example : correct m4_4_3 = true := by decide
example : unforgeable m4_4_3 = true := by decide
example : forgeries m4_4_3 = [] := by decide
example : accepted m4_4_3 = [c] := by decide
def m4_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[c]⟩
example : correct m4_4_4 = true := by decide
example : unforgeable m4_4_4 = true := by decide
example : forgeries m4_4_4 = [] := by decide
example : accepted m4_4_4 = [c] := by decide
def m4_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[a,c]⟩
example : correct m4_4_5 = true := by decide
example : unforgeable m4_4_5 = true := by decide
example : forgeries m4_4_5 = [] := by decide
example : accepted m4_4_5 = [c] := by decide
def m4_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[b,c]⟩
example : correct m4_4_6 = true := by decide
example : unforgeable m4_4_6 = true := by decide
example : forgeries m4_4_6 = [] := by decide
example : accepted m4_4_6 = [c] := by decide
def m4_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[c],[a,b,c]⟩
example : correct m4_4_7 = true := by decide
example : unforgeable m4_4_7 = true := by decide
example : forgeries m4_4_7 = [] := by decide
example : accepted m4_4_7 = [c] := by decide
def m4_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[]⟩
example : correct m4_5_0 = true := by decide
example : unforgeable m4_5_0 = true := by decide
example : forgeries m4_5_0 = [] := by decide
example : accepted m4_5_0 = [a,c] := by decide
def m4_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[a]⟩
example : correct m4_5_1 = true := by decide
example : unforgeable m4_5_1 = false := by decide
example : forgeries m4_5_1 = [a] := by decide
example : accepted m4_5_1 = [a,c] := by decide
def m4_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[b]⟩
example : correct m4_5_2 = true := by decide
example : unforgeable m4_5_2 = true := by decide
example : forgeries m4_5_2 = [] := by decide
example : accepted m4_5_2 = [a,c] := by decide
def m4_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[a,b]⟩
example : correct m4_5_3 = true := by decide
example : unforgeable m4_5_3 = false := by decide
example : forgeries m4_5_3 = [a] := by decide
example : accepted m4_5_3 = [a,c] := by decide
def m4_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[c]⟩
example : correct m4_5_4 = true := by decide
example : unforgeable m4_5_4 = true := by decide
example : forgeries m4_5_4 = [] := by decide
example : accepted m4_5_4 = [a,c] := by decide
def m4_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[a,c]⟩
example : correct m4_5_5 = true := by decide
example : unforgeable m4_5_5 = false := by decide
example : forgeries m4_5_5 = [a] := by decide
example : accepted m4_5_5 = [a,c] := by decide
def m4_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[b,c]⟩
example : correct m4_5_6 = true := by decide
example : unforgeable m4_5_6 = true := by decide
example : forgeries m4_5_6 = [] := by decide
example : accepted m4_5_6 = [a,c] := by decide
def m4_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,c],[a,b,c]⟩
example : correct m4_5_7 = true := by decide
example : unforgeable m4_5_7 = false := by decide
example : forgeries m4_5_7 = [a] := by decide
example : accepted m4_5_7 = [a,c] := by decide
def m4_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[]⟩
example : correct m4_6_0 = true := by decide
example : unforgeable m4_6_0 = true := by decide
example : forgeries m4_6_0 = [] := by decide
example : accepted m4_6_0 = [b,c] := by decide
def m4_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[a]⟩
example : correct m4_6_1 = true := by decide
example : unforgeable m4_6_1 = true := by decide
example : forgeries m4_6_1 = [] := by decide
example : accepted m4_6_1 = [b,c] := by decide
def m4_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[b]⟩
example : correct m4_6_2 = true := by decide
example : unforgeable m4_6_2 = false := by decide
example : forgeries m4_6_2 = [b] := by decide
example : accepted m4_6_2 = [b,c] := by decide
def m4_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[a,b]⟩
example : correct m4_6_3 = true := by decide
example : unforgeable m4_6_3 = false := by decide
example : forgeries m4_6_3 = [b] := by decide
example : accepted m4_6_3 = [b,c] := by decide
def m4_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[c]⟩
example : correct m4_6_4 = true := by decide
example : unforgeable m4_6_4 = true := by decide
example : forgeries m4_6_4 = [] := by decide
example : accepted m4_6_4 = [b,c] := by decide
def m4_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[a,c]⟩
example : correct m4_6_5 = true := by decide
example : unforgeable m4_6_5 = true := by decide
example : forgeries m4_6_5 = [] := by decide
example : accepted m4_6_5 = [b,c] := by decide
def m4_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[b,c]⟩
example : correct m4_6_6 = true := by decide
example : unforgeable m4_6_6 = false := by decide
example : forgeries m4_6_6 = [b] := by decide
example : accepted m4_6_6 = [b,c] := by decide
def m4_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[b,c],[a,b,c]⟩
example : correct m4_6_7 = true := by decide
example : unforgeable m4_6_7 = false := by decide
example : forgeries m4_6_7 = [b] := by decide
example : accepted m4_6_7 = [b,c] := by decide
def m4_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[]⟩
example : correct m4_7_0 = true := by decide
example : unforgeable m4_7_0 = true := by decide
example : forgeries m4_7_0 = [] := by decide
example : accepted m4_7_0 = [a,b,c] := by decide
def m4_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[a]⟩
example : correct m4_7_1 = true := by decide
example : unforgeable m4_7_1 = false := by decide
example : forgeries m4_7_1 = [a] := by decide
example : accepted m4_7_1 = [a,b,c] := by decide
def m4_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[b]⟩
example : correct m4_7_2 = true := by decide
example : unforgeable m4_7_2 = false := by decide
example : forgeries m4_7_2 = [b] := by decide
example : accepted m4_7_2 = [a,b,c] := by decide
def m4_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[a,b]⟩
example : correct m4_7_3 = true := by decide
example : unforgeable m4_7_3 = false := by decide
example : forgeries m4_7_3 = [a,b] := by decide
example : accepted m4_7_3 = [a,b,c] := by decide
def m4_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[c]⟩
example : correct m4_7_4 = true := by decide
example : unforgeable m4_7_4 = true := by decide
example : forgeries m4_7_4 = [] := by decide
example : accepted m4_7_4 = [a,b,c] := by decide
def m4_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[a,c]⟩
example : correct m4_7_5 = true := by decide
example : unforgeable m4_7_5 = false := by decide
example : forgeries m4_7_5 = [a] := by decide
example : accepted m4_7_5 = [a,b,c] := by decide
def m4_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[b,c]⟩
example : correct m4_7_6 = true := by decide
example : unforgeable m4_7_6 = false := by decide
example : forgeries m4_7_6 = [b] := by decide
example : accepted m4_7_6 = [a,b,c] := by decide
def m4_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[c],[a,b,c],[a,b,c]⟩
example : correct m4_7_7 = true := by decide
example : unforgeable m4_7_7 = false := by decide
example : forgeries m4_7_7 = [a,b] := by decide
example : accepted m4_7_7 = [a,b,c] := by decide
def m5_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[]⟩
example : correct m5_0_0 = false := by decide
example : unforgeable m5_0_0 = true := by decide
example : forgeries m5_0_0 = [] := by decide
example : accepted m5_0_0 = [] := by decide
def m5_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[a]⟩
example : correct m5_0_1 = false := by decide
example : unforgeable m5_0_1 = true := by decide
example : forgeries m5_0_1 = [] := by decide
example : accepted m5_0_1 = [] := by decide
def m5_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[b]⟩
example : correct m5_0_2 = false := by decide
example : unforgeable m5_0_2 = true := by decide
example : forgeries m5_0_2 = [] := by decide
example : accepted m5_0_2 = [] := by decide
def m5_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[a,b]⟩
example : correct m5_0_3 = false := by decide
example : unforgeable m5_0_3 = true := by decide
example : forgeries m5_0_3 = [] := by decide
example : accepted m5_0_3 = [] := by decide
def m5_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[c]⟩
example : correct m5_0_4 = false := by decide
example : unforgeable m5_0_4 = true := by decide
example : forgeries m5_0_4 = [] := by decide
example : accepted m5_0_4 = [] := by decide
def m5_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[a,c]⟩
example : correct m5_0_5 = false := by decide
example : unforgeable m5_0_5 = true := by decide
example : forgeries m5_0_5 = [] := by decide
example : accepted m5_0_5 = [] := by decide
def m5_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[b,c]⟩
example : correct m5_0_6 = false := by decide
example : unforgeable m5_0_6 = true := by decide
example : forgeries m5_0_6 = [] := by decide
example : accepted m5_0_6 = [] := by decide
def m5_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[],[a,b,c]⟩
example : correct m5_0_7 = false := by decide
example : unforgeable m5_0_7 = true := by decide
example : forgeries m5_0_7 = [] := by decide
example : accepted m5_0_7 = [] := by decide
def m5_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[]⟩
example : correct m5_1_0 = false := by decide
example : unforgeable m5_1_0 = true := by decide
example : forgeries m5_1_0 = [] := by decide
example : accepted m5_1_0 = [a] := by decide
def m5_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[a]⟩
example : correct m5_1_1 = false := by decide
example : unforgeable m5_1_1 = true := by decide
example : forgeries m5_1_1 = [] := by decide
example : accepted m5_1_1 = [a] := by decide
def m5_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[b]⟩
example : correct m5_1_2 = false := by decide
example : unforgeable m5_1_2 = true := by decide
example : forgeries m5_1_2 = [] := by decide
example : accepted m5_1_2 = [a] := by decide
def m5_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[a,b]⟩
example : correct m5_1_3 = false := by decide
example : unforgeable m5_1_3 = true := by decide
example : forgeries m5_1_3 = [] := by decide
example : accepted m5_1_3 = [a] := by decide
def m5_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[c]⟩
example : correct m5_1_4 = false := by decide
example : unforgeable m5_1_4 = true := by decide
example : forgeries m5_1_4 = [] := by decide
example : accepted m5_1_4 = [a] := by decide
def m5_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[a,c]⟩
example : correct m5_1_5 = false := by decide
example : unforgeable m5_1_5 = true := by decide
example : forgeries m5_1_5 = [] := by decide
example : accepted m5_1_5 = [a] := by decide
def m5_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[b,c]⟩
example : correct m5_1_6 = false := by decide
example : unforgeable m5_1_6 = true := by decide
example : forgeries m5_1_6 = [] := by decide
example : accepted m5_1_6 = [a] := by decide
def m5_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a],[a,b,c]⟩
example : correct m5_1_7 = false := by decide
example : unforgeable m5_1_7 = true := by decide
example : forgeries m5_1_7 = [] := by decide
example : accepted m5_1_7 = [a] := by decide
def m5_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[]⟩
example : correct m5_2_0 = false := by decide
example : unforgeable m5_2_0 = true := by decide
example : forgeries m5_2_0 = [] := by decide
example : accepted m5_2_0 = [b] := by decide
def m5_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[a]⟩
example : correct m5_2_1 = false := by decide
example : unforgeable m5_2_1 = true := by decide
example : forgeries m5_2_1 = [] := by decide
example : accepted m5_2_1 = [b] := by decide
def m5_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[b]⟩
example : correct m5_2_2 = false := by decide
example : unforgeable m5_2_2 = false := by decide
example : forgeries m5_2_2 = [b] := by decide
example : accepted m5_2_2 = [b] := by decide
def m5_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[a,b]⟩
example : correct m5_2_3 = false := by decide
example : unforgeable m5_2_3 = false := by decide
example : forgeries m5_2_3 = [b] := by decide
example : accepted m5_2_3 = [b] := by decide
def m5_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[c]⟩
example : correct m5_2_4 = false := by decide
example : unforgeable m5_2_4 = true := by decide
example : forgeries m5_2_4 = [] := by decide
example : accepted m5_2_4 = [b] := by decide
def m5_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[a,c]⟩
example : correct m5_2_5 = false := by decide
example : unforgeable m5_2_5 = true := by decide
example : forgeries m5_2_5 = [] := by decide
example : accepted m5_2_5 = [b] := by decide
def m5_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[b,c]⟩
example : correct m5_2_6 = false := by decide
example : unforgeable m5_2_6 = false := by decide
example : forgeries m5_2_6 = [b] := by decide
example : accepted m5_2_6 = [b] := by decide
def m5_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b],[a,b,c]⟩
example : correct m5_2_7 = false := by decide
example : unforgeable m5_2_7 = false := by decide
example : forgeries m5_2_7 = [b] := by decide
example : accepted m5_2_7 = [b] := by decide
def m5_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[]⟩
example : correct m5_3_0 = false := by decide
example : unforgeable m5_3_0 = true := by decide
example : forgeries m5_3_0 = [] := by decide
example : accepted m5_3_0 = [a,b] := by decide
def m5_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[a]⟩
example : correct m5_3_1 = false := by decide
example : unforgeable m5_3_1 = true := by decide
example : forgeries m5_3_1 = [] := by decide
example : accepted m5_3_1 = [a,b] := by decide
def m5_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[b]⟩
example : correct m5_3_2 = false := by decide
example : unforgeable m5_3_2 = false := by decide
example : forgeries m5_3_2 = [b] := by decide
example : accepted m5_3_2 = [a,b] := by decide
def m5_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[a,b]⟩
example : correct m5_3_3 = false := by decide
example : unforgeable m5_3_3 = false := by decide
example : forgeries m5_3_3 = [b] := by decide
example : accepted m5_3_3 = [a,b] := by decide
def m5_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[c]⟩
example : correct m5_3_4 = false := by decide
example : unforgeable m5_3_4 = true := by decide
example : forgeries m5_3_4 = [] := by decide
example : accepted m5_3_4 = [a,b] := by decide
def m5_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[a,c]⟩
example : correct m5_3_5 = false := by decide
example : unforgeable m5_3_5 = true := by decide
example : forgeries m5_3_5 = [] := by decide
example : accepted m5_3_5 = [a,b] := by decide
def m5_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[b,c]⟩
example : correct m5_3_6 = false := by decide
example : unforgeable m5_3_6 = false := by decide
example : forgeries m5_3_6 = [b] := by decide
example : accepted m5_3_6 = [a,b] := by decide
def m5_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b],[a,b,c]⟩
example : correct m5_3_7 = false := by decide
example : unforgeable m5_3_7 = false := by decide
example : forgeries m5_3_7 = [b] := by decide
example : accepted m5_3_7 = [a,b] := by decide
def m5_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[]⟩
example : correct m5_4_0 = false := by decide
example : unforgeable m5_4_0 = true := by decide
example : forgeries m5_4_0 = [] := by decide
example : accepted m5_4_0 = [c] := by decide
def m5_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[a]⟩
example : correct m5_4_1 = false := by decide
example : unforgeable m5_4_1 = true := by decide
example : forgeries m5_4_1 = [] := by decide
example : accepted m5_4_1 = [c] := by decide
def m5_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[b]⟩
example : correct m5_4_2 = false := by decide
example : unforgeable m5_4_2 = true := by decide
example : forgeries m5_4_2 = [] := by decide
example : accepted m5_4_2 = [c] := by decide
def m5_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[a,b]⟩
example : correct m5_4_3 = false := by decide
example : unforgeable m5_4_3 = true := by decide
example : forgeries m5_4_3 = [] := by decide
example : accepted m5_4_3 = [c] := by decide
def m5_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[c]⟩
example : correct m5_4_4 = false := by decide
example : unforgeable m5_4_4 = true := by decide
example : forgeries m5_4_4 = [] := by decide
example : accepted m5_4_4 = [c] := by decide
def m5_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[a,c]⟩
example : correct m5_4_5 = false := by decide
example : unforgeable m5_4_5 = true := by decide
example : forgeries m5_4_5 = [] := by decide
example : accepted m5_4_5 = [c] := by decide
def m5_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[b,c]⟩
example : correct m5_4_6 = false := by decide
example : unforgeable m5_4_6 = true := by decide
example : forgeries m5_4_6 = [] := by decide
example : accepted m5_4_6 = [c] := by decide
def m5_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[c],[a,b,c]⟩
example : correct m5_4_7 = false := by decide
example : unforgeable m5_4_7 = true := by decide
example : forgeries m5_4_7 = [] := by decide
example : accepted m5_4_7 = [c] := by decide
def m5_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[]⟩
example : correct m5_5_0 = true := by decide
example : unforgeable m5_5_0 = true := by decide
example : forgeries m5_5_0 = [] := by decide
example : accepted m5_5_0 = [a,c] := by decide
def m5_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[a]⟩
example : correct m5_5_1 = true := by decide
example : unforgeable m5_5_1 = true := by decide
example : forgeries m5_5_1 = [] := by decide
example : accepted m5_5_1 = [a,c] := by decide
def m5_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[b]⟩
example : correct m5_5_2 = true := by decide
example : unforgeable m5_5_2 = true := by decide
example : forgeries m5_5_2 = [] := by decide
example : accepted m5_5_2 = [a,c] := by decide
def m5_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[a,b]⟩
example : correct m5_5_3 = true := by decide
example : unforgeable m5_5_3 = true := by decide
example : forgeries m5_5_3 = [] := by decide
example : accepted m5_5_3 = [a,c] := by decide
def m5_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[c]⟩
example : correct m5_5_4 = true := by decide
example : unforgeable m5_5_4 = true := by decide
example : forgeries m5_5_4 = [] := by decide
example : accepted m5_5_4 = [a,c] := by decide
def m5_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[a,c]⟩
example : correct m5_5_5 = true := by decide
example : unforgeable m5_5_5 = true := by decide
example : forgeries m5_5_5 = [] := by decide
example : accepted m5_5_5 = [a,c] := by decide
def m5_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[b,c]⟩
example : correct m5_5_6 = true := by decide
example : unforgeable m5_5_6 = true := by decide
example : forgeries m5_5_6 = [] := by decide
example : accepted m5_5_6 = [a,c] := by decide
def m5_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,c],[a,b,c]⟩
example : correct m5_5_7 = true := by decide
example : unforgeable m5_5_7 = true := by decide
example : forgeries m5_5_7 = [] := by decide
example : accepted m5_5_7 = [a,c] := by decide
def m5_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[]⟩
example : correct m5_6_0 = false := by decide
example : unforgeable m5_6_0 = true := by decide
example : forgeries m5_6_0 = [] := by decide
example : accepted m5_6_0 = [b,c] := by decide
def m5_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[a]⟩
example : correct m5_6_1 = false := by decide
example : unforgeable m5_6_1 = true := by decide
example : forgeries m5_6_1 = [] := by decide
example : accepted m5_6_1 = [b,c] := by decide
def m5_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[b]⟩
example : correct m5_6_2 = false := by decide
example : unforgeable m5_6_2 = false := by decide
example : forgeries m5_6_2 = [b] := by decide
example : accepted m5_6_2 = [b,c] := by decide
def m5_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[a,b]⟩
example : correct m5_6_3 = false := by decide
example : unforgeable m5_6_3 = false := by decide
example : forgeries m5_6_3 = [b] := by decide
example : accepted m5_6_3 = [b,c] := by decide
def m5_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[c]⟩
example : correct m5_6_4 = false := by decide
example : unforgeable m5_6_4 = true := by decide
example : forgeries m5_6_4 = [] := by decide
example : accepted m5_6_4 = [b,c] := by decide
def m5_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[a,c]⟩
example : correct m5_6_5 = false := by decide
example : unforgeable m5_6_5 = true := by decide
example : forgeries m5_6_5 = [] := by decide
example : accepted m5_6_5 = [b,c] := by decide
def m5_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[b,c]⟩
example : correct m5_6_6 = false := by decide
example : unforgeable m5_6_6 = false := by decide
example : forgeries m5_6_6 = [b] := by decide
example : accepted m5_6_6 = [b,c] := by decide
def m5_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[b,c],[a,b,c]⟩
example : correct m5_6_7 = false := by decide
example : unforgeable m5_6_7 = false := by decide
example : forgeries m5_6_7 = [b] := by decide
example : accepted m5_6_7 = [b,c] := by decide
def m5_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[]⟩
example : correct m5_7_0 = true := by decide
example : unforgeable m5_7_0 = true := by decide
example : forgeries m5_7_0 = [] := by decide
example : accepted m5_7_0 = [a,b,c] := by decide
def m5_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[a]⟩
example : correct m5_7_1 = true := by decide
example : unforgeable m5_7_1 = true := by decide
example : forgeries m5_7_1 = [] := by decide
example : accepted m5_7_1 = [a,b,c] := by decide
def m5_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[b]⟩
example : correct m5_7_2 = true := by decide
example : unforgeable m5_7_2 = false := by decide
example : forgeries m5_7_2 = [b] := by decide
example : accepted m5_7_2 = [a,b,c] := by decide
def m5_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[a,b]⟩
example : correct m5_7_3 = true := by decide
example : unforgeable m5_7_3 = false := by decide
example : forgeries m5_7_3 = [b] := by decide
example : accepted m5_7_3 = [a,b,c] := by decide
def m5_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[c]⟩
example : correct m5_7_4 = true := by decide
example : unforgeable m5_7_4 = true := by decide
example : forgeries m5_7_4 = [] := by decide
example : accepted m5_7_4 = [a,b,c] := by decide
def m5_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[a,c]⟩
example : correct m5_7_5 = true := by decide
example : unforgeable m5_7_5 = true := by decide
example : forgeries m5_7_5 = [] := by decide
example : accepted m5_7_5 = [a,b,c] := by decide
def m5_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[b,c]⟩
example : correct m5_7_6 = true := by decide
example : unforgeable m5_7_6 = false := by decide
example : forgeries m5_7_6 = [b] := by decide
example : accepted m5_7_6 = [a,b,c] := by decide
def m5_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,c],[a,b,c],[a,b,c]⟩
example : correct m5_7_7 = true := by decide
example : unforgeable m5_7_7 = false := by decide
example : forgeries m5_7_7 = [b] := by decide
example : accepted m5_7_7 = [a,b,c] := by decide
def m6_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[]⟩
example : correct m6_0_0 = false := by decide
example : unforgeable m6_0_0 = true := by decide
example : forgeries m6_0_0 = [] := by decide
example : accepted m6_0_0 = [] := by decide
def m6_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[a]⟩
example : correct m6_0_1 = false := by decide
example : unforgeable m6_0_1 = true := by decide
example : forgeries m6_0_1 = [] := by decide
example : accepted m6_0_1 = [] := by decide
def m6_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[b]⟩
example : correct m6_0_2 = false := by decide
example : unforgeable m6_0_2 = true := by decide
example : forgeries m6_0_2 = [] := by decide
example : accepted m6_0_2 = [] := by decide
def m6_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[a,b]⟩
example : correct m6_0_3 = false := by decide
example : unforgeable m6_0_3 = true := by decide
example : forgeries m6_0_3 = [] := by decide
example : accepted m6_0_3 = [] := by decide
def m6_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[c]⟩
example : correct m6_0_4 = false := by decide
example : unforgeable m6_0_4 = true := by decide
example : forgeries m6_0_4 = [] := by decide
example : accepted m6_0_4 = [] := by decide
def m6_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[a,c]⟩
example : correct m6_0_5 = false := by decide
example : unforgeable m6_0_5 = true := by decide
example : forgeries m6_0_5 = [] := by decide
example : accepted m6_0_5 = [] := by decide
def m6_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[b,c]⟩
example : correct m6_0_6 = false := by decide
example : unforgeable m6_0_6 = true := by decide
example : forgeries m6_0_6 = [] := by decide
example : accepted m6_0_6 = [] := by decide
def m6_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[],[a,b,c]⟩
example : correct m6_0_7 = false := by decide
example : unforgeable m6_0_7 = true := by decide
example : forgeries m6_0_7 = [] := by decide
example : accepted m6_0_7 = [] := by decide
def m6_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[]⟩
example : correct m6_1_0 = false := by decide
example : unforgeable m6_1_0 = true := by decide
example : forgeries m6_1_0 = [] := by decide
example : accepted m6_1_0 = [a] := by decide
def m6_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[a]⟩
example : correct m6_1_1 = false := by decide
example : unforgeable m6_1_1 = false := by decide
example : forgeries m6_1_1 = [a] := by decide
example : accepted m6_1_1 = [a] := by decide
def m6_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[b]⟩
example : correct m6_1_2 = false := by decide
example : unforgeable m6_1_2 = true := by decide
example : forgeries m6_1_2 = [] := by decide
example : accepted m6_1_2 = [a] := by decide
def m6_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[a,b]⟩
example : correct m6_1_3 = false := by decide
example : unforgeable m6_1_3 = false := by decide
example : forgeries m6_1_3 = [a] := by decide
example : accepted m6_1_3 = [a] := by decide
def m6_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[c]⟩
example : correct m6_1_4 = false := by decide
example : unforgeable m6_1_4 = true := by decide
example : forgeries m6_1_4 = [] := by decide
example : accepted m6_1_4 = [a] := by decide
def m6_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[a,c]⟩
example : correct m6_1_5 = false := by decide
example : unforgeable m6_1_5 = false := by decide
example : forgeries m6_1_5 = [a] := by decide
example : accepted m6_1_5 = [a] := by decide
def m6_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[b,c]⟩
example : correct m6_1_6 = false := by decide
example : unforgeable m6_1_6 = true := by decide
example : forgeries m6_1_6 = [] := by decide
example : accepted m6_1_6 = [a] := by decide
def m6_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a],[a,b,c]⟩
example : correct m6_1_7 = false := by decide
example : unforgeable m6_1_7 = false := by decide
example : forgeries m6_1_7 = [a] := by decide
example : accepted m6_1_7 = [a] := by decide
def m6_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[]⟩
example : correct m6_2_0 = false := by decide
example : unforgeable m6_2_0 = true := by decide
example : forgeries m6_2_0 = [] := by decide
example : accepted m6_2_0 = [b] := by decide
def m6_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[a]⟩
example : correct m6_2_1 = false := by decide
example : unforgeable m6_2_1 = true := by decide
example : forgeries m6_2_1 = [] := by decide
example : accepted m6_2_1 = [b] := by decide
def m6_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[b]⟩
example : correct m6_2_2 = false := by decide
example : unforgeable m6_2_2 = true := by decide
example : forgeries m6_2_2 = [] := by decide
example : accepted m6_2_2 = [b] := by decide
def m6_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[a,b]⟩
example : correct m6_2_3 = false := by decide
example : unforgeable m6_2_3 = true := by decide
example : forgeries m6_2_3 = [] := by decide
example : accepted m6_2_3 = [b] := by decide
def m6_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[c]⟩
example : correct m6_2_4 = false := by decide
example : unforgeable m6_2_4 = true := by decide
example : forgeries m6_2_4 = [] := by decide
example : accepted m6_2_4 = [b] := by decide
def m6_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[a,c]⟩
example : correct m6_2_5 = false := by decide
example : unforgeable m6_2_5 = true := by decide
example : forgeries m6_2_5 = [] := by decide
example : accepted m6_2_5 = [b] := by decide
def m6_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[b,c]⟩
example : correct m6_2_6 = false := by decide
example : unforgeable m6_2_6 = true := by decide
example : forgeries m6_2_6 = [] := by decide
example : accepted m6_2_6 = [b] := by decide
def m6_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b],[a,b,c]⟩
example : correct m6_2_7 = false := by decide
example : unforgeable m6_2_7 = true := by decide
example : forgeries m6_2_7 = [] := by decide
example : accepted m6_2_7 = [b] := by decide
def m6_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[]⟩
example : correct m6_3_0 = false := by decide
example : unforgeable m6_3_0 = true := by decide
example : forgeries m6_3_0 = [] := by decide
example : accepted m6_3_0 = [a,b] := by decide
def m6_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[a]⟩
example : correct m6_3_1 = false := by decide
example : unforgeable m6_3_1 = false := by decide
example : forgeries m6_3_1 = [a] := by decide
example : accepted m6_3_1 = [a,b] := by decide
def m6_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[b]⟩
example : correct m6_3_2 = false := by decide
example : unforgeable m6_3_2 = true := by decide
example : forgeries m6_3_2 = [] := by decide
example : accepted m6_3_2 = [a,b] := by decide
def m6_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[a,b]⟩
example : correct m6_3_3 = false := by decide
example : unforgeable m6_3_3 = false := by decide
example : forgeries m6_3_3 = [a] := by decide
example : accepted m6_3_3 = [a,b] := by decide
def m6_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[c]⟩
example : correct m6_3_4 = false := by decide
example : unforgeable m6_3_4 = true := by decide
example : forgeries m6_3_4 = [] := by decide
example : accepted m6_3_4 = [a,b] := by decide
def m6_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[a,c]⟩
example : correct m6_3_5 = false := by decide
example : unforgeable m6_3_5 = false := by decide
example : forgeries m6_3_5 = [a] := by decide
example : accepted m6_3_5 = [a,b] := by decide
def m6_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[b,c]⟩
example : correct m6_3_6 = false := by decide
example : unforgeable m6_3_6 = true := by decide
example : forgeries m6_3_6 = [] := by decide
example : accepted m6_3_6 = [a,b] := by decide
def m6_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b],[a,b,c]⟩
example : correct m6_3_7 = false := by decide
example : unforgeable m6_3_7 = false := by decide
example : forgeries m6_3_7 = [a] := by decide
example : accepted m6_3_7 = [a,b] := by decide
def m6_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[]⟩
example : correct m6_4_0 = false := by decide
example : unforgeable m6_4_0 = true := by decide
example : forgeries m6_4_0 = [] := by decide
example : accepted m6_4_0 = [c] := by decide
def m6_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[a]⟩
example : correct m6_4_1 = false := by decide
example : unforgeable m6_4_1 = true := by decide
example : forgeries m6_4_1 = [] := by decide
example : accepted m6_4_1 = [c] := by decide
def m6_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[b]⟩
example : correct m6_4_2 = false := by decide
example : unforgeable m6_4_2 = true := by decide
example : forgeries m6_4_2 = [] := by decide
example : accepted m6_4_2 = [c] := by decide
def m6_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[a,b]⟩
example : correct m6_4_3 = false := by decide
example : unforgeable m6_4_3 = true := by decide
example : forgeries m6_4_3 = [] := by decide
example : accepted m6_4_3 = [c] := by decide
def m6_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[c]⟩
example : correct m6_4_4 = false := by decide
example : unforgeable m6_4_4 = true := by decide
example : forgeries m6_4_4 = [] := by decide
example : accepted m6_4_4 = [c] := by decide
def m6_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[a,c]⟩
example : correct m6_4_5 = false := by decide
example : unforgeable m6_4_5 = true := by decide
example : forgeries m6_4_5 = [] := by decide
example : accepted m6_4_5 = [c] := by decide
def m6_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[b,c]⟩
example : correct m6_4_6 = false := by decide
example : unforgeable m6_4_6 = true := by decide
example : forgeries m6_4_6 = [] := by decide
example : accepted m6_4_6 = [c] := by decide
def m6_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[c],[a,b,c]⟩
example : correct m6_4_7 = false := by decide
example : unforgeable m6_4_7 = true := by decide
example : forgeries m6_4_7 = [] := by decide
example : accepted m6_4_7 = [c] := by decide
def m6_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[]⟩
example : correct m6_5_0 = false := by decide
example : unforgeable m6_5_0 = true := by decide
example : forgeries m6_5_0 = [] := by decide
example : accepted m6_5_0 = [a,c] := by decide
def m6_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[a]⟩
example : correct m6_5_1 = false := by decide
example : unforgeable m6_5_1 = false := by decide
example : forgeries m6_5_1 = [a] := by decide
example : accepted m6_5_1 = [a,c] := by decide
def m6_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[b]⟩
example : correct m6_5_2 = false := by decide
example : unforgeable m6_5_2 = true := by decide
example : forgeries m6_5_2 = [] := by decide
example : accepted m6_5_2 = [a,c] := by decide
def m6_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[a,b]⟩
example : correct m6_5_3 = false := by decide
example : unforgeable m6_5_3 = false := by decide
example : forgeries m6_5_3 = [a] := by decide
example : accepted m6_5_3 = [a,c] := by decide
def m6_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[c]⟩
example : correct m6_5_4 = false := by decide
example : unforgeable m6_5_4 = true := by decide
example : forgeries m6_5_4 = [] := by decide
example : accepted m6_5_4 = [a,c] := by decide
def m6_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[a,c]⟩
example : correct m6_5_5 = false := by decide
example : unforgeable m6_5_5 = false := by decide
example : forgeries m6_5_5 = [a] := by decide
example : accepted m6_5_5 = [a,c] := by decide
def m6_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[b,c]⟩
example : correct m6_5_6 = false := by decide
example : unforgeable m6_5_6 = true := by decide
example : forgeries m6_5_6 = [] := by decide
example : accepted m6_5_6 = [a,c] := by decide
def m6_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,c],[a,b,c]⟩
example : correct m6_5_7 = false := by decide
example : unforgeable m6_5_7 = false := by decide
example : forgeries m6_5_7 = [a] := by decide
example : accepted m6_5_7 = [a,c] := by decide
def m6_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[]⟩
example : correct m6_6_0 = true := by decide
example : unforgeable m6_6_0 = true := by decide
example : forgeries m6_6_0 = [] := by decide
example : accepted m6_6_0 = [b,c] := by decide
def m6_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[a]⟩
example : correct m6_6_1 = true := by decide
example : unforgeable m6_6_1 = true := by decide
example : forgeries m6_6_1 = [] := by decide
example : accepted m6_6_1 = [b,c] := by decide
def m6_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[b]⟩
example : correct m6_6_2 = true := by decide
example : unforgeable m6_6_2 = true := by decide
example : forgeries m6_6_2 = [] := by decide
example : accepted m6_6_2 = [b,c] := by decide
def m6_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[a,b]⟩
example : correct m6_6_3 = true := by decide
example : unforgeable m6_6_3 = true := by decide
example : forgeries m6_6_3 = [] := by decide
example : accepted m6_6_3 = [b,c] := by decide
def m6_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[c]⟩
example : correct m6_6_4 = true := by decide
example : unforgeable m6_6_4 = true := by decide
example : forgeries m6_6_4 = [] := by decide
example : accepted m6_6_4 = [b,c] := by decide
def m6_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[a,c]⟩
example : correct m6_6_5 = true := by decide
example : unforgeable m6_6_5 = true := by decide
example : forgeries m6_6_5 = [] := by decide
example : accepted m6_6_5 = [b,c] := by decide
def m6_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[b,c]⟩
example : correct m6_6_6 = true := by decide
example : unforgeable m6_6_6 = true := by decide
example : forgeries m6_6_6 = [] := by decide
example : accepted m6_6_6 = [b,c] := by decide
def m6_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[b,c],[a,b,c]⟩
example : correct m6_6_7 = true := by decide
example : unforgeable m6_6_7 = true := by decide
example : forgeries m6_6_7 = [] := by decide
example : accepted m6_6_7 = [b,c] := by decide
def m6_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[]⟩
example : correct m6_7_0 = true := by decide
example : unforgeable m6_7_0 = true := by decide
example : forgeries m6_7_0 = [] := by decide
example : accepted m6_7_0 = [a,b,c] := by decide
def m6_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[a]⟩
example : correct m6_7_1 = true := by decide
example : unforgeable m6_7_1 = false := by decide
example : forgeries m6_7_1 = [a] := by decide
example : accepted m6_7_1 = [a,b,c] := by decide
def m6_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[b]⟩
example : correct m6_7_2 = true := by decide
example : unforgeable m6_7_2 = true := by decide
example : forgeries m6_7_2 = [] := by decide
example : accepted m6_7_2 = [a,b,c] := by decide
def m6_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[a,b]⟩
example : correct m6_7_3 = true := by decide
example : unforgeable m6_7_3 = false := by decide
example : forgeries m6_7_3 = [a] := by decide
example : accepted m6_7_3 = [a,b,c] := by decide
def m6_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[c]⟩
example : correct m6_7_4 = true := by decide
example : unforgeable m6_7_4 = true := by decide
example : forgeries m6_7_4 = [] := by decide
example : accepted m6_7_4 = [a,b,c] := by decide
def m6_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[a,c]⟩
example : correct m6_7_5 = true := by decide
example : unforgeable m6_7_5 = false := by decide
example : forgeries m6_7_5 = [a] := by decide
example : accepted m6_7_5 = [a,b,c] := by decide
def m6_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[b,c]⟩
example : correct m6_7_6 = true := by decide
example : unforgeable m6_7_6 = true := by decide
example : forgeries m6_7_6 = [] := by decide
example : accepted m6_7_6 = [a,b,c] := by decide
def m6_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[b,c],[a,b,c],[a,b,c]⟩
example : correct m6_7_7 = true := by decide
example : unforgeable m6_7_7 = false := by decide
example : forgeries m6_7_7 = [a] := by decide
example : accepted m6_7_7 = [a,b,c] := by decide
def m7_0_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[]⟩
example : correct m7_0_0 = false := by decide
example : unforgeable m7_0_0 = true := by decide
example : forgeries m7_0_0 = [] := by decide
example : accepted m7_0_0 = [] := by decide
def m7_0_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[a]⟩
example : correct m7_0_1 = false := by decide
example : unforgeable m7_0_1 = true := by decide
example : forgeries m7_0_1 = [] := by decide
example : accepted m7_0_1 = [] := by decide
def m7_0_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[b]⟩
example : correct m7_0_2 = false := by decide
example : unforgeable m7_0_2 = true := by decide
example : forgeries m7_0_2 = [] := by decide
example : accepted m7_0_2 = [] := by decide
def m7_0_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[a,b]⟩
example : correct m7_0_3 = false := by decide
example : unforgeable m7_0_3 = true := by decide
example : forgeries m7_0_3 = [] := by decide
example : accepted m7_0_3 = [] := by decide
def m7_0_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[c]⟩
example : correct m7_0_4 = false := by decide
example : unforgeable m7_0_4 = true := by decide
example : forgeries m7_0_4 = [] := by decide
example : accepted m7_0_4 = [] := by decide
def m7_0_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[a,c]⟩
example : correct m7_0_5 = false := by decide
example : unforgeable m7_0_5 = true := by decide
example : forgeries m7_0_5 = [] := by decide
example : accepted m7_0_5 = [] := by decide
def m7_0_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[b,c]⟩
example : correct m7_0_6 = false := by decide
example : unforgeable m7_0_6 = true := by decide
example : forgeries m7_0_6 = [] := by decide
example : accepted m7_0_6 = [] := by decide
def m7_0_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[],[a,b,c]⟩
example : correct m7_0_7 = false := by decide
example : unforgeable m7_0_7 = true := by decide
example : forgeries m7_0_7 = [] := by decide
example : accepted m7_0_7 = [] := by decide
def m7_1_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[]⟩
example : correct m7_1_0 = false := by decide
example : unforgeable m7_1_0 = true := by decide
example : forgeries m7_1_0 = [] := by decide
example : accepted m7_1_0 = [a] := by decide
def m7_1_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[a]⟩
example : correct m7_1_1 = false := by decide
example : unforgeable m7_1_1 = true := by decide
example : forgeries m7_1_1 = [] := by decide
example : accepted m7_1_1 = [a] := by decide
def m7_1_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[b]⟩
example : correct m7_1_2 = false := by decide
example : unforgeable m7_1_2 = true := by decide
example : forgeries m7_1_2 = [] := by decide
example : accepted m7_1_2 = [a] := by decide
def m7_1_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[a,b]⟩
example : correct m7_1_3 = false := by decide
example : unforgeable m7_1_3 = true := by decide
example : forgeries m7_1_3 = [] := by decide
example : accepted m7_1_3 = [a] := by decide
def m7_1_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[c]⟩
example : correct m7_1_4 = false := by decide
example : unforgeable m7_1_4 = true := by decide
example : forgeries m7_1_4 = [] := by decide
example : accepted m7_1_4 = [a] := by decide
def m7_1_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[a,c]⟩
example : correct m7_1_5 = false := by decide
example : unforgeable m7_1_5 = true := by decide
example : forgeries m7_1_5 = [] := by decide
example : accepted m7_1_5 = [a] := by decide
def m7_1_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[b,c]⟩
example : correct m7_1_6 = false := by decide
example : unforgeable m7_1_6 = true := by decide
example : forgeries m7_1_6 = [] := by decide
example : accepted m7_1_6 = [a] := by decide
def m7_1_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a],[a,b,c]⟩
example : correct m7_1_7 = false := by decide
example : unforgeable m7_1_7 = true := by decide
example : forgeries m7_1_7 = [] := by decide
example : accepted m7_1_7 = [a] := by decide
def m7_2_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[]⟩
example : correct m7_2_0 = false := by decide
example : unforgeable m7_2_0 = true := by decide
example : forgeries m7_2_0 = [] := by decide
example : accepted m7_2_0 = [b] := by decide
def m7_2_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[a]⟩
example : correct m7_2_1 = false := by decide
example : unforgeable m7_2_1 = true := by decide
example : forgeries m7_2_1 = [] := by decide
example : accepted m7_2_1 = [b] := by decide
def m7_2_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[b]⟩
example : correct m7_2_2 = false := by decide
example : unforgeable m7_2_2 = true := by decide
example : forgeries m7_2_2 = [] := by decide
example : accepted m7_2_2 = [b] := by decide
def m7_2_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[a,b]⟩
example : correct m7_2_3 = false := by decide
example : unforgeable m7_2_3 = true := by decide
example : forgeries m7_2_3 = [] := by decide
example : accepted m7_2_3 = [b] := by decide
def m7_2_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[c]⟩
example : correct m7_2_4 = false := by decide
example : unforgeable m7_2_4 = true := by decide
example : forgeries m7_2_4 = [] := by decide
example : accepted m7_2_4 = [b] := by decide
def m7_2_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[a,c]⟩
example : correct m7_2_5 = false := by decide
example : unforgeable m7_2_5 = true := by decide
example : forgeries m7_2_5 = [] := by decide
example : accepted m7_2_5 = [b] := by decide
def m7_2_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[b,c]⟩
example : correct m7_2_6 = false := by decide
example : unforgeable m7_2_6 = true := by decide
example : forgeries m7_2_6 = [] := by decide
example : accepted m7_2_6 = [b] := by decide
def m7_2_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b],[a,b,c]⟩
example : correct m7_2_7 = false := by decide
example : unforgeable m7_2_7 = true := by decide
example : forgeries m7_2_7 = [] := by decide
example : accepted m7_2_7 = [b] := by decide
def m7_3_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[]⟩
example : correct m7_3_0 = false := by decide
example : unforgeable m7_3_0 = true := by decide
example : forgeries m7_3_0 = [] := by decide
example : accepted m7_3_0 = [a,b] := by decide
def m7_3_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[a]⟩
example : correct m7_3_1 = false := by decide
example : unforgeable m7_3_1 = true := by decide
example : forgeries m7_3_1 = [] := by decide
example : accepted m7_3_1 = [a,b] := by decide
def m7_3_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[b]⟩
example : correct m7_3_2 = false := by decide
example : unforgeable m7_3_2 = true := by decide
example : forgeries m7_3_2 = [] := by decide
example : accepted m7_3_2 = [a,b] := by decide
def m7_3_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[a,b]⟩
example : correct m7_3_3 = false := by decide
example : unforgeable m7_3_3 = true := by decide
example : forgeries m7_3_3 = [] := by decide
example : accepted m7_3_3 = [a,b] := by decide
def m7_3_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[c]⟩
example : correct m7_3_4 = false := by decide
example : unforgeable m7_3_4 = true := by decide
example : forgeries m7_3_4 = [] := by decide
example : accepted m7_3_4 = [a,b] := by decide
def m7_3_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[a,c]⟩
example : correct m7_3_5 = false := by decide
example : unforgeable m7_3_5 = true := by decide
example : forgeries m7_3_5 = [] := by decide
example : accepted m7_3_5 = [a,b] := by decide
def m7_3_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[b,c]⟩
example : correct m7_3_6 = false := by decide
example : unforgeable m7_3_6 = true := by decide
example : forgeries m7_3_6 = [] := by decide
example : accepted m7_3_6 = [a,b] := by decide
def m7_3_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b],[a,b,c]⟩
example : correct m7_3_7 = false := by decide
example : unforgeable m7_3_7 = true := by decide
example : forgeries m7_3_7 = [] := by decide
example : accepted m7_3_7 = [a,b] := by decide
def m7_4_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[]⟩
example : correct m7_4_0 = false := by decide
example : unforgeable m7_4_0 = true := by decide
example : forgeries m7_4_0 = [] := by decide
example : accepted m7_4_0 = [c] := by decide
def m7_4_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[a]⟩
example : correct m7_4_1 = false := by decide
example : unforgeable m7_4_1 = true := by decide
example : forgeries m7_4_1 = [] := by decide
example : accepted m7_4_1 = [c] := by decide
def m7_4_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[b]⟩
example : correct m7_4_2 = false := by decide
example : unforgeable m7_4_2 = true := by decide
example : forgeries m7_4_2 = [] := by decide
example : accepted m7_4_2 = [c] := by decide
def m7_4_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[a,b]⟩
example : correct m7_4_3 = false := by decide
example : unforgeable m7_4_3 = true := by decide
example : forgeries m7_4_3 = [] := by decide
example : accepted m7_4_3 = [c] := by decide
def m7_4_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[c]⟩
example : correct m7_4_4 = false := by decide
example : unforgeable m7_4_4 = true := by decide
example : forgeries m7_4_4 = [] := by decide
example : accepted m7_4_4 = [c] := by decide
def m7_4_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[a,c]⟩
example : correct m7_4_5 = false := by decide
example : unforgeable m7_4_5 = true := by decide
example : forgeries m7_4_5 = [] := by decide
example : accepted m7_4_5 = [c] := by decide
def m7_4_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[b,c]⟩
example : correct m7_4_6 = false := by decide
example : unforgeable m7_4_6 = true := by decide
example : forgeries m7_4_6 = [] := by decide
example : accepted m7_4_6 = [c] := by decide
def m7_4_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[c],[a,b,c]⟩
example : correct m7_4_7 = false := by decide
example : unforgeable m7_4_7 = true := by decide
example : forgeries m7_4_7 = [] := by decide
example : accepted m7_4_7 = [c] := by decide
def m7_5_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[]⟩
example : correct m7_5_0 = false := by decide
example : unforgeable m7_5_0 = true := by decide
example : forgeries m7_5_0 = [] := by decide
example : accepted m7_5_0 = [a,c] := by decide
def m7_5_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[a]⟩
example : correct m7_5_1 = false := by decide
example : unforgeable m7_5_1 = true := by decide
example : forgeries m7_5_1 = [] := by decide
example : accepted m7_5_1 = [a,c] := by decide
def m7_5_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[b]⟩
example : correct m7_5_2 = false := by decide
example : unforgeable m7_5_2 = true := by decide
example : forgeries m7_5_2 = [] := by decide
example : accepted m7_5_2 = [a,c] := by decide
def m7_5_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[a,b]⟩
example : correct m7_5_3 = false := by decide
example : unforgeable m7_5_3 = true := by decide
example : forgeries m7_5_3 = [] := by decide
example : accepted m7_5_3 = [a,c] := by decide
def m7_5_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[c]⟩
example : correct m7_5_4 = false := by decide
example : unforgeable m7_5_4 = true := by decide
example : forgeries m7_5_4 = [] := by decide
example : accepted m7_5_4 = [a,c] := by decide
def m7_5_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[a,c]⟩
example : correct m7_5_5 = false := by decide
example : unforgeable m7_5_5 = true := by decide
example : forgeries m7_5_5 = [] := by decide
example : accepted m7_5_5 = [a,c] := by decide
def m7_5_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[b,c]⟩
example : correct m7_5_6 = false := by decide
example : unforgeable m7_5_6 = true := by decide
example : forgeries m7_5_6 = [] := by decide
example : accepted m7_5_6 = [a,c] := by decide
def m7_5_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,c],[a,b,c]⟩
example : correct m7_5_7 = false := by decide
example : unforgeable m7_5_7 = true := by decide
example : forgeries m7_5_7 = [] := by decide
example : accepted m7_5_7 = [a,c] := by decide
def m7_6_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[]⟩
example : correct m7_6_0 = false := by decide
example : unforgeable m7_6_0 = true := by decide
example : forgeries m7_6_0 = [] := by decide
example : accepted m7_6_0 = [b,c] := by decide
def m7_6_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[a]⟩
example : correct m7_6_1 = false := by decide
example : unforgeable m7_6_1 = true := by decide
example : forgeries m7_6_1 = [] := by decide
example : accepted m7_6_1 = [b,c] := by decide
def m7_6_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[b]⟩
example : correct m7_6_2 = false := by decide
example : unforgeable m7_6_2 = true := by decide
example : forgeries m7_6_2 = [] := by decide
example : accepted m7_6_2 = [b,c] := by decide
def m7_6_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[a,b]⟩
example : correct m7_6_3 = false := by decide
example : unforgeable m7_6_3 = true := by decide
example : forgeries m7_6_3 = [] := by decide
example : accepted m7_6_3 = [b,c] := by decide
def m7_6_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[c]⟩
example : correct m7_6_4 = false := by decide
example : unforgeable m7_6_4 = true := by decide
example : forgeries m7_6_4 = [] := by decide
example : accepted m7_6_4 = [b,c] := by decide
def m7_6_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[a,c]⟩
example : correct m7_6_5 = false := by decide
example : unforgeable m7_6_5 = true := by decide
example : forgeries m7_6_5 = [] := by decide
example : accepted m7_6_5 = [b,c] := by decide
def m7_6_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[b,c]⟩
example : correct m7_6_6 = false := by decide
example : unforgeable m7_6_6 = true := by decide
example : forgeries m7_6_6 = [] := by decide
example : accepted m7_6_6 = [b,c] := by decide
def m7_6_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[b,c],[a,b,c]⟩
example : correct m7_6_7 = false := by decide
example : unforgeable m7_6_7 = true := by decide
example : forgeries m7_6_7 = [] := by decide
example : accepted m7_6_7 = [b,c] := by decide
def m7_7_0 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[]⟩
example : correct m7_7_0 = true := by decide
example : unforgeable m7_7_0 = true := by decide
example : forgeries m7_7_0 = [] := by decide
example : accepted m7_7_0 = [a,b,c] := by decide
def m7_7_1 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[a]⟩
example : correct m7_7_1 = true := by decide
example : unforgeable m7_7_1 = true := by decide
example : forgeries m7_7_1 = [] := by decide
example : accepted m7_7_1 = [a,b,c] := by decide
def m7_7_2 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[b]⟩
example : correct m7_7_2 = true := by decide
example : unforgeable m7_7_2 = true := by decide
example : forgeries m7_7_2 = [] := by decide
example : accepted m7_7_2 = [a,b,c] := by decide
def m7_7_3 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[a,b]⟩
example : correct m7_7_3 = true := by decide
example : unforgeable m7_7_3 = true := by decide
example : forgeries m7_7_3 = [] := by decide
example : accepted m7_7_3 = [a,b,c] := by decide
def m7_7_4 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[c]⟩
example : correct m7_7_4 = true := by decide
example : unforgeable m7_7_4 = true := by decide
example : forgeries m7_7_4 = [] := by decide
example : accepted m7_7_4 = [a,b,c] := by decide
def m7_7_5 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[a,c]⟩
example : correct m7_7_5 = true := by decide
example : unforgeable m7_7_5 = true := by decide
example : forgeries m7_7_5 = [] := by decide
example : accepted m7_7_5 = [a,b,c] := by decide
def m7_7_6 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[b,c]⟩
example : correct m7_7_6 = true := by decide
example : unforgeable m7_7_6 = true := by decide
example : forgeries m7_7_6 = [] := by decide
example : accepted m7_7_6 = [a,b,c] := by decide
def m7_7_7 : Model := ⟨["m0","m1"],["k0","k1"],[a,b,c],[a,b,c],[a,b,c]⟩
example : correct m7_7_7 = true := by decide
example : unforgeable m7_7_7 = true := by decide
example : forgeries m7_7_7 = [] := by decide
example : accepted m7_7_7 = [a,b,c] := by decide
def nativeSigning : SigningTrace m1_1_1 := ⟨a,by decide⟩
def nativeVerification : VerificationTrace m1_1_1 := correctnessTrace _ (by decide) nativeSigning
theorem nativeRetained : nativeVerification.row = a := rfl
#print axioms nativeRetained
end SFT.Computation.Signature
