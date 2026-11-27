import SFT.Chemistry.AromaticRecurrenceDerivation
import SFT.Physics.FoldFirstReturn
namespace SFT.Chemistry.AromaticRecurrenceWitnesses
open SFT.Host SFT.Physics.CapabilityValues AromaticRecurrence

def centres : Except String (List String) := do
 let n ← SFT.Physics.FoldFirstReturn.generatorPeriod
 return (List.range (n*2)).map (fun i => Text.append "centre-" (toString (i+1)))
def base : Except String Recurrence := do aromaticRecurrence "carrier" (← centres) ⟨1,by decide⟩
def successor : Except String Recurrence := do appendLayer (← base)
def secondSuccessor : Except String Recurrence := do appendLayer (← successor)
def baseWitness : Bool := match base with | .error _ => false | .ok r => supportSize r==6
def successorWitness : Bool := match successor,secondSuccessor with
 | .ok a,.ok b => supportSize a==10 && supportSize b==14
 | .error _,.error _ | .error _,.ok _ | .ok _,.error _ => false
def returnWitness : Bool := match base with
 | .error _ => false
 | .ok r => match firstReturnTrace r with
  | .error _ => false
  | .ok trace => match trace,trace.reverse with
   | a::_,b::_ => MulticentreSupport.sameLabel a b && trace.length==r.cycle.centres.length+1
   | [],[] | [],_::_ | _::_,[] => false
def closureWitness : Bool := match base with | .error _ => false | .ok r => perturbationClosure r
def stabilityWitness : Bool := match (do aromaticStability (← base)) with | .error _ => false | .ok s => closedPrecedes s
def incompleteWitness : Bool := match base with
 | .error _ => false
 | .ok r => match recurrence r.carrier r.cycle r.boundary [completeCells.take 3] with
  | .error _ => true | .ok _ => false
def openPathWitness : Bool := match aromaticRecurrence "invalid" ["left","right"] ⟨1,by decide⟩ with
 | .error _ => true | .ok _ => false
def zeroWitness : Bool := match count 0 with | .error _ => true | .ok _ => false
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000
theorem basePassed : baseWitness=true := by decide
theorem successorPassed : successorWitness=true := by decide
theorem returnPassed : returnWitness=true := by decide
theorem closurePassed : closureWitness=true := by decide
theorem stabilityPassed : stabilityWitness=true := by decide
theorem incompletePassed : incompleteWitness=true := by decide
theorem openPathPassed : openPathWitness=true := by decide
theorem zeroPassed : zeroWitness=true := by decide
end SFT.Chemistry.AromaticRecurrenceWitnesses
