import SFT.Mathematics.ExactRatioRelations
namespace SFT.Physics.ReferenceTransport
open SFT.Foundation.ExactOperations
open SFT.Mathematics.ExactRatioRelations
-- Source: measurement_laws.py UNIT_COMPARISON and DIMENSIONAL_CONSISTENCY.
-- Form denotes the held canonical dimension form, not a numerical magnitude.
-- This component proves transport on admitted references; dimension generation
-- and the full entry grammar/validation are separate source obligations.
structure Reference (Form : Type) where
  name : String
  dimension : Form

structure Comparison {Form : Type} (quantity reference : Reference Form) where
  sameDimension : quantity.dimension = reference.dimension
  ratio : PositiveFraction

def reverse {Form : Type} {a b : Reference Form}
    (ab : Comparison a b) : Comparison b a :=
  ⟨ab.sameDimension.symm,reciprocal ab.ratio⟩

def chain {Form : Type} {a b c : Reference Form}
    (ab : Comparison a b) (bc : Comparison b c) : Comparison a c :=
  ⟨ab.sameDimension.trans bc.sameDimension,compose ab.ratio bc.ratio⟩

theorem retainsDimension {Form : Type} {a b : Reference Form}
    (ab : Comparison a b) : a.dimension = b.dimension := ab.sameDimension

theorem differentDimensionExcluded {Form : Type} {a b : Reference Form}
    (different : a.dimension ≠ b.dimension) : Comparison a b → False :=
  fun ab => different ab.sameDimension

theorem ratioPositive {Form : Type} {a b : Reference Form}
    (ab : Comparison a b) : 0 < ab.ratio.numerator := ab.ratio.positive

theorem reverseDimension {Form : Type} {a b : Reference Form}
    (ab : Comparison a b) : b.dimension = a.dimension :=
  (reverse ab).sameDimension

theorem reverseValue {Form : Type} {a b : Reference Form}
    (ab : Comparison a b) :
    ab.ratio.denominator * (reverse ab).ratio.denominator =
      (reverse ab).ratio.numerator * ab.ratio.numerator :=
  reciprocalValue ab.ratio

theorem chainDimension {Form : Type} {a b c : Reference Form}
    (ab : Comparison a b) (bc : Comparison b c) :
    a.dimension = c.dimension := (chain ab bc).sameDimension

theorem chainValue {Form : Type} {a b c : Reference Form}
    (ab : Comparison a b) (bc : Comparison b c) :
    (ab.ratio.numerator * bc.ratio.numerator) * (chain ab bc).ratio.denominator =
      (chain ab bc).ratio.numerator * (ab.ratio.denominator * bc.ratio.denominator) :=
  composeValue ab.ratio bc.ratio

theorem reverseReturnsOne {Form : Type} {a b : Reference Form}
    (ab : Comparison a b) :
    (chain ab (reverse ab)).ratio.numerator = 1 ∧
    (chain ab (reverse ab)).ratio.denominator = 1 :=
  reciprocalReturnsOne ab.ratio

def exactView {Form : Type} {a b : Reference Form}
    (same : a.dimension = b.dimension)
    (n d : Nat) (hn : 0 < n) (hd : 0 < d) : Comparison a b :=
  ⟨same,ratio n d hn hd⟩

theorem chainedViewsTelescope {Form : Type} {a b c : Reference Form}
    (hab : a.dimension = b.dimension) (hbc : b.dimension = c.dimension)
    (n m k : Nat) (hn : 0 < n) (hm : 0 < m) (hk : 0 < k) :
    (chain (exactView hab n m hn hm) (exactView hbc m k hm hk)).ratio.numerator * k =
    n * (chain (exactView hab n m hn hm) (exactView hbc m k hm hk)).ratio.denominator :=
  telescopeNormalized n m k hn hm hk

inductive Chain {Form : Type} : Reference Form → Reference Form → Type
  | one {a b} : Comparison a b → Chain a b
  | append {a b c} : Chain a b → Comparison b c → Chain a c

def collapse {Form : Type} {a b : Reference Form} : Chain a b → Comparison a b
  | .one ab => ab
  | .append path bc => chain (collapse path) bc

theorem everyFiniteChainPreservesDimension {Form : Type} {a b : Reference Form}
    (path : Chain a b) : a.dimension = b.dimension :=
  (collapse path).sameDimension

theorem everyFiniteChainPositive {Form : Type} {a b : Reference Form}
    (path : Chain a b) : 0 < (collapse path).ratio.numerator :=
  (collapse path).ratio.positive

theorem singletonCollapse {Form : Type} {a b : Reference Form}
    (ab : Comparison a b) : collapse (.one ab) = ab := rfl

theorem successorCollapse {Form : Type} {a b c : Reference Form}
    (path : Chain a b) (bc : Comparison b c) :
    collapse (.append path bc) = chain (collapse path) bc := rfl
end SFT.Physics.ReferenceTransport
