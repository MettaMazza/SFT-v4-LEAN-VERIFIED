import SFT.Computation.Adaptation
namespace SFT.Computation.Adaptation
def m0_a : Model := ⟨⟨["a","b"],["go"],[]⟩,"a","engine","law",[]⟩
example : adapt m0_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m0_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m0_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m0_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m0_b : Model := ⟨⟨["a","b"],["go"],[]⟩,"b","engine","law",[]⟩
example : adapt m0_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m0_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m0_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m0_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m0_outside : Model := ⟨⟨["a","b"],["go"],[]⟩,"outside","engine","law",[]⟩
example : adapt m0_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m0_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m0_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m0_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m0_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m1_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"a","engine","law",[]⟩
example : adapt m1_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m1_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","a"],"engine","law"⟩ := rfl
example : adapt m1_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["a","a","a"],"engine","law"⟩ := rfl
example : adapt m1_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m1_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"b","engine","law",[]⟩
example : adapt m1_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m1_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m1_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m1_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m1_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a")]⟩,"outside","engine","law",[]⟩
example : adapt m1_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m1_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m1_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m1_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m1_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m2_a : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m2_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m2_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","b"],"engine","law"⟩ := rfl
example : adapt m2_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m2_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m2_b : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m2_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m2_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m2_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m2_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m2_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m2_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m2_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m2_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m2_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m2_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m3_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m3_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m3_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m3_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m3_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m3_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m3_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m3_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m3_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m3_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m3_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m3_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m3_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m3_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m3_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m3_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m4_a : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"a","engine","law",[]⟩
example : adapt m4_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m4_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m4_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m4_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m4_b : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"b","engine","law",[]⟩
example : adapt m4_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m4_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","a"],"engine","law"⟩ := rfl
example : adapt m4_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m4_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m4_outside : Model := ⟨⟨["a","b"],["go"],[("b","go","a")]⟩,"outside","engine","law",[]⟩
example : adapt m4_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m4_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m4_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m4_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m4_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m5_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"a","engine","law",[]⟩
example : adapt m5_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m5_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","a"],"engine","law"⟩ := rfl
example : adapt m5_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["a","a","a"],"engine","law"⟩ := rfl
example : adapt m5_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m5_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"b","engine","law",[]⟩
example : adapt m5_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m5_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","a"],"engine","law"⟩ := rfl
example : adapt m5_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["b","a","a"],"engine","law"⟩ := rfl
example : adapt m5_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m5_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a")]⟩,"outside","engine","law",[]⟩
example : adapt m5_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m5_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m5_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m5_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m5_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m6_a : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"a","engine","law",[]⟩
example : adapt m6_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m6_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","b"],"engine","law"⟩ := rfl
example : adapt m6_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["a","b","a"],"engine","law"⟩ := rfl
example : adapt m6_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m6_b : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"b","engine","law",[]⟩
example : adapt m6_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m6_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","a"],"engine","law"⟩ := rfl
example : adapt m6_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["b","a","b"],"engine","law"⟩ := rfl
example : adapt m6_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m6_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a")]⟩,"outside","engine","law",[]⟩
example : adapt m6_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m6_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m6_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m6_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m6_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m7_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"a","engine","law",[]⟩
example : adapt m7_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m7_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m7_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m7_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m7_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"b","engine","law",[]⟩
example : adapt m7_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m7_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","a"],"engine","law"⟩ := rfl
example : adapt m7_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m7_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m7_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a")]⟩,"outside","engine","law",[]⟩
example : adapt m7_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m7_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m7_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m7_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m7_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m8_a : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m8_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m8_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m8_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m8_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m8_b : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m8_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m8_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","b"],"engine","law"⟩ := rfl
example : adapt m8_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["b","b","b"],"engine","law"⟩ := rfl
example : adapt m8_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m8_outside : Model := ⟨⟨["a","b"],["go"],[("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m8_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m8_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m8_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m8_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m8_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m9_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m9_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m9_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","a"],"engine","law"⟩ := rfl
example : adapt m9_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["a","a","a"],"engine","law"⟩ := rfl
example : adapt m9_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m9_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m9_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m9_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","b"],"engine","law"⟩ := rfl
example : adapt m9_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["b","b","b"],"engine","law"⟩ := rfl
example : adapt m9_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m9_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m9_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m9_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m9_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m9_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m9_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m10_a : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m10_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m10_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","b"],"engine","law"⟩ := rfl
example : adapt m10_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["a","b","b"],"engine","law"⟩ := rfl
example : adapt m10_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m10_b : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m10_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m10_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","b"],"engine","law"⟩ := rfl
example : adapt m10_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["b","b","b"],"engine","law"⟩ := rfl
example : adapt m10_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m10_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m10_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m10_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m10_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m10_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m10_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m11_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m11_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m11_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m11_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m11_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m11_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m11_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m11_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["b","b"],"engine","law"⟩ := rfl
example : adapt m11_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["b","b","b"],"engine","law"⟩ := rfl
example : adapt m11_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m11_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m11_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m11_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m11_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m11_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m11_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m12_a : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m12_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m12_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m12_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m12_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m12_b : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m12_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m12_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m12_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m12_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m12_outside : Model := ⟨⟨["a","b"],["go"],[("b","go","a"),("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m12_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m12_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m12_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m12_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m12_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m13_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m13_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m13_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","a"],"engine","law"⟩ := rfl
example : adapt m13_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨["go","go"],"engine","law"⟩ = .ok ⟨["go","go"],["a","a","a"],"engine","law"⟩ := rfl
example : adapt m13_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m13_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m13_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m13_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m13_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m13_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m13_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("b","go","a"),("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m13_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m13_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m13_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m13_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m13_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m14_a : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m14_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m14_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨["go"],"engine","law"⟩ = .ok ⟨["go"],["a","b"],"engine","law"⟩ := rfl
example : adapt m14_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m14_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m14_b : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m14_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m14_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m14_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m14_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m14_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","b"),("b","go","a"),("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m14_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m14_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m14_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m14_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m14_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m15_a : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"a","engine","law",[]⟩
example : adapt m15_a ⟨[],"engine","law"⟩ = .ok ⟨[],["a"],"engine","law"⟩ := rfl
example : adapt m15_a ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m15_a ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m15_a ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_a ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m15_b : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"b","engine","law",[]⟩
example : adapt m15_b ⟨[],"engine","law"⟩ = .ok ⟨[],["b"],"engine","law"⟩ := rfl
example : adapt m15_b ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨["go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m15_b ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨["go","go"],"engine","law"⟩ = .error "ValueError: the requested transition is not exactly generated" := rfl
example : adapt m15_b ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_b ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
def m15_outside : Model := ⟨⟨["a","b"],["go"],[("a","go","a"),("a","go","b"),("b","go","a"),("b","go","b")]⟩,"outside","engine","law",[]⟩
example : adapt m15_outside ⟨[],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m15_outside ⟨[],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨[],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨[],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨["go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m15_outside ⟨["go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨["go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨["go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨["go","go"],"engine","law"⟩ = .error "ValueError: initial state is outside the carrier" := rfl
example : adapt m15_outside ⟨["go","go"],"engine","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨["go","go"],"changed","law"⟩ = .error "update changes constitutional engine or claim law" := rfl
example : adapt m15_outside ⟨["go","go"],"changed","changed"⟩ = .error "update changes constitutional engine or claim law" := rfl


def performance0 : Model := {m10_a with performance := []}
example : improves performance0 "a" "a" = false := by decide
example : improves performance0 "a" "b" = false := by decide
example : improves performance0 "b" "a" = false := by decide
example : improves performance0 "b" "b" = false := by decide

def performance1 : Model := {m10_a with performance := [("a","a")]}
example : improves performance1 "a" "a" = true := by decide
example : improves performance1 "a" "b" = false := by decide
example : improves performance1 "b" "a" = false := by decide
example : improves performance1 "b" "b" = false := by decide

def performance2 : Model := {m10_a with performance := [("a","b")]}
example : improves performance2 "a" "a" = false := by decide
example : improves performance2 "a" "b" = true := by decide
example : improves performance2 "b" "a" = false := by decide
example : improves performance2 "b" "b" = false := by decide

def performance3 : Model := {m10_a with performance := [("a","a"),("a","b")]}
example : improves performance3 "a" "a" = true := by decide
example : improves performance3 "a" "b" = true := by decide
example : improves performance3 "b" "a" = false := by decide
example : improves performance3 "b" "b" = false := by decide

def performance4 : Model := {m10_a with performance := [("b","a")]}
example : improves performance4 "a" "a" = false := by decide
example : improves performance4 "a" "b" = false := by decide
example : improves performance4 "b" "a" = true := by decide
example : improves performance4 "b" "b" = false := by decide

def performance5 : Model := {m10_a with performance := [("a","a"),("b","a")]}
example : improves performance5 "a" "a" = true := by decide
example : improves performance5 "a" "b" = false := by decide
example : improves performance5 "b" "a" = true := by decide
example : improves performance5 "b" "b" = false := by decide

def performance6 : Model := {m10_a with performance := [("a","b"),("b","a")]}
example : improves performance6 "a" "a" = false := by decide
example : improves performance6 "a" "b" = true := by decide
example : improves performance6 "b" "a" = true := by decide
example : improves performance6 "b" "b" = false := by decide

def performance7 : Model := {m10_a with performance := [("a","a"),("a","b"),("b","a")]}
example : improves performance7 "a" "a" = true := by decide
example : improves performance7 "a" "b" = true := by decide
example : improves performance7 "b" "a" = true := by decide
example : improves performance7 "b" "b" = false := by decide

def performance8 : Model := {m10_a with performance := [("b","b")]}
example : improves performance8 "a" "a" = false := by decide
example : improves performance8 "a" "b" = false := by decide
example : improves performance8 "b" "a" = false := by decide
example : improves performance8 "b" "b" = true := by decide

def performance9 : Model := {m10_a with performance := [("a","a"),("b","b")]}
example : improves performance9 "a" "a" = true := by decide
example : improves performance9 "a" "b" = false := by decide
example : improves performance9 "b" "a" = false := by decide
example : improves performance9 "b" "b" = true := by decide

def performance10 : Model := {m10_a with performance := [("a","b"),("b","b")]}
example : improves performance10 "a" "a" = false := by decide
example : improves performance10 "a" "b" = true := by decide
example : improves performance10 "b" "a" = false := by decide
example : improves performance10 "b" "b" = true := by decide

def performance11 : Model := {m10_a with performance := [("a","a"),("a","b"),("b","b")]}
example : improves performance11 "a" "a" = true := by decide
example : improves performance11 "a" "b" = true := by decide
example : improves performance11 "b" "a" = false := by decide
example : improves performance11 "b" "b" = true := by decide

def performance12 : Model := {m10_a with performance := [("b","a"),("b","b")]}
example : improves performance12 "a" "a" = false := by decide
example : improves performance12 "a" "b" = false := by decide
example : improves performance12 "b" "a" = true := by decide
example : improves performance12 "b" "b" = true := by decide

def performance13 : Model := {m10_a with performance := [("a","a"),("b","a"),("b","b")]}
example : improves performance13 "a" "a" = true := by decide
example : improves performance13 "a" "b" = false := by decide
example : improves performance13 "b" "a" = true := by decide
example : improves performance13 "b" "b" = true := by decide

def performance14 : Model := {m10_a with performance := [("a","b"),("b","a"),("b","b")]}
example : improves performance14 "a" "a" = false := by decide
example : improves performance14 "a" "b" = true := by decide
example : improves performance14 "b" "a" = true := by decide
example : improves performance14 "b" "b" = true := by decide

def performance15 : Model := {m10_a with performance := [("a","a"),("a","b"),("b","a"),("b","b")]}
example : improves performance15 "a" "a" = true := by decide
example : improves performance15 "a" "b" = true := by decide
example : improves performance15 "b" "a" = true := by decide
example : improves performance15 "b" "b" = true := by decide

theorem nativeComposition : adapt m10_a ⟨["go","go"],"engine","law"⟩ =
    .ok ⟨["go","go"],["a","b","b"],"engine","law"⟩ :=
  updateComposition _ "b" "b" ["go"] ["go"] ["a"] ["b"] (.head _)
    (.next _ _ _ _ _ _ rfl (.identity _)) (.next _ _ _ _ _ _ rfl (.identity _))
theorem nativeTrace : "a" ∈ m10_a.updates.states ∧
    SFT.Computation.StateTransition.Execution m10_a.updates "a" ["go","go"] ["a","b","b"] :=
  receiptTrace _ _ _ nativeComposition
#print axioms nativeComposition
#print axioms nativeTrace
end SFT.Computation.Adaptation
