import SFT.Computation.OneWayness
import SFT.Computation.SecurityPartition
open SFT.Computation
set_option maxRecDepth 10000
example : SecurityPartition.partition [] [] = .ok [] := rfl
example : SecurityPartition.partition [] [("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("a","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("b","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition [] [("c","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v")] = .ok [("v",["a"])] := rfl
example : SecurityPartition.partition ["a"] [("a","w")] = .ok [("w",["a"])] := rfl
example : SecurityPartition.partition ["a"] [("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("a","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("b","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a"] [("c","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","v")] = .ok [("v",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","w")] = .ok [("v",["a"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","v")] = .ok [("v",["b"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","w")] = .ok [("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","v")] = .ok [("v",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","w")] = .ok [("v",["b"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","v")] = .ok [("v",["a"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","w")] = .ok [("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("a","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("b","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a"] [("c","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","v"),("c","v")] = .ok [("v",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","v"),("c","w")] = .ok [("v",["a","b"]),("w",["c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","w"),("c","v")] = .ok [("v",["a","c"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("b","w"),("c","w")] = .ok [("v",["a"]),("w",["b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","v"),("b","v")] = .ok [("v",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","v"),("b","w")] = .ok [("v",["a","c"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","w"),("b","v")] = .ok [("v",["a","b"]),("w",["c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","w"),("b","w")] = .ok [("v",["a"]),("w",["b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","v"),("c","v")] = .ok [("v",["b","c"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","v"),("c","w")] = .ok [("v",["b"]),("w",["a","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","w"),("c","v")] = .ok [("v",["c"]),("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("b","w"),("c","w")] = .ok [("w",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","v"),("b","v")] = .ok [("v",["b","c"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","v"),("b","w")] = .ok [("v",["c"]),("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","w"),("b","v")] = .ok [("v",["b"]),("w",["a","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","w"),("b","w")] = .ok [("w",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("a","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","v"),("c","v")] = .ok [("v",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","v"),("c","w")] = .ok [("v",["a","b"]),("w",["c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","w"),("c","v")] = .ok [("v",["b","c"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("a","w"),("c","w")] = .ok [("v",["b"]),("w",["a","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","v"),("a","v")] = .ok [("v",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","v"),("a","w")] = .ok [("v",["b","c"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","w"),("a","v")] = .ok [("v",["a","b"]),("w",["c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","w"),("a","w")] = .ok [("v",["b"]),("w",["a","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","v"),("c","v")] = .ok [("v",["a","c"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","v"),("c","w")] = .ok [("v",["a"]),("w",["b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","w"),("c","v")] = .ok [("v",["c"]),("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("a","w"),("c","w")] = .ok [("w",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","v"),("a","v")] = .ok [("v",["a","c"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","v"),("a","w")] = .ok [("v",["c"]),("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","w"),("a","v")] = .ok [("v",["a"]),("w",["b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","w"),("a","w")] = .ok [("w",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("b","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","v"),("b","v")] = .ok [("v",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","v"),("b","w")] = .ok [("v",["a","c"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","w"),("b","v")] = .ok [("v",["b","c"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","w"),("b","w")] = .ok [("v",["c"]),("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","v"),("a","v")] = .ok [("v",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","v"),("a","w")] = .ok [("v",["b","c"]),("w",["a"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","w"),("a","v")] = .ok [("v",["a","c"]),("w",["b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","w"),("a","w")] = .ok [("v",["c"]),("w",["a","b"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","v"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","v"),("b","v")] = .ok [("v",["a","b"]),("w",["c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","v"),("b","w")] = .ok [("v",["a"]),("w",["b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","w"),("b","v")] = .ok [("v",["b"]),("w",["a","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","w"),("b","w")] = .ok [("w",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("a","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","v"),("a","v")] = .ok [("v",["a","b"]),("w",["c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","v"),("a","w")] = .ok [("v",["b"]),("w",["a","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","w"),("a","v")] = .ok [("v",["a"]),("w",["b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","w"),("a","w")] = .ok [("w",["a","b","c"])] := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("b","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","v"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","v"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","v"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","v"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","v"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","v"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","w"),("a","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","w"),("a","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","w"),("b","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","w"),("b","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","w"),("c","v")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["b","a","c"] [("c","w"),("c","w"),("c","w")] = .error "ValueError: security observation must cover each message exactly once" := rfl
example : SecurityPartition.partition ["a","a"] [] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("a","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("b","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","v"),("c","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("a","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("b","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("a","w"),("c","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("a","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("b","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","v"),("c","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("a","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("b","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("b","w"),("c","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("a","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("b","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","v"),("c","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("a","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("b","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","v"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","v"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","v"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","v"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","v"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","v"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","w"),("a","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","w"),("a","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","w"),("b","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","w"),("b","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","w"),("c","v")] = .error "ValueError: messages must contain unique generated identities" := rfl
example : SecurityPartition.partition ["a","a"] [("c","w"),("c","w"),("c","w")] = .error "ValueError: messages must contain unique generated identities" := rfl
def forward : OneWayness.Forward where
  support := ["a","b"]
  mapping := [("a","v"),("b","v")]
  total := by
    intro x h; cases h with
    | head => exact ⟨"v",rfl⟩
    | tail _ h => cases h with
      | head => exact ⟨"v",rfl⟩
      | tail _ h => cases h
example : OneWayness.success forward ⟨"attempt","v","a",[],[]⟩ = true := rfl
example : OneWayness.success forward ⟨"attempt","v","b",[],[]⟩ = true := rfl
example : OneWayness.success forward ⟨"attempt","v","outside",[],[]⟩ = false := rfl
example : OneWayness.success forward ⟨"attempt","w","a",[],[]⟩ = false := rfl
example : OneWayness.success forward ⟨"attempt","w","b",[],[]⟩ = false := rfl
example : OneWayness.success forward ⟨"attempt","w","outside",[],[]⟩ = false := rfl
#print axioms forward

def bad : OneWayness.Attempt := ⟨"bad","v","outside",[],["s"]⟩
def good : OneWayness.Attempt := ⟨"good","v","a",["step"],["s","s"]⟩
def grammar : OneWayness.Grammar := ⟨⟨["s"],["step"],[("s","step","s")]⟩,"s",[bad,good],0⟩
example : OneWayness.allBoundedFail forward grammar = true := rfl
example : OneWayness.allBoundedFail forward {grammar with bound := 1} = false := rfl
example : OneWayness.allBoundedFail forward {grammar with bound := 1, attempts := [bad,{good with states := []}]} = true := rfl
example : (OneWayness.boundedAttempts grammar).length = 1 := rfl
theorem nativeResourceBoundary : ¬ ∃ a, OneWayness.admitted grammar a ∧ OneWayness.success forward a = true :=
  OneWayness.computedNoAdmittedSuccess forward grammar rfl
#print axioms nativeResourceBoundary
