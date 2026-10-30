import SFT.Computation.ClassicalLearning
namespace SFT.Computation.ClassicalLearning
open SFT.Computation.ClassificationPrediction
def tr1 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x")]),("other",[("a","y")])],[("a","x")]⟩
def sealed1 : Sealed tr1 := ⟨("h",[("a","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m1_x).inferred = .ok ["h"] := rfl
example : (report m1_x).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m1_x).passed = false := by decide
example : (report m1_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m1_y).inferred = .ok ["h"] := rfl
example : (report m1_y).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m1_y).passed = false := by decide
example : (report m1_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
def tr3 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y")]),("other",[("a","y")])],[("a","x")]⟩
def sealed3 : Sealed tr3 := ⟨("h",[("a","x"),("a","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m3_x).inferred = .ok ["h"] := rfl
example : (report m3_x).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m3_x).passed = false := by decide
example : (report m3_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m3_y).inferred = .ok ["h"] := rfl
example : (report m3_y).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m3_y).passed = false := by decide
example : (report m3_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
def tr5 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","x")]),("other",[("a","y")])],[("a","x")]⟩
def sealed5 : Sealed tr5 := ⟨("h",[("a","x"),("b","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m5_x).inferred = .ok ["h"] := rfl
example : (report m5_x).predictions = [("b",.ok "x")] := rfl
example : (report m5_x).passed = true := by decide
example : (report m5_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m5_y).inferred = .ok ["h"] := rfl
example : (report m5_y).predictions = [("b",.ok "x")] := rfl
example : (report m5_y).passed = false := by decide
example : (report m5_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
def tr7 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x")]),("other",[("a","y")])],[("a","x")]⟩
def sealed7 : Sealed tr7 := ⟨("h",[("a","x"),("a","y"),("b","x")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m7_x).inferred = .ok ["h"] := rfl
example : (report m7_x).predictions = [("b",.ok "x")] := rfl
example : (report m7_x).passed = true := by decide
example : (report m7_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m7_y).inferred = .ok ["h"] := rfl
example : (report m7_y).predictions = [("b",.ok "x")] := rfl
example : (report m7_y).passed = false := by decide
example : (report m7_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
def tr9 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","y")]),("other",[("a","y")])],[("a","x")]⟩
def sealed9 : Sealed tr9 := ⟨("h",[("a","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m9_x).inferred = .ok ["h"] := rfl
example : (report m9_x).predictions = [("b",.ok "y")] := rfl
example : (report m9_x).passed = false := by decide
example : (report m9_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m9_y).inferred = .ok ["h"] := rfl
example : (report m9_y).predictions = [("b",.ok "y")] := rfl
example : (report m9_y).passed = true := by decide
example : (report m9_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
def tr11 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","y")]),("other",[("a","y")])],[("a","x")]⟩
def sealed11 : Sealed tr11 := ⟨("h",[("a","x"),("a","y"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m11_x).inferred = .ok ["h"] := rfl
example : (report m11_x).predictions = [("b",.ok "y")] := rfl
example : (report m11_x).passed = false := by decide
example : (report m11_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m11_y).inferred = .ok ["h"] := rfl
example : (report m11_y).predictions = [("b",.ok "y")] := rfl
example : (report m11_y).passed = true := by decide
example : (report m11_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
def tr13 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("b","x"),("b","y")]),("other",[("a","y")])],[("a","x")]⟩
def sealed13 : Sealed tr13 := ⟨("h",[("a","x"),("b","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m13_x).inferred = .ok ["h"] := rfl
example : (report m13_x).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m13_x).passed = false := by decide
example : (report m13_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m13_y).inferred = .ok ["h"] := rfl
example : (report m13_y).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m13_y).passed = false := by decide
example : (report m13_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
def tr15 : Training := ⟨["a","b"],["x","y"],[("h",[("a","x"),("a","y"),("b","x"),("b","y")]),("other",[("a","y")])],[("a","x")]⟩
def sealed15 : Sealed tr15 := ⟨("h",[("a","x"),("a","y"),("b","x"),("b","y")]),(SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨.head _,by decide⟩⟩
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m15_x).inferred = .ok ["h"] := rfl
example : (report m15_x).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m15_x).passed = false := by decide
example : (report m15_x).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
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
    intro input held row member
    cases held with
    | head =>
      cases member with
      | head => exact of_decide_eq_false rfl
      | tail _ bad => cases bad
    | tail _ bad => cases bad
example : (report m15_y).inferred = .ok ["h"] := rfl
example : (report m15_y).predictions = [("b",.error "prediction requires exactly one supported label")] := rfl
example : (report m15_y).passed = false := by decide
example : (report m15_y).resources = [("examples",1),("hypotheses",2),("withheld",1),("targets",1)] := rfl
theorem nativeHeldTarget : ∃ t, t ∈ m5_x.targets ∧ t.input = "b" ∧
    predict m5_x.training m5_x.sealed "b" = .ok t.label := everyHeldTarget _ (by decide) _ (.head _)
theorem nativeInference : (report m5_x).inferred = .ok ["h"] := inferenceExact _ (by decide) (by decide)
#print axioms nativeHeldTarget
#print axioms nativeInference
end SFT.Computation.ClassicalLearning
