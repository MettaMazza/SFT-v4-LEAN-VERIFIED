from pathlib import Path
import json,re,hashlib,fcntl
w=Path('work');r=w/'turn1064_recovery';corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());bindings={'1115.7':'NormalVariationSource','1116.7':'SymptomRecordSource','1118.7':'ClinicalAssociationSource','1121.7':'DoseSource','1122.7':'EfficacySource','1123.7':'ClinicalTrialSource','1124.7':'ScreeningSource','1125.7':'IndividualInferenceSource','1126.7':'InformedConsentSource'};evidence=[]
for key,name in bindings.items():
 rel='SFT/Medicine/'+name+'.lean';rows=[x for x in corr['modules']if x.get('lean_module')==rel];assert len(rows)==1;binding=rows[0];receipt=json.loads((r/binding['completion_evidence']).read_text());assert receipt['status']=='complete';assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==receipt['lean_source_sha256'][rel]
 text=(r/rel).read_text();assert 'def sourceCorpus' in text and 'def validateSources' in text
 names=re.findall(r'^def (\w+)',text,re.M);evidence.append({'section':key,'module':rel,'declarations':names,'completion_receipt':binding['completion_evidence'],'sha256':receipt['lean_source_sha256'][rel]})
with(w/'entry_registration.lock').open('a')as lock:
 fcntl.flock(lock,fcntl.LOCK_EX);p=r/'ZENODO_PAPER_DRAFT.txt';old=p.read_text();s=old
 for item in evidence:
  key=item['section'];m=re.search(r'(?m)^'+re.escape(key)+r'\. [^\n]+$',s);assert m;n=re.search(r'(?m)^\d+(?:\.\d+)*\. ',s[m.end():]);end=m.end()+n.start()if n else len(s);body=s[m.start():end]
  formula='The retained extraction receipt is H([(s,h_s,f,H([s,casefold(f)]))] in original order).';assert formula in body
  body=body.replace(formula,r'''The retained extraction receipt is

\[
E=H\!\left(\left[(s,h_s,f,H([s,\operatorname{casefold}(f)]))\right]_{\text{original order}}\right).
\]
'''.strip())
  body=body.replace('13 records,11captured and 2failed','13 records, 11 captured and 2 failed').replace('12 field4 message','12-field, 4-message')
  turn=re.search(r'TURN\d+',item['completion_receipt'])[0];name=bindings[key]
  methods=[x for x in item['declarations']if x in ['sourceCorpus','validateSources','sourceDerivedTarget','extract']]
  assert 'sourceDerivedTarget' in methods or 'extract' in methods,(key,methods)
  body=body.rstrip()+'\n\nOriginal source: sft/medicine/empirical_program.py, _source_derived_target; sft/medicine/sources.py, source_corpus and validate_sources; sft/medicine/external_bindings.py, the registered source requirements; pinned commit 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. Native verification: '+item['module']+', '+', '.join(methods)+'. Completion evidence: '+item['completion_receipt']+'. Chronological verification: TIMELINE.txt, '+turn+'.\n\n'
  s=s[:m.start()]+body+s[end:]
 p.write_text(s)
(w/'paper_sources1401_receipt.json').write_text(json.dumps({'before_sha256':hashlib.sha256(old.encode()).hexdigest(),'after_sha256':hashlib.sha256(s.encode()).hexdigest(),'scope':'Explicit source/Lean/timeline citations and typesetting of unchanged receipt formula in nine existing subsections','bindings':evidence},indent=2)+'\n');print('Updated9subsection citations and existing formulas')
