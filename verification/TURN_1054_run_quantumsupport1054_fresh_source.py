from pathlib import Path
import sys,json,subprocess
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics.quantum_support_uncertainty_terminal_law_v1 import SPEC
from sft.physics.structural_constants import StructuralPhysicsProgram
from sft.engine.canonical import canonical_value
w=Path('work');source=json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:claims/SFT-PHYS-QUANTUM-SUPPORT-UNCERTAINTY-TERMINAL-049/certificate.json']))['source_manifest_hash'];p=StructuralPhysicsProgram(SPEC,source);census=p.generate_candidates();decisions=tuple(p.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=p.registration,census=census,decisions=decisions,closure=p.closure_evidence(decisions),controls=p.run_controls(),unknown_id='StopIteration'))
(w/'quantumsupport1054_fresh_expected.json').write_text(json.dumps(expected,indent=2))
print('Fresh original complete programme retained')
