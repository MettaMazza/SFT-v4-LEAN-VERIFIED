import SFT.Computation.Generalization
namespace SFT.Computation.Generalization
open SFT.Computation.ClassificationPrediction
def tr0 : Training := ⟨["a","b"],["x","y"],[("h",[])],[]⟩
def sealed0 : Sealed tr0 := ⟨("h",[]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m0_x : Model where
  training := tr0
  sealed := sealed0
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m0_x = false := by decide
example : failures m0_x = [⟨"b","x"⟩] := by decide
def m0_y : Model where
  training := tr0
  sealed := sealed0
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m0_y = false := by decide
example : failures m0_y = [⟨"b","y"⟩] := by decide
def tr1 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x")])],[]⟩
def sealed1 : Sealed tr1 := ⟨("h",[("a","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m1_x : Model where
  training := tr1
  sealed := sealed1
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m1_x = false := by decide
example : failures m1_x = [⟨"b","x"⟩] := by decide
def m1_y : Model where
  training := tr1
  sealed := sealed1
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m1_y = false := by decide
example : failures m1_y = [⟨"b","y"⟩] := by decide
def tr2 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y")])],[]⟩
def sealed2 : Sealed tr2 := ⟨("h",[("a","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m2_x : Model where
  training := tr2
  sealed := sealed2
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m2_x = false := by decide
example : failures m2_x = [⟨"b","x"⟩] := by decide
def m2_y : Model where
  training := tr2
  sealed := sealed2
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m2_y = false := by decide
example : failures m2_y = [⟨"b","y"⟩] := by decide
def tr3 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y")])],[]⟩
def sealed3 : Sealed tr3 := ⟨("h",[("a","x"),("a","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m3_x : Model where
  training := tr3
  sealed := sealed3
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m3_x = false := by decide
example : failures m3_x = [⟨"b","x"⟩] := by decide
def m3_y : Model where
  training := tr3
  sealed := sealed3
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m3_y = false := by decide
example : failures m3_y = [⟨"b","y"⟩] := by decide
def tr4 : Training := ⟨["a","b"],["x","y"],[("h",[("b","x")])],[]⟩
def sealed4 : Sealed tr4 := ⟨("h",[("b","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m4_x : Model where
  training := tr4
  sealed := sealed4
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m4_x = true := by decide
example : failures m4_x = [] := by decide
def m4_y : Model where
  training := tr4
  sealed := sealed4
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m4_y = false := by decide
example : failures m4_y = [⟨"b","y"⟩] := by decide
def tr5 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","x")])],[]⟩
def sealed5 : Sealed tr5 := ⟨("h",[("a","x"),("b","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m5_x : Model where
  training := tr5
  sealed := sealed5
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m5_x = true := by decide
example : failures m5_x = [] := by decide
def m5_y : Model where
  training := tr5
  sealed := sealed5
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m5_y = false := by decide
example : failures m5_y = [⟨"b","y"⟩] := by decide
def tr6 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y"),("b","x")])],[]⟩
def sealed6 : Sealed tr6 := ⟨("h",[("a","y"),("b","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m6_x : Model where
  training := tr6
  sealed := sealed6
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m6_x = true := by decide
example : failures m6_x = [] := by decide
def m6_y : Model where
  training := tr6
  sealed := sealed6
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m6_y = false := by decide
example : failures m6_y = [⟨"b","y"⟩] := by decide
def tr7 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x")])],[]⟩
def sealed7 : Sealed tr7 := ⟨("h",[("a","x"),("a","y"),("b","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m7_x : Model where
  training := tr7
  sealed := sealed7
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m7_x = true := by decide
example : failures m7_x = [] := by decide
def m7_y : Model where
  training := tr7
  sealed := sealed7
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m7_y = false := by decide
example : failures m7_y = [⟨"b","y"⟩] := by decide
def tr8 : Training := ⟨["a","b"],["x","y"],[("h",[("b","y")])],[]⟩
def sealed8 : Sealed tr8 := ⟨("h",[("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m8_x : Model where
  training := tr8
  sealed := sealed8
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m8_x = false := by decide
example : failures m8_x = [⟨"b","x"⟩] := by decide
def m8_y : Model where
  training := tr8
  sealed := sealed8
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m8_y = true := by decide
example : failures m8_y = [] := by decide
def tr9 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","y")])],[]⟩
def sealed9 : Sealed tr9 := ⟨("h",[("a","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m9_x : Model where
  training := tr9
  sealed := sealed9
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m9_x = false := by decide
example : failures m9_x = [⟨"b","x"⟩] := by decide
def m9_y : Model where
  training := tr9
  sealed := sealed9
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m9_y = true := by decide
example : failures m9_y = [] := by decide
def tr10 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y"),("b","y")])],[]⟩
def sealed10 : Sealed tr10 := ⟨("h",[("a","y"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m10_x : Model where
  training := tr10
  sealed := sealed10
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m10_x = false := by decide
example : failures m10_x = [⟨"b","x"⟩] := by decide
def m10_y : Model where
  training := tr10
  sealed := sealed10
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m10_y = true := by decide
example : failures m10_y = [] := by decide
def tr11 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","y")])],[]⟩
def sealed11 : Sealed tr11 := ⟨("h",[("a","x"),("a","y"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m11_x : Model where
  training := tr11
  sealed := sealed11
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m11_x = false := by decide
example : failures m11_x = [⟨"b","x"⟩] := by decide
def m11_y : Model where
  training := tr11
  sealed := sealed11
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m11_y = true := by decide
example : failures m11_y = [] := by decide
def tr12 : Training := ⟨["a","b"],["x","y"],[("h",[("b","x"),("b","y")])],[]⟩
def sealed12 : Sealed tr12 := ⟨("h",[("b","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m12_x : Model where
  training := tr12
  sealed := sealed12
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m12_x = false := by decide
example : failures m12_x = [⟨"b","x"⟩] := by decide
def m12_y : Model where
  training := tr12
  sealed := sealed12
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m12_y = false := by decide
example : failures m12_y = [⟨"b","y"⟩] := by decide
def tr13 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","x"),("b","y")])],[]⟩
def sealed13 : Sealed tr13 := ⟨("h",[("a","x"),("b","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m13_x : Model where
  training := tr13
  sealed := sealed13
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m13_x = false := by decide
example : failures m13_x = [⟨"b","x"⟩] := by decide
def m13_y : Model where
  training := tr13
  sealed := sealed13
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m13_y = false := by decide
example : failures m13_y = [⟨"b","y"⟩] := by decide
def tr14 : Training := ⟨["a","b"],["x","y"],[("h",[("a","y"),("b","x"),("b","y")])],[]⟩
def sealed14 : Sealed tr14 := ⟨("h",[("a","y"),("b","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m14_x : Model where
  training := tr14
  sealed := sealed14
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m14_x = false := by decide
example : failures m14_x = [⟨"b","x"⟩] := by decide
def m14_y : Model where
  training := tr14
  sealed := sealed14
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m14_y = false := by decide
example : failures m14_y = [⟨"b","y"⟩] := by decide
def tr15 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")])],[]⟩
def sealed15 : Sealed tr15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,rfl⟩⟩
def m15_x : Model where
  training := tr15
  sealed := sealed15
  withheld := ["b"]
  targets := [⟨"b","x"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","x"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m15_x = false := by decide
example : failures m15_x = [⟨"b","x"⟩] := by decide
def m15_y : Model where
  training := tr15
  sealed := sealed15
  withheld := ["b"]
  targets := [⟨"b","y"⟩]
  completeTargets := by
    intro input held
    cases held with
    | head => exact ⟨⟨"b","y"⟩,.head _,rfl⟩
    | tail _ bad => cases bad
  heldApart := by
    intro input held row bad
    cases bad
example : passes m15_y = false := by decide
example : failures m15_y = [⟨"b","y"⟩] := by decide
def nativeCertificate : StructuralCertificate tr4 sealed4 := ⟨fun _ => ⟨"b","x"⟩,rfl,fun _ _ => rfl⟩
theorem nativeFamily (n : Nat) : predict tr4 sealed4 (nativeCertificate.generated n).input = .ok (nativeCertificate.generated n).label := structuralFamily _ _ nativeCertificate n
#print axioms nativeFamily
end SFT.Computation.Generalization
