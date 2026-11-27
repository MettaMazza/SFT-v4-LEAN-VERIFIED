from pathlib import Path
import ast
r=Path('work/turn1064_recovery/SFT/Chemistry')
b=ast.parse(Path('work/pinned_conformerpopulation1495/sft/chemistry/conformer_population_ordering_batch_v1.py').read_text())
v={}
for node in b.body:
 if isinstance(node,ast.Assign):
  try: value=ast.literal_eval(node.value)
  except: continue
  for t in node.targets:
   if isinstance(t,ast.Name):v[t.id]=value
s=(r/'ConformerPrediction.lean').read_text().replace('ConformerPrediction','ConformerPopulationPrediction').replace('ORG-005','ORG-006')
s=s.replace('7f148f0b99d0939aefb6023521d697dc00386a0de2f7a328d6b1220377965ad4',v['IDENTITY_HASH'].removeprefix('sha256:'))
s=s.replace('"definition","table","value"','"definition","value"')
a=s.index(' if !equal (get document "complete_registered_target_count")');e=s.index(' return rows',a)
s=s[:a]+''' if !equal (get document "complete_registered_target_count") (.integer 14) ||
    !equal (get document "external_values_or_outcomes_used_to_select_identity") (.boolean false) ||
    rows.length != 14 || hasForbidden then
  throw "ORG-006 value-free identity boundary changed"
'''+s[e:]
s=s.replace('conformer-record-','population-record-').replace('"conformer-law"','"conformer-population-law"')
for old,new in [('complete-cartesian-held-state-generation','exact-conditioned-class-count-ratio'),('exhaustive-graph-automorphism-census','structural-EmptyOne-absence'),('exact-disjoint-orbit-equivalence','positive-Take-energy-and-population-order'),('development-observed-complete-external-census-after-seal','complete-blind-condition-bound-value-vector'),('complete-conformer-vector','complete-conditioned-population-vector'),('CONFORMER-GENERATION-EQUIVALENCE-005','CONFORMER-POPULATION-ORDERING-006')]:s=s.replace(old,new)
(r/'ConformerPopulationPrediction.lean').write_text(s)
s=(r/'ConformerSource.lean').read_text().replace('ConformerSource','ConformerPopulationSource').replace('ConformerPrediction','ConformerPopulationPrediction').replace('ORG-005','ORG-006')
s=s.replace('sha256:ed750adf9e52a8257fd3784f19fee213bca5c3a147cd72cb9488a2a4ec45c8f3',v['TARGET_HASH']).replace('sha256:a5eb356e0240a4e56457ba7265368cc7e06ca0396b38b103eac357e9ac186f10',v['PRIMARY_HASH'])
s=s.replace('entries.length != 4','entries.length != 14').replace('resolved.length != 4','resolved.length != 14').replace('targets.length != 4','targets.length != 14').replace('(.integer 4)','(.integer 14)')
s=s.replace('    !equal (get targetDocument "all_rows_development_observed_and_not_claimed_blind") (.boolean true) ||\n','')
s=s.replace('all_favourable_adverse_absent_scope_and_unresolved_rows_preserved','all_favourable_adverse_absent_unavailable_unresolved_signed_and_rounded_rows_preserved')
(r/'ConformerPopulationSource.lean').write_text(s)
s=Path('work/build_conformerpopulation1495_witnesses.py').read_text().replace("['ConformerPopulationWitnesses']","['ConformerPopulationPrediction','ConformerPopulationSource']").replace('ConformerPopulationWitnessesAudit1495','ConformerPopulationInterfacesAudit1495').replace('population_witnesses_audit','population_interfaces_audit')
Path('work/build_conformerpopulation1495_interfaces.py').write_text(s)
print('Generated original 14-row prediction and source-guard translation')
