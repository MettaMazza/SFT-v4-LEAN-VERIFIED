from pathlib import Path
import subprocess,json,hashlib
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');cov=json.loads((r/'COVERAGE.json').read_text());claims=[e['claim_id'] for e in cov['claims'] if e['lean_status']=='complete'];pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
p=subprocess.Popen(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','cat-file','--batch'],stdin=subprocess.PIPE,stdout=subprocess.PIPE);rows=[]
for cid in claims:
 rel='claims/'+cid+'/candidate_census.json';p.stdin.write((pin+':'+rel+'\n').encode());p.stdin.flush();header=p.stdout.readline().decode().split();assert header[-1]!='missing',cid;raw=p.stdout.read(int(header[2]));assert p.stdout.read(1)==b'\n';d=json.loads(raw);assert len(d['candidates'])==d['expected_cardinality'];rows.append(dict(claim_id=cid,candidates=len(d['candidates']),source_sha256=hashlib.sha256(raw).hexdigest()))
p.stdin.close();p.wait();report=dict(source_commit=pin,completed_entries=len(claims),original_candidate_rows_in_completed_entries=sum(x['candidates'] for x in rows),scope='Publication inventory arithmetic from pinned source censuses of already completed entries; no proof or comparison rerun.',entries=rows);Path('work/publication_counts515.json').write_text(json.dumps(report,indent=2)+'\n');print({k:v for k,v in report.items() if k!='entries'})
