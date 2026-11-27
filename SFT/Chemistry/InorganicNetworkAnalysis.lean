import SFT.Chemistry.InorganicNetworkSource
import SFT.Chemistry.InorganicNetworkWitnesses
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.InorganicNetworkAnalysis
open SFT.Host InorganicNetwork InorganicNetworkWitnesses
open JointCorrelationTargets (field text)
open InorganicNetworkPrediction (get equal)
abbrev J := Canonical.Value

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 15 then throw "INORG-017 requires all fifteen external surfaces"
 let a ← acid
 let an ← acidNetwork
 let o ← oxidation
 let r ← reduction
 let rn ← redoxNetwork
 let e ← extended
 let post ← field primary "exact_postseal_analysis"
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let uniqueSources := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 let custody ← rows.mapM (fun row => field row "custody_class" >>= text)
 return .object [
 ("acid_base_species_count",.integer (.ofNat an.species.length)),("acid_base_step_count",.integer (.ofNat an.path.length)),
 ("lewis_pair_occurrence_count",.integer (.ofNat a.pair.length)),("adduct_retained",.boolean (an.species.any (InorganicColour.sameLabel a.adduct))),
 ("redox_species_count",.integer (.ofNat rn.species.length)),("redox_transfer_count",.integer (.ofNat o.electrons.length)),
 ("reverse_same_transfer_support",.boolean (DefectChemistry.sameLabels r.electrons o.electrons)),
 ("reverse_endpoints_swapped",.boolean (InorganicColour.sameLabel r.donor o.acceptor && InorganicColour.sameLabel r.acceptor o.donor)),
 ("extended_species_count",.integer (.ofNat e.species.length)),("extended_step_count",.integer (.ofNat e.path.length)),
 ("missing_species_rejected",.boolean speciesWitness),
 ("complete_target_count",.integer (.ofNat rows.length)),("complete_source_count",.integer (.ofNat uniqueSources.length)),
 ("development_observed_target_count",.integer (.ofNat (custody.filter (Text.equal "family-development-observed")).length)),
 ("identity_only_unopened_target_count",.integer (.ofNat (custody.filter (Text.equal "family-identity-only-unopened")).length)),
 ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
 ("rendered_structure_absence_count",← field post "rendered_structure_absence_count"),
 ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
 ("source_recapture_count",← field post "source_recapture_count"),("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.InorganicNetworkAnalysis
