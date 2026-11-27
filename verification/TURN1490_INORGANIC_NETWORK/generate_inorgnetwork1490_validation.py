from pathlib import Path
import sys,json,re,ast
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';pin=w/'pinned_inorgnetwork1490';sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__=[str((pin/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import inorganic_acid_base_redox_network_validation_v1 as v
spec=v.INORGANIC_ACID_BASE_REDOX_NETWORK_SPEC;q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer '+str(x)
 if isinstance(x,(tuple,list)):return '.array ['+','.join(map(cv,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(y)+')'for k,y in x.items())+']'
 raise TypeError(type(x))
s=(r/'CoordinationIsomerismExperiment.lean').read_text().replace('CoordinationIsomerism','InorganicNetwork').replace('InorganicNetworkWitnesses','InorganicNetworkWitnesses')
rows=v._source_rows(pin)
values={'claimId':q(spec.claim_id),'experimentId':q(spec.experiment_id),'expectedLabel':q(spec.expected_observation_label),'falsification':q(spec.falsification_condition),'targetRegistryHash':q(v.TARGET_HASH),'sourceFiles':'['+','.join('('+q(p)+','+q(h)+')'for p,h in [(v.TARGET_PATH,v.TARGET_HASH),(v.PRIMARY_PATH,v.PRIMARY_HASH)])+']','sourceIds':'['+','.join(q(x)for x in dict.fromkeys(x['source_id']for x in rows))+']','references':'['+','.join('⟨'+','.join(q(getattr(row,k))for k in ['target_id','source_id','source_locator','snapshot_path','snapshot_hash'])+'⟩'for row in spec.target_rows)+']','specDimensions':'['+','.join('('+q(d.key)+',['+','.join(str(c.admitted).lower()for c in d.choices)+'])'for d in spec.dimensions)+']','specWitnesses':'['+','.join('InorganicNetworkWitnesses.'+n for n in ['lewisWitness','redoxWitness','reverseWitness','successorWitness','speciesWitness'])+']'}
for k,value in values.items():s=re.sub(r'^def '+k+r' (.*?) := .*$',lambda m:'def '+k+' '+m[1]+' := '+value,s,flags=re.M)
registration=v.experiment_registration_record(pin);line='def registration (program : Value) : Value := .object ['+','.join('('+q(k)+','+('program'if k=='prediction_program'else cv(value))+')'for k,value in registration.items())+']';s=re.sub(r'^def registration .*$',lambda _:line,s,flags=re.M);(r/'InorganicNetworkExperiment.lean').write_text(s)
s=(r/'CoordinationGeometryComparison.lean').read_text().replace('CoordinationGeometry','InorganicNetwork');a=s.index('def expectedLaws');b=s.index('def cellAt',a);s=s[:a]+'def expectedLaws : List String := ['+','.join(map(q,v.EXPECTED_LAWS))+']\n'+s[b:];s=s.replace('["source_record_ordinal","authority","source_id","source_document_identity","source_record_role"]','['+','.join(map(q,v.IDENTITY_KEYS[1:]))+']')
s=s.replace('cells.drop 6','cells.drop 7');s=s[:s.index('def controls')]+'def controls (rows : List J) (_primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do\n let get := InorganicNetworkPrediction.get analysis\n let eq := InorganicNetworkPrediction.equal\n let acidRows := rows.filter (fun row => eq (InorganicNetworkPrediction.get row "source_record_role") (.text "acid-example-introduced-rendered-structure-absent"))\n let absence ← if acidRows.length==1 then do\n  let row ← match acidRows with | [] => .error "tuple index out of range" | row::_ => .ok row\n  let value ← JointCorrelationTargets.field (← JointCorrelationTargets.field row "source_outcome") "introduced_example_structure_present_after_colon"\n  pure (eq value (.boolean false))\n  else pure false\n return [("omitted_source_row_rejected",StateSymmetryControls.rejected (InorganicNetworkAnalysis.analysis (rows.take (rows.length-1)) (.object []))),\n ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),\n ("all_fifteen_target_hashes_bound_postseal",released.length==15),\n ("missing_network_species_rejected",CoordinationAnalysis.truthy (get "missing_species_rejected")),\n ("rendered_acid_example_absence_preserved",absence),\n ("signed_oxidation_number_downstream_only",!Text.contains InorganicNetworkGrammar.survivorId "signed-oxidation-number-arithmetic"),\n ("sources_not_recaptured",eq (get "source_recapture_count") (.integer 0)),\n ("prediction_contains_no_definition_example_criterion_or_target_payload",!["complete_definition_text","target_payload_hash","For example:","oxidation number"].any (fun token => Text.contains (Canonical.render document) token))]\ndef analysisPassed (analysis : J) : Bool :=\n let get := InorganicNetworkPrediction.get analysis\n let eq := InorganicNetworkPrediction.equal\n'
# Translate the original passed conjunction's literal comparisons and boolean fields directly from its AST.
module=ast.parse((pin/'sft/chemistry/inorganic_acid_base_redox_network_validation_v1.py').read_text());validate=next(n for n in ast.walk(module) if isinstance(n,ast.FunctionDef) and n.name=='validate');passed=next(n.value for n in validate.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='passed' for t in n.targets));terms=[]
for term in passed.values:
 if isinstance(term,ast.Call):continue # all(comparisons) and all(controls) are preserved by the reused Validation operation.
 if isinstance(term,ast.Subscript):terms.append('CoordinationAnalysis.truthy (get '+q(ast.literal_eval(term.slice))+')')
 elif isinstance(term,ast.Compare):
  assert len(term.ops)==1
  if isinstance(term.left,ast.Tuple):
   for left,right in zip(term.left.elts,ast.literal_eval(term.comparators[0])):
    terms.append('eq (get '+q(ast.literal_eval(left.slice))+') ('+cv(right)+')')
  else:terms.append('eq (get '+q(ast.literal_eval(term.left.slice))+') ('+cv(ast.literal_eval(term.comparators[0]))+')')
 else:raise ValueError(ast.dump(term))
s+=' '+ ' &&\n '.join(terms)+'\nend SFT.Chemistry.InorganicNetworkComparison\n';s=s.replace('import SFT.Chemistry.MulticentreControls','import SFT.Chemistry.MulticentreControls\nimport SFT.Chemistry.CoordinationAnalysis');s=s.replace('import SFT.Chemistry.CoordinationAnalysis','import SFT.Chemistry.CoordinationAnalysis\nimport SFT.Chemistry.InorganicNetworkGrammar');(r/'InorganicNetworkComparison.lean').write_text(s)
s=(r/'CoordinationIsomerismValidation.lean').read_text().replace('CoordinationIsomerism','InorganicNetwork').replace('INORG-005','INORG-017').replace('exact-coordination-isomer-equivalence-classes/1','exact-inorganic-acid-base-redox-network/1').replace('INORG-017 released target differs','INORG-017 released target identity differs')
a=s.index(' let rowMessages :=');b=s.index(' let messages :=',a)
s=s[:a]+''' let vectorHash ← JointCorrelationTargets.field analysis "complete_target_vector_hash" >>= JointCorrelationTargets.text
 let rowMessages := ["Lewis network: three species, one step, two retained pair occurrences and one retained adduct",
 "redox network: two species, one two-occurrence conserved transfer and exact reverse",
 "joint successor: five species and two ordered steps",
 "complete fifteen-row five-source Lewis/adduct/oxidation/reduction vector",
 "one introduced but unrendered acid example retained as explicit absence",
 Text.append "complete exact target vector " vectorHash]
'''+s[b:];s=s.replace('INORG-017 prediction package changed','INORG-017 package changed').replace('INORG-017 released target identity differs','INORG-017 target identity differs');s=s.replace('INORG-017 package changed','INORG-017 capability-closed package changed');(r/'InorganicNetworkValidation.lean').write_text(s)
