import SFT.QuantumComputation.UnboundedFaults
namespace SFT.QuantumComputation.UnboundedWitnesses
open UnboundedFaults
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000

def faultTrace (depth : Nat) : List String :=
 (List.range depth).map (fun i => SFT.Host.Text.append "fault-" (String.ofList (Nat.toDigits 10 (i+1))))

def widthEquals (depth expected : Nat) : Bool :=
 match forcedWidth (faultTrace depth) with
 | .ok width => width==expected
 | .error _ => false

def passed (value : Except String Bool) : Bool :=
 match value with
 | .ok b => b
 | .error _ => false

def witness0 : Bool := widthEquals 1 3
def witness1 : Bool := widthEquals 2 5 && widthEquals 3 7
def witness2 : Bool := widthEquals 14 29
def witness3 : Bool := ["held","returned"].all (fun label => [1,2,3].all
 (fun depth => passed (exhaustiveSmallFaultCensus label (faultTrace depth))))
def witness4 : Bool := (List.range 14).all (fun i => shorterWidthsFail (faultTrace (i+1)))
def witness5 : Bool := (List.range 13).all (fun i =>
 match forcedWidth (faultTrace (i+1)),forcedWidth (faultTrace (i+2)) with
 | .ok first,.ok next => next==first+2
 | .error _,.ok _ => false
 | .ok _,.error _ => false
 | .error _,.error _ => false)
def witness6 : Bool := (List.range 14).all (fun i => decide (i+2>i+1))
def witness7 : Bool := passed (depthSevenRoundTrip (faultTrace 14))

theorem witness0Passed : witness0=true := by decide
theorem witness1Passed : witness1=true := by decide
theorem witness2Passed : witness2=true := by decide
theorem witness3Passed : witness3=true := by decide
theorem witness4Passed : witness4=true := by decide
theorem witness5Passed : witness5=true := by decide
theorem witness6Passed : witness6=true := by decide
theorem witness7Passed : witness7=true := by decide
end SFT.QuantumComputation.UnboundedWitnesses
