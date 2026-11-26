"""Official execution binding for Chemistry INORG-006."""

from pathlib import Path
import json
import sys

from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.chemistry.ligand_state_splitting_batch_v1 import (
    ADDENDUM_FILES, FAMILY_BOUNDARY_PATH, FAMILY_INVENTORY_PATH, FAMILY_REGISTRY_PATH,
    IDENTITY_PATH, INVENTORY_FILES, IUPAC_FILES, LIGAND_STATE_SPLITTING_SPEC,
    PRIMARY_PATH, TARGET_PATH,
)
from sft.chemistry.ligand_state_splitting_validation_v1 import LigandStateSplittingValidator
from sft.engine import ExternalCommandValidator
from sft.engine.source import build_source_manifest
from sft.verification import ClaimExecution


def build_execution(root: Path):
    identities = json.loads((root / IDENTITY_PATH).read_text(encoding="utf-8"))
    snapshot_paths = tuple(dict.fromkeys(row["snapshot_path"] for row in identities["rows"]))
    files = (
        root / "sft/chemistry/ligand_state_splitting_law_v1.py",
        root / "sft/chemistry/ligand_state_splitting_batch_v1.py",
        root / "sft/chemistry/ligand_state_splitting_validation_v1.py",
        root / "sft/chemistry/generated_law.py",
        root / "sft/chemistry/generated_observational_law.py",
        root / "sft/physics/generated_empirical_law.py",
        root / "tools/capture_chemistry_inorg_004_017_family_sources_v1.py",
        root / "tools/capture_chemistry_inorg_006_spectral_sources_v1.py",
        root / "tools/capture_chemistry_inorg_006_spectral_sources_v2.py",
        root / "tools/capture_chemistry_inorg_006_spectral_sources_v3.py",
        root / "tools/build_chemistry_ligand_state_splitting_primary_v1.py",
        root / FAMILY_BOUNDARY_PATH,
        root / FAMILY_REGISTRY_PATH,
        root / FAMILY_INVENTORY_PATH,
        *(root / path for path, _ in ADDENDUM_FILES),
        *(root / path for path, _ in INVENTORY_FILES),
        *(root / path for path, _ in IUPAC_FILES),
        root / IDENTITY_PATH,
        root / TARGET_PATH,
        root / PRIMARY_PATH,
        *(root / path for path in snapshot_paths),
        root / "claims/SFT-CHEM-LIGAND-STATE-SPLITTING-006/execution.py",
    )
    unique_files = tuple(dict.fromkeys(files))
    source_hash = build_source_manifest(root, unique_files).manifest_hash
    validator = root / "claims/SFT-CHEM-LIGAND-STATE-SPLITTING-006/independent_validator.py"
    return ClaimExecution(
        GeneratedObservationalChemistryProgram(LIGAND_STATE_SPLITTING_SPEC, source_hash),
        ExternalCommandValidator(
            "sft-chem-ligand-state-splitting-006-independent-python/1",
            (sys.executable, str(validator)),
            validator.parent,
            (validator,),
        ),
        unique_files,
        LigandStateSplittingValidator(root),
    )
