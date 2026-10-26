import SFT
def main : IO Unit := do
  for c in SFT.Foundation.Root.candidates do
    IO.println ("Root\t" ++ SFT.Foundation.Root.candidateId c ++ "\t" ++ (if SFT.Foundation.Root.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.Root.exactForm c ++ "\t" ++ SFT.Foundation.Root.decisionReason c)
  for c in SFT.Foundation.One.candidates do
    IO.println ("One\t" ++ SFT.Foundation.One.candidateId c ++ "\t" ++ (if SFT.Foundation.One.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.One.exactForm c ++ "\t" ++ SFT.Foundation.One.decisionReason c)
  for c in SFT.Foundation.Count.candidates do
    IO.println ("Count\t" ++ SFT.Foundation.Count.candidateId c ++ "\t" ++ (if SFT.Foundation.Count.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.Count.exactForm c ++ "\t" ++ SFT.Foundation.Count.decisionReason c)
  for c in SFT.Foundation.Part.candidates do
    IO.println ("Part\t" ++ SFT.Foundation.Part.candidateId c ++ "\t" ++ (if SFT.Foundation.Part.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.Part.exactForm c ++ "\t" ++ SFT.Foundation.Part.decisionReason c)
  for c in SFT.Foundation.PartEquivalence.candidates do
    IO.println ("PartEquivalence\t" ++ SFT.Foundation.PartEquivalence.candidateId c ++ "\t" ++ (if SFT.Foundation.PartEquivalence.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.PartEquivalence.exactForm c ++ "\t" ++ SFT.Foundation.PartEquivalence.decisionReason c)
  for c in SFT.Foundation.Fold.candidates do
    IO.println ("Fold\t" ++ SFT.Foundation.Fold.candidateId c ++ "\t" ++ (if SFT.Foundation.Fold.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.Fold.exactForm c ++ "\t" ++ SFT.Foundation.Fold.decisionReason c)
  for c in SFT.Foundation.FoldAssemblyGrammar.candidates do
    IO.println ("FoldAssemblyGrammar\t" ++ SFT.Foundation.FoldAssemblyGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.FoldAssemblyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.FoldAssemblyGrammar.exactForm c ++ "\t" ++ SFT.Foundation.FoldAssemblyGrammar.decisionReason c)
  for c in SFT.Foundation.ExactOperationsGrammar.candidates do
    IO.println ("ExactOperationsGrammar\t" ++ SFT.Foundation.ExactOperationsGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.ExactOperationsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.ExactOperationsGrammar.exactForm c ++ "\t" ++ SFT.Foundation.ExactOperationsGrammar.decisionReason c)
  for c in SFT.Foundation.HalfOneGrammar.candidates do
    IO.println ("HalfOneGrammar\t" ++ SFT.Foundation.HalfOneGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.HalfOneGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.HalfOneGrammar.exactForm c ++ "\t" ++ SFT.Foundation.HalfOneGrammar.decisionReason c)
  for c in SFT.Foundation.FoldDynamicsGrammar.candidates do
    IO.println ("FoldDynamicsGrammar\t" ++ SFT.Foundation.FoldDynamicsGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.FoldDynamicsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.FoldDynamicsGrammar.exactForm c ++ "\t" ++ SFT.Foundation.FoldDynamicsGrammar.decisionReason c)
  for c in SFT.Foundation.FormGrammar.candidates do
    IO.println ("FormGrammar\t" ++ SFT.Foundation.FormGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.FormGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.FormGrammar.exactForm c ++ "\t" ++ SFT.Foundation.FormGrammar.decisionReason c)
  for c in SFT.Foundation.FormEnforcementGrammar.candidates do
    IO.println ("FormEnforcementGrammar\t" ++ SFT.Foundation.FormEnforcementGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.FormEnforcementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.FormEnforcementGrammar.exactForm c ++ "\t" ++ SFT.Foundation.FormEnforcementGrammar.decisionReason c)
  for c in SFT.Foundation.MeasurementGrammar.candidates do
    IO.println ("MeasurementGrammar\t" ++ SFT.Foundation.MeasurementGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.MeasurementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.MeasurementGrammar.exactForm c ++ "\t" ++ SFT.Foundation.MeasurementGrammar.decisionReason c)
  for c in SFT.Mathematics.ExactArithmeticGrammar.candidates do
    IO.println ("ExactArithmeticGrammar\t" ++ SFT.Mathematics.ExactArithmeticGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.ExactArithmeticGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.ExactArithmeticGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.ExactArithmeticGrammar.decisionReason c)
  for c in SFT.Mathematics.DiscreteGrammar.candidates do
    IO.println ("DiscreteGrammar\t" ++ SFT.Mathematics.DiscreteGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.DiscreteGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.DiscreteGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.DiscreteGrammar.decisionReason c)
  for c in SFT.Foundation.PrimitiveMapGrammar.candidates do
    IO.println ("PrimitiveMapGrammar\t" ++ SFT.Foundation.PrimitiveMapGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.PrimitiveMapGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.PrimitiveMapGrammar.exactForm c ++ "\t" ++ SFT.Foundation.PrimitiveMapGrammar.decisionReason c)
