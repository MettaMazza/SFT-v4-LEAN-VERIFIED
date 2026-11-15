from pathlib import Path
import ast,json
p=Path('work/constants-recovery/SFT/Physics')
s=(p/'YangMillsSpectrumValidation.lean').read_text().replace('YangMillsSpectrum','Parker').replace('SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027','SFT-PHYS-PARKER-PROTON-ENERGY-TERMINAL-028').replace('exact-yang-mills-singlet-gap-spectrum-comparator/1','exact-parker-proton-energy-comparator/1')
s=s.replace('open SFT.Host SFT.Host.Canonical ParkerExperiment LeptonIntervals','open SFT.Host SFT.Host.Canonical ParkerExperiment ParkerPrediction LeptonIntervals')
a=s.index('def labelMatches');b=s.index('def replaceField',a);s=s[:a]+s[b:]
s=s.replace('wrong Yang-Mills spectrum seal','wrong Parker proton-energy seal').replace('let document := programDocument','let registrationHash := admissionIdentity (← registrationRecord)\n let document ← predictionProgramDocument')
a=s.index(' let held ←');b=s.index(' let hashes :=',a)
s=s[:a]+''' let inputs ← formalPredictionInputs
 let keys := inputs.map Prod.fst
 let env := envelope derivationSeal inputs registrationHash
 let originalTargets ← releasedTargets files record
'''+s[b:]
s=s.replace('Yang-Mills prediction package audit failed','Parker hostile-package audit failed')
s=s.replace(' if !labelMatches execution.output then throw "Yang-Mills spectrum prediction changed"',' let mapped ← outputMapping execution.output keys\n if !sameValue (.object (mapped.map (fun (k,v) => (k,CapabilityValues.canonical v)))) (.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))) then throw "Parker prediction changed"')
a=s.index(' let analysis ←');b=s.index(' let targetIdentity ←',a)
s=s[:a]+''' let analysis ← ParkerMeasurement.exactMeasurementAnalysis target
 let yes := fun key => SymmetricRecords.truthy (PostNewtonianRecords.getDefault analysis key)
 let equals := fun key expected => sameValue (PostNewtonianRecords.getDefault analysis key) expected
 let adverse ← RunningConvergenceMeasurement.array (← field analysis "adverse_formula_rows")
 let event ← field target "parker_event"
 let wording ← field event "reported_energy_wording"
 let allRows := adverse.length == 12 && ParkerRecords.sourceLength wording == 3
 let inside ← RunningConvergenceMeasurement.array (← field analysis "adverse_inside_range")
 let controls := yes "terminal_inside_complete_range" && yes "leading_inside_complete_range" && equals "approximate_label_has_uncertainty" (.boolean false) && equals "approximate_label_is_exact_cutoff" (.boolean false) && equals "observation_uniquely_selects_structural_formula" (.boolean false) && inside.any (fun x => sameValue x (.array [.integer 2,.integer 2])) && inside.any (fun x => sameValue x (.array [.integer 3,.integer 2]))
 let tampered := replaceField target "parker_event" (replaceField event "spectral_analysis_upper_keV" (.text "300"))
 let tamperedAnalysis ← ParkerMeasurement.exactMeasurementAnalysis tampered
 let tamperedRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault tamperedAnalysis "terminal_inside_complete_range")
 let passed := allRows && controls && tamperedRejected
'''+s[b:]
s=s.replace(',("formal",.boolean formal)','')
tree=ast.parse(Path('work/parker1006_original_validation.py').read_text())
measurements=next(ast.literal_eval(n.value) for n in ast.walk(tree) if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='measurements' for t in n.targets))
a=s.index(' let measurements :=');b=s.index('\n pure ⟨',a)
s=s[:a]+' let measurements := '+json.dumps(list(measurements))+s[b:]
s=s.replace('.array [.text ParkerRecords.sourceId]','.array (ParkerRecords.sourceIds.map Value.text)')
for root in [p,Path('/Volumes/One Touch/SFT v4 Full model LEAN/SFT/Physics')]: (root/'ParkerValidation.lean').write_text(s)
