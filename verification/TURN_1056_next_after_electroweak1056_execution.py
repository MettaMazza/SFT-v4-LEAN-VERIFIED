from sft.physics.common_scale_measured_value_successor_execution_v1 import build_execution as _build_execution


def build_execution(root):
    return _build_execution(root, root / "claims/SFT-PHYS-VALIDATION-COMMON-SCALE-MEASURED-VALUE-054/execution.py")


__all__ = ("build_execution",)
