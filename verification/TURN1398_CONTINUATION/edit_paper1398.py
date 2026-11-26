from pathlib import Path
import json,re,hashlib,fcntl,datetime
w=Path('work');r=w/'turn1064_recovery';p=r/'ZENODO_PAPER_DRAFT.txt'
for n in ['earth1448_structural_comparison_report.json','earth1448_structural_entry_audit_report.json']:
 a=json.loads((w/n).read_text());assert a['status']=='PASS';assert hashlib.sha256((r/'SFT/EarthEnvironment/StructuralModel.lean').read_bytes()).hexdigest()==a['source_sha256']['StructuralModel']
with(w/'entry_registration.lock').open('a')as lock:
 fcntl.flock(lock,fcntl.LOCK_EX);old=p.read_text();s=old
 s=re.sub(r'\b(Sections?)(?=\d)',r'\1 ',s)
 s=re.sub(r'(\d)(?=(?:ordered|audited|fields|measurement|measurements|sources|source|entries|declarations|empty|native|original|independent|candidates|controls|messages|rows)\b)',r'\1 ',s)
 replacements={'all1,024':'all 1,024','after26 refinements':'after 26 refinements','complete256-form':'complete 256-form','All48original':'All 48 original','All48 original':'All 48 original',',10prediction-domain':', 10 prediction-domain',',4287prediction instructions':', 4,287 prediction instructions',',complete256candidate programme andthreeadverse':', complete 256-candidate programme and three adverse','original252row':'original 252-row','inall12 fields':'in all 12 fields','and256 messages':'and 256 messages','fields,256 ordered':'fields, 256 ordered','retain35 original':'retain 35 original','cover27and80 declarations':'cover 27 and 80 declarations','modules139 declarations':'modules, 139 declarations','15and6 empty':'15 and 6 empty'}
 for x,y in replacements.items():s=s.replace(x,y)
 stale='Native compilation, axiom audit and comparison of80 original operation outcomes and seven complete fixed records are pending; this entry is not yet counted complete.'
 assert stale in s
 s=s.replace(stale,'The 24 native structural declarations have empty axiom dependencies, and their source comparison agrees on all 80 original operation outcomes and seven complete fixed records. Source evidence: earth1448_structural_entry_audit_report.json and earth1448_structural_comparison_report.json; these results establish the structural operations described in this section.')
 p.write_text(s);receipt={'time':datetime.datetime.now(datetime.timezone.utc).isoformat(),'before_sha256':hashlib.sha256(old.encode()).hexdigest(),'after_sha256':hashlib.sha256(s.encode()).hexdigest(),'change':'Numerical prose spacing and source-bound correction of stale Earth structural pending sentence. No mathematical definitions or expressions changed.','structural_source_hash':a['source_sha256']['StructuralModel']};(w/'paper1398_editorial_receipt.json').write_text(json.dumps(receipt,indent=2)+'\n');print(receipt)
