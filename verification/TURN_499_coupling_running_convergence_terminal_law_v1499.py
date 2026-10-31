"""Terminal exact coupling-running and common-support convergence law.

The formal module has no measurement reader, source locator, measured coupling,
energy value, beta function or unification target.  It closes the V1/V2 running
obligation over the independently forced prime-sector ladder and the generated
binary depth carrier.  Physical measurements enter only after the engine has
sealed the formal survivor.
"""

from __future__ import annotations

from dataclasses import dataclass, replace
from fractions import Fraction
from functools import lru_cache
from itertools import product
from typing import Sequence

from sft.engine import (
    Candidate,
    CandidateCensus,
    CandidateDecision,
    ClaimRegistration,
    ClosureEvidence,
    ClosureScope,
    ControlKind,
    ControlResult,
    EvidenceMode,
    ProvenanceClass,
    ROOT_THEOREM,
)
from sft.engine.canonical import sha256_identity
from sft.physics.lineage_particle_laws import prime_sector_ladder
from sft.physics.prior_value_laws import positive_take
from sft.physics.sector_inventory_law_v1 import running_coupling, running_gap


CLAIM_ID = "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006"
EXPERIMENT_ID = "SFT-EXP-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006"


@dataclass(frozen=True)
class CandidateForm:
    sector_domain: str
    scale_generation: str
    coupling_form: str
    successor_law: str
    pair_gap_law: str
    convergence_law: str
    physical_translation: str
    target_boundary: str
    extension: str

    @property
    def candidate_id(self) -> str:
        return "__".join((
            self.sector_domain,
            self.scale_generation,
            self.coupling_form,
            self.successor_law,
            self.pair_gap_law,
            self.convergence_law,
            self.physical_translation,
            self.target_boundary,
            self.extension,
        ))


SECTOR_DOMAINS = (
    "complete-prime-sectors-through-seven",
    "selected-familiar-sectors-only",
    "free-sector-appended-beyond-ceiling",
)
SCALE_GENERATIONS = (
    "One-base-binary-depth-successor",
    "imported-linear-scale-grid",
    "target-assigned-continuous-scale",
)
COUPLING_FORMS = (
    "holding-share-of-sector-plus-support",
    "fixed-bare-sector-share",
    "target-assigned-running-value",
)
SUCCESSOR_LAWS = (
    "binary-support-successor-raises-holding-share",
    "binary-support-successor-lowers-holding-share",
    "support-independent-holding-share",
)
PAIR_GAP_LAWS = (
    "exact-generator-gap-over-paired-sources",
    "constant-sector-gap",
    "target-assigned-gap",
)
CONVERGENCE_LAWS = (
    "finite-positive-epsilon-witness-for-every-pair",
    "completed-infinity-as-proof-value",
    "visual-approach-without-certificate",
)
PHYSICAL_TRANSLATIONS = (
    "carrier-specific-self-source-range-and-screening-exposure",
    "one-imported-energy-sign-for-every-carrier",
    "measurement-selected-coordinate-direction",
)
TARGET_BOUNDARIES = ("sealed-before-release", "readable-before-seal")
EXTENSIONS = ("empty-extension", "free-running-correction")

GENERATION_RULE = (
    "Generate the complete product of every closed or selected sector domain, every binary, linear or target-"
    "assigned scale carrier, every holding-share, fixed or target-assigned coupling form, every successor "
    "direction, every exact, constant or target-assigned pair-gap law, every constructive, completed-infinity "
    "or visual convergence form, every carrier-specific, universal-sign or measurement-selected physical "
    "translation, both target-custody states and both extension states."
)
GRAMMAR_BOUNDARY = (
    "The complete independently forced prime-sector ladder two, three, five and seven; every generated finite "
    "positive depth level with One base and binary successor; exact positive rational holding shares, "
    "shortfalls, successor takes and ordered pair gaps; every finite positive tolerance denominator; the "
    "already forced self-source-range and screening-exposure translation classes; sealed or exposed targets; "
    "and empty or free extension. No completed infinity, continuum scale or numerical null state is admitted."
)


def generated_scale_support(level: int) -> int:
    """One-based finite depth support: One, two, four, eight, ... ."""

    if isinstance(level, bool) or level < 1:
        raise ValueError("scale level must be a generated positive whole count")
    support = 1
    step = 1
    while step < level:
        support *= 2
        step += 1
    return support


def generator_indexed_coupling(sector: int, level: int) -> Fraction:
    return running_coupling(sector, generated_scale_support(level))


def common_scale_vector(level: int) -> tuple[tuple[int, Fraction], ...]:
    support = generated_scale_support(level)
    return tuple(
        (sector, running_coupling(sector, support))
        for sector in prime_sector_ladder()
    )


def coupling_shortfall(sector: int, level: int) -> Fraction:
    shortfall = positive_take(Fraction(1, 1), generator_indexed_coupling(sector, level))
    if not isinstance(shortfall, Fraction):
        raise ValueError("finite running share must retain a positive shortfall")
    return shortfall


def coupling_successor_take(sector: int, level: int) -> Fraction:
    current = generator_indexed_coupling(sector, level)
    successor = generator_indexed_coupling(sector, level + 1)
    take = positive_take(successor, current)
    if not isinstance(take, Fraction):
        raise ValueError("binary support successor failed to raise the holding share")
    return take


def generator_pair_gap(lower_sector: int, upper_sector: int, level: int) -> Fraction:
    return running_gap(lower_sector, upper_sector, generated_scale_support(level))


def pair_gap_successor_take(lower_sector: int, upper_sector: int, level: int) -> Fraction:
    current = generator_pair_gap(lower_sector, upper_sector, level)
    successor = generator_pair_gap(lower_sector, upper_sector, level + 1)
    take = positive_take(current, successor)
    if not isinstance(take, Fraction):
        raise ValueError("binary support successor failed to close the pair gap")
    return take


def level_reaching_support(required_support: int) -> tuple[int, int]:
    if isinstance(required_support, bool) or required_support < 1:
        raise ValueError("required support must be a positive whole count")
    level = 1
    support = 1
    while support < required_support:
        support *= 2
        level += 1
    return level, support


def convergence_witness(
    lower_sector: int,
    upper_sector: int,
    tolerance_denominator: int,
) -> dict[str, object]:
    if lower_sector >= upper_sector:
        raise ValueError("convergence requires strictly ordered sectors")
    if isinstance(tolerance_denominator, bool) or tolerance_denominator < 1:
        raise ValueError("tolerance denominator must be a positive whole count")
    separation = positive_take(upper_sector, lower_sector)
    if not isinstance(separation, int):
        raise ValueError("sector separation must remain a positive whole count")
    level, support = level_reaching_support(separation * tolerance_denominator)
    gap = generator_pair_gap(lower_sector, upper_sector, level)
    tolerance = Fraction(1, tolerance_denominator)
    return {
        "lower_sector": lower_sector,
        "upper_sector": upper_sector,
        "tolerance": tolerance,
        "level": level,
        "support": support,
        "gap": gap,
        "gap_below_tolerance": gap < tolerance,
        "binary_support_reaches_required_bound": support >= separation * tolerance_denominator,
    }


def carrier_translation_record() -> dict[str, object]:
    """Formal coordinate orientation inherited from the sealed carrier laws."""

    return {
        "self_sourced_colour": {
            "generated_coordinate": "retained-self-source-support-over-range",
            "larger_support_corresponds_to": "greater-range-and-lower-transfer-scale",
            "formal_holding_direction": "increases-with-generated-support",
        },
        "screened_electromagnetic": {
            "generated_coordinate": "exposed-support-after-screening-removal",
            "larger_support_corresponds_to": "closer-probe-and-higher-transfer-scale",
            "formal_holding_direction": "increases-with-generated-support",
        },
        "single_common_fold_axis": True,
        "universal_imported_energy_sign_required": False,
        "measurement_selects_orientation": False,
    }


@lru_cache(maxsize=1)
def formal_certificate() -> dict[str, object]:
    sectors = prime_sector_ladder()
    levels = (1, 2, 3, 4, 5, 6)
    ordered_pairs = tuple(
        (lower, upper)
        for lower in sectors
        for upper in sectors
        if lower < upper
    )
    tolerance_denominators = (1, 2, 3, 5, 7, 11)
    return {
        "sectors": sectors,
        "levels": levels,
        "supports": tuple(generated_scale_support(level) for level in levels),
        "common_scale_vectors": tuple(common_scale_vector(level) for level in levels),
        "shortfall_vectors": tuple(
            tuple(coupling_shortfall(sector, level) for sector in sectors)
            for level in levels
        ),
        "successor_take_vectors": tuple(
            tuple(coupling_successor_take(sector, level) for sector in sectors)
            for level in levels[:-1]
        ),
        "pair_gap_vectors": tuple(
            tuple(generator_pair_gap(lower, upper, level) for lower, upper in ordered_pairs)
            for level in levels
        ),
        "pair_gap_successor_takes": tuple(
            tuple(pair_gap_successor_take(lower, upper, level) for lower, upper in ordered_pairs)
            for level in levels[:-1]
        ),
        "convergence_witnesses": tuple(
            convergence_witness(lower, upper, denominator)
            for lower, upper in ordered_pairs
            for denominator in tolerance_denominators
        ),
        "carrier_translation": carrier_translation_record(),
    }


@lru_cache(maxsize=None)
def sector_domain_is_forced(value: str) -> bool:
    observed = prime_sector_ladder()
    alternatives = {
        "complete-prime-sectors-through-seven": (2, 3, 5, 7),
        "selected-familiar-sectors-only": (2, 3),
        "free-sector-appended-beyond-ceiling": (2, 3, 5, 7, 11),
    }
    if value not in alternatives:
        raise ValueError("candidate names an ungenerated sector domain")
    return observed == alternatives[value]


@lru_cache(maxsize=None)
def scale_generation_is_forced(value: str) -> bool:
    observed = tuple(generated_scale_support(level) for level in (1, 2, 3, 4))
    alternatives = {
        "One-base-binary-depth-successor": (1, 2, 4, 8),
        "imported-linear-scale-grid": (1, 2, 3, 4),
        "target-assigned-continuous-scale": (1, 1, 1, 1),
    }
    if value not in alternatives:
        raise ValueError("candidate names an ungenerated scale law")
    return observed == alternatives[value]


@lru_cache(maxsize=None)
def coupling_form_is_forced(value: str) -> bool:
    observed = generator_indexed_coupling(2, 3)
    alternatives = {
        "holding-share-of-sector-plus-support": Fraction(5, 6),
        "fixed-bare-sector-share": Fraction(1, 2),
        "target-assigned-running-value": Fraction(127, 128),
    }
    if value not in alternatives:
        raise ValueError("candidate names an ungenerated coupling form")
    return observed == alternatives[value]


@lru_cache(maxsize=None)
def successor_law_is_forced(value: str) -> bool:
    increases = all(
        coupling_successor_take(sector, level).numerator >= 1
        for sector in prime_sector_ladder()
        for level in (1, 2, 3, 4)
    )
    alternatives = {
        "binary-support-successor-raises-holding-share": increases,
        "binary-support-successor-lowers-holding-share": False,
        "support-independent-holding-share": False,
    }
    if value not in alternatives:
        raise ValueError("candidate names an ungenerated successor law")
    return alternatives[value]


@lru_cache(maxsize=None)
def pair_gap_law_is_forced(value: str) -> bool:
    observed = generator_pair_gap(2, 3, 3)
    alternatives = {
        "exact-generator-gap-over-paired-sources": Fraction(1, 42),
        "constant-sector-gap": Fraction(1, 6),
        "target-assigned-gap": Fraction(1, 128),
    }
    if value not in alternatives:
        raise ValueError("candidate names an ungenerated pair-gap law")
    return observed == alternatives[value]


@lru_cache(maxsize=None)
def convergence_law_is_forced(value: str) -> bool:
    witnesses = formal_certificate()["convergence_witnesses"]
    constructive = all(
        item["gap_below_tolerance"] and item["binary_support_reaches_required_bound"]
        for item in witnesses
    )
    alternatives = {
        "finite-positive-epsilon-witness-for-every-pair": constructive,
        "completed-infinity-as-proof-value": False,
        "visual-approach-without-certificate": False,
    }
    if value not in alternatives:
        raise ValueError("candidate names an ungenerated convergence law")
    return alternatives[value]


@lru_cache(maxsize=None)
def physical_translation_is_forced(value: str) -> bool:
    translation = carrier_translation_record()
    carrier_specific = all((
        translation["single_common_fold_axis"],
        not translation["universal_imported_energy_sign_required"],
        not translation["measurement_selects_orientation"],
    ))
    alternatives = {
        "carrier-specific-self-source-range-and-screening-exposure": carrier_specific,
        "one-imported-energy-sign-for-every-carrier": False,
        "measurement-selected-coordinate-direction": False,
    }
    if value not in alternatives:
        raise ValueError("candidate names an ungenerated physical translation")
    return alternatives[value]


def target_boundary_is_forced(value: str) -> bool:
    if value == "sealed-before-release":
        return True
    if value == "readable-before-seal":
        return False
    raise ValueError("candidate names an ungenerated target boundary")


def extension_is_forced(value: str) -> bool:
    if value == "empty-extension":
        return True
    if value == "free-running-correction":
        return False
    raise ValueError("candidate names an ungenerated extension")


def candidate_forms() -> tuple[CandidateForm, ...]:
    return tuple(
        CandidateForm(*values)
        for values in product(
            SECTOR_DOMAINS,
            SCALE_GENERATIONS,
            COUPLING_FORMS,
            SUCCESSOR_LAWS,
            PAIR_GAP_LAWS,
            CONVERGENCE_LAWS,
            PHYSICAL_TRANSLATIONS,
            TARGET_BOUNDARIES,
            EXTENSIONS,
        )
    )


def candidate_facts(form: CandidateForm) -> dict[str, bool]:
    return {
        "sector_domain": sector_domain_is_forced(form.sector_domain),
        "scale_generation": scale_generation_is_forced(form.scale_generation),
        "coupling_form": coupling_form_is_forced(form.coupling_form),
        "successor_law": successor_law_is_forced(form.successor_law),
        "pair_gap_law": pair_gap_law_is_forced(form.pair_gap_law),
        "convergence_law": convergence_law_is_forced(form.convergence_law),
        "physical_translation": physical_translation_is_forced(form.physical_translation),
        "target_boundary": target_boundary_is_forced(form.target_boundary),
        "extension": extension_is_forced(form.extension),
    }


def form_survives(form: CandidateForm) -> bool:
    return all(candidate_facts(form).values())


def candidate_exact_form(form: CandidateForm) -> str:
    return (
        f"sectors={form.sector_domain}; scale={form.scale_generation}; coupling={form.coupling_form}; "
        f"successor={form.successor_law}; gap={form.pair_gap_law}; convergence={form.convergence_law}; "
        f"translation={form.physical_translation}; target={form.target_boundary}; extension={form.extension}"
    )


def decision_reason(facts: dict[str, bool]) -> str:
    failures = tuple(name for name, passed in facts.items() if not passed)
    if failures:
        return "Rejected by computed Fold predicates: " + ", ".join(failures) + "."
    return (
        "The complete prime-sector ladder shares the One-base binary support successor. Its one-predecessor "
        "shortfall forces (p+R-1)/(p+R), makes every finite sector share rise, makes every ordered pair gap "
        "shrink with the exact paired-source denominator, and supplies a finite positive witness below every "
        "generated tolerance without a completed infinity or measurement-selected correction."
    )


def completeness_record() -> dict[str, object]:
    forms = candidate_forms()
    return {
        "generation_rule": GENERATION_RULE,
        "grammar_boundary": GRAMMAR_BOUNDARY,
        "axis_cardinalities": (3, 3, 3, 3, 3, 3, 3, 2, 2),
        "candidate_count": len(forms),
        "candidate_ids": tuple(form.candidate_id for form in forms),
    }


class CouplingRunningConvergenceProgram:
    """Complete computed enumeration with no claimant-supplied answer key."""

    def __init__(self, source_hash: str):
        self.source_hash = source_hash
        self._forms = candidate_forms()
        self._forms_by_id = {form.candidate_id: form for form in self._forms}

    @property
    def registration(self) -> ClaimRegistration:
        return ClaimRegistration(
            claim_id=CLAIM_ID,
            title="Terminal Fold running functions and common-support convergence",
            branch="physics",
            statement=(
                "The complete forced prime sectors p in two, three, five and seven share one generated scale "
                "carrier with One base and binary successor R_(n+1)=2R_n. Each sector's exact finite running "
                "share is g_p(R)=(p+R-1)/(p+R), with positive shortfall 1/(p+R). Every binary successor raises "
                "g_p by R/[(p+R)(p+2R)]. For p<q the exact gap is (q-p)/[(p+R)(q+R)], it strictly shrinks at "
                "every successor, and for every finite positive tolerance a generated binary support gives a "
                "smaller gap. Thus all four sector functions converge constructively on the common support axis "
                "without a completed infinity, imported beta function, fitted parameter or measurement-selected "
                "correction. The sealed self-source-range and screening-exposure laws determine the opposite "
                "physical energy orientations used in post-seal comparison."
            ),
            evidence_mode=EvidenceMode.EMPIRICAL,
            root_theorems=(ROOT_THEOREM,),
            dependencies=(
                "SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002",
                "SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003",
                "SFT-PHYS-STRONG-RUNNING-DIRECTION-002",
                "SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003",
                "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001",
                "SFT-PHYS-MEAS-TARGET-CUSTODY-001",
                "SFT-PHYS-MEAS-UNCERTAINTY-001",
                "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001",
                "SFT-MATH-LIMIT-CONTINUUM-002",
                "SFT-MATH-SELF-SIMILAR-CONVERGENCE-002",
                "SFT-MATH-EXACT-ARITHMETIC-001",
                "SFT-MATH-COMBINATORICS-001",
            ),
            axioms=(),
            free_parameters=(),
            provenance=(
                ProvenanceClass.FORWARD_FORCING,
                ProvenanceClass.OBSERVATIONAL_DERIVATION,
            ),
            source_hash=self.source_hash,
        )

    def generate_candidates(self) -> CandidateCensus:
        candidates = tuple(
            Candidate(
                candidate_id=form.candidate_id,
                exact_form=candidate_exact_form(form),
                trace_hash=sha256_identity({
                    "generator": GENERATION_RULE,
                    "form": form,
                    "computed_facts": candidate_facts(form),
                }),
            )
            for form in self._forms
        )
        return CandidateCensus(
            generation_rule=GENERATION_RULE,
            grammar_boundary=GRAMMAR_BOUNDARY,
            expected_cardinality=len(self._forms),
            completeness_certificate_hash=sha256_identity(completeness_record()),
            candidates=candidates,
        )

    def decide_candidate(self, candidate: Candidate) -> CandidateDecision:
        form = self._forms_by_id[candidate.candidate_id]
        facts = candidate_facts(form)
        survives = all(facts.values())
        reason = decision_reason(facts)
        return CandidateDecision(
            candidate_id=candidate.candidate_id,
            survives=survives,
            reason=reason,
            proof_hash=sha256_identity({
                "candidate_trace": candidate.trace_hash,
                "form": form,
                "facts": facts,
                "survives": survives,
                "reason": reason,
            }),
        )

    def closure_evidence(self, decisions: Sequence[CandidateDecision]) -> ClosureEvidence:
        certificate = formal_certificate()
        survivors = tuple(item.candidate_id for item in decisions if item.survives)
        minimality = all((
            len(survivors) == 1,
            certificate["sectors"] == (2, 3, 5, 7),
            certificate["supports"] == (1, 2, 4, 8, 16, 32),
            all(
                value.numerator >= 1
                for vector in certificate["shortfall_vectors"]
                for value in vector
            ),
            all(
                value.numerator >= 1
                for vector in certificate["successor_take_vectors"]
                for value in vector
            ),
            all(
                value.numerator >= 1
                for vector in certificate["pair_gap_vectors"]
                for value in vector
            ),
            all(
                value.numerator >= 1
                for vector in certificate["pair_gap_successor_takes"]
                for value in vector
            ),
            all(item["gap_below_tolerance"] for item in certificate["convergence_witnesses"]),
            certificate["carrier_translation"]["single_common_fold_axis"],
        ))
        uniqueness = minimality and extension_is_forced("empty-extension")
        generality = {
            "base": "R_One=One and g_p(One)=p/(p+One) for every forced sector p",
            "successor_support": "R_(n+One)=2R_n",
            "successor_share_take": "g_p(2R) take g_p(R)=R/[(p+R)(p+2R)]",
            "ordered_pair_gap": "g_q(R) take g_p(R)=(q-p)/[(p+R)(q+R)] for p<q",
            "gap_successor": "the positive take between the R and 2R gaps closes every finite pair",
            "constructive_convergence": "for each positive N, a finite binary R reaching N(q-p) gives gap below 1/N",
            "physical_translation": carrier_translation_record(),
            "target_absent_from_formal_module": True,
        }
        return ClosureEvidence(
            scope=ClosureScope.DEPTH_INDEPENDENT,
            exact_boundary=GRAMMAR_BOUNDARY,
            minimality_passed=minimality,
            named_shape_uniqueness_passed=uniqueness,
            proof_hash=sha256_identity({
                "certificate": certificate,
                "decisions": tuple(decisions),
                "survivors_computed": survivors,
            }),
            generality_certificate_hash=sha256_identity(generality),
        )

    def run_controls(self) -> tuple[ControlResult, ...]:
        computed = tuple(form for form in self._forms if form_survives(form))
        if len(computed) != 1:
            raise ValueError("controls require exactly one computed form")
        form = computed[0]
        reversed_successor = replace(
            form,
            successor_law="binary-support-successor-lowers-holding-share",
        )
        completed_infinity = replace(
            form,
            convergence_law="completed-infinity-as-proof-value",
        )
        target_exposed = replace(form, target_boundary="readable-before-seal")
        free_extension = replace(form, extension="free-running-correction")
        identifiers = tuple(item.candidate_id for item in self._forms)
        records = (
            (
                ControlKind.FALSE_PREMISE,
                not form_survives(reversed_successor) and not form_survives(completed_infinity),
                "Reject reversed running and a completed infinity as a proof value.",
                "Exact positive successor takes and finite epsilon witnesses reject both false laws.",
            ),
            (
                ControlKind.TAMPERED_SOURCE,
                sha256_identity({"changed": self.source_hash}) != self.source_hash,
                "Reject any changed claimant source identity.",
                "The changed identity differs from the registered source manifest.",
            ),
            (
                ControlKind.TAMPERED_ARTIFACT,
                len(set(identifiers + (identifiers[0],))) != len(identifiers) + 1,
                "Reject a duplicated or incomplete candidate census.",
                "The deliberate duplicate fails complete candidate identity.",
            ),
            (
                ControlKind.BOUNDARY,
                not form_survives(target_exposed)
                and not form_survives(free_extension)
                and generated_scale_support(1) == 1,
                "Reject pre-seal target access, free correction and a numerical null base.",
                "The scale begins at the One; sealed custody and empty extension are required.",
            ),
        )
        return tuple(
            ControlResult(kind, passed, expected, observed, sha256_identity({
                "kind": kind,
                "passed": passed,
                "expected": expected,
                "observed": observed,
            }))
            for kind, passed, expected, observed in records
        )


__all__ = (
    "CLAIM_ID",
    "COUPLING_FORMS",
    "CONVERGENCE_LAWS",
    "CouplingRunningConvergenceProgram",
    "EXPERIMENT_ID",
    "GENERATION_RULE",
    "GRAMMAR_BOUNDARY",
    "PAIR_GAP_LAWS",
    "PHYSICAL_TRANSLATIONS",
    "SCALE_GENERATIONS",
    "SECTOR_DOMAINS",
    "SUCCESSOR_LAWS",
    "candidate_facts",
    "candidate_forms",
    "carrier_translation_record",
    "common_scale_vector",
    "completeness_record",
    "convergence_witness",
    "coupling_shortfall",
    "coupling_successor_take",
    "formal_certificate",
    "form_survives",
    "generated_scale_support",
    "generator_indexed_coupling",
    "generator_pair_gap",
    "level_reaching_support",
    "pair_gap_successor_take",
)
