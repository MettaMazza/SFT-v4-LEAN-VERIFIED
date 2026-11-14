from pathlib import Path
import json,sys,subprocess
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()))
from sft.physics import matter_flavour_terminal_ckm_validation_v1 as src
v='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
paths=[src.SOURCE_PATH]+['experiments/external_sources/physics/snapshots/'+n for n in src.COMPONENT_HASHES]
for name in paths:
 p=runtime/name;data=subprocess.check_output(['git','-C',v,'show',pin+':'+name]);p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==data
 else:p.write_bytes(data)
record=src.authoritative_record(runtime);(w/'terminalckm938_original_record.json').write_text(json.dumps(record,indent=2))
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(v) for v in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s=(r/'SFT/Physics/MatterAuthoritativeRecords.lean').read_text().replace('MatterAuthoritativeRecords','TerminalMatterRecords').replace('matter/flavour','terminal matter/flavour').replace('missing registered source','missing registered terminal source')
a=s.index('def componentHashes');b=s.index('def payloadBoundary',a);s=s[:a]+'def componentHashes : List (String × String) := ['+','.join('('+q(k)+','+q(v)+')' for k,v in src.COMPONENT_HASHES.items())+']\ndef sourceHash : String := '+q(src.SOURCE_HASH)+'\n'+s[b:]
a=s.index(' let sealed');b=s.index(' let sources',a);required={'development_target_already_known':True,'classification':'observational_derivation','formal_relation_contains_measurement':False,'measurement_selects_formal_survivor':False,'engine_prediction_sealed_before_target_release_within_run':True,'blind_forward_discovery_claimed':False,'all_rows_and_uncertainties_retained':True};s=s[:a]+''.join(' if !sameValue ((field custody '+q(k)+').toOption.getD .null) ('+cv(v)+') then throw "terminal matter/flavour custody disclosure changed"\n' for k,v in required.items())+s[b:];s=s.replace('sources.length != 6','sources.length != 2').replace('| none => pure ()','| none => throw "terminal matter/flavour component identity changed"');s=s.replace('end SFT.Physics.TerminalMatterRecords','def registeredRecord : Value := '+cv(record)+'\ntheorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl\nend SFT.Physics.TerminalMatterRecords')
for root in [r,c]:(root/'SFT/Physics/TerminalMatterRecords.lean').write_text(s)
# Pin exact computed prediction endpoints, checked by reduction of the translated operation.
p=r/'SFT/Physics/TerminalCKMComparison.lean';s=p.read_text();s=s[:s.index('end SFT.')]
values=src.terminal_ckm_prediction_intervals()
def rat(x):return f'normalize ({x.numerator}) {x.denominator} (by decide)'
def pair(row):return '('+rat(row[0])+','+rat(row[1])+')'
s+='def originalPredictions : Predictions := ⟨'+','.join(pair(values[k]) for k in ['s12_squared','s23_squared','s13_squared','jarlskog_squared'])+'⟩\ntheorem completePredictions : predictionIntervals=.ok originalPredictions := rfl\nend SFT.Physics.TerminalCKMComparison\n'
for root in [r,c]:(root/'SFT/Physics/TerminalCKMComparison.lean').write_text(s)
print('pinned complete record and two components;all four exact original intervals prepared')
