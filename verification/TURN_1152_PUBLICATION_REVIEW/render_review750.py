"""Run the existing cumulative PDF workflow sequentially after verified 750 registration."""
from pathlib import Path
import argparse,hashlib,json,os,re,subprocess
p=argparse.ArgumentParser();p.add_argument('--code-commit',required=True);a=p.parse_args();assert re.fullmatch('[0-9a-f]{40}',a.code_commit)
r=Path('work/turn1064_recovery');w=Path('work');stats=json.loads((r/'COVERAGE.json').read_text())['summary'];assert stats['fully_reconstructed_claims']==750
node='/Users/dolltrading/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node'
python='/Users/dolltrading/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/bin/python3'
def run(args,env=None):subprocess.run(args,check=True,env=env)
run([python,'work/prepare_review750_metadata.py','--code-commit',a.code_commit])
run([python,'work/index_publication1146.py'])
text=(r/'ZENODO_PAPER_DRAFT.txt').read_text();heads=re.findall(r'(?m)^\d+(?:\.\d+)*\. [^\n]+$',text)
(w/'headings1145.json').write_text(json.dumps(heads,ensure_ascii=False)+'\n')
(w/'publication1145_prepared.json').write_text(json.dumps(dict(completed_entries=750,theorems=stats['axiom_free_exported_results'],declarations=stats['axiom_free_audited_definitions_and_theorems']))+'\n')
env=dict(os.environ,SFT_PAPER_SOURCE=str(r/'ZENODO_PAPER_DRAFT.txt'),SFT_CODE_PIN=a.code_commit,SFT_REVIEW_EDITION='750');env.pop('SFT_LAYOUT_ONLY',None)
for iteration in range(3):
 old=json.loads((w/'pdf1145/page_map.json').read_text())
 run([node,'--max-old-space-size=1024','work/pdf1145/build_html.cjs'],env)
 run([node,'--max-old-space-size=1024','work/pdf1145/render.cjs'],env)
 run([python,'work/pdf1145/map_pages.py'])
 new=json.loads((w/'pdf1145/page_map.json').read_text())
 if new==old:break
else:raise RuntimeError('Contents pagination has not converged; preserve latest output for layout repair')
run([python,'work/finalize_review750.py'])
print('750 review PDF assembled with stable contents; final rendered-page QA and release bundle still required; no publication')
