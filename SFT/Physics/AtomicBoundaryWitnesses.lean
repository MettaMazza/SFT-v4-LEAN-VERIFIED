import SFT.Physics.AtomicBoundary
namespace SFT.Physics.AtomicBoundaryWitnesses
open SFT.Physics.AtomicBoundary
structure Witness where
 name : String
 statement : String
 passed : Bool

def endpointCheck : Bool := match atomicEndpoint with
 | .ok n => n == 137
 | .error _ => false

def sharpCheck : Bool := match AlphaRatio.inverseFineStructure none with
 | .ok p => 137*p.denominator <= p.numerator && p.numerator < 138*p.denominator
 | .error _ => false

def successorCheck : Bool := match AlphaRatio.inverseFineStructure none with
 | .ok p => ((List.range 22).map (fun n => n+138)).all (fun n => p.numerator<n*p.denominator)
 | .error _ => false

def witnesses : List Witness := [⟨"greatest-whole","Exact quotient/remainder forces the endpoint 137.",endpointCheck⟩,⟨"sharp-boundary","The endpoint is below and its immediate successor above the exact ratio.",sharpCheck⟩,⟨"successor-closure","Every sampled later successor remains above; the formal order certificate is depth-independent.",successorCheck⟩]
theorem endpointCheckPassed : endpointCheck=true := rfl
theorem sharpCheckPassed : sharpCheck=true := rfl
theorem successorCheckPassed : successorCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.AtomicBoundaryWitnesses
