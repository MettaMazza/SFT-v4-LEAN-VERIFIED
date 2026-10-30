import SFT.Computation.MathematicalModelling
import SFT.Computation.MathematicalModellingEvidence
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
def registrationFixture : Model := ⟨SFT.Computation.MathematicalModellingEvidence.registrationData "sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", fun _ => true, none, by decide⟩
def model0 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model0 ["a"] [] = some ["a"] := rfl
example : executeOperations model0 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [] = some ["b"] := rfl
example : executeOperations model0 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model0 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons0 : List (Comparison model0) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model0 comparisons0 = [((["a"],["a"]),false),((["a"],["b"]),false),((["b"],["a"]),false),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model0 comparisons0).map (fun r => (r.formal,r.observed)) = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
def model1 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model1 ["a"] [] = some ["a"] := rfl
example : executeOperations model1 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model1 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model1 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [] = some ["b"] := rfl
example : executeOperations model1 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model1 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons1 : List (Comparison model1) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model1 comparisons1 = [((["a"],["a"]),true),((["a"],["b"]),false),((["b"],["a"]),false),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model1 comparisons1).map (fun r => (r.formal,r.observed)) = [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] := rfl
def model2 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model2 ["a"] [] = some ["a"] := rfl
example : executeOperations model2 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model2 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [] = some ["b"] := rfl
example : executeOperations model2 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model2 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons2 : List (Comparison model2) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model2 comparisons2 = [((["a"],["a"]),false),((["a"],["b"]),true),((["b"],["a"]),false),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model2 comparisons2).map (fun r => (r.formal,r.observed)) = [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] := rfl
def model3 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"]),(["a"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model3 ["a"] [] = some ["a"] := rfl
example : executeOperations model3 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model3 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model3 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model3 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model3 ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model3 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [] = some ["b"] := rfl
example : executeOperations model3 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model3 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons3 : List (Comparison model3) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model3 comparisons3 = [((["a"],["a"]),true),((["a"],["b"]),true),((["b"],["a"]),false),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model3 comparisons3).map (fun r => (r.formal,r.observed)) = [(["b"],["a"]),(["b"],["b"])] := rfl
def model4 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["b"],["a"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model4 ["a"] [] = some ["a"] := rfl
example : executeOperations model4 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [] = some ["b"] := rfl
example : executeOperations model4 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model4 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model4 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons4 : List (Comparison model4) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model4 comparisons4 = [((["a"],["a"]),false),((["a"],["b"]),false),((["b"],["a"]),true),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model4 comparisons4).map (fun r => (r.formal,r.observed)) = [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] := rfl
def model5 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"]),(["b"],["a"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model5 ["a"] [] = some ["a"] := rfl
example : executeOperations model5 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model5 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model5 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [] = some ["b"] := rfl
example : executeOperations model5 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model5 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model5 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model5 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons5 : List (Comparison model5) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model5 comparisons5 = [((["a"],["a"]),true),((["a"],["b"]),false),((["b"],["a"]),true),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model5 comparisons5).map (fun r => (r.formal,r.observed)) = [(["a"],["b"]),(["b"],["b"])] := rfl
def model6 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["b"]),(["b"],["a"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model6 ["a"] [] = some ["a"] := rfl
example : executeOperations model6 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model6 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model6 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [] = some ["b"] := rfl
example : executeOperations model6 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model6 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model6 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model6 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons6 : List (Comparison model6) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model6 comparisons6 = [((["a"],["a"]),false),((["a"],["b"]),true),((["b"],["a"]),true),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model6 comparisons6).map (fun r => (r.formal,r.observed)) = [(["a"],["a"]),(["b"],["b"])] := rfl
def model7 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"]),(["a"],["b"]),(["b"],["a"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model7 ["a"] [] = some ["a"] := rfl
example : executeOperations model7 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model7 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model7 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model7 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model7 ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model7 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model7 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [] = some ["b"] := rfl
example : executeOperations model7 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model7 ["b"] [(["b"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model7 ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model7 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["b"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model7 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons7 : List (Comparison model7) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model7 comparisons7 = [((["a"],["a"]),true),((["a"],["b"]),true),((["b"],["a"]),true),((["b"],["b"]),false)] := rfl
example : (falsifyingRows model7 comparisons7).map (fun r => (r.formal,r.observed)) = [(["b"],["b"])] := rfl
def model8 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model8 ["a"] [] = some ["a"] := rfl
example : executeOperations model8 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [] = some ["b"] := rfl
example : executeOperations model8 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model8 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model8 ["outside"] [] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model8 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons8 : List (Comparison model8) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model8 comparisons8 = [((["a"],["a"]),false),((["a"],["b"]),false),((["b"],["a"]),false),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model8 comparisons8).map (fun r => (r.formal,r.observed)) = [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] := rfl
def model9 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"]),(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model9 ["a"] [] = some ["a"] := rfl
example : executeOperations model9 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model9 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model9 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [] = some ["b"] := rfl
example : executeOperations model9 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model9 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model9 ["outside"] [] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model9 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons9 : List (Comparison model9) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model9 comparisons9 = [((["a"],["a"]),true),((["a"],["b"]),false),((["b"],["a"]),false),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model9 comparisons9).map (fun r => (r.formal,r.observed)) = [(["a"],["b"]),(["b"],["a"])] := rfl
def model10 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["b"]),(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model10 ["a"] [] = some ["a"] := rfl
example : executeOperations model10 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model10 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model10 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [] = some ["b"] := rfl
example : executeOperations model10 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model10 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model10 ["outside"] [] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model10 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons10 : List (Comparison model10) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model10 comparisons10 = [((["a"],["a"]),false),((["a"],["b"]),true),((["b"],["a"]),false),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model10 comparisons10).map (fun r => (r.formal,r.observed)) = [(["a"],["a"]),(["b"],["a"])] := rfl
def model11 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"]),(["a"],["b"]),(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model11 ["a"] [] = some ["a"] := rfl
example : executeOperations model11 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model11 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model11 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model11 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model11 ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model11 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model11 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [] = some ["b"] := rfl
example : executeOperations model11 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model11 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model11 ["outside"] [] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model11 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons11 : List (Comparison model11) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model11 comparisons11 = [((["a"],["a"]),true),((["a"],["b"]),true),((["b"],["a"]),false),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model11 comparisons11).map (fun r => (r.formal,r.observed)) = [(["b"],["a"])] := rfl
def model12 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["b"],["a"]),(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model12 ["a"] [] = some ["a"] := rfl
example : executeOperations model12 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [] = some ["b"] := rfl
example : executeOperations model12 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model12 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model12 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model12 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model12 ["outside"] [] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model12 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons12 : List (Comparison model12) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model12 comparisons12 = [((["a"],["a"]),false),((["a"],["b"]),false),((["b"],["a"]),true),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model12 comparisons12).map (fun r => (r.formal,r.observed)) = [(["a"],["a"]),(["a"],["b"])] := rfl
def model13 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"]),(["b"],["a"]),(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model13 ["a"] [] = some ["a"] := rfl
example : executeOperations model13 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model13 ["a"] [(["a"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model13 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [] = some ["b"] := rfl
example : executeOperations model13 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model13 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model13 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model13 ["b"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model13 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model13 ["outside"] [] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model13 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons13 : List (Comparison model13) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model13 comparisons13 = [((["a"],["a"]),true),((["a"],["b"]),false),((["b"],["a"]),true),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model13 comparisons13).map (fun r => (r.formal,r.observed)) = [(["a"],["b"])] := rfl
def model14 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["b"]),(["b"],["a"]),(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model14 ["a"] [] = some ["a"] := rfl
example : executeOperations model14 ["a"] [(["a"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model14 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model14 ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model14 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [] = some ["b"] := rfl
example : executeOperations model14 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model14 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model14 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model14 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model14 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model14 ["outside"] [] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model14 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons14 : List (Comparison model14) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model14 comparisons14 = [((["a"],["a"]),false),((["a"],["b"]),true),((["b"],["a"]),true),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model14 comparisons14).map (fun r => (r.formal,r.observed)) = [(["a"],["a"])] := rfl
def model15 : Correspondence := ⟨registrationFixture,"held phenomenon",⟨[["a"],["b"]],[["a"],["b"]],[(["a"],["a"]),(["a"],["b"]),(["b"],["a"]),(["b"],["b"])],by rfl,by rfl,by rfl⟩⟩
example : executeOperations model15 ["a"] [] = some ["a"] := rfl
example : executeOperations model15 ["a"] [(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model15 ["a"] [(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model15 ["a"] [(["b"],["a"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["b"])] = none := rfl
example : executeOperations model15 ["a"] [(["a"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model15 ["a"] [(["a"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model15 ["a"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["a"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["a"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["a"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["a"] [(["a"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model15 ["a"] [(["a"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model15 ["a"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["a"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [] = some ["b"] := rfl
example : executeOperations model15 ["b"] [(["a"],["a"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model15 ["b"] [(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model15 ["b"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["b"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [(["b"],["a"]),(["a"],["a"])] = some ["a"] := rfl
example : executeOperations model15 ["b"] [(["b"],["a"]),(["a"],["b"])] = some ["b"] := rfl
example : executeOperations model15 ["b"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["b"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["b"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["b"] [(["b"],["b"]),(["b"],["a"])] = some ["a"] := rfl
example : executeOperations model15 ["b"] [(["b"],["b"]),(["b"],["b"])] = some ["b"] := rfl
example : executeOperations model15 ["outside"] [] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["a"],["b"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["a"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["a"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["a"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["a"]),(["b"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["b"]),(["a"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["b"]),(["a"],["b"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["b"]),(["b"],["a"])] = none := rfl
example : executeOperations model15 ["outside"] [(["b"],["b"]),(["b"],["b"])] = none := rfl
def comparisons15 : List (Comparison model15) := [⟨["a"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["a"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["a"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩,⟨["b"],["b"],by decide,by decide,⟨false,false,true,true,by rfl⟩⟩]
example : comparisonLedger model15 comparisons15 = [((["a"],["a"]),true),((["a"],["b"]),true),((["b"],["a"]),true),((["b"],["b"]),true)] := rfl
example : (falsifyingRows model15 comparisons15).map (fun r => (r.formal,r.observed)) = [] := rfl
