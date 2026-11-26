import SFT.Chemistry.TemperatureCorrespondenceSource
import SFT.Chemistry.InternalEnergyCompositionSource
namespace SFT.Chemistry.PhaseRuleAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics InternalEnergyCompositionExperiment
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
structure RowAnalysis where
 components : Nat
 emptyDegree : Bool
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let target := get row.row "target_payload"
 let components ← field target "component_count_external_inscription" >>= sourceInteger
 let phases ← field target "phase_count_external_inscription" >>= sourceInteger
 let degree ← field target "degree_support_external_inscription" >>= sourceInteger
 if @decide (components<1) (Int.decLt _ _) || @decide (phases<1) (Int.decLt _ _) then
  throw "THERMO-011 external identity is not positive"
 let relation ← identityString (get target "external_relation_record")
 let relation := String.ofList ((Text.chars relation).map fun c => if c=='−' then '-' else c)
 if !Text.equal relation "F = C - P + 2" then throw "THERMO-011 IUPAC relation record changed"
 if @decide (degree=0) (Int.decEq _ _) then
  if !sameValue (get target "sft_degree_support_state") (.text "EmptyOne") ||
   !(@decide (components+2=phases) (Int.decEq _ _)) then
   throw "THERMO-011 invariant external glyph was consumed as a number"
  pure ⟨components.toNat,true⟩
 else if @decide (0<degree) (Int.decLt _ _) then
  if !sameValue (get target "sft_degree_support_state") (.text "exact-positive-degree-support") ||
   !(@decide (components+2=phases+degree) (Int.decEq _ _)) then
   throw "THERMO-011 positive degree support breaks exact carrier balance"
  pure ⟨components.toNat,false⟩
 else throw "THERMO-011 external degree inscription is negative"
structure Analysis where
 count : Nat
 componentCounts : List (Nat×Nat)
 positiveCount : Nat
 emptyCount : Nat
 checks : List (String×Bool)
def exactPhaseRuleAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let counts := analyzed.foldl (fun counts row =>
  if counts.any (fun item => item.1==row.components) then
   counts.map (fun (key,n)=>(key,if key==row.components then n+1 else n))
  else counts++[(row.components,1)]) ([] : List (Nat×Nat))
 let emptyCount := (analyzed.filter RowAnalysis.emptyDegree).length
 let positiveCount := (analyzed.filter fun row => !row.emptyDegree).length
 let classes := counts.length==4 && [(1,3),(2,4),(3,5),(4,6)].all (fun (k,n)=>counts.any fun (key,value)=>key==k && value==n)
 pure ⟨rows.length,counts,positiveCount,emptyCount,[
 ("all_18_component_phase_rows_retained",rows.length==18),
 ("complete_one_through_four_component_classes_retained",classes),
 ("all_14_positive_degree_supports_retained",positiveCount==14),
 ("all_four_external_zero_glyphs_translated_only_to_EmptyOne",emptyCount==4),
 ("complete_iupac_source_retained",sameValue (get primary "iupac_snapshot_hash") (.text "sha256:49cb8a30304e143e190be51be1a9fcd9045e0581718d0da2bc1ebcdd73152477")),
 ("complete_32_page_nist_source_retained",sameValue (get primary "nist_snapshot_hash") (.text "sha256:8572fe338cf9256c9510d89cfc0d62b16d272575d69d89e6584e39cb629fc5f6") && sameValue (get primary "nist_complete_page_count") (.integer 32)),
 ("all_sources_and_rows_preserved",sameValue (get primary "all_complete_sources_and_component_phase_degree_rows_preserved") (.boolean true)),
 ("no_external_equation_or_degree_used_as_proof_parameter",sameValue (get primary "external_equation_or_degree_value_used_as_proof_parameter") (.boolean false)),
 ("no_subtraction_signed_count_or_numerical_zero_imported",sameValue (get primary "subtraction_signed_count_or_numerical_zero_imported_into_sft_derivation") (.boolean false))]⟩
end SFT.Chemistry.PhaseRuleAnalysis
