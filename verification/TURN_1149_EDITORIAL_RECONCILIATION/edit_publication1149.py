from pathlib import Path
import re,json,hashlib,fcntl
lock=open('work/entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
r=Path('work/turn1064_recovery');p=r/'ZENODO_PAPER_DRAFT.txt';before=p.read_text();s=before;edits=[]
spacing={'to76f1b34e9e9682989adcbb088797b4ae4ce4fcf1':'to 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1','at76f1b34e9e9682989adcbb088797b4ae4ce4fcf1':'at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1','The132-declaration':'The 132-declaration','The29 new':'The 29 new','The22-row':'The 22-row','With22 species':'With 22 species','These29 declarations':'These 29 declarations','modules to135':'modules to 135','The31 exported':'The 31 exported','all256original alternatives,allthree operational witnesses,original controls':'all 256 original alternatives, all three operational witnesses, original controls','All116audited':'All 116 audited','complete75claim':'complete 75 claim','assigned to1 by':'assigned to 1 by','label in1,...,R':'label in 1,...,R','ratio to1 and':'ratio to 1 and'}
for old,new in spacing.items():
 count=s.count(old)
 if count:s=s.replace(old,new);edits.append({'old':old,'new':new,'occurrences':count})
assert re.sub(r'\s','',before)==re.sub(r'\s','',s)
replacements=[
 ('Full entry registration awaits its original grammar, closure and empirical assembly; this section describes the implemented components.','The original grammar, closure and empirical assembly are complete; verification/TURN_1087_STATE_ENERGY_ORDER_COMPLETION.json records the source-bound verification.','1087_STATE_ENERGY_ORDER'),
 ('Full entry registration remains separate from this verified target/comparison assembly.','The complete entry includes this target/comparison assembly and the original grammar, controls and empirical validation; see verification/TURN_1087_STATE_ENERGY_ORDER_COMPLETION.json.','1087_STATE_ENERGY_ORDER'),
 ('The original full empirical validator passes; the full native empirical comparison and complete candidate-programme comparison are still pending, so this entry has not yet increased the completed-entry count.','The original full empirical validator, full native empirical comparison and complete candidate-programme comparison pass. The entry is complete, with its source correspondence and verification recorded in verification/TURN_1124_LIFE_CHEMICAL_BOUNDARY_COMPLETION.json.','1124_LIFE_CHEMICAL_BOUNDARY'),
 ('This records the core operations; complete entry registration awaits its original grammar and empirical programme.','These core operations form part of the completed entry, including its original grammar and empirical programme; see verification/TURN_1129_ISOTOPE_EXCHANGE_COMPLETION.json.','1129_ISOTOPE_EXCHANGE'),
 ('Full empirical programme registration remains pending.','The full empirical programme is verified and the entry is complete; see verification/TURN_1132_MULTICENTRE_COMPLETION.json.','1132_MULTICENTRE')]
for old,new,tag in replacements:
 d=json.loads((r/('verification/TURN_'+tag+'_COMPLETION.json')).read_text());assert d['status']=='complete' and d['remaining']==[]
 for rel,h in d['lean_source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h
 assert s.count(old)==1,old;s=s.replace(old,new);edits.append({'old':old,'new':new,'receipt':'verification/TURN_'+tag+'_COMPLETION.json'})
math=lambda t:re.findall(r'\\\[[\s\S]*?\\\]|\\\([\s\S]*?\\\)',t)
assert math(before)==math(s)
p.write_text(s)
report=dict(status='PASS',before_sha256=hashlib.sha256(before.encode()).hexdigest(),after_sha256=hashlib.sha256(s.encode()).hexdigest(),math_expressions_unchanged=len(math(s)),completion_sentences_corrected=5,edits=edits,scope='Editorial corrections only; no proof or count changes')
Path('work/publication1149_editorial_report.json').write_text(json.dumps(report,indent=2)+'\n');print({k:v for k,v in report.items() if k!='edits'})
