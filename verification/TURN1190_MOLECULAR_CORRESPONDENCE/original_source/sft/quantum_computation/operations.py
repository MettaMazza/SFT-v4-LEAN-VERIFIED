"""Exact Fold-native operational kernels for reversible and quantum computation.

No complex amplitude, irrational normalization, imaginary value or stochastic
collapse is used.  A state is complete generated branch support with held phase
labels.  Joint support, phase actions, predecessor merging, reversible maps and
observation records are exact finite structures.
"""

from __future__ import annotations

from dataclasses import dataclass
from itertools import combinations, product


Word = tuple[str, ...]


@dataclass(frozen=True)
class FoldQuantumState:
    branches: tuple[tuple[Word, str], ...]
    phase_cycle: tuple[str, ...]

    def __post_init__(self) -> None:
        if not self.branches or len(set(self.phase_cycle)) != len(self.phase_cycle) or len(self.phase_cycle) < 2:
            raise ValueError("state requires nonempty support and a nontrivial exact phase cycle")
        words = tuple(word for word, _phase in self.branches)
        if len(set(words)) != len(words):
            raise ValueError("a branch word occurs twice")
        if any(phase not in self.phase_cycle for _word, phase in self.branches):
            raise ValueError("branch phase is outside the registered cycle")

    @property
    def support(self) -> tuple[Word, ...]:
        return tuple(word for word, _phase in self.branches)


def complete_support(alphabet: tuple[str, ...], positions: tuple[str, ...], phase_cycle: tuple[str, ...]) -> FoldQuantumState:
    if not alphabet or not positions or len(set(alphabet)) != len(alphabet) or len(set(positions)) != len(positions):
        raise ValueError("support requires unique generated alphabet and positions")
    words = tuple(product(alphabet, repeat=len(positions)))
    return FoldQuantumState(tuple((tuple(word), phase_cycle[0]) for word in words), phase_cycle)


def compose(left: FoldQuantumState, right: FoldQuantumState) -> FoldQuantumState:
    if left.phase_cycle != right.phase_cycle:
        raise ValueError("joint states require one exact phase cycle")
    cycle = left.phase_cycle
    index = {phase: position for position, phase in enumerate(cycle)}
    branches = []
    for left_word, left_phase in left.branches:
        for right_word, right_phase in right.branches:
            phase = cycle[(index[left_phase] + index[right_phase]) % len(cycle)]
            branches.append((left_word + ("joint",) + right_word, phase))
    return FoldQuantumState(tuple(branches), cycle)


def phase_action(state: FoldQuantumState, successor_steps: tuple[str, ...]) -> FoldQuantumState:
    if not successor_steps:
        raise ValueError("phase action requires a generated nonempty successor trace")
    cycle = state.phase_cycle
    index = {phase: position for position, phase in enumerate(cycle)}
    shift = len(successor_steps) % len(cycle)
    return FoldQuantumState(
        tuple((word, cycle[(index[phase] + shift) % len(cycle)]) for word, phase in state.branches),
        cycle,
    )


def predecessor_merge(state: FoldQuantumState, image_rows: tuple[tuple[Word, str], ...]) -> tuple[tuple[str, tuple[tuple[Word, str], ...]], ...]:
    mapping = {word: target for word, target in image_rows}
    if len(mapping) != len(image_rows) or set(mapping) != set(state.support):
        raise ValueError("interference image must classify every branch exactly once")
    fibres: dict[str, list[tuple[Word, str]]] = {}
    for word, phase in state.branches:
        fibres.setdefault(mapping[word], []).append((word, phase))
    return tuple(sorted((target, tuple(predecessors)) for target, predecessors in fibres.items()))


def is_factorable(joint_support: tuple[tuple[str, str], ...]) -> bool:
    if not joint_support or len(set(joint_support)) != len(joint_support):
        raise ValueError("joint support must be nonempty and unique")
    left = {a for a, _b in joint_support}
    right = {b for _a, b in joint_support}
    return set(joint_support) == set(product(left, right))


def observe(state: FoldQuantumState, observation: tuple[tuple[Word, str], ...], retained_label: str) -> tuple[FoldQuantumState, tuple[tuple[Word, str, str], ...]]:
    mapping = {word: label for word, label in observation}
    if len(mapping) != len(observation) or set(mapping) != set(state.support):
        raise ValueError("measurement must classify complete state support")
    retained = tuple((word, phase) for word, phase in state.branches if mapping[word] == retained_label)
    if not retained:
        raise ValueError("selected observation class has no generated branch")
    record = tuple((word, phase, mapping[word]) for word, phase in state.branches)
    return FoldQuantumState(retained, state.phase_cycle), record


@dataclass(frozen=True)
class ReversibleGate:
    word_map: tuple[tuple[Word, Word], ...]
    phase_successors: tuple[str, ...]

    def __post_init__(self) -> None:
        sources = tuple(source for source, _target in self.word_map)
        targets = tuple(target for _source, target in self.word_map)
        if not sources or len(set(sources)) != len(sources) or len(set(targets)) != len(targets):
            raise ValueError("gate word map must be a finite bijection")
        if not self.phase_successors:
            raise ValueError("gate phase action requires a generated successor trace")

    def inverse(self) -> "ReversibleGate":
        return ReversibleGate(tuple((target, source) for source, target in self.word_map), self.phase_successors)


def apply_gate(state: FoldQuantumState, gate: ReversibleGate, inverse_phase: bool = False) -> FoldQuantumState:
    mapping = dict(gate.word_map)
    if set(mapping) != set(state.support):
        raise ValueError("gate domain must equal complete state support")
    cycle = state.phase_cycle
    index = {phase: position for position, phase in enumerate(cycle)}
    shift = len(gate.phase_successors) % len(cycle)
    if inverse_phase and shift:
        shift = len(cycle) - shift
    return FoldQuantumState(
        tuple((mapping[word], cycle[(index[phase] + shift) % len(cycle)]) for word, phase in state.branches),
        cycle,
    )


def repetition_encode(label: str, fault_depth_trace: tuple[str, ...]) -> tuple[str, ...]:
    if label not in {"held", "returned"} or not fault_depth_trace or len(set(fault_depth_trace)) != len(fault_depth_trace):
        raise ValueError("code requires a held label and nonempty generated fault-depth trace")
    width = 2 * len(fault_depth_trace) + 1
    return tuple(label for _ in range(width))


def repetition_decode(word: tuple[str, ...]) -> str:
    if not word or any(label not in {"held", "returned"} for label in word):
        raise ValueError("codeword contains an external label")
    held = sum(label == "held" for label in word)
    returned = sum(label == "returned" for label in word)
    if held == returned:
        raise ValueError("decoder requires an odd generated width")
    return "held" if held > returned else "returned"


def exhaustive_fault_census(label: str, fault_depth_trace: tuple[str, ...]) -> tuple[tuple[tuple[str, ...], str], ...]:
    encoded = repetition_encode(label, fault_depth_trace)
    opposite = "returned" if label == "held" else "held"
    rows = []
    for fault_count in range(len(fault_depth_trace) + 1):
        for positions in combinations(range(len(encoded)), fault_count):
            changed = tuple(opposite if index in positions else value for index, value in enumerate(encoded))
            rows.append((changed, repetition_decode(changed)))
    return tuple(rows)


def operational_witnesses(claim_id: str) -> tuple[tuple[str, str, bool], ...]:
    cycle = ("phase-held", "phase-returned")
    state = complete_support(("held", "returned"), ("position-1",), cycle)
    phased = phase_action(state, ("phase-step",))
    joint = compose(state, state)
    merged = predecessor_merge(state, ((("held",), "image"), (("returned",), "image")))
    measured, record = observe(state, ((("held",), "left"), (("returned",), "right")), "left")
    gate = ReversibleGate(((("held",), ("returned",)), (("returned",), ("held",))), ("phase-step",))
    transformed = apply_gate(state, gate)
    restored = apply_gate(transformed, gate.inverse(), inverse_phase=True)
    faults_pass = all(
        all(decoded == "held" for _word, decoded in exhaustive_fault_census("held", tuple(f"fault-{i + 1}" for i in range(depth))))
        for depth in (1, 2, 3)
    )
    checks = (
        state.support == (("held",), ("returned",)),
        phased.branches[0][1] == "phase-returned",
        len(joint.branches) == 4,
        len(merged[0][1]) == 2,
        not is_factorable((("held", "held"), ("returned", "returned"))),
        measured.support == (("held",),) and len(record) == 2,
        restored == state,
        faults_pass,
    )
    return tuple(
        (f"quantum-witness-{index}", f"exact Fold quantum operational witness {index} for {claim_id}", passed)
        for index, passed in enumerate(checks, 1)
    )

