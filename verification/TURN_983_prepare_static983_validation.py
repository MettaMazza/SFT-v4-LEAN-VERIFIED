from pathlib import Path
import ast,json
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
s=(r/'SFT/Physics/SymmetricValidation.lean').read_text().replace('SymmetricSourceConservation','StaticExteriorClock').replace('Symmetric','Static').replace('symmetric-source-conservation','static-exterior-clock').replace('SYMMETRIC-SOURCE-CONSERVATION-TERMINAL-010','STATIC-EXTERIOR-CLOCK-TERMINAL-011').replace('D9n','D9o');a=s.index(' let analysis ←');b=s.index(' let targetIdentity ←',a);s=s[:a]+''' let analysis ← StaticMeasurement.exactMeasurementAnalysis target
 let yes := fun key => sameValue (PostNewtonianRecords.getDefault analysis key) (.boolean true)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let formalChannel := equals "formal_horizon" (.object [("numerator",.integer 1),("denominator",.integer 2)]) && yes "formal_boundary_empty" && yes "formal_fluxes_conserved" && yes "formal_well_relation" && yes "formal_coefficients_complete_One" && yes "formal_well_halves" && yes "formal_field_quarters" && yes "formal_coefficients_increase" && equals "formal_far_over_near_rate" (.object [("numerator",.integer 16),("denominator",.integer 15)]) && yes "formal_far_clock_faster"
 let prerequisites ← RunningConvergenceMeasurement.array (← field analysis "prerequisite_rows_retained")
 let theory ← RunningConvergenceMeasurement.array (← field analysis "external_theory_rows_retained")
 let nist ← RunningConvergenceMeasurement.array (← field analysis "nist_rows_retained")
 let allRows := yes "all_target_rows_retained" && prerequisites.length==5 && theory.length==9 && nist.length==9
 let controls := yes "historical_relation_retained" && yes "external_unit_conversion_matches" && yes "nist_direction_matches" && yes "nist_scope_preserved" && yes "no_completed_infinity" && yes "no_irrational_clock" && equals "fitted_value_used" (.boolean false)
 let passed := formalChannel && allRows && controls
'''+s[b:]
a=s.index(' let measurements :=');b=s.index(' pure ⟨.object',a);tree=ast.parse((w/'v3-runtime500/sft/physics/static_exterior_clock_terminal_validation_v1.py').read_text());measurements=ast.literal_eval(next(n.value for n in ast.walk(tree) if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='measurements' for t in n.targets)));s=s[:a]+' let measurements := '+json.dumps(list(measurements))+'\n'+s[b:]
for root in [r,w/'constants-recovery']:(root/'SFT/Physics/StaticValidation.lean').write_text(s)
