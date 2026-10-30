import verification.TURN_342_ReversibleApplicationDraft
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleApplication
set_option maxRecDepth 1000000
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["q","p"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["y"],"r"),(["x"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["y"],"p"),(["x"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["y"],"q"),(["x"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ (inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .ok ⟨[(["x"],"r"),(["y"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .ok ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["x"],"p"),(["y"],"p")],["p","q","r"]⟩ (inverse ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩) true = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .ok ⟨[(["x"],"q"),(["y"],"q")],["p","q","r"]⟩ := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["a"]),(["b"],["b"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],["b"]),(["b"],["a"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ false = .error "gate domain must equal complete state support" := rfl
example : applyGate ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],["x"]),(["a"],["y"])],["step","step","step","step"]⟩ true = .error "gate domain must equal complete state support" := rfl
