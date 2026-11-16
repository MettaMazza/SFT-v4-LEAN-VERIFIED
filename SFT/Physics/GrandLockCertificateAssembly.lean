import SFT.Physics.GrandLockCertificate
namespace SFT.Physics.GrandLockCertificateAssembly
open SFT.Host SFT.Host.Canonical UnifiedConstantsFoundation UnifiedConstantsCertificate GrandLockVector GrandLockHeadline GrandLockCertificate
open RunningConvergenceMeasurement (sameValue)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem assemble (record dependency current reconstructed successor : Value) (changed names : List String)
 (hd : GrandLockDependency.dependencyCertificate record = .ok dependency)
 (hc : currentHeadlineVector.map fieldsValue = .ok current)
 (hr : (generatorValueVector (.integer 3)).map fieldsValue = .ok reconstructed)
 (hs : (generatorValueVector (.integer 4)).map fieldsValue = .ok successor)
 (hp : GrandLockProbe.sourceProbe = .ok (changed,names)) :
 GrandLockCertificate.theoremCertificate record = (
 let eqSet := changed.all (fun n=>GrandLockDependency.member n names) && names.all (fun n=>GrandLockDependency.member n changed)
 Except.ok (.object [
 ("dependency",dependency),("current_vector",current),
 ("reconstructed_vector",reconstructed),("successor_vector",successor),
 ("current_cross_lock",.boolean (sameValue (current) (reconstructed))),
 ("all_declared_generator_dependent_values_move",.boolean eqSet),
 ("generator_independent_values_hold",.boolean (sameValue (fieldsValue held) (fieldsValue [("binary_fibre",.fraction LeptonIntervals.half),("space_rank",.count 3),("boundary_rank",.count 2)]))),
 ("changed_value_count",.integer (.ofNat changed.length)),
 ("cross_domain_identity_graph",graphValue),
 ("cross_domain_graph_complete",.boolean (crossDomainIdentityGraph.all (fun (_,v)=> !v.isEmpty))),
 ("separate_normalized_cosmic_value_retained",.boolean (sameValue (RunningConvergenceCertificate.rat VacuumDensity.normalizedCosmologicalConstant) (RunningConvergenceCertificate.rat (LeptonIntervals.normalize 33 16 (by decide)))))])) := by
 unfold GrandLockCertificate.theoremCertificate
 rewrite [hd, hc, hr, hs, hp]
 rfl
#print axioms assemble
end SFT.Physics.GrandLockCertificateAssembly
