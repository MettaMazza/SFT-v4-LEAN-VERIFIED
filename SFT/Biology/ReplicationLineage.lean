import SFT.Host.Text
namespace SFT.Biology.ReplicationLineage
structure Obligation where
 claimId : String
 title : String
 subbranch : String
 carrier : String
 relation : String
 organization : String
 observation : String
 statement : String
def original : Obligation := ⟨"SFT-BIO-REPLICATION-LINEAGE-001","Replication lineage","inheritance_replication","finite-predecessor-successor-graph","parent-child-generation-edges","branch-merger-and-sample-history-retained","depth-and-sampling-declared","A replication lineage is a finite directed predecessor-successor graph with every sampled branch, merger, missing observation and generation boundary explicit."⟩
def carrierWitness : Bool := !(SFT.Host.Text.equal original.carrier "")
def relationWitness : Bool := !(SFT.Host.Text.equal original.relation original.organization)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.observation original.relation)
theorem carrierWitnessPassed : carrierWitness = true := by rfl
theorem relationWitnessPassed : relationWitness = true := by rfl
theorem boundaryWitnessPassed : boundaryWitness = true := by rfl
end SFT.Biology.ReplicationLineage
