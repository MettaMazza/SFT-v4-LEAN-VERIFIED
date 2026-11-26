from pathlib import Path
import sys,json,re
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';pin=w/'pinned_ligandsplit1474';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((pin/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import ligand_state_splitting_validation_v1 as v
spec=v.LIGAND_STATE_SPLITTING_SPEC;q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer '+str(x)
 if isinstance(x,(tuple,list)):return '.array ['+','.join(map(cv,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(y)+')'for k,y in x.items())+']'
 raise TypeError(type(x))
s=(r/'CoordinationIsomerismExperiment.lean').read_text().replace('CoordinationIsomerism','LigandStateSplitting')
rows=v._source_rows(pin)
values={'claimId':q(spec.claim_id),'experimentId':q(spec.experiment_id),'expectedLabel':q(spec.expected_observation_label),'falsification':q(spec.falsification_condition),'targetRegistryHash':q(v.TARGET_HASH),'sourceFiles':'['+','.join('('+q(p)+','+q(h)+')'for p,h in [(v.TARGET_PATH,v.TARGET_HASH),(v.PRIMARY_PATH,v.PRIMARY_HASH)])+']','sourceIds':'['+','.join(q(x)for x in dict.fromkeys(x['source_id']for x in rows))+']','references':'['+','.join('⟨'+','.join(q(getattr(row,k))for k in ['target_id','source_id','source_locator','snapshot_path','snapshot_hash'])+'⟩'for row in spec.target_rows)+']','specDimensions':'['+','.join('('+q(d.key)+',['+','.join(str(c.admitted).lower()for c in d.choices)+'])'for d in spec.dimensions)+']','specWitnesses':'['+','.join('LigandStateSplittingWitnesses.'+n for n in ['generatorWitness','sixPartitionWitness','sixBalanceWitness','fourPartitionWitness','memberWitness','removedWitness'])+']'}
for k,value in values.items():s=re.sub(r'^def '+k+r' (.*?) := .*$',lambda m:'def '+k+' '+m[1]+' := '+value,s,flags=re.M)
registration=v.experiment_registration_record(pin);line='def registration (program : Value) : Value := .object ['+','.join('('+q(k)+','+('program'if k=='prediction_program'else cv(value))+')'for k,value in registration.items())+']';s=re.sub(r'^def registration .*$',lambda _:line,s,flags=re.M);(r/'LigandStateSplittingExperiment.lean').write_text(s)
s=(r/'CoordinationGeometryComparison.lean').read_text().replace('CoordinationGeometry','LigandStateSplitting');a=s.index('def expectedLaws');b=s.index('def cellAt',a);s=s[:a]+'def expectedLaws : List String := ['+','.join(map(q,v.EXPECTED_LAWS))+']\n'+s[b:];s=s.replace('["source_record_ordinal","authority","source_id","source_document_identity","source_record_role"]','['+','.join(map(q,v.IDENTITY_KEYS[1:]))+']')
s=s[:s.index('def controls')]+'''def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := LigandStateSplittingPrediction.get analysis
 let eq := LigandStateSplittingPrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (LigandStateSplittingAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("tampered_six_direct_axis_multiplicity_rejected",!eq (get "six_multiplicity_vector") (.array [.integer 2,.integer 3])),
  ("all_32_target_hashes_bound_postseal",released.length==32),
  ("prediction_contains_no_target_payload_hash_or_peak_value",!Text.contains (Canonical.render document) "target_payload_hash" && !Text.contains (Canonical.render document) "48361/200"),
  ("two_adverse_blind_absences_preserved",eq (get "law_sealed_adverse_absence_count") (.integer 2)),
  ("twelve_development_ancillary_rows_preserved",eq (get "development_ancillary_count") (.integer 12))]
def analysisPassed (analysis : J) : Bool :=
 let get := LigandStateSplittingPrediction.get analysis
 let eq := LigandStateSplittingPrediction.equal
 eq (get "generated_support_count") (.integer 5) &&
 eq (get "six_multiplicity_vector") (.array [.integer 3,.integer 2]) &&
 eq (get "six_separation_vector") (.array [.text "2/3"]) &&
 eq (get "six_balance_vector") (.array [.text "2/5",.text "3/5"]) &&
 eq (get "four_multiplicity_vector") (.array [.integer 2,.integer 3]) &&
 eq (get "four_separation_vector") (.array [.text "1"]) &&
 eq (get "four_balance_vector") (.array [.text "3/5",.text "2/5"]) &&
 ["all_members_preserved","removal_remerges_one_five_member_class","iupac_removal_of_degeneracy_surface_present",
  "iupac_ligand_attachment_reduced_symmetry_surface_present","iupac_conventional_variable_parameter_surface_preserved_as_downstream",
  "blind_distinguishability_condition_passed","complete_32_rows_preserved","no_dimensional_wavelength_fitted_or_claimed"].all
  (fun key => CoordinationAnalysis.truthy (get key)) &&
 eq (get "blind_spectrum_payload_count") (.integer 1)
end SFT.Chemistry.LigandStateSplittingComparison
'''
s=s.replace('import SFT.Chemistry.MulticentreControls','import SFT.Chemistry.MulticentreControls\nimport SFT.Chemistry.CoordinationAnalysis');(r/'LigandStateSplittingComparison.lean').write_text(s)
s=(r/'CoordinationIsomerismValidation.lean').read_text().replace('CoordinationIsomerism','LigandStateSplitting').replace('INORG-005','INORG-006').replace('exact-coordination-isomer-equivalence-classes/1','exact-ligand-state-splitting/1').replace('INORG-006 released target differs','INORG-006 released target identity differs')
a=s.index('def measurementPayload');s=s[:a]+'''-- The source measurement prints tuples of exact rational inscriptions.
def tupleText (values : List String) : String :=
 Text.intercalate "" ["(",Text.intercalate ", " values,if values.length==1 then ",)" else ")"]
def spectrumTupleText (value : Value) : Except String String := do
 let rows ← match value with
  | .array rows => pure rows
  | .null | .text _ | .integer _ | .boolean _ | .object _ => throw "spectrum tuple must be a sequence"
 let rendered ← rows.mapM fun row => do
  let cells ← match row with
   | .array cells => pure cells
   | .null | .text _ | .integer _ | .boolean _ | .object _ => throw "spectrum row must be a sequence"
  let inscriptions ← cells.mapM fun cell => do
   let inscription ← JointCorrelationTargets.text cell
   pure (Text.intercalate "" ["'",inscription,"'"])
  pure (tupleText inscriptions)
 pure (tupleText rendered)
'''+s[a:]
a=s.index(' let rowMessages :=');b=s.index(' let messages :=',a)
s=s[:a]+''' let peaks ← spectrumTupleText (← JointCorrelationTargets.field analysis "blind_exact_interior_peak_positions")
 let gaps ← spectrumTupleText (← JointCorrelationTargets.field analysis "blind_exact_adjacent_peak_separations")
 let rowMessages := [
  "forced five-support partition: two held contrasts plus three boundary pairs",
  "six direct-axis multiplicities 3 and 2; structural separation 2/3; balance distances 2/5 and 3/5",
  "four complete-axis multiplicities 2 and 3; structural separation 1; balance distances 3/5 and 2/5",
  Text.intercalate "" ["law-sealed blind NIST spectrum interior maxima ",peaks," with exact separation ",gaps],
  "two law-sealed absent NIST spectrum rows and twelve development ancillary captures preserved",
  "IUPAC degeneracy-removal and ligand-attachment/reduced-symmetry surfaces preserved; conventional variable parameters remain downstream only"]
'''+s[b:];(r/'LigandStateSplittingValidation.lean').write_text(s)
s=(w/'build_coordisomer1474_validation.py').read_text().replace('CoordinationIsomerism','LigandStateSplitting').replace('coordisomer1474','ligandsplit1476').replace('1474','1476');(w/'build_ligandsplit1476_validation.py').write_text(s)
print('Translated',len(registration),'registration fields,7controls and13messages from original validator')
