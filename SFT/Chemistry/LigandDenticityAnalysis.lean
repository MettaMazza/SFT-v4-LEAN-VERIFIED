import SFT.Chemistry.LigandDenticity
import SFT.Chemistry.CoordinationNumberAnalysis
namespace SFT.Chemistry.LigandDenticityAnalysis
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationNumberPrediction (equal)
open LigandDenticity
abbrev J := Canonical.Value
-- Distinct source fixture names from the validation module, preserved literally.
def validationEntity (width : Nat) : Except String CoordinationEntity.Entity := do
 let central ← heldLabel "coordination-central-occurrence" "M-one"
 let group ← heldLabel "coordination-ligand-group" "given-ligand"
 let rows ← (List.range width).mapM fun i => do
  let n := i+1
  CoordinationEntity.attachment (← count n) central
   (← heldLabel "coordination-ligand-occurrence" (Text.append "donor-" (toString n))) group
   (← heldLabel "positive-coordination-incidence" (Text.append "edge-" (toString n)))
 CoordinationEntity.construct (← heldLabel "coordination-entity" (Text.append "entity-" (toString width)))
  (← heldLabel "coordination-central-element" "M") central rows

def validationTopology (e : CoordinationEntity.Entity) (width : Option Nat := none) : Except String Topology := do
 let rows := match width with
  | none => e.orderedAttachments
  | some n => e.orderedAttachments.take n
 let internalConnections ← (List.range (rows.length-1)).mapM fun i =>
  heldLabel "positive-ligand-internal-incidence" (Text.intercalate "" ["path-",toString (i+1),"-",toString (i+2)])
 construct ⟨← heldLabel "coordination-ligand-carrier-occurrence" "ligand-one",
  ← heldLabel "coordination-ligand-group" "given-ligand",e.centralOccurrence,
  rows.map CoordinationEntity.Attachment.ligandOccurrence,
  rows.map CoordinationEntity.Attachment.attachmentTrace,internalConnections⟩

def pyAnd (a b : J) : J := if CoordinationAnalysis.truthy a then b else a

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 24 || !CoordinationNumberPrediction.completeOrdinals 1 rows then
  throw "INORG-003 requires all 24 source records"
 let twoEntity ← validationEntity 2
 let threeEntity ← validationEntity 3
 let two ← forced twoEntity (← validationTopology twoEntity)
 let oneEntity ← validationEntity 1
 let one ← forced oneEntity (← validationTopology oneEntity)
 let successor ← appendSite threeEntity (← validationTopology threeEntity (some 2))
  (← heldLabel "coordination-ligand-occurrence" "donor-3")
  (← heldLabel "positive-coordination-incidence" "edge-3")
  (← heldLabel "positive-ligand-internal-incidence" "path-2-3")
 let source ← field primary "exact_postseal_topology_analysis"
 let authorities ← rows.mapM fun row => field row "authority" >>= text
 let iupac := (authorities.filter (Text.equal · "IUPAC")).length
 return .object [
  ("complete_registered_target_count",.integer (.ofNat rows.length)),
  ("source_class_census",.object [("IUPAC",.integer (.ofNat iupac))]),
  ("source_class_census_matches",.boolean (authorities.all (Text.equal · "IUPAC"))),
  ("positive_denticity_two_reconstructed",.boolean (two.denticity.value == 2)),
  ("single_site_open_topology_reconstructed",.boolean (Text.equal one.state.label "single-site-open-topology" && one.closedTrace.isEmpty)),
  ("first_multiple_site_closed_topology_reconstructed",.boolean (Text.equal two.state.label "multiple-separate-sites-one-ligand-one-centre-closed-topology" && two.closedTrace.length == 3)),
  ("successor_preserves_prior_and_adds_one",.boolean successor),
  ("all_six_complete_current_term_records_retained",← field source "all_six_complete_current_term_records_retained"),
  ("denticity_given_ligand_same_central_count_retained",← field source "denticity_given_ligand_same_central_count_retained"),
  ("chelation_separate_sites_same_ligand_single_central_retained",← field source "chelation_separate_sites_same_ligand_single_central_retained"),
  ("first_multiple_site_threshold_retained",← field source "first_multiple_site_threshold_retained"),
  ("bidentate_example_and_single_site_exclusions_retained",pyAnd
   (← field source "bidentate_ethylenediamine_two_nitrogen_example_retained") (← field source "single_binding_site_nonchelate_exclusions_retained")),
  ("kappa_eta_and_scope_boundaries_retained",pyAnd (pyAnd
   (← field source "kappa_single_atom_attachment_count_retained") (← field source "eta_multi_atom_pi_support_boundary_retained"))
   (← field source "inorganic_and_biochemical_ligand_scope_boundary_retained")),
  ("complete_provenance_status_license_and_disclaimer_surface_retained",← field source "all_status_source_citation_license_and_disclaimer_surfaces_retained"),
  ("source_topologies_remain_postseal_evidence_only",.boolean (equal (← field primary "no_source_topology_or_classification_used_as_fold_proof_parameter") (.boolean true)))]
end SFT.Chemistry.LigandDenticityAnalysis
