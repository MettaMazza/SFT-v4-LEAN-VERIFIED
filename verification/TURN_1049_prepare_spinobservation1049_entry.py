from pathlib import Path
import json,re,sys,dataclasses,shutil
w=Path('work');r=w/'constants-recovery/SFT/Physics';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.spin_statistics_condensation_empirical_v1 import SPEC
meta=dataclasses.asdict(SPEC);dimensions=meta.pop('dimensions');witnesses=meta.pop('operational_witnesses');meta['target_rows']=[list(row.values()) for row in meta['target_rows']];values=meta;tag='SpinCondensation';q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d['key'],[[x['name'],x['reason']] for x in d['choices']]] for d in dimensions]
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(y) for y in x)+']'
 raise TypeError(x)
def renameIdentity(s):return re.sub(r'"(?:\\.|[^"\\])*"|(?<![\w.])\bidentity\b',lambda m:'admissionIdentity' if m.group()=='identity' else m.group(),s)
s='import SFT.Physics.SpinStatisticsCertificateProof\nnamespace SFT.Physics.SpinCondensationWitnesses\nopen SpinStatisticsCondensationCertificate SpinStatisticsCertificateProof\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
checks=['occupation','weights','spin','cold']
for name in checks:s+='def formal'+name.capitalize()+' : Bool := match certificate with | .error _ => false | .ok c => c.'+name+'\n'
s+='def witnesses : List Witness := ['+','.join('⟨'+q(row[0])+','+q(row[1])+',formal'+check.capitalize()+'⟩' for row,check in zip(witnesses,checks))+']\n'
for name in checks:s+='theorem formal'+name.capitalize()+'Passed : formal'+name.capitalize()+'=true := by decide +kernel\n'
s+='theorem allWitnessesPass : witnesses.all Witness.passed=true := by\n unfold witnesses\n change (formalOccupation && (formalWeights && (formalSpin && (formalCold && true)))) = true\n rw [formalOccupationPassed,formalWeightsPassed,formalSpinPassed,formalColdPassed]\n rfl\nend SFT.Physics.SpinCondensationWitnesses\n'
(r/f'{tag}Witnesses.lean').write_text(s)
base=(w/'prepare_sector_program875.py').read_text();body=base[base.index(" s=(r/'RadioactivityEvidence.lean')"):base.index(' extra=')];body=body.replace('import SFT.Physics.SectorAnchorRecords\\n','');exec(compile('\n'.join(line[1:] for line in body.splitlines()),'empirical-source-template','exec'))
# The custom source validator is assembled separately; do not install the generic blind validator.
p=r/f'{tag}Experiment.lean';s=p.read_text().replace('targetRows.length = 1','targetRows.length = 3').replace('= [expectedLabel] := rfl','= [expectedLabel,expectedLabel,expectedLabel] := rfl');p.write_text(s)
gen=(w/'generate_sectorvalidation873.py').read_text();gen=gen[gen.index('template='):];gen=gen.replace('PrecisionValidationWitnesses','SpinCondensationWitnesses').replace('SectorValidationGrammar','SpinCondensationGrammar');grammarDims=[];axisChoices={};fields=[];cs={'GENERATION_RULE':values['generation_rule'],'GRAMMAR_BOUNDARY':values['grammar_boundary']}
for d in dimensions:
 bad,good=d['choices'];k=d['key'];assert not bad['admitted'] and good['admitted'];grammarDims.append([k,'',bad['name'],bad['reason'],good['name'],good['reason']]);axisChoices[k]=[(x['name'],x['reason']) for x in d['choices']];fields.append((k,k.capitalize(),['rejected','admitted'],k.upper(),1));cs[k.upper()]=[x['name'] for x in d['choices']]
cs['SURVIVOR']='__'.join(d[4] for d in grammarDims);lit=lambda k:values[k];scope=dict(r=w/'constants-recovery',Path=Path,ast=None,json=json,re=re,dims=grammarDims,axisChoices=axisChoices,fields=fields,cs=cs,q=q,lit=lit);exec(compile(gen,'source-grammar','exec'),scope)
for suffix in ['Witnesses','Grammar','Evidence']:shutil.copy2(r/f'{tag}{suffix}.lean',c/f'SFT/Physics/{tag}{suffix}.lean')
(w/'spinobservation1049_spec.json').write_text(json.dumps(dict(values=values,dimensions=dims),indent=2));print('Prepared original256grammar,3witness bindings and source metadata; custom validator not generated')

p=c/'SFT/Physics/SpinCondensationEvidence.lean'
p.write_text(p.read_text().replace('provenance := [.forwardForcing]','provenance := [.observationalDerivation]'))
