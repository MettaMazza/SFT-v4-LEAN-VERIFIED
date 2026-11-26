from pathlib import Path
import sys,json,re,ast
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';pin=w/'pinned_coordisomer1473';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((pin/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import coordination_isomerism_validation_v1 as v
spec=v.COORDINATION_ISOMERISM_SPEC;q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(tuple,list)):return '.array ['+','.join(map(cv,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(y)+')'for k,y in x.items())+']'
 raise TypeError(type(x))
s=(r/'CoordinationGeometryExperiment.lean').read_text().replace('CoordinationGeometry','CoordinationIsomerism');s=s.replace('import SFT.Chemistry.CoordinationIsomerism\n','import SFT.Chemistry.CoordinationIsomerism\nimport SFT.Chemistry.CoordinationIsomerismWitnesses\n')
values={'claimId':q(spec.claim_id),'experimentId':q(spec.experiment_id),'expectedLabel':q(spec.expected_observation_label),'falsification':q(spec.falsification_condition),'targetRegistryHash':q(v.TARGET_HASH),'sourceFiles':'['+','.join('('+q(p)+','+q(h)+')'for p,h in [(v.TARGET_PATH,v.TARGET_HASH),(v.PRIMARY_PATH,v.PRIMARY_HASH),*v.SOURCE_FILES])+']','sourceIds':'["IUPAC-GOLD-BOOK-I03294","IUPAC-GOLD-BOOK-C01093","IUPAC-GOLD-BOOK-E02069","IUPAC-RED-BOOK-2005"]','references':'['+','.join('⟨'+','.join(q(getattr(row,k))for k in ['target_id','source_id','source_locator','snapshot_path','snapshot_hash'])+'⟩'for row in spec.target_rows)+']','specDimensions':'['+','.join('('+q(d.key)+',['+','.join(str(c.admitted).lower()for c in d.choices)+'])'for d in spec.dimensions)+']','specWitnesses':'['+','.join('CoordinationIsomerismWitnesses.'+n+'Witness'for n in ['equivalence','attachment','mirror','orientation','successor'])+']'}
for k,value in values.items():s=re.sub(r'^def '+k+r' (.*?) := .*$',lambda m:'def '+k+' '+m[1]+' := '+value,s,flags=re.M)
registration=v.experiment_registration_record(pin);line='def registration (program : Value) : Value := .object ['+','.join('('+q(k)+','+('program'if k=='prediction_program'else cv(value))+')'for k,value in registration.items())+']';s=re.sub(r'^def registration .*$',lambda _:line,s,flags=re.M);(r/'CoordinationIsomerismExperiment.lean').write_text(s)
s=(r/'CoordinationGeometryComparison.lean').read_text().replace('CoordinationGeometry','CoordinationIsomerism');a=s.index('def expectedLaws');b=s.index('def cellAt',a);laws=json.load(open(w/'coordisomer1474_laws.json'));s=s[:a]+'def expectedLaws : List String := ['+','.join(map(q,laws))+']\n'+s[b:]
s=s.replace('["source_record_ordinal","authority","source_id","source_document_identity","source_record_role"]','['+','.join(map(q,v.IDENTITY_KEYS[1:]))+']').replace('cells.drop 6','cells.drop 7');s=s[:s.index('def controls')]+'''def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (targetHash : String) : Except String (List (String × Bool)) := do
 let different ← field analysis "different_composition_rejected"
 let redirectCount ← field analysis "registered_to_presented_identity_redirect_count"
 let redirects ← field analysis "registered_to_presented_identity_redirects_preserved"
 let absence ← field analysis "explicit_linkage_literal_absence_preserved"
 let third := CoordinationIsomerismAnalysis.makeForm ["L","L"] ["mode-one","mode-one"]
  [["fibre-one","EmptyOne","EmptyOne"],["fibre-three","EmptyOne","EmptyOne"]] [(1,2)]
 return [("tampered_omitted_source_record_rejected",StateSymmetryControls.rejected (CoordinationIsomerismAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("third_fibre_label_rejected",StateSymmetryControls.rejected third),
  ("different_composition_rejected",CoordinationAnalysis.truthy different),
  ("both_presented_identity_redirects_preserved",CoordinationIsomerismPrediction.equal redirectCount (.integer 2) && CoordinationAnalysis.truthy redirects),
  ("explicit_linkage_literal_absence_preserved",CoordinationAnalysis.truthy absence),
  ("complete_17_record_vector_retained",released.length==17),
  ("prediction_contains_no_withheld_target_hash_or_inscription",!Text.contains (Canonical.render document) targetHash && !Text.contains (Canonical.render document) "source_inscription")]

def analysisPassed (analysis : J) : Bool := match analysis with
 | .object fs =>
  let booleans := fs.all fun (key,value) =>
   if Text.equal key "imported_catalogue_or_observed_class_used_as_fold_parameter" then true
   else match value with
    | .boolean b => b
    | .null | .text _ | .integer _ | .array _ | .object _ => true
  let get := CoordinationIsomerismPrediction.get analysis
  booleans && CoordinationIsomerismPrediction.equal (get "registered_to_presented_identity_redirect_count") (.integer 2) &&
   CoordinationIsomerismPrediction.equal (get "imported_catalogue_or_observed_class_used_as_fold_parameter") (.boolean false)
 | .null | .text _ | .boolean _ | .integer _ | .array _ => false
end SFT.Chemistry.CoordinationIsomerismComparison
''';(r/'CoordinationIsomerismComparison.lean').write_text(s)
s=(r/'CoordinationGeometryValidation.lean').read_text().replace('CoordinationGeometry','CoordinationIsomerism').replace('INORG-004','INORG-005').replace('exact-coordination-geometry-held-orientation-law/1','exact-coordination-isomer-equivalence-classes/1')
a=s.index('def integerText');b=s.index('def measurementPayload',a);s=s[:a]+s[b:];a=s.index(' let counts ← vectorText');b=s.index(' let messages :=',a)
tree=ast.parse((pin/'sft/chemistry/coordination_isomerism_validation_v1.py').read_text());messages=next(ast.literal_eval(n.value.left)for n in ast.walk(tree)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets));s=s[:a]+' let rowMessages := ['+','.join(map(q,messages))+']\n'+s[b:];(r/'CoordinationIsomerismValidation.lean').write_text(s)
s=(w/'build_coordgeometry1446_validation.py').read_text().replace('CoordinationGeometry','CoordinationIsomerism').replace('coordgeometry1446','coordisomer1474').replace('1446','1474');(w/'build_coordisomer1474_validation.py').write_text(s)
print('Translated original20field registration,17identities,8controls and14messages')
