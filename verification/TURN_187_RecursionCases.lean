import SFT.Computation.RecursionDerivation
open SFT.Computation.RecursionDerivation
example : structuralRecursion [] [] (fun v p => v ++ [p]) = .ok [[]] := by rfl
example : structuralRecursion [] [] (fun v p => p::v) = .ok [[]] := by rfl
example : structuralRecursion [] [] (fun v _ => v) = .ok [[]] := by rfl
example : structuralRecursion [] [] (fun _ p => [p]) = .ok [[]] := by rfl
example : structuralRecursion [] [] (fun v _ => v ++ v) = .ok [[]] := by rfl
example : structuralRecursion [] [""] (fun v p => v ++ [p]) = .ok [[],[""]] := by rfl
example : structuralRecursion [] [""] (fun v p => p::v) = .ok [[],[""]] := by rfl
example : structuralRecursion [] [""] (fun v _ => v) = .ok [[],[]] := by rfl
example : structuralRecursion [] [""] (fun _ p => [p]) = .ok [[],[""]] := by rfl
example : structuralRecursion [] [""] (fun v _ => v ++ v) = .ok [[],[]] := by rfl
example : structuralRecursion [] ["p"] (fun v p => v ++ [p]) = .ok [[],["p"]] := by rfl
example : structuralRecursion [] ["p"] (fun v p => p::v) = .ok [[],["p"]] := by rfl
example : structuralRecursion [] ["p"] (fun v _ => v) = .ok [[],[]] := by rfl
example : structuralRecursion [] ["p"] (fun _ p => [p]) = .ok [[],["p"]] := by rfl
example : structuralRecursion [] ["p"] (fun v _ => v ++ v) = .ok [[],[]] := by rfl
example : structuralRecursion [] ["q"] (fun v p => v ++ [p]) = .ok [[],["q"]] := by rfl
example : structuralRecursion [] ["q"] (fun v p => p::v) = .ok [[],["q"]] := by rfl
example : structuralRecursion [] ["q"] (fun v _ => v) = .ok [[],[]] := by rfl
example : structuralRecursion [] ["q"] (fun _ p => [p]) = .ok [[],["q"]] := by rfl
example : structuralRecursion [] ["q"] (fun v _ => v ++ v) = .ok [[],[]] := by rfl
example : structuralRecursion [] ["",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p"] (fun v p => v ++ [p]) = .ok [[],[""],["","p"]] := by rfl
example : structuralRecursion [] ["","p"] (fun v p => p::v) = .ok [[],[""],["p",""]] := by rfl
example : structuralRecursion [] ["","p"] (fun v _ => v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["","p"] (fun _ p => [p]) = .ok [[],[""],["p"]] := by rfl
example : structuralRecursion [] ["","p"] (fun v _ => v ++ v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["","q"] (fun v p => v ++ [p]) = .ok [[],[""],["","q"]] := by rfl
example : structuralRecursion [] ["","q"] (fun v p => p::v) = .ok [[],[""],["q",""]] := by rfl
example : structuralRecursion [] ["","q"] (fun v _ => v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["","q"] (fun _ p => [p]) = .ok [[],[""],["q"]] := by rfl
example : structuralRecursion [] ["","q"] (fun v _ => v ++ v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["p",""] (fun v p => v ++ [p]) = .ok [[],["p"],["p",""]] := by rfl
example : structuralRecursion [] ["p",""] (fun v p => p::v) = .ok [[],["p"],["","p"]] := by rfl
example : structuralRecursion [] ["p",""] (fun v _ => v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["p",""] (fun _ p => [p]) = .ok [[],["p"],[""]] := by rfl
example : structuralRecursion [] ["p",""] (fun v _ => v ++ v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q"] (fun v p => v ++ [p]) = .ok [[],["p"],["p","q"]] := by rfl
example : structuralRecursion [] ["p","q"] (fun v p => p::v) = .ok [[],["p"],["q","p"]] := by rfl
example : structuralRecursion [] ["p","q"] (fun v _ => v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["p","q"] (fun _ p => [p]) = .ok [[],["p"],["q"]] := by rfl
example : structuralRecursion [] ["p","q"] (fun v _ => v ++ v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["q",""] (fun v p => v ++ [p]) = .ok [[],["q"],["q",""]] := by rfl
example : structuralRecursion [] ["q",""] (fun v p => p::v) = .ok [[],["q"],["","q"]] := by rfl
example : structuralRecursion [] ["q",""] (fun v _ => v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["q",""] (fun _ p => [p]) = .ok [[],["q"],[""]] := by rfl
example : structuralRecursion [] ["q",""] (fun v _ => v ++ v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["q","p"] (fun v p => v ++ [p]) = .ok [[],["q"],["q","p"]] := by rfl
example : structuralRecursion [] ["q","p"] (fun v p => p::v) = .ok [[],["q"],["p","q"]] := by rfl
example : structuralRecursion [] ["q","p"] (fun v _ => v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["q","p"] (fun _ p => [p]) = .ok [[],["q"],["p"]] := by rfl
example : structuralRecursion [] ["q","p"] (fun v _ => v ++ v) = .ok [[],[],[]] := by rfl
example : structuralRecursion [] ["q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","p","q"] (fun v p => v ++ [p]) = .ok [[],[""],["","p"],["","p","q"]] := by rfl
example : structuralRecursion [] ["","p","q"] (fun v p => p::v) = .ok [[],[""],["p",""],["q","p",""]] := by rfl
example : structuralRecursion [] ["","p","q"] (fun v _ => v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["","p","q"] (fun _ p => [p]) = .ok [[],[""],["p"],["q"]] := by rfl
example : structuralRecursion [] ["","p","q"] (fun v _ => v ++ v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q","p"] (fun v p => v ++ [p]) = .ok [[],[""],["","q"],["","q","p"]] := by rfl
example : structuralRecursion [] ["","q","p"] (fun v p => p::v) = .ok [[],[""],["q",""],["p","q",""]] := by rfl
example : structuralRecursion [] ["","q","p"] (fun v _ => v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["","q","p"] (fun _ p => [p]) = .ok [[],[""],["q"],["p"]] := by rfl
example : structuralRecursion [] ["","q","p"] (fun v _ => v ++ v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","","q"] (fun v p => v ++ [p]) = .ok [[],["p"],["p",""],["p","","q"]] := by rfl
example : structuralRecursion [] ["p","","q"] (fun v p => p::v) = .ok [[],["p"],["","p"],["q","","p"]] := by rfl
example : structuralRecursion [] ["p","","q"] (fun v _ => v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["p","","q"] (fun _ p => [p]) = .ok [[],["p"],[""],["q"]] := by rfl
example : structuralRecursion [] ["p","","q"] (fun v _ => v ++ v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["p","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q",""] (fun v p => v ++ [p]) = .ok [[],["p"],["p","q"],["p","q",""]] := by rfl
example : structuralRecursion [] ["p","q",""] (fun v p => p::v) = .ok [[],["p"],["q","p"],["","q","p"]] := by rfl
example : structuralRecursion [] ["p","q",""] (fun v _ => v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["p","q",""] (fun _ p => [p]) = .ok [[],["p"],["q"],[""]] := by rfl
example : structuralRecursion [] ["p","q",""] (fun v _ => v ++ v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["p","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["p","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","","p"] (fun v p => v ++ [p]) = .ok [[],["q"],["q",""],["q","","p"]] := by rfl
example : structuralRecursion [] ["q","","p"] (fun v p => p::v) = .ok [[],["q"],["","q"],["p","","q"]] := by rfl
example : structuralRecursion [] ["q","","p"] (fun v _ => v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["q","","p"] (fun _ p => [p]) = .ok [[],["q"],[""],["p"]] := by rfl
example : structuralRecursion [] ["q","","p"] (fun v _ => v ++ v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["q","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p",""] (fun v p => v ++ [p]) = .ok [[],["q"],["q","p"],["q","p",""]] := by rfl
example : structuralRecursion [] ["q","p",""] (fun v p => p::v) = .ok [[],["q"],["p","q"],["","p","q"]] := by rfl
example : structuralRecursion [] ["q","p",""] (fun v _ => v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["q","p",""] (fun _ p => [p]) = .ok [[],["q"],["p"],[""]] := by rfl
example : structuralRecursion [] ["q","p",""] (fun v _ => v ++ v) = .ok [[],[],[],[]] := by rfl
example : structuralRecursion [] ["q","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [] ["q","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] [] (fun v p => v ++ [p]) = .ok [[""]] := by rfl
example : structuralRecursion [""] [] (fun v p => p::v) = .ok [[""]] := by rfl
example : structuralRecursion [""] [] (fun v _ => v) = .ok [[""]] := by rfl
example : structuralRecursion [""] [] (fun _ p => [p]) = .ok [[""]] := by rfl
example : structuralRecursion [""] [] (fun v _ => v ++ v) = .ok [[""]] := by rfl
example : structuralRecursion [""] [""] (fun v p => v ++ [p]) = .ok [[""],["",""]] := by rfl
example : structuralRecursion [""] [""] (fun v p => p::v) = .ok [[""],["",""]] := by rfl
example : structuralRecursion [""] [""] (fun v _ => v) = .ok [[""],[""]] := by rfl
example : structuralRecursion [""] [""] (fun _ p => [p]) = .ok [[""],[""]] := by rfl
example : structuralRecursion [""] [""] (fun v _ => v ++ v) = .ok [[""],["",""]] := by rfl
example : structuralRecursion [""] ["p"] (fun v p => v ++ [p]) = .ok [[""],["","p"]] := by rfl
example : structuralRecursion [""] ["p"] (fun v p => p::v) = .ok [[""],["p",""]] := by rfl
example : structuralRecursion [""] ["p"] (fun v _ => v) = .ok [[""],[""]] := by rfl
example : structuralRecursion [""] ["p"] (fun _ p => [p]) = .ok [[""],["p"]] := by rfl
example : structuralRecursion [""] ["p"] (fun v _ => v ++ v) = .ok [[""],["",""]] := by rfl
example : structuralRecursion [""] ["q"] (fun v p => v ++ [p]) = .ok [[""],["","q"]] := by rfl
example : structuralRecursion [""] ["q"] (fun v p => p::v) = .ok [[""],["q",""]] := by rfl
example : structuralRecursion [""] ["q"] (fun v _ => v) = .ok [[""],[""]] := by rfl
example : structuralRecursion [""] ["q"] (fun _ p => [p]) = .ok [[""],["q"]] := by rfl
example : structuralRecursion [""] ["q"] (fun v _ => v ++ v) = .ok [[""],["",""]] := by rfl
example : structuralRecursion [""] ["",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p"] (fun v p => v ++ [p]) = .ok [[""],["",""],["","","p"]] := by rfl
example : structuralRecursion [""] ["","p"] (fun v p => p::v) = .ok [[""],["",""],["p","",""]] := by rfl
example : structuralRecursion [""] ["","p"] (fun v _ => v) = .ok [[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["","p"] (fun _ p => [p]) = .ok [[""],[""],["p"]] := by rfl
example : structuralRecursion [""] ["","p"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""]] := by rfl
example : structuralRecursion [""] ["","q"] (fun v p => v ++ [p]) = .ok [[""],["",""],["","","q"]] := by rfl
example : structuralRecursion [""] ["","q"] (fun v p => p::v) = .ok [[""],["",""],["q","",""]] := by rfl
example : structuralRecursion [""] ["","q"] (fun v _ => v) = .ok [[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["","q"] (fun _ p => [p]) = .ok [[""],[""],["q"]] := by rfl
example : structuralRecursion [""] ["","q"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""]] := by rfl
example : structuralRecursion [""] ["p",""] (fun v p => v ++ [p]) = .ok [[""],["","p"],["","p",""]] := by rfl
example : structuralRecursion [""] ["p",""] (fun v p => p::v) = .ok [[""],["p",""],["","p",""]] := by rfl
example : structuralRecursion [""] ["p",""] (fun v _ => v) = .ok [[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["p",""] (fun _ p => [p]) = .ok [[""],["p"],[""]] := by rfl
example : structuralRecursion [""] ["p",""] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""]] := by rfl
example : structuralRecursion [""] ["p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q"] (fun v p => v ++ [p]) = .ok [[""],["","p"],["","p","q"]] := by rfl
example : structuralRecursion [""] ["p","q"] (fun v p => p::v) = .ok [[""],["p",""],["q","p",""]] := by rfl
example : structuralRecursion [""] ["p","q"] (fun v _ => v) = .ok [[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["p","q"] (fun _ p => [p]) = .ok [[""],["p"],["q"]] := by rfl
example : structuralRecursion [""] ["p","q"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""]] := by rfl
example : structuralRecursion [""] ["q",""] (fun v p => v ++ [p]) = .ok [[""],["","q"],["","q",""]] := by rfl
example : structuralRecursion [""] ["q",""] (fun v p => p::v) = .ok [[""],["q",""],["","q",""]] := by rfl
example : structuralRecursion [""] ["q",""] (fun v _ => v) = .ok [[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["q",""] (fun _ p => [p]) = .ok [[""],["q"],[""]] := by rfl
example : structuralRecursion [""] ["q",""] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""]] := by rfl
example : structuralRecursion [""] ["q","p"] (fun v p => v ++ [p]) = .ok [[""],["","q"],["","q","p"]] := by rfl
example : structuralRecursion [""] ["q","p"] (fun v p => p::v) = .ok [[""],["q",""],["p","q",""]] := by rfl
example : structuralRecursion [""] ["q","p"] (fun v _ => v) = .ok [[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["q","p"] (fun _ p => [p]) = .ok [[""],["q"],["p"]] := by rfl
example : structuralRecursion [""] ["q","p"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""]] := by rfl
example : structuralRecursion [""] ["q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","p","q"] (fun v p => v ++ [p]) = .ok [[""],["",""],["","","p"],["","","p","q"]] := by rfl
example : structuralRecursion [""] ["","p","q"] (fun v p => p::v) = .ok [[""],["",""],["p","",""],["q","p","",""]] := by rfl
example : structuralRecursion [""] ["","p","q"] (fun v _ => v) = .ok [[""],[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["","p","q"] (fun _ p => [p]) = .ok [[""],[""],["p"],["q"]] := by rfl
example : structuralRecursion [""] ["","p","q"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""],["","","","","","","",""]] := by rfl
example : structuralRecursion [""] ["","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q","p"] (fun v p => v ++ [p]) = .ok [[""],["",""],["","","q"],["","","q","p"]] := by rfl
example : structuralRecursion [""] ["","q","p"] (fun v p => p::v) = .ok [[""],["",""],["q","",""],["p","q","",""]] := by rfl
example : structuralRecursion [""] ["","q","p"] (fun v _ => v) = .ok [[""],[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["","q","p"] (fun _ p => [p]) = .ok [[""],[""],["q"],["p"]] := by rfl
example : structuralRecursion [""] ["","q","p"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""],["","","","","","","",""]] := by rfl
example : structuralRecursion [""] ["","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","","q"] (fun v p => v ++ [p]) = .ok [[""],["","p"],["","p",""],["","p","","q"]] := by rfl
example : structuralRecursion [""] ["p","","q"] (fun v p => p::v) = .ok [[""],["p",""],["","p",""],["q","","p",""]] := by rfl
example : structuralRecursion [""] ["p","","q"] (fun v _ => v) = .ok [[""],[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["p","","q"] (fun _ p => [p]) = .ok [[""],["p"],[""],["q"]] := by rfl
example : structuralRecursion [""] ["p","","q"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""],["","","","","","","",""]] := by rfl
example : structuralRecursion [""] ["p","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q",""] (fun v p => v ++ [p]) = .ok [[""],["","p"],["","p","q"],["","p","q",""]] := by rfl
example : structuralRecursion [""] ["p","q",""] (fun v p => p::v) = .ok [[""],["p",""],["q","p",""],["","q","p",""]] := by rfl
example : structuralRecursion [""] ["p","q",""] (fun v _ => v) = .ok [[""],[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["p","q",""] (fun _ p => [p]) = .ok [[""],["p"],["q"],[""]] := by rfl
example : structuralRecursion [""] ["p","q",""] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""],["","","","","","","",""]] := by rfl
example : structuralRecursion [""] ["p","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["p","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","","p"] (fun v p => v ++ [p]) = .ok [[""],["","q"],["","q",""],["","q","","p"]] := by rfl
example : structuralRecursion [""] ["q","","p"] (fun v p => p::v) = .ok [[""],["q",""],["","q",""],["p","","q",""]] := by rfl
example : structuralRecursion [""] ["q","","p"] (fun v _ => v) = .ok [[""],[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["q","","p"] (fun _ p => [p]) = .ok [[""],["q"],[""],["p"]] := by rfl
example : structuralRecursion [""] ["q","","p"] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""],["","","","","","","",""]] := by rfl
example : structuralRecursion [""] ["q","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p",""] (fun v p => v ++ [p]) = .ok [[""],["","q"],["","q","p"],["","q","p",""]] := by rfl
example : structuralRecursion [""] ["q","p",""] (fun v p => p::v) = .ok [[""],["q",""],["p","q",""],["","p","q",""]] := by rfl
example : structuralRecursion [""] ["q","p",""] (fun v _ => v) = .ok [[""],[""],[""],[""]] := by rfl
example : structuralRecursion [""] ["q","p",""] (fun _ p => [p]) = .ok [[""],["q"],["p"],[""]] := by rfl
example : structuralRecursion [""] ["q","p",""] (fun v _ => v ++ v) = .ok [[""],["",""],["","","",""],["","","","","","","",""]] := by rfl
example : structuralRecursion [""] ["q","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion [""] ["q","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] [] (fun v p => v ++ [p]) = .ok [["a"]] := by rfl
example : structuralRecursion ["a"] [] (fun v p => p::v) = .ok [["a"]] := by rfl
example : structuralRecursion ["a"] [] (fun v _ => v) = .ok [["a"]] := by rfl
example : structuralRecursion ["a"] [] (fun _ p => [p]) = .ok [["a"]] := by rfl
example : structuralRecursion ["a"] [] (fun v _ => v ++ v) = .ok [["a"]] := by rfl
example : structuralRecursion ["a"] [""] (fun v p => v ++ [p]) = .ok [["a"],["a",""]] := by rfl
example : structuralRecursion ["a"] [""] (fun v p => p::v) = .ok [["a"],["","a"]] := by rfl
example : structuralRecursion ["a"] [""] (fun v _ => v) = .ok [["a"],["a"]] := by rfl
example : structuralRecursion ["a"] [""] (fun _ p => [p]) = .ok [["a"],[""]] := by rfl
example : structuralRecursion ["a"] [""] (fun v _ => v ++ v) = .ok [["a"],["a","a"]] := by rfl
example : structuralRecursion ["a"] ["p"] (fun v p => v ++ [p]) = .ok [["a"],["a","p"]] := by rfl
example : structuralRecursion ["a"] ["p"] (fun v p => p::v) = .ok [["a"],["p","a"]] := by rfl
example : structuralRecursion ["a"] ["p"] (fun v _ => v) = .ok [["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["p"] (fun _ p => [p]) = .ok [["a"],["p"]] := by rfl
example : structuralRecursion ["a"] ["p"] (fun v _ => v ++ v) = .ok [["a"],["a","a"]] := by rfl
example : structuralRecursion ["a"] ["q"] (fun v p => v ++ [p]) = .ok [["a"],["a","q"]] := by rfl
example : structuralRecursion ["a"] ["q"] (fun v p => p::v) = .ok [["a"],["q","a"]] := by rfl
example : structuralRecursion ["a"] ["q"] (fun v _ => v) = .ok [["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["q"] (fun _ p => [p]) = .ok [["a"],["q"]] := by rfl
example : structuralRecursion ["a"] ["q"] (fun v _ => v ++ v) = .ok [["a"],["a","a"]] := by rfl
example : structuralRecursion ["a"] ["",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p"] (fun v p => v ++ [p]) = .ok [["a"],["a",""],["a","","p"]] := by rfl
example : structuralRecursion ["a"] ["","p"] (fun v p => p::v) = .ok [["a"],["","a"],["p","","a"]] := by rfl
example : structuralRecursion ["a"] ["","p"] (fun v _ => v) = .ok [["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["","p"] (fun _ p => [p]) = .ok [["a"],[""],["p"]] := by rfl
example : structuralRecursion ["a"] ["","p"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["","q"] (fun v p => v ++ [p]) = .ok [["a"],["a",""],["a","","q"]] := by rfl
example : structuralRecursion ["a"] ["","q"] (fun v p => p::v) = .ok [["a"],["","a"],["q","","a"]] := by rfl
example : structuralRecursion ["a"] ["","q"] (fun v _ => v) = .ok [["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["","q"] (fun _ p => [p]) = .ok [["a"],[""],["q"]] := by rfl
example : structuralRecursion ["a"] ["","q"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["p",""] (fun v p => v ++ [p]) = .ok [["a"],["a","p"],["a","p",""]] := by rfl
example : structuralRecursion ["a"] ["p",""] (fun v p => p::v) = .ok [["a"],["p","a"],["","p","a"]] := by rfl
example : structuralRecursion ["a"] ["p",""] (fun v _ => v) = .ok [["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["p",""] (fun _ p => [p]) = .ok [["a"],["p"],[""]] := by rfl
example : structuralRecursion ["a"] ["p",""] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q"] (fun v p => v ++ [p]) = .ok [["a"],["a","p"],["a","p","q"]] := by rfl
example : structuralRecursion ["a"] ["p","q"] (fun v p => p::v) = .ok [["a"],["p","a"],["q","p","a"]] := by rfl
example : structuralRecursion ["a"] ["p","q"] (fun v _ => v) = .ok [["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["p","q"] (fun _ p => [p]) = .ok [["a"],["p"],["q"]] := by rfl
example : structuralRecursion ["a"] ["p","q"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["q",""] (fun v p => v ++ [p]) = .ok [["a"],["a","q"],["a","q",""]] := by rfl
example : structuralRecursion ["a"] ["q",""] (fun v p => p::v) = .ok [["a"],["q","a"],["","q","a"]] := by rfl
example : structuralRecursion ["a"] ["q",""] (fun v _ => v) = .ok [["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["q",""] (fun _ p => [p]) = .ok [["a"],["q"],[""]] := by rfl
example : structuralRecursion ["a"] ["q",""] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["q","p"] (fun v p => v ++ [p]) = .ok [["a"],["a","q"],["a","q","p"]] := by rfl
example : structuralRecursion ["a"] ["q","p"] (fun v p => p::v) = .ok [["a"],["q","a"],["p","q","a"]] := by rfl
example : structuralRecursion ["a"] ["q","p"] (fun v _ => v) = .ok [["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["q","p"] (fun _ p => [p]) = .ok [["a"],["q"],["p"]] := by rfl
example : structuralRecursion ["a"] ["q","p"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","p","q"] (fun v p => v ++ [p]) = .ok [["a"],["a",""],["a","","p"],["a","","p","q"]] := by rfl
example : structuralRecursion ["a"] ["","p","q"] (fun v p => p::v) = .ok [["a"],["","a"],["p","","a"],["q","p","","a"]] := by rfl
example : structuralRecursion ["a"] ["","p","q"] (fun v _ => v) = .ok [["a"],["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["","p","q"] (fun _ p => [p]) = .ok [["a"],[""],["p"],["q"]] := by rfl
example : structuralRecursion ["a"] ["","p","q"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"],["a","a","a","a","a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q","p"] (fun v p => v ++ [p]) = .ok [["a"],["a",""],["a","","q"],["a","","q","p"]] := by rfl
example : structuralRecursion ["a"] ["","q","p"] (fun v p => p::v) = .ok [["a"],["","a"],["q","","a"],["p","q","","a"]] := by rfl
example : structuralRecursion ["a"] ["","q","p"] (fun v _ => v) = .ok [["a"],["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["","q","p"] (fun _ p => [p]) = .ok [["a"],[""],["q"],["p"]] := by rfl
example : structuralRecursion ["a"] ["","q","p"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"],["a","a","a","a","a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","","q"] (fun v p => v ++ [p]) = .ok [["a"],["a","p"],["a","p",""],["a","p","","q"]] := by rfl
example : structuralRecursion ["a"] ["p","","q"] (fun v p => p::v) = .ok [["a"],["p","a"],["","p","a"],["q","","p","a"]] := by rfl
example : structuralRecursion ["a"] ["p","","q"] (fun v _ => v) = .ok [["a"],["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["p","","q"] (fun _ p => [p]) = .ok [["a"],["p"],[""],["q"]] := by rfl
example : structuralRecursion ["a"] ["p","","q"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"],["a","a","a","a","a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["p","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q",""] (fun v p => v ++ [p]) = .ok [["a"],["a","p"],["a","p","q"],["a","p","q",""]] := by rfl
example : structuralRecursion ["a"] ["p","q",""] (fun v p => p::v) = .ok [["a"],["p","a"],["q","p","a"],["","q","p","a"]] := by rfl
example : structuralRecursion ["a"] ["p","q",""] (fun v _ => v) = .ok [["a"],["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["p","q",""] (fun _ p => [p]) = .ok [["a"],["p"],["q"],[""]] := by rfl
example : structuralRecursion ["a"] ["p","q",""] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"],["a","a","a","a","a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["p","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["p","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","","p"] (fun v p => v ++ [p]) = .ok [["a"],["a","q"],["a","q",""],["a","q","","p"]] := by rfl
example : structuralRecursion ["a"] ["q","","p"] (fun v p => p::v) = .ok [["a"],["q","a"],["","q","a"],["p","","q","a"]] := by rfl
example : structuralRecursion ["a"] ["q","","p"] (fun v _ => v) = .ok [["a"],["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["q","","p"] (fun _ p => [p]) = .ok [["a"],["q"],[""],["p"]] := by rfl
example : structuralRecursion ["a"] ["q","","p"] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"],["a","a","a","a","a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["q","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p",""] (fun v p => v ++ [p]) = .ok [["a"],["a","q"],["a","q","p"],["a","q","p",""]] := by rfl
example : structuralRecursion ["a"] ["q","p",""] (fun v p => p::v) = .ok [["a"],["q","a"],["p","q","a"],["","p","q","a"]] := by rfl
example : structuralRecursion ["a"] ["q","p",""] (fun v _ => v) = .ok [["a"],["a"],["a"],["a"]] := by rfl
example : structuralRecursion ["a"] ["q","p",""] (fun _ p => [p]) = .ok [["a"],["q"],["p"],[""]] := by rfl
example : structuralRecursion ["a"] ["q","p",""] (fun v _ => v ++ v) = .ok [["a"],["a","a"],["a","a","a","a"],["a","a","a","a","a","a","a","a"]] := by rfl
example : structuralRecursion ["a"] ["q","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a"] ["q","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] [] (fun v p => v ++ [p]) = .ok [["a","b"]] := by rfl
example : structuralRecursion ["a","b"] [] (fun v p => p::v) = .ok [["a","b"]] := by rfl
example : structuralRecursion ["a","b"] [] (fun v _ => v) = .ok [["a","b"]] := by rfl
example : structuralRecursion ["a","b"] [] (fun _ p => [p]) = .ok [["a","b"]] := by rfl
example : structuralRecursion ["a","b"] [] (fun v _ => v ++ v) = .ok [["a","b"]] := by rfl
example : structuralRecursion ["a","b"] [""] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b",""]] := by rfl
example : structuralRecursion ["a","b"] [""] (fun v p => p::v) = .ok [["a","b"],["","a","b"]] := by rfl
example : structuralRecursion ["a","b"] [""] (fun v _ => v) = .ok [["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] [""] (fun _ p => [p]) = .ok [["a","b"],[""]] := by rfl
example : structuralRecursion ["a","b"] [""] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","p"]] := by rfl
example : structuralRecursion ["a","b"] ["p"] (fun v p => p::v) = .ok [["a","b"],["p","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p"] (fun v _ => v) = .ok [["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p"] (fun _ p => [p]) = .ok [["a","b"],["p"]] := by rfl
example : structuralRecursion ["a","b"] ["p"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","q"]] := by rfl
example : structuralRecursion ["a","b"] ["q"] (fun v p => p::v) = .ok [["a","b"],["q","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q"] (fun v _ => v) = .ok [["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q"] (fun _ p => [p]) = .ok [["a","b"],["q"]] := by rfl
example : structuralRecursion ["a","b"] ["q"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b",""],["a","b","","p"]] := by rfl
example : structuralRecursion ["a","b"] ["","p"] (fun v p => p::v) = .ok [["a","b"],["","a","b"],["p","","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","p"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","p"] (fun _ p => [p]) = .ok [["a","b"],[""],["p"]] := by rfl
example : structuralRecursion ["a","b"] ["","p"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","q"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b",""],["a","b","","q"]] := by rfl
example : structuralRecursion ["a","b"] ["","q"] (fun v p => p::v) = .ok [["a","b"],["","a","b"],["q","","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","q"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","q"] (fun _ p => [p]) = .ok [["a","b"],[""],["q"]] := by rfl
example : structuralRecursion ["a","b"] ["","q"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p",""] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","p"],["a","b","p",""]] := by rfl
example : structuralRecursion ["a","b"] ["p",""] (fun v p => p::v) = .ok [["a","b"],["p","a","b"],["","p","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p",""] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p",""] (fun _ p => [p]) = .ok [["a","b"],["p"],[""]] := by rfl
example : structuralRecursion ["a","b"] ["p",""] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","p"],["a","b","p","q"]] := by rfl
example : structuralRecursion ["a","b"] ["p","q"] (fun v p => p::v) = .ok [["a","b"],["p","a","b"],["q","p","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","q"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","q"] (fun _ p => [p]) = .ok [["a","b"],["p"],["q"]] := by rfl
example : structuralRecursion ["a","b"] ["p","q"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q",""] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","q"],["a","b","q",""]] := by rfl
example : structuralRecursion ["a","b"] ["q",""] (fun v p => p::v) = .ok [["a","b"],["q","a","b"],["","q","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q",""] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q",""] (fun _ p => [p]) = .ok [["a","b"],["q"],[""]] := by rfl
example : structuralRecursion ["a","b"] ["q",""] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","q"],["a","b","q","p"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p"] (fun v p => p::v) = .ok [["a","b"],["q","a","b"],["p","q","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p"] (fun _ p => [p]) = .ok [["a","b"],["q"],["p"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","p","q"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b",""],["a","b","","p"],["a","b","","p","q"]] := by rfl
example : structuralRecursion ["a","b"] ["","p","q"] (fun v p => p::v) = .ok [["a","b"],["","a","b"],["p","","a","b"],["q","p","","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","p","q"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","p","q"] (fun _ p => [p]) = .ok [["a","b"],[""],["p"],["q"]] := by rfl
example : structuralRecursion ["a","b"] ["","p","q"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"],["a","b","a","b","a","b","a","b","a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q","p"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b",""],["a","b","","q"],["a","b","","q","p"]] := by rfl
example : structuralRecursion ["a","b"] ["","q","p"] (fun v p => p::v) = .ok [["a","b"],["","a","b"],["q","","a","b"],["p","q","","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","q","p"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","q","p"] (fun _ p => [p]) = .ok [["a","b"],[""],["q"],["p"]] := by rfl
example : structuralRecursion ["a","b"] ["","q","p"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"],["a","b","a","b","a","b","a","b","a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","","q"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","p"],["a","b","p",""],["a","b","p","","q"]] := by rfl
example : structuralRecursion ["a","b"] ["p","","q"] (fun v p => p::v) = .ok [["a","b"],["p","a","b"],["","p","a","b"],["q","","p","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","","q"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","","q"] (fun _ p => [p]) = .ok [["a","b"],["p"],[""],["q"]] := by rfl
example : structuralRecursion ["a","b"] ["p","","q"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"],["a","b","a","b","a","b","a","b","a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","p",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q",""] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","p"],["a","b","p","q"],["a","b","p","q",""]] := by rfl
example : structuralRecursion ["a","b"] ["p","q",""] (fun v p => p::v) = .ok [["a","b"],["p","a","b"],["q","p","a","b"],["","q","p","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","q",""] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","q",""] (fun _ p => [p]) = .ok [["a","b"],["p"],["q"],[""]] := by rfl
example : structuralRecursion ["a","b"] ["p","q",""] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"],["a","b","a","b","a","b","a","b","a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["p","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["p","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","","p"] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","q"],["a","b","q",""],["a","b","q","","p"]] := by rfl
example : structuralRecursion ["a","b"] ["q","","p"] (fun v p => p::v) = .ok [["a","b"],["q","a","b"],["","q","a","b"],["p","","q","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","","p"] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","","p"] (fun _ p => [p]) = .ok [["a","b"],["q"],[""],["p"]] := by rfl
example : structuralRecursion ["a","b"] ["q","","p"] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"],["a","b","a","b","a","b","a","b","a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p",""] (fun v p => v ++ [p]) = .ok [["a","b"],["a","b","q"],["a","b","q","p"],["a","b","q","p",""]] := by rfl
example : structuralRecursion ["a","b"] ["q","p",""] (fun v p => p::v) = .ok [["a","b"],["q","a","b"],["p","q","a","b"],["","p","q","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p",""] (fun v _ => v) = .ok [["a","b"],["a","b"],["a","b"],["a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p",""] (fun _ p => [p]) = .ok [["a","b"],["q"],["p"],[""]] := by rfl
example : structuralRecursion ["a","b"] ["q","p",""] (fun v _ => v ++ v) = .ok [["a","b"],["a","b","a","b"],["a","b","a","b","a","b","a","b"],["a","b","a","b","a","b","a","b","a","b","a","b","a","b","a","b"]] := by rfl
example : structuralRecursion ["a","b"] ["q","p","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","p","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q",""] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q",""] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q",""] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q",""] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q",""] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","p"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","p"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","p"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","p"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","p"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","q"] (fun v p => v ++ [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","q"] (fun v p => p::v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","q"] (fun v _ => v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","q"] (fun _ p => [p]) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
example : structuralRecursion ["a","b"] ["q","q","q"] (fun v _ => v ++ v) = .error "ValueError: successor trace must contain unique generated identities" := by rfl
#eval "PASS: 800 exact structural_recursion outputs/errors"
