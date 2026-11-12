import SFT.Materials.UnitCellSourceChoices
import SFT.Materials.UnitCellMinimum
namespace SFT.Materials.UnitCellFamily
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects

-- Each target retains all admissible original sources, in original target order.
def assignments {α : Type} (options : α → List α) : List α → List (List (α × α))
 | [] => [[]]
 | target::rest => (options target).flatMap (fun seed =>
     (assignments options rest).map (fun rows => (seed,target)::rows))

inductive Matches {α : Type} (options : α → List α) : List α → List (α × α) → Prop
 | nil : Matches options [] []
 | cons {target seed : α} {targets : List α} {rows : List (α × α)} :
   seed∈options target → Matches options targets rows →
   Matches options (target::targets) ((seed,target)::rows)

theorem assignmentsMeaning {α : Type} (options : α → List α)
 (targets : List α) (rows : List (α × α)) :
 rows∈assignments options targets ↔ Matches options targets rows := by
 induction targets generalizing rows with
 | nil =>
   constructor
   · intro h
     cases h with
     | head => exact Matches.nil
     | tail _ h => cases h
   · intro h; cases h; exact List.Mem.head []
 | cons target rest ih =>
   constructor
   · intro h
     obtain ⟨seed,hs,hm⟩ := memFlatMapOrigin _ _ _ h
     obtain ⟨tail,ht,eq⟩ := memMapPreimage _ _ _ hm
     cases eq
     exact Matches.cons hs ((ih tail).mp ht)
   · intro h
     cases h with
     | cons hs hm =>
       exact memFlatMap _ _ _ _ hs
         (memMap _ _ _ ((ih _).mpr hm))

theorem targetsRetained {α : Type} {options : α → List α}
 {targets : List α} {rows : List (α × α)} (h : Matches options targets rows) :
 rows.map Prod.snd=targets := by
 induction h with
 | nil => rfl
 | cons _ _ ih => exact congrArg (List.cons _) ih

theorem everySourceRetained {α : Type} {options : α → List α}
 {targets : List α} {rows : List (α × α)} (h : Matches options targets rows)
 (seed target : α) (held : (seed,target)∈rows) : seed∈options target := by
 induction h with
 | nil => cases held
 | cons hs hm ih =>
   cases held with
   | head => exact hs
   | tail _ ht => exact ih ht

def siteFamilies (l : Lattice.Record) := assignments (UnitCellSourceChoices.siteChoices l) l.cells.graph.nodes

def relationFamilies (l : Lattice.Record) := assignments (UnitCellSourceChoices.relationChoices l) l.cells.graph.edges

def jointFamily (l : Lattice.Record) :=
 (siteFamilies l).flatMap (fun sites => (relationFamilies l).map (fun edges => (sites,edges)))

theorem jointFamilyMeaning (l : Lattice.Record)
 (sites : List (String × String)) (edges : List (Edge × Edge)) :
 (sites,edges)∈jointFamily l ↔
 Matches (UnitCellSourceChoices.siteChoices l) l.cells.graph.nodes sites ∧
 Matches (UnitCellSourceChoices.relationChoices l) l.cells.graph.edges edges := by
 constructor
 · intro held
   obtain ⟨ss,hs,hm⟩ := memFlatMapOrigin _ _ _ held
   obtain ⟨es,he,eq⟩ := memMapPreimage _ _ _ hm
   have a := congrArg Prod.fst eq
   have b := congrArg Prod.snd eq
   change ss=sites at a
   change es=edges at b
   cases a; cases b
   exact ⟨(assignmentsMeaning _ _ _).mp hs,(assignmentsMeaning _ _ _).mp he⟩
 · intro h
   exact memFlatMap _ _ _ _ ((assignmentsMeaning _ _ _).mpr h.1)
     (memMap _ _ _ ((assignmentsMeaning _ _ _).mpr h.2))

theorem realizeSites (l : Lattice.Record) (targets : List String)
 (rows : List (String × String)) (h : Matches (UnitCellSourceChoices.siteChoices l) targets rows) :
 ∃ steps : List (Nat × String),
 steps.map Prod.snd=rows.map Prod.fst ∧
 steps.map (fun row => Lattice.translate l row.1 row.2)=targets ∧
 (∀ row, row∈steps → row.2∈l.cells.graph.nodes) := by
 induction h with
 | nil => exact ⟨[],rfl,rfl,fun _ h => by cases h⟩
 | @cons target seed targets rows allowed matched ih =>
   obtain ⟨held,n,eq⟩ := (UnitCellSourceChoices.siteChoicesMeaning l seed target).mp allowed
   obtain ⟨steps,seeds,outputs,supported⟩ := ih
   refine ⟨(n,seed)::steps,congrArg (List.cons seed) seeds,?_,?_⟩
   · change Lattice.translate l n seed :: _ = target::targets
     rw [eq,outputs]
   · intro row member
     cases member with
     | head => exact held
     | tail _ hm => exact supported row hm

theorem realizeRelations (l : Lattice.Record) (targets : List Edge)
 (rows : List (Edge × Edge)) (h : Matches (UnitCellSourceChoices.relationChoices l) targets rows) :
 ∃ steps : List (Nat × Edge),
 steps.map Prod.snd=rows.map Prod.fst ∧
 steps.map (fun row => UnitCellRelationSupport.iterate l row.1 row.2)=targets ∧
 (∀ row, row∈steps → row.2∈l.cells.graph.edges) := by
 induction h with
 | nil => exact ⟨[],rfl,rfl,fun _ h => by cases h⟩
 | @cons target seed targets rows allowed matched ih =>
   obtain ⟨held,n,eq⟩ := (UnitCellSourceChoices.relationChoicesMeaning l seed target).mp allowed
   obtain ⟨steps,seeds,outputs,supported⟩ := ih
   refine ⟨(n,seed)::steps,congrArg (List.cons seed) seeds,?_,?_⟩
   · change UnitCellRelationSupport.iterate l n seed :: _ = target::targets
     rw [eq,outputs]
   · intro row member
     cases member with
     | head => exact held
     | tail _ hm => exact supported row hm

theorem realizeJoint (l : Lattice.Record) (ss : List (String × String)) (es : List (Edge × Edge))
 (held : (ss,es)∈jointFamily l) :
 ∃ t : UnitCellReconstruction.Trace, t.lattice=l ∧ UnitCellMinimum.admissible t ∧
 t.siteSteps.map Prod.snd=ss.map Prod.fst ∧ t.relationSteps.map Prod.snd=es.map Prod.fst := by
 have both := (jointFamilyMeaning l ss es).mp held
 obtain ⟨ps,psSeeds,psOutputs,psHeld⟩ := realizeSites l _ ss both.1
 obtain ⟨qs,qsSeeds,qsOutputs,qsHeld⟩ := realizeRelations l _ es both.2
 refine ⟨⟨l,ps,qs⟩,rfl,⟨?_,?_⟩,psSeeds,qsSeeds⟩
 · apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
   exact ⟨(SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr
     (fun row hr => (hasIff _ _).mpr (psHeld row hr)),
     (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr
     (fun row hr => (hasIff _ _).mpr (qsHeld row hr))⟩
 · constructor
   · intro x; exact congrArg (UnitCellReconstruction.occurrence x) psOutputs
   · intro e; exact congrArg (UnitCellReconstruction.occurrence e) qsOutputs

theorem diagonalMatches {α : Type} (options : α → List α) (targets : List α)
 (self : ∀ x, x∈targets → x∈options x) :
 Matches options targets (targets.map (fun x => (x,x))) := by
 induction targets with
 | nil => exact Matches.nil
 | cons first rest ih =>
   exact Matches.cons (self first (List.Mem.head _))
     (ih (fun x h => self x (List.Mem.tail first h)))

theorem identityInFamily (l : Lattice.Record) :
 (l.cells.graph.nodes.map (fun x => (x,x)),l.cells.graph.edges.map (fun e => (e,e)))∈jointFamily l := by
 apply (jointFamilyMeaning l _ _).mpr
 constructor
 · exact diagonalMatches _ _ (fun x hx =>
     (UnitCellSourceChoices.siteChoicesMeaning l x x).mpr ⟨hx,⟨0,rfl⟩⟩)
 · exact diagonalMatches _ _ (fun e he =>
     (UnitCellSourceChoices.relationChoicesMeaning l e e).mpr ⟨he,⟨0,rfl⟩⟩)
end SFT.Materials.UnitCellFamily
