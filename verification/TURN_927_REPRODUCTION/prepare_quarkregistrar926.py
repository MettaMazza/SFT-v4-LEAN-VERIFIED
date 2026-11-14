from pathlib import Path
w=Path('work');s=(w/'register_gravityvalidation912.py').read_text().replace('_build912','_build926')
s=s.replace("assert json.load(open(w/'gravityvalidation912_authoritative_report.json'))['status']=='PASS'","assert json.load(open(w/'quarkcomparison926_science_report.json'))['status']=='PASS'")
a=s.index(" 'GravityAuthoritativeRecords':");b=s.index(" tag+'Grammar':",a)
s=s[:a]+""" 'QuarkComparison':'Original refined_quark_roots stopping loop,exact source-run proofs,all three dressed ratio intervals and all four CKM intervals,with original arithmetic,branch order and domain.',
 'MatterAuthoritativeRecords':'Original authoritative_record byte hash,post-seal custody flag,six-source count,five named component hashes and complete source_rows lookup.',
 'QuarkComparisonMeasurement':'Original quark_ckm_classification:full PDG uncertainty arithmetic,both dressed overlaps,top/charm status guards,and all four CKM three-sigma comparisons retaining the s23 tension.',
 'MatterAuthoritativeWitnesses':'Entire original six-source record,payload boundary and computed quark classification proofs;fresh full-record byte/parser and native comparison binds the retained document.',
"""+s[b:]
s=s.replace('sft/physics/gravity_spacetime_validation_v1.py','sft/physics/matter_flavour_validation_v1.py')
s=s.replace("'gravityvalidation912_source_identity.json','gravityvalidation912_authoritative_report.json','gravityvalidation912_authoritative_output.json','gravityvalidation912_original_classifications.json'","'mattervalidation926_source_identity.json','mattervalidation926_original_record.json','mattervalidation926_original_classifications.json','quarkcomparison926_science_report.json','quarkcomparison926_core_audit.log','quarkvalidation926_core_build.log'")
s=s.replace('check_fieldvalidation_original895.py','check_quarkvalidation_original926.py')
s=s.replace('complete original six-source/six-control record,two named document hashes and all four classifications match.','complete original six-source record,five component hashes and all exact quark/CKM computations and original status outcomes match.')
(w/'register_quarkvalidation926.py').write_text(s)
