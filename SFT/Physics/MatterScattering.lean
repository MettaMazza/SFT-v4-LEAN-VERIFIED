import SFT.Physics.MatterHadrons
namespace SFT.Physics.MatterScattering
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

structure Channel where
  incoming : List MatterAntiparticle.Constituent
  outgoing : List MatterAntiparticle.Constituent
  preparation : SFT.Host.Canonical.Value
  detector : SFT.Host.Canonical.Value
  sourceIdentity : String
  successful : Bool

def successes : List Channel → List Channel
  | [] => []
  | c::rest => match c.successful with
    | false => successes rest
    | true => c::successes rest

theorem successExactly (channels : List Channel) (c : Channel) :
    c ∈ successes channels ↔ c ∈ channels ∧ c.successful = true := by
  induction channels with
  | nil => constructor
           · intro h; cases h
           · intro h; cases h.1
  | cons a rest ih =>
    cases h : a.successful <;> simp only [successes,h]
    · constructor
      · intro hc; have z := ih.mp hc; exact ⟨.tail _ z.1,z.2⟩
      · intro hc; cases hc.1 with
        | head => exact Bool.noConfusion (h.symm.trans hc.2)
        | tail _ hm => exact ih.mpr ⟨hm,hc.2⟩
    · constructor
      · intro hc; cases hc with
        | head => exact ⟨.head _,h⟩
        | tail _ hm => have z := ih.mp hm; exact ⟨.tail _ z.1,z.2⟩
      · intro hc; cases hc.1 with
        | head => exact .head _
        | tail _ hm => exact .tail _ (ih.mpr ⟨hm,hc.2⟩)

theorem successfulCountBounded (channels : List Channel) : (successes channels).length ≤ channels.length := by
  induction channels with
  | nil => exact Nat.le_refl _
  | cons a rest ih =>
    cases h : a.successful <;> simp only [successes,h,List.length_cons]
    · exact Nat.le_trans ih (Nat.le_succ _)
    · exact Nat.succ_le_succ ih

structure Observation where
  channels : List Channel
  observed : 0 < (successes channels).length
  geometry : PositiveFraction
  geometryRecord : SFT.Host.Canonical.Value

theorem incidentPositive (o : Observation) : 0 < o.channels.length :=
  Nat.lt_of_lt_of_le o.observed (successfulCountBounded o.channels)

def supportRatio (o : Observation) := ratio (successes o.channels).length o.channels.length o.observed (incidentPositive o)

def crossSection (o : Observation) := compose (supportRatio o) o.geometry

theorem exactSupportRatio (o : Observation) :
    (successes o.channels).length * (supportRatio o).denominator = (supportRatio o).numerator * o.channels.length :=
  ratioValue _ _ _ _

theorem exactCrossSection (o : Observation) :
    ((successes o.channels).length * o.geometry.numerator) * (crossSection o).denominator =
      (crossSection o).numerator * (o.channels.length * o.geometry.denominator) :=
  composeRepresents _ _ _ _ _ _ (exactSupportRatio o) rfl

theorem onlyExactCrossSection (o : Observation) (candidate : PositiveFraction)
    (equation : ((successes o.channels).length * o.geometry.numerator) * candidate.denominator =
      candidate.numerator * (o.channels.length * o.geometry.denominator)) : candidate = crossSection o := by
  have hn := Nat.mul_pos o.observed o.geometry.positive
  have hd := Nat.mul_pos (incidentPositive o) (Nat.pos_of_ne_zero o.geometry.denominatorNonzero)
  exact (FieldGeometricDilution.positiveNormalizationRepresents _ _ hn hd candidate equation).symm.trans
    (FieldGeometricDilution.positiveNormalizationRepresents _ _ hn hd (crossSection o) (exactCrossSection o))

def completeMap (o : Observation) := o.channels.map (fun c => (c.incoming,c.outgoing,c.preparation,c.detector,c.sourceIdentity))

theorem everyChannelRetained (o : Observation) (c : Channel) (held : c ∈ o.channels) :
    (c.incoming,c.outgoing,c.preparation,c.detector,c.sourceIdentity) ∈ completeMap o :=
  SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem completeMapCount (o : Observation) : (completeMap o).length = o.channels.length :=
  SFT.Foundation.CommonRefinement.mapLength _ _

theorem geometryRecordDoesNotSelectMeasure (o : Observation) (record : SFT.Host.Canonical.Value) :
    crossSection {o with geometryRecord := record} = crossSection o := rfl
end SFT.Physics.MatterScattering
