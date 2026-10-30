import SFT.Computation.SecurityDefinition
namespace SFT.Computation.SecurityDefinition
def a : Attempt := ⟨"adv","s0","v","s0",2⟩
def b : Attempt := ⟨"adv","s1","v","s0",1⟩
def m0_0_0_0 : Model := ⟨[],[],[],[]⟩
example : rows m0_0_0_0 = [] := by decide
example : successes m0_0_0_0 = [] := by decide
example : allFail m0_0_0_0 = true := by decide
example : fullObservationClosure m0_0_0_0 = true := by decide
example : boundedSuccesses m0_0_0_0 1 = [] := by decide
example : boundedFail m0_0_0_0 1 = true := by decide
example : boundedSuccesses m0_0_0_0 2 = [] := by decide
example : boundedFail m0_0_0_0 2 = true := by decide
def m0_0_0_1 : Model := ⟨[],[],[],[a]⟩
example : rows m0_0_0_1 = [] := by decide
example : successes m0_0_0_1 = [] := by decide
example : allFail m0_0_0_1 = true := by decide
example : fullObservationClosure m0_0_0_1 = true := by decide
example : boundedSuccesses m0_0_0_1 1 = [] := by decide
example : boundedFail m0_0_0_1 1 = true := by decide
example : boundedSuccesses m0_0_0_1 2 = [] := by decide
example : boundedFail m0_0_0_1 2 = true := by decide
def m0_0_0_2 : Model := ⟨[],[],[],[b]⟩
example : rows m0_0_0_2 = [] := by decide
example : successes m0_0_0_2 = [] := by decide
example : allFail m0_0_0_2 = true := by decide
example : fullObservationClosure m0_0_0_2 = true := by decide
example : boundedSuccesses m0_0_0_2 1 = [] := by decide
example : boundedFail m0_0_0_2 1 = true := by decide
example : boundedSuccesses m0_0_0_2 2 = [] := by decide
example : boundedFail m0_0_0_2 2 = true := by decide
def m0_0_0_3 : Model := ⟨[],[],[],[a,b]⟩
example : rows m0_0_0_3 = [] := by decide
example : successes m0_0_0_3 = [] := by decide
example : allFail m0_0_0_3 = true := by decide
example : fullObservationClosure m0_0_0_3 = true := by decide
example : boundedSuccesses m0_0_0_3 1 = [] := by decide
example : boundedFail m0_0_0_3 1 = true := by decide
example : boundedSuccesses m0_0_0_3 2 = [] := by decide
example : boundedFail m0_0_0_3 2 = true := by decide
def m0_0_1_0 : Model := ⟨[],[],["adv"],[]⟩
example : rows m0_0_1_0 = [] := by decide
example : successes m0_0_1_0 = [] := by decide
example : allFail m0_0_1_0 = true := by decide
example : fullObservationClosure m0_0_1_0 = true := by decide
example : boundedSuccesses m0_0_1_0 1 = [] := by decide
example : boundedFail m0_0_1_0 1 = true := by decide
example : boundedSuccesses m0_0_1_0 2 = [] := by decide
example : boundedFail m0_0_1_0 2 = true := by decide
def m0_0_1_1 : Model := ⟨[],[],["adv"],[a]⟩
example : rows m0_0_1_1 = [] := by decide
example : successes m0_0_1_1 = [] := by decide
example : allFail m0_0_1_1 = true := by decide
example : fullObservationClosure m0_0_1_1 = true := by decide
example : boundedSuccesses m0_0_1_1 1 = [] := by decide
example : boundedFail m0_0_1_1 1 = true := by decide
example : boundedSuccesses m0_0_1_1 2 = [] := by decide
example : boundedFail m0_0_1_1 2 = true := by decide
def m0_0_1_2 : Model := ⟨[],[],["adv"],[b]⟩
example : rows m0_0_1_2 = [] := by decide
example : successes m0_0_1_2 = [] := by decide
example : allFail m0_0_1_2 = true := by decide
example : fullObservationClosure m0_0_1_2 = true := by decide
example : boundedSuccesses m0_0_1_2 1 = [] := by decide
example : boundedFail m0_0_1_2 1 = true := by decide
example : boundedSuccesses m0_0_1_2 2 = [] := by decide
example : boundedFail m0_0_1_2 2 = true := by decide
def m0_0_1_3 : Model := ⟨[],[],["adv"],[a,b]⟩
example : rows m0_0_1_3 = [] := by decide
example : successes m0_0_1_3 = [] := by decide
example : allFail m0_0_1_3 = true := by decide
example : fullObservationClosure m0_0_1_3 = true := by decide
example : boundedSuccesses m0_0_1_3 1 = [] := by decide
example : boundedFail m0_0_1_3 1 = true := by decide
example : boundedSuccesses m0_0_1_3 2 = [] := by decide
example : boundedFail m0_0_1_3 2 = true := by decide
def m0_1_0_0 : Model := ⟨[],[("s0","v")],[],[]⟩
example : rows m0_1_0_0 = [] := by decide
example : successes m0_1_0_0 = [] := by decide
example : allFail m0_1_0_0 = true := by decide
example : fullObservationClosure m0_1_0_0 = true := by decide
example : boundedSuccesses m0_1_0_0 1 = [] := by decide
example : boundedFail m0_1_0_0 1 = true := by decide
example : boundedSuccesses m0_1_0_0 2 = [] := by decide
example : boundedFail m0_1_0_0 2 = true := by decide
def m0_1_0_1 : Model := ⟨[],[("s0","v")],[],[a]⟩
example : rows m0_1_0_1 = [] := by decide
example : successes m0_1_0_1 = [] := by decide
example : allFail m0_1_0_1 = true := by decide
example : fullObservationClosure m0_1_0_1 = true := by decide
example : boundedSuccesses m0_1_0_1 1 = [] := by decide
example : boundedFail m0_1_0_1 1 = true := by decide
example : boundedSuccesses m0_1_0_1 2 = [] := by decide
example : boundedFail m0_1_0_1 2 = true := by decide
def m0_1_0_2 : Model := ⟨[],[("s0","v")],[],[b]⟩
example : rows m0_1_0_2 = [] := by decide
example : successes m0_1_0_2 = [] := by decide
example : allFail m0_1_0_2 = true := by decide
example : fullObservationClosure m0_1_0_2 = true := by decide
example : boundedSuccesses m0_1_0_2 1 = [] := by decide
example : boundedFail m0_1_0_2 1 = true := by decide
example : boundedSuccesses m0_1_0_2 2 = [] := by decide
example : boundedFail m0_1_0_2 2 = true := by decide
def m0_1_0_3 : Model := ⟨[],[("s0","v")],[],[a,b]⟩
example : rows m0_1_0_3 = [] := by decide
example : successes m0_1_0_3 = [] := by decide
example : allFail m0_1_0_3 = true := by decide
example : fullObservationClosure m0_1_0_3 = true := by decide
example : boundedSuccesses m0_1_0_3 1 = [] := by decide
example : boundedFail m0_1_0_3 1 = true := by decide
example : boundedSuccesses m0_1_0_3 2 = [] := by decide
example : boundedFail m0_1_0_3 2 = true := by decide
def m0_1_1_0 : Model := ⟨[],[("s0","v")],["adv"],[]⟩
example : rows m0_1_1_0 = [] := by decide
example : successes m0_1_1_0 = [] := by decide
example : allFail m0_1_1_0 = true := by decide
example : fullObservationClosure m0_1_1_0 = true := by decide
example : boundedSuccesses m0_1_1_0 1 = [] := by decide
example : boundedFail m0_1_1_0 1 = true := by decide
example : boundedSuccesses m0_1_1_0 2 = [] := by decide
example : boundedFail m0_1_1_0 2 = true := by decide
def m0_1_1_1 : Model := ⟨[],[("s0","v")],["adv"],[a]⟩
example : rows m0_1_1_1 = [] := by decide
example : successes m0_1_1_1 = [] := by decide
example : allFail m0_1_1_1 = true := by decide
example : fullObservationClosure m0_1_1_1 = true := by decide
example : boundedSuccesses m0_1_1_1 1 = [] := by decide
example : boundedFail m0_1_1_1 1 = true := by decide
example : boundedSuccesses m0_1_1_1 2 = [] := by decide
example : boundedFail m0_1_1_1 2 = true := by decide
def m0_1_1_2 : Model := ⟨[],[("s0","v")],["adv"],[b]⟩
example : rows m0_1_1_2 = [] := by decide
example : successes m0_1_1_2 = [] := by decide
example : allFail m0_1_1_2 = true := by decide
example : fullObservationClosure m0_1_1_2 = true := by decide
example : boundedSuccesses m0_1_1_2 1 = [] := by decide
example : boundedFail m0_1_1_2 1 = true := by decide
example : boundedSuccesses m0_1_1_2 2 = [] := by decide
example : boundedFail m0_1_1_2 2 = true := by decide
def m0_1_1_3 : Model := ⟨[],[("s0","v")],["adv"],[a,b]⟩
example : rows m0_1_1_3 = [] := by decide
example : successes m0_1_1_3 = [] := by decide
example : allFail m0_1_1_3 = true := by decide
example : fullObservationClosure m0_1_1_3 = true := by decide
example : boundedSuccesses m0_1_1_3 1 = [] := by decide
example : boundedFail m0_1_1_3 1 = true := by decide
example : boundedSuccesses m0_1_1_3 2 = [] := by decide
example : boundedFail m0_1_1_3 2 = true := by decide
def m0_2_0_0 : Model := ⟨[],[("s1","v")],[],[]⟩
example : rows m0_2_0_0 = [] := by decide
example : successes m0_2_0_0 = [] := by decide
example : allFail m0_2_0_0 = true := by decide
example : fullObservationClosure m0_2_0_0 = true := by decide
example : boundedSuccesses m0_2_0_0 1 = [] := by decide
example : boundedFail m0_2_0_0 1 = true := by decide
example : boundedSuccesses m0_2_0_0 2 = [] := by decide
example : boundedFail m0_2_0_0 2 = true := by decide
def m0_2_0_1 : Model := ⟨[],[("s1","v")],[],[a]⟩
example : rows m0_2_0_1 = [] := by decide
example : successes m0_2_0_1 = [] := by decide
example : allFail m0_2_0_1 = true := by decide
example : fullObservationClosure m0_2_0_1 = true := by decide
example : boundedSuccesses m0_2_0_1 1 = [] := by decide
example : boundedFail m0_2_0_1 1 = true := by decide
example : boundedSuccesses m0_2_0_1 2 = [] := by decide
example : boundedFail m0_2_0_1 2 = true := by decide
def m0_2_0_2 : Model := ⟨[],[("s1","v")],[],[b]⟩
example : rows m0_2_0_2 = [] := by decide
example : successes m0_2_0_2 = [] := by decide
example : allFail m0_2_0_2 = true := by decide
example : fullObservationClosure m0_2_0_2 = true := by decide
example : boundedSuccesses m0_2_0_2 1 = [] := by decide
example : boundedFail m0_2_0_2 1 = true := by decide
example : boundedSuccesses m0_2_0_2 2 = [] := by decide
example : boundedFail m0_2_0_2 2 = true := by decide
def m0_2_0_3 : Model := ⟨[],[("s1","v")],[],[a,b]⟩
example : rows m0_2_0_3 = [] := by decide
example : successes m0_2_0_3 = [] := by decide
example : allFail m0_2_0_3 = true := by decide
example : fullObservationClosure m0_2_0_3 = true := by decide
example : boundedSuccesses m0_2_0_3 1 = [] := by decide
example : boundedFail m0_2_0_3 1 = true := by decide
example : boundedSuccesses m0_2_0_3 2 = [] := by decide
example : boundedFail m0_2_0_3 2 = true := by decide
def m0_2_1_0 : Model := ⟨[],[("s1","v")],["adv"],[]⟩
example : rows m0_2_1_0 = [] := by decide
example : successes m0_2_1_0 = [] := by decide
example : allFail m0_2_1_0 = true := by decide
example : fullObservationClosure m0_2_1_0 = true := by decide
example : boundedSuccesses m0_2_1_0 1 = [] := by decide
example : boundedFail m0_2_1_0 1 = true := by decide
example : boundedSuccesses m0_2_1_0 2 = [] := by decide
example : boundedFail m0_2_1_0 2 = true := by decide
def m0_2_1_1 : Model := ⟨[],[("s1","v")],["adv"],[a]⟩
example : rows m0_2_1_1 = [] := by decide
example : successes m0_2_1_1 = [] := by decide
example : allFail m0_2_1_1 = true := by decide
example : fullObservationClosure m0_2_1_1 = true := by decide
example : boundedSuccesses m0_2_1_1 1 = [] := by decide
example : boundedFail m0_2_1_1 1 = true := by decide
example : boundedSuccesses m0_2_1_1 2 = [] := by decide
example : boundedFail m0_2_1_1 2 = true := by decide
def m0_2_1_2 : Model := ⟨[],[("s1","v")],["adv"],[b]⟩
example : rows m0_2_1_2 = [] := by decide
example : successes m0_2_1_2 = [] := by decide
example : allFail m0_2_1_2 = true := by decide
example : fullObservationClosure m0_2_1_2 = true := by decide
example : boundedSuccesses m0_2_1_2 1 = [] := by decide
example : boundedFail m0_2_1_2 1 = true := by decide
example : boundedSuccesses m0_2_1_2 2 = [] := by decide
example : boundedFail m0_2_1_2 2 = true := by decide
def m0_2_1_3 : Model := ⟨[],[("s1","v")],["adv"],[a,b]⟩
example : rows m0_2_1_3 = [] := by decide
example : successes m0_2_1_3 = [] := by decide
example : allFail m0_2_1_3 = true := by decide
example : fullObservationClosure m0_2_1_3 = true := by decide
example : boundedSuccesses m0_2_1_3 1 = [] := by decide
example : boundedFail m0_2_1_3 1 = true := by decide
example : boundedSuccesses m0_2_1_3 2 = [] := by decide
example : boundedFail m0_2_1_3 2 = true := by decide
def m0_3_0_0 : Model := ⟨[],[("s0","v"),("s1","v")],[],[]⟩
example : rows m0_3_0_0 = [] := by decide
example : successes m0_3_0_0 = [] := by decide
example : allFail m0_3_0_0 = true := by decide
example : fullObservationClosure m0_3_0_0 = true := by decide
example : boundedSuccesses m0_3_0_0 1 = [] := by decide
example : boundedFail m0_3_0_0 1 = true := by decide
example : boundedSuccesses m0_3_0_0 2 = [] := by decide
example : boundedFail m0_3_0_0 2 = true := by decide
def m0_3_0_1 : Model := ⟨[],[("s0","v"),("s1","v")],[],[a]⟩
example : rows m0_3_0_1 = [] := by decide
example : successes m0_3_0_1 = [] := by decide
example : allFail m0_3_0_1 = true := by decide
example : fullObservationClosure m0_3_0_1 = true := by decide
example : boundedSuccesses m0_3_0_1 1 = [] := by decide
example : boundedFail m0_3_0_1 1 = true := by decide
example : boundedSuccesses m0_3_0_1 2 = [] := by decide
example : boundedFail m0_3_0_1 2 = true := by decide
def m0_3_0_2 : Model := ⟨[],[("s0","v"),("s1","v")],[],[b]⟩
example : rows m0_3_0_2 = [] := by decide
example : successes m0_3_0_2 = [] := by decide
example : allFail m0_3_0_2 = true := by decide
example : fullObservationClosure m0_3_0_2 = true := by decide
example : boundedSuccesses m0_3_0_2 1 = [] := by decide
example : boundedFail m0_3_0_2 1 = true := by decide
example : boundedSuccesses m0_3_0_2 2 = [] := by decide
example : boundedFail m0_3_0_2 2 = true := by decide
def m0_3_0_3 : Model := ⟨[],[("s0","v"),("s1","v")],[],[a,b]⟩
example : rows m0_3_0_3 = [] := by decide
example : successes m0_3_0_3 = [] := by decide
example : allFail m0_3_0_3 = true := by decide
example : fullObservationClosure m0_3_0_3 = true := by decide
example : boundedSuccesses m0_3_0_3 1 = [] := by decide
example : boundedFail m0_3_0_3 1 = true := by decide
example : boundedSuccesses m0_3_0_3 2 = [] := by decide
example : boundedFail m0_3_0_3 2 = true := by decide
def m0_3_1_0 : Model := ⟨[],[("s0","v"),("s1","v")],["adv"],[]⟩
example : rows m0_3_1_0 = [] := by decide
example : successes m0_3_1_0 = [] := by decide
example : allFail m0_3_1_0 = true := by decide
example : fullObservationClosure m0_3_1_0 = true := by decide
example : boundedSuccesses m0_3_1_0 1 = [] := by decide
example : boundedFail m0_3_1_0 1 = true := by decide
example : boundedSuccesses m0_3_1_0 2 = [] := by decide
example : boundedFail m0_3_1_0 2 = true := by decide
def m0_3_1_1 : Model := ⟨[],[("s0","v"),("s1","v")],["adv"],[a]⟩
example : rows m0_3_1_1 = [] := by decide
example : successes m0_3_1_1 = [] := by decide
example : allFail m0_3_1_1 = true := by decide
example : fullObservationClosure m0_3_1_1 = true := by decide
example : boundedSuccesses m0_3_1_1 1 = [] := by decide
example : boundedFail m0_3_1_1 1 = true := by decide
example : boundedSuccesses m0_3_1_1 2 = [] := by decide
example : boundedFail m0_3_1_1 2 = true := by decide
def m0_3_1_2 : Model := ⟨[],[("s0","v"),("s1","v")],["adv"],[b]⟩
example : rows m0_3_1_2 = [] := by decide
example : successes m0_3_1_2 = [] := by decide
example : allFail m0_3_1_2 = true := by decide
example : fullObservationClosure m0_3_1_2 = true := by decide
example : boundedSuccesses m0_3_1_2 1 = [] := by decide
example : boundedFail m0_3_1_2 1 = true := by decide
example : boundedSuccesses m0_3_1_2 2 = [] := by decide
example : boundedFail m0_3_1_2 2 = true := by decide
def m0_3_1_3 : Model := ⟨[],[("s0","v"),("s1","v")],["adv"],[a,b]⟩
example : rows m0_3_1_3 = [] := by decide
example : successes m0_3_1_3 = [] := by decide
example : allFail m0_3_1_3 = true := by decide
example : fullObservationClosure m0_3_1_3 = true := by decide
example : boundedSuccesses m0_3_1_3 1 = [] := by decide
example : boundedFail m0_3_1_3 1 = true := by decide
example : boundedSuccesses m0_3_1_3 2 = [] := by decide
example : boundedFail m0_3_1_3 2 = true := by decide
def m1_0_0_0 : Model := ⟨["s0"],[],[],[]⟩
example : rows m1_0_0_0 = [] := by decide
example : successes m1_0_0_0 = [] := by decide
example : allFail m1_0_0_0 = true := by decide
example : fullObservationClosure m1_0_0_0 = true := by decide
example : boundedSuccesses m1_0_0_0 1 = [] := by decide
example : boundedFail m1_0_0_0 1 = true := by decide
example : boundedSuccesses m1_0_0_0 2 = [] := by decide
example : boundedFail m1_0_0_0 2 = true := by decide
def m1_0_0_1 : Model := ⟨["s0"],[],[],[a]⟩
example : rows m1_0_0_1 = [] := by decide
example : successes m1_0_0_1 = [] := by decide
example : allFail m1_0_0_1 = true := by decide
example : fullObservationClosure m1_0_0_1 = true := by decide
example : boundedSuccesses m1_0_0_1 1 = [] := by decide
example : boundedFail m1_0_0_1 1 = true := by decide
example : boundedSuccesses m1_0_0_1 2 = [] := by decide
example : boundedFail m1_0_0_1 2 = true := by decide
def m1_0_0_2 : Model := ⟨["s0"],[],[],[b]⟩
example : rows m1_0_0_2 = [] := by decide
example : successes m1_0_0_2 = [] := by decide
example : allFail m1_0_0_2 = true := by decide
example : fullObservationClosure m1_0_0_2 = true := by decide
example : boundedSuccesses m1_0_0_2 1 = [] := by decide
example : boundedFail m1_0_0_2 1 = true := by decide
example : boundedSuccesses m1_0_0_2 2 = [] := by decide
example : boundedFail m1_0_0_2 2 = true := by decide
def m1_0_0_3 : Model := ⟨["s0"],[],[],[a,b]⟩
example : rows m1_0_0_3 = [] := by decide
example : successes m1_0_0_3 = [] := by decide
example : allFail m1_0_0_3 = true := by decide
example : fullObservationClosure m1_0_0_3 = true := by decide
example : boundedSuccesses m1_0_0_3 1 = [] := by decide
example : boundedFail m1_0_0_3 1 = true := by decide
example : boundedSuccesses m1_0_0_3 2 = [] := by decide
example : boundedFail m1_0_0_3 2 = true := by decide
def m1_0_1_0 : Model := ⟨["s0"],[],["adv"],[]⟩
example : rows m1_0_1_0 = [] := by decide
example : successes m1_0_1_0 = [] := by decide
example : allFail m1_0_1_0 = true := by decide
example : fullObservationClosure m1_0_1_0 = true := by decide
example : boundedSuccesses m1_0_1_0 1 = [] := by decide
example : boundedFail m1_0_1_0 1 = true := by decide
example : boundedSuccesses m1_0_1_0 2 = [] := by decide
example : boundedFail m1_0_1_0 2 = true := by decide
def m1_0_1_1 : Model := ⟨["s0"],[],["adv"],[a]⟩
example : rows m1_0_1_1 = [] := by decide
example : successes m1_0_1_1 = [] := by decide
example : allFail m1_0_1_1 = true := by decide
example : fullObservationClosure m1_0_1_1 = true := by decide
example : boundedSuccesses m1_0_1_1 1 = [] := by decide
example : boundedFail m1_0_1_1 1 = true := by decide
example : boundedSuccesses m1_0_1_1 2 = [] := by decide
example : boundedFail m1_0_1_1 2 = true := by decide
def m1_0_1_2 : Model := ⟨["s0"],[],["adv"],[b]⟩
example : rows m1_0_1_2 = [] := by decide
example : successes m1_0_1_2 = [] := by decide
example : allFail m1_0_1_2 = true := by decide
example : fullObservationClosure m1_0_1_2 = true := by decide
example : boundedSuccesses m1_0_1_2 1 = [] := by decide
example : boundedFail m1_0_1_2 1 = true := by decide
example : boundedSuccesses m1_0_1_2 2 = [] := by decide
example : boundedFail m1_0_1_2 2 = true := by decide
def m1_0_1_3 : Model := ⟨["s0"],[],["adv"],[a,b]⟩
example : rows m1_0_1_3 = [] := by decide
example : successes m1_0_1_3 = [] := by decide
example : allFail m1_0_1_3 = true := by decide
example : fullObservationClosure m1_0_1_3 = true := by decide
example : boundedSuccesses m1_0_1_3 1 = [] := by decide
example : boundedFail m1_0_1_3 1 = true := by decide
example : boundedSuccesses m1_0_1_3 2 = [] := by decide
example : boundedFail m1_0_1_3 2 = true := by decide
def m1_1_0_0 : Model := ⟨["s0"],[("s0","v")],[],[]⟩
example : rows m1_1_0_0 = [] := by decide
example : successes m1_1_0_0 = [] := by decide
example : allFail m1_1_0_0 = true := by decide
example : fullObservationClosure m1_1_0_0 = true := by decide
example : boundedSuccesses m1_1_0_0 1 = [] := by decide
example : boundedFail m1_1_0_0 1 = true := by decide
example : boundedSuccesses m1_1_0_0 2 = [] := by decide
example : boundedFail m1_1_0_0 2 = true := by decide
def m1_1_0_1 : Model := ⟨["s0"],[("s0","v")],[],[a]⟩
example : rows m1_1_0_1 = [] := by decide
example : successes m1_1_0_1 = [] := by decide
example : allFail m1_1_0_1 = true := by decide
example : fullObservationClosure m1_1_0_1 = true := by decide
example : boundedSuccesses m1_1_0_1 1 = [] := by decide
example : boundedFail m1_1_0_1 1 = true := by decide
example : boundedSuccesses m1_1_0_1 2 = [] := by decide
example : boundedFail m1_1_0_1 2 = true := by decide
def m1_1_0_2 : Model := ⟨["s0"],[("s0","v")],[],[b]⟩
example : rows m1_1_0_2 = [] := by decide
example : successes m1_1_0_2 = [] := by decide
example : allFail m1_1_0_2 = true := by decide
example : fullObservationClosure m1_1_0_2 = true := by decide
example : boundedSuccesses m1_1_0_2 1 = [] := by decide
example : boundedFail m1_1_0_2 1 = true := by decide
example : boundedSuccesses m1_1_0_2 2 = [] := by decide
example : boundedFail m1_1_0_2 2 = true := by decide
def m1_1_0_3 : Model := ⟨["s0"],[("s0","v")],[],[a,b]⟩
example : rows m1_1_0_3 = [] := by decide
example : successes m1_1_0_3 = [] := by decide
example : allFail m1_1_0_3 = true := by decide
example : fullObservationClosure m1_1_0_3 = true := by decide
example : boundedSuccesses m1_1_0_3 1 = [] := by decide
example : boundedFail m1_1_0_3 1 = true := by decide
example : boundedSuccesses m1_1_0_3 2 = [] := by decide
example : boundedFail m1_1_0_3 2 = true := by decide
def m1_1_1_0 : Model := ⟨["s0"],[("s0","v")],["adv"],[]⟩
example : rows m1_1_1_0 = [] := by decide
example : successes m1_1_1_0 = [] := by decide
example : allFail m1_1_1_0 = true := by decide
example : fullObservationClosure m1_1_1_0 = true := by decide
example : boundedSuccesses m1_1_1_0 1 = [] := by decide
example : boundedFail m1_1_1_0 1 = true := by decide
example : boundedSuccesses m1_1_1_0 2 = [] := by decide
example : boundedFail m1_1_1_0 2 = true := by decide
def m1_1_1_1 : Model := ⟨["s0"],[("s0","v")],["adv"],[a]⟩
example : rows m1_1_1_1 = [a] := by decide
example : successes m1_1_1_1 = [a] := by decide
example : allFail m1_1_1_1 = false := by decide
example : fullObservationClosure m1_1_1_1 = true := by decide
example : boundedSuccesses m1_1_1_1 1 = [] := by decide
example : boundedFail m1_1_1_1 1 = true := by decide
example : boundedSuccesses m1_1_1_1 2 = [a] := by decide
example : boundedFail m1_1_1_1 2 = false := by decide
def m1_1_1_2 : Model := ⟨["s0"],[("s0","v")],["adv"],[b]⟩
example : rows m1_1_1_2 = [] := by decide
example : successes m1_1_1_2 = [] := by decide
example : allFail m1_1_1_2 = true := by decide
example : fullObservationClosure m1_1_1_2 = true := by decide
example : boundedSuccesses m1_1_1_2 1 = [] := by decide
example : boundedFail m1_1_1_2 1 = true := by decide
example : boundedSuccesses m1_1_1_2 2 = [] := by decide
example : boundedFail m1_1_1_2 2 = true := by decide
def m1_1_1_3 : Model := ⟨["s0"],[("s0","v")],["adv"],[a,b]⟩
example : rows m1_1_1_3 = [a] := by decide
example : successes m1_1_1_3 = [a] := by decide
example : allFail m1_1_1_3 = false := by decide
example : fullObservationClosure m1_1_1_3 = true := by decide
example : boundedSuccesses m1_1_1_3 1 = [] := by decide
example : boundedFail m1_1_1_3 1 = true := by decide
example : boundedSuccesses m1_1_1_3 2 = [a] := by decide
example : boundedFail m1_1_1_3 2 = false := by decide
def m1_2_0_0 : Model := ⟨["s0"],[("s1","v")],[],[]⟩
example : rows m1_2_0_0 = [] := by decide
example : successes m1_2_0_0 = [] := by decide
example : allFail m1_2_0_0 = true := by decide
example : fullObservationClosure m1_2_0_0 = true := by decide
example : boundedSuccesses m1_2_0_0 1 = [] := by decide
example : boundedFail m1_2_0_0 1 = true := by decide
example : boundedSuccesses m1_2_0_0 2 = [] := by decide
example : boundedFail m1_2_0_0 2 = true := by decide
def m1_2_0_1 : Model := ⟨["s0"],[("s1","v")],[],[a]⟩
example : rows m1_2_0_1 = [] := by decide
example : successes m1_2_0_1 = [] := by decide
example : allFail m1_2_0_1 = true := by decide
example : fullObservationClosure m1_2_0_1 = true := by decide
example : boundedSuccesses m1_2_0_1 1 = [] := by decide
example : boundedFail m1_2_0_1 1 = true := by decide
example : boundedSuccesses m1_2_0_1 2 = [] := by decide
example : boundedFail m1_2_0_1 2 = true := by decide
def m1_2_0_2 : Model := ⟨["s0"],[("s1","v")],[],[b]⟩
example : rows m1_2_0_2 = [] := by decide
example : successes m1_2_0_2 = [] := by decide
example : allFail m1_2_0_2 = true := by decide
example : fullObservationClosure m1_2_0_2 = true := by decide
example : boundedSuccesses m1_2_0_2 1 = [] := by decide
example : boundedFail m1_2_0_2 1 = true := by decide
example : boundedSuccesses m1_2_0_2 2 = [] := by decide
example : boundedFail m1_2_0_2 2 = true := by decide
def m1_2_0_3 : Model := ⟨["s0"],[("s1","v")],[],[a,b]⟩
example : rows m1_2_0_3 = [] := by decide
example : successes m1_2_0_3 = [] := by decide
example : allFail m1_2_0_3 = true := by decide
example : fullObservationClosure m1_2_0_3 = true := by decide
example : boundedSuccesses m1_2_0_3 1 = [] := by decide
example : boundedFail m1_2_0_3 1 = true := by decide
example : boundedSuccesses m1_2_0_3 2 = [] := by decide
example : boundedFail m1_2_0_3 2 = true := by decide
def m1_2_1_0 : Model := ⟨["s0"],[("s1","v")],["adv"],[]⟩
example : rows m1_2_1_0 = [] := by decide
example : successes m1_2_1_0 = [] := by decide
example : allFail m1_2_1_0 = true := by decide
example : fullObservationClosure m1_2_1_0 = true := by decide
example : boundedSuccesses m1_2_1_0 1 = [] := by decide
example : boundedFail m1_2_1_0 1 = true := by decide
example : boundedSuccesses m1_2_1_0 2 = [] := by decide
example : boundedFail m1_2_1_0 2 = true := by decide
def m1_2_1_1 : Model := ⟨["s0"],[("s1","v")],["adv"],[a]⟩
example : rows m1_2_1_1 = [] := by decide
example : successes m1_2_1_1 = [] := by decide
example : allFail m1_2_1_1 = true := by decide
example : fullObservationClosure m1_2_1_1 = true := by decide
example : boundedSuccesses m1_2_1_1 1 = [] := by decide
example : boundedFail m1_2_1_1 1 = true := by decide
example : boundedSuccesses m1_2_1_1 2 = [] := by decide
example : boundedFail m1_2_1_1 2 = true := by decide
def m1_2_1_2 : Model := ⟨["s0"],[("s1","v")],["adv"],[b]⟩
example : rows m1_2_1_2 = [] := by decide
example : successes m1_2_1_2 = [] := by decide
example : allFail m1_2_1_2 = true := by decide
example : fullObservationClosure m1_2_1_2 = true := by decide
example : boundedSuccesses m1_2_1_2 1 = [] := by decide
example : boundedFail m1_2_1_2 1 = true := by decide
example : boundedSuccesses m1_2_1_2 2 = [] := by decide
example : boundedFail m1_2_1_2 2 = true := by decide
def m1_2_1_3 : Model := ⟨["s0"],[("s1","v")],["adv"],[a,b]⟩
example : rows m1_2_1_3 = [] := by decide
example : successes m1_2_1_3 = [] := by decide
example : allFail m1_2_1_3 = true := by decide
example : fullObservationClosure m1_2_1_3 = true := by decide
example : boundedSuccesses m1_2_1_3 1 = [] := by decide
example : boundedFail m1_2_1_3 1 = true := by decide
example : boundedSuccesses m1_2_1_3 2 = [] := by decide
example : boundedFail m1_2_1_3 2 = true := by decide
def m1_3_0_0 : Model := ⟨["s0"],[("s0","v"),("s1","v")],[],[]⟩
example : rows m1_3_0_0 = [] := by decide
example : successes m1_3_0_0 = [] := by decide
example : allFail m1_3_0_0 = true := by decide
example : fullObservationClosure m1_3_0_0 = true := by decide
example : boundedSuccesses m1_3_0_0 1 = [] := by decide
example : boundedFail m1_3_0_0 1 = true := by decide
example : boundedSuccesses m1_3_0_0 2 = [] := by decide
example : boundedFail m1_3_0_0 2 = true := by decide
def m1_3_0_1 : Model := ⟨["s0"],[("s0","v"),("s1","v")],[],[a]⟩
example : rows m1_3_0_1 = [] := by decide
example : successes m1_3_0_1 = [] := by decide
example : allFail m1_3_0_1 = true := by decide
example : fullObservationClosure m1_3_0_1 = true := by decide
example : boundedSuccesses m1_3_0_1 1 = [] := by decide
example : boundedFail m1_3_0_1 1 = true := by decide
example : boundedSuccesses m1_3_0_1 2 = [] := by decide
example : boundedFail m1_3_0_1 2 = true := by decide
def m1_3_0_2 : Model := ⟨["s0"],[("s0","v"),("s1","v")],[],[b]⟩
example : rows m1_3_0_2 = [] := by decide
example : successes m1_3_0_2 = [] := by decide
example : allFail m1_3_0_2 = true := by decide
example : fullObservationClosure m1_3_0_2 = true := by decide
example : boundedSuccesses m1_3_0_2 1 = [] := by decide
example : boundedFail m1_3_0_2 1 = true := by decide
example : boundedSuccesses m1_3_0_2 2 = [] := by decide
example : boundedFail m1_3_0_2 2 = true := by decide
def m1_3_0_3 : Model := ⟨["s0"],[("s0","v"),("s1","v")],[],[a,b]⟩
example : rows m1_3_0_3 = [] := by decide
example : successes m1_3_0_3 = [] := by decide
example : allFail m1_3_0_3 = true := by decide
example : fullObservationClosure m1_3_0_3 = true := by decide
example : boundedSuccesses m1_3_0_3 1 = [] := by decide
example : boundedFail m1_3_0_3 1 = true := by decide
example : boundedSuccesses m1_3_0_3 2 = [] := by decide
example : boundedFail m1_3_0_3 2 = true := by decide
def m1_3_1_0 : Model := ⟨["s0"],[("s0","v"),("s1","v")],["adv"],[]⟩
example : rows m1_3_1_0 = [] := by decide
example : successes m1_3_1_0 = [] := by decide
example : allFail m1_3_1_0 = true := by decide
example : fullObservationClosure m1_3_1_0 = true := by decide
example : boundedSuccesses m1_3_1_0 1 = [] := by decide
example : boundedFail m1_3_1_0 1 = true := by decide
example : boundedSuccesses m1_3_1_0 2 = [] := by decide
example : boundedFail m1_3_1_0 2 = true := by decide
def m1_3_1_1 : Model := ⟨["s0"],[("s0","v"),("s1","v")],["adv"],[a]⟩
example : rows m1_3_1_1 = [a] := by decide
example : successes m1_3_1_1 = [a] := by decide
example : allFail m1_3_1_1 = false := by decide
example : fullObservationClosure m1_3_1_1 = true := by decide
example : boundedSuccesses m1_3_1_1 1 = [] := by decide
example : boundedFail m1_3_1_1 1 = true := by decide
example : boundedSuccesses m1_3_1_1 2 = [a] := by decide
example : boundedFail m1_3_1_1 2 = false := by decide
def m1_3_1_2 : Model := ⟨["s0"],[("s0","v"),("s1","v")],["adv"],[b]⟩
example : rows m1_3_1_2 = [] := by decide
example : successes m1_3_1_2 = [] := by decide
example : allFail m1_3_1_2 = true := by decide
example : fullObservationClosure m1_3_1_2 = true := by decide
example : boundedSuccesses m1_3_1_2 1 = [] := by decide
example : boundedFail m1_3_1_2 1 = true := by decide
example : boundedSuccesses m1_3_1_2 2 = [] := by decide
example : boundedFail m1_3_1_2 2 = true := by decide
def m1_3_1_3 : Model := ⟨["s0"],[("s0","v"),("s1","v")],["adv"],[a,b]⟩
example : rows m1_3_1_3 = [a] := by decide
example : successes m1_3_1_3 = [a] := by decide
example : allFail m1_3_1_3 = false := by decide
example : fullObservationClosure m1_3_1_3 = true := by decide
example : boundedSuccesses m1_3_1_3 1 = [] := by decide
example : boundedFail m1_3_1_3 1 = true := by decide
example : boundedSuccesses m1_3_1_3 2 = [a] := by decide
example : boundedFail m1_3_1_3 2 = false := by decide
def m2_0_0_0 : Model := ⟨["s1"],[],[],[]⟩
example : rows m2_0_0_0 = [] := by decide
example : successes m2_0_0_0 = [] := by decide
example : allFail m2_0_0_0 = true := by decide
example : fullObservationClosure m2_0_0_0 = true := by decide
example : boundedSuccesses m2_0_0_0 1 = [] := by decide
example : boundedFail m2_0_0_0 1 = true := by decide
example : boundedSuccesses m2_0_0_0 2 = [] := by decide
example : boundedFail m2_0_0_0 2 = true := by decide
def m2_0_0_1 : Model := ⟨["s1"],[],[],[a]⟩
example : rows m2_0_0_1 = [] := by decide
example : successes m2_0_0_1 = [] := by decide
example : allFail m2_0_0_1 = true := by decide
example : fullObservationClosure m2_0_0_1 = true := by decide
example : boundedSuccesses m2_0_0_1 1 = [] := by decide
example : boundedFail m2_0_0_1 1 = true := by decide
example : boundedSuccesses m2_0_0_1 2 = [] := by decide
example : boundedFail m2_0_0_1 2 = true := by decide
def m2_0_0_2 : Model := ⟨["s1"],[],[],[b]⟩
example : rows m2_0_0_2 = [] := by decide
example : successes m2_0_0_2 = [] := by decide
example : allFail m2_0_0_2 = true := by decide
example : fullObservationClosure m2_0_0_2 = true := by decide
example : boundedSuccesses m2_0_0_2 1 = [] := by decide
example : boundedFail m2_0_0_2 1 = true := by decide
example : boundedSuccesses m2_0_0_2 2 = [] := by decide
example : boundedFail m2_0_0_2 2 = true := by decide
def m2_0_0_3 : Model := ⟨["s1"],[],[],[a,b]⟩
example : rows m2_0_0_3 = [] := by decide
example : successes m2_0_0_3 = [] := by decide
example : allFail m2_0_0_3 = true := by decide
example : fullObservationClosure m2_0_0_3 = true := by decide
example : boundedSuccesses m2_0_0_3 1 = [] := by decide
example : boundedFail m2_0_0_3 1 = true := by decide
example : boundedSuccesses m2_0_0_3 2 = [] := by decide
example : boundedFail m2_0_0_3 2 = true := by decide
def m2_0_1_0 : Model := ⟨["s1"],[],["adv"],[]⟩
example : rows m2_0_1_0 = [] := by decide
example : successes m2_0_1_0 = [] := by decide
example : allFail m2_0_1_0 = true := by decide
example : fullObservationClosure m2_0_1_0 = true := by decide
example : boundedSuccesses m2_0_1_0 1 = [] := by decide
example : boundedFail m2_0_1_0 1 = true := by decide
example : boundedSuccesses m2_0_1_0 2 = [] := by decide
example : boundedFail m2_0_1_0 2 = true := by decide
def m2_0_1_1 : Model := ⟨["s1"],[],["adv"],[a]⟩
example : rows m2_0_1_1 = [] := by decide
example : successes m2_0_1_1 = [] := by decide
example : allFail m2_0_1_1 = true := by decide
example : fullObservationClosure m2_0_1_1 = true := by decide
example : boundedSuccesses m2_0_1_1 1 = [] := by decide
example : boundedFail m2_0_1_1 1 = true := by decide
example : boundedSuccesses m2_0_1_1 2 = [] := by decide
example : boundedFail m2_0_1_1 2 = true := by decide
def m2_0_1_2 : Model := ⟨["s1"],[],["adv"],[b]⟩
example : rows m2_0_1_2 = [] := by decide
example : successes m2_0_1_2 = [] := by decide
example : allFail m2_0_1_2 = true := by decide
example : fullObservationClosure m2_0_1_2 = true := by decide
example : boundedSuccesses m2_0_1_2 1 = [] := by decide
example : boundedFail m2_0_1_2 1 = true := by decide
example : boundedSuccesses m2_0_1_2 2 = [] := by decide
example : boundedFail m2_0_1_2 2 = true := by decide
def m2_0_1_3 : Model := ⟨["s1"],[],["adv"],[a,b]⟩
example : rows m2_0_1_3 = [] := by decide
example : successes m2_0_1_3 = [] := by decide
example : allFail m2_0_1_3 = true := by decide
example : fullObservationClosure m2_0_1_3 = true := by decide
example : boundedSuccesses m2_0_1_3 1 = [] := by decide
example : boundedFail m2_0_1_3 1 = true := by decide
example : boundedSuccesses m2_0_1_3 2 = [] := by decide
example : boundedFail m2_0_1_3 2 = true := by decide
def m2_1_0_0 : Model := ⟨["s1"],[("s0","v")],[],[]⟩
example : rows m2_1_0_0 = [] := by decide
example : successes m2_1_0_0 = [] := by decide
example : allFail m2_1_0_0 = true := by decide
example : fullObservationClosure m2_1_0_0 = true := by decide
example : boundedSuccesses m2_1_0_0 1 = [] := by decide
example : boundedFail m2_1_0_0 1 = true := by decide
example : boundedSuccesses m2_1_0_0 2 = [] := by decide
example : boundedFail m2_1_0_0 2 = true := by decide
def m2_1_0_1 : Model := ⟨["s1"],[("s0","v")],[],[a]⟩
example : rows m2_1_0_1 = [] := by decide
example : successes m2_1_0_1 = [] := by decide
example : allFail m2_1_0_1 = true := by decide
example : fullObservationClosure m2_1_0_1 = true := by decide
example : boundedSuccesses m2_1_0_1 1 = [] := by decide
example : boundedFail m2_1_0_1 1 = true := by decide
example : boundedSuccesses m2_1_0_1 2 = [] := by decide
example : boundedFail m2_1_0_1 2 = true := by decide
def m2_1_0_2 : Model := ⟨["s1"],[("s0","v")],[],[b]⟩
example : rows m2_1_0_2 = [] := by decide
example : successes m2_1_0_2 = [] := by decide
example : allFail m2_1_0_2 = true := by decide
example : fullObservationClosure m2_1_0_2 = true := by decide
example : boundedSuccesses m2_1_0_2 1 = [] := by decide
example : boundedFail m2_1_0_2 1 = true := by decide
example : boundedSuccesses m2_1_0_2 2 = [] := by decide
example : boundedFail m2_1_0_2 2 = true := by decide
def m2_1_0_3 : Model := ⟨["s1"],[("s0","v")],[],[a,b]⟩
example : rows m2_1_0_3 = [] := by decide
example : successes m2_1_0_3 = [] := by decide
example : allFail m2_1_0_3 = true := by decide
example : fullObservationClosure m2_1_0_3 = true := by decide
example : boundedSuccesses m2_1_0_3 1 = [] := by decide
example : boundedFail m2_1_0_3 1 = true := by decide
example : boundedSuccesses m2_1_0_3 2 = [] := by decide
example : boundedFail m2_1_0_3 2 = true := by decide
def m2_1_1_0 : Model := ⟨["s1"],[("s0","v")],["adv"],[]⟩
example : rows m2_1_1_0 = [] := by decide
example : successes m2_1_1_0 = [] := by decide
example : allFail m2_1_1_0 = true := by decide
example : fullObservationClosure m2_1_1_0 = true := by decide
example : boundedSuccesses m2_1_1_0 1 = [] := by decide
example : boundedFail m2_1_1_0 1 = true := by decide
example : boundedSuccesses m2_1_1_0 2 = [] := by decide
example : boundedFail m2_1_1_0 2 = true := by decide
def m2_1_1_1 : Model := ⟨["s1"],[("s0","v")],["adv"],[a]⟩
example : rows m2_1_1_1 = [] := by decide
example : successes m2_1_1_1 = [] := by decide
example : allFail m2_1_1_1 = true := by decide
example : fullObservationClosure m2_1_1_1 = true := by decide
example : boundedSuccesses m2_1_1_1 1 = [] := by decide
example : boundedFail m2_1_1_1 1 = true := by decide
example : boundedSuccesses m2_1_1_1 2 = [] := by decide
example : boundedFail m2_1_1_1 2 = true := by decide
def m2_1_1_2 : Model := ⟨["s1"],[("s0","v")],["adv"],[b]⟩
example : rows m2_1_1_2 = [] := by decide
example : successes m2_1_1_2 = [] := by decide
example : allFail m2_1_1_2 = true := by decide
example : fullObservationClosure m2_1_1_2 = true := by decide
example : boundedSuccesses m2_1_1_2 1 = [] := by decide
example : boundedFail m2_1_1_2 1 = true := by decide
example : boundedSuccesses m2_1_1_2 2 = [] := by decide
example : boundedFail m2_1_1_2 2 = true := by decide
def m2_1_1_3 : Model := ⟨["s1"],[("s0","v")],["adv"],[a,b]⟩
example : rows m2_1_1_3 = [] := by decide
example : successes m2_1_1_3 = [] := by decide
example : allFail m2_1_1_3 = true := by decide
example : fullObservationClosure m2_1_1_3 = true := by decide
example : boundedSuccesses m2_1_1_3 1 = [] := by decide
example : boundedFail m2_1_1_3 1 = true := by decide
example : boundedSuccesses m2_1_1_3 2 = [] := by decide
example : boundedFail m2_1_1_3 2 = true := by decide
def m2_2_0_0 : Model := ⟨["s1"],[("s1","v")],[],[]⟩
example : rows m2_2_0_0 = [] := by decide
example : successes m2_2_0_0 = [] := by decide
example : allFail m2_2_0_0 = true := by decide
example : fullObservationClosure m2_2_0_0 = true := by decide
example : boundedSuccesses m2_2_0_0 1 = [] := by decide
example : boundedFail m2_2_0_0 1 = true := by decide
example : boundedSuccesses m2_2_0_0 2 = [] := by decide
example : boundedFail m2_2_0_0 2 = true := by decide
def m2_2_0_1 : Model := ⟨["s1"],[("s1","v")],[],[a]⟩
example : rows m2_2_0_1 = [] := by decide
example : successes m2_2_0_1 = [] := by decide
example : allFail m2_2_0_1 = true := by decide
example : fullObservationClosure m2_2_0_1 = true := by decide
example : boundedSuccesses m2_2_0_1 1 = [] := by decide
example : boundedFail m2_2_0_1 1 = true := by decide
example : boundedSuccesses m2_2_0_1 2 = [] := by decide
example : boundedFail m2_2_0_1 2 = true := by decide
def m2_2_0_2 : Model := ⟨["s1"],[("s1","v")],[],[b]⟩
example : rows m2_2_0_2 = [] := by decide
example : successes m2_2_0_2 = [] := by decide
example : allFail m2_2_0_2 = true := by decide
example : fullObservationClosure m2_2_0_2 = true := by decide
example : boundedSuccesses m2_2_0_2 1 = [] := by decide
example : boundedFail m2_2_0_2 1 = true := by decide
example : boundedSuccesses m2_2_0_2 2 = [] := by decide
example : boundedFail m2_2_0_2 2 = true := by decide
def m2_2_0_3 : Model := ⟨["s1"],[("s1","v")],[],[a,b]⟩
example : rows m2_2_0_3 = [] := by decide
example : successes m2_2_0_3 = [] := by decide
example : allFail m2_2_0_3 = true := by decide
example : fullObservationClosure m2_2_0_3 = true := by decide
example : boundedSuccesses m2_2_0_3 1 = [] := by decide
example : boundedFail m2_2_0_3 1 = true := by decide
example : boundedSuccesses m2_2_0_3 2 = [] := by decide
example : boundedFail m2_2_0_3 2 = true := by decide
def m2_2_1_0 : Model := ⟨["s1"],[("s1","v")],["adv"],[]⟩
example : rows m2_2_1_0 = [] := by decide
example : successes m2_2_1_0 = [] := by decide
example : allFail m2_2_1_0 = true := by decide
example : fullObservationClosure m2_2_1_0 = true := by decide
example : boundedSuccesses m2_2_1_0 1 = [] := by decide
example : boundedFail m2_2_1_0 1 = true := by decide
example : boundedSuccesses m2_2_1_0 2 = [] := by decide
example : boundedFail m2_2_1_0 2 = true := by decide
def m2_2_1_1 : Model := ⟨["s1"],[("s1","v")],["adv"],[a]⟩
example : rows m2_2_1_1 = [] := by decide
example : successes m2_2_1_1 = [] := by decide
example : allFail m2_2_1_1 = true := by decide
example : fullObservationClosure m2_2_1_1 = true := by decide
example : boundedSuccesses m2_2_1_1 1 = [] := by decide
example : boundedFail m2_2_1_1 1 = true := by decide
example : boundedSuccesses m2_2_1_1 2 = [] := by decide
example : boundedFail m2_2_1_1 2 = true := by decide
def m2_2_1_2 : Model := ⟨["s1"],[("s1","v")],["adv"],[b]⟩
example : rows m2_2_1_2 = [b] := by decide
example : successes m2_2_1_2 = [] := by decide
example : allFail m2_2_1_2 = true := by decide
example : fullObservationClosure m2_2_1_2 = true := by decide
example : boundedSuccesses m2_2_1_2 1 = [] := by decide
example : boundedFail m2_2_1_2 1 = true := by decide
example : boundedSuccesses m2_2_1_2 2 = [] := by decide
example : boundedFail m2_2_1_2 2 = true := by decide
def m2_2_1_3 : Model := ⟨["s1"],[("s1","v")],["adv"],[a,b]⟩
example : rows m2_2_1_3 = [b] := by decide
example : successes m2_2_1_3 = [] := by decide
example : allFail m2_2_1_3 = true := by decide
example : fullObservationClosure m2_2_1_3 = true := by decide
example : boundedSuccesses m2_2_1_3 1 = [] := by decide
example : boundedFail m2_2_1_3 1 = true := by decide
example : boundedSuccesses m2_2_1_3 2 = [] := by decide
example : boundedFail m2_2_1_3 2 = true := by decide
def m2_3_0_0 : Model := ⟨["s1"],[("s0","v"),("s1","v")],[],[]⟩
example : rows m2_3_0_0 = [] := by decide
example : successes m2_3_0_0 = [] := by decide
example : allFail m2_3_0_0 = true := by decide
example : fullObservationClosure m2_3_0_0 = true := by decide
example : boundedSuccesses m2_3_0_0 1 = [] := by decide
example : boundedFail m2_3_0_0 1 = true := by decide
example : boundedSuccesses m2_3_0_0 2 = [] := by decide
example : boundedFail m2_3_0_0 2 = true := by decide
def m2_3_0_1 : Model := ⟨["s1"],[("s0","v"),("s1","v")],[],[a]⟩
example : rows m2_3_0_1 = [] := by decide
example : successes m2_3_0_1 = [] := by decide
example : allFail m2_3_0_1 = true := by decide
example : fullObservationClosure m2_3_0_1 = true := by decide
example : boundedSuccesses m2_3_0_1 1 = [] := by decide
example : boundedFail m2_3_0_1 1 = true := by decide
example : boundedSuccesses m2_3_0_1 2 = [] := by decide
example : boundedFail m2_3_0_1 2 = true := by decide
def m2_3_0_2 : Model := ⟨["s1"],[("s0","v"),("s1","v")],[],[b]⟩
example : rows m2_3_0_2 = [] := by decide
example : successes m2_3_0_2 = [] := by decide
example : allFail m2_3_0_2 = true := by decide
example : fullObservationClosure m2_3_0_2 = true := by decide
example : boundedSuccesses m2_3_0_2 1 = [] := by decide
example : boundedFail m2_3_0_2 1 = true := by decide
example : boundedSuccesses m2_3_0_2 2 = [] := by decide
example : boundedFail m2_3_0_2 2 = true := by decide
def m2_3_0_3 : Model := ⟨["s1"],[("s0","v"),("s1","v")],[],[a,b]⟩
example : rows m2_3_0_3 = [] := by decide
example : successes m2_3_0_3 = [] := by decide
example : allFail m2_3_0_3 = true := by decide
example : fullObservationClosure m2_3_0_3 = true := by decide
example : boundedSuccesses m2_3_0_3 1 = [] := by decide
example : boundedFail m2_3_0_3 1 = true := by decide
example : boundedSuccesses m2_3_0_3 2 = [] := by decide
example : boundedFail m2_3_0_3 2 = true := by decide
def m2_3_1_0 : Model := ⟨["s1"],[("s0","v"),("s1","v")],["adv"],[]⟩
example : rows m2_3_1_0 = [] := by decide
example : successes m2_3_1_0 = [] := by decide
example : allFail m2_3_1_0 = true := by decide
example : fullObservationClosure m2_3_1_0 = true := by decide
example : boundedSuccesses m2_3_1_0 1 = [] := by decide
example : boundedFail m2_3_1_0 1 = true := by decide
example : boundedSuccesses m2_3_1_0 2 = [] := by decide
example : boundedFail m2_3_1_0 2 = true := by decide
def m2_3_1_1 : Model := ⟨["s1"],[("s0","v"),("s1","v")],["adv"],[a]⟩
example : rows m2_3_1_1 = [] := by decide
example : successes m2_3_1_1 = [] := by decide
example : allFail m2_3_1_1 = true := by decide
example : fullObservationClosure m2_3_1_1 = true := by decide
example : boundedSuccesses m2_3_1_1 1 = [] := by decide
example : boundedFail m2_3_1_1 1 = true := by decide
example : boundedSuccesses m2_3_1_1 2 = [] := by decide
example : boundedFail m2_3_1_1 2 = true := by decide
def m2_3_1_2 : Model := ⟨["s1"],[("s0","v"),("s1","v")],["adv"],[b]⟩
example : rows m2_3_1_2 = [b] := by decide
example : successes m2_3_1_2 = [] := by decide
example : allFail m2_3_1_2 = true := by decide
example : fullObservationClosure m2_3_1_2 = true := by decide
example : boundedSuccesses m2_3_1_2 1 = [] := by decide
example : boundedFail m2_3_1_2 1 = true := by decide
example : boundedSuccesses m2_3_1_2 2 = [] := by decide
example : boundedFail m2_3_1_2 2 = true := by decide
def m2_3_1_3 : Model := ⟨["s1"],[("s0","v"),("s1","v")],["adv"],[a,b]⟩
example : rows m2_3_1_3 = [b] := by decide
example : successes m2_3_1_3 = [] := by decide
example : allFail m2_3_1_3 = true := by decide
example : fullObservationClosure m2_3_1_3 = true := by decide
example : boundedSuccesses m2_3_1_3 1 = [] := by decide
example : boundedFail m2_3_1_3 1 = true := by decide
example : boundedSuccesses m2_3_1_3 2 = [] := by decide
example : boundedFail m2_3_1_3 2 = true := by decide
def m3_0_0_0 : Model := ⟨["s0","s1"],[],[],[]⟩
example : rows m3_0_0_0 = [] := by decide
example : successes m3_0_0_0 = [] := by decide
example : allFail m3_0_0_0 = true := by decide
example : fullObservationClosure m3_0_0_0 = true := by decide
example : boundedSuccesses m3_0_0_0 1 = [] := by decide
example : boundedFail m3_0_0_0 1 = true := by decide
example : boundedSuccesses m3_0_0_0 2 = [] := by decide
example : boundedFail m3_0_0_0 2 = true := by decide
def m3_0_0_1 : Model := ⟨["s0","s1"],[],[],[a]⟩
example : rows m3_0_0_1 = [] := by decide
example : successes m3_0_0_1 = [] := by decide
example : allFail m3_0_0_1 = true := by decide
example : fullObservationClosure m3_0_0_1 = true := by decide
example : boundedSuccesses m3_0_0_1 1 = [] := by decide
example : boundedFail m3_0_0_1 1 = true := by decide
example : boundedSuccesses m3_0_0_1 2 = [] := by decide
example : boundedFail m3_0_0_1 2 = true := by decide
def m3_0_0_2 : Model := ⟨["s0","s1"],[],[],[b]⟩
example : rows m3_0_0_2 = [] := by decide
example : successes m3_0_0_2 = [] := by decide
example : allFail m3_0_0_2 = true := by decide
example : fullObservationClosure m3_0_0_2 = true := by decide
example : boundedSuccesses m3_0_0_2 1 = [] := by decide
example : boundedFail m3_0_0_2 1 = true := by decide
example : boundedSuccesses m3_0_0_2 2 = [] := by decide
example : boundedFail m3_0_0_2 2 = true := by decide
def m3_0_0_3 : Model := ⟨["s0","s1"],[],[],[a,b]⟩
example : rows m3_0_0_3 = [] := by decide
example : successes m3_0_0_3 = [] := by decide
example : allFail m3_0_0_3 = true := by decide
example : fullObservationClosure m3_0_0_3 = true := by decide
example : boundedSuccesses m3_0_0_3 1 = [] := by decide
example : boundedFail m3_0_0_3 1 = true := by decide
example : boundedSuccesses m3_0_0_3 2 = [] := by decide
example : boundedFail m3_0_0_3 2 = true := by decide
def m3_0_1_0 : Model := ⟨["s0","s1"],[],["adv"],[]⟩
example : rows m3_0_1_0 = [] := by decide
example : successes m3_0_1_0 = [] := by decide
example : allFail m3_0_1_0 = true := by decide
example : fullObservationClosure m3_0_1_0 = true := by decide
example : boundedSuccesses m3_0_1_0 1 = [] := by decide
example : boundedFail m3_0_1_0 1 = true := by decide
example : boundedSuccesses m3_0_1_0 2 = [] := by decide
example : boundedFail m3_0_1_0 2 = true := by decide
def m3_0_1_1 : Model := ⟨["s0","s1"],[],["adv"],[a]⟩
example : rows m3_0_1_1 = [] := by decide
example : successes m3_0_1_1 = [] := by decide
example : allFail m3_0_1_1 = true := by decide
example : fullObservationClosure m3_0_1_1 = true := by decide
example : boundedSuccesses m3_0_1_1 1 = [] := by decide
example : boundedFail m3_0_1_1 1 = true := by decide
example : boundedSuccesses m3_0_1_1 2 = [] := by decide
example : boundedFail m3_0_1_1 2 = true := by decide
def m3_0_1_2 : Model := ⟨["s0","s1"],[],["adv"],[b]⟩
example : rows m3_0_1_2 = [] := by decide
example : successes m3_0_1_2 = [] := by decide
example : allFail m3_0_1_2 = true := by decide
example : fullObservationClosure m3_0_1_2 = true := by decide
example : boundedSuccesses m3_0_1_2 1 = [] := by decide
example : boundedFail m3_0_1_2 1 = true := by decide
example : boundedSuccesses m3_0_1_2 2 = [] := by decide
example : boundedFail m3_0_1_2 2 = true := by decide
def m3_0_1_3 : Model := ⟨["s0","s1"],[],["adv"],[a,b]⟩
example : rows m3_0_1_3 = [] := by decide
example : successes m3_0_1_3 = [] := by decide
example : allFail m3_0_1_3 = true := by decide
example : fullObservationClosure m3_0_1_3 = true := by decide
example : boundedSuccesses m3_0_1_3 1 = [] := by decide
example : boundedFail m3_0_1_3 1 = true := by decide
example : boundedSuccesses m3_0_1_3 2 = [] := by decide
example : boundedFail m3_0_1_3 2 = true := by decide
def m3_1_0_0 : Model := ⟨["s0","s1"],[("s0","v")],[],[]⟩
example : rows m3_1_0_0 = [] := by decide
example : successes m3_1_0_0 = [] := by decide
example : allFail m3_1_0_0 = true := by decide
example : fullObservationClosure m3_1_0_0 = false := by decide
example : boundedSuccesses m3_1_0_0 1 = [] := by decide
example : boundedFail m3_1_0_0 1 = true := by decide
example : boundedSuccesses m3_1_0_0 2 = [] := by decide
example : boundedFail m3_1_0_0 2 = true := by decide
def m3_1_0_1 : Model := ⟨["s0","s1"],[("s0","v")],[],[a]⟩
example : rows m3_1_0_1 = [] := by decide
example : successes m3_1_0_1 = [] := by decide
example : allFail m3_1_0_1 = true := by decide
example : fullObservationClosure m3_1_0_1 = false := by decide
example : boundedSuccesses m3_1_0_1 1 = [] := by decide
example : boundedFail m3_1_0_1 1 = true := by decide
example : boundedSuccesses m3_1_0_1 2 = [] := by decide
example : boundedFail m3_1_0_1 2 = true := by decide
def m3_1_0_2 : Model := ⟨["s0","s1"],[("s0","v")],[],[b]⟩
example : rows m3_1_0_2 = [] := by decide
example : successes m3_1_0_2 = [] := by decide
example : allFail m3_1_0_2 = true := by decide
example : fullObservationClosure m3_1_0_2 = false := by decide
example : boundedSuccesses m3_1_0_2 1 = [] := by decide
example : boundedFail m3_1_0_2 1 = true := by decide
example : boundedSuccesses m3_1_0_2 2 = [] := by decide
example : boundedFail m3_1_0_2 2 = true := by decide
def m3_1_0_3 : Model := ⟨["s0","s1"],[("s0","v")],[],[a,b]⟩
example : rows m3_1_0_3 = [] := by decide
example : successes m3_1_0_3 = [] := by decide
example : allFail m3_1_0_3 = true := by decide
example : fullObservationClosure m3_1_0_3 = false := by decide
example : boundedSuccesses m3_1_0_3 1 = [] := by decide
example : boundedFail m3_1_0_3 1 = true := by decide
example : boundedSuccesses m3_1_0_3 2 = [] := by decide
example : boundedFail m3_1_0_3 2 = true := by decide
def m3_1_1_0 : Model := ⟨["s0","s1"],[("s0","v")],["adv"],[]⟩
example : rows m3_1_1_0 = [] := by decide
example : successes m3_1_1_0 = [] := by decide
example : allFail m3_1_1_0 = true := by decide
example : fullObservationClosure m3_1_1_0 = false := by decide
example : boundedSuccesses m3_1_1_0 1 = [] := by decide
example : boundedFail m3_1_1_0 1 = true := by decide
example : boundedSuccesses m3_1_1_0 2 = [] := by decide
example : boundedFail m3_1_1_0 2 = true := by decide
def m3_1_1_1 : Model := ⟨["s0","s1"],[("s0","v")],["adv"],[a]⟩
example : rows m3_1_1_1 = [a] := by decide
example : successes m3_1_1_1 = [a] := by decide
example : allFail m3_1_1_1 = false := by decide
example : fullObservationClosure m3_1_1_1 = false := by decide
example : boundedSuccesses m3_1_1_1 1 = [] := by decide
example : boundedFail m3_1_1_1 1 = true := by decide
example : boundedSuccesses m3_1_1_1 2 = [a] := by decide
example : boundedFail m3_1_1_1 2 = false := by decide
def m3_1_1_2 : Model := ⟨["s0","s1"],[("s0","v")],["adv"],[b]⟩
example : rows m3_1_1_2 = [] := by decide
example : successes m3_1_1_2 = [] := by decide
example : allFail m3_1_1_2 = true := by decide
example : fullObservationClosure m3_1_1_2 = false := by decide
example : boundedSuccesses m3_1_1_2 1 = [] := by decide
example : boundedFail m3_1_1_2 1 = true := by decide
example : boundedSuccesses m3_1_1_2 2 = [] := by decide
example : boundedFail m3_1_1_2 2 = true := by decide
def m3_1_1_3 : Model := ⟨["s0","s1"],[("s0","v")],["adv"],[a,b]⟩
example : rows m3_1_1_3 = [a] := by decide
example : successes m3_1_1_3 = [a] := by decide
example : allFail m3_1_1_3 = false := by decide
example : fullObservationClosure m3_1_1_3 = false := by decide
example : boundedSuccesses m3_1_1_3 1 = [] := by decide
example : boundedFail m3_1_1_3 1 = true := by decide
example : boundedSuccesses m3_1_1_3 2 = [a] := by decide
example : boundedFail m3_1_1_3 2 = false := by decide
def m3_2_0_0 : Model := ⟨["s0","s1"],[("s1","v")],[],[]⟩
example : rows m3_2_0_0 = [] := by decide
example : successes m3_2_0_0 = [] := by decide
example : allFail m3_2_0_0 = true := by decide
example : fullObservationClosure m3_2_0_0 = false := by decide
example : boundedSuccesses m3_2_0_0 1 = [] := by decide
example : boundedFail m3_2_0_0 1 = true := by decide
example : boundedSuccesses m3_2_0_0 2 = [] := by decide
example : boundedFail m3_2_0_0 2 = true := by decide
def m3_2_0_1 : Model := ⟨["s0","s1"],[("s1","v")],[],[a]⟩
example : rows m3_2_0_1 = [] := by decide
example : successes m3_2_0_1 = [] := by decide
example : allFail m3_2_0_1 = true := by decide
example : fullObservationClosure m3_2_0_1 = false := by decide
example : boundedSuccesses m3_2_0_1 1 = [] := by decide
example : boundedFail m3_2_0_1 1 = true := by decide
example : boundedSuccesses m3_2_0_1 2 = [] := by decide
example : boundedFail m3_2_0_1 2 = true := by decide
def m3_2_0_2 : Model := ⟨["s0","s1"],[("s1","v")],[],[b]⟩
example : rows m3_2_0_2 = [] := by decide
example : successes m3_2_0_2 = [] := by decide
example : allFail m3_2_0_2 = true := by decide
example : fullObservationClosure m3_2_0_2 = false := by decide
example : boundedSuccesses m3_2_0_2 1 = [] := by decide
example : boundedFail m3_2_0_2 1 = true := by decide
example : boundedSuccesses m3_2_0_2 2 = [] := by decide
example : boundedFail m3_2_0_2 2 = true := by decide
def m3_2_0_3 : Model := ⟨["s0","s1"],[("s1","v")],[],[a,b]⟩
example : rows m3_2_0_3 = [] := by decide
example : successes m3_2_0_3 = [] := by decide
example : allFail m3_2_0_3 = true := by decide
example : fullObservationClosure m3_2_0_3 = false := by decide
example : boundedSuccesses m3_2_0_3 1 = [] := by decide
example : boundedFail m3_2_0_3 1 = true := by decide
example : boundedSuccesses m3_2_0_3 2 = [] := by decide
example : boundedFail m3_2_0_3 2 = true := by decide
def m3_2_1_0 : Model := ⟨["s0","s1"],[("s1","v")],["adv"],[]⟩
example : rows m3_2_1_0 = [] := by decide
example : successes m3_2_1_0 = [] := by decide
example : allFail m3_2_1_0 = true := by decide
example : fullObservationClosure m3_2_1_0 = false := by decide
example : boundedSuccesses m3_2_1_0 1 = [] := by decide
example : boundedFail m3_2_1_0 1 = true := by decide
example : boundedSuccesses m3_2_1_0 2 = [] := by decide
example : boundedFail m3_2_1_0 2 = true := by decide
def m3_2_1_1 : Model := ⟨["s0","s1"],[("s1","v")],["adv"],[a]⟩
example : rows m3_2_1_1 = [] := by decide
example : successes m3_2_1_1 = [] := by decide
example : allFail m3_2_1_1 = true := by decide
example : fullObservationClosure m3_2_1_1 = false := by decide
example : boundedSuccesses m3_2_1_1 1 = [] := by decide
example : boundedFail m3_2_1_1 1 = true := by decide
example : boundedSuccesses m3_2_1_1 2 = [] := by decide
example : boundedFail m3_2_1_1 2 = true := by decide
def m3_2_1_2 : Model := ⟨["s0","s1"],[("s1","v")],["adv"],[b]⟩
example : rows m3_2_1_2 = [b] := by decide
example : successes m3_2_1_2 = [] := by decide
example : allFail m3_2_1_2 = true := by decide
example : fullObservationClosure m3_2_1_2 = false := by decide
example : boundedSuccesses m3_2_1_2 1 = [] := by decide
example : boundedFail m3_2_1_2 1 = true := by decide
example : boundedSuccesses m3_2_1_2 2 = [] := by decide
example : boundedFail m3_2_1_2 2 = true := by decide
def m3_2_1_3 : Model := ⟨["s0","s1"],[("s1","v")],["adv"],[a,b]⟩
example : rows m3_2_1_3 = [b] := by decide
example : successes m3_2_1_3 = [] := by decide
example : allFail m3_2_1_3 = true := by decide
example : fullObservationClosure m3_2_1_3 = false := by decide
example : boundedSuccesses m3_2_1_3 1 = [] := by decide
example : boundedFail m3_2_1_3 1 = true := by decide
example : boundedSuccesses m3_2_1_3 2 = [] := by decide
example : boundedFail m3_2_1_3 2 = true := by decide
def m3_3_0_0 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],[],[]⟩
example : rows m3_3_0_0 = [] := by decide
example : successes m3_3_0_0 = [] := by decide
example : allFail m3_3_0_0 = true := by decide
example : fullObservationClosure m3_3_0_0 = true := by decide
example : boundedSuccesses m3_3_0_0 1 = [] := by decide
example : boundedFail m3_3_0_0 1 = true := by decide
example : boundedSuccesses m3_3_0_0 2 = [] := by decide
example : boundedFail m3_3_0_0 2 = true := by decide
def m3_3_0_1 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],[],[a]⟩
example : rows m3_3_0_1 = [] := by decide
example : successes m3_3_0_1 = [] := by decide
example : allFail m3_3_0_1 = true := by decide
example : fullObservationClosure m3_3_0_1 = true := by decide
example : boundedSuccesses m3_3_0_1 1 = [] := by decide
example : boundedFail m3_3_0_1 1 = true := by decide
example : boundedSuccesses m3_3_0_1 2 = [] := by decide
example : boundedFail m3_3_0_1 2 = true := by decide
def m3_3_0_2 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],[],[b]⟩
example : rows m3_3_0_2 = [] := by decide
example : successes m3_3_0_2 = [] := by decide
example : allFail m3_3_0_2 = true := by decide
example : fullObservationClosure m3_3_0_2 = true := by decide
example : boundedSuccesses m3_3_0_2 1 = [] := by decide
example : boundedFail m3_3_0_2 1 = true := by decide
example : boundedSuccesses m3_3_0_2 2 = [] := by decide
example : boundedFail m3_3_0_2 2 = true := by decide
def m3_3_0_3 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],[],[a,b]⟩
example : rows m3_3_0_3 = [] := by decide
example : successes m3_3_0_3 = [] := by decide
example : allFail m3_3_0_3 = true := by decide
example : fullObservationClosure m3_3_0_3 = true := by decide
example : boundedSuccesses m3_3_0_3 1 = [] := by decide
example : boundedFail m3_3_0_3 1 = true := by decide
example : boundedSuccesses m3_3_0_3 2 = [] := by decide
example : boundedFail m3_3_0_3 2 = true := by decide
def m3_3_1_0 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],["adv"],[]⟩
example : rows m3_3_1_0 = [] := by decide
example : successes m3_3_1_0 = [] := by decide
example : allFail m3_3_1_0 = true := by decide
example : fullObservationClosure m3_3_1_0 = true := by decide
example : boundedSuccesses m3_3_1_0 1 = [] := by decide
example : boundedFail m3_3_1_0 1 = true := by decide
example : boundedSuccesses m3_3_1_0 2 = [] := by decide
example : boundedFail m3_3_1_0 2 = true := by decide
def m3_3_1_1 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],["adv"],[a]⟩
example : rows m3_3_1_1 = [a] := by decide
example : successes m3_3_1_1 = [a] := by decide
example : allFail m3_3_1_1 = false := by decide
example : fullObservationClosure m3_3_1_1 = true := by decide
example : boundedSuccesses m3_3_1_1 1 = [] := by decide
example : boundedFail m3_3_1_1 1 = true := by decide
example : boundedSuccesses m3_3_1_1 2 = [a] := by decide
example : boundedFail m3_3_1_1 2 = false := by decide
def m3_3_1_2 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],["adv"],[b]⟩
example : rows m3_3_1_2 = [b] := by decide
example : successes m3_3_1_2 = [] := by decide
example : allFail m3_3_1_2 = true := by decide
example : fullObservationClosure m3_3_1_2 = true := by decide
example : boundedSuccesses m3_3_1_2 1 = [] := by decide
example : boundedFail m3_3_1_2 1 = true := by decide
example : boundedSuccesses m3_3_1_2 2 = [] := by decide
example : boundedFail m3_3_1_2 2 = true := by decide
def m3_3_1_3 : Model := ⟨["s0","s1"],[("s0","v"),("s1","v")],["adv"],[a,b]⟩
example : rows m3_3_1_3 = [a,b] := by decide
example : successes m3_3_1_3 = [a] := by decide
example : allFail m3_3_1_3 = false := by decide
example : fullObservationClosure m3_3_1_3 = true := by decide
example : boundedSuccesses m3_3_1_3 1 = [] := by decide
example : boundedFail m3_3_1_3 1 = true := by decide
example : boundedSuccesses m3_3_1_3 2 = [a] := by decide
example : boundedFail m3_3_1_3 2 = false := by decide
theorem boundedNotAll : boundedFail m3_3_1_3 1 = true ∧ allFail m3_3_1_3 = false := ⟨rfl,rfl⟩
theorem observationClosureWithGuessSuccess : fullObservationClosure m3_3_1_3 = true ∧ successes m3_3_1_3 = [a] := ⟨rfl,rfl⟩
#print axioms boundedNotAll
#print axioms observationClosureWithGuessSuccess
end SFT.Computation.SecurityDefinition
