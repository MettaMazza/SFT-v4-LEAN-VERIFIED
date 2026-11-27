from pathlib import Path
import json,sys,hashlib
w=Path('work');stage=w/'pinned_electrophilic1498';sys.path.insert(0,str((w/'radiochemical1122_pdf6142').resolve()));sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry import electrophilic_substitution_validation_v1 as v
from pypdf import PdfReader,__version__
rows=v._source_rows(stage);primary=json.loads((stage/v.PRIMARY_PATH).read_text());p=stage/rows[3]['opened_snapshot_path'];texts=[page.extract_text()or''for page in PdfReader(p).pages]
# exact_analysis is the original validation operation; extraction is retained for native replay.
a,checks=v.exact_analysis(stage,rows,primary)
x={'rows':rows,'primary':primary,'page_texts':texts};(w/'electrophilic1498_analysis_input.json').write_text(json.dumps(x,indent=2)+'\n');(w/'electrophilic1498_analysis_expected.json').write_text(json.dumps({'analysis':a,'checks':checks},indent=2)+'\n');(w/'electrophilic1498_pdf_boundary.json').write_text(json.dumps({'source_path':rows[3]['opened_snapshot_path'],'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'pypdf':__version__,'pages':len(texts),'characters':sum(map(len,texts)),'boundary':'Original external PdfReader.extract_text; native checks the complete ordered text vector, page count, hash and character sum.'},indent=2)+'\n')
s=(w/'NucleophilicAnalysis1497.lean').read_text().replace('NucleophilicAnalysis','ElectrophilicAnalysis').replace('nucleophilic1497_analysis','electrophilic1498_analysis');a=s.index(' let (analysis,checks)');s=s[:a]+''' let texts ← IO.ofExcept ((← IO.ofExcept (items input "page_texts")).mapM Lean.Json.getStr?)
 let (analysis,checks) ← IO.ofExcept (ElectrophilicAnalysis.analysis rows primary texts)
 IO.println (SFT.Host.Canonical.render (.object [("analysis",analysis),("checks",.object (checks.map fun (k,v) => (k,.boolean v)))]))
''';(w/'ElectrophilicAnalysis1498.lean').write_text(s)
s=(w/'prepare_nucleophilic1497_analysis_native.py').read_text().replace('NucleophilicAnalysis1497','ElectrophilicAnalysis1498').replace("visit('SFT.Chemistry.NucleophilicAnalysis')","visit('SFT.Chemistry.ElectrophilicAnalysis')").replace('nucleophilic1497_analysis','electrophilic1498_analysis');s=s.replace("'conformerpopulation1495_interfaces_native_build.json']:","'conformerpopulation1495_interfaces_native_build.json','nucleophilic1497_analysis_native_build.json','nucleophilic1497_validation_native_build.json']:");(w/'prepare_electrophilic1498_analysis_native.py').write_text(s)
print('Prepared',len(texts),'pages for exact native analysis')
