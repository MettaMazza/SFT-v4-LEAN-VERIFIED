"""Exact finite witnesses used by the foundational Biology inventory."""

from __future__ import annotations

from itertools import product


def held_pair_alphabet() -> tuple[tuple[int, int], ...]:
    """Generate the complete two-by-two held-label alphabet."""

    labels = (1, 2)
    return tuple(product(labels, repeat=2))


def codon_words() -> tuple[tuple[tuple[int, int], ...], ...]:
    """Generate every ordered length-three word over the four-label alphabet."""

    alphabet = held_pair_alphabet()
    return tuple(product(alphabet, repeat=3))


def codon_boxes() -> dict[tuple[tuple[int, int], tuple[int, int]], tuple[tuple[tuple[int, int], ...], ...]]:
    """Partition the codon census by its first two positions."""

    boxes: dict[tuple[tuple[int, int], tuple[int, int]], list[tuple[tuple[int, int], ...]]] = {}
    for word in codon_words():
        boxes.setdefault((word[0], word[1]), []).append(word)
    return {key: tuple(value) for key, value in boxes.items()}


def exact_codon_certificate() -> dict[str, object]:
    alphabet = held_pair_alphabet()
    words = codon_words()
    boxes = codon_boxes()
    return {
        "held_distinctions": 2,
        "alphabet_count": len(alphabet),
        "word_length": 3,
        "codon_count": len(words),
        "box_count": len(boxes),
        "box_widths": tuple(sorted({len(value) for value in boxes.values()})),
        "alphabet_complete": len(set(alphabet)) == 4,
        "codon_census_complete": len(set(words)) == 64,
        "partition_complete": sum(len(value) for value in boxes.values()) == len(words),
        "each_word_once": len({word for value in boxes.values() for word in value}) == len(words),
    }


def validate_structural_counts() -> None:
    certificate = exact_codon_certificate()
    if certificate != {
        "held_distinctions": 2,
        "alphabet_count": 4,
        "word_length": 3,
        "codon_count": 64,
        "box_count": 16,
        "box_widths": (4,),
        "alphabet_complete": True,
        "codon_census_complete": True,
        "partition_complete": True,
        "each_word_once": True,
    }:
        raise ValueError("exact Biology codon certificate failed")


validate_structural_counts()

__all__ = ("held_pair_alphabet", "codon_words", "codon_boxes", "exact_codon_certificate", "validate_structural_counts")
