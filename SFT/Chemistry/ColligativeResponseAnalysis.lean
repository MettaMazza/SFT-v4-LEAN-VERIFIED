import SFT.Chemistry.ColligativeResponse
import SFT.Chemistry.RealGasAnalysis
import SFT.Chemistry.TemperatureCorrespondenceSource
namespace SFT.Chemistry.ColligativeResponseAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open ColligativeResponse
abbrev sourceFraction := ComponentExchangeAnalysis.sourceFraction
abbrev truthy := ComponentExchangeAnalysis.truthy
abbrev fractionText := InternalEnergyCompositionSource.fractionText
structure RowAnalysis where
 className : String
 dataset : String
 response : Rat
 composition : Rat
 absent : Bool
def analyzeRow (row : InternalEnergyCompositionSource.Target) : Except String RowAnalysis := do
 let target := get row.row "target_payload"
 let className ← identityString (get target "response_class")
 if (responseOrientation className).isNone then throw "THERMO-014 response class changed"
 let raw ← match get target "component_orgnums" with | .array xs => pure xs | .null => pure [] | .boolean _ | .integer _ | .text _ | .object _ => throw "THERMO-014 solvent/solute identity support changed"
 let components ← raw.mapM TemperatureCorrespondenceSource.integer
 let (solvent,solute) ← match components with
  | [a,b] =>
   if @decide (a=b) (Int.decEq _ _) then throw "THERMO-014 solvent/solute identity support changed"
   pure (a,b)
  | [] | [_] | _::_::_::_ => throw "THERMO-014 solvent/solute identity support changed"
 if (match get target "complete_component_records" with | .array xs => xs.length | .null | .boolean _ | .integer _ | .text _ | .object _ => 0) != 2 then
  throw "THERMO-014 solvent/solute identity support changed"
 let composition ← field target "composition_external_inscription" >>= identityString >>= sourceFraction
 let response ← field target "response_external_inscription" >>= identityString >>= sourceFraction
 let temperature ← field target "temperature_K_external_inscription" >>= identityString >>= sourceFraction
 let pressure ← field target "pressure_kPa_external_inscription" >>= identityString >>= sourceFraction
 if @decide (composition.num<0) (Int.decLt _ _) || @decide (response.num≤0) (Int.decLe _ _) ||
  @decide (temperature.num≤0) (Int.decLe _ _) || @decide (pressure.num≤0) (Int.decLe _ _) then
  throw "THERMO-014 external coordinate left the exact nonnegative/positive boundary"
 let absent := @decide (composition.num=0) (Int.decEq _ _)
 let coordinate ← if absent then pure DihedralTorsion.Height.emptyOne else do
  let n ← CapabilityValues.count composition.num.natAbs
  let d ← CapabilityValues.count composition.den
  pure (.ratio ⟨n,d⟩)
 let solvent ← identityString (.integer solvent) >>= CapabilityValues.heldLabel "chemical-component"
 let solute ← identityString (.integer solute) >>= CapabilityValues.heldLabel "chemical-component"
 let classLabel ← CapabilityValues.heldLabel "colligative-response" className
 let account ← makeAccount (.held solvent) (.held solute) (.held classLabel) coordinate (.count ⟨5,by decide⟩) (.count ⟨3,by decide⟩)
 let orientation ← forcedColligativeOrientation (.account account)
 if absent then
  if !Text.equal orientation.relation.label "pure-solvent-reference" then throw "THERMO-014 absence did not remain the reference boundary"
 else
  match responseOrientation className with
  | some expected => if !Text.equal orientation.relation.label expected.label then throw "THERMO-014 forced response orientation changed"
  | none => throw "THERMO-014 forced response orientation changed"
 if !truthy (get target "complete_point_record") || !truthy (get target "complete_property_metadata") ||
  !truthy (get target "complete_variable_metadata") || !truthy (get target "complete_constraint_metadata") then
  throw "THERMO-014 complete measurement provenance is absent"
 let dataset ← field target "dataset_ordinal" >>= identityString
 pure ⟨className,Text.append className (Text.append ":" dataset),response,composition,absent⟩
structure ClassRange where
 className : String
 compositionBounds : Rat×Rat
 responseBounds : Rat×Rat
structure Analysis where
 count : Nat
 classes : List (String×Nat)
 datasets : List (String×Nat)
 emptyCount : Nat
 forcedCount : Nat
 ranges : List ClassRange
 checks : List (String×Bool)
def exactColligativeAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.mapM analyzeRow
 let addCount := fun (counts : List (String×Nat)) (key : String) =>
  if counts.any (fun item=>Text.equal item.1 key) then counts.map (fun (k,n)=>(k,if Text.equal k key then n+1 else n))
  else counts++[(key,1)]
 let classes := analyzed.foldl (fun counts row=>addCount counts row.className) []
 let datasets := analyzed.foldl (fun counts row=>addCount counts row.dataset) []
 let emptyCount := (analyzed.filter RowAnalysis.absent).length
 let forcedCount := (analyzed.filter fun r=> !r.absent).length
 let ranges ← ["boiling","freezing","osmotic"].mapM fun name=>do
  let selected := analyzed.filter fun r=>Text.equal r.className name
  let cb ← RealGasAnalysis.bounds (selected.map RowAnalysis.composition)
  let rb ← RealGasAnalysis.bounds (selected.map RowAnalysis.response)
  pure (⟨name,cb,rb⟩ : ClassRange)
 let expectedDatasets := (List.range 16).map (fun i=>(Text.append "boiling:" (toString (i+1)),9)) ++
  [("freezing:1",6),("freezing:2",3),("freezing:3",4),("freezing:4",9),("freezing:5",9),("freezing:6",6),
   ("osmotic:1",17),("osmotic:2",14),("osmotic:3",16),("osmotic:4",17),("osmotic:5",16),("osmotic:6",15)]
 let classMatch := classes.length==3 && [("boiling",144),("freezing",37),("osmotic",95)].all (fun (k,n)=>classes.any fun (key,count)=>Text.equal k key && n==count)
 let datasetMatch := datasets.length==28 && expectedDatasets.all (fun (k,n)=>datasets.any fun (key,count)=>Text.equal k key && n==count)
 pure ⟨rows.length,classes,datasets,emptyCount,forcedCount,ranges,[
  ("all_276_records_retained",rows.length==276),
  ("all_144_boiling_37_freezing_95_osmotic_records_retained",classMatch),
  ("all_28_datasets_complete",datasetMatch),
  ("all_nonreference_records_have_forced_orientation",forcedCount==275),
  ("sole_absent_coordinate_is_EmptyOne_reference",emptyCount==1),
  ("complete_three_sources_preserved",sameValue (get primary "complete_source_count") (.integer 3) && sameValue (get primary "complete_compound_record_count_across_sources") (.integer 19) && sameValue (get primary "complete_dataset_count") (.integer 28) && sameValue (get primary "complete_point_count") (.integer 276) && sameValue (get primary "all_direct_boiling_freezing_osmotic_rows_and_complete_sources_preserved") (.boolean true)),
  ("no_imported_response_equation_constant_or_fit",sameValue (get primary "conventional_response_equation_constant_dissociation_parameter_interpolation_regression_or_fit_used") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.ColligativeResponseAnalysis
