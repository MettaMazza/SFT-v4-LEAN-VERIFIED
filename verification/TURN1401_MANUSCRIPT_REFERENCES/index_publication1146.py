from pathlib import Path
import re,json,hashlib
r=Path('work/turn1064_recovery');pub=r/'publication';pub.mkdir(exist_ok=True);s=(r/'ZENODO_PAPER_DRAFT.txt').read_text();heads=list(re.finditer(r'(?m)^(\d+(?:\.\d+)*)\. ([^\n]+)$',s));rows=[]
for i,m in enumerate(heads):
 body=s[m.end():heads[i+1].start()if i+1<len(heads)else len(s)]
 rows.append(dict(section=m[1],title=m[2],manuscript_line=s.count('\n',0,m.start())+1,links=sorted(set(re.findall(r'https?://[^\s)<>]+',body))),source_paths=sorted(set(x.rstrip('.,;:')for x in re.findall(r'(?:SFT|sft|claims|verification|reference)/[A-Za-z0-9_./-]+\.(?:lean|py|json|txt|log|md)',body))),timeline_mentions=sorted(set(re.findall(r'TURN[_ ]?\d+(?:[–-]\d+)?',body,re.I)+re.findall(r'TIMELINE\.txt#L\d+',body))),display_equations=body.count('\\[')))
(pub/'CONTENTS.txt').write_text('\n'.join(m[0]for m in heads)+'\n');(pub/'SECTION_SOURCE_INDEX.json').write_text(json.dumps(rows,ensure_ascii=False,indent=2)+'\n')
report=dict(status='PASS',manuscript_sha256=hashlib.sha256(s.encode()).hexdigest(),numbered_headings=len(heads),main_headings=sum('.'not in m[1]for m in heads),sections_with_source_paths=sum(bool(x['source_paths'])for x in rows),sections_with_timeline_mentions=sum(bool(x['timeline_mentions'])for x in rows),purpose='Manuscript navigation and citation index only; not a proof-completion test.')
Path('work/publication1146_index_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
