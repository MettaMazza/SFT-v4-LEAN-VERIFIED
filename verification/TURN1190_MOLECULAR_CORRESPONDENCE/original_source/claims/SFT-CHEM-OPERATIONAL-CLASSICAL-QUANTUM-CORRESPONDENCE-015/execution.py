"""Official execution binding for SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015."""
from pathlib import Path
import sys
from sft.engine import ExternalCommandValidator
from sft.engine.source import build_source_manifest
from sft.chemistry.classical_quantum_correspondence_batch_v1 import CLASSICAL_QUANTUM_SPEC, GeneratedOperationalChemistryProgram
from sft.verification import ClaimExecution

def build_execution(root: Path) -> ClaimExecution:
    source_files = (
        root / "sft/chemistry/classical_quantum_correspondence_law_v1.py",
        root / "sft/chemistry/classical_quantum_correspondence_batch_v1.py",
        root / "sft/physics/generated_empirical_law.py",
        root / "sft/quantum_computation/operations.py",
        root / "claims/SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015/execution.py",
    )
    source_hash = build_source_manifest(root, source_files).manifest_hash
    validator = root / "claims/SFT-CHEM-OPERATIONAL-CLASSICAL-QUANTUM-CORRESPONDENCE-015/independent_validator.py"
    return ClaimExecution(
        program=GeneratedOperationalChemistryProgram(CLASSICAL_QUANTUM_SPEC, source_hash),
        independent_validator=ExternalCommandValidator(
            "sft-chem-operational-classical-quantum-correspondence-015-independent-python/1",
            (sys.executable, str(validator)),
            validator.parent,
            (validator,),
        ),
        source_files=source_files,
    )
