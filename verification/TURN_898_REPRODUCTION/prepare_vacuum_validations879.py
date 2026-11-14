from pathlib import Path
import json,re
w=Path('work');r=w/'constants-recovery/SFT/Physics'
items=[('FLOOR','VacuumFloorValidation',879,['floorCheck'],'floorClassification'),('POLARIZATION','VacuumPolarizationValidation',880,['nonoverlapCheck','polarizationCheck'],'polarizationClassification'),('INERTIA','VacuumInertiaValidation',881,['inertiaCheck'],'inertiaClassification'),('EXTRACTION','VacuumExtractionValidation',882,['extractionCheck'],'extractionClassification')]
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(y) for y in x)+']'
 raise TypeError(x)
def renameIdentity(s):return re.sub(r'"(?:\\.|[^"\\])*"|(?<![\w.])\bidentity\b',lambda m:'admissionIdentity' if m.group()=='identity' else m.group(),s)
base=Path('work/prepare_sector_program875.py').read_text();body=base[base.index(" s=(r/'RadioactivityEvidence.lean')"):base.index(" extra=")]
body=body.replace('SFT.Physics.SectorAnchorRecords','SFT.Physics.VacuumAuthoritativeRecords')
for key,tag,n,checks,classify in items:
 meta=json.loads((w/f'SFT-PHYS-VALIDATION-VACUUM-{key}-003_spec879.json').read_text());values=meta['values'];dims=[[d['key'],[[x['name'],x['reason']] for x in d['choices']]] for d in meta['dimensions']]
 s='import SFT.Physics.VacuumAuthoritativeWitnesses\nnamespace SFT.Physics.'+tag+'Witnesses\nopen VacuumAuthoritativeWitnesses\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
 s+='def witnesses : List Witness := ['+','.join('⟨'+q(row[0])+','+q(row[1])+','+check+'⟩' for row,check in zip(meta['witnesses'],checks))+']\n'
 s+='theorem allWitnessesPass : witnesses.all Witness.passed=true := by\n change ('+' && '.join(checks+['true'])+')=true\n rw ['+','.join(x+'Passed' for x in checks)+']\n rfl\nend SFT.Physics.'+tag+'Witnesses\n';(r/f'{tag}Witnesses.lean').write_text(s)
 exec(compile('\n'.join(line[1:] for line in body.splitlines()),'original-empirical-template','exec'))
 extra=f'''\ndef validateExternal (snapshot : ByteArray) (files : List (String × ByteArray))
 (record : Value) (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 let result ← VacuumAuthoritativeRecords.{classify} snapshot files record
 let label := {'result.1' if classify=='polarizationClassification' else 'result'}
 if !Text.equal label expectedLabel then
  .error "authoritative vacuum classification differs from registration"
 else validate snapshot derivationSeal host implementation before after
'''
 (r/f'{tag}Validation.lean').write_text(s[:-len(end)]+extra+end)
 (w/f'{tag.lower()}{n}_spec.json').write_text(json.dumps(dict(values=values,dimensions=dims),indent=2))
 # Reuse the existing complete grammar generator with exact original dimensions.
 gen=Path('work/generate_sectorvalidation873.py').read_text();gen=gen[gen.index('template='):]
 gen=gen.replace('PrecisionValidationWitnesses','VacuumAuthoritativeWitnesses').replace('SectorValidationGrammar',tag+'Grammar')
 grammarDims=[];axisChoices={};fields=[];cs={'GENERATION_RULE':values['generation_rule'],'GRAMMAR_BOUNDARY':values['grammar_boundary']}
 for d in meta['dimensions']:
  assert len(d['choices'])==2 and [x['admitted'] for x in d['choices']]==[False,True]
  bad,good=d['choices'];k=d['key'];grammarDims.append([k,'',bad['name'],bad['reason'],good['name'],good['reason']]);axisChoices[k]=[(x['name'],x['reason']) for x in d['choices']];fields.append((k,k.capitalize(),['rejected','admitted'],k.upper(),1));cs[k.upper()]=[x['name'] for x in d['choices']]
 cs['SURVIVOR']='__'.join(d[4] for d in grammarDims);lit=lambda k:values[k]
 scope=dict(r=w/'constants-recovery',Path=Path,ast=None,json=json,re=re,dims=grammarDims,axisChoices=axisChoices,fields=fields,cs=cs,q=q,lit=lit)
 exec(compile(gen,'original-complete-grammar-template','exec'),scope)
 print(tag,'original witnesses,full grammar,program,experiment and external wrapper prepared',flush=True)
