from pathlib import Path
import json,fcntl,re,ast
w=Path('work');r=w/'turn1064_recovery'
ids=['SFT-BIO-INHERITANCE-001','SFT-BIO-TEMPLATE-001','SFT-BIO-REPLICATION-001','SFT-BIO-COPY-FIDELITY-001','SFT-BIO-HERITABLE-VARIATION-001','SFT-BIO-REPLICATION-LINEAGE-001','SFT-BIO-VARIATION-001','SFT-BIO-HERITABILITY-001','SFT-BIO-DIFFERENTIAL-REPRODUCTION-001','SFT-BIO-SELECTION-001','SFT-BIO-FIXATION-001','SFT-BIO-DRIFT-BOUNDARY-001']
pattern=r'Original-source validation evidence for the twelve [^\n]*'
prefix='Original-source validation evidence for the twelve inheritance/replication and variation/evolution entries in sections1105–1106 is retained in verification/TURN1170_BIOLOGY_SOURCE: pinned source manifests, original complete empirical outputs and comparison reports. '
with(w/'entry_registration.lock').open('a')as lock:
 fcntl.flock(lock,fcntl.LOCK_EX);c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};done=[by[i]['title']for i in ids if by[i]['lean_status']=='complete'];pending=[by[i]['title']for i in ids if by[i]['lean_status']!='complete'];assert len(done)==7
 text=prefix+'Native verification is complete for '+', '.join(done)+'. Remaining native checks: '+', '.join(pending)+'.'
 p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();s,n=re.subn(pattern,lambda _:text,s);assert n==1;p.write_text(s)
for tag in ['heritability1184','differential1185','selection1186','fixation1187','drift1188']:
 p=w/('register_'+tag+'.py');s=p.read_text();needle=' p.write_text(s)\nwith(r/\'ZENODO_PAPER_DRAFT.txt\').open';assert needle in s,p
 addition=" if fn=='ZENODO_PAPER_DRAFT.txt':\n  statusIds="+repr(ids)+"\n  completedTitles=[by[i]['title']for i in statusIds if by[i]['lean_status']=='complete']\n  pendingTitles=[by[i]['title']for i in statusIds if by[i]['lean_status']!='complete']\n  statusText="+repr(prefix)+"+'Native verification is complete for '+', '.join(completedTitles)+'.'+(' Remaining native checks: '+', '.join(pendingTitles)+'.' if pendingTitles else ' All twelve entries are registered complete.')\n  s=re.sub("+repr(pattern)+",lambda _:statusText,s)\n"
 s=s.replace(needle,addition+needle);ast.parse(s);p.write_text(s)
print('Corrected shared paragraph:7completed/5pending;next five registrations now update it from actual registered results.')
