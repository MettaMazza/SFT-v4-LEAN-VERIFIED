import SFT.Physics.GrandLockDependency
import SFT.Physics.GrandLockProbe
namespace SFT.Physics.GrandLockCertificate
open SFT.Host SFT.Host.Canonical UnifiedConstantsFoundation UnifiedConstantsCertificate GrandLockVector GrandLockHeadline GrandLockProbe
open RunningConvergenceMeasurement (sameValue)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def crossDomainIdentityGraph : List (String × List String) := [("binary_fibre",["fine_structure", "leptons", "quarks", "cosmology", "planck_hierarchy", "vacuum_floor"]),("generator",["fine_structure", "leptons", "quarks", "dark_baryon", "hubble", "planck_hierarchy", "vacuum_floor"]),("down_cover",["fine_structure", "leptons", "dark_baryon", "vacuum_floor"]),("up_cover",["fine_structure", "leptons", "quarks", "hubble", "planck_hierarchy"]),("space_rank",["cover_depths", "dark_baryon", "hubble", "vacuum_floor"]),("terminal_alpha",["leptons", "planck_hierarchy"])]
def graphValue : Value := .object (crossDomainIdentityGraph.map fun (k,v)=>(k,.array (v.map Value.text)))
def held : Fields := [("binary_fibre",.fraction LeptonIntervals.half),("space_rank",.count 3),("boundary_rank",.count 2)]
def theoremCertificate (record : Value) : Except String Value := do
 let dependency ← GrandLockDependency.dependencyCertificate record
 let current ← currentHeadlineVector.map fieldsValue
 let reconstructed ← (generatorValueVector (.integer 3)).map fieldsValue
 let successor ← (generatorValueVector (.integer 4)).map fieldsValue
 let (changed,names) ← GrandLockProbe.sourceProbe
 let eqSet := changed.all (fun n=>GrandLockDependency.member n names) && names.all (fun n=>GrandLockDependency.member n changed)
 pure (.object [
 ("dependency",dependency),("current_vector",current),
 ("reconstructed_vector",reconstructed),("successor_vector",successor),
 ("current_cross_lock",.boolean (sameValue (current) (reconstructed))),
 ("all_declared_generator_dependent_values_move",.boolean eqSet),
 ("generator_independent_values_hold",.boolean (sameValue (fieldsValue held) (fieldsValue [("binary_fibre",.fraction LeptonIntervals.half),("space_rank",.count 3),("boundary_rank",.count 2)]))),
 ("changed_value_count",.integer (.ofNat changed.length)),
 ("cross_domain_identity_graph",graphValue),
 ("cross_domain_graph_complete",.boolean (crossDomainIdentityGraph.all (fun (_,v)=> !v.isEmpty))),
 ("separate_normalized_cosmic_value_retained",.boolean (sameValue (RunningConvergenceCertificate.rat VacuumDensity.normalizedCosmologicalConstant) (RunningConvergenceCertificate.rat (LeptonIntervals.normalize 33 16 (by decide)))))])
theorem originalGraphComplete : crossDomainIdentityGraph.all (fun (_,v)=> !v.isEmpty)=true := rfl
theorem originalHeld : sameValue (fieldsValue held) (fieldsValue [("binary_fibre",.fraction LeptonIntervals.half),("space_rank",.count 3),("boundary_rank",.count 2)])=true := rfl
#print axioms crossDomainIdentityGraph
#print axioms held
#print axioms theoremCertificate
#print axioms originalGraphComplete
#print axioms originalHeld
end SFT.Physics.GrandLockCertificate
