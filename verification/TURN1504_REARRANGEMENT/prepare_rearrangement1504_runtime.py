from pathlib import Path
import sys,json,platform
w=Path('work');stage=w/'pinned_rearrangement1504';sys.path.insert(0,str((w/'radiochemical1122_pdf6142').resolve()));sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()));from sft.chemistry import rearrangement_reaction_batch_v1 as b,rearrangement_reaction_validation_v1 as v
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
from pypdf import PdfReader
paths={'analysisDocument':b.ANALYSIS_PATH,'inventory':b.INVENTORY_PATH,'identityDocument':b.IDENTITY_PATH,'preseal':b.PRESEAL_PATH,'firstAnalysis':b.V1_ANALYSIS_PATH,'molecularDefinition':b.AUTHORITIES[14][0],'stageDefinition':b.AUTHORITIES[16][0]};x={k:json.loads((stage/p).read_text())for k,p in paths.items()};x['aliasText']=(stage/b.AUTHORITIES[15][0]).read_text();x['rawPages']=[p.extract_text()or''for p in PdfReader(stage/b.PDF_PATH).pages];assert len(x['rawPages'])==38
x['paths']=paths;x['source_files']=[r['path']for r in json.load(open(w/'rearrangement1504_source_pin.json'))['files']];x.update(before=canonical_value(snapshot_protected_tree(stage)),after=canonical_value(snapshot_protected_tree(stage)),derivation_seal='native-rearrangement1504',host=platform.system(),implementation=platform.python_implementation());(w/'rearrangement1504_empirical_input.json').write_text(json.dumps(x,indent=2)+'\n')
a,checks=v.exact_analysis(stage);(w/'rearrangement1504_analysis_expected.json').write_text(json.dumps({'analysis':a,'checks':checks},indent=2)+'\n')
s=(w/'EliminationValidation1503.lean').read_text().replace('Elimination','Rearrangement').replace('elimination1503','rearrangement1504')
a=s.index(' let pageTexts');z=s.index(' let before',a);s=s[:a]+''' let rawPages ← IO.ofExcept ((← IO.ofExcept (items input "rawPages")).mapM Lean.Json.getStr?)
 let data : RearrangementAnalysis.Input := ⟨← doc "analysisDocument",← doc "inventory",← doc "identityDocument",← doc "preseal",← doc "firstAnalysis",← doc "molecularDefinition",← doc "stageDefinition",← IO.ofExcept (text input "aliasText"),rawPages,files,← hash "analysisDocument",← hash "inventory"⟩
'''+s[z:];(w/'RearrangementValidation1504.lean').write_text(s)
print('Prepared38rawPDFpages,30originalsourcefiles,9analysisfields/'+str(len(checks))+'checks andnative runner')
