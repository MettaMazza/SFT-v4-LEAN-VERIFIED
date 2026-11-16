import SFT.Physics.SpinStatisticsCondensation
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.SpinStatisticsCondensationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Exchange where
  | rejected | admitted

def exchangeName : Exchange → String
  | .rejected => "named-particle-species"
  | .admitted => "preserving-versus-alternating-held-trace"

inductive Fermion where
  | rejected | admitted

def fermionName : Fermion → String
  | .rejected => "selected-occupancy-cap"
  | .admitted => "one-cell-distinction-exclusion"

inductive Boson where
  | rejected | admitted

def bosonName : Boson → String
  | .rejected => "finite-selected-ceiling"
  | .admitted => "every-positive-finite-multiplicity-admitted"

inductive Weights where
  | rejected | admitted

def weightsName : Weights → String
  | .rejected => "continuum-statistical-distribution"
  | .admitted => "complete-exact-dyadic-occupation-census"

inductive Spin where
  | rejected | admitted

def spinName : Spin → String
  | .rejected => "imaginary-signed-phase"
  | .admitted => "typed-one-turn-two-turn-held-orbits"

inductive Pairing where
  | rejected | admitted

def pairingName : Pairing → String
  | .rejected => "independent-boson-postulate"
  | .admitted => "alternating-pair-preserves-exchange"

inductive Lock where
  | rejected | admitted

def lockName : Lock → String
  | .rejected => "measured-or-fitted-temperature"
  | .admitted => "first-exact-crossing-of-forced-m-minus-one-over-m-share"

inductive Ground where
  | rejected | admitted

def groundName : Ground → String
  | .rejected => "asserted-macroscopic-ground-mode"
  | .admitted => "unique-minimum-throw-shared-ground-word"

structure Candidate where
  exchange : Exchange
  fermion : Fermion
  boson : Boson
  weights : Weights
  spin : Spin
  pairing : Pairing
  lock : Lock
  ground : Ground

def sourceFields (c : Candidate) : List String := [exchangeName c.exchange, fermionName c.fermion, bosonName c.boson, weightsName c.weights, spinName c.spin, pairingName c.pairing, lockName c.lock, groundName c.ground]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "exchange=" (exchangeName c.exchange), SFT.Host.Text.append "fermion=" (fermionName c.fermion), SFT.Host.Text.append "boson=" (bosonName c.boson), SFT.Host.Text.append "weights=" (weightsName c.weights), SFT.Host.Text.append "spin=" (spinName c.spin), SFT.Host.Text.append "pairing=" (pairingName c.pairing), SFT.Host.Text.append "lock=" (lockName c.lock), SFT.Host.Text.append "ground=" (groundName c.ground)]
def survivorId : String := "preserving-versus-alternating-held-trace__one-cell-distinction-exclusion__every-positive-finite-multiplicity-admitted__complete-exact-dyadic-occupation-census__typed-one-turn-two-turn-held-orbits__alternating-pair-preserves-exchange__first-exact-crossing-of-forced-m-minus-one-over-m-share__unique-minimum-throw-shared-ground-word"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (exchangeName c.exchange) "preserving-versus-alternating-held-trace" &&
  SFT.Host.Text.equal (fermionName c.fermion) "one-cell-distinction-exclusion" &&
  SFT.Host.Text.equal (bosonName c.boson) "every-positive-finite-multiplicity-admitted" &&
  SFT.Host.Text.equal (weightsName c.weights) "complete-exact-dyadic-occupation-census" &&
  SFT.Host.Text.equal (spinName c.spin) "typed-one-turn-two-turn-held-orbits" &&
  SFT.Host.Text.equal (pairingName c.pairing) "alternating-pair-preserves-exchange" &&
  SFT.Host.Text.equal (lockName c.lock) "first-exact-crossing-of-forced-m-minus-one-over-m-share" &&
  SFT.Host.Text.equal (groundName c.ground) "unique-minimum-throw-shared-ground-word"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (exchangeName c.exchange) "preserving-versus-alternating-held-trace") then "A species name does not force its exchange law." else
  if !(SFT.Host.Text.equal (fermionName c.fermion) "one-cell-distinction-exclusion") then "A selected cap is a free rule." else
  if !(SFT.Host.Text.equal (bosonName c.boson) "every-positive-finite-multiplicity-admitted") then "No generated ceiling follows from preserving exchange." else
  if !(SFT.Host.Text.equal (weightsName c.weights) "complete-exact-dyadic-occupation-census") then "A continuum distribution is outside Fold arithmetic." else
  if !(SFT.Host.Text.equal (spinName c.spin) "typed-one-turn-two-turn-held-orbits") then "Imaginary or signed proof scalars are inadmissible." else
  if !(SFT.Host.Text.equal (pairingName c.pairing) "alternating-pair-preserves-exchange") then "An independent postulate breaks the single derivation chain." else
  if !(SFT.Host.Text.equal (lockName c.lock) "first-exact-crossing-of-forced-m-minus-one-over-m-share") then "A measured or fitted onset would select the law." else
  if !(SFT.Host.Text.equal (groundName c.ground) "unique-minimum-throw-shared-ground-word") then "Naming a condensate is not an enumeration." else
  "For positive finite N and L, preserving exchange has exactly C(N+L-1,N) occupation words and admits N occupants in one cell for every N; alternating exchange has exactly C(L,N) words for N<=L, an empty support for N>L, and never exceeds one occupant per cell. Every finite canonical occupation weight is exact rational and sums to One. The two-label spin census is 3/4 preserving and 1/4 alternating; alternating spin first returns after two turns, while a pair is preserving and returns after one. For every N,L and m>=2, the ground-orbit share crosses (m-1)/m at a uniquely first finite cold depth, fixing an exact rational critical mean throw; the unique minimum-throw preserving word places all N occupants in the shared ground orbit."

def generationRule : String := "Generate the complete product of exchange, exclusion, accumulation, occupation-weight, spin-return, pairing, lock-threshold and ground-orbit forms."
def grammarBoundary : String := "Every positive finite particle count N, positive finite level count L, preserving or alternating exchange class, positive finite cold depth, and Fold factor m at least two; empty cells are typed structural-absence records."

def candidates : List Candidate :=
  ([Exchange.rejected,Exchange.admitted]).flatMap fun exchange =>
  ([Fermion.rejected,Fermion.admitted]).flatMap fun fermion =>
  ([Boson.rejected,Boson.admitted]).flatMap fun boson =>
  ([Weights.rejected,Weights.admitted]).flatMap fun weights =>
  ([Spin.rejected,Spin.admitted]).flatMap fun spin =>
  ([Pairing.rejected,Pairing.admitted]).flatMap fun pairing =>
  ([Lock.rejected,Lock.admitted]).flatMap fun lock =>
  ([Ground.rejected,Ground.admitted]).map fun ground =>
  ⟨exchange,fermion,boson,weights,spin,pairing,lock,ground⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk exchange fermion boson weights spin pairing lock ground =>
    have hexchange : exchange ∈ [Exchange.rejected,Exchange.admitted] := by
      cases exchange <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfermion : fermion ∈ [Fermion.rejected,Fermion.admitted] := by
      cases fermion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboson : boson ∈ [Boson.rejected,Boson.admitted] := by
      cases boson <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hweights : weights ∈ [Weights.rejected,Weights.admitted] := by
      cases weights <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspin : spin ∈ [Spin.rejected,Spin.admitted] := by
      cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpairing : pairing ∈ [Pairing.rejected,Pairing.admitted] := by
      cases pairing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlock : lock ∈ [Lock.rejected,Lock.admitted] := by
      cases lock <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hground : ground ∈ [Ground.rejected,Ground.admitted] := by
      cases ground <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ exchange _ hexchange
    apply CommonRefinement.memFlatMap _ _ fermion _ hfermion
    apply CommonRefinement.memFlatMap _ _ boson _ hboson
    apply CommonRefinement.memFlatMap _ _ weights _ hweights
    apply CommonRefinement.memFlatMap _ _ spin _ hspin
    apply CommonRefinement.memFlatMap _ _ pairing _ hpairing
    apply CommonRefinement.memFlatMap _ _ lock _ hlock
    exact Count.TraceDerivation.memMap _ ground _ hground

end SFT.Physics.SpinStatisticsCondensationGrammar
