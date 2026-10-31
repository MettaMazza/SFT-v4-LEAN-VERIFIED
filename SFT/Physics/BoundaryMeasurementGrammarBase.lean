import SFT.Physics.BoundaryGrowthDiscriminator
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.BoundaryMeasurementGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "unbound-response-values"
  | .admitted => "one-retained-source-boundary"

inductive Distance where
  | rejected | admitted

def distanceName : Distance → String
  | .rejected => "floating-or-signed-distance"
  | .admitted => "exact-positive-distance-ratio"

inductive Response where
  | rejected | admitted

def responseName : Response → String
  | .rejected => "point-answer-without-uncertainty"
  | .admitted => "complete-positive-response-ratio-interval"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "fitted-source-amplitude"
  | .admitted => "same-source-ratio-cancellation"

inductive Candidates where
  | rejected | admitted

def candidatesName : Candidates → String
  | .rejected => "borrowed-or-fitted-exponent"
  | .admitted => "positive-successor-power-family"

inductive Selection where
  | rejected | admitted

def selectionName : Selection → String
  | .rejected => "best-fit-or-first-match"
  | .admitted => "all-interval-compatible-exponents"

inductive Stopping where
  | rejected | admitted

def stoppingName : Stopping → String
  | .rejected => "fixed-search-depth"
  | .admitted => "monotonic-strict-excess-certificate"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "target-readable-method"
  | .admitted => "postseal-custodied-observations"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "reported-exponent-only"
  | .admitted => "complete-ratio-power-decision-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-dimension-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  source : Source
  distance : Distance
  response : Response
  scale : Scale
  candidates : Candidates
  selection : Selection
  stopping : Stopping
  target : Target
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [sourceName c.source, distanceName c.distance, responseName c.response, scaleName c.scale, candidatesName c.candidates, selectionName c.selection, stoppingName c.stopping, targetName c.target, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "distance=" (distanceName c.distance), SFT.Host.Text.append "response=" (responseName c.response), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "candidates=" (candidatesName c.candidates), SFT.Host.Text.append "selection=" (selectionName c.selection), SFT.Host.Text.append "stopping=" (stoppingName c.stopping), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-source-boundary__exact-positive-distance-ratio__complete-positive-response-ratio-interval__same-source-ratio-cancellation__positive-successor-power-family__all-interval-compatible-exponents__monotonic-strict-excess-certificate__postseal-custodied-observations__complete-ratio-power-decision-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sourceName c.source) "one-retained-source-boundary" &&
  SFT.Host.Text.equal (distanceName c.distance) "exact-positive-distance-ratio" &&
  SFT.Host.Text.equal (responseName c.response) "complete-positive-response-ratio-interval" &&
  SFT.Host.Text.equal (scaleName c.scale) "same-source-ratio-cancellation" &&
  SFT.Host.Text.equal (candidatesName c.candidates) "positive-successor-power-family" &&
  SFT.Host.Text.equal (selectionName c.selection) "all-interval-compatible-exponents" &&
  SFT.Host.Text.equal (stoppingName c.stopping) "monotonic-strict-excess-certificate" &&
  SFT.Host.Text.equal (targetName c.target) "postseal-custodied-observations" &&
  SFT.Host.Text.equal (recordName c.record) "complete-ratio-power-decision-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (sourceName c.source) "unbound-response-values" then "Unbound responses may come from different sources or preparations." else
  if SFT.Host.Text.equal (distanceName c.distance) "floating-or-signed-distance" then "Floating or signed distances are outside the exact positive proof domain." else
  if SFT.Host.Text.equal (responseName c.response) "point-answer-without-uncertainty" then "A point answer discards unresolved measurement support." else
  if SFT.Host.Text.equal (scaleName c.scale) "fitted-source-amplitude" then "A fitted amplitude is a free target-derived parameter." else
  if SFT.Host.Text.equal (candidatesName c.candidates) "borrowed-or-fitted-exponent" then "A borrowed exponent selects the answer before measurement." else
  if SFT.Host.Text.equal (selectionName c.selection) "best-fit-or-first-match" then "Best fit or first match can erase tied compatible alternatives." else
  if SFT.Host.Text.equal (stoppingName c.stopping) "fixed-search-depth" then "A fixed depth can hide a later compatible candidate." else
  if SFT.Host.Text.equal (targetName c.target) "target-readable-method" then "Target access can choose the exponent rule." else
  if SFT.Host.Text.equal (recordName c.record) "reported-exponent-only" then "An exponent alone cannot reproduce generation, comparison or closure." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-dimension-rule" then "An added spatial model can force a desired exponent." else
  "One source-bound exact ratio experiment, complete response uncertainty, positive successor-power enumeration, all-compatible selection, monotonic closure, post-seal custody and complete trace."

def generationRule : String := "Generate the complete product of source carrier, distance comparison, response comparison, scale, candidate generation, selection, stopping, target access, evidence record and extra-rule forms."
def grammarBoundary : String := "All finite exact procedures for inferring a positive source-boundary growth exponent from two or more registered distance/response observations under admitted conserved-source dilution, including complete uncertainty support and a depth-independent stopping certificate."

def candidates : List Candidate :=
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Distance.rejected,Distance.admitted]).flatMap fun distance =>
  ([Response.rejected,Response.admitted]).flatMap fun response =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Candidates.rejected,Candidates.admitted]).flatMap fun candidates =>
  ([Selection.rejected,Selection.admitted]).flatMap fun selection =>
  ([Stopping.rejected,Stopping.admitted]).flatMap fun stopping =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨source,distance,response,scale,candidates,selection,stopping,target,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk source distance response scale candidates selection stopping target record extension =>
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistance : distance ∈ [Distance.rejected,Distance.admitted] := by
      cases distance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresponse : response ∈ [Response.rejected,Response.admitted] := by
      cases response <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcandidates : candidates ∈ [Candidates.rejected,Candidates.admitted] := by
      cases candidates <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselection : selection ∈ [Selection.rejected,Selection.admitted] := by
      cases selection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstopping : stopping ∈ [Stopping.rejected,Stopping.admitted] := by
      cases stopping <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold SFT.Physics.BoundaryMeasurementGrammar.candidates
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ distance _ hdistance
    apply CommonRefinement.memFlatMap _ _ response _ hresponse
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ candidates _ hcandidates
    apply CommonRefinement.memFlatMap _ _ selection _ hselection
    apply CommonRefinement.memFlatMap _ _ stopping _ hstopping
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.BoundaryMeasurementGrammar
