from fractions import Fraction
import math

# Define ONE exactly as a Fraction
ONE_VAL = Fraction(1, 1)

def cast_out(m):
    """
    Brings a value back into (0, 1] by removing whole ONEs.
    cast_out(m) = m - floor(m), except when that would give 0, it gives 1.
    """
    if isinstance(m, float):
        rem = m % 1.0
        # If float precision causes it to be extremely close to 0 or 1,
        # we handle it carefully.
        if math.isclose(rem, 0.0, abs_tol=1e-15):
            return 1.0
        return rem
    
    # Exact Fraction arithmetic
    frac = Fraction(m)
    # Perform modulo 1
    rem = frac % ONE_VAL
    if rem == Fraction(0, 1):
        return ONE_VAL
    return rem

class SmithianValue:
    """
    Represents a value strictly inside the SFTOE domain (0, 1].
    Every SmithianValue carries a trace (derivation tree) representing
    how it was constructed from the ONE.
    """
    def __init__(self, value, trace=None):
        if isinstance(value, float):
            self.value = value
        elif isinstance(value, SmithianValue):
            self.value = value.value
            if trace is None:
                trace = value.trace
        else:
            self.value = Fraction(value)
            
        # Domain verification: must be strictly in (0, 1]
        # No zero, no negatives.
        if isinstance(self.value, float):
            if self.value <= 0.0 or self.value > 1.0:
                raise ValueError(f"Value {value} is outside the SFTOE domain (0, 1]")
        else:
            if self.value <= Fraction(0, 1) or self.value > ONE_VAL:
                raise ValueError(f"Value {value} is outside the SFTOE domain (0, 1]")
                
        # Handle trace
        from sftoe.proof import ProofNode
        if trace is None:
            if self.value == ONE_VAL:
                self.trace = ProofNode("axiom", "ONE", [])
            else:
                self.trace = ProofNode("hypothesis", str(self.value), [])
        else:
            self.trace = trace

    def fold(self):
        """
        Doubles the value and casts out the whole parts.
        fold(x) = cast_out(x + x)
        """
        # Addition is allowed, cast_out will wrap it
        folded = cast_out(self.value + self.value)
        from sftoe.proof import ProofNode
        new_trace = ProofNode("fold", "fold", [self.trace])
        return SmithianValue(folded, new_trace)

    def take(self, other):
        """
        Subtracts the other value from self, asserting self > other.
        This is the only permitted subtraction.
        """
        if not isinstance(other, SmithianValue):
            other = SmithianValue(other)
            
        if self.value <= other.value:
            raise AssertionError(f"Subtraction violation: {self.value} is not strictly greater than {other.value}")
            
        # Perform the guarded subtraction
        diff = self.value - other.value
        from sftoe.proof import ProofNode
        new_trace = ProofNode("take", "take", [self.trace, other.trace])
        return SmithianValue(diff, new_trace)


    def __eq__(self, other):
        if isinstance(other, SmithianValue):
            return self.value == other.value
        return self.value == other

    def __lt__(self, other):
        if isinstance(other, SmithianValue):
            return self.value < other.value
        return self.value < other

    def __le__(self, other):
        if isinstance(other, SmithianValue):
            return self.value <= other.value
        return self.value <= other

    def __gt__(self, other):
        if isinstance(other, SmithianValue):
            return self.value > other.value
        return self.value > other

    def __ge__(self, other):
        if isinstance(other, SmithianValue):
            return self.value >= other.value
        return self.value >= other

    def __repr__(self):
        return f"SmithianValue({self.value})"

    def __str__(self):
        return str(self.value)

# Define public constant ONE
ONE = SmithianValue(ONE_VAL)

def fold(x):
    if not isinstance(x, SmithianValue):
        x = SmithianValue(x)
    return x.fold()

def take(big, small):
    if not isinstance(big, SmithianValue):
        big = SmithianValue(big)
    return big.take(small)

def period(p, cap=100000):
    """
    Computes the fundamental period of a rational value p under repeated folding.
    Returns the period as an integer count, or None if it exceeds cap.
    """
    if not isinstance(p, SmithianValue):
        p = SmithianValue(p)
    cur = fold(p)
    n = 1
    while cur != p:
        cur = fold(cur)
        n += 1
        if n > cap:
            return None
    return n

def combined_period(parts, cap=1000000):
    """
    Computes the framework combined period of a set of rational values under joint folding.
    Returns the combined period as an integer count, or None if it exceeds cap.
    """
    sv_parts = []
    for x in parts:
        if not isinstance(x, SmithianValue):
            sv_parts.append(SmithianValue(x))
        else:
            sv_parts.append(x)
            
    start = tuple(x.value for x in sv_parts)
    cur = tuple(fold(x).value for x in sv_parts)
    n = 1
    while cur != start:
        cur = tuple(fold(x).value for x in cur)
        n += 1
        if n > cap:
            return None
    return n


def rotate(phase, step):
    """
    Advances a phase by a fixed part of the One: rotate(phase, step) = cast_out(phase + step).
    """
    if not isinstance(phase, SmithianValue):
        phase = SmithianValue(phase)
    if not isinstance(step, SmithianValue):
        step = SmithianValue(step)
    val = cast_out(phase.value + step.value)
    return SmithianValue(val)


def relative_phase(p1, p2):
    """
    Computes the relative phase of p1 seen from p2 on the circle of the One.
    """
    if not isinstance(p1, SmithianValue):
        p1 = SmithianValue(p1)
    if not isinstance(p2, SmithianValue):
        p2 = SmithianValue(p2)
        
    if p2.value == ONE.value:
        return p1
        
    diff = take(ONE, p2)
    val = cast_out(p1.value + diff.value)
    return SmithianValue(val)


def beat_frequency(f1, f2):
    """
    Computes the beat frequency between two frequencies f1 and f2: |f1 - f2|.
    Returns a SmithianValue representing the absolute difference, derived via take.
    """
    if not isinstance(f1, SmithianValue):
        f1 = SmithianValue(f1)
    if not isinstance(f2, SmithianValue):
        f2 = SmithianValue(f2)
        
    if f1.value == f2.value:
        return ONE
        
    if f1.value > f2.value:
        return take(f1, f2)
    else:
        return take(f2, f1)


def relative_advance(rel):
    """
    Computes the constant relative advance step between successive phases in rel.
    """
    sv_rel = []
    for r in rel:
        if not isinstance(r, SmithianValue):
            sv_rel.append(SmithianValue(r))
        else:
            sv_rel.append(r)
            
    pairs = list(zip(sv_rel, sv_rel[1:]))
    if not pairs:
        return None
        
    step0 = relative_phase(pairs[0][1], pairs[0][0])
    for x, y in pairs:
        if relative_phase(y, x).value != step0.value:
            return None
    return step0


def run_wave(f1, f2, ticks, p1=None, p2=None):
    """
    Simulates the evolution of two waves stepping by f1 and f2 over ticks.
    Returns the list of relative phases at each tick.
    """
    if not isinstance(f1, SmithianValue):
        f1 = SmithianValue(f1)
    if not isinstance(f2, SmithianValue):
        f2 = SmithianValue(f2)
        
    p1 = f1 if p1 is None else (p1 if isinstance(p1, SmithianValue) else SmithianValue(p1))
    p2 = f2 if p2 is None else (p2 if isinstance(p2, SmithianValue) else SmithianValue(p2))
    
    rel = []
    for _ in range(ticks):
        p1 = rotate(p1, f1)
        p2 = rotate(p2, f2)
        rel.append(relative_phase(p1, p2))
    return rel




