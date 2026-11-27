import SFT.Chemistry.NucleophilicAnalysis
import SFT.Chemistry.ConjugatedSupportControls
namespace SFT.Chemistry.ElectrophilicAnalysis
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
open NucleophilicAnalysis (outcome)
abbrev J := Canonical.Value
-- The ordered page text is supplied by the original external PdfReader boundary.
def definition (rows : List J) (id : String) : Except String String := do
 let term ← field (← outcome rows id) "term"
 let defs ← field term "definitions" >>= ConformerAnalysis.array
 let texts ← defs.mapM fun d => match get d "text" with
  | .null => pure ""
  | .text s => pure s
  | .boolean _ | .integer _ | .array _ | .object _ => throw "definition text must be a string"
 return HalfReactionOrientationAnalysis.casefold (Text.intercalate " " texts)
def analysis (rows : List J) (primary : J) (pageTexts : List String) : Except String (J × List (String × Bool)) := do
 if rows.length != 4 then throw "ORG-008 requires all four rows"
 let a := match get primary "exact_postseal_analysis" with
  | .null => Canonical.Value.object []
  | .text s => .text s
  | .boolean b => .boolean b
  | .integer n => .integer n
  | .array xs => .array xs
  | .object fs => .object fs
 let e ← definition rows "SFT-CHEM-ORG-008-001"
 let s ← definition rows "SFT-CHEM-ORG-008-002"
 let article ← outcome rows "SFT-CHEM-ORG-008-003"
 let pdf ← outcome rows "SFT-CHEM-ORG-008-004"
 let length := pageTexts.foldl (fun n t => n+(Text.chars t).length) 0
 if !equal (.integer (.ofNat pageTexts.length)) (← field pdf "complete_pdf_page_count") ||
  !equal (.text (Canonical.identity (.array (pageTexts.map Canonical.Value.text)))) (← field pdf "complete_page_text_vector_hash") ||
  !equal (.integer (.ofNat length)) (← field pdf "complete_extracted_text_character_count") then
  throw "ORG-008 complete PDF reconstruction changed"
 let values ← match article with
  | .object fs => pure (fs.map Prod.snd)
  | .null | .text _ | .integer _ | .boolean _ | .array _ => throw "article outcome must be a dictionary"
 let fixed ← [("complete_pdf_page_count",452),("nonempty_extracted_page_count",452),("complete_table_s1_row_count",25),("displayed_zero_yield_or_zero_star_row_count",14),("displayed_full_yield_row_count",9)].mapM fun (key,n) => do
  return equal (← field pdf key) (.integer n)
 let flags ← ["EAS_like_ligand_coupling_present","C_electrophile_attacked_by_nucleophilic_phenol_present","dearomatized_intermediate_surface_present","rearomatization_surface_present","radical_control_preserved","phenoxonium_alternative_preserved","starting_material_recovered_control_preserved"].mapM fun key => do
  return ConjugatedSupportControls.truthy (← field pdf key)
 let ids ← rows.mapM fun row => field row "target_id" >>= text
 let checks := ids.zip [Text.contains e "accepting both bonding electrons",Text.contains s "relinquishes both electrons" && Text.contains s "electrofuge",values.all ConjugatedSupportControls.truthy,fixed.all id && flags.all id]
 let vector ← rows.mapM fun row => do return Canonical.Value.array [← field row "target_id",← field row "source_outcome"]
 if !(checks.all Prod.snd) || !equal (get a "complete_pdf_page_count") (.integer 452) || !equal (get a "complete_table_s1_row_count") (.integer 25) ||
  !equal (get a "complete_target_vector_hash") (.text (Canonical.identity (.array vector))) then throw "ORG-008 exact postseal analysis changed"
 return (a,checks)
end SFT.Chemistry.ElectrophilicAnalysis
