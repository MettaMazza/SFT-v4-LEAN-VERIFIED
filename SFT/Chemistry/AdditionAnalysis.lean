import SFT.Chemistry.AdditionHistory
namespace SFT.Chemistry.AdditionAnalysis
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
open ConformerAnalysis (array)
abbrev J := Canonical.Value
structure FileReceipt where
 path : String
 present : Bool
 bytes : Nat
 hash : String
structure Input where
 identityDocument : J
 preseal : J
 inventory : J
 selection : J
 selectionSeal : J
 comparison : J
 historyV5 : J
 historyV6 : J
 historyV8 : J
 queryV7 : String
 priorIdentitiesPresent : List Bool
 files : List FileReceipt
 selectionHash : String
 inventoryHash : String
 selectionSealHash : String
 presealHash : String
 analyzerHash : String
 comparisonHash : String
def inventoryAnalysis (input : Input) : Except String (List J) := do
 let inventory := input.inventory
 let rows ← field inventory "rows" >>= array
 if !equal (get inventory "complete_payload_count") (.integer 48) ||
  !equal (get inventory "complete_payload_bytes") (.integer 12993815) ||
  !equal (get inventory "all_payloads_opened_only_after_v9_seal") (.boolean true) ||
  !equal (get inventory "source_recapture_count") (.integer 0) || rows.length != 48 then
  throw "ORG-009 V9 inventory boundary changed"
 let _ ← rows.mapM fun row => do
  let path ← field row "opened_snapshot_path" >>= text
  if !equal (get row "capture_status") (.text "captured_once_after_v9_seal") then
   throw "ORG-009 V9 payload custody changed"
  let r ← match input.files.find? (fun r => Text.equal r.path path) with
   | none => throw "ORG-009 V9 payload custody changed"
   | some r => pure r
  if !r.present then throw "ORG-009 V9 payload custody changed"
  if !equal (.integer (.ofNat r.bytes)) (← field row "opened_snapshot_bytes") then
   throw "ORG-009 V9 payload custody changed"
  if !equal (.text r.hash) (← field row "opened_snapshot_sha256") then
   throw "ORG-009 V9 payload custody changed"
  pure ()
 return rows
def rowIdentity (row : J) : Except String J := do
 let tokens ← field row "independent_label_tokens" >>= array
 return .array [← field row "reaction_id",← field row "config",← field row "row_ordinal",.array tokens]
def distinct (xs : List J) : Bool :=
 (xs.foldl (fun acc x => if acc.any (equal x) then acc else x::acc) []).length == xs.length
def productCheck (source result : J) (productRows correspondences : List J) : Except String Bool := do
 if !equal (get result "reaction_status") (.text "favorable") || productRows.length != 1 then return false
 if !(productRows.all fun row => equal (get row "status") (.text "favorable")) then return false
 if !(productRows.all fun row => equal (get row "complete_element_preserving_bijection_count") (.integer 4)) then return false
 if correspondences.length != 4 then return false
 if !(← correspondences.allM fun row => do return (← field row "new_cross_adjacencies" >>= array).length == 2) then return false
 if !(← correspondences.allM fun row => do return (← field row "positive_finite_multiplicity_changes" >>= array).length == 3) then return false
 if !(← correspondences.allM fun row => do return distinct (← field row "azide_atom_mapping" >>= array)) then return false
 if !(← correspondences.allM fun row => do return distinct (← field row "alkyne_atom_mapping" >>= array)) then return false
 return ConjugatedSupportControls.truthy (← field source "independent_label_tokens")
def analysis (input : Input) (selectedOverride outcomesOverride : Option (List J) := none) : Except String (J × List (String × Bool)) := do
 let inventoryRows ← inventoryAnalysis input
 let selected ← match selectedOverride with
  | none => field input.selection "selected_in_payload_and_row_order" >>= array
  | some rows => pure rows
 let outcomes ← match outcomesOverride with
  | none => field input.comparison "results_in_frozen_order" >>= array
  | some rows => pure rows
 if selected.length != 28 || outcomes.length != 28 then throw "ORG-009 requires every one of the 28 source-selected reactions"
 let conditions := [
  equal (get input.identityDocument "parquet_payload_open_count_before_v9_seal") (.integer 0),
  equal (get input.identityDocument "all_v1_through_v8_results_must_remain_preserved") (.boolean true),
  equal (get input.preseal "ord_reaction_rows_or_products_opened_before_v9_seal") (.boolean false),
  equal (get input.selection "product_outcomes_opened_before_selection_seal") (.boolean false),
  equal (get input.selection "complete_payload_count") (.integer 48),
  equal (get input.selection "complete_conventional_reaction_count") (.integer 131209),
  equal (get input.selection "independently_labeled_selected_count") (.integer 28),
  equal (get input.selection "structural_but_unlabeled_count") (.integer 0),
  equal (get input.selectionSeal "selection_sha256") (.text input.selectionHash),
  equal (get input.comparison "source_inventory_sha256") (.text input.inventoryHash),
  equal (get input.comparison "source_selection_sha256") (.text input.selectionHash),
  equal (get input.comparison "source_selection_seal_sha256") (.text input.selectionSealHash),
  equal (get input.comparison "prediction_seal_sha256") (.text input.presealHash),
  equal (get input.comparison "comparison_program_sha256") (.text "sha256:9fc5c9942d320806164b2a9c8b4076e6dc6309207e18ad968a50df1d2e97af61"),
  Text.equal input.analyzerHash "sha256:9fc5c9942d320806164b2a9c8b4076e6dc6309207e18ad968a50df1d2e97af61",
  equal (get input.comparison "complete_selected_reaction_count") (.integer 28),
  equal (get input.comparison "reaction_status_counts") (.object [("adverse",.integer 0),("favorable",.integer 28),("unresolved",.integer 0)]),
  equal (get input.comparison "no_post_outcome_filter_applied") (.boolean true),
  equal (get input.comparison "no_selected_reaction_omitted") (.boolean true),
  Text.equal input.comparisonHash "sha256:ae8b152f09ebdd07e068890f0bff121d6dcfe189f57b6999ea79a6c22f29f96c"]
 if !conditions.all id then throw "ORG-009 V9 registration, custody or complete result changed"
 let selectedIdentity ← selected.mapM rowIdentity
 let outcomeIdentity ← outcomes.mapM rowIdentity
 if !equal (.array selectedIdentity) (.array outcomeIdentity) then throw "ORG-009 selected reaction identity or order changed"
 let details ← (selected.zip outcomes).mapM fun (source,result) => do
  let productRows ← field result "complete_product_identifier_comparisons" >>= array
  let valid ← productRows.mapM fun row => field row "valid_correspondences" >>= array
  let correspondences := valid.flatten
  let exact ← productCheck source result productRows correspondences
  return (productRows.length,correspondences.length,exact)
 let checks := details.zipIdx |>.map fun (row,i) =>
  let n := toString (i+1)
  let padded := if i+1<10 then Text.append "00" n else if i+1<100 then Text.append "0" n else n
  (Text.append "SFT-CHEM-ORG-009-ORD-REACTION-" padded,row.2.2)
 if !(checks.all Prod.snd) then throw "ORG-009 exact product-vector reconstruction failed"
 let history ← AdditionHistory.history input.historyV5 input.historyV6 input.historyV8 input.queryV7 input.priorIdentitiesPresent
 let statuses ← outcomes.mapM fun r => field r "reaction_status"
 let vector ← outcomes.mapM fun row => do return Canonical.Value.array [← field row "reaction_id",← field row "reaction_status"]
 let value : J := .object [
  ("registered_non_uspto_payload_count",.integer (.ofNat inventoryRows.length)),
  ("registered_non_uspto_payload_bytes",← field input.inventory "complete_payload_bytes"),
  ("complete_conventional_reaction_count",← field input.selection "complete_conventional_reaction_count"),
  ("source_selected_reaction_count",.integer (.ofNat selected.length)),
  ("favorable_reaction_count",.integer (.ofNat (statuses.filter (equal (.text "favorable"))).length)),
  ("adverse_reaction_count",.integer (.ofNat (statuses.filter (equal (.text "adverse"))).length)),
  ("unresolved_reaction_count",.integer (.ofNat (statuses.filter (equal (.text "unresolved"))).length)),
  ("complete_product_identifier_count",.integer (.ofNat (details.foldl (fun n r => n+r.1) 0))),
  ("complete_valid_correspondence_count",.integer (.ofNat (details.foldl (fun n r => n+r.2.1) 0))),
  ("complete_selected_identity_hash",.text (Canonical.identity (.array selectedIdentity))),
  ("complete_result_vector_hash",.text (Canonical.identity (.array vector))),
  ("v1_through_v8_preserved_adverse_history",history),("source_recapture_count",← field input.inventory "source_recapture_count"),
  ("post_outcome_filter_applied",.boolean false)]
 return (value,checks)
end SFT.Chemistry.AdditionAnalysis
