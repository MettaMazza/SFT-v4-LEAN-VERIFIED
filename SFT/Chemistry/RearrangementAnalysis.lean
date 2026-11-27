import SFT.Chemistry.EliminationAnalysis
import SFT.Chemistry.HtmlUnescapeLinear
namespace SFT.Chemistry.RearrangementAnalysis
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
 firstAnalysis : J
 molecularDefinition : J
 stageDefinition : J
 aliasText : String
 rawPages : List String
 files : List FileReceipt
 analysisHash : String
 inventoryHash : String
abbrev payloadHash := CrossPropertyMolecularVectorSource.canonicalPayloadHash
def textHash (s : String) : String := Text.append "sha256:" (SHA256Streaming.digest s.toUTF8)
def normalizedPage (s : String) : String :=
 HtmlUnescapeLinear.normalizeSpace (String.ofList ((Text.chars s).filter fun c => c.toNat != 173))
def integer : J → Except String Int
 | .integer n => .ok n
 | .null | .text _ | .boolean _ | .array _ | .object _ => .error "page ordinal must be an integer"
def pageAt (pages : List String) (ordinal : J) : Except String String := do
 let n ← integer ordinal
 let i := n-1
 let i := if i<0 then Int.ofNat pages.length+i else i
 if i<0 then throw "tuple index out of range"
 match MolecularGraphEnumeration.atIndex pages i.toNat with
 | none => throw "tuple index out of range"
 | some s => pure s
def pad2 (n : J) : Except String String := do
 let i ← integer n
 let s := Canonical.render (.integer i)
 return if (@decide (0≤i) (Int.decLe _ _)) && (@decide (i<10) (Int.decLt _ _)) then Text.append "0" s else s
def definition (doc : J) : Except String String := do
 let rows ← field (← field doc "term") "definitions" >>= array
 let texts ← rows.mapM fun row => field row "text" >>= text
 return HalfReactionOrientationAnalysis.casefold (Text.intercalate " " texts)
def pairPassed (pages : List String) (row : J) : Except String Bool := do
 let sourcePage ← pageAt pages (← field row "source_characterization_page")
 let productPage ← pageAt pages (← field row "product_characterization_page")
 let enumerated ← field row "independently_enumerated_source_formula"
 if !equal (← field row "independently_enumerated_product_formula") enumerated then return false
 if !equal (← field row "source_atom_inventory") (← field row "product_atom_inventory") then return false
 if !equal (← field row "formula_pair_status") (.text "favorable_identical_exact_endpoint_atom_inventory") then return false
 if !equal (← field row "complete_source_product_structure_pair_drawn") (.boolean true) then return false
 if !equal (← field row "positive_constitutional_incidence_change_drawn") (.boolean true) then return false
 if equal (← field row "source_structure_relation") (← field row "product_structure_relation") then return false
 if !equal (← field row "printed_formulae_consistent_with_structure_enumeration") (.boolean true) then return false
 if !equal (← field row "mass_inscriptions_cross_check_enumeration") (.boolean true) then return false
 let sourceMass ← field row "source_mass_inscription" >>= text
 if !Text.contains (HalfReactionOrientationAnalysis.casefold sourcePage) (HalfReactionOrientationAnalysis.casefold sourceMass) then return false
 let productMass ← field row "product_mass_inscription" >>= text
 if !Text.contains (HalfReactionOrientationAnalysis.casefold productPage) (HalfReactionOrientationAnalysis.casefold productMass) then return false
 if !equal (← field row "source_page_text_sha256") (.text (textHash sourcePage)) then return false
 return equal (← field row "product_page_text_sha256") (.text (textHash productPage))
def pairCheck (pages : List String) (row : J) : Except String (String × Bool) := do
 let passed ← pairPassed pages row
 return (Text.append "SFT-CHEM-ORG-011-CLAISEN-PAIR-" (← field row "ordinal" >>= pad2),passed)
def optimizationPassed (pages : List String) (row : J) : Except String Bool := do
 let ordinal ← field row "page"
 if !equal (← field row "complete_page_text") (.text (← pageAt pages ordinal)) then return false
 if !equal (← field row "complete_page_text_sha256") (.text (textHash (← pageAt pages ordinal))) then return false
 if !(truthy (← field row "signed_stereochemical_inscriptions_preserved")) then return false
 if !equal ordinal (.integer 3) then return true
 return truthy (← field row "explicit_non_detection_preserved")
def optimizationCheck (pages : List String) (row : J) : Except String (String × Bool) := do
 let ordinal ← field row "page"
 let passed ← optimizationPassed pages row
 return (Text.append "SFT-CHEM-ORG-011-OPTIMIZATION-" (← pad2 ordinal),passed)
def expectedTargets : List String :=
 ["SFT-CHEM-ORG-011-IUPAC-MOLECULAR","SFT-CHEM-ORG-011-IUPAC-REARRANGEMENT","SFT-CHEM-ORG-011-IUPAC-STAGE"] ++
 (List.range 8).map (fun n => Text.append "SFT-CHEM-ORG-011-CLAISEN-PAIR-0" (toString (n+1))) ++
 ["SFT-CHEM-ORG-011-OPTIMIZATION-03","SFT-CHEM-ORG-011-OPTIMIZATION-04","SFT-CHEM-ORG-011-TRANSITION-RELATION","SFT-CHEM-ORG-011-FIRST-BLIND-SURFACE","SFT-CHEM-ORG-011-COMPLETE-SUPPLEMENT"]
def analysis (input : Input) (pairRows : Option (List J) := none) : Except String (J × List (String × Bool)) := do
 if !Text.equal input.analysisHash "sha256:2e200b570d0a407ef960fc02e0cd203d73f970af0c666fe5478f930385ef1a27" ||
  !Text.equal input.inventoryHash "sha256:7a66799333f95fe3ae35f060d2b7f1e81a01d4a41112d4dd159f6a513a66f11c" then
  throw "ORG-011 analysis or custody inventory changed"
 let a := input.analysisDocument
 let pairs ← match pairRows with
  | some rows => pure rows
  | none => field a "explicit_claisen_source_product_pairs_in_source_order" >>= array
 let fields ← match a with
  | .object fs => pure fs
  | .null | .text _ | .integer _ | .boolean _ | .array _ => throw "ORG-011 result vector changed"
 let recordedHash := get a "complete_result_vector_sha256"
 if !equal recordedHash (.text (payloadHash (.object (fields.filter fun p => !Text.equal p.1 "complete_result_vector_sha256")))) then
  throw "ORG-011 result vector changed"
 if pairs.length != 8 then throw "ORG-011 observation order, pair boundary or custody changed"
 let ordinals ← pairs.mapM fun row => field row "ordinal"
 if !equal (.array ordinals) (.array ((List.range 8).map fun n => .integer (.ofNat (n+1)))) ||
  !equal (get input.identityDocument "supplementary_pdf_open_count_before_seal") (.integer 0) ||
  !equal (get input.preseal "new_supplementary_pdf_pages_characterization_structures_formulas_or_spectra_opened_before_this_seal") (.boolean false) ||
  !equal (get input.preseal "external_target_content_used_by_candidate_generator_or_eliminator") (.boolean false) ||
  !equal (get input.inventory "source_recapture_count") (.integer 0) ||
  !equal (get input.inventory "capture_status") (.text "captured_once_after_claim_specific_v2_seal") ||
  !equal (get input.inventory "snapshot_sha256") (.text "sha256:c4720e6f02dfe930c2b0b45630e8b6a8f15b95108f0285fcfc35e30a0a0d9ca3") then
  throw "ORG-011 observation order, pair boundary or custody changed"
 let pages := input.rawPages.map normalizedPage
 let vector := pages.zipIdx.map fun (s,i) => Canonical.Value.object [
  ("page",.integer (.ofNat (i+1))),("text_character_count",.integer (.ofNat (Text.chars s).length)),
  ("text_sha256",.text (textHash s)),("has_extracted_text",.boolean (!s.isEmpty))]
 if pages.length != 38 || !equal (.array vector) (← field a "complete_page_text_vector") ||
  !equal (.text (payloadHash (.array vector))) (← field a "complete_page_text_vector_sha256") then
  throw "ORG-011 complete 38-page reconstruction changed"
 let molecular ← definition input.molecularDefinition
 let stage ← definition input.stageDefinition
 let alias := HalfReactionOrientationAnalysis.casefold input.aliasText
 let iupacChecks := [("SFT-CHEM-ORG-011-IUPAC-MOLECULAR",["change of connectivity","product is isomeric with the reactant","claisen rearrangement"].all (Text.contains molecular)),
  ("SFT-CHEM-ORG-011-IUPAC-REARRANGEMENT",["molecular rearrangement","change of","connectivity"].all (Text.contains alias)),
  ("SFT-CHEM-ORG-011-IUPAC-STAGE",["making and breaking of bonds","atoms common to a reactant"].all (Text.contains stage))]
 let pairChecks ← pairs.mapM (pairCheck pages)
 let optimizationChecks ← (← field a "optimization_and_control_pages" >>= array).mapM (optimizationCheck pages)
 let transition ← field a "transition_relation"
 let fragments ← field transition "required_fragments" >>= array
 let transitionOk ← fragments.allM fun v => do
  let fragment ← text v
  let page ← pageAt pages (.integer 37)
  return Text.contains (HalfReactionOrientationAnalysis.casefold page) (HalfReactionOrientationAnalysis.casefold fragment)
 let v1 := get input.firstAnalysis "comparison_status"
 let v1Ok := equal (get (get a "first_blind_surface") "preserved_without_relabelling") (.boolean true) &&
  equal (get v1 "complete_atom_support_pairs_favorable") (.integer 0) &&
  equal (get v1 "complete_atom_support_pairs_adverse") (.integer 0) &&
  equal (get v1 "complete_atom_support_pairs_unresolved") (.integer 52) &&
  equal (get v1 "blind_supplement_does_not_by_itself_close_the_registered_exact_structure_vector") (.boolean true)
 let custody := get a "custody"
 let custodyOk := equal (get custody "pdf_page_count") (.integer 38) && equal (get custody "all_pages_retained") (.boolean true) &&
  equal (get a "pair_count") (.integer 8) && equal (get a "exact_endpoint_inventory_favorable_count") (.integer 8) &&
  equal (get a "exact_endpoint_inventory_adverse_count") (.integer 0) && equal (get a "exact_endpoint_inventory_unresolved_count") (.integer 0) &&
  equal (get a "drawn_positive_constitutional_incidence_change_count") (.integer 8) &&
  equal (get (get a "comparison_status") "no_yield_selectivity_formula_or_favorable_result_filter_applied") (.boolean true)
 let checks := iupacChecks ++ pairChecks ++ optimizationChecks ++ [("SFT-CHEM-ORG-011-TRANSITION-RELATION",transitionOk),("SFT-CHEM-ORG-011-FIRST-BLIND-SURFACE",v1Ok),("SFT-CHEM-ORG-011-COMPLETE-SUPPLEMENT",custodyOk)]
 if !equal (.array ((checks.map Prod.fst).map Canonical.Value.text)) (.array (expectedTargets.map Canonical.Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append "ORG-011 complete target comparison changed: " (ConformerAnalysis.headerRepr ((checks.filter fun p => !p.2).map Prod.fst)))
 return (.object [("supplementary_pdf_page_count",.integer 38),("explicit_source_product_pair_count",.integer 8),
  ("exact_endpoint_inventory_favorable_count",.integer 8),("exact_endpoint_inventory_adverse_count",.integer 0),("exact_endpoint_inventory_unresolved_count",.integer 0),
  ("positive_constitutional_incidence_change_count",.integer 8),("optimization_control_page_count",.integer 2),
  ("first_blind_surface_preserved_unresolved",.boolean true),("complete_result_vector_sha256",recordedHash)],checks)
end SFT.Chemistry.RearrangementAnalysis
