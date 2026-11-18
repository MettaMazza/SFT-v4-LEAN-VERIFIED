import SFT.Host.Text
namespace SFT.Medicine.Dose
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-DOSE-001","Dose","dose_exposure_response_adverse_event","administered-substance-or-action","amount-per-declared-carrier-and-time","unit-route-formulation-schedule","delivered-and-received-record","Dose is an exact positive finite relation among amount, recipient carrier, formulation, route and schedule; no universal effect follows from dose alone."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.Dose
