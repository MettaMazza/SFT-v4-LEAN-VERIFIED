import verification.TURN_341_ReversibleModelDraft
open SFT.QuantumComputation.ReversibleModel
set_option maxRecDepth 1000000
example : makeGate [] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["a"],["a"])] ["step"] = .ok ⟨[(["a"],["a"])],["step"]⟩ := rfl
example : inverse ⟨[(["a"],["a"])],["step"]⟩ = ⟨[(["a"],["a"])],["step"]⟩ := rfl
example : makeGate [(["a"],["a"])] ["step","step"] = .ok ⟨[(["a"],["a"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["a"],["a"])],["step","step"]⟩ = ⟨[(["a"],["a"])],["step","step"]⟩ := rfl
example : makeGate [(["a"],["b"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["a"],["b"])] ["step"] = .ok ⟨[(["a"],["b"])],["step"]⟩ := rfl
example : inverse ⟨[(["a"],["b"])],["step"]⟩ = ⟨[(["b"],["a"])],["step"]⟩ := rfl
example : makeGate [(["a"],["b"])] ["step","step"] = .ok ⟨[(["a"],["b"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["a"],["b"])],["step","step"]⟩ = ⟨[(["b"],["a"])],["step","step"]⟩ := rfl
example : makeGate [(["b"],["a"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["b"],["a"])] ["step"] = .ok ⟨[(["b"],["a"])],["step"]⟩ := rfl
example : inverse ⟨[(["b"],["a"])],["step"]⟩ = ⟨[(["a"],["b"])],["step"]⟩ := rfl
example : makeGate [(["b"],["a"])] ["step","step"] = .ok ⟨[(["b"],["a"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["b"],["a"])],["step","step"]⟩ = ⟨[(["a"],["b"])],["step","step"]⟩ := rfl
example : makeGate [(["b"],["b"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["b"],["b"])] ["step"] = .ok ⟨[(["b"],["b"])],["step"]⟩ := rfl
example : inverse ⟨[(["b"],["b"])],["step"]⟩ = ⟨[(["b"],["b"])],["step"]⟩ := rfl
example : makeGate [(["b"],["b"])] ["step","step"] = .ok ⟨[(["b"],["b"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["b"],["b"])],["step","step"]⟩ = ⟨[(["b"],["b"])],["step","step"]⟩ := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"])] ["step"] = .ok ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ := rfl
example : inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ = ⟨[(["a"],["a"]),(["b"],["b"])],["step"]⟩ := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"])] ["step","step"] = .ok ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ = ⟨[(["a"],["a"]),(["b"],["b"])],["step","step"]⟩ := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"])] ["step"] = .ok ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ := rfl
example : inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ = ⟨[(["b"],["a"]),(["a"],["b"])],["step"]⟩ := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"])] ["step","step"] = .ok ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ = ⟨[(["b"],["a"]),(["a"],["b"])],["step","step"]⟩ := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"])] ["step"] = .ok ⟨[(["b"],["a"]),(["a"],["b"])],["step"]⟩ := rfl
example : inverse ⟨[(["b"],["a"]),(["a"],["b"])],["step"]⟩ = ⟨[(["a"],["b"]),(["b"],["a"])],["step"]⟩ := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"])] ["step","step"] = .ok ⟨[(["b"],["a"]),(["a"],["b"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["b"],["a"]),(["a"],["b"])],["step","step"]⟩ = ⟨[(["a"],["b"]),(["b"],["a"])],["step","step"]⟩ := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"])] [] = .error "gate phase action requires a generated successor trace" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"])] ["step"] = .ok ⟨[(["b"],["b"]),(["a"],["a"])],["step"]⟩ := rfl
example : inverse ⟨[(["b"],["b"]),(["a"],["a"])],["step"]⟩ = ⟨[(["b"],["b"]),(["a"],["a"])],["step"]⟩ := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"])] ["step","step"] = .ok ⟨[(["b"],["b"]),(["a"],["a"])],["step","step"]⟩ := rfl
example : inverse ⟨[(["b"],["b"]),(["a"],["a"])],["step","step"]⟩ = ⟨[(["b"],["b"]),(["a"],["a"])],["step","step"]⟩ := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["a"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["a"]),(["b"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["a"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["a"],["b"]),(["b"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["a"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["a"]),(["b"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["a"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["a"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["a"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["a"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["a"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["a"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["a"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["a"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["b"],["a"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["b"],["a"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["b"],["a"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["b"],["b"])] [] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["b"],["b"])] ["step"] = .error "gate word map must be a finite bijection" := rfl
example : makeGate [(["b"],["b"]),(["b"],["b"]),(["b"],["b"])] ["step","step"] = .error "gate word map must be a finite bijection" := rfl
example : makeState [(["a"],"p")] ["p","q"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ ["step"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : makeState [(["a"],"q")] ["p","q"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ ["step"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : makeState [(["b"],"p")] ["p","q"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ ["step"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : makeState [(["b"],"q")] ["p","q"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ ["step"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q"]⟩ := rfl
example : makeState [(["a"],"p"),(["b"],"p")] ["p","q"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ["step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : makeState [(["a"],"p"),(["b"],"q")] ["p","q"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ["step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : makeState [(["a"],"q"),(["b"],"p")] ["p","q"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ["step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ := rfl
example : makeState [(["a"],"q"),(["b"],"q")] ["p","q"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ["step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : makeState [(["b"],"p"),(["a"],"p")] ["p","q"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ["step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : makeState [(["b"],"p"),(["a"],"q")] ["p","q"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ["step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : makeState [(["b"],"q"),(["a"],"p")] ["p","q"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ["step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ := rfl
example : makeState [(["b"],"q"),(["a"],"q")] ["p","q"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ["step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ["step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : makeState [(["a"],"q")] ["q","p"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ ["step"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : makeState [(["a"],"p")] ["q","p"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ ["step"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["q","p"]⟩ := rfl
example : makeState [(["b"],"q")] ["q","p"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ ["step"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : makeState [(["b"],"p")] ["q","p"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ ["step"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["q","p"]⟩ := rfl
example : makeState [(["a"],"q"),(["b"],"q")] ["q","p"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ["step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : makeState [(["a"],"q"),(["b"],"p")] ["q","p"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ["step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : makeState [(["a"],"p"),(["b"],"q")] ["q","p"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ["step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ := rfl
example : makeState [(["a"],"p"),(["b"],"p")] ["q","p"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ["step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ := rfl
example : makeState [(["b"],"q"),(["a"],"q")] ["q","p"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ["step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : makeState [(["b"],"q"),(["a"],"p")] ["q","p"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ["step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : makeState [(["b"],"p"),(["a"],"q")] ["q","p"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ["step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ := rfl
example : makeState [(["b"],"p"),(["a"],"p")] ["q","p"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ["step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ["step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ := rfl
example : makeState [(["a"],"p")] ["p","q","r"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"q")] ["p","q","r"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"r")] ["p","q","r"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"p")] ["p","q","r"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"q")] ["p","q","r"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"r")] ["p","q","r"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"p"),(["b"],"p")] ["p","q","r"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"p"),(["b"],"q")] ["p","q","r"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"p"),(["b"],"r")] ["p","q","r"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"q"),(["b"],"p")] ["p","q","r"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"q"),(["b"],"q")] ["p","q","r"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"q"),(["b"],"r")] ["p","q","r"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"r"),(["b"],"p")] ["p","q","r"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"r"),(["b"],"q")] ["p","q","r"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["a"],"r"),(["b"],"r")] ["p","q","r"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"p"),(["a"],"p")] ["p","q","r"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"p"),(["a"],"q")] ["p","q","r"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"p"),(["a"],"r")] ["p","q","r"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"q"),(["a"],"p")] ["p","q","r"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"q"),(["a"],"q")] ["p","q","r"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"q"),(["a"],"r")] ["p","q","r"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"r"),(["a"],"p")] ["p","q","r"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"r"),(["a"],"q")] ["p","q","r"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : makeState [(["b"],"r"),(["a"],"r")] ["p","q","r"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ["step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ["step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step"] = .ok ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ := rfl
example : phaseAction ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : makeState [] ["p","q"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : makeState [(["a"],"p")] [] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : makeState [(["a"],"p")] ["p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : makeState [(["a"],"p")] ["p","p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : makeState [(["a"],"outside")] ["p","q"] = .error "branch phase is outside the registered cycle" := rfl
example : makeState [(["a"],"p"),(["a"],"q")] ["p","q"] = .error "a branch word occurs twice" := rfl
example : makeState [([],"p")] ["p","q"] = .ok ⟨[([],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ [] = .error "phase action requires a generated nonempty successor trace" := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ ["step"] = .ok ⟨[([],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ ["step","step"] = .ok ⟨[([],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ ["step","step","step"] = .ok ⟨[([],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ ["step","step","step","step"] = .ok ⟨[([],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ ["step","step","step","step","step"] = .ok ⟨[([],"q")],["p","q"]⟩ := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ ["step","step","step","step","step","step"] = .ok ⟨[([],"p")],["p","q"]⟩ := rfl
example : phaseAction ⟨[([],"p")],["p","q"]⟩ ["step","step","step","step","step","step","step"] = .ok ⟨[([],"q")],["p","q"]⟩ := rfl
example : completeSupport [] [] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] [] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] [] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] [] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] [] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","y"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","y"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","y"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","y"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","y"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","x"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","x"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","x"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","x"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport [] ["x","x"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] [] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] [] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] [] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] [] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] [] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] ["x"] [] = .error "IndexError: tuple index out of range" := rfl
example : completeSupport ["a"] ["x"] ["p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a"] ["x"] ["p","p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a"] ["x"] ["p","q"] = .ok ⟨[(["a"],"p")],["p","q"]⟩ := rfl
example : completeSupport ["a"] ["x"] ["p","q","r"] = .ok ⟨[(["a"],"p")],["p","q","r"]⟩ := rfl
example : completeSupport ["a"] ["x","y"] [] = .error "IndexError: tuple index out of range" := rfl
example : completeSupport ["a"] ["x","y"] ["p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a"] ["x","y"] ["p","p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a"] ["x","y"] ["p","q"] = .ok ⟨[(["a","a"],"p")],["p","q"]⟩ := rfl
example : completeSupport ["a"] ["x","y"] ["p","q","r"] = .ok ⟨[(["a","a"],"p")],["p","q","r"]⟩ := rfl
example : completeSupport ["a"] ["x","x"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] ["x","x"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] ["x","x"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] ["x","x"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a"] ["x","x"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] [] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] [] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] [] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] [] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] [] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] ["x"] [] = .error "IndexError: tuple index out of range" := rfl
example : completeSupport ["a","b"] ["x"] ["p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a","b"] ["x"] ["p","p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a","b"] ["x"] ["p","q"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ := rfl
example : completeSupport ["a","b"] ["x"] ["p","q","r"] = .ok ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ := rfl
example : completeSupport ["a","b"] ["x","y"] [] = .error "IndexError: tuple index out of range" := rfl
example : completeSupport ["a","b"] ["x","y"] ["p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a","b"] ["x","y"] ["p","p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["a","b"] ["x","y"] ["p","q"] = .ok ⟨[(["a","a"],"p"),(["a","b"],"p"),(["b","a"],"p"),(["b","b"],"p")],["p","q"]⟩ := rfl
example : completeSupport ["a","b"] ["x","y"] ["p","q","r"] = .ok ⟨[(["a","a"],"p"),(["a","b"],"p"),(["b","a"],"p"),(["b","b"],"p")],["p","q","r"]⟩ := rfl
example : completeSupport ["a","b"] ["x","x"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] ["x","x"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] ["x","x"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] ["x","x"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","b"] ["x","x"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] [] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] [] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] [] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] [] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] [] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] ["x"] [] = .error "IndexError: tuple index out of range" := rfl
example : completeSupport ["b","a"] ["x"] ["p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["b","a"] ["x"] ["p","p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["b","a"] ["x"] ["p","q"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ := rfl
example : completeSupport ["b","a"] ["x"] ["p","q","r"] = .ok ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ := rfl
example : completeSupport ["b","a"] ["x","y"] [] = .error "IndexError: tuple index out of range" := rfl
example : completeSupport ["b","a"] ["x","y"] ["p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["b","a"] ["x","y"] ["p","p"] = .error "state requires nonempty support and a nontrivial exact phase cycle" := rfl
example : completeSupport ["b","a"] ["x","y"] ["p","q"] = .ok ⟨[(["b","b"],"p"),(["b","a"],"p"),(["a","b"],"p"),(["a","a"],"p")],["p","q"]⟩ := rfl
example : completeSupport ["b","a"] ["x","y"] ["p","q","r"] = .ok ⟨[(["b","b"],"p"),(["b","a"],"p"),(["a","b"],"p"),(["a","a"],"p")],["p","q","r"]⟩ := rfl
example : completeSupport ["b","a"] ["x","x"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] ["x","x"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] ["x","x"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] ["x","x"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["b","a"] ["x","x"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] [] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] [] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] [] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] [] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] [] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","y"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","y"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","y"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","y"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","y"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","x"] [] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","x"] ["p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","x"] ["p","p"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","x"] ["p","q"] = .error "support requires unique generated alphabet and positions" := rfl
example : completeSupport ["a","a"] ["x","x"] ["p","q","r"] = .error "support requires unique generated alphabet and positions" := rfl
