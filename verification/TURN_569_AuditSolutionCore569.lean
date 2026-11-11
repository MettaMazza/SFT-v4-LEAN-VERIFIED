import SFT.Chemistry.MixtureSupport
namespace SFT.Chemistry.SolutionSupport
open ExactComposition SFT.Mathematics.GeometryTopology
inductive Role where
 | solvent | solute
 deriving DecidableEq
structure Row where
 component : Component
 phase : String
 role : Role
structure Record where
 rows : List Row
 phase : String
 kind : String
 context : SFT.Host.Canonical.Value
 boundary : SFT.Host.Canonical.Value
 history : List (List Row)

def components (rows : List Row) := rows.map Row.component
def mixture (record : Record) : MixtureSupport.Record :=
 ⟨⟨components record.rows,record.boundary,[]⟩,.text record.phase⟩
def phaseAllowed (kind : String) : Bool := decide (kind="liquid") || decide (kind="solid")
def singlePhase (record : Record) : Bool := record.rows.all (fun row => decide (row.phase=record.phase))
def hasRole (role : Role) (rows : List Row) : Bool := rows.any (fun row => decide (row.role=role))
def admitted (record : Record) : Bool :=
 MixtureSupport.admitted (mixture record) && phaseAllowed record.kind && singlePhase record &&
 hasRole .solvent record.rows && hasRole .solute record.rows

theorem phaseAllowedExactly (kind : String) : phaseAllowed kind=true ↔ kind="liquid" ∨ kind="solid" := by
 constructor
 · intro h
   cases a : decide (kind="liquid") with
   | true => exact Or.inl (of_decide_eq_true a)
   | false =>
     unfold phaseAllowed at h
     rw [a] at h
     exact Or.inr (of_decide_eq_true h)
 · intro h
   unfold phaseAllowed
   cases h with
   | inl h => rw [decide_eq_true h]; rfl
   | inr h => rw [decide_eq_true h]; cases decide (kind="liquid") <;> rfl

theorem admittedExactly (record : Record) : admitted record=true ↔
 MixtureSupport.admitted (mixture record)=true ∧ phaseAllowed record.kind=true ∧ singlePhase record=true ∧
 hasRole .solvent record.rows=true ∧ hasRole .solute record.rows=true := by
 constructor
 · intro h
   have a := (andTrue _ _).mp h
   have b := (andTrue _ _).mp a.1
   have c := (andTrue _ _).mp b.1
   have d := (andTrue _ _).mp c.1
   exact ⟨d.1,d.2,c.2,b.2,a.2⟩
 · intro h
   exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨h.1,h.2.1⟩,h.2.2.1⟩,h.2.2.2.1⟩,h.2.2.2.2⟩

theorem eachRole (row : Row) : row.role=.solvent ∨ row.role=.solute := by
 cases row.role with
 | solvent => exact Or.inl rfl
 | solute => exact Or.inr rfl

theorem rolesDisjoint (row : Row) : ¬ (row.role=.solvent ∧ row.role=.solute) := by
 intro ⟨a,b⟩
 have impossible : Role.solvent = Role.solute := a.symm.trans b
 cases impossible

theorem hasRoleExactly (role : Role) (rows : List Row) : hasRole role rows=true ↔
 ∃ row, row ∈ rows ∧ row.role=role := by
 induction rows with
 | nil => constructor
          · intro h; cases h
          · intro ⟨row,h,_⟩; cases h
 | cons first rest ih =>
   change (decide (first.role=role) || hasRole role rest)=true ↔ _
   cases matchRole : decide (first.role=role) with
   | true =>
     constructor
     · intro _; exact ⟨first,.head _,of_decide_eq_true matchRole⟩
     · intro _; rfl
   | false =>
     constructor
     · intro h
       obtain ⟨row,held,equal⟩ := ih.mp h
       exact ⟨row,.tail _ held,equal⟩
     · intro ⟨row,held,equal⟩
       cases held with
       | head => rw [decide_eq_true equal] at matchRole; cases matchRole
       | tail _ h => exact ih.mpr ⟨row,h,equal⟩

theorem sourcePhaseRetained (record : Record) (valid : admitted record=true) (row : Row) (held : row ∈ record.rows) : row.phase=record.phase := by
 have all := ((admittedExactly _).mp valid).2.2.1
 exact of_decide_eq_true (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ all row held)

theorem mixedPhaseRejected (record : Record) (row : Row) (held : row ∈ record.rows) (different : row.phase ≠ record.phase) : admitted record ≠ true :=
 fun valid => different (sourcePhaseRetained _ valid row held)

theorem nonSolutionPhaseRejected (record : Record) (liquid : record.kind ≠ "liquid") (solid : record.kind ≠ "solid") : admitted record ≠ true := by
 intro valid
 cases (phaseAllowedExactly _).mp (((admittedExactly _).mp valid).2.1) with
 | inl h => exact liquid h
 | inr h => exact solid h

def setRole (row : Row) (role : Role) : Row := {row with role := role}
theorem roleRetainsIdentity (row : Row) (role : Role) :
 (setRole row role).component = row.component ∧ (setRole row role).phase = row.phase := ⟨rfl,rfl⟩

theorem contextNotIntrinsic (record : Record) (context : SFT.Host.Canonical.Value) :
 admitted {record with context := context} = admitted record := rfl

def initial (solvent solute : Component) (phase kind : String) (context boundary : SFT.Host.Canonical.Value) : Record :=
 ⟨[⟨solvent,phase,.solvent⟩,⟨solute,phase,.solute⟩],phase,kind,context,boundary,[]⟩

theorem initialAdmitted (solvent solute : Component) (phase kind : String) (context boundary : SFT.Host.Canonical.Value)
 (identities : distinct [solvent,solute]=true) (partition : closed [solvent,solute]) (allowed : phaseAllowed kind=true) :
 admitted (initial solvent solute phase kind context boundary)=true := by
 apply (admittedExactly _).mpr
 refine ⟨MixtureSupport.initialAdmitted _ _ _ _ identities partition,allowed,?_,?_,?_⟩
 · change (decide (phase=phase) && (decide (phase=phase) && true))=true
   rw [decide_eq_true rfl]
   rfl
 · rfl
 · rfl

def extend (record : Record) (rows : List Row) : Record :=
 {record with rows := rows, history := record.history++[record.rows]}

theorem extensionBoundary (record : Record) (rows : List Row) :
 (extend record rows).phase=record.phase ∧ (extend record rows).kind=record.kind ∧
 (extend record rows).context=record.context ∧ (extend record rows).boundary=record.boundary := ⟨rfl,rfl,rfl,rfl⟩

theorem extensionHistory (record : Record) (rows : List Row) : record.rows ∈ (extend record rows).history :=
 SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head _)

theorem extendedAdmission (record : Record) (rows : List Row)
 (mix : MixtureSupport.admitted (mixture (extend record rows))=true)
 (phase : phaseAllowed record.kind=true) (single : singlePhase (extend record rows)=true)
 (solvent : hasRole .solvent rows=true) (solute : hasRole .solute rows=true) : admitted (extend record rows)=true :=
 (admittedExactly _).mpr ⟨mix,phase,single,solvent,solute⟩
end SFT.Chemistry.SolutionSupport

#print axioms SFT.Chemistry.SolutionSupport.components
#print axioms SFT.Chemistry.SolutionSupport.mixture
#print axioms SFT.Chemistry.SolutionSupport.phaseAllowed
#print axioms SFT.Chemistry.SolutionSupport.singlePhase
#print axioms SFT.Chemistry.SolutionSupport.hasRole
#print axioms SFT.Chemistry.SolutionSupport.admitted
#print axioms SFT.Chemistry.SolutionSupport.phaseAllowedExactly
#print axioms SFT.Chemistry.SolutionSupport.admittedExactly
#print axioms SFT.Chemistry.SolutionSupport.eachRole
#print axioms SFT.Chemistry.SolutionSupport.rolesDisjoint
#print axioms SFT.Chemistry.SolutionSupport.hasRoleExactly
#print axioms SFT.Chemistry.SolutionSupport.sourcePhaseRetained
#print axioms SFT.Chemistry.SolutionSupport.mixedPhaseRejected
#print axioms SFT.Chemistry.SolutionSupport.nonSolutionPhaseRejected
#print axioms SFT.Chemistry.SolutionSupport.setRole
#print axioms SFT.Chemistry.SolutionSupport.roleRetainsIdentity
#print axioms SFT.Chemistry.SolutionSupport.contextNotIntrinsic
#print axioms SFT.Chemistry.SolutionSupport.initial
#print axioms SFT.Chemistry.SolutionSupport.initialAdmitted
#print axioms SFT.Chemistry.SolutionSupport.extend
#print axioms SFT.Chemistry.SolutionSupport.extensionBoundary
#print axioms SFT.Chemistry.SolutionSupport.extensionHistory
#print axioms SFT.Chemistry.SolutionSupport.extendedAdmission
