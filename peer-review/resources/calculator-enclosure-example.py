#!/usr/bin/env python3
"""Reproduce the rational arithmetic in the SFT calculator reading guide.

Maria Smith, scientific author. Educational script prepared with AI assistance.
Paper 35, version 1.1: https://doi.org/10.5281/zenodo.24354302
Source: SFT.Mathematics.CalculatorOperationsV2.atanUnitEnclosureV2
V4 commit: 21cdf559922fb057f8560f42d056ffa035329eb3

This is a separate arithmetic illustration, not the Lean implementation,
a proof of the remainder bound, or a whole-calculator verification run.
Read Sections 3–5 and the versioned source archive for those arguments.

Run with Python 3 (standard library only):
    python3 calculator-enclosure-example.py --x 1/5 --terms 1
    python3 calculator-enclosure-example.py --x 1/5 --terms 2
    python3 calculator-enclosure-example.py --machin --terms 8
Fractions and decimal strings are parsed exactly; no binary floats are used.
"""

import argparse
from fractions import Fraction


def endpoints(x, terms):
    """Evaluate the published partial sum, next term and endpoint branch."""
    if not 0 < x <= 1:
        raise ValueError("x must satisfy 0 < x <= 1")
    if terms < 1:
        raise ValueError("terms must be positive")
    positive = Fraction(0)
    counter = Fraction(0)
    for j in range(terms):
        term = x ** (2 * j + 1) / (2 * j + 1)
        if j % 2:
            counter += term
        else:
            positive += term
    partial = positive - counter
    next_term = x ** (2 * terms + 1) / (2 * terms + 1)
    lower, upper = ((partial - next_term, partial) if terms % 2
                    else (partial, partial + next_term))
    return partial, next_term, lower, upper


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--x", default="1/5", help="exact fraction or decimal string")
    parser.add_argument("--terms", type=int, default=2)
    parser.add_argument("--machin", action="store_true",
                        help="combine atan(1/5) and atan(1/239) bounds for pi; --x is unused")
    args = parser.parse_args()
    try:
        if args.machin:
            _, q5, a, b = endpoints(Fraction(1, 5), args.terms)
            _, q239, c, d = endpoints(Fraction(1, 239), args.terms)
            lower, upper = 16 * a - 4 * d, 16 * b - 4 * c
            print(f"N = {args.terms} for each arctangent")
            print(f"atan(1/5) endpoints = [{a}, {b}]")
            print(f"atan(1/239) endpoints = [{c}, {d}]")
            print("pi endpoints = [16*a - 4*d, 16*b - 4*c]")
            print(f"rational endpoints = [{lower}, {upper}]")
            print(f"width = {upper - lower}")
            print(f"width from next terms = {16 * q5 + 4 * q239}")
            print("Arithmetic illustration only; see paper Section 5 for the argument.")
            return
        x = Fraction(args.x)
        partial, next_term, lower, upper = endpoints(x, args.terms)
    except (ValueError, ZeroDivisionError) as error:
        parser.error(str(error))
    print(f"x = {x}; N = {args.terms}")
    print(f"partial sum = {partial}")
    print(f"next-term magnitude = {next_term}")
    print(f"branch = {'odd: subtract next term' if args.terms % 2 else 'even: add next term'}")
    print(f"rational endpoints = [{lower}, {upper}]")
    print(f"width = {upper - lower}")
    print("Arithmetic illustration only; see the paper for the enclosure proof.")


if __name__ == "__main__":
    main()
