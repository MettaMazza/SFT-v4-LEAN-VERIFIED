import SFT.Chemistry.AdditionAnalysis
import SFT.Chemistry.ActivationBarrierAnalysis
import SFT.Host.SHA256Streaming
import SFT.Chemistry.CrossPropertyMolecularVectorSource
namespace SFT.Chemistry.EliminationAnalysis
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
open ConformerAnalysis (array)
open ConjugatedSupportControls (truthy)
abbrev J := Canonical.Value
abbrev FileReceipt := AdditionAnalysis.FileReceipt
structure Input where
 analysisDocument : J
 inventory : J
 identityDocument : J
 preseal : J
 iupac : J
 pageTexts : List String
 files : List FileReceipt
 analysisHash : String
 inventoryHash : String

def upperAscii (s : String) : String := String.ofList ((Text.chars s).map fun c =>
 if 97≤c.toNat && c.toNat≤122 then Char.ofNat (c.toNat-32) else c)
def analysis (input : Input) (productRows unsuccessfulRows optimisationTables : Option (List J) := none)
 : Except String (J × List (String × Bool)) := do
 if !Text.equal input.analysisHash "sha256:157144f86339efa5ddb583d860ef1fd444af6761c3080a82465367544735b89b" ||
  !Text.equal input.inventoryHash "sha256:0d4204dfd4633dbc6ada89cd87cda76813c989f2444490547371d7aca64696de" then
  throw "ORG-010 complete analysis or inventory changed"
 let a := input.analysisDocument
 let products ← match productRows with
  | some rows => pure rows
  | none => field a "characterized_product_rows_in_source_order" >>= array
 let unsuccessful ← match unsuccessfulRows with
  | some rows => pure rows
  | none => field a "unsuccessful_substrate_rows" >>= array
 let optimisation ← match optimisationTables with
  | some rows => pure rows
  | none => field a "optimisation_tables" >>= array
 if products.length != 32 || unsuccessful.length != 5 || optimisation.length != 7 then
  throw "ORG-010 requires every product, unsuccessful row and optimization table"
 let codes := (Text.chars "abcdefghijklmnopqrstuvwxyz").map (fun c => Text.append "3" (String.ofList [c])) ++
  (Text.chars "abcdef").map (fun c => Text.append "3a" (String.ofList [c]))
 let productCodes ← products.mapM fun row => field row "product_code"
 if !equal (.array productCodes) (.array (codes.map Canonical.Value.text)) then
  throw "ORG-010 characterized product identity or source order changed"
 let unsuccessfulOrdinals ← unsuccessful.mapM fun row => field row "ordinal"
 if !equal (.array unsuccessfulOrdinals) (.array ((List.range 5).map fun n => .integer (.ofNat (n+1)))) then
  throw "ORG-010 unsuccessful-substrate order changed"
 let tableNames ← optimisation.mapM fun row => field row "table"
 if !equal (.array tableNames) (.array ((List.range 7).map fun n => .text (Text.append "S" (toString (n+1))))) then
  throw "ORG-010 optimization-table order changed"
 let fields ← match a with
  | .object fs => pure fs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => throw "ORG-010 result-vector identity changed"
 let recordedHash := get a "complete_result_vector_sha256"
 if !equal recordedHash (.text (CrossPropertyMolecularVectorSource.canonicalPayloadHash (.object (fields.filter fun p => !Text.equal p.1 "complete_result_vector_sha256")))) then
  throw "ORG-010 result-vector identity changed"
 let members := match get input.inventory "members" with
  | .array rows => rows
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 if !equal (get input.identityDocument "supplementary_archive_open_count_before_seal") (.integer 0) ||
  !equal (get input.preseal "supplementary_archive_product_structures_yields_spectra_or_complete_page_contents_opened_before_this_seal") (.boolean false) ||
  !equal (get input.preseal "external_target_content_used_by_candidate_generator_or_eliminator") (.boolean false) ||
  !equal (get input.inventory "source_recapture_count") (.integer 0) ||
  !equal (get input.inventory "capture_status") (.text "captured_once_after_claim_specific_seal") || members.length != 22 then
  throw "ORG-010 custody or observation order changed"
 let _ ← members.mapM fun member => do
  let path ← field member "snapshot_path" >>= text
  let error := Text.append "ORG-010 captured member changed: " (← field member "archive_member" >>= text)
  let receipt ← match input.files.find? (fun f => Text.equal f.path path) with
   | none => throw error
   | some row => pure row
  if !receipt.present then throw error
  if !equal (.integer (.ofNat receipt.bytes)) (← field member "snapshot_bytes") then throw error
  if !equal (.text receipt.hash) (← field member "snapshot_sha256") then throw error
  pure ()
 let pdf ← match members.find? (fun row => match get row "archive_member" with
  | .text s => (Text.chars ".pdf").reverse.isPrefixOf (Text.chars s).reverse
  | .null | .integer _ | .boolean _ | .array _ | .object _ => false) with
  | none => throw "StopIteration"
  | some row => pure row
 if !equal (← field pdf "snapshot_sha256") (.text "sha256:f274759e0f850ecefb14e4d685d78bcae2641284b366d74f2bd03b10a8459620") then
  throw "ORG-010 PDF identity changed"
 let pageVector := input.pageTexts.zipIdx.map fun (s,i) => Canonical.Value.object [
  ("page",.integer (.ofNat (i+1))),("text_character_count",.integer (.ofNat (Text.chars s).length)),
  ("text_sha256",.text (Text.append "sha256:" (SHA256Streaming.digest s.toUTF8))),("has_extracted_text",.boolean (SFT.Physics.CapabilityValues.nonblank s))]
 if input.pageTexts.length != 117 || !equal (.array pageVector) (← field a "complete_page_text_vector") ||
  !equal (.text (CrossPropertyMolecularVectorSource.canonicalPayloadHash (.array pageVector))) (← field a "complete_page_text_vector_sha256") then
  throw "ORG-010 complete PDF page reconstruction changed"
 let defs ← field (← field input.iupac "term") "definitions" >>= array
 let definitions ← defs.mapM fun d => field d "text" >>= text
 let definition := HalfReactionOrientationAnalysis.casefold (Text.intercalate " " definitions)
 let iupacOk := ["reverse of an addition","two groups","two different centres","formation of an unsaturation","1/1/elimination"].all (Text.contains definition)
 let productChecks ← products.mapM fun row => do
  let block ← field row "source_block" >>= text
  let hashOk := equal (.text (Text.append "sha256:" (SHA256Streaming.digest block.toUTF8))) (← field row "source_block_sha256")
  let code ← field row "product_code" >>= text
  let passed ← if !hashOk then pure false else if !(truthy (← field row "observable_unsaturation_in_reported_product_name")) then pure false
   else if !equal (← field row "full_reactant_byproduct_carrier_present_in_characterization_block") (.boolean false) then pure false
   else if !equal (← field row "complete_atom_and_support_balance_status") (.text "unresolved_in_this_conventional_product_block") then pure false
   else do
    let procedure ← field row "procedure"
    pure (["2.16","2.17"].any fun s => equal procedure (.text s))
  pure (Text.append "SFT-CHEM-ORG-010-PRODUCT-" (upperAscii code),passed)
 let unsuccessfulChecks ← unsuccessful.mapM fun row => do
  let ordinal ← match (← field row "ordinal") with
   | .integer (.ofNat n) => pure n
   | .integer (.negSucc _) | .null | .text _ | .boolean _ | .array _ | .object _ => throw "invalid unsuccessful ordinal"
  let label := toString ordinal
  let label := if ordinal<10 then Text.append "0" label else label
  let substrate ← field row "substrate"
  let passed ← if !truthy substrate then pure false else do
   pure (truthy (← field row "observed"))
  pure (Text.append "SFT-CHEM-ORG-010-UNSUCCESSFUL-" label,passed)
 let optimisationChecks ← optimisation.mapM fun table => do
  let name ← field table "table" >>= text
  let rows ← field table "rows" >>= array
  let expected ← match [("S1",3),("S2",5),("S3",8),("S4",6),("S5",4),("S6",4),("S7",4)].find? (fun p => Text.equal p.1 name) with
   | none => throw "unknown optimization table"
   | some p => pure p.2
  pure (Text.append "SFT-CHEM-ORG-010-OPTIMISATION-" name,rows.length == expected)
 let intermediate ← field a "observed_intermediate_record"
 let timeRows ← field intermediate "reported_time_course_rows" >>= array
 let productValues ← timeRows.mapM fun row => field row "3a_percent" >>= ActivationBarrierAnalysis.sourceFraction
 let intermediateValues ← timeRows.mapM fun row => field row "3a_prime_percent" >>= ActivationBarrierAnalysis.sourceFraction
 let less := fun (a b : Rat) => @decide (a.num * .ofNat b.den < b.num * .ofNat a.den) (Int.decLt _ _)
 let intermediateOk := timeRows.length == 6 && (productValues.zip productValues.tail).all (fun (a,b) => less a b) &&
  (intermediateValues.zip intermediateValues.tail).all (fun (a,b) => less b a) &&
  equal (get intermediate "reported_15_minute_GC_ratio") (.text "3a:3a-prime = 72:28")
 let custody ← field a "custody"
 let custodyOk := equal (get custody "archive_member_count") (.integer 22) && equal (get custody "pdf_page_count") (.integer 117) &&
  equal (get a "characterized_product_count") (.integer 32) && equal (get a "products_with_observable_unsaturation_count") (.integer 32) &&
  equal (get a "products_with_full_carrier_balance_in_characterization_block_count") (.integer 0) && equal (get a "unresolved_complete_carrier_balance_count") (.integer 32) &&
  equal (get a "optimisation_row_count_including_explicit_source_gap") (.integer 34) && equal (get a "unsuccessful_substrate_count") (.integer 5) &&
  equal (get (get a "comparison_status") "no_post_outcome_product_filter_applied") (.boolean true) &&
  equal (get (get a "comparison_status") "no_optimization_or_control_page_omitted") (.boolean true)
 let checks := [("SFT-CHEM-ORG-010-IUPAC-001",iupacOk)] ++ productChecks ++ unsuccessfulChecks ++ optimisationChecks ++
  [("SFT-CHEM-ORG-010-INTERMEDIATE-001",intermediateOk),("SFT-CHEM-ORG-010-COMPLETE-SUPPLEMENT-001",custodyOk)]
 let expectedTargets := ["SFT-CHEM-ORG-010-IUPAC-001"] ++ codes.map (fun c => Text.append "SFT-CHEM-ORG-010-PRODUCT-" (upperAscii c)) ++
  (List.range 5).map (fun n => Text.append "SFT-CHEM-ORG-010-UNSUCCESSFUL-0" (toString (n+1))) ++
  (List.range 7).map (fun n => Text.append "SFT-CHEM-ORG-010-OPTIMISATION-S" (toString (n+1))) ++
  ["SFT-CHEM-ORG-010-INTERMEDIATE-001","SFT-CHEM-ORG-010-COMPLETE-SUPPLEMENT-001"]
 if !equal (.array ((checks.map Prod.fst).map Canonical.Value.text)) (.array (expectedTargets.map Canonical.Value.text)) || !(checks.all Prod.snd) then
  throw "ORG-010 complete target comparison changed"
 let summary : J := .object [
  ("archive_member_count",.integer 22),("supplementary_pdf_page_count",.integer 117),
  ("characterized_product_count",.integer 32),("observable_unsaturation_product_count",.integer 32),
  ("full_carrier_favorable_count",.integer 0),("full_carrier_adverse_count",.integer 0),("full_carrier_unresolved_count",.integer 32),
  ("unsuccessful_or_low_elimination_row_count",.integer 5),("optimization_table_count",.integer 7),
  ("optimization_row_count_including_source_gap",.integer 34),("intermediate_time_course_row_count",.integer 6),
  ("complete_result_vector_sha256",recordedHash)]
 return (summary,checks)
end SFT.Chemistry.EliminationAnalysis
