"""Run the existing cumulative PDF workflow sequentially after verified 1000 registration."""
from pathlib import Path
import argparse,hashlib,json,os,re,subprocess
p=argparse.ArgumentParser();p.add_argument('--code-commit',required=True);a=p.parse_args();assert re.fullmatch('[0-9a-f]{40}',a.code_commit)
r=Path('work/turn1064_recovery');w=Path('work');stats=json.loads((r/'COVERAGE.json').read_text())['summary'];assert stats['fully_reconstructed_claims']==1000
node='/Users/dolltrading/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node'
python='/Users/dolltrading/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3'
def run(args,env=None):subprocess.run(args,check=True,env=env)
run([python,'work/prepare_review1000_metadata.py','--code-commit',a.code_commit])
run([python,'work/index_publication1146.py'])
text=(r/'ZENODO_PAPER_DRAFT.txt').read_text();heads=re.findall(r'(?m)^\d+(?:\.\d+)*\. [^\n]+$',text)
(w/'headings_review1000.json').write_text(json.dumps(heads,ensure_ascii=False)+'\n')
(w/'publication_review1000_prepared.json').write_text(json.dumps(dict(completed_entries=1000,theorems=stats['axiom_free_exported_results'],declarations=stats['axiom_free_audited_definitions_and_theorems']))+'\n')
env=dict(os.environ,SFT_PAPER_SOURCE=str(r/'ZENODO_PAPER_DRAFT.txt'),SFT_CODE_PIN=a.code_commit,SFT_REVIEW_EDITION='1000');env.pop('SFT_LAYOUT_ONLY',None)
env.pop('SFT_PUBLICATION_EDITION',None)
env.pop('SFT_PUBLICATION_DOI',None)
# Bind source links to actual pinned Git objects; avoid per-reference drive I/O.
import urllib.request
v3paths=json.loads((w/'pdf_review1000/v3_paths.json').read_text())
assert v3paths['source_commit']=='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
api='https://api.github.com/repos/MettaMazza/SFT-v4-LEAN-VERIFIED'
commit=json.load(urllib.request.urlopen(api+'/git/commits/'+a.code_commit,timeout=30))
assert commit['sha']==a.code_commit
published_tree=json.load(urllib.request.urlopen(api+'/git/trees/'+commit['tree']['sha']+'?recursive=1',timeout=30))
assert not published_tree['truncated']
(w/'pdf_review1000/published_paths.json').write_text(json.dumps({'v3':v3paths['paths'],'v4':[x['path']for x in published_tree['tree']if x['type']=='blob']}))
# Resolve shorthand Lean filenames only when the published pin has one match.
paths={}
for item in published_tree['tree']:
 rel=item['path']
 if item['type']=='blob' and rel.startswith('SFT/') and rel.endswith('.lean'):
  paths.setdefault(Path(rel).name,set()).add(rel)
(w/'pdf_review1000/bare_lean_paths.json').write_text(json.dumps({name:next(iter(items))for name,items in paths.items()if len(items)==1}))
(w/'pdf_review1000/ambiguous_lean_paths.json').write_text(json.dumps({name:sorted(items)for name,items in paths.items()if len(items)>1},indent=2))
if not(w/'pdf_review1000/page_map.json').exists():(w/'pdf_review1000/page_map.json').write_text('{}')
source_snapshot_sha256=hashlib.sha256((r/'ZENODO_PAPER_DRAFT.txt').read_bytes()).hexdigest()
for iteration in range(3):
 old=json.loads((w/'pdf_review1000/page_map.json').read_text())
 run([node,'--max-old-space-size=1024','work/pdf_review1000/build_html.cjs'],env)
 run([node,'--max-old-space-size=1024','work/pdf_review1000/render.cjs'],env)
 run([python,'work/pdf_review1000/map_pages.py'])
 new=json.loads((w/'pdf_review1000/page_map.json').read_text())
 if new==old:break
else:raise RuntimeError('Contents pagination has not converged; preserve latest output for layout repair')
assert hashlib.sha256((r/'ZENODO_PAPER_DRAFT.txt').read_bytes()).hexdigest()==source_snapshot_sha256, 'Manuscript changed during PDF rendering; retain output and rerender current source before review'
run([python,'work/finalize_review1000.py'])
print('1000 review PDF assembled with stable contents; final rendered-page QA and release bundle still required; no publication')
