"""Official execution binding for SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001."""

from pathlib import Path
import sys

from sft.engine import ExternalCommandValidator
from sft.engine.source import build_source_manifest
from sft.chemistry.electronic_structure_batch_1 import ELECTRONIC_STRUCTURE_BATCH_1_SPECS
from sft.chemistry.generated_observational_law import BlindObservationalChemistryValidator, GeneratedObservationalChemistryProgram
from sft.verification import ClaimExecution


def build_execution(root: Path) -> ClaimExecution:
    spec = next(item for item in ELECTRONIC_STRUCTURE_BATCH_1_SPECS if item.claim_id == 'SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001')
    source_files = (
        root / "sft/chemistry/electronic_structure_derivation.py",
        root / "sft/chemistry/electronic_structure_batch_1.py",
        root / "sft/chemistry/generated_law.py",
        root / "sft/chemistry/generated_observational_law.py",
        root / "claims/SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001/execution.py",
        root / "sft/physics/generated_empirical_law.py",
        root / "sft/claim_evidence/fold_language.py",
        root / "sft/claim_evidence/custody.py",
        root / "sft/claim_evidence/hostile.py",
        root / "sft/engine/isolation.py",
        root / "sft/engine/empirical.py",
    )
    source_hash = build_source_manifest(root, source_files).manifest_hash
    validator = root / "claims/SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001/independent_validator.py"
    return ClaimExecution(
        program=GeneratedObservationalChemistryProgram(spec, source_hash),
        independent_validator=ExternalCommandValidator(
            "sft-chem-electronic-state-identity-001-independent-python/1",
            (sys.executable, str(validator)),
            validator.parent,
            (validator,),
        ),
        source_files=source_files,
        empirical_validator=BlindObservationalChemistryValidator(root, spec),
    )
