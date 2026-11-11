from pathlib import Path
import json,subprocess
w=Path('work');expected=json.load(open(w/'material_text652_expected.json'));root=Path('/Volumes/One Touch/ernos-labs-sft-platform/experiments/external_sources/materials/snapshots');files=[p for p in sorted(root.iterdir()) if p.is_file() and not p.name.startswith('._')];base=len(expected)-len(files);ids=list(range(base))+[base+next(i for i,p in enumerate(files) if p.name=='nist-reference-materials.html')]
# Reuse the unchanged native executable. Preserve each emitted result before comparison.
with (w/'material_text652_selected_actual.jsonl').open('w') as f:
 run=subprocess.run([str((w/'MaterialText652').resolve()),*[str((w/'material_text652_inputs'/str(i)).resolve()) for i in ids]],stdout=f,check=True)
actual=[json.loads(x) for x in (w/'material_text652_selected_actual.jsonl').read_text().splitlines()];assert len(actual)==len(ids)
for i,a in zip(ids,actual):assert a==expected[i],(i,a[:300],expected[i][:300])
report={'status':'PASS','cases':len(ids),'full_named_html_entities':2231,'actual_entry_snapshot':'nist-reference-materials.html','source_operation':'external_bindings.source_corpus: regex tags, HTML unescape, Unicode casefold, whitespace split/join','native_program_reused':True,'tested_indices':ids};(w/'material_text652_report.json').write_text(json.dumps(report,indent=2));print('PASS',len(ids),'cases including complete material-entry snapshot')
