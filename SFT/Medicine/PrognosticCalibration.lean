import SFT.Host.Text
namespace SFT.Medicine.PrognosticCalibration
structure Obligation where
 claimId : String
 title : String
 family : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-MED-PROGNOSTIC-CALIBRATION-001","Prognostic calibration","risk_prognosis_outcome","predicted-and-observed-risk-groups","prediction-observation-incidence","complete-calibration-table","new-population-and-time-window","Calibration compares predeclared risk groups with every observed outcome row in a distinct population and interval without post-outcome retuning."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Medicine.PrognosticCalibration
