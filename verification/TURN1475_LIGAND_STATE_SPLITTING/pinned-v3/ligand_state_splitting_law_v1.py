"""Fold-native ligand/state interaction and exact splitting law for INORG-006."""

from __future__ import annotations

from dataclasses import dataclass
from itertools import combinations
from typing import Union

from sft.claim_evidence import EmptyOne
from sft.engine.exact import ExactPart, HeldLabel, InadmissibleExactValue, PositiveCount
from sft.physics.generated_empirical_law import LawDimension, dimension


OrientationCell = Union[HeldLabel, EmptyOne]
InteractionRank = Union[PositiveCount, EmptyOne]


@dataclass(frozen=True)
class GeneratedRankTwoSupport:
    """One of the five supports forced by rank three with rank-two relations."""

    support_identity: HeldLabel
    support_kind: HeldLabel
    first_axis: PositiveCount
    second_axis: PositiveCount

    def __post_init__(self) -> None:
        if self.support_identity.family != "rank-two-state-support":
            raise InadmissibleExactValue("rank-two support requires a retained identity")
        if self.support_kind.family != "rank-two-support-kind" or self.support_kind.label not in {
            "held-axis-contrast", "boundary-axis-pair"
        }:
            raise InadmissibleExactValue("rank-two support requires a generated kind")
        if self.first_axis.value >= self.second_axis.value or self.second_axis.value > 3:
            raise InadmissibleExactValue("rank-two support axes must be one generated pair in rank three")


def generate_complete_rank_two_support() -> tuple[GeneratedRankTwoSupport, ...]:
    """Generate two independent held contrasts plus all three boundary pairs."""

    contrasts = tuple(
        GeneratedRankTwoSupport(
            HeldLabel("rank-two-state-support", f"held-contrast-{first}-{second}"),
            HeldLabel("rank-two-support-kind", "held-axis-contrast"),
            PositiveCount(first),
            PositiveCount(second),
        )
        for first, second in ((1, 2), (2, 3))
    )
    boundary_pairs = tuple(
        GeneratedRankTwoSupport(
            HeldLabel("rank-two-state-support", f"boundary-pair-{first}-{second}"),
            HeldLabel("rank-two-support-kind", "boundary-axis-pair"),
            PositiveCount(first),
            PositiveCount(second),
        )
        for first, second in combinations((1, 2, 3), 2)
    )
    result = contrasts + boundary_pairs
    if len(result) != 5 or len({row.support_identity for row in result}) != 5:
        raise InadmissibleExactValue("generator three and boundary rank two must produce five supports")
    return result


@dataclass(frozen=True)
class LigandInteractionGeometry:
    central_identity: HeldLabel
    ligand_orientation_words: tuple[tuple[OrientationCell, OrientationCell, OrientationCell], ...]

    def __post_init__(self) -> None:
        if self.central_identity.family != "coordination-central-occurrence":
            raise InadmissibleExactValue("ligand interaction requires one retained centre")
        if not self.ligand_orientation_words:
            raise InadmissibleExactValue("ligand interaction geometry requires positive attached support")
        if len(set(self.ligand_orientation_words)) != len(self.ligand_orientation_words):
            raise InadmissibleExactValue("every attached ligand occurrence requires a distinct orientation word")
        for word in self.ligand_orientation_words:
            if len(word) != 3 or all(isinstance(cell, EmptyOne) for cell in word):
                raise InadmissibleExactValue("each ligand requires a nonempty three-axis word")
            for cell in word:
                if isinstance(cell, HeldLabel) and (
                    cell.family != "fold-orientation-fibre" or cell.label not in {"fibre-one", "fibre-two"}
                ):
                    raise InadmissibleExactValue("orientation admits only the two forced Fold fibres")
                if not isinstance(cell, (HeldLabel, EmptyOne)):
                    raise InadmissibleExactValue("orientation cells are Fold fibres or structural EmptyOne")

    @property
    def positive_ligand_count(self) -> PositiveCount:
        return PositiveCount(len(self.ligand_orientation_words))


def _present(cell: OrientationCell) -> bool:
    return isinstance(cell, HeldLabel)


def interaction_rank(support: GeneratedRankTwoSupport, geometry: LigandInteractionGeometry) -> InteractionRank:
    """Count exact incidence without a conventional orbital or field model."""

    first = support.first_axis.value - 1
    second = support.second_axis.value - 1
    matches = tuple(
        word
        for word in geometry.ligand_orientation_words
        if (
            (_present(word[first]) != _present(word[second]))
            if support.support_kind.label == "held-axis-contrast"
            else (_present(word[first]) and _present(word[second]))
        )
    )
    return EmptyOne() if not matches else PositiveCount(len(matches))


@dataclass(frozen=True)
class ExactSplitLevel:
    interaction_rank: InteractionRank
    members: tuple[GeneratedRankTwoSupport, ...]

    def __post_init__(self) -> None:
        if not self.members or len(set(self.members)) != len(self.members):
            raise InadmissibleExactValue("a split level requires positive distinct member support")

    @property
    def positive_multiplicity(self) -> PositiveCount:
        return PositiveCount(len(self.members))


@dataclass(frozen=True)
class ExactLigandStateSplitting:
    central_identity: HeldLabel
    unperturbed_positive_multiplicity: PositiveCount
    levels: tuple[ExactSplitLevel, ...]
    adjacent_positive_separations: tuple[ExactPart, ...]
    lower_distance_from_unsplit_or_absence: Union[ExactPart, EmptyOne]
    upper_distance_from_unsplit_or_absence: Union[ExactPart, EmptyOne]
    complete_member_preservation: bool

    def __post_init__(self) -> None:
        if not self.levels:
            raise InadmissibleExactValue("splitting requires at least one retained level")
        if sum(level.positive_multiplicity.value for level in self.levels) != self.unperturbed_positive_multiplicity.value:
            raise InadmissibleExactValue("splitting must preserve every unperturbed component")
        if len(self.adjacent_positive_separations) + 1 != len(self.levels):
            raise InadmissibleExactValue("every adjacent split pair requires one exact separation")
        if len(self.levels) == 2:
            if not isinstance(self.lower_distance_from_unsplit_or_absence, ExactPart) or not isinstance(self.upper_distance_from_unsplit_or_absence, ExactPart):
                raise InadmissibleExactValue("a two-level split requires both positive balance distances")
            lower_width = self.levels[0].positive_multiplicity.value
            upper_width = self.levels[1].positive_multiplicity.value
            if (
                lower_width * self.lower_distance_from_unsplit_or_absence.value
                != upper_width * self.upper_distance_from_unsplit_or_absence.value
            ):
                raise InadmissibleExactValue("two-level splitting must preserve the unsplit balance exactly")
        elif not isinstance(self.lower_distance_from_unsplit_or_absence, EmptyOne) or not isinstance(self.upper_distance_from_unsplit_or_absence, EmptyOne):
            raise InadmissibleExactValue("non-binary splitting retains no invented pair-balance distance")


def _rank_key(value: InteractionRank) -> tuple[str, PositiveCount]:
    return ("absence-rank", PositiveCount(1)) if isinstance(value, EmptyOne) else ("positive-rank", value)


def forced_ligand_state_splitting(geometry: LigandInteractionGeometry) -> ExactLigandStateSplitting:
    """Partition all five generated supports by complete ligand-incidence signature."""

    supports = generate_complete_rank_two_support()
    groups: dict[tuple[str, PositiveCount], list[GeneratedRankTwoSupport]] = {}
    ranks: dict[tuple[str, PositiveCount], InteractionRank] = {}
    for support in supports:
        rank = interaction_rank(support, geometry)
        key = _rank_key(rank)
        groups.setdefault(key, []).append(support)
        ranks[key] = rank
    ordered_keys = tuple(sorted(groups))
    levels = tuple(ExactSplitLevel(ranks[key], tuple(groups[key])) for key in ordered_keys)
    separations = []
    for lower_key, upper_key in zip(ordered_keys, ordered_keys[1:]):
        lower = ranks[lower_key]
        upper = ranks[upper_key]
        numerator = upper.value if isinstance(lower, EmptyOne) else upper.value - lower.value
        separations.append(ExactPart.from_pair(numerator, geometry.positive_ligand_count.value))

    if len(levels) == 2:
        total = sum(level.positive_multiplicity.value for level in levels)
        lower_distance: Union[ExactPart, EmptyOne] = ExactPart.from_pair(levels[1].positive_multiplicity.value, total)
        upper_distance: Union[ExactPart, EmptyOne] = ExactPart.from_pair(levels[0].positive_multiplicity.value, total)
    else:
        lower_distance = EmptyOne()
        upper_distance = EmptyOne()
    all_members = tuple(member for level in levels for member in level.members)
    return ExactLigandStateSplitting(
        geometry.central_identity,
        PositiveCount(len(supports)),
        levels,
        tuple(separations),
        lower_distance,
        upper_distance,
        set(all_members) == set(supports) and len(all_members) == len(supports),
    )


def removed_ligand_remerging(central_identity: HeldLabel) -> ExactLigandStateSplitting:
    """Removing the distinguishing interaction restores one five-member class."""

    supports = generate_complete_rank_two_support()
    return ExactLigandStateSplitting(
        central_identity,
        PositiveCount(5),
        (ExactSplitLevel(EmptyOne(), supports),),
        (),
        EmptyOne(),
        EmptyOne(),
        True,
    )


def _fibre(label: str) -> HeldLabel:
    return HeldLabel("fold-orientation-fibre", label)


def _empty() -> EmptyOne:
    return EmptyOne()


def six_direct_axis_geometry() -> LigandInteractionGeometry:
    return LigandInteractionGeometry(
        HeldLabel("coordination-central-occurrence", "six-direct-axis-centre"),
        (
            (_fibre("fibre-one"), _empty(), _empty()),
            (_fibre("fibre-two"), _empty(), _empty()),
            (_empty(), _fibre("fibre-one"), _empty()),
            (_empty(), _fibre("fibre-two"), _empty()),
            (_empty(), _empty(), _fibre("fibre-one")),
            (_empty(), _empty(), _fibre("fibre-two")),
        ),
    )


def four_complete_axis_geometry() -> LigandInteractionGeometry:
    return LigandInteractionGeometry(
        HeldLabel("coordination-central-occurrence", "four-complete-axis-centre"),
        (
            (_fibre("fibre-one"), _fibre("fibre-one"), _fibre("fibre-one")),
            (_fibre("fibre-one"), _fibre("fibre-two"), _fibre("fibre-two")),
            (_fibre("fibre-two"), _fibre("fibre-one"), _fibre("fibre-two")),
            (_fibre("fibre-two"), _fibre("fibre-two"), _fibre("fibre-one")),
        ),
    )


DEPENDENCIES = (
    "SFT-FOUNDATION-FORM-ENFORCEMENT-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",
    "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DISCRETE-001", "SFT-MATH-COMBINATORICS-001",
    "SFT-MATH-ORDER-LATTICE-001", "SFT-MATH-GEOMETRY-TOPOLOGY-001",
    "SFT-INFO-SYMBOL-DISTINCTION-001", "SFT-INFO-CONSERVATION-LOSS-001",
    "SFT-COMP-FORM-STATE-TRANSITION-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001",
    "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001",
    "SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001", "SFT-CHEM-ORBITAL-SUPPORT-OCCUPANCY-003",
    "SFT-CHEM-STATE-ENERGY-ORDER-004", "SFT-CHEM-STATE-SYMMETRY-DEGENERACY-005",
    "SFT-CHEM-MOLECULAR-STATE-TRANSITION-009", "SFT-CHEM-SELECTION-RULE-STRUCTURE-010",
    "SFT-CHEM-COORDINATION-GEOMETRY-HELD-ORIENTATION-004",
    "SFT-CHEM-COORDINATION-ISOMERISM-EQUIVALENCE-005",
)


DIMENSIONS: tuple[LawDimension, ...] = (
    dimension("carrier", "imported-orbital-or-field-table", "A named table imports the desired splitting.", "generated-rank-three-boundary-two-support", "Three directions and rank-two relation generate two held contrasts and three boundary pairs."),
    dimension("interaction", "free-field-strength-or-fitted-parameter", "A free strength can fit any spectrum.", "complete-ligand-support-incidence", "Every component receives its exact XOR or joint boundary incidence against every retained ligand word."),
    dimension("partition", "asserted-level-catalogue", "An asserted catalogue does not derive degeneracy removal.", "complete-equivalence-partition-by-incidence", "Equal signatures remain one level and every unequal signature is separated."),
    dimension("multiplicity", "free-degeneracy-label", "A free degeneracy loses member conservation.", "positive-cardinality-of-each-partition-block", "Each level multiplicity is its exact positive member count and all five members remain."),
    dimension("separation", "signed-floating-or-dimensional-gap", "Signed or fitted gaps violate the exact Fold domain.", "exact-positive-normalized-incidence-separation", "Adjacent levels carry the positive excess incidence divided by complete ligand count."),
    dimension("balance", "opposite-signed-shift-premise", "Signed displacements import negative values.", "complementary-positive-two-block-distances", "For two blocks, complementary member counts force positive distances whose weighted products are equal."),
    dimension("observation", "selected-peak-or-favourable-spectrum", "Selected peaks can manufacture correspondence.", "complete-sealed-definition-and-spectrum-surfaces", "Both IUPAC records and all three complete NIST pages with every discovered payload, ancillary row and boundary condition are retained."),
    dimension("extension", "species-specific-exception-or-reclassification", "An exception permits outcomes to select the law.", "same-partition-law-and-removed-ligand-remerging", "The same incidence partition applies to every finite geometry and removing the interaction restores one class."),
)


EXACT_RESULT = "generated-rank-three-boundary-two-support__complete-ligand-support-incidence__complete-equivalence-partition-by-incidence__positive-cardinality-of-each-partition-block__exact-positive-normalized-incidence-separation__complementary-positive-two-block-distances__complete-sealed-definition-and-spectrum-surfaces__same-partition-law-and-removed-ligand-remerging"


_SIX = forced_ligand_state_splitting(six_direct_axis_geometry())
_FOUR = forced_ligand_state_splitting(four_complete_axis_geometry())
_REMOVED = removed_ligand_remerging(HeldLabel("coordination-central-occurrence", "removed-ligand-centre"))


OPERATIONAL_WITNESSES = (
    ("five-support-generator", "Rank three with rank-two relations forces exactly two held contrasts and three boundary pairs.", len(generate_complete_rank_two_support()) == 5),
    ("six-direct-axis-partition", "Six direct-axis occurrences force a lower three-member boundary-pair block and upper two-member held-contrast block.", tuple(level.positive_multiplicity.value for level in _SIX.levels) == (3, 2)),
    ("six-direct-axis-balance", "The two blocks force lower and upper positive distances two-fifths and three-fifths.", isinstance(_SIX.lower_distance_from_unsplit_or_absence, ExactPart) and _SIX.lower_distance_from_unsplit_or_absence == ExactPart.from_pair(2, 5) and _SIX.upper_distance_from_unsplit_or_absence == ExactPart.from_pair(3, 5)),
    ("four-complete-axis-reversal", "Four complete-axis occurrences force a lower two-member held-contrast block and upper three-member boundary-pair block.", tuple(level.positive_multiplicity.value for level in _FOUR.levels) == (2, 3)),
    ("member-conservation", "Both interactions preserve all five generated supports exactly once.", _SIX.complete_member_preservation and _FOUR.complete_member_preservation),
    ("removed-interaction-remerging", "Removing ligand distinction restores one five-member equivalence class without numerical zero.", len(_REMOVED.levels) == 1 and _REMOVED.levels[0].positive_multiplicity == PositiveCount(5) and isinstance(_REMOVED.levels[0].interaction_rank, EmptyOne)),
)


__all__ = (
    "DEPENDENCIES", "DIMENSIONS", "EXACT_RESULT", "ExactLigandStateSplitting", "ExactSplitLevel",
    "GeneratedRankTwoSupport", "LigandInteractionGeometry", "OPERATIONAL_WITNESSES",
    "forced_ligand_state_splitting", "four_complete_axis_geometry", "generate_complete_rank_two_support",
    "interaction_rank", "removed_ligand_remerging", "six_direct_axis_geometry",
)
