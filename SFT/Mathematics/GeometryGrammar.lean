import SFT.Mathematics.GeometryShortest
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.GeometryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Cells where
  | rejected | admitted

def cellsName : Cells → String
  | .rejected => "coordinate-samples"
  | .admitted => "canonical-generated-cells"

inductive Incidence where
  | rejected | admitted

def incidenceName : Incidence → String
  | .rejected => "assumed-containment"
  | .admitted => "held-acyclic-boundary"

inductive Dimension where
  | rejected | admitted

def dimensionName : Dimension → String
  | .rejected => "borrowed-coordinate-count"
  | .admitted => "boundary-chain-depth"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "metric-threshold"
  | .admitted => "shared-incidence-witness"

inductive Distance where
  | rejected | admitted

def distanceName : Distance → String
  | .rejected => "floating-metric"
  | .admitted => "shortest-generated-path"

inductive Opens where
  | rejected | admitted

def opensName : Opens → String
  | .rejected => "named-neighborhoods"
  | .admitted => "generated-open-family-closure"

inductive Connectedness where
  | rejected | admitted

def connectednessName : Connectedness → String
  | .rejected => "visual-continuity"
  | .admitted => "no-disjoint-open-separation"

inductive Continuity where
  | rejected | admitted

def continuityName : Continuity → String
  | .rejected => "epsilon-scale"
  | .admitted => "inverse-open-preservation"

inductive Deformation where
  | rejected | admitted

def deformationName : Deformation → String
  | .rejected => "untracked-shape-change"
  | .admitted => "reversible-incidence-trace"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "continuum-or-extra-metric"
  | .admitted => "no-ambient-continuum"

structure Candidate where
  cells : Cells
  incidence : Incidence
  dimension : Dimension
  adjacency : Adjacency
  distance : Distance
  opens : Opens
  connectedness : Connectedness
  continuity : Continuity
  deformation : Deformation
  addition : Addition

def sourceFields (c : Candidate) : List String := [cellsName c.cells, incidenceName c.incidence, dimensionName c.dimension, adjacencyName c.adjacency, distanceName c.distance, opensName c.opens, connectednessName c.connectedness, continuityName c.continuity, deformationName c.deformation, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "cells=" (cellsName c.cells), SFT.Host.Text.append "incidence=" (incidenceName c.incidence), SFT.Host.Text.append "dimension=" (dimensionName c.dimension), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "distance=" (distanceName c.distance), SFT.Host.Text.append "opens=" (opensName c.opens), SFT.Host.Text.append "connectedness=" (connectednessName c.connectedness), SFT.Host.Text.append "continuity=" (continuityName c.continuity), SFT.Host.Text.append "deformation=" (deformationName c.deformation), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "canonical-generated-cells__held-acyclic-boundary__boundary-chain-depth__shared-incidence-witness__shortest-generated-path__generated-open-family-closure__no-disjoint-open-separation__inverse-open-preservation__reversible-incidence-trace__no-ambient-continuum"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (cellsName c.cells) "canonical-generated-cells" &&
  SFT.Host.Text.equal (incidenceName c.incidence) "held-acyclic-boundary" &&
  SFT.Host.Text.equal (dimensionName c.dimension) "boundary-chain-depth" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "shared-incidence-witness" &&
  SFT.Host.Text.equal (distanceName c.distance) "shortest-generated-path" &&
  SFT.Host.Text.equal (opensName c.opens) "generated-open-family-closure" &&
  SFT.Host.Text.equal (connectednessName c.connectedness) "no-disjoint-open-separation" &&
  SFT.Host.Text.equal (continuityName c.continuity) "inverse-open-preservation" &&
  SFT.Host.Text.equal (deformationName c.deformation) "reversible-incidence-trace" &&
  SFT.Host.Text.equal (additionName c.addition) "no-ambient-continuum"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (cellsName c.cells) "canonical-generated-cells") then "Samples from a borrowed coordinate field omit structural provenance." else
  if !(SFT.Host.Text.equal (incidenceName c.incidence) "held-acyclic-boundary") then "Assumed containment has no exact face-to-cell witness." else
  if !(SFT.Host.Text.equal (dimensionName c.dimension) "boundary-chain-depth") then "A coordinate count imports an ambient space." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "shared-incidence-witness") then "A threshold imports a free scale." else
  if !(SFT.Host.Text.equal (distanceName c.distance) "shortest-generated-path") then "A floating metric imports precision and possibly irrational values." else
  if !(SFT.Host.Text.equal (opensName c.opens) "generated-open-family-closure") then "Named neighborhoods need not satisfy closure." else
  if !(SFT.Host.Text.equal (connectednessName c.connectedness) "no-disjoint-open-separation") then "A presentation cannot establish structural connection." else
  if !(SFT.Host.Text.equal (continuityName c.continuity) "inverse-open-preservation") then "An imported scale is neither forced nor needed in the finite grammar." else
  if !(SFT.Host.Text.equal (deformationName c.deformation) "reversible-incidence-trace") then "An untracked change can erase incidence." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-ambient-continuum") then "A continuum or metric field is outside the generated computational need." else
  "The geometry/topology kernel is finite canonical cells with held acyclic incidence, boundary-depth dimension, shared-face adjacency, exact shortest paths, closed finite open families, inverse-image continuity and reversible incidence-preserving deformation."

def generationRule : String := "Generate the complete product of cell carrier, incidence, dimension, adjacency, path distance, open-family closure, connectedness, continuity, deformation and extra-geometric status."
def grammarBoundary : String := "All finite incidence complexes, path geometries and finite open families generated from canonical forms, held boundary relations, exact path traces, selections, joins and intersections."

def candidates : List Candidate :=
  ([Cells.rejected,Cells.admitted]).flatMap fun cells =>
  ([Incidence.rejected,Incidence.admitted]).flatMap fun incidence =>
  ([Dimension.rejected,Dimension.admitted]).flatMap fun dimension =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Distance.rejected,Distance.admitted]).flatMap fun distance =>
  ([Opens.rejected,Opens.admitted]).flatMap fun opens =>
  ([Connectedness.rejected,Connectedness.admitted]).flatMap fun connectedness =>
  ([Continuity.rejected,Continuity.admitted]).flatMap fun continuity =>
  ([Deformation.rejected,Deformation.admitted]).flatMap fun deformation =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨cells,incidence,dimension,adjacency,distance,opens,connectedness,continuity,deformation,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk cells incidence dimension adjacency distance opens connectedness continuity deformation addition =>
    have hcells : cells ∈ [Cells.rejected,Cells.admitted] := by
      cases cells <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hincidence : incidence ∈ [Incidence.rejected,Incidence.admitted] := by
      cases incidence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdimension : dimension ∈ [Dimension.rejected,Dimension.admitted] := by
      cases dimension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistance : distance ∈ [Distance.rejected,Distance.admitted] := by
      cases distance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hopens : opens ∈ [Opens.rejected,Opens.admitted] := by
      cases opens <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnectedness : connectedness ∈ [Connectedness.rejected,Connectedness.admitted] := by
      cases connectedness <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontinuity : continuity ∈ [Continuity.rejected,Continuity.admitted] := by
      cases continuity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdeformation : deformation ∈ [Deformation.rejected,Deformation.admitted] := by
      cases deformation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ cells _ hcells
    apply CommonRefinement.memFlatMap _ _ incidence _ hincidence
    apply CommonRefinement.memFlatMap _ _ dimension _ hdimension
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ distance _ hdistance
    apply CommonRefinement.memFlatMap _ _ opens _ hopens
    apply CommonRefinement.memFlatMap _ _ connectedness _ hconnectedness
    apply CommonRefinement.memFlatMap _ _ continuity _ hcontinuity
    apply CommonRefinement.memFlatMap _ _ deformation _ hdeformation
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk cells incidence dimension adjacency distance opens connectedness continuity deformation addition =>
    cases cells <;> cases incidence <;> cases dimension <;> cases adjacency <;> cases distance <;> cases opens <;> cases connectedness <;> cases continuity <;> cases deformation <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk cells incidence dimension adjacency distance opens connectedness continuity deformation addition =>
    cases cells <;> cases incidence <;> cases dimension <;> cases adjacency <;> cases distance <;> cases opens <;> cases connectedness <;> cases continuity <;> cases deformation <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.cells = .admitted ∧ c.incidence = .admitted ∧ c.dimension = .admitted ∧ c.adjacency = .admitted ∧ c.distance = .admitted ∧ c.opens = .admitted ∧ c.connectedness = .admitted ∧ c.continuity = .admitted ∧ c.deformation = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk cells incidence dimension adjacency distance opens connectedness continuity deformation addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem cells_rejected_rejected (c : Candidate) (h : c.cells = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cells eq
    rw [h] at field
    cases field

theorem incidence_rejected_rejected (c : Candidate) (h : c.incidence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.incidence eq
    rw [h] at field
    cases field

theorem dimension_rejected_rejected (c : Candidate) (h : c.dimension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dimension eq
    rw [h] at field
    cases field

theorem adjacency_rejected_rejected (c : Candidate) (h : c.adjacency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adjacency eq
    rw [h] at field
    cases field

theorem distance_rejected_rejected (c : Candidate) (h : c.distance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distance eq
    rw [h] at field
    cases field

theorem opens_rejected_rejected (c : Candidate) (h : c.opens = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.opens eq
    rw [h] at field
    cases field

theorem connectedness_rejected_rejected (c : Candidate) (h : c.connectedness = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.connectedness eq
    rw [h] at field
    cases field

theorem continuity_rejected_rejected (c : Candidate) (h : c.continuity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.continuity eq
    rw [h] at field
    cases field

theorem deformation_rejected_rejected (c : Candidate) (h : c.deformation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.deformation eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.GeometryGrammar
