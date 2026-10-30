import verification.TURN_339_MathematicalModellingDraft
open SFT.Computation.MathematicalModelling
set_option maxRecDepth 1000000
def fixture : PredictionSeal := ⟨"experiment","prediction","trace","envelope","seal"⟩
example : openTargets none [] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) [] [] = .ok (fixture,.object []) := rfl
example : openTargets none [] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) [] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none [] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) [] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none [] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) [] [("a",.text "value-a"),("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a"] [("a",.text "value-a")] = .ok (fixture,.object [("a",.text "value-a")]) := rfl
example : openTargets none ["a"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b"] [("b",.text "value-b")] = .ok (fixture,.object [("b",.text "value-b")]) := rfl
example : openTargets none ["b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a"] [("a",.text "value-a")] = .ok (fixture,.object [("a",.text "value-a")]) := rfl
example : openTargets none ["a","a"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["b","a"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["b","b"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","b"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","b"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b"] [("b",.text "value-b")] = .ok (fixture,.object [("b",.text "value-b")]) := rfl
example : openTargets none ["b","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a","a"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","a"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a","a"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","a"] [("a",.text "value-a")] = .ok (fixture,.object [("a",.text "value-a")]) := rfl
example : openTargets none ["a","a","a"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","a"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a","b"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","b"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a","b"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","b"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a","b"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","b"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","a","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","a","b"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["a","b","a"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","a"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b","a"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","a"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b","a"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","a"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","a"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["a","b","b"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","b"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b","b"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","b"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b","b"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","b"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["a","b","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["a","b","b"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["b","a","a"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","a"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a","a"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","a"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a","a"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","a"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","a"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["b","a","b"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","b"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a","b"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","b"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a","b"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","b"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","a","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","a","b"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["b","b","a"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","a"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","b","a"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","a"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","b","a"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","a"] [("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","b","a"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","a"] [("a",.text "value-a"),("b",.text "value-b")] = .ok (fixture,.object [("a",.text "value-a"),("b",.text "value-b")]) := rfl
example : openTargets none ["b","b","b"] [] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","b"] [] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","b","b"] [("a",.text "value-a")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","b"] [("a",.text "value-a")] = .error "post-seal target identities do not match the registration" := rfl
example : openTargets none ["b","b","b"] [("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","b"] [("b",.text "value-b")] = .ok (fixture,.object [("b",.text "value-b")]) := rfl
example : openTargets none ["b","b","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "target material cannot be opened before prediction seal" := rfl
example : openTargets (some fixture) ["b","b","b"] [("a",.text "value-a"),("b",.text "value-b")] = .error "post-seal target identities do not match the registration" := rfl
example : sealPrediction none fixture = .ok fixture := rfl
example : sealPrediction (some fixture) fixture = .error "prediction is already sealed and cannot be replaced" := rfl
#eval do
  let result := (assembleSeal "experiment" "prediction" "trace" "envelope").sealHash
  if result != "sha256:bdf87e6dfe88a73b7fd9959b65f8065752a804f5b32a5cabad13fb08e30a8bf0" then throw (IO.userError "seal hash mismatch")
#eval do
  let result := (assembleSeal "é" "p" "t" "e").sealHash
  if result != "sha256:99a8c72d6d55bf9e1b9bd9f9f92cf4574b3ca6ea90ed011b3e3d6abd251e01a7" then throw (IO.userError "seal hash mismatch")
