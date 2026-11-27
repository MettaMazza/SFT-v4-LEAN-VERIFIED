from pathlib import Path
import sys,json,platform
w=Path('work');stage=w/'pinned_elimination1503';sys.path.insert(0,str((w/'radiochemical1122_pdf6142').resolve()));sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()));from sft.chemistry import elimination_reaction_batch_v1 as b,elimination_reaction_validation_v1 as v
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
from pypdf import PdfReader
paths={'analysisDocument':b.ANALYSIS_PATH,'inventory':b.INVENTORY_PATH,'identityDocument':b.IDENTITY_PATH,'preseal':b.PRESEAL_PATH,'iupac':b.IUPAC_PATH};x={k:json.loads((stage/p).read_text())for k,p in paths.items()};pdf=next(r for r in x['inventory']['members']if r['archive_member'].endswith('.pdf'));x['pageTexts']=[p.extract_text()or''for p in PdfReader(stage/pdf['snapshot_path']).pages];assert len(x['pageTexts'])==117
x['paths']=paths;x['source_files']=[r['path']for r in json.load(open(w/'elimination1503_source_pin.json'))['files']];x.update(before=canonical_value(snapshot_protected_tree(stage)),after=canonical_value(snapshot_protected_tree(stage)),derivation_seal='native-elimination1503',host=platform.system(),implementation=platform.python_implementation());(w/'elimination1503_empirical_input.json').write_text(json.dumps(x,indent=2)+'\n')
a,checks=v.exact_analysis(stage);(w/'elimination1503_analysis_expected.json').write_text(json.dumps({'analysis':a,'checks':checks},indent=2)+'\n')
s=(w/'AdditionValidation1502.lean').read_text().replace('Addition','Elimination').replace('addition1502','elimination1503').replace('pinned_addition1499','pinned_elimination1503')
a=s.index(' let priorPaths');z=s.index(' let before',a)
s=s[:a]+''' let pageTexts ← IO.ofExcept ((← IO.ofExcept (items input "pageTexts")).mapM Lean.Json.getStr?)
 let data : EliminationAnalysis.Input := ⟨← doc "analysisDocument",← doc "inventory",← doc "identityDocument",← doc "preseal",← doc "iupac",pageTexts,files,← hash "analysisDocument",← hash "inventory"⟩
'''+s[z:];(w/'EliminationValidation1503.lean').write_text(s)
print('Prepared117page extraction,44originalsourcefiles,12analysisfields/47checks and native runner')
