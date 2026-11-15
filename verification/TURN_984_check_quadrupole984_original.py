from pathlib import Path
import sys,json,subprocess,hashlib
w=Path('work');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));from sft.physics import quadrupole_radiated_power_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid=src.CLAIM_ID
read=lambda name:json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+cid+'/'+name]))
source=read('certificate.json')['source_manifest_hash'];p=src.QuadrupoleRadiatedPowerProgram(source);census=p.generate_candidates();decisions=tuple(p.decide_candidate(c) for c in census.candidates);out=canonical_value(dict(registration=p.registration,census=census,decisions=decisions,closure=p.closure_evidence(decisions),controls=p.run_controls()));(w/'quadrupole984_original_program.json').write_text(json.dumps(out,indent=2));print('PASS original2916 fullprogram',flush=True)
