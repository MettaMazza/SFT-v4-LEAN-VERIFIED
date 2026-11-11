import SFT.Materials.MicrostructureRetention
namespace SFT.Materials.MicrostructureBinding
open Microstructure

def supportBound (record : Record) (support : List String) : Prop :=
 ∀ cell∈support, cell∈record.network.graph.nodes

def rowBound (record : Record) : Extension → Prop
 | .phase row => supportBound record row.2
 | .grain row => supportBound record row.2
 | .interface row => row.2.1∈record.network.graph.nodes ∧ row.2.2∈record.network.graph.nodes
 | .defect row => supportBound record row.2

def admitted (record : Record) : Prop :=
 (∀ row∈record.phases, rowBound record (.phase row)) ∧
 (∀ row∈record.grains, rowBound record (.grain row)) ∧
 (∀ row∈record.interfaces, rowBound record (.interface row)) ∧
 (∀ row∈record.defects, rowBound record (.defect row))

theorem boundRetained (record : Record) (extension row : Extension) :
 rowBound (extend record extension) row ↔ rowBound record row := by
 cases extension <;> cases row <;> exact Iff.rfl

theorem extensionAdmitted (record : Record) (extension : Extension)
 (prior : admitted record) (bound : rowBound record extension) : admitted (extend record extension) := by
 obtain ⟨hp,hg,hi,hd⟩:=prior
 cases extension with
 | phase added =>
   refine ⟨?_,?_,?_,?_⟩
   · intro row held
     change row∈record.phases++[added] at held
     cases SFT.Foundation.Count.TraceDerivation.memAppendCases row record.phases [added] held with
     | inl old => exact hp row old
     | inr new =>
       cases new with
       | head => exact bound
       | tail _ impossible => cases impossible
   · intro row held
     exact hg row held
   · intro row held
     exact hi row held
   · intro row held
     exact hd row held
 | grain added =>
   refine ⟨?_,?_,?_,?_⟩
   · intro row held
     exact hp row held
   · intro row held
     change row∈record.grains++[added] at held
     cases SFT.Foundation.Count.TraceDerivation.memAppendCases row record.grains [added] held with
     | inl old => exact hg row old
     | inr new =>
       cases new with
       | head => exact bound
       | tail _ impossible => cases impossible
   · intro row held
     exact hi row held
   · intro row held
     exact hd row held
 | interface added =>
   refine ⟨?_,?_,?_,?_⟩
   · intro row held
     exact hp row held
   · intro row held
     exact hg row held
   · intro row held
     change row∈record.interfaces++[added] at held
     cases SFT.Foundation.Count.TraceDerivation.memAppendCases row record.interfaces [added] held with
     | inl old => exact hi row old
     | inr new =>
       cases new with
       | head => exact bound
       | tail _ impossible => cases impossible
   · intro row held
     exact hd row held
 | defect added =>
   refine ⟨?_,?_,?_,?_⟩
   · intro row held
     exact hp row held
   · intro row held
     exact hg row held
   · intro row held
     exact hi row held
   · intro row held
     change row∈record.defects++[added] at held
     cases SFT.Foundation.Count.TraceDerivation.memAppendCases row record.defects [added] held with
     | inl old => exact hd row old
     | inr new =>
       cases new with
       | head => exact bound
       | tail _ impossible => cases impossible

theorem newRowMustBeBound (record : Record) (extension : Extension)
 (accepted : admitted (extend record extension)) : rowBound record extension := by
 cases extension with
 | phase row => exact accepted.1 row (List.mem_append_right _ (.head _))
 | grain row => exact accepted.2.1 row (List.mem_append_right _ (.head _))
 | interface row => exact accepted.2.2.1 row (List.mem_append_right _ (.head _))
 | defect row => exact accepted.2.2.2 row (List.mem_append_right _ (.head _))

theorem unboundRowRejected (record : Record) (extension : Extension)
 (unbound : ¬ rowBound record extension) : ¬ admitted (extend record extension) :=
 fun accepted => unbound (newRowMustBeBound record extension accepted)

inductive History : Record → Record → Prop where
 | base (record : Record) : History record record
 | next {start prior : Record} (history : History start prior) (extension : Extension)
   (bound : rowBound prior extension) : History start (extend prior extension)

theorem everyFiniteBoundExtension {start finish : Record} (history : History start finish)
 (initial : admitted start) : admitted finish := by
 induction history with
 | base => exact initial
 | next history extension bound ih => exact extensionAdmitted _ extension ih bound


theorem initialAdmitted (scale lower upper : String) :
 admitted (MicrostructureRetention.initial scale lower upper) := by
 refine ⟨?_,?_,?_,?_⟩
 · intro row held
   cases held with
   | head =>
     intro cell member
     cases member with
     | head => exact .head _
     | tail _ h => cases h
   | tail _ h => cases h
 · intro row held
   cases held with
   | head =>
     intro cell member
     cases member with
     | head => exact .head _
     | tail _ h => cases h
   | tail _ h => cases h
 · intro row held; cases held
 · intro row held; cases held

end SFT.Materials.MicrostructureBinding
