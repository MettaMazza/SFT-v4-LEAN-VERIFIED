import SFT.Chemistry.MolecularElectronicState
namespace SFT.Chemistry.MolecularElectronicWitnesses
open MolecularElectronicState SFT.Physics.CapabilityValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def spinA : HeldLabel := ⟨"electron-spin","fibre-a",by rfl,by rfl⟩
def spinB : HeldLabel := ⟨"electron-spin","fibre-b",by rfl,by rfl⟩
def joined : HeldLabel := ⟨"molecular-electronic-support","joined-region",by rfl,by rfl⟩
def separated : HeldLabel := ⟨"molecular-electronic-support","separated-region",by rfl,by rfl⟩
def signatureA : HeldLabel := ⟨"molecular-electronic-state","state-a",by rfl,by rfl⟩
def signatureB : HeldLabel := ⟨"molecular-electronic-state","state-b",by rfl,by rfl⟩
def originalA : State := ⟨"molecule-one",["electron-one","electron-two"],[spinA,spinB],[("electron-one",joined),("electron-two",joined)],signatureA⟩
def originalB : State := ⟨"molecule-one",["electron-one","electron-two"],[spinA,spinB],[("electron-one",separated),("electron-two",separated)],signatureB⟩
def incomplete : State := {originalA with jointSupport := [("electron-one",joined)], observationSignature:=⟨"molecular-electronic-state","incomplete",by rfl,by rfl⟩}
theorem originalAAdmitted : valid originalA=.ok originalA := rfl
theorem originalBAdmitted : valid originalB=.ok originalB := rfl
theorem originalCount : (electronicCount originalA).map PositiveCount.value=.ok 2 := rfl
theorem originalDistinction : distinguishableElectronicStates originalA originalB=.ok true := rfl
theorem incompleteRejected : valid incomplete=.error "joint support must contain every electron occurrence exactly once" := rfl
#print axioms originalAAdmitted
#print axioms originalBAdmitted
#print axioms originalCount
#print axioms originalDistinction
#print axioms incompleteRejected
end SFT.Chemistry.MolecularElectronicWitnesses
