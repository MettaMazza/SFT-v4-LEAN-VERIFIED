import SFT.Computation.SampleComplexity
namespace SFT.Computation.SampleComplexity
def m0_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[],[]⟩
example : teaches m0_0_0_0 ("h0",[]) = false := by decide
example : teaches m0_0_0_0 ("h1",[]) = false := by decide
example : (ambiguity m0_0_0_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_0_0 = 0 := rfl
def m0_0_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[]⟩
example : teaches m0_0_0_1 ("h0",[]) = false := by decide
example : teaches m0_0_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_0_0_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_0_1 = 0 := rfl
def m0_0_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[],[]⟩
example : teaches m0_0_0_2 ("h0",[]) = false := by decide
example : teaches m0_0_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_0_0_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_0_2 = 0 := rfl
def m0_0_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[],[]⟩
example : teaches m0_0_0_3 ("h0",[]) = false := by decide
example : teaches m0_0_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_0_0_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_0_3 = 0 := rfl
def m0_0_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[]⟩
example : teaches m0_0_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m0_0_1_0 ("h1",[]) = false := by decide
example : (ambiguity m0_0_1_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_1_0 = 0 := rfl
def m0_0_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[]⟩
example : teaches m0_0_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m0_0_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_0_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_1_1 = 0 := rfl
def m0_0_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[],[]⟩
example : teaches m0_0_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m0_0_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_0_1_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_1_2 = 0 := rfl
def m0_0_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[],[]⟩
example : teaches m0_0_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m0_0_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_0_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_1_3 = 0 := rfl
def m0_0_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[],[]⟩
example : teaches m0_0_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m0_0_2_0 ("h1",[]) = false := by decide
example : (ambiguity m0_0_2_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_2_0 = 0 := rfl
def m0_0_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[],[]⟩
example : teaches m0_0_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m0_0_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_0_2_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_2_1 = 0 := rfl
def m0_0_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[],[]⟩
example : teaches m0_0_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m0_0_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_0_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_2_2 = 0 := rfl
def m0_0_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[],[]⟩
example : teaches m0_0_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m0_0_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_0_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_2_3 = 0 := rfl
def m0_0_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[],[]⟩
example : teaches m0_0_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_0_3_0 ("h1",[]) = false := by decide
example : (ambiguity m0_0_3_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_3_0 = 0 := rfl
def m0_0_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[],[]⟩
example : teaches m0_0_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_0_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_0_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_3_1 = 0 := rfl
def m0_0_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[],[]⟩
example : teaches m0_0_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_0_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_0_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_3_2 = 0 := rfl
def m0_0_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[],[]⟩
example : teaches m0_0_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_0_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_0_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_0_3_3 = 0 := rfl
def m0_1_0_0 : Model := ⟨[("h0",[]),("h1",[])],[],[("a","x")]⟩
example : teaches m0_1_0_0 ("h0",[]) = false := by decide
example : teaches m0_1_0_0 ("h1",[]) = false := by decide
example : (ambiguity m0_1_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_0_0 = 1 := rfl
def m0_1_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("a","x")]⟩
example : teaches m0_1_0_1 ("h0",[]) = false := by decide
example : teaches m0_1_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_1_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_0_1 = 1 := rfl
def m0_1_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_0_2 ("h0",[]) = false := by decide
example : teaches m0_1_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_1_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_0_2 = 1 := rfl
def m0_1_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_0_3 ("h0",[]) = false := by decide
example : teaches m0_1_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_1_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_0_3 = 1 := rfl
def m0_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("a","x")]⟩
example : teaches m0_1_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m0_1_1_0 ("h1",[]) = false := by decide
example : (ambiguity m0_1_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_1_0 = 1 := rfl
def m0_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("a","x")]⟩
example : teaches m0_1_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m0_1_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_1_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_1_1_1 = 1 := rfl
def m0_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m0_1_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_1_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_1_2 = 1 := rfl
def m0_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m0_1_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_1_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_1_1_3 = 1 := rfl
def m0_1_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[],[("a","x")]⟩
example : teaches m0_1_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m0_1_2_0 ("h1",[]) = false := by decide
example : (ambiguity m0_1_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_2_0 = 1 := rfl
def m0_1_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[],[("a","x")]⟩
example : teaches m0_1_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m0_1_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_1_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_2_1 = 1 := rfl
def m0_1_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m0_1_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_1_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_2_2 = 1 := rfl
def m0_1_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m0_1_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_1_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_2_3 = 1 := rfl
def m0_1_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[],[("a","x")]⟩
example : teaches m0_1_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_1_3_0 ("h1",[]) = false := by decide
example : (ambiguity m0_1_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_3_0 = 1 := rfl
def m0_1_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[],[("a","x")]⟩
example : teaches m0_1_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_1_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_1_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_1_3_1 = 1 := rfl
def m0_1_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_1_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_1_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_1_3_2 = 1 := rfl
def m0_1_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[],[("a","x")]⟩
example : teaches m0_1_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_1_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_1_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_1_3_3 = 1 := rfl
def m0_2_0_0 : Model := ⟨[("h0",[]),("h1",[])],[],[("b","y")]⟩
example : teaches m0_2_0_0 ("h0",[]) = false := by decide
example : teaches m0_2_0_0 ("h1",[]) = false := by decide
example : (ambiguity m0_2_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_0_0 = 1 := rfl
def m0_2_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("b","y")]⟩
example : teaches m0_2_0_1 ("h0",[]) = false := by decide
example : teaches m0_2_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_2_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_0_1 = 1 := rfl
def m0_2_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_0_2 ("h0",[]) = false := by decide
example : teaches m0_2_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_2_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_0_2 = 1 := rfl
def m0_2_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_0_3 ("h0",[]) = false := by decide
example : teaches m0_2_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_2_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_0_3 = 1 := rfl
def m0_2_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("b","y")]⟩
example : teaches m0_2_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m0_2_1_0 ("h1",[]) = false := by decide
example : (ambiguity m0_2_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_1_0 = 1 := rfl
def m0_2_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("b","y")]⟩
example : teaches m0_2_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m0_2_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_2_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_1_1 = 1 := rfl
def m0_2_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m0_2_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_2_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_1_2 = 1 := rfl
def m0_2_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m0_2_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_2_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_1_3 = 1 := rfl
def m0_2_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[],[("b","y")]⟩
example : teaches m0_2_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m0_2_2_0 ("h1",[]) = false := by decide
example : (ambiguity m0_2_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_2_0 = 1 := rfl
def m0_2_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[],[("b","y")]⟩
example : teaches m0_2_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m0_2_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_2_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_2_1 = 1 := rfl
def m0_2_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m0_2_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_2_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_2_2_2 = 1 := rfl
def m0_2_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m0_2_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_2_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_2_2_3 = 1 := rfl
def m0_2_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[],[("b","y")]⟩
example : teaches m0_2_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_2_3_0 ("h1",[]) = false := by decide
example : (ambiguity m0_2_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_3_0 = 1 := rfl
def m0_2_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[],[("b","y")]⟩
example : teaches m0_2_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_2_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_2_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_2_3_1 = 1 := rfl
def m0_2_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_2_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_2_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_2_3_2 = 1 := rfl
def m0_2_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[],[("b","y")]⟩
example : teaches m0_2_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_2_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_2_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_2_3_3 = 1 := rfl
def m0_3_0_0 : Model := ⟨[("h0",[]),("h1",[])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_0_0 ("h0",[]) = false := by decide
example : teaches m0_3_0_0 ("h1",[]) = false := by decide
example : (ambiguity m0_3_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_0_0 = 2 := rfl
def m0_3_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_0_1 ("h0",[]) = false := by decide
example : teaches m0_3_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_3_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_0_1 = 2 := rfl
def m0_3_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_0_2 ("h0",[]) = false := by decide
example : teaches m0_3_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_3_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_0_2 = 2 := rfl
def m0_3_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_0_3 ("h0",[]) = false := by decide
example : teaches m0_3_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_3_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_0_3 = 2 := rfl
def m0_3_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m0_3_1_0 ("h1",[]) = false := by decide
example : (ambiguity m0_3_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_1_0 = 2 := rfl
def m0_3_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m0_3_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_3_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_1_1 = 2 := rfl
def m0_3_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m0_3_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_3_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_1_2 = 2 := rfl
def m0_3_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m0_3_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_3_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_1_3 = 2 := rfl
def m0_3_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m0_3_2_0 ("h1",[]) = false := by decide
example : (ambiguity m0_3_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_2_0 = 2 := rfl
def m0_3_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m0_3_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_3_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_2_1 = 2 := rfl
def m0_3_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m0_3_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_3_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_2_2 = 2 := rfl
def m0_3_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m0_3_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_3_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_2_3 = 2 := rfl
def m0_3_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_3_3_0 ("h1",[]) = false := by decide
example : (ambiguity m0_3_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_3_0 = 2 := rfl
def m0_3_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_3_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m0_3_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_3_1 = 2 := rfl
def m0_3_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_3_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m0_3_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m0_3_3_2 = 2 := rfl
def m0_3_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[],[("a","x"),("b","y")]⟩
example : teaches m0_3_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m0_3_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m0_3_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m0_3_3_3 = 2 := rfl
def m1_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[]⟩
example : teaches m1_0_0_0 ("h0",[]) = false := by decide
example : teaches m1_0_0_0 ("h1",[]) = false := by decide
example : (ambiguity m1_0_0_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_0_0 = 0 := rfl
def m1_0_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[]⟩
example : teaches m1_0_0_1 ("h0",[]) = false := by decide
example : teaches m1_0_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_0_0_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_0_1 = 0 := rfl
def m1_0_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_0_2 ("h0",[]) = false := by decide
example : teaches m1_0_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_0_0_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_0_2 = 0 := rfl
def m1_0_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_0_3 ("h0",[]) = false := by decide
example : teaches m1_0_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_0_0_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_0_3 = 0 := rfl
def m1_0_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[]⟩
example : teaches m1_0_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m1_0_1_0 ("h1",[]) = false := by decide
example : (ambiguity m1_0_1_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_1_0 = 0 := rfl
def m1_0_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : teaches m1_0_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m1_0_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_0_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_1_1 = 0 := rfl
def m1_0_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m1_0_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_0_1_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_1_2 = 0 := rfl
def m1_0_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m1_0_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_0_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_1_3 = 0 := rfl
def m1_0_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x")],[]⟩
example : teaches m1_0_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m1_0_2_0 ("h1",[]) = false := by decide
example : (ambiguity m1_0_2_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_2_0 = 0 := rfl
def m1_0_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : teaches m1_0_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m1_0_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_0_2_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_2_1 = 0 := rfl
def m1_0_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m1_0_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_0_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_2_2 = 0 := rfl
def m1_0_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m1_0_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_0_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_2_3 = 0 := rfl
def m1_0_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x")],[]⟩
example : teaches m1_0_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_0_3_0 ("h1",[]) = false := by decide
example : (ambiguity m1_0_3_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_3_0 = 0 := rfl
def m1_0_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x")],[]⟩
example : teaches m1_0_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_0_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_0_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_3_1 = 0 := rfl
def m1_0_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_0_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_0_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_3_2 = 0 := rfl
def m1_0_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[]⟩
example : teaches m1_0_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_0_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_0_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_0_3_3 = 0 := rfl
def m1_1_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_0_0 ("h0",[]) = false := by decide
example : teaches m1_1_0_0 ("h1",[]) = false := by decide
example : (ambiguity m1_1_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_0_0 = 1 := rfl
def m1_1_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_0_1 ("h0",[]) = false := by decide
example : teaches m1_1_0_1 ("h1",[("a","x")]) = true := by decide
example : (ambiguity m1_1_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_0_1 = 1 := rfl
def m1_1_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_0_2 ("h0",[]) = false := by decide
example : teaches m1_1_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_1_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_0_2 = 1 := rfl
def m1_1_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_0_3 ("h0",[]) = false := by decide
example : teaches m1_1_0_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m1_1_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_0_3 = 1 := rfl
def m1_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_1_0 ("h0",[("a","x")]) = true := by decide
example : teaches m1_1_1_0 ("h1",[]) = false := by decide
example : (ambiguity m1_1_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_1_0 = 1 := rfl
def m1_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m1_1_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_1_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_1_1_1 = 1 := rfl
def m1_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_1_2 ("h0",[("a","x")]) = true := by decide
example : teaches m1_1_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_1_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_1_2 = 1 := rfl
def m1_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m1_1_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_1_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_1_1_3 = 1 := rfl
def m1_1_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m1_1_2_0 ("h1",[]) = false := by decide
example : (ambiguity m1_1_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_2_0 = 1 := rfl
def m1_1_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m1_1_2_1 ("h1",[("a","x")]) = true := by decide
example : (ambiguity m1_1_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_2_1 = 1 := rfl
def m1_1_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m1_1_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_1_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_2_2 = 1 := rfl
def m1_1_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m1_1_2_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m1_1_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_2_3 = 1 := rfl
def m1_1_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_3_0 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m1_1_3_0 ("h1",[]) = false := by decide
example : (ambiguity m1_1_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_3_0 = 1 := rfl
def m1_1_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_1_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_1_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_1_3_1 = 1 := rfl
def m1_1_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_3_2 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m1_1_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_1_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_1_3_2 = 1 := rfl
def m1_1_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x")]⟩
example : teaches m1_1_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_1_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_1_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_1_3_3 = 1 := rfl
def m1_2_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_0_0 ("h0",[]) = false := by decide
example : teaches m1_2_0_0 ("h1",[]) = false := by decide
example : (ambiguity m1_2_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_0_0 = 1 := rfl
def m1_2_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_0_1 ("h0",[]) = false := by decide
example : teaches m1_2_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_2_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_0_1 = 1 := rfl
def m1_2_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_0_2 ("h0",[]) = false := by decide
example : teaches m1_2_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_2_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_0_2 = 1 := rfl
def m1_2_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_0_3 ("h0",[]) = false := by decide
example : teaches m1_2_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_2_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_0_3 = 1 := rfl
def m1_2_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m1_2_1_0 ("h1",[]) = false := by decide
example : (ambiguity m1_2_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_1_0 = 1 := rfl
def m1_2_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m1_2_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_2_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_1_1 = 1 := rfl
def m1_2_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m1_2_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_2_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_1_2 = 1 := rfl
def m1_2_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m1_2_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_2_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_1_3 = 1 := rfl
def m1_2_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m1_2_2_0 ("h1",[]) = false := by decide
example : (ambiguity m1_2_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_2_0 = 1 := rfl
def m1_2_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m1_2_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_2_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_2_1 = 1 := rfl
def m1_2_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m1_2_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_2_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_2_2_2 = 1 := rfl
def m1_2_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m1_2_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_2_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_2_2_3 = 1 := rfl
def m1_2_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_2_3_0 ("h1",[]) = false := by decide
example : (ambiguity m1_2_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_3_0 = 1 := rfl
def m1_2_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_2_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_2_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_2_3_1 = 1 := rfl
def m1_2_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_2_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_2_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_2_3_2 = 1 := rfl
def m1_2_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("b","y")]⟩
example : teaches m1_2_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_2_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_2_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_2_3_3 = 1 := rfl
def m1_3_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_0_0 ("h0",[]) = false := by decide
example : teaches m1_3_0_0 ("h1",[]) = false := by decide
example : (ambiguity m1_3_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_0_0 = 2 := rfl
def m1_3_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_0_1 ("h0",[]) = false := by decide
example : teaches m1_3_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_3_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_0_1 = 2 := rfl
def m1_3_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_0_2 ("h0",[]) = false := by decide
example : teaches m1_3_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_3_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_0_2 = 2 := rfl
def m1_3_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_0_3 ("h0",[]) = false := by decide
example : teaches m1_3_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_3_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_0_3 = 2 := rfl
def m1_3_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m1_3_1_0 ("h1",[]) = false := by decide
example : (ambiguity m1_3_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_1_0 = 2 := rfl
def m1_3_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m1_3_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_3_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_1_1 = 2 := rfl
def m1_3_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m1_3_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_3_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_1_2 = 2 := rfl
def m1_3_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m1_3_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_3_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_1_3 = 2 := rfl
def m1_3_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m1_3_2_0 ("h1",[]) = false := by decide
example : (ambiguity m1_3_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_2_0 = 2 := rfl
def m1_3_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m1_3_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_3_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_2_1 = 2 := rfl
def m1_3_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m1_3_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_3_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_2_2 = 2 := rfl
def m1_3_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m1_3_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_3_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_2_3 = 2 := rfl
def m1_3_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_3_3_0 ("h1",[]) = false := by decide
example : (ambiguity m1_3_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_3_0 = 2 := rfl
def m1_3_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_3_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m1_3_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_3_1 = 2 := rfl
def m1_3_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_3_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m1_3_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m1_3_3_2 = 2 := rfl
def m1_3_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x")],[("a","x"),("b","y")]⟩
example : teaches m1_3_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m1_3_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m1_3_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m1_3_3_3 = 2 := rfl
def m2_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("b","y")],[]⟩
example : teaches m2_0_0_0 ("h0",[]) = false := by decide
example : teaches m2_0_0_0 ("h1",[]) = false := by decide
example : (ambiguity m2_0_0_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_0_0 = 0 := rfl
def m2_0_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("b","y")],[]⟩
example : teaches m2_0_0_1 ("h0",[]) = false := by decide
example : teaches m2_0_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_0_0_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_0_1 = 0 := rfl
def m2_0_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_0_2 ("h0",[]) = false := by decide
example : teaches m2_0_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_0_0_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_0_2 = 0 := rfl
def m2_0_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_0_3 ("h0",[]) = false := by decide
example : teaches m2_0_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_0_0_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_0_3 = 0 := rfl
def m2_0_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("b","y")],[]⟩
example : teaches m2_0_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m2_0_1_0 ("h1",[]) = false := by decide
example : (ambiguity m2_0_1_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_1_0 = 0 := rfl
def m2_0_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("b","y")],[]⟩
example : teaches m2_0_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m2_0_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_0_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_1_1 = 0 := rfl
def m2_0_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m2_0_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_0_1_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_1_2 = 0 := rfl
def m2_0_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m2_0_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_0_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_1_3 = 0 := rfl
def m2_0_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("b","y")],[]⟩
example : teaches m2_0_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m2_0_2_0 ("h1",[]) = false := by decide
example : (ambiguity m2_0_2_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_2_0 = 0 := rfl
def m2_0_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("b","y")],[]⟩
example : teaches m2_0_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m2_0_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_0_2_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_2_1 = 0 := rfl
def m2_0_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m2_0_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_0_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_2_2 = 0 := rfl
def m2_0_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m2_0_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_0_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_2_3 = 0 := rfl
def m2_0_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("b","y")],[]⟩
example : teaches m2_0_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_0_3_0 ("h1",[]) = false := by decide
example : (ambiguity m2_0_3_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_3_0 = 0 := rfl
def m2_0_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("b","y")],[]⟩
example : teaches m2_0_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_0_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_0_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_3_1 = 0 := rfl
def m2_0_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_0_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_0_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_3_2 = 0 := rfl
def m2_0_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[]⟩
example : teaches m2_0_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_0_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_0_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_0_3_3 = 0 := rfl
def m2_1_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_0_0 ("h0",[]) = false := by decide
example : teaches m2_1_0_0 ("h1",[]) = false := by decide
example : (ambiguity m2_1_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_0_0 = 1 := rfl
def m2_1_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_0_1 ("h0",[]) = false := by decide
example : teaches m2_1_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_1_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_0_1 = 1 := rfl
def m2_1_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_0_2 ("h0",[]) = false := by decide
example : teaches m2_1_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_1_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_0_2 = 1 := rfl
def m2_1_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_0_3 ("h0",[]) = false := by decide
example : teaches m2_1_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_1_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_0_3 = 1 := rfl
def m2_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m2_1_1_0 ("h1",[]) = false := by decide
example : (ambiguity m2_1_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_1_0 = 1 := rfl
def m2_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m2_1_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_1_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_1_1_1 = 1 := rfl
def m2_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m2_1_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_1_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_1_2 = 1 := rfl
def m2_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m2_1_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_1_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_1_1_3 = 1 := rfl
def m2_1_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m2_1_2_0 ("h1",[]) = false := by decide
example : (ambiguity m2_1_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_2_0 = 1 := rfl
def m2_1_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m2_1_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_1_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_2_1 = 1 := rfl
def m2_1_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m2_1_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_1_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_2_2 = 1 := rfl
def m2_1_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m2_1_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_1_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_2_3 = 1 := rfl
def m2_1_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_1_3_0 ("h1",[]) = false := by decide
example : (ambiguity m2_1_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_3_0 = 1 := rfl
def m2_1_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_1_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_1_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_1_3_1 = 1 := rfl
def m2_1_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_1_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_1_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_1_3_2 = 1 := rfl
def m2_1_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x")]⟩
example : teaches m2_1_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_1_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_1_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_1_3_3 = 1 := rfl
def m2_2_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_0_0 ("h0",[]) = false := by decide
example : teaches m2_2_0_0 ("h1",[]) = false := by decide
example : (ambiguity m2_2_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_0_0 = 1 := rfl
def m2_2_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_0_1 ("h0",[]) = false := by decide
example : teaches m2_2_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_2_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_0_1 = 1 := rfl
def m2_2_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_0_2 ("h0",[]) = false := by decide
example : teaches m2_2_0_2 ("h1",[("b","y")]) = true := by decide
example : (ambiguity m2_2_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_0_2 = 1 := rfl
def m2_2_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_0_3 ("h0",[]) = false := by decide
example : teaches m2_2_0_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m2_2_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_0_3 = 1 := rfl
def m2_2_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m2_2_1_0 ("h1",[]) = false := by decide
example : (ambiguity m2_2_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_1_0 = 1 := rfl
def m2_2_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m2_2_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_2_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_1_1 = 1 := rfl
def m2_2_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m2_2_1_2 ("h1",[("b","y")]) = true := by decide
example : (ambiguity m2_2_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_1_2 = 1 := rfl
def m2_2_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m2_2_1_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m2_2_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_1_3 = 1 := rfl
def m2_2_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_2_0 ("h0",[("b","y")]) = true := by decide
example : teaches m2_2_2_0 ("h1",[]) = false := by decide
example : (ambiguity m2_2_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_2_0 = 1 := rfl
def m2_2_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_2_1 ("h0",[("b","y")]) = true := by decide
example : teaches m2_2_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_2_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_2_1 = 1 := rfl
def m2_2_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m2_2_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_2_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_2_2_2 = 1 := rfl
def m2_2_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m2_2_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_2_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_2_2_3 = 1 := rfl
def m2_2_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_3_0 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m2_2_3_0 ("h1",[]) = false := by decide
example : (ambiguity m2_2_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_3_0 = 1 := rfl
def m2_2_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_3_1 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m2_2_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_2_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_2_3_1 = 1 := rfl
def m2_2_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_2_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_2_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_2_3_2 = 1 := rfl
def m2_2_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("b","y")]⟩
example : teaches m2_2_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_2_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_2_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_2_3_3 = 1 := rfl
def m2_3_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_0_0 ("h0",[]) = false := by decide
example : teaches m2_3_0_0 ("h1",[]) = false := by decide
example : (ambiguity m2_3_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_0_0 = 2 := rfl
def m2_3_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_0_1 ("h0",[]) = false := by decide
example : teaches m2_3_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_3_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_0_1 = 2 := rfl
def m2_3_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_0_2 ("h0",[]) = false := by decide
example : teaches m2_3_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_3_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_0_2 = 2 := rfl
def m2_3_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_0_3 ("h0",[]) = false := by decide
example : teaches m2_3_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_3_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_0_3 = 2 := rfl
def m2_3_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m2_3_1_0 ("h1",[]) = false := by decide
example : (ambiguity m2_3_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_1_0 = 2 := rfl
def m2_3_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m2_3_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_3_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_1_1 = 2 := rfl
def m2_3_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m2_3_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_3_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_1_2 = 2 := rfl
def m2_3_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m2_3_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_3_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_1_3 = 2 := rfl
def m2_3_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m2_3_2_0 ("h1",[]) = false := by decide
example : (ambiguity m2_3_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_2_0 = 2 := rfl
def m2_3_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m2_3_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_3_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_2_1 = 2 := rfl
def m2_3_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m2_3_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_3_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_2_2 = 2 := rfl
def m2_3_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m2_3_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_3_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_2_3 = 2 := rfl
def m2_3_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_3_3_0 ("h1",[]) = false := by decide
example : (ambiguity m2_3_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_3_0 = 2 := rfl
def m2_3_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_3_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m2_3_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_3_1 = 2 := rfl
def m2_3_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_3_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m2_3_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m2_3_3_2 = 2 := rfl
def m2_3_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("b","y")],[("a","x"),("b","y")]⟩
example : teaches m2_3_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m2_3_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m2_3_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m2_3_3_3 = 2 := rfl
def m3_0_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_0_0 ("h0",[]) = false := by decide
example : teaches m3_0_0_0 ("h1",[]) = false := by decide
example : (ambiguity m3_0_0_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_0_0 = 0 := rfl
def m3_0_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_0_1 ("h0",[]) = false := by decide
example : teaches m3_0_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_0_0_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_0_1 = 0 := rfl
def m3_0_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_0_2 ("h0",[]) = false := by decide
example : teaches m3_0_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_0_0_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_0_2 = 0 := rfl
def m3_0_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_0_3 ("h0",[]) = false := by decide
example : teaches m3_0_0_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_0_0_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_0_3 = 0 := rfl
def m3_0_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m3_0_1_0 ("h1",[]) = false := by decide
example : (ambiguity m3_0_1_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_1_0 = 0 := rfl
def m3_0_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m3_0_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_0_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_1_1 = 0 := rfl
def m3_0_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m3_0_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_0_1_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_1_2 = 0 := rfl
def m3_0_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m3_0_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_0_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_1_3 = 0 := rfl
def m3_0_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m3_0_2_0 ("h1",[]) = false := by decide
example : (ambiguity m3_0_2_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_2_0 = 0 := rfl
def m3_0_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m3_0_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_0_2_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_2_1 = 0 := rfl
def m3_0_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m3_0_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_0_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_2_2 = 0 := rfl
def m3_0_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m3_0_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_0_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_2_3 = 0 := rfl
def m3_0_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_3_0 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_0_3_0 ("h1",[]) = false := by decide
example : (ambiguity m3_0_3_0).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_3_0 = 0 := rfl
def m3_0_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_0_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_0_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_3_1 = 0 := rfl
def m3_0_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_0_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_0_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_3_2 = 0 := rfl
def m3_0_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[]⟩
example : teaches m3_0_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_0_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_0_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_0_3_3 = 0 := rfl
def m3_1_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_0_0 ("h0",[]) = false := by decide
example : teaches m3_1_0_0 ("h1",[]) = false := by decide
example : (ambiguity m3_1_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_0_0 = 1 := rfl
def m3_1_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_0_1 ("h0",[]) = false := by decide
example : teaches m3_1_0_1 ("h1",[("a","x")]) = true := by decide
example : (ambiguity m3_1_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_0_1 = 1 := rfl
def m3_1_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_0_2 ("h0",[]) = false := by decide
example : teaches m3_1_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_1_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_0_2 = 1 := rfl
def m3_1_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_0_3 ("h0",[]) = false := by decide
example : teaches m3_1_0_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m3_1_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_0_3 = 1 := rfl
def m3_1_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_1_0 ("h0",[("a","x")]) = true := by decide
example : teaches m3_1_1_0 ("h1",[]) = false := by decide
example : (ambiguity m3_1_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_1_0 = 1 := rfl
def m3_1_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m3_1_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_1_1_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_1_1_1 = 1 := rfl
def m3_1_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_1_2 ("h0",[("a","x")]) = true := by decide
example : teaches m3_1_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_1_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_1_2 = 1 := rfl
def m3_1_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m3_1_1_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_1_1_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_1_1_3 = 1 := rfl
def m3_1_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m3_1_2_0 ("h1",[]) = false := by decide
example : (ambiguity m3_1_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_2_0 = 1 := rfl
def m3_1_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m3_1_2_1 ("h1",[("a","x")]) = true := by decide
example : (ambiguity m3_1_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_2_1 = 1 := rfl
def m3_1_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m3_1_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_1_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_2_2 = 1 := rfl
def m3_1_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m3_1_2_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m3_1_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_2_3 = 1 := rfl
def m3_1_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_3_0 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m3_1_3_0 ("h1",[]) = false := by decide
example : (ambiguity m3_1_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_3_0 = 1 := rfl
def m3_1_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_3_1 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_1_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_1_3_1).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_1_3_1 = 1 := rfl
def m3_1_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_3_2 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m3_1_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_1_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_1_3_2 = 1 := rfl
def m3_1_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x")]⟩
example : teaches m3_1_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_1_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_1_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_1_3_3 = 1 := rfl
def m3_2_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_0_0 ("h0",[]) = false := by decide
example : teaches m3_2_0_0 ("h1",[]) = false := by decide
example : (ambiguity m3_2_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_0_0 = 1 := rfl
def m3_2_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_0_1 ("h0",[]) = false := by decide
example : teaches m3_2_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_2_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_0_1 = 1 := rfl
def m3_2_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_0_2 ("h0",[]) = false := by decide
example : teaches m3_2_0_2 ("h1",[("b","y")]) = true := by decide
example : (ambiguity m3_2_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_0_2 = 1 := rfl
def m3_2_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_0_3 ("h0",[]) = false := by decide
example : teaches m3_2_0_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m3_2_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_0_3 = 1 := rfl
def m3_2_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m3_2_1_0 ("h1",[]) = false := by decide
example : (ambiguity m3_2_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_1_0 = 1 := rfl
def m3_2_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m3_2_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_2_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_1_1 = 1 := rfl
def m3_2_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m3_2_1_2 ("h1",[("b","y")]) = true := by decide
example : (ambiguity m3_2_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_1_2 = 1 := rfl
def m3_2_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m3_2_1_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m3_2_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_1_3 = 1 := rfl
def m3_2_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_2_0 ("h0",[("b","y")]) = true := by decide
example : teaches m3_2_2_0 ("h1",[]) = false := by decide
example : (ambiguity m3_2_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_2_0 = 1 := rfl
def m3_2_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_2_1 ("h0",[("b","y")]) = true := by decide
example : teaches m3_2_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_2_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_2_1 = 1 := rfl
def m3_2_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m3_2_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_2_2_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_2_2_2 = 1 := rfl
def m3_2_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m3_2_2_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_2_2_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_2_2_3 = 1 := rfl
def m3_2_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_3_0 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m3_2_3_0 ("h1",[]) = false := by decide
example : (ambiguity m3_2_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_3_0 = 1 := rfl
def m3_2_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_3_1 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m3_2_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_2_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_2_3_1 = 1 := rfl
def m3_2_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_3_2 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_2_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_2_3_2).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_2_3_2 = 1 := rfl
def m3_2_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("b","y")]⟩
example : teaches m3_2_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_2_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_2_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_2_3_3 = 1 := rfl
def m3_3_0_0 : Model := ⟨[("h0",[]),("h1",[])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_0_0 ("h0",[]) = false := by decide
example : teaches m3_3_0_0 ("h1",[]) = false := by decide
example : (ambiguity m3_3_0_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_0_0 = 2 := rfl
def m3_3_0_1 : Model := ⟨[("h0",[]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_0_1 ("h0",[]) = false := by decide
example : teaches m3_3_0_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_3_0_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_0_1 = 2 := rfl
def m3_3_0_2 : Model := ⟨[("h0",[]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_0_2 ("h0",[]) = false := by decide
example : teaches m3_3_0_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_3_0_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_0_2 = 2 := rfl
def m3_3_0_3 : Model := ⟨[("h0",[]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_0_3 ("h0",[]) = false := by decide
example : teaches m3_3_0_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m3_3_0_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_0_3 = 2 := rfl
def m3_3_1_0 : Model := ⟨[("h0",[("a","x")]),("h1",[])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_1_0 ("h0",[("a","x")]) = false := by decide
example : teaches m3_3_1_0 ("h1",[]) = false := by decide
example : (ambiguity m3_3_1_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_1_0 = 2 := rfl
def m3_3_1_1 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_1_1 ("h0",[("a","x")]) = false := by decide
example : teaches m3_3_1_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_3_1_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_1_1 = 2 := rfl
def m3_3_1_2 : Model := ⟨[("h0",[("a","x")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_1_2 ("h0",[("a","x")]) = false := by decide
example : teaches m3_3_1_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_3_1_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_1_2 = 2 := rfl
def m3_3_1_3 : Model := ⟨[("h0",[("a","x")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_1_3 ("h0",[("a","x")]) = false := by decide
example : teaches m3_3_1_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m3_3_1_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_1_3 = 2 := rfl
def m3_3_2_0 : Model := ⟨[("h0",[("b","y")]),("h1",[])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_2_0 ("h0",[("b","y")]) = false := by decide
example : teaches m3_3_2_0 ("h1",[]) = false := by decide
example : (ambiguity m3_3_2_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_2_0 = 2 := rfl
def m3_3_2_1 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_2_1 ("h0",[("b","y")]) = false := by decide
example : teaches m3_3_2_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_3_2_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_2_1 = 2 := rfl
def m3_3_2_2 : Model := ⟨[("h0",[("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_2_2 ("h0",[("b","y")]) = false := by decide
example : teaches m3_3_2_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_3_2_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_2_2 = 2 := rfl
def m3_3_2_3 : Model := ⟨[("h0",[("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_2_3 ("h0",[("b","y")]) = false := by decide
example : teaches m3_3_2_3 ("h1",[("a","x"),("b","y")]) = true := by decide
example : (ambiguity m3_3_2_3).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_2_3 = 2 := rfl
def m3_3_3_0 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_3_0 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m3_3_3_0 ("h1",[]) = false := by decide
example : (ambiguity m3_3_3_0).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_3_0 = 2 := rfl
def m3_3_3_1 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_3_1 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m3_3_3_1 ("h1",[("a","x")]) = false := by decide
example : (ambiguity m3_3_3_1).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_3_1 = 2 := rfl
def m3_3_3_2 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_3_2 ("h0",[("a","x"),("b","y")]) = true := by decide
example : teaches m3_3_3_2 ("h1",[("b","y")]) = false := by decide
example : (ambiguity m3_3_3_2).map (fun p => (p.1.1,p.2.1)) = [] := by decide
example : sampleSize m3_3_3_2 = 2 := rfl
def m3_3_3_3 : Model := ⟨[("h0",[("a","x"),("b","y")]),("h1",[("a","x"),("b","y")])],[("a","x"),("b","y")],[("a","x"),("b","y")]⟩
example : teaches m3_3_3_3 ("h0",[("a","x"),("b","y")]) = false := by decide
example : teaches m3_3_3_3 ("h1",[("a","x"),("b","y")]) = false := by decide
example : (ambiguity m3_3_3_3).map (fun p => (p.1.1,p.2.1)) = [("h0","h1"),("h1","h0")] := by decide
example : sampleSize m3_3_3_3 = 2 := rfl
theorem nativeWitness : ∃ e, e ∈ m1_1_1_0.sample ∧ e ∈ [("a","x")] ∧ e ∉ ([] : List SFT.Computation.Inference.Evidence) := teachingWitness m1_1_1_0 ("h0",[("a","x")]) ("h1",[]) (by decide) (.tail _ (.head _)) (by decide)
#print axioms nativeWitness
end SFT.Computation.SampleComplexity
