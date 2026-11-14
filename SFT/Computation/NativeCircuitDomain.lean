import SFT.Computation.NativeCircuit
namespace SFT.Computation.NativeCircuitDomain
open NativeCircuit

def admittedResources (depth : Int) : Except String (Nat × Nat × Nat) :=
 match depth with
 | .ofNat 0 => .error "depth must be a supplied positive finite host count"
 | .negSucc _ => .error "depth must be a supplied positive finite host count"
 | .ofNat (n+1) => .ok (circuitResources (n+1))

theorem exactAdmittedResources (n : Nat) :
 admittedResources (.ofNat (n+1))=.ok (n+1,2^(n+1),layeredCount (n+1)) :=
 congrArg Except.ok (exactResources (n+1))
end SFT.Computation.NativeCircuitDomain
