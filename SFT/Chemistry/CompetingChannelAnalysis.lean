import SFT.Chemistry.CompetingChannel
import SFT.Chemistry.TransitionBoundaryAnalysis
namespace SFT.Chemistry.CompetingChannelAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open CompetingChannel
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev sourceFraction := ActivationBarrierAnalysis.sourceFraction
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
def sameFraction (a b : Rat) : Bool := @decide (a.num * .ofNat b.den = b.num * .ofNat a.den) (Int.decEq _ _)
structure RowAnalysis where
 channel : ProductChannelSupport
 experimental : Rat
 uncertainty : Rat
 calculation : Rat
def analyzeRow (row : InternalEnergyCompositionSource.Target) (ordinal : Nat) : Except String RowAnalysis := do
 let target := get row.row "target_payload"
 if !sameValue (get target "source_status") (.text "experimentally determined branching ratio with separately retained calculated comparison") ||
  !sameValue (get target "source_product_row") (.integer ordinal) then
  throw "KIN-006 target provenance or source order changed"
 let support ← field target "experimental_branching_exact_fraction_of_complete_support" >>= sourceFraction
 let uncertainty ← field target "experimental_uncertainty_exact_fraction" >>= sourceFraction
 let calculation ← field target "calculated_comparison_exact_fraction" >>= sourceFraction
 if !(@decide (0<support.num) (Int.decLt _ _)) || !(@decide (0<uncertainty.num) (Int.decLt _ _)) || !(@decide (0<calculation.num) (Int.decLt _ _)) then
  throw "KIN-006 external vector contains prohibited nonpositive magnitude"
 let percent ← field target "experimental_branching_percent_external_inscription" >>= sourceInteger
 if !sameFraction support (normalize percent 100 (by decide)) then throw "KIN-006 experimental exact fraction changed"
 let uncertaintyPercent ← field target "experimental_uncertainty_percent_external_inscription" >>= sourceInteger
 if !sameFraction uncertainty (normalize uncertaintyPercent 100 (by decide)) then throw "KIN-006 uncertainty exact fraction changed"
 let identity ← field target "product_channel_identity" >>= identityString >>= CapabilityValues.heldLabel "registered-product-channel"
 let ratio ← SolvationDissolution.positiveRatio support
 let ordinal ← CapabilityValues.count ordinal
 let channel ← makeChannel (.held identity) (.ratio ratio) (.count ordinal)
 pure ⟨channel,support,uncertainty,calculation⟩
structure Analysis where
 count : Nat
 supplementCount : Value
 pdfCount : Nat
 experimentalSum : Rat
 calculatedSum : Rat
 experimentalBounds : Rat×Rat
 uncertaintyBounds : Rat×Rat
 checks : List (String×Bool)
def sumRats (values : List Rat) : Rat := values.foldl add (normalize 0 1 (by decide))
def exactCompetingChannelAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 8 then throw "KIN-006 requires the complete eight-channel vector"
 let analyzed ← rows.zipIdx.mapM fun (row,i)=>analyzeRow row (i+1)
 let first ← match rows with | first::_=>pure first | []=>throw "KIN-006 requires the complete eight-channel vector"
 let reaction ← field first.row "reaction_identity" >>= identityString >>= CapabilityValues.heldLabel "registered-reaction"
 let condition ← field first.row "condition_identity" >>= identityString >>= CapabilityValues.heldLabel "held-condition"
 let record ← makeRecord (.held reaction) (.held condition) (analyzed.map fun a=>ChannelInput.channel a.channel)
 let relation ← forcedCompetingChannelBranching (.record record)
 let shares ← relation.orderedRows.mapM fun row=>match row.shareOfCompleteSupport with
  | .ratio r=>pure (ratioValue r)
  | .emptyOne | .otherEmptyOne _ | .invalid=>throw "'EmptyOne' object has no attribute 'fraction'"
 let experimental := analyzed.map RowAnalysis.experimental
 let uncertainties := analyzed.map RowAnalysis.uncertainty
 let calculated := analyzed.map RowAnalysis.calculation
 let experimentalBounds ← RealGasAnalysis.bounds experimental
 let uncertaintyBounds ← RealGasAnalysis.bounds uncertainties
 let shareBounds ← RealGasAnalysis.bounds shares
 let pdfs ← RunningConvergenceMeasurement.array (if hasKey primary "supplement_pdf_records" then get primary "supplement_pdf_records" else .array [])
 let files ← RunningConvergenceMeasurement.array (if hasKey primary "complete_supplementary_files" then get primary "complete_supplementary_files" else .array [])
 let identities := relation.orderedRows.map ExactBranchRow.channelIdentity
 pure ⟨rows.length,get primary "complete_supplementary_file_count",pdfs.length,sumRats experimental,sumRats calculated,experimentalBounds,uncertaintyBounds,[
  ("all_eight_source_rows_and_product_identities_retained",relation.orderedRows.length==8 && (relation.orderedRows.zipIdx.all fun (row,i)=>row.sourceRow.value==i+1) && (identities.foldl (fun found x=>if found.any (DihedralTorsion.equalLabel x) then found else found++[x]) []).length==8),
  ("forced_shares_match_complete_postseal_experimental_vector",shares.length==experimental.length && (shares.zip experimental).all fun (a,b)=>sameFraction a b),
  ("complete_channel_partition_reconstructs_One",sameFraction (sumRats shares) (normalize 1 1 (by decide))),
  ("weakest_and_all_unfavorable_channels_retained",sameFraction shareBounds.1 (normalize 3 50 (by decide)) && shares.length==8),
  ("complete_article_nineteen_files_and_two_pdfs_retained",sameValue (get primary "all_article_and_supplement_files_preserved") (.boolean true) && sameValue (get primary "complete_supplementary_file_count") (.integer 19) && files.length==19 && pdfs.length==2),
  ("experimental_calculated_and_analysis_provenance_separated",sameValue (get primary "experimental_and_calculated_columns_separated") (.boolean true) && sameValue (get primary "reference_spectrum_Monte_Carlo_and_analysis_disclosures_retained") (.boolean true)),
  ("no_imported_normalization_fit_selection_or_target_correction",sameValue (get primary "imported_probability_normalization_branching_equation_fitted_ratio_selection_renormalization_or_target_correction_used_in_fold_law") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false) && sameValue (get primary "image_curves_not_digitized_and_unreported_values_not_inferred") (.boolean true))]⟩
end SFT.Chemistry.CompetingChannelAnalysis
