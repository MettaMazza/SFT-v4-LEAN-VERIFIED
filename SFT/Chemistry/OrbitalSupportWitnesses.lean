import SFT.Chemistry.OrbitalSupport
namespace SFT.Chemistry.OrbitalSupportWitnesses
open SFT.Host SFT.Physics.CapabilityValues OrbitalSupport
def sigmaPair := occupiedSupportFromSourceAssignment "H2" ⟨1,by decide⟩ "σ" ⟨2,by decide⟩
def sigmaSingle := occupiedSupportFromSourceAssignment "H2+" ⟨1,by decide⟩ "σ" ⟨1,by decide⟩
def piSingle := occupiedSupportFromSourceAssignment "H2-excited" ⟨2,by decide⟩ "π" ⟨1,by decide⟩
def phases := joinedPhasePair "molecule" ⟨1,by decide⟩ ElectronCountSpin.structuralEmpty
def witness0 : Bool :=
 match phases with
 | .error _ => false
 | .ok cells => match cells with
   | [] => false
   | a::rest => match rest with
     | [] => false
     | b::tail => match tail with
       | [] => !(ElectronCountSpin.sameLabel a.molecularCarrier b.molecularCarrier && sameCoordinate a b)
       | _::_ => false
def witness1 : Bool :=
 match sigmaPair,piSingle with
 | .ok a,.ok b => sameRank a.cell.axisRecurrence ElectronCountSpin.structuralEmpty && sameRank b.cell.axisRecurrence (.count ⟨1,by decide⟩)
 | .error _,.ok _ | .ok _,.error _ | .error _,.error _ => false
def witness2 : Bool :=
 match sigmaSingle,sigmaPair with
 | .ok a,.ok b => a.electronOccurrences.length==1 && b.electronOccurrences.length==2
 | .error _,.ok _ | .ok _,.error _ | .error _,.error _ => false
def witness3 : Bool :=
 match occupiedSupportFromSourceAssignment "tampered" ⟨1,by decide⟩ "σ" ⟨3,by decide⟩ with
 | .error _ => true
 | .ok _ => false
def sameSpinTrial : Except String OccupiedMolecularSupport := do
 let cells ← phases
 let cell ← match cells with | [] => .error "IndexError" | head::_ => .ok head
 let one ← heldLabel "electron-occurrence" "one"
 let two ← heldLabel "electron-occurrence" "two"
 let a ← heldLabel "electron-spin" "fibre-a"
 validOccupied ⟨cell,[one,two],[a,a]⟩
def witness4 : Bool := match sameSpinTrial with | .error _ => true | .ok _ => false
theorem joiningPhasePairPassed : witness0 = true := rfl
theorem axisBoundaryAndSuccessorPassed : witness1 = true := rfl
theorem singleAndPairOccupationPassed : witness2 = true := rfl
theorem tripleOccupationRejected : witness3 = true := rfl
theorem sameSpinRejected : witness4 = true := rfl
end SFT.Chemistry.OrbitalSupportWitnesses
