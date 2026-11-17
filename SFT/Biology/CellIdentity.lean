import SFT.Host.Text
namespace SFT.Biology.CellIdentity
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-CELL-001","Cell identity","cell_process","compartmented-living-process-carrier","integrated-maintenance-inheritance-relation","membrane-metabolism-and-lineage-held","cell-cycle-window-declared","A cell is the least compartmented living organization jointly retaining boundary, maintenance, hereditary continuation and regulated process integration."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.CellIdentity
