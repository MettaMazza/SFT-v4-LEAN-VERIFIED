from pathlib import Path
import sys,json,platform,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1163';sys.path[:0]=[str((w/'v3-runtime500').resolve()),str((w/'radiochemical1122_pdf6142').resolve()),str((w/'accuracy1162_testdeps').resolve())]
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.analytical_terminal_batch_v1 import SPECS_BY_NUMBER,ANALYSIS_PATH,AUTHORITIES,SOURCE_ARTIFACTS
from sft.chemistry.analytical_terminal_validation_v1 import AnalyticalTerminalValidator,_independent_surface
from sft.claim_evidence import snapshot_protected_tree
from sft.engine.canonical import canonical_value
from pypdf import PdfReader
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel
 if not p.exists():p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to((w/'v3-runtime500'/rel).resolve(),target_is_directory=True)
before=snapshot_protected_tree(stage);assert before.file_hashes==snapshot_protected_tree(w/'v3-runtime500').file_hashes
result=AnalyticalTerminalValidator(stage,SPECS_BY_NUMBER['016']).validate(SimpleNamespace(seal_hash='native-xray1163'));after=snapshot_protected_tree(stage);assert result.passed and before==after
analysis=json.loads((stage/ANALYSIS_PATH).read_text());snap=stage/'experiments/external_sources/chemistry/snapshots/anal-012-022-whole-subfield-v1';pdfs=[]
for name in ['nist-srm-674-xray-intensity-set.pdf','nist-srm-676a-diffraction-standard.pdf']:
 p=snap/name;pdfs.append(dict(path=str(p.relative_to(stage)),source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),pages=len(PdfReader(p).pages)))
ocr=json.loads((snap/'nist-srm-674-xray-intensity-set-apple-vision-ocr.json').read_text())
payload=dict(analysis=analysis,ocr=ocr,pdf_observations=pdfs,independent=_independent_surface(stage,'016',analysis),derivation_seal='native-xray1163',host=platform.system(),implementation=platform.python_implementation(),before=canonical_value(before),after=canonical_value(after));(w/'xray1163_empirical_input.json').write_text(json.dumps(payload,ensure_ascii=False));out=canonical_value(result);(w/'xray1163_original_empirical.json').write_text(json.dumps(out,indent=2)+'\n');(w/'xray1163_original_report.json').write_text(json.dumps(dict(status='PASS',fields=len(out),messages=len(out['measurements']),authority_files=len(AUTHORITIES),source_artifacts=len(SOURCE_ARTIFACTS),source_bytes=sum((stage/p).stat().st_size for p,_ in SOURCE_ARTIFACTS),independent=payload['independent'],protected_tree_unchanged=True),indent=2)+'\n');print('PASS original complete empirical12fields4messages,218source artifacts,10PDFpages and213OCRlines')
