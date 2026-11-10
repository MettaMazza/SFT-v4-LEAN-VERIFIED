from pathlib import Path
import ast,dataclasses,json,subprocess,re
w=Path('work');r=w/'constants-recovery';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def raw(path):return subprocess.check_output(['git','-C',repo,'show',pin+':'+path],text=True)
ns={'dataclass':dataclasses.dataclass}
groups=[('sft/physics/generated_empirical_law.py',{'LawChoice','LawDimension','ExternalTargetRow','EmpiricalPhysicsSpec','dimension','empirical_dimensions'}),('sft/physics/measured_value.py',{'MeasuredQuantity','ExactRelationStep','ExactMeasuredValueSpec','CODATA_SOURCE_ID','CODATA_SOURCE_PATH','CODATA_SOURCE_HASH'}),('sft/physics/measured_value_backfill_laws.py',{'validation_law','value_spec','MOLAR_PLANCK','MECHANICS_MOMENTUM','MECHANICS_FORCE','FIELD_POTENTIAL','FIELD_STRENGTH','WAVE_FREQUENCY','WAVE_ENERGY','THERMAL_MOLAR','BACKFILL_SPECS','VALUE_SPECS'})]
for path,names in groups:
 tree=ast.parse(raw(path));nodes=[n for n in tree.body if getattr(n,'name',None) in names or isinstance(n,ast.Assign) and getattr(n.targets[0],'id',None) in names];exec(compile(ast.Module(body=nodes,type_ignores=[]),path,'exec'),ns)
items=[];template=(r/'SFT/Physics/MassEnergyMeasured.lean').read_text();q=lambda s:json.dumps(s,ensure_ascii=False)
for law in ns['BACKFILL_SPECS']:
 spec=ns['VALUE_SPECS'][law.claim_id];law.validate();spec.validate()
 stem={'molar-planck-product':'MolarPlanck','momentum-mass-speed-product':'MeasuredMomentum','force-energy-length-quotient':'MeasuredForce','potential-energy-charge-quotient':'MeasuredPotential','electric-field-potential-length-quotient':'MeasuredField','frequency-inverse-length-speed-product':'MeasuredFrequency','energy-inverse-length-planck-speed-product':'MeasuredWaveEnergy','molar-thermal-product':'MolarThermal'}[spec.relation_id]
 module='Backfill'+stem
 s=template.replace('import SFT.Physics.MassEnergyValidation','import SFT.Physics.UnitValidation').replace('namespace SFT.Physics.MassEnergyMeasured','namespace SFT.Physics.'+module).replace('end SFT.Physics.MassEnergyMeasured','end SFT.Physics.'+module).replace('MassEnergyValidation','UnitValidation')
 for key,value in [('experimentId',spec.experiment_id),('claimId',spec.claim_id),('snapshotHash',spec.source_snapshot_hash),('sourceId',spec.source_id),('relationId',spec.relation_id),('relationStatement',spec.relation_statement),('falsification',spec.falsification_condition),('targetId',spec.target.key+'__withheld_interval'),('targetQuantity',spec.target.quantity)]:
  s=re.sub(r'^def '+key+r' := .*$',lambda _: 'def '+key+' := '+q(value),s,flags=re.M)
 instructions=[]
 for x in spec.inputs:
  for side in ['lower','upper']:instructions.append(('input',x.key+'__'+side,[x.key+'__'+side]))
 for step in spec.steps:
  for side in ['lower','upper']:
   right=side if step.operation=='product' else ('upper' if side=='lower' else 'lower')
   instructions.append((step.operation,step.output+'__'+side,[step.left+'__'+side,step.right+'__'+right]))
 instructions += [('pair','predicted_interval',[spec.output_key+'__lower',spec.output_key+'__upper']),('emit','',['predicted_interval'])]
 a=s.index('def program :');b=s.index('\ndef programFields',a)
 s=s[:a]+'def program : CapabilityAdmission.Program := ⟨Text.append experimentId "-exact-measured-value",[\n'+',\n'.join(' ⟨.'+op+','+q(dest)+',['+','.join(q(x) for x in args)+']⟩' for op,dest,args in instructions)+']⟩\n'+s[b:]
 a=s.index(' ("input_quantities",');b=s.index('\n ("source_id",',a)
 s=s[:a]+' ("input_quantities",.array ['+','.join('.array [.text '+q(x.key)+',.text '+q(x.quantity)+',.text '+q(x.unit)+']' for x in spec.inputs)+']),\n ("withheld_target_identity",.array [.text targetId,.text targetQuantity,.text '+q(spec.target.unit)+']),'+s[b:]
 a=s.index('def inputs ');b=s.index('\ndef envelope',a)
 s=s[:a]+'def inputs '+' '.join('('+x.key+' : Interval)' for x in spec.inputs)+' : Except String (List (String × CapabilityValues.Value)) := do\n .ok ['+','.join('('+q(x.key+'__'+side)+',← ratioValue '+x.key+'.'+side+')' for x in spec.inputs for side in ['lower','upper'])+']\n'+s[b:]
 s=s.replace('MassEnergyExperiment.sourceMatches','sourceMatches')
 a=s.index('def validate ');s=s[:a]+'def sourceMatches (bytes : ByteArray) : Bool := Text.equal (Text.append "sha256:" (SFT.Host.SHA256Window.digest bytes)) snapshotHash\n\n'+s[a:]
 a=s.index('  let mass ←');b=s.index('  let targetPair',a)
 s=s[:a]+''.join('  let '+x.key+' ← loadRows rows '+q(x.quantity)+' '+q(x.unit)+'\n' for x in spec.inputs)+'  let target ← loadRows rows targetQuantity '+q(spec.target.unit)+'\n  let parsed ← CapabilityDocuments.loadProgramFields programFields\n  let values ← inputs '+' '.join(x.key for x in spec.inputs)+'\n'+s[b:]
 assert 'MassEnergy' not in s
 (r/'SFT/Physics'/(module+'.lean')).write_text(s)
 items.append({'stem':stem,'module':module,'claim_id':law.claim_id,'law':dataclasses.asdict(law),'value_spec':dataclasses.asdict(spec),'instructions':instructions})
(w/'backfill534_metadata.json').write_text(json.dumps(items,indent=2)+'\n');print('Staged',len(items),'source-specialized numeric adapters, reusing existing exact parser/runtime/custody.')
