import SFT.Physics.PostNewtonianValidation
import Lean
open SFT.Physics SFT.Host.Canonical
def convert : Nat → Lean.Json → Except String Value
 | 0,_ => .error "JSON nesting exceeds input byte count"
 | n+1,j => match j with
   | .null => .ok .null
   | .bool b => .ok (.boolean b)
   | .num _ => do pure (.integer (← j.getInt?))
   | .str s => .ok (.text s)
   | .arr xs => do pure (.array (← xs.toList.mapM (convert n)))
   | .obj fs => do pure (.object (← fs.toList.mapM (fun (k,v) => do pure (k,← convert n v))))

def main (args : List String) : IO Unit := do
 let root := args[0]!
 let derivationSeal := args[1]!
 let host := args[2]!
 let implementation := args[3]!
 let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩
 let files ← (PostNewtonianRecords.sourceHashes.map Prod.fst).mapM fun name => do
  pure (name,← IO.FS.readBinFile (System.FilePath.mk (root ++ "/" ++ name)))
 let bytes ← IO.FS.readBinFile (root ++ "/" ++ PostNewtonianRecords.sourcePath)
 -- Ordered fixture from the actual pinned source JSON; all original file bytes are independently checked by validate.
 let payload : Value := .object [("schema",.text "sft-v3-post-newtonian-fixed-point-source-record/1"),("source_id",.text "D9M-POST-NEWTONIAN-FIXED-POINT-COMPARISON"),("source_class",.text "superseded-clean-room-record-plus-external-primary-review"),("source_note",.text "Historical V1/V2 observations and the external PN review open only after the V3 prediction seal. None selects the V3 map, fixed point or survivor."),("snapshots",.array [.object [("path",.text "audits/v1_theorem_manifest_observation_census.json"),("sha256",.text "05c7c285e87720c0b22a69cc69b07cdd9749a1aa1728afd934e1ed9f7c30ce93"),("scope",.text "V1 D9m exact four-correction observation")],.object [("path",.text "audits/v2_407_step_observation_census.json"),("sha256",.text "abc262ac488a35eb00ab38bf5c94b7b3c7a49110868ab86275c27e454eb62d3f"),("scope",.text "V2 step 179 exact self-source map and fixed-point observation")],.object [("path",.text "experiments/external_sources/physics/snapshots/arxiv-1310.1528-post-newtonian-theory.pdf"),("sha256",.text "c3b1b7c454e15b65bade4245a8e6d61b6e5c0546baaee436a17b99ef6983b4a8"),("source_uri",.text "https://arxiv.org/abs/1310.1528"),("scope",.text "Primary Living Reviews account of nonlinear weak-field iteration, near-zone matching and explicit PN correction hierarchy")]]),("registered_target",.object [("v1_source_entry",.text "D9m"),("v1_corrections",.array [.text "7/50",.text "7/150",.text "7/1350",.text "7/109350"]),("v1_relation",.text "strictly-decreasing-positive-self-energy-corrections"),("v2_source_step",.text "179"),("v2_map",.text "f-next-equals-half-One-times-seven-sixteenths-plus-f-squared"),("v2_matter_source",.text "7/16"),("v2_coupling",.text "1/2"),("v2_fixed_point",.text "1/4"),("external_scheme",.text "post-Newtonian-near-zone-iteration-matched-to-exterior-multipolar-post-Minkowskian-field"),("external_nonlinearity",.text "successive-field-orders-include-nonlinear-source-interactions"),("external_1PN_scalar_structure",.text "linear-potential-term-and-quadratic-potential-correction"),("external_domain",.text "weak-field-slow-motion-near-zone-with-matching-and-boundary-conditions"),("external_formal_order",.text "developed-to-any-post-Newtonian-order"),("external_universal_numeric_convergence_claimed",.boolean false),("measured_parameter_fitted",.boolean false)]),("custody",.object [("formal_claim_contains_historical_or_external_target_values",.boolean false),("target_inaccessible_during_prediction_execution",.boolean true),("prediction_sealed_before_target_release_within_run",.boolean true),("all_historical_and_external_rows_retained",.boolean true),("targets_select_formal_survivor",.boolean false),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-comparison")])]
 let v1text ← IO.FS.readFile (root ++ "/audits/v1_theorem_manifest_observation_census.json")
 let v2text ← IO.FS.readFile (root ++ "/audits/v2_407_step_observation_census.json")
 let v1 ← IO.ofExcept (do convert (v1text.utf8ByteSize+1) (← Lean.Json.parse v1text))
 let v2 ← IO.ofExcept (do convert (v2text.utf8ByteSize+1) (← Lean.Json.parse v2text))
 let result ← IO.ofExcept (PostNewtonianValidation.validate files payload v1 v2 PostNewtonianValidation.claimId derivationSeal host implementation before before)
 IO.println (render result.value)
