import SFT.Computation.NativeCircuit
namespace SFT.Computation.NativeCircuitCensus
open NativeCircuit
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000

def selectedEdges (mask : Nat) : List Edge :=
 ((forcedEdges 3).zipIdx.filter (fun row => (mask / 2^row.2)%2==1)).map Prod.fst

def subsetAdmitted (mask : Nat) : Bool :=
 (forcedEdges 3).all (fun edge => (selectedEdges mask).contains edge)

def survivorMasks : List Nat := (List.range (2^14)).filter subsetAdmitted

theorem originalFourteenEdges : (forcedEdges 3).length=14 := rfl

theorem completeSubsetCensus : survivorMasks=[16383] := by decide
end SFT.Computation.NativeCircuitCensus
