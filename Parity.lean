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

  for c in SFT.Foundation.DerivationTraceGrammar.candidates do
    IO.println ("DerivationTraceGrammar\t" ++ SFT.Foundation.DerivationTraceGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.DerivationTraceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.DerivationTraceGrammar.exactForm c ++ "\t" ++ SFT.Foundation.DerivationTraceGrammar.decisionReason c)

  for c in SFT.Mathematics.CombinatoricsGrammar.candidates do
    IO.println ("CombinatoricsGrammar\t" ++ SFT.Mathematics.CombinatoricsGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.CombinatoricsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.CombinatoricsGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.CombinatoricsGrammar.decisionReason c)

  for c in SFT.Mathematics.AlgebraGrammar.candidates do
    IO.println ("AlgebraGrammar\t" ++ SFT.Mathematics.AlgebraGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.AlgebraGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.AlgebraGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.AlgebraGrammar.decisionReason c)

  for c in SFT.Mathematics.OrderGrammar.candidates do
    IO.println ("OrderGrammar\t" ++ SFT.Mathematics.OrderGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.OrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.OrderGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.OrderGrammar.decisionReason c)

  for c in SFT.Mathematics.GraphGrammar.candidates do
    IO.println ("GraphGrammar\t" ++ SFT.Mathematics.GraphGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.GraphGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.GraphGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.GraphGrammar.decisionReason c)

  for c in SFT.Mathematics.GeometryGrammar.candidates do
    IO.println ("GeometryGrammar\t" ++ SFT.Mathematics.GeometryGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.GeometryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.GeometryGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.GeometryGrammar.decisionReason c)

  for c in SFT.Mathematics.ProbabilityGrammar.candidates do
    IO.println ("ProbabilityGrammar\t" ++ SFT.Mathematics.ProbabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.ProbabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.ProbabilityGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.ProbabilityGrammar.decisionReason c)

  for c in SFT.Mathematics.OptimizationGrammar.candidates do
    IO.println ("OptimizationGrammar\t" ++ SFT.Mathematics.OptimizationGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.OptimizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.OptimizationGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.OptimizationGrammar.decisionReason c)

  for c in SFT.Mathematics.DynamicsGrammar.candidates do
    IO.println ("DynamicsGrammar\t" ++ SFT.Mathematics.DynamicsGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.DynamicsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.DynamicsGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.DynamicsGrammar.decisionReason c)

  for c in SFT.Mathematics.LogicGrammar.candidates do
    IO.println ("LogicGrammar\t" ++ SFT.Mathematics.LogicGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.LogicGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.LogicGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.LogicGrammar.decisionReason c)

  for c in SFT.Mathematics.CategoryGrammar.candidates do
    IO.println ("CategoryGrammar\t" ++ SFT.Mathematics.CategoryGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.CategoryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.CategoryGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.CategoryGrammar.decisionReason c)

  for c in SFT.InformationScience.SymbolGrammar.candidates do
    IO.println ("SymbolGrammar\t" ++ SFT.InformationScience.SymbolGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.SymbolGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.SymbolGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.SymbolGrammar.decisionReason c)

  for c in SFT.InformationScience.EncodingGrammar.candidates do
    IO.println ("EncodingGrammar\t" ++ SFT.InformationScience.EncodingGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.EncodingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.EncodingGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.EncodingGrammar.decisionReason c)

  for c in SFT.InformationScience.QuantityGrammar.candidates do
    IO.println ("QuantityGrammar\t" ++ SFT.InformationScience.QuantityGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.QuantityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.QuantityGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.QuantityGrammar.decisionReason c)

  for c in SFT.InformationScience.EntropyGrammar.candidates do
    IO.println ("EntropyGrammar\t" ++ SFT.InformationScience.EntropyGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.EntropyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.EntropyGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.EntropyGrammar.decisionReason c)

  for c in SFT.InformationScience.CompressionGrammar.candidates do
    IO.println ("CompressionGrammar\t" ++ SFT.InformationScience.CompressionGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.CompressionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.CompressionGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.CompressionGrammar.decisionReason c)

  for c in SFT.InformationScience.ChannelGrammar.candidates do
    IO.println ("ChannelGrammar\t" ++ SFT.InformationScience.ChannelGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.ChannelGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.ChannelGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.ChannelGrammar.decisionReason c)

  for c in SFT.InformationScience.NoiseGrammar.candidates do
    IO.println ("NoiseGrammar\t" ++ SFT.InformationScience.NoiseGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.NoiseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.NoiseGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.NoiseGrammar.decisionReason c)

  for c in SFT.InformationScience.CodingGrammar.candidates do
    IO.println ("CodingGrammar\t" ++ SFT.InformationScience.CodingGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.CodingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.CodingGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.CodingGrammar.decisionReason c)

  for c in SFT.InformationScience.MutualGrammar.candidates do
    IO.println ("MutualGrammar\t" ++ SFT.InformationScience.MutualGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.MutualGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.MutualGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.MutualGrammar.decisionReason c)

