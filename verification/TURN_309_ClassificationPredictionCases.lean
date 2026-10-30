import SFT.Computation.ClassificationPrediction
namespace SFT.Computation.ClassificationPrediction
def m0_0_0 : Training := ⟨[],[],[("h",[])],[]⟩
def s0_0_0 : Sealed m0_0_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_0 s0_0_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_0 s0_0_0 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_0 s0_0_0 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_0 s0_0_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_0 s0_0_0 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_0 s0_0_0 ⟨"b","y"⟩ = false := by decide
def m0_0_1 : Training := ⟨[],[],[("h",[("a","x")])],[]⟩
def s0_0_1 : Sealed m0_0_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_1 s0_0_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_1 s0_0_1 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_1 s0_0_1 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_1 s0_0_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_1 s0_0_1 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_1 s0_0_1 ⟨"b","y"⟩ = false := by decide
def m0_0_2 : Training := ⟨[],[],[("h",[("a","y")])],[]⟩
def s0_0_2 : Sealed m0_0_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_2 s0_0_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_2 s0_0_2 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_2 s0_0_2 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_2 s0_0_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_2 s0_0_2 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_2 s0_0_2 ⟨"b","y"⟩ = false := by decide
def m0_0_3 : Training := ⟨[],[],[("h",[("a","x"),("a","y")])],[]⟩
def s0_0_3 : Sealed m0_0_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_3 s0_0_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_3 s0_0_3 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_3 s0_0_3 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_3 s0_0_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_3 s0_0_3 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_3 s0_0_3 ⟨"b","y"⟩ = false := by decide
def m0_0_4 : Training := ⟨[],[],[("h",[("b","x")])],[]⟩
def s0_0_4 : Sealed m0_0_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_4 s0_0_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_4 s0_0_4 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_4 s0_0_4 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_4 s0_0_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_4 s0_0_4 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_4 s0_0_4 ⟨"b","y"⟩ = false := by decide
def m0_0_5 : Training := ⟨[],[],[("h",[("a","x"),("b","x")])],[]⟩
def s0_0_5 : Sealed m0_0_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_5 s0_0_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_5 s0_0_5 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_5 s0_0_5 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_5 s0_0_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_5 s0_0_5 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_5 s0_0_5 ⟨"b","y"⟩ = false := by decide
def m0_0_6 : Training := ⟨[],[],[("h",[("a","y"),("b","x")])],[]⟩
def s0_0_6 : Sealed m0_0_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_6 s0_0_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_6 s0_0_6 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_6 s0_0_6 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_6 s0_0_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_6 s0_0_6 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_6 s0_0_6 ⟨"b","y"⟩ = false := by decide
def m0_0_7 : Training := ⟨[],[],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s0_0_7 : Sealed m0_0_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_7 s0_0_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_7 s0_0_7 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_7 s0_0_7 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_7 s0_0_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_7 s0_0_7 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_7 s0_0_7 ⟨"b","y"⟩ = false := by decide
def m0_0_8 : Training := ⟨[],[],[("h",[("b","y")])],[]⟩
def s0_0_8 : Sealed m0_0_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_8 s0_0_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_8 s0_0_8 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_8 s0_0_8 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_8 s0_0_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_8 s0_0_8 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_8 s0_0_8 ⟨"b","y"⟩ = false := by decide
def m0_0_9 : Training := ⟨[],[],[("h",[("a","x"),("b","y")])],[]⟩
def s0_0_9 : Sealed m0_0_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_9 s0_0_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_9 s0_0_9 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_9 s0_0_9 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_9 s0_0_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_9 s0_0_9 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_9 s0_0_9 ⟨"b","y"⟩ = false := by decide
def m0_0_10 : Training := ⟨[],[],[("h",[("a","y"),("b","y")])],[]⟩
def s0_0_10 : Sealed m0_0_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_10 s0_0_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_10 s0_0_10 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_10 s0_0_10 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_10 s0_0_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_10 s0_0_10 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_10 s0_0_10 ⟨"b","y"⟩ = false := by decide
def m0_0_11 : Training := ⟨[],[],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s0_0_11 : Sealed m0_0_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_11 s0_0_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_11 s0_0_11 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_11 s0_0_11 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_11 s0_0_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_11 s0_0_11 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_11 s0_0_11 ⟨"b","y"⟩ = false := by decide
def m0_0_12 : Training := ⟨[],[],[("h",[("b","x"),("b","y")])],[]⟩
def s0_0_12 : Sealed m0_0_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_12 s0_0_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_12 s0_0_12 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_12 s0_0_12 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_12 s0_0_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_12 s0_0_12 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_12 s0_0_12 ⟨"b","y"⟩ = false := by decide
def m0_0_13 : Training := ⟨[],[],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s0_0_13 : Sealed m0_0_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_13 s0_0_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_13 s0_0_13 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_13 s0_0_13 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_13 s0_0_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_13 s0_0_13 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_13 s0_0_13 ⟨"b","y"⟩ = false := by decide
def m0_0_14 : Training := ⟨[],[],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s0_0_14 : Sealed m0_0_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_14 s0_0_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_14 s0_0_14 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_14 s0_0_14 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_14 s0_0_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_14 s0_0_14 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_14 s0_0_14 ⟨"b","y"⟩ = false := by decide
def m0_0_15 : Training := ⟨[],[],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s0_0_15 : Sealed m0_0_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_0_15 s0_0_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_15 s0_0_15 ⟨"a","x"⟩ = false := by decide
example : falsified m0_0_15 s0_0_15 ⟨"a","y"⟩ = false := by decide
example : predict m0_0_15 s0_0_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_0_15 s0_0_15 ⟨"b","x"⟩ = false := by decide
example : falsified m0_0_15 s0_0_15 ⟨"b","y"⟩ = false := by decide
def m0_1_0 : Training := ⟨[],["x"],[("h",[])],[]⟩
def s0_1_0 : Sealed m0_1_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_0 s0_1_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_0 s0_1_0 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_0 s0_1_0 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_0 s0_1_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_0 s0_1_0 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_0 s0_1_0 ⟨"b","y"⟩ = false := by decide
def m0_1_1 : Training := ⟨[],["x"],[("h",[("a","x")])],[]⟩
def s0_1_1 : Sealed m0_1_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_1 s0_1_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_1 s0_1_1 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_1 s0_1_1 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_1 s0_1_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_1 s0_1_1 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_1 s0_1_1 ⟨"b","y"⟩ = false := by decide
def m0_1_2 : Training := ⟨[],["x"],[("h",[("a","y")])],[]⟩
def s0_1_2 : Sealed m0_1_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_2 s0_1_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_2 s0_1_2 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_2 s0_1_2 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_2 s0_1_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_2 s0_1_2 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_2 s0_1_2 ⟨"b","y"⟩ = false := by decide
def m0_1_3 : Training := ⟨[],["x"],[("h",[("a","x"),("a","y")])],[]⟩
def s0_1_3 : Sealed m0_1_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_3 s0_1_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_3 s0_1_3 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_3 s0_1_3 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_3 s0_1_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_3 s0_1_3 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_3 s0_1_3 ⟨"b","y"⟩ = false := by decide
def m0_1_4 : Training := ⟨[],["x"],[("h",[("b","x")])],[]⟩
def s0_1_4 : Sealed m0_1_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_4 s0_1_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_4 s0_1_4 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_4 s0_1_4 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_4 s0_1_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_4 s0_1_4 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_4 s0_1_4 ⟨"b","y"⟩ = false := by decide
def m0_1_5 : Training := ⟨[],["x"],[("h",[("a","x"),("b","x")])],[]⟩
def s0_1_5 : Sealed m0_1_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_5 s0_1_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_5 s0_1_5 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_5 s0_1_5 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_5 s0_1_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_5 s0_1_5 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_5 s0_1_5 ⟨"b","y"⟩ = false := by decide
def m0_1_6 : Training := ⟨[],["x"],[("h",[("a","y"),("b","x")])],[]⟩
def s0_1_6 : Sealed m0_1_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_6 s0_1_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_6 s0_1_6 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_6 s0_1_6 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_6 s0_1_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_6 s0_1_6 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_6 s0_1_6 ⟨"b","y"⟩ = false := by decide
def m0_1_7 : Training := ⟨[],["x"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s0_1_7 : Sealed m0_1_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_7 s0_1_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_7 s0_1_7 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_7 s0_1_7 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_7 s0_1_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_7 s0_1_7 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_7 s0_1_7 ⟨"b","y"⟩ = false := by decide
def m0_1_8 : Training := ⟨[],["x"],[("h",[("b","y")])],[]⟩
def s0_1_8 : Sealed m0_1_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_8 s0_1_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_8 s0_1_8 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_8 s0_1_8 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_8 s0_1_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_8 s0_1_8 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_8 s0_1_8 ⟨"b","y"⟩ = false := by decide
def m0_1_9 : Training := ⟨[],["x"],[("h",[("a","x"),("b","y")])],[]⟩
def s0_1_9 : Sealed m0_1_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_9 s0_1_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_9 s0_1_9 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_9 s0_1_9 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_9 s0_1_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_9 s0_1_9 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_9 s0_1_9 ⟨"b","y"⟩ = false := by decide
def m0_1_10 : Training := ⟨[],["x"],[("h",[("a","y"),("b","y")])],[]⟩
def s0_1_10 : Sealed m0_1_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_10 s0_1_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_10 s0_1_10 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_10 s0_1_10 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_10 s0_1_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_10 s0_1_10 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_10 s0_1_10 ⟨"b","y"⟩ = false := by decide
def m0_1_11 : Training := ⟨[],["x"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s0_1_11 : Sealed m0_1_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_11 s0_1_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_11 s0_1_11 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_11 s0_1_11 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_11 s0_1_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_11 s0_1_11 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_11 s0_1_11 ⟨"b","y"⟩ = false := by decide
def m0_1_12 : Training := ⟨[],["x"],[("h",[("b","x"),("b","y")])],[]⟩
def s0_1_12 : Sealed m0_1_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_12 s0_1_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_12 s0_1_12 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_12 s0_1_12 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_12 s0_1_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_12 s0_1_12 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_12 s0_1_12 ⟨"b","y"⟩ = false := by decide
def m0_1_13 : Training := ⟨[],["x"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s0_1_13 : Sealed m0_1_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_13 s0_1_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_13 s0_1_13 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_13 s0_1_13 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_13 s0_1_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_13 s0_1_13 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_13 s0_1_13 ⟨"b","y"⟩ = false := by decide
def m0_1_14 : Training := ⟨[],["x"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s0_1_14 : Sealed m0_1_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_14 s0_1_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_14 s0_1_14 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_14 s0_1_14 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_14 s0_1_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_14 s0_1_14 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_14 s0_1_14 ⟨"b","y"⟩ = false := by decide
def m0_1_15 : Training := ⟨[],["x"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s0_1_15 : Sealed m0_1_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_1_15 s0_1_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_15 s0_1_15 ⟨"a","x"⟩ = false := by decide
example : falsified m0_1_15 s0_1_15 ⟨"a","y"⟩ = false := by decide
example : predict m0_1_15 s0_1_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_1_15 s0_1_15 ⟨"b","x"⟩ = false := by decide
example : falsified m0_1_15 s0_1_15 ⟨"b","y"⟩ = false := by decide
def m0_2_0 : Training := ⟨[],["y"],[("h",[])],[]⟩
def s0_2_0 : Sealed m0_2_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_0 s0_2_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_0 s0_2_0 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_0 s0_2_0 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_0 s0_2_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_0 s0_2_0 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_0 s0_2_0 ⟨"b","y"⟩ = false := by decide
def m0_2_1 : Training := ⟨[],["y"],[("h",[("a","x")])],[]⟩
def s0_2_1 : Sealed m0_2_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_1 s0_2_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_1 s0_2_1 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_1 s0_2_1 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_1 s0_2_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_1 s0_2_1 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_1 s0_2_1 ⟨"b","y"⟩ = false := by decide
def m0_2_2 : Training := ⟨[],["y"],[("h",[("a","y")])],[]⟩
def s0_2_2 : Sealed m0_2_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_2 s0_2_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_2 s0_2_2 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_2 s0_2_2 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_2 s0_2_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_2 s0_2_2 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_2 s0_2_2 ⟨"b","y"⟩ = false := by decide
def m0_2_3 : Training := ⟨[],["y"],[("h",[("a","x"),("a","y")])],[]⟩
def s0_2_3 : Sealed m0_2_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_3 s0_2_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_3 s0_2_3 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_3 s0_2_3 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_3 s0_2_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_3 s0_2_3 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_3 s0_2_3 ⟨"b","y"⟩ = false := by decide
def m0_2_4 : Training := ⟨[],["y"],[("h",[("b","x")])],[]⟩
def s0_2_4 : Sealed m0_2_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_4 s0_2_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_4 s0_2_4 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_4 s0_2_4 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_4 s0_2_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_4 s0_2_4 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_4 s0_2_4 ⟨"b","y"⟩ = false := by decide
def m0_2_5 : Training := ⟨[],["y"],[("h",[("a","x"),("b","x")])],[]⟩
def s0_2_5 : Sealed m0_2_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_5 s0_2_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_5 s0_2_5 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_5 s0_2_5 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_5 s0_2_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_5 s0_2_5 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_5 s0_2_5 ⟨"b","y"⟩ = false := by decide
def m0_2_6 : Training := ⟨[],["y"],[("h",[("a","y"),("b","x")])],[]⟩
def s0_2_6 : Sealed m0_2_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_6 s0_2_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_6 s0_2_6 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_6 s0_2_6 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_6 s0_2_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_6 s0_2_6 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_6 s0_2_6 ⟨"b","y"⟩ = false := by decide
def m0_2_7 : Training := ⟨[],["y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s0_2_7 : Sealed m0_2_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_7 s0_2_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_7 s0_2_7 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_7 s0_2_7 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_7 s0_2_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_7 s0_2_7 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_7 s0_2_7 ⟨"b","y"⟩ = false := by decide
def m0_2_8 : Training := ⟨[],["y"],[("h",[("b","y")])],[]⟩
def s0_2_8 : Sealed m0_2_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_8 s0_2_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_8 s0_2_8 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_8 s0_2_8 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_8 s0_2_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_8 s0_2_8 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_8 s0_2_8 ⟨"b","y"⟩ = false := by decide
def m0_2_9 : Training := ⟨[],["y"],[("h",[("a","x"),("b","y")])],[]⟩
def s0_2_9 : Sealed m0_2_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_9 s0_2_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_9 s0_2_9 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_9 s0_2_9 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_9 s0_2_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_9 s0_2_9 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_9 s0_2_9 ⟨"b","y"⟩ = false := by decide
def m0_2_10 : Training := ⟨[],["y"],[("h",[("a","y"),("b","y")])],[]⟩
def s0_2_10 : Sealed m0_2_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_10 s0_2_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_10 s0_2_10 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_10 s0_2_10 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_10 s0_2_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_10 s0_2_10 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_10 s0_2_10 ⟨"b","y"⟩ = false := by decide
def m0_2_11 : Training := ⟨[],["y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s0_2_11 : Sealed m0_2_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_11 s0_2_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_11 s0_2_11 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_11 s0_2_11 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_11 s0_2_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_11 s0_2_11 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_11 s0_2_11 ⟨"b","y"⟩ = false := by decide
def m0_2_12 : Training := ⟨[],["y"],[("h",[("b","x"),("b","y")])],[]⟩
def s0_2_12 : Sealed m0_2_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_12 s0_2_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_12 s0_2_12 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_12 s0_2_12 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_12 s0_2_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_12 s0_2_12 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_12 s0_2_12 ⟨"b","y"⟩ = false := by decide
def m0_2_13 : Training := ⟨[],["y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s0_2_13 : Sealed m0_2_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_13 s0_2_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_13 s0_2_13 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_13 s0_2_13 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_13 s0_2_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_13 s0_2_13 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_13 s0_2_13 ⟨"b","y"⟩ = false := by decide
def m0_2_14 : Training := ⟨[],["y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s0_2_14 : Sealed m0_2_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_14 s0_2_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_14 s0_2_14 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_14 s0_2_14 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_14 s0_2_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_14 s0_2_14 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_14 s0_2_14 ⟨"b","y"⟩ = false := by decide
def m0_2_15 : Training := ⟨[],["y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s0_2_15 : Sealed m0_2_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_2_15 s0_2_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_15 s0_2_15 ⟨"a","x"⟩ = false := by decide
example : falsified m0_2_15 s0_2_15 ⟨"a","y"⟩ = false := by decide
example : predict m0_2_15 s0_2_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_2_15 s0_2_15 ⟨"b","x"⟩ = false := by decide
example : falsified m0_2_15 s0_2_15 ⟨"b","y"⟩ = false := by decide
def m0_3_0 : Training := ⟨[],["x","y"],[("h",[])],[]⟩
def s0_3_0 : Sealed m0_3_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_0 s0_3_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_0 s0_3_0 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_0 s0_3_0 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_0 s0_3_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_0 s0_3_0 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_0 s0_3_0 ⟨"b","y"⟩ = false := by decide
def m0_3_1 : Training := ⟨[],["x","y"],[("h",[("a","x")])],[]⟩
def s0_3_1 : Sealed m0_3_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_1 s0_3_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_1 s0_3_1 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_1 s0_3_1 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_1 s0_3_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_1 s0_3_1 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_1 s0_3_1 ⟨"b","y"⟩ = false := by decide
def m0_3_2 : Training := ⟨[],["x","y"],[("h",[("a","y")])],[]⟩
def s0_3_2 : Sealed m0_3_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_2 s0_3_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_2 s0_3_2 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_2 s0_3_2 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_2 s0_3_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_2 s0_3_2 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_2 s0_3_2 ⟨"b","y"⟩ = false := by decide
def m0_3_3 : Training := ⟨[],["x","y"],[("h",[("a","x"),("a","y")])],[]⟩
def s0_3_3 : Sealed m0_3_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_3 s0_3_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_3 s0_3_3 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_3 s0_3_3 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_3 s0_3_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_3 s0_3_3 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_3 s0_3_3 ⟨"b","y"⟩ = false := by decide
def m0_3_4 : Training := ⟨[],["x","y"],[("h",[("b","x")])],[]⟩
def s0_3_4 : Sealed m0_3_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_4 s0_3_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_4 s0_3_4 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_4 s0_3_4 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_4 s0_3_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_4 s0_3_4 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_4 s0_3_4 ⟨"b","y"⟩ = false := by decide
def m0_3_5 : Training := ⟨[],["x","y"],[("h",[("a","x"),("b","x")])],[]⟩
def s0_3_5 : Sealed m0_3_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_5 s0_3_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_5 s0_3_5 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_5 s0_3_5 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_5 s0_3_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_5 s0_3_5 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_5 s0_3_5 ⟨"b","y"⟩ = false := by decide
def m0_3_6 : Training := ⟨[],["x","y"],[("h",[("a","y"),("b","x")])],[]⟩
def s0_3_6 : Sealed m0_3_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_6 s0_3_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_6 s0_3_6 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_6 s0_3_6 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_6 s0_3_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_6 s0_3_6 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_6 s0_3_6 ⟨"b","y"⟩ = false := by decide
def m0_3_7 : Training := ⟨[],["x","y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s0_3_7 : Sealed m0_3_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_7 s0_3_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_7 s0_3_7 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_7 s0_3_7 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_7 s0_3_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_7 s0_3_7 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_7 s0_3_7 ⟨"b","y"⟩ = false := by decide
def m0_3_8 : Training := ⟨[],["x","y"],[("h",[("b","y")])],[]⟩
def s0_3_8 : Sealed m0_3_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_8 s0_3_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_8 s0_3_8 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_8 s0_3_8 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_8 s0_3_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_8 s0_3_8 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_8 s0_3_8 ⟨"b","y"⟩ = false := by decide
def m0_3_9 : Training := ⟨[],["x","y"],[("h",[("a","x"),("b","y")])],[]⟩
def s0_3_9 : Sealed m0_3_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_9 s0_3_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_9 s0_3_9 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_9 s0_3_9 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_9 s0_3_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_9 s0_3_9 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_9 s0_3_9 ⟨"b","y"⟩ = false := by decide
def m0_3_10 : Training := ⟨[],["x","y"],[("h",[("a","y"),("b","y")])],[]⟩
def s0_3_10 : Sealed m0_3_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_10 s0_3_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_10 s0_3_10 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_10 s0_3_10 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_10 s0_3_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_10 s0_3_10 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_10 s0_3_10 ⟨"b","y"⟩ = false := by decide
def m0_3_11 : Training := ⟨[],["x","y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s0_3_11 : Sealed m0_3_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_11 s0_3_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_11 s0_3_11 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_11 s0_3_11 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_11 s0_3_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_11 s0_3_11 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_11 s0_3_11 ⟨"b","y"⟩ = false := by decide
def m0_3_12 : Training := ⟨[],["x","y"],[("h",[("b","x"),("b","y")])],[]⟩
def s0_3_12 : Sealed m0_3_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_12 s0_3_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_12 s0_3_12 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_12 s0_3_12 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_12 s0_3_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_12 s0_3_12 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_12 s0_3_12 ⟨"b","y"⟩ = false := by decide
def m0_3_13 : Training := ⟨[],["x","y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s0_3_13 : Sealed m0_3_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_13 s0_3_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_13 s0_3_13 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_13 s0_3_13 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_13 s0_3_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_13 s0_3_13 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_13 s0_3_13 ⟨"b","y"⟩ = false := by decide
def m0_3_14 : Training := ⟨[],["x","y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s0_3_14 : Sealed m0_3_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_14 s0_3_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_14 s0_3_14 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_14 s0_3_14 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_14 s0_3_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_14 s0_3_14 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_14 s0_3_14 ⟨"b","y"⟩ = false := by decide
def m0_3_15 : Training := ⟨[],["x","y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s0_3_15 : Sealed m0_3_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m0_3_15 s0_3_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_15 s0_3_15 ⟨"a","x"⟩ = false := by decide
example : falsified m0_3_15 s0_3_15 ⟨"a","y"⟩ = false := by decide
example : predict m0_3_15 s0_3_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m0_3_15 s0_3_15 ⟨"b","x"⟩ = false := by decide
example : falsified m0_3_15 s0_3_15 ⟨"b","y"⟩ = false := by decide
def m1_0_0 : Training := ⟨["a"],[],[("h",[])],[]⟩
def s1_0_0 : Sealed m1_0_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_0 s1_0_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_0 s1_0_0 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_0 s1_0_0 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_0 s1_0_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_0 s1_0_0 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_0 s1_0_0 ⟨"b","y"⟩ = false := by decide
def m1_0_1 : Training := ⟨["a"],[],[("h",[("a","x")])],[]⟩
def s1_0_1 : Sealed m1_0_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_1 s1_0_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_1 s1_0_1 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_1 s1_0_1 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_1 s1_0_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_1 s1_0_1 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_1 s1_0_1 ⟨"b","y"⟩ = false := by decide
def m1_0_2 : Training := ⟨["a"],[],[("h",[("a","y")])],[]⟩
def s1_0_2 : Sealed m1_0_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_2 s1_0_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_2 s1_0_2 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_2 s1_0_2 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_2 s1_0_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_2 s1_0_2 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_2 s1_0_2 ⟨"b","y"⟩ = false := by decide
def m1_0_3 : Training := ⟨["a"],[],[("h",[("a","x"),("a","y")])],[]⟩
def s1_0_3 : Sealed m1_0_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_3 s1_0_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_3 s1_0_3 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_3 s1_0_3 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_3 s1_0_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_3 s1_0_3 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_3 s1_0_3 ⟨"b","y"⟩ = false := by decide
def m1_0_4 : Training := ⟨["a"],[],[("h",[("b","x")])],[]⟩
def s1_0_4 : Sealed m1_0_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_4 s1_0_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_4 s1_0_4 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_4 s1_0_4 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_4 s1_0_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_4 s1_0_4 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_4 s1_0_4 ⟨"b","y"⟩ = false := by decide
def m1_0_5 : Training := ⟨["a"],[],[("h",[("a","x"),("b","x")])],[]⟩
def s1_0_5 : Sealed m1_0_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_5 s1_0_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_5 s1_0_5 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_5 s1_0_5 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_5 s1_0_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_5 s1_0_5 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_5 s1_0_5 ⟨"b","y"⟩ = false := by decide
def m1_0_6 : Training := ⟨["a"],[],[("h",[("a","y"),("b","x")])],[]⟩
def s1_0_6 : Sealed m1_0_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_6 s1_0_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_6 s1_0_6 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_6 s1_0_6 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_6 s1_0_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_6 s1_0_6 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_6 s1_0_6 ⟨"b","y"⟩ = false := by decide
def m1_0_7 : Training := ⟨["a"],[],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s1_0_7 : Sealed m1_0_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_7 s1_0_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_7 s1_0_7 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_7 s1_0_7 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_7 s1_0_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_7 s1_0_7 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_7 s1_0_7 ⟨"b","y"⟩ = false := by decide
def m1_0_8 : Training := ⟨["a"],[],[("h",[("b","y")])],[]⟩
def s1_0_8 : Sealed m1_0_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_8 s1_0_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_8 s1_0_8 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_8 s1_0_8 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_8 s1_0_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_8 s1_0_8 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_8 s1_0_8 ⟨"b","y"⟩ = false := by decide
def m1_0_9 : Training := ⟨["a"],[],[("h",[("a","x"),("b","y")])],[]⟩
def s1_0_9 : Sealed m1_0_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_9 s1_0_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_9 s1_0_9 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_9 s1_0_9 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_9 s1_0_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_9 s1_0_9 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_9 s1_0_9 ⟨"b","y"⟩ = false := by decide
def m1_0_10 : Training := ⟨["a"],[],[("h",[("a","y"),("b","y")])],[]⟩
def s1_0_10 : Sealed m1_0_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_10 s1_0_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_10 s1_0_10 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_10 s1_0_10 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_10 s1_0_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_10 s1_0_10 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_10 s1_0_10 ⟨"b","y"⟩ = false := by decide
def m1_0_11 : Training := ⟨["a"],[],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s1_0_11 : Sealed m1_0_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_11 s1_0_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_11 s1_0_11 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_11 s1_0_11 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_11 s1_0_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_11 s1_0_11 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_11 s1_0_11 ⟨"b","y"⟩ = false := by decide
def m1_0_12 : Training := ⟨["a"],[],[("h",[("b","x"),("b","y")])],[]⟩
def s1_0_12 : Sealed m1_0_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_12 s1_0_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_12 s1_0_12 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_12 s1_0_12 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_12 s1_0_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_12 s1_0_12 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_12 s1_0_12 ⟨"b","y"⟩ = false := by decide
def m1_0_13 : Training := ⟨["a"],[],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s1_0_13 : Sealed m1_0_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_13 s1_0_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_13 s1_0_13 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_13 s1_0_13 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_13 s1_0_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_13 s1_0_13 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_13 s1_0_13 ⟨"b","y"⟩ = false := by decide
def m1_0_14 : Training := ⟨["a"],[],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s1_0_14 : Sealed m1_0_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_14 s1_0_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_14 s1_0_14 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_14 s1_0_14 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_14 s1_0_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_14 s1_0_14 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_14 s1_0_14 ⟨"b","y"⟩ = false := by decide
def m1_0_15 : Training := ⟨["a"],[],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s1_0_15 : Sealed m1_0_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_0_15 s1_0_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_15 s1_0_15 ⟨"a","x"⟩ = false := by decide
example : falsified m1_0_15 s1_0_15 ⟨"a","y"⟩ = false := by decide
example : predict m1_0_15 s1_0_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_0_15 s1_0_15 ⟨"b","x"⟩ = false := by decide
example : falsified m1_0_15 s1_0_15 ⟨"b","y"⟩ = false := by decide
def m1_1_0 : Training := ⟨["a"],["x"],[("h",[])],[]⟩
def s1_1_0 : Sealed m1_1_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_0 s1_1_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_0 s1_1_0 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_0 s1_1_0 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_0 s1_1_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_0 s1_1_0 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_0 s1_1_0 ⟨"b","y"⟩ = false := by decide
def m1_1_1 : Training := ⟨["a"],["x"],[("h",[("a","x")])],[]⟩
def s1_1_1 : Sealed m1_1_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_1 s1_1_1 "a" = .ok "x" := rfl
example : falsified m1_1_1 s1_1_1 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_1 s1_1_1 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_1 s1_1_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_1 s1_1_1 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_1 s1_1_1 ⟨"b","y"⟩ = false := by decide
def m1_1_2 : Training := ⟨["a"],["x"],[("h",[("a","y")])],[]⟩
def s1_1_2 : Sealed m1_1_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_2 s1_1_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_2 s1_1_2 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_2 s1_1_2 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_2 s1_1_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_2 s1_1_2 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_2 s1_1_2 ⟨"b","y"⟩ = false := by decide
def m1_1_3 : Training := ⟨["a"],["x"],[("h",[("a","x"),("a","y")])],[]⟩
def s1_1_3 : Sealed m1_1_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_3 s1_1_3 "a" = .ok "x" := rfl
example : falsified m1_1_3 s1_1_3 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_3 s1_1_3 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_3 s1_1_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_3 s1_1_3 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_3 s1_1_3 ⟨"b","y"⟩ = false := by decide
def m1_1_4 : Training := ⟨["a"],["x"],[("h",[("b","x")])],[]⟩
def s1_1_4 : Sealed m1_1_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_4 s1_1_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_4 s1_1_4 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_4 s1_1_4 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_4 s1_1_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_4 s1_1_4 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_4 s1_1_4 ⟨"b","y"⟩ = false := by decide
def m1_1_5 : Training := ⟨["a"],["x"],[("h",[("a","x"),("b","x")])],[]⟩
def s1_1_5 : Sealed m1_1_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_5 s1_1_5 "a" = .ok "x" := rfl
example : falsified m1_1_5 s1_1_5 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_5 s1_1_5 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_5 s1_1_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_5 s1_1_5 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_5 s1_1_5 ⟨"b","y"⟩ = false := by decide
def m1_1_6 : Training := ⟨["a"],["x"],[("h",[("a","y"),("b","x")])],[]⟩
def s1_1_6 : Sealed m1_1_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_6 s1_1_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_6 s1_1_6 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_6 s1_1_6 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_6 s1_1_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_6 s1_1_6 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_6 s1_1_6 ⟨"b","y"⟩ = false := by decide
def m1_1_7 : Training := ⟨["a"],["x"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s1_1_7 : Sealed m1_1_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_7 s1_1_7 "a" = .ok "x" := rfl
example : falsified m1_1_7 s1_1_7 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_7 s1_1_7 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_7 s1_1_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_7 s1_1_7 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_7 s1_1_7 ⟨"b","y"⟩ = false := by decide
def m1_1_8 : Training := ⟨["a"],["x"],[("h",[("b","y")])],[]⟩
def s1_1_8 : Sealed m1_1_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_8 s1_1_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_8 s1_1_8 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_8 s1_1_8 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_8 s1_1_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_8 s1_1_8 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_8 s1_1_8 ⟨"b","y"⟩ = false := by decide
def m1_1_9 : Training := ⟨["a"],["x"],[("h",[("a","x"),("b","y")])],[]⟩
def s1_1_9 : Sealed m1_1_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_9 s1_1_9 "a" = .ok "x" := rfl
example : falsified m1_1_9 s1_1_9 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_9 s1_1_9 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_9 s1_1_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_9 s1_1_9 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_9 s1_1_9 ⟨"b","y"⟩ = false := by decide
def m1_1_10 : Training := ⟨["a"],["x"],[("h",[("a","y"),("b","y")])],[]⟩
def s1_1_10 : Sealed m1_1_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_10 s1_1_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_10 s1_1_10 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_10 s1_1_10 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_10 s1_1_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_10 s1_1_10 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_10 s1_1_10 ⟨"b","y"⟩ = false := by decide
def m1_1_11 : Training := ⟨["a"],["x"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s1_1_11 : Sealed m1_1_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_11 s1_1_11 "a" = .ok "x" := rfl
example : falsified m1_1_11 s1_1_11 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_11 s1_1_11 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_11 s1_1_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_11 s1_1_11 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_11 s1_1_11 ⟨"b","y"⟩ = false := by decide
def m1_1_12 : Training := ⟨["a"],["x"],[("h",[("b","x"),("b","y")])],[]⟩
def s1_1_12 : Sealed m1_1_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_12 s1_1_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_12 s1_1_12 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_12 s1_1_12 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_12 s1_1_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_12 s1_1_12 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_12 s1_1_12 ⟨"b","y"⟩ = false := by decide
def m1_1_13 : Training := ⟨["a"],["x"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s1_1_13 : Sealed m1_1_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_13 s1_1_13 "a" = .ok "x" := rfl
example : falsified m1_1_13 s1_1_13 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_13 s1_1_13 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_13 s1_1_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_13 s1_1_13 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_13 s1_1_13 ⟨"b","y"⟩ = false := by decide
def m1_1_14 : Training := ⟨["a"],["x"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s1_1_14 : Sealed m1_1_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_14 s1_1_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_14 s1_1_14 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_14 s1_1_14 ⟨"a","y"⟩ = false := by decide
example : predict m1_1_14 s1_1_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_14 s1_1_14 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_14 s1_1_14 ⟨"b","y"⟩ = false := by decide
def m1_1_15 : Training := ⟨["a"],["x"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s1_1_15 : Sealed m1_1_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_1_15 s1_1_15 "a" = .ok "x" := rfl
example : falsified m1_1_15 s1_1_15 ⟨"a","x"⟩ = false := by decide
example : falsified m1_1_15 s1_1_15 ⟨"a","y"⟩ = true := by decide
example : predict m1_1_15 s1_1_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_1_15 s1_1_15 ⟨"b","x"⟩ = false := by decide
example : falsified m1_1_15 s1_1_15 ⟨"b","y"⟩ = false := by decide
def m1_2_0 : Training := ⟨["a"],["y"],[("h",[])],[]⟩
def s1_2_0 : Sealed m1_2_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_0 s1_2_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_0 s1_2_0 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_0 s1_2_0 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_0 s1_2_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_0 s1_2_0 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_0 s1_2_0 ⟨"b","y"⟩ = false := by decide
def m1_2_1 : Training := ⟨["a"],["y"],[("h",[("a","x")])],[]⟩
def s1_2_1 : Sealed m1_2_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_1 s1_2_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_1 s1_2_1 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_1 s1_2_1 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_1 s1_2_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_1 s1_2_1 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_1 s1_2_1 ⟨"b","y"⟩ = false := by decide
def m1_2_2 : Training := ⟨["a"],["y"],[("h",[("a","y")])],[]⟩
def s1_2_2 : Sealed m1_2_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_2 s1_2_2 "a" = .ok "y" := rfl
example : falsified m1_2_2 s1_2_2 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_2 s1_2_2 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_2 s1_2_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_2 s1_2_2 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_2 s1_2_2 ⟨"b","y"⟩ = false := by decide
def m1_2_3 : Training := ⟨["a"],["y"],[("h",[("a","x"),("a","y")])],[]⟩
def s1_2_3 : Sealed m1_2_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_3 s1_2_3 "a" = .ok "y" := rfl
example : falsified m1_2_3 s1_2_3 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_3 s1_2_3 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_3 s1_2_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_3 s1_2_3 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_3 s1_2_3 ⟨"b","y"⟩ = false := by decide
def m1_2_4 : Training := ⟨["a"],["y"],[("h",[("b","x")])],[]⟩
def s1_2_4 : Sealed m1_2_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_4 s1_2_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_4 s1_2_4 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_4 s1_2_4 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_4 s1_2_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_4 s1_2_4 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_4 s1_2_4 ⟨"b","y"⟩ = false := by decide
def m1_2_5 : Training := ⟨["a"],["y"],[("h",[("a","x"),("b","x")])],[]⟩
def s1_2_5 : Sealed m1_2_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_5 s1_2_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_5 s1_2_5 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_5 s1_2_5 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_5 s1_2_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_5 s1_2_5 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_5 s1_2_5 ⟨"b","y"⟩ = false := by decide
def m1_2_6 : Training := ⟨["a"],["y"],[("h",[("a","y"),("b","x")])],[]⟩
def s1_2_6 : Sealed m1_2_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_6 s1_2_6 "a" = .ok "y" := rfl
example : falsified m1_2_6 s1_2_6 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_6 s1_2_6 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_6 s1_2_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_6 s1_2_6 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_6 s1_2_6 ⟨"b","y"⟩ = false := by decide
def m1_2_7 : Training := ⟨["a"],["y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s1_2_7 : Sealed m1_2_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_7 s1_2_7 "a" = .ok "y" := rfl
example : falsified m1_2_7 s1_2_7 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_7 s1_2_7 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_7 s1_2_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_7 s1_2_7 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_7 s1_2_7 ⟨"b","y"⟩ = false := by decide
def m1_2_8 : Training := ⟨["a"],["y"],[("h",[("b","y")])],[]⟩
def s1_2_8 : Sealed m1_2_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_8 s1_2_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_8 s1_2_8 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_8 s1_2_8 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_8 s1_2_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_8 s1_2_8 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_8 s1_2_8 ⟨"b","y"⟩ = false := by decide
def m1_2_9 : Training := ⟨["a"],["y"],[("h",[("a","x"),("b","y")])],[]⟩
def s1_2_9 : Sealed m1_2_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_9 s1_2_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_9 s1_2_9 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_9 s1_2_9 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_9 s1_2_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_9 s1_2_9 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_9 s1_2_9 ⟨"b","y"⟩ = false := by decide
def m1_2_10 : Training := ⟨["a"],["y"],[("h",[("a","y"),("b","y")])],[]⟩
def s1_2_10 : Sealed m1_2_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_10 s1_2_10 "a" = .ok "y" := rfl
example : falsified m1_2_10 s1_2_10 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_10 s1_2_10 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_10 s1_2_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_10 s1_2_10 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_10 s1_2_10 ⟨"b","y"⟩ = false := by decide
def m1_2_11 : Training := ⟨["a"],["y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s1_2_11 : Sealed m1_2_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_11 s1_2_11 "a" = .ok "y" := rfl
example : falsified m1_2_11 s1_2_11 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_11 s1_2_11 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_11 s1_2_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_11 s1_2_11 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_11 s1_2_11 ⟨"b","y"⟩ = false := by decide
def m1_2_12 : Training := ⟨["a"],["y"],[("h",[("b","x"),("b","y")])],[]⟩
def s1_2_12 : Sealed m1_2_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_12 s1_2_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_12 s1_2_12 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_12 s1_2_12 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_12 s1_2_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_12 s1_2_12 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_12 s1_2_12 ⟨"b","y"⟩ = false := by decide
def m1_2_13 : Training := ⟨["a"],["y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s1_2_13 : Sealed m1_2_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_13 s1_2_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_13 s1_2_13 ⟨"a","x"⟩ = false := by decide
example : falsified m1_2_13 s1_2_13 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_13 s1_2_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_13 s1_2_13 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_13 s1_2_13 ⟨"b","y"⟩ = false := by decide
def m1_2_14 : Training := ⟨["a"],["y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s1_2_14 : Sealed m1_2_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_14 s1_2_14 "a" = .ok "y" := rfl
example : falsified m1_2_14 s1_2_14 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_14 s1_2_14 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_14 s1_2_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_14 s1_2_14 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_14 s1_2_14 ⟨"b","y"⟩ = false := by decide
def m1_2_15 : Training := ⟨["a"],["y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s1_2_15 : Sealed m1_2_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_2_15 s1_2_15 "a" = .ok "y" := rfl
example : falsified m1_2_15 s1_2_15 ⟨"a","x"⟩ = true := by decide
example : falsified m1_2_15 s1_2_15 ⟨"a","y"⟩ = false := by decide
example : predict m1_2_15 s1_2_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_2_15 s1_2_15 ⟨"b","x"⟩ = false := by decide
example : falsified m1_2_15 s1_2_15 ⟨"b","y"⟩ = false := by decide
def m1_3_0 : Training := ⟨["a"],["x","y"],[("h",[])],[]⟩
def s1_3_0 : Sealed m1_3_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_0 s1_3_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_0 s1_3_0 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_0 s1_3_0 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_0 s1_3_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_0 s1_3_0 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_0 s1_3_0 ⟨"b","y"⟩ = false := by decide
def m1_3_1 : Training := ⟨["a"],["x","y"],[("h",[("a","x")])],[]⟩
def s1_3_1 : Sealed m1_3_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_1 s1_3_1 "a" = .ok "x" := rfl
example : falsified m1_3_1 s1_3_1 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_1 s1_3_1 ⟨"a","y"⟩ = true := by decide
example : predict m1_3_1 s1_3_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_1 s1_3_1 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_1 s1_3_1 ⟨"b","y"⟩ = false := by decide
def m1_3_2 : Training := ⟨["a"],["x","y"],[("h",[("a","y")])],[]⟩
def s1_3_2 : Sealed m1_3_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_2 s1_3_2 "a" = .ok "y" := rfl
example : falsified m1_3_2 s1_3_2 ⟨"a","x"⟩ = true := by decide
example : falsified m1_3_2 s1_3_2 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_2 s1_3_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_2 s1_3_2 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_2 s1_3_2 ⟨"b","y"⟩ = false := by decide
def m1_3_3 : Training := ⟨["a"],["x","y"],[("h",[("a","x"),("a","y")])],[]⟩
def s1_3_3 : Sealed m1_3_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_3 s1_3_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_3 s1_3_3 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_3 s1_3_3 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_3 s1_3_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_3 s1_3_3 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_3 s1_3_3 ⟨"b","y"⟩ = false := by decide
def m1_3_4 : Training := ⟨["a"],["x","y"],[("h",[("b","x")])],[]⟩
def s1_3_4 : Sealed m1_3_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_4 s1_3_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_4 s1_3_4 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_4 s1_3_4 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_4 s1_3_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_4 s1_3_4 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_4 s1_3_4 ⟨"b","y"⟩ = false := by decide
def m1_3_5 : Training := ⟨["a"],["x","y"],[("h",[("a","x"),("b","x")])],[]⟩
def s1_3_5 : Sealed m1_3_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_5 s1_3_5 "a" = .ok "x" := rfl
example : falsified m1_3_5 s1_3_5 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_5 s1_3_5 ⟨"a","y"⟩ = true := by decide
example : predict m1_3_5 s1_3_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_5 s1_3_5 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_5 s1_3_5 ⟨"b","y"⟩ = false := by decide
def m1_3_6 : Training := ⟨["a"],["x","y"],[("h",[("a","y"),("b","x")])],[]⟩
def s1_3_6 : Sealed m1_3_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_6 s1_3_6 "a" = .ok "y" := rfl
example : falsified m1_3_6 s1_3_6 ⟨"a","x"⟩ = true := by decide
example : falsified m1_3_6 s1_3_6 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_6 s1_3_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_6 s1_3_6 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_6 s1_3_6 ⟨"b","y"⟩ = false := by decide
def m1_3_7 : Training := ⟨["a"],["x","y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s1_3_7 : Sealed m1_3_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_7 s1_3_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_7 s1_3_7 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_7 s1_3_7 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_7 s1_3_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_7 s1_3_7 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_7 s1_3_7 ⟨"b","y"⟩ = false := by decide
def m1_3_8 : Training := ⟨["a"],["x","y"],[("h",[("b","y")])],[]⟩
def s1_3_8 : Sealed m1_3_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_8 s1_3_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_8 s1_3_8 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_8 s1_3_8 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_8 s1_3_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_8 s1_3_8 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_8 s1_3_8 ⟨"b","y"⟩ = false := by decide
def m1_3_9 : Training := ⟨["a"],["x","y"],[("h",[("a","x"),("b","y")])],[]⟩
def s1_3_9 : Sealed m1_3_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_9 s1_3_9 "a" = .ok "x" := rfl
example : falsified m1_3_9 s1_3_9 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_9 s1_3_9 ⟨"a","y"⟩ = true := by decide
example : predict m1_3_9 s1_3_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_9 s1_3_9 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_9 s1_3_9 ⟨"b","y"⟩ = false := by decide
def m1_3_10 : Training := ⟨["a"],["x","y"],[("h",[("a","y"),("b","y")])],[]⟩
def s1_3_10 : Sealed m1_3_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_10 s1_3_10 "a" = .ok "y" := rfl
example : falsified m1_3_10 s1_3_10 ⟨"a","x"⟩ = true := by decide
example : falsified m1_3_10 s1_3_10 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_10 s1_3_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_10 s1_3_10 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_10 s1_3_10 ⟨"b","y"⟩ = false := by decide
def m1_3_11 : Training := ⟨["a"],["x","y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s1_3_11 : Sealed m1_3_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_11 s1_3_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_11 s1_3_11 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_11 s1_3_11 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_11 s1_3_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_11 s1_3_11 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_11 s1_3_11 ⟨"b","y"⟩ = false := by decide
def m1_3_12 : Training := ⟨["a"],["x","y"],[("h",[("b","x"),("b","y")])],[]⟩
def s1_3_12 : Sealed m1_3_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_12 s1_3_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_12 s1_3_12 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_12 s1_3_12 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_12 s1_3_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_12 s1_3_12 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_12 s1_3_12 ⟨"b","y"⟩ = false := by decide
def m1_3_13 : Training := ⟨["a"],["x","y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s1_3_13 : Sealed m1_3_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_13 s1_3_13 "a" = .ok "x" := rfl
example : falsified m1_3_13 s1_3_13 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_13 s1_3_13 ⟨"a","y"⟩ = true := by decide
example : predict m1_3_13 s1_3_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_13 s1_3_13 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_13 s1_3_13 ⟨"b","y"⟩ = false := by decide
def m1_3_14 : Training := ⟨["a"],["x","y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s1_3_14 : Sealed m1_3_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_14 s1_3_14 "a" = .ok "y" := rfl
example : falsified m1_3_14 s1_3_14 ⟨"a","x"⟩ = true := by decide
example : falsified m1_3_14 s1_3_14 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_14 s1_3_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_14 s1_3_14 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_14 s1_3_14 ⟨"b","y"⟩ = false := by decide
def m1_3_15 : Training := ⟨["a"],["x","y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s1_3_15 : Sealed m1_3_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m1_3_15 s1_3_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_15 s1_3_15 ⟨"a","x"⟩ = false := by decide
example : falsified m1_3_15 s1_3_15 ⟨"a","y"⟩ = false := by decide
example : predict m1_3_15 s1_3_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m1_3_15 s1_3_15 ⟨"b","x"⟩ = false := by decide
example : falsified m1_3_15 s1_3_15 ⟨"b","y"⟩ = false := by decide
def m2_0_0 : Training := ⟨["b"],[],[("h",[])],[]⟩
def s2_0_0 : Sealed m2_0_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_0 s2_0_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_0 s2_0_0 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_0 s2_0_0 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_0 s2_0_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_0 s2_0_0 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_0 s2_0_0 ⟨"b","y"⟩ = false := by decide
def m2_0_1 : Training := ⟨["b"],[],[("h",[("a","x")])],[]⟩
def s2_0_1 : Sealed m2_0_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_1 s2_0_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_1 s2_0_1 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_1 s2_0_1 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_1 s2_0_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_1 s2_0_1 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_1 s2_0_1 ⟨"b","y"⟩ = false := by decide
def m2_0_2 : Training := ⟨["b"],[],[("h",[("a","y")])],[]⟩
def s2_0_2 : Sealed m2_0_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_2 s2_0_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_2 s2_0_2 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_2 s2_0_2 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_2 s2_0_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_2 s2_0_2 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_2 s2_0_2 ⟨"b","y"⟩ = false := by decide
def m2_0_3 : Training := ⟨["b"],[],[("h",[("a","x"),("a","y")])],[]⟩
def s2_0_3 : Sealed m2_0_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_3 s2_0_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_3 s2_0_3 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_3 s2_0_3 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_3 s2_0_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_3 s2_0_3 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_3 s2_0_3 ⟨"b","y"⟩ = false := by decide
def m2_0_4 : Training := ⟨["b"],[],[("h",[("b","x")])],[]⟩
def s2_0_4 : Sealed m2_0_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_4 s2_0_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_4 s2_0_4 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_4 s2_0_4 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_4 s2_0_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_4 s2_0_4 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_4 s2_0_4 ⟨"b","y"⟩ = false := by decide
def m2_0_5 : Training := ⟨["b"],[],[("h",[("a","x"),("b","x")])],[]⟩
def s2_0_5 : Sealed m2_0_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_5 s2_0_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_5 s2_0_5 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_5 s2_0_5 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_5 s2_0_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_5 s2_0_5 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_5 s2_0_5 ⟨"b","y"⟩ = false := by decide
def m2_0_6 : Training := ⟨["b"],[],[("h",[("a","y"),("b","x")])],[]⟩
def s2_0_6 : Sealed m2_0_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_6 s2_0_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_6 s2_0_6 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_6 s2_0_6 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_6 s2_0_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_6 s2_0_6 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_6 s2_0_6 ⟨"b","y"⟩ = false := by decide
def m2_0_7 : Training := ⟨["b"],[],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s2_0_7 : Sealed m2_0_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_7 s2_0_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_7 s2_0_7 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_7 s2_0_7 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_7 s2_0_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_7 s2_0_7 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_7 s2_0_7 ⟨"b","y"⟩ = false := by decide
def m2_0_8 : Training := ⟨["b"],[],[("h",[("b","y")])],[]⟩
def s2_0_8 : Sealed m2_0_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_8 s2_0_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_8 s2_0_8 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_8 s2_0_8 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_8 s2_0_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_8 s2_0_8 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_8 s2_0_8 ⟨"b","y"⟩ = false := by decide
def m2_0_9 : Training := ⟨["b"],[],[("h",[("a","x"),("b","y")])],[]⟩
def s2_0_9 : Sealed m2_0_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_9 s2_0_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_9 s2_0_9 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_9 s2_0_9 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_9 s2_0_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_9 s2_0_9 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_9 s2_0_9 ⟨"b","y"⟩ = false := by decide
def m2_0_10 : Training := ⟨["b"],[],[("h",[("a","y"),("b","y")])],[]⟩
def s2_0_10 : Sealed m2_0_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_10 s2_0_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_10 s2_0_10 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_10 s2_0_10 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_10 s2_0_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_10 s2_0_10 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_10 s2_0_10 ⟨"b","y"⟩ = false := by decide
def m2_0_11 : Training := ⟨["b"],[],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s2_0_11 : Sealed m2_0_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_11 s2_0_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_11 s2_0_11 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_11 s2_0_11 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_11 s2_0_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_11 s2_0_11 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_11 s2_0_11 ⟨"b","y"⟩ = false := by decide
def m2_0_12 : Training := ⟨["b"],[],[("h",[("b","x"),("b","y")])],[]⟩
def s2_0_12 : Sealed m2_0_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_12 s2_0_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_12 s2_0_12 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_12 s2_0_12 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_12 s2_0_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_12 s2_0_12 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_12 s2_0_12 ⟨"b","y"⟩ = false := by decide
def m2_0_13 : Training := ⟨["b"],[],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s2_0_13 : Sealed m2_0_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_13 s2_0_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_13 s2_0_13 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_13 s2_0_13 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_13 s2_0_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_13 s2_0_13 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_13 s2_0_13 ⟨"b","y"⟩ = false := by decide
def m2_0_14 : Training := ⟨["b"],[],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s2_0_14 : Sealed m2_0_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_14 s2_0_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_14 s2_0_14 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_14 s2_0_14 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_14 s2_0_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_14 s2_0_14 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_14 s2_0_14 ⟨"b","y"⟩ = false := by decide
def m2_0_15 : Training := ⟨["b"],[],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s2_0_15 : Sealed m2_0_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_0_15 s2_0_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_15 s2_0_15 ⟨"a","x"⟩ = false := by decide
example : falsified m2_0_15 s2_0_15 ⟨"a","y"⟩ = false := by decide
example : predict m2_0_15 s2_0_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_0_15 s2_0_15 ⟨"b","x"⟩ = false := by decide
example : falsified m2_0_15 s2_0_15 ⟨"b","y"⟩ = false := by decide
def m2_1_0 : Training := ⟨["b"],["x"],[("h",[])],[]⟩
def s2_1_0 : Sealed m2_1_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_0 s2_1_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_0 s2_1_0 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_0 s2_1_0 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_0 s2_1_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_0 s2_1_0 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_0 s2_1_0 ⟨"b","y"⟩ = false := by decide
def m2_1_1 : Training := ⟨["b"],["x"],[("h",[("a","x")])],[]⟩
def s2_1_1 : Sealed m2_1_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_1 s2_1_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_1 s2_1_1 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_1 s2_1_1 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_1 s2_1_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_1 s2_1_1 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_1 s2_1_1 ⟨"b","y"⟩ = false := by decide
def m2_1_2 : Training := ⟨["b"],["x"],[("h",[("a","y")])],[]⟩
def s2_1_2 : Sealed m2_1_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_2 s2_1_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_2 s2_1_2 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_2 s2_1_2 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_2 s2_1_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_2 s2_1_2 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_2 s2_1_2 ⟨"b","y"⟩ = false := by decide
def m2_1_3 : Training := ⟨["b"],["x"],[("h",[("a","x"),("a","y")])],[]⟩
def s2_1_3 : Sealed m2_1_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_3 s2_1_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_3 s2_1_3 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_3 s2_1_3 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_3 s2_1_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_3 s2_1_3 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_3 s2_1_3 ⟨"b","y"⟩ = false := by decide
def m2_1_4 : Training := ⟨["b"],["x"],[("h",[("b","x")])],[]⟩
def s2_1_4 : Sealed m2_1_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_4 s2_1_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_4 s2_1_4 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_4 s2_1_4 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_4 s2_1_4 "b" = .ok "x" := rfl
example : falsified m2_1_4 s2_1_4 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_4 s2_1_4 ⟨"b","y"⟩ = true := by decide
def m2_1_5 : Training := ⟨["b"],["x"],[("h",[("a","x"),("b","x")])],[]⟩
def s2_1_5 : Sealed m2_1_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_5 s2_1_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_5 s2_1_5 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_5 s2_1_5 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_5 s2_1_5 "b" = .ok "x" := rfl
example : falsified m2_1_5 s2_1_5 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_5 s2_1_5 ⟨"b","y"⟩ = true := by decide
def m2_1_6 : Training := ⟨["b"],["x"],[("h",[("a","y"),("b","x")])],[]⟩
def s2_1_6 : Sealed m2_1_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_6 s2_1_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_6 s2_1_6 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_6 s2_1_6 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_6 s2_1_6 "b" = .ok "x" := rfl
example : falsified m2_1_6 s2_1_6 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_6 s2_1_6 ⟨"b","y"⟩ = true := by decide
def m2_1_7 : Training := ⟨["b"],["x"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s2_1_7 : Sealed m2_1_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_7 s2_1_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_7 s2_1_7 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_7 s2_1_7 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_7 s2_1_7 "b" = .ok "x" := rfl
example : falsified m2_1_7 s2_1_7 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_7 s2_1_7 ⟨"b","y"⟩ = true := by decide
def m2_1_8 : Training := ⟨["b"],["x"],[("h",[("b","y")])],[]⟩
def s2_1_8 : Sealed m2_1_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_8 s2_1_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_8 s2_1_8 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_8 s2_1_8 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_8 s2_1_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_8 s2_1_8 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_8 s2_1_8 ⟨"b","y"⟩ = false := by decide
def m2_1_9 : Training := ⟨["b"],["x"],[("h",[("a","x"),("b","y")])],[]⟩
def s2_1_9 : Sealed m2_1_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_9 s2_1_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_9 s2_1_9 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_9 s2_1_9 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_9 s2_1_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_9 s2_1_9 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_9 s2_1_9 ⟨"b","y"⟩ = false := by decide
def m2_1_10 : Training := ⟨["b"],["x"],[("h",[("a","y"),("b","y")])],[]⟩
def s2_1_10 : Sealed m2_1_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_10 s2_1_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_10 s2_1_10 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_10 s2_1_10 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_10 s2_1_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_10 s2_1_10 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_10 s2_1_10 ⟨"b","y"⟩ = false := by decide
def m2_1_11 : Training := ⟨["b"],["x"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s2_1_11 : Sealed m2_1_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_11 s2_1_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_11 s2_1_11 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_11 s2_1_11 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_11 s2_1_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_11 s2_1_11 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_11 s2_1_11 ⟨"b","y"⟩ = false := by decide
def m2_1_12 : Training := ⟨["b"],["x"],[("h",[("b","x"),("b","y")])],[]⟩
def s2_1_12 : Sealed m2_1_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_12 s2_1_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_12 s2_1_12 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_12 s2_1_12 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_12 s2_1_12 "b" = .ok "x" := rfl
example : falsified m2_1_12 s2_1_12 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_12 s2_1_12 ⟨"b","y"⟩ = true := by decide
def m2_1_13 : Training := ⟨["b"],["x"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s2_1_13 : Sealed m2_1_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_13 s2_1_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_13 s2_1_13 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_13 s2_1_13 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_13 s2_1_13 "b" = .ok "x" := rfl
example : falsified m2_1_13 s2_1_13 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_13 s2_1_13 ⟨"b","y"⟩ = true := by decide
def m2_1_14 : Training := ⟨["b"],["x"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s2_1_14 : Sealed m2_1_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_14 s2_1_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_14 s2_1_14 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_14 s2_1_14 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_14 s2_1_14 "b" = .ok "x" := rfl
example : falsified m2_1_14 s2_1_14 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_14 s2_1_14 ⟨"b","y"⟩ = true := by decide
def m2_1_15 : Training := ⟨["b"],["x"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s2_1_15 : Sealed m2_1_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_1_15 s2_1_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_1_15 s2_1_15 ⟨"a","x"⟩ = false := by decide
example : falsified m2_1_15 s2_1_15 ⟨"a","y"⟩ = false := by decide
example : predict m2_1_15 s2_1_15 "b" = .ok "x" := rfl
example : falsified m2_1_15 s2_1_15 ⟨"b","x"⟩ = false := by decide
example : falsified m2_1_15 s2_1_15 ⟨"b","y"⟩ = true := by decide
def m2_2_0 : Training := ⟨["b"],["y"],[("h",[])],[]⟩
def s2_2_0 : Sealed m2_2_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_0 s2_2_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_0 s2_2_0 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_0 s2_2_0 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_0 s2_2_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_0 s2_2_0 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_0 s2_2_0 ⟨"b","y"⟩ = false := by decide
def m2_2_1 : Training := ⟨["b"],["y"],[("h",[("a","x")])],[]⟩
def s2_2_1 : Sealed m2_2_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_1 s2_2_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_1 s2_2_1 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_1 s2_2_1 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_1 s2_2_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_1 s2_2_1 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_1 s2_2_1 ⟨"b","y"⟩ = false := by decide
def m2_2_2 : Training := ⟨["b"],["y"],[("h",[("a","y")])],[]⟩
def s2_2_2 : Sealed m2_2_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_2 s2_2_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_2 s2_2_2 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_2 s2_2_2 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_2 s2_2_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_2 s2_2_2 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_2 s2_2_2 ⟨"b","y"⟩ = false := by decide
def m2_2_3 : Training := ⟨["b"],["y"],[("h",[("a","x"),("a","y")])],[]⟩
def s2_2_3 : Sealed m2_2_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_3 s2_2_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_3 s2_2_3 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_3 s2_2_3 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_3 s2_2_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_3 s2_2_3 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_3 s2_2_3 ⟨"b","y"⟩ = false := by decide
def m2_2_4 : Training := ⟨["b"],["y"],[("h",[("b","x")])],[]⟩
def s2_2_4 : Sealed m2_2_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_4 s2_2_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_4 s2_2_4 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_4 s2_2_4 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_4 s2_2_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_4 s2_2_4 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_4 s2_2_4 ⟨"b","y"⟩ = false := by decide
def m2_2_5 : Training := ⟨["b"],["y"],[("h",[("a","x"),("b","x")])],[]⟩
def s2_2_5 : Sealed m2_2_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_5 s2_2_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_5 s2_2_5 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_5 s2_2_5 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_5 s2_2_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_5 s2_2_5 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_5 s2_2_5 ⟨"b","y"⟩ = false := by decide
def m2_2_6 : Training := ⟨["b"],["y"],[("h",[("a","y"),("b","x")])],[]⟩
def s2_2_6 : Sealed m2_2_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_6 s2_2_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_6 s2_2_6 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_6 s2_2_6 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_6 s2_2_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_6 s2_2_6 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_6 s2_2_6 ⟨"b","y"⟩ = false := by decide
def m2_2_7 : Training := ⟨["b"],["y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s2_2_7 : Sealed m2_2_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_7 s2_2_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_7 s2_2_7 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_7 s2_2_7 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_7 s2_2_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_7 s2_2_7 ⟨"b","x"⟩ = false := by decide
example : falsified m2_2_7 s2_2_7 ⟨"b","y"⟩ = false := by decide
def m2_2_8 : Training := ⟨["b"],["y"],[("h",[("b","y")])],[]⟩
def s2_2_8 : Sealed m2_2_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_8 s2_2_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_8 s2_2_8 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_8 s2_2_8 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_8 s2_2_8 "b" = .ok "y" := rfl
example : falsified m2_2_8 s2_2_8 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_8 s2_2_8 ⟨"b","y"⟩ = false := by decide
def m2_2_9 : Training := ⟨["b"],["y"],[("h",[("a","x"),("b","y")])],[]⟩
def s2_2_9 : Sealed m2_2_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_9 s2_2_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_9 s2_2_9 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_9 s2_2_9 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_9 s2_2_9 "b" = .ok "y" := rfl
example : falsified m2_2_9 s2_2_9 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_9 s2_2_9 ⟨"b","y"⟩ = false := by decide
def m2_2_10 : Training := ⟨["b"],["y"],[("h",[("a","y"),("b","y")])],[]⟩
def s2_2_10 : Sealed m2_2_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_10 s2_2_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_10 s2_2_10 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_10 s2_2_10 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_10 s2_2_10 "b" = .ok "y" := rfl
example : falsified m2_2_10 s2_2_10 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_10 s2_2_10 ⟨"b","y"⟩ = false := by decide
def m2_2_11 : Training := ⟨["b"],["y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s2_2_11 : Sealed m2_2_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_11 s2_2_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_11 s2_2_11 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_11 s2_2_11 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_11 s2_2_11 "b" = .ok "y" := rfl
example : falsified m2_2_11 s2_2_11 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_11 s2_2_11 ⟨"b","y"⟩ = false := by decide
def m2_2_12 : Training := ⟨["b"],["y"],[("h",[("b","x"),("b","y")])],[]⟩
def s2_2_12 : Sealed m2_2_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_12 s2_2_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_12 s2_2_12 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_12 s2_2_12 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_12 s2_2_12 "b" = .ok "y" := rfl
example : falsified m2_2_12 s2_2_12 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_12 s2_2_12 ⟨"b","y"⟩ = false := by decide
def m2_2_13 : Training := ⟨["b"],["y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s2_2_13 : Sealed m2_2_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_13 s2_2_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_13 s2_2_13 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_13 s2_2_13 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_13 s2_2_13 "b" = .ok "y" := rfl
example : falsified m2_2_13 s2_2_13 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_13 s2_2_13 ⟨"b","y"⟩ = false := by decide
def m2_2_14 : Training := ⟨["b"],["y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s2_2_14 : Sealed m2_2_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_14 s2_2_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_14 s2_2_14 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_14 s2_2_14 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_14 s2_2_14 "b" = .ok "y" := rfl
example : falsified m2_2_14 s2_2_14 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_14 s2_2_14 ⟨"b","y"⟩ = false := by decide
def m2_2_15 : Training := ⟨["b"],["y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s2_2_15 : Sealed m2_2_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_2_15 s2_2_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_2_15 s2_2_15 ⟨"a","x"⟩ = false := by decide
example : falsified m2_2_15 s2_2_15 ⟨"a","y"⟩ = false := by decide
example : predict m2_2_15 s2_2_15 "b" = .ok "y" := rfl
example : falsified m2_2_15 s2_2_15 ⟨"b","x"⟩ = true := by decide
example : falsified m2_2_15 s2_2_15 ⟨"b","y"⟩ = false := by decide
def m2_3_0 : Training := ⟨["b"],["x","y"],[("h",[])],[]⟩
def s2_3_0 : Sealed m2_3_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_0 s2_3_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_0 s2_3_0 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_0 s2_3_0 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_0 s2_3_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_0 s2_3_0 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_0 s2_3_0 ⟨"b","y"⟩ = false := by decide
def m2_3_1 : Training := ⟨["b"],["x","y"],[("h",[("a","x")])],[]⟩
def s2_3_1 : Sealed m2_3_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_1 s2_3_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_1 s2_3_1 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_1 s2_3_1 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_1 s2_3_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_1 s2_3_1 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_1 s2_3_1 ⟨"b","y"⟩ = false := by decide
def m2_3_2 : Training := ⟨["b"],["x","y"],[("h",[("a","y")])],[]⟩
def s2_3_2 : Sealed m2_3_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_2 s2_3_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_2 s2_3_2 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_2 s2_3_2 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_2 s2_3_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_2 s2_3_2 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_2 s2_3_2 ⟨"b","y"⟩ = false := by decide
def m2_3_3 : Training := ⟨["b"],["x","y"],[("h",[("a","x"),("a","y")])],[]⟩
def s2_3_3 : Sealed m2_3_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_3 s2_3_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_3 s2_3_3 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_3 s2_3_3 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_3 s2_3_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_3 s2_3_3 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_3 s2_3_3 ⟨"b","y"⟩ = false := by decide
def m2_3_4 : Training := ⟨["b"],["x","y"],[("h",[("b","x")])],[]⟩
def s2_3_4 : Sealed m2_3_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_4 s2_3_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_4 s2_3_4 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_4 s2_3_4 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_4 s2_3_4 "b" = .ok "x" := rfl
example : falsified m2_3_4 s2_3_4 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_4 s2_3_4 ⟨"b","y"⟩ = true := by decide
def m2_3_5 : Training := ⟨["b"],["x","y"],[("h",[("a","x"),("b","x")])],[]⟩
def s2_3_5 : Sealed m2_3_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_5 s2_3_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_5 s2_3_5 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_5 s2_3_5 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_5 s2_3_5 "b" = .ok "x" := rfl
example : falsified m2_3_5 s2_3_5 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_5 s2_3_5 ⟨"b","y"⟩ = true := by decide
def m2_3_6 : Training := ⟨["b"],["x","y"],[("h",[("a","y"),("b","x")])],[]⟩
def s2_3_6 : Sealed m2_3_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_6 s2_3_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_6 s2_3_6 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_6 s2_3_6 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_6 s2_3_6 "b" = .ok "x" := rfl
example : falsified m2_3_6 s2_3_6 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_6 s2_3_6 ⟨"b","y"⟩ = true := by decide
def m2_3_7 : Training := ⟨["b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s2_3_7 : Sealed m2_3_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_7 s2_3_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_7 s2_3_7 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_7 s2_3_7 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_7 s2_3_7 "b" = .ok "x" := rfl
example : falsified m2_3_7 s2_3_7 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_7 s2_3_7 ⟨"b","y"⟩ = true := by decide
def m2_3_8 : Training := ⟨["b"],["x","y"],[("h",[("b","y")])],[]⟩
def s2_3_8 : Sealed m2_3_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_8 s2_3_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_8 s2_3_8 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_8 s2_3_8 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_8 s2_3_8 "b" = .ok "y" := rfl
example : falsified m2_3_8 s2_3_8 ⟨"b","x"⟩ = true := by decide
example : falsified m2_3_8 s2_3_8 ⟨"b","y"⟩ = false := by decide
def m2_3_9 : Training := ⟨["b"],["x","y"],[("h",[("a","x"),("b","y")])],[]⟩
def s2_3_9 : Sealed m2_3_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_9 s2_3_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_9 s2_3_9 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_9 s2_3_9 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_9 s2_3_9 "b" = .ok "y" := rfl
example : falsified m2_3_9 s2_3_9 ⟨"b","x"⟩ = true := by decide
example : falsified m2_3_9 s2_3_9 ⟨"b","y"⟩ = false := by decide
def m2_3_10 : Training := ⟨["b"],["x","y"],[("h",[("a","y"),("b","y")])],[]⟩
def s2_3_10 : Sealed m2_3_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_10 s2_3_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_10 s2_3_10 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_10 s2_3_10 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_10 s2_3_10 "b" = .ok "y" := rfl
example : falsified m2_3_10 s2_3_10 ⟨"b","x"⟩ = true := by decide
example : falsified m2_3_10 s2_3_10 ⟨"b","y"⟩ = false := by decide
def m2_3_11 : Training := ⟨["b"],["x","y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s2_3_11 : Sealed m2_3_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_11 s2_3_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_11 s2_3_11 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_11 s2_3_11 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_11 s2_3_11 "b" = .ok "y" := rfl
example : falsified m2_3_11 s2_3_11 ⟨"b","x"⟩ = true := by decide
example : falsified m2_3_11 s2_3_11 ⟨"b","y"⟩ = false := by decide
def m2_3_12 : Training := ⟨["b"],["x","y"],[("h",[("b","x"),("b","y")])],[]⟩
def s2_3_12 : Sealed m2_3_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_12 s2_3_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_12 s2_3_12 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_12 s2_3_12 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_12 s2_3_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_12 s2_3_12 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_12 s2_3_12 ⟨"b","y"⟩ = false := by decide
def m2_3_13 : Training := ⟨["b"],["x","y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s2_3_13 : Sealed m2_3_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_13 s2_3_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_13 s2_3_13 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_13 s2_3_13 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_13 s2_3_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_13 s2_3_13 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_13 s2_3_13 ⟨"b","y"⟩ = false := by decide
def m2_3_14 : Training := ⟨["b"],["x","y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s2_3_14 : Sealed m2_3_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_14 s2_3_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_14 s2_3_14 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_14 s2_3_14 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_14 s2_3_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_14 s2_3_14 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_14 s2_3_14 ⟨"b","y"⟩ = false := by decide
def m2_3_15 : Training := ⟨["b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s2_3_15 : Sealed m2_3_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m2_3_15 s2_3_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_15 s2_3_15 ⟨"a","x"⟩ = false := by decide
example : falsified m2_3_15 s2_3_15 ⟨"a","y"⟩ = false := by decide
example : predict m2_3_15 s2_3_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m2_3_15 s2_3_15 ⟨"b","x"⟩ = false := by decide
example : falsified m2_3_15 s2_3_15 ⟨"b","y"⟩ = false := by decide
def m3_0_0 : Training := ⟨["a","b"],[],[("h",[])],[]⟩
def s3_0_0 : Sealed m3_0_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_0 s3_0_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_0 s3_0_0 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_0 s3_0_0 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_0 s3_0_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_0 s3_0_0 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_0 s3_0_0 ⟨"b","y"⟩ = false := by decide
def m3_0_1 : Training := ⟨["a","b"],[],[("h",[("a","x")])],[]⟩
def s3_0_1 : Sealed m3_0_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_1 s3_0_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_1 s3_0_1 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_1 s3_0_1 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_1 s3_0_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_1 s3_0_1 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_1 s3_0_1 ⟨"b","y"⟩ = false := by decide
def m3_0_2 : Training := ⟨["a","b"],[],[("h",[("a","y")])],[]⟩
def s3_0_2 : Sealed m3_0_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_2 s3_0_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_2 s3_0_2 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_2 s3_0_2 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_2 s3_0_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_2 s3_0_2 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_2 s3_0_2 ⟨"b","y"⟩ = false := by decide
def m3_0_3 : Training := ⟨["a","b"],[],[("h",[("a","x"),("a","y")])],[]⟩
def s3_0_3 : Sealed m3_0_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_3 s3_0_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_3 s3_0_3 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_3 s3_0_3 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_3 s3_0_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_3 s3_0_3 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_3 s3_0_3 ⟨"b","y"⟩ = false := by decide
def m3_0_4 : Training := ⟨["a","b"],[],[("h",[("b","x")])],[]⟩
def s3_0_4 : Sealed m3_0_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_4 s3_0_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_4 s3_0_4 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_4 s3_0_4 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_4 s3_0_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_4 s3_0_4 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_4 s3_0_4 ⟨"b","y"⟩ = false := by decide
def m3_0_5 : Training := ⟨["a","b"],[],[("h",[("a","x"),("b","x")])],[]⟩
def s3_0_5 : Sealed m3_0_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_5 s3_0_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_5 s3_0_5 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_5 s3_0_5 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_5 s3_0_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_5 s3_0_5 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_5 s3_0_5 ⟨"b","y"⟩ = false := by decide
def m3_0_6 : Training := ⟨["a","b"],[],[("h",[("a","y"),("b","x")])],[]⟩
def s3_0_6 : Sealed m3_0_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_6 s3_0_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_6 s3_0_6 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_6 s3_0_6 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_6 s3_0_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_6 s3_0_6 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_6 s3_0_6 ⟨"b","y"⟩ = false := by decide
def m3_0_7 : Training := ⟨["a","b"],[],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s3_0_7 : Sealed m3_0_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_7 s3_0_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_7 s3_0_7 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_7 s3_0_7 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_7 s3_0_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_7 s3_0_7 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_7 s3_0_7 ⟨"b","y"⟩ = false := by decide
def m3_0_8 : Training := ⟨["a","b"],[],[("h",[("b","y")])],[]⟩
def s3_0_8 : Sealed m3_0_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_8 s3_0_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_8 s3_0_8 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_8 s3_0_8 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_8 s3_0_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_8 s3_0_8 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_8 s3_0_8 ⟨"b","y"⟩ = false := by decide
def m3_0_9 : Training := ⟨["a","b"],[],[("h",[("a","x"),("b","y")])],[]⟩
def s3_0_9 : Sealed m3_0_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_9 s3_0_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_9 s3_0_9 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_9 s3_0_9 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_9 s3_0_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_9 s3_0_9 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_9 s3_0_9 ⟨"b","y"⟩ = false := by decide
def m3_0_10 : Training := ⟨["a","b"],[],[("h",[("a","y"),("b","y")])],[]⟩
def s3_0_10 : Sealed m3_0_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_10 s3_0_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_10 s3_0_10 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_10 s3_0_10 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_10 s3_0_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_10 s3_0_10 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_10 s3_0_10 ⟨"b","y"⟩ = false := by decide
def m3_0_11 : Training := ⟨["a","b"],[],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s3_0_11 : Sealed m3_0_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_11 s3_0_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_11 s3_0_11 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_11 s3_0_11 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_11 s3_0_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_11 s3_0_11 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_11 s3_0_11 ⟨"b","y"⟩ = false := by decide
def m3_0_12 : Training := ⟨["a","b"],[],[("h",[("b","x"),("b","y")])],[]⟩
def s3_0_12 : Sealed m3_0_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_12 s3_0_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_12 s3_0_12 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_12 s3_0_12 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_12 s3_0_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_12 s3_0_12 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_12 s3_0_12 ⟨"b","y"⟩ = false := by decide
def m3_0_13 : Training := ⟨["a","b"],[],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s3_0_13 : Sealed m3_0_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_13 s3_0_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_13 s3_0_13 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_13 s3_0_13 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_13 s3_0_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_13 s3_0_13 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_13 s3_0_13 ⟨"b","y"⟩ = false := by decide
def m3_0_14 : Training := ⟨["a","b"],[],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s3_0_14 : Sealed m3_0_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_14 s3_0_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_14 s3_0_14 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_14 s3_0_14 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_14 s3_0_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_14 s3_0_14 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_14 s3_0_14 ⟨"b","y"⟩ = false := by decide
def m3_0_15 : Training := ⟨["a","b"],[],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s3_0_15 : Sealed m3_0_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_0_15 s3_0_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_15 s3_0_15 ⟨"a","x"⟩ = false := by decide
example : falsified m3_0_15 s3_0_15 ⟨"a","y"⟩ = false := by decide
example : predict m3_0_15 s3_0_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_0_15 s3_0_15 ⟨"b","x"⟩ = false := by decide
example : falsified m3_0_15 s3_0_15 ⟨"b","y"⟩ = false := by decide
def m3_1_0 : Training := ⟨["a","b"],["x"],[("h",[])],[]⟩
def s3_1_0 : Sealed m3_1_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_0 s3_1_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_0 s3_1_0 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_0 s3_1_0 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_0 s3_1_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_0 s3_1_0 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_0 s3_1_0 ⟨"b","y"⟩ = false := by decide
def m3_1_1 : Training := ⟨["a","b"],["x"],[("h",[("a","x")])],[]⟩
def s3_1_1 : Sealed m3_1_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_1 s3_1_1 "a" = .ok "x" := rfl
example : falsified m3_1_1 s3_1_1 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_1 s3_1_1 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_1 s3_1_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_1 s3_1_1 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_1 s3_1_1 ⟨"b","y"⟩ = false := by decide
def m3_1_2 : Training := ⟨["a","b"],["x"],[("h",[("a","y")])],[]⟩
def s3_1_2 : Sealed m3_1_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_2 s3_1_2 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_2 s3_1_2 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_2 s3_1_2 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_2 s3_1_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_2 s3_1_2 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_2 s3_1_2 ⟨"b","y"⟩ = false := by decide
def m3_1_3 : Training := ⟨["a","b"],["x"],[("h",[("a","x"),("a","y")])],[]⟩
def s3_1_3 : Sealed m3_1_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_3 s3_1_3 "a" = .ok "x" := rfl
example : falsified m3_1_3 s3_1_3 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_3 s3_1_3 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_3 s3_1_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_3 s3_1_3 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_3 s3_1_3 ⟨"b","y"⟩ = false := by decide
def m3_1_4 : Training := ⟨["a","b"],["x"],[("h",[("b","x")])],[]⟩
def s3_1_4 : Sealed m3_1_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_4 s3_1_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_4 s3_1_4 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_4 s3_1_4 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_4 s3_1_4 "b" = .ok "x" := rfl
example : falsified m3_1_4 s3_1_4 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_4 s3_1_4 ⟨"b","y"⟩ = true := by decide
def m3_1_5 : Training := ⟨["a","b"],["x"],[("h",[("a","x"),("b","x")])],[]⟩
def s3_1_5 : Sealed m3_1_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_5 s3_1_5 "a" = .ok "x" := rfl
example : falsified m3_1_5 s3_1_5 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_5 s3_1_5 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_5 s3_1_5 "b" = .ok "x" := rfl
example : falsified m3_1_5 s3_1_5 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_5 s3_1_5 ⟨"b","y"⟩ = true := by decide
def m3_1_6 : Training := ⟨["a","b"],["x"],[("h",[("a","y"),("b","x")])],[]⟩
def s3_1_6 : Sealed m3_1_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_6 s3_1_6 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_6 s3_1_6 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_6 s3_1_6 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_6 s3_1_6 "b" = .ok "x" := rfl
example : falsified m3_1_6 s3_1_6 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_6 s3_1_6 ⟨"b","y"⟩ = true := by decide
def m3_1_7 : Training := ⟨["a","b"],["x"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s3_1_7 : Sealed m3_1_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_7 s3_1_7 "a" = .ok "x" := rfl
example : falsified m3_1_7 s3_1_7 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_7 s3_1_7 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_7 s3_1_7 "b" = .ok "x" := rfl
example : falsified m3_1_7 s3_1_7 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_7 s3_1_7 ⟨"b","y"⟩ = true := by decide
def m3_1_8 : Training := ⟨["a","b"],["x"],[("h",[("b","y")])],[]⟩
def s3_1_8 : Sealed m3_1_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_8 s3_1_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_8 s3_1_8 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_8 s3_1_8 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_8 s3_1_8 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_8 s3_1_8 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_8 s3_1_8 ⟨"b","y"⟩ = false := by decide
def m3_1_9 : Training := ⟨["a","b"],["x"],[("h",[("a","x"),("b","y")])],[]⟩
def s3_1_9 : Sealed m3_1_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_9 s3_1_9 "a" = .ok "x" := rfl
example : falsified m3_1_9 s3_1_9 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_9 s3_1_9 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_9 s3_1_9 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_9 s3_1_9 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_9 s3_1_9 ⟨"b","y"⟩ = false := by decide
def m3_1_10 : Training := ⟨["a","b"],["x"],[("h",[("a","y"),("b","y")])],[]⟩
def s3_1_10 : Sealed m3_1_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_10 s3_1_10 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_10 s3_1_10 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_10 s3_1_10 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_10 s3_1_10 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_10 s3_1_10 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_10 s3_1_10 ⟨"b","y"⟩ = false := by decide
def m3_1_11 : Training := ⟨["a","b"],["x"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s3_1_11 : Sealed m3_1_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_11 s3_1_11 "a" = .ok "x" := rfl
example : falsified m3_1_11 s3_1_11 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_11 s3_1_11 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_11 s3_1_11 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_11 s3_1_11 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_11 s3_1_11 ⟨"b","y"⟩ = false := by decide
def m3_1_12 : Training := ⟨["a","b"],["x"],[("h",[("b","x"),("b","y")])],[]⟩
def s3_1_12 : Sealed m3_1_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_12 s3_1_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_12 s3_1_12 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_12 s3_1_12 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_12 s3_1_12 "b" = .ok "x" := rfl
example : falsified m3_1_12 s3_1_12 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_12 s3_1_12 ⟨"b","y"⟩ = true := by decide
def m3_1_13 : Training := ⟨["a","b"],["x"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s3_1_13 : Sealed m3_1_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_13 s3_1_13 "a" = .ok "x" := rfl
example : falsified m3_1_13 s3_1_13 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_13 s3_1_13 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_13 s3_1_13 "b" = .ok "x" := rfl
example : falsified m3_1_13 s3_1_13 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_13 s3_1_13 ⟨"b","y"⟩ = true := by decide
def m3_1_14 : Training := ⟨["a","b"],["x"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s3_1_14 : Sealed m3_1_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_14 s3_1_14 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_1_14 s3_1_14 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_14 s3_1_14 ⟨"a","y"⟩ = false := by decide
example : predict m3_1_14 s3_1_14 "b" = .ok "x" := rfl
example : falsified m3_1_14 s3_1_14 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_14 s3_1_14 ⟨"b","y"⟩ = true := by decide
def m3_1_15 : Training := ⟨["a","b"],["x"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s3_1_15 : Sealed m3_1_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_1_15 s3_1_15 "a" = .ok "x" := rfl
example : falsified m3_1_15 s3_1_15 ⟨"a","x"⟩ = false := by decide
example : falsified m3_1_15 s3_1_15 ⟨"a","y"⟩ = true := by decide
example : predict m3_1_15 s3_1_15 "b" = .ok "x" := rfl
example : falsified m3_1_15 s3_1_15 ⟨"b","x"⟩ = false := by decide
example : falsified m3_1_15 s3_1_15 ⟨"b","y"⟩ = true := by decide
def m3_2_0 : Training := ⟨["a","b"],["y"],[("h",[])],[]⟩
def s3_2_0 : Sealed m3_2_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_0 s3_2_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_0 s3_2_0 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_0 s3_2_0 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_0 s3_2_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_0 s3_2_0 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_0 s3_2_0 ⟨"b","y"⟩ = false := by decide
def m3_2_1 : Training := ⟨["a","b"],["y"],[("h",[("a","x")])],[]⟩
def s3_2_1 : Sealed m3_2_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_1 s3_2_1 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_1 s3_2_1 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_1 s3_2_1 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_1 s3_2_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_1 s3_2_1 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_1 s3_2_1 ⟨"b","y"⟩ = false := by decide
def m3_2_2 : Training := ⟨["a","b"],["y"],[("h",[("a","y")])],[]⟩
def s3_2_2 : Sealed m3_2_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_2 s3_2_2 "a" = .ok "y" := rfl
example : falsified m3_2_2 s3_2_2 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_2 s3_2_2 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_2 s3_2_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_2 s3_2_2 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_2 s3_2_2 ⟨"b","y"⟩ = false := by decide
def m3_2_3 : Training := ⟨["a","b"],["y"],[("h",[("a","x"),("a","y")])],[]⟩
def s3_2_3 : Sealed m3_2_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_3 s3_2_3 "a" = .ok "y" := rfl
example : falsified m3_2_3 s3_2_3 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_3 s3_2_3 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_3 s3_2_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_3 s3_2_3 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_3 s3_2_3 ⟨"b","y"⟩ = false := by decide
def m3_2_4 : Training := ⟨["a","b"],["y"],[("h",[("b","x")])],[]⟩
def s3_2_4 : Sealed m3_2_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_4 s3_2_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_4 s3_2_4 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_4 s3_2_4 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_4 s3_2_4 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_4 s3_2_4 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_4 s3_2_4 ⟨"b","y"⟩ = false := by decide
def m3_2_5 : Training := ⟨["a","b"],["y"],[("h",[("a","x"),("b","x")])],[]⟩
def s3_2_5 : Sealed m3_2_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_5 s3_2_5 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_5 s3_2_5 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_5 s3_2_5 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_5 s3_2_5 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_5 s3_2_5 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_5 s3_2_5 ⟨"b","y"⟩ = false := by decide
def m3_2_6 : Training := ⟨["a","b"],["y"],[("h",[("a","y"),("b","x")])],[]⟩
def s3_2_6 : Sealed m3_2_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_6 s3_2_6 "a" = .ok "y" := rfl
example : falsified m3_2_6 s3_2_6 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_6 s3_2_6 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_6 s3_2_6 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_6 s3_2_6 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_6 s3_2_6 ⟨"b","y"⟩ = false := by decide
def m3_2_7 : Training := ⟨["a","b"],["y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s3_2_7 : Sealed m3_2_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_7 s3_2_7 "a" = .ok "y" := rfl
example : falsified m3_2_7 s3_2_7 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_7 s3_2_7 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_7 s3_2_7 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_7 s3_2_7 ⟨"b","x"⟩ = false := by decide
example : falsified m3_2_7 s3_2_7 ⟨"b","y"⟩ = false := by decide
def m3_2_8 : Training := ⟨["a","b"],["y"],[("h",[("b","y")])],[]⟩
def s3_2_8 : Sealed m3_2_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_8 s3_2_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_8 s3_2_8 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_8 s3_2_8 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_8 s3_2_8 "b" = .ok "y" := rfl
example : falsified m3_2_8 s3_2_8 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_8 s3_2_8 ⟨"b","y"⟩ = false := by decide
def m3_2_9 : Training := ⟨["a","b"],["y"],[("h",[("a","x"),("b","y")])],[]⟩
def s3_2_9 : Sealed m3_2_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_9 s3_2_9 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_9 s3_2_9 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_9 s3_2_9 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_9 s3_2_9 "b" = .ok "y" := rfl
example : falsified m3_2_9 s3_2_9 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_9 s3_2_9 ⟨"b","y"⟩ = false := by decide
def m3_2_10 : Training := ⟨["a","b"],["y"],[("h",[("a","y"),("b","y")])],[]⟩
def s3_2_10 : Sealed m3_2_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_10 s3_2_10 "a" = .ok "y" := rfl
example : falsified m3_2_10 s3_2_10 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_10 s3_2_10 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_10 s3_2_10 "b" = .ok "y" := rfl
example : falsified m3_2_10 s3_2_10 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_10 s3_2_10 ⟨"b","y"⟩ = false := by decide
def m3_2_11 : Training := ⟨["a","b"],["y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s3_2_11 : Sealed m3_2_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_11 s3_2_11 "a" = .ok "y" := rfl
example : falsified m3_2_11 s3_2_11 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_11 s3_2_11 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_11 s3_2_11 "b" = .ok "y" := rfl
example : falsified m3_2_11 s3_2_11 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_11 s3_2_11 ⟨"b","y"⟩ = false := by decide
def m3_2_12 : Training := ⟨["a","b"],["y"],[("h",[("b","x"),("b","y")])],[]⟩
def s3_2_12 : Sealed m3_2_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_12 s3_2_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_12 s3_2_12 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_12 s3_2_12 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_12 s3_2_12 "b" = .ok "y" := rfl
example : falsified m3_2_12 s3_2_12 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_12 s3_2_12 ⟨"b","y"⟩ = false := by decide
def m3_2_13 : Training := ⟨["a","b"],["y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s3_2_13 : Sealed m3_2_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_13 s3_2_13 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_2_13 s3_2_13 ⟨"a","x"⟩ = false := by decide
example : falsified m3_2_13 s3_2_13 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_13 s3_2_13 "b" = .ok "y" := rfl
example : falsified m3_2_13 s3_2_13 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_13 s3_2_13 ⟨"b","y"⟩ = false := by decide
def m3_2_14 : Training := ⟨["a","b"],["y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s3_2_14 : Sealed m3_2_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_14 s3_2_14 "a" = .ok "y" := rfl
example : falsified m3_2_14 s3_2_14 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_14 s3_2_14 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_14 s3_2_14 "b" = .ok "y" := rfl
example : falsified m3_2_14 s3_2_14 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_14 s3_2_14 ⟨"b","y"⟩ = false := by decide
def m3_2_15 : Training := ⟨["a","b"],["y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s3_2_15 : Sealed m3_2_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_2_15 s3_2_15 "a" = .ok "y" := rfl
example : falsified m3_2_15 s3_2_15 ⟨"a","x"⟩ = true := by decide
example : falsified m3_2_15 s3_2_15 ⟨"a","y"⟩ = false := by decide
example : predict m3_2_15 s3_2_15 "b" = .ok "y" := rfl
example : falsified m3_2_15 s3_2_15 ⟨"b","x"⟩ = true := by decide
example : falsified m3_2_15 s3_2_15 ⟨"b","y"⟩ = false := by decide
def m3_3_0 : Training := ⟨["a","b"],["x","y"],[("h",[])],[]⟩
def s3_3_0 : Sealed m3_3_0 := ⟨("h",[]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_0 s3_3_0 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_0 s3_3_0 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_0 s3_3_0 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_0 s3_3_0 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_0 s3_3_0 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_0 s3_3_0 ⟨"b","y"⟩ = false := by decide
def m3_3_1 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x")])],[]⟩
def s3_3_1 : Sealed m3_3_1 := ⟨("h",[("a","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_1 s3_3_1 "a" = .ok "x" := rfl
example : falsified m3_3_1 s3_3_1 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_1 s3_3_1 ⟨"a","y"⟩ = true := by decide
example : predict m3_3_1 s3_3_1 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_1 s3_3_1 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_1 s3_3_1 ⟨"b","y"⟩ = false := by decide
def m3_3_2 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y")])],[]⟩
def s3_3_2 : Sealed m3_3_2 := ⟨("h",[("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_2 s3_3_2 "a" = .ok "y" := rfl
example : falsified m3_3_2 s3_3_2 ⟨"a","x"⟩ = true := by decide
example : falsified m3_3_2 s3_3_2 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_2 s3_3_2 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_2 s3_3_2 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_2 s3_3_2 ⟨"b","y"⟩ = false := by decide
def m3_3_3 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y")])],[]⟩
def s3_3_3 : Sealed m3_3_3 := ⟨("h",[("a","x"),("a","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_3 s3_3_3 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_3 s3_3_3 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_3 s3_3_3 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_3 s3_3_3 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_3 s3_3_3 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_3 s3_3_3 ⟨"b","y"⟩ = false := by decide
def m3_3_4 : Training := ⟨["a","b"],["x","y"],[("h",[("b","x")])],[]⟩
def s3_3_4 : Sealed m3_3_4 := ⟨("h",[("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_4 s3_3_4 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_4 s3_3_4 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_4 s3_3_4 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_4 s3_3_4 "b" = .ok "x" := rfl
example : falsified m3_3_4 s3_3_4 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_4 s3_3_4 ⟨"b","y"⟩ = true := by decide
def m3_3_5 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","x")])],[]⟩
def s3_3_5 : Sealed m3_3_5 := ⟨("h",[("a","x"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_5 s3_3_5 "a" = .ok "x" := rfl
example : falsified m3_3_5 s3_3_5 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_5 s3_3_5 ⟨"a","y"⟩ = true := by decide
example : predict m3_3_5 s3_3_5 "b" = .ok "x" := rfl
example : falsified m3_3_5 s3_3_5 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_5 s3_3_5 ⟨"b","y"⟩ = true := by decide
def m3_3_6 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y"),("b","x")])],[]⟩
def s3_3_6 : Sealed m3_3_6 := ⟨("h",[("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_6 s3_3_6 "a" = .ok "y" := rfl
example : falsified m3_3_6 s3_3_6 ⟨"a","x"⟩ = true := by decide
example : falsified m3_3_6 s3_3_6 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_6 s3_3_6 "b" = .ok "x" := rfl
example : falsified m3_3_6 s3_3_6 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_6 s3_3_6 ⟨"b","y"⟩ = true := by decide
def m3_3_7 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def s3_3_7 : Sealed m3_3_7 := ⟨("h",[("a","x"),("a","y"),("b","x")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_7 s3_3_7 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_7 s3_3_7 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_7 s3_3_7 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_7 s3_3_7 "b" = .ok "x" := rfl
example : falsified m3_3_7 s3_3_7 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_7 s3_3_7 ⟨"b","y"⟩ = true := by decide
def m3_3_8 : Training := ⟨["a","b"],["x","y"],[("h",[("b","y")])],[]⟩
def s3_3_8 : Sealed m3_3_8 := ⟨("h",[("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_8 s3_3_8 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_8 s3_3_8 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_8 s3_3_8 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_8 s3_3_8 "b" = .ok "y" := rfl
example : falsified m3_3_8 s3_3_8 ⟨"b","x"⟩ = true := by decide
example : falsified m3_3_8 s3_3_8 ⟨"b","y"⟩ = false := by decide
def m3_3_9 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","y")])],[]⟩
def s3_3_9 : Sealed m3_3_9 := ⟨("h",[("a","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_9 s3_3_9 "a" = .ok "x" := rfl
example : falsified m3_3_9 s3_3_9 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_9 s3_3_9 ⟨"a","y"⟩ = true := by decide
example : predict m3_3_9 s3_3_9 "b" = .ok "y" := rfl
example : falsified m3_3_9 s3_3_9 ⟨"b","x"⟩ = true := by decide
example : falsified m3_3_9 s3_3_9 ⟨"b","y"⟩ = false := by decide
def m3_3_10 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y"),("b","y")])],[]⟩
def s3_3_10 : Sealed m3_3_10 := ⟨("h",[("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_10 s3_3_10 "a" = .ok "y" := rfl
example : falsified m3_3_10 s3_3_10 ⟨"a","x"⟩ = true := by decide
example : falsified m3_3_10 s3_3_10 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_10 s3_3_10 "b" = .ok "y" := rfl
example : falsified m3_3_10 s3_3_10 ⟨"b","x"⟩ = true := by decide
example : falsified m3_3_10 s3_3_10 ⟨"b","y"⟩ = false := by decide
def m3_3_11 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def s3_3_11 : Sealed m3_3_11 := ⟨("h",[("a","x"),("a","y"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_11 s3_3_11 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_11 s3_3_11 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_11 s3_3_11 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_11 s3_3_11 "b" = .ok "y" := rfl
example : falsified m3_3_11 s3_3_11 ⟨"b","x"⟩ = true := by decide
example : falsified m3_3_11 s3_3_11 ⟨"b","y"⟩ = false := by decide
def m3_3_12 : Training := ⟨["a","b"],["x","y"],[("h",[("b","x"),("b","y")])],[]⟩
def s3_3_12 : Sealed m3_3_12 := ⟨("h",[("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_12 s3_3_12 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_12 s3_3_12 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_12 s3_3_12 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_12 s3_3_12 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_12 s3_3_12 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_12 s3_3_12 ⟨"b","y"⟩ = false := by decide
def m3_3_13 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def s3_3_13 : Sealed m3_3_13 := ⟨("h",[("a","x"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_13 s3_3_13 "a" = .ok "x" := rfl
example : falsified m3_3_13 s3_3_13 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_13 s3_3_13 ⟨"a","y"⟩ = true := by decide
example : predict m3_3_13 s3_3_13 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_13 s3_3_13 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_13 s3_3_13 ⟨"b","y"⟩ = false := by decide
def m3_3_14 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def s3_3_14 : Sealed m3_3_14 := ⟨("h",[("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_14 s3_3_14 "a" = .ok "y" := rfl
example : falsified m3_3_14 s3_3_14 ⟨"a","x"⟩ = true := by decide
example : falsified m3_3_14 s3_3_14 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_14 s3_3_14 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_14 s3_3_14 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_14 s3_3_14 ⟨"b","y"⟩ = false := by decide
def m3_3_15 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def s3_3_15 : Sealed m3_3_15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]), (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
example : predict m3_3_15 s3_3_15 "a" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_15 s3_3_15 ⟨"a","x"⟩ = false := by decide
example : falsified m3_3_15 s3_3_15 ⟨"a","y"⟩ = false := by decide
example : predict m3_3_15 s3_3_15 "b" = .error "prediction requires exactly one supported label" := rfl
example : falsified m3_3_15 s3_3_15 ⟨"b","x"⟩ = false := by decide
example : falsified m3_3_15 s3_3_15 ⟨"b","y"⟩ = false := by decide
end SFT.Computation.ClassificationPrediction
