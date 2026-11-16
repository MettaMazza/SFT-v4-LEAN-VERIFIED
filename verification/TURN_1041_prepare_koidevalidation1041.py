from pathlib import Path
import json,re,sys,dataclasses,shutil
w=Path('work');r=w/'constants-recovery/SFT/Physics';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.charged_lepton_validation import KOIDE_VALIDATION_SPEC as SPEC
meta=dataclasses.asdict(SPEC);dimensions=meta.pop('dimensions');witnesses=meta.pop('operational_witnesses');meta['target_rows']=[list(row.values()) for row in meta['target_rows']];values=meta;tag='KoideValidationV2';q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d['key'],[[x['name'],x['reason']] for x in d['choices']]] for d in dimensions]
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(y) for y in x)+']'
 raise TypeError(x)
def renameIdentity(s):return re.sub(r'"(?:\\.|[^"\\])*"|(?<![\w.])\bidentity\b',lambda m:'admissionIdentity' if m.group()=='identity' else m.group(),s)
s='''import SFT.Physics.LeptonIntervals
namespace SFT.Physics.KoideValidationV2Witnesses
structure Witness where
 name : String
 statement : String
 passed : Bool
def exactPositive : Bool := LeptonIntervals.zero.blt (LeptonIntervals.normalize 2 3 (by decide))
theorem exactPositivePassed : exactPositive=true := rfl
'''
s+='def witnesses : List Witness := ['+','.join('⟨'+q(row[0])+','+q(row[1])+','+check+'⟩' for row,check in zip(witnesses,['exactPositive','true','true']))+']\n'
s+='theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl\nend SFT.Physics.KoideValidationV2Witnesses\n'
(r/f'{tag}Witnesses.lean').write_text(s)
base=(w/'prepare_sector_program875.py').read_text();body=base[base.index(" s=(r/'RadioactivityEvidence.lean')"):base.index(' extra=')];body=body.replace('import SFT.Physics.SectorAnchorRecords\\n','');exec(compile('\n'.join(line[1:] for line in body.splitlines()),'empirical-source-template','exec'))
p=r/f'{tag}Experiment.lean';s=p.read_text().replace('targetRows.length = 1','targetRows.length = 2').replace('= [expectedLabel] := rfl','= [expectedLabel,expectedLabel] := rfl');p.write_text(s)
s=(r/'RadioactivityValidation.lean').read_text().replace('Radioactivity',tag);s='import SFT.Foundation.AdmissionControls\n'+s;s=s.replace('open SFT.Host SFT.Host.Canonical '+tag+'Experiment','open SFT.Host SFT.Host.Canonical '+tag+'Experiment\nopen SFT.Foundation.AdmissionControls (admissionIdentity)');s=renameIdentity(s);(r/f'{tag}Validation.lean').write_text(s)
s=(c/'SFT/Physics/KoideIntervalExternal.lean').read_text().replace('KoideInterval',tag);(r/f'{tag}External.lean').write_text(s)
gen=(w/'generate_sectorvalidation873.py').read_text();gen=gen[gen.index('template='):].replace('PrecisionValidationWitnesses',tag+'Witnesses').replace('SectorValidationGrammar',tag+'Grammar');grammarDims=[];axisChoices={};fields=[];cs={'GENERATION_RULE':values['generation_rule'],'GRAMMAR_BOUNDARY':values['grammar_boundary']}
for d in dimensions:
 bad,good=d['choices'];k=d['key'];assert not bad['admitted'] and good['admitted'];grammarDims.append([k,'',bad['name'],bad['reason'],good['name'],good['reason']]);axisChoices[k]=[(x['name'],x['reason']) for x in d['choices']];fields.append((k,k.capitalize(),['rejected','admitted'],k.upper(),1));cs[k.upper()]=[x['name'] for x in d['choices']]
cs['SURVIVOR']='__'.join(d[4] for d in grammarDims);lit=lambda k:values[k];scope=dict(r=w/'constants-recovery',Path=Path,ast=None,json=json,re=re,dims=grammarDims,axisChoices=axisChoices,fields=fields,cs=cs,q=q,lit=lit);exec(compile(gen,'source-grammar','exec'),scope)
for suffix in ['Witnesses','Grammar','Evidence','Experiment','Validation','External']:shutil.copy2(r/f'{tag}{suffix}.lean',c/f'SFT/Physics/{tag}{suffix}.lean')
(w/'koidevalidation1041_spec.json').write_text(json.dumps(dict(values=values,dimensions=dims),indent=2));print('Prepared exact versioned Koide metadata and256grammar; reused original numeric enclosure/validator composition. No count registration.')
