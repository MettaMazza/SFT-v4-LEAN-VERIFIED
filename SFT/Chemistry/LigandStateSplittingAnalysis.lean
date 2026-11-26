import SFT.Chemistry.LigandStateSplittingSource
import SFT.Chemistry.LigandStateSplittingWitnesses
namespace SFT.Chemistry.LigandStateSplittingAnalysis
open SFT.Host SFT.Physics.CapabilityValues LigandStateSplitting
open JointCorrelationTargets (field text)
open LigandStateSplittingPrediction (get equal)
abbrev J := Canonical.Value
def array : J → List J
 | .array xs => xs
 | .null | .text _ | .integer _ | .boolean _ | .object _ => []
def fractionText (p : Part) : String :=
 if p.denominator.value==1 then toString p.numerator.value
 else Text.intercalate "/" [toString p.numerator.value,toString p.denominator.value]
def distanceText (d : Distance) : Except String J := match d with
 | .absent => throw "balance distance has no value"
 | .part p => pure (.text (fractionText p))
def definition (row : J) : Except String String := do
 let outcome := get row "source_outcome"
 match outcome with
 | .object fields => match fields.find? (fun p => Text.equal p.1 "definition") with
   | none => pure ""
   | some pair => LigandStateSplittingPrediction.identityText (.object [pair]) "definition"
 | .null | .text _ | .integer _ | .boolean _ | .array _ => throw "source outcome must be a mapping"
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 32 then throw "INORG-006 requires all 32 source surfaces"
 let six ← sixResult
 let four ← fourResult
 let removed ← LigandStateSplitting.removed (← heldLabel "coordination-central-occurrence" "validation-centre")
 let supports ← generated
 let postseal ← field primary "exact_postseal_analysis"
 let blind := rows.filter fun row => equal (get row "custody_class") (.text "law-sealed-blind") &&
  equal (get (get row "source_outcome") "payload_class") (.text "complete-uv-visible-spectrum")
 let adverse := rows.filter fun row => equal (get (get row "source_outcome") "surface_class") (.text "linked-spectrum-absence")
 let ancillary := rows.filter fun row => equal (get (get row "source_outcome") "payload_class") (.text "captured-non-spectrum-ancillary")
 let definitions ← (rows.filter fun row => equal (get row "authority") (.text "IUPAC")).mapM definition
 let iupac := Text.intercalate " " definitions
 let counts ← blind.mapM fun row => do
  let maxima ← field (get row "source_outcome") "complete_interior_local_maxima"
  pure (Canonical.Value.integer (.ofNat (array maxima).length))
 let positions ← blind.mapM fun row => do
  let maxima ← field (get row "source_outcome") "complete_interior_local_maxima"
  pure (Canonical.Value.array (← (array maxima).mapM fun peak => field peak "x"))
 let separations ← blind.mapM fun row => field (get row "source_outcome") "adjacent_interior_maximum_separations"
 let distinguishable := !blind.isEmpty && counts.all (fun n => match n with
  | .integer (.ofNat n) => n>=2
  | .integer (.negSucc _) | .null | .text _ | .boolean _ | .array _ | .object _ => false)
 let widths := fun (s : Splitting) => Canonical.Value.array (s.levels.map fun l => .integer (.ofNat l.members.length))
 let remerged := removed.levels.length==1 &&
  match removed.levels with
  | [] => false
  | level::_ => level.members.length==5 &&
   match level.rank with | .absent => true | .positive _ => false
 return .object [
  ("generated_support_count",.integer (.ofNat supports.length)),
  ("six_multiplicity_vector",widths six),
  ("six_separation_vector",.array (six.separations.map fun p => .text (fractionText p))),
  ("six_balance_vector",.array [← distanceText six.lower,← distanceText six.upper]),
  ("four_multiplicity_vector",widths four),
  ("four_separation_vector",.array (four.separations.map fun p => .text (fractionText p))),
  ("four_balance_vector",.array [← distanceText four.lower,← distanceText four.upper]),
  ("all_members_preserved",.boolean (six.completeMemberPreservation && four.completeMemberPreservation)),
  ("removal_remerges_one_five_member_class",.boolean remerged),
  ("iupac_removal_of_degeneracy_surface_present",.boolean (Text.contains iupac "removal of a degeneracy")),
  ("iupac_ligand_attachment_reduced_symmetry_surface_present",.boolean (Text.contains iupac "attachment or removal of ligands" && Text.contains iupac "reduced symmetries")),
  ("iupac_conventional_variable_parameter_surface_preserved_as_downstream",.boolean (Text.contains iupac "parameters as variables")),
  ("blind_spectrum_payload_count",.integer (.ofNat blind.length)),
  ("blind_complete_interior_maximum_counts",.array counts),
  ("blind_exact_interior_peak_positions",.array positions),
  ("blind_exact_adjacent_peak_separations",.array separations),
  ("blind_distinguishability_condition_passed",.boolean distinguishable),
  ("law_sealed_adverse_absence_count",.integer (.ofNat adverse.length)),
  ("development_ancillary_count",.integer (.ofNat ancillary.length)),
  ("complete_32_rows_preserved",← field postseal "all_32_rows_preserved"),
  ("no_dimensional_wavelength_fitted_or_claimed",← field postseal "no_dimensional_wavelength_fitted_or_claimed")]
end SFT.Chemistry.LigandStateSplittingAnalysis
