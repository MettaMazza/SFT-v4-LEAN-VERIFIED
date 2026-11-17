"""Fold-native molecular configuration-order law for ELEC-011."""

from __future__ import annotations

from dataclasses import dataclass
from typing import Union

from sft.claim_evidence import PositiveRatio
from sft.claim_evidence.fold_language import EMPTY_ONE, EmptyOne
from sft.engine.exact import HeldLabel, InadmissibleExactValue
from sft.physics.generated_empirical_law import LawDimension, dimension


ExactHeight = Union[PositiveRatio, EmptyOne]


@dataclass(frozen=True)
class ConfigurationNode:
    carrier: HeldLabel
    coordinate: HeldLabel
    height: ExactHeight
    record: HeldLabel

    def __post_init__(self) -> None:
        if self.carrier.family != "molecular-carrier" or self.coordinate.family != "configuration-coordinate" or self.record.family != "configuration-record":
            raise InadmissibleExactValue("configuration node must retain carrier, coordinate and record")
        if not isinstance(self.height, (PositiveRatio, EmptyOne)):
            raise InadmissibleExactValue("configuration height is exact positive or structural EmptyOne")


@dataclass(frozen=True)
class ConfigurationPath:
    nodes: tuple[ConfigurationNode, ...]

    def __post_init__(self) -> None:
        if not self.nodes or len({node.carrier for node in self.nodes}) != 1:
            raise InadmissibleExactValue("one configuration path requires one retained molecular carrier")

    def local_minimum(self, position: int) -> bool:
        if position <= 0 or position >= len(self.nodes) - 1:
            raise InadmissibleExactValue("a local configuration comparison requires two neighbours")
        centre, left, right = self.nodes[position].height, self.nodes[position - 1].height, self.nodes[position + 1].height
        if centre is EMPTY_ONE:
            return left is not EMPTY_ONE and right is not EMPTY_ONE
        if left is EMPTY_ONE or right is EMPTY_ONE:
            return False
        return centre.fraction < left.fraction and centre.fraction < right.fraction

    def local_barrier(self, position: int) -> bool:
        if position <= 0 or position >= len(self.nodes) - 1:
            raise InadmissibleExactValue("a barrier comparison requires two neighbours")
        centre, left, right = self.nodes[position].height, self.nodes[position - 1].height, self.nodes[position + 1].height
        if centre is EMPTY_ONE or left is EMPTY_ONE or right is EMPTY_ONE:
            return centre is not EMPTY_ONE and (left is EMPTY_ONE or right is EMPTY_ONE)
        return centre.fraction > left.fraction and centre.fraction > right.fraction


DEPENDENCIES = (
    "SFT-FOUNDATION-FORM-ENFORCEMENT-001", "SFT-MATH-EXACT-ARITHMETIC-001",
    "SFT-MATH-DISCRETE-001", "SFT-MATH-GRAPH-NETWORK-001", "SFT-MATH-ORDER-LATTICE-001",
    "SFT-INFO-SYMBOL-DISTINCTION-001", "SFT-COMP-FORM-STATE-TRANSITION-001",
    "SFT-CHEM-MOLECULAR-STATE-TRANSITION-009", "SFT-CHEM-SELECTION-RULE-STRUCTURE-010",
)


DIMENSIONS: tuple[LawDimension, ...] = (
    dimension("carrier", "coordinate-only-surface", "Coordinates without the molecular carrier do not identify one chemical configuration space.", "retained-molecular-carrier", "Every node retains one carrier."),
    dimension("configuration", "continuum-point-premise", "A continuum potential coordinate imports an ungenerated domain.", "generated-configuration-nodes", "Configurations are exact generated nodes."),
    dimension("order", "signed-or-floating-energy", "Signed or floating magnitudes violate the exact Fold domain.", "exact-positive-order-or-EmptyOne", "Heights are exact positive ratios above a structural least coordinate."),
    dimension("stability", "named-stable-structure", "A stability name alone does not decide neighbouring alternatives.", "local-minimum-by-complete-neighbours", "A basin is forced by exact comparison with every adjacent node."),
    dimension("barrier", "imported-saddle-formula", "A continuum saddle formula is unnecessary and ungenerated.", "local-barrier-by-complete-neighbours", "A transition configuration is higher than its adjacent path nodes."),
    dimension("path", "endpoint-only-reaction", "Endpoints erase intermediates and barriers.", "connected-complete-configuration-path", "Every adjacent generated configuration and its record remain in the path."),
    dimension("recurrence", "open-curve-assumption", "An internal rotation that erases closure duplicates rather than identifies its terminal configuration.", "exact-periodic-endpoint-identity", "A complete recurrence returns to the identical held configuration class."),
    dimension("record", "selected-minima-and-maxima", "Keeping extrema alone hides the empirical path.", "complete-favourable-and-adverse-vector", "Every measured configuration row, including non-extrema, is retained."),
)


def _witnesses() -> tuple[tuple[str, str, bool], ...]:
    carrier = HeldLabel("molecular-carrier", "ethanol")
    def node(name: str, pair):
        height = EMPTY_ONE if pair is None else PositiveRatio.from_pair(*pair)
        return ConfigurationNode(carrier, HeldLabel("configuration-coordinate", name), height, HeldLabel("configuration-record", name))
    path = ConfigurationPath((node("left", (2, 1)), node("basin", None), node("right", (3, 1)), node("barrier", (5, 1)), node("terminal", (1, 1))))
    return (
        ("basin", "Structural least coordinate is lower than both exact neighbours.", path.local_minimum(1)),
        ("barrier", "A transition configuration is higher than both exact neighbours.", path.local_barrier(3)),
        ("path", "Every node retains one carrier and record.", len(path.nodes) == 5),
        ("invalid", "An empty configuration path rejects.", _empty_path_rejects()),
    )


def _empty_path_rejects() -> bool:
    try:
        ConfigurationPath(())
    except InadmissibleExactValue:
        return True
    return False


OPERATIONAL_WITNESSES = _witnesses()
EXACT_RESULT = "retained-molecular-carrier__generated-configuration-nodes__exact-positive-order-or-EmptyOne__local-minimum-by-complete-neighbours__local-barrier-by-complete-neighbours__connected-complete-configuration-path__exact-periodic-endpoint-identity__complete-favourable-and-adverse-vector"


__all__ = ("ConfigurationNode", "ConfigurationPath", "DEPENDENCIES", "DIMENSIONS", "EXACT_RESULT", "OPERATIONAL_WITNESSES")
