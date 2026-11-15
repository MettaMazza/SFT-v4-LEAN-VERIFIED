from pathlib import Path
import ast,json
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');s=(r/'SFT/Physics/ParkerValidation.lean').read_text().replace('Parker','ProtonRadius').replace('SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028','SFT-PHYS-PROTON-RADIUS-TERMINAL-029').replace('exact-parker-proton-energy-comparator/1','exact-proton-radius-terminal-comparator/1').replace('wrong ProtonRadius proton-energy seal','wrong proton-radius seal').replace('ProtonRadius hostile-package audit failed','proton-radius hostile-package audit failed').replace('ProtonRadius prediction changed','proton-radius prediction changed')
a=s.index(' let event ←',s.index(' let adverse ←'));b=s.index(' let passed :=',a)
s=s[:a]+''' let current ← match ← field analysis "current_intervals_fm" with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "TypeError"
 let allRows := current.length == 4 && adverse.length == 9 && yes "scope_rows_retained"
 let inside ← RunningConvergenceMeasurement.array (← field analysis "adverse_inside_muonic_interval")
 let controls := yes "all_current_intervals_contain_prediction" && yes "historical_conflict_retained" && equals "observation_uniquely_selects_ten_linear" (.boolean false) && ([8,9,10] : List Nat).all (fun n => inside.any (fun x => sameValue x (.array [.integer (.ofNat n),.text "linear"])))
 let rows ← RunningConvergenceMeasurement.array (← field target "current_radius_rows")
 let altered ← match rows with
  | [] => throw "IndexError"
  | first::rest => pure (replaceField (replaceField first "value_fm" (.text "0.8200")) "standard_uncertainty_fm" (.text "0.0010") :: rest)
 let tampered := replaceField target "current_radius_rows" (.array altered)
 let tamperedAnalysis ← ProtonRadiusMeasurement.exactMeasurementAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "all_current_intervals_contain_prediction")
'''+s[b:]
tree=ast.parse((w/'proton_radius1012_original_validation.py').read_text());node=next(n for n in ast.walk(tree) if isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None)=='measurements');measurements=ast.literal_eval(node.value);a=s.index(' let measurements :=');b=s.index('\n pure ⟨',a);s=s[:a]+' let measurements := '+json.dumps(measurements)+s[b:]
for root in [r,w/'constants-recovery']:(root/'SFT/Physics/ProtonRadiusValidation.lean').write_text(s)
