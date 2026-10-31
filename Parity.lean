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


  for c in SFT.InformationScience.ConservationGrammar.candidates do
    IO.println ("ConservationGrammar\t" ++ SFT.InformationScience.ConservationGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.ConservationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.ConservationGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.ConservationGrammar.decisionReason c)


  for c in SFT.InformationScience.ClassicalGrammar.candidates do
    IO.println ("ClassicalGrammar\t" ++ SFT.InformationScience.ClassicalGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.ClassicalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.ClassicalGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.ClassicalGrammar.decisionReason c)


  for c in SFT.InformationScience.QuantumGrammar.candidates do
    IO.println ("QuantumGrammar\t" ++ SFT.InformationScience.QuantumGrammar.candidateId c ++ "\t" ++ (if SFT.InformationScience.QuantumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.InformationScience.QuantumGrammar.exactForm c ++ "\t" ++ SFT.InformationScience.QuantumGrammar.decisionReason c)


  for c in SFT.Computation.StateGrammar.candidates do
    IO.println ("StateGrammar\t" ++ SFT.Computation.StateGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.StateGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.StateGrammar.exactForm c ++ "\t" ++ SFT.Computation.StateGrammar.decisionReason c)


  for c in SFT.Computation.LanguageGrammar.candidates do
    IO.println ("LanguageGrammar\t" ++ SFT.Computation.LanguageGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.LanguageGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.LanguageGrammar.exactForm c ++ "\t" ++ SFT.Computation.LanguageGrammar.decisionReason c)


  for c in SFT.Computation.AutomatonGrammar.candidates do
    IO.println ("AutomatonGrammar\t" ++ SFT.Computation.AutomatonGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AutomatonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AutomatonGrammar.exactForm c ++ "\t" ++ SFT.Computation.AutomatonGrammar.decisionReason c)


  for c in SFT.Computation.RewritingGrammar.candidates do
    IO.println ("RewritingGrammar\t" ++ SFT.Computation.RewritingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.RewritingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.RewritingGrammar.exactForm c ++ "\t" ++ SFT.Computation.RewritingGrammar.decisionReason c)


  for c in SFT.Computation.RecursionGrammar.candidates do
    IO.println ("RecursionGrammar\t" ++ SFT.Computation.RecursionGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.RecursionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.RecursionGrammar.exactForm c ++ "\t" ++ SFT.Computation.RecursionGrammar.decisionReason c)


  for c in SFT.Computation.BindingGrammar.candidates do
    IO.println ("BindingGrammar\t" ++ SFT.Computation.BindingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.BindingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.BindingGrammar.exactForm c ++ "\t" ++ SFT.Computation.BindingGrammar.decisionReason c)


  for c in SFT.Computation.MachineGrammar.candidates do
    IO.println ("MachineGrammar\t" ++ SFT.Computation.MachineGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.MachineGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.MachineGrammar.exactForm c ++ "\t" ++ SFT.Computation.MachineGrammar.decisionReason c)


  for c in SFT.Computation.CircuitGrammar.candidates do
    IO.println ("CircuitGrammar\t" ++ SFT.Computation.CircuitGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CircuitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CircuitGrammar.exactForm c ++ "\t" ++ SFT.Computation.CircuitGrammar.decisionReason c)


  for c in SFT.Computation.ProcessGrammar.candidates do
    IO.println ("ProcessGrammar\t" ++ SFT.Computation.ProcessGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ProcessGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ProcessGrammar.exactForm c ++ "\t" ++ SFT.Computation.ProcessGrammar.decisionReason c)


  for c in SFT.Computation.AssemblyGrammar.candidates do
    IO.println ("AssemblyGrammar\t" ++ SFT.Computation.AssemblyGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AssemblyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AssemblyGrammar.exactForm c ++ "\t" ++ SFT.Computation.AssemblyGrammar.decisionReason c)


  for c in SFT.Computation.ModelGrammar.candidates do
    IO.println ("ModelGrammar\t" ++ SFT.Computation.ModelGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ModelGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ModelGrammar.exactForm c ++ "\t" ++ SFT.Computation.ModelGrammar.decisionReason c)


  for c in SFT.Computation.UniversalGrammar.candidates do
    IO.println ("UniversalGrammar\t" ++ SFT.Computation.UniversalGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.UniversalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.UniversalGrammar.exactForm c ++ "\t" ++ SFT.Computation.UniversalGrammar.decisionReason c)


  for c in SFT.Computation.RecognitionGrammar.candidates do
    IO.println ("RecognitionGrammar\t" ++ SFT.Computation.RecognitionGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.RecognitionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.RecognitionGrammar.exactForm c ++ "\t" ++ SFT.Computation.RecognitionGrammar.decisionReason c)


  for c in SFT.Computation.HaltingGrammar.candidates do
    IO.println ("HaltingGrammar\t" ++ SFT.Computation.HaltingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.HaltingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.HaltingGrammar.exactForm c ++ "\t" ++ SFT.Computation.HaltingGrammar.decisionReason c)


  for c in SFT.Computation.EnumerationGrammar.candidates do
    IO.println ("EnumerationGrammar\t" ++ SFT.Computation.EnumerationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.EnumerationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.EnumerationGrammar.exactForm c ++ "\t" ++ SFT.Computation.EnumerationGrammar.decisionReason c)


  for c in SFT.Computation.ReductionGrammar.candidates do
    IO.println ("ReductionGrammar\t" ++ SFT.Computation.ReductionGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ReductionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ReductionGrammar.exactForm c ++ "\t" ++ SFT.Computation.ReductionGrammar.decisionReason c)


  for c in SFT.Computation.DegreesGrammar.candidates do
    IO.println ("DegreesGrammar\t" ++ SFT.Computation.DegreesGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.DegreesGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.DegreesGrammar.exactForm c ++ "\t" ++ SFT.Computation.DegreesGrammar.decisionReason c)


  for c in SFT.Computation.UniversalMachineGrammar.candidates do
    IO.println ("UniversalMachineGrammar\t" ++ SFT.Computation.UniversalMachineGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.UniversalMachineGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.UniversalMachineGrammar.exactForm c ++ "\t" ++ SFT.Computation.UniversalMachineGrammar.decisionReason c)


  for c in SFT.Computation.UndecidabilityGrammar.candidates do
    IO.println ("UndecidabilityGrammar\t" ++ SFT.Computation.UndecidabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.UndecidabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.UndecidabilityGrammar.exactForm c ++ "\t" ++ SFT.Computation.UndecidabilityGrammar.decisionReason c)


  for c in SFT.Computation.IncompletenessGrammar.candidates do
    IO.println ("IncompletenessGrammar\t" ++ SFT.Computation.IncompletenessGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.IncompletenessGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.IncompletenessGrammar.exactForm c ++ "\t" ++ SFT.Computation.IncompletenessGrammar.decisionReason c)


  for c in SFT.Computation.RelativeOracleGrammar.candidates do
    IO.println ("RelativeOracleGrammar\t" ++ SFT.Computation.RelativeOracleGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.RelativeOracleGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.RelativeOracleGrammar.exactForm c ++ "\t" ++ SFT.Computation.RelativeOracleGrammar.decisionReason c)


  for c in SFT.Computation.HypercomputationLimitGrammar.candidates do
    IO.println ("HypercomputationLimitGrammar\t" ++ SFT.Computation.HypercomputationLimitGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.HypercomputationLimitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.HypercomputationLimitGrammar.exactForm c ++ "\t" ++ SFT.Computation.HypercomputationLimitGrammar.decisionReason c)


  for c in SFT.Computation.InputSizeGrammar.candidates do
    IO.println ("InputSizeGrammar\t" ++ SFT.Computation.InputSizeGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.InputSizeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.InputSizeGrammar.exactForm c ++ "\t" ++ SFT.Computation.InputSizeGrammar.decisionReason c)


  for c in SFT.Computation.TimeSpaceGrammar.candidates do
    IO.println ("TimeSpaceGrammar\t" ++ SFT.Computation.TimeSpaceGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.TimeSpaceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.TimeSpaceGrammar.exactForm c ++ "\t" ++ SFT.Computation.TimeSpaceGrammar.decisionReason c)


  for c in SFT.Computation.CircuitResourceGrammar.candidates do
    IO.println ("CircuitResourceGrammar\t" ++ SFT.Computation.CircuitResourceGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CircuitResourceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CircuitResourceGrammar.exactForm c ++ "\t" ++ SFT.Computation.CircuitResourceGrammar.decisionReason c)


  for c in SFT.Computation.CommunicationQueryGrammar.candidates do
    IO.println ("CommunicationQueryGrammar\t" ++ SFT.Computation.CommunicationQueryGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CommunicationQueryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CommunicationQueryGrammar.exactForm c ++ "\t" ++ SFT.Computation.CommunicationQueryGrammar.decisionReason c)


  for c in SFT.Computation.RandomnessGrammar.candidates do
    IO.println ("RandomnessGrammar\t" ++ SFT.Computation.RandomnessGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.RandomnessGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.RandomnessGrammar.exactForm c ++ "\t" ++ SFT.Computation.RandomnessGrammar.decisionReason c)


  for c in SFT.Computation.ReversibilityCostGrammar.candidates do
    IO.println ("ReversibilityCostGrammar\t" ++ SFT.Computation.ReversibilityCostGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ReversibilityCostGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ReversibilityCostGrammar.exactForm c ++ "\t" ++ SFT.Computation.ReversibilityCostGrammar.decisionReason c)


  for c in SFT.Computation.ParallelGrammar.candidates do
    IO.println ("ParallelGrammar\t" ++ SFT.Computation.ParallelGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ParallelGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ParallelGrammar.exactForm c ++ "\t" ++ SFT.Computation.ParallelGrammar.decisionReason c)


  for c in SFT.Computation.BoundsGrammar.candidates do
    IO.println ("BoundsGrammar\t" ++ SFT.Computation.BoundsGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.BoundsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.BoundsGrammar.exactForm c ++ "\t" ++ SFT.Computation.BoundsGrammar.decisionReason c)


  for c in SFT.Computation.ReductionCompletenessGrammar.candidates do
    IO.println ("ReductionCompletenessGrammar\t" ++ SFT.Computation.ReductionCompletenessGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ReductionCompletenessGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ReductionCompletenessGrammar.exactForm c ++ "\t" ++ SFT.Computation.ReductionCompletenessGrammar.decisionReason c)


  for c in SFT.Computation.AverageWorstGrammar.candidates do
    IO.println ("AverageWorstGrammar\t" ++ SFT.Computation.AverageWorstGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AverageWorstGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AverageWorstGrammar.exactForm c ++ "\t" ++ SFT.Computation.AverageWorstGrammar.decisionReason c)


  for c in SFT.Computation.ApproximationGrammar.candidates do
    IO.println ("ApproximationGrammar\t" ++ SFT.Computation.ApproximationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ApproximationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ApproximationGrammar.exactForm c ++ "\t" ++ SFT.Computation.ApproximationGrammar.decisionReason c)


  for c in SFT.Computation.ParameterizedGrammar.candidates do
    IO.println ("ParameterizedGrammar\t" ++ SFT.Computation.ParameterizedGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ParameterizedGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ParameterizedGrammar.exactForm c ++ "\t" ++ SFT.Computation.ParameterizedGrammar.decisionReason c)


  for c in SFT.Computation.DescriptiveGrammar.candidates do
    IO.println ("DescriptiveGrammar\t" ++ SFT.Computation.DescriptiveGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.DescriptiveGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.DescriptiveGrammar.exactForm c ++ "\t" ++ SFT.Computation.DescriptiveGrammar.decisionReason c)


  for c in SFT.Computation.SearchOrderGrammar.candidates do
    IO.println ("SearchOrderGrammar\t" ++ SFT.Computation.SearchOrderGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SearchOrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SearchOrderGrammar.exactForm c ++ "\t" ++ SFT.Computation.SearchOrderGrammar.decisionReason c)


  for c in SFT.Computation.ArithmeticGrammar.candidates do
    IO.println ("ArithmeticGrammar\t" ++ SFT.Computation.ArithmeticGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ArithmeticGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ArithmeticGrammar.exactForm c ++ "\t" ++ SFT.Computation.ArithmeticGrammar.decisionReason c)


  for c in SFT.Computation.StringsSequencesGrammar.candidates do
    IO.println ("StringsSequencesGrammar\t" ++ SFT.Computation.StringsSequencesGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.StringsSequencesGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.StringsSequencesGrammar.exactForm c ++ "\t" ++ SFT.Computation.StringsSequencesGrammar.decisionReason c)


  for c in SFT.Computation.TreesGraphsGrammar.candidates do
    IO.println ("TreesGraphsGrammar\t" ++ SFT.Computation.TreesGraphsGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.TreesGraphsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.TreesGraphsGrammar.exactForm c ++ "\t" ++ SFT.Computation.TreesGraphsGrammar.decisionReason c)


  for c in SFT.Computation.AlgebraicGeometricGrammar.candidates do
    IO.println ("AlgebraicGeometricGrammar\t" ++ SFT.Computation.AlgebraicGeometricGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AlgebraicGeometricGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AlgebraicGeometricGrammar.exactForm c ++ "\t" ++ SFT.Computation.AlgebraicGeometricGrammar.decisionReason c)


  for c in SFT.Computation.DynamicProgrammingGrammar.candidates do
    IO.println ("DynamicProgrammingGrammar\t" ++ SFT.Computation.DynamicProgrammingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.DynamicProgrammingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.DynamicProgrammingGrammar.exactForm c ++ "\t" ++ SFT.Computation.DynamicProgrammingGrammar.decisionReason c)


  for c in SFT.Computation.OptimizationGrammar.candidates do
    IO.println ("OptimizationGrammar\t" ++ SFT.Computation.OptimizationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.OptimizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.OptimizationGrammar.exactForm c ++ "\t" ++ SFT.Computation.OptimizationGrammar.decisionReason c)


  for c in SFT.Computation.RandomizedGrammar.candidates do
    IO.println ("RandomizedGrammar\t" ++ SFT.Computation.RandomizedGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.RandomizedGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.RandomizedGrammar.exactForm c ++ "\t" ++ SFT.Computation.RandomizedGrammar.decisionReason c)


  for c in SFT.Computation.ParallelAlgorithmGrammar.candidates do
    IO.println ("ParallelAlgorithmGrammar\t" ++ SFT.Computation.ParallelAlgorithmGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ParallelAlgorithmGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ParallelAlgorithmGrammar.exactForm c ++ "\t" ++ SFT.Computation.ParallelAlgorithmGrammar.decisionReason c)


  for c in SFT.Computation.DistributedAlgorithmGrammar.candidates do
    IO.println ("DistributedAlgorithmGrammar\t" ++ SFT.Computation.DistributedAlgorithmGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.DistributedAlgorithmGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.DistributedAlgorithmGrammar.exactForm c ++ "\t" ++ SFT.Computation.DistributedAlgorithmGrammar.decisionReason c)


  for c in SFT.Computation.OnlineStreamingGrammar.candidates do
    IO.println ("OnlineStreamingGrammar\t" ++ SFT.Computation.OnlineStreamingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.OnlineStreamingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.OnlineStreamingGrammar.exactForm c ++ "\t" ++ SFT.Computation.OnlineStreamingGrammar.decisionReason c)


  for c in SFT.Computation.NumericalGrammar.candidates do
    IO.println ("NumericalGrammar\t" ++ SFT.Computation.NumericalGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.NumericalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.NumericalGrammar.exactForm c ++ "\t" ++ SFT.Computation.NumericalGrammar.decisionReason c)


  for c in SFT.Computation.SymbolicGrammar.candidates do
    IO.println ("SymbolicGrammar\t" ++ SFT.Computation.SymbolicGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SymbolicGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SymbolicGrammar.exactForm c ++ "\t" ++ SFT.Computation.SymbolicGrammar.decisionReason c)


  for c in SFT.Computation.ApproximateGrammar.candidates do
    IO.println ("ApproximateGrammar\t" ++ SFT.Computation.ApproximateGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ApproximateGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ApproximateGrammar.exactForm c ++ "\t" ++ SFT.Computation.ApproximateGrammar.decisionReason c)


  for c in SFT.Computation.SyntaxGrammar.candidates do
    IO.println ("SyntaxGrammar\t" ++ SFT.Computation.SyntaxGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SyntaxGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SyntaxGrammar.exactForm c ++ "\t" ++ SFT.Computation.SyntaxGrammar.decisionReason c)


  for c in SFT.Computation.SemBindingGrammar.candidates do
    IO.println ("SemBindingGrammar\t" ++ SFT.Computation.SemBindingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SemBindingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SemBindingGrammar.exactForm c ++ "\t" ++ SFT.Computation.SemBindingGrammar.decisionReason c)


  for c in SFT.Computation.EvaluationGrammar.candidates do
    IO.println ("EvaluationGrammar\t" ++ SFT.Computation.EvaluationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.EvaluationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.EvaluationGrammar.exactForm c ++ "\t" ++ SFT.Computation.EvaluationGrammar.decisionReason c)


  for c in SFT.Computation.MeaningGrammar.candidates do
    IO.println ("MeaningGrammar\t" ++ SFT.Computation.MeaningGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.MeaningGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.MeaningGrammar.exactForm c ++ "\t" ++ SFT.Computation.MeaningGrammar.decisionReason c)


  for c in SFT.Computation.TypeGrammar.candidates do
    IO.println ("TypeGrammar\t" ++ SFT.Computation.TypeGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.TypeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.TypeGrammar.exactForm c ++ "\t" ++ SFT.Computation.TypeGrammar.decisionReason c)


  for c in SFT.Computation.EquivalenceGrammar.candidates do
    IO.println ("EquivalenceGrammar\t" ++ SFT.Computation.EquivalenceGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.EquivalenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.EquivalenceGrammar.exactForm c ++ "\t" ++ SFT.Computation.EquivalenceGrammar.decisionReason c)


  for c in SFT.Computation.TerminationGrammar.candidates do
    IO.println ("TerminationGrammar\t" ++ SFT.Computation.TerminationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.TerminationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.TerminationGrammar.exactForm c ++ "\t" ++ SFT.Computation.TerminationGrammar.decisionReason c)


  for c in SFT.Computation.CorrectnessGrammar.candidates do
    IO.println ("CorrectnessGrammar\t" ++ SFT.Computation.CorrectnessGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CorrectnessGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CorrectnessGrammar.exactForm c ++ "\t" ++ SFT.Computation.CorrectnessGrammar.decisionReason c)


  for c in SFT.Computation.SpecificationGrammar.candidates do
    IO.println ("SpecificationGrammar\t" ++ SFT.Computation.SpecificationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SpecificationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SpecificationGrammar.exactForm c ++ "\t" ++ SFT.Computation.SpecificationGrammar.decisionReason c)


  for c in SFT.Computation.TransformationGrammar.candidates do
    IO.println ("TransformationGrammar\t" ++ SFT.Computation.TransformationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.TransformationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.TransformationGrammar.exactForm c ++ "\t" ++ SFT.Computation.TransformationGrammar.decisionReason c)


  for c in SFT.Computation.CompilationGrammar.candidates do
    IO.println ("CompilationGrammar\t" ++ SFT.Computation.CompilationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CompilationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CompilationGrammar.exactForm c ++ "\t" ++ SFT.Computation.CompilationGrammar.decisionReason c)


  for c in SFT.Computation.VerificationGrammar.candidates do
    IO.println ("VerificationGrammar\t" ++ SFT.Computation.VerificationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.VerificationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.VerificationGrammar.exactForm c ++ "\t" ++ SFT.Computation.VerificationGrammar.decisionReason c)


  for c in SFT.Computation.ConcurrencyGrammar.candidates do
    IO.println ("ConcurrencyGrammar\t" ++ SFT.Computation.ConcurrencyGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ConcurrencyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ConcurrencyGrammar.exactForm c ++ "\t" ++ SFT.Computation.ConcurrencyGrammar.decisionReason c)


  for c in SFT.Computation.CausalityGrammar.candidates do
    IO.println ("CausalityGrammar\t" ++ SFT.Computation.CausalityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CausalityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CausalityGrammar.exactForm c ++ "\t" ++ SFT.Computation.CausalityGrammar.decisionReason c)


  for c in SFT.Physics.GeneratorThreeGrammar.candidates do
    IO.println ("GeneratorThreeGrammar\t" ++ SFT.Physics.GeneratorThreeGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GeneratorThreeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GeneratorThreeGrammar.exactForm c ++ "\t" ++ SFT.Physics.GeneratorThreeGrammar.decisionReason c)


  for c in SFT.Physics.SpatialThreeGrammar.candidates do
    IO.println ("SpatialThreeGrammar\t" ++ SFT.Physics.SpatialThreeGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpatialThreeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpatialThreeGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpatialThreeGrammar.decisionReason c)


  for c in SFT.Physics.BoundaryRankGrammar.candidates do
    IO.println ("BoundaryRankGrammar\t" ++ SFT.Physics.BoundaryRankGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.BoundaryRankGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.BoundaryRankGrammar.exactForm c ++ "\t" ++ SFT.Physics.BoundaryRankGrammar.decisionReason c)


  for c in SFT.Physics.AlphaGrammar.candidates do
    IO.println ("AlphaGrammar\t" ++ SFT.Physics.AlphaGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.AlphaGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.AlphaGrammar.exactForm c ++ "\t" ++ SFT.Physics.AlphaGrammar.decisionReason c)


  for c in SFT.Physics.LeptonGrammar.candidates do
    IO.println ("LeptonGrammar\t" ++ SFT.Physics.LeptonGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.LeptonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.LeptonGrammar.exactForm c ++ "\t" ++ SFT.Physics.LeptonGrammar.decisionReason c)


  for c in SFT.Physics.TerminalGrammar.candidates do
    IO.println ("TerminalGrammar\t" ++ SFT.Physics.TerminalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TerminalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TerminalGrammar.exactForm c ++ "\t" ++ SFT.Physics.TerminalGrammar.decisionReason c)


  for c in SFT.Physics.MixingGrammar.candidates do
    IO.println ("MixingGrammar\t" ++ SFT.Physics.MixingGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MixingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MixingGrammar.exactForm c ++ "\t" ++ SFT.Physics.MixingGrammar.decisionReason c)


  for c in SFT.Computation.SynchronizationGrammar.candidates do
    IO.println ("SynchronizationGrammar\t" ++ SFT.Computation.SynchronizationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SynchronizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SynchronizationGrammar.exactForm c ++ "\t" ++ SFT.Computation.SynchronizationGrammar.decisionReason c)


  for c in SFT.Computation.CommunicationGrammar.candidates do
    IO.println ("CommunicationGrammar\t" ++ SFT.Computation.CommunicationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CommunicationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CommunicationGrammar.exactForm c ++ "\t" ++ SFT.Computation.CommunicationGrammar.decisionReason c)


  for c in SFT.Computation.DistributedOrderGrammar.candidates do
    IO.println ("DistributedOrderGrammar\t" ++ SFT.Computation.DistributedOrderGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.DistributedOrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.DistributedOrderGrammar.exactForm c ++ "\t" ++ SFT.Computation.DistributedOrderGrammar.decisionReason c)


  for c in SFT.Computation.ConsensusGrammar.candidates do
    IO.println ("ConsensusGrammar\t" ++ SFT.Computation.ConsensusGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ConsensusGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ConsensusGrammar.exactForm c ++ "\t" ++ SFT.Computation.ConsensusGrammar.decisionReason c)


  for c in SFT.Computation.AgreementImpossibilityGrammar.candidates do
    IO.println ("AgreementImpossibilityGrammar\t" ++ SFT.Computation.AgreementImpossibilityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AgreementImpossibilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AgreementImpossibilityGrammar.exactForm c ++ "\t" ++ SFT.Computation.AgreementImpossibilityGrammar.decisionReason c)


  for c in SFT.Computation.ReplicationGrammar.candidates do
    IO.println ("ReplicationGrammar\t" ++ SFT.Computation.ReplicationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ReplicationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ReplicationGrammar.exactForm c ++ "\t" ++ SFT.Computation.ReplicationGrammar.decisionReason c)


  for c in SFT.Computation.FaultModelGrammar.candidates do
    IO.println ("FaultModelGrammar\t" ++ SFT.Computation.FaultModelGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.FaultModelGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.FaultModelGrammar.exactForm c ++ "\t" ++ SFT.Computation.FaultModelGrammar.decisionReason c)


  for c in SFT.Computation.DistributedKnowledgeGrammar.candidates do
    IO.println ("DistributedKnowledgeGrammar\t" ++ SFT.Computation.DistributedKnowledgeGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.DistributedKnowledgeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.DistributedKnowledgeGrammar.exactForm c ++ "\t" ++ SFT.Computation.DistributedKnowledgeGrammar.decisionReason c)


  for c in SFT.Computation.LocalityGrammar.candidates do
    IO.println ("LocalityGrammar\t" ++ SFT.Computation.LocalityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.LocalityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.LocalityGrammar.exactForm c ++ "\t" ++ SFT.Computation.LocalityGrammar.decisionReason c)


  for c in SFT.Computation.NetworkComputationGrammar.candidates do
    IO.println ("NetworkComputationGrammar\t" ++ SFT.Computation.NetworkComputationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.NetworkComputationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.NetworkComputationGrammar.exactForm c ++ "\t" ++ SFT.Computation.NetworkComputationGrammar.decisionReason c)


  for c in SFT.Computation.OneWaynessGrammar.candidates do
    IO.println ("OneWaynessGrammar\t" ++ SFT.Computation.OneWaynessGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.OneWaynessGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.OneWaynessGrammar.exactForm c ++ "\t" ++ SFT.Computation.OneWaynessGrammar.decisionReason c)


  for c in SFT.Computation.SecrecyGrammar.candidates do
    IO.println ("SecrecyGrammar\t" ++ SFT.Computation.SecrecyGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SecrecyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SecrecyGrammar.exactForm c ++ "\t" ++ SFT.Computation.SecrecyGrammar.decisionReason c)


  for c in SFT.Computation.IntegrityGrammar.candidates do
    IO.println ("IntegrityGrammar\t" ++ SFT.Computation.IntegrityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.IntegrityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.IntegrityGrammar.exactForm c ++ "\t" ++ SFT.Computation.IntegrityGrammar.decisionReason c)


  for c in SFT.Computation.AuthenticationGrammar.candidates do
    IO.println ("AuthenticationGrammar\t" ++ SFT.Computation.AuthenticationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AuthenticationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AuthenticationGrammar.exactForm c ++ "\t" ++ SFT.Computation.AuthenticationGrammar.decisionReason c)


  for c in SFT.Computation.HashingGrammar.candidates do
    IO.println ("HashingGrammar\t" ++ SFT.Computation.HashingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.HashingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.HashingGrammar.exactForm c ++ "\t" ++ SFT.Computation.HashingGrammar.decisionReason c)


  for c in SFT.Computation.CommitmentGrammar.candidates do
    IO.println ("CommitmentGrammar\t" ++ SFT.Computation.CommitmentGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.CommitmentGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.CommitmentGrammar.exactForm c ++ "\t" ++ SFT.Computation.CommitmentGrammar.decisionReason c)


  for c in SFT.Computation.SignatureGrammar.candidates do
    IO.println ("SignatureGrammar\t" ++ SFT.Computation.SignatureGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SignatureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SignatureGrammar.exactForm c ++ "\t" ++ SFT.Computation.SignatureGrammar.decisionReason c)


  for c in SFT.Computation.ProofKnowledgeGrammar.candidates do
    IO.println ("ProofKnowledgeGrammar\t" ++ SFT.Computation.ProofKnowledgeGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ProofKnowledgeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ProofKnowledgeGrammar.exactForm c ++ "\t" ++ SFT.Computation.ProofKnowledgeGrammar.decisionReason c)


  for c in SFT.Computation.ZeroKnowledgeGrammar.candidates do
    IO.println ("ZeroKnowledgeGrammar\t" ++ SFT.Computation.ZeroKnowledgeGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ZeroKnowledgeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ZeroKnowledgeGrammar.exactForm c ++ "\t" ++ SFT.Computation.ZeroKnowledgeGrammar.decisionReason c)


  for c in SFT.Computation.MultipartyGrammar.candidates do
    IO.println ("MultipartyGrammar\t" ++ SFT.Computation.MultipartyGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.MultipartyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.MultipartyGrammar.exactForm c ++ "\t" ++ SFT.Computation.MultipartyGrammar.decisionReason c)


  for c in SFT.Computation.AdversarialGrammar.candidates do
    IO.println ("AdversarialGrammar\t" ++ SFT.Computation.AdversarialGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AdversarialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AdversarialGrammar.exactForm c ++ "\t" ++ SFT.Computation.AdversarialGrammar.decisionReason c)


  for c in SFT.Computation.SecurityDefinitionGrammar.candidates do
    IO.println ("SecurityDefinitionGrammar\t" ++ SFT.Computation.SecurityDefinitionGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SecurityDefinitionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SecurityDefinitionGrammar.exactForm c ++ "\t" ++ SFT.Computation.SecurityDefinitionGrammar.decisionReason c)


  for c in SFT.Computation.PostQuantumBoundaryGrammar.candidates do
    IO.println ("PostQuantumBoundaryGrammar\t" ++ SFT.Computation.PostQuantumBoundaryGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.PostQuantumBoundaryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.PostQuantumBoundaryGrammar.exactForm c ++ "\t" ++ SFT.Computation.PostQuantumBoundaryGrammar.decisionReason c)


  for c in SFT.Computation.InferenceGrammar.candidates do
    IO.println ("InferenceGrammar\t" ++ SFT.Computation.InferenceGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.InferenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.InferenceGrammar.exactForm c ++ "\t" ++ SFT.Computation.InferenceGrammar.decisionReason c)


  for c in SFT.Computation.ClassificationPredictionGrammar.candidates do
    IO.println ("ClassificationPredictionGrammar\t" ++ SFT.Computation.ClassificationPredictionGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ClassificationPredictionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ClassificationPredictionGrammar.exactForm c ++ "\t" ++ SFT.Computation.ClassificationPredictionGrammar.decisionReason c)


  for c in SFT.Computation.RepresentationLearningGrammar.candidates do
    IO.println ("RepresentationLearningGrammar\t" ++ SFT.Computation.RepresentationLearningGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.RepresentationLearningGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.RepresentationLearningGrammar.exactForm c ++ "\t" ++ SFT.Computation.RepresentationLearningGrammar.decisionReason c)


  for c in SFT.Computation.GeneralizationGrammar.candidates do
    IO.println ("GeneralizationGrammar\t" ++ SFT.Computation.GeneralizationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.GeneralizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.GeneralizationGrammar.exactForm c ++ "\t" ++ SFT.Computation.GeneralizationGrammar.decisionReason c)


  for c in SFT.Computation.SampleComplexityGrammar.candidates do
    IO.println ("SampleComplexityGrammar\t" ++ SFT.Computation.SampleComplexityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SampleComplexityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SampleComplexityGrammar.exactForm c ++ "\t" ++ SFT.Computation.SampleComplexityGrammar.decisionReason c)


  for c in SFT.Computation.LearningOptimizationGrammar.candidates do
    IO.println ("LearningOptimizationGrammar\t" ++ SFT.Computation.LearningOptimizationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.LearningOptimizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.LearningOptimizationGrammar.exactForm c ++ "\t" ++ SFT.Computation.LearningOptimizationGrammar.decisionReason c)


  for c in SFT.Computation.ComputationalInductionGrammar.candidates do
    IO.println ("ComputationalInductionGrammar\t" ++ SFT.Computation.ComputationalInductionGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ComputationalInductionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ComputationalInductionGrammar.exactForm c ++ "\t" ++ SFT.Computation.ComputationalInductionGrammar.decisionReason c)


  for c in SFT.Computation.SearchPlanningGrammar.candidates do
    IO.println ("SearchPlanningGrammar\t" ++ SFT.Computation.SearchPlanningGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SearchPlanningGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SearchPlanningGrammar.exactForm c ++ "\t" ++ SFT.Computation.SearchPlanningGrammar.decisionReason c)


  for c in SFT.Computation.ReinforcementGrammar.candidates do
    IO.println ("ReinforcementGrammar\t" ++ SFT.Computation.ReinforcementGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ReinforcementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ReinforcementGrammar.exactForm c ++ "\t" ++ SFT.Computation.ReinforcementGrammar.decisionReason c)


  for c in SFT.Computation.MultiAgentGrammar.candidates do
    IO.println ("MultiAgentGrammar\t" ++ SFT.Computation.MultiAgentGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.MultiAgentGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.MultiAgentGrammar.exactForm c ++ "\t" ++ SFT.Computation.MultiAgentGrammar.decisionReason c)


  for c in SFT.Computation.AdaptationGrammar.candidates do
    IO.println ("AdaptationGrammar\t" ++ SFT.Computation.AdaptationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.AdaptationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.AdaptationGrammar.exactForm c ++ "\t" ++ SFT.Computation.AdaptationGrammar.decisionReason c)


  for c in SFT.Computation.LearningLimitsGrammar.candidates do
    IO.println ("LearningLimitsGrammar\t" ++ SFT.Computation.LearningLimitsGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.LearningLimitsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.LearningLimitsGrammar.exactForm c ++ "\t" ++ SFT.Computation.LearningLimitsGrammar.decisionReason c)


  for c in SFT.Computation.InterpretabilityGrammar.candidates do
    IO.println ("InterpretabilityGrammar\t" ++ SFT.Computation.InterpretabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.InterpretabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.InterpretabilityGrammar.exactForm c ++ "\t" ++ SFT.Computation.InterpretabilityGrammar.decisionReason c)


  for c in SFT.Computation.ClassicalLearningGrammar.candidates do
    IO.println ("ClassicalLearningGrammar\t" ++ SFT.Computation.ClassicalLearningGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ClassicalLearningGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ClassicalLearningGrammar.exactForm c ++ "\t" ++ SFT.Computation.ClassicalLearningGrammar.decisionReason c)


  for c in SFT.Physics.CapabilityGrammar.candidates do
    IO.println ("CapabilityGrammar\t" ++ SFT.Physics.CapabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CapabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CapabilityGrammar.exactForm c ++ "\t" ++ SFT.Physics.CapabilityGrammar.decisionReason c)

  for c in SFT.Computation.ExactApproximateGrammar.candidates do
    IO.println ("ExactApproximateGrammar\t" ++ SFT.Computation.ExactApproximateGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ExactApproximateGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ExactApproximateGrammar.exactForm c ++ "\t" ++ SFT.Computation.ExactApproximateGrammar.decisionReason c)

  for c in SFT.Computation.StabilityGrammar.candidates do
    IO.println ("StabilityGrammar\t" ++ SFT.Computation.StabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.StabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.StabilityGrammar.exactForm c ++ "\t" ++ SFT.Computation.StabilityGrammar.decisionReason c)

  for c in SFT.Computation.ErrorPropagationGrammar.candidates do
    IO.println ("ErrorPropagationGrammar\t" ++ SFT.Computation.ErrorPropagationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ErrorPropagationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ErrorPropagationGrammar.exactForm c ++ "\t" ++ SFT.Computation.ErrorPropagationGrammar.decisionReason c)

  for c in SFT.Computation.DiscretizationGrammar.candidates do
    IO.println ("DiscretizationGrammar\t" ++ SFT.Computation.DiscretizationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.DiscretizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.DiscretizationGrammar.exactForm c ++ "\t" ++ SFT.Computation.DiscretizationGrammar.decisionReason c)

  for c in SFT.Computation.ConvergenceGrammar.candidates do
    IO.println ("ConvergenceGrammar\t" ++ SFT.Computation.ConvergenceGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ConvergenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ConvergenceGrammar.exactForm c ++ "\t" ++ SFT.Computation.ConvergenceGrammar.decisionReason c)

  for c in SFT.Computation.ScientificSymbolicGrammar.candidates do
    IO.println ("ScientificSymbolicGrammar\t" ++ SFT.Computation.ScientificSymbolicGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ScientificSymbolicGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ScientificSymbolicGrammar.exactForm c ++ "\t" ++ SFT.Computation.ScientificSymbolicGrammar.decisionReason c)

  for c in SFT.Computation.SimulationGrammar.candidates do
    IO.println ("SimulationGrammar\t" ++ SFT.Computation.SimulationGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.SimulationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.SimulationGrammar.exactForm c ++ "\t" ++ SFT.Computation.SimulationGrammar.decisionReason c)

  for c in SFT.Computation.ComputationalDynamicsGrammar.candidates do
    IO.println ("ComputationalDynamicsGrammar\t" ++ SFT.Computation.ComputationalDynamicsGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ComputationalDynamicsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ComputationalDynamicsGrammar.exactForm c ++ "\t" ++ SFT.Computation.ComputationalDynamicsGrammar.decisionReason c)

  for c in SFT.Computation.InverseProblemGrammar.candidates do
    IO.println ("InverseProblemGrammar\t" ++ SFT.Computation.InverseProblemGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.InverseProblemGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.InverseProblemGrammar.exactForm c ++ "\t" ++ SFT.Computation.InverseProblemGrammar.decisionReason c)

  for c in SFT.Computation.ComputationalStatisticsGrammar.candidates do
    IO.println ("ComputationalStatisticsGrammar\t" ++ SFT.Computation.ComputationalStatisticsGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ComputationalStatisticsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ComputationalStatisticsGrammar.exactForm c ++ "\t" ++ SFT.Computation.ComputationalStatisticsGrammar.decisionReason c)

  for c in SFT.Computation.HighDimensionalGrammar.candidates do
    IO.println ("HighDimensionalGrammar\t" ++ SFT.Computation.HighDimensionalGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.HighDimensionalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.HighDimensionalGrammar.exactForm c ++ "\t" ++ SFT.Computation.HighDimensionalGrammar.decisionReason c)

  for c in SFT.Computation.ManyBodyGrammar.candidates do
    IO.println ("ManyBodyGrammar\t" ++ SFT.Computation.ManyBodyGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.ManyBodyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.ManyBodyGrammar.exactForm c ++ "\t" ++ SFT.Computation.ManyBodyGrammar.decisionReason c)

  for c in SFT.Computation.MathematicalModellingGrammar.candidates do
    IO.println ("MathematicalModellingGrammar\t" ++ SFT.Computation.MathematicalModellingGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.MathematicalModellingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.MathematicalModellingGrammar.exactForm c ++ "\t" ++ SFT.Computation.MathematicalModellingGrammar.decisionReason c)

  for c in SFT.QuantumComputation.ReversibleGrammar.candidates do
    IO.println ("ReversibleGrammar\t" ++ SFT.QuantumComputation.ReversibleGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.ReversibleGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.ReversibleGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.ReversibleGrammar.decisionReason c)

  for c in SFT.QuantumComputation.InformationUnitGrammar.candidates do
    IO.println ("InformationUnitGrammar\t" ++ SFT.QuantumComputation.InformationUnitGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.InformationUnitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.InformationUnitGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.InformationUnitGrammar.decisionReason c)

  for c in SFT.QuantumComputation.StateCompositionGrammar.candidates do
    IO.println ("StateCompositionGrammar\t" ++ SFT.QuantumComputation.StateCompositionGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.StateCompositionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.StateCompositionGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.StateCompositionGrammar.decisionReason c)

  for c in SFT.QuantumComputation.SuperpositionGrammar.candidates do
    IO.println ("SuperpositionGrammar\t" ++ SFT.QuantumComputation.SuperpositionGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.SuperpositionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.SuperpositionGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.SuperpositionGrammar.decisionReason c)

  for c in SFT.QuantumComputation.PhaseInterferenceGrammar.candidates do
    IO.println ("PhaseInterferenceGrammar\t" ++ SFT.QuantumComputation.PhaseInterferenceGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.PhaseInterferenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.PhaseInterferenceGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.PhaseInterferenceGrammar.decisionReason c)

  for c in SFT.QuantumComputation.EntanglementGrammar.candidates do
    IO.println ("EntanglementGrammar\t" ++ SFT.QuantumComputation.EntanglementGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.EntanglementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.EntanglementGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.EntanglementGrammar.decisionReason c)

  for c in SFT.QuantumComputation.MeasurementGrammar.candidates do
    IO.println ("MeasurementGrammar\t" ++ SFT.QuantumComputation.MeasurementGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.MeasurementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.MeasurementGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.MeasurementGrammar.decisionReason c)

  for c in SFT.QuantumComputation.GateLawGrammar.candidates do
    IO.println ("GateLawGrammar\t" ++ SFT.QuantumComputation.GateLawGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.GateLawGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.GateLawGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.GateLawGrammar.decisionReason c)

  for c in SFT.QuantumComputation.CircuitGrammar.candidates do
    IO.println ("CircuitGrammar\t" ++ SFT.QuantumComputation.CircuitGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.CircuitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.CircuitGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.CircuitGrammar.decisionReason c)

  for c in SFT.QuantumComputation.UniversalityGrammar.candidates do
    IO.println ("UniversalityGrammar\t" ++ SFT.QuantumComputation.UniversalityGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.UniversalityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.UniversalityGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.UniversalityGrammar.decisionReason c)

  for c in SFT.QuantumComputation.AlgorithmsGrammar.candidates do
    IO.println ("AlgorithmsGrammar\t" ++ SFT.QuantumComputation.AlgorithmsGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.AlgorithmsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.AlgorithmsGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.AlgorithmsGrammar.decisionReason c)

  for c in SFT.QuantumComputation.ComplexityGrammar.candidates do
    IO.println ("ComplexityGrammar\t" ++ SFT.QuantumComputation.ComplexityGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.ComplexityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.ComplexityGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.ComplexityGrammar.decisionReason c)

  for c in SFT.QuantumComputation.CommunicationGrammar.candidates do
    IO.println ("CommunicationGrammar\t" ++ SFT.QuantumComputation.CommunicationGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.CommunicationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.CommunicationGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.CommunicationGrammar.decisionReason c)

  for c in SFT.QuantumComputation.CodingGrammar.candidates do
    IO.println ("CodingGrammar\t" ++ SFT.QuantumComputation.CodingGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.CodingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.CodingGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.CodingGrammar.decisionReason c)

  for c in SFT.QuantumComputation.ErrorCorrectionGrammar.candidates do
    IO.println ("ErrorCorrectionGrammar\t" ++ SFT.QuantumComputation.ErrorCorrectionGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.ErrorCorrectionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.ErrorCorrectionGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.ErrorCorrectionGrammar.decisionReason c)

  for c in SFT.QuantumComputation.FaultToleranceGrammar.candidates do
    IO.println ("FaultToleranceGrammar\t" ++ SFT.QuantumComputation.FaultToleranceGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.FaultToleranceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.FaultToleranceGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.FaultToleranceGrammar.decisionReason c)

  for c in SFT.QuantumComputation.SimulationGrammar.candidates do
    IO.println ("SimulationGrammar\t" ++ SFT.QuantumComputation.SimulationGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.SimulationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.SimulationGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.SimulationGrammar.decisionReason c)

  for c in SFT.QuantumComputation.VerificationGrammar.candidates do
    IO.println ("VerificationGrammar\t" ++ SFT.QuantumComputation.VerificationGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.VerificationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.VerificationGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.VerificationGrammar.decisionReason c)

  for c in SFT.QuantumComputation.LearningGrammar.candidates do
    IO.println ("LearningGrammar\t" ++ SFT.QuantumComputation.LearningGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.LearningGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.LearningGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.LearningGrammar.decisionReason c)

  for c in SFT.QuantumComputation.ClassicalCorrespondenceGrammar.candidates do
    IO.println ("ClassicalCorrespondenceGrammar\t" ++ SFT.QuantumComputation.ClassicalCorrespondenceGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.ClassicalCorrespondenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.ClassicalCorrespondenceGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.ClassicalCorrespondenceGrammar.decisionReason c)

  for c in SFT.QuantumComputation.LimitsGrammar.candidates do
    IO.println ("LimitsGrammar\t" ++ SFT.QuantumComputation.LimitsGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.LimitsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.LimitsGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.LimitsGrammar.decisionReason c)

  for c in SFT.Physics.TargetCustodyGrammar.candidates do
    IO.println ("TargetCustodyGrammar\t" ++ SFT.Physics.TargetCustodyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TargetCustodyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TargetCustodyGrammar.exactForm c ++ "\t" ++ SFT.Physics.TargetCustodyGrammar.decisionReason c)

  for c in SFT.Physics.HostileGrammar.candidates do
    IO.println ("HostileGrammar\t" ++ SFT.Physics.HostileGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.HostileGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.HostileGrammar.exactForm c ++ "\t" ++ SFT.Physics.HostileGrammar.decisionReason c)

  for c in SFT.Physics.ObservationGrammar.candidates do
    IO.println ("ObservationGrammar\t" ++ SFT.Physics.ObservationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ObservationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ObservationGrammar.exactForm c ++ "\t" ++ SFT.Physics.ObservationGrammar.decisionReason c)


  for c in SFT.Physics.VacuumFloorGrammar.candidates do
    IO.println ("VacuumFloorGrammar\t" ++ SFT.Physics.VacuumFloorGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumFloorGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumFloorGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumFloorGrammar.decisionReason c)

  for c in SFT.Physics.QuarkChannelsGrammar.candidates do
    IO.println ("QuarkChannelsGrammar\t" ++ SFT.Physics.QuarkChannelsGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.QuarkChannelsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.QuarkChannelsGrammar.exactForm c ++ "\t" ++ SFT.Physics.QuarkChannelsGrammar.decisionReason c)

  for c in SFT.Physics.QuarkCubicsGrammar.candidates do
    IO.println ("QuarkCubicsGrammar\t" ++ SFT.Physics.QuarkCubicsGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.QuarkCubicsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.QuarkCubicsGrammar.exactForm c ++ "\t" ++ SFT.Physics.QuarkCubicsGrammar.decisionReason c)


  for c in SFT.Mathematics.OrbitGrammar.candidates do
    IO.println ("OrbitGrammar\t" ++ SFT.Mathematics.OrbitGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.OrbitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.OrbitGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.OrbitGrammar.decisionReason c)

  for c in SFT.Physics.ForceLadderGrammar.candidates do
    IO.println ("ForceLadderGrammar\t" ++ SFT.Physics.ForceLadderGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ForceLadderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ForceLadderGrammar.exactForm c ++ "\t" ++ SFT.Physics.ForceLadderGrammar.decisionReason c)

  for c in SFT.Physics.PlanckBaseGrammar.candidates do
    IO.println ("PlanckBaseGrammar\t" ++ SFT.Physics.PlanckBaseGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PlanckBaseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PlanckBaseGrammar.exactForm c ++ "\t" ++ SFT.Physics.PlanckBaseGrammar.decisionReason c)


  for c in SFT.Mathematics.ExactRelationsGrammar.candidates do
    IO.println ("ExactRelationsGrammar\t" ++ SFT.Mathematics.ExactRelationsGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.ExactRelationsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.ExactRelationsGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.ExactRelationsGrammar.decisionReason c)


  for c in SFT.Mathematics.LimitContinuumGrammar.candidates do
    IO.println ("LimitContinuumGrammar\t" ++ SFT.Mathematics.LimitContinuumGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.LimitContinuumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.LimitContinuumGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.LimitContinuumGrammar.decisionReason c)


  for c in SFT.Physics.VacuumOddGrammar.candidates do
    IO.println ("VacuumOddGrammar\t" ++ SFT.Physics.VacuumOddGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumOddGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumOddGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumOddGrammar.decisionReason c)

  for c in SFT.Physics.QuantityGrammar.candidates do
    IO.println ("QuantityGrammar\t" ++ SFT.Physics.QuantityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.QuantityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.QuantityGrammar.exactForm c ++ "\t" ++ SFT.Physics.QuantityGrammar.decisionReason c)

  for c in SFT.Physics.DimensionGrammar.candidates do
    IO.println ("DimensionGrammar\t" ++ SFT.Physics.DimensionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DimensionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DimensionGrammar.exactForm c ++ "\t" ++ SFT.Physics.DimensionGrammar.decisionReason c)

  for c in SFT.Physics.UnitGrammar.candidates do
    IO.println ("UnitGrammar\t" ++ SFT.Physics.UnitGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.UnitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.UnitGrammar.exactForm c ++ "\t" ++ SFT.Physics.UnitGrammar.decisionReason c)

  for c in SFT.Physics.RealizationGrammar.candidates do
    IO.println ("RealizationGrammar\t" ++ SFT.Physics.RealizationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.RealizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.RealizationGrammar.exactForm c ++ "\t" ++ SFT.Physics.RealizationGrammar.decisionReason c)

  for c in SFT.Physics.ValueRecordGrammar.candidates do
    IO.println ("ValueRecordGrammar\t" ++ SFT.Physics.ValueRecordGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ValueRecordGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ValueRecordGrammar.exactForm c ++ "\t" ++ SFT.Physics.ValueRecordGrammar.decisionReason c)

  for c in SFT.Physics.UncertaintyGrammar.candidates do
    IO.println ("UncertaintyGrammar\t" ++ SFT.Physics.UncertaintyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.UncertaintyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.UncertaintyGrammar.exactForm c ++ "\t" ++ SFT.Physics.UncertaintyGrammar.decisionReason c)

  for c in SFT.Physics.CalibrationGrammar.candidates do
    IO.println ("CalibrationGrammar\t" ++ SFT.Physics.CalibrationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CalibrationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CalibrationGrammar.exactForm c ++ "\t" ++ SFT.Physics.CalibrationGrammar.decisionReason c)

  for c in SFT.Physics.ConsistencyGrammar.candidates do
    IO.println ("ConsistencyGrammar\t" ++ SFT.Physics.ConsistencyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ConsistencyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ConsistencyGrammar.exactForm c ++ "\t" ++ SFT.Physics.ConsistencyGrammar.decisionReason c)

  for c in SFT.Physics.EventGrammar.candidates do
    IO.println ("EventGrammar\t" ++ SFT.Physics.EventGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.EventGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.EventGrammar.exactForm c ++ "\t" ++ SFT.Physics.EventGrammar.decisionReason c)

  for c in SFT.Physics.DurationGrammar.candidates do
    IO.println ("DurationGrammar\t" ++ SFT.Physics.DurationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DurationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DurationGrammar.exactForm c ++ "\t" ++ SFT.Physics.DurationGrammar.decisionReason c)

  for c in SFT.Physics.DisplacementGrammar.candidates do
    IO.println ("DisplacementGrammar\t" ++ SFT.Physics.DisplacementGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DisplacementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DisplacementGrammar.exactForm c ++ "\t" ++ SFT.Physics.DisplacementGrammar.decisionReason c)

  for c in SFT.Physics.VelocityGrammar.candidates do
    IO.println ("VelocityGrammar\t" ++ SFT.Physics.VelocityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VelocityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VelocityGrammar.exactForm c ++ "\t" ++ SFT.Physics.VelocityGrammar.decisionReason c)

  for c in SFT.Physics.DarkBaryonGrammar.candidates do
    IO.println ("DarkBaryonGrammar\t" ++ SFT.Physics.DarkBaryonGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DarkBaryonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DarkBaryonGrammar.exactForm c ++ "\t" ++ SFT.Physics.DarkBaryonGrammar.decisionReason c)

  for c in SFT.Physics.AccelerationGrammar.candidates do
    IO.println ("AccelerationGrammar\t" ++ SFT.Physics.AccelerationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.AccelerationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.AccelerationGrammar.exactForm c ++ "\t" ++ SFT.Physics.AccelerationGrammar.decisionReason c)

  for c in SFT.Physics.InertiaGrammar.candidates do
    IO.println ("InertiaGrammar\t" ++ SFT.Physics.InertiaGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.InertiaGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.InertiaGrammar.exactForm c ++ "\t" ++ SFT.Physics.InertiaGrammar.decisionReason c)

  for c in SFT.Physics.MomentumGrammar.candidates do
    IO.println ("MomentumGrammar\t" ++ SFT.Physics.MomentumGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MomentumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MomentumGrammar.exactForm c ++ "\t" ++ SFT.Physics.MomentumGrammar.decisionReason c)

  for c in SFT.Physics.ForceGrammar.candidates do
    IO.println ("ForceGrammar\t" ++ SFT.Physics.ForceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ForceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ForceGrammar.exactForm c ++ "\t" ++ SFT.Physics.ForceGrammar.decisionReason c)

  for c in SFT.Physics.WorkEnergyGrammar.candidates do
    IO.println ("WorkEnergyGrammar\t" ++ SFT.Physics.WorkEnergyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.WorkEnergyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.WorkEnergyGrammar.exactForm c ++ "\t" ++ SFT.Physics.WorkEnergyGrammar.decisionReason c)

  for c in SFT.Physics.PowerGrammar.candidates do
    IO.println ("PowerGrammar\t" ++ SFT.Physics.PowerGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PowerGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PowerGrammar.exactForm c ++ "\t" ++ SFT.Physics.PowerGrammar.decisionReason c)

  for c in SFT.Physics.AngularMotionGrammar.candidates do
    IO.println ("AngularMotionGrammar\t" ++ SFT.Physics.AngularMotionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.AngularMotionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.AngularMotionGrammar.exactForm c ++ "\t" ++ SFT.Physics.AngularMotionGrammar.decisionReason c)

  for c in SFT.Physics.AngularMomentumGrammar.candidates do
    IO.println ("AngularMomentumGrammar\t" ++ SFT.Physics.AngularMomentumGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.AngularMomentumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.AngularMomentumGrammar.exactForm c ++ "\t" ++ SFT.Physics.AngularMomentumGrammar.decisionReason c)

  for c in SFT.Physics.CompositeCentreGrammar.candidates do
    IO.println ("CompositeCentreGrammar\t" ++ SFT.Physics.CompositeCentreGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CompositeCentreGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CompositeCentreGrammar.exactForm c ++ "\t" ++ SFT.Physics.CompositeCentreGrammar.decisionReason c)

  for c in SFT.Physics.ConservationGrammar.candidates do
    IO.println ("ConservationGrammar\t" ++ SFT.Physics.ConservationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ConservationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ConservationGrammar.exactForm c ++ "\t" ++ SFT.Physics.ConservationGrammar.decisionReason c)

  for c in SFT.Physics.ConstraintOscillationGrammar.candidates do
    IO.println ("ConstraintOscillationGrammar\t" ++ SFT.Physics.ConstraintOscillationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ConstraintOscillationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ConstraintOscillationGrammar.exactForm c ++ "\t" ++ SFT.Physics.ConstraintOscillationGrammar.decisionReason c)

  for c in SFT.Physics.SourceResponseGrammar.candidates do
    IO.println ("SourceResponseGrammar\t" ++ SFT.Physics.SourceResponseGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SourceResponseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SourceResponseGrammar.exactForm c ++ "\t" ++ SFT.Physics.SourceResponseGrammar.decisionReason c)

  for c in SFT.Physics.GeometricDilutionGrammar.candidates do
    IO.println ("GeometricDilutionGrammar\t" ++ SFT.Physics.GeometricDilutionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GeometricDilutionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GeometricDilutionGrammar.exactForm c ++ "\t" ++ SFT.Physics.GeometricDilutionGrammar.decisionReason c)

  for c in SFT.Physics.GravitationGrammar.candidates do
    IO.println ("GravitationGrammar\t" ++ SFT.Physics.GravitationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravitationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravitationGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravitationGrammar.decisionReason c)

  for c in SFT.Physics.ElectricDistinctionGrammar.candidates do
    IO.println ("ElectricDistinctionGrammar\t" ++ SFT.Physics.ElectricDistinctionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ElectricDistinctionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ElectricDistinctionGrammar.exactForm c ++ "\t" ++ SFT.Physics.ElectricDistinctionGrammar.decisionReason c)

  for c in SFT.Physics.ElectricPotentialGrammar.candidates do
    IO.println ("ElectricPotentialGrammar\t" ++ SFT.Physics.ElectricPotentialGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ElectricPotentialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ElectricPotentialGrammar.exactForm c ++ "\t" ++ SFT.Physics.ElectricPotentialGrammar.decisionReason c)

  for c in SFT.Physics.HubbleGrammar.candidates do
    IO.println ("HubbleGrammar\t" ++ SFT.Physics.HubbleGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.HubbleGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.HubbleGrammar.exactForm c ++ "\t" ++ SFT.Physics.HubbleGrammar.decisionReason c)

  for c in SFT.Physics.MagneticGrammar.candidates do
    IO.println ("MagneticGrammar\t" ++ SFT.Physics.MagneticGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MagneticGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MagneticGrammar.exactForm c ++ "\t" ++ SFT.Physics.MagneticGrammar.decisionReason c)

  for c in SFT.Physics.InductionGrammar.candidates do
    IO.println ("InductionGrammar\t" ++ SFT.Physics.InductionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.InductionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.InductionGrammar.exactForm c ++ "\t" ++ SFT.Physics.InductionGrammar.decisionReason c)

  for c in SFT.Physics.ElectromagneticGrammar.candidates do
    IO.println ("ElectromagneticGrammar\t" ++ SFT.Physics.ElectromagneticGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ElectromagneticGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ElectromagneticGrammar.exactForm c ++ "\t" ++ SFT.Physics.ElectromagneticGrammar.decisionReason c)

  for c in SFT.Physics.GaugeEquivalenceGrammar.candidates do
    IO.println ("GaugeEquivalenceGrammar\t" ++ SFT.Physics.GaugeEquivalenceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GaugeEquivalenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GaugeEquivalenceGrammar.exactForm c ++ "\t" ++ SFT.Physics.GaugeEquivalenceGrammar.decisionReason c)

  for c in SFT.Physics.LocalityGrammar.candidates do
    IO.println ("LocalityGrammar\t" ++ SFT.Physics.LocalityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.LocalityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.LocalityGrammar.exactForm c ++ "\t" ++ SFT.Physics.LocalityGrammar.decisionReason c)

  for c in SFT.Physics.ElectroweakTerminalGrammar.candidates do
    IO.println ("ElectroweakTerminalGrammar\t" ++ SFT.Physics.ElectroweakTerminalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ElectroweakTerminalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ElectroweakTerminalGrammar.exactForm c ++ "\t" ++ SFT.Physics.ElectroweakTerminalGrammar.decisionReason c)

  for c in SFT.Physics.RadiationGrammar.candidates do
    IO.println ("RadiationGrammar\t" ++ SFT.Physics.RadiationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.RadiationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.RadiationGrammar.exactForm c ++ "\t" ++ SFT.Physics.RadiationGrammar.decisionReason c)

  for c in SFT.Physics.InteractionClassesGrammar.candidates do
    IO.println ("InteractionClassesGrammar\t" ++ SFT.Physics.InteractionClassesGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.InteractionClassesGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.InteractionClassesGrammar.exactForm c ++ "\t" ++ SFT.Physics.InteractionClassesGrammar.decisionReason c)

  for c in SFT.Physics.SourceContinuityGrammar.candidates do
    IO.println ("SourceContinuityGrammar\t" ++ SFT.Physics.SourceContinuityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SourceContinuityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SourceContinuityGrammar.exactForm c ++ "\t" ++ SFT.Physics.SourceContinuityGrammar.decisionReason c)

  for c in SFT.Physics.ActionReactionGrammar.candidates do
    IO.println ("ActionReactionGrammar\t" ++ SFT.Physics.ActionReactionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ActionReactionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ActionReactionGrammar.exactForm c ++ "\t" ++ SFT.Physics.ActionReactionGrammar.decisionReason c)

  for c in SFT.Physics.PeriodFrequencyGrammar.candidates do
    IO.println ("PeriodFrequencyGrammar\t" ++ SFT.Physics.PeriodFrequencyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PeriodFrequencyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PeriodFrequencyGrammar.exactForm c ++ "\t" ++ SFT.Physics.PeriodFrequencyGrammar.decisionReason c)

  for c in SFT.Physics.PropagationGrammar.candidates do
    IO.println ("PropagationGrammar\t" ++ SFT.Physics.PropagationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PropagationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PropagationGrammar.exactForm c ++ "\t" ++ SFT.Physics.PropagationGrammar.decisionReason c)

  for c in SFT.Physics.SpeedRelationGrammar.candidates do
    IO.println ("SpeedRelationGrammar\t" ++ SFT.Physics.SpeedRelationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpeedRelationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpeedRelationGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpeedRelationGrammar.decisionReason c)

  for c in SFT.Physics.SuperpositionGrammar.candidates do
    IO.println ("SuperpositionGrammar\t" ++ SFT.Physics.SuperpositionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SuperpositionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SuperpositionGrammar.exactForm c ++ "\t" ++ SFT.Physics.SuperpositionGrammar.decisionReason c)

  for c in SFT.Physics.InterferenceGrammar.candidates do
    IO.println ("InterferenceGrammar\t" ++ SFT.Physics.InterferenceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.InterferenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.InterferenceGrammar.exactForm c ++ "\t" ++ SFT.Physics.InterferenceGrammar.decisionReason c)

  for c in SFT.Physics.DiffractionGrammar.candidates do
    IO.println ("DiffractionGrammar\t" ++ SFT.Physics.DiffractionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DiffractionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DiffractionGrammar.exactForm c ++ "\t" ++ SFT.Physics.DiffractionGrammar.decisionReason c)

  for c in SFT.Physics.PolarizationGrammar.candidates do
    IO.println ("PolarizationGrammar\t" ++ SFT.Physics.PolarizationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PolarizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PolarizationGrammar.exactForm c ++ "\t" ++ SFT.Physics.PolarizationGrammar.decisionReason c)

  for c in SFT.Physics.DispersionGrammar.candidates do
    IO.println ("DispersionGrammar\t" ++ SFT.Physics.DispersionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DispersionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DispersionGrammar.exactForm c ++ "\t" ++ SFT.Physics.DispersionGrammar.decisionReason c)

  for c in SFT.Physics.ResonanceGrammar.candidates do
    IO.println ("ResonanceGrammar\t" ++ SFT.Physics.ResonanceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ResonanceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ResonanceGrammar.exactForm c ++ "\t" ++ SFT.Physics.ResonanceGrammar.decisionReason c)

  for c in SFT.Physics.EnergyMomentumGrammar.candidates do
    IO.println ("EnergyMomentumGrammar\t" ++ SFT.Physics.EnergyMomentumGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.EnergyMomentumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.EnergyMomentumGrammar.exactForm c ++ "\t" ++ SFT.Physics.EnergyMomentumGrammar.decisionReason c)

  for c in SFT.Physics.PhysicalStateGrammar.candidates do
    IO.println ("PhysicalStateGrammar\t" ++ SFT.Physics.PhysicalStateGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PhysicalStateGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PhysicalStateGrammar.exactForm c ++ "\t" ++ SFT.Physics.PhysicalStateGrammar.decisionReason c)

  for c in SFT.Physics.EvolutionGrammar.candidates do
    IO.println ("EvolutionGrammar\t" ++ SFT.Physics.EvolutionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.EvolutionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.EvolutionGrammar.exactForm c ++ "\t" ++ SFT.Physics.EvolutionGrammar.decisionReason c)

  for c in SFT.Physics.ObservableGrammar.candidates do
    IO.println ("ObservableGrammar\t" ++ SFT.Physics.ObservableGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ObservableGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ObservableGrammar.exactForm c ++ "\t" ++ SFT.Physics.ObservableGrammar.decisionReason c)

  for c in SFT.Physics.WeightGrammar.candidates do
    IO.println ("WeightGrammar\t" ++ SFT.Physics.WeightGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.WeightGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.WeightGrammar.exactForm c ++ "\t" ++ SFT.Physics.WeightGrammar.decisionReason c)

  for c in SFT.Physics.IncompatibilityGrammar.candidates do
    IO.println ("IncompatibilityGrammar\t" ++ SFT.Physics.IncompatibilityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.IncompatibilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.IncompatibilityGrammar.exactForm c ++ "\t" ++ SFT.Physics.IncompatibilityGrammar.decisionReason c)

  for c in SFT.Physics.SpinGrammar.candidates do
    IO.println ("SpinGrammar\t" ++ SFT.Physics.SpinGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpinGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpinGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpinGrammar.decisionReason c)

  for c in SFT.Physics.IndistinguishabilityGrammar.candidates do
    IO.println ("IndistinguishabilityGrammar\t" ++ SFT.Physics.IndistinguishabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.IndistinguishabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.IndistinguishabilityGrammar.exactForm c ++ "\t" ++ SFT.Physics.IndistinguishabilityGrammar.decisionReason c)

  for c in SFT.Physics.ExclusionGrammar.candidates do
    IO.println ("ExclusionGrammar\t" ++ SFT.Physics.ExclusionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ExclusionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ExclusionGrammar.exactForm c ++ "\t" ++ SFT.Physics.ExclusionGrammar.decisionReason c)

  for c in SFT.Physics.TunnellingGrammar.candidates do
    IO.println ("TunnellingGrammar\t" ++ SFT.Physics.TunnellingGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TunnellingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TunnellingGrammar.exactForm c ++ "\t" ++ SFT.Physics.TunnellingGrammar.decisionReason c)

  for c in SFT.Physics.DiscreteSpectraGrammar.candidates do
    IO.println ("DiscreteSpectraGrammar\t" ++ SFT.Physics.DiscreteSpectraGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DiscreteSpectraGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DiscreteSpectraGrammar.exactForm c ++ "\t" ++ SFT.Physics.DiscreteSpectraGrammar.decisionReason c)

  for c in SFT.Physics.EntanglementGrammar.candidates do
    IO.println ("EntanglementGrammar\t" ++ SFT.Physics.EntanglementGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.EntanglementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.EntanglementGrammar.exactForm c ++ "\t" ++ SFT.Physics.EntanglementGrammar.decisionReason c)

  for c in SFT.Physics.BellGrammar.candidates do
    IO.println ("BellGrammar\t" ++ SFT.Physics.BellGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.BellGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.BellGrammar.exactForm c ++ "\t" ++ SFT.Physics.BellGrammar.decisionReason c)

  for c in SFT.Physics.ContextualityGrammar.candidates do
    IO.println ("ContextualityGrammar\t" ++ SFT.Physics.ContextualityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ContextualityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ContextualityGrammar.exactForm c ++ "\t" ++ SFT.Physics.ContextualityGrammar.decisionReason c)

  for c in SFT.Physics.DecoherenceGrammar.candidates do
    IO.println ("DecoherenceGrammar\t" ++ SFT.Physics.DecoherenceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DecoherenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DecoherenceGrammar.exactForm c ++ "\t" ++ SFT.Physics.DecoherenceGrammar.decisionReason c)

  for c in SFT.Physics.ClassicalLimitGrammar.candidates do
    IO.println ("ClassicalLimitGrammar\t" ++ SFT.Physics.ClassicalLimitGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ClassicalLimitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ClassicalLimitGrammar.exactForm c ++ "\t" ++ SFT.Physics.ClassicalLimitGrammar.decisionReason c)

  for c in SFT.Physics.NoSignallingGrammar.candidates do
    IO.println ("NoSignallingGrammar\t" ++ SFT.Physics.NoSignallingGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NoSignallingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NoSignallingGrammar.exactForm c ++ "\t" ++ SFT.Physics.NoSignallingGrammar.decisionReason c)

  for c in SFT.Physics.MassEnergyGrammar.candidates do
    IO.println ("MassEnergyGrammar\t" ++ SFT.Physics.MassEnergyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MassEnergyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MassEnergyGrammar.exactForm c ++ "\t" ++ SFT.Physics.MassEnergyGrammar.decisionReason c)

  for c in SFT.Physics.ParticleAntiparticleGrammar.candidates do
    IO.println ("ParticleAntiparticleGrammar\t" ++ SFT.Physics.ParticleAntiparticleGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ParticleAntiparticleGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ParticleAntiparticleGrammar.exactForm c ++ "\t" ++ SFT.Physics.ParticleAntiparticleGrammar.decisionReason c)

  for c in SFT.Physics.FermionBosonGrammar.candidates do
    IO.println ("FermionBosonGrammar\t" ++ SFT.Physics.FermionBosonGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FermionBosonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FermionBosonGrammar.exactForm c ++ "\t" ++ SFT.Physics.FermionBosonGrammar.decisionReason c)

  for c in SFT.Physics.ConservedLabelsGrammar.candidates do
    IO.println ("ConservedLabelsGrammar\t" ++ SFT.Physics.ConservedLabelsGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ConservedLabelsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ConservedLabelsGrammar.exactForm c ++ "\t" ++ SFT.Physics.ConservedLabelsGrammar.decisionReason c)

  for c in SFT.Physics.ParticleSpectrumGrammar.candidates do
    IO.println ("ParticleSpectrumGrammar\t" ++ SFT.Physics.ParticleSpectrumGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ParticleSpectrumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ParticleSpectrumGrammar.exactForm c ++ "\t" ++ SFT.Physics.ParticleSpectrumGrammar.decisionReason c)

  for c in SFT.Physics.CompositeHadronsGrammar.candidates do
    IO.println ("CompositeHadronsGrammar\t" ++ SFT.Physics.CompositeHadronsGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CompositeHadronsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CompositeHadronsGrammar.exactForm c ++ "\t" ++ SFT.Physics.CompositeHadronsGrammar.decisionReason c)

  for c in SFT.Physics.ScatteringGrammar.candidates do
    IO.println ("ScatteringGrammar\t" ++ SFT.Physics.ScatteringGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ScatteringGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ScatteringGrammar.exactForm c ++ "\t" ++ SFT.Physics.ScatteringGrammar.decisionReason c)

  for c in SFT.Physics.DecayGrammar.candidates do
    IO.println ("DecayGrammar\t" ++ SFT.Physics.DecayGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DecayGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DecayGrammar.exactForm c ++ "\t" ++ SFT.Physics.DecayGrammar.decisionReason c)

  for c in SFT.Physics.StateMixingGrammar.candidates do
    IO.println ("StateMixingGrammar\t" ++ SFT.Physics.StateMixingGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.StateMixingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.StateMixingGrammar.exactForm c ++ "\t" ++ SFT.Physics.StateMixingGrammar.decisionReason c)

  for c in SFT.Physics.NuclearBindingGrammar.candidates do
    IO.println ("NuclearBindingGrammar\t" ++ SFT.Physics.NuclearBindingGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NuclearBindingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NuclearBindingGrammar.exactForm c ++ "\t" ++ SFT.Physics.NuclearBindingGrammar.decisionReason c)

  for c in SFT.Physics.NuclearLevelsGrammar.candidates do
    IO.println ("NuclearLevelsGrammar\t" ++ SFT.Physics.NuclearLevelsGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NuclearLevelsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NuclearLevelsGrammar.exactForm c ++ "\t" ++ SFT.Physics.NuclearLevelsGrammar.decisionReason c)

  for c in SFT.Physics.RadioactivityGrammar.candidates do
    IO.println ("RadioactivityGrammar\t" ++ SFT.Physics.RadioactivityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.RadioactivityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.RadioactivityGrammar.exactForm c ++ "\t" ++ SFT.Physics.RadioactivityGrammar.decisionReason c)

  for c in SFT.Physics.NuclearReactionsGrammar.candidates do
    IO.println ("NuclearReactionsGrammar\t" ++ SFT.Physics.NuclearReactionsGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NuclearReactionsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NuclearReactionsGrammar.exactForm c ++ "\t" ++ SFT.Physics.NuclearReactionsGrammar.decisionReason c)

  for c in SFT.Physics.FissionGrammar.candidates do
    IO.println ("FissionGrammar\t" ++ SFT.Physics.FissionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FissionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FissionGrammar.exactForm c ++ "\t" ++ SFT.Physics.FissionGrammar.decisionReason c)

  for c in SFT.Physics.FusionGrammar.candidates do
    IO.println ("FusionGrammar\t" ++ SFT.Physics.FusionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FusionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FusionGrammar.exactForm c ++ "\t" ++ SFT.Physics.FusionGrammar.decisionReason c)

  for c in SFT.Physics.ColourCouplingGrammar.candidates do
    IO.println ("ColourCouplingGrammar\t" ++ SFT.Physics.ColourCouplingGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ColourCouplingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ColourCouplingGrammar.exactForm c ++ "\t" ++ SFT.Physics.ColourCouplingGrammar.decisionReason c)

  for c in SFT.Physics.PlanckTerminalGrammar.candidates do
    IO.println ("PlanckTerminalGrammar\t" ++ SFT.Physics.PlanckTerminalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PlanckTerminalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PlanckTerminalGrammar.exactForm c ++ "\t" ++ SFT.Physics.PlanckTerminalGrammar.decisionReason c)

  for c in SFT.Physics.VacuumPolarizationGrammar.candidates do
    IO.println ("VacuumPolarizationGrammar\t" ++ SFT.Physics.VacuumPolarizationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumPolarizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumPolarizationGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumPolarizationGrammar.decisionReason c)

  for c in SFT.Physics.StrongRunningGrammar.candidates do
    IO.println ("StrongRunningGrammar\t" ++ SFT.Physics.StrongRunningGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.StrongRunningGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.StrongRunningGrammar.exactForm c ++ "\t" ++ SFT.Physics.StrongRunningGrammar.decisionReason c)

  for c in SFT.Mathematics.SelfSimilarGrammar.candidates do
    IO.println ("SelfSimilarGrammar\t" ++ SFT.Mathematics.SelfSimilarGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.SelfSimilarGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.SelfSimilarGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.SelfSimilarGrammar.decisionReason c)

  for c in SFT.Physics.SpacetimeEventGrammar.candidates do
    IO.println ("SpacetimeEventGrammar\t" ++ SFT.Physics.SpacetimeEventGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpacetimeEventGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpacetimeEventGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpacetimeEventGrammar.decisionReason c)

  for c in SFT.Physics.SpacetimeIntervalGrammar.candidates do
    IO.println ("SpacetimeIntervalGrammar\t" ++ SFT.Physics.SpacetimeIntervalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpacetimeIntervalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpacetimeIntervalGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpacetimeIntervalGrammar.decisionReason c)

  for c in SFT.Physics.SpacetimeCausalOrderGrammar.candidates do
    IO.println ("SpacetimeCausalOrderGrammar\t" ++ SFT.Physics.SpacetimeCausalOrderGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpacetimeCausalOrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpacetimeCausalOrderGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpacetimeCausalOrderGrammar.decisionReason c)

  for c in SFT.Physics.SectorInventoryGrammar.candidates do
    IO.println ("SectorInventoryGrammar\t" ++ SFT.Physics.SectorInventoryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SectorInventoryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SectorInventoryGrammar.exactForm c ++ "\t" ++ SFT.Physics.SectorInventoryGrammar.decisionReason c)

  for c in SFT.Physics.BoundaryMeasurementGrammar.candidates do
    IO.println ("BoundaryMeasurementGrammar\t" ++ SFT.Physics.BoundaryMeasurementGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.BoundaryMeasurementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.BoundaryMeasurementGrammar.exactForm c ++ "\t" ++ SFT.Physics.BoundaryMeasurementGrammar.decisionReason c)

  for c in SFT.Physics.SpacetimeInertialGrammar.candidates do
    IO.println ("SpacetimeInertialGrammar\t" ++ SFT.Physics.SpacetimeInertialGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpacetimeInertialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpacetimeInertialGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpacetimeInertialGrammar.decisionReason c)

  for c in SFT.Physics.RunningConvergenceGrammar.candidates do
    IO.println ("RunningConvergenceGrammar\t" ++ SFT.Physics.RunningConvergenceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.RunningConvergenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.RunningConvergenceGrammar.exactForm c ++ "\t" ++ SFT.Physics.RunningConvergenceGrammar.decisionReason c)

  for c in SFT.Physics.SpacetimeLimitSpeedGrammar.candidates do
    IO.println ("SpacetimeLimitSpeedGrammar\t" ++ SFT.Physics.SpacetimeLimitSpeedGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpacetimeLimitSpeedGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpacetimeLimitSpeedGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpacetimeLimitSpeedGrammar.decisionReason c)

  for c in SFT.Physics.SpacetimeClockRateGrammar.candidates do
    IO.println ("SpacetimeClockRateGrammar\t" ++ SFT.Physics.SpacetimeClockRateGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpacetimeClockRateGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpacetimeClockRateGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpacetimeClockRateGrammar.decisionReason c)

  for c in SFT.Physics.SpacetimeLengthRelationGrammar.candidates do
    IO.println ("SpacetimeLengthRelationGrammar\t" ++ SFT.Physics.SpacetimeLengthRelationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SpacetimeLengthRelationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SpacetimeLengthRelationGrammar.exactForm c ++ "\t" ++ SFT.Physics.SpacetimeLengthRelationGrammar.decisionReason c)

  for c in SFT.Physics.GravityEquivalenceGrammar.candidates do
    IO.println ("GravityEquivalenceGrammar\t" ++ SFT.Physics.GravityEquivalenceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityEquivalenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityEquivalenceGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityEquivalenceGrammar.decisionReason c)

  for c in SFT.Physics.GravityCurvatureGrammar.candidates do
    IO.println ("GravityCurvatureGrammar\t" ++ SFT.Physics.GravityCurvatureGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityCurvatureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityCurvatureGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityCurvatureGrammar.decisionReason c)

  for c in SFT.Physics.GravityGeodesicGrammar.candidates do
    IO.println ("GravityGeodesicGrammar\t" ++ SFT.Physics.GravityGeodesicGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityGeodesicGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityGeodesicGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityGeodesicGrammar.decisionReason c)

  for c in SFT.Physics.GravityFieldSourceGrammar.candidates do
    IO.println ("GravityFieldSourceGrammar\t" ++ SFT.Physics.GravityFieldSourceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityFieldSourceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityFieldSourceGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityFieldSourceGrammar.decisionReason c)

  for c in SFT.Physics.GravityWaveGrammar.candidates do
    IO.println ("GravityWaveGrammar\t" ++ SFT.Physics.GravityWaveGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityWaveGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityWaveGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityWaveGrammar.decisionReason c)

  for c in SFT.Physics.GravityHorizonGrammar.candidates do
    IO.println ("GravityHorizonGrammar\t" ++ SFT.Physics.GravityHorizonGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityHorizonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityHorizonGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityHorizonGrammar.decisionReason c)

  for c in SFT.Physics.CosmoRedshiftGrammar.candidates do
    IO.println ("CosmoRedshiftGrammar\t" ++ SFT.Physics.CosmoRedshiftGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoRedshiftGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoRedshiftGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoRedshiftGrammar.decisionReason c)

  for c in SFT.Physics.CosmoExpansionGrammar.candidates do
    IO.println ("CosmoExpansionGrammar\t" ++ SFT.Physics.CosmoExpansionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoExpansionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoExpansionGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoExpansionGrammar.decisionReason c)
