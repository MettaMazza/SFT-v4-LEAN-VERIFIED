import verification.TURN_344_ReversibleCompositionDraft
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleComposition
set_option maxRecDepth 1000000
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["a","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","joint"],"p"),(["a","joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["a","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["a","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","joint"],"q"),(["a","joint","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["a","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["b","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","joint"],"p"),(["b","joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["b","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["b","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","joint"],"q"),(["b","joint","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["b","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["b","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["a","joint","joint"],"q"),(["b","joint"],"p"),(["b","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","joint"],"p"),(["a","joint","joint","joint"],"q"),(["b","joint","joint"],"p"),(["b","joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","a","joint"],"p"),(["b","joint","a"],"p"),(["b","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["a","joint","joint","a"],"p"),(["b","joint"],"q"),(["b","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["b","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["a","joint","joint"],"q"),(["b","joint"],"q"),(["b","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","joint"],"p"),(["a","joint","joint","joint"],"q"),(["b","joint","joint"],"q"),(["b","joint","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","a","joint"],"p"),(["b","joint","a"],"q"),(["b","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["a","joint","joint","a"],"p"),(["b","joint"],"p"),(["b","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["b","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["a","joint","joint"],"p"),(["b","joint"],"p"),(["b","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","joint"],"q"),(["a","joint","joint","joint"],"p"),(["b","joint","joint"],"p"),(["b","joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","a","joint"],"q"),(["b","joint","a"],"p"),(["b","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["a","joint","joint","a"],"q"),(["b","joint"],"q"),(["b","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["b","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["a","joint","joint"],"p"),(["b","joint"],"q"),(["b","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","joint"],"q"),(["a","joint","joint","joint"],"p"),(["b","joint","joint"],"q"),(["b","joint","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","a","joint"],"q"),(["b","joint","a"],"q"),(["b","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["a","joint","joint","a"],"q"),(["b","joint"],"p"),(["b","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["b","joint","joint"],"q"),(["a","joint"],"p"),(["a","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","joint"],"p"),(["b","joint","joint","joint"],"q"),(["a","joint","joint"],"p"),(["a","joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","a","joint"],"p"),(["a","joint","a"],"p"),(["a","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["b","joint","joint","a"],"p"),(["a","joint"],"q"),(["a","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["b","joint","joint"],"q"),(["a","joint"],"q"),(["a","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","joint"],"p"),(["b","joint","joint","joint"],"q"),(["a","joint","joint"],"q"),(["a","joint","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","a","joint"],"p"),(["a","joint","a"],"q"),(["a","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["b","joint","joint","a"],"p"),(["a","joint"],"p"),(["a","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["b","joint","joint"],"p"),(["a","joint"],"p"),(["a","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","joint"],"q"),(["b","joint","joint","joint"],"p"),(["a","joint","joint"],"p"),(["a","joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","a","joint"],"q"),(["a","joint","a"],"p"),(["a","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["b","joint","joint","a"],"q"),(["a","joint"],"q"),(["a","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"q"),(["b","joint","joint"],"p"),(["a","joint"],"q"),(["a","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["b","joint","joint"],"q"),(["b","joint","joint","joint"],"p"),(["a","joint","joint"],"q"),(["a","joint","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","a","joint"],"q"),(["a","joint","a"],"q"),(["a","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["b","joint"],"p"),(["b","joint","joint","a"],"q"),(["a","joint"],"p"),(["a","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["q","p"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"r"),(["b","joint","a"],"r"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"p"),(["b","joint","a"],"r"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"r"),(["a","joint","b"],"q"),(["b","joint","a"],"r"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"r"),(["b","joint","a"],"p"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["b","joint","a"],"p"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["b","joint","a"],"p"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"r"),(["b","joint","a"],"q"),(["b","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["b","joint","a"],"q"),(["b","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["b","joint","a"],"q"),(["b","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"r"),(["b","joint","b"],"r"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"p"),(["b","joint","b"],"r"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"r"),(["a","joint","a"],"q"),(["b","joint","b"],"r"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"r"),(["b","joint","b"],"p"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["b","joint","b"],"p"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["b","joint","b"],"p"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"r"),(["b","joint","b"],"q"),(["b","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["b","joint","b"],"q"),(["b","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["b","joint","b"],"q"),(["b","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"r"),(["a","joint","a"],"r"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"p"),(["a","joint","a"],"r"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"r"),(["b","joint","b"],"q"),(["a","joint","a"],"r"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"r"),(["a","joint","a"],"p"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"p"),(["b","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"r"),(["a","joint","a"],"q"),(["a","joint","b"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","b"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","a"],"q"),(["b","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","b"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"r"),(["a","joint","b"],"r"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"p"),(["a","joint","b"],"r"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"r"),(["b","joint","a"],"q"),(["a","joint","b"],"r"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"r"),(["a","joint","b"],"p"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"p"),(["b","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"r"),(["a","joint","b"],"q"),(["a","joint","a"],"r")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","a"],"p")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .ok ⟨[(["b","joint","b"],"q"),(["b","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","a"],"q")],["p","q","r"]⟩ := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint"],"p"),(["joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint"],"q"),(["joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","b"],"p"),(["joint","joint","a"],"q"),(["joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","b"],"q"),(["joint","joint","a"],"q"),(["joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","b"],"p"),(["joint","joint","a"],"p"),(["joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","b"],"q"),(["joint","joint","a"],"p"),(["joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","a"],"p"),(["joint","joint","b"],"q"),(["joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","a"],"q"),(["joint","joint","b"],"q"),(["joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","a"],"p"),(["joint","joint","b"],"p"),(["joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","a"],"q"),(["joint","joint","b"],"p"),(["joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "a branch word occurs twice" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "a branch word occurs twice" := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","a","joint"],"p"),(["joint","joint","a"],"q"),(["joint","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint"],"q"),(["joint","joint","a"],"p"),(["joint","joint"],"p"),(["joint","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint","a"],"p"),(["joint","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint","a"],"q"),(["joint","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint","b"],"p"),(["joint","joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint","b"],"q"),(["joint","joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint","a"],"p"),(["joint","joint","b"],"p"),(["joint","joint","joint","a"],"q"),(["joint","joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint","a"],"p"),(["joint","joint","b"],"q"),(["joint","joint","joint","a"],"q"),(["joint","joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint","a"],"q"),(["joint","joint","b"],"p"),(["joint","joint","joint","a"],"p"),(["joint","joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint","a"],"q"),(["joint","joint","b"],"q"),(["joint","joint","joint","a"],"p"),(["joint","joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint","b"],"p"),(["joint","joint","a"],"p"),(["joint","joint","joint","b"],"q"),(["joint","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint","b"],"p"),(["joint","joint","a"],"q"),(["joint","joint","joint","b"],"q"),(["joint","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint","b"],"q"),(["joint","joint","a"],"p"),(["joint","joint","joint","b"],"p"),(["joint","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint","b"],"q"),(["joint","joint","a"],"q"),(["joint","joint","joint","b"],"p"),(["joint","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint"],"p"),(["joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "a branch word occurs twice" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "a branch word occurs twice" := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint","a"],"p"),(["joint","joint","a","joint"],"p"),(["joint","joint","joint","a"],"q"),(["joint","joint","joint","a","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","joint"],"q"),(["joint","joint","joint","a"],"p"),(["joint","joint","joint"],"p"),(["joint","joint","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"p"),(["a","joint","joint","a"],"p"),(["a","joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","b"],"q"),(["a","joint","joint","a"],"p"),(["a","joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"p"),(["a","joint","joint","a"],"q"),(["a","joint","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"q"),(["a","joint","b"],"q"),(["a","joint","joint","a"],"q"),(["a","joint","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"p"),(["a","joint","joint","b"],"p"),(["a","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"p"),(["a","joint","a"],"q"),(["a","joint","joint","b"],"p"),(["a","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"p"),(["a","joint","joint","b"],"q"),(["a","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["a","joint","b"],"q"),(["a","joint","a"],"q"),(["a","joint","joint","b"],"q"),(["a","joint","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"p"),(["a","joint","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .error "a branch word occurs twice" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .error "a branch word occurs twice" := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint","a"],"p"),(["a","joint","a","joint"],"p"),(["a","joint","joint","a"],"p"),(["a","joint","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["a","joint"],"q"),(["a","joint","joint","a"],"p"),(["a","joint","joint"],"q"),(["a","joint","joint","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","b"],"q"),(["joint","a","joint","a"],"p"),(["joint","a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","b"],"p"),(["joint","a","joint","a"],"p"),(["joint","a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","b"],"q"),(["joint","a","joint","a"],"q"),(["joint","a","joint","b"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"p"),(["joint","b"],"p"),(["joint","a","joint","a"],"q"),(["joint","a","joint","b"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","a"],"q"),(["joint","a","joint","b"],"p"),(["joint","a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"q"),(["joint","a"],"p"),(["joint","a","joint","b"],"p"),(["joint","a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","a"],"q"),(["joint","a","joint","b"],"q"),(["joint","a","joint","a"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","b"],"p"),(["joint","a"],"p"),(["joint","a","joint","b"],"q"),(["joint","a","joint","a"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["q","p"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"q"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"r"),(["b"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"p"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"q"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"p")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"q")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["b"],"r"),(["a"],"r")],["p","q","r"]⟩ = .error "joint states require one exact phase cycle" := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[([],"p")],["p","q"]⟩ = .ok ⟨[(["joint"],"q"),(["joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[([],"p"),(["joint"],"q")],["p","q"]⟩ = .ok ⟨[(["joint"],"q"),(["joint","joint"],"p"),(["joint","a","joint"],"p"),(["joint","a","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["joint"],"p"),(["joint","joint"],"q")],["p","q"]⟩ = .ok ⟨[(["joint","joint"],"q"),(["joint","joint","joint"],"p"),(["joint","a","joint","joint"],"p"),(["joint","a","joint","joint","joint"],"q")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[(["a"],"p"),(["a","joint"],"p")],["p","q"]⟩ = .ok ⟨[(["joint","a"],"q"),(["joint","a","joint"],"q"),(["joint","a","joint","a"],"p"),(["joint","a","joint","a","joint"],"p")],["p","q"]⟩ := rfl
example : compose ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ ⟨[([],"q"),(["joint","a"],"p")],["p","q"]⟩ = .ok ⟨[(["joint"],"p"),(["joint","joint","a"],"q"),(["joint","a","joint"],"q"),(["joint","a","joint","joint","a"],"p")],["p","q"]⟩ := rfl
