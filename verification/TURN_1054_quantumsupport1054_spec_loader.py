from pathlib import Path
import sys,ast,json
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.engine import EvidenceMode,ProvenanceClass
from sft.physics.structural_constants import StructuralPhysicsSpec,Witness,binary_axis
CLAIM_ID='SFT-PHYS-QUANTUM-SUPPORT-UNCERTAINTY-TERMINAL-049'
# Reuse the exact retained original certificate output; do not rerun its census at metadata import.
def theorem_certificate(): return json.loads((w/'quantumsupport1051_walsh_expected.json').read_text())[-1]['ok']
tree=ast.parse((w/'quantumsupport1051_law.py').read_text())
node=next(n for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='SPEC' for t in n.targets))
exec(compile(ast.Module(body=[node],type_ignores=[]),'pinned-v3-SPEC','exec'))
SPEC.validate()
