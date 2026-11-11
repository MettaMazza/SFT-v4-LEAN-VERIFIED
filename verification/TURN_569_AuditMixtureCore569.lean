import SFT.Chemistry.ExactComposition
namespace SFT.Chemistry.MixtureSupport
open ExactComposition SFT.Mathematics.GeometryTopology

def multiple : List Component → Bool
 | [] => false
 | _::rest => match rest with
   | [] => false
   | _::_ => true

structure Record where
 composition : ExactComposition.Record
 phaseSupport : SFT.Host.Canonical.Value

instance (components : List Component) : Decidable (closed components) :=
 inferInstanceAs (Decidable ((total components).1 = (total components).2))

def admitted (record : Record) : Bool :=
 multiple record.composition.components && distinct record.composition.components &&
 decide (closed record.composition.components)

theorem multipleExactly (components : List Component) : multiple components = true ↔
 ∃ first second rest, components = first::second::rest := by
 cases components with
 | nil => constructor
          · intro h; cases h
          · intro ⟨first,second,rest,h⟩; cases h
 | cons first rest =>
   cases rest with
   | nil => constructor
            · intro h; cases h
            · intro ⟨a,b,rest,h⟩; cases h
   | cons second rest => exact ⟨fun _ => ⟨first,second,rest,rfl⟩,fun _ => rfl⟩

theorem admittedExactly (record : Record) : admitted record = true ↔
 multiple record.composition.components = true ∧ distinct record.composition.components = true ∧ closed record.composition.components := by
 constructor
 · intro h
   have all := (andTrue _ _).mp h
   have first := (andTrue _ _).mp all.1
   exact ⟨first.1,first.2,of_decide_eq_true all.2⟩
 · intro h
   exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,decide_eq_true h.2.2⟩

theorem emptyRejected (boundary phase : SFT.Host.Canonical.Value) (history : List (List Component)) :
 admitted ⟨⟨[],boundary,history⟩,phase⟩ = false := rfl

theorem singleRejected (component : Component) (boundary phase : SFT.Host.Canonical.Value) (history : List (List Component)) :
 admitted ⟨⟨[component],boundary,history⟩,phase⟩ = false := rfl

def initial (first second : Component) (boundary phase : SFT.Host.Canonical.Value) : Record :=
 ⟨⟨[first,second],boundary,[]⟩,phase⟩

theorem initialAdmitted (first second : Component) (boundary phase : SFT.Host.Canonical.Value)
 (identities : distinct [first,second] = true) (partition : closed [first,second]) :
 admitted (initial first second boundary phase) = true :=
 (admittedExactly _).mpr ⟨rfl,identities,partition⟩

theorem phaseNotForced (record : Record) (phase : SFT.Host.Canonical.Value) :
 admitted {record with phaseSupport := phase} = admitted record := rfl

theorem exactCompositionRetained (record : Record) (valid : admitted record = true) :
 exactComposition record.composition.components = .ok record.composition.components := by
 have h := (admittedExactly _).mp valid
 obtain ⟨first,second,rest,equal⟩ := (multipleExactly _).mp h.1
 have nonempty : record.composition.components.isEmpty = false := by rw [equal]; rfl
 exact (exactClosure _ nonempty h.2.1).mpr h.2.2

def refine (record : Record) (components : List Component) : Record :=
 {record with composition := refineRecord record.composition components}

theorem boundaryRetained (record : Record) (components : List Component) :
 (refine record components).composition.sourceBoundary = record.composition.sourceBoundary ∧
 (refine record components).phaseSupport = record.phaseSupport := ⟨rfl,rfl⟩

theorem priorIdentitiesRetained (record : Record) (components : List Component) :
 record.composition.components ∈ (refine record components).composition.sourceHistory := parentIdentitiesRetained _ _

theorem samePartDistinctIdentity (first second : Component) (samePart : first.part=second.part)
 (different : first.identity ≠ second.identity) : first ≠ second := equalPartsDoNotEraseIdentity first second samePart different

theorem multipleAfterSplit (before tail : List Component) (first second : Component) :
 multiple (before++first::second::tail)=true := by
 cases before with
 | nil => rfl
 | cons head rest => cases rest <;> rfl

theorem splitAdmitted (record : Record) (before tail : List Component) (parent first second : Component)
 (prior : record.composition.components = before++parent::tail)
 (valid : admitted record=true)
 (split : (first.part.numerator*second.part.denominator+second.part.numerator*first.part.denominator)*parent.part.denominator =
 parent.part.numerator*(first.part.denominator*second.part.denominator))
 (identities : distinct (before++first::second::tail)=true) :
 admitted (refine record (before++first::second::tail))=true := by
 have old := ((admittedExactly record).mp valid).2.2
 rw [prior] at old
 exact (admittedExactly _).mpr ⟨multipleAfterSplit _ _ _ _,identities,refinementCloses _ _ _ _ _ split old⟩

inductive History : Record → Record → Prop where
 | base (record : Record) (valid : admitted record=true) : History record record
 | step {start prior : Record} (history : History start prior) (components : List Component)
   (valid : admitted (refine prior components)=true) : History start (refine prior components)

theorem allFiniteAdmitted {start finish : Record} (history : History start finish) : admitted finish=true := by
 cases history with
 | base valid => exact valid
 | step history components valid => exact valid

theorem allFiniteBoundary {start finish : Record} (history : History start finish) :
 finish.composition.sourceBoundary=start.composition.sourceBoundary ∧ finish.phaseSupport=start.phaseSupport := by
 induction history with
 | base => exact ⟨rfl,rfl⟩
 | step history components valid ih => exact ih
end SFT.Chemistry.MixtureSupport

#print axioms SFT.Chemistry.MixtureSupport.multiple
#print axioms SFT.Chemistry.MixtureSupport.admitted
#print axioms SFT.Chemistry.MixtureSupport.multipleExactly
#print axioms SFT.Chemistry.MixtureSupport.admittedExactly
#print axioms SFT.Chemistry.MixtureSupport.emptyRejected
#print axioms SFT.Chemistry.MixtureSupport.singleRejected
#print axioms SFT.Chemistry.MixtureSupport.initial
#print axioms SFT.Chemistry.MixtureSupport.initialAdmitted
#print axioms SFT.Chemistry.MixtureSupport.phaseNotForced
#print axioms SFT.Chemistry.MixtureSupport.exactCompositionRetained
#print axioms SFT.Chemistry.MixtureSupport.refine
#print axioms SFT.Chemistry.MixtureSupport.boundaryRetained
#print axioms SFT.Chemistry.MixtureSupport.priorIdentitiesRetained
#print axioms SFT.Chemistry.MixtureSupport.samePartDistinctIdentity
#print axioms SFT.Chemistry.MixtureSupport.multipleAfterSplit
#print axioms SFT.Chemistry.MixtureSupport.splitAdmitted
#print axioms SFT.Chemistry.MixtureSupport.allFiniteAdmitted
#print axioms SFT.Chemistry.MixtureSupport.allFiniteBoundary
