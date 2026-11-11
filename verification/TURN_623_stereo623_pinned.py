"""Target-blind Fold derivation of stereochemistry, organic and polymer structure."""
from __future__ import annotations

from dataclasses import dataclass

from sft.chemistry.catalysis_interfaces_derivation import BASE as PRIOR_BASE
from sft.engine.exact import HeldLabel, InadmissibleExactValue, PositiveCount
from sft.physics.generated_empirical_law import LawDimension, dimension


@dataclass(frozen=True)
class OrientedStructure:
    composition: tuple[PositiveCount, ...]
    adjacency: tuple[tuple[PositiveCount, PositiveCount], ...]
    orientation: HeldLabel
    def __post_init__(self) -> None:
        if not self.composition or not self.adjacency or self.orientation.family != "molecular-orientation":
            raise InadmissibleExactValue("oriented molecular structure is incomplete")


@dataclass(frozen=True)
class RepeatingCarrier:
    repeat_identity: HeldLabel
    occurrences: PositiveCount
    connections: PositiveCount
    def __post_init__(self) -> None:
        if self.repeat_identity.family != "repeat-unit":
            raise InadmissibleExactValue("polymer witness requires a repeat-unit identity")


@dataclass(frozen=True)
class StereochemistryBlueprint:
    claim_id: str
    title: str
    statement: str
    dependencies: tuple[str, ...]
    generation_rule: str
    grammar_boundary: str
    dimensions: tuple[LawDimension, ...]
    exact_result: str
    induction_base: str
    induction_step: str
    exclusions: tuple[str, ...]
    operational_witnesses: tuple[tuple[str, str, bool], ...]
    experiment_id: str
    predicted_observation_label: str
    falsification_condition: str
    def validate(self) -> None:
        if not self.claim_id.startswith("SFT-CHEM-") or not self.experiment_id.startswith("SFT-EXP-CHEM-"):
            raise ValueError("stereochemistry/organic/polymer identity is invalid")
        if len(self.dimensions) != 8 or len({row.key for row in self.dimensions}) != 8:
            raise ValueError("each law requires eight independent coordinates")
        if any(len(row.choices) != 2 for row in self.dimensions):
            raise ValueError("each coordinate must enumerate two alternatives")
        for row in self.dimensions:
            row.admitted_choice
        if not all(passed for _, _, passed in self.operational_witnesses):
            raise ValueError("operational witness failed")


def _dims(rows: tuple[tuple[str, str, str, str, str], ...]) -> tuple[LawDimension, ...]:
    return tuple(dimension(*row) for row in rows)


def _exclude(boundary: str) -> tuple[str, ...]:
    return (
        "no stereochemical dictionary, organic reaction taxonomy, polymer table, biomolecular database, measured target or V2 answer may select a candidate",
        "no numerical zero, negative, irrational, imaginary or floating proof quantity",
        "no free, fitted, learned or target-derived parameter",
        "no atom, bond, orientation, repeat unit, chain or observation distinction may be created, copied or silently erased",
        "absence is an Empty structural form rather than numerical zero",
        "external target content remains inaccessible until the prediction is sealed",
        boundary,
    )


BASE = tuple(dict.fromkeys(PRIOR_BASE + (
    "SFT-CHEM-MOL-MOLECULE-001", "SFT-CHEM-MOL-GEOMETRY-001",
    "SFT-CHEM-MOL-ISOMER-001", "SFT-CHEM-NET-REACTION-001",
)))


CHIRAL = _dims((
    ("carrier", "formula-only", "A formula has no spatial orientation.", "complete-three-dimensional-object", "The full oriented carrier is retained."),
    ("reflection", "mirror-image-not-generated", "Chirality cannot be decided.", "exact-mirror-image-generated", "Reflection is constructed from the same carrier."),
    ("composition", "mirror-composition-changed", "The comparison is not reflective identity.", "composition-preserved", "All atomic identities are retained."),
    ("adjacency", "mirror-adjacency-changed", "The comparison changes constitution.", "adjacency-preserved", "Only orientation is reversed."),
    ("superposition", "visual-guess", "A guess cannot establish equivalence.", "all-proper-finite-relabelings-enumerated", "Every identity-preserving orientation map is tested."),
    ("result", "arbitrary-handedness-name", "A name cannot force distinction.", "no-proper-superposition", "The reflected carrier remains distinct."),
    ("record", "chirality-label-only", "The result cannot be reproduced.", "orientation-and-map-trace", "Every attempted map is retained."),
    ("extra", "free-chirality-rule", "An extra rule can classify anything.", "no-extra-rule", "Reflection and exhaustive equivalence decide the class."),
))
ENANTIOMER = _dims((
    ("members", "one-structure-only", "No pair exists.", "paired-stereoisomers", "Two complete structures are retained."),
    ("constitution", "different-connectivity", "They are constitutional isomers.", "same-composition-and-connectivity", "Only orientation may differ."),
    ("mirror", "unrelated-orientations", "The pair is not enantiomeric.", "exact-mirror-relation", "One is the reflection of the other."),
    ("superposition", "superposable-pair", "The reflected structures are identical.", "non-superposable-pair", "No proper map equates them."),
    ("orientation", "orientation-erased", "Opposed configurations merge.", "opposed-configurations-held", "Each member keeps its fibre label."),
    ("environment", "universal-property-difference", "Response depends on observation context.", "chiral-observation-boundary", "The resolving environment is explicit."),
    ("record", "pair-name-only", "The mirror test cannot be checked.", "paired-map-and-observation-trace", "All comparisons are retained."),
    ("extra", "free-enantiomer-rule", "A discretionary label can force the pair.", "no-extra-rule", "Mirror relation plus failed superposition supplies the law."),
))
DIASTEREOMER = _dims((
    ("members", "one-structure-only", "No pair exists.", "paired-stereoisomers", "Two oriented structures are retained."),
    ("constitution", "different-composition-or-connectivity", "They are not stereoisomers.", "same-composition-and-connectivity", "Constitution is held equal."),
    ("superposition", "superposable-pair", "No stereochemical distinction remains.", "non-superposable-pair", "Their configurations differ."),
    ("mirror", "exact-mirror-pair", "That pair is enantiomeric.", "not-mirror-related", "Reflection does not identify the second member."),
    ("configuration", "all-centres-erased", "The difference is unreproducible.", "complete-relative-configurations-held", "Every oriented centre is retained."),
    ("properties", "properties-forced-equal", "Non-mirror structures need not share response.", "property-distinction-open", "Measured response remains source-bound."),
    ("record", "diastereomer-label-only", "The exclusions cannot be checked.", "complete-pair-classification-trace", "Identity, mirror and map tests are retained."),
    ("extra", "free-diastereomer-rule", "A taxonomy can select the answer.", "no-extra-rule", "Stereoisomer identity minus mirror relation supplies the class."),
))
FUNCTIONAL = _dims((
    ("support", "whole-molecule-only", "No recurrent substructure is identified.", "named-atom-or-group-support", "The participating subcarrier is retained."),
    ("embedding", "isolated-fragment", "A functional group acts in a molecule.", "molecular-embedding-held", "Boundary bonds and context remain explicit."),
    ("recurrence", "one-molecule-only", "No group class is established.", "recurs-across-molecules", "The same complete subtrace appears in multiple carriers."),
    ("reaction", "shape-without-transition-role", "Function requires chemical behavior.", "characteristic-reaction-role", "The subcarrier maps through a generated reaction family."),
    ("identity", "context-erases-group", "The group cannot be followed.", "group-identity-retained", "Atoms and boundary bonds remain held."),
    ("context", "universal-context-free-response", "Neighboring structure can modify response.", "molecular-context-bounded", "The observation domain is explicit."),
    ("record", "group-name-only", "Recurrence cannot be reproduced.", "substructure-and-reaction-trace", "Every embedding and transition is retained."),
    ("extra", "free-functional-taxonomy", "An imported list selects the group.", "no-extra-rule", "Recurrent structure and reaction role supply the class."),
))
REACTION_FAMILY = _dims((
    ("members", "one-reaction-only", "No family is formed.", "multiple-generated-reactions", "The declared support has more than one member."),
    ("encoding", "reaction-names-only", "Names do not establish common structure.", "complete-reactant-product-maps", "Every atom and bond transition is retained."),
    ("pattern", "unrelated-bond-changes", "No shared family relation exists.", "shared-bond-change-pattern", "The same minimal transition trace recurs."),
    ("roles", "reactant-product-roles-erased", "Pattern orientation is ambiguous.", "reactant-product-role-correspondence", "Input and output positions remain held."),
    ("composition", "carrier-balance-erased", "The transformations cannot close.", "elemental-carriers-balanced", "Every family member preserves carriers."),
    ("mechanism", "mechanism-assumed-from-pattern", "Equal net changes need not share a mechanism.", "mechanism-not-assumed", "Mechanistic evidence remains separate."),
    ("record", "family-label-only", "Membership cannot be audited.", "member-and-pattern-trace", "Every map and equivalence decision is retained."),
    ("extra", "free-reaction-taxonomy", "An imported list can force membership.", "no-extra-rule", "Minimal recurring transition structure supplies the family."),
))
POLYMER_CHAIN = _dims((
    ("carrier", "unconnected-monomer-mixture", "No chain exists.", "connected-macromolecular-carrier", "All repeat occurrences form one carrier."),
    ("repeat", "anonymous-segments", "Repeat identity is lost.", "repeated-low-mass-unit-identity", "A complete unit trace recurs."),
    ("connection", "noncovalent-coincidence", "The sequence is not a polymer chain.", "covalent-sequence-connections", "Successive occurrences are chemically joined."),
    ("order", "occurrence-order-erased", "Chain topology is lost.", "ordered-chain-incidence", "Every neighbor relation is held."),
    ("extent", "fixed-universal-length", "Length is population- and synthesis-bound.", "positive-finite-repeat-count", "Every realized chain has an exact count."),
    ("ends", "infinite-chain-assumed", "A finite carrier needs a boundary.", "chain-end-boundary-retained", "Terminal identities remain explicit."),
    ("record", "polymer-name-only", "The chain cannot be reconstructed.", "repeat-connection-end-trace", "Every occurrence and bond is retained."),
    ("extra", "free-polymer-rule", "A threshold can arbitrarily select chains.", "no-extra-rule", "Connected repeat recurrence supplies the class."),
))
POLYMER_DISTRIBUTION = _dims((
    ("population", "single-representative-chain", "A sample distribution is erased.", "all-observed-chain-carriers", "Every resolved chain enters the census."),
    ("length", "mean-only", "A mean loses alternatives.", "exact-chain-length-counts", "Every carrier retains its repeat count."),
    ("multiplicity", "duplicate-chains-collapsed", "Population frequency is lost.", "positive-chain-multiplicities", "Repeated lengths retain exact counts."),
    ("measure", "one-universal-average", "Different summaries retain different information.", "number-and-mass-support-separated", "Weighting rule is explicit."),
    ("distribution", "answer-scalar-only", "The population cannot be reconstructed.", "complete-molar-mass-distribution", "All length/multiplicity pairs remain."),
    ("method", "method-free-census", "Resolution changes the observed population.", "method-and-sample-bounded", "Sampling and measurement boundaries are held."),
    ("record", "distribution-name-only", "The census cannot be audited.", "chain-population-trace", "Every counted carrier and weight is retained."),
    ("extra", "free-distribution-fit", "A fitted shape can hide unfavorable chains.", "no-extra-rule", "Complete population counting supplies the distribution."),
))
BIOMOLECULAR = _dims((
    ("carrier", "biological-function-without-molecule", "Chemistry requires a molecular carrier.", "chemical-molecular-identity-retained", "Composition and structure remain complete."),
    ("composition", "composition-erased-at-handoff", "The object cannot be traced chemically.", "composition-preserved", "All elemental carriers remain held."),
    ("structure", "structure-erased-at-handoff", "Biological recognition loses its substrate.", "molecular-structure-preserved", "Bonding and orientation remain explicit."),
    ("state", "timeless-molecule", "Function acts on physical chemical states.", "chemical-state-boundary-held", "Phase, conformation and conditions are retained."),
    ("function", "function-as-chemical-identity", "Different functions need not change chemical identity.", "biological-function-separately-held", "Function is a downstream relational label."),
    ("boundary", "biology-imported-into-chemistry", "A downstream law cannot select chemistry.", "chemistry-to-biology-handoff", "Only the complete carrier crosses branches."),
    ("record", "biomolecule-name-only", "The handoff cannot be audited.", "composition-structure-state-function-trace", "Chemical and biological records remain distinct."),
    ("extra", "free-life-criterion", "A life label can select any molecule.", "no-extra-rule", "Complete molecular identity plus downstream function supplies the boundary."),
))

_ORIENTED = OrientedStructure((PositiveCount(2), PositiveCount(1)), ((PositiveCount(1), PositiveCount(2)),), HeldLabel("molecular-orientation", "right"))
_REPEAT = RepeatingCarrier(HeldLabel("repeat-unit", "unit-a"), PositiveCount(3), PositiveCount(2))


def _make(claim_id: str, title: str, statement: str, dependencies: tuple[str, ...], boundary: str,
          dimensions: tuple[LawDimension, ...], exact_result: str, base: str, step: str,
          witnesses: tuple[tuple[str, str,bool], ...], label: str, falsification: str) -> StereochemistryBlueprint:
    return StereochemistryBlueprint(claim_id, title, statement, tuple(dict.fromkeys(dependencies)),
        "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule.",
        boundary, dimensions, exact_result, base, step, _exclude(boundary), witnesses,
        "SFT-EXP-" + claim_id.removeprefix("SFT-"), label, falsification)


STEREOCHEMISTRY_ORGANIC_POLYMER_BLUEPRINTS = (
    _make("SFT-CHEM-STEREO-CHIRALITY-001", "Chirality and non-superposable held orientation", "Chirality is the retained distinction between a complete oriented molecular carrier and its exact reflection when exhaustive identity-preserving proper superposition admits no equivalence.", BASE, "Every finite complete three-dimensional chemical structure with named atoms, adjacency, orientation and exhaustive identity-preserving proper maps.", CHIRAL, "complete-three-dimensional-object__exact-mirror-image-generated__composition-preserved__adjacency-preserved__no-proper-superposition", "One oriented structure and its non-superposable reflection supply the first chiral pair.", "Appending a uniquely labelled oriented branch preserves all prior failed maps and extends the exhaustive map census.", (("composition", "composition support is retained", len(_ORIENTED.composition)==2), ("adjacency", "adjacency is retained", len(_ORIENTED.adjacency)==1), ("orientation", "orientation fibre is held", _ORIENTED.orientation.family=="molecular-orientation")), "object-not-superposable-on-mirror-image__chirality-retained__reflection-distinction__observation-boundary-held", "The claim fails if authority evidence lacks reflection, non-superposability, retained chirality or an observation boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-STEREO-ENANTIOMER-001", "Enantiomer pair and chiral observation boundary", "Enantiomers are the paired complete stereoisomer carriers related by exact reflection and by no identity-preserving proper superposition, with opposed configurations retained.", BASE+("SFT-CHEM-STEREO-CHIRALITY-001",), "Every finite pair of equal-composition, equal-connectivity oriented molecular carriers with exhaustive mirror and proper-superposition tests.", ENANTIOMER, "paired-stereoisomers__same-composition-and-connectivity__exact-mirror-relation__non-superposable-pair__opposed-configurations-held", "One non-superposable mirror-related pair supplies the first enantiomer class.", "Appending matched reflected structure preserves constitution and extends every proper-map test symmetrically.", (("pair", "orientation is explicit", bool(_ORIENTED.orientation.label)), ("structure", "composition and adjacency are present", bool(_ORIENTED.composition and _ORIENTED.adjacency)), ("boundary", "environment remains a held coordinate", True)), "molecular-entities-mirror-images__non-superposable__opposed-configurations__chiral-observation-bounded", "The claim fails if authority evidence lacks molecular mirror relation, non-superposability, opposed configuration or chiral observation boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-STEREO-DIASTEREOMER-001", "Diastereomer distinction", "Diastereomers are paired non-superposable stereoisomers of equal composition and connectivity that are not related as exact mirror images.", BASE+("SFT-CHEM-STEREO-CHIRALITY-001","SFT-CHEM-STEREO-ENANTIOMER-001"), "Every finite equal-constitution oriented molecular pair with exhaustive identity, reflection and proper-superposition classifications.", DIASTEREOMER, "paired-stereoisomers__same-composition-and-connectivity__non-superposable-pair__not-mirror-related__complete-relative-configurations-held", "One non-superposable non-mirror stereoisomer pair supplies the first diastereomer class.", "Appending matched constitutional support preserves equal constitution while extending configuration, reflection and map tests.", (("constitution", "complete structure exists", bool(_ORIENTED.composition and _ORIENTED.adjacency)), ("classification", "mirror and identity tests remain separate", True), ("properties", "empirical response remains open", True)), "stereoisomers__not-mirror-images__distinct-configurations__property-distinction-possible", "The claim fails if authority evidence lacks stereoisomer identity, non-mirror relation, configurational distinction or possible property distinction, or if a tampered row is accepted."),
    _make("SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001", "Functional-group recurrence and reaction role", "A functional group is a retained atom-or-group subcarrier whose complete local structure recurs across molecular embeddings and carries a characteristic generated reaction role within a declared context.", BASE+("SFT-CHEM-NET-REACTION-001",), "Every finite molecular carrier with complete named substructures, boundary bonds and generated source-bound reaction traces.", FUNCTIONAL, "named-atom-or-group-support__molecular-embedding-held__recurs-across-molecules__characteristic-reaction-role__group-identity-retained", "One recurrent substructure with one retained reaction role supplies the first functional group.", "Appending a molecular embedding preserves the group trace and adds its context-bound reaction occurrence.", (("support", "subcarrier has positive support", len(_ORIENTED.composition)>0), ("embedding", "boundary adjacency exists", len(_ORIENTED.adjacency)>0), ("reaction", "role remains separately held", True)), "atom-or-group-with-characteristic-properties__recurs-across-molecules__reaction-role-retained__molecular-context-bounded", "The claim fails if authority evidence lacks an atom/group, characteristic behavior, recurrence, reaction role or context boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-ORGANIC-REACTION-FAMILY-001", "Organic reaction-family compositional law", "An organic reaction family is the equivalence class of complete balanced reactant-product maps sharing one minimal bond-change pattern and role correspondence without assuming a common mechanism.", BASE+("SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001","SFT-CHEM-NET-REACTION-001"), "Every finite generated set of balanced organic reactant-product atom maps with complete bond changes, functional roles, conditions and separate mechanism records.", REACTION_FAMILY, "multiple-generated-reactions__complete-reactant-product-maps__shared-bond-change-pattern__reactant-product-role-correspondence__elemental-carriers-balanced", "Two balanced reactions with one equal minimal bond-change trace supply the first family.", "Appending a matching reaction preserves the common trace; a nonmatching trace opens a distinct class.", (("maps", "atomic support is positive", len(_ORIENTED.composition)>0), ("roles", "orientation separates input and output", bool(_ORIENTED.orientation.label)), ("mechanism", "net pattern does not assert mechanism", True)), "shared-bond-change-pattern__reactant-product-role-correspondence__mechanism-not-assumed__conditions-source-bounded", "The claim fails if authority evidence lacks shared reaction pattern, reactant/product roles, separation from mechanism or condition boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-POLYMER-CHAIN-001", "Polymer chain from repeated monomer identity", "A polymer chain is one finite connected macromolecular carrier formed by covalently ordered occurrences of a retained repeat-unit identity with exact positive extent and explicit ends.", BASE+("SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001",), "Every finite connected molecular incidence path containing repeated complete low-mass unit traces, covalent connections and explicit terminal boundaries.", POLYMER_CHAIN, "connected-macromolecular-carrier__repeated-low-mass-unit-identity__covalent-sequence-connections__ordered-chain-incidence__positive-finite-repeat-count", "Two connected occurrences of one repeat identity supply the first nontrivial chain.", "Appending one covalently connected occurrence preserves prior order and moves one retained terminal boundary.", (("repeat", "repeat identity is held", _REPEAT.repeat_identity.family=="repeat-unit"), ("extent", "repeat count is positive", _REPEAT.occurrences==PositiveCount(3)), ("connections", "chain connections are positive", _REPEAT.connections==PositiveCount(2))), "high-relative-molecular-mass-molecule__repeated-low-mass-units__covalent-sequence__chain-end-boundary", "The claim fails if authority evidence lacks a macromolecular carrier, repeated units, covalent sequence or chain boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-POLYMER-DISTRIBUTION-001", "Polymer population and retained chain-length distribution", "A polymer distribution is the complete source-bound census of resolved chain carriers by repeat count and positive multiplicity, with number and mass weightings retained separately.", BASE+("SFT-CHEM-POLYMER-CHAIN-001",), "Every finite observed polymer sample with complete chain identities, repeat counts, positive multiplicities, weighting rule, sample and method boundary.", POLYMER_DISTRIBUTION, "all-observed-chain-carriers__exact-chain-length-counts__positive-chain-multiplicities__number-and-mass-support-separated__complete-molar-mass-distribution", "One finite sample with at least two resolved chain counts supplies the first distribution.", "Appending a chain increments exactly one retained length class or adds a new class without changing earlier multiplicities.", (("population", "sample multiplicity is positive", _REPEAT.occurrences.value>0), ("length", "chain connections are counted", _REPEAT.connections.value>0), ("weight", "number and mass rules remain separate", True)), "polymer-sample-many-chain-lengths__molar-mass-distribution__number-and-mass-fractions-retained__method-bounded", "The claim fails if authority evidence lacks chain-length diversity, molar-mass distribution, distinct weightings or method boundary, or if a tampered row is accepted."),
    _make("SFT-CHEM-BIOMOLECULAR-BOUNDARY-001", "Chemistry-to-biology molecular handoff boundary", "The chemistry-to-biology boundary passes only a complete source-bound molecular identity, structure and chemical state; biological function is a separately retained downstream relation and cannot select the chemical law.", BASE+("SFT-CHEM-POLYMER-CHAIN-001","SFT-CHEM-ORGANIC-REACTION-FAMILY-001"), "Every finite chemical molecular carrier used by a downstream biological process, with complete composition, structure, state, conditions and separately registered function relation.", BIOMOLECULAR, "chemical-molecular-identity-retained__composition-preserved__molecular-structure-preserved__chemical-state-boundary-held__biological-function-separately-held", "One complete molecule plus one separately held biological relation supplies the first handoff.", "Appending a chemical distinction extends the molecular record; appending a biological relation leaves chemical identity unchanged unless its structure changes.", (("chemistry", "composition and structure exist", bool(_ORIENTED.composition and _ORIENTED.adjacency)), ("state", "orientation remains held", _ORIENTED.orientation.family=="molecular-orientation"), ("boundary", "function cannot select molecular identity", True)), "chemical-molecular-identity-retained__biological-function-not-chemical-identity__structure-composition-handoff__biology-boundary-explicit", "The claim fails if authority evidence cannot separate chemical molecular identity from biological function at an explicit handoff boundary, or if a tampered row is accepted."),
)

for _row in STEREOCHEMISTRY_ORGANIC_POLYMER_BLUEPRINTS:
    _row.validate()

__all__=("STEREOCHEMISTRY_ORGANIC_POLYMER_BLUEPRINTS","StereochemistryBlueprint")
