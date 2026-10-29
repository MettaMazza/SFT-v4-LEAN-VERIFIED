import SFT.Computation.FaultModel
open SFT.Computation.FaultModel
def f0 : Fault := ⟨"f0",⟨"c","act","good","bad"⟩,"alert"⟩
def f1 : Fault := ⟨"f1",⟨"c","act","good","bad2"⟩,"quiet"⟩
def f2 : Fault := ⟨"f2",⟨"d","act","good","bad"⟩,"alert"⟩
def n0 : Transition × String := (⟨"c","act","good","good"⟩,"quiet")
def n1 : Transition × String := (⟨"c","act","good","bad"⟩,"alert")
def r0 : Transition := ⟨"c","repair","bad","good"⟩
def r1 : Transition := ⟨"c","repair","bad2","good"⟩
def r2 : Transition := ⟨"d","repair","bad","good"⟩
def m0_0_0 : Model := ⟨[],[],[]⟩
example : classify m0_0_0 f0 = .outside := rfl
example : detected m0_0_0 f0 = true := rfl
example : deviation m0_0_0 f0 = false := rfl
example : correctable m0_0_0 f0 = false := rfl
example : classify m0_0_0 f1 = .outside := rfl
example : detected m0_0_0 f1 = true := rfl
example : deviation m0_0_0 f1 = false := rfl
example : correctable m0_0_0 f1 = false := rfl
example : classify m0_0_0 f2 = .outside := rfl
example : detected m0_0_0 f2 = true := rfl
example : deviation m0_0_0 f2 = false := rfl
example : correctable m0_0_0 f2 = false := rfl
example : allGeneratedCorrectable m0_0_0 = true := rfl
def m0_0_1 : Model := ⟨[],[],[r0]⟩
example : classify m0_0_1 f0 = .outside := rfl
example : detected m0_0_1 f0 = true := rfl
example : deviation m0_0_1 f0 = false := rfl
example : correctable m0_0_1 f0 = true := rfl
example : classify m0_0_1 f1 = .outside := rfl
example : detected m0_0_1 f1 = true := rfl
example : deviation m0_0_1 f1 = false := rfl
example : correctable m0_0_1 f1 = false := rfl
example : classify m0_0_1 f2 = .outside := rfl
example : detected m0_0_1 f2 = true := rfl
example : deviation m0_0_1 f2 = false := rfl
example : correctable m0_0_1 f2 = false := rfl
example : allGeneratedCorrectable m0_0_1 = true := rfl
def m0_0_2 : Model := ⟨[],[],[r1]⟩
example : classify m0_0_2 f0 = .outside := rfl
example : detected m0_0_2 f0 = true := rfl
example : deviation m0_0_2 f0 = false := rfl
example : correctable m0_0_2 f0 = false := rfl
example : classify m0_0_2 f1 = .outside := rfl
example : detected m0_0_2 f1 = true := rfl
example : deviation m0_0_2 f1 = false := rfl
example : correctable m0_0_2 f1 = true := rfl
example : classify m0_0_2 f2 = .outside := rfl
example : detected m0_0_2 f2 = true := rfl
example : deviation m0_0_2 f2 = false := rfl
example : correctable m0_0_2 f2 = false := rfl
example : allGeneratedCorrectable m0_0_2 = true := rfl
def m0_0_3 : Model := ⟨[],[],[r0,r1]⟩
example : classify m0_0_3 f0 = .outside := rfl
example : detected m0_0_3 f0 = true := rfl
example : deviation m0_0_3 f0 = false := rfl
example : correctable m0_0_3 f0 = true := rfl
example : classify m0_0_3 f1 = .outside := rfl
example : detected m0_0_3 f1 = true := rfl
example : deviation m0_0_3 f1 = false := rfl
example : correctable m0_0_3 f1 = true := rfl
example : classify m0_0_3 f2 = .outside := rfl
example : detected m0_0_3 f2 = true := rfl
example : deviation m0_0_3 f2 = false := rfl
example : correctable m0_0_3 f2 = false := rfl
example : allGeneratedCorrectable m0_0_3 = true := rfl
def m0_0_4 : Model := ⟨[],[],[r2]⟩
example : classify m0_0_4 f0 = .outside := rfl
example : detected m0_0_4 f0 = true := rfl
example : deviation m0_0_4 f0 = false := rfl
example : correctable m0_0_4 f0 = false := rfl
example : classify m0_0_4 f1 = .outside := rfl
example : detected m0_0_4 f1 = true := rfl
example : deviation m0_0_4 f1 = false := rfl
example : correctable m0_0_4 f1 = false := rfl
example : classify m0_0_4 f2 = .outside := rfl
example : detected m0_0_4 f2 = true := rfl
example : deviation m0_0_4 f2 = false := rfl
example : correctable m0_0_4 f2 = true := rfl
example : allGeneratedCorrectable m0_0_4 = true := rfl
def m0_0_5 : Model := ⟨[],[],[r0,r2]⟩
example : classify m0_0_5 f0 = .outside := rfl
example : detected m0_0_5 f0 = true := rfl
example : deviation m0_0_5 f0 = false := rfl
example : correctable m0_0_5 f0 = true := rfl
example : classify m0_0_5 f1 = .outside := rfl
example : detected m0_0_5 f1 = true := rfl
example : deviation m0_0_5 f1 = false := rfl
example : correctable m0_0_5 f1 = false := rfl
example : classify m0_0_5 f2 = .outside := rfl
example : detected m0_0_5 f2 = true := rfl
example : deviation m0_0_5 f2 = false := rfl
example : correctable m0_0_5 f2 = true := rfl
example : allGeneratedCorrectable m0_0_5 = true := rfl
def m0_0_6 : Model := ⟨[],[],[r1,r2]⟩
example : classify m0_0_6 f0 = .outside := rfl
example : detected m0_0_6 f0 = true := rfl
example : deviation m0_0_6 f0 = false := rfl
example : correctable m0_0_6 f0 = false := rfl
example : classify m0_0_6 f1 = .outside := rfl
example : detected m0_0_6 f1 = true := rfl
example : deviation m0_0_6 f1 = false := rfl
example : correctable m0_0_6 f1 = true := rfl
example : classify m0_0_6 f2 = .outside := rfl
example : detected m0_0_6 f2 = true := rfl
example : deviation m0_0_6 f2 = false := rfl
example : correctable m0_0_6 f2 = true := rfl
example : allGeneratedCorrectable m0_0_6 = true := rfl
def m0_0_7 : Model := ⟨[],[],[r0,r1,r2]⟩
example : classify m0_0_7 f0 = .outside := rfl
example : detected m0_0_7 f0 = true := rfl
example : deviation m0_0_7 f0 = false := rfl
example : correctable m0_0_7 f0 = true := rfl
example : classify m0_0_7 f1 = .outside := rfl
example : detected m0_0_7 f1 = true := rfl
example : deviation m0_0_7 f1 = false := rfl
example : correctable m0_0_7 f1 = true := rfl
example : classify m0_0_7 f2 = .outside := rfl
example : detected m0_0_7 f2 = true := rfl
example : deviation m0_0_7 f2 = false := rfl
example : correctable m0_0_7 f2 = true := rfl
example : allGeneratedCorrectable m0_0_7 = true := rfl
def m0_1_0 : Model := ⟨[],[f0],[]⟩
example : classify m0_1_0 f0 = .uncorrectable := rfl
example : detected m0_1_0 f0 = true := rfl
example : deviation m0_1_0 f0 = true := rfl
example : correctable m0_1_0 f0 = false := rfl
example : classify m0_1_0 f1 = .outside := rfl
example : detected m0_1_0 f1 = true := rfl
example : deviation m0_1_0 f1 = false := rfl
example : correctable m0_1_0 f1 = false := rfl
example : classify m0_1_0 f2 = .outside := rfl
example : detected m0_1_0 f2 = true := rfl
example : deviation m0_1_0 f2 = false := rfl
example : correctable m0_1_0 f2 = false := rfl
example : allGeneratedCorrectable m0_1_0 = false := rfl
def m0_1_1 : Model := ⟨[],[f0],[r0]⟩
example : classify m0_1_1 f0 = .recoverable [r0] := rfl
example : detected m0_1_1 f0 = true := rfl
example : deviation m0_1_1 f0 = true := rfl
example : correctable m0_1_1 f0 = true := rfl
example : classify m0_1_1 f1 = .outside := rfl
example : detected m0_1_1 f1 = true := rfl
example : deviation m0_1_1 f1 = false := rfl
example : correctable m0_1_1 f1 = false := rfl
example : classify m0_1_1 f2 = .outside := rfl
example : detected m0_1_1 f2 = true := rfl
example : deviation m0_1_1 f2 = false := rfl
example : correctable m0_1_1 f2 = false := rfl
example : allGeneratedCorrectable m0_1_1 = true := rfl
def m0_1_2 : Model := ⟨[],[f0],[r1]⟩
example : classify m0_1_2 f0 = .uncorrectable := rfl
example : detected m0_1_2 f0 = true := rfl
example : deviation m0_1_2 f0 = true := rfl
example : correctable m0_1_2 f0 = false := rfl
example : classify m0_1_2 f1 = .outside := rfl
example : detected m0_1_2 f1 = true := rfl
example : deviation m0_1_2 f1 = false := rfl
example : correctable m0_1_2 f1 = true := rfl
example : classify m0_1_2 f2 = .outside := rfl
example : detected m0_1_2 f2 = true := rfl
example : deviation m0_1_2 f2 = false := rfl
example : correctable m0_1_2 f2 = false := rfl
example : allGeneratedCorrectable m0_1_2 = false := rfl
def m0_1_3 : Model := ⟨[],[f0],[r0,r1]⟩
example : classify m0_1_3 f0 = .recoverable [r0] := rfl
example : detected m0_1_3 f0 = true := rfl
example : deviation m0_1_3 f0 = true := rfl
example : correctable m0_1_3 f0 = true := rfl
example : classify m0_1_3 f1 = .outside := rfl
example : detected m0_1_3 f1 = true := rfl
example : deviation m0_1_3 f1 = false := rfl
example : correctable m0_1_3 f1 = true := rfl
example : classify m0_1_3 f2 = .outside := rfl
example : detected m0_1_3 f2 = true := rfl
example : deviation m0_1_3 f2 = false := rfl
example : correctable m0_1_3 f2 = false := rfl
example : allGeneratedCorrectable m0_1_3 = true := rfl
def m0_1_4 : Model := ⟨[],[f0],[r2]⟩
example : classify m0_1_4 f0 = .uncorrectable := rfl
example : detected m0_1_4 f0 = true := rfl
example : deviation m0_1_4 f0 = true := rfl
example : correctable m0_1_4 f0 = false := rfl
example : classify m0_1_4 f1 = .outside := rfl
example : detected m0_1_4 f1 = true := rfl
example : deviation m0_1_4 f1 = false := rfl
example : correctable m0_1_4 f1 = false := rfl
example : classify m0_1_4 f2 = .outside := rfl
example : detected m0_1_4 f2 = true := rfl
example : deviation m0_1_4 f2 = false := rfl
example : correctable m0_1_4 f2 = true := rfl
example : allGeneratedCorrectable m0_1_4 = false := rfl
def m0_1_5 : Model := ⟨[],[f0],[r0,r2]⟩
example : classify m0_1_5 f0 = .recoverable [r0] := rfl
example : detected m0_1_5 f0 = true := rfl
example : deviation m0_1_5 f0 = true := rfl
example : correctable m0_1_5 f0 = true := rfl
example : classify m0_1_5 f1 = .outside := rfl
example : detected m0_1_5 f1 = true := rfl
example : deviation m0_1_5 f1 = false := rfl
example : correctable m0_1_5 f1 = false := rfl
example : classify m0_1_5 f2 = .outside := rfl
example : detected m0_1_5 f2 = true := rfl
example : deviation m0_1_5 f2 = false := rfl
example : correctable m0_1_5 f2 = true := rfl
example : allGeneratedCorrectable m0_1_5 = true := rfl
def m0_1_6 : Model := ⟨[],[f0],[r1,r2]⟩
example : classify m0_1_6 f0 = .uncorrectable := rfl
example : detected m0_1_6 f0 = true := rfl
example : deviation m0_1_6 f0 = true := rfl
example : correctable m0_1_6 f0 = false := rfl
example : classify m0_1_6 f1 = .outside := rfl
example : detected m0_1_6 f1 = true := rfl
example : deviation m0_1_6 f1 = false := rfl
example : correctable m0_1_6 f1 = true := rfl
example : classify m0_1_6 f2 = .outside := rfl
example : detected m0_1_6 f2 = true := rfl
example : deviation m0_1_6 f2 = false := rfl
example : correctable m0_1_6 f2 = true := rfl
example : allGeneratedCorrectable m0_1_6 = false := rfl
def m0_1_7 : Model := ⟨[],[f0],[r0,r1,r2]⟩
example : classify m0_1_7 f0 = .recoverable [r0] := rfl
example : detected m0_1_7 f0 = true := rfl
example : deviation m0_1_7 f0 = true := rfl
example : correctable m0_1_7 f0 = true := rfl
example : classify m0_1_7 f1 = .outside := rfl
example : detected m0_1_7 f1 = true := rfl
example : deviation m0_1_7 f1 = false := rfl
example : correctable m0_1_7 f1 = true := rfl
example : classify m0_1_7 f2 = .outside := rfl
example : detected m0_1_7 f2 = true := rfl
example : deviation m0_1_7 f2 = false := rfl
example : correctable m0_1_7 f2 = true := rfl
example : allGeneratedCorrectable m0_1_7 = true := rfl
def m0_2_0 : Model := ⟨[],[f1],[]⟩
example : classify m0_2_0 f0 = .outside := rfl
example : detected m0_2_0 f0 = true := rfl
example : deviation m0_2_0 f0 = false := rfl
example : correctable m0_2_0 f0 = false := rfl
example : classify m0_2_0 f1 = .uncorrectable := rfl
example : detected m0_2_0 f1 = true := rfl
example : deviation m0_2_0 f1 = true := rfl
example : correctable m0_2_0 f1 = false := rfl
example : classify m0_2_0 f2 = .outside := rfl
example : detected m0_2_0 f2 = true := rfl
example : deviation m0_2_0 f2 = false := rfl
example : correctable m0_2_0 f2 = false := rfl
example : allGeneratedCorrectable m0_2_0 = false := rfl
def m0_2_1 : Model := ⟨[],[f1],[r0]⟩
example : classify m0_2_1 f0 = .outside := rfl
example : detected m0_2_1 f0 = true := rfl
example : deviation m0_2_1 f0 = false := rfl
example : correctable m0_2_1 f0 = true := rfl
example : classify m0_2_1 f1 = .uncorrectable := rfl
example : detected m0_2_1 f1 = true := rfl
example : deviation m0_2_1 f1 = true := rfl
example : correctable m0_2_1 f1 = false := rfl
example : classify m0_2_1 f2 = .outside := rfl
example : detected m0_2_1 f2 = true := rfl
example : deviation m0_2_1 f2 = false := rfl
example : correctable m0_2_1 f2 = false := rfl
example : allGeneratedCorrectable m0_2_1 = false := rfl
def m0_2_2 : Model := ⟨[],[f1],[r1]⟩
example : classify m0_2_2 f0 = .outside := rfl
example : detected m0_2_2 f0 = true := rfl
example : deviation m0_2_2 f0 = false := rfl
example : correctable m0_2_2 f0 = false := rfl
example : classify m0_2_2 f1 = .recoverable [r1] := rfl
example : detected m0_2_2 f1 = true := rfl
example : deviation m0_2_2 f1 = true := rfl
example : correctable m0_2_2 f1 = true := rfl
example : classify m0_2_2 f2 = .outside := rfl
example : detected m0_2_2 f2 = true := rfl
example : deviation m0_2_2 f2 = false := rfl
example : correctable m0_2_2 f2 = false := rfl
example : allGeneratedCorrectable m0_2_2 = true := rfl
def m0_2_3 : Model := ⟨[],[f1],[r0,r1]⟩
example : classify m0_2_3 f0 = .outside := rfl
example : detected m0_2_3 f0 = true := rfl
example : deviation m0_2_3 f0 = false := rfl
example : correctable m0_2_3 f0 = true := rfl
example : classify m0_2_3 f1 = .recoverable [r1] := rfl
example : detected m0_2_3 f1 = true := rfl
example : deviation m0_2_3 f1 = true := rfl
example : correctable m0_2_3 f1 = true := rfl
example : classify m0_2_3 f2 = .outside := rfl
example : detected m0_2_3 f2 = true := rfl
example : deviation m0_2_3 f2 = false := rfl
example : correctable m0_2_3 f2 = false := rfl
example : allGeneratedCorrectable m0_2_3 = true := rfl
def m0_2_4 : Model := ⟨[],[f1],[r2]⟩
example : classify m0_2_4 f0 = .outside := rfl
example : detected m0_2_4 f0 = true := rfl
example : deviation m0_2_4 f0 = false := rfl
example : correctable m0_2_4 f0 = false := rfl
example : classify m0_2_4 f1 = .uncorrectable := rfl
example : detected m0_2_4 f1 = true := rfl
example : deviation m0_2_4 f1 = true := rfl
example : correctable m0_2_4 f1 = false := rfl
example : classify m0_2_4 f2 = .outside := rfl
example : detected m0_2_4 f2 = true := rfl
example : deviation m0_2_4 f2 = false := rfl
example : correctable m0_2_4 f2 = true := rfl
example : allGeneratedCorrectable m0_2_4 = false := rfl
def m0_2_5 : Model := ⟨[],[f1],[r0,r2]⟩
example : classify m0_2_5 f0 = .outside := rfl
example : detected m0_2_5 f0 = true := rfl
example : deviation m0_2_5 f0 = false := rfl
example : correctable m0_2_5 f0 = true := rfl
example : classify m0_2_5 f1 = .uncorrectable := rfl
example : detected m0_2_5 f1 = true := rfl
example : deviation m0_2_5 f1 = true := rfl
example : correctable m0_2_5 f1 = false := rfl
example : classify m0_2_5 f2 = .outside := rfl
example : detected m0_2_5 f2 = true := rfl
example : deviation m0_2_5 f2 = false := rfl
example : correctable m0_2_5 f2 = true := rfl
example : allGeneratedCorrectable m0_2_5 = false := rfl
def m0_2_6 : Model := ⟨[],[f1],[r1,r2]⟩
example : classify m0_2_6 f0 = .outside := rfl
example : detected m0_2_6 f0 = true := rfl
example : deviation m0_2_6 f0 = false := rfl
example : correctable m0_2_6 f0 = false := rfl
example : classify m0_2_6 f1 = .recoverable [r1] := rfl
example : detected m0_2_6 f1 = true := rfl
example : deviation m0_2_6 f1 = true := rfl
example : correctable m0_2_6 f1 = true := rfl
example : classify m0_2_6 f2 = .outside := rfl
example : detected m0_2_6 f2 = true := rfl
example : deviation m0_2_6 f2 = false := rfl
example : correctable m0_2_6 f2 = true := rfl
example : allGeneratedCorrectable m0_2_6 = true := rfl
def m0_2_7 : Model := ⟨[],[f1],[r0,r1,r2]⟩
example : classify m0_2_7 f0 = .outside := rfl
example : detected m0_2_7 f0 = true := rfl
example : deviation m0_2_7 f0 = false := rfl
example : correctable m0_2_7 f0 = true := rfl
example : classify m0_2_7 f1 = .recoverable [r1] := rfl
example : detected m0_2_7 f1 = true := rfl
example : deviation m0_2_7 f1 = true := rfl
example : correctable m0_2_7 f1 = true := rfl
example : classify m0_2_7 f2 = .outside := rfl
example : detected m0_2_7 f2 = true := rfl
example : deviation m0_2_7 f2 = false := rfl
example : correctable m0_2_7 f2 = true := rfl
example : allGeneratedCorrectable m0_2_7 = true := rfl
def m0_3_0 : Model := ⟨[],[f0,f1],[]⟩
example : classify m0_3_0 f0 = .uncorrectable := rfl
example : detected m0_3_0 f0 = true := rfl
example : deviation m0_3_0 f0 = true := rfl
example : correctable m0_3_0 f0 = false := rfl
example : classify m0_3_0 f1 = .uncorrectable := rfl
example : detected m0_3_0 f1 = true := rfl
example : deviation m0_3_0 f1 = true := rfl
example : correctable m0_3_0 f1 = false := rfl
example : classify m0_3_0 f2 = .outside := rfl
example : detected m0_3_0 f2 = true := rfl
example : deviation m0_3_0 f2 = false := rfl
example : correctable m0_3_0 f2 = false := rfl
example : allGeneratedCorrectable m0_3_0 = false := rfl
def m0_3_1 : Model := ⟨[],[f0,f1],[r0]⟩
example : classify m0_3_1 f0 = .recoverable [r0] := rfl
example : detected m0_3_1 f0 = true := rfl
example : deviation m0_3_1 f0 = true := rfl
example : correctable m0_3_1 f0 = true := rfl
example : classify m0_3_1 f1 = .uncorrectable := rfl
example : detected m0_3_1 f1 = true := rfl
example : deviation m0_3_1 f1 = true := rfl
example : correctable m0_3_1 f1 = false := rfl
example : classify m0_3_1 f2 = .outside := rfl
example : detected m0_3_1 f2 = true := rfl
example : deviation m0_3_1 f2 = false := rfl
example : correctable m0_3_1 f2 = false := rfl
example : allGeneratedCorrectable m0_3_1 = false := rfl
def m0_3_2 : Model := ⟨[],[f0,f1],[r1]⟩
example : classify m0_3_2 f0 = .uncorrectable := rfl
example : detected m0_3_2 f0 = true := rfl
example : deviation m0_3_2 f0 = true := rfl
example : correctable m0_3_2 f0 = false := rfl
example : classify m0_3_2 f1 = .recoverable [r1] := rfl
example : detected m0_3_2 f1 = true := rfl
example : deviation m0_3_2 f1 = true := rfl
example : correctable m0_3_2 f1 = true := rfl
example : classify m0_3_2 f2 = .outside := rfl
example : detected m0_3_2 f2 = true := rfl
example : deviation m0_3_2 f2 = false := rfl
example : correctable m0_3_2 f2 = false := rfl
example : allGeneratedCorrectable m0_3_2 = false := rfl
def m0_3_3 : Model := ⟨[],[f0,f1],[r0,r1]⟩
example : classify m0_3_3 f0 = .recoverable [r0] := rfl
example : detected m0_3_3 f0 = true := rfl
example : deviation m0_3_3 f0 = true := rfl
example : correctable m0_3_3 f0 = true := rfl
example : classify m0_3_3 f1 = .recoverable [r1] := rfl
example : detected m0_3_3 f1 = true := rfl
example : deviation m0_3_3 f1 = true := rfl
example : correctable m0_3_3 f1 = true := rfl
example : classify m0_3_3 f2 = .outside := rfl
example : detected m0_3_3 f2 = true := rfl
example : deviation m0_3_3 f2 = false := rfl
example : correctable m0_3_3 f2 = false := rfl
example : allGeneratedCorrectable m0_3_3 = true := rfl
def m0_3_4 : Model := ⟨[],[f0,f1],[r2]⟩
example : classify m0_3_4 f0 = .uncorrectable := rfl
example : detected m0_3_4 f0 = true := rfl
example : deviation m0_3_4 f0 = true := rfl
example : correctable m0_3_4 f0 = false := rfl
example : classify m0_3_4 f1 = .uncorrectable := rfl
example : detected m0_3_4 f1 = true := rfl
example : deviation m0_3_4 f1 = true := rfl
example : correctable m0_3_4 f1 = false := rfl
example : classify m0_3_4 f2 = .outside := rfl
example : detected m0_3_4 f2 = true := rfl
example : deviation m0_3_4 f2 = false := rfl
example : correctable m0_3_4 f2 = true := rfl
example : allGeneratedCorrectable m0_3_4 = false := rfl
def m0_3_5 : Model := ⟨[],[f0,f1],[r0,r2]⟩
example : classify m0_3_5 f0 = .recoverable [r0] := rfl
example : detected m0_3_5 f0 = true := rfl
example : deviation m0_3_5 f0 = true := rfl
example : correctable m0_3_5 f0 = true := rfl
example : classify m0_3_5 f1 = .uncorrectable := rfl
example : detected m0_3_5 f1 = true := rfl
example : deviation m0_3_5 f1 = true := rfl
example : correctable m0_3_5 f1 = false := rfl
example : classify m0_3_5 f2 = .outside := rfl
example : detected m0_3_5 f2 = true := rfl
example : deviation m0_3_5 f2 = false := rfl
example : correctable m0_3_5 f2 = true := rfl
example : allGeneratedCorrectable m0_3_5 = false := rfl
def m0_3_6 : Model := ⟨[],[f0,f1],[r1,r2]⟩
example : classify m0_3_6 f0 = .uncorrectable := rfl
example : detected m0_3_6 f0 = true := rfl
example : deviation m0_3_6 f0 = true := rfl
example : correctable m0_3_6 f0 = false := rfl
example : classify m0_3_6 f1 = .recoverable [r1] := rfl
example : detected m0_3_6 f1 = true := rfl
example : deviation m0_3_6 f1 = true := rfl
example : correctable m0_3_6 f1 = true := rfl
example : classify m0_3_6 f2 = .outside := rfl
example : detected m0_3_6 f2 = true := rfl
example : deviation m0_3_6 f2 = false := rfl
example : correctable m0_3_6 f2 = true := rfl
example : allGeneratedCorrectable m0_3_6 = false := rfl
def m0_3_7 : Model := ⟨[],[f0,f1],[r0,r1,r2]⟩
example : classify m0_3_7 f0 = .recoverable [r0] := rfl
example : detected m0_3_7 f0 = true := rfl
example : deviation m0_3_7 f0 = true := rfl
example : correctable m0_3_7 f0 = true := rfl
example : classify m0_3_7 f1 = .recoverable [r1] := rfl
example : detected m0_3_7 f1 = true := rfl
example : deviation m0_3_7 f1 = true := rfl
example : correctable m0_3_7 f1 = true := rfl
example : classify m0_3_7 f2 = .outside := rfl
example : detected m0_3_7 f2 = true := rfl
example : deviation m0_3_7 f2 = false := rfl
example : correctable m0_3_7 f2 = true := rfl
example : allGeneratedCorrectable m0_3_7 = true := rfl
def m0_4_0 : Model := ⟨[],[f2],[]⟩
example : classify m0_4_0 f0 = .outside := rfl
example : detected m0_4_0 f0 = true := rfl
example : deviation m0_4_0 f0 = false := rfl
example : correctable m0_4_0 f0 = false := rfl
example : classify m0_4_0 f1 = .outside := rfl
example : detected m0_4_0 f1 = true := rfl
example : deviation m0_4_0 f1 = false := rfl
example : correctable m0_4_0 f1 = false := rfl
example : classify m0_4_0 f2 = .uncorrectable := rfl
example : detected m0_4_0 f2 = true := rfl
example : deviation m0_4_0 f2 = true := rfl
example : correctable m0_4_0 f2 = false := rfl
example : allGeneratedCorrectable m0_4_0 = false := rfl
def m0_4_1 : Model := ⟨[],[f2],[r0]⟩
example : classify m0_4_1 f0 = .outside := rfl
example : detected m0_4_1 f0 = true := rfl
example : deviation m0_4_1 f0 = false := rfl
example : correctable m0_4_1 f0 = true := rfl
example : classify m0_4_1 f1 = .outside := rfl
example : detected m0_4_1 f1 = true := rfl
example : deviation m0_4_1 f1 = false := rfl
example : correctable m0_4_1 f1 = false := rfl
example : classify m0_4_1 f2 = .uncorrectable := rfl
example : detected m0_4_1 f2 = true := rfl
example : deviation m0_4_1 f2 = true := rfl
example : correctable m0_4_1 f2 = false := rfl
example : allGeneratedCorrectable m0_4_1 = false := rfl
def m0_4_2 : Model := ⟨[],[f2],[r1]⟩
example : classify m0_4_2 f0 = .outside := rfl
example : detected m0_4_2 f0 = true := rfl
example : deviation m0_4_2 f0 = false := rfl
example : correctable m0_4_2 f0 = false := rfl
example : classify m0_4_2 f1 = .outside := rfl
example : detected m0_4_2 f1 = true := rfl
example : deviation m0_4_2 f1 = false := rfl
example : correctable m0_4_2 f1 = true := rfl
example : classify m0_4_2 f2 = .uncorrectable := rfl
example : detected m0_4_2 f2 = true := rfl
example : deviation m0_4_2 f2 = true := rfl
example : correctable m0_4_2 f2 = false := rfl
example : allGeneratedCorrectable m0_4_2 = false := rfl
def m0_4_3 : Model := ⟨[],[f2],[r0,r1]⟩
example : classify m0_4_3 f0 = .outside := rfl
example : detected m0_4_3 f0 = true := rfl
example : deviation m0_4_3 f0 = false := rfl
example : correctable m0_4_3 f0 = true := rfl
example : classify m0_4_3 f1 = .outside := rfl
example : detected m0_4_3 f1 = true := rfl
example : deviation m0_4_3 f1 = false := rfl
example : correctable m0_4_3 f1 = true := rfl
example : classify m0_4_3 f2 = .uncorrectable := rfl
example : detected m0_4_3 f2 = true := rfl
example : deviation m0_4_3 f2 = true := rfl
example : correctable m0_4_3 f2 = false := rfl
example : allGeneratedCorrectable m0_4_3 = false := rfl
def m0_4_4 : Model := ⟨[],[f2],[r2]⟩
example : classify m0_4_4 f0 = .outside := rfl
example : detected m0_4_4 f0 = true := rfl
example : deviation m0_4_4 f0 = false := rfl
example : correctable m0_4_4 f0 = false := rfl
example : classify m0_4_4 f1 = .outside := rfl
example : detected m0_4_4 f1 = true := rfl
example : deviation m0_4_4 f1 = false := rfl
example : correctable m0_4_4 f1 = false := rfl
example : classify m0_4_4 f2 = .recoverable [r2] := rfl
example : detected m0_4_4 f2 = true := rfl
example : deviation m0_4_4 f2 = true := rfl
example : correctable m0_4_4 f2 = true := rfl
example : allGeneratedCorrectable m0_4_4 = true := rfl
def m0_4_5 : Model := ⟨[],[f2],[r0,r2]⟩
example : classify m0_4_5 f0 = .outside := rfl
example : detected m0_4_5 f0 = true := rfl
example : deviation m0_4_5 f0 = false := rfl
example : correctable m0_4_5 f0 = true := rfl
example : classify m0_4_5 f1 = .outside := rfl
example : detected m0_4_5 f1 = true := rfl
example : deviation m0_4_5 f1 = false := rfl
example : correctable m0_4_5 f1 = false := rfl
example : classify m0_4_5 f2 = .recoverable [r2] := rfl
example : detected m0_4_5 f2 = true := rfl
example : deviation m0_4_5 f2 = true := rfl
example : correctable m0_4_5 f2 = true := rfl
example : allGeneratedCorrectable m0_4_5 = true := rfl
def m0_4_6 : Model := ⟨[],[f2],[r1,r2]⟩
example : classify m0_4_6 f0 = .outside := rfl
example : detected m0_4_6 f0 = true := rfl
example : deviation m0_4_6 f0 = false := rfl
example : correctable m0_4_6 f0 = false := rfl
example : classify m0_4_6 f1 = .outside := rfl
example : detected m0_4_6 f1 = true := rfl
example : deviation m0_4_6 f1 = false := rfl
example : correctable m0_4_6 f1 = true := rfl
example : classify m0_4_6 f2 = .recoverable [r2] := rfl
example : detected m0_4_6 f2 = true := rfl
example : deviation m0_4_6 f2 = true := rfl
example : correctable m0_4_6 f2 = true := rfl
example : allGeneratedCorrectable m0_4_6 = true := rfl
def m0_4_7 : Model := ⟨[],[f2],[r0,r1,r2]⟩
example : classify m0_4_7 f0 = .outside := rfl
example : detected m0_4_7 f0 = true := rfl
example : deviation m0_4_7 f0 = false := rfl
example : correctable m0_4_7 f0 = true := rfl
example : classify m0_4_7 f1 = .outside := rfl
example : detected m0_4_7 f1 = true := rfl
example : deviation m0_4_7 f1 = false := rfl
example : correctable m0_4_7 f1 = true := rfl
example : classify m0_4_7 f2 = .recoverable [r2] := rfl
example : detected m0_4_7 f2 = true := rfl
example : deviation m0_4_7 f2 = true := rfl
example : correctable m0_4_7 f2 = true := rfl
example : allGeneratedCorrectable m0_4_7 = true := rfl
def m0_5_0 : Model := ⟨[],[f0,f2],[]⟩
example : classify m0_5_0 f0 = .uncorrectable := rfl
example : detected m0_5_0 f0 = true := rfl
example : deviation m0_5_0 f0 = true := rfl
example : correctable m0_5_0 f0 = false := rfl
example : classify m0_5_0 f1 = .outside := rfl
example : detected m0_5_0 f1 = true := rfl
example : deviation m0_5_0 f1 = false := rfl
example : correctable m0_5_0 f1 = false := rfl
example : classify m0_5_0 f2 = .uncorrectable := rfl
example : detected m0_5_0 f2 = true := rfl
example : deviation m0_5_0 f2 = true := rfl
example : correctable m0_5_0 f2 = false := rfl
example : allGeneratedCorrectable m0_5_0 = false := rfl
def m0_5_1 : Model := ⟨[],[f0,f2],[r0]⟩
example : classify m0_5_1 f0 = .recoverable [r0] := rfl
example : detected m0_5_1 f0 = true := rfl
example : deviation m0_5_1 f0 = true := rfl
example : correctable m0_5_1 f0 = true := rfl
example : classify m0_5_1 f1 = .outside := rfl
example : detected m0_5_1 f1 = true := rfl
example : deviation m0_5_1 f1 = false := rfl
example : correctable m0_5_1 f1 = false := rfl
example : classify m0_5_1 f2 = .uncorrectable := rfl
example : detected m0_5_1 f2 = true := rfl
example : deviation m0_5_1 f2 = true := rfl
example : correctable m0_5_1 f2 = false := rfl
example : allGeneratedCorrectable m0_5_1 = false := rfl
def m0_5_2 : Model := ⟨[],[f0,f2],[r1]⟩
example : classify m0_5_2 f0 = .uncorrectable := rfl
example : detected m0_5_2 f0 = true := rfl
example : deviation m0_5_2 f0 = true := rfl
example : correctable m0_5_2 f0 = false := rfl
example : classify m0_5_2 f1 = .outside := rfl
example : detected m0_5_2 f1 = true := rfl
example : deviation m0_5_2 f1 = false := rfl
example : correctable m0_5_2 f1 = true := rfl
example : classify m0_5_2 f2 = .uncorrectable := rfl
example : detected m0_5_2 f2 = true := rfl
example : deviation m0_5_2 f2 = true := rfl
example : correctable m0_5_2 f2 = false := rfl
example : allGeneratedCorrectable m0_5_2 = false := rfl
def m0_5_3 : Model := ⟨[],[f0,f2],[r0,r1]⟩
example : classify m0_5_3 f0 = .recoverable [r0] := rfl
example : detected m0_5_3 f0 = true := rfl
example : deviation m0_5_3 f0 = true := rfl
example : correctable m0_5_3 f0 = true := rfl
example : classify m0_5_3 f1 = .outside := rfl
example : detected m0_5_3 f1 = true := rfl
example : deviation m0_5_3 f1 = false := rfl
example : correctable m0_5_3 f1 = true := rfl
example : classify m0_5_3 f2 = .uncorrectable := rfl
example : detected m0_5_3 f2 = true := rfl
example : deviation m0_5_3 f2 = true := rfl
example : correctable m0_5_3 f2 = false := rfl
example : allGeneratedCorrectable m0_5_3 = false := rfl
def m0_5_4 : Model := ⟨[],[f0,f2],[r2]⟩
example : classify m0_5_4 f0 = .uncorrectable := rfl
example : detected m0_5_4 f0 = true := rfl
example : deviation m0_5_4 f0 = true := rfl
example : correctable m0_5_4 f0 = false := rfl
example : classify m0_5_4 f1 = .outside := rfl
example : detected m0_5_4 f1 = true := rfl
example : deviation m0_5_4 f1 = false := rfl
example : correctable m0_5_4 f1 = false := rfl
example : classify m0_5_4 f2 = .recoverable [r2] := rfl
example : detected m0_5_4 f2 = true := rfl
example : deviation m0_5_4 f2 = true := rfl
example : correctable m0_5_4 f2 = true := rfl
example : allGeneratedCorrectable m0_5_4 = false := rfl
def m0_5_5 : Model := ⟨[],[f0,f2],[r0,r2]⟩
example : classify m0_5_5 f0 = .recoverable [r0] := rfl
example : detected m0_5_5 f0 = true := rfl
example : deviation m0_5_5 f0 = true := rfl
example : correctable m0_5_5 f0 = true := rfl
example : classify m0_5_5 f1 = .outside := rfl
example : detected m0_5_5 f1 = true := rfl
example : deviation m0_5_5 f1 = false := rfl
example : correctable m0_5_5 f1 = false := rfl
example : classify m0_5_5 f2 = .recoverable [r2] := rfl
example : detected m0_5_5 f2 = true := rfl
example : deviation m0_5_5 f2 = true := rfl
example : correctable m0_5_5 f2 = true := rfl
example : allGeneratedCorrectable m0_5_5 = true := rfl
def m0_5_6 : Model := ⟨[],[f0,f2],[r1,r2]⟩
example : classify m0_5_6 f0 = .uncorrectable := rfl
example : detected m0_5_6 f0 = true := rfl
example : deviation m0_5_6 f0 = true := rfl
example : correctable m0_5_6 f0 = false := rfl
example : classify m0_5_6 f1 = .outside := rfl
example : detected m0_5_6 f1 = true := rfl
example : deviation m0_5_6 f1 = false := rfl
example : correctable m0_5_6 f1 = true := rfl
example : classify m0_5_6 f2 = .recoverable [r2] := rfl
example : detected m0_5_6 f2 = true := rfl
example : deviation m0_5_6 f2 = true := rfl
example : correctable m0_5_6 f2 = true := rfl
example : allGeneratedCorrectable m0_5_6 = false := rfl
def m0_5_7 : Model := ⟨[],[f0,f2],[r0,r1,r2]⟩
example : classify m0_5_7 f0 = .recoverable [r0] := rfl
example : detected m0_5_7 f0 = true := rfl
example : deviation m0_5_7 f0 = true := rfl
example : correctable m0_5_7 f0 = true := rfl
example : classify m0_5_7 f1 = .outside := rfl
example : detected m0_5_7 f1 = true := rfl
example : deviation m0_5_7 f1 = false := rfl
example : correctable m0_5_7 f1 = true := rfl
example : classify m0_5_7 f2 = .recoverable [r2] := rfl
example : detected m0_5_7 f2 = true := rfl
example : deviation m0_5_7 f2 = true := rfl
example : correctable m0_5_7 f2 = true := rfl
example : allGeneratedCorrectable m0_5_7 = true := rfl
def m0_6_0 : Model := ⟨[],[f1,f2],[]⟩
example : classify m0_6_0 f0 = .outside := rfl
example : detected m0_6_0 f0 = true := rfl
example : deviation m0_6_0 f0 = false := rfl
example : correctable m0_6_0 f0 = false := rfl
example : classify m0_6_0 f1 = .uncorrectable := rfl
example : detected m0_6_0 f1 = true := rfl
example : deviation m0_6_0 f1 = true := rfl
example : correctable m0_6_0 f1 = false := rfl
example : classify m0_6_0 f2 = .uncorrectable := rfl
example : detected m0_6_0 f2 = true := rfl
example : deviation m0_6_0 f2 = true := rfl
example : correctable m0_6_0 f2 = false := rfl
example : allGeneratedCorrectable m0_6_0 = false := rfl
def m0_6_1 : Model := ⟨[],[f1,f2],[r0]⟩
example : classify m0_6_1 f0 = .outside := rfl
example : detected m0_6_1 f0 = true := rfl
example : deviation m0_6_1 f0 = false := rfl
example : correctable m0_6_1 f0 = true := rfl
example : classify m0_6_1 f1 = .uncorrectable := rfl
example : detected m0_6_1 f1 = true := rfl
example : deviation m0_6_1 f1 = true := rfl
example : correctable m0_6_1 f1 = false := rfl
example : classify m0_6_1 f2 = .uncorrectable := rfl
example : detected m0_6_1 f2 = true := rfl
example : deviation m0_6_1 f2 = true := rfl
example : correctable m0_6_1 f2 = false := rfl
example : allGeneratedCorrectable m0_6_1 = false := rfl
def m0_6_2 : Model := ⟨[],[f1,f2],[r1]⟩
example : classify m0_6_2 f0 = .outside := rfl
example : detected m0_6_2 f0 = true := rfl
example : deviation m0_6_2 f0 = false := rfl
example : correctable m0_6_2 f0 = false := rfl
example : classify m0_6_2 f1 = .recoverable [r1] := rfl
example : detected m0_6_2 f1 = true := rfl
example : deviation m0_6_2 f1 = true := rfl
example : correctable m0_6_2 f1 = true := rfl
example : classify m0_6_2 f2 = .uncorrectable := rfl
example : detected m0_6_2 f2 = true := rfl
example : deviation m0_6_2 f2 = true := rfl
example : correctable m0_6_2 f2 = false := rfl
example : allGeneratedCorrectable m0_6_2 = false := rfl
def m0_6_3 : Model := ⟨[],[f1,f2],[r0,r1]⟩
example : classify m0_6_3 f0 = .outside := rfl
example : detected m0_6_3 f0 = true := rfl
example : deviation m0_6_3 f0 = false := rfl
example : correctable m0_6_3 f0 = true := rfl
example : classify m0_6_3 f1 = .recoverable [r1] := rfl
example : detected m0_6_3 f1 = true := rfl
example : deviation m0_6_3 f1 = true := rfl
example : correctable m0_6_3 f1 = true := rfl
example : classify m0_6_3 f2 = .uncorrectable := rfl
example : detected m0_6_3 f2 = true := rfl
example : deviation m0_6_3 f2 = true := rfl
example : correctable m0_6_3 f2 = false := rfl
example : allGeneratedCorrectable m0_6_3 = false := rfl
def m0_6_4 : Model := ⟨[],[f1,f2],[r2]⟩
example : classify m0_6_4 f0 = .outside := rfl
example : detected m0_6_4 f0 = true := rfl
example : deviation m0_6_4 f0 = false := rfl
example : correctable m0_6_4 f0 = false := rfl
example : classify m0_6_4 f1 = .uncorrectable := rfl
example : detected m0_6_4 f1 = true := rfl
example : deviation m0_6_4 f1 = true := rfl
example : correctable m0_6_4 f1 = false := rfl
example : classify m0_6_4 f2 = .recoverable [r2] := rfl
example : detected m0_6_4 f2 = true := rfl
example : deviation m0_6_4 f2 = true := rfl
example : correctable m0_6_4 f2 = true := rfl
example : allGeneratedCorrectable m0_6_4 = false := rfl
def m0_6_5 : Model := ⟨[],[f1,f2],[r0,r2]⟩
example : classify m0_6_5 f0 = .outside := rfl
example : detected m0_6_5 f0 = true := rfl
example : deviation m0_6_5 f0 = false := rfl
example : correctable m0_6_5 f0 = true := rfl
example : classify m0_6_5 f1 = .uncorrectable := rfl
example : detected m0_6_5 f1 = true := rfl
example : deviation m0_6_5 f1 = true := rfl
example : correctable m0_6_5 f1 = false := rfl
example : classify m0_6_5 f2 = .recoverable [r2] := rfl
example : detected m0_6_5 f2 = true := rfl
example : deviation m0_6_5 f2 = true := rfl
example : correctable m0_6_5 f2 = true := rfl
example : allGeneratedCorrectable m0_6_5 = false := rfl
def m0_6_6 : Model := ⟨[],[f1,f2],[r1,r2]⟩
example : classify m0_6_6 f0 = .outside := rfl
example : detected m0_6_6 f0 = true := rfl
example : deviation m0_6_6 f0 = false := rfl
example : correctable m0_6_6 f0 = false := rfl
example : classify m0_6_6 f1 = .recoverable [r1] := rfl
example : detected m0_6_6 f1 = true := rfl
example : deviation m0_6_6 f1 = true := rfl
example : correctable m0_6_6 f1 = true := rfl
example : classify m0_6_6 f2 = .recoverable [r2] := rfl
example : detected m0_6_6 f2 = true := rfl
example : deviation m0_6_6 f2 = true := rfl
example : correctable m0_6_6 f2 = true := rfl
example : allGeneratedCorrectable m0_6_6 = true := rfl
def m0_6_7 : Model := ⟨[],[f1,f2],[r0,r1,r2]⟩
example : classify m0_6_7 f0 = .outside := rfl
example : detected m0_6_7 f0 = true := rfl
example : deviation m0_6_7 f0 = false := rfl
example : correctable m0_6_7 f0 = true := rfl
example : classify m0_6_7 f1 = .recoverable [r1] := rfl
example : detected m0_6_7 f1 = true := rfl
example : deviation m0_6_7 f1 = true := rfl
example : correctable m0_6_7 f1 = true := rfl
example : classify m0_6_7 f2 = .recoverable [r2] := rfl
example : detected m0_6_7 f2 = true := rfl
example : deviation m0_6_7 f2 = true := rfl
example : correctable m0_6_7 f2 = true := rfl
example : allGeneratedCorrectable m0_6_7 = true := rfl
def m0_7_0 : Model := ⟨[],[f0,f1,f2],[]⟩
example : classify m0_7_0 f0 = .uncorrectable := rfl
example : detected m0_7_0 f0 = true := rfl
example : deviation m0_7_0 f0 = true := rfl
example : correctable m0_7_0 f0 = false := rfl
example : classify m0_7_0 f1 = .uncorrectable := rfl
example : detected m0_7_0 f1 = true := rfl
example : deviation m0_7_0 f1 = true := rfl
example : correctable m0_7_0 f1 = false := rfl
example : classify m0_7_0 f2 = .uncorrectable := rfl
example : detected m0_7_0 f2 = true := rfl
example : deviation m0_7_0 f2 = true := rfl
example : correctable m0_7_0 f2 = false := rfl
example : allGeneratedCorrectable m0_7_0 = false := rfl
def m0_7_1 : Model := ⟨[],[f0,f1,f2],[r0]⟩
example : classify m0_7_1 f0 = .recoverable [r0] := rfl
example : detected m0_7_1 f0 = true := rfl
example : deviation m0_7_1 f0 = true := rfl
example : correctable m0_7_1 f0 = true := rfl
example : classify m0_7_1 f1 = .uncorrectable := rfl
example : detected m0_7_1 f1 = true := rfl
example : deviation m0_7_1 f1 = true := rfl
example : correctable m0_7_1 f1 = false := rfl
example : classify m0_7_1 f2 = .uncorrectable := rfl
example : detected m0_7_1 f2 = true := rfl
example : deviation m0_7_1 f2 = true := rfl
example : correctable m0_7_1 f2 = false := rfl
example : allGeneratedCorrectable m0_7_1 = false := rfl
def m0_7_2 : Model := ⟨[],[f0,f1,f2],[r1]⟩
example : classify m0_7_2 f0 = .uncorrectable := rfl
example : detected m0_7_2 f0 = true := rfl
example : deviation m0_7_2 f0 = true := rfl
example : correctable m0_7_2 f0 = false := rfl
example : classify m0_7_2 f1 = .recoverable [r1] := rfl
example : detected m0_7_2 f1 = true := rfl
example : deviation m0_7_2 f1 = true := rfl
example : correctable m0_7_2 f1 = true := rfl
example : classify m0_7_2 f2 = .uncorrectable := rfl
example : detected m0_7_2 f2 = true := rfl
example : deviation m0_7_2 f2 = true := rfl
example : correctable m0_7_2 f2 = false := rfl
example : allGeneratedCorrectable m0_7_2 = false := rfl
def m0_7_3 : Model := ⟨[],[f0,f1,f2],[r0,r1]⟩
example : classify m0_7_3 f0 = .recoverable [r0] := rfl
example : detected m0_7_3 f0 = true := rfl
example : deviation m0_7_3 f0 = true := rfl
example : correctable m0_7_3 f0 = true := rfl
example : classify m0_7_3 f1 = .recoverable [r1] := rfl
example : detected m0_7_3 f1 = true := rfl
example : deviation m0_7_3 f1 = true := rfl
example : correctable m0_7_3 f1 = true := rfl
example : classify m0_7_3 f2 = .uncorrectable := rfl
example : detected m0_7_3 f2 = true := rfl
example : deviation m0_7_3 f2 = true := rfl
example : correctable m0_7_3 f2 = false := rfl
example : allGeneratedCorrectable m0_7_3 = false := rfl
def m0_7_4 : Model := ⟨[],[f0,f1,f2],[r2]⟩
example : classify m0_7_4 f0 = .uncorrectable := rfl
example : detected m0_7_4 f0 = true := rfl
example : deviation m0_7_4 f0 = true := rfl
example : correctable m0_7_4 f0 = false := rfl
example : classify m0_7_4 f1 = .uncorrectable := rfl
example : detected m0_7_4 f1 = true := rfl
example : deviation m0_7_4 f1 = true := rfl
example : correctable m0_7_4 f1 = false := rfl
example : classify m0_7_4 f2 = .recoverable [r2] := rfl
example : detected m0_7_4 f2 = true := rfl
example : deviation m0_7_4 f2 = true := rfl
example : correctable m0_7_4 f2 = true := rfl
example : allGeneratedCorrectable m0_7_4 = false := rfl
def m0_7_5 : Model := ⟨[],[f0,f1,f2],[r0,r2]⟩
example : classify m0_7_5 f0 = .recoverable [r0] := rfl
example : detected m0_7_5 f0 = true := rfl
example : deviation m0_7_5 f0 = true := rfl
example : correctable m0_7_5 f0 = true := rfl
example : classify m0_7_5 f1 = .uncorrectable := rfl
example : detected m0_7_5 f1 = true := rfl
example : deviation m0_7_5 f1 = true := rfl
example : correctable m0_7_5 f1 = false := rfl
example : classify m0_7_5 f2 = .recoverable [r2] := rfl
example : detected m0_7_5 f2 = true := rfl
example : deviation m0_7_5 f2 = true := rfl
example : correctable m0_7_5 f2 = true := rfl
example : allGeneratedCorrectable m0_7_5 = false := rfl
def m0_7_6 : Model := ⟨[],[f0,f1,f2],[r1,r2]⟩
example : classify m0_7_6 f0 = .uncorrectable := rfl
example : detected m0_7_6 f0 = true := rfl
example : deviation m0_7_6 f0 = true := rfl
example : correctable m0_7_6 f0 = false := rfl
example : classify m0_7_6 f1 = .recoverable [r1] := rfl
example : detected m0_7_6 f1 = true := rfl
example : deviation m0_7_6 f1 = true := rfl
example : correctable m0_7_6 f1 = true := rfl
example : classify m0_7_6 f2 = .recoverable [r2] := rfl
example : detected m0_7_6 f2 = true := rfl
example : deviation m0_7_6 f2 = true := rfl
example : correctable m0_7_6 f2 = true := rfl
example : allGeneratedCorrectable m0_7_6 = false := rfl
def m0_7_7 : Model := ⟨[],[f0,f1,f2],[r0,r1,r2]⟩
example : classify m0_7_7 f0 = .recoverable [r0] := rfl
example : detected m0_7_7 f0 = true := rfl
example : deviation m0_7_7 f0 = true := rfl
example : correctable m0_7_7 f0 = true := rfl
example : classify m0_7_7 f1 = .recoverable [r1] := rfl
example : detected m0_7_7 f1 = true := rfl
example : deviation m0_7_7 f1 = true := rfl
example : correctable m0_7_7 f1 = true := rfl
example : classify m0_7_7 f2 = .recoverable [r2] := rfl
example : detected m0_7_7 f2 = true := rfl
example : deviation m0_7_7 f2 = true := rfl
example : correctable m0_7_7 f2 = true := rfl
example : allGeneratedCorrectable m0_7_7 = true := rfl
def m1_0_0 : Model := ⟨[n0],[],[]⟩
example : classify m1_0_0 f0 = .outside := rfl
example : detected m1_0_0 f0 = true := rfl
example : deviation m1_0_0 f0 = false := rfl
example : correctable m1_0_0 f0 = false := rfl
example : classify m1_0_0 f1 = .outside := rfl
example : detected m1_0_0 f1 = false := rfl
example : deviation m1_0_0 f1 = false := rfl
example : correctable m1_0_0 f1 = false := rfl
example : classify m1_0_0 f2 = .outside := rfl
example : detected m1_0_0 f2 = true := rfl
example : deviation m1_0_0 f2 = false := rfl
example : correctable m1_0_0 f2 = false := rfl
example : allGeneratedCorrectable m1_0_0 = true := rfl
def m1_0_1 : Model := ⟨[n0],[],[r0]⟩
example : classify m1_0_1 f0 = .outside := rfl
example : detected m1_0_1 f0 = true := rfl
example : deviation m1_0_1 f0 = false := rfl
example : correctable m1_0_1 f0 = true := rfl
example : classify m1_0_1 f1 = .outside := rfl
example : detected m1_0_1 f1 = false := rfl
example : deviation m1_0_1 f1 = false := rfl
example : correctable m1_0_1 f1 = false := rfl
example : classify m1_0_1 f2 = .outside := rfl
example : detected m1_0_1 f2 = true := rfl
example : deviation m1_0_1 f2 = false := rfl
example : correctable m1_0_1 f2 = false := rfl
example : allGeneratedCorrectable m1_0_1 = true := rfl
def m1_0_2 : Model := ⟨[n0],[],[r1]⟩
example : classify m1_0_2 f0 = .outside := rfl
example : detected m1_0_2 f0 = true := rfl
example : deviation m1_0_2 f0 = false := rfl
example : correctable m1_0_2 f0 = false := rfl
example : classify m1_0_2 f1 = .outside := rfl
example : detected m1_0_2 f1 = false := rfl
example : deviation m1_0_2 f1 = false := rfl
example : correctable m1_0_2 f1 = true := rfl
example : classify m1_0_2 f2 = .outside := rfl
example : detected m1_0_2 f2 = true := rfl
example : deviation m1_0_2 f2 = false := rfl
example : correctable m1_0_2 f2 = false := rfl
example : allGeneratedCorrectable m1_0_2 = true := rfl
def m1_0_3 : Model := ⟨[n0],[],[r0,r1]⟩
example : classify m1_0_3 f0 = .outside := rfl
example : detected m1_0_3 f0 = true := rfl
example : deviation m1_0_3 f0 = false := rfl
example : correctable m1_0_3 f0 = true := rfl
example : classify m1_0_3 f1 = .outside := rfl
example : detected m1_0_3 f1 = false := rfl
example : deviation m1_0_3 f1 = false := rfl
example : correctable m1_0_3 f1 = true := rfl
example : classify m1_0_3 f2 = .outside := rfl
example : detected m1_0_3 f2 = true := rfl
example : deviation m1_0_3 f2 = false := rfl
example : correctable m1_0_3 f2 = false := rfl
example : allGeneratedCorrectable m1_0_3 = true := rfl
def m1_0_4 : Model := ⟨[n0],[],[r2]⟩
example : classify m1_0_4 f0 = .outside := rfl
example : detected m1_0_4 f0 = true := rfl
example : deviation m1_0_4 f0 = false := rfl
example : correctable m1_0_4 f0 = false := rfl
example : classify m1_0_4 f1 = .outside := rfl
example : detected m1_0_4 f1 = false := rfl
example : deviation m1_0_4 f1 = false := rfl
example : correctable m1_0_4 f1 = false := rfl
example : classify m1_0_4 f2 = .outside := rfl
example : detected m1_0_4 f2 = true := rfl
example : deviation m1_0_4 f2 = false := rfl
example : correctable m1_0_4 f2 = true := rfl
example : allGeneratedCorrectable m1_0_4 = true := rfl
def m1_0_5 : Model := ⟨[n0],[],[r0,r2]⟩
example : classify m1_0_5 f0 = .outside := rfl
example : detected m1_0_5 f0 = true := rfl
example : deviation m1_0_5 f0 = false := rfl
example : correctable m1_0_5 f0 = true := rfl
example : classify m1_0_5 f1 = .outside := rfl
example : detected m1_0_5 f1 = false := rfl
example : deviation m1_0_5 f1 = false := rfl
example : correctable m1_0_5 f1 = false := rfl
example : classify m1_0_5 f2 = .outside := rfl
example : detected m1_0_5 f2 = true := rfl
example : deviation m1_0_5 f2 = false := rfl
example : correctable m1_0_5 f2 = true := rfl
example : allGeneratedCorrectable m1_0_5 = true := rfl
def m1_0_6 : Model := ⟨[n0],[],[r1,r2]⟩
example : classify m1_0_6 f0 = .outside := rfl
example : detected m1_0_6 f0 = true := rfl
example : deviation m1_0_6 f0 = false := rfl
example : correctable m1_0_6 f0 = false := rfl
example : classify m1_0_6 f1 = .outside := rfl
example : detected m1_0_6 f1 = false := rfl
example : deviation m1_0_6 f1 = false := rfl
example : correctable m1_0_6 f1 = true := rfl
example : classify m1_0_6 f2 = .outside := rfl
example : detected m1_0_6 f2 = true := rfl
example : deviation m1_0_6 f2 = false := rfl
example : correctable m1_0_6 f2 = true := rfl
example : allGeneratedCorrectable m1_0_6 = true := rfl
def m1_0_7 : Model := ⟨[n0],[],[r0,r1,r2]⟩
example : classify m1_0_7 f0 = .outside := rfl
example : detected m1_0_7 f0 = true := rfl
example : deviation m1_0_7 f0 = false := rfl
example : correctable m1_0_7 f0 = true := rfl
example : classify m1_0_7 f1 = .outside := rfl
example : detected m1_0_7 f1 = false := rfl
example : deviation m1_0_7 f1 = false := rfl
example : correctable m1_0_7 f1 = true := rfl
example : classify m1_0_7 f2 = .outside := rfl
example : detected m1_0_7 f2 = true := rfl
example : deviation m1_0_7 f2 = false := rfl
example : correctable m1_0_7 f2 = true := rfl
example : allGeneratedCorrectable m1_0_7 = true := rfl
def m1_1_0 : Model := ⟨[n0],[f0],[]⟩
example : classify m1_1_0 f0 = .uncorrectable := rfl
example : detected m1_1_0 f0 = true := rfl
example : deviation m1_1_0 f0 = true := rfl
example : correctable m1_1_0 f0 = false := rfl
example : classify m1_1_0 f1 = .outside := rfl
example : detected m1_1_0 f1 = false := rfl
example : deviation m1_1_0 f1 = false := rfl
example : correctable m1_1_0 f1 = false := rfl
example : classify m1_1_0 f2 = .outside := rfl
example : detected m1_1_0 f2 = true := rfl
example : deviation m1_1_0 f2 = false := rfl
example : correctable m1_1_0 f2 = false := rfl
example : allGeneratedCorrectable m1_1_0 = false := rfl
def m1_1_1 : Model := ⟨[n0],[f0],[r0]⟩
example : classify m1_1_1 f0 = .recoverable [r0] := rfl
example : detected m1_1_1 f0 = true := rfl
example : deviation m1_1_1 f0 = true := rfl
example : correctable m1_1_1 f0 = true := rfl
example : classify m1_1_1 f1 = .outside := rfl
example : detected m1_1_1 f1 = false := rfl
example : deviation m1_1_1 f1 = false := rfl
example : correctable m1_1_1 f1 = false := rfl
example : classify m1_1_1 f2 = .outside := rfl
example : detected m1_1_1 f2 = true := rfl
example : deviation m1_1_1 f2 = false := rfl
example : correctable m1_1_1 f2 = false := rfl
example : allGeneratedCorrectable m1_1_1 = true := rfl
def m1_1_2 : Model := ⟨[n0],[f0],[r1]⟩
example : classify m1_1_2 f0 = .uncorrectable := rfl
example : detected m1_1_2 f0 = true := rfl
example : deviation m1_1_2 f0 = true := rfl
example : correctable m1_1_2 f0 = false := rfl
example : classify m1_1_2 f1 = .outside := rfl
example : detected m1_1_2 f1 = false := rfl
example : deviation m1_1_2 f1 = false := rfl
example : correctable m1_1_2 f1 = true := rfl
example : classify m1_1_2 f2 = .outside := rfl
example : detected m1_1_2 f2 = true := rfl
example : deviation m1_1_2 f2 = false := rfl
example : correctable m1_1_2 f2 = false := rfl
example : allGeneratedCorrectable m1_1_2 = false := rfl
def m1_1_3 : Model := ⟨[n0],[f0],[r0,r1]⟩
example : classify m1_1_3 f0 = .recoverable [r0] := rfl
example : detected m1_1_3 f0 = true := rfl
example : deviation m1_1_3 f0 = true := rfl
example : correctable m1_1_3 f0 = true := rfl
example : classify m1_1_3 f1 = .outside := rfl
example : detected m1_1_3 f1 = false := rfl
example : deviation m1_1_3 f1 = false := rfl
example : correctable m1_1_3 f1 = true := rfl
example : classify m1_1_3 f2 = .outside := rfl
example : detected m1_1_3 f2 = true := rfl
example : deviation m1_1_3 f2 = false := rfl
example : correctable m1_1_3 f2 = false := rfl
example : allGeneratedCorrectable m1_1_3 = true := rfl
def m1_1_4 : Model := ⟨[n0],[f0],[r2]⟩
example : classify m1_1_4 f0 = .uncorrectable := rfl
example : detected m1_1_4 f0 = true := rfl
example : deviation m1_1_4 f0 = true := rfl
example : correctable m1_1_4 f0 = false := rfl
example : classify m1_1_4 f1 = .outside := rfl
example : detected m1_1_4 f1 = false := rfl
example : deviation m1_1_4 f1 = false := rfl
example : correctable m1_1_4 f1 = false := rfl
example : classify m1_1_4 f2 = .outside := rfl
example : detected m1_1_4 f2 = true := rfl
example : deviation m1_1_4 f2 = false := rfl
example : correctable m1_1_4 f2 = true := rfl
example : allGeneratedCorrectable m1_1_4 = false := rfl
def m1_1_5 : Model := ⟨[n0],[f0],[r0,r2]⟩
example : classify m1_1_5 f0 = .recoverable [r0] := rfl
example : detected m1_1_5 f0 = true := rfl
example : deviation m1_1_5 f0 = true := rfl
example : correctable m1_1_5 f0 = true := rfl
example : classify m1_1_5 f1 = .outside := rfl
example : detected m1_1_5 f1 = false := rfl
example : deviation m1_1_5 f1 = false := rfl
example : correctable m1_1_5 f1 = false := rfl
example : classify m1_1_5 f2 = .outside := rfl
example : detected m1_1_5 f2 = true := rfl
example : deviation m1_1_5 f2 = false := rfl
example : correctable m1_1_5 f2 = true := rfl
example : allGeneratedCorrectable m1_1_5 = true := rfl
def m1_1_6 : Model := ⟨[n0],[f0],[r1,r2]⟩
example : classify m1_1_6 f0 = .uncorrectable := rfl
example : detected m1_1_6 f0 = true := rfl
example : deviation m1_1_6 f0 = true := rfl
example : correctable m1_1_6 f0 = false := rfl
example : classify m1_1_6 f1 = .outside := rfl
example : detected m1_1_6 f1 = false := rfl
example : deviation m1_1_6 f1 = false := rfl
example : correctable m1_1_6 f1 = true := rfl
example : classify m1_1_6 f2 = .outside := rfl
example : detected m1_1_6 f2 = true := rfl
example : deviation m1_1_6 f2 = false := rfl
example : correctable m1_1_6 f2 = true := rfl
example : allGeneratedCorrectable m1_1_6 = false := rfl
def m1_1_7 : Model := ⟨[n0],[f0],[r0,r1,r2]⟩
example : classify m1_1_7 f0 = .recoverable [r0] := rfl
example : detected m1_1_7 f0 = true := rfl
example : deviation m1_1_7 f0 = true := rfl
example : correctable m1_1_7 f0 = true := rfl
example : classify m1_1_7 f1 = .outside := rfl
example : detected m1_1_7 f1 = false := rfl
example : deviation m1_1_7 f1 = false := rfl
example : correctable m1_1_7 f1 = true := rfl
example : classify m1_1_7 f2 = .outside := rfl
example : detected m1_1_7 f2 = true := rfl
example : deviation m1_1_7 f2 = false := rfl
example : correctable m1_1_7 f2 = true := rfl
example : allGeneratedCorrectable m1_1_7 = true := rfl
def m1_2_0 : Model := ⟨[n0],[f1],[]⟩
example : classify m1_2_0 f0 = .outside := rfl
example : detected m1_2_0 f0 = true := rfl
example : deviation m1_2_0 f0 = false := rfl
example : correctable m1_2_0 f0 = false := rfl
example : classify m1_2_0 f1 = .uncorrectable := rfl
example : detected m1_2_0 f1 = false := rfl
example : deviation m1_2_0 f1 = true := rfl
example : correctable m1_2_0 f1 = false := rfl
example : classify m1_2_0 f2 = .outside := rfl
example : detected m1_2_0 f2 = true := rfl
example : deviation m1_2_0 f2 = false := rfl
example : correctable m1_2_0 f2 = false := rfl
example : allGeneratedCorrectable m1_2_0 = false := rfl
def m1_2_1 : Model := ⟨[n0],[f1],[r0]⟩
example : classify m1_2_1 f0 = .outside := rfl
example : detected m1_2_1 f0 = true := rfl
example : deviation m1_2_1 f0 = false := rfl
example : correctable m1_2_1 f0 = true := rfl
example : classify m1_2_1 f1 = .uncorrectable := rfl
example : detected m1_2_1 f1 = false := rfl
example : deviation m1_2_1 f1 = true := rfl
example : correctable m1_2_1 f1 = false := rfl
example : classify m1_2_1 f2 = .outside := rfl
example : detected m1_2_1 f2 = true := rfl
example : deviation m1_2_1 f2 = false := rfl
example : correctable m1_2_1 f2 = false := rfl
example : allGeneratedCorrectable m1_2_1 = false := rfl
def m1_2_2 : Model := ⟨[n0],[f1],[r1]⟩
example : classify m1_2_2 f0 = .outside := rfl
example : detected m1_2_2 f0 = true := rfl
example : deviation m1_2_2 f0 = false := rfl
example : correctable m1_2_2 f0 = false := rfl
example : classify m1_2_2 f1 = .recoverable [r1] := rfl
example : detected m1_2_2 f1 = false := rfl
example : deviation m1_2_2 f1 = true := rfl
example : correctable m1_2_2 f1 = true := rfl
example : classify m1_2_2 f2 = .outside := rfl
example : detected m1_2_2 f2 = true := rfl
example : deviation m1_2_2 f2 = false := rfl
example : correctable m1_2_2 f2 = false := rfl
example : allGeneratedCorrectable m1_2_2 = true := rfl
def m1_2_3 : Model := ⟨[n0],[f1],[r0,r1]⟩
example : classify m1_2_3 f0 = .outside := rfl
example : detected m1_2_3 f0 = true := rfl
example : deviation m1_2_3 f0 = false := rfl
example : correctable m1_2_3 f0 = true := rfl
example : classify m1_2_3 f1 = .recoverable [r1] := rfl
example : detected m1_2_3 f1 = false := rfl
example : deviation m1_2_3 f1 = true := rfl
example : correctable m1_2_3 f1 = true := rfl
example : classify m1_2_3 f2 = .outside := rfl
example : detected m1_2_3 f2 = true := rfl
example : deviation m1_2_3 f2 = false := rfl
example : correctable m1_2_3 f2 = false := rfl
example : allGeneratedCorrectable m1_2_3 = true := rfl
def m1_2_4 : Model := ⟨[n0],[f1],[r2]⟩
example : classify m1_2_4 f0 = .outside := rfl
example : detected m1_2_4 f0 = true := rfl
example : deviation m1_2_4 f0 = false := rfl
example : correctable m1_2_4 f0 = false := rfl
example : classify m1_2_4 f1 = .uncorrectable := rfl
example : detected m1_2_4 f1 = false := rfl
example : deviation m1_2_4 f1 = true := rfl
example : correctable m1_2_4 f1 = false := rfl
example : classify m1_2_4 f2 = .outside := rfl
example : detected m1_2_4 f2 = true := rfl
example : deviation m1_2_4 f2 = false := rfl
example : correctable m1_2_4 f2 = true := rfl
example : allGeneratedCorrectable m1_2_4 = false := rfl
def m1_2_5 : Model := ⟨[n0],[f1],[r0,r2]⟩
example : classify m1_2_5 f0 = .outside := rfl
example : detected m1_2_5 f0 = true := rfl
example : deviation m1_2_5 f0 = false := rfl
example : correctable m1_2_5 f0 = true := rfl
example : classify m1_2_5 f1 = .uncorrectable := rfl
example : detected m1_2_5 f1 = false := rfl
example : deviation m1_2_5 f1 = true := rfl
example : correctable m1_2_5 f1 = false := rfl
example : classify m1_2_5 f2 = .outside := rfl
example : detected m1_2_5 f2 = true := rfl
example : deviation m1_2_5 f2 = false := rfl
example : correctable m1_2_5 f2 = true := rfl
example : allGeneratedCorrectable m1_2_5 = false := rfl
def m1_2_6 : Model := ⟨[n0],[f1],[r1,r2]⟩
example : classify m1_2_6 f0 = .outside := rfl
example : detected m1_2_6 f0 = true := rfl
example : deviation m1_2_6 f0 = false := rfl
example : correctable m1_2_6 f0 = false := rfl
example : classify m1_2_6 f1 = .recoverable [r1] := rfl
example : detected m1_2_6 f1 = false := rfl
example : deviation m1_2_6 f1 = true := rfl
example : correctable m1_2_6 f1 = true := rfl
example : classify m1_2_6 f2 = .outside := rfl
example : detected m1_2_6 f2 = true := rfl
example : deviation m1_2_6 f2 = false := rfl
example : correctable m1_2_6 f2 = true := rfl
example : allGeneratedCorrectable m1_2_6 = true := rfl
def m1_2_7 : Model := ⟨[n0],[f1],[r0,r1,r2]⟩
example : classify m1_2_7 f0 = .outside := rfl
example : detected m1_2_7 f0 = true := rfl
example : deviation m1_2_7 f0 = false := rfl
example : correctable m1_2_7 f0 = true := rfl
example : classify m1_2_7 f1 = .recoverable [r1] := rfl
example : detected m1_2_7 f1 = false := rfl
example : deviation m1_2_7 f1 = true := rfl
example : correctable m1_2_7 f1 = true := rfl
example : classify m1_2_7 f2 = .outside := rfl
example : detected m1_2_7 f2 = true := rfl
example : deviation m1_2_7 f2 = false := rfl
example : correctable m1_2_7 f2 = true := rfl
example : allGeneratedCorrectable m1_2_7 = true := rfl
def m1_3_0 : Model := ⟨[n0],[f0,f1],[]⟩
example : classify m1_3_0 f0 = .uncorrectable := rfl
example : detected m1_3_0 f0 = true := rfl
example : deviation m1_3_0 f0 = true := rfl
example : correctable m1_3_0 f0 = false := rfl
example : classify m1_3_0 f1 = .uncorrectable := rfl
example : detected m1_3_0 f1 = false := rfl
example : deviation m1_3_0 f1 = true := rfl
example : correctable m1_3_0 f1 = false := rfl
example : classify m1_3_0 f2 = .outside := rfl
example : detected m1_3_0 f2 = true := rfl
example : deviation m1_3_0 f2 = false := rfl
example : correctable m1_3_0 f2 = false := rfl
example : allGeneratedCorrectable m1_3_0 = false := rfl
def m1_3_1 : Model := ⟨[n0],[f0,f1],[r0]⟩
example : classify m1_3_1 f0 = .recoverable [r0] := rfl
example : detected m1_3_1 f0 = true := rfl
example : deviation m1_3_1 f0 = true := rfl
example : correctable m1_3_1 f0 = true := rfl
example : classify m1_3_1 f1 = .uncorrectable := rfl
example : detected m1_3_1 f1 = false := rfl
example : deviation m1_3_1 f1 = true := rfl
example : correctable m1_3_1 f1 = false := rfl
example : classify m1_3_1 f2 = .outside := rfl
example : detected m1_3_1 f2 = true := rfl
example : deviation m1_3_1 f2 = false := rfl
example : correctable m1_3_1 f2 = false := rfl
example : allGeneratedCorrectable m1_3_1 = false := rfl
def m1_3_2 : Model := ⟨[n0],[f0,f1],[r1]⟩
example : classify m1_3_2 f0 = .uncorrectable := rfl
example : detected m1_3_2 f0 = true := rfl
example : deviation m1_3_2 f0 = true := rfl
example : correctable m1_3_2 f0 = false := rfl
example : classify m1_3_2 f1 = .recoverable [r1] := rfl
example : detected m1_3_2 f1 = false := rfl
example : deviation m1_3_2 f1 = true := rfl
example : correctable m1_3_2 f1 = true := rfl
example : classify m1_3_2 f2 = .outside := rfl
example : detected m1_3_2 f2 = true := rfl
example : deviation m1_3_2 f2 = false := rfl
example : correctable m1_3_2 f2 = false := rfl
example : allGeneratedCorrectable m1_3_2 = false := rfl
def m1_3_3 : Model := ⟨[n0],[f0,f1],[r0,r1]⟩
example : classify m1_3_3 f0 = .recoverable [r0] := rfl
example : detected m1_3_3 f0 = true := rfl
example : deviation m1_3_3 f0 = true := rfl
example : correctable m1_3_3 f0 = true := rfl
example : classify m1_3_3 f1 = .recoverable [r1] := rfl
example : detected m1_3_3 f1 = false := rfl
example : deviation m1_3_3 f1 = true := rfl
example : correctable m1_3_3 f1 = true := rfl
example : classify m1_3_3 f2 = .outside := rfl
example : detected m1_3_3 f2 = true := rfl
example : deviation m1_3_3 f2 = false := rfl
example : correctable m1_3_3 f2 = false := rfl
example : allGeneratedCorrectable m1_3_3 = true := rfl
def m1_3_4 : Model := ⟨[n0],[f0,f1],[r2]⟩
example : classify m1_3_4 f0 = .uncorrectable := rfl
example : detected m1_3_4 f0 = true := rfl
example : deviation m1_3_4 f0 = true := rfl
example : correctable m1_3_4 f0 = false := rfl
example : classify m1_3_4 f1 = .uncorrectable := rfl
example : detected m1_3_4 f1 = false := rfl
example : deviation m1_3_4 f1 = true := rfl
example : correctable m1_3_4 f1 = false := rfl
example : classify m1_3_4 f2 = .outside := rfl
example : detected m1_3_4 f2 = true := rfl
example : deviation m1_3_4 f2 = false := rfl
example : correctable m1_3_4 f2 = true := rfl
example : allGeneratedCorrectable m1_3_4 = false := rfl
def m1_3_5 : Model := ⟨[n0],[f0,f1],[r0,r2]⟩
example : classify m1_3_5 f0 = .recoverable [r0] := rfl
example : detected m1_3_5 f0 = true := rfl
example : deviation m1_3_5 f0 = true := rfl
example : correctable m1_3_5 f0 = true := rfl
example : classify m1_3_5 f1 = .uncorrectable := rfl
example : detected m1_3_5 f1 = false := rfl
example : deviation m1_3_5 f1 = true := rfl
example : correctable m1_3_5 f1 = false := rfl
example : classify m1_3_5 f2 = .outside := rfl
example : detected m1_3_5 f2 = true := rfl
example : deviation m1_3_5 f2 = false := rfl
example : correctable m1_3_5 f2 = true := rfl
example : allGeneratedCorrectable m1_3_5 = false := rfl
def m1_3_6 : Model := ⟨[n0],[f0,f1],[r1,r2]⟩
example : classify m1_3_6 f0 = .uncorrectable := rfl
example : detected m1_3_6 f0 = true := rfl
example : deviation m1_3_6 f0 = true := rfl
example : correctable m1_3_6 f0 = false := rfl
example : classify m1_3_6 f1 = .recoverable [r1] := rfl
example : detected m1_3_6 f1 = false := rfl
example : deviation m1_3_6 f1 = true := rfl
example : correctable m1_3_6 f1 = true := rfl
example : classify m1_3_6 f2 = .outside := rfl
example : detected m1_3_6 f2 = true := rfl
example : deviation m1_3_6 f2 = false := rfl
example : correctable m1_3_6 f2 = true := rfl
example : allGeneratedCorrectable m1_3_6 = false := rfl
def m1_3_7 : Model := ⟨[n0],[f0,f1],[r0,r1,r2]⟩
example : classify m1_3_7 f0 = .recoverable [r0] := rfl
example : detected m1_3_7 f0 = true := rfl
example : deviation m1_3_7 f0 = true := rfl
example : correctable m1_3_7 f0 = true := rfl
example : classify m1_3_7 f1 = .recoverable [r1] := rfl
example : detected m1_3_7 f1 = false := rfl
example : deviation m1_3_7 f1 = true := rfl
example : correctable m1_3_7 f1 = true := rfl
example : classify m1_3_7 f2 = .outside := rfl
example : detected m1_3_7 f2 = true := rfl
example : deviation m1_3_7 f2 = false := rfl
example : correctable m1_3_7 f2 = true := rfl
example : allGeneratedCorrectable m1_3_7 = true := rfl
def m1_4_0 : Model := ⟨[n0],[f2],[]⟩
example : classify m1_4_0 f0 = .outside := rfl
example : detected m1_4_0 f0 = true := rfl
example : deviation m1_4_0 f0 = false := rfl
example : correctable m1_4_0 f0 = false := rfl
example : classify m1_4_0 f1 = .outside := rfl
example : detected m1_4_0 f1 = false := rfl
example : deviation m1_4_0 f1 = false := rfl
example : correctable m1_4_0 f1 = false := rfl
example : classify m1_4_0 f2 = .uncorrectable := rfl
example : detected m1_4_0 f2 = true := rfl
example : deviation m1_4_0 f2 = true := rfl
example : correctable m1_4_0 f2 = false := rfl
example : allGeneratedCorrectable m1_4_0 = false := rfl
def m1_4_1 : Model := ⟨[n0],[f2],[r0]⟩
example : classify m1_4_1 f0 = .outside := rfl
example : detected m1_4_1 f0 = true := rfl
example : deviation m1_4_1 f0 = false := rfl
example : correctable m1_4_1 f0 = true := rfl
example : classify m1_4_1 f1 = .outside := rfl
example : detected m1_4_1 f1 = false := rfl
example : deviation m1_4_1 f1 = false := rfl
example : correctable m1_4_1 f1 = false := rfl
example : classify m1_4_1 f2 = .uncorrectable := rfl
example : detected m1_4_1 f2 = true := rfl
example : deviation m1_4_1 f2 = true := rfl
example : correctable m1_4_1 f2 = false := rfl
example : allGeneratedCorrectable m1_4_1 = false := rfl
def m1_4_2 : Model := ⟨[n0],[f2],[r1]⟩
example : classify m1_4_2 f0 = .outside := rfl
example : detected m1_4_2 f0 = true := rfl
example : deviation m1_4_2 f0 = false := rfl
example : correctable m1_4_2 f0 = false := rfl
example : classify m1_4_2 f1 = .outside := rfl
example : detected m1_4_2 f1 = false := rfl
example : deviation m1_4_2 f1 = false := rfl
example : correctable m1_4_2 f1 = true := rfl
example : classify m1_4_2 f2 = .uncorrectable := rfl
example : detected m1_4_2 f2 = true := rfl
example : deviation m1_4_2 f2 = true := rfl
example : correctable m1_4_2 f2 = false := rfl
example : allGeneratedCorrectable m1_4_2 = false := rfl
def m1_4_3 : Model := ⟨[n0],[f2],[r0,r1]⟩
example : classify m1_4_3 f0 = .outside := rfl
example : detected m1_4_3 f0 = true := rfl
example : deviation m1_4_3 f0 = false := rfl
example : correctable m1_4_3 f0 = true := rfl
example : classify m1_4_3 f1 = .outside := rfl
example : detected m1_4_3 f1 = false := rfl
example : deviation m1_4_3 f1 = false := rfl
example : correctable m1_4_3 f1 = true := rfl
example : classify m1_4_3 f2 = .uncorrectable := rfl
example : detected m1_4_3 f2 = true := rfl
example : deviation m1_4_3 f2 = true := rfl
example : correctable m1_4_3 f2 = false := rfl
example : allGeneratedCorrectable m1_4_3 = false := rfl
def m1_4_4 : Model := ⟨[n0],[f2],[r2]⟩
example : classify m1_4_4 f0 = .outside := rfl
example : detected m1_4_4 f0 = true := rfl
example : deviation m1_4_4 f0 = false := rfl
example : correctable m1_4_4 f0 = false := rfl
example : classify m1_4_4 f1 = .outside := rfl
example : detected m1_4_4 f1 = false := rfl
example : deviation m1_4_4 f1 = false := rfl
example : correctable m1_4_4 f1 = false := rfl
example : classify m1_4_4 f2 = .recoverable [r2] := rfl
example : detected m1_4_4 f2 = true := rfl
example : deviation m1_4_4 f2 = true := rfl
example : correctable m1_4_4 f2 = true := rfl
example : allGeneratedCorrectable m1_4_4 = true := rfl
def m1_4_5 : Model := ⟨[n0],[f2],[r0,r2]⟩
example : classify m1_4_5 f0 = .outside := rfl
example : detected m1_4_5 f0 = true := rfl
example : deviation m1_4_5 f0 = false := rfl
example : correctable m1_4_5 f0 = true := rfl
example : classify m1_4_5 f1 = .outside := rfl
example : detected m1_4_5 f1 = false := rfl
example : deviation m1_4_5 f1 = false := rfl
example : correctable m1_4_5 f1 = false := rfl
example : classify m1_4_5 f2 = .recoverable [r2] := rfl
example : detected m1_4_5 f2 = true := rfl
example : deviation m1_4_5 f2 = true := rfl
example : correctable m1_4_5 f2 = true := rfl
example : allGeneratedCorrectable m1_4_5 = true := rfl
def m1_4_6 : Model := ⟨[n0],[f2],[r1,r2]⟩
example : classify m1_4_6 f0 = .outside := rfl
example : detected m1_4_6 f0 = true := rfl
example : deviation m1_4_6 f0 = false := rfl
example : correctable m1_4_6 f0 = false := rfl
example : classify m1_4_6 f1 = .outside := rfl
example : detected m1_4_6 f1 = false := rfl
example : deviation m1_4_6 f1 = false := rfl
example : correctable m1_4_6 f1 = true := rfl
example : classify m1_4_6 f2 = .recoverable [r2] := rfl
example : detected m1_4_6 f2 = true := rfl
example : deviation m1_4_6 f2 = true := rfl
example : correctable m1_4_6 f2 = true := rfl
example : allGeneratedCorrectable m1_4_6 = true := rfl
def m1_4_7 : Model := ⟨[n0],[f2],[r0,r1,r2]⟩
example : classify m1_4_7 f0 = .outside := rfl
example : detected m1_4_7 f0 = true := rfl
example : deviation m1_4_7 f0 = false := rfl
example : correctable m1_4_7 f0 = true := rfl
example : classify m1_4_7 f1 = .outside := rfl
example : detected m1_4_7 f1 = false := rfl
example : deviation m1_4_7 f1 = false := rfl
example : correctable m1_4_7 f1 = true := rfl
example : classify m1_4_7 f2 = .recoverable [r2] := rfl
example : detected m1_4_7 f2 = true := rfl
example : deviation m1_4_7 f2 = true := rfl
example : correctable m1_4_7 f2 = true := rfl
example : allGeneratedCorrectable m1_4_7 = true := rfl
def m1_5_0 : Model := ⟨[n0],[f0,f2],[]⟩
example : classify m1_5_0 f0 = .uncorrectable := rfl
example : detected m1_5_0 f0 = true := rfl
example : deviation m1_5_0 f0 = true := rfl
example : correctable m1_5_0 f0 = false := rfl
example : classify m1_5_0 f1 = .outside := rfl
example : detected m1_5_0 f1 = false := rfl
example : deviation m1_5_0 f1 = false := rfl
example : correctable m1_5_0 f1 = false := rfl
example : classify m1_5_0 f2 = .uncorrectable := rfl
example : detected m1_5_0 f2 = true := rfl
example : deviation m1_5_0 f2 = true := rfl
example : correctable m1_5_0 f2 = false := rfl
example : allGeneratedCorrectable m1_5_0 = false := rfl
def m1_5_1 : Model := ⟨[n0],[f0,f2],[r0]⟩
example : classify m1_5_1 f0 = .recoverable [r0] := rfl
example : detected m1_5_1 f0 = true := rfl
example : deviation m1_5_1 f0 = true := rfl
example : correctable m1_5_1 f0 = true := rfl
example : classify m1_5_1 f1 = .outside := rfl
example : detected m1_5_1 f1 = false := rfl
example : deviation m1_5_1 f1 = false := rfl
example : correctable m1_5_1 f1 = false := rfl
example : classify m1_5_1 f2 = .uncorrectable := rfl
example : detected m1_5_1 f2 = true := rfl
example : deviation m1_5_1 f2 = true := rfl
example : correctable m1_5_1 f2 = false := rfl
example : allGeneratedCorrectable m1_5_1 = false := rfl
def m1_5_2 : Model := ⟨[n0],[f0,f2],[r1]⟩
example : classify m1_5_2 f0 = .uncorrectable := rfl
example : detected m1_5_2 f0 = true := rfl
example : deviation m1_5_2 f0 = true := rfl
example : correctable m1_5_2 f0 = false := rfl
example : classify m1_5_2 f1 = .outside := rfl
example : detected m1_5_2 f1 = false := rfl
example : deviation m1_5_2 f1 = false := rfl
example : correctable m1_5_2 f1 = true := rfl
example : classify m1_5_2 f2 = .uncorrectable := rfl
example : detected m1_5_2 f2 = true := rfl
example : deviation m1_5_2 f2 = true := rfl
example : correctable m1_5_2 f2 = false := rfl
example : allGeneratedCorrectable m1_5_2 = false := rfl
def m1_5_3 : Model := ⟨[n0],[f0,f2],[r0,r1]⟩
example : classify m1_5_3 f0 = .recoverable [r0] := rfl
example : detected m1_5_3 f0 = true := rfl
example : deviation m1_5_3 f0 = true := rfl
example : correctable m1_5_3 f0 = true := rfl
example : classify m1_5_3 f1 = .outside := rfl
example : detected m1_5_3 f1 = false := rfl
example : deviation m1_5_3 f1 = false := rfl
example : correctable m1_5_3 f1 = true := rfl
example : classify m1_5_3 f2 = .uncorrectable := rfl
example : detected m1_5_3 f2 = true := rfl
example : deviation m1_5_3 f2 = true := rfl
example : correctable m1_5_3 f2 = false := rfl
example : allGeneratedCorrectable m1_5_3 = false := rfl
def m1_5_4 : Model := ⟨[n0],[f0,f2],[r2]⟩
example : classify m1_5_4 f0 = .uncorrectable := rfl
example : detected m1_5_4 f0 = true := rfl
example : deviation m1_5_4 f0 = true := rfl
example : correctable m1_5_4 f0 = false := rfl
example : classify m1_5_4 f1 = .outside := rfl
example : detected m1_5_4 f1 = false := rfl
example : deviation m1_5_4 f1 = false := rfl
example : correctable m1_5_4 f1 = false := rfl
example : classify m1_5_4 f2 = .recoverable [r2] := rfl
example : detected m1_5_4 f2 = true := rfl
example : deviation m1_5_4 f2 = true := rfl
example : correctable m1_5_4 f2 = true := rfl
example : allGeneratedCorrectable m1_5_4 = false := rfl
def m1_5_5 : Model := ⟨[n0],[f0,f2],[r0,r2]⟩
example : classify m1_5_5 f0 = .recoverable [r0] := rfl
example : detected m1_5_5 f0 = true := rfl
example : deviation m1_5_5 f0 = true := rfl
example : correctable m1_5_5 f0 = true := rfl
example : classify m1_5_5 f1 = .outside := rfl
example : detected m1_5_5 f1 = false := rfl
example : deviation m1_5_5 f1 = false := rfl
example : correctable m1_5_5 f1 = false := rfl
example : classify m1_5_5 f2 = .recoverable [r2] := rfl
example : detected m1_5_5 f2 = true := rfl
example : deviation m1_5_5 f2 = true := rfl
example : correctable m1_5_5 f2 = true := rfl
example : allGeneratedCorrectable m1_5_5 = true := rfl
def m1_5_6 : Model := ⟨[n0],[f0,f2],[r1,r2]⟩
example : classify m1_5_6 f0 = .uncorrectable := rfl
example : detected m1_5_6 f0 = true := rfl
example : deviation m1_5_6 f0 = true := rfl
example : correctable m1_5_6 f0 = false := rfl
example : classify m1_5_6 f1 = .outside := rfl
example : detected m1_5_6 f1 = false := rfl
example : deviation m1_5_6 f1 = false := rfl
example : correctable m1_5_6 f1 = true := rfl
example : classify m1_5_6 f2 = .recoverable [r2] := rfl
example : detected m1_5_6 f2 = true := rfl
example : deviation m1_5_6 f2 = true := rfl
example : correctable m1_5_6 f2 = true := rfl
example : allGeneratedCorrectable m1_5_6 = false := rfl
def m1_5_7 : Model := ⟨[n0],[f0,f2],[r0,r1,r2]⟩
example : classify m1_5_7 f0 = .recoverable [r0] := rfl
example : detected m1_5_7 f0 = true := rfl
example : deviation m1_5_7 f0 = true := rfl
example : correctable m1_5_7 f0 = true := rfl
example : classify m1_5_7 f1 = .outside := rfl
example : detected m1_5_7 f1 = false := rfl
example : deviation m1_5_7 f1 = false := rfl
example : correctable m1_5_7 f1 = true := rfl
example : classify m1_5_7 f2 = .recoverable [r2] := rfl
example : detected m1_5_7 f2 = true := rfl
example : deviation m1_5_7 f2 = true := rfl
example : correctable m1_5_7 f2 = true := rfl
example : allGeneratedCorrectable m1_5_7 = true := rfl
def m1_6_0 : Model := ⟨[n0],[f1,f2],[]⟩
example : classify m1_6_0 f0 = .outside := rfl
example : detected m1_6_0 f0 = true := rfl
example : deviation m1_6_0 f0 = false := rfl
example : correctable m1_6_0 f0 = false := rfl
example : classify m1_6_0 f1 = .uncorrectable := rfl
example : detected m1_6_0 f1 = false := rfl
example : deviation m1_6_0 f1 = true := rfl
example : correctable m1_6_0 f1 = false := rfl
example : classify m1_6_0 f2 = .uncorrectable := rfl
example : detected m1_6_0 f2 = true := rfl
example : deviation m1_6_0 f2 = true := rfl
example : correctable m1_6_0 f2 = false := rfl
example : allGeneratedCorrectable m1_6_0 = false := rfl
def m1_6_1 : Model := ⟨[n0],[f1,f2],[r0]⟩
example : classify m1_6_1 f0 = .outside := rfl
example : detected m1_6_1 f0 = true := rfl
example : deviation m1_6_1 f0 = false := rfl
example : correctable m1_6_1 f0 = true := rfl
example : classify m1_6_1 f1 = .uncorrectable := rfl
example : detected m1_6_1 f1 = false := rfl
example : deviation m1_6_1 f1 = true := rfl
example : correctable m1_6_1 f1 = false := rfl
example : classify m1_6_1 f2 = .uncorrectable := rfl
example : detected m1_6_1 f2 = true := rfl
example : deviation m1_6_1 f2 = true := rfl
example : correctable m1_6_1 f2 = false := rfl
example : allGeneratedCorrectable m1_6_1 = false := rfl
def m1_6_2 : Model := ⟨[n0],[f1,f2],[r1]⟩
example : classify m1_6_2 f0 = .outside := rfl
example : detected m1_6_2 f0 = true := rfl
example : deviation m1_6_2 f0 = false := rfl
example : correctable m1_6_2 f0 = false := rfl
example : classify m1_6_2 f1 = .recoverable [r1] := rfl
example : detected m1_6_2 f1 = false := rfl
example : deviation m1_6_2 f1 = true := rfl
example : correctable m1_6_2 f1 = true := rfl
example : classify m1_6_2 f2 = .uncorrectable := rfl
example : detected m1_6_2 f2 = true := rfl
example : deviation m1_6_2 f2 = true := rfl
example : correctable m1_6_2 f2 = false := rfl
example : allGeneratedCorrectable m1_6_2 = false := rfl
def m1_6_3 : Model := ⟨[n0],[f1,f2],[r0,r1]⟩
example : classify m1_6_3 f0 = .outside := rfl
example : detected m1_6_3 f0 = true := rfl
example : deviation m1_6_3 f0 = false := rfl
example : correctable m1_6_3 f0 = true := rfl
example : classify m1_6_3 f1 = .recoverable [r1] := rfl
example : detected m1_6_3 f1 = false := rfl
example : deviation m1_6_3 f1 = true := rfl
example : correctable m1_6_3 f1 = true := rfl
example : classify m1_6_3 f2 = .uncorrectable := rfl
example : detected m1_6_3 f2 = true := rfl
example : deviation m1_6_3 f2 = true := rfl
example : correctable m1_6_3 f2 = false := rfl
example : allGeneratedCorrectable m1_6_3 = false := rfl
def m1_6_4 : Model := ⟨[n0],[f1,f2],[r2]⟩
example : classify m1_6_4 f0 = .outside := rfl
example : detected m1_6_4 f0 = true := rfl
example : deviation m1_6_4 f0 = false := rfl
example : correctable m1_6_4 f0 = false := rfl
example : classify m1_6_4 f1 = .uncorrectable := rfl
example : detected m1_6_4 f1 = false := rfl
example : deviation m1_6_4 f1 = true := rfl
example : correctable m1_6_4 f1 = false := rfl
example : classify m1_6_4 f2 = .recoverable [r2] := rfl
example : detected m1_6_4 f2 = true := rfl
example : deviation m1_6_4 f2 = true := rfl
example : correctable m1_6_4 f2 = true := rfl
example : allGeneratedCorrectable m1_6_4 = false := rfl
def m1_6_5 : Model := ⟨[n0],[f1,f2],[r0,r2]⟩
example : classify m1_6_5 f0 = .outside := rfl
example : detected m1_6_5 f0 = true := rfl
example : deviation m1_6_5 f0 = false := rfl
example : correctable m1_6_5 f0 = true := rfl
example : classify m1_6_5 f1 = .uncorrectable := rfl
example : detected m1_6_5 f1 = false := rfl
example : deviation m1_6_5 f1 = true := rfl
example : correctable m1_6_5 f1 = false := rfl
example : classify m1_6_5 f2 = .recoverable [r2] := rfl
example : detected m1_6_5 f2 = true := rfl
example : deviation m1_6_5 f2 = true := rfl
example : correctable m1_6_5 f2 = true := rfl
example : allGeneratedCorrectable m1_6_5 = false := rfl
def m1_6_6 : Model := ⟨[n0],[f1,f2],[r1,r2]⟩
example : classify m1_6_6 f0 = .outside := rfl
example : detected m1_6_6 f0 = true := rfl
example : deviation m1_6_6 f0 = false := rfl
example : correctable m1_6_6 f0 = false := rfl
example : classify m1_6_6 f1 = .recoverable [r1] := rfl
example : detected m1_6_6 f1 = false := rfl
example : deviation m1_6_6 f1 = true := rfl
example : correctable m1_6_6 f1 = true := rfl
example : classify m1_6_6 f2 = .recoverable [r2] := rfl
example : detected m1_6_6 f2 = true := rfl
example : deviation m1_6_6 f2 = true := rfl
example : correctable m1_6_6 f2 = true := rfl
example : allGeneratedCorrectable m1_6_6 = true := rfl
def m1_6_7 : Model := ⟨[n0],[f1,f2],[r0,r1,r2]⟩
example : classify m1_6_7 f0 = .outside := rfl
example : detected m1_6_7 f0 = true := rfl
example : deviation m1_6_7 f0 = false := rfl
example : correctable m1_6_7 f0 = true := rfl
example : classify m1_6_7 f1 = .recoverable [r1] := rfl
example : detected m1_6_7 f1 = false := rfl
example : deviation m1_6_7 f1 = true := rfl
example : correctable m1_6_7 f1 = true := rfl
example : classify m1_6_7 f2 = .recoverable [r2] := rfl
example : detected m1_6_7 f2 = true := rfl
example : deviation m1_6_7 f2 = true := rfl
example : correctable m1_6_7 f2 = true := rfl
example : allGeneratedCorrectable m1_6_7 = true := rfl
def m1_7_0 : Model := ⟨[n0],[f0,f1,f2],[]⟩
example : classify m1_7_0 f0 = .uncorrectable := rfl
example : detected m1_7_0 f0 = true := rfl
example : deviation m1_7_0 f0 = true := rfl
example : correctable m1_7_0 f0 = false := rfl
example : classify m1_7_0 f1 = .uncorrectable := rfl
example : detected m1_7_0 f1 = false := rfl
example : deviation m1_7_0 f1 = true := rfl
example : correctable m1_7_0 f1 = false := rfl
example : classify m1_7_0 f2 = .uncorrectable := rfl
example : detected m1_7_0 f2 = true := rfl
example : deviation m1_7_0 f2 = true := rfl
example : correctable m1_7_0 f2 = false := rfl
example : allGeneratedCorrectable m1_7_0 = false := rfl
def m1_7_1 : Model := ⟨[n0],[f0,f1,f2],[r0]⟩
example : classify m1_7_1 f0 = .recoverable [r0] := rfl
example : detected m1_7_1 f0 = true := rfl
example : deviation m1_7_1 f0 = true := rfl
example : correctable m1_7_1 f0 = true := rfl
example : classify m1_7_1 f1 = .uncorrectable := rfl
example : detected m1_7_1 f1 = false := rfl
example : deviation m1_7_1 f1 = true := rfl
example : correctable m1_7_1 f1 = false := rfl
example : classify m1_7_1 f2 = .uncorrectable := rfl
example : detected m1_7_1 f2 = true := rfl
example : deviation m1_7_1 f2 = true := rfl
example : correctable m1_7_1 f2 = false := rfl
example : allGeneratedCorrectable m1_7_1 = false := rfl
def m1_7_2 : Model := ⟨[n0],[f0,f1,f2],[r1]⟩
example : classify m1_7_2 f0 = .uncorrectable := rfl
example : detected m1_7_2 f0 = true := rfl
example : deviation m1_7_2 f0 = true := rfl
example : correctable m1_7_2 f0 = false := rfl
example : classify m1_7_2 f1 = .recoverable [r1] := rfl
example : detected m1_7_2 f1 = false := rfl
example : deviation m1_7_2 f1 = true := rfl
example : correctable m1_7_2 f1 = true := rfl
example : classify m1_7_2 f2 = .uncorrectable := rfl
example : detected m1_7_2 f2 = true := rfl
example : deviation m1_7_2 f2 = true := rfl
example : correctable m1_7_2 f2 = false := rfl
example : allGeneratedCorrectable m1_7_2 = false := rfl
def m1_7_3 : Model := ⟨[n0],[f0,f1,f2],[r0,r1]⟩
example : classify m1_7_3 f0 = .recoverable [r0] := rfl
example : detected m1_7_3 f0 = true := rfl
example : deviation m1_7_3 f0 = true := rfl
example : correctable m1_7_3 f0 = true := rfl
example : classify m1_7_3 f1 = .recoverable [r1] := rfl
example : detected m1_7_3 f1 = false := rfl
example : deviation m1_7_3 f1 = true := rfl
example : correctable m1_7_3 f1 = true := rfl
example : classify m1_7_3 f2 = .uncorrectable := rfl
example : detected m1_7_3 f2 = true := rfl
example : deviation m1_7_3 f2 = true := rfl
example : correctable m1_7_3 f2 = false := rfl
example : allGeneratedCorrectable m1_7_3 = false := rfl
def m1_7_4 : Model := ⟨[n0],[f0,f1,f2],[r2]⟩
example : classify m1_7_4 f0 = .uncorrectable := rfl
example : detected m1_7_4 f0 = true := rfl
example : deviation m1_7_4 f0 = true := rfl
example : correctable m1_7_4 f0 = false := rfl
example : classify m1_7_4 f1 = .uncorrectable := rfl
example : detected m1_7_4 f1 = false := rfl
example : deviation m1_7_4 f1 = true := rfl
example : correctable m1_7_4 f1 = false := rfl
example : classify m1_7_4 f2 = .recoverable [r2] := rfl
example : detected m1_7_4 f2 = true := rfl
example : deviation m1_7_4 f2 = true := rfl
example : correctable m1_7_4 f2 = true := rfl
example : allGeneratedCorrectable m1_7_4 = false := rfl
def m1_7_5 : Model := ⟨[n0],[f0,f1,f2],[r0,r2]⟩
example : classify m1_7_5 f0 = .recoverable [r0] := rfl
example : detected m1_7_5 f0 = true := rfl
example : deviation m1_7_5 f0 = true := rfl
example : correctable m1_7_5 f0 = true := rfl
example : classify m1_7_5 f1 = .uncorrectable := rfl
example : detected m1_7_5 f1 = false := rfl
example : deviation m1_7_5 f1 = true := rfl
example : correctable m1_7_5 f1 = false := rfl
example : classify m1_7_5 f2 = .recoverable [r2] := rfl
example : detected m1_7_5 f2 = true := rfl
example : deviation m1_7_5 f2 = true := rfl
example : correctable m1_7_5 f2 = true := rfl
example : allGeneratedCorrectable m1_7_5 = false := rfl
def m1_7_6 : Model := ⟨[n0],[f0,f1,f2],[r1,r2]⟩
example : classify m1_7_6 f0 = .uncorrectable := rfl
example : detected m1_7_6 f0 = true := rfl
example : deviation m1_7_6 f0 = true := rfl
example : correctable m1_7_6 f0 = false := rfl
example : classify m1_7_6 f1 = .recoverable [r1] := rfl
example : detected m1_7_6 f1 = false := rfl
example : deviation m1_7_6 f1 = true := rfl
example : correctable m1_7_6 f1 = true := rfl
example : classify m1_7_6 f2 = .recoverable [r2] := rfl
example : detected m1_7_6 f2 = true := rfl
example : deviation m1_7_6 f2 = true := rfl
example : correctable m1_7_6 f2 = true := rfl
example : allGeneratedCorrectable m1_7_6 = false := rfl
def m1_7_7 : Model := ⟨[n0],[f0,f1,f2],[r0,r1,r2]⟩
example : classify m1_7_7 f0 = .recoverable [r0] := rfl
example : detected m1_7_7 f0 = true := rfl
example : deviation m1_7_7 f0 = true := rfl
example : correctable m1_7_7 f0 = true := rfl
example : classify m1_7_7 f1 = .recoverable [r1] := rfl
example : detected m1_7_7 f1 = false := rfl
example : deviation m1_7_7 f1 = true := rfl
example : correctable m1_7_7 f1 = true := rfl
example : classify m1_7_7 f2 = .recoverable [r2] := rfl
example : detected m1_7_7 f2 = true := rfl
example : deviation m1_7_7 f2 = true := rfl
example : correctable m1_7_7 f2 = true := rfl
example : allGeneratedCorrectable m1_7_7 = true := rfl
def m2_0_0 : Model := ⟨[n1],[],[]⟩
example : classify m2_0_0 f0 = .outside := rfl
example : detected m2_0_0 f0 = false := rfl
example : deviation m2_0_0 f0 = false := rfl
example : correctable m2_0_0 f0 = false := rfl
example : classify m2_0_0 f1 = .outside := rfl
example : detected m2_0_0 f1 = true := rfl
example : deviation m2_0_0 f1 = false := rfl
example : correctable m2_0_0 f1 = false := rfl
example : classify m2_0_0 f2 = .outside := rfl
example : detected m2_0_0 f2 = false := rfl
example : deviation m2_0_0 f2 = false := rfl
example : correctable m2_0_0 f2 = false := rfl
example : allGeneratedCorrectable m2_0_0 = true := rfl
def m2_0_1 : Model := ⟨[n1],[],[r0]⟩
example : classify m2_0_1 f0 = .outside := rfl
example : detected m2_0_1 f0 = false := rfl
example : deviation m2_0_1 f0 = false := rfl
example : correctable m2_0_1 f0 = true := rfl
example : classify m2_0_1 f1 = .outside := rfl
example : detected m2_0_1 f1 = true := rfl
example : deviation m2_0_1 f1 = false := rfl
example : correctable m2_0_1 f1 = false := rfl
example : classify m2_0_1 f2 = .outside := rfl
example : detected m2_0_1 f2 = false := rfl
example : deviation m2_0_1 f2 = false := rfl
example : correctable m2_0_1 f2 = false := rfl
example : allGeneratedCorrectable m2_0_1 = true := rfl
def m2_0_2 : Model := ⟨[n1],[],[r1]⟩
example : classify m2_0_2 f0 = .outside := rfl
example : detected m2_0_2 f0 = false := rfl
example : deviation m2_0_2 f0 = false := rfl
example : correctable m2_0_2 f0 = false := rfl
example : classify m2_0_2 f1 = .outside := rfl
example : detected m2_0_2 f1 = true := rfl
example : deviation m2_0_2 f1 = false := rfl
example : correctable m2_0_2 f1 = true := rfl
example : classify m2_0_2 f2 = .outside := rfl
example : detected m2_0_2 f2 = false := rfl
example : deviation m2_0_2 f2 = false := rfl
example : correctable m2_0_2 f2 = false := rfl
example : allGeneratedCorrectable m2_0_2 = true := rfl
def m2_0_3 : Model := ⟨[n1],[],[r0,r1]⟩
example : classify m2_0_3 f0 = .outside := rfl
example : detected m2_0_3 f0 = false := rfl
example : deviation m2_0_3 f0 = false := rfl
example : correctable m2_0_3 f0 = true := rfl
example : classify m2_0_3 f1 = .outside := rfl
example : detected m2_0_3 f1 = true := rfl
example : deviation m2_0_3 f1 = false := rfl
example : correctable m2_0_3 f1 = true := rfl
example : classify m2_0_3 f2 = .outside := rfl
example : detected m2_0_3 f2 = false := rfl
example : deviation m2_0_3 f2 = false := rfl
example : correctable m2_0_3 f2 = false := rfl
example : allGeneratedCorrectable m2_0_3 = true := rfl
def m2_0_4 : Model := ⟨[n1],[],[r2]⟩
example : classify m2_0_4 f0 = .outside := rfl
example : detected m2_0_4 f0 = false := rfl
example : deviation m2_0_4 f0 = false := rfl
example : correctable m2_0_4 f0 = false := rfl
example : classify m2_0_4 f1 = .outside := rfl
example : detected m2_0_4 f1 = true := rfl
example : deviation m2_0_4 f1 = false := rfl
example : correctable m2_0_4 f1 = false := rfl
example : classify m2_0_4 f2 = .outside := rfl
example : detected m2_0_4 f2 = false := rfl
example : deviation m2_0_4 f2 = false := rfl
example : correctable m2_0_4 f2 = true := rfl
example : allGeneratedCorrectable m2_0_4 = true := rfl
def m2_0_5 : Model := ⟨[n1],[],[r0,r2]⟩
example : classify m2_0_5 f0 = .outside := rfl
example : detected m2_0_5 f0 = false := rfl
example : deviation m2_0_5 f0 = false := rfl
example : correctable m2_0_5 f0 = true := rfl
example : classify m2_0_5 f1 = .outside := rfl
example : detected m2_0_5 f1 = true := rfl
example : deviation m2_0_5 f1 = false := rfl
example : correctable m2_0_5 f1 = false := rfl
example : classify m2_0_5 f2 = .outside := rfl
example : detected m2_0_5 f2 = false := rfl
example : deviation m2_0_5 f2 = false := rfl
example : correctable m2_0_5 f2 = true := rfl
example : allGeneratedCorrectable m2_0_5 = true := rfl
def m2_0_6 : Model := ⟨[n1],[],[r1,r2]⟩
example : classify m2_0_6 f0 = .outside := rfl
example : detected m2_0_6 f0 = false := rfl
example : deviation m2_0_6 f0 = false := rfl
example : correctable m2_0_6 f0 = false := rfl
example : classify m2_0_6 f1 = .outside := rfl
example : detected m2_0_6 f1 = true := rfl
example : deviation m2_0_6 f1 = false := rfl
example : correctable m2_0_6 f1 = true := rfl
example : classify m2_0_6 f2 = .outside := rfl
example : detected m2_0_6 f2 = false := rfl
example : deviation m2_0_6 f2 = false := rfl
example : correctable m2_0_6 f2 = true := rfl
example : allGeneratedCorrectable m2_0_6 = true := rfl
def m2_0_7 : Model := ⟨[n1],[],[r0,r1,r2]⟩
example : classify m2_0_7 f0 = .outside := rfl
example : detected m2_0_7 f0 = false := rfl
example : deviation m2_0_7 f0 = false := rfl
example : correctable m2_0_7 f0 = true := rfl
example : classify m2_0_7 f1 = .outside := rfl
example : detected m2_0_7 f1 = true := rfl
example : deviation m2_0_7 f1 = false := rfl
example : correctable m2_0_7 f1 = true := rfl
example : classify m2_0_7 f2 = .outside := rfl
example : detected m2_0_7 f2 = false := rfl
example : deviation m2_0_7 f2 = false := rfl
example : correctable m2_0_7 f2 = true := rfl
example : allGeneratedCorrectable m2_0_7 = true := rfl
def m2_1_0 : Model := ⟨[n1],[f0],[]⟩
example : classify m2_1_0 f0 = .uncorrectable := rfl
example : detected m2_1_0 f0 = false := rfl
example : deviation m2_1_0 f0 = false := rfl
example : correctable m2_1_0 f0 = false := rfl
example : classify m2_1_0 f1 = .outside := rfl
example : detected m2_1_0 f1 = true := rfl
example : deviation m2_1_0 f1 = false := rfl
example : correctable m2_1_0 f1 = false := rfl
example : classify m2_1_0 f2 = .outside := rfl
example : detected m2_1_0 f2 = false := rfl
example : deviation m2_1_0 f2 = false := rfl
example : correctable m2_1_0 f2 = false := rfl
example : allGeneratedCorrectable m2_1_0 = false := rfl
def m2_1_1 : Model := ⟨[n1],[f0],[r0]⟩
example : classify m2_1_1 f0 = .recoverable [r0] := rfl
example : detected m2_1_1 f0 = false := rfl
example : deviation m2_1_1 f0 = false := rfl
example : correctable m2_1_1 f0 = true := rfl
example : classify m2_1_1 f1 = .outside := rfl
example : detected m2_1_1 f1 = true := rfl
example : deviation m2_1_1 f1 = false := rfl
example : correctable m2_1_1 f1 = false := rfl
example : classify m2_1_1 f2 = .outside := rfl
example : detected m2_1_1 f2 = false := rfl
example : deviation m2_1_1 f2 = false := rfl
example : correctable m2_1_1 f2 = false := rfl
example : allGeneratedCorrectable m2_1_1 = true := rfl
def m2_1_2 : Model := ⟨[n1],[f0],[r1]⟩
example : classify m2_1_2 f0 = .uncorrectable := rfl
example : detected m2_1_2 f0 = false := rfl
example : deviation m2_1_2 f0 = false := rfl
example : correctable m2_1_2 f0 = false := rfl
example : classify m2_1_2 f1 = .outside := rfl
example : detected m2_1_2 f1 = true := rfl
example : deviation m2_1_2 f1 = false := rfl
example : correctable m2_1_2 f1 = true := rfl
example : classify m2_1_2 f2 = .outside := rfl
example : detected m2_1_2 f2 = false := rfl
example : deviation m2_1_2 f2 = false := rfl
example : correctable m2_1_2 f2 = false := rfl
example : allGeneratedCorrectable m2_1_2 = false := rfl
def m2_1_3 : Model := ⟨[n1],[f0],[r0,r1]⟩
example : classify m2_1_3 f0 = .recoverable [r0] := rfl
example : detected m2_1_3 f0 = false := rfl
example : deviation m2_1_3 f0 = false := rfl
example : correctable m2_1_3 f0 = true := rfl
example : classify m2_1_3 f1 = .outside := rfl
example : detected m2_1_3 f1 = true := rfl
example : deviation m2_1_3 f1 = false := rfl
example : correctable m2_1_3 f1 = true := rfl
example : classify m2_1_3 f2 = .outside := rfl
example : detected m2_1_3 f2 = false := rfl
example : deviation m2_1_3 f2 = false := rfl
example : correctable m2_1_3 f2 = false := rfl
example : allGeneratedCorrectable m2_1_3 = true := rfl
def m2_1_4 : Model := ⟨[n1],[f0],[r2]⟩
example : classify m2_1_4 f0 = .uncorrectable := rfl
example : detected m2_1_4 f0 = false := rfl
example : deviation m2_1_4 f0 = false := rfl
example : correctable m2_1_4 f0 = false := rfl
example : classify m2_1_4 f1 = .outside := rfl
example : detected m2_1_4 f1 = true := rfl
example : deviation m2_1_4 f1 = false := rfl
example : correctable m2_1_4 f1 = false := rfl
example : classify m2_1_4 f2 = .outside := rfl
example : detected m2_1_4 f2 = false := rfl
example : deviation m2_1_4 f2 = false := rfl
example : correctable m2_1_4 f2 = true := rfl
example : allGeneratedCorrectable m2_1_4 = false := rfl
def m2_1_5 : Model := ⟨[n1],[f0],[r0,r2]⟩
example : classify m2_1_5 f0 = .recoverable [r0] := rfl
example : detected m2_1_5 f0 = false := rfl
example : deviation m2_1_5 f0 = false := rfl
example : correctable m2_1_5 f0 = true := rfl
example : classify m2_1_5 f1 = .outside := rfl
example : detected m2_1_5 f1 = true := rfl
example : deviation m2_1_5 f1 = false := rfl
example : correctable m2_1_5 f1 = false := rfl
example : classify m2_1_5 f2 = .outside := rfl
example : detected m2_1_5 f2 = false := rfl
example : deviation m2_1_5 f2 = false := rfl
example : correctable m2_1_5 f2 = true := rfl
example : allGeneratedCorrectable m2_1_5 = true := rfl
def m2_1_6 : Model := ⟨[n1],[f0],[r1,r2]⟩
example : classify m2_1_6 f0 = .uncorrectable := rfl
example : detected m2_1_6 f0 = false := rfl
example : deviation m2_1_6 f0 = false := rfl
example : correctable m2_1_6 f0 = false := rfl
example : classify m2_1_6 f1 = .outside := rfl
example : detected m2_1_6 f1 = true := rfl
example : deviation m2_1_6 f1 = false := rfl
example : correctable m2_1_6 f1 = true := rfl
example : classify m2_1_6 f2 = .outside := rfl
example : detected m2_1_6 f2 = false := rfl
example : deviation m2_1_6 f2 = false := rfl
example : correctable m2_1_6 f2 = true := rfl
example : allGeneratedCorrectable m2_1_6 = false := rfl
def m2_1_7 : Model := ⟨[n1],[f0],[r0,r1,r2]⟩
example : classify m2_1_7 f0 = .recoverable [r0] := rfl
example : detected m2_1_7 f0 = false := rfl
example : deviation m2_1_7 f0 = false := rfl
example : correctable m2_1_7 f0 = true := rfl
example : classify m2_1_7 f1 = .outside := rfl
example : detected m2_1_7 f1 = true := rfl
example : deviation m2_1_7 f1 = false := rfl
example : correctable m2_1_7 f1 = true := rfl
example : classify m2_1_7 f2 = .outside := rfl
example : detected m2_1_7 f2 = false := rfl
example : deviation m2_1_7 f2 = false := rfl
example : correctable m2_1_7 f2 = true := rfl
example : allGeneratedCorrectable m2_1_7 = true := rfl
def m2_2_0 : Model := ⟨[n1],[f1],[]⟩
example : classify m2_2_0 f0 = .outside := rfl
example : detected m2_2_0 f0 = false := rfl
example : deviation m2_2_0 f0 = false := rfl
example : correctable m2_2_0 f0 = false := rfl
example : classify m2_2_0 f1 = .uncorrectable := rfl
example : detected m2_2_0 f1 = true := rfl
example : deviation m2_2_0 f1 = true := rfl
example : correctable m2_2_0 f1 = false := rfl
example : classify m2_2_0 f2 = .outside := rfl
example : detected m2_2_0 f2 = false := rfl
example : deviation m2_2_0 f2 = false := rfl
example : correctable m2_2_0 f2 = false := rfl
example : allGeneratedCorrectable m2_2_0 = false := rfl
def m2_2_1 : Model := ⟨[n1],[f1],[r0]⟩
example : classify m2_2_1 f0 = .outside := rfl
example : detected m2_2_1 f0 = false := rfl
example : deviation m2_2_1 f0 = false := rfl
example : correctable m2_2_1 f0 = true := rfl
example : classify m2_2_1 f1 = .uncorrectable := rfl
example : detected m2_2_1 f1 = true := rfl
example : deviation m2_2_1 f1 = true := rfl
example : correctable m2_2_1 f1 = false := rfl
example : classify m2_2_1 f2 = .outside := rfl
example : detected m2_2_1 f2 = false := rfl
example : deviation m2_2_1 f2 = false := rfl
example : correctable m2_2_1 f2 = false := rfl
example : allGeneratedCorrectable m2_2_1 = false := rfl
def m2_2_2 : Model := ⟨[n1],[f1],[r1]⟩
example : classify m2_2_2 f0 = .outside := rfl
example : detected m2_2_2 f0 = false := rfl
example : deviation m2_2_2 f0 = false := rfl
example : correctable m2_2_2 f0 = false := rfl
example : classify m2_2_2 f1 = .recoverable [r1] := rfl
example : detected m2_2_2 f1 = true := rfl
example : deviation m2_2_2 f1 = true := rfl
example : correctable m2_2_2 f1 = true := rfl
example : classify m2_2_2 f2 = .outside := rfl
example : detected m2_2_2 f2 = false := rfl
example : deviation m2_2_2 f2 = false := rfl
example : correctable m2_2_2 f2 = false := rfl
example : allGeneratedCorrectable m2_2_2 = true := rfl
def m2_2_3 : Model := ⟨[n1],[f1],[r0,r1]⟩
example : classify m2_2_3 f0 = .outside := rfl
example : detected m2_2_3 f0 = false := rfl
example : deviation m2_2_3 f0 = false := rfl
example : correctable m2_2_3 f0 = true := rfl
example : classify m2_2_3 f1 = .recoverable [r1] := rfl
example : detected m2_2_3 f1 = true := rfl
example : deviation m2_2_3 f1 = true := rfl
example : correctable m2_2_3 f1 = true := rfl
example : classify m2_2_3 f2 = .outside := rfl
example : detected m2_2_3 f2 = false := rfl
example : deviation m2_2_3 f2 = false := rfl
example : correctable m2_2_3 f2 = false := rfl
example : allGeneratedCorrectable m2_2_3 = true := rfl
def m2_2_4 : Model := ⟨[n1],[f1],[r2]⟩
example : classify m2_2_4 f0 = .outside := rfl
example : detected m2_2_4 f0 = false := rfl
example : deviation m2_2_4 f0 = false := rfl
example : correctable m2_2_4 f0 = false := rfl
example : classify m2_2_4 f1 = .uncorrectable := rfl
example : detected m2_2_4 f1 = true := rfl
example : deviation m2_2_4 f1 = true := rfl
example : correctable m2_2_4 f1 = false := rfl
example : classify m2_2_4 f2 = .outside := rfl
example : detected m2_2_4 f2 = false := rfl
example : deviation m2_2_4 f2 = false := rfl
example : correctable m2_2_4 f2 = true := rfl
example : allGeneratedCorrectable m2_2_4 = false := rfl
def m2_2_5 : Model := ⟨[n1],[f1],[r0,r2]⟩
example : classify m2_2_5 f0 = .outside := rfl
example : detected m2_2_5 f0 = false := rfl
example : deviation m2_2_5 f0 = false := rfl
example : correctable m2_2_5 f0 = true := rfl
example : classify m2_2_5 f1 = .uncorrectable := rfl
example : detected m2_2_5 f1 = true := rfl
example : deviation m2_2_5 f1 = true := rfl
example : correctable m2_2_5 f1 = false := rfl
example : classify m2_2_5 f2 = .outside := rfl
example : detected m2_2_5 f2 = false := rfl
example : deviation m2_2_5 f2 = false := rfl
example : correctable m2_2_5 f2 = true := rfl
example : allGeneratedCorrectable m2_2_5 = false := rfl
def m2_2_6 : Model := ⟨[n1],[f1],[r1,r2]⟩
example : classify m2_2_6 f0 = .outside := rfl
example : detected m2_2_6 f0 = false := rfl
example : deviation m2_2_6 f0 = false := rfl
example : correctable m2_2_6 f0 = false := rfl
example : classify m2_2_6 f1 = .recoverable [r1] := rfl
example : detected m2_2_6 f1 = true := rfl
example : deviation m2_2_6 f1 = true := rfl
example : correctable m2_2_6 f1 = true := rfl
example : classify m2_2_6 f2 = .outside := rfl
example : detected m2_2_6 f2 = false := rfl
example : deviation m2_2_6 f2 = false := rfl
example : correctable m2_2_6 f2 = true := rfl
example : allGeneratedCorrectable m2_2_6 = true := rfl
def m2_2_7 : Model := ⟨[n1],[f1],[r0,r1,r2]⟩
example : classify m2_2_7 f0 = .outside := rfl
example : detected m2_2_7 f0 = false := rfl
example : deviation m2_2_7 f0 = false := rfl
example : correctable m2_2_7 f0 = true := rfl
example : classify m2_2_7 f1 = .recoverable [r1] := rfl
example : detected m2_2_7 f1 = true := rfl
example : deviation m2_2_7 f1 = true := rfl
example : correctable m2_2_7 f1 = true := rfl
example : classify m2_2_7 f2 = .outside := rfl
example : detected m2_2_7 f2 = false := rfl
example : deviation m2_2_7 f2 = false := rfl
example : correctable m2_2_7 f2 = true := rfl
example : allGeneratedCorrectable m2_2_7 = true := rfl
def m2_3_0 : Model := ⟨[n1],[f0,f1],[]⟩
example : classify m2_3_0 f0 = .uncorrectable := rfl
example : detected m2_3_0 f0 = false := rfl
example : deviation m2_3_0 f0 = false := rfl
example : correctable m2_3_0 f0 = false := rfl
example : classify m2_3_0 f1 = .uncorrectable := rfl
example : detected m2_3_0 f1 = true := rfl
example : deviation m2_3_0 f1 = true := rfl
example : correctable m2_3_0 f1 = false := rfl
example : classify m2_3_0 f2 = .outside := rfl
example : detected m2_3_0 f2 = false := rfl
example : deviation m2_3_0 f2 = false := rfl
example : correctable m2_3_0 f2 = false := rfl
example : allGeneratedCorrectable m2_3_0 = false := rfl
def m2_3_1 : Model := ⟨[n1],[f0,f1],[r0]⟩
example : classify m2_3_1 f0 = .recoverable [r0] := rfl
example : detected m2_3_1 f0 = false := rfl
example : deviation m2_3_1 f0 = false := rfl
example : correctable m2_3_1 f0 = true := rfl
example : classify m2_3_1 f1 = .uncorrectable := rfl
example : detected m2_3_1 f1 = true := rfl
example : deviation m2_3_1 f1 = true := rfl
example : correctable m2_3_1 f1 = false := rfl
example : classify m2_3_1 f2 = .outside := rfl
example : detected m2_3_1 f2 = false := rfl
example : deviation m2_3_1 f2 = false := rfl
example : correctable m2_3_1 f2 = false := rfl
example : allGeneratedCorrectable m2_3_1 = false := rfl
def m2_3_2 : Model := ⟨[n1],[f0,f1],[r1]⟩
example : classify m2_3_2 f0 = .uncorrectable := rfl
example : detected m2_3_2 f0 = false := rfl
example : deviation m2_3_2 f0 = false := rfl
example : correctable m2_3_2 f0 = false := rfl
example : classify m2_3_2 f1 = .recoverable [r1] := rfl
example : detected m2_3_2 f1 = true := rfl
example : deviation m2_3_2 f1 = true := rfl
example : correctable m2_3_2 f1 = true := rfl
example : classify m2_3_2 f2 = .outside := rfl
example : detected m2_3_2 f2 = false := rfl
example : deviation m2_3_2 f2 = false := rfl
example : correctable m2_3_2 f2 = false := rfl
example : allGeneratedCorrectable m2_3_2 = false := rfl
def m2_3_3 : Model := ⟨[n1],[f0,f1],[r0,r1]⟩
example : classify m2_3_3 f0 = .recoverable [r0] := rfl
example : detected m2_3_3 f0 = false := rfl
example : deviation m2_3_3 f0 = false := rfl
example : correctable m2_3_3 f0 = true := rfl
example : classify m2_3_3 f1 = .recoverable [r1] := rfl
example : detected m2_3_3 f1 = true := rfl
example : deviation m2_3_3 f1 = true := rfl
example : correctable m2_3_3 f1 = true := rfl
example : classify m2_3_3 f2 = .outside := rfl
example : detected m2_3_3 f2 = false := rfl
example : deviation m2_3_3 f2 = false := rfl
example : correctable m2_3_3 f2 = false := rfl
example : allGeneratedCorrectable m2_3_3 = true := rfl
def m2_3_4 : Model := ⟨[n1],[f0,f1],[r2]⟩
example : classify m2_3_4 f0 = .uncorrectable := rfl
example : detected m2_3_4 f0 = false := rfl
example : deviation m2_3_4 f0 = false := rfl
example : correctable m2_3_4 f0 = false := rfl
example : classify m2_3_4 f1 = .uncorrectable := rfl
example : detected m2_3_4 f1 = true := rfl
example : deviation m2_3_4 f1 = true := rfl
example : correctable m2_3_4 f1 = false := rfl
example : classify m2_3_4 f2 = .outside := rfl
example : detected m2_3_4 f2 = false := rfl
example : deviation m2_3_4 f2 = false := rfl
example : correctable m2_3_4 f2 = true := rfl
example : allGeneratedCorrectable m2_3_4 = false := rfl
def m2_3_5 : Model := ⟨[n1],[f0,f1],[r0,r2]⟩
example : classify m2_3_5 f0 = .recoverable [r0] := rfl
example : detected m2_3_5 f0 = false := rfl
example : deviation m2_3_5 f0 = false := rfl
example : correctable m2_3_5 f0 = true := rfl
example : classify m2_3_5 f1 = .uncorrectable := rfl
example : detected m2_3_5 f1 = true := rfl
example : deviation m2_3_5 f1 = true := rfl
example : correctable m2_3_5 f1 = false := rfl
example : classify m2_3_5 f2 = .outside := rfl
example : detected m2_3_5 f2 = false := rfl
example : deviation m2_3_5 f2 = false := rfl
example : correctable m2_3_5 f2 = true := rfl
example : allGeneratedCorrectable m2_3_5 = false := rfl
def m2_3_6 : Model := ⟨[n1],[f0,f1],[r1,r2]⟩
example : classify m2_3_6 f0 = .uncorrectable := rfl
example : detected m2_3_6 f0 = false := rfl
example : deviation m2_3_6 f0 = false := rfl
example : correctable m2_3_6 f0 = false := rfl
example : classify m2_3_6 f1 = .recoverable [r1] := rfl
example : detected m2_3_6 f1 = true := rfl
example : deviation m2_3_6 f1 = true := rfl
example : correctable m2_3_6 f1 = true := rfl
example : classify m2_3_6 f2 = .outside := rfl
example : detected m2_3_6 f2 = false := rfl
example : deviation m2_3_6 f2 = false := rfl
example : correctable m2_3_6 f2 = true := rfl
example : allGeneratedCorrectable m2_3_6 = false := rfl
def m2_3_7 : Model := ⟨[n1],[f0,f1],[r0,r1,r2]⟩
example : classify m2_3_7 f0 = .recoverable [r0] := rfl
example : detected m2_3_7 f0 = false := rfl
example : deviation m2_3_7 f0 = false := rfl
example : correctable m2_3_7 f0 = true := rfl
example : classify m2_3_7 f1 = .recoverable [r1] := rfl
example : detected m2_3_7 f1 = true := rfl
example : deviation m2_3_7 f1 = true := rfl
example : correctable m2_3_7 f1 = true := rfl
example : classify m2_3_7 f2 = .outside := rfl
example : detected m2_3_7 f2 = false := rfl
example : deviation m2_3_7 f2 = false := rfl
example : correctable m2_3_7 f2 = true := rfl
example : allGeneratedCorrectable m2_3_7 = true := rfl
def m2_4_0 : Model := ⟨[n1],[f2],[]⟩
example : classify m2_4_0 f0 = .outside := rfl
example : detected m2_4_0 f0 = false := rfl
example : deviation m2_4_0 f0 = false := rfl
example : correctable m2_4_0 f0 = false := rfl
example : classify m2_4_0 f1 = .outside := rfl
example : detected m2_4_0 f1 = true := rfl
example : deviation m2_4_0 f1 = false := rfl
example : correctable m2_4_0 f1 = false := rfl
example : classify m2_4_0 f2 = .uncorrectable := rfl
example : detected m2_4_0 f2 = false := rfl
example : deviation m2_4_0 f2 = true := rfl
example : correctable m2_4_0 f2 = false := rfl
example : allGeneratedCorrectable m2_4_0 = false := rfl
def m2_4_1 : Model := ⟨[n1],[f2],[r0]⟩
example : classify m2_4_1 f0 = .outside := rfl
example : detected m2_4_1 f0 = false := rfl
example : deviation m2_4_1 f0 = false := rfl
example : correctable m2_4_1 f0 = true := rfl
example : classify m2_4_1 f1 = .outside := rfl
example : detected m2_4_1 f1 = true := rfl
example : deviation m2_4_1 f1 = false := rfl
example : correctable m2_4_1 f1 = false := rfl
example : classify m2_4_1 f2 = .uncorrectable := rfl
example : detected m2_4_1 f2 = false := rfl
example : deviation m2_4_1 f2 = true := rfl
example : correctable m2_4_1 f2 = false := rfl
example : allGeneratedCorrectable m2_4_1 = false := rfl
def m2_4_2 : Model := ⟨[n1],[f2],[r1]⟩
example : classify m2_4_2 f0 = .outside := rfl
example : detected m2_4_2 f0 = false := rfl
example : deviation m2_4_2 f0 = false := rfl
example : correctable m2_4_2 f0 = false := rfl
example : classify m2_4_2 f1 = .outside := rfl
example : detected m2_4_2 f1 = true := rfl
example : deviation m2_4_2 f1 = false := rfl
example : correctable m2_4_2 f1 = true := rfl
example : classify m2_4_2 f2 = .uncorrectable := rfl
example : detected m2_4_2 f2 = false := rfl
example : deviation m2_4_2 f2 = true := rfl
example : correctable m2_4_2 f2 = false := rfl
example : allGeneratedCorrectable m2_4_2 = false := rfl
def m2_4_3 : Model := ⟨[n1],[f2],[r0,r1]⟩
example : classify m2_4_3 f0 = .outside := rfl
example : detected m2_4_3 f0 = false := rfl
example : deviation m2_4_3 f0 = false := rfl
example : correctable m2_4_3 f0 = true := rfl
example : classify m2_4_3 f1 = .outside := rfl
example : detected m2_4_3 f1 = true := rfl
example : deviation m2_4_3 f1 = false := rfl
example : correctable m2_4_3 f1 = true := rfl
example : classify m2_4_3 f2 = .uncorrectable := rfl
example : detected m2_4_3 f2 = false := rfl
example : deviation m2_4_3 f2 = true := rfl
example : correctable m2_4_3 f2 = false := rfl
example : allGeneratedCorrectable m2_4_3 = false := rfl
def m2_4_4 : Model := ⟨[n1],[f2],[r2]⟩
example : classify m2_4_4 f0 = .outside := rfl
example : detected m2_4_4 f0 = false := rfl
example : deviation m2_4_4 f0 = false := rfl
example : correctable m2_4_4 f0 = false := rfl
example : classify m2_4_4 f1 = .outside := rfl
example : detected m2_4_4 f1 = true := rfl
example : deviation m2_4_4 f1 = false := rfl
example : correctable m2_4_4 f1 = false := rfl
example : classify m2_4_4 f2 = .recoverable [r2] := rfl
example : detected m2_4_4 f2 = false := rfl
example : deviation m2_4_4 f2 = true := rfl
example : correctable m2_4_4 f2 = true := rfl
example : allGeneratedCorrectable m2_4_4 = true := rfl
def m2_4_5 : Model := ⟨[n1],[f2],[r0,r2]⟩
example : classify m2_4_5 f0 = .outside := rfl
example : detected m2_4_5 f0 = false := rfl
example : deviation m2_4_5 f0 = false := rfl
example : correctable m2_4_5 f0 = true := rfl
example : classify m2_4_5 f1 = .outside := rfl
example : detected m2_4_5 f1 = true := rfl
example : deviation m2_4_5 f1 = false := rfl
example : correctable m2_4_5 f1 = false := rfl
example : classify m2_4_5 f2 = .recoverable [r2] := rfl
example : detected m2_4_5 f2 = false := rfl
example : deviation m2_4_5 f2 = true := rfl
example : correctable m2_4_5 f2 = true := rfl
example : allGeneratedCorrectable m2_4_5 = true := rfl
def m2_4_6 : Model := ⟨[n1],[f2],[r1,r2]⟩
example : classify m2_4_6 f0 = .outside := rfl
example : detected m2_4_6 f0 = false := rfl
example : deviation m2_4_6 f0 = false := rfl
example : correctable m2_4_6 f0 = false := rfl
example : classify m2_4_6 f1 = .outside := rfl
example : detected m2_4_6 f1 = true := rfl
example : deviation m2_4_6 f1 = false := rfl
example : correctable m2_4_6 f1 = true := rfl
example : classify m2_4_6 f2 = .recoverable [r2] := rfl
example : detected m2_4_6 f2 = false := rfl
example : deviation m2_4_6 f2 = true := rfl
example : correctable m2_4_6 f2 = true := rfl
example : allGeneratedCorrectable m2_4_6 = true := rfl
def m2_4_7 : Model := ⟨[n1],[f2],[r0,r1,r2]⟩
example : classify m2_4_7 f0 = .outside := rfl
example : detected m2_4_7 f0 = false := rfl
example : deviation m2_4_7 f0 = false := rfl
example : correctable m2_4_7 f0 = true := rfl
example : classify m2_4_7 f1 = .outside := rfl
example : detected m2_4_7 f1 = true := rfl
example : deviation m2_4_7 f1 = false := rfl
example : correctable m2_4_7 f1 = true := rfl
example : classify m2_4_7 f2 = .recoverable [r2] := rfl
example : detected m2_4_7 f2 = false := rfl
example : deviation m2_4_7 f2 = true := rfl
example : correctable m2_4_7 f2 = true := rfl
example : allGeneratedCorrectable m2_4_7 = true := rfl
def m2_5_0 : Model := ⟨[n1],[f0,f2],[]⟩
example : classify m2_5_0 f0 = .uncorrectable := rfl
example : detected m2_5_0 f0 = false := rfl
example : deviation m2_5_0 f0 = false := rfl
example : correctable m2_5_0 f0 = false := rfl
example : classify m2_5_0 f1 = .outside := rfl
example : detected m2_5_0 f1 = true := rfl
example : deviation m2_5_0 f1 = false := rfl
example : correctable m2_5_0 f1 = false := rfl
example : classify m2_5_0 f2 = .uncorrectable := rfl
example : detected m2_5_0 f2 = false := rfl
example : deviation m2_5_0 f2 = true := rfl
example : correctable m2_5_0 f2 = false := rfl
example : allGeneratedCorrectable m2_5_0 = false := rfl
def m2_5_1 : Model := ⟨[n1],[f0,f2],[r0]⟩
example : classify m2_5_1 f0 = .recoverable [r0] := rfl
example : detected m2_5_1 f0 = false := rfl
example : deviation m2_5_1 f0 = false := rfl
example : correctable m2_5_1 f0 = true := rfl
example : classify m2_5_1 f1 = .outside := rfl
example : detected m2_5_1 f1 = true := rfl
example : deviation m2_5_1 f1 = false := rfl
example : correctable m2_5_1 f1 = false := rfl
example : classify m2_5_1 f2 = .uncorrectable := rfl
example : detected m2_5_1 f2 = false := rfl
example : deviation m2_5_1 f2 = true := rfl
example : correctable m2_5_1 f2 = false := rfl
example : allGeneratedCorrectable m2_5_1 = false := rfl
def m2_5_2 : Model := ⟨[n1],[f0,f2],[r1]⟩
example : classify m2_5_2 f0 = .uncorrectable := rfl
example : detected m2_5_2 f0 = false := rfl
example : deviation m2_5_2 f0 = false := rfl
example : correctable m2_5_2 f0 = false := rfl
example : classify m2_5_2 f1 = .outside := rfl
example : detected m2_5_2 f1 = true := rfl
example : deviation m2_5_2 f1 = false := rfl
example : correctable m2_5_2 f1 = true := rfl
example : classify m2_5_2 f2 = .uncorrectable := rfl
example : detected m2_5_2 f2 = false := rfl
example : deviation m2_5_2 f2 = true := rfl
example : correctable m2_5_2 f2 = false := rfl
example : allGeneratedCorrectable m2_5_2 = false := rfl
def m2_5_3 : Model := ⟨[n1],[f0,f2],[r0,r1]⟩
example : classify m2_5_3 f0 = .recoverable [r0] := rfl
example : detected m2_5_3 f0 = false := rfl
example : deviation m2_5_3 f0 = false := rfl
example : correctable m2_5_3 f0 = true := rfl
example : classify m2_5_3 f1 = .outside := rfl
example : detected m2_5_3 f1 = true := rfl
example : deviation m2_5_3 f1 = false := rfl
example : correctable m2_5_3 f1 = true := rfl
example : classify m2_5_3 f2 = .uncorrectable := rfl
example : detected m2_5_3 f2 = false := rfl
example : deviation m2_5_3 f2 = true := rfl
example : correctable m2_5_3 f2 = false := rfl
example : allGeneratedCorrectable m2_5_3 = false := rfl
def m2_5_4 : Model := ⟨[n1],[f0,f2],[r2]⟩
example : classify m2_5_4 f0 = .uncorrectable := rfl
example : detected m2_5_4 f0 = false := rfl
example : deviation m2_5_4 f0 = false := rfl
example : correctable m2_5_4 f0 = false := rfl
example : classify m2_5_4 f1 = .outside := rfl
example : detected m2_5_4 f1 = true := rfl
example : deviation m2_5_4 f1 = false := rfl
example : correctable m2_5_4 f1 = false := rfl
example : classify m2_5_4 f2 = .recoverable [r2] := rfl
example : detected m2_5_4 f2 = false := rfl
example : deviation m2_5_4 f2 = true := rfl
example : correctable m2_5_4 f2 = true := rfl
example : allGeneratedCorrectable m2_5_4 = false := rfl
def m2_5_5 : Model := ⟨[n1],[f0,f2],[r0,r2]⟩
example : classify m2_5_5 f0 = .recoverable [r0] := rfl
example : detected m2_5_5 f0 = false := rfl
example : deviation m2_5_5 f0 = false := rfl
example : correctable m2_5_5 f0 = true := rfl
example : classify m2_5_5 f1 = .outside := rfl
example : detected m2_5_5 f1 = true := rfl
example : deviation m2_5_5 f1 = false := rfl
example : correctable m2_5_5 f1 = false := rfl
example : classify m2_5_5 f2 = .recoverable [r2] := rfl
example : detected m2_5_5 f2 = false := rfl
example : deviation m2_5_5 f2 = true := rfl
example : correctable m2_5_5 f2 = true := rfl
example : allGeneratedCorrectable m2_5_5 = true := rfl
def m2_5_6 : Model := ⟨[n1],[f0,f2],[r1,r2]⟩
example : classify m2_5_6 f0 = .uncorrectable := rfl
example : detected m2_5_6 f0 = false := rfl
example : deviation m2_5_6 f0 = false := rfl
example : correctable m2_5_6 f0 = false := rfl
example : classify m2_5_6 f1 = .outside := rfl
example : detected m2_5_6 f1 = true := rfl
example : deviation m2_5_6 f1 = false := rfl
example : correctable m2_5_6 f1 = true := rfl
example : classify m2_5_6 f2 = .recoverable [r2] := rfl
example : detected m2_5_6 f2 = false := rfl
example : deviation m2_5_6 f2 = true := rfl
example : correctable m2_5_6 f2 = true := rfl
example : allGeneratedCorrectable m2_5_6 = false := rfl
def m2_5_7 : Model := ⟨[n1],[f0,f2],[r0,r1,r2]⟩
example : classify m2_5_7 f0 = .recoverable [r0] := rfl
example : detected m2_5_7 f0 = false := rfl
example : deviation m2_5_7 f0 = false := rfl
example : correctable m2_5_7 f0 = true := rfl
example : classify m2_5_7 f1 = .outside := rfl
example : detected m2_5_7 f1 = true := rfl
example : deviation m2_5_7 f1 = false := rfl
example : correctable m2_5_7 f1 = true := rfl
example : classify m2_5_7 f2 = .recoverable [r2] := rfl
example : detected m2_5_7 f2 = false := rfl
example : deviation m2_5_7 f2 = true := rfl
example : correctable m2_5_7 f2 = true := rfl
example : allGeneratedCorrectable m2_5_7 = true := rfl
def m2_6_0 : Model := ⟨[n1],[f1,f2],[]⟩
example : classify m2_6_0 f0 = .outside := rfl
example : detected m2_6_0 f0 = false := rfl
example : deviation m2_6_0 f0 = false := rfl
example : correctable m2_6_0 f0 = false := rfl
example : classify m2_6_0 f1 = .uncorrectable := rfl
example : detected m2_6_0 f1 = true := rfl
example : deviation m2_6_0 f1 = true := rfl
example : correctable m2_6_0 f1 = false := rfl
example : classify m2_6_0 f2 = .uncorrectable := rfl
example : detected m2_6_0 f2 = false := rfl
example : deviation m2_6_0 f2 = true := rfl
example : correctable m2_6_0 f2 = false := rfl
example : allGeneratedCorrectable m2_6_0 = false := rfl
def m2_6_1 : Model := ⟨[n1],[f1,f2],[r0]⟩
example : classify m2_6_1 f0 = .outside := rfl
example : detected m2_6_1 f0 = false := rfl
example : deviation m2_6_1 f0 = false := rfl
example : correctable m2_6_1 f0 = true := rfl
example : classify m2_6_1 f1 = .uncorrectable := rfl
example : detected m2_6_1 f1 = true := rfl
example : deviation m2_6_1 f1 = true := rfl
example : correctable m2_6_1 f1 = false := rfl
example : classify m2_6_1 f2 = .uncorrectable := rfl
example : detected m2_6_1 f2 = false := rfl
example : deviation m2_6_1 f2 = true := rfl
example : correctable m2_6_1 f2 = false := rfl
example : allGeneratedCorrectable m2_6_1 = false := rfl
def m2_6_2 : Model := ⟨[n1],[f1,f2],[r1]⟩
example : classify m2_6_2 f0 = .outside := rfl
example : detected m2_6_2 f0 = false := rfl
example : deviation m2_6_2 f0 = false := rfl
example : correctable m2_6_2 f0 = false := rfl
example : classify m2_6_2 f1 = .recoverable [r1] := rfl
example : detected m2_6_2 f1 = true := rfl
example : deviation m2_6_2 f1 = true := rfl
example : correctable m2_6_2 f1 = true := rfl
example : classify m2_6_2 f2 = .uncorrectable := rfl
example : detected m2_6_2 f2 = false := rfl
example : deviation m2_6_2 f2 = true := rfl
example : correctable m2_6_2 f2 = false := rfl
example : allGeneratedCorrectable m2_6_2 = false := rfl
def m2_6_3 : Model := ⟨[n1],[f1,f2],[r0,r1]⟩
example : classify m2_6_3 f0 = .outside := rfl
example : detected m2_6_3 f0 = false := rfl
example : deviation m2_6_3 f0 = false := rfl
example : correctable m2_6_3 f0 = true := rfl
example : classify m2_6_3 f1 = .recoverable [r1] := rfl
example : detected m2_6_3 f1 = true := rfl
example : deviation m2_6_3 f1 = true := rfl
example : correctable m2_6_3 f1 = true := rfl
example : classify m2_6_3 f2 = .uncorrectable := rfl
example : detected m2_6_3 f2 = false := rfl
example : deviation m2_6_3 f2 = true := rfl
example : correctable m2_6_3 f2 = false := rfl
example : allGeneratedCorrectable m2_6_3 = false := rfl
def m2_6_4 : Model := ⟨[n1],[f1,f2],[r2]⟩
example : classify m2_6_4 f0 = .outside := rfl
example : detected m2_6_4 f0 = false := rfl
example : deviation m2_6_4 f0 = false := rfl
example : correctable m2_6_4 f0 = false := rfl
example : classify m2_6_4 f1 = .uncorrectable := rfl
example : detected m2_6_4 f1 = true := rfl
example : deviation m2_6_4 f1 = true := rfl
example : correctable m2_6_4 f1 = false := rfl
example : classify m2_6_4 f2 = .recoverable [r2] := rfl
example : detected m2_6_4 f2 = false := rfl
example : deviation m2_6_4 f2 = true := rfl
example : correctable m2_6_4 f2 = true := rfl
example : allGeneratedCorrectable m2_6_4 = false := rfl
def m2_6_5 : Model := ⟨[n1],[f1,f2],[r0,r2]⟩
example : classify m2_6_5 f0 = .outside := rfl
example : detected m2_6_5 f0 = false := rfl
example : deviation m2_6_5 f0 = false := rfl
example : correctable m2_6_5 f0 = true := rfl
example : classify m2_6_5 f1 = .uncorrectable := rfl
example : detected m2_6_5 f1 = true := rfl
example : deviation m2_6_5 f1 = true := rfl
example : correctable m2_6_5 f1 = false := rfl
example : classify m2_6_5 f2 = .recoverable [r2] := rfl
example : detected m2_6_5 f2 = false := rfl
example : deviation m2_6_5 f2 = true := rfl
example : correctable m2_6_5 f2 = true := rfl
example : allGeneratedCorrectable m2_6_5 = false := rfl
def m2_6_6 : Model := ⟨[n1],[f1,f2],[r1,r2]⟩
example : classify m2_6_6 f0 = .outside := rfl
example : detected m2_6_6 f0 = false := rfl
example : deviation m2_6_6 f0 = false := rfl
example : correctable m2_6_6 f0 = false := rfl
example : classify m2_6_6 f1 = .recoverable [r1] := rfl
example : detected m2_6_6 f1 = true := rfl
example : deviation m2_6_6 f1 = true := rfl
example : correctable m2_6_6 f1 = true := rfl
example : classify m2_6_6 f2 = .recoverable [r2] := rfl
example : detected m2_6_6 f2 = false := rfl
example : deviation m2_6_6 f2 = true := rfl
example : correctable m2_6_6 f2 = true := rfl
example : allGeneratedCorrectable m2_6_6 = true := rfl
def m2_6_7 : Model := ⟨[n1],[f1,f2],[r0,r1,r2]⟩
example : classify m2_6_7 f0 = .outside := rfl
example : detected m2_6_7 f0 = false := rfl
example : deviation m2_6_7 f0 = false := rfl
example : correctable m2_6_7 f0 = true := rfl
example : classify m2_6_7 f1 = .recoverable [r1] := rfl
example : detected m2_6_7 f1 = true := rfl
example : deviation m2_6_7 f1 = true := rfl
example : correctable m2_6_7 f1 = true := rfl
example : classify m2_6_7 f2 = .recoverable [r2] := rfl
example : detected m2_6_7 f2 = false := rfl
example : deviation m2_6_7 f2 = true := rfl
example : correctable m2_6_7 f2 = true := rfl
example : allGeneratedCorrectable m2_6_7 = true := rfl
def m2_7_0 : Model := ⟨[n1],[f0,f1,f2],[]⟩
example : classify m2_7_0 f0 = .uncorrectable := rfl
example : detected m2_7_0 f0 = false := rfl
example : deviation m2_7_0 f0 = false := rfl
example : correctable m2_7_0 f0 = false := rfl
example : classify m2_7_0 f1 = .uncorrectable := rfl
example : detected m2_7_0 f1 = true := rfl
example : deviation m2_7_0 f1 = true := rfl
example : correctable m2_7_0 f1 = false := rfl
example : classify m2_7_0 f2 = .uncorrectable := rfl
example : detected m2_7_0 f2 = false := rfl
example : deviation m2_7_0 f2 = true := rfl
example : correctable m2_7_0 f2 = false := rfl
example : allGeneratedCorrectable m2_7_0 = false := rfl
def m2_7_1 : Model := ⟨[n1],[f0,f1,f2],[r0]⟩
example : classify m2_7_1 f0 = .recoverable [r0] := rfl
example : detected m2_7_1 f0 = false := rfl
example : deviation m2_7_1 f0 = false := rfl
example : correctable m2_7_1 f0 = true := rfl
example : classify m2_7_1 f1 = .uncorrectable := rfl
example : detected m2_7_1 f1 = true := rfl
example : deviation m2_7_1 f1 = true := rfl
example : correctable m2_7_1 f1 = false := rfl
example : classify m2_7_1 f2 = .uncorrectable := rfl
example : detected m2_7_1 f2 = false := rfl
example : deviation m2_7_1 f2 = true := rfl
example : correctable m2_7_1 f2 = false := rfl
example : allGeneratedCorrectable m2_7_1 = false := rfl
def m2_7_2 : Model := ⟨[n1],[f0,f1,f2],[r1]⟩
example : classify m2_7_2 f0 = .uncorrectable := rfl
example : detected m2_7_2 f0 = false := rfl
example : deviation m2_7_2 f0 = false := rfl
example : correctable m2_7_2 f0 = false := rfl
example : classify m2_7_2 f1 = .recoverable [r1] := rfl
example : detected m2_7_2 f1 = true := rfl
example : deviation m2_7_2 f1 = true := rfl
example : correctable m2_7_2 f1 = true := rfl
example : classify m2_7_2 f2 = .uncorrectable := rfl
example : detected m2_7_2 f2 = false := rfl
example : deviation m2_7_2 f2 = true := rfl
example : correctable m2_7_2 f2 = false := rfl
example : allGeneratedCorrectable m2_7_2 = false := rfl
def m2_7_3 : Model := ⟨[n1],[f0,f1,f2],[r0,r1]⟩
example : classify m2_7_3 f0 = .recoverable [r0] := rfl
example : detected m2_7_3 f0 = false := rfl
example : deviation m2_7_3 f0 = false := rfl
example : correctable m2_7_3 f0 = true := rfl
example : classify m2_7_3 f1 = .recoverable [r1] := rfl
example : detected m2_7_3 f1 = true := rfl
example : deviation m2_7_3 f1 = true := rfl
example : correctable m2_7_3 f1 = true := rfl
example : classify m2_7_3 f2 = .uncorrectable := rfl
example : detected m2_7_3 f2 = false := rfl
example : deviation m2_7_3 f2 = true := rfl
example : correctable m2_7_3 f2 = false := rfl
example : allGeneratedCorrectable m2_7_3 = false := rfl
def m2_7_4 : Model := ⟨[n1],[f0,f1,f2],[r2]⟩
example : classify m2_7_4 f0 = .uncorrectable := rfl
example : detected m2_7_4 f0 = false := rfl
example : deviation m2_7_4 f0 = false := rfl
example : correctable m2_7_4 f0 = false := rfl
example : classify m2_7_4 f1 = .uncorrectable := rfl
example : detected m2_7_4 f1 = true := rfl
example : deviation m2_7_4 f1 = true := rfl
example : correctable m2_7_4 f1 = false := rfl
example : classify m2_7_4 f2 = .recoverable [r2] := rfl
example : detected m2_7_4 f2 = false := rfl
example : deviation m2_7_4 f2 = true := rfl
example : correctable m2_7_4 f2 = true := rfl
example : allGeneratedCorrectable m2_7_4 = false := rfl
def m2_7_5 : Model := ⟨[n1],[f0,f1,f2],[r0,r2]⟩
example : classify m2_7_5 f0 = .recoverable [r0] := rfl
example : detected m2_7_5 f0 = false := rfl
example : deviation m2_7_5 f0 = false := rfl
example : correctable m2_7_5 f0 = true := rfl
example : classify m2_7_5 f1 = .uncorrectable := rfl
example : detected m2_7_5 f1 = true := rfl
example : deviation m2_7_5 f1 = true := rfl
example : correctable m2_7_5 f1 = false := rfl
example : classify m2_7_5 f2 = .recoverable [r2] := rfl
example : detected m2_7_5 f2 = false := rfl
example : deviation m2_7_5 f2 = true := rfl
example : correctable m2_7_5 f2 = true := rfl
example : allGeneratedCorrectable m2_7_5 = false := rfl
def m2_7_6 : Model := ⟨[n1],[f0,f1,f2],[r1,r2]⟩
example : classify m2_7_6 f0 = .uncorrectable := rfl
example : detected m2_7_6 f0 = false := rfl
example : deviation m2_7_6 f0 = false := rfl
example : correctable m2_7_6 f0 = false := rfl
example : classify m2_7_6 f1 = .recoverable [r1] := rfl
example : detected m2_7_6 f1 = true := rfl
example : deviation m2_7_6 f1 = true := rfl
example : correctable m2_7_6 f1 = true := rfl
example : classify m2_7_6 f2 = .recoverable [r2] := rfl
example : detected m2_7_6 f2 = false := rfl
example : deviation m2_7_6 f2 = true := rfl
example : correctable m2_7_6 f2 = true := rfl
example : allGeneratedCorrectable m2_7_6 = false := rfl
def m2_7_7 : Model := ⟨[n1],[f0,f1,f2],[r0,r1,r2]⟩
example : classify m2_7_7 f0 = .recoverable [r0] := rfl
example : detected m2_7_7 f0 = false := rfl
example : deviation m2_7_7 f0 = false := rfl
example : correctable m2_7_7 f0 = true := rfl
example : classify m2_7_7 f1 = .recoverable [r1] := rfl
example : detected m2_7_7 f1 = true := rfl
example : deviation m2_7_7 f1 = true := rfl
example : correctable m2_7_7 f1 = true := rfl
example : classify m2_7_7 f2 = .recoverable [r2] := rfl
example : detected m2_7_7 f2 = false := rfl
example : deviation m2_7_7 f2 = true := rfl
example : correctable m2_7_7 f2 = true := rfl
example : allGeneratedCorrectable m2_7_7 = true := rfl
def m3_0_0 : Model := ⟨[n0,n1],[],[]⟩
example : classify m3_0_0 f0 = .outside := rfl
example : detected m3_0_0 f0 = false := rfl
example : deviation m3_0_0 f0 = false := rfl
example : correctable m3_0_0 f0 = false := rfl
example : classify m3_0_0 f1 = .outside := rfl
example : detected m3_0_0 f1 = false := rfl
example : deviation m3_0_0 f1 = false := rfl
example : correctable m3_0_0 f1 = false := rfl
example : classify m3_0_0 f2 = .outside := rfl
example : detected m3_0_0 f2 = false := rfl
example : deviation m3_0_0 f2 = false := rfl
example : correctable m3_0_0 f2 = false := rfl
example : allGeneratedCorrectable m3_0_0 = true := rfl
def m3_0_1 : Model := ⟨[n0,n1],[],[r0]⟩
example : classify m3_0_1 f0 = .outside := rfl
example : detected m3_0_1 f0 = false := rfl
example : deviation m3_0_1 f0 = false := rfl
example : correctable m3_0_1 f0 = true := rfl
example : classify m3_0_1 f1 = .outside := rfl
example : detected m3_0_1 f1 = false := rfl
example : deviation m3_0_1 f1 = false := rfl
example : correctable m3_0_1 f1 = false := rfl
example : classify m3_0_1 f2 = .outside := rfl
example : detected m3_0_1 f2 = false := rfl
example : deviation m3_0_1 f2 = false := rfl
example : correctable m3_0_1 f2 = false := rfl
example : allGeneratedCorrectable m3_0_1 = true := rfl
def m3_0_2 : Model := ⟨[n0,n1],[],[r1]⟩
example : classify m3_0_2 f0 = .outside := rfl
example : detected m3_0_2 f0 = false := rfl
example : deviation m3_0_2 f0 = false := rfl
example : correctable m3_0_2 f0 = false := rfl
example : classify m3_0_2 f1 = .outside := rfl
example : detected m3_0_2 f1 = false := rfl
example : deviation m3_0_2 f1 = false := rfl
example : correctable m3_0_2 f1 = true := rfl
example : classify m3_0_2 f2 = .outside := rfl
example : detected m3_0_2 f2 = false := rfl
example : deviation m3_0_2 f2 = false := rfl
example : correctable m3_0_2 f2 = false := rfl
example : allGeneratedCorrectable m3_0_2 = true := rfl
def m3_0_3 : Model := ⟨[n0,n1],[],[r0,r1]⟩
example : classify m3_0_3 f0 = .outside := rfl
example : detected m3_0_3 f0 = false := rfl
example : deviation m3_0_3 f0 = false := rfl
example : correctable m3_0_3 f0 = true := rfl
example : classify m3_0_3 f1 = .outside := rfl
example : detected m3_0_3 f1 = false := rfl
example : deviation m3_0_3 f1 = false := rfl
example : correctable m3_0_3 f1 = true := rfl
example : classify m3_0_3 f2 = .outside := rfl
example : detected m3_0_3 f2 = false := rfl
example : deviation m3_0_3 f2 = false := rfl
example : correctable m3_0_3 f2 = false := rfl
example : allGeneratedCorrectable m3_0_3 = true := rfl
def m3_0_4 : Model := ⟨[n0,n1],[],[r2]⟩
example : classify m3_0_4 f0 = .outside := rfl
example : detected m3_0_4 f0 = false := rfl
example : deviation m3_0_4 f0 = false := rfl
example : correctable m3_0_4 f0 = false := rfl
example : classify m3_0_4 f1 = .outside := rfl
example : detected m3_0_4 f1 = false := rfl
example : deviation m3_0_4 f1 = false := rfl
example : correctable m3_0_4 f1 = false := rfl
example : classify m3_0_4 f2 = .outside := rfl
example : detected m3_0_4 f2 = false := rfl
example : deviation m3_0_4 f2 = false := rfl
example : correctable m3_0_4 f2 = true := rfl
example : allGeneratedCorrectable m3_0_4 = true := rfl
def m3_0_5 : Model := ⟨[n0,n1],[],[r0,r2]⟩
example : classify m3_0_5 f0 = .outside := rfl
example : detected m3_0_5 f0 = false := rfl
example : deviation m3_0_5 f0 = false := rfl
example : correctable m3_0_5 f0 = true := rfl
example : classify m3_0_5 f1 = .outside := rfl
example : detected m3_0_5 f1 = false := rfl
example : deviation m3_0_5 f1 = false := rfl
example : correctable m3_0_5 f1 = false := rfl
example : classify m3_0_5 f2 = .outside := rfl
example : detected m3_0_5 f2 = false := rfl
example : deviation m3_0_5 f2 = false := rfl
example : correctable m3_0_5 f2 = true := rfl
example : allGeneratedCorrectable m3_0_5 = true := rfl
def m3_0_6 : Model := ⟨[n0,n1],[],[r1,r2]⟩
example : classify m3_0_6 f0 = .outside := rfl
example : detected m3_0_6 f0 = false := rfl
example : deviation m3_0_6 f0 = false := rfl
example : correctable m3_0_6 f0 = false := rfl
example : classify m3_0_6 f1 = .outside := rfl
example : detected m3_0_6 f1 = false := rfl
example : deviation m3_0_6 f1 = false := rfl
example : correctable m3_0_6 f1 = true := rfl
example : classify m3_0_6 f2 = .outside := rfl
example : detected m3_0_6 f2 = false := rfl
example : deviation m3_0_6 f2 = false := rfl
example : correctable m3_0_6 f2 = true := rfl
example : allGeneratedCorrectable m3_0_6 = true := rfl
def m3_0_7 : Model := ⟨[n0,n1],[],[r0,r1,r2]⟩
example : classify m3_0_7 f0 = .outside := rfl
example : detected m3_0_7 f0 = false := rfl
example : deviation m3_0_7 f0 = false := rfl
example : correctable m3_0_7 f0 = true := rfl
example : classify m3_0_7 f1 = .outside := rfl
example : detected m3_0_7 f1 = false := rfl
example : deviation m3_0_7 f1 = false := rfl
example : correctable m3_0_7 f1 = true := rfl
example : classify m3_0_7 f2 = .outside := rfl
example : detected m3_0_7 f2 = false := rfl
example : deviation m3_0_7 f2 = false := rfl
example : correctable m3_0_7 f2 = true := rfl
example : allGeneratedCorrectable m3_0_7 = true := rfl
def m3_1_0 : Model := ⟨[n0,n1],[f0],[]⟩
example : classify m3_1_0 f0 = .uncorrectable := rfl
example : detected m3_1_0 f0 = false := rfl
example : deviation m3_1_0 f0 = false := rfl
example : correctable m3_1_0 f0 = false := rfl
example : classify m3_1_0 f1 = .outside := rfl
example : detected m3_1_0 f1 = false := rfl
example : deviation m3_1_0 f1 = false := rfl
example : correctable m3_1_0 f1 = false := rfl
example : classify m3_1_0 f2 = .outside := rfl
example : detected m3_1_0 f2 = false := rfl
example : deviation m3_1_0 f2 = false := rfl
example : correctable m3_1_0 f2 = false := rfl
example : allGeneratedCorrectable m3_1_0 = false := rfl
def m3_1_1 : Model := ⟨[n0,n1],[f0],[r0]⟩
example : classify m3_1_1 f0 = .recoverable [r0] := rfl
example : detected m3_1_1 f0 = false := rfl
example : deviation m3_1_1 f0 = false := rfl
example : correctable m3_1_1 f0 = true := rfl
example : classify m3_1_1 f1 = .outside := rfl
example : detected m3_1_1 f1 = false := rfl
example : deviation m3_1_1 f1 = false := rfl
example : correctable m3_1_1 f1 = false := rfl
example : classify m3_1_1 f2 = .outside := rfl
example : detected m3_1_1 f2 = false := rfl
example : deviation m3_1_1 f2 = false := rfl
example : correctable m3_1_1 f2 = false := rfl
example : allGeneratedCorrectable m3_1_1 = true := rfl
def m3_1_2 : Model := ⟨[n0,n1],[f0],[r1]⟩
example : classify m3_1_2 f0 = .uncorrectable := rfl
example : detected m3_1_2 f0 = false := rfl
example : deviation m3_1_2 f0 = false := rfl
example : correctable m3_1_2 f0 = false := rfl
example : classify m3_1_2 f1 = .outside := rfl
example : detected m3_1_2 f1 = false := rfl
example : deviation m3_1_2 f1 = false := rfl
example : correctable m3_1_2 f1 = true := rfl
example : classify m3_1_2 f2 = .outside := rfl
example : detected m3_1_2 f2 = false := rfl
example : deviation m3_1_2 f2 = false := rfl
example : correctable m3_1_2 f2 = false := rfl
example : allGeneratedCorrectable m3_1_2 = false := rfl
def m3_1_3 : Model := ⟨[n0,n1],[f0],[r0,r1]⟩
example : classify m3_1_3 f0 = .recoverable [r0] := rfl
example : detected m3_1_3 f0 = false := rfl
example : deviation m3_1_3 f0 = false := rfl
example : correctable m3_1_3 f0 = true := rfl
example : classify m3_1_3 f1 = .outside := rfl
example : detected m3_1_3 f1 = false := rfl
example : deviation m3_1_3 f1 = false := rfl
example : correctable m3_1_3 f1 = true := rfl
example : classify m3_1_3 f2 = .outside := rfl
example : detected m3_1_3 f2 = false := rfl
example : deviation m3_1_3 f2 = false := rfl
example : correctable m3_1_3 f2 = false := rfl
example : allGeneratedCorrectable m3_1_3 = true := rfl
def m3_1_4 : Model := ⟨[n0,n1],[f0],[r2]⟩
example : classify m3_1_4 f0 = .uncorrectable := rfl
example : detected m3_1_4 f0 = false := rfl
example : deviation m3_1_4 f0 = false := rfl
example : correctable m3_1_4 f0 = false := rfl
example : classify m3_1_4 f1 = .outside := rfl
example : detected m3_1_4 f1 = false := rfl
example : deviation m3_1_4 f1 = false := rfl
example : correctable m3_1_4 f1 = false := rfl
example : classify m3_1_4 f2 = .outside := rfl
example : detected m3_1_4 f2 = false := rfl
example : deviation m3_1_4 f2 = false := rfl
example : correctable m3_1_4 f2 = true := rfl
example : allGeneratedCorrectable m3_1_4 = false := rfl
def m3_1_5 : Model := ⟨[n0,n1],[f0],[r0,r2]⟩
example : classify m3_1_5 f0 = .recoverable [r0] := rfl
example : detected m3_1_5 f0 = false := rfl
example : deviation m3_1_5 f0 = false := rfl
example : correctable m3_1_5 f0 = true := rfl
example : classify m3_1_5 f1 = .outside := rfl
example : detected m3_1_5 f1 = false := rfl
example : deviation m3_1_5 f1 = false := rfl
example : correctable m3_1_5 f1 = false := rfl
example : classify m3_1_5 f2 = .outside := rfl
example : detected m3_1_5 f2 = false := rfl
example : deviation m3_1_5 f2 = false := rfl
example : correctable m3_1_5 f2 = true := rfl
example : allGeneratedCorrectable m3_1_5 = true := rfl
def m3_1_6 : Model := ⟨[n0,n1],[f0],[r1,r2]⟩
example : classify m3_1_6 f0 = .uncorrectable := rfl
example : detected m3_1_6 f0 = false := rfl
example : deviation m3_1_6 f0 = false := rfl
example : correctable m3_1_6 f0 = false := rfl
example : classify m3_1_6 f1 = .outside := rfl
example : detected m3_1_6 f1 = false := rfl
example : deviation m3_1_6 f1 = false := rfl
example : correctable m3_1_6 f1 = true := rfl
example : classify m3_1_6 f2 = .outside := rfl
example : detected m3_1_6 f2 = false := rfl
example : deviation m3_1_6 f2 = false := rfl
example : correctable m3_1_6 f2 = true := rfl
example : allGeneratedCorrectable m3_1_6 = false := rfl
def m3_1_7 : Model := ⟨[n0,n1],[f0],[r0,r1,r2]⟩
example : classify m3_1_7 f0 = .recoverable [r0] := rfl
example : detected m3_1_7 f0 = false := rfl
example : deviation m3_1_7 f0 = false := rfl
example : correctable m3_1_7 f0 = true := rfl
example : classify m3_1_7 f1 = .outside := rfl
example : detected m3_1_7 f1 = false := rfl
example : deviation m3_1_7 f1 = false := rfl
example : correctable m3_1_7 f1 = true := rfl
example : classify m3_1_7 f2 = .outside := rfl
example : detected m3_1_7 f2 = false := rfl
example : deviation m3_1_7 f2 = false := rfl
example : correctable m3_1_7 f2 = true := rfl
example : allGeneratedCorrectable m3_1_7 = true := rfl
def m3_2_0 : Model := ⟨[n0,n1],[f1],[]⟩
example : classify m3_2_0 f0 = .outside := rfl
example : detected m3_2_0 f0 = false := rfl
example : deviation m3_2_0 f0 = false := rfl
example : correctable m3_2_0 f0 = false := rfl
example : classify m3_2_0 f1 = .uncorrectable := rfl
example : detected m3_2_0 f1 = false := rfl
example : deviation m3_2_0 f1 = true := rfl
example : correctable m3_2_0 f1 = false := rfl
example : classify m3_2_0 f2 = .outside := rfl
example : detected m3_2_0 f2 = false := rfl
example : deviation m3_2_0 f2 = false := rfl
example : correctable m3_2_0 f2 = false := rfl
example : allGeneratedCorrectable m3_2_0 = false := rfl
def m3_2_1 : Model := ⟨[n0,n1],[f1],[r0]⟩
example : classify m3_2_1 f0 = .outside := rfl
example : detected m3_2_1 f0 = false := rfl
example : deviation m3_2_1 f0 = false := rfl
example : correctable m3_2_1 f0 = true := rfl
example : classify m3_2_1 f1 = .uncorrectable := rfl
example : detected m3_2_1 f1 = false := rfl
example : deviation m3_2_1 f1 = true := rfl
example : correctable m3_2_1 f1 = false := rfl
example : classify m3_2_1 f2 = .outside := rfl
example : detected m3_2_1 f2 = false := rfl
example : deviation m3_2_1 f2 = false := rfl
example : correctable m3_2_1 f2 = false := rfl
example : allGeneratedCorrectable m3_2_1 = false := rfl
def m3_2_2 : Model := ⟨[n0,n1],[f1],[r1]⟩
example : classify m3_2_2 f0 = .outside := rfl
example : detected m3_2_2 f0 = false := rfl
example : deviation m3_2_2 f0 = false := rfl
example : correctable m3_2_2 f0 = false := rfl
example : classify m3_2_2 f1 = .recoverable [r1] := rfl
example : detected m3_2_2 f1 = false := rfl
example : deviation m3_2_2 f1 = true := rfl
example : correctable m3_2_2 f1 = true := rfl
example : classify m3_2_2 f2 = .outside := rfl
example : detected m3_2_2 f2 = false := rfl
example : deviation m3_2_2 f2 = false := rfl
example : correctable m3_2_2 f2 = false := rfl
example : allGeneratedCorrectable m3_2_2 = true := rfl
def m3_2_3 : Model := ⟨[n0,n1],[f1],[r0,r1]⟩
example : classify m3_2_3 f0 = .outside := rfl
example : detected m3_2_3 f0 = false := rfl
example : deviation m3_2_3 f0 = false := rfl
example : correctable m3_2_3 f0 = true := rfl
example : classify m3_2_3 f1 = .recoverable [r1] := rfl
example : detected m3_2_3 f1 = false := rfl
example : deviation m3_2_3 f1 = true := rfl
example : correctable m3_2_3 f1 = true := rfl
example : classify m3_2_3 f2 = .outside := rfl
example : detected m3_2_3 f2 = false := rfl
example : deviation m3_2_3 f2 = false := rfl
example : correctable m3_2_3 f2 = false := rfl
example : allGeneratedCorrectable m3_2_3 = true := rfl
def m3_2_4 : Model := ⟨[n0,n1],[f1],[r2]⟩
example : classify m3_2_4 f0 = .outside := rfl
example : detected m3_2_4 f0 = false := rfl
example : deviation m3_2_4 f0 = false := rfl
example : correctable m3_2_4 f0 = false := rfl
example : classify m3_2_4 f1 = .uncorrectable := rfl
example : detected m3_2_4 f1 = false := rfl
example : deviation m3_2_4 f1 = true := rfl
example : correctable m3_2_4 f1 = false := rfl
example : classify m3_2_4 f2 = .outside := rfl
example : detected m3_2_4 f2 = false := rfl
example : deviation m3_2_4 f2 = false := rfl
example : correctable m3_2_4 f2 = true := rfl
example : allGeneratedCorrectable m3_2_4 = false := rfl
def m3_2_5 : Model := ⟨[n0,n1],[f1],[r0,r2]⟩
example : classify m3_2_5 f0 = .outside := rfl
example : detected m3_2_5 f0 = false := rfl
example : deviation m3_2_5 f0 = false := rfl
example : correctable m3_2_5 f0 = true := rfl
example : classify m3_2_5 f1 = .uncorrectable := rfl
example : detected m3_2_5 f1 = false := rfl
example : deviation m3_2_5 f1 = true := rfl
example : correctable m3_2_5 f1 = false := rfl
example : classify m3_2_5 f2 = .outside := rfl
example : detected m3_2_5 f2 = false := rfl
example : deviation m3_2_5 f2 = false := rfl
example : correctable m3_2_5 f2 = true := rfl
example : allGeneratedCorrectable m3_2_5 = false := rfl
def m3_2_6 : Model := ⟨[n0,n1],[f1],[r1,r2]⟩
example : classify m3_2_6 f0 = .outside := rfl
example : detected m3_2_6 f0 = false := rfl
example : deviation m3_2_6 f0 = false := rfl
example : correctable m3_2_6 f0 = false := rfl
example : classify m3_2_6 f1 = .recoverable [r1] := rfl
example : detected m3_2_6 f1 = false := rfl
example : deviation m3_2_6 f1 = true := rfl
example : correctable m3_2_6 f1 = true := rfl
example : classify m3_2_6 f2 = .outside := rfl
example : detected m3_2_6 f2 = false := rfl
example : deviation m3_2_6 f2 = false := rfl
example : correctable m3_2_6 f2 = true := rfl
example : allGeneratedCorrectable m3_2_6 = true := rfl
def m3_2_7 : Model := ⟨[n0,n1],[f1],[r0,r1,r2]⟩
example : classify m3_2_7 f0 = .outside := rfl
example : detected m3_2_7 f0 = false := rfl
example : deviation m3_2_7 f0 = false := rfl
example : correctable m3_2_7 f0 = true := rfl
example : classify m3_2_7 f1 = .recoverable [r1] := rfl
example : detected m3_2_7 f1 = false := rfl
example : deviation m3_2_7 f1 = true := rfl
example : correctable m3_2_7 f1 = true := rfl
example : classify m3_2_7 f2 = .outside := rfl
example : detected m3_2_7 f2 = false := rfl
example : deviation m3_2_7 f2 = false := rfl
example : correctable m3_2_7 f2 = true := rfl
example : allGeneratedCorrectable m3_2_7 = true := rfl
def m3_3_0 : Model := ⟨[n0,n1],[f0,f1],[]⟩
example : classify m3_3_0 f0 = .uncorrectable := rfl
example : detected m3_3_0 f0 = false := rfl
example : deviation m3_3_0 f0 = false := rfl
example : correctable m3_3_0 f0 = false := rfl
example : classify m3_3_0 f1 = .uncorrectable := rfl
example : detected m3_3_0 f1 = false := rfl
example : deviation m3_3_0 f1 = true := rfl
example : correctable m3_3_0 f1 = false := rfl
example : classify m3_3_0 f2 = .outside := rfl
example : detected m3_3_0 f2 = false := rfl
example : deviation m3_3_0 f2 = false := rfl
example : correctable m3_3_0 f2 = false := rfl
example : allGeneratedCorrectable m3_3_0 = false := rfl
def m3_3_1 : Model := ⟨[n0,n1],[f0,f1],[r0]⟩
example : classify m3_3_1 f0 = .recoverable [r0] := rfl
example : detected m3_3_1 f0 = false := rfl
example : deviation m3_3_1 f0 = false := rfl
example : correctable m3_3_1 f0 = true := rfl
example : classify m3_3_1 f1 = .uncorrectable := rfl
example : detected m3_3_1 f1 = false := rfl
example : deviation m3_3_1 f1 = true := rfl
example : correctable m3_3_1 f1 = false := rfl
example : classify m3_3_1 f2 = .outside := rfl
example : detected m3_3_1 f2 = false := rfl
example : deviation m3_3_1 f2 = false := rfl
example : correctable m3_3_1 f2 = false := rfl
example : allGeneratedCorrectable m3_3_1 = false := rfl
def m3_3_2 : Model := ⟨[n0,n1],[f0,f1],[r1]⟩
example : classify m3_3_2 f0 = .uncorrectable := rfl
example : detected m3_3_2 f0 = false := rfl
example : deviation m3_3_2 f0 = false := rfl
example : correctable m3_3_2 f0 = false := rfl
example : classify m3_3_2 f1 = .recoverable [r1] := rfl
example : detected m3_3_2 f1 = false := rfl
example : deviation m3_3_2 f1 = true := rfl
example : correctable m3_3_2 f1 = true := rfl
example : classify m3_3_2 f2 = .outside := rfl
example : detected m3_3_2 f2 = false := rfl
example : deviation m3_3_2 f2 = false := rfl
example : correctable m3_3_2 f2 = false := rfl
example : allGeneratedCorrectable m3_3_2 = false := rfl
def m3_3_3 : Model := ⟨[n0,n1],[f0,f1],[r0,r1]⟩
example : classify m3_3_3 f0 = .recoverable [r0] := rfl
example : detected m3_3_3 f0 = false := rfl
example : deviation m3_3_3 f0 = false := rfl
example : correctable m3_3_3 f0 = true := rfl
example : classify m3_3_3 f1 = .recoverable [r1] := rfl
example : detected m3_3_3 f1 = false := rfl
example : deviation m3_3_3 f1 = true := rfl
example : correctable m3_3_3 f1 = true := rfl
example : classify m3_3_3 f2 = .outside := rfl
example : detected m3_3_3 f2 = false := rfl
example : deviation m3_3_3 f2 = false := rfl
example : correctable m3_3_3 f2 = false := rfl
example : allGeneratedCorrectable m3_3_3 = true := rfl
def m3_3_4 : Model := ⟨[n0,n1],[f0,f1],[r2]⟩
example : classify m3_3_4 f0 = .uncorrectable := rfl
example : detected m3_3_4 f0 = false := rfl
example : deviation m3_3_4 f0 = false := rfl
example : correctable m3_3_4 f0 = false := rfl
example : classify m3_3_4 f1 = .uncorrectable := rfl
example : detected m3_3_4 f1 = false := rfl
example : deviation m3_3_4 f1 = true := rfl
example : correctable m3_3_4 f1 = false := rfl
example : classify m3_3_4 f2 = .outside := rfl
example : detected m3_3_4 f2 = false := rfl
example : deviation m3_3_4 f2 = false := rfl
example : correctable m3_3_4 f2 = true := rfl
example : allGeneratedCorrectable m3_3_4 = false := rfl
def m3_3_5 : Model := ⟨[n0,n1],[f0,f1],[r0,r2]⟩
example : classify m3_3_5 f0 = .recoverable [r0] := rfl
example : detected m3_3_5 f0 = false := rfl
example : deviation m3_3_5 f0 = false := rfl
example : correctable m3_3_5 f0 = true := rfl
example : classify m3_3_5 f1 = .uncorrectable := rfl
example : detected m3_3_5 f1 = false := rfl
example : deviation m3_3_5 f1 = true := rfl
example : correctable m3_3_5 f1 = false := rfl
example : classify m3_3_5 f2 = .outside := rfl
example : detected m3_3_5 f2 = false := rfl
example : deviation m3_3_5 f2 = false := rfl
example : correctable m3_3_5 f2 = true := rfl
example : allGeneratedCorrectable m3_3_5 = false := rfl
def m3_3_6 : Model := ⟨[n0,n1],[f0,f1],[r1,r2]⟩
example : classify m3_3_6 f0 = .uncorrectable := rfl
example : detected m3_3_6 f0 = false := rfl
example : deviation m3_3_6 f0 = false := rfl
example : correctable m3_3_6 f0 = false := rfl
example : classify m3_3_6 f1 = .recoverable [r1] := rfl
example : detected m3_3_6 f1 = false := rfl
example : deviation m3_3_6 f1 = true := rfl
example : correctable m3_3_6 f1 = true := rfl
example : classify m3_3_6 f2 = .outside := rfl
example : detected m3_3_6 f2 = false := rfl
example : deviation m3_3_6 f2 = false := rfl
example : correctable m3_3_6 f2 = true := rfl
example : allGeneratedCorrectable m3_3_6 = false := rfl
def m3_3_7 : Model := ⟨[n0,n1],[f0,f1],[r0,r1,r2]⟩
example : classify m3_3_7 f0 = .recoverable [r0] := rfl
example : detected m3_3_7 f0 = false := rfl
example : deviation m3_3_7 f0 = false := rfl
example : correctable m3_3_7 f0 = true := rfl
example : classify m3_3_7 f1 = .recoverable [r1] := rfl
example : detected m3_3_7 f1 = false := rfl
example : deviation m3_3_7 f1 = true := rfl
example : correctable m3_3_7 f1 = true := rfl
example : classify m3_3_7 f2 = .outside := rfl
example : detected m3_3_7 f2 = false := rfl
example : deviation m3_3_7 f2 = false := rfl
example : correctable m3_3_7 f2 = true := rfl
example : allGeneratedCorrectable m3_3_7 = true := rfl
def m3_4_0 : Model := ⟨[n0,n1],[f2],[]⟩
example : classify m3_4_0 f0 = .outside := rfl
example : detected m3_4_0 f0 = false := rfl
example : deviation m3_4_0 f0 = false := rfl
example : correctable m3_4_0 f0 = false := rfl
example : classify m3_4_0 f1 = .outside := rfl
example : detected m3_4_0 f1 = false := rfl
example : deviation m3_4_0 f1 = false := rfl
example : correctable m3_4_0 f1 = false := rfl
example : classify m3_4_0 f2 = .uncorrectable := rfl
example : detected m3_4_0 f2 = false := rfl
example : deviation m3_4_0 f2 = true := rfl
example : correctable m3_4_0 f2 = false := rfl
example : allGeneratedCorrectable m3_4_0 = false := rfl
def m3_4_1 : Model := ⟨[n0,n1],[f2],[r0]⟩
example : classify m3_4_1 f0 = .outside := rfl
example : detected m3_4_1 f0 = false := rfl
example : deviation m3_4_1 f0 = false := rfl
example : correctable m3_4_1 f0 = true := rfl
example : classify m3_4_1 f1 = .outside := rfl
example : detected m3_4_1 f1 = false := rfl
example : deviation m3_4_1 f1 = false := rfl
example : correctable m3_4_1 f1 = false := rfl
example : classify m3_4_1 f2 = .uncorrectable := rfl
example : detected m3_4_1 f2 = false := rfl
example : deviation m3_4_1 f2 = true := rfl
example : correctable m3_4_1 f2 = false := rfl
example : allGeneratedCorrectable m3_4_1 = false := rfl
def m3_4_2 : Model := ⟨[n0,n1],[f2],[r1]⟩
example : classify m3_4_2 f0 = .outside := rfl
example : detected m3_4_2 f0 = false := rfl
example : deviation m3_4_2 f0 = false := rfl
example : correctable m3_4_2 f0 = false := rfl
example : classify m3_4_2 f1 = .outside := rfl
example : detected m3_4_2 f1 = false := rfl
example : deviation m3_4_2 f1 = false := rfl
example : correctable m3_4_2 f1 = true := rfl
example : classify m3_4_2 f2 = .uncorrectable := rfl
example : detected m3_4_2 f2 = false := rfl
example : deviation m3_4_2 f2 = true := rfl
example : correctable m3_4_2 f2 = false := rfl
example : allGeneratedCorrectable m3_4_2 = false := rfl
def m3_4_3 : Model := ⟨[n0,n1],[f2],[r0,r1]⟩
example : classify m3_4_3 f0 = .outside := rfl
example : detected m3_4_3 f0 = false := rfl
example : deviation m3_4_3 f0 = false := rfl
example : correctable m3_4_3 f0 = true := rfl
example : classify m3_4_3 f1 = .outside := rfl
example : detected m3_4_3 f1 = false := rfl
example : deviation m3_4_3 f1 = false := rfl
example : correctable m3_4_3 f1 = true := rfl
example : classify m3_4_3 f2 = .uncorrectable := rfl
example : detected m3_4_3 f2 = false := rfl
example : deviation m3_4_3 f2 = true := rfl
example : correctable m3_4_3 f2 = false := rfl
example : allGeneratedCorrectable m3_4_3 = false := rfl
def m3_4_4 : Model := ⟨[n0,n1],[f2],[r2]⟩
example : classify m3_4_4 f0 = .outside := rfl
example : detected m3_4_4 f0 = false := rfl
example : deviation m3_4_4 f0 = false := rfl
example : correctable m3_4_4 f0 = false := rfl
example : classify m3_4_4 f1 = .outside := rfl
example : detected m3_4_4 f1 = false := rfl
example : deviation m3_4_4 f1 = false := rfl
example : correctable m3_4_4 f1 = false := rfl
example : classify m3_4_4 f2 = .recoverable [r2] := rfl
example : detected m3_4_4 f2 = false := rfl
example : deviation m3_4_4 f2 = true := rfl
example : correctable m3_4_4 f2 = true := rfl
example : allGeneratedCorrectable m3_4_4 = true := rfl
def m3_4_5 : Model := ⟨[n0,n1],[f2],[r0,r2]⟩
example : classify m3_4_5 f0 = .outside := rfl
example : detected m3_4_5 f0 = false := rfl
example : deviation m3_4_5 f0 = false := rfl
example : correctable m3_4_5 f0 = true := rfl
example : classify m3_4_5 f1 = .outside := rfl
example : detected m3_4_5 f1 = false := rfl
example : deviation m3_4_5 f1 = false := rfl
example : correctable m3_4_5 f1 = false := rfl
example : classify m3_4_5 f2 = .recoverable [r2] := rfl
example : detected m3_4_5 f2 = false := rfl
example : deviation m3_4_5 f2 = true := rfl
example : correctable m3_4_5 f2 = true := rfl
example : allGeneratedCorrectable m3_4_5 = true := rfl
def m3_4_6 : Model := ⟨[n0,n1],[f2],[r1,r2]⟩
example : classify m3_4_6 f0 = .outside := rfl
example : detected m3_4_6 f0 = false := rfl
example : deviation m3_4_6 f0 = false := rfl
example : correctable m3_4_6 f0 = false := rfl
example : classify m3_4_6 f1 = .outside := rfl
example : detected m3_4_6 f1 = false := rfl
example : deviation m3_4_6 f1 = false := rfl
example : correctable m3_4_6 f1 = true := rfl
example : classify m3_4_6 f2 = .recoverable [r2] := rfl
example : detected m3_4_6 f2 = false := rfl
example : deviation m3_4_6 f2 = true := rfl
example : correctable m3_4_6 f2 = true := rfl
example : allGeneratedCorrectable m3_4_6 = true := rfl
def m3_4_7 : Model := ⟨[n0,n1],[f2],[r0,r1,r2]⟩
example : classify m3_4_7 f0 = .outside := rfl
example : detected m3_4_7 f0 = false := rfl
example : deviation m3_4_7 f0 = false := rfl
example : correctable m3_4_7 f0 = true := rfl
example : classify m3_4_7 f1 = .outside := rfl
example : detected m3_4_7 f1 = false := rfl
example : deviation m3_4_7 f1 = false := rfl
example : correctable m3_4_7 f1 = true := rfl
example : classify m3_4_7 f2 = .recoverable [r2] := rfl
example : detected m3_4_7 f2 = false := rfl
example : deviation m3_4_7 f2 = true := rfl
example : correctable m3_4_7 f2 = true := rfl
example : allGeneratedCorrectable m3_4_7 = true := rfl
def m3_5_0 : Model := ⟨[n0,n1],[f0,f2],[]⟩
example : classify m3_5_0 f0 = .uncorrectable := rfl
example : detected m3_5_0 f0 = false := rfl
example : deviation m3_5_0 f0 = false := rfl
example : correctable m3_5_0 f0 = false := rfl
example : classify m3_5_0 f1 = .outside := rfl
example : detected m3_5_0 f1 = false := rfl
example : deviation m3_5_0 f1 = false := rfl
example : correctable m3_5_0 f1 = false := rfl
example : classify m3_5_0 f2 = .uncorrectable := rfl
example : detected m3_5_0 f2 = false := rfl
example : deviation m3_5_0 f2 = true := rfl
example : correctable m3_5_0 f2 = false := rfl
example : allGeneratedCorrectable m3_5_0 = false := rfl
def m3_5_1 : Model := ⟨[n0,n1],[f0,f2],[r0]⟩
example : classify m3_5_1 f0 = .recoverable [r0] := rfl
example : detected m3_5_1 f0 = false := rfl
example : deviation m3_5_1 f0 = false := rfl
example : correctable m3_5_1 f0 = true := rfl
example : classify m3_5_1 f1 = .outside := rfl
example : detected m3_5_1 f1 = false := rfl
example : deviation m3_5_1 f1 = false := rfl
example : correctable m3_5_1 f1 = false := rfl
example : classify m3_5_1 f2 = .uncorrectable := rfl
example : detected m3_5_1 f2 = false := rfl
example : deviation m3_5_1 f2 = true := rfl
example : correctable m3_5_1 f2 = false := rfl
example : allGeneratedCorrectable m3_5_1 = false := rfl
def m3_5_2 : Model := ⟨[n0,n1],[f0,f2],[r1]⟩
example : classify m3_5_2 f0 = .uncorrectable := rfl
example : detected m3_5_2 f0 = false := rfl
example : deviation m3_5_2 f0 = false := rfl
example : correctable m3_5_2 f0 = false := rfl
example : classify m3_5_2 f1 = .outside := rfl
example : detected m3_5_2 f1 = false := rfl
example : deviation m3_5_2 f1 = false := rfl
example : correctable m3_5_2 f1 = true := rfl
example : classify m3_5_2 f2 = .uncorrectable := rfl
example : detected m3_5_2 f2 = false := rfl
example : deviation m3_5_2 f2 = true := rfl
example : correctable m3_5_2 f2 = false := rfl
example : allGeneratedCorrectable m3_5_2 = false := rfl
def m3_5_3 : Model := ⟨[n0,n1],[f0,f2],[r0,r1]⟩
example : classify m3_5_3 f0 = .recoverable [r0] := rfl
example : detected m3_5_3 f0 = false := rfl
example : deviation m3_5_3 f0 = false := rfl
example : correctable m3_5_3 f0 = true := rfl
example : classify m3_5_3 f1 = .outside := rfl
example : detected m3_5_3 f1 = false := rfl
example : deviation m3_5_3 f1 = false := rfl
example : correctable m3_5_3 f1 = true := rfl
example : classify m3_5_3 f2 = .uncorrectable := rfl
example : detected m3_5_3 f2 = false := rfl
example : deviation m3_5_3 f2 = true := rfl
example : correctable m3_5_3 f2 = false := rfl
example : allGeneratedCorrectable m3_5_3 = false := rfl
def m3_5_4 : Model := ⟨[n0,n1],[f0,f2],[r2]⟩
example : classify m3_5_4 f0 = .uncorrectable := rfl
example : detected m3_5_4 f0 = false := rfl
example : deviation m3_5_4 f0 = false := rfl
example : correctable m3_5_4 f0 = false := rfl
example : classify m3_5_4 f1 = .outside := rfl
example : detected m3_5_4 f1 = false := rfl
example : deviation m3_5_4 f1 = false := rfl
example : correctable m3_5_4 f1 = false := rfl
example : classify m3_5_4 f2 = .recoverable [r2] := rfl
example : detected m3_5_4 f2 = false := rfl
example : deviation m3_5_4 f2 = true := rfl
example : correctable m3_5_4 f2 = true := rfl
example : allGeneratedCorrectable m3_5_4 = false := rfl
def m3_5_5 : Model := ⟨[n0,n1],[f0,f2],[r0,r2]⟩
example : classify m3_5_5 f0 = .recoverable [r0] := rfl
example : detected m3_5_5 f0 = false := rfl
example : deviation m3_5_5 f0 = false := rfl
example : correctable m3_5_5 f0 = true := rfl
example : classify m3_5_5 f1 = .outside := rfl
example : detected m3_5_5 f1 = false := rfl
example : deviation m3_5_5 f1 = false := rfl
example : correctable m3_5_5 f1 = false := rfl
example : classify m3_5_5 f2 = .recoverable [r2] := rfl
example : detected m3_5_5 f2 = false := rfl
example : deviation m3_5_5 f2 = true := rfl
example : correctable m3_5_5 f2 = true := rfl
example : allGeneratedCorrectable m3_5_5 = true := rfl
def m3_5_6 : Model := ⟨[n0,n1],[f0,f2],[r1,r2]⟩
example : classify m3_5_6 f0 = .uncorrectable := rfl
example : detected m3_5_6 f0 = false := rfl
example : deviation m3_5_6 f0 = false := rfl
example : correctable m3_5_6 f0 = false := rfl
example : classify m3_5_6 f1 = .outside := rfl
example : detected m3_5_6 f1 = false := rfl
example : deviation m3_5_6 f1 = false := rfl
example : correctable m3_5_6 f1 = true := rfl
example : classify m3_5_6 f2 = .recoverable [r2] := rfl
example : detected m3_5_6 f2 = false := rfl
example : deviation m3_5_6 f2 = true := rfl
example : correctable m3_5_6 f2 = true := rfl
example : allGeneratedCorrectable m3_5_6 = false := rfl
def m3_5_7 : Model := ⟨[n0,n1],[f0,f2],[r0,r1,r2]⟩
example : classify m3_5_7 f0 = .recoverable [r0] := rfl
example : detected m3_5_7 f0 = false := rfl
example : deviation m3_5_7 f0 = false := rfl
example : correctable m3_5_7 f0 = true := rfl
example : classify m3_5_7 f1 = .outside := rfl
example : detected m3_5_7 f1 = false := rfl
example : deviation m3_5_7 f1 = false := rfl
example : correctable m3_5_7 f1 = true := rfl
example : classify m3_5_7 f2 = .recoverable [r2] := rfl
example : detected m3_5_7 f2 = false := rfl
example : deviation m3_5_7 f2 = true := rfl
example : correctable m3_5_7 f2 = true := rfl
example : allGeneratedCorrectable m3_5_7 = true := rfl
def m3_6_0 : Model := ⟨[n0,n1],[f1,f2],[]⟩
example : classify m3_6_0 f0 = .outside := rfl
example : detected m3_6_0 f0 = false := rfl
example : deviation m3_6_0 f0 = false := rfl
example : correctable m3_6_0 f0 = false := rfl
example : classify m3_6_0 f1 = .uncorrectable := rfl
example : detected m3_6_0 f1 = false := rfl
example : deviation m3_6_0 f1 = true := rfl
example : correctable m3_6_0 f1 = false := rfl
example : classify m3_6_0 f2 = .uncorrectable := rfl
example : detected m3_6_0 f2 = false := rfl
example : deviation m3_6_0 f2 = true := rfl
example : correctable m3_6_0 f2 = false := rfl
example : allGeneratedCorrectable m3_6_0 = false := rfl
def m3_6_1 : Model := ⟨[n0,n1],[f1,f2],[r0]⟩
example : classify m3_6_1 f0 = .outside := rfl
example : detected m3_6_1 f0 = false := rfl
example : deviation m3_6_1 f0 = false := rfl
example : correctable m3_6_1 f0 = true := rfl
example : classify m3_6_1 f1 = .uncorrectable := rfl
example : detected m3_6_1 f1 = false := rfl
example : deviation m3_6_1 f1 = true := rfl
example : correctable m3_6_1 f1 = false := rfl
example : classify m3_6_1 f2 = .uncorrectable := rfl
example : detected m3_6_1 f2 = false := rfl
example : deviation m3_6_1 f2 = true := rfl
example : correctable m3_6_1 f2 = false := rfl
example : allGeneratedCorrectable m3_6_1 = false := rfl
def m3_6_2 : Model := ⟨[n0,n1],[f1,f2],[r1]⟩
example : classify m3_6_2 f0 = .outside := rfl
example : detected m3_6_2 f0 = false := rfl
example : deviation m3_6_2 f0 = false := rfl
example : correctable m3_6_2 f0 = false := rfl
example : classify m3_6_2 f1 = .recoverable [r1] := rfl
example : detected m3_6_2 f1 = false := rfl
example : deviation m3_6_2 f1 = true := rfl
example : correctable m3_6_2 f1 = true := rfl
example : classify m3_6_2 f2 = .uncorrectable := rfl
example : detected m3_6_2 f2 = false := rfl
example : deviation m3_6_2 f2 = true := rfl
example : correctable m3_6_2 f2 = false := rfl
example : allGeneratedCorrectable m3_6_2 = false := rfl
def m3_6_3 : Model := ⟨[n0,n1],[f1,f2],[r0,r1]⟩
example : classify m3_6_3 f0 = .outside := rfl
example : detected m3_6_3 f0 = false := rfl
example : deviation m3_6_3 f0 = false := rfl
example : correctable m3_6_3 f0 = true := rfl
example : classify m3_6_3 f1 = .recoverable [r1] := rfl
example : detected m3_6_3 f1 = false := rfl
example : deviation m3_6_3 f1 = true := rfl
example : correctable m3_6_3 f1 = true := rfl
example : classify m3_6_3 f2 = .uncorrectable := rfl
example : detected m3_6_3 f2 = false := rfl
example : deviation m3_6_3 f2 = true := rfl
example : correctable m3_6_3 f2 = false := rfl
example : allGeneratedCorrectable m3_6_3 = false := rfl
def m3_6_4 : Model := ⟨[n0,n1],[f1,f2],[r2]⟩
example : classify m3_6_4 f0 = .outside := rfl
example : detected m3_6_4 f0 = false := rfl
example : deviation m3_6_4 f0 = false := rfl
example : correctable m3_6_4 f0 = false := rfl
example : classify m3_6_4 f1 = .uncorrectable := rfl
example : detected m3_6_4 f1 = false := rfl
example : deviation m3_6_4 f1 = true := rfl
example : correctable m3_6_4 f1 = false := rfl
example : classify m3_6_4 f2 = .recoverable [r2] := rfl
example : detected m3_6_4 f2 = false := rfl
example : deviation m3_6_4 f2 = true := rfl
example : correctable m3_6_4 f2 = true := rfl
example : allGeneratedCorrectable m3_6_4 = false := rfl
def m3_6_5 : Model := ⟨[n0,n1],[f1,f2],[r0,r2]⟩
example : classify m3_6_5 f0 = .outside := rfl
example : detected m3_6_5 f0 = false := rfl
example : deviation m3_6_5 f0 = false := rfl
example : correctable m3_6_5 f0 = true := rfl
example : classify m3_6_5 f1 = .uncorrectable := rfl
example : detected m3_6_5 f1 = false := rfl
example : deviation m3_6_5 f1 = true := rfl
example : correctable m3_6_5 f1 = false := rfl
example : classify m3_6_5 f2 = .recoverable [r2] := rfl
example : detected m3_6_5 f2 = false := rfl
example : deviation m3_6_5 f2 = true := rfl
example : correctable m3_6_5 f2 = true := rfl
example : allGeneratedCorrectable m3_6_5 = false := rfl
def m3_6_6 : Model := ⟨[n0,n1],[f1,f2],[r1,r2]⟩
example : classify m3_6_6 f0 = .outside := rfl
example : detected m3_6_6 f0 = false := rfl
example : deviation m3_6_6 f0 = false := rfl
example : correctable m3_6_6 f0 = false := rfl
example : classify m3_6_6 f1 = .recoverable [r1] := rfl
example : detected m3_6_6 f1 = false := rfl
example : deviation m3_6_6 f1 = true := rfl
example : correctable m3_6_6 f1 = true := rfl
example : classify m3_6_6 f2 = .recoverable [r2] := rfl
example : detected m3_6_6 f2 = false := rfl
example : deviation m3_6_6 f2 = true := rfl
example : correctable m3_6_6 f2 = true := rfl
example : allGeneratedCorrectable m3_6_6 = true := rfl
def m3_6_7 : Model := ⟨[n0,n1],[f1,f2],[r0,r1,r2]⟩
example : classify m3_6_7 f0 = .outside := rfl
example : detected m3_6_7 f0 = false := rfl
example : deviation m3_6_7 f0 = false := rfl
example : correctable m3_6_7 f0 = true := rfl
example : classify m3_6_7 f1 = .recoverable [r1] := rfl
example : detected m3_6_7 f1 = false := rfl
example : deviation m3_6_7 f1 = true := rfl
example : correctable m3_6_7 f1 = true := rfl
example : classify m3_6_7 f2 = .recoverable [r2] := rfl
example : detected m3_6_7 f2 = false := rfl
example : deviation m3_6_7 f2 = true := rfl
example : correctable m3_6_7 f2 = true := rfl
example : allGeneratedCorrectable m3_6_7 = true := rfl
def m3_7_0 : Model := ⟨[n0,n1],[f0,f1,f2],[]⟩
example : classify m3_7_0 f0 = .uncorrectable := rfl
example : detected m3_7_0 f0 = false := rfl
example : deviation m3_7_0 f0 = false := rfl
example : correctable m3_7_0 f0 = false := rfl
example : classify m3_7_0 f1 = .uncorrectable := rfl
example : detected m3_7_0 f1 = false := rfl
example : deviation m3_7_0 f1 = true := rfl
example : correctable m3_7_0 f1 = false := rfl
example : classify m3_7_0 f2 = .uncorrectable := rfl
example : detected m3_7_0 f2 = false := rfl
example : deviation m3_7_0 f2 = true := rfl
example : correctable m3_7_0 f2 = false := rfl
example : allGeneratedCorrectable m3_7_0 = false := rfl
def m3_7_1 : Model := ⟨[n0,n1],[f0,f1,f2],[r0]⟩
example : classify m3_7_1 f0 = .recoverable [r0] := rfl
example : detected m3_7_1 f0 = false := rfl
example : deviation m3_7_1 f0 = false := rfl
example : correctable m3_7_1 f0 = true := rfl
example : classify m3_7_1 f1 = .uncorrectable := rfl
example : detected m3_7_1 f1 = false := rfl
example : deviation m3_7_1 f1 = true := rfl
example : correctable m3_7_1 f1 = false := rfl
example : classify m3_7_1 f2 = .uncorrectable := rfl
example : detected m3_7_1 f2 = false := rfl
example : deviation m3_7_1 f2 = true := rfl
example : correctable m3_7_1 f2 = false := rfl
example : allGeneratedCorrectable m3_7_1 = false := rfl
def m3_7_2 : Model := ⟨[n0,n1],[f0,f1,f2],[r1]⟩
example : classify m3_7_2 f0 = .uncorrectable := rfl
example : detected m3_7_2 f0 = false := rfl
example : deviation m3_7_2 f0 = false := rfl
example : correctable m3_7_2 f0 = false := rfl
example : classify m3_7_2 f1 = .recoverable [r1] := rfl
example : detected m3_7_2 f1 = false := rfl
example : deviation m3_7_2 f1 = true := rfl
example : correctable m3_7_2 f1 = true := rfl
example : classify m3_7_2 f2 = .uncorrectable := rfl
example : detected m3_7_2 f2 = false := rfl
example : deviation m3_7_2 f2 = true := rfl
example : correctable m3_7_2 f2 = false := rfl
example : allGeneratedCorrectable m3_7_2 = false := rfl
def m3_7_3 : Model := ⟨[n0,n1],[f0,f1,f2],[r0,r1]⟩
example : classify m3_7_3 f0 = .recoverable [r0] := rfl
example : detected m3_7_3 f0 = false := rfl
example : deviation m3_7_3 f0 = false := rfl
example : correctable m3_7_3 f0 = true := rfl
example : classify m3_7_3 f1 = .recoverable [r1] := rfl
example : detected m3_7_3 f1 = false := rfl
example : deviation m3_7_3 f1 = true := rfl
example : correctable m3_7_3 f1 = true := rfl
example : classify m3_7_3 f2 = .uncorrectable := rfl
example : detected m3_7_3 f2 = false := rfl
example : deviation m3_7_3 f2 = true := rfl
example : correctable m3_7_3 f2 = false := rfl
example : allGeneratedCorrectable m3_7_3 = false := rfl
def m3_7_4 : Model := ⟨[n0,n1],[f0,f1,f2],[r2]⟩
example : classify m3_7_4 f0 = .uncorrectable := rfl
example : detected m3_7_4 f0 = false := rfl
example : deviation m3_7_4 f0 = false := rfl
example : correctable m3_7_4 f0 = false := rfl
example : classify m3_7_4 f1 = .uncorrectable := rfl
example : detected m3_7_4 f1 = false := rfl
example : deviation m3_7_4 f1 = true := rfl
example : correctable m3_7_4 f1 = false := rfl
example : classify m3_7_4 f2 = .recoverable [r2] := rfl
example : detected m3_7_4 f2 = false := rfl
example : deviation m3_7_4 f2 = true := rfl
example : correctable m3_7_4 f2 = true := rfl
example : allGeneratedCorrectable m3_7_4 = false := rfl
def m3_7_5 : Model := ⟨[n0,n1],[f0,f1,f2],[r0,r2]⟩
example : classify m3_7_5 f0 = .recoverable [r0] := rfl
example : detected m3_7_5 f0 = false := rfl
example : deviation m3_7_5 f0 = false := rfl
example : correctable m3_7_5 f0 = true := rfl
example : classify m3_7_5 f1 = .uncorrectable := rfl
example : detected m3_7_5 f1 = false := rfl
example : deviation m3_7_5 f1 = true := rfl
example : correctable m3_7_5 f1 = false := rfl
example : classify m3_7_5 f2 = .recoverable [r2] := rfl
example : detected m3_7_5 f2 = false := rfl
example : deviation m3_7_5 f2 = true := rfl
example : correctable m3_7_5 f2 = true := rfl
example : allGeneratedCorrectable m3_7_5 = false := rfl
def m3_7_6 : Model := ⟨[n0,n1],[f0,f1,f2],[r1,r2]⟩
example : classify m3_7_6 f0 = .uncorrectable := rfl
example : detected m3_7_6 f0 = false := rfl
example : deviation m3_7_6 f0 = false := rfl
example : correctable m3_7_6 f0 = false := rfl
example : classify m3_7_6 f1 = .recoverable [r1] := rfl
example : detected m3_7_6 f1 = false := rfl
example : deviation m3_7_6 f1 = true := rfl
example : correctable m3_7_6 f1 = true := rfl
example : classify m3_7_6 f2 = .recoverable [r2] := rfl
example : detected m3_7_6 f2 = false := rfl
example : deviation m3_7_6 f2 = true := rfl
example : correctable m3_7_6 f2 = true := rfl
example : allGeneratedCorrectable m3_7_6 = false := rfl
def m3_7_7 : Model := ⟨[n0,n1],[f0,f1,f2],[r0,r1,r2]⟩
example : classify m3_7_7 f0 = .recoverable [r0] := rfl
example : detected m3_7_7 f0 = false := rfl
example : deviation m3_7_7 f0 = false := rfl
example : correctable m3_7_7 f0 = true := rfl
example : classify m3_7_7 f1 = .recoverable [r1] := rfl
example : detected m3_7_7 f1 = false := rfl
example : deviation m3_7_7 f1 = true := rfl
example : correctable m3_7_7 f1 = true := rfl
example : classify m3_7_7 f2 = .recoverable [r2] := rfl
example : detected m3_7_7 f2 = false := rfl
example : deviation m3_7_7 f2 = true := rfl
example : correctable m3_7_7 f2 = true := rfl
example : allGeneratedCorrectable m3_7_7 = true := rfl
