from pathlib import Path
import re,json
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry'
s=(r/'CoordinationIsomerismPrediction.lean').read_text().replace('CoordinationIsomerism','LigandStateSplitting').replace('INORG-005','INORG-006').replace('sha256:60a107df040a81774fd312354a36710c7455d6175495c5c300ec83382a0033d1','sha256:70188a12aa368cf39624142b408b4895f933a194dced0ff99b6a984a2cef19c3')
s=s.replace(' let ids ← rows.mapM (fun row => field row "target_id" >>= text)\n','')
a=s.index(' let forbidden :=');b=s.index(' let hasForbidden',a);s=s[:a]+' let forbidden := ["value","outcome","definition","peak","intensity","band_count","source_outcome","target_payload_hash"]\n'+s[b:]
a=s.index(' if !equal (get document');b=s.index('  throw "INORG-006 value-free',a)
s=s[:a]+''' if !equal (get document "complete_registered_target_count") (.integer 32) ||
    !equal (get document "target_values_peak_positions_intensities_band_counts_definitions_and_outcomes_present") (.boolean false) ||
    rows.length != 32 || !completeOrdinals 1 rows || hasForbidden then
'''+s[b:]
s=s.replace('coordination-isomerism-record-','ligand-state-splitting-record-').replace('[(1,"source_record_ordinal"),(2,"authority"),(3,"source_id"),(4,"registered_identity"),(5,"source_record_role"),(6,"source_locator")]','[(1,"source_record_ordinal"),(2,"source_id"),(3,"authority"),(4,"source_record_role"),(5,"custody_class")]')
laws=['five-supports-from-generator-three-and-boundary-rank-two','complete-ligand-incidence-signature-partitions-levels','positive-block-cardinalities-preserve-all-members','exact-normalized-separation-and-complementary-balance','all-thirty-two-definition-development-adverse-absent-ancillary-and-blind-surfaces-retained']
a=s.index(' let (instructions,registers) :=');b=s.index('.foldl',a);s=s[:a]+' let (instructions,registers) := ['+','.join('("ligand-state-splitting-law",'+json.dumps(x)+')'for x in laws)+']'+s[b:]
s=s.replace('complete-coordination-isomerism-vector','complete-ligand-state-splitting-vector').replace('SFT-EXP-CHEM-COORDINATION-ISOMERISM-EQUIVALENCE-005-value-free-complete-vector','SFT-EXP-CHEM-LIGAND-STATE-SPLITTING-006-value-free-vector');(r/'LigandStateSplittingPrediction.lean').write_text(s)
s=(r/'CoordinationIsomerismSource.lean').read_text().replace('CoordinationIsomerism','LigandStateSplitting').replace('INORG-005','INORG-006').replace('17','32').replace('cells.length != 12','cells.length != 11').replace('complete 32-record table','complete 32-row table').replace('prediction lost a consequence','prediction row is incomplete').replace('prediction duplicated a target','prediction duplicates a target').replace('identity/target binding changed','target differs from registered identity').replace('target payload changed','target payload hash changed').replace('target registry changed','target vector is incomplete')
s=s.replace('["target_id","source_record_ordinal","authority","source_id","registered_identity","source_record_role","source_locator"]','["target_id","source_record_ordinal","source_id","authority","source_record_role","custody_class"]')
a=s.index(' let inscription ←');b=s.index(' let payload :=',a);s=s[:a]+' let inscription := get target "source_outcome"\n'+s[b:]
s=s.replace('throw (Text.append "INORG-006 source changed: " path)','throw "INORG-006 post-seal target evidence changed"');(r/'LigandStateSplittingSource.lean').write_text(s)
