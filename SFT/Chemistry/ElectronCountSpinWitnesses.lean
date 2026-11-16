import SFT.Chemistry.ElectronCountSpinDerivation
import SFT.Chemistry.ElectronCountSpin
namespace SFT.Chemistry.ElectronCountSpinWitnesses
open SFT.Chemistry.ElectronCountSpin SFT.Physics.CapabilityValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def carbon : NuclearPopulation := ⟨⟨"element-symbol","C",rfl,rfl⟩,⟨6,by decide⟩,⟨1,by decide⟩⟩
def oxygen : NuclearPopulation := ⟨⟨"element-symbol","O",rfl,rfl⟩,⟨8,by decide⟩,⟨1,by decide⟩⟩
def neutral : HeldChargeTransfer := ⟨⟨"electron-transfer","empty-One",rfl,rfl⟩,structuralEmpty⟩
def adjoin : HeldChargeTransfer := ⟨⟨"electron-transfer","adjoin-electron",rfl,rfl⟩,.count ⟨1,by decide⟩⟩
def coCount : Except String PositiveCount := exactElectronCount [carbon,oxygen] neutral
def oxygenAnionCount : Except String PositiveCount := exactElectronCount [{oxygen with occurrenceCount := ⟨2,by decide⟩}] adjoin
def co : Except String Organization := do buildCompleteSpinOrganization "CO" (← coCount) ⟨1,by decide⟩
def oxygenAnion : Except String Organization := do buildCompleteSpinOrganization "O2-" (← oxygenAnionCount) ⟨2,by decide⟩
def doubledFibre : SpinCell := ⟨⟨"electron-support-cell","tampered",rfl,rfl⟩,
 [⟨"electron-spin","fibre-a",rfl,rfl⟩,⟨"electron-spin","fibre-a",rfl,rfl⟩]⟩
def witness0 : Bool := match co with | .ok x => x.electronCount.value==14 | .error _ => false
def witness1 : Bool := match oxygenAnion with | .ok x => x.electronCount.value==17 | .error _ => false
def witness2 : Bool := match (do
 let a ← co
 let b ← oxygenAnion
 pure (a.cells.length==7 && b.cells.length==9) : Except String Bool) with
 | .ok b => b
 | .error _ => false
def witness3 : Bool := match validCell doubledFibre with | .error _ => true | .ok _ => false
def witness4 : Bool := match buildCompleteSpinOrganization "tampered" ⟨14,by decide⟩ ⟨2,by decide⟩ with
 | .error _ => true
 | .ok _ => false
theorem carbonAdmitted : validPopulation carbon = .ok carbon := rfl
theorem oxygenAdmitted : validPopulation oxygen = .ok oxygen := rfl
theorem neutralAdmitted : validTransfer neutral = .ok neutral := rfl
theorem adjoinAdmitted : validTransfer adjoin = .ok adjoin := rfl
theorem coCountForced : coCount.map PositiveCount.value = .ok 14 := rfl
theorem oxygenAnionCountForced : oxygenAnionCount.map PositiveCount.value = .ok 17 := rfl
theorem witness0Passed : witness0=true := rfl
theorem witness1Passed : witness1=true := rfl
theorem witness2Passed : witness2=true := rfl
theorem witness3Passed : witness3=true := rfl
theorem witness4Passed : witness4=true := rfl
#print axioms coCountForced
#print axioms oxygenAnionCountForced
#print axioms witness0Passed
#print axioms witness1Passed
#print axioms witness2Passed
#print axioms witness3Passed
#print axioms witness4Passed
end SFT.Chemistry.ElectronCountSpinWitnesses
