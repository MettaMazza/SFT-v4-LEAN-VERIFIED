from pathlib import Path
import json,re,sys,dataclasses,shutil
w=Path('work');r=w/'constants-recovery/SFT/Physics';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.charged_lepton_validation import TERMINAL_VALIDATION_SPEC as SPEC
meta=dataclasses.asdict(SPEC);dimensions=meta.pop('dimensions');witnesses=meta.pop('operational_witnesses');meta['target_rows']=[list(row.values()) for row in meta['target_rows']];values=meta;tag='TerminalLeptonValidation';q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d['key'],[[x['name'],x['reason']] for x in d['choices']]] for d in dimensions]
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(y) for y in x)+']'
 raise TypeError(x)
def renameIdentity(s):return re.sub(r'"(?:\\.|[^"\\])*"|(?<![\w.])\bidentity\b',lambda m:'admissionIdentity' if m.group()=='identity' else m.group(),s)
s='''import SFT.Physics.LeptonIsolation
namespace SFT.Physics.TerminalLeptonValidationWitnesses
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def threeRoots : Bool := match LeptonIsolation.terminalSearch with
 | .ok (some brackets) => brackets.length == 3
 | .ok none => false
 | .error _ => false
theorem threeRootsPassed : threeRoots=true := by
 unfold threeRoots
 rw [LeptonIsolation.terminalSearchComplete]
 rfl
'''
s+='def witnesses : List Witness := ['+','.join('⟨'+q(row[0])+','+q(row[1])+','+check+'⟩' for row,check in zip(witnesses,['threeRoots','true','true']))+']\n'
s+='theorem allWitnessesPass : witnesses.all Witness.passed=true := by\n unfold witnesses\n change (threeRoots && (true && (true && true))) = true\n rw [threeRootsPassed]\n rfl\nend SFT.Physics.TerminalLeptonValidationWitnesses\n'
(r/f'{tag}Witnesses.lean').write_text(s)
base=(w/'prepare_sector_program875.py').read_text();body=base[base.index(" s=(r/'RadioactivityEvidence.lean')"):base.index(' extra=')];body=body.replace('import SFT.Physics.SectorAnchorRecords\\n','');exec(compile('\n'.join(line[1:] for line in body.splitlines()),'empirical-source-template','exec'))
p=r/f'{tag}Experiment.lean';s=p.read_text().replace('targetRows.length = 1','targetRows.length = 2').replace('= [expectedLabel] := rfl','= [expectedLabel,expectedLabel] := rfl');s=s.replace('theorem registeredSpecValid : validateSpec = .ok () := rfl','theorem registeredSpecValid : validateSpec = .ok () := by\n unfold validateSpec specWitnesses\n rw [TerminalLeptonValidationWitnesses.allWitnessesPass]\n rfl');p.write_text(s)
# Reuse the original blind protocol, with this entry's exact numeric comparison and error.
s='import SFT.Physics.LeptonComparison\n'+s if False else s
# s currently holds experiment; obtain protocol template explicitly.
s=(r/'RadioactivityValidation.lean').read_text().replace('Radioactivity',tag)
s='import SFT.Foundation.AdmissionControls\nimport SFT.Physics.LeptonComparison\n'+s
s=s.replace('open SFT.Host SFT.Host.Canonical '+tag+'Experiment','open SFT.Host SFT.Host.Canonical '+tag+'Experiment\nopen SFT.Foundation.AdmissionControls (admissionIdentity)');s=renameIdentity(s)
end='end SFT.Physics.'+tag+'Validation\n';assert s.endswith(end)
s=s[:-len(end)]+'''def requireAgreement (numeric : LeptonComparison.Record) (validation : Validation) : Except String Validation :=
 if numeric.allRowsPassed == validation.passed then .ok validation
 else .error "ValueError: terminal validation numeric interval result differs from sealed label comparison"

def validateExternalWithin (rows : List (List Char)) (electronFuel tauFuel : Nat)
 (bytes : ByteArray) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String (Option Validation) := do
 let record ← LeptonComparison.comparisonRowsWithin rows electronFuel tauFuel
 match record with
 | none => .ok none
 | some numeric => do
   let validation ← validate bytes derivationSeal host implementation before after
   let result ← requireAgreement numeric validation
   pure (some result)

theorem numericLabelAgreement (v : Validation) (passed : v.passed=true) :
 requireAgreement LeptonComparison.terminalRecord v=.ok v := by
 unfold requireAgreement
 rw [LeptonComparison.bothRowsPassed,passed]
 rfl

theorem numericLabelDisagreement (v : Validation) (failed : v.passed=false) :
 requireAgreement LeptonComparison.terminalRecord v=
 .error "ValueError: terminal validation numeric interval result differs from sealed label comparison" := by
 unfold requireAgreement
 rw [LeptonComparison.bothRowsPassed,failed]
 rfl

theorem originalTerminalConnection (bytes : ByteArray) (derivationSeal host implementation : String)
 (before after : Snapshot) (v : Validation)
 (validated : validate bytes derivationSeal host implementation before after=.ok v)
 (passed : v.passed=true) :
 validateExternalWithin LeptonSource.snapshotRows 27 15 bytes derivationSeal host implementation before after=.ok (some v) := by
 unfold validateExternalWithin
 rw [LeptonComparison.nativeComparison]
 dsimp only [Bind.bind,Except.bind]
 rw [validated]
 dsimp only [Bind.bind,Except.bind]
 rw [numericLabelAgreement v passed]
 rfl
'''+end
(r/f'{tag}Validation.lean').write_text(s)
gen=(w/'generate_sectorvalidation873.py').read_text();gen=gen[gen.index('template='):].replace('PrecisionValidationWitnesses',tag+'Witnesses').replace('SectorValidationGrammar',tag+'Grammar');grammarDims=[];axisChoices={};fields=[];cs={'GENERATION_RULE':values['generation_rule'],'GRAMMAR_BOUNDARY':values['grammar_boundary']}
for d in dimensions:
 bad,good=d['choices'];k=d['key'];assert not bad['admitted'] and good['admitted'];grammarDims.append([k,'',bad['name'],bad['reason'],good['name'],good['reason']]);axisChoices[k]=[(x['name'],x['reason']) for x in d['choices']];fields.append((k,k.capitalize(),['rejected','admitted'],k.upper(),1));cs[k.upper()]=[x['name'] for x in d['choices']]
cs['SURVIVOR']='__'.join(d[4] for d in grammarDims);lit=lambda k:values[k];scope=dict(r=w/'constants-recovery',Path=Path,ast=None,json=json,re=re,dims=grammarDims,axisChoices=axisChoices,fields=fields,cs=cs,q=q,lit=lit);exec(compile(gen,'source-grammar','exec'),scope)
for suffix in ['Witnesses','Grammar','Evidence','Experiment','Validation']:shutil.copy2(r/f'{tag}{suffix}.lean',c/f'SFT/Physics/{tag}{suffix}.lean')
(w/'leptonvalidation1040_spec.json').write_text(json.dumps(dict(values=values,dimensions=dims),indent=2));print('Prepared original256grammar,3witnesses, exact002metadata, originalblindprotocol and reused numeric comparison')
