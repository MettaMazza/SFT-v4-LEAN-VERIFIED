"""Fold-native ligand denticity and chelation topology for INORG-003."""

from __future__ import annotations

from dataclasses import dataclass

from sft.chemistry.coordination_entity_law_v1 import CompleteCoordinationEntity
from sft.engine.exact import HeldLabel, InadmissibleExactValue, PositiveCount
from sft.physics.generated_empirical_law import LawDimension, dimension


@dataclass(frozen=True)
class CompleteLigandDonorTopology:
    """One retained ligand carrier and all its donor incidences to one centre."""

    ligand_carrier_occurrence: HeldLabel
    ligand_group_identity: HeldLabel
    central_occurrence: HeldLabel
    ordered_donor_site_occurrences: tuple[HeldLabel, ...]
    ordered_attachment_traces: tuple[HeldLabel, ...]
    ordered_internal_connection_traces: tuple[HeldLabel, ...]

    def __post_init__(self) -> None:
        if (
            not isinstance(self.ligand_carrier_occurrence, HeldLabel)
            or self.ligand_carrier_occurrence.family != "coordination-ligand-carrier-occurrence"
        ):
            raise InadmissibleExactValue("denticity requires one retained ligand carrier occurrence")
        if (
            not isinstance(self.ligand_group_identity, HeldLabel)
            or self.ligand_group_identity.family != "coordination-ligand-group"
        ):
            raise InadmissibleExactValue("denticity requires one retained ligand group identity")
        if (
            not isinstance(self.central_occurrence, HeldLabel)
            or self.central_occurrence.family != "coordination-central-occurrence"
        ):
            raise InadmissibleExactValue("denticity requires one retained central occurrence")
        if not self.ordered_donor_site_occurrences:
            raise InadmissibleExactValue("a ligand carrier requires positive donor-site support")
        if any(
            not isinstance(site, HeldLabel) or site.family != "coordination-ligand-occurrence"
            for site in self.ordered_donor_site_occurrences
        ):
            raise InadmissibleExactValue("every donor site must retain its occurrence")
        if len(set(self.ordered_donor_site_occurrences)) != len(self.ordered_donor_site_occurrences):
            raise InadmissibleExactValue("distinct donor sites cannot collapse")
        if len(self.ordered_attachment_traces) != len(self.ordered_donor_site_occurrences):
            raise InadmissibleExactValue("every donor site requires one central attachment trace")
        if any(
            not isinstance(trace, HeldLabel) or trace.family != "positive-coordination-incidence"
            for trace in self.ordered_attachment_traces
        ) or len(set(self.ordered_attachment_traces)) != len(self.ordered_attachment_traces):
            raise InadmissibleExactValue("central attachment traces must be positive and distinct")
        required_internal_width = len(self.ordered_donor_site_occurrences) - 1
        if len(self.ordered_internal_connection_traces) != required_internal_width:
            raise InadmissibleExactValue("donor sites must retain one complete gap-free internal path")
        if any(
            not isinstance(trace, HeldLabel)
            or trace.family != "positive-ligand-internal-incidence"
            for trace in self.ordered_internal_connection_traces
        ) or len(set(self.ordered_internal_connection_traces)) != len(
            self.ordered_internal_connection_traces
        ):
            raise InadmissibleExactValue("internal ligand path traces must be positive and distinct")


@dataclass(frozen=True)
class ExactLigandDenticityChelationRecord:
    ligand_carrier_occurrence: HeldLabel
    central_occurrence: HeldLabel
    positive_denticity: PositiveCount
    ordered_donor_site_occurrences: tuple[HeldLabel, ...]
    ordered_attachment_traces: tuple[HeldLabel, ...]
    ordered_internal_connection_traces: tuple[HeldLabel, ...]
    chelation_state: HeldLabel
    closed_topology_trace: tuple[HeldLabel, ...]


def forced_ligand_denticity_and_chelation(
    entity: CompleteCoordinationEntity,
    topology: CompleteLigandDonorTopology,
) -> ExactLigandDenticityChelationRecord:
    if not isinstance(entity, CompleteCoordinationEntity):
        raise InadmissibleExactValue("denticity requires an admitted complete coordination entity")
    if not isinstance(topology, CompleteLigandDonorTopology):
        raise InadmissibleExactValue("denticity requires complete connected donor-site support")
    if topology.central_occurrence != entity.central_occurrence:
        raise InadmissibleExactValue("ligand topology cannot change the retained central occurrence")

    entity_bindings = {
        (row.ligand_occurrence, row.ligand_group_identity, row.attachment_trace)
        for row in entity.ordered_attachments
    }
    topology_bindings = set(
        zip(
            topology.ordered_donor_site_occurrences,
            (topology.ligand_group_identity,) * len(topology.ordered_donor_site_occurrences),
            topology.ordered_attachment_traces,
        )
    )
    if len(topology_bindings) != len(topology.ordered_donor_site_occurrences):
        raise InadmissibleExactValue("ligand donor bindings cannot collapse")
    if not topology_bindings.issubset(entity_bindings):
        raise InadmissibleExactValue("ligand topology contains an attachment outside the complete entity")

    denticity = PositiveCount(len(topology.ordered_donor_site_occurrences))
    if len(topology.ordered_donor_site_occurrences) == 1:
        state = HeldLabel("chelation-state", "single-site-open-topology")
        closed_trace: tuple[HeldLabel, ...] = ()
    else:
        state = HeldLabel("chelation-state", "multiple-separate-sites-one-ligand-one-centre-closed-topology")
        closed_trace = (
            topology.ordered_attachment_traces[0],
            *topology.ordered_internal_connection_traces,
            topology.ordered_attachment_traces[-1],
        )
    return ExactLigandDenticityChelationRecord(
        topology.ligand_carrier_occurrence,
        topology.central_occurrence,
        denticity,
        topology.ordered_donor_site_occurrences,
        topology.ordered_attachment_traces,
        topology.ordered_internal_connection_traces,
        state,
        closed_trace,
    )


def append_donor_site_preserves_topology_and_increments_denticity(
    entity: CompleteCoordinationEntity,
    topology: CompleteLigandDonorTopology,
    donor_site: HeldLabel,
    attachment_trace: HeldLabel,
    internal_connection_trace: HeldLabel,
) -> bool:
    before = forced_ligand_denticity_and_chelation(entity, topology)
    extended = CompleteLigandDonorTopology(
        topology.ligand_carrier_occurrence,
        topology.ligand_group_identity,
        topology.central_occurrence,
        topology.ordered_donor_site_occurrences + (donor_site,),
        topology.ordered_attachment_traces + (attachment_trace,),
        topology.ordered_internal_connection_traces + (internal_connection_trace,),
    )
    after = forced_ligand_denticity_and_chelation(entity, extended)
    prior_width = len(before.ordered_donor_site_occurrences)
    return (
        after.ligand_carrier_occurrence == before.ligand_carrier_occurrence
        and after.central_occurrence == before.central_occurrence
        and after.positive_denticity.value == before.positive_denticity.value + 1
        and after.ordered_donor_site_occurrences[:prior_width]
        == before.ordered_donor_site_occurrences
        and after.ordered_attachment_traces[:prior_width] == before.ordered_attachment_traces
        and after.ordered_internal_connection_traces[:-1]
        == before.ordered_internal_connection_traces
    )


DEPENDENCIES = (
    "SFT-FOUNDATION-FORM-ENFORCEMENT-001",
    "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",
    "SFT-MATH-EXACT-ARITHMETIC-001",
    "SFT-MATH-DISCRETE-001",
    "SFT-MATH-COMBINATORICS-001",
    "SFT-MATH-GRAPH-NETWORK-001",
    "SFT-INFO-SYMBOL-DISTINCTION-001",
    "SFT-INFO-CONSERVATION-LOSS-001",
    "SFT-COMP-FORM-STATE-TRANSITION-001",
    "SFT-CHEM-MEAS-CHEMICAL-ENTITY-001",
    "SFT-CHEM-BOND-CHEMICAL-BOND-001",
    "SFT-CHEM-STOICH-COMPOSITION-001",
    "SFT-CHEM-COORDINATION-ENTITY-RETAINED-IDENTITY-001",
    "SFT-CHEM-COORDINATION-NUMBER-INCIDENCE-COUNT-002",
)


DIMENSIONS: tuple[LawDimension, ...] = (
    dimension("carrier", "chemical-label-only", "A repeated chemical label does not distinguish a given ligand occurrence.", "one-retained-ligand-carrier-occurrence", "Every donor site is assigned to one exact ligand carrier occurrence."),
    dimension("membership", "selected-or-nearby-donor-sites", "Selection and proximity do not preserve complete binding support.", "every-distinct-donor-site-on-that-carrier", "Every and only distinct sites belonging to the given ligand carrier enter."),
    dimension("centre", "donor-sites-across-centres-merged", "Merging centres destroys the one-centre relation.", "same-retained-central-occurrence", "All counted donor sites attach to the same retained central occurrence."),
    dimension("quantity", "imported-denticity-name-or-table", "A conventional name or table selects the count.", "positive-count-of-generated-donor-incidences", "The complete donor-incidence support forces its positive cardinality."),
    dimension("chelation", "two-or-more-label-imported-as-threshold", "A named threshold does not explain the topology.", "first-closed-carrier-centre-path-forces-chelation", "The second separate site is the first successor that closes a carrier-centre path; every later site preserves closure."),
    dimension("boundary", "eta-kappa-and-separate-sites-collapsed", "Collapsing attachment modes confuses atoms with separate binding sites.", "separate-site-and-attachment-topologies-held", "Separate donor sites, single-atom attachments and multi-atom pi support remain distinguishable."),
    dimension("observation", "source-topologies-readable-before-seal", "Observed classifications could select the law.", "complete-24-record-value-free-identity-seal", "Twenty-four value-free identities seal before definitions, examples and exclusions open."),
    dimension("extension", "next-site-recounts-or-replaces-prior-support", "Replacement destroys the retained carrier topology.", "next-site-preserves-prior-and-adds-one", "The next donor site preserves all prior sites and paths and adds exactly one."),
)


EXACT_RESULT = (
    "one-retained-ligand-carrier-occurrence__every-distinct-donor-site-on-that-carrier__"
    "same-retained-central-occurrence__positive-count-of-generated-donor-incidences__"
    "first-closed-carrier-centre-path-forces-chelation__separate-site-and-attachment-topologies-held__"
    "complete-24-record-value-free-identity-seal__next-site-preserves-prior-and-adds-one"
)


def _entity(width: int) -> CompleteCoordinationEntity:
    from sft.chemistry.coordination_entity_law_v1 import RetainedCoordinationAttachment

    central = HeldLabel("coordination-central-occurrence", "M-one")
    group = HeldLabel("coordination-ligand-group", "given-ligand-group")
    attachments = tuple(
        RetainedCoordinationAttachment(
            PositiveCount(number),
            central,
            HeldLabel("coordination-ligand-occurrence", f"donor-{number}"),
            group,
            HeldLabel("positive-coordination-incidence", f"central-donor-{number}"),
        )
        for number in range(1, width + 1)
    )
    return CompleteCoordinationEntity(
        HeldLabel("coordination-entity", f"entity-{width}"),
        HeldLabel("coordination-central-element", "M"),
        central,
        attachments,
    )


def _topology(width: int) -> CompleteLigandDonorTopology:
    entity = _entity(width)
    return CompleteLigandDonorTopology(
        HeldLabel("coordination-ligand-carrier-occurrence", "ligand-one"),
        HeldLabel("coordination-ligand-group", "given-ligand-group"),
        entity.central_occurrence,
        tuple(row.ligand_occurrence for row in entity.ordered_attachments),
        tuple(row.attachment_trace for row in entity.ordered_attachments),
        tuple(
            HeldLabel("positive-ligand-internal-incidence", f"donor-{number}-to-{number + 1}")
            for number in range(1, width)
        ),
    )


_BASE_ENTITY = _entity(2)
_BASE_TOPOLOGY = _topology(2)
_BASE_RESULT = forced_ligand_denticity_and_chelation(_BASE_ENTITY, _BASE_TOPOLOGY)
_THREE_ENTITY = _entity(3)

OPERATIONAL_WITNESSES = (
    ("denticity-two", "Two generated donor sites on one ligand carrier and centre force positive denticity two.", _BASE_RESULT.positive_denticity == PositiveCount(2)),
    ("first-closed-topology", "The first multiple-site support closes a centre-carrier path.", len(_BASE_RESULT.closed_topology_trace) == 3),
    ("single-site-open", "One donor site remains an open topology rather than a chelate.", forced_ligand_denticity_and_chelation(_entity(1), _topology(1)).chelation_state.label == "single-site-open-topology"),
    ("successor", "The next donor site preserves every prior site and path and increments denticity once.", append_donor_site_preserves_topology_and_increments_denticity(
        _THREE_ENTITY,
        CompleteLigandDonorTopology(
            _BASE_TOPOLOGY.ligand_carrier_occurrence,
            _BASE_TOPOLOGY.ligand_group_identity,
            _BASE_TOPOLOGY.central_occurrence,
            _BASE_TOPOLOGY.ordered_donor_site_occurrences,
            _BASE_TOPOLOGY.ordered_attachment_traces,
            _BASE_TOPOLOGY.ordered_internal_connection_traces,
        ),
        _THREE_ENTITY.ordered_attachments[2].ligand_occurrence,
        _THREE_ENTITY.ordered_attachments[2].attachment_trace,
        HeldLabel("positive-ligand-internal-incidence", "donor-2-to-3"),
    )),
)


__all__ = (
    "CompleteLigandDonorTopology",
    "DEPENDENCIES",
    "DIMENSIONS",
    "EXACT_RESULT",
    "ExactLigandDenticityChelationRecord",
    "OPERATIONAL_WITNESSES",
    "append_donor_site_preserves_topology_and_increments_denticity",
    "forced_ligand_denticity_and_chelation",
)
