import SFT.Chemistry.MolecularDipoleMagnitudeExperiment
import SFT.Chemistry.MolecularBondAngleSource
namespace SFT.Chemistry.MolecularDipoleMagnitudeSource
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
open MolecularDipoleMagnitudeExperiment
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev sameKeys := MolecularBondAngleSource.sameKeys
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def pdfPath := "experiments/external_sources/chemistry/snapshots/prop-005-nist-water-dipole-1973-v1.pdf"
def pdfHash := "sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84"
def htmlPath := "experiments/external_sources/chemistry/snapshots/prop-005-nist-cccbdb-experimental-dipoles-v1.html"
def htmlHash := "sha256:6320aca1d0c0e4fd12509dedaa985d2252813011e69d090a127b49f12414b49d"
def primaryPath := "experiments/external_sources/chemistry/snapshots/prop-005-molecular-dipole-primary-records-v1.json"
def primaryHash := "sha256:6ad1fa4ff8c570cb0d8f84df2def3670f630924d9fdac8e3a8011c2ec3578dc5"
def fraction (row : Value) : Except String Rat := do
 let fields ← match row with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-005 exact fraction record is malformed"
 if !sameKeys (fields.map Prod.fst) ["numerator","denominator"] then throw "PROP-005 exact fraction record is malformed"
 let n ← match get row "numerator" with
  | .integer n => pure n
  | .null | .boolean _ | .text _ | .array _ | .object _ => throw "PROP-005 exact fraction left the positive domain"
 let d ← match get row "denominator" with
  | .integer n => pure n
  | .null | .boolean _ | .text _ | .array _ | .object _ => throw "PROP-005 exact fraction left the positive domain"
 if !(@decide (Int.lt 0 n) (Int.decLt _ _)) || !(@decide (Int.lt 0 d) (Int.decLt _ _)) then
  throw "PROP-005 exact fraction left the positive domain"
 if positive : 0<d.natAbs then pure (normalize n d.natAbs positive)
 else throw "PROP-005 exact fraction left the positive domain"
def ratio (value : Rat) : Except String CapabilityValues.Value := do
 if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then throw "PROP-005 measurement ratio must be exact and positive"
 pure (.ratio (← CapabilityValues.count value.num.natAbs) (← CapabilityValues.count value.den))
def equalRat (a b : Rat) : Bool := (@decide (a.num=b.num) (Int.decEq _ _)) && a.den==b.den
def lessRat (a b : Rat) : Bool := @decide (Int.lt (a.num*Int.ofNat b.den) (b.num*Int.ofNat a.den)) (Int.decLt _ _)
structure Interval where
 central : Rat
 uncertainty : Rat
 lower : Rat
 upper : Rat
def interval (row : Value) : Except String Interval := do
 let central ← field row "central" >>= fraction
 let uncertainty ← field row "uncertainty" >>= fraction
 let lower ← field row "lower" >>= fraction
 let upper ← field row "upper" >>= fraction
 if !equalRat (add lower uncertainty) central || !equalRat (add central uncertainty) upper || !lessRat lower upper then
  throw "PROP-005 interval does not reconstruct exactly"
 pure ⟨central,uncertainty,lower,upper⟩
structure Target where
 targetId : String
 species : String
 role : String
 inscription : String
 common : Value
 measurement : Option Interval
 value : CapabilityValues.Value
 intervalValue : CapabilityValues.Value
def loadTargets (files : List (String × ByteArray)) (primary identities measurements : Value) : Except String (List Target) := do
 let _ ← [(pdfPath,pdfHash),(htmlPath,htmlHash),(primaryPath,primaryHash),(identityPath,identityHash),(targetPath,targetHash)].mapM fun (path,hash) => do
  let bytes ← match files.find? (fun p => Text.equal p.1 path) with
   | none => throw (Text.append "FileNotFoundError: " path)
   | some p => pure p.2
  if !bytesMatch bytes hash then throw (Text.append "PROP-005 source bytes changed: " path)
  pure ()
 let primaryList ← RunningConvergenceMeasurement.array (get primary "records")
 let identityList ← RunningConvergenceMeasurement.array (get identities "rows")
 let measurementList ← RunningConvergenceMeasurement.array (get measurements "rows")
 if !sameValue (get primary "schema") (.text "sft-v3-molecular-dipole-primary-records/1") ||
    !sameValue (get primary "all_registered_rows_preserved") (.boolean true) ||
    !sameValue (get identities "schema") (.text "sft-v3-molecular-dipole-identities/1") ||
    !sameValue (get identities "all_measurement_values_absent") (.boolean true) ||
    !sameValue (get measurements "schema") (.text "sft-v3-molecular-dipole-withheld-measurements/1") ||
    !sameValue (get measurements "release_requires_prediction_seal") (.boolean true) ||
    !sameValue (get measurements "identity_document_hash") (.text (identity identities)) ||
    primaryList.length != 9 || identityList.length != 9 || measurementList.length != 9 then
  throw "PROP-005 complete source boundary changed"
 let primaryRows ← EquilibriumBondLengthSource.indexedRows (.object [("rows",.array primaryList)])
 let identityRows ← EquilibriumBondLengthSource.indexedRows identities
 let measurementRows ← EquilibriumBondLengthSource.indexedRows measurements
 if !sameKeys (primaryRows.map Prod.fst) (identityRows.map Prod.fst) ||
    !sameKeys (primaryRows.map Prod.fst) (measurementRows.map Prod.fst) || primaryRows.length != 9 then
  throw "PROP-005 source, identity and target support differ"
 let forbidden := ["central","uncertainty","lower","upper","inscription","raw_source_inscription","source_glyph"]
 (SFT.Engine.sortIdentifiers (primaryRows.map Prod.fst)).mapM fun targetId => do
  let source ← field (.object primaryRows) targetId
  let identityRow ← field (.object identityRows) targetId
  let row ← field (.object measurementRows) targetId
  let identityFields ← match identityRow with
   | .object fields => pure fields
   | .null | .boolean _ | .integer _ | .text _ | .array _ => throw (Text.append "PROP-005 source reconstruction differs: " targetId)
  if !sameValue (get identityRow "target_value_absent") (.boolean true) ||
     identityFields.any (fun (key,_) => forbidden.any (Text.equal key)) ||
     !sameValue row source ||
     identityFields.any (fun (key,value) => !Text.equal key "target_value_absent" && !sameValue value (get source key)) then
   throw (Text.append "PROP-005 source reconstruction differs: " targetId)
  let species ← field row "species" >>= text
  let role ← field row "measurement_role" >>= text
  let inscription ← field row "inscription" >>= text
  let kind ← field row "value_kind" >>= text
  let fields ← ["species","measurement_role","axis","symmetry","molecular_state","geometry",
   "charge_distinction_carrier","method","condition","conventional_direction","inscription","value_kind"].mapM fun key => do
    let value ← field row key >>= text
    pure (key,Value.text value)
  let support ← field row "component_support"
  let common := Value.object ([("target_id",.text targetId)]++fields++[("component_support",support)])
  if Text.equal kind "source_absence_glyph" then
   if !sameValue (get row "native_interpretation") (.text "EmptyOne") || !sameValue (get row "source_glyph") (.text "0.000") then
    throw "PROP-005 source absence glyph changed"
   pure ⟨targetId,species,role,inscription,common,none,.emptyOne "empty-One",.emptyOne "empty-One"⟩
  else if Text.equal kind "positive_magnitude" then
   let values ← interval row
   pure ⟨targetId,species,role,inscription,common,some values,← ratio values.central,
    .pair (← ratio values.lower) (← ratio values.upper)⟩
  else throw "PROP-005 measurement kind is outside the registered boundary"
def squareInterval (rows : List Target) : Except String (Rat × Rat) := do
 let intervals ← rows.mapM fun row => match row.measurement with
  | none => throw "KeyError: lower"
  | some value => pure value
 match intervals with
 | [] => throw "PROP-005 magnitude requires positive component support"
 | first::rest =>
  pure (rest.foldl (fun a v => add a (multiply v.lower v.lower)) (multiply first.lower first.lower),
   rest.foldl (fun a v => add a (multiply v.upper v.upper)) (multiply first.upper first.upper))
theorem emptySquareIntervalRejected : squareInterval [] = .error "PROP-005 magnitude requires positive component support" := rfl
end SFT.Chemistry.MolecularDipoleMagnitudeSource
