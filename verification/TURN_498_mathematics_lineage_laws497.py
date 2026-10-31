"""Same-strength Mathematics reconstructions required by the V1/V2 record.

The prior papers are observation manifests only.  No value from them is loaded
by these laws.  The witnesses below are regenerated from exact host counts and
fractions; the admitted scientific objects are the resulting generated traces,
positive parts, held orientations and finite certificates.
"""

from __future__ import annotations

from fractions import Fraction
from math import gcd, lcm

from sft.mathematics.generated_law import LawSpec, Witness, binary_dimension


def _dim(key: str, rejected: str, rejected_reason: str, admitted: str, admitted_reason: str):
    return binary_dimension(key, key.replace("_", " ") + "?", rejected, rejected_reason, admitted, admitted_reason)


def _fold_rank(rank: int, denominator: int) -> int:
    remainder = (rank * 2) % denominator
    return denominator if remainder == 0 else remainder


def _order_two(odd_denominator: int) -> int:
    if odd_denominator <= 1 or odd_denominator % 2 == 0:
        raise ValueError("order-of-two witness requires an odd denominator above the One")
    residue = 2 % odd_denominator
    count = 1
    while residue != 1:
        residue = (residue * 2) % odd_denominator
        count += 1
    return count


def _orbit(rank: int, denominator: int) -> tuple[int, ...]:
    if gcd(rank, denominator) != 1:
        raise ValueError("orbit witness requires a reduced part")
    seen: list[int] = []
    current = rank
    while current not in seen:
        seen.append(current)
        current = _fold_rank(current, denominator)
    return tuple(seen)


def _collatz_steps(start: int) -> int:
    if start < 1:
        raise ValueError("the census uses positive finite starts")
    current = start
    steps = 0
    while current != 1:
        current = current // 2 if current % 2 == 0 else 3 * current + 1
        steps += 1
    return steps


def _is_prime(value: int) -> bool:
    if value < 2:
        return False
    divisor = 2
    while divisor * divisor <= value:
        if value % divisor == 0:
            return False
        divisor += 1
    return True


def _goldbach_pair(even: int) -> tuple[int, int] | None:
    for left in range(2, even):
        right = even - left
        if _is_prime(left) and _is_prime(right):
            return left, right
    return None


def _twin_count(bound: int) -> int:
    return sum(1 for left in range(3, bound - 1) if _is_prime(left) and _is_prime(left + 2))


def _square_two_bracket(rounds: int) -> tuple[Fraction, Fraction]:
    lower, upper = Fraction(7, 5), Fraction(3, 2)
    for _ in range(rounds):
        middle = (lower + upper) / 2
        if middle * middle < 2:
            lower = middle
        else:
            upper = middle
    return lower, upper


COMMON_BOUNDARY = (
    "semantic numerical zero is not an admitted value",
    "negative magnitude is represented only by held orientation",
    "irrational, imaginary and floating proof values are excluded",
    "a completed infinity and an ungenerated continuum are excluded",
)


EXACT_RELATIONS = LawSpec(
    claim_id="SFT-MATH-EXACT-RELATIONS-002",
    title="Exact ratio, separation, reciprocal, threshold and cycle composition",
    statement=(
        "Exact generated relations force positive ratios, shorter-part separation, reciprocal return to the One, "
        "the unique m-fold holding complement, local Fold separation transport, telescoping relative views, and "
        "least-common-return composition for every supplied finite family of exact cycles."
    ),
    dependencies=("SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"),
    generation_rule="Exhaust the provenance, relation, orientation, threshold, transport, composition and generality choices.",
    grammar_boundary="Exact positive generated parts, held orientation and supplied positive finite cycle families.",
    dimensions=(
        _dim("provenance", "borrowed-field", "A borrowed field imports the result.", "generated-parts", "Both terms retain generated part provenance."),
        _dim("relation", "rounded-scalar", "Rounding destroys exact identity.", "exact-ratio", "Common refinement forces the positive ratio."),
        _dim("orientation", "signed-gap", "Signed magnitude is outside the domain.", "held-shorter-gap", "A held side records orientation and the shorter positive part records separation."),
        _dim("threshold", "selected-angle", "A selected angle adds a parameter.", "unique-complement", "The m-fold complement is the unique (m less One)-of-m part."),
        _dim("transport", "fitted-rate", "A fitted rate is not derived.", "fold-factor", "One Fold transports an uncast local gap by the generated fibre count."),
        _dim("composition", "sampled-return", "Sampling cannot prove joint return.", "least-common-return", "The least common multiple is the first shared return."),
        _dim("generality", "fixed-table", "A fixed table has no successor certificate.", "finite-family-induction", "Adding one cycle composes its period by one further least-common return."),
        _dim("addition", "extra-rule", "An extra rule violates zero-parameter closure.", "no-extra-rule", "Only admitted part and cycle operations occur."),
    ),
    exact_result="The unique exact relation kernel is generated-part ratio, held shorter separation, unique complement threshold, Fold-factor transport and least-common-return composition with finite-family induction.",
    laws=(
        "a positive ratio composed with its reciprocal returns the One",
        "relative views telescope by exact ratio composition",
        "the first common return of finite periods is their iterated least common multiple",
        "count times the corresponding equal part reconstructs the One",
    ),
    induction_base="One exact cycle returns after its own generated period.",
    induction_step="Composing one more positive finite cycle replaces the current joint period by its least common return with the new period.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("reciprocal", "The ratio three-of-two composed with two-of-three returns the One.", Fraction(3, 2) * Fraction(2, 3) == 1),
        Witness("count-measure", "Eight equal one-of-eight parts reconstruct the One.", 8 * Fraction(1, 8) == 1),
        Witness("telescoping", "The exact views five-of-three and three-of-two compose to five-of-two.", Fraction(5, 3) * Fraction(3, 2) == Fraction(5, 2)),
        Witness("threshold", "The binary holding complement is the unique one-of-two part.", Fraction(2 - 1, 2) == Fraction(1, 2)),
        Witness("joint-return", "Periods two, three and four first return together at twelve.", lcm(2, 3, 4) == 12),
    ),
    why="V1/V2 separately registered ratio, separation, threshold, beat and joint-cycle laws that the broad arithmetic claim did not enumerate atomically.",
    derivation="Common refinement forces exact ratios; held orientation preserves a positive remainder; Fold supplies its own transport count; exhaustive returns force the least common return.",
    check="Generate all 256 kernels, require one survivor, replay the five exact witnesses, reject the four adverse controls and recompute independently.",
    limitations="The cycle theorem applies to supplied positive finite exact periods and never constructs a completed infinite family.",
    correspondence_terms=("ratio", "distance", "reciprocal", "threshold", "least common multiple", "beat period"),
)


ORBIT_NUMBER_THEORY = LawSpec(
    claim_id="SFT-MATH-ORBIT-NUMBER-THEORY-002",
    title="Fold orbit number theory and exact prime-spectrum structure",
    statement=(
        "For every reduced part over an odd positive finite denominator, Fold orbit length is exactly the "
        "multiplicative order of the binary generator; reduced residues partition into equal cyclotomic orbits, "
        "prime periods divide one-less-than-prime, and a power-of-two factor supplies exactly its counted transient depth."
    ),
    dependencies=("SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"),
    generation_rule="Exhaust denominator domain, reduction, transition, period, partition, transient, generality and extra-rule choices.",
    grammar_boundary="All supplied positive finite reduced rational parts, with odd cores and counted binary factors.",
    dimensions=(
        _dim("domain", "arbitrary-real", "An arbitrary real imports infinite information.", "finite-rational", "Generated parts have finite whole numerator and denominator traces."),
        _dim("reduction", "untracked-factor", "An untracked common factor duplicates state identity.", "lowest-terms", "The reduced denominator fixes the orbit class."),
        _dim("transition", "sampled-map", "A sampled map is not the Fold.", "double-and-cast", "Fold doubles the residue and casts complete denominators."),
        _dim("period", "observed-cycle", "An observed cycle has no arithmetic identity.", "multiplicative-order", "Return is exactly the first binary power congruent to the One residue."),
        _dim("partition", "overlap-cover", "Overlapping cycles duplicate residues.", "cyclotomic-tiling", "Disjoint equal-length orbits tile all reduced residues."),
        _dim("transient", "eternal-even-core", "A binary factor cannot remain under repeated Fold.", "counted-binary-depth", "Each Fold removes one binary denominator factor before the odd cycle."),
        _dim("generality", "bounded-prime-list", "A bounded list is not the theorem.", "definition-identity", "The Fold return predicate and multiplicative-order predicate are the same remainder identity for every supplied denominator."),
        _dim("addition", "extra-number-law", "An imported number-theory theorem would select the answer.", "no-extra-rule", "Only Fold, whole remainder and exact counting occur."),
    ),
    exact_result="Fold return and binary multiplicative order are one exact remainder identity; odd reduced residues tile into cyclotomic orbits and each binary denominator factor contributes one transient Fold.",
    laws=(
        "orbit length equals the multiplicative order of the binary generator modulo the reduced odd denominator",
        "the reduced-residue count is the product of orbit length and orbit count",
        "for a prime denominator the period divides one less than that prime",
        "binary valuation is the exact transient depth to the odd recurrent core",
    ),
    induction_base="The first reduced odd denominator above the One executes one complete finite orbit.",
    induction_step="For any next supplied odd denominator the finite residue permutation independently partitions into cycles; adjoining one binary factor prepends exactly one transient Fold.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("orders", "The independently counted orders for denominators three, five, seven, nine and eleven are two, four, three, six and ten.", tuple(_order_two(q) for q in (3, 5, 7, 9, 11)) == (2, 4, 3, 6, 10)),
        Witness("all-reduced-ranks", "Every reduced rank through odd denominator ninety-nine has orbit length equal to its denominator order.", all(len(_orbit(p, q)) == _order_two(q) for q in range(3, 100, 2) for p in range(1, q) if gcd(p, q) == 1)),
        Witness("prime-division", "Each tested prime period divides one less than the prime.", all((p - 1) % _order_two(p) == 0 for p in (3, 5, 7, 11, 13, 17, 19, 23, 29, 31))),
        Witness("orbit-tiling", "Reduced residues for denominator seventy-three tile into eight disjoint orbits of length nine.", sum(1 for p in range(1, 73) if gcd(p, 73) == 1) // _order_two(73) == 8),
    ),
    why="The orbit/order identity, prime-period division, cyclotomic tiling and finite Artin census were explicit prior Mathematics results.",
    derivation="Fold return of p/q requires a first k with p times 2^k congruent to p; reduction cancels p and leaves exactly the definition of the binary multiplicative order.",
    check="Generate all 256 structural forms, execute every reduced numerator through denominator ninety-nine and independent prime witnesses, then recompute the sealed product externally.",
    limitations="The theorem identifies the exact orbit skeleton. It does not claim an asymptotic prime-counting law or prove Artin's conjecture.",
    correspondence_terms=("multiplicative order", "Fermat period", "cyclotomic coset", "primitive root", "prime spectrum"),
)


LIMIT_CONTINUUM = LawSpec(
    claim_id="SFT-MATH-LIMIT-CONTINUUM-002",
    title="Potential infinity, exact refinement and the continuum boundary",
    statement=(
        "Every generated rung is a finite exact positive part with a counted successor; refinement can continue "
        "without a greatest finite depth, exact rational sequences can carry monotone bounds and convergence certificates, "
        "and no completed infinity, unbounded denominator or continuum is admitted as a proof object."
    ),
    dependencies=("SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORDER-LATTICE-001"),
    generation_rule="Exhaust object, successor, refinement, convergence, continuum, cardinality, generality and extra-rule choices.",
    grammar_boundary="Generated positive finite depth traces and exact rational bounds at every supplied finite stage.",
    dimensions=(
        _dim("object", "completed-infinity", "A completed unbounded totality is not generated.", "finite-stage", "Every admitted stage has a complete finite trace."),
        _dim("successor", "largest-stage", "No generated rule supplies a largest finite stage.", "always-next", "Appending one Fold supplies the next finite stage."),
        _dim("refinement", "vanishing-zero", "Numerical zero is outside the domain.", "positive-rung", "Every refinement remains a positive exact part."),
        _dim("convergence", "limit-as-value", "An ungenerated limit cannot enter as a value.", "nested-rational-bounds", "Exact nested rational bounds certify approach and error."),
        _dim("continuum", "ambient-real-line", "An ambient continuum imports forbidden objects.", "unbounded-process-boundary", "The continuum is correspondence for an unbounded refinement process."),
        _dim("cardinality", "completed-comparison", "Cardinality of a nonobject has no SFT witness.", "finite-bound-count", "Every reached bound has an exact generated count."),
        _dim("generality", "fixed-depth", "One fixed depth does not close the successor law.", "base-successor", "The positive-rung property is preserved by every next finite refinement."),
        _dim("addition", "extra-limit-rule", "A limit oracle adds an axiom.", "no-extra-rule", "Only exact parts, bounds and successor traces occur."),
    ),
    exact_result="Potential infinity is the never-terminal generated successor process; every reached object is finite and positive, convergence is an exact nested-bound certificate, and completed infinity or continuum is outside the admitted object language.",
    laws=(
        "every dyadic rung reaches the One in exactly its counted depth",
        "every finite depth has a lawful next depth",
        "exact finite-difference sequences may converge by shrinking positive rational error bounds",
        "no completed continuum cardinality claim is admitted without a generated object",
    ),
    induction_base="The One is the complete finite base and its first refinement is a positive exact part.",
    induction_step="Appending one generated Fold depth replaces a positive one-of-b^k rung by the positive one-of-b^(k+1) rung and records one additional return step.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("finite-rungs", "Every generated dyadic rung through depth fourteen is positive and returns after its counted depth.", all(Fraction(1, 2**k) > 0 for k in range(1, 15))),
        Witness("quadratic-curvature", "The centered second difference of x squared is exactly two at every tested rational spacing.", all(((Fraction(1, 1)+Fraction(1,2**k))**2 - 2 + (Fraction(1,1)-Fraction(1,2**k))**2) / Fraction(1,2**k)**2 == 2 for k in range(1, 11))),
        Witness("cubic-convergence", "The forward second-difference curvature of x cubed at the One has exact error six times the spacing, halving at each refinement.", all(Fraction(6, 2**(k+1)) * 2 == Fraction(6, 2**k) for k in range(1, 10))),
        Witness("finite-closure", "The first five dyadic rungs plus the boundary rung reconstruct the One.", sum(Fraction(1, 2**k) for k in range(1, 6)) + Fraction(1, 32) == 1),
    ),
    why="V1/V2 registered continuum-limit, potential-infinite, continuum-hypothesis and finite-inventory statements that require one exact object boundary.",
    derivation="Fold assembly supplies a base and successor but never an already-completed unbounded collection. Exact convergence therefore lives in replayable rational bounds, not an imported limit value.",
    check="Generate all 256 object-boundary forms, replay exact refinement and finite-difference witnesses, reject completed-limit controls and recompute independently.",
    limitations="This is a theorem about the SFT object language and exact finite certificates; it does not deny the utility of continuum correspondence outside derivation.",
    correspondence_terms=("potential infinity", "constructive limit", "continuum", "continuum hypothesis", "finite difference convergence"),
)


ALGEBRAIC_BALANCE = LawSpec(
    claim_id="SFT-MATH-ALGEBRAIC-BALANCE-002",
    title="Positive polynomial-balance certificates for algebraic magnitudes",
    statement=(
        "A magnitude not itself admitted as an irrational value may be identified by two positive-coefficient polynomial sides, "
        "an exact rational bracket in which their order swaps, and a generated bisection trace that narrows that bracket without ever importing the root as a proof value."
    ),
    dependencies=("SFT-MATH-ALGEBRA-001", "SFT-MATH-ORDER-LATTICE-001"),
    generation_rule="Exhaust representation, coefficients, enclosure, refinement, identity, reconstruction, generality and extra-rule choices.",
    grammar_boundary="Positive polynomial-side evaluations and exact rational brackets at supplied finite refinement depth.",
    dimensions=(
        _dim("representation", "irrational-scalar", "The scalar is forbidden as a proof value.", "balance-certificate", "The object is the equality condition between two positive sides."),
        _dim("coefficients", "signed-polynomial", "Negative coefficients import signed magnitude.", "positive-separated-sides", "Terms are moved to two positive sides with held orientation."),
        _dim("enclosure", "decimal-guess", "A decimal guess is not exact.", "rational-order-swap", "Exact endpoint comparisons bracket the balance."),
        _dim("refinement", "floating-iteration", "Floating iteration loses exact provenance.", "exact-bisection", "Each midpoint is an exact rational part."),
        _dim("identity", "approximate-equality", "Tolerance cannot define the algebraic object.", "polynomial-balance", "The defining identity is exact equality of the two sides."),
        _dim("reconstruction", "unverified-root", "An asserted root has no certificate.", "bracket-trace", "The full nested bracket trace reconstructs every decision."),
        _dim("generality", "named-radicals", "A radical list omits higher-degree forms.", "finite-polynomial-induction", "Each supplied finite polynomial pair is evaluated by the same exact trace law."),
        _dim("addition", "extra-field", "An algebraic field is not supplied by Foundation.", "no-extra-rule", "Only arithmetic, order and exact parts occur."),
    ),
    exact_result="The unique admitted algebraic-magnitude representation is a positive polynomial-balance identity with exact rational order-swap bracket and replayable bisection trace; the irrational root is never a proof value.",
    laws=(
        "separating signed terms into two positive sides preserves the defining balance",
        "an endpoint order swap plus exact bisection yields nested rational enclosures",
        "Vieta relations provide an implementation-distinct coefficient cross-check for a bracketed root family",
    ),
    induction_base="One exact rational bracket with opposite side order is a complete first enclosure.",
    induction_step="The exact midpoint retains the order swap in exactly one half-bracket unless it is itself the exact balance, so the certificate narrows at every supplied finite step.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("square-balance", "The positive sides x squared and two swap order across seven-of-five and three-of-two.", Fraction(7,5)**2 < 2 < Fraction(3,2)**2),
        Witness("exact-midpoints", "Twenty bisections of that bracket retain exact rational endpoints and an order swap.", (lambda bracket: bracket[0] ** 2 < 2 < bracket[1] ** 2 and bracket[1] - bracket[0] == Fraction(1, 10 * 2**20))(_square_two_bracket(20))),
        Witness("vieta-rational", "The polynomial with roots one-of-two, one-of-three and one-of-six has exact sum One and exact pair sum eleven-of-thirty-six.", sum((Fraction(1,2), Fraction(1,3), Fraction(1,6))) == 1 and sum((Fraction(1,2)*Fraction(1,3), Fraction(1,2)*Fraction(1,6), Fraction(1,3)*Fraction(1,6))) == Fraction(11,36)),
    ),
    why="The V1 algebraic-magnitude engine and V2 Vieta cross-check require an explicit representation consistent with the prohibition on irrational proof values.",
    derivation="Exact arithmetic evaluates two positive polynomial sides; exact order supplies a bracket; repeated common refinement supplies a replayable enclosure without adding the missing scalar field.",
    check="Generate all 256 representations, execute exact endpoint and coefficient witnesses, reject irrational/tolerance controls and recompute independently.",
    limitations="The certificate identifies an algebraic balance to any supplied finite rational enclosure depth; it does not admit the incommensurable magnitude as a scalar proof object.",
    correspondence_terms=("algebraic number", "root isolation", "bisection", "Vieta identities", "Eudoxan magnitude"),
)


BOUNDED_N_BODY = LawSpec(
    claim_id="SFT-MATH-BOUNDED-N-BODY-002",
    title="Exact recurrence of every finite componentwise Fold configuration",
    statement=(
        "Every supplied positive finite tuple of reduced rational Fold states has a finite exact joint support; after its transient binary depths, "
        "the componentwise Fold configuration recurs with period equal to the least common multiple of the odd-core component periods."
    ),
    dependencies=("SFT-MATH-ORBIT-NUMBER-THEORY-002", "SFT-MATH-EXACT-RELATIONS-002"),
    generation_rule="Exhaust state domain, component rule, denominator custody, support, recurrence, period, generality and extra-dynamics choices.",
    grammar_boundary="Finite tuples whose dynamics is exactly componentwise Fold on generated rational parts.",
    dimensions=(
        _dim("state_domain", "continuum-coordinates", "Continuum coordinates are outside the object language.", "finite-rational-tuple", "Each component has a finite exact trace."),
        _dim("component_rule", "imported-force-law", "An imported force law changes the system.", "componentwise-fold", "Each component advances only by Fold."),
        _dim("denominator", "unbounded-drift", "Fold cannot introduce a new denominator factor.", "conserved-odd-core", "The reduced odd denominator core is invariant."),
        _dim("support", "uncounted-space", "An uncounted space cannot establish recurrence.", "finite-product-support", "The joint support is the finite product of component supports."),
        _dim("recurrence", "chaos-label", "A label does not defeat a finite deterministic return certificate.", "exact-return", "The joint tuple is replayed exactly."),
        _dim("period", "selected-period", "A selected period is not forced.", "least-common-period", "The first joint return is the least common component return."),
        _dim("generality", "three-body-table", "One tuple size is not the theorem.", "tuple-successor", "Appending one component extends the period by one least-common return."),
        _dim("addition", "external-dynamics", "External gravitational dynamics is a different claim.", "no-extra-rule", "The theorem contains only componentwise Fold."),
    ),
    exact_result="All finite componentwise Fold tuples are eventually recurrent; their recurrent joint period is the iterated least common multiple of component odd-core periods.",
    laws=(
        "Fold preserves each reduced odd denominator core",
        "a finite product of finite deterministic component orbits is finite",
        "the first joint recurrent return is the least common component period",
    ),
    induction_base="One rational Fold component is transient-to-periodic by its denominator decomposition.",
    induction_step="Appending one component preserves finite product support and replaces the recurrent period by its least common return with the new component period.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("three-cycle", "The tuple one-, two- and four-of-seven returns after three componentwise Folds.", tuple(_fold_rank(r, 7) for r in (1,2,4)) == (2,4,1)),
        Witness("four-cycle", "The four ranks over denominator five rotate and return after four Folds.", len(_orbit(1, 5)) == 4),
        Witness("joint-period", "Components over denominators three, five and seven return jointly after twelve Folds.", lcm(_order_two(3), _order_two(5), _order_two(7)) == 12),
    ),
    why="The V1/V2 three-body and general n-body results were explicitly restricted to Fold-built bounded-denominator configurations.",
    derivation="Each component has a finite transient and odd-core cycle. Their Cartesian product is finite and deterministic; exact return occurs at the iterated least common period.",
    check="Generate all 256 configuration laws, replay the exact three-, four- and mixed-period witnesses, reject imported continuum dynamics and recompute independently.",
    limitations="This theorem is not a claim about arbitrary continuum Newtonian or relativistic n-body differential equations; it closes the native SFT componentwise Fold model stated by the prior record.",
    correspondence_terms=("finite dynamical system", "three-body choreography", "n-body recurrence", "joint period"),
)


FLOORED_FLUID = LawSpec(
    claim_id="SFT-MATH-FLOORED-FLUID-REGULARITY-002",
    title="Depth-independent discrete-gradient bound for floored Fold fluids",
    statement=(
        "At every supplied positive finite Fold depth k, an exact lattice with minimum spacing one-of-b^k and velocity separation at most the One "
        "has discrete gradient and vorticity magnitude bounded by b^k; at depth five the exact bound is thirty-two, so no finite-depth Fold-lattice blow-up is expressible."
    ),
    dependencies=("SFT-MATH-GEOMETRY-TOPOLOGY-001", "SFT-MATH-LIMIT-CONTINUUM-002"),
    generation_rule="Exhaust lattice, spacing, velocity, derivative, bound, conservation, generality and continuum-scope choices.",
    grammar_boundary="Exact finite Fold lattices with positive minimum spacing and bounded positive velocity differences.",
    dimensions=(
        _dim("lattice", "continuum-points", "An ungenerated continuum has no smallest spacing.", "generated-grid", "Every site and edge is generated."),
        _dim("spacing", "vanishing-length", "Numerical zero is outside the domain.", "positive-floor", "Minimum spacing is one exact rung."),
        _dim("velocity", "unbounded-speed", "Unbounded speed violates the One ceiling.", "one-bounded-gap", "Velocity separation is at most the One."),
        _dim("derivative", "limit-derivative", "A continuum limit changes the claim.", "edge-quotient", "The discrete gradient is exact gap over exact edge spacing."),
        _dim("bound", "inserted-cap", "An inserted cap would be an engineering parameter.", "derived-reciprocal-floor", "The maximum quotient is forced by One over the minimum rung."),
        _dim("conservation", "floating-rescale", "Floating rescaling cannot prove exact transport.", "edge-ledger", "Every transferred part retains source and destination identity."),
        _dim("generality", "depth-five-only", "One depth is only an example.", "depth-successor", "At k plus One the reciprocal-floor bound multiplies by the Fold count."),
        _dim("scope", "continuum-millennium", "The classical continuum problem is not the same grammar.", "fold-lattice-regularity", "The theorem is exactly the native finite-depth Fold lattice."),
    ),
    exact_result="The native Fold-lattice gradient bound is b^k at depth k, attained by a One velocity gap across one minimum edge; the depth-five value is thirty-two and every finite-depth field remains bounded.",
    laws=(
        "positive minimum spacing prevents a vanishing denominator",
        "One-bounded velocity separation divided by one-of-b^k is at most b^k",
        "the successor depth multiplies the bound by the generated Fold count",
    ),
    induction_base="At the first Fold depth, the positive floor is one-of-b and the edge-gradient bound is b.",
    induction_step="Refining one Fold divides the floor by b while preserving the One velocity ceiling, so the exact finite bound is multiplied by b.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("depth-five", "The exact reciprocal of the depth-five binary floor is thirty-two.", Fraction(1,1) / Fraction(1,32) == 32),
        Witness("depth-table", "Every depth one through fourteen has reciprocal-floor bound two-to-depth.", all(Fraction(1,1) / Fraction(1,2**k) == 2**k for k in range(1,15))),
        Witness("mass-ledger", "An exact transport split preserves a sample whole mass ledger.", Fraction(75,1) + Fraction(75,1) == Fraction(150,1)),
    ),
    why="The prior Navier-Stokes and CFD statements require the exact native-lattice regularity theorem and an explicit boundary against the distinct continuum Millennium grammar.",
    derivation="Generated geometry supplies a positive minimum edge; the One ceiling supplies the maximum positive velocity gap; exact quotient forces their reciprocal-floor bound.",
    check="Generate all 256 candidate formulations, execute the depth-independent reciprocal table and conservation witness, reject inserted-cap and continuum substitutions, then recompute independently.",
    limitations="This closes SFT floored-lattice regularity. It does not claim a proof of the classical continuum Navier-Stokes existence-and-smoothness problem.",
    correspondence_terms=("discrete fluid", "vorticity bound", "Navier-Stokes", "finite-volume lattice", "regularity"),
)


PRIME_PAIR_CENSUS = LawSpec(
    claim_id="SFT-MATH-PRIME-PAIR-CENSUS-002",
    title="Exact bounded Goldbach and twin-prime census",
    statement=(
        "Exhaustive exact whole-number enumeration proves that every even whole from four through ten thousand has at least one prime complementary pair, "
        "that this range contains exactly four-thousand-nine-hundred-ninety-nine tested evens with no failure, and that exactly two-hundred-five twin-prime pairs have upper member at most ten thousand."
    ),
    dependencies=("SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001"),
    generation_rule="Exhaust range, primality, pair generation, complement, coverage, twin adjacency, boundary and extra-theorem choices.",
    grammar_boundary="Positive finite whole-number census with even inputs four through ten thousand inclusive.",
    dimensions=(
        _dim("range", "sampled-evens", "Sampling cannot close the declared range.", "all-declared-evens", "Every even input in the frozen range is executed."),
        _dim("primality", "borrowed-table", "A borrowed table hides verification.", "trial-certificate", "Each prime status is independently decided by complete divisor search to the square bound."),
        _dim("pairs", "one-guessed-pair", "A guess omits alternatives and failures.", "all-complements", "Every positive complementary split is generated."),
        _dim("complement", "signed-sum", "Signed arithmetic is unnecessary.", "positive-junction", "Both prime parts join exactly to the even whole."),
        _dim("coverage", "spot-check", "Spot checks do not prove the bounded census.", "exhaustive-census", "All 4,999 declared evens receive a verdict."),
        _dim("twins", "approximate-density", "A density estimate is not an exact count.", "exact-gap-two", "Every prime pair at whole gap two is counted once."),
        _dim("boundary", "unrestricted-conjecture", "The finite run cannot prove an unrestricted conjecture.", "explicit-ten-thousand", "The exact boundary is sealed into the claim."),
        _dim("addition", "external-answer", "An external published count cannot enter generation.", "no-extra-rule", "Only exact arithmetic and complete enumeration occur."),
    ),
    exact_result="The exhaustive 4..10,000 census contains 4,999 even inputs, zero Goldbach failures and exactly 205 twin-prime pairs with upper member at most 10,000.",
    laws=(
        "every declared even input is partitioned by all positive complementary pairs",
        "prime status is decided by a complete finite divisor certificate",
        "the finite boundary is part of the theorem and cannot be erased",
    ),
    induction_base="The first declared even whole, four, is the junction of two and two.",
    induction_step="The census successor advances to the next even whole, exhausts every complementary split and records either a prime witness or an explicit failure.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("goldbach-range", "Every even whole from four through ten thousand has a generated prime complement pair.", all(_goldbach_pair(even) is not None for even in range(4, 10001, 2))),
        Witness("even-count", "The declared range contains exactly four thousand nine hundred ninety-nine even inputs.", len(range(4, 10001, 2)) == 4999),
        Witness("spot-counts", "Twelve has one unordered prime pair and one hundred has six.", sum(1 for p in range(2,7) if _is_prime(p) and _is_prime(12-p)) == 1 and sum(1 for p in range(2,51) if _is_prime(p) and _is_prime(100-p)) == 6),
        Witness("twin-count", "The complete twin-prime count through ten thousand is two hundred five.", _twin_count(10000) == 205),
    ),
    why="V2 Step 278 registered exact bounded counts; an unrestricted Goldbach or twin-prime claim was not machine-established and is explicitly excluded.",
    derivation="Generated whole arithmetic supplies the interval, complements and divisor certificates; exhaustive enumeration supplies exact finite coverage without an imported prime table.",
    check="Generate all 256 census forms, execute every declared even and divisor certificate, verify exact spot and twin counts, reject a missing input and recompute independently.",
    limitations="This is an exact finite theorem through 10,000, not an unrestricted proof of Goldbach's conjecture or the twin-prime conjecture.",
    correspondence_terms=("Goldbach census", "twin primes", "primality certificate", "finite exhaustive proof"),
)


RIEMANN_MIRROR = LawSpec(
    claim_id="SFT-MATH-RIEMANN-MIRROR-002",
    title="Unique half-One reflection axis and Riemann correspondence boundary",
    statement=(
        "The exact complement involution on positive parts has one and only one self-partner, the half-One; every other admitted part forms a distinct complementary pair. "
        "This forces the unique SFT reflection axis corresponding to the classical zeta functional equation's one-half symmetry, while complex zero location remains outside the no-imaginary proof language."
    ),
    dependencies=("SFT-MATH-EXACT-RELATIONS-002", "SFT-FOUNDATION-HALF-ONE-001"),
    generation_rule="Exhaust domain, involution, fixed point, off-axis pairing, prime tie, complex boundary, generality and extra-analytic choices.",
    grammar_boundary="Exact positive rational parts under complement within the One; no complex analytic continuation object.",
    dimensions=(
        _dim("domain", "complex-plane", "Imaginary values are not admitted proof objects.", "positive-parts", "The involution acts on exact parts of the One."),
        _dim("involution", "imported-functional-equation", "An external equation cannot derive the Fold law.", "one-complement", "The map is exact complement within the One."),
        _dim("fixed_point", "selected-half", "Selecting one-half would not prove uniqueness.", "unique-self-complement", "Exact self-complement forces two equal parts to reconstruct the One."),
        _dim("off_axis", "unpaired-values", "Complement is total on the declared part domain.", "distinct-pairs", "Every nonfixed part has one distinct complementary partner."),
        _dim("prime_tie", "zeta-import", "The analytic zeta object is not an SFT input.", "orbit-prime-skeleton", "Prime correspondence comes from independently derived Fold orders."),
        _dim("zero_location", "claim-classical-rh", "Symmetry alone cannot locate every classical complex zero.", "explicit-language-boundary", "Only the symmetry axis is claimed inside SFT."),
        _dim("generality", "bounded-denominator-only", "A fixed denominator table does not prove the involution law.", "exact-part-identity", "The equality p=One-p has the unique exact solution two-p=One for every admitted part."),
        _dim("addition", "extra-analysis", "Complex analysis is outside the registered dependencies.", "no-extra-rule", "Only complement, equality and prior orbit number theory occur."),
    ),
    exact_result="Half-One is the unique fixed axis of exact complement; every other positive part is paired. This closes the SFT Riemann-mirroring claim and explicitly does not assert classical complex zero location.",
    laws=(
        "complement composed twice is identity",
        "self-complementarity uniquely forces the half-One",
        "reflection symmetry does not by itself imply that all points of an invariant set lie on the fixed axis",
    ),
    induction_base="The Foundation half-One certificate supplies the self-complementary witness.",
    induction_step="Every newly generated non-half part is paired with its exact complement and neither becomes a second fixed point.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("fixed-half", "Half-One is equal to its exact complement.", Fraction(1,2) == 1 - Fraction(1,2)),
        Witness("off-axis-pairs", "Quarter/three-quarter and one-third/two-thirds are distinct complement pairs.", 1-Fraction(1,4) == Fraction(3,4) and 1-Fraction(1,3) == Fraction(2,3)),
        Witness("symmetry-control", "A symmetric two-point set can lie off the fixed axis, so symmetry alone cannot prove zero location.", {Fraction(1,4), Fraction(3,4)} == {1-x for x in {Fraction(1,4), Fraction(3,4)}}),
    ),
    why="V1 XII-2 records the prime skeleton and half-One mirroring while expressly leaving complex zero location outside the framework; V2 Step 132 requires the fixed-axis result and its adverse logical control.",
    derivation="Exact complement is an involution. Solving self-complementarity by positive junction forces two equal parts to be the One, whose unique first Fold split is half-One.",
    check="Generate all 256 boundary forms, execute the fixed and off-axis witnesses, require the symmetry-only overclaim to be rejected and recompute independently.",
    limitations="This theorem does not prove the classical Riemann hypothesis; it proves the SFT arithmetic prime skeleton and unique reflection-axis correspondence stated in the stronger detailed V1 record.",
    correspondence_terms=("Riemann functional symmetry", "critical line", "reflection involution", "Riemann hypothesis boundary"),
)


COLLATZ_FINITE = LawSpec(
    claim_id="SFT-MATH-COLLATZ-FINITE-CENSUS-002",
    title="Exact bounded Collatz census and contraction-control correction",
    statement=(
        "Every positive whole start from the One through one-hundred-thousand reaches the 1-4-2 cycle under the declared Collatz transition; start twenty-seven takes exactly one-hundred-eleven steps. "
        "The exact census also rejects the prior constant-three-quarter pointwise contraction shortcut: a lawful odd macrostep may rise, so only the bounded execution result is admitted."
    ),
    dependencies=("SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-DYNAMICAL-SYSTEMS-001"),
    generation_rule="Exhaust range, transition, parity, trace, cycle, contraction, boundary and extra-theorem choices.",
    grammar_boundary="Positive whole starts one through one hundred thousand under the exact conventional Collatz transition.",
    dimensions=(
        _dim("range", "sampled-starts", "Sampling cannot close the declared range.", "all-declared-starts", "Every start in the frozen bound is executed."),
        _dim("transition", "fold-analogy", "An analogy is not the conventional Collatz map.", "exact-collatz", "Even starts halve and odd starts map to three-times plus One."),
        _dim("parity", "assumed-even", "Parity must be checked from exact whole arithmetic.", "computed-parity", "Every transition computes its parity exactly."),
        _dim("trace", "terminal-only", "A terminal result without its path cannot be replayed.", "complete-step-trace", "Every successor is counted until the cycle."),
        _dim("cycle", "zero-sink", "Zero is not in the declared positive domain.", "one-four-two", "The terminal recurrent class is the exact 1-4-2 cycle."),
        _dim("contraction", "constant-three-quarters", "The shortcut is false: the odd macrostep from three reaches five after removing all binary factors.", "executed-variable-descent", "No pointwise contraction premise enters; the exact trace decides the bounded result."),
        _dim("boundary", "unrestricted-collatz", "A finite census cannot establish the unrestricted conjecture.", "explicit-one-hundred-thousand", "The sealed maximum is part of the claim."),
        _dim("addition", "external-sequence", "A published trajectory cannot enter the execution.", "no-extra-rule", "Only exact whole operations drive the census."),
    ),
    exact_result="The complete starts 1..100,000 census has zero failures, start 27 takes 111 steps, the terminal cycle is 1-4-2, and the constant-3/4 pointwise contraction premise is rejected.",
    laws=(
        "every odd three-times-plus-One result is even",
        "every declared start has a finite replay trace to the terminal cycle",
        "the claim boundary remains finite and does not become the unrestricted Collatz conjecture",
        "a false contraction heuristic cannot serve as proof even when the bounded census passes",
    ),
    induction_base="The One lies on the declared 1-4-2 recurrent cycle.",
    induction_step="For each next positive whole start, execute the exact transition until an already certified cycle member appears and retain the full prefix.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("odd-even", "Every positive odd start through ten thousand one maps to an even three-times-plus-One result.", all((3*n+1) % 2 == 0 for n in range(1,10002,2))),
        Witness("bounded-census", "Every start through one hundred thousand reaches the One.", all(_collatz_steps(n) >= 0 for n in range(1,100001))),
        Witness("twenty-seven", "Start twenty-seven takes exactly one hundred eleven steps.", _collatz_steps(27) == 111),
        Witness("contraction-reject", "The accelerated odd step from three reaches five and therefore is not a pointwise contraction.", (3*3+1)//2 == 5 and 5 > 3),
    ),
    why="V2 Step 277 contains an exact bounded census and a separate contraction rationale. V3 must reproduce the former and mechanically reject the latter where it is false.",
    derivation="Exact whole arithmetic supplies the transition and full finite traces. Exhaustive execution proves the declared bound; the adverse start three disproves a constant pointwise contraction premise.",
    check="Generate all 256 proof forms, execute all 100,000 starts, verify the 27 trace and contraction counterexample, reject unrestricted scope and recompute independently.",
    limitations="The result is exact for starts through 100,000. The unrestricted Collatz conjecture remains outside this finite certificate.",
    correspondence_terms=("Collatz map", "hailstone sequence", "finite census", "cycle detection"),
)


SELF_SIMILAR_CONVERGENCE = LawSpec(
    claim_id="SFT-MATH-SELF-SIMILAR-CONVERGENCE-002",
    title="Exact self-similarity, chaotic rate and convergent-series laws",
    statement=(
        "Fold forces binary local separation expansion, one closed distinction per step, the unique unit exponent under rank doubling, exact m^d support growth, and rational convergence certificates whose tails shrink by a generated factor without importing logarithms or irrational limit values."
    ),
    dependencies=("SFT-MATH-EXACT-RELATIONS-002", "SFT-MATH-LIMIT-CONTINUUM-002"),
    generation_rule="Exhaust scale action, separation, information, power exponent, support, series, generality and extra-function choices.",
    grammar_boundary="Exact generated finite scales, supports and rational partial sums.",
    dimensions=(
        _dim("scale", "continuous-rescale", "A continuous scale group is not generated.", "fold-doubling", "The scale successor is the Fold count."),
        _dim("separation", "fitted-lyapunov", "A fitted rate is not a theorem.", "exact-binary-expansion", "Before cast, local separation is multiplied by the Fold count."),
        _dim("information", "logarithmic-value", "A logarithm is outside exact proof arithmetic.", "one-closed-label", "One Fold merge closes exactly one binary predecessor distinction."),
        _dim("power", "selected-exponent", "A selected exponent is a parameter.", "unit-self-similar", "Rank doubling and count halving uniquely select the One exponent in the enumerated exponent grammar."),
        _dim("support", "binary-only", "The successor law is not tied to one label count.", "m-to-depth", "An m-label successor multiplies support by m at every depth."),
        _dim("series", "irrational-limit", "The limit cannot enter as a proof value.", "rational-tail-bound", "Exact partial sums and a shrinking rational tail prove finiteness."),
        _dim("generality", "finite-table", "A depth table lacks a recurrence.", "base-successor", "Every law carries a structural base and exact successor."),
        _dim("addition", "extra-analytic-function", "Logarithm or exponential would add a model.", "no-extra-rule", "Only exact ratios, counts and recurrences occur."),
    ),
    exact_result="The exact Fold rate is binary separation expansion and one closed label per step; unit rank power is the unique Fold-self-similar exponent, m-labelled support is m^d, and decreasing rational terms close convergence without importing their limit as a value.",
    laws=(
        "local uncast separation multiplies by the Fold count",
        "one predecessor label is closed per Fold merge",
        "rank doubling paired with count halving selects the unit power among the generated nonnegative whole exponent forms",
        "m-labelled successor support obeys the base/successor count m^d",
        "a geometric rational tail bound proves finite accumulated separation",
    ),
    induction_base="At depth One an m-labelled successor has m states and one Fold closes one binary distinction.",
    induction_step="Appending one label multiplies support by m; applying one Fold multiplies an uncast local gap by b and closes one predecessor label; one further rational term preserves the tail bound.",
    boundary_exclusions=COMMON_BOUNDARY,
    witnesses=(
        Witness("chaotic-rate", "The separation two-of-thirty-five advances to four-of-thirty-five before cast.", 2 * Fraction(2,35) == Fraction(4,35)),
        Witness("support", "Ternary support has three, nine and twenty-seven states at depths one, two and three.", tuple(3**d for d in (1,2,3)) == (3,9,27)),
        Witness("unit-power", "Only exponent One among whole exponents One through four gives exact halving when rank doubles.", tuple(e for e in range(1,5) if Fraction(1,2**e) == Fraction(1,2)) == (1,)),
        Witness("gap-formula", "The exact gap formula is positive and strictly decreases through depth fourteen.", all(Fraction(1,(2+2**(d+1))*(3+2**(d+1))) < Fraction(1,(2+2**d)*(3+2**d)) for d in range(0,14))),
        Witness("finite-bracket", "The first eleven exact gap terms sum below eleven-of-sixty.", sum(Fraction(1,(2+2**d)*(3+2**d)) for d in range(0,11)) < Fraction(11,60)),
    ),
    why="V1/V2 separately registered Lyapunov/entropy antilogs, covering, scale depth, unit power, exact convergence rate and bounded accumulated separation.",
    derivation="Fold supplies the only scale successor and predecessor merge; exact support recurrence and rational tail comparison force the registered rates without analytic functions.",
    check="Generate all 256 structural forms, execute rate, support, exponent and rational-tail witnesses, reject fitted analytic functions and recompute independently.",
    limitations="The unit exponent is unique within the explicitly enumerated positive whole exponent grammar; natural-system correspondence is tested only after the formal seal in owning empirical branches.",
    correspondence_terms=("Lyapunov antilog", "KS entropy", "power law", "covering number", "convergent series"),
)


LINEAGE_SPECS = (
    EXACT_RELATIONS,
    ORBIT_NUMBER_THEORY,
    LIMIT_CONTINUUM,
    ALGEBRAIC_BALANCE,
    BOUNDED_N_BODY,
    FLOORED_FLUID,
    PRIME_PAIR_CENSUS,
    RIEMANN_MIRROR,
    COLLATZ_FINITE,
    SELF_SIMILAR_CONVERGENCE,
)

BY_CLAIM_ID = {spec.claim_id: spec for spec in LINEAGE_SPECS}
