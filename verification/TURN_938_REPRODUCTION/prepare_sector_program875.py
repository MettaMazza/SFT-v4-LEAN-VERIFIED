from pathlib import Path
import ast,json,re,subprocess
w=Path('work');r=w/'constants-recovery/SFT/Physics';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';tree=ast.parse((w/'original873_sector_inventory_validation_v1.py').read_text());constants={}
for t in [tree,ast.parse(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/sector_inventory_law_v1.py'],text=True))]:
 for n in t.body:
  if isinstance(n,ast.Assign):
   try:constants[n.targets[0].id]=ast.literal_eval(n.value)
   except (TypeError,ValueError):pass
constants['FORMAL_CLAIM_ID']=constants['CLAIM_ID']
constants['CLAIM_ID']='SFT-PHYS-VALIDATION-FORCE-SECTOR-ANCHORS-003'
def lit(n):
 if isinstance(n,ast.Name):return constants[n.id]
 if isinstance(n,(ast.List,ast.Tuple)):return [lit(x) for x in n.elts]
 if isinstance(n,ast.Call):return [lit(x) for x in n.args]
 return ast.literal_eval(n)
def cv(x):
 if isinstance(x,str):return '.text '+json.dumps(x,ensure_ascii=False)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(y) for y in x)+']'
 raise TypeError(x)
q=lambda x:json.dumps(x,ensure_ascii=False)
def renameIdentity(s):
 return re.sub(r'"(?:\\.|[^"\\])*"|(?<![\w.])\bidentity\b',lambda m:'admissionIdentity' if m.group()=='identity' else m.group(),s)
fn=next(n for n in ast.parse((w/'generated_empirical_law372_source.py').read_text()).body if isinstance(n,ast.FunctionDef) and n.name=='empirical_dimensions')
for spec,tag in [('SPEC','SectorValidation')]:
 call=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')==spec);kw={k.arg:k.value for k in call.keywords};values={k:lit(v) for k,v in kw.items() if k not in ['operational_witnesses','dimensions']};bindings=dict(zip(['relation_name','relation_reason'],kw['dimensions'].args))
 class Sub(ast.NodeTransformer):
  def visit_Name(self,n):return bindings.get(n.id,n)
 axes=Sub().visit(ast.parse(ast.unparse(next(n.value for n in fn.body if isinstance(n,ast.Return))),mode='eval').body);dims=[]
 for axis in axes.elts:
  k,b,br,g,gr=map(lit,axis.args);dims.append([k,[[b,br],[g,gr]]])
 s=(r/'RadioactivityEvidence.lean').read_text().replace('Radioactivity',tag)
 s=s.replace('import SFT.Engine.RegistrationGate','import SFT.Engine.RegistrationGate\nimport SFT.Physics.'+tag+'Witnesses\nimport SFT.Foundation.AdmissionControls')
 s=s.replace('open SFT.Host.Canonical '+tag+'Grammar','open SFT.Host.Canonical '+tag+'Grammar\nopen SFT.Foundation.AdmissionControls (admissionIdentity)')
 a=s.index('def sourceResponseWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ('+tag+'Witnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])\n'+s[b:]
 s=re.sub(r'^def claimId.*$',lambda _: 'def claimId : String := '+q(values['claim_id']),s,flags=re.M)
 s=re.sub(r'^def dependencies.*$',lambda _: 'def dependencies : List String := '+q(values['dependencies']),s,flags=re.M)
 for k in ['title','statement']:s=re.sub(r'^ '+k+r' := .*$',lambda _,k=k:' '+k+' := '+q(values[k]),s,flags=re.M)
 a=s.index('def completenessRecord');b=s.index('def registrationData',a)
 s=s[:a]+'def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",'+cv(dims)+'),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]\n'+s[b:]
 a=s.index('def closureValue');b=s.index('def closureData',a)
 s=s[:a]+'def closureValue : Value := .object [("claim_id",.text claimId),("result",'+cv(values['exact_result'])+'),("base",'+cv(values['induction_base'])+'),("successor",'+cv(values['induction_step'])+'),("exclusions",'+cv(values['exclusions'])+'),("witnesses",witnesses),("survivor",.text survivorId)]\ndef exclusions : List String := '+q(values['exclusions'])+'\n'+s[b:]
 s=renameIdentity(s);(r/f'{tag}Evidence.lean').write_text(s)
 s=(r/'RadioactivityExperiment.lean').read_text().replace('Radioactivity',tag).replace('SHA256Window','SHA256Chunks');s=s.replace('namespace SFT.Physics.'+tag+'Experiment','import SFT.Foundation.AdmissionControls\nnamespace SFT.Physics.'+tag+'Experiment');s=s.replace('open SFT.Host SFT.Host.Canonical','open SFT.Host SFT.Host.Canonical\nopen SFT.Foundation.AdmissionControls (admissionIdentity)')
 fields={'claimId':'claim_id','experimentId':'experiment_id','expectedLabel':'expected_observation_label','frozenRelation':'exact_result','sourcePath':'source_snapshot_path','snapshotHash':'source_snapshot_hash','falsification':'falsification_condition'}
 for name,key in fields.items():s=re.sub(r'^def '+name+r' : String := .*$',lambda _,name=name,key=key:'def '+name+' : String := '+q(values[key]),s,flags=re.M)
 s=re.sub(r'^def targetRows.*$',lambda _:'def targetRows : List TargetRow := ['+','.join('⟨'+','.join(q(v) for v in row)+'⟩' for row in values['target_rows'])+']',s,flags=re.M)
 s=s.replace('targetRows.length = 2','targetRows.length = 1').replace('[expectedLabel,expectedLabel]','[expectedLabel]');s=re.sub(r'^def specDependencies.*$',lambda _:'def specDependencies : List String := '+q(values['dependencies']),s,flags=re.M);s=re.sub(r'^def specWitnesses.*$',lambda _:'def specWitnesses : Except String Bool := .ok ('+tag+'Witnesses.witnesses.all '+tag+'Witnesses.Witness.passed)',s,flags=re.M);s=renameIdentity(s);s=s.replace('import SFT.Foundation.AdmissionControls\n','');s='import SFT.Foundation.AdmissionControls\n'+s;(r/f'{tag}Experiment.lean').write_text(s)
 s=(r/'RadioactivityValidation.lean').read_text().replace('Radioactivity',tag);s=s.replace('namespace SFT.Physics.'+tag+'Validation','import SFT.Physics.SectorAnchorRecords\nimport SFT.Foundation.AdmissionControls\nnamespace SFT.Physics.'+tag+'Validation');s=s.replace('open SFT.Host SFT.Host.Canonical '+tag+'Experiment','open SFT.Host SFT.Host.Canonical '+tag+'Experiment\nopen SFT.Foundation.AdmissionControls (admissionIdentity)');s=renameIdentity(s)
 end='end SFT.Physics.'+tag+'Validation\n';assert s.endswith(end)
 extra='\ndef validateExternal (snapshot : ByteArray) (files : List (String × ByteArray))\n (record : Value) (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do\n let analysis ← SectorAnchorRecords.anchorRecord files record\n let anchors ← RunningConvergenceMeasurement.field analysis "anchors_pass"\n let predictions ← RunningConvergenceMeasurement.field analysis "standing_predictions_retained"\n if !RunningConvergenceMeasurement.sameValue anchors (.boolean true) ||\n    !RunningConvergenceMeasurement.sameValue predictions (.boolean true) then\n  .error "complete PDG sector anchor classification failed"\n else validate snapshot derivationSeal host implementation before after\n'
 (r/f'{tag}Validation.lean').write_text(s[:-len(end)]+extra+end)
 (w/f'{tag.lower()}875_spec.json').write_text(json.dumps(dict(values=values,dimensions=dims),indent=2))
print('Prepared exact empirical program,experiment and external-validator assemblies for two entries.')
