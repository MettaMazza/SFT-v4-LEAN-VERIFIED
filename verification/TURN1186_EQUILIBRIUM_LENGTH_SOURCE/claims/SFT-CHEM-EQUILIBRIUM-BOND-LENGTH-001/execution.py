"""Official execution binding for SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001."""
from pathlib import Path
import sys
from sft.engine import ExternalCommandValidator
from sft.engine.source import build_source_manifest
from sft.chemistry.equilibrium_bond_length_batch_v1 import EQUILIBRIUM_BOND_LENGTH_SPEC, GeneratedFiniteQuantitativeChemistryProgram
from sft.chemistry.equilibrium_bond_length_validation_v1 import EquilibriumBondLengthValidator
from sft.verification import ClaimExecution

def build_execution(root: Path) -> ClaimExecution:
    source_files = (
        root / "sft/chemistry/equilibrium_bond_length_law_v1.py",
        root / "sft/chemistry/equilibrium_bond_length_batch_v1.py",
        root / "sft/chemistry/equilibrium_bond_length_validation_v1.py",
        root / "sft/chemistry/generated_law.py",
        root / "sft/chemistry/generated_observational_law.py",
        root / "sft/physics/generated_empirical_law.py",
        root / "sft/physics/atomic_constants.py",
        root / "sft/physics/molecular_spectroscopy_successor_laws_v1.py",
        root / "sft/physics/molecular_spectroscopy_successor_validation_v1.py",
        root / "claims/SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001/execution.py",
    )
    source_hash = build_source_manifest(root, source_files).manifest_hash
    validator = root / "claims/SFT-CHEM-EQUILIBRIUM-BOND-LENGTH-001/independent_validator.py"
    return ClaimExecution(
        program=GeneratedFiniteQuantitativeChemistryProgram(EQUILIBRIUM_BOND_LENGTH_SPEC, source_hash),
        independent_validator=ExternalCommandValidator(
            "sft-chem-equilibrium-bond-length-001-independent-python/1",
            (sys.executable, str(validator)),
            validator.parent,
            (validator,),
        ),
        source_files=source_files,
        empirical_validator=EquilibriumBondLengthValidator(root),
    )
