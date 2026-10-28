import SFT.Computation.BindingSubstitution
open SFT.Computation.BindingTerms SFT.Computation.BindingSubstitution
example : free (.var "") "" = true := rfl
example : free (.var "") "x" = false := rfl
example : free (.var "") "y" = false := rfl
example : free (.var "") "u" = false := rfl
example : free (.var "") "v" = false := rfl
example : free (.var "") "w" = false := rfl
example : free (.var "") "z" = false := rfl
example : free (.var "x") "" = false := rfl
example : free (.var "x") "x" = true := rfl
example : free (.var "x") "y" = false := rfl
example : free (.var "x") "u" = false := rfl
example : free (.var "x") "v" = false := rfl
example : free (.var "x") "w" = false := rfl
example : free (.var "x") "z" = false := rfl
example : free (.var "y") "" = false := rfl
example : free (.var "y") "x" = false := rfl
example : free (.var "y") "y" = true := rfl
example : free (.var "y") "u" = false := rfl
example : free (.var "y") "v" = false := rfl
example : free (.var "y") "w" = false := rfl
example : free (.var "y") "z" = false := rfl
example : free (.var "u") "" = false := rfl
example : free (.var "u") "x" = false := rfl
example : free (.var "u") "y" = false := rfl
example : free (.var "u") "u" = true := rfl
example : free (.var "u") "v" = false := rfl
example : free (.var "u") "w" = false := rfl
example : free (.var "u") "z" = false := rfl
example : free (.var "v") "" = false := rfl
example : free (.var "v") "x" = false := rfl
example : free (.var "v") "y" = false := rfl
example : free (.var "v") "u" = false := rfl
example : free (.var "v") "v" = true := rfl
example : free (.var "v") "w" = false := rfl
example : free (.var "v") "z" = false := rfl
example : free (.var "w") "" = false := rfl
example : free (.var "w") "x" = false := rfl
example : free (.var "w") "y" = false := rfl
example : free (.var "w") "u" = false := rfl
example : free (.var "w") "v" = false := rfl
example : free (.var "w") "w" = true := rfl
example : free (.var "w") "z" = false := rfl
example : free (.var "z") "" = false := rfl
example : free (.var "z") "x" = false := rfl
example : free (.var "z") "y" = false := rfl
example : free (.var "z") "u" = false := rfl
example : free (.var "z") "v" = false := rfl
example : free (.var "z") "w" = false := rfl
example : free (.var "z") "z" = true := rfl
example : free (.app (.var "") (.var "")) "" = true := rfl
example : free (.app (.var "") (.var "")) "x" = false := rfl
example : free (.app (.var "") (.var "")) "y" = false := rfl
example : free (.app (.var "") (.var "")) "u" = false := rfl
example : free (.app (.var "") (.var "")) "v" = false := rfl
example : free (.app (.var "") (.var "")) "w" = false := rfl
example : free (.app (.var "") (.var "")) "z" = false := rfl
example : free (.app (.var "") (.var "x")) "" = true := rfl
example : free (.app (.var "") (.var "x")) "x" = true := rfl
example : free (.app (.var "") (.var "x")) "y" = false := rfl
example : free (.app (.var "") (.var "x")) "u" = false := rfl
example : free (.app (.var "") (.var "x")) "v" = false := rfl
example : free (.app (.var "") (.var "x")) "w" = false := rfl
example : free (.app (.var "") (.var "x")) "z" = false := rfl
example : free (.app (.var "") (.var "y")) "" = true := rfl
example : free (.app (.var "") (.var "y")) "x" = false := rfl
example : free (.app (.var "") (.var "y")) "y" = true := rfl
example : free (.app (.var "") (.var "y")) "u" = false := rfl
example : free (.app (.var "") (.var "y")) "v" = false := rfl
example : free (.app (.var "") (.var "y")) "w" = false := rfl
example : free (.app (.var "") (.var "y")) "z" = false := rfl
example : free (.app (.var "") (.var "u")) "" = true := rfl
example : free (.app (.var "") (.var "u")) "x" = false := rfl
example : free (.app (.var "") (.var "u")) "y" = false := rfl
example : free (.app (.var "") (.var "u")) "u" = true := rfl
example : free (.app (.var "") (.var "u")) "v" = false := rfl
example : free (.app (.var "") (.var "u")) "w" = false := rfl
example : free (.app (.var "") (.var "u")) "z" = false := rfl
example : free (.app (.var "") (.var "v")) "" = true := rfl
example : free (.app (.var "") (.var "v")) "x" = false := rfl
example : free (.app (.var "") (.var "v")) "y" = false := rfl
example : free (.app (.var "") (.var "v")) "u" = false := rfl
example : free (.app (.var "") (.var "v")) "v" = true := rfl
example : free (.app (.var "") (.var "v")) "w" = false := rfl
example : free (.app (.var "") (.var "v")) "z" = false := rfl
example : free (.app (.var "") (.var "w")) "" = true := rfl
example : free (.app (.var "") (.var "w")) "x" = false := rfl
example : free (.app (.var "") (.var "w")) "y" = false := rfl
example : free (.app (.var "") (.var "w")) "u" = false := rfl
example : free (.app (.var "") (.var "w")) "v" = false := rfl
example : free (.app (.var "") (.var "w")) "w" = true := rfl
example : free (.app (.var "") (.var "w")) "z" = false := rfl
example : free (.app (.var "") (.var "z")) "" = true := rfl
example : free (.app (.var "") (.var "z")) "x" = false := rfl
example : free (.app (.var "") (.var "z")) "y" = false := rfl
example : free (.app (.var "") (.var "z")) "u" = false := rfl
example : free (.app (.var "") (.var "z")) "v" = false := rfl
example : free (.app (.var "") (.var "z")) "w" = false := rfl
example : free (.app (.var "") (.var "z")) "z" = true := rfl
example : free (.app (.var "x") (.var "")) "" = true := rfl
example : free (.app (.var "x") (.var "")) "x" = true := rfl
example : free (.app (.var "x") (.var "")) "y" = false := rfl
example : free (.app (.var "x") (.var "")) "u" = false := rfl
example : free (.app (.var "x") (.var "")) "v" = false := rfl
example : free (.app (.var "x") (.var "")) "w" = false := rfl
example : free (.app (.var "x") (.var "")) "z" = false := rfl
example : free (.app (.var "x") (.var "x")) "" = false := rfl
example : free (.app (.var "x") (.var "x")) "x" = true := rfl
example : free (.app (.var "x") (.var "x")) "y" = false := rfl
example : free (.app (.var "x") (.var "x")) "u" = false := rfl
example : free (.app (.var "x") (.var "x")) "v" = false := rfl
example : free (.app (.var "x") (.var "x")) "w" = false := rfl
example : free (.app (.var "x") (.var "x")) "z" = false := rfl
example : free (.app (.var "x") (.var "y")) "" = false := rfl
example : free (.app (.var "x") (.var "y")) "x" = true := rfl
example : free (.app (.var "x") (.var "y")) "y" = true := rfl
example : free (.app (.var "x") (.var "y")) "u" = false := rfl
example : free (.app (.var "x") (.var "y")) "v" = false := rfl
example : free (.app (.var "x") (.var "y")) "w" = false := rfl
example : free (.app (.var "x") (.var "y")) "z" = false := rfl
example : free (.app (.var "x") (.var "u")) "" = false := rfl
example : free (.app (.var "x") (.var "u")) "x" = true := rfl
example : free (.app (.var "x") (.var "u")) "y" = false := rfl
example : free (.app (.var "x") (.var "u")) "u" = true := rfl
example : free (.app (.var "x") (.var "u")) "v" = false := rfl
example : free (.app (.var "x") (.var "u")) "w" = false := rfl
example : free (.app (.var "x") (.var "u")) "z" = false := rfl
example : free (.app (.var "x") (.var "v")) "" = false := rfl
example : free (.app (.var "x") (.var "v")) "x" = true := rfl
example : free (.app (.var "x") (.var "v")) "y" = false := rfl
example : free (.app (.var "x") (.var "v")) "u" = false := rfl
example : free (.app (.var "x") (.var "v")) "v" = true := rfl
example : free (.app (.var "x") (.var "v")) "w" = false := rfl
example : free (.app (.var "x") (.var "v")) "z" = false := rfl
example : free (.app (.var "x") (.var "w")) "" = false := rfl
example : free (.app (.var "x") (.var "w")) "x" = true := rfl
example : free (.app (.var "x") (.var "w")) "y" = false := rfl
example : free (.app (.var "x") (.var "w")) "u" = false := rfl
example : free (.app (.var "x") (.var "w")) "v" = false := rfl
example : free (.app (.var "x") (.var "w")) "w" = true := rfl
example : free (.app (.var "x") (.var "w")) "z" = false := rfl
example : free (.app (.var "x") (.var "z")) "" = false := rfl
example : free (.app (.var "x") (.var "z")) "x" = true := rfl
example : free (.app (.var "x") (.var "z")) "y" = false := rfl
example : free (.app (.var "x") (.var "z")) "u" = false := rfl
example : free (.app (.var "x") (.var "z")) "v" = false := rfl
example : free (.app (.var "x") (.var "z")) "w" = false := rfl
example : free (.app (.var "x") (.var "z")) "z" = true := rfl
example : free (.app (.var "y") (.var "")) "" = true := rfl
example : free (.app (.var "y") (.var "")) "x" = false := rfl
example : free (.app (.var "y") (.var "")) "y" = true := rfl
example : free (.app (.var "y") (.var "")) "u" = false := rfl
example : free (.app (.var "y") (.var "")) "v" = false := rfl
example : free (.app (.var "y") (.var "")) "w" = false := rfl
example : free (.app (.var "y") (.var "")) "z" = false := rfl
example : free (.app (.var "y") (.var "x")) "" = false := rfl
example : free (.app (.var "y") (.var "x")) "x" = true := rfl
example : free (.app (.var "y") (.var "x")) "y" = true := rfl
example : free (.app (.var "y") (.var "x")) "u" = false := rfl
example : free (.app (.var "y") (.var "x")) "v" = false := rfl
example : free (.app (.var "y") (.var "x")) "w" = false := rfl
example : free (.app (.var "y") (.var "x")) "z" = false := rfl
example : free (.app (.var "y") (.var "y")) "" = false := rfl
example : free (.app (.var "y") (.var "y")) "x" = false := rfl
example : free (.app (.var "y") (.var "y")) "y" = true := rfl
example : free (.app (.var "y") (.var "y")) "u" = false := rfl
example : free (.app (.var "y") (.var "y")) "v" = false := rfl
example : free (.app (.var "y") (.var "y")) "w" = false := rfl
example : free (.app (.var "y") (.var "y")) "z" = false := rfl
example : free (.app (.var "y") (.var "u")) "" = false := rfl
example : free (.app (.var "y") (.var "u")) "x" = false := rfl
example : free (.app (.var "y") (.var "u")) "y" = true := rfl
example : free (.app (.var "y") (.var "u")) "u" = true := rfl
example : free (.app (.var "y") (.var "u")) "v" = false := rfl
example : free (.app (.var "y") (.var "u")) "w" = false := rfl
example : free (.app (.var "y") (.var "u")) "z" = false := rfl
example : free (.app (.var "y") (.var "v")) "" = false := rfl
example : free (.app (.var "y") (.var "v")) "x" = false := rfl
example : free (.app (.var "y") (.var "v")) "y" = true := rfl
example : free (.app (.var "y") (.var "v")) "u" = false := rfl
example : free (.app (.var "y") (.var "v")) "v" = true := rfl
example : free (.app (.var "y") (.var "v")) "w" = false := rfl
example : free (.app (.var "y") (.var "v")) "z" = false := rfl
example : free (.app (.var "y") (.var "w")) "" = false := rfl
example : free (.app (.var "y") (.var "w")) "x" = false := rfl
example : free (.app (.var "y") (.var "w")) "y" = true := rfl
example : free (.app (.var "y") (.var "w")) "u" = false := rfl
example : free (.app (.var "y") (.var "w")) "v" = false := rfl
example : free (.app (.var "y") (.var "w")) "w" = true := rfl
example : free (.app (.var "y") (.var "w")) "z" = false := rfl
example : free (.app (.var "y") (.var "z")) "" = false := rfl
example : free (.app (.var "y") (.var "z")) "x" = false := rfl
example : free (.app (.var "y") (.var "z")) "y" = true := rfl
example : free (.app (.var "y") (.var "z")) "u" = false := rfl
example : free (.app (.var "y") (.var "z")) "v" = false := rfl
example : free (.app (.var "y") (.var "z")) "w" = false := rfl
example : free (.app (.var "y") (.var "z")) "z" = true := rfl
example : free (.app (.var "u") (.var "")) "" = true := rfl
example : free (.app (.var "u") (.var "")) "x" = false := rfl
example : free (.app (.var "u") (.var "")) "y" = false := rfl
example : free (.app (.var "u") (.var "")) "u" = true := rfl
example : free (.app (.var "u") (.var "")) "v" = false := rfl
example : free (.app (.var "u") (.var "")) "w" = false := rfl
example : free (.app (.var "u") (.var "")) "z" = false := rfl
example : free (.app (.var "u") (.var "x")) "" = false := rfl
example : free (.app (.var "u") (.var "x")) "x" = true := rfl
example : free (.app (.var "u") (.var "x")) "y" = false := rfl
example : free (.app (.var "u") (.var "x")) "u" = true := rfl
example : free (.app (.var "u") (.var "x")) "v" = false := rfl
example : free (.app (.var "u") (.var "x")) "w" = false := rfl
example : free (.app (.var "u") (.var "x")) "z" = false := rfl
example : free (.app (.var "u") (.var "y")) "" = false := rfl
example : free (.app (.var "u") (.var "y")) "x" = false := rfl
example : free (.app (.var "u") (.var "y")) "y" = true := rfl
example : free (.app (.var "u") (.var "y")) "u" = true := rfl
example : free (.app (.var "u") (.var "y")) "v" = false := rfl
example : free (.app (.var "u") (.var "y")) "w" = false := rfl
example : free (.app (.var "u") (.var "y")) "z" = false := rfl
example : free (.app (.var "u") (.var "u")) "" = false := rfl
example : free (.app (.var "u") (.var "u")) "x" = false := rfl
example : free (.app (.var "u") (.var "u")) "y" = false := rfl
example : free (.app (.var "u") (.var "u")) "u" = true := rfl
example : free (.app (.var "u") (.var "u")) "v" = false := rfl
example : free (.app (.var "u") (.var "u")) "w" = false := rfl
example : free (.app (.var "u") (.var "u")) "z" = false := rfl
example : free (.app (.var "u") (.var "v")) "" = false := rfl
example : free (.app (.var "u") (.var "v")) "x" = false := rfl
example : free (.app (.var "u") (.var "v")) "y" = false := rfl
example : free (.app (.var "u") (.var "v")) "u" = true := rfl
example : free (.app (.var "u") (.var "v")) "v" = true := rfl
example : free (.app (.var "u") (.var "v")) "w" = false := rfl
example : free (.app (.var "u") (.var "v")) "z" = false := rfl
example : free (.app (.var "u") (.var "w")) "" = false := rfl
example : free (.app (.var "u") (.var "w")) "x" = false := rfl
example : free (.app (.var "u") (.var "w")) "y" = false := rfl
example : free (.app (.var "u") (.var "w")) "u" = true := rfl
example : free (.app (.var "u") (.var "w")) "v" = false := rfl
example : free (.app (.var "u") (.var "w")) "w" = true := rfl
example : free (.app (.var "u") (.var "w")) "z" = false := rfl
example : free (.app (.var "u") (.var "z")) "" = false := rfl
example : free (.app (.var "u") (.var "z")) "x" = false := rfl
example : free (.app (.var "u") (.var "z")) "y" = false := rfl
example : free (.app (.var "u") (.var "z")) "u" = true := rfl
example : free (.app (.var "u") (.var "z")) "v" = false := rfl
example : free (.app (.var "u") (.var "z")) "w" = false := rfl
example : free (.app (.var "u") (.var "z")) "z" = true := rfl
example : free (.app (.var "v") (.var "")) "" = true := rfl
example : free (.app (.var "v") (.var "")) "x" = false := rfl
example : free (.app (.var "v") (.var "")) "y" = false := rfl
example : free (.app (.var "v") (.var "")) "u" = false := rfl
example : free (.app (.var "v") (.var "")) "v" = true := rfl
example : free (.app (.var "v") (.var "")) "w" = false := rfl
example : free (.app (.var "v") (.var "")) "z" = false := rfl
example : free (.app (.var "v") (.var "x")) "" = false := rfl
example : free (.app (.var "v") (.var "x")) "x" = true := rfl
example : free (.app (.var "v") (.var "x")) "y" = false := rfl
example : free (.app (.var "v") (.var "x")) "u" = false := rfl
example : free (.app (.var "v") (.var "x")) "v" = true := rfl
example : free (.app (.var "v") (.var "x")) "w" = false := rfl
example : free (.app (.var "v") (.var "x")) "z" = false := rfl
example : free (.app (.var "v") (.var "y")) "" = false := rfl
example : free (.app (.var "v") (.var "y")) "x" = false := rfl
example : free (.app (.var "v") (.var "y")) "y" = true := rfl
example : free (.app (.var "v") (.var "y")) "u" = false := rfl
example : free (.app (.var "v") (.var "y")) "v" = true := rfl
example : free (.app (.var "v") (.var "y")) "w" = false := rfl
example : free (.app (.var "v") (.var "y")) "z" = false := rfl
example : free (.app (.var "v") (.var "u")) "" = false := rfl
example : free (.app (.var "v") (.var "u")) "x" = false := rfl
example : free (.app (.var "v") (.var "u")) "y" = false := rfl
example : free (.app (.var "v") (.var "u")) "u" = true := rfl
example : free (.app (.var "v") (.var "u")) "v" = true := rfl
example : free (.app (.var "v") (.var "u")) "w" = false := rfl
example : free (.app (.var "v") (.var "u")) "z" = false := rfl
example : free (.app (.var "v") (.var "v")) "" = false := rfl
example : free (.app (.var "v") (.var "v")) "x" = false := rfl
example : free (.app (.var "v") (.var "v")) "y" = false := rfl
example : free (.app (.var "v") (.var "v")) "u" = false := rfl
example : free (.app (.var "v") (.var "v")) "v" = true := rfl
example : free (.app (.var "v") (.var "v")) "w" = false := rfl
example : free (.app (.var "v") (.var "v")) "z" = false := rfl
example : free (.app (.var "v") (.var "w")) "" = false := rfl
example : free (.app (.var "v") (.var "w")) "x" = false := rfl
example : free (.app (.var "v") (.var "w")) "y" = false := rfl
example : free (.app (.var "v") (.var "w")) "u" = false := rfl
example : free (.app (.var "v") (.var "w")) "v" = true := rfl
example : free (.app (.var "v") (.var "w")) "w" = true := rfl
example : free (.app (.var "v") (.var "w")) "z" = false := rfl
example : free (.app (.var "v") (.var "z")) "" = false := rfl
example : free (.app (.var "v") (.var "z")) "x" = false := rfl
example : free (.app (.var "v") (.var "z")) "y" = false := rfl
example : free (.app (.var "v") (.var "z")) "u" = false := rfl
example : free (.app (.var "v") (.var "z")) "v" = true := rfl
example : free (.app (.var "v") (.var "z")) "w" = false := rfl
example : free (.app (.var "v") (.var "z")) "z" = true := rfl
example : free (.app (.var "w") (.var "")) "" = true := rfl
example : free (.app (.var "w") (.var "")) "x" = false := rfl
example : free (.app (.var "w") (.var "")) "y" = false := rfl
example : free (.app (.var "w") (.var "")) "u" = false := rfl
example : free (.app (.var "w") (.var "")) "v" = false := rfl
example : free (.app (.var "w") (.var "")) "w" = true := rfl
example : free (.app (.var "w") (.var "")) "z" = false := rfl
example : free (.app (.var "w") (.var "x")) "" = false := rfl
example : free (.app (.var "w") (.var "x")) "x" = true := rfl
example : free (.app (.var "w") (.var "x")) "y" = false := rfl
example : free (.app (.var "w") (.var "x")) "u" = false := rfl
example : free (.app (.var "w") (.var "x")) "v" = false := rfl
example : free (.app (.var "w") (.var "x")) "w" = true := rfl
example : free (.app (.var "w") (.var "x")) "z" = false := rfl
example : free (.app (.var "w") (.var "y")) "" = false := rfl
example : free (.app (.var "w") (.var "y")) "x" = false := rfl
example : free (.app (.var "w") (.var "y")) "y" = true := rfl
example : free (.app (.var "w") (.var "y")) "u" = false := rfl
example : free (.app (.var "w") (.var "y")) "v" = false := rfl
example : free (.app (.var "w") (.var "y")) "w" = true := rfl
example : free (.app (.var "w") (.var "y")) "z" = false := rfl
example : free (.app (.var "w") (.var "u")) "" = false := rfl
example : free (.app (.var "w") (.var "u")) "x" = false := rfl
example : free (.app (.var "w") (.var "u")) "y" = false := rfl
example : free (.app (.var "w") (.var "u")) "u" = true := rfl
example : free (.app (.var "w") (.var "u")) "v" = false := rfl
example : free (.app (.var "w") (.var "u")) "w" = true := rfl
example : free (.app (.var "w") (.var "u")) "z" = false := rfl
example : free (.app (.var "w") (.var "v")) "" = false := rfl
example : free (.app (.var "w") (.var "v")) "x" = false := rfl
example : free (.app (.var "w") (.var "v")) "y" = false := rfl
example : free (.app (.var "w") (.var "v")) "u" = false := rfl
example : free (.app (.var "w") (.var "v")) "v" = true := rfl
example : free (.app (.var "w") (.var "v")) "w" = true := rfl
example : free (.app (.var "w") (.var "v")) "z" = false := rfl
example : free (.app (.var "w") (.var "w")) "" = false := rfl
example : free (.app (.var "w") (.var "w")) "x" = false := rfl
example : free (.app (.var "w") (.var "w")) "y" = false := rfl
example : free (.app (.var "w") (.var "w")) "u" = false := rfl
example : free (.app (.var "w") (.var "w")) "v" = false := rfl
example : free (.app (.var "w") (.var "w")) "w" = true := rfl
example : free (.app (.var "w") (.var "w")) "z" = false := rfl
example : free (.app (.var "w") (.var "z")) "" = false := rfl
example : free (.app (.var "w") (.var "z")) "x" = false := rfl
example : free (.app (.var "w") (.var "z")) "y" = false := rfl
example : free (.app (.var "w") (.var "z")) "u" = false := rfl
example : free (.app (.var "w") (.var "z")) "v" = false := rfl
example : free (.app (.var "w") (.var "z")) "w" = true := rfl
example : free (.app (.var "w") (.var "z")) "z" = true := rfl
example : free (.app (.var "z") (.var "")) "" = true := rfl
example : free (.app (.var "z") (.var "")) "x" = false := rfl
example : free (.app (.var "z") (.var "")) "y" = false := rfl
example : free (.app (.var "z") (.var "")) "u" = false := rfl
example : free (.app (.var "z") (.var "")) "v" = false := rfl
example : free (.app (.var "z") (.var "")) "w" = false := rfl
example : free (.app (.var "z") (.var "")) "z" = true := rfl
example : free (.app (.var "z") (.var "x")) "" = false := rfl
example : free (.app (.var "z") (.var "x")) "x" = true := rfl
example : free (.app (.var "z") (.var "x")) "y" = false := rfl
example : free (.app (.var "z") (.var "x")) "u" = false := rfl
example : free (.app (.var "z") (.var "x")) "v" = false := rfl
example : free (.app (.var "z") (.var "x")) "w" = false := rfl
example : free (.app (.var "z") (.var "x")) "z" = true := rfl
example : free (.app (.var "z") (.var "y")) "" = false := rfl
example : free (.app (.var "z") (.var "y")) "x" = false := rfl
example : free (.app (.var "z") (.var "y")) "y" = true := rfl
example : free (.app (.var "z") (.var "y")) "u" = false := rfl
example : free (.app (.var "z") (.var "y")) "v" = false := rfl
example : free (.app (.var "z") (.var "y")) "w" = false := rfl
example : free (.app (.var "z") (.var "y")) "z" = true := rfl
example : free (.app (.var "z") (.var "u")) "" = false := rfl
example : free (.app (.var "z") (.var "u")) "x" = false := rfl
example : free (.app (.var "z") (.var "u")) "y" = false := rfl
example : free (.app (.var "z") (.var "u")) "u" = true := rfl
example : free (.app (.var "z") (.var "u")) "v" = false := rfl
example : free (.app (.var "z") (.var "u")) "w" = false := rfl
example : free (.app (.var "z") (.var "u")) "z" = true := rfl
example : free (.app (.var "z") (.var "v")) "" = false := rfl
example : free (.app (.var "z") (.var "v")) "x" = false := rfl
example : free (.app (.var "z") (.var "v")) "y" = false := rfl
example : free (.app (.var "z") (.var "v")) "u" = false := rfl
example : free (.app (.var "z") (.var "v")) "v" = true := rfl
example : free (.app (.var "z") (.var "v")) "w" = false := rfl
example : free (.app (.var "z") (.var "v")) "z" = true := rfl
example : free (.app (.var "z") (.var "w")) "" = false := rfl
example : free (.app (.var "z") (.var "w")) "x" = false := rfl
example : free (.app (.var "z") (.var "w")) "y" = false := rfl
example : free (.app (.var "z") (.var "w")) "u" = false := rfl
example : free (.app (.var "z") (.var "w")) "v" = false := rfl
example : free (.app (.var "z") (.var "w")) "w" = true := rfl
example : free (.app (.var "z") (.var "w")) "z" = true := rfl
example : free (.app (.var "z") (.var "z")) "" = false := rfl
example : free (.app (.var "z") (.var "z")) "x" = false := rfl
example : free (.app (.var "z") (.var "z")) "y" = false := rfl
example : free (.app (.var "z") (.var "z")) "u" = false := rfl
example : free (.app (.var "z") (.var "z")) "v" = false := rfl
example : free (.app (.var "z") (.var "z")) "w" = false := rfl
example : free (.app (.var "z") (.var "z")) "z" = true := rfl
example : free (.abs "" (.var "")) "" = false := rfl
example : free (.abs "" (.var "")) "x" = false := rfl
example : free (.abs "" (.var "")) "y" = false := rfl
example : free (.abs "" (.var "")) "u" = false := rfl
example : free (.abs "" (.var "")) "v" = false := rfl
example : free (.abs "" (.var "")) "w" = false := rfl
example : free (.abs "" (.var "")) "z" = false := rfl
example : free (.abs "" (.var "x")) "" = false := rfl
example : free (.abs "" (.var "x")) "x" = true := rfl
example : free (.abs "" (.var "x")) "y" = false := rfl
example : free (.abs "" (.var "x")) "u" = false := rfl
example : free (.abs "" (.var "x")) "v" = false := rfl
example : free (.abs "" (.var "x")) "w" = false := rfl
example : free (.abs "" (.var "x")) "z" = false := rfl
example : free (.abs "" (.var "y")) "" = false := rfl
example : free (.abs "" (.var "y")) "x" = false := rfl
example : free (.abs "" (.var "y")) "y" = true := rfl
example : free (.abs "" (.var "y")) "u" = false := rfl
example : free (.abs "" (.var "y")) "v" = false := rfl
example : free (.abs "" (.var "y")) "w" = false := rfl
example : free (.abs "" (.var "y")) "z" = false := rfl
example : free (.abs "" (.var "u")) "" = false := rfl
example : free (.abs "" (.var "u")) "x" = false := rfl
example : free (.abs "" (.var "u")) "y" = false := rfl
example : free (.abs "" (.var "u")) "u" = true := rfl
example : free (.abs "" (.var "u")) "v" = false := rfl
example : free (.abs "" (.var "u")) "w" = false := rfl
example : free (.abs "" (.var "u")) "z" = false := rfl
example : free (.abs "" (.var "v")) "" = false := rfl
example : free (.abs "" (.var "v")) "x" = false := rfl
example : free (.abs "" (.var "v")) "y" = false := rfl
example : free (.abs "" (.var "v")) "u" = false := rfl
example : free (.abs "" (.var "v")) "v" = true := rfl
example : free (.abs "" (.var "v")) "w" = false := rfl
example : free (.abs "" (.var "v")) "z" = false := rfl
example : free (.abs "" (.var "w")) "" = false := rfl
example : free (.abs "" (.var "w")) "x" = false := rfl
example : free (.abs "" (.var "w")) "y" = false := rfl
example : free (.abs "" (.var "w")) "u" = false := rfl
example : free (.abs "" (.var "w")) "v" = false := rfl
example : free (.abs "" (.var "w")) "w" = true := rfl
example : free (.abs "" (.var "w")) "z" = false := rfl
example : free (.abs "" (.var "z")) "" = false := rfl
example : free (.abs "" (.var "z")) "x" = false := rfl
example : free (.abs "" (.var "z")) "y" = false := rfl
example : free (.abs "" (.var "z")) "u" = false := rfl
example : free (.abs "" (.var "z")) "v" = false := rfl
example : free (.abs "" (.var "z")) "w" = false := rfl
example : free (.abs "" (.var "z")) "z" = true := rfl
example : free (.abs "x" (.var "")) "" = true := rfl
example : free (.abs "x" (.var "")) "x" = false := rfl
example : free (.abs "x" (.var "")) "y" = false := rfl
example : free (.abs "x" (.var "")) "u" = false := rfl
example : free (.abs "x" (.var "")) "v" = false := rfl
example : free (.abs "x" (.var "")) "w" = false := rfl
example : free (.abs "x" (.var "")) "z" = false := rfl
example : free (.abs "x" (.var "x")) "" = false := rfl
example : free (.abs "x" (.var "x")) "x" = false := rfl
example : free (.abs "x" (.var "x")) "y" = false := rfl
example : free (.abs "x" (.var "x")) "u" = false := rfl
example : free (.abs "x" (.var "x")) "v" = false := rfl
example : free (.abs "x" (.var "x")) "w" = false := rfl
example : free (.abs "x" (.var "x")) "z" = false := rfl
example : free (.abs "x" (.var "y")) "" = false := rfl
example : free (.abs "x" (.var "y")) "x" = false := rfl
example : free (.abs "x" (.var "y")) "y" = true := rfl
example : free (.abs "x" (.var "y")) "u" = false := rfl
example : free (.abs "x" (.var "y")) "v" = false := rfl
example : free (.abs "x" (.var "y")) "w" = false := rfl
example : free (.abs "x" (.var "y")) "z" = false := rfl
example : free (.abs "x" (.var "u")) "" = false := rfl
example : free (.abs "x" (.var "u")) "x" = false := rfl
example : free (.abs "x" (.var "u")) "y" = false := rfl
example : free (.abs "x" (.var "u")) "u" = true := rfl
example : free (.abs "x" (.var "u")) "v" = false := rfl
example : free (.abs "x" (.var "u")) "w" = false := rfl
example : free (.abs "x" (.var "u")) "z" = false := rfl
example : free (.abs "x" (.var "v")) "" = false := rfl
example : free (.abs "x" (.var "v")) "x" = false := rfl
example : free (.abs "x" (.var "v")) "y" = false := rfl
example : free (.abs "x" (.var "v")) "u" = false := rfl
example : free (.abs "x" (.var "v")) "v" = true := rfl
example : free (.abs "x" (.var "v")) "w" = false := rfl
example : free (.abs "x" (.var "v")) "z" = false := rfl
example : free (.abs "x" (.var "w")) "" = false := rfl
example : free (.abs "x" (.var "w")) "x" = false := rfl
example : free (.abs "x" (.var "w")) "y" = false := rfl
example : free (.abs "x" (.var "w")) "u" = false := rfl
example : free (.abs "x" (.var "w")) "v" = false := rfl
example : free (.abs "x" (.var "w")) "w" = true := rfl
example : free (.abs "x" (.var "w")) "z" = false := rfl
example : free (.abs "x" (.var "z")) "" = false := rfl
example : free (.abs "x" (.var "z")) "x" = false := rfl
example : free (.abs "x" (.var "z")) "y" = false := rfl
example : free (.abs "x" (.var "z")) "u" = false := rfl
example : free (.abs "x" (.var "z")) "v" = false := rfl
example : free (.abs "x" (.var "z")) "w" = false := rfl
example : free (.abs "x" (.var "z")) "z" = true := rfl
example : free (.abs "y" (.var "")) "" = true := rfl
example : free (.abs "y" (.var "")) "x" = false := rfl
example : free (.abs "y" (.var "")) "y" = false := rfl
example : free (.abs "y" (.var "")) "u" = false := rfl
example : free (.abs "y" (.var "")) "v" = false := rfl
example : free (.abs "y" (.var "")) "w" = false := rfl
example : free (.abs "y" (.var "")) "z" = false := rfl
example : free (.abs "y" (.var "x")) "" = false := rfl
example : free (.abs "y" (.var "x")) "x" = true := rfl
example : free (.abs "y" (.var "x")) "y" = false := rfl
example : free (.abs "y" (.var "x")) "u" = false := rfl
example : free (.abs "y" (.var "x")) "v" = false := rfl
example : free (.abs "y" (.var "x")) "w" = false := rfl
example : free (.abs "y" (.var "x")) "z" = false := rfl
example : free (.abs "y" (.var "y")) "" = false := rfl
example : free (.abs "y" (.var "y")) "x" = false := rfl
example : free (.abs "y" (.var "y")) "y" = false := rfl
example : free (.abs "y" (.var "y")) "u" = false := rfl
example : free (.abs "y" (.var "y")) "v" = false := rfl
example : free (.abs "y" (.var "y")) "w" = false := rfl
example : free (.abs "y" (.var "y")) "z" = false := rfl
example : free (.abs "y" (.var "u")) "" = false := rfl
example : free (.abs "y" (.var "u")) "x" = false := rfl
example : free (.abs "y" (.var "u")) "y" = false := rfl
example : free (.abs "y" (.var "u")) "u" = true := rfl
example : free (.abs "y" (.var "u")) "v" = false := rfl
example : free (.abs "y" (.var "u")) "w" = false := rfl
example : free (.abs "y" (.var "u")) "z" = false := rfl
example : free (.abs "y" (.var "v")) "" = false := rfl
example : free (.abs "y" (.var "v")) "x" = false := rfl
example : free (.abs "y" (.var "v")) "y" = false := rfl
example : free (.abs "y" (.var "v")) "u" = false := rfl
example : free (.abs "y" (.var "v")) "v" = true := rfl
example : free (.abs "y" (.var "v")) "w" = false := rfl
example : free (.abs "y" (.var "v")) "z" = false := rfl
example : free (.abs "y" (.var "w")) "" = false := rfl
example : free (.abs "y" (.var "w")) "x" = false := rfl
example : free (.abs "y" (.var "w")) "y" = false := rfl
example : free (.abs "y" (.var "w")) "u" = false := rfl
example : free (.abs "y" (.var "w")) "v" = false := rfl
example : free (.abs "y" (.var "w")) "w" = true := rfl
example : free (.abs "y" (.var "w")) "z" = false := rfl
example : free (.abs "y" (.var "z")) "" = false := rfl
example : free (.abs "y" (.var "z")) "x" = false := rfl
example : free (.abs "y" (.var "z")) "y" = false := rfl
example : free (.abs "y" (.var "z")) "u" = false := rfl
example : free (.abs "y" (.var "z")) "v" = false := rfl
example : free (.abs "y" (.var "z")) "w" = false := rfl
example : free (.abs "y" (.var "z")) "z" = true := rfl
example : free (.abs "u" (.var "")) "" = true := rfl
example : free (.abs "u" (.var "")) "x" = false := rfl
example : free (.abs "u" (.var "")) "y" = false := rfl
example : free (.abs "u" (.var "")) "u" = false := rfl
example : free (.abs "u" (.var "")) "v" = false := rfl
example : free (.abs "u" (.var "")) "w" = false := rfl
example : free (.abs "u" (.var "")) "z" = false := rfl
example : free (.abs "u" (.var "x")) "" = false := rfl
example : free (.abs "u" (.var "x")) "x" = true := rfl
example : free (.abs "u" (.var "x")) "y" = false := rfl
example : free (.abs "u" (.var "x")) "u" = false := rfl
example : free (.abs "u" (.var "x")) "v" = false := rfl
example : free (.abs "u" (.var "x")) "w" = false := rfl
example : free (.abs "u" (.var "x")) "z" = false := rfl
example : free (.abs "u" (.var "y")) "" = false := rfl
example : free (.abs "u" (.var "y")) "x" = false := rfl
example : free (.abs "u" (.var "y")) "y" = true := rfl
example : free (.abs "u" (.var "y")) "u" = false := rfl
example : free (.abs "u" (.var "y")) "v" = false := rfl
example : free (.abs "u" (.var "y")) "w" = false := rfl
example : free (.abs "u" (.var "y")) "z" = false := rfl
example : free (.abs "u" (.var "u")) "" = false := rfl
example : free (.abs "u" (.var "u")) "x" = false := rfl
example : free (.abs "u" (.var "u")) "y" = false := rfl
example : free (.abs "u" (.var "u")) "u" = false := rfl
example : free (.abs "u" (.var "u")) "v" = false := rfl
example : free (.abs "u" (.var "u")) "w" = false := rfl
example : free (.abs "u" (.var "u")) "z" = false := rfl
example : free (.abs "u" (.var "v")) "" = false := rfl
example : free (.abs "u" (.var "v")) "x" = false := rfl
example : free (.abs "u" (.var "v")) "y" = false := rfl
example : free (.abs "u" (.var "v")) "u" = false := rfl
example : free (.abs "u" (.var "v")) "v" = true := rfl
example : free (.abs "u" (.var "v")) "w" = false := rfl
example : free (.abs "u" (.var "v")) "z" = false := rfl
example : free (.abs "u" (.var "w")) "" = false := rfl
example : free (.abs "u" (.var "w")) "x" = false := rfl
example : free (.abs "u" (.var "w")) "y" = false := rfl
example : free (.abs "u" (.var "w")) "u" = false := rfl
example : free (.abs "u" (.var "w")) "v" = false := rfl
example : free (.abs "u" (.var "w")) "w" = true := rfl
example : free (.abs "u" (.var "w")) "z" = false := rfl
example : free (.abs "u" (.var "z")) "" = false := rfl
example : free (.abs "u" (.var "z")) "x" = false := rfl
example : free (.abs "u" (.var "z")) "y" = false := rfl
example : free (.abs "u" (.var "z")) "u" = false := rfl
example : free (.abs "u" (.var "z")) "v" = false := rfl
example : free (.abs "u" (.var "z")) "w" = false := rfl
example : free (.abs "u" (.var "z")) "z" = true := rfl
example : free (.abs "v" (.var "")) "" = true := rfl
example : free (.abs "v" (.var "")) "x" = false := rfl
example : free (.abs "v" (.var "")) "y" = false := rfl
example : free (.abs "v" (.var "")) "u" = false := rfl
example : free (.abs "v" (.var "")) "v" = false := rfl
example : free (.abs "v" (.var "")) "w" = false := rfl
example : free (.abs "v" (.var "")) "z" = false := rfl
example : free (.abs "v" (.var "x")) "" = false := rfl
example : free (.abs "v" (.var "x")) "x" = true := rfl
example : free (.abs "v" (.var "x")) "y" = false := rfl
example : free (.abs "v" (.var "x")) "u" = false := rfl
example : free (.abs "v" (.var "x")) "v" = false := rfl
example : free (.abs "v" (.var "x")) "w" = false := rfl
example : free (.abs "v" (.var "x")) "z" = false := rfl
example : free (.abs "v" (.var "y")) "" = false := rfl
example : free (.abs "v" (.var "y")) "x" = false := rfl
example : free (.abs "v" (.var "y")) "y" = true := rfl
example : free (.abs "v" (.var "y")) "u" = false := rfl
example : free (.abs "v" (.var "y")) "v" = false := rfl
example : free (.abs "v" (.var "y")) "w" = false := rfl
example : free (.abs "v" (.var "y")) "z" = false := rfl
example : free (.abs "v" (.var "u")) "" = false := rfl
example : free (.abs "v" (.var "u")) "x" = false := rfl
example : free (.abs "v" (.var "u")) "y" = false := rfl
example : free (.abs "v" (.var "u")) "u" = true := rfl
example : free (.abs "v" (.var "u")) "v" = false := rfl
example : free (.abs "v" (.var "u")) "w" = false := rfl
example : free (.abs "v" (.var "u")) "z" = false := rfl
example : free (.abs "v" (.var "v")) "" = false := rfl
example : free (.abs "v" (.var "v")) "x" = false := rfl
example : free (.abs "v" (.var "v")) "y" = false := rfl
example : free (.abs "v" (.var "v")) "u" = false := rfl
example : free (.abs "v" (.var "v")) "v" = false := rfl
example : free (.abs "v" (.var "v")) "w" = false := rfl
example : free (.abs "v" (.var "v")) "z" = false := rfl
example : free (.abs "v" (.var "w")) "" = false := rfl
example : free (.abs "v" (.var "w")) "x" = false := rfl
example : free (.abs "v" (.var "w")) "y" = false := rfl
example : free (.abs "v" (.var "w")) "u" = false := rfl
example : free (.abs "v" (.var "w")) "v" = false := rfl
example : free (.abs "v" (.var "w")) "w" = true := rfl
example : free (.abs "v" (.var "w")) "z" = false := rfl
example : free (.abs "v" (.var "z")) "" = false := rfl
example : free (.abs "v" (.var "z")) "x" = false := rfl
example : free (.abs "v" (.var "z")) "y" = false := rfl
example : free (.abs "v" (.var "z")) "u" = false := rfl
example : free (.abs "v" (.var "z")) "v" = false := rfl
example : free (.abs "v" (.var "z")) "w" = false := rfl
example : free (.abs "v" (.var "z")) "z" = true := rfl
example : free (.abs "w" (.var "")) "" = true := rfl
example : free (.abs "w" (.var "")) "x" = false := rfl
example : free (.abs "w" (.var "")) "y" = false := rfl
example : free (.abs "w" (.var "")) "u" = false := rfl
example : free (.abs "w" (.var "")) "v" = false := rfl
example : free (.abs "w" (.var "")) "w" = false := rfl
example : free (.abs "w" (.var "")) "z" = false := rfl
example : free (.abs "w" (.var "x")) "" = false := rfl
example : free (.abs "w" (.var "x")) "x" = true := rfl
example : free (.abs "w" (.var "x")) "y" = false := rfl
example : free (.abs "w" (.var "x")) "u" = false := rfl
example : free (.abs "w" (.var "x")) "v" = false := rfl
example : free (.abs "w" (.var "x")) "w" = false := rfl
example : free (.abs "w" (.var "x")) "z" = false := rfl
example : free (.abs "w" (.var "y")) "" = false := rfl
example : free (.abs "w" (.var "y")) "x" = false := rfl
example : free (.abs "w" (.var "y")) "y" = true := rfl
example : free (.abs "w" (.var "y")) "u" = false := rfl
example : free (.abs "w" (.var "y")) "v" = false := rfl
example : free (.abs "w" (.var "y")) "w" = false := rfl
example : free (.abs "w" (.var "y")) "z" = false := rfl
example : free (.abs "w" (.var "u")) "" = false := rfl
example : free (.abs "w" (.var "u")) "x" = false := rfl
example : free (.abs "w" (.var "u")) "y" = false := rfl
example : free (.abs "w" (.var "u")) "u" = true := rfl
example : free (.abs "w" (.var "u")) "v" = false := rfl
example : free (.abs "w" (.var "u")) "w" = false := rfl
example : free (.abs "w" (.var "u")) "z" = false := rfl
example : free (.abs "w" (.var "v")) "" = false := rfl
example : free (.abs "w" (.var "v")) "x" = false := rfl
example : free (.abs "w" (.var "v")) "y" = false := rfl
example : free (.abs "w" (.var "v")) "u" = false := rfl
example : free (.abs "w" (.var "v")) "v" = true := rfl
example : free (.abs "w" (.var "v")) "w" = false := rfl
example : free (.abs "w" (.var "v")) "z" = false := rfl
example : free (.abs "w" (.var "w")) "" = false := rfl
example : free (.abs "w" (.var "w")) "x" = false := rfl
example : free (.abs "w" (.var "w")) "y" = false := rfl
example : free (.abs "w" (.var "w")) "u" = false := rfl
example : free (.abs "w" (.var "w")) "v" = false := rfl
example : free (.abs "w" (.var "w")) "w" = false := rfl
example : free (.abs "w" (.var "w")) "z" = false := rfl
example : free (.abs "w" (.var "z")) "" = false := rfl
example : free (.abs "w" (.var "z")) "x" = false := rfl
example : free (.abs "w" (.var "z")) "y" = false := rfl
example : free (.abs "w" (.var "z")) "u" = false := rfl
example : free (.abs "w" (.var "z")) "v" = false := rfl
example : free (.abs "w" (.var "z")) "w" = false := rfl
example : free (.abs "w" (.var "z")) "z" = true := rfl
example : free (.abs "z" (.var "")) "" = true := rfl
example : free (.abs "z" (.var "")) "x" = false := rfl
example : free (.abs "z" (.var "")) "y" = false := rfl
example : free (.abs "z" (.var "")) "u" = false := rfl
example : free (.abs "z" (.var "")) "v" = false := rfl
example : free (.abs "z" (.var "")) "w" = false := rfl
example : free (.abs "z" (.var "")) "z" = false := rfl
example : free (.abs "z" (.var "x")) "" = false := rfl
example : free (.abs "z" (.var "x")) "x" = true := rfl
example : free (.abs "z" (.var "x")) "y" = false := rfl
example : free (.abs "z" (.var "x")) "u" = false := rfl
example : free (.abs "z" (.var "x")) "v" = false := rfl
example : free (.abs "z" (.var "x")) "w" = false := rfl
example : free (.abs "z" (.var "x")) "z" = false := rfl
example : free (.abs "z" (.var "y")) "" = false := rfl
example : free (.abs "z" (.var "y")) "x" = false := rfl
example : free (.abs "z" (.var "y")) "y" = true := rfl
example : free (.abs "z" (.var "y")) "u" = false := rfl
example : free (.abs "z" (.var "y")) "v" = false := rfl
example : free (.abs "z" (.var "y")) "w" = false := rfl
example : free (.abs "z" (.var "y")) "z" = false := rfl
example : free (.abs "z" (.var "u")) "" = false := rfl
example : free (.abs "z" (.var "u")) "x" = false := rfl
example : free (.abs "z" (.var "u")) "y" = false := rfl
example : free (.abs "z" (.var "u")) "u" = true := rfl
example : free (.abs "z" (.var "u")) "v" = false := rfl
example : free (.abs "z" (.var "u")) "w" = false := rfl
example : free (.abs "z" (.var "u")) "z" = false := rfl
example : free (.abs "z" (.var "v")) "" = false := rfl
example : free (.abs "z" (.var "v")) "x" = false := rfl
example : free (.abs "z" (.var "v")) "y" = false := rfl
example : free (.abs "z" (.var "v")) "u" = false := rfl
example : free (.abs "z" (.var "v")) "v" = true := rfl
example : free (.abs "z" (.var "v")) "w" = false := rfl
example : free (.abs "z" (.var "v")) "z" = false := rfl
example : free (.abs "z" (.var "w")) "" = false := rfl
example : free (.abs "z" (.var "w")) "x" = false := rfl
example : free (.abs "z" (.var "w")) "y" = false := rfl
example : free (.abs "z" (.var "w")) "u" = false := rfl
example : free (.abs "z" (.var "w")) "v" = false := rfl
example : free (.abs "z" (.var "w")) "w" = true := rfl
example : free (.abs "z" (.var "w")) "z" = false := rfl
example : free (.abs "z" (.var "z")) "" = false := rfl
example : free (.abs "z" (.var "z")) "x" = false := rfl
example : free (.abs "z" (.var "z")) "y" = false := rfl
example : free (.abs "z" (.var "z")) "u" = false := rfl
example : free (.abs "z" (.var "z")) "v" = false := rfl
example : free (.abs "z" (.var "z")) "w" = false := rfl
example : free (.abs "z" (.var "z")) "z" = false := rfl
example : free (.abs "y" (.abs "u" (.var "y"))) "" = false := rfl
example : free (.abs "y" (.abs "u" (.var "y"))) "x" = false := rfl
example : free (.abs "y" (.abs "u" (.var "y"))) "y" = false := rfl
example : free (.abs "y" (.abs "u" (.var "y"))) "u" = false := rfl
example : free (.abs "y" (.abs "u" (.var "y"))) "v" = false := rfl
example : free (.abs "y" (.abs "u" (.var "y"))) "w" = false := rfl
example : free (.abs "y" (.abs "u" (.var "y"))) "z" = false := rfl
example : free (.abs "y" (.abs "u" (.var "x"))) "" = false := rfl
example : free (.abs "y" (.abs "u" (.var "x"))) "x" = true := rfl
example : free (.abs "y" (.abs "u" (.var "x"))) "y" = false := rfl
example : free (.abs "y" (.abs "u" (.var "x"))) "u" = false := rfl
example : free (.abs "y" (.abs "u" (.var "x"))) "v" = false := rfl
example : free (.abs "y" (.abs "u" (.var "x"))) "w" = false := rfl
example : free (.abs "y" (.abs "u" (.var "x"))) "z" = false := rfl
example : free (.abs "y" (.app (.var "x") (.var "u"))) "" = false := rfl
example : free (.abs "y" (.app (.var "x") (.var "u"))) "x" = true := rfl
example : free (.abs "y" (.app (.var "x") (.var "u"))) "y" = false := rfl
example : free (.abs "y" (.app (.var "x") (.var "u"))) "u" = true := rfl
example : free (.abs "y" (.app (.var "x") (.var "u"))) "v" = false := rfl
example : free (.abs "y" (.app (.var "x") (.var "u"))) "w" = false := rfl
example : free (.abs "y" (.app (.var "x") (.var "u"))) "z" = false := rfl
example : rename (.var "") "x" "u" = (.var "") := rfl
example : rename (.var "") "x" "x" = (.var "") := rfl
example : rename (.var "") "y" "u" = (.var "") := rfl
example : rename (.var "") "y" "x" = (.var "") := rfl
example : rename (.var "x") "x" "u" = (.var "u") := rfl
example : rename (.var "x") "x" "x" = (.var "x") := rfl
example : rename (.var "x") "y" "u" = (.var "x") := rfl
example : rename (.var "x") "y" "x" = (.var "x") := rfl
example : rename (.var "y") "x" "u" = (.var "y") := rfl
example : rename (.var "y") "x" "x" = (.var "y") := rfl
example : rename (.var "y") "y" "u" = (.var "u") := rfl
example : rename (.var "y") "y" "x" = (.var "x") := rfl
example : rename (.var "u") "x" "u" = (.var "u") := rfl
example : rename (.var "u") "x" "x" = (.var "u") := rfl
example : rename (.var "u") "y" "u" = (.var "u") := rfl
example : rename (.var "u") "y" "x" = (.var "u") := rfl
example : rename (.var "v") "x" "u" = (.var "v") := rfl
example : rename (.var "v") "x" "x" = (.var "v") := rfl
example : rename (.var "v") "y" "u" = (.var "v") := rfl
example : rename (.var "v") "y" "x" = (.var "v") := rfl
example : rename (.var "w") "x" "u" = (.var "w") := rfl
example : rename (.var "w") "x" "x" = (.var "w") := rfl
example : rename (.var "w") "y" "u" = (.var "w") := rfl
example : rename (.var "w") "y" "x" = (.var "w") := rfl
example : rename (.var "z") "x" "u" = (.var "z") := rfl
example : rename (.var "z") "x" "x" = (.var "z") := rfl
example : rename (.var "z") "y" "u" = (.var "z") := rfl
example : rename (.var "z") "y" "x" = (.var "z") := rfl
example : rename (.app (.var "") (.var "")) "x" "u" = (.app (.var "") (.var "")) := rfl
example : rename (.app (.var "") (.var "")) "x" "x" = (.app (.var "") (.var "")) := rfl
example : rename (.app (.var "") (.var "")) "y" "u" = (.app (.var "") (.var "")) := rfl
example : rename (.app (.var "") (.var "")) "y" "x" = (.app (.var "") (.var "")) := rfl
example : rename (.app (.var "") (.var "x")) "x" "u" = (.app (.var "") (.var "u")) := rfl
example : rename (.app (.var "") (.var "x")) "x" "x" = (.app (.var "") (.var "x")) := rfl
example : rename (.app (.var "") (.var "x")) "y" "u" = (.app (.var "") (.var "x")) := rfl
example : rename (.app (.var "") (.var "x")) "y" "x" = (.app (.var "") (.var "x")) := rfl
example : rename (.app (.var "") (.var "y")) "x" "u" = (.app (.var "") (.var "y")) := rfl
example : rename (.app (.var "") (.var "y")) "x" "x" = (.app (.var "") (.var "y")) := rfl
example : rename (.app (.var "") (.var "y")) "y" "u" = (.app (.var "") (.var "u")) := rfl
example : rename (.app (.var "") (.var "y")) "y" "x" = (.app (.var "") (.var "x")) := rfl
example : rename (.app (.var "") (.var "u")) "x" "u" = (.app (.var "") (.var "u")) := rfl
example : rename (.app (.var "") (.var "u")) "x" "x" = (.app (.var "") (.var "u")) := rfl
example : rename (.app (.var "") (.var "u")) "y" "u" = (.app (.var "") (.var "u")) := rfl
example : rename (.app (.var "") (.var "u")) "y" "x" = (.app (.var "") (.var "u")) := rfl
example : rename (.app (.var "") (.var "v")) "x" "u" = (.app (.var "") (.var "v")) := rfl
example : rename (.app (.var "") (.var "v")) "x" "x" = (.app (.var "") (.var "v")) := rfl
example : rename (.app (.var "") (.var "v")) "y" "u" = (.app (.var "") (.var "v")) := rfl
example : rename (.app (.var "") (.var "v")) "y" "x" = (.app (.var "") (.var "v")) := rfl
example : rename (.app (.var "") (.var "w")) "x" "u" = (.app (.var "") (.var "w")) := rfl
example : rename (.app (.var "") (.var "w")) "x" "x" = (.app (.var "") (.var "w")) := rfl
example : rename (.app (.var "") (.var "w")) "y" "u" = (.app (.var "") (.var "w")) := rfl
example : rename (.app (.var "") (.var "w")) "y" "x" = (.app (.var "") (.var "w")) := rfl
example : rename (.app (.var "") (.var "z")) "x" "u" = (.app (.var "") (.var "z")) := rfl
example : rename (.app (.var "") (.var "z")) "x" "x" = (.app (.var "") (.var "z")) := rfl
example : rename (.app (.var "") (.var "z")) "y" "u" = (.app (.var "") (.var "z")) := rfl
example : rename (.app (.var "") (.var "z")) "y" "x" = (.app (.var "") (.var "z")) := rfl
example : rename (.app (.var "x") (.var "")) "x" "u" = (.app (.var "u") (.var "")) := rfl
example : rename (.app (.var "x") (.var "")) "x" "x" = (.app (.var "x") (.var "")) := rfl
example : rename (.app (.var "x") (.var "")) "y" "u" = (.app (.var "x") (.var "")) := rfl
example : rename (.app (.var "x") (.var "")) "y" "x" = (.app (.var "x") (.var "")) := rfl
example : rename (.app (.var "x") (.var "x")) "x" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "x") (.var "x")) "x" "x" = (.app (.var "x") (.var "x")) := rfl
example : rename (.app (.var "x") (.var "x")) "y" "u" = (.app (.var "x") (.var "x")) := rfl
example : rename (.app (.var "x") (.var "x")) "y" "x" = (.app (.var "x") (.var "x")) := rfl
example : rename (.app (.var "x") (.var "y")) "x" "u" = (.app (.var "u") (.var "y")) := rfl
example : rename (.app (.var "x") (.var "y")) "x" "x" = (.app (.var "x") (.var "y")) := rfl
example : rename (.app (.var "x") (.var "y")) "y" "u" = (.app (.var "x") (.var "u")) := rfl
example : rename (.app (.var "x") (.var "y")) "y" "x" = (.app (.var "x") (.var "x")) := rfl
example : rename (.app (.var "x") (.var "u")) "x" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "x") (.var "u")) "x" "x" = (.app (.var "x") (.var "u")) := rfl
example : rename (.app (.var "x") (.var "u")) "y" "u" = (.app (.var "x") (.var "u")) := rfl
example : rename (.app (.var "x") (.var "u")) "y" "x" = (.app (.var "x") (.var "u")) := rfl
example : rename (.app (.var "x") (.var "v")) "x" "u" = (.app (.var "u") (.var "v")) := rfl
example : rename (.app (.var "x") (.var "v")) "x" "x" = (.app (.var "x") (.var "v")) := rfl
example : rename (.app (.var "x") (.var "v")) "y" "u" = (.app (.var "x") (.var "v")) := rfl
example : rename (.app (.var "x") (.var "v")) "y" "x" = (.app (.var "x") (.var "v")) := rfl
example : rename (.app (.var "x") (.var "w")) "x" "u" = (.app (.var "u") (.var "w")) := rfl
example : rename (.app (.var "x") (.var "w")) "x" "x" = (.app (.var "x") (.var "w")) := rfl
example : rename (.app (.var "x") (.var "w")) "y" "u" = (.app (.var "x") (.var "w")) := rfl
example : rename (.app (.var "x") (.var "w")) "y" "x" = (.app (.var "x") (.var "w")) := rfl
example : rename (.app (.var "x") (.var "z")) "x" "u" = (.app (.var "u") (.var "z")) := rfl
example : rename (.app (.var "x") (.var "z")) "x" "x" = (.app (.var "x") (.var "z")) := rfl
example : rename (.app (.var "x") (.var "z")) "y" "u" = (.app (.var "x") (.var "z")) := rfl
example : rename (.app (.var "x") (.var "z")) "y" "x" = (.app (.var "x") (.var "z")) := rfl
example : rename (.app (.var "y") (.var "")) "x" "u" = (.app (.var "y") (.var "")) := rfl
example : rename (.app (.var "y") (.var "")) "x" "x" = (.app (.var "y") (.var "")) := rfl
example : rename (.app (.var "y") (.var "")) "y" "u" = (.app (.var "u") (.var "")) := rfl
example : rename (.app (.var "y") (.var "")) "y" "x" = (.app (.var "x") (.var "")) := rfl
example : rename (.app (.var "y") (.var "x")) "x" "u" = (.app (.var "y") (.var "u")) := rfl
example : rename (.app (.var "y") (.var "x")) "x" "x" = (.app (.var "y") (.var "x")) := rfl
example : rename (.app (.var "y") (.var "x")) "y" "u" = (.app (.var "u") (.var "x")) := rfl
example : rename (.app (.var "y") (.var "x")) "y" "x" = (.app (.var "x") (.var "x")) := rfl
example : rename (.app (.var "y") (.var "y")) "x" "u" = (.app (.var "y") (.var "y")) := rfl
example : rename (.app (.var "y") (.var "y")) "x" "x" = (.app (.var "y") (.var "y")) := rfl
example : rename (.app (.var "y") (.var "y")) "y" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "y") (.var "y")) "y" "x" = (.app (.var "x") (.var "x")) := rfl
example : rename (.app (.var "y") (.var "u")) "x" "u" = (.app (.var "y") (.var "u")) := rfl
example : rename (.app (.var "y") (.var "u")) "x" "x" = (.app (.var "y") (.var "u")) := rfl
example : rename (.app (.var "y") (.var "u")) "y" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "y") (.var "u")) "y" "x" = (.app (.var "x") (.var "u")) := rfl
example : rename (.app (.var "y") (.var "v")) "x" "u" = (.app (.var "y") (.var "v")) := rfl
example : rename (.app (.var "y") (.var "v")) "x" "x" = (.app (.var "y") (.var "v")) := rfl
example : rename (.app (.var "y") (.var "v")) "y" "u" = (.app (.var "u") (.var "v")) := rfl
example : rename (.app (.var "y") (.var "v")) "y" "x" = (.app (.var "x") (.var "v")) := rfl
example : rename (.app (.var "y") (.var "w")) "x" "u" = (.app (.var "y") (.var "w")) := rfl
example : rename (.app (.var "y") (.var "w")) "x" "x" = (.app (.var "y") (.var "w")) := rfl
example : rename (.app (.var "y") (.var "w")) "y" "u" = (.app (.var "u") (.var "w")) := rfl
example : rename (.app (.var "y") (.var "w")) "y" "x" = (.app (.var "x") (.var "w")) := rfl
example : rename (.app (.var "y") (.var "z")) "x" "u" = (.app (.var "y") (.var "z")) := rfl
example : rename (.app (.var "y") (.var "z")) "x" "x" = (.app (.var "y") (.var "z")) := rfl
example : rename (.app (.var "y") (.var "z")) "y" "u" = (.app (.var "u") (.var "z")) := rfl
example : rename (.app (.var "y") (.var "z")) "y" "x" = (.app (.var "x") (.var "z")) := rfl
example : rename (.app (.var "u") (.var "")) "x" "u" = (.app (.var "u") (.var "")) := rfl
example : rename (.app (.var "u") (.var "")) "x" "x" = (.app (.var "u") (.var "")) := rfl
example : rename (.app (.var "u") (.var "")) "y" "u" = (.app (.var "u") (.var "")) := rfl
example : rename (.app (.var "u") (.var "")) "y" "x" = (.app (.var "u") (.var "")) := rfl
example : rename (.app (.var "u") (.var "x")) "x" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "u") (.var "x")) "x" "x" = (.app (.var "u") (.var "x")) := rfl
example : rename (.app (.var "u") (.var "x")) "y" "u" = (.app (.var "u") (.var "x")) := rfl
example : rename (.app (.var "u") (.var "x")) "y" "x" = (.app (.var "u") (.var "x")) := rfl
example : rename (.app (.var "u") (.var "y")) "x" "u" = (.app (.var "u") (.var "y")) := rfl
example : rename (.app (.var "u") (.var "y")) "x" "x" = (.app (.var "u") (.var "y")) := rfl
example : rename (.app (.var "u") (.var "y")) "y" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "u") (.var "y")) "y" "x" = (.app (.var "u") (.var "x")) := rfl
example : rename (.app (.var "u") (.var "u")) "x" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "u") (.var "u")) "x" "x" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "u") (.var "u")) "y" "u" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "u") (.var "u")) "y" "x" = (.app (.var "u") (.var "u")) := rfl
example : rename (.app (.var "u") (.var "v")) "x" "u" = (.app (.var "u") (.var "v")) := rfl
example : rename (.app (.var "u") (.var "v")) "x" "x" = (.app (.var "u") (.var "v")) := rfl
example : rename (.app (.var "u") (.var "v")) "y" "u" = (.app (.var "u") (.var "v")) := rfl
example : rename (.app (.var "u") (.var "v")) "y" "x" = (.app (.var "u") (.var "v")) := rfl
example : rename (.app (.var "u") (.var "w")) "x" "u" = (.app (.var "u") (.var "w")) := rfl
example : rename (.app (.var "u") (.var "w")) "x" "x" = (.app (.var "u") (.var "w")) := rfl
example : rename (.app (.var "u") (.var "w")) "y" "u" = (.app (.var "u") (.var "w")) := rfl
example : rename (.app (.var "u") (.var "w")) "y" "x" = (.app (.var "u") (.var "w")) := rfl
example : rename (.app (.var "u") (.var "z")) "x" "u" = (.app (.var "u") (.var "z")) := rfl
example : rename (.app (.var "u") (.var "z")) "x" "x" = (.app (.var "u") (.var "z")) := rfl
example : rename (.app (.var "u") (.var "z")) "y" "u" = (.app (.var "u") (.var "z")) := rfl
example : rename (.app (.var "u") (.var "z")) "y" "x" = (.app (.var "u") (.var "z")) := rfl
example : rename (.app (.var "v") (.var "")) "x" "u" = (.app (.var "v") (.var "")) := rfl
example : rename (.app (.var "v") (.var "")) "x" "x" = (.app (.var "v") (.var "")) := rfl
example : rename (.app (.var "v") (.var "")) "y" "u" = (.app (.var "v") (.var "")) := rfl
example : rename (.app (.var "v") (.var "")) "y" "x" = (.app (.var "v") (.var "")) := rfl
example : rename (.app (.var "v") (.var "x")) "x" "u" = (.app (.var "v") (.var "u")) := rfl
example : rename (.app (.var "v") (.var "x")) "x" "x" = (.app (.var "v") (.var "x")) := rfl
example : rename (.app (.var "v") (.var "x")) "y" "u" = (.app (.var "v") (.var "x")) := rfl
example : rename (.app (.var "v") (.var "x")) "y" "x" = (.app (.var "v") (.var "x")) := rfl
example : rename (.app (.var "v") (.var "y")) "x" "u" = (.app (.var "v") (.var "y")) := rfl
example : rename (.app (.var "v") (.var "y")) "x" "x" = (.app (.var "v") (.var "y")) := rfl
example : rename (.app (.var "v") (.var "y")) "y" "u" = (.app (.var "v") (.var "u")) := rfl
example : rename (.app (.var "v") (.var "y")) "y" "x" = (.app (.var "v") (.var "x")) := rfl
example : rename (.app (.var "v") (.var "u")) "x" "u" = (.app (.var "v") (.var "u")) := rfl
example : rename (.app (.var "v") (.var "u")) "x" "x" = (.app (.var "v") (.var "u")) := rfl
example : rename (.app (.var "v") (.var "u")) "y" "u" = (.app (.var "v") (.var "u")) := rfl
example : rename (.app (.var "v") (.var "u")) "y" "x" = (.app (.var "v") (.var "u")) := rfl
example : rename (.app (.var "v") (.var "v")) "x" "u" = (.app (.var "v") (.var "v")) := rfl
example : rename (.app (.var "v") (.var "v")) "x" "x" = (.app (.var "v") (.var "v")) := rfl
example : rename (.app (.var "v") (.var "v")) "y" "u" = (.app (.var "v") (.var "v")) := rfl
example : rename (.app (.var "v") (.var "v")) "y" "x" = (.app (.var "v") (.var "v")) := rfl
example : rename (.app (.var "v") (.var "w")) "x" "u" = (.app (.var "v") (.var "w")) := rfl
example : rename (.app (.var "v") (.var "w")) "x" "x" = (.app (.var "v") (.var "w")) := rfl
example : rename (.app (.var "v") (.var "w")) "y" "u" = (.app (.var "v") (.var "w")) := rfl
example : rename (.app (.var "v") (.var "w")) "y" "x" = (.app (.var "v") (.var "w")) := rfl
example : rename (.app (.var "v") (.var "z")) "x" "u" = (.app (.var "v") (.var "z")) := rfl
example : rename (.app (.var "v") (.var "z")) "x" "x" = (.app (.var "v") (.var "z")) := rfl
example : rename (.app (.var "v") (.var "z")) "y" "u" = (.app (.var "v") (.var "z")) := rfl
example : rename (.app (.var "v") (.var "z")) "y" "x" = (.app (.var "v") (.var "z")) := rfl
example : rename (.app (.var "w") (.var "")) "x" "u" = (.app (.var "w") (.var "")) := rfl
example : rename (.app (.var "w") (.var "")) "x" "x" = (.app (.var "w") (.var "")) := rfl
example : rename (.app (.var "w") (.var "")) "y" "u" = (.app (.var "w") (.var "")) := rfl
example : rename (.app (.var "w") (.var "")) "y" "x" = (.app (.var "w") (.var "")) := rfl
example : rename (.app (.var "w") (.var "x")) "x" "u" = (.app (.var "w") (.var "u")) := rfl
example : rename (.app (.var "w") (.var "x")) "x" "x" = (.app (.var "w") (.var "x")) := rfl
example : rename (.app (.var "w") (.var "x")) "y" "u" = (.app (.var "w") (.var "x")) := rfl
example : rename (.app (.var "w") (.var "x")) "y" "x" = (.app (.var "w") (.var "x")) := rfl
example : rename (.app (.var "w") (.var "y")) "x" "u" = (.app (.var "w") (.var "y")) := rfl
example : rename (.app (.var "w") (.var "y")) "x" "x" = (.app (.var "w") (.var "y")) := rfl
example : rename (.app (.var "w") (.var "y")) "y" "u" = (.app (.var "w") (.var "u")) := rfl
example : rename (.app (.var "w") (.var "y")) "y" "x" = (.app (.var "w") (.var "x")) := rfl
example : rename (.app (.var "w") (.var "u")) "x" "u" = (.app (.var "w") (.var "u")) := rfl
example : rename (.app (.var "w") (.var "u")) "x" "x" = (.app (.var "w") (.var "u")) := rfl
example : rename (.app (.var "w") (.var "u")) "y" "u" = (.app (.var "w") (.var "u")) := rfl
example : rename (.app (.var "w") (.var "u")) "y" "x" = (.app (.var "w") (.var "u")) := rfl
example : rename (.app (.var "w") (.var "v")) "x" "u" = (.app (.var "w") (.var "v")) := rfl
example : rename (.app (.var "w") (.var "v")) "x" "x" = (.app (.var "w") (.var "v")) := rfl
example : rename (.app (.var "w") (.var "v")) "y" "u" = (.app (.var "w") (.var "v")) := rfl
example : rename (.app (.var "w") (.var "v")) "y" "x" = (.app (.var "w") (.var "v")) := rfl
example : rename (.app (.var "w") (.var "w")) "x" "u" = (.app (.var "w") (.var "w")) := rfl
example : rename (.app (.var "w") (.var "w")) "x" "x" = (.app (.var "w") (.var "w")) := rfl
example : rename (.app (.var "w") (.var "w")) "y" "u" = (.app (.var "w") (.var "w")) := rfl
example : rename (.app (.var "w") (.var "w")) "y" "x" = (.app (.var "w") (.var "w")) := rfl
example : rename (.app (.var "w") (.var "z")) "x" "u" = (.app (.var "w") (.var "z")) := rfl
example : rename (.app (.var "w") (.var "z")) "x" "x" = (.app (.var "w") (.var "z")) := rfl
example : rename (.app (.var "w") (.var "z")) "y" "u" = (.app (.var "w") (.var "z")) := rfl
example : rename (.app (.var "w") (.var "z")) "y" "x" = (.app (.var "w") (.var "z")) := rfl
example : rename (.app (.var "z") (.var "")) "x" "u" = (.app (.var "z") (.var "")) := rfl
example : rename (.app (.var "z") (.var "")) "x" "x" = (.app (.var "z") (.var "")) := rfl
example : rename (.app (.var "z") (.var "")) "y" "u" = (.app (.var "z") (.var "")) := rfl
example : rename (.app (.var "z") (.var "")) "y" "x" = (.app (.var "z") (.var "")) := rfl
example : rename (.app (.var "z") (.var "x")) "x" "u" = (.app (.var "z") (.var "u")) := rfl
example : rename (.app (.var "z") (.var "x")) "x" "x" = (.app (.var "z") (.var "x")) := rfl
example : rename (.app (.var "z") (.var "x")) "y" "u" = (.app (.var "z") (.var "x")) := rfl
example : rename (.app (.var "z") (.var "x")) "y" "x" = (.app (.var "z") (.var "x")) := rfl
example : rename (.app (.var "z") (.var "y")) "x" "u" = (.app (.var "z") (.var "y")) := rfl
example : rename (.app (.var "z") (.var "y")) "x" "x" = (.app (.var "z") (.var "y")) := rfl
example : rename (.app (.var "z") (.var "y")) "y" "u" = (.app (.var "z") (.var "u")) := rfl
example : rename (.app (.var "z") (.var "y")) "y" "x" = (.app (.var "z") (.var "x")) := rfl
example : rename (.app (.var "z") (.var "u")) "x" "u" = (.app (.var "z") (.var "u")) := rfl
example : rename (.app (.var "z") (.var "u")) "x" "x" = (.app (.var "z") (.var "u")) := rfl
example : rename (.app (.var "z") (.var "u")) "y" "u" = (.app (.var "z") (.var "u")) := rfl
example : rename (.app (.var "z") (.var "u")) "y" "x" = (.app (.var "z") (.var "u")) := rfl
example : rename (.app (.var "z") (.var "v")) "x" "u" = (.app (.var "z") (.var "v")) := rfl
example : rename (.app (.var "z") (.var "v")) "x" "x" = (.app (.var "z") (.var "v")) := rfl
example : rename (.app (.var "z") (.var "v")) "y" "u" = (.app (.var "z") (.var "v")) := rfl
example : rename (.app (.var "z") (.var "v")) "y" "x" = (.app (.var "z") (.var "v")) := rfl
example : rename (.app (.var "z") (.var "w")) "x" "u" = (.app (.var "z") (.var "w")) := rfl
example : rename (.app (.var "z") (.var "w")) "x" "x" = (.app (.var "z") (.var "w")) := rfl
example : rename (.app (.var "z") (.var "w")) "y" "u" = (.app (.var "z") (.var "w")) := rfl
example : rename (.app (.var "z") (.var "w")) "y" "x" = (.app (.var "z") (.var "w")) := rfl
example : rename (.app (.var "z") (.var "z")) "x" "u" = (.app (.var "z") (.var "z")) := rfl
example : rename (.app (.var "z") (.var "z")) "x" "x" = (.app (.var "z") (.var "z")) := rfl
example : rename (.app (.var "z") (.var "z")) "y" "u" = (.app (.var "z") (.var "z")) := rfl
example : rename (.app (.var "z") (.var "z")) "y" "x" = (.app (.var "z") (.var "z")) := rfl
example : rename (.abs "" (.var "")) "x" "u" = (.abs "" (.var "")) := rfl
example : rename (.abs "" (.var "")) "x" "x" = (.abs "" (.var "")) := rfl
example : rename (.abs "" (.var "")) "y" "u" = (.abs "" (.var "")) := rfl
example : rename (.abs "" (.var "")) "y" "x" = (.abs "" (.var "")) := rfl
example : rename (.abs "" (.var "x")) "x" "u" = (.abs "" (.var "u")) := rfl
example : rename (.abs "" (.var "x")) "x" "x" = (.abs "" (.var "x")) := rfl
example : rename (.abs "" (.var "x")) "y" "u" = (.abs "" (.var "x")) := rfl
example : rename (.abs "" (.var "x")) "y" "x" = (.abs "" (.var "x")) := rfl
example : rename (.abs "" (.var "y")) "x" "u" = (.abs "" (.var "y")) := rfl
example : rename (.abs "" (.var "y")) "x" "x" = (.abs "" (.var "y")) := rfl
example : rename (.abs "" (.var "y")) "y" "u" = (.abs "" (.var "u")) := rfl
example : rename (.abs "" (.var "y")) "y" "x" = (.abs "" (.var "x")) := rfl
example : rename (.abs "" (.var "u")) "x" "u" = (.abs "" (.var "u")) := rfl
example : rename (.abs "" (.var "u")) "x" "x" = (.abs "" (.var "u")) := rfl
example : rename (.abs "" (.var "u")) "y" "u" = (.abs "" (.var "u")) := rfl
example : rename (.abs "" (.var "u")) "y" "x" = (.abs "" (.var "u")) := rfl
example : rename (.abs "" (.var "v")) "x" "u" = (.abs "" (.var "v")) := rfl
example : rename (.abs "" (.var "v")) "x" "x" = (.abs "" (.var "v")) := rfl
example : rename (.abs "" (.var "v")) "y" "u" = (.abs "" (.var "v")) := rfl
example : rename (.abs "" (.var "v")) "y" "x" = (.abs "" (.var "v")) := rfl
example : rename (.abs "" (.var "w")) "x" "u" = (.abs "" (.var "w")) := rfl
example : rename (.abs "" (.var "w")) "x" "x" = (.abs "" (.var "w")) := rfl
example : rename (.abs "" (.var "w")) "y" "u" = (.abs "" (.var "w")) := rfl
example : rename (.abs "" (.var "w")) "y" "x" = (.abs "" (.var "w")) := rfl
example : rename (.abs "" (.var "z")) "x" "u" = (.abs "" (.var "z")) := rfl
example : rename (.abs "" (.var "z")) "x" "x" = (.abs "" (.var "z")) := rfl
example : rename (.abs "" (.var "z")) "y" "u" = (.abs "" (.var "z")) := rfl
example : rename (.abs "" (.var "z")) "y" "x" = (.abs "" (.var "z")) := rfl
example : rename (.abs "x" (.var "")) "x" "u" = (.abs "u" (.var "")) := rfl
example : rename (.abs "x" (.var "")) "x" "x" = (.abs "x" (.var "")) := rfl
example : rename (.abs "x" (.var "")) "y" "u" = (.abs "x" (.var "")) := rfl
example : rename (.abs "x" (.var "")) "y" "x" = (.abs "x" (.var "")) := rfl
example : rename (.abs "x" (.var "x")) "x" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "x" (.var "x")) "x" "x" = (.abs "x" (.var "x")) := rfl
example : rename (.abs "x" (.var "x")) "y" "u" = (.abs "x" (.var "x")) := rfl
example : rename (.abs "x" (.var "x")) "y" "x" = (.abs "x" (.var "x")) := rfl
example : rename (.abs "x" (.var "y")) "x" "u" = (.abs "u" (.var "y")) := rfl
example : rename (.abs "x" (.var "y")) "x" "x" = (.abs "x" (.var "y")) := rfl
example : rename (.abs "x" (.var "y")) "y" "u" = (.abs "x" (.var "u")) := rfl
example : rename (.abs "x" (.var "y")) "y" "x" = (.abs "x" (.var "x")) := rfl
example : rename (.abs "x" (.var "u")) "x" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "x" (.var "u")) "x" "x" = (.abs "x" (.var "u")) := rfl
example : rename (.abs "x" (.var "u")) "y" "u" = (.abs "x" (.var "u")) := rfl
example : rename (.abs "x" (.var "u")) "y" "x" = (.abs "x" (.var "u")) := rfl
example : rename (.abs "x" (.var "v")) "x" "u" = (.abs "u" (.var "v")) := rfl
example : rename (.abs "x" (.var "v")) "x" "x" = (.abs "x" (.var "v")) := rfl
example : rename (.abs "x" (.var "v")) "y" "u" = (.abs "x" (.var "v")) := rfl
example : rename (.abs "x" (.var "v")) "y" "x" = (.abs "x" (.var "v")) := rfl
example : rename (.abs "x" (.var "w")) "x" "u" = (.abs "u" (.var "w")) := rfl
example : rename (.abs "x" (.var "w")) "x" "x" = (.abs "x" (.var "w")) := rfl
example : rename (.abs "x" (.var "w")) "y" "u" = (.abs "x" (.var "w")) := rfl
example : rename (.abs "x" (.var "w")) "y" "x" = (.abs "x" (.var "w")) := rfl
example : rename (.abs "x" (.var "z")) "x" "u" = (.abs "u" (.var "z")) := rfl
example : rename (.abs "x" (.var "z")) "x" "x" = (.abs "x" (.var "z")) := rfl
example : rename (.abs "x" (.var "z")) "y" "u" = (.abs "x" (.var "z")) := rfl
example : rename (.abs "x" (.var "z")) "y" "x" = (.abs "x" (.var "z")) := rfl
example : rename (.abs "y" (.var "")) "x" "u" = (.abs "y" (.var "")) := rfl
example : rename (.abs "y" (.var "")) "x" "x" = (.abs "y" (.var "")) := rfl
example : rename (.abs "y" (.var "")) "y" "u" = (.abs "u" (.var "")) := rfl
example : rename (.abs "y" (.var "")) "y" "x" = (.abs "x" (.var "")) := rfl
example : rename (.abs "y" (.var "x")) "x" "u" = (.abs "y" (.var "u")) := rfl
example : rename (.abs "y" (.var "x")) "x" "x" = (.abs "y" (.var "x")) := rfl
example : rename (.abs "y" (.var "x")) "y" "u" = (.abs "u" (.var "x")) := rfl
example : rename (.abs "y" (.var "x")) "y" "x" = (.abs "x" (.var "x")) := rfl
example : rename (.abs "y" (.var "y")) "x" "u" = (.abs "y" (.var "y")) := rfl
example : rename (.abs "y" (.var "y")) "x" "x" = (.abs "y" (.var "y")) := rfl
example : rename (.abs "y" (.var "y")) "y" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "y" (.var "y")) "y" "x" = (.abs "x" (.var "x")) := rfl
example : rename (.abs "y" (.var "u")) "x" "u" = (.abs "y" (.var "u")) := rfl
example : rename (.abs "y" (.var "u")) "x" "x" = (.abs "y" (.var "u")) := rfl
example : rename (.abs "y" (.var "u")) "y" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "y" (.var "u")) "y" "x" = (.abs "x" (.var "u")) := rfl
example : rename (.abs "y" (.var "v")) "x" "u" = (.abs "y" (.var "v")) := rfl
example : rename (.abs "y" (.var "v")) "x" "x" = (.abs "y" (.var "v")) := rfl
example : rename (.abs "y" (.var "v")) "y" "u" = (.abs "u" (.var "v")) := rfl
example : rename (.abs "y" (.var "v")) "y" "x" = (.abs "x" (.var "v")) := rfl
example : rename (.abs "y" (.var "w")) "x" "u" = (.abs "y" (.var "w")) := rfl
example : rename (.abs "y" (.var "w")) "x" "x" = (.abs "y" (.var "w")) := rfl
example : rename (.abs "y" (.var "w")) "y" "u" = (.abs "u" (.var "w")) := rfl
example : rename (.abs "y" (.var "w")) "y" "x" = (.abs "x" (.var "w")) := rfl
example : rename (.abs "y" (.var "z")) "x" "u" = (.abs "y" (.var "z")) := rfl
example : rename (.abs "y" (.var "z")) "x" "x" = (.abs "y" (.var "z")) := rfl
example : rename (.abs "y" (.var "z")) "y" "u" = (.abs "u" (.var "z")) := rfl
example : rename (.abs "y" (.var "z")) "y" "x" = (.abs "x" (.var "z")) := rfl
example : rename (.abs "u" (.var "")) "x" "u" = (.abs "u" (.var "")) := rfl
example : rename (.abs "u" (.var "")) "x" "x" = (.abs "u" (.var "")) := rfl
example : rename (.abs "u" (.var "")) "y" "u" = (.abs "u" (.var "")) := rfl
example : rename (.abs "u" (.var "")) "y" "x" = (.abs "u" (.var "")) := rfl
example : rename (.abs "u" (.var "x")) "x" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "u" (.var "x")) "x" "x" = (.abs "u" (.var "x")) := rfl
example : rename (.abs "u" (.var "x")) "y" "u" = (.abs "u" (.var "x")) := rfl
example : rename (.abs "u" (.var "x")) "y" "x" = (.abs "u" (.var "x")) := rfl
example : rename (.abs "u" (.var "y")) "x" "u" = (.abs "u" (.var "y")) := rfl
example : rename (.abs "u" (.var "y")) "x" "x" = (.abs "u" (.var "y")) := rfl
example : rename (.abs "u" (.var "y")) "y" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "u" (.var "y")) "y" "x" = (.abs "u" (.var "x")) := rfl
example : rename (.abs "u" (.var "u")) "x" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "u" (.var "u")) "x" "x" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "u" (.var "u")) "y" "u" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "u" (.var "u")) "y" "x" = (.abs "u" (.var "u")) := rfl
example : rename (.abs "u" (.var "v")) "x" "u" = (.abs "u" (.var "v")) := rfl
example : rename (.abs "u" (.var "v")) "x" "x" = (.abs "u" (.var "v")) := rfl
example : rename (.abs "u" (.var "v")) "y" "u" = (.abs "u" (.var "v")) := rfl
example : rename (.abs "u" (.var "v")) "y" "x" = (.abs "u" (.var "v")) := rfl
example : rename (.abs "u" (.var "w")) "x" "u" = (.abs "u" (.var "w")) := rfl
example : rename (.abs "u" (.var "w")) "x" "x" = (.abs "u" (.var "w")) := rfl
example : rename (.abs "u" (.var "w")) "y" "u" = (.abs "u" (.var "w")) := rfl
example : rename (.abs "u" (.var "w")) "y" "x" = (.abs "u" (.var "w")) := rfl
example : rename (.abs "u" (.var "z")) "x" "u" = (.abs "u" (.var "z")) := rfl
example : rename (.abs "u" (.var "z")) "x" "x" = (.abs "u" (.var "z")) := rfl
example : rename (.abs "u" (.var "z")) "y" "u" = (.abs "u" (.var "z")) := rfl
example : rename (.abs "u" (.var "z")) "y" "x" = (.abs "u" (.var "z")) := rfl
example : rename (.abs "v" (.var "")) "x" "u" = (.abs "v" (.var "")) := rfl
example : rename (.abs "v" (.var "")) "x" "x" = (.abs "v" (.var "")) := rfl
example : rename (.abs "v" (.var "")) "y" "u" = (.abs "v" (.var "")) := rfl
example : rename (.abs "v" (.var "")) "y" "x" = (.abs "v" (.var "")) := rfl
example : rename (.abs "v" (.var "x")) "x" "u" = (.abs "v" (.var "u")) := rfl
example : rename (.abs "v" (.var "x")) "x" "x" = (.abs "v" (.var "x")) := rfl
example : rename (.abs "v" (.var "x")) "y" "u" = (.abs "v" (.var "x")) := rfl
example : rename (.abs "v" (.var "x")) "y" "x" = (.abs "v" (.var "x")) := rfl
example : rename (.abs "v" (.var "y")) "x" "u" = (.abs "v" (.var "y")) := rfl
example : rename (.abs "v" (.var "y")) "x" "x" = (.abs "v" (.var "y")) := rfl
example : rename (.abs "v" (.var "y")) "y" "u" = (.abs "v" (.var "u")) := rfl
example : rename (.abs "v" (.var "y")) "y" "x" = (.abs "v" (.var "x")) := rfl
example : rename (.abs "v" (.var "u")) "x" "u" = (.abs "v" (.var "u")) := rfl
example : rename (.abs "v" (.var "u")) "x" "x" = (.abs "v" (.var "u")) := rfl
example : rename (.abs "v" (.var "u")) "y" "u" = (.abs "v" (.var "u")) := rfl
example : rename (.abs "v" (.var "u")) "y" "x" = (.abs "v" (.var "u")) := rfl
example : rename (.abs "v" (.var "v")) "x" "u" = (.abs "v" (.var "v")) := rfl
example : rename (.abs "v" (.var "v")) "x" "x" = (.abs "v" (.var "v")) := rfl
example : rename (.abs "v" (.var "v")) "y" "u" = (.abs "v" (.var "v")) := rfl
example : rename (.abs "v" (.var "v")) "y" "x" = (.abs "v" (.var "v")) := rfl
example : rename (.abs "v" (.var "w")) "x" "u" = (.abs "v" (.var "w")) := rfl
example : rename (.abs "v" (.var "w")) "x" "x" = (.abs "v" (.var "w")) := rfl
example : rename (.abs "v" (.var "w")) "y" "u" = (.abs "v" (.var "w")) := rfl
example : rename (.abs "v" (.var "w")) "y" "x" = (.abs "v" (.var "w")) := rfl
example : rename (.abs "v" (.var "z")) "x" "u" = (.abs "v" (.var "z")) := rfl
example : rename (.abs "v" (.var "z")) "x" "x" = (.abs "v" (.var "z")) := rfl
example : rename (.abs "v" (.var "z")) "y" "u" = (.abs "v" (.var "z")) := rfl
example : rename (.abs "v" (.var "z")) "y" "x" = (.abs "v" (.var "z")) := rfl
example : rename (.abs "w" (.var "")) "x" "u" = (.abs "w" (.var "")) := rfl
example : rename (.abs "w" (.var "")) "x" "x" = (.abs "w" (.var "")) := rfl
example : rename (.abs "w" (.var "")) "y" "u" = (.abs "w" (.var "")) := rfl
example : rename (.abs "w" (.var "")) "y" "x" = (.abs "w" (.var "")) := rfl
example : rename (.abs "w" (.var "x")) "x" "u" = (.abs "w" (.var "u")) := rfl
example : rename (.abs "w" (.var "x")) "x" "x" = (.abs "w" (.var "x")) := rfl
example : rename (.abs "w" (.var "x")) "y" "u" = (.abs "w" (.var "x")) := rfl
example : rename (.abs "w" (.var "x")) "y" "x" = (.abs "w" (.var "x")) := rfl
example : rename (.abs "w" (.var "y")) "x" "u" = (.abs "w" (.var "y")) := rfl
example : rename (.abs "w" (.var "y")) "x" "x" = (.abs "w" (.var "y")) := rfl
example : rename (.abs "w" (.var "y")) "y" "u" = (.abs "w" (.var "u")) := rfl
example : rename (.abs "w" (.var "y")) "y" "x" = (.abs "w" (.var "x")) := rfl
example : rename (.abs "w" (.var "u")) "x" "u" = (.abs "w" (.var "u")) := rfl
example : rename (.abs "w" (.var "u")) "x" "x" = (.abs "w" (.var "u")) := rfl
example : rename (.abs "w" (.var "u")) "y" "u" = (.abs "w" (.var "u")) := rfl
example : rename (.abs "w" (.var "u")) "y" "x" = (.abs "w" (.var "u")) := rfl
example : rename (.abs "w" (.var "v")) "x" "u" = (.abs "w" (.var "v")) := rfl
example : rename (.abs "w" (.var "v")) "x" "x" = (.abs "w" (.var "v")) := rfl
example : rename (.abs "w" (.var "v")) "y" "u" = (.abs "w" (.var "v")) := rfl
example : rename (.abs "w" (.var "v")) "y" "x" = (.abs "w" (.var "v")) := rfl
example : rename (.abs "w" (.var "w")) "x" "u" = (.abs "w" (.var "w")) := rfl
example : rename (.abs "w" (.var "w")) "x" "x" = (.abs "w" (.var "w")) := rfl
example : rename (.abs "w" (.var "w")) "y" "u" = (.abs "w" (.var "w")) := rfl
example : rename (.abs "w" (.var "w")) "y" "x" = (.abs "w" (.var "w")) := rfl
example : rename (.abs "w" (.var "z")) "x" "u" = (.abs "w" (.var "z")) := rfl
example : rename (.abs "w" (.var "z")) "x" "x" = (.abs "w" (.var "z")) := rfl
example : rename (.abs "w" (.var "z")) "y" "u" = (.abs "w" (.var "z")) := rfl
example : rename (.abs "w" (.var "z")) "y" "x" = (.abs "w" (.var "z")) := rfl
example : rename (.abs "z" (.var "")) "x" "u" = (.abs "z" (.var "")) := rfl
example : rename (.abs "z" (.var "")) "x" "x" = (.abs "z" (.var "")) := rfl
example : rename (.abs "z" (.var "")) "y" "u" = (.abs "z" (.var "")) := rfl
example : rename (.abs "z" (.var "")) "y" "x" = (.abs "z" (.var "")) := rfl
example : rename (.abs "z" (.var "x")) "x" "u" = (.abs "z" (.var "u")) := rfl
example : rename (.abs "z" (.var "x")) "x" "x" = (.abs "z" (.var "x")) := rfl
example : rename (.abs "z" (.var "x")) "y" "u" = (.abs "z" (.var "x")) := rfl
example : rename (.abs "z" (.var "x")) "y" "x" = (.abs "z" (.var "x")) := rfl
example : rename (.abs "z" (.var "y")) "x" "u" = (.abs "z" (.var "y")) := rfl
example : rename (.abs "z" (.var "y")) "x" "x" = (.abs "z" (.var "y")) := rfl
example : rename (.abs "z" (.var "y")) "y" "u" = (.abs "z" (.var "u")) := rfl
example : rename (.abs "z" (.var "y")) "y" "x" = (.abs "z" (.var "x")) := rfl
example : rename (.abs "z" (.var "u")) "x" "u" = (.abs "z" (.var "u")) := rfl
example : rename (.abs "z" (.var "u")) "x" "x" = (.abs "z" (.var "u")) := rfl
example : rename (.abs "z" (.var "u")) "y" "u" = (.abs "z" (.var "u")) := rfl
example : rename (.abs "z" (.var "u")) "y" "x" = (.abs "z" (.var "u")) := rfl
example : rename (.abs "z" (.var "v")) "x" "u" = (.abs "z" (.var "v")) := rfl
example : rename (.abs "z" (.var "v")) "x" "x" = (.abs "z" (.var "v")) := rfl
example : rename (.abs "z" (.var "v")) "y" "u" = (.abs "z" (.var "v")) := rfl
example : rename (.abs "z" (.var "v")) "y" "x" = (.abs "z" (.var "v")) := rfl
example : rename (.abs "z" (.var "w")) "x" "u" = (.abs "z" (.var "w")) := rfl
example : rename (.abs "z" (.var "w")) "x" "x" = (.abs "z" (.var "w")) := rfl
example : rename (.abs "z" (.var "w")) "y" "u" = (.abs "z" (.var "w")) := rfl
example : rename (.abs "z" (.var "w")) "y" "x" = (.abs "z" (.var "w")) := rfl
example : rename (.abs "z" (.var "z")) "x" "u" = (.abs "z" (.var "z")) := rfl
example : rename (.abs "z" (.var "z")) "x" "x" = (.abs "z" (.var "z")) := rfl
example : rename (.abs "z" (.var "z")) "y" "u" = (.abs "z" (.var "z")) := rfl
example : rename (.abs "z" (.var "z")) "y" "x" = (.abs "z" (.var "z")) := rfl
example : rename (.abs "y" (.abs "u" (.var "y"))) "x" "u" = (.abs "y" (.abs "u" (.var "y"))) := rfl
example : rename (.abs "y" (.abs "u" (.var "y"))) "x" "x" = (.abs "y" (.abs "u" (.var "y"))) := rfl
example : rename (.abs "y" (.abs "u" (.var "y"))) "y" "u" = (.abs "u" (.abs "u" (.var "u"))) := rfl
example : rename (.abs "y" (.abs "u" (.var "y"))) "y" "x" = (.abs "x" (.abs "u" (.var "x"))) := rfl
example : rename (.abs "y" (.abs "u" (.var "x"))) "x" "u" = (.abs "y" (.abs "u" (.var "u"))) := rfl
example : rename (.abs "y" (.abs "u" (.var "x"))) "x" "x" = (.abs "y" (.abs "u" (.var "x"))) := rfl
example : rename (.abs "y" (.abs "u" (.var "x"))) "y" "u" = (.abs "u" (.abs "u" (.var "x"))) := rfl
example : rename (.abs "y" (.abs "u" (.var "x"))) "y" "x" = (.abs "x" (.abs "u" (.var "x"))) := rfl
example : rename (.abs "y" (.app (.var "x") (.var "u"))) "x" "u" = (.abs "y" (.app (.var "u") (.var "u"))) := rfl
example : rename (.abs "y" (.app (.var "x") (.var "u"))) "x" "x" = (.abs "y" (.app (.var "x") (.var "u"))) := rfl
example : rename (.abs "y" (.app (.var "x") (.var "u"))) "y" "u" = (.abs "u" (.app (.var "x") (.var "u"))) := rfl
example : rename (.abs "y" (.app (.var "x") (.var "u"))) "y" "x" = (.abs "x" (.app (.var "x") (.var "u"))) := rfl
example : substitute (.var "") "x" (.var "x") = .ok (.var "") := rfl
example : substitute (.var "") "x" (.var "y") = .ok (.var "") := rfl
example : substitute (.var "") "x" (.var "u") = .ok (.var "") := rfl
example : substitute (.var "") "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "") := rfl
example : substitute (.var "") "y" (.var "x") = .ok (.var "") := rfl
example : substitute (.var "") "y" (.var "y") = .ok (.var "") := rfl
example : substitute (.var "") "y" (.var "u") = .ok (.var "") := rfl
example : substitute (.var "") "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "") := rfl
example : substitute (.var "x") "x" (.var "x") = .ok (.var "x") := rfl
example : substitute (.var "x") "x" (.var "y") = .ok (.var "y") := rfl
example : substitute (.var "x") "x" (.var "u") = .ok (.var "u") := rfl
example : substitute (.var "x") "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) := rfl
example : substitute (.var "x") "y" (.var "x") = .ok (.var "x") := rfl
example : substitute (.var "x") "y" (.var "y") = .ok (.var "x") := rfl
example : substitute (.var "x") "y" (.var "u") = .ok (.var "x") := rfl
example : substitute (.var "x") "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "x") := rfl
example : substitute (.var "y") "x" (.var "x") = .ok (.var "y") := rfl
example : substitute (.var "y") "x" (.var "y") = .ok (.var "y") := rfl
example : substitute (.var "y") "x" (.var "u") = .ok (.var "y") := rfl
example : substitute (.var "y") "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "y") := rfl
example : substitute (.var "y") "y" (.var "x") = .ok (.var "x") := rfl
example : substitute (.var "y") "y" (.var "y") = .ok (.var "y") := rfl
example : substitute (.var "y") "y" (.var "u") = .ok (.var "u") := rfl
example : substitute (.var "y") "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) := rfl
example : substitute (.var "u") "x" (.var "x") = .ok (.var "u") := rfl
example : substitute (.var "u") "x" (.var "y") = .ok (.var "u") := rfl
example : substitute (.var "u") "x" (.var "u") = .ok (.var "u") := rfl
example : substitute (.var "u") "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "u") := rfl
example : substitute (.var "u") "y" (.var "x") = .ok (.var "u") := rfl
example : substitute (.var "u") "y" (.var "y") = .ok (.var "u") := rfl
example : substitute (.var "u") "y" (.var "u") = .ok (.var "u") := rfl
example : substitute (.var "u") "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "u") := rfl
example : substitute (.var "v") "x" (.var "x") = .ok (.var "v") := rfl
example : substitute (.var "v") "x" (.var "y") = .ok (.var "v") := rfl
example : substitute (.var "v") "x" (.var "u") = .ok (.var "v") := rfl
example : substitute (.var "v") "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "v") := rfl
example : substitute (.var "v") "y" (.var "x") = .ok (.var "v") := rfl
example : substitute (.var "v") "y" (.var "y") = .ok (.var "v") := rfl
example : substitute (.var "v") "y" (.var "u") = .ok (.var "v") := rfl
example : substitute (.var "v") "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "v") := rfl
example : substitute (.var "w") "x" (.var "x") = .ok (.var "w") := rfl
example : substitute (.var "w") "x" (.var "y") = .ok (.var "w") := rfl
example : substitute (.var "w") "x" (.var "u") = .ok (.var "w") := rfl
example : substitute (.var "w") "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "w") := rfl
example : substitute (.var "w") "y" (.var "x") = .ok (.var "w") := rfl
example : substitute (.var "w") "y" (.var "y") = .ok (.var "w") := rfl
example : substitute (.var "w") "y" (.var "u") = .ok (.var "w") := rfl
example : substitute (.var "w") "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "w") := rfl
example : substitute (.var "z") "x" (.var "x") = .ok (.var "z") := rfl
example : substitute (.var "z") "x" (.var "y") = .ok (.var "z") := rfl
example : substitute (.var "z") "x" (.var "u") = .ok (.var "z") := rfl
example : substitute (.var "z") "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "z") := rfl
example : substitute (.var "z") "y" (.var "x") = .ok (.var "z") := rfl
example : substitute (.var "z") "y" (.var "y") = .ok (.var "z") := rfl
example : substitute (.var "z") "y" (.var "u") = .ok (.var "z") := rfl
example : substitute (.var "z") "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.var "z") := rfl
example : substitute (.app (.var "") (.var "")) "x" (.var "x") = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "")) "x" (.var "y") = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "")) "x" (.var "u") = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "")) "y" (.var "x") = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "")) "y" (.var "y") = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "")) "y" (.var "u") = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "")) := rfl
example : substitute (.app (.var "") (.var "x")) "x" (.var "x") = .ok (.app (.var "") (.var "x")) := rfl
example : substitute (.app (.var "") (.var "x")) "x" (.var "y") = .ok (.app (.var "") (.var "y")) := rfl
example : substitute (.app (.var "") (.var "x")) "x" (.var "u") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "") (.var "x")) "y" (.var "x") = .ok (.app (.var "") (.var "x")) := rfl
example : substitute (.app (.var "") (.var "x")) "y" (.var "y") = .ok (.app (.var "") (.var "x")) := rfl
example : substitute (.app (.var "") (.var "x")) "y" (.var "u") = .ok (.app (.var "") (.var "x")) := rfl
example : substitute (.app (.var "") (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "x")) := rfl
example : substitute (.app (.var "") (.var "y")) "x" (.var "x") = .ok (.app (.var "") (.var "y")) := rfl
example : substitute (.app (.var "") (.var "y")) "x" (.var "y") = .ok (.app (.var "") (.var "y")) := rfl
example : substitute (.app (.var "") (.var "y")) "x" (.var "u") = .ok (.app (.var "") (.var "y")) := rfl
example : substitute (.app (.var "") (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "y")) := rfl
example : substitute (.app (.var "") (.var "y")) "y" (.var "x") = .ok (.app (.var "") (.var "x")) := rfl
example : substitute (.app (.var "") (.var "y")) "y" (.var "y") = .ok (.app (.var "") (.var "y")) := rfl
example : substitute (.app (.var "") (.var "y")) "y" (.var "u") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "") (.var "u")) "x" (.var "x") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "u")) "x" (.var "y") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "u")) "x" (.var "u") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "u")) "y" (.var "x") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "u")) "y" (.var "y") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "u")) "y" (.var "u") = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "u")) := rfl
example : substitute (.app (.var "") (.var "v")) "x" (.var "x") = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "v")) "x" (.var "y") = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "v")) "x" (.var "u") = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "v")) "y" (.var "x") = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "v")) "y" (.var "y") = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "v")) "y" (.var "u") = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "v")) := rfl
example : substitute (.app (.var "") (.var "w")) "x" (.var "x") = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "w")) "x" (.var "y") = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "w")) "x" (.var "u") = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "w")) "y" (.var "x") = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "w")) "y" (.var "y") = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "w")) "y" (.var "u") = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "w")) := rfl
example : substitute (.app (.var "") (.var "z")) "x" (.var "x") = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "") (.var "z")) "x" (.var "y") = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "") (.var "z")) "x" (.var "u") = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "") (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "") (.var "z")) "y" (.var "x") = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "") (.var "z")) "y" (.var "y") = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "") (.var "z")) "y" (.var "u") = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "") (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "") (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "")) "x" (.var "x") = .ok (.app (.var "x") (.var "")) := rfl
example : substitute (.app (.var "x") (.var "")) "x" (.var "y") = .ok (.app (.var "y") (.var "")) := rfl
example : substitute (.app (.var "x") (.var "")) "x" (.var "u") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "x") (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "")) := rfl
example : substitute (.app (.var "x") (.var "")) "y" (.var "x") = .ok (.app (.var "x") (.var "")) := rfl
example : substitute (.app (.var "x") (.var "")) "y" (.var "y") = .ok (.app (.var "x") (.var "")) := rfl
example : substitute (.app (.var "x") (.var "")) "y" (.var "u") = .ok (.app (.var "x") (.var "")) := rfl
example : substitute (.app (.var "x") (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "x") (.var "")) := rfl
example : substitute (.app (.var "x") (.var "x")) "x" (.var "x") = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "x") (.var "x")) "x" (.var "y") = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "x") (.var "x")) "x" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "x") (.var "x")) "y" (.var "x") = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "x") (.var "x")) "y" (.var "y") = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "x") (.var "x")) "y" (.var "u") = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "x") (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "x") (.var "y")) "x" (.var "x") = .ok (.app (.var "x") (.var "y")) := rfl
example : substitute (.app (.var "x") (.var "y")) "x" (.var "y") = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "x") (.var "y")) "x" (.var "u") = .ok (.app (.var "u") (.var "y")) := rfl
example : substitute (.app (.var "x") (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "y")) := rfl
example : substitute (.app (.var "x") (.var "y")) "y" (.var "x") = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "x") (.var "y")) "y" (.var "y") = .ok (.app (.var "x") (.var "y")) := rfl
example : substitute (.app (.var "x") (.var "y")) "y" (.var "u") = .ok (.app (.var "x") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "x") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "x") (.var "u")) "x" (.var "x") = .ok (.app (.var "x") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "u")) "x" (.var "y") = .ok (.app (.var "y") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "u")) "x" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "u")) "y" (.var "x") = .ok (.app (.var "x") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "u")) "y" (.var "y") = .ok (.app (.var "x") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "u")) "y" (.var "u") = .ok (.app (.var "x") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "x") (.var "u")) := rfl
example : substitute (.app (.var "x") (.var "v")) "x" (.var "x") = .ok (.app (.var "x") (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "v")) "x" (.var "y") = .ok (.app (.var "y") (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "v")) "x" (.var "u") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "v")) "y" (.var "x") = .ok (.app (.var "x") (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "v")) "y" (.var "y") = .ok (.app (.var "x") (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "v")) "y" (.var "u") = .ok (.app (.var "x") (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "x") (.var "v")) := rfl
example : substitute (.app (.var "x") (.var "w")) "x" (.var "x") = .ok (.app (.var "x") (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "w")) "x" (.var "y") = .ok (.app (.var "y") (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "w")) "x" (.var "u") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "w")) "y" (.var "x") = .ok (.app (.var "x") (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "w")) "y" (.var "y") = .ok (.app (.var "x") (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "w")) "y" (.var "u") = .ok (.app (.var "x") (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "x") (.var "w")) := rfl
example : substitute (.app (.var "x") (.var "z")) "x" (.var "x") = .ok (.app (.var "x") (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "z")) "x" (.var "y") = .ok (.app (.var "y") (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "z")) "x" (.var "u") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "z")) "y" (.var "x") = .ok (.app (.var "x") (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "z")) "y" (.var "y") = .ok (.app (.var "x") (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "z")) "y" (.var "u") = .ok (.app (.var "x") (.var "z")) := rfl
example : substitute (.app (.var "x") (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "x") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "")) "x" (.var "x") = .ok (.app (.var "y") (.var "")) := rfl
example : substitute (.app (.var "y") (.var "")) "x" (.var "y") = .ok (.app (.var "y") (.var "")) := rfl
example : substitute (.app (.var "y") (.var "")) "x" (.var "u") = .ok (.app (.var "y") (.var "")) := rfl
example : substitute (.app (.var "y") (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "y") (.var "")) := rfl
example : substitute (.app (.var "y") (.var "")) "y" (.var "x") = .ok (.app (.var "x") (.var "")) := rfl
example : substitute (.app (.var "y") (.var "")) "y" (.var "y") = .ok (.app (.var "y") (.var "")) := rfl
example : substitute (.app (.var "y") (.var "")) "y" (.var "u") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "y") (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "")) := rfl
example : substitute (.app (.var "y") (.var "x")) "x" (.var "x") = .ok (.app (.var "y") (.var "x")) := rfl
example : substitute (.app (.var "y") (.var "x")) "x" (.var "y") = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "y") (.var "x")) "x" (.var "u") = .ok (.app (.var "y") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "y") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "y") (.var "x")) "y" (.var "x") = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "y") (.var "x")) "y" (.var "y") = .ok (.app (.var "y") (.var "x")) := rfl
example : substitute (.app (.var "y") (.var "x")) "y" (.var "u") = .ok (.app (.var "u") (.var "x")) := rfl
example : substitute (.app (.var "y") (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "x")) := rfl
example : substitute (.app (.var "y") (.var "y")) "x" (.var "x") = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "y") (.var "y")) "x" (.var "y") = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "y") (.var "y")) "x" (.var "u") = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "y") (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "y") (.var "y")) "y" (.var "x") = .ok (.app (.var "x") (.var "x")) := rfl
example : substitute (.app (.var "y") (.var "y")) "y" (.var "y") = .ok (.app (.var "y") (.var "y")) := rfl
example : substitute (.app (.var "y") (.var "y")) "y" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "y") (.var "u")) "x" (.var "x") = .ok (.app (.var "y") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "u")) "x" (.var "y") = .ok (.app (.var "y") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "u")) "x" (.var "u") = .ok (.app (.var "y") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "y") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "u")) "y" (.var "x") = .ok (.app (.var "x") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "u")) "y" (.var "y") = .ok (.app (.var "y") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "u")) "y" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "u")) := rfl
example : substitute (.app (.var "y") (.var "v")) "x" (.var "x") = .ok (.app (.var "y") (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "v")) "x" (.var "y") = .ok (.app (.var "y") (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "v")) "x" (.var "u") = .ok (.app (.var "y") (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "y") (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "v")) "y" (.var "x") = .ok (.app (.var "x") (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "v")) "y" (.var "y") = .ok (.app (.var "y") (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "v")) "y" (.var "u") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "v")) := rfl
example : substitute (.app (.var "y") (.var "w")) "x" (.var "x") = .ok (.app (.var "y") (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "w")) "x" (.var "y") = .ok (.app (.var "y") (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "w")) "x" (.var "u") = .ok (.app (.var "y") (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "y") (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "w")) "y" (.var "x") = .ok (.app (.var "x") (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "w")) "y" (.var "y") = .ok (.app (.var "y") (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "w")) "y" (.var "u") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "w")) := rfl
example : substitute (.app (.var "y") (.var "z")) "x" (.var "x") = .ok (.app (.var "y") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "z")) "x" (.var "y") = .ok (.app (.var "y") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "z")) "x" (.var "u") = .ok (.app (.var "y") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "y") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "z")) "y" (.var "x") = .ok (.app (.var "x") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "z")) "y" (.var "y") = .ok (.app (.var "y") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "z")) "y" (.var "u") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "y") (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "")) "x" (.var "x") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "")) "x" (.var "y") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "")) "x" (.var "u") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "")) "y" (.var "x") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "")) "y" (.var "y") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "")) "y" (.var "u") = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "")) := rfl
example : substitute (.app (.var "u") (.var "x")) "x" (.var "x") = .ok (.app (.var "u") (.var "x")) := rfl
example : substitute (.app (.var "u") (.var "x")) "x" (.var "y") = .ok (.app (.var "u") (.var "y")) := rfl
example : substitute (.app (.var "u") (.var "x")) "x" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "u") (.var "x")) "y" (.var "x") = .ok (.app (.var "u") (.var "x")) := rfl
example : substitute (.app (.var "u") (.var "x")) "y" (.var "y") = .ok (.app (.var "u") (.var "x")) := rfl
example : substitute (.app (.var "u") (.var "x")) "y" (.var "u") = .ok (.app (.var "u") (.var "x")) := rfl
example : substitute (.app (.var "u") (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "x")) := rfl
example : substitute (.app (.var "u") (.var "y")) "x" (.var "x") = .ok (.app (.var "u") (.var "y")) := rfl
example : substitute (.app (.var "u") (.var "y")) "x" (.var "y") = .ok (.app (.var "u") (.var "y")) := rfl
example : substitute (.app (.var "u") (.var "y")) "x" (.var "u") = .ok (.app (.var "u") (.var "y")) := rfl
example : substitute (.app (.var "u") (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "y")) := rfl
example : substitute (.app (.var "u") (.var "y")) "y" (.var "x") = .ok (.app (.var "u") (.var "x")) := rfl
example : substitute (.app (.var "u") (.var "y")) "y" (.var "y") = .ok (.app (.var "u") (.var "y")) := rfl
example : substitute (.app (.var "u") (.var "y")) "y" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "u") (.var "u")) "x" (.var "x") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "u")) "x" (.var "y") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "u")) "x" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "u")) "y" (.var "x") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "u")) "y" (.var "y") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "u")) "y" (.var "u") = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "u")) := rfl
example : substitute (.app (.var "u") (.var "v")) "x" (.var "x") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "v")) "x" (.var "y") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "v")) "x" (.var "u") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "v")) "y" (.var "x") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "v")) "y" (.var "y") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "v")) "y" (.var "u") = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "v")) := rfl
example : substitute (.app (.var "u") (.var "w")) "x" (.var "x") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "w")) "x" (.var "y") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "w")) "x" (.var "u") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "w")) "y" (.var "x") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "w")) "y" (.var "y") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "w")) "y" (.var "u") = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "w")) := rfl
example : substitute (.app (.var "u") (.var "z")) "x" (.var "x") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "z")) "x" (.var "y") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "z")) "x" (.var "u") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "z")) "y" (.var "x") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "z")) "y" (.var "y") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "z")) "y" (.var "u") = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "u") (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "u") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "")) "x" (.var "x") = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "")) "x" (.var "y") = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "")) "x" (.var "u") = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "")) "y" (.var "x") = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "")) "y" (.var "y") = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "")) "y" (.var "u") = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "")) := rfl
example : substitute (.app (.var "v") (.var "x")) "x" (.var "x") = .ok (.app (.var "v") (.var "x")) := rfl
example : substitute (.app (.var "v") (.var "x")) "x" (.var "y") = .ok (.app (.var "v") (.var "y")) := rfl
example : substitute (.app (.var "v") (.var "x")) "x" (.var "u") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "v") (.var "x")) "y" (.var "x") = .ok (.app (.var "v") (.var "x")) := rfl
example : substitute (.app (.var "v") (.var "x")) "y" (.var "y") = .ok (.app (.var "v") (.var "x")) := rfl
example : substitute (.app (.var "v") (.var "x")) "y" (.var "u") = .ok (.app (.var "v") (.var "x")) := rfl
example : substitute (.app (.var "v") (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "x")) := rfl
example : substitute (.app (.var "v") (.var "y")) "x" (.var "x") = .ok (.app (.var "v") (.var "y")) := rfl
example : substitute (.app (.var "v") (.var "y")) "x" (.var "y") = .ok (.app (.var "v") (.var "y")) := rfl
example : substitute (.app (.var "v") (.var "y")) "x" (.var "u") = .ok (.app (.var "v") (.var "y")) := rfl
example : substitute (.app (.var "v") (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "y")) := rfl
example : substitute (.app (.var "v") (.var "y")) "y" (.var "x") = .ok (.app (.var "v") (.var "x")) := rfl
example : substitute (.app (.var "v") (.var "y")) "y" (.var "y") = .ok (.app (.var "v") (.var "y")) := rfl
example : substitute (.app (.var "v") (.var "y")) "y" (.var "u") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "v") (.var "u")) "x" (.var "x") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "u")) "x" (.var "y") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "u")) "x" (.var "u") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "u")) "y" (.var "x") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "u")) "y" (.var "y") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "u")) "y" (.var "u") = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "u")) := rfl
example : substitute (.app (.var "v") (.var "v")) "x" (.var "x") = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "v")) "x" (.var "y") = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "v")) "x" (.var "u") = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "v")) "y" (.var "x") = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "v")) "y" (.var "y") = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "v")) "y" (.var "u") = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "v")) := rfl
example : substitute (.app (.var "v") (.var "w")) "x" (.var "x") = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "w")) "x" (.var "y") = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "w")) "x" (.var "u") = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "w")) "y" (.var "x") = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "w")) "y" (.var "y") = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "w")) "y" (.var "u") = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "w")) := rfl
example : substitute (.app (.var "v") (.var "z")) "x" (.var "x") = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "z")) "x" (.var "y") = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "z")) "x" (.var "u") = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "z")) "y" (.var "x") = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "z")) "y" (.var "y") = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "z")) "y" (.var "u") = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "v") (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "v") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "")) "x" (.var "x") = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "")) "x" (.var "y") = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "")) "x" (.var "u") = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "")) "y" (.var "x") = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "")) "y" (.var "y") = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "")) "y" (.var "u") = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "")) := rfl
example : substitute (.app (.var "w") (.var "x")) "x" (.var "x") = .ok (.app (.var "w") (.var "x")) := rfl
example : substitute (.app (.var "w") (.var "x")) "x" (.var "y") = .ok (.app (.var "w") (.var "y")) := rfl
example : substitute (.app (.var "w") (.var "x")) "x" (.var "u") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "w") (.var "x")) "y" (.var "x") = .ok (.app (.var "w") (.var "x")) := rfl
example : substitute (.app (.var "w") (.var "x")) "y" (.var "y") = .ok (.app (.var "w") (.var "x")) := rfl
example : substitute (.app (.var "w") (.var "x")) "y" (.var "u") = .ok (.app (.var "w") (.var "x")) := rfl
example : substitute (.app (.var "w") (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "x")) := rfl
example : substitute (.app (.var "w") (.var "y")) "x" (.var "x") = .ok (.app (.var "w") (.var "y")) := rfl
example : substitute (.app (.var "w") (.var "y")) "x" (.var "y") = .ok (.app (.var "w") (.var "y")) := rfl
example : substitute (.app (.var "w") (.var "y")) "x" (.var "u") = .ok (.app (.var "w") (.var "y")) := rfl
example : substitute (.app (.var "w") (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "y")) := rfl
example : substitute (.app (.var "w") (.var "y")) "y" (.var "x") = .ok (.app (.var "w") (.var "x")) := rfl
example : substitute (.app (.var "w") (.var "y")) "y" (.var "y") = .ok (.app (.var "w") (.var "y")) := rfl
example : substitute (.app (.var "w") (.var "y")) "y" (.var "u") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "w") (.var "u")) "x" (.var "x") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "u")) "x" (.var "y") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "u")) "x" (.var "u") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "u")) "y" (.var "x") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "u")) "y" (.var "y") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "u")) "y" (.var "u") = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "u")) := rfl
example : substitute (.app (.var "w") (.var "v")) "x" (.var "x") = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "v")) "x" (.var "y") = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "v")) "x" (.var "u") = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "v")) "y" (.var "x") = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "v")) "y" (.var "y") = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "v")) "y" (.var "u") = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "v")) := rfl
example : substitute (.app (.var "w") (.var "w")) "x" (.var "x") = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "w")) "x" (.var "y") = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "w")) "x" (.var "u") = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "w")) "y" (.var "x") = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "w")) "y" (.var "y") = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "w")) "y" (.var "u") = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "w")) := rfl
example : substitute (.app (.var "w") (.var "z")) "x" (.var "x") = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "z")) "x" (.var "y") = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "z")) "x" (.var "u") = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "z")) "y" (.var "x") = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "z")) "y" (.var "y") = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "z")) "y" (.var "u") = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "w") (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "w") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "")) "x" (.var "x") = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "")) "x" (.var "y") = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "")) "x" (.var "u") = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "")) "y" (.var "x") = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "")) "y" (.var "y") = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "")) "y" (.var "u") = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "")) := rfl
example : substitute (.app (.var "z") (.var "x")) "x" (.var "x") = .ok (.app (.var "z") (.var "x")) := rfl
example : substitute (.app (.var "z") (.var "x")) "x" (.var "y") = .ok (.app (.var "z") (.var "y")) := rfl
example : substitute (.app (.var "z") (.var "x")) "x" (.var "u") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "z") (.var "x")) "y" (.var "x") = .ok (.app (.var "z") (.var "x")) := rfl
example : substitute (.app (.var "z") (.var "x")) "y" (.var "y") = .ok (.app (.var "z") (.var "x")) := rfl
example : substitute (.app (.var "z") (.var "x")) "y" (.var "u") = .ok (.app (.var "z") (.var "x")) := rfl
example : substitute (.app (.var "z") (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "x")) := rfl
example : substitute (.app (.var "z") (.var "y")) "x" (.var "x") = .ok (.app (.var "z") (.var "y")) := rfl
example : substitute (.app (.var "z") (.var "y")) "x" (.var "y") = .ok (.app (.var "z") (.var "y")) := rfl
example : substitute (.app (.var "z") (.var "y")) "x" (.var "u") = .ok (.app (.var "z") (.var "y")) := rfl
example : substitute (.app (.var "z") (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "y")) := rfl
example : substitute (.app (.var "z") (.var "y")) "y" (.var "x") = .ok (.app (.var "z") (.var "x")) := rfl
example : substitute (.app (.var "z") (.var "y")) "y" (.var "y") = .ok (.app (.var "z") (.var "y")) := rfl
example : substitute (.app (.var "z") (.var "y")) "y" (.var "u") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.app (.var "z") (.var "u")) "x" (.var "x") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "u")) "x" (.var "y") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "u")) "x" (.var "u") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "u")) "y" (.var "x") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "u")) "y" (.var "y") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "u")) "y" (.var "u") = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "u")) := rfl
example : substitute (.app (.var "z") (.var "v")) "x" (.var "x") = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "v")) "x" (.var "y") = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "v")) "x" (.var "u") = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "v")) "y" (.var "x") = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "v")) "y" (.var "y") = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "v")) "y" (.var "u") = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "v")) := rfl
example : substitute (.app (.var "z") (.var "w")) "x" (.var "x") = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "w")) "x" (.var "y") = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "w")) "x" (.var "u") = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "w")) "y" (.var "x") = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "w")) "y" (.var "y") = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "w")) "y" (.var "u") = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "w")) := rfl
example : substitute (.app (.var "z") (.var "z")) "x" (.var "x") = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "z")) "x" (.var "y") = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "z")) "x" (.var "u") = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "z")) "y" (.var "x") = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "z")) "y" (.var "y") = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "z")) "y" (.var "u") = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.app (.var "z") (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.app (.var "z") (.var "z")) := rfl
example : substitute (.abs "" (.var "")) "x" (.var "x") = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "")) "x" (.var "y") = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "")) "x" (.var "u") = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "")) "y" (.var "x") = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "")) "y" (.var "y") = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "")) "y" (.var "u") = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "")) := rfl
example : substitute (.abs "" (.var "x")) "x" (.var "x") = .ok (.abs "" (.var "x")) := rfl
example : substitute (.abs "" (.var "x")) "x" (.var "y") = .ok (.abs "" (.var "y")) := rfl
example : substitute (.abs "" (.var "x")) "x" (.var "u") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.abs "" (.var "x")) "y" (.var "x") = .ok (.abs "" (.var "x")) := rfl
example : substitute (.abs "" (.var "x")) "y" (.var "y") = .ok (.abs "" (.var "x")) := rfl
example : substitute (.abs "" (.var "x")) "y" (.var "u") = .ok (.abs "" (.var "x")) := rfl
example : substitute (.abs "" (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "x")) := rfl
example : substitute (.abs "" (.var "y")) "x" (.var "x") = .ok (.abs "" (.var "y")) := rfl
example : substitute (.abs "" (.var "y")) "x" (.var "y") = .ok (.abs "" (.var "y")) := rfl
example : substitute (.abs "" (.var "y")) "x" (.var "u") = .ok (.abs "" (.var "y")) := rfl
example : substitute (.abs "" (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "y")) := rfl
example : substitute (.abs "" (.var "y")) "y" (.var "x") = .ok (.abs "" (.var "x")) := rfl
example : substitute (.abs "" (.var "y")) "y" (.var "y") = .ok (.abs "" (.var "y")) := rfl
example : substitute (.abs "" (.var "y")) "y" (.var "u") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.abs "" (.var "u")) "x" (.var "x") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "u")) "x" (.var "y") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "u")) "x" (.var "u") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "u")) "y" (.var "x") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "u")) "y" (.var "y") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "u")) "y" (.var "u") = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "u")) := rfl
example : substitute (.abs "" (.var "v")) "x" (.var "x") = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "v")) "x" (.var "y") = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "v")) "x" (.var "u") = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "v")) "y" (.var "x") = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "v")) "y" (.var "y") = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "v")) "y" (.var "u") = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "v")) := rfl
example : substitute (.abs "" (.var "w")) "x" (.var "x") = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "w")) "x" (.var "y") = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "w")) "x" (.var "u") = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "w")) "y" (.var "x") = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "w")) "y" (.var "y") = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "w")) "y" (.var "u") = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "w")) := rfl
example : substitute (.abs "" (.var "z")) "x" (.var "x") = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "" (.var "z")) "x" (.var "y") = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "" (.var "z")) "x" (.var "u") = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "" (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "" (.var "z")) "y" (.var "x") = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "" (.var "z")) "y" (.var "y") = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "" (.var "z")) "y" (.var "u") = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "" (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "" (.var "z")) := rfl
example : substitute (.abs "x" (.var "")) "x" (.var "x") = .ok (.abs "x" (.var "")) := rfl
example : substitute (.abs "x" (.var "")) "x" (.var "y") = .ok (.abs "x" (.var "")) := rfl
example : substitute (.abs "x" (.var "")) "x" (.var "u") = .ok (.abs "x" (.var "")) := rfl
example : substitute (.abs "x" (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "")) := rfl
example : substitute (.abs "x" (.var "")) "y" (.var "x") = .ok (.abs "u" (.var "")) := rfl
example : substitute (.abs "x" (.var "")) "y" (.var "y") = .ok (.abs "x" (.var "")) := rfl
example : substitute (.abs "x" (.var "")) "y" (.var "u") = .ok (.abs "x" (.var "")) := rfl
example : substitute (.abs "x" (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "")) := rfl
example : substitute (.abs "x" (.var "x")) "x" (.var "x") = .ok (.abs "x" (.var "x")) := rfl
example : substitute (.abs "x" (.var "x")) "x" (.var "y") = .ok (.abs "x" (.var "x")) := rfl
example : substitute (.abs "x" (.var "x")) "x" (.var "u") = .ok (.abs "x" (.var "x")) := rfl
example : substitute (.abs "x" (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "x")) := rfl
example : substitute (.abs "x" (.var "x")) "y" (.var "x") = .ok (.abs "u" (.var "u")) := rfl
example : substitute (.abs "x" (.var "x")) "y" (.var "y") = .ok (.abs "x" (.var "x")) := rfl
example : substitute (.abs "x" (.var "x")) "y" (.var "u") = .ok (.abs "x" (.var "x")) := rfl
example : substitute (.abs "x" (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "x")) := rfl
example : substitute (.abs "x" (.var "y")) "x" (.var "x") = .ok (.abs "x" (.var "y")) := rfl
example : substitute (.abs "x" (.var "y")) "x" (.var "y") = .ok (.abs "x" (.var "y")) := rfl
example : substitute (.abs "x" (.var "y")) "x" (.var "u") = .ok (.abs "x" (.var "y")) := rfl
example : substitute (.abs "x" (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "y")) := rfl
example : substitute (.abs "x" (.var "y")) "y" (.var "x") = .ok (.abs "u" (.var "x")) := rfl
example : substitute (.abs "x" (.var "y")) "y" (.var "y") = .ok (.abs "x" (.var "y")) := rfl
example : substitute (.abs "x" (.var "y")) "y" (.var "u") = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.abs "x" (.var "u")) "x" (.var "x") = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "u")) "x" (.var "y") = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "u")) "x" (.var "u") = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "u")) "y" (.var "x") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "x" (.var "u")) "y" (.var "y") = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "u")) "y" (.var "u") = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "u")) := rfl
example : substitute (.abs "x" (.var "v")) "x" (.var "x") = .ok (.abs "x" (.var "v")) := rfl
example : substitute (.abs "x" (.var "v")) "x" (.var "y") = .ok (.abs "x" (.var "v")) := rfl
example : substitute (.abs "x" (.var "v")) "x" (.var "u") = .ok (.abs "x" (.var "v")) := rfl
example : substitute (.abs "x" (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "v")) := rfl
example : substitute (.abs "x" (.var "v")) "y" (.var "x") = .ok (.abs "u" (.var "v")) := rfl
example : substitute (.abs "x" (.var "v")) "y" (.var "y") = .ok (.abs "x" (.var "v")) := rfl
example : substitute (.abs "x" (.var "v")) "y" (.var "u") = .ok (.abs "x" (.var "v")) := rfl
example : substitute (.abs "x" (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "v")) := rfl
example : substitute (.abs "x" (.var "w")) "x" (.var "x") = .ok (.abs "x" (.var "w")) := rfl
example : substitute (.abs "x" (.var "w")) "x" (.var "y") = .ok (.abs "x" (.var "w")) := rfl
example : substitute (.abs "x" (.var "w")) "x" (.var "u") = .ok (.abs "x" (.var "w")) := rfl
example : substitute (.abs "x" (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "w")) := rfl
example : substitute (.abs "x" (.var "w")) "y" (.var "x") = .ok (.abs "u" (.var "w")) := rfl
example : substitute (.abs "x" (.var "w")) "y" (.var "y") = .ok (.abs "x" (.var "w")) := rfl
example : substitute (.abs "x" (.var "w")) "y" (.var "u") = .ok (.abs "x" (.var "w")) := rfl
example : substitute (.abs "x" (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "w")) := rfl
example : substitute (.abs "x" (.var "z")) "x" (.var "x") = .ok (.abs "x" (.var "z")) := rfl
example : substitute (.abs "x" (.var "z")) "x" (.var "y") = .ok (.abs "x" (.var "z")) := rfl
example : substitute (.abs "x" (.var "z")) "x" (.var "u") = .ok (.abs "x" (.var "z")) := rfl
example : substitute (.abs "x" (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "z")) := rfl
example : substitute (.abs "x" (.var "z")) "y" (.var "x") = .ok (.abs "u" (.var "z")) := rfl
example : substitute (.abs "x" (.var "z")) "y" (.var "y") = .ok (.abs "x" (.var "z")) := rfl
example : substitute (.abs "x" (.var "z")) "y" (.var "u") = .ok (.abs "x" (.var "z")) := rfl
example : substitute (.abs "x" (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "x" (.var "z")) := rfl
example : substitute (.abs "y" (.var "")) "x" (.var "x") = .ok (.abs "y" (.var "")) := rfl
example : substitute (.abs "y" (.var "")) "x" (.var "y") = .ok (.abs "u" (.var "")) := rfl
example : substitute (.abs "y" (.var "")) "x" (.var "u") = .ok (.abs "y" (.var "")) := rfl
example : substitute (.abs "y" (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "")) := rfl
example : substitute (.abs "y" (.var "")) "y" (.var "x") = .ok (.abs "y" (.var "")) := rfl
example : substitute (.abs "y" (.var "")) "y" (.var "y") = .ok (.abs "y" (.var "")) := rfl
example : substitute (.abs "y" (.var "")) "y" (.var "u") = .ok (.abs "y" (.var "")) := rfl
example : substitute (.abs "y" (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "")) := rfl
example : substitute (.abs "y" (.var "x")) "x" (.var "x") = .ok (.abs "y" (.var "x")) := rfl
example : substitute (.abs "y" (.var "x")) "x" (.var "y") = .ok (.abs "u" (.var "y")) := rfl
example : substitute (.abs "y" (.var "x")) "x" (.var "u") = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z"))))) := rfl
example : substitute (.abs "y" (.var "x")) "y" (.var "x") = .ok (.abs "y" (.var "x")) := rfl
example : substitute (.abs "y" (.var "x")) "y" (.var "y") = .ok (.abs "y" (.var "x")) := rfl
example : substitute (.abs "y" (.var "x")) "y" (.var "u") = .ok (.abs "y" (.var "x")) := rfl
example : substitute (.abs "y" (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "x")) := rfl
example : substitute (.abs "y" (.var "y")) "x" (.var "x") = .ok (.abs "y" (.var "y")) := rfl
example : substitute (.abs "y" (.var "y")) "x" (.var "y") = .ok (.abs "u" (.var "u")) := rfl
example : substitute (.abs "y" (.var "y")) "x" (.var "u") = .ok (.abs "y" (.var "y")) := rfl
example : substitute (.abs "y" (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "y")) := rfl
example : substitute (.abs "y" (.var "y")) "y" (.var "x") = .ok (.abs "y" (.var "y")) := rfl
example : substitute (.abs "y" (.var "y")) "y" (.var "y") = .ok (.abs "y" (.var "y")) := rfl
example : substitute (.abs "y" (.var "y")) "y" (.var "u") = .ok (.abs "y" (.var "y")) := rfl
example : substitute (.abs "y" (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "y")) := rfl
example : substitute (.abs "y" (.var "u")) "x" (.var "x") = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "u")) "x" (.var "y") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "y" (.var "u")) "x" (.var "u") = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "u")) "y" (.var "x") = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "u")) "y" (.var "y") = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "u")) "y" (.var "u") = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "u")) := rfl
example : substitute (.abs "y" (.var "v")) "x" (.var "x") = .ok (.abs "y" (.var "v")) := rfl
example : substitute (.abs "y" (.var "v")) "x" (.var "y") = .ok (.abs "u" (.var "v")) := rfl
example : substitute (.abs "y" (.var "v")) "x" (.var "u") = .ok (.abs "y" (.var "v")) := rfl
example : substitute (.abs "y" (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "v")) := rfl
example : substitute (.abs "y" (.var "v")) "y" (.var "x") = .ok (.abs "y" (.var "v")) := rfl
example : substitute (.abs "y" (.var "v")) "y" (.var "y") = .ok (.abs "y" (.var "v")) := rfl
example : substitute (.abs "y" (.var "v")) "y" (.var "u") = .ok (.abs "y" (.var "v")) := rfl
example : substitute (.abs "y" (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "v")) := rfl
example : substitute (.abs "y" (.var "w")) "x" (.var "x") = .ok (.abs "y" (.var "w")) := rfl
example : substitute (.abs "y" (.var "w")) "x" (.var "y") = .ok (.abs "u" (.var "w")) := rfl
example : substitute (.abs "y" (.var "w")) "x" (.var "u") = .ok (.abs "y" (.var "w")) := rfl
example : substitute (.abs "y" (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "w")) := rfl
example : substitute (.abs "y" (.var "w")) "y" (.var "x") = .ok (.abs "y" (.var "w")) := rfl
example : substitute (.abs "y" (.var "w")) "y" (.var "y") = .ok (.abs "y" (.var "w")) := rfl
example : substitute (.abs "y" (.var "w")) "y" (.var "u") = .ok (.abs "y" (.var "w")) := rfl
example : substitute (.abs "y" (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "w")) := rfl
example : substitute (.abs "y" (.var "z")) "x" (.var "x") = .ok (.abs "y" (.var "z")) := rfl
example : substitute (.abs "y" (.var "z")) "x" (.var "y") = .ok (.abs "u" (.var "z")) := rfl
example : substitute (.abs "y" (.var "z")) "x" (.var "u") = .ok (.abs "y" (.var "z")) := rfl
example : substitute (.abs "y" (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "z")) := rfl
example : substitute (.abs "y" (.var "z")) "y" (.var "x") = .ok (.abs "y" (.var "z")) := rfl
example : substitute (.abs "y" (.var "z")) "y" (.var "y") = .ok (.abs "y" (.var "z")) := rfl
example : substitute (.abs "y" (.var "z")) "y" (.var "u") = .ok (.abs "y" (.var "z")) := rfl
example : substitute (.abs "y" (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.var "z")) := rfl
example : substitute (.abs "u" (.var "")) "x" (.var "x") = .ok (.abs "u" (.var "")) := rfl
example : substitute (.abs "u" (.var "")) "x" (.var "y") = .ok (.abs "u" (.var "")) := rfl
example : substitute (.abs "u" (.var "")) "x" (.var "u") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "u" (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "")) "y" (.var "x") = .ok (.abs "u" (.var "")) := rfl
example : substitute (.abs "u" (.var "")) "y" (.var "y") = .ok (.abs "u" (.var "")) := rfl
example : substitute (.abs "u" (.var "")) "y" (.var "u") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "u" (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "x")) "x" (.var "x") = .ok (.abs "u" (.var "x")) := rfl
example : substitute (.abs "u" (.var "x")) "x" (.var "y") = .ok (.abs "u" (.var "y")) := rfl
example : substitute (.abs "u" (.var "x")) "x" (.var "u") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "u" (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "x")) "y" (.var "x") = .ok (.abs "u" (.var "x")) := rfl
example : substitute (.abs "u" (.var "x")) "y" (.var "y") = .ok (.abs "u" (.var "x")) := rfl
example : substitute (.abs "u" (.var "x")) "y" (.var "u") = .ok (.abs "v" (.var "x")) := rfl
example : substitute (.abs "u" (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "y")) "x" (.var "x") = .ok (.abs "u" (.var "y")) := rfl
example : substitute (.abs "u" (.var "y")) "x" (.var "y") = .ok (.abs "u" (.var "y")) := rfl
example : substitute (.abs "u" (.var "y")) "x" (.var "u") = .ok (.abs "v" (.var "y")) := rfl
example : substitute (.abs "u" (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "y")) "y" (.var "x") = .ok (.abs "u" (.var "x")) := rfl
example : substitute (.abs "u" (.var "y")) "y" (.var "y") = .ok (.abs "u" (.var "y")) := rfl
example : substitute (.abs "u" (.var "y")) "y" (.var "u") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "u" (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "u")) "x" (.var "x") = .ok (.abs "u" (.var "u")) := rfl
example : substitute (.abs "u" (.var "u")) "x" (.var "y") = .ok (.abs "u" (.var "u")) := rfl
example : substitute (.abs "u" (.var "u")) "x" (.var "u") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "u" (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "u")) "y" (.var "x") = .ok (.abs "u" (.var "u")) := rfl
example : substitute (.abs "u" (.var "u")) "y" (.var "y") = .ok (.abs "u" (.var "u")) := rfl
example : substitute (.abs "u" (.var "u")) "y" (.var "u") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "u" (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "v")) "x" (.var "x") = .ok (.abs "u" (.var "v")) := rfl
example : substitute (.abs "u" (.var "v")) "x" (.var "y") = .ok (.abs "u" (.var "v")) := rfl
example : substitute (.abs "u" (.var "v")) "x" (.var "u") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "u" (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "v")) "y" (.var "x") = .ok (.abs "u" (.var "v")) := rfl
example : substitute (.abs "u" (.var "v")) "y" (.var "y") = .ok (.abs "u" (.var "v")) := rfl
example : substitute (.abs "u" (.var "v")) "y" (.var "u") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "u" (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "w")) "x" (.var "x") = .ok (.abs "u" (.var "w")) := rfl
example : substitute (.abs "u" (.var "w")) "x" (.var "y") = .ok (.abs "u" (.var "w")) := rfl
example : substitute (.abs "u" (.var "w")) "x" (.var "u") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "u" (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "w")) "y" (.var "x") = .ok (.abs "u" (.var "w")) := rfl
example : substitute (.abs "u" (.var "w")) "y" (.var "y") = .ok (.abs "u" (.var "w")) := rfl
example : substitute (.abs "u" (.var "w")) "y" (.var "u") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "u" (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "z")) "x" (.var "x") = .ok (.abs "u" (.var "z")) := rfl
example : substitute (.abs "u" (.var "z")) "x" (.var "y") = .ok (.abs "u" (.var "z")) := rfl
example : substitute (.abs "u" (.var "z")) "x" (.var "u") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "u" (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "u" (.var "z")) "y" (.var "x") = .ok (.abs "u" (.var "z")) := rfl
example : substitute (.abs "u" (.var "z")) "y" (.var "y") = .ok (.abs "u" (.var "z")) := rfl
example : substitute (.abs "u" (.var "z")) "y" (.var "u") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "u" (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "")) "x" (.var "x") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "v" (.var "")) "x" (.var "y") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "v" (.var "")) "x" (.var "u") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "v" (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "")) "y" (.var "x") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "v" (.var "")) "y" (.var "y") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "v" (.var "")) "y" (.var "u") = .ok (.abs "v" (.var "")) := rfl
example : substitute (.abs "v" (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "x")) "x" (.var "x") = .ok (.abs "v" (.var "x")) := rfl
example : substitute (.abs "v" (.var "x")) "x" (.var "y") = .ok (.abs "v" (.var "y")) := rfl
example : substitute (.abs "v" (.var "x")) "x" (.var "u") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "x")) "y" (.var "x") = .ok (.abs "v" (.var "x")) := rfl
example : substitute (.abs "v" (.var "x")) "y" (.var "y") = .ok (.abs "v" (.var "x")) := rfl
example : substitute (.abs "v" (.var "x")) "y" (.var "u") = .ok (.abs "v" (.var "x")) := rfl
example : substitute (.abs "v" (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "y")) "x" (.var "x") = .ok (.abs "v" (.var "y")) := rfl
example : substitute (.abs "v" (.var "y")) "x" (.var "y") = .ok (.abs "v" (.var "y")) := rfl
example : substitute (.abs "v" (.var "y")) "x" (.var "u") = .ok (.abs "v" (.var "y")) := rfl
example : substitute (.abs "v" (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "y")) "y" (.var "x") = .ok (.abs "v" (.var "x")) := rfl
example : substitute (.abs "v" (.var "y")) "y" (.var "y") = .ok (.abs "v" (.var "y")) := rfl
example : substitute (.abs "v" (.var "y")) "y" (.var "u") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "u")) "x" (.var "x") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "u")) "x" (.var "y") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "u")) "x" (.var "u") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "u")) "y" (.var "x") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "u")) "y" (.var "y") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "u")) "y" (.var "u") = .ok (.abs "v" (.var "u")) := rfl
example : substitute (.abs "v" (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "v")) "x" (.var "x") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "v" (.var "v")) "x" (.var "y") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "v" (.var "v")) "x" (.var "u") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "v" (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "v")) "y" (.var "x") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "v" (.var "v")) "y" (.var "y") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "v" (.var "v")) "y" (.var "u") = .ok (.abs "v" (.var "v")) := rfl
example : substitute (.abs "v" (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "w")) "x" (.var "x") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "v" (.var "w")) "x" (.var "y") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "v" (.var "w")) "x" (.var "u") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "v" (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "w")) "y" (.var "x") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "v" (.var "w")) "y" (.var "y") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "v" (.var "w")) "y" (.var "u") = .ok (.abs "v" (.var "w")) := rfl
example : substitute (.abs "v" (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "z")) "x" (.var "x") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "v" (.var "z")) "x" (.var "y") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "v" (.var "z")) "x" (.var "u") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "v" (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "v" (.var "z")) "y" (.var "x") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "v" (.var "z")) "y" (.var "y") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "v" (.var "z")) "y" (.var "u") = .ok (.abs "v" (.var "z")) := rfl
example : substitute (.abs "v" (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "")) "x" (.var "x") = .ok (.abs "w" (.var "")) := rfl
example : substitute (.abs "w" (.var "")) "x" (.var "y") = .ok (.abs "w" (.var "")) := rfl
example : substitute (.abs "w" (.var "")) "x" (.var "u") = .ok (.abs "w" (.var "")) := rfl
example : substitute (.abs "w" (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "")) "y" (.var "x") = .ok (.abs "w" (.var "")) := rfl
example : substitute (.abs "w" (.var "")) "y" (.var "y") = .ok (.abs "w" (.var "")) := rfl
example : substitute (.abs "w" (.var "")) "y" (.var "u") = .ok (.abs "w" (.var "")) := rfl
example : substitute (.abs "w" (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "x")) "x" (.var "x") = .ok (.abs "w" (.var "x")) := rfl
example : substitute (.abs "w" (.var "x")) "x" (.var "y") = .ok (.abs "w" (.var "y")) := rfl
example : substitute (.abs "w" (.var "x")) "x" (.var "u") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "x")) "y" (.var "x") = .ok (.abs "w" (.var "x")) := rfl
example : substitute (.abs "w" (.var "x")) "y" (.var "y") = .ok (.abs "w" (.var "x")) := rfl
example : substitute (.abs "w" (.var "x")) "y" (.var "u") = .ok (.abs "w" (.var "x")) := rfl
example : substitute (.abs "w" (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "y")) "x" (.var "x") = .ok (.abs "w" (.var "y")) := rfl
example : substitute (.abs "w" (.var "y")) "x" (.var "y") = .ok (.abs "w" (.var "y")) := rfl
example : substitute (.abs "w" (.var "y")) "x" (.var "u") = .ok (.abs "w" (.var "y")) := rfl
example : substitute (.abs "w" (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "y")) "y" (.var "x") = .ok (.abs "w" (.var "x")) := rfl
example : substitute (.abs "w" (.var "y")) "y" (.var "y") = .ok (.abs "w" (.var "y")) := rfl
example : substitute (.abs "w" (.var "y")) "y" (.var "u") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "u")) "x" (.var "x") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "u")) "x" (.var "y") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "u")) "x" (.var "u") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "u")) "y" (.var "x") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "u")) "y" (.var "y") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "u")) "y" (.var "u") = .ok (.abs "w" (.var "u")) := rfl
example : substitute (.abs "w" (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "v")) "x" (.var "x") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "w" (.var "v")) "x" (.var "y") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "w" (.var "v")) "x" (.var "u") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "w" (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "v")) "y" (.var "x") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "w" (.var "v")) "y" (.var "y") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "w" (.var "v")) "y" (.var "u") = .ok (.abs "w" (.var "v")) := rfl
example : substitute (.abs "w" (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "w")) "x" (.var "x") = .ok (.abs "w" (.var "w")) := rfl
example : substitute (.abs "w" (.var "w")) "x" (.var "y") = .ok (.abs "w" (.var "w")) := rfl
example : substitute (.abs "w" (.var "w")) "x" (.var "u") = .ok (.abs "w" (.var "w")) := rfl
example : substitute (.abs "w" (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "w")) "y" (.var "x") = .ok (.abs "w" (.var "w")) := rfl
example : substitute (.abs "w" (.var "w")) "y" (.var "y") = .ok (.abs "w" (.var "w")) := rfl
example : substitute (.abs "w" (.var "w")) "y" (.var "u") = .ok (.abs "w" (.var "w")) := rfl
example : substitute (.abs "w" (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "z")) "x" (.var "x") = .ok (.abs "w" (.var "z")) := rfl
example : substitute (.abs "w" (.var "z")) "x" (.var "y") = .ok (.abs "w" (.var "z")) := rfl
example : substitute (.abs "w" (.var "z")) "x" (.var "u") = .ok (.abs "w" (.var "z")) := rfl
example : substitute (.abs "w" (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "w" (.var "z")) "y" (.var "x") = .ok (.abs "w" (.var "z")) := rfl
example : substitute (.abs "w" (.var "z")) "y" (.var "y") = .ok (.abs "w" (.var "z")) := rfl
example : substitute (.abs "w" (.var "z")) "y" (.var "u") = .ok (.abs "w" (.var "z")) := rfl
example : substitute (.abs "w" (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "")) "x" (.var "x") = .ok (.abs "z" (.var "")) := rfl
example : substitute (.abs "z" (.var "")) "x" (.var "y") = .ok (.abs "z" (.var "")) := rfl
example : substitute (.abs "z" (.var "")) "x" (.var "u") = .ok (.abs "z" (.var "")) := rfl
example : substitute (.abs "z" (.var "")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "")) "y" (.var "x") = .ok (.abs "z" (.var "")) := rfl
example : substitute (.abs "z" (.var "")) "y" (.var "y") = .ok (.abs "z" (.var "")) := rfl
example : substitute (.abs "z" (.var "")) "y" (.var "u") = .ok (.abs "z" (.var "")) := rfl
example : substitute (.abs "z" (.var "")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "x")) "x" (.var "x") = .ok (.abs "z" (.var "x")) := rfl
example : substitute (.abs "z" (.var "x")) "x" (.var "y") = .ok (.abs "z" (.var "y")) := rfl
example : substitute (.abs "z" (.var "x")) "x" (.var "u") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "x")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "x")) "y" (.var "x") = .ok (.abs "z" (.var "x")) := rfl
example : substitute (.abs "z" (.var "x")) "y" (.var "y") = .ok (.abs "z" (.var "x")) := rfl
example : substitute (.abs "z" (.var "x")) "y" (.var "u") = .ok (.abs "z" (.var "x")) := rfl
example : substitute (.abs "z" (.var "x")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "y")) "x" (.var "x") = .ok (.abs "z" (.var "y")) := rfl
example : substitute (.abs "z" (.var "y")) "x" (.var "y") = .ok (.abs "z" (.var "y")) := rfl
example : substitute (.abs "z" (.var "y")) "x" (.var "u") = .ok (.abs "z" (.var "y")) := rfl
example : substitute (.abs "z" (.var "y")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "y")) "y" (.var "x") = .ok (.abs "z" (.var "x")) := rfl
example : substitute (.abs "z" (.var "y")) "y" (.var "y") = .ok (.abs "z" (.var "y")) := rfl
example : substitute (.abs "z" (.var "y")) "y" (.var "u") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "y")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "u")) "x" (.var "x") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "u")) "x" (.var "y") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "u")) "x" (.var "u") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "u")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "u")) "y" (.var "x") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "u")) "y" (.var "y") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "u")) "y" (.var "u") = .ok (.abs "z" (.var "u")) := rfl
example : substitute (.abs "z" (.var "u")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "v")) "x" (.var "x") = .ok (.abs "z" (.var "v")) := rfl
example : substitute (.abs "z" (.var "v")) "x" (.var "y") = .ok (.abs "z" (.var "v")) := rfl
example : substitute (.abs "z" (.var "v")) "x" (.var "u") = .ok (.abs "z" (.var "v")) := rfl
example : substitute (.abs "z" (.var "v")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "v")) "y" (.var "x") = .ok (.abs "z" (.var "v")) := rfl
example : substitute (.abs "z" (.var "v")) "y" (.var "y") = .ok (.abs "z" (.var "v")) := rfl
example : substitute (.abs "z" (.var "v")) "y" (.var "u") = .ok (.abs "z" (.var "v")) := rfl
example : substitute (.abs "z" (.var "v")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "w")) "x" (.var "x") = .ok (.abs "z" (.var "w")) := rfl
example : substitute (.abs "z" (.var "w")) "x" (.var "y") = .ok (.abs "z" (.var "w")) := rfl
example : substitute (.abs "z" (.var "w")) "x" (.var "u") = .ok (.abs "z" (.var "w")) := rfl
example : substitute (.abs "z" (.var "w")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "w")) "y" (.var "x") = .ok (.abs "z" (.var "w")) := rfl
example : substitute (.abs "z" (.var "w")) "y" (.var "y") = .ok (.abs "z" (.var "w")) := rfl
example : substitute (.abs "z" (.var "w")) "y" (.var "u") = .ok (.abs "z" (.var "w")) := rfl
example : substitute (.abs "z" (.var "w")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "z")) "x" (.var "x") = .ok (.abs "z" (.var "z")) := rfl
example : substitute (.abs "z" (.var "z")) "x" (.var "y") = .ok (.abs "z" (.var "z")) := rfl
example : substitute (.abs "z" (.var "z")) "x" (.var "u") = .ok (.abs "z" (.var "z")) := rfl
example : substitute (.abs "z" (.var "z")) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "z" (.var "z")) "y" (.var "x") = .ok (.abs "z" (.var "z")) := rfl
example : substitute (.abs "z" (.var "z")) "y" (.var "y") = .ok (.abs "z" (.var "z")) := rfl
example : substitute (.abs "z" (.var "z")) "y" (.var "u") = .ok (.abs "z" (.var "z")) := rfl
example : substitute (.abs "z" (.var "z")) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "x" (.var "x") = .ok (.abs "y" (.abs "u" (.var "y"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "x" (.var "y") = .ok (.abs "u" (.abs "u" (.var "u"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "x" (.var "u") = .ok (.abs "y" (.abs "v" (.var "y"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "y" (.var "x") = .ok (.abs "y" (.abs "u" (.var "y"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "y" (.var "y") = .ok (.abs "y" (.abs "u" (.var "y"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "y" (.var "u") = .ok (.abs "y" (.abs "u" (.var "y"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "y"))) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.abs "u" (.var "y"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "x" (.var "x") = .ok (.abs "y" (.abs "u" (.var "x"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "x" (.var "y") = .ok (.abs "u" (.abs "u" (.var "y"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "x" (.var "u") = .ok (.abs "y" (.abs "v" (.var "u"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .error "StopIteration" := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "y" (.var "x") = .ok (.abs "y" (.abs "u" (.var "x"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "y" (.var "y") = .ok (.abs "y" (.abs "u" (.var "x"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "y" (.var "u") = .ok (.abs "y" (.abs "u" (.var "x"))) := rfl
example : substitute (.abs "y" (.abs "u" (.var "x"))) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.abs "u" (.var "x"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "x" (.var "x") = .ok (.abs "y" (.app (.var "x") (.var "u"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "x" (.var "y") = .ok (.abs "v" (.app (.var "y") (.var "u"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "x" (.var "u") = .ok (.abs "y" (.app (.var "u") (.var "u"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "x" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.app (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) (.var "u"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "y" (.var "x") = .ok (.abs "y" (.app (.var "x") (.var "u"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "y" (.var "y") = .ok (.abs "y" (.app (.var "x") (.var "u"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "y" (.var "u") = .ok (.abs "y" (.app (.var "x") (.var "u"))) := rfl
example : substitute (.abs "y" (.app (.var "x") (.var "u"))) "y" (.app (.var "u") (.app (.var "v") (.app (.var "w") (.var "z")))) = .ok (.abs "y" (.app (.var "x") (.var "u"))) := rfl
#eval "PASS: {\"free\": 756, \"rename\": 432, \"substitution\": 864}"
