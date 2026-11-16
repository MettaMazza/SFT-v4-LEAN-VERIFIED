import SFT.Chemistry.MolecularRovibronicState
import SFT.Chemistry.MolecularElectronicWitnesses
namespace SFT.Chemistry.MolecularRovibronicWitnesses
open MolecularRovibronicState SFT.Physics.CapabilityValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def ground : HeldLabel := ⟨"molecular-electronic-state","ground-state",by rfl,by rfl⟩
def electronic : MolecularElectronicState.State := ⟨"homonuclear-hydrogen-carrier",["electron-one","electron-two"],[MolecularElectronicWitnesses.spinA,MolecularElectronicWitnesses.spinB],[("electron-one",MolecularElectronicWitnesses.joined),("electron-two",MolecularElectronicWitnesses.joined)],ground⟩
def protium : HeldLabel := ⟨"molecular-isotope","protium",by rfl,by rfl⟩
def deuteriumLabel : HeldLabel := ⟨"molecular-isotope","deuterium",by rfl,by rfl⟩
def singlet : HeldLabel := ⟨"molecular-spin-state","singlet",by rfl,by rfl⟩
def hydrogen : State := ⟨electronic,["nucleus-one","nucleus-two"],[protium,protium],⟨1,by decide⟩,⟨1,by decide⟩,singlet,⟨"molecular-rovibronic-observation","h2-ground-row",by rfl,by rfl⟩⟩
def deuterium : State := {hydrogen with isotopeLabels := [deuteriumLabel,deuteriumLabel], observationRecord := ⟨"molecular-rovibronic-observation","d2-ground-row",by rfl,by rfl⟩}
def incomplete : State := {hydrogen with isotopeLabels := [protium], observationRecord := ⟨"molecular-rovibronic-observation","incomplete",by rfl,by rfl⟩}
theorem electronicAdmitted : MolecularElectronicState.valid electronic = .ok electronic := rfl
theorem hydrogenAdmitted : valid hydrogen = .ok hydrogen := rfl
theorem deuteriumAdmitted : valid deuterium = .ok deuterium := rfl
theorem hydrogenVibration : (vibrationalRecurrence hydrogen).map PositiveCount.value = .ok 1 := rfl
theorem hydrogenRotation : (rotationalRecurrence hydrogen).map PositiveCount.value = .ok 2 := rfl
theorem originalIsotopeDistinction : isotopologueDistinguishable hydrogen deuterium = .ok true := rfl
theorem incompleteRejected : valid incomplete = .error "every nuclear occurrence requires one isotope label" := rfl
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool :=
 match (do
  let v ← (vibrationalRecurrence hydrogen).map PositiveCount.value
  let r ← (rotationalRecurrence hydrogen).map PositiveCount.value
  pure (v==1 && r==2) : Except String Bool) with
 | .ok b=>b
 | .error _=>false

def witness1 : Bool := match isotopologueDistinguishable hydrogen deuterium with | .ok b=>b | .error _=>false
def witness2 : Bool := match valid incomplete with | .error _=>true | .ok _=>false
theorem witness0Passed : witness0=true := rfl
theorem witness1Passed : witness1=true := rfl
theorem witness2Passed : witness2=true := rfl
def witnesses : List Witness := [⟨"exact-positive-recurrence","The first positive vibration and rotation coordinates generate exact positive carriers.",witness0⟩,⟨"isotopologue-distinction","Changing retained nuclear isotope labels changes the joint molecular state while preserving its electronic carrier class.",witness1⟩,⟨"incomplete-nuclear-support-control","A missing isotope label rejects rather than being silently supplied.",witness2⟩]
#print axioms electronicAdmitted
#print axioms hydrogenAdmitted
#print axioms deuteriumAdmitted
#print axioms hydrogenVibration
#print axioms hydrogenRotation
#print axioms originalIsotopeDistinction
#print axioms incompleteRejected
#print axioms witness0Passed
#print axioms witness1Passed
#print axioms witness2Passed
end SFT.Chemistry.MolecularRovibronicWitnesses
