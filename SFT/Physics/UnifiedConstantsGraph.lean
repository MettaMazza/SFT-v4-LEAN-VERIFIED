import SFT.Mathematics.GraphPathCompleteness
import SFT.Host.Text
namespace SFT.Physics.UnifiedConstantsGraph
open SFT.Mathematics.GraphOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 16000000
-- Exact parent-to-child incidence from unified_constants_object_law_v1.py.
def dependencyGraph : List (String × List String) := [("One",["Fold"]),
 ("Fold",["binary_fibre_count","generator_count"]),
 ("binary_fibre_count",["down_cover_depth","up_cover_depth","half_One"]),
 ("generator_count",["spatial_rank","lepton_sector","quark_sector","cosmic_partition"]),
 ("spatial_rank",["boundary_rank","down_cover_depth","up_cover_depth"]),
 ("boundary_rank",["fine_structure_sector","vacuum_sector"]),
 ("down_cover_depth",["fine_structure_sector","lepton_sector","dark_baryon_sector","vacuum_sector"]),
 ("up_cover_depth",["fine_structure_sector","quark_sector","hubble_sector","planck_sector"]),
 ("fine_structure_sector",["lepton_sector","quark_sector","planck_sector"]),
 ("cosmic_partition",["dark_baryon_sector","hubble_sector","vacuum_sector"])]
def edges : List Edge := dependencyGraph.flatMap fun (parent,children) => children.map fun child => (parent,child)
def addNode (nodes : List String) (node : String) : List String :=
 if nodes.any (SFT.Host.Text.equal node) then nodes else nodes++[node]
def nodes : List String := (dependencyGraph.flatMap fun (parent,children) => parent::children).foldl addNode []
def generatedGraph : Except String GeneratedGraph := makeGraph nodes edges
def sectorNodes : List String := ["dark_baryon_sector","fine_structure_sector","hubble_sector","lepton_sector","planck_sector","quark_sector","vacuum_sector"]
def reachableFromOne : Except String (List String) := do
 let graph ← generatedGraph
 .ok (nodes.filter fun node => reachable graph "One" node)
def allSectorsReachOne : Except String Bool := do
 let graph ← generatedGraph
 .ok (sectorNodes.all fun node => reachable graph "One" node)
def incomingCount (node : String) : Nat :=
 (dependencyGraph.filter fun (_,children) => children.any (SFT.Host.Text.equal node)).length
def sharedGeometry : Bool := sectorNodes.all fun node => 1≤incomingCount node

theorem exactGraphAccepted : generatedGraph = .ok ⟨nodes,edges⟩ := rfl
 theorem seventeenNodes : nodes.length=17 := rfl
theorem sectorReachable0 : reachable ⟨nodes,edges⟩ "One" "dark_baryon_sector" = true :=
 pathWitnessReachable ⟨nodes,edges⟩ "One" "dark_baryon_sector" ⟨["One","Fold","binary_fibre_count","down_cover_depth"],rfl,rfl⟩

theorem sectorReachable1 : reachable ⟨nodes,edges⟩ "One" "fine_structure_sector" = true :=
 pathWitnessReachable ⟨nodes,edges⟩ "One" "fine_structure_sector" ⟨["One","Fold","binary_fibre_count","down_cover_depth"],rfl,rfl⟩

theorem sectorReachable2 : reachable ⟨nodes,edges⟩ "One" "hubble_sector" = true :=
 pathWitnessReachable ⟨nodes,edges⟩ "One" "hubble_sector" ⟨["One","Fold","binary_fibre_count","up_cover_depth"],rfl,rfl⟩

theorem sectorReachable3 : reachable ⟨nodes,edges⟩ "One" "lepton_sector" = true :=
 pathWitnessReachable ⟨nodes,edges⟩ "One" "lepton_sector" ⟨["One","Fold","generator_count"],rfl,rfl⟩

theorem sectorReachable4 : reachable ⟨nodes,edges⟩ "One" "planck_sector" = true :=
 pathWitnessReachable ⟨nodes,edges⟩ "One" "planck_sector" ⟨["One","Fold","binary_fibre_count","up_cover_depth"],rfl,rfl⟩

theorem sectorReachable5 : reachable ⟨nodes,edges⟩ "One" "quark_sector" = true :=
 pathWitnessReachable ⟨nodes,edges⟩ "One" "quark_sector" ⟨["One","Fold","generator_count"],rfl,rfl⟩

theorem sectorReachable6 : reachable ⟨nodes,edges⟩ "One" "vacuum_sector" = true :=
 pathWitnessReachable ⟨nodes,edges⟩ "One" "vacuum_sector" ⟨["One","Fold","binary_fibre_count","down_cover_depth"],rfl,rfl⟩

theorem allSevenReachable : allSectorsReachOne=.ok true := by
 unfold allSectorsReachOne
 rw [exactGraphAccepted]
 change (Except.ok (reachable ⟨nodes,edges⟩ "One" "dark_baryon_sector" && (reachable ⟨nodes,edges⟩ "One" "fine_structure_sector" && (reachable ⟨nodes,edges⟩ "One" "hubble_sector" && (reachable ⟨nodes,edges⟩ "One" "lepton_sector" && (reachable ⟨nodes,edges⟩ "One" "planck_sector" && (reachable ⟨nodes,edges⟩ "One" "quark_sector" && (reachable ⟨nodes,edges⟩ "One" "vacuum_sector" && true))))))) : Except String Bool) = .ok true
 rw [sectorReachable0,sectorReachable1,sectorReachable2,sectorReachable3,sectorReachable4,sectorReachable5,sectorReachable6]
 rfl

 theorem everySectorHasIncoming : sharedGeometry=true := rfl
end SFT.Physics.UnifiedConstantsGraph
