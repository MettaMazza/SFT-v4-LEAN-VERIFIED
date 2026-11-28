"""
ratio.py — the permitted-language core. One axiom (the One); no negatives; no zero;
no imaginaries. Every magnitude is an exact ratio, a part of the One, in (0, 1].

The single place a whole is ever taken away is cast_out, the ancient casting-out-the-One:
it acts only on a magnitude past the whole and so always leaves a strictly positive part.
Zero is never a value; coincidence of two ones is unison (the ratio One), not zero.
No other subtraction, no negative, no imaginary, no sine/cosine is used anywhere.
"""
from fractions import Fraction

ONE = Fraction(1)

def cast_out(m):
    """Casting out the One: while a positive magnitude exceeds one whole, take one whole
       away. Each step acts on m > ONE, so each remainder is strictly positive; the final
       result lies in (0, 1]. This is the only operation that removes, and it is auditable
       here in one place."""
    whole = ONE
    while m > whole:
        m = m.__sub__(whole)       # acts only on m > ONE -> strictly positive remainder
    return m

def part(p, q):
    """A part of the One: p out of q whole parts, brought into (0, 1] by casting out."""
    return cast_out(Fraction(p, q))

def fold(r):
    """Double the part, then cast out the One. r in (0,1] -> 2r in (0,2] -> a part in (0,1].
       The boundary (doubled magnitude exactly one whole) is unison, the One."""
    return cast_out(r + r)

def ratio(a, b):
    """The relation between two ones: the proportion a:b, strictly positive. Unison = ONE."""
    return a / b

def take(big, small):
    """The positive part between two magnitudes, with big > small. The part between
       them is obtained by one guarded removal, valid because big > small guarantees a
       strictly positive result. This is the only removal primitive besides cast_out."""
    assert big > small
    return big.__sub__(small)

def separation(a, b):
    """How far apart two ones lie, as a part of the One, the short way, in (0, 1].
       From ordering and the single removal primitive; coincidence is unison (ONE)."""
    if a == b:
        return ONE
    hi, lo = (a, b) if a > b else (b, a)
    one_way = take(hi, lo)            # hi > lo => strictly positive
    other_way = take(ONE, one_way)    # one_way < ONE => strictly positive
    return one_way if one_way <= other_way else other_way

def whole_parts(k):
    """The whole divided into 2^k equal parts: each part is the ratio one-in-2^k."""
    return Fraction(1, 2**k)

# Absence of a magnitude. A site that holds no presence, a curvature that is flat, two magnitudes
# that coincide -- these are absence, not the value zero (no zero-as-value/sink, §8). Absence is
# carried structurally as None and contributes nothing to a sum.
ABSENT = None

def present_sum(values):
    """Sum the present magnitudes (skipping absence), starting the running total from the first
       present term -- never seeded with zero. Returns ABSENT if every term is absent."""
    acc = ABSENT
    for v in values:
        if v is ABSENT:
            continue
        acc = v if acc is ABSENT else acc + v
    return acc

def gap(a, b):
    """The positive difference of two magnitudes, or ABSENT when they coincide or are both absent.
       Absence on one side leaves the other (nothing is taken away). No zero, no negative."""
    if a is ABSENT and b is ABSENT: return ABSENT
    if a is ABSENT: return b
    if b is ABSENT: return a
    if a > b: return take(a, b)
    if b > a: return take(b, a)
    return ABSENT
