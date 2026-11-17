import SFT.Chemistry.CoordinationEntity
import SFT.Chemistry.CoordinationSource
namespace SFT.Chemistry.CoordinationAnalysis
open SFT.Host SFT.Physics.CapabilityValues
open CoordinationEntity
open JointCorrelationTargets (field text)
open CoordinationPrediction (equal)
abbrev J := Canonical.Value

def entity (centralLabel : String := "Fe-one") : Except String Entity := do
 let central ← heldLabel "coordination-central-occurrence" centralLabel
 let rows ← (List.range 5).mapM fun index => do
  let n := index+1
  attachment (← count n) central
   (← heldLabel "coordination-ligand-occurrence" (Text.append "CO-" (toString n)))
   (← heldLabel "coordination-ligand-group" "CO")
   (← heldLabel "positive-coordination-incidence" (Text.append "Fe-C-" (toString n)))
 construct (← heldLabel "coordination-entity" "FeCO5") (← heldLabel "coordination-central-element" "Fe") central rows

def truthy : J → Bool
 | .null => false
 | .boolean b => b
 | .integer (.ofNat n) => n != 0
 | .integer (.negSucc _) => true
 | .text s => !s.isEmpty
 | .array xs => !xs.isEmpty
 | .object xs => !xs.isEmpty

def inscription (rows : List J) (role : String) : Except String String := do
 let pairs ← rows.mapM fun row => do return (← field row "source_record_role" >>= text,← field row "source_inscription" >>= text)
 match pairs.reverse.find? (fun p => Text.equal p.1 role) with
 | some p => return p.2
 | none => throw (Text.intercalate "" ["'",role,"'"])

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 20 || !CoordinationPrediction.completeOrdinals 1 rows then
  throw "INORG-001 requires the complete source-ordered 20-record vector"
 let authorities ← rows.mapM (fun row => field row "authority" >>= text)
 let iupacCount := (authorities.filter (Text.equal · "IUPAC")).length
 let nistCount := (authorities.filter (Text.equal · "NIST-CCCBDB")).length
 let carrier ← entity
 let result := forcedIdentity carrier
 let successor ← attachment (← count 6) carrier.centralOccurrence
  (← heldLabel "coordination-ligand-occurrence" "CO-6") (← heldLabel "coordination-ligand-group" "CO")
  (← heldLabel "positive-coordination-incidence" "Fe-C-6")
 let adverse ← field primary "adverse_and_limitation_surface"
 let adverseValues ← match adverse with
  | .object fields => pure (fields.map Prod.snd)
  | .null | .text _ | .integer _ | .boolean _ | .array _ => throw "limitation surface requires an object"
 let current ← inscription rows "coordination-entity-current-term"
 let feCount ← inscription rows "FeCO5-C-Fe-link-count"
 let feIdentity ← inscription rows "FeCO5-entity-identity"
 let ferCount ← inscription rows "ferrocene-C-Fe-link-count"
 let ferIdentity ← inscription rows "ferrocene-entity-identity"
 let sourceBoundary ← field primary "no_source_value_used_as_fold_proof_parameter"
 return .object [("complete_registered_target_count",.integer (.ofNat rows.length)),
  ("source_class_census",.object [("IUPAC",.integer (.ofNat iupacCount)),("NIST-CCCBDB",.integer (.ofNat nistCount))]),
  ("source_class_census_matches",.boolean (iupacCount==3 && nistCount==17)),
  ("single_retained_central_occurrence_reconstructed",.boolean (MulticentreSupport.sameLabel result.centralOccurrence (← heldLabel "coordination-central-occurrence" "Fe-one"))),
  ("five_distinct_ligand_occurrences_and_incidences_reconstructed",.boolean
   (MulticentreSupport.distinct result.orderedLigandOccurrences && result.orderedLigandOccurrences.length==5 &&
    MulticentreSupport.distinct result.orderedAttachmentTraces && result.orderedAttachmentTraces.length==5)),
  ("successor_preserves_complete_prior_identity",.boolean (← appendPreservesIdentity carrier successor)),
  ("iupac_central_ligand_structure_retained",.boolean (Text.contains current "central atom" && Text.contains current "ligands")),
  ("nist_iron_pentacarbonyl_structure_retained",.boolean (Text.equal feCount "5" && Text.isPrefix "Fe(CO)5".toUTF8.data.toList feIdentity.toUTF8.data.toList)),
  ("nist_ferrocene_structure_retained",.boolean (Text.equal ferCount "10" && Text.isPrefix "Fe(C5H5)2".toUTF8.data.toList ferIdentity.toUTF8.data.toList)),
  ("all_reported_absences_and_disclaimers_retained",.boolean (adverseValues.all truthy)),
  ("source_values_remain_postseal_evidence_only",.boolean (equal sourceBoundary (.boolean true)))]
end SFT.Chemistry.CoordinationAnalysis
