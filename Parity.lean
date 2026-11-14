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

  for c in SFT.Physics.CosmoBackgroundGrammar.candidates do
    IO.println ("CosmoBackgroundGrammar\t" ++ SFT.Physics.CosmoBackgroundGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoBackgroundGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoBackgroundGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoBackgroundGrammar.decisionReason c)

  for c in SFT.Physics.CosmoLensingGrammar.candidates do
    IO.println ("CosmoLensingGrammar\t" ++ SFT.Physics.CosmoLensingGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoLensingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoLensingGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoLensingGrammar.decisionReason c)

  for c in SFT.Physics.CosmoDistanceGrammar.candidates do
    IO.println ("CosmoDistanceGrammar\t" ++ SFT.Physics.CosmoDistanceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoDistanceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoDistanceGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoDistanceGrammar.decisionReason c)

  for c in SFT.Physics.CosmoStructureGrowthGrammar.candidates do
    IO.println ("CosmoStructureGrowthGrammar\t" ++ SFT.Physics.CosmoStructureGrowthGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoStructureGrowthGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoStructureGrowthGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoStructureGrowthGrammar.decisionReason c)

  for c in SFT.Physics.CosmoBranchBoundaryGrammar.candidates do
    IO.println ("CosmoBranchBoundaryGrammar\t" ++ SFT.Physics.CosmoBranchBoundaryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoBranchBoundaryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoBranchBoundaryGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoBranchBoundaryGrammar.decisionReason c)

  for c in SFT.Physics.CosmoSpatialFlatnessGrammar.candidates do
    IO.println ("CosmoSpatialFlatnessGrammar\t" ++ SFT.Physics.CosmoSpatialFlatnessGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoSpatialFlatnessGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoSpatialFlatnessGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoSpatialFlatnessGrammar.decisionReason c)

  for c in SFT.Physics.CosmoCompleteBudgetGrammar.candidates do
    IO.println ("CosmoCompleteBudgetGrammar\t" ++ SFT.Physics.CosmoCompleteBudgetGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmoCompleteBudgetGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmoCompleteBudgetGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmoCompleteBudgetGrammar.decisionReason c)

  for c in SFT.Physics.CommonScaleAxisGrammar.candidates do
    IO.println ("CommonScaleAxisGrammar\t" ++ SFT.Physics.CommonScaleAxisGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CommonScaleAxisGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CommonScaleAxisGrammar.exactForm c ++ "\t" ++ SFT.Physics.CommonScaleAxisGrammar.decisionReason c)

  for c in SFT.Physics.CosmicComponentTransportGrammar.candidates do
    IO.println ("CosmicComponentTransportGrammar\t" ++ SFT.Physics.CosmicComponentTransportGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CosmicComponentTransportGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CosmicComponentTransportGrammar.exactForm c ++ "\t" ++ SFT.Physics.CosmicComponentTransportGrammar.decisionReason c)

  for c in SFT.Physics.VacuumDensityGrammar.candidates do
    IO.println ("VacuumDensityGrammar\t" ++ SFT.Physics.VacuumDensityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumDensityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumDensityGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumDensityGrammar.decisionReason c)

  for c in SFT.Physics.UnifiedConstantsGrammar.candidates do
    IO.println ("UnifiedConstantsGrammar\t" ++ SFT.Physics.UnifiedConstantsGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.UnifiedConstantsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.UnifiedConstantsGrammar.exactForm c ++ "\t" ++ SFT.Physics.UnifiedConstantsGrammar.decisionReason c)

  for c in SFT.Physics.MicroMacroGrammar.candidates do
    IO.println ("MicroMacroGrammar\t" ++ SFT.Physics.MicroMacroGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MicroMacroGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MicroMacroGrammar.exactForm c ++ "\t" ++ SFT.Physics.MicroMacroGrammar.decisionReason c)

  for c in SFT.Physics.TemperatureGrammar.candidates do
    IO.println ("TemperatureGrammar\t" ++ SFT.Physics.TemperatureGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TemperatureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TemperatureGrammar.exactForm c ++ "\t" ++ SFT.Physics.TemperatureGrammar.decisionReason c)

  for c in SFT.Physics.EquilibriumGrammar.candidates do
    IO.println ("EquilibriumGrammar\t" ++ SFT.Physics.EquilibriumGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.EquilibriumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.EquilibriumGrammar.exactForm c ++ "\t" ++ SFT.Physics.EquilibriumGrammar.decisionReason c)

  for c in SFT.Physics.HeatWorkGrammar.candidates do
    IO.println ("HeatWorkGrammar\t" ++ SFT.Physics.HeatWorkGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.HeatWorkGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.HeatWorkGrammar.exactForm c ++ "\t" ++ SFT.Physics.HeatWorkGrammar.decisionReason c)

  for c in SFT.Physics.FirstLawGrammar.candidates do
    IO.println ("FirstLawGrammar\t" ++ SFT.Physics.FirstLawGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FirstLawGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FirstLawGrammar.exactForm c ++ "\t" ++ SFT.Physics.FirstLawGrammar.decisionReason c)

  for c in SFT.Physics.EntropyGrammar.candidates do
    IO.println ("EntropyGrammar\t" ++ SFT.Physics.EntropyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.EntropyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.EntropyGrammar.exactForm c ++ "\t" ++ SFT.Physics.EntropyGrammar.decisionReason c)

  for c in SFT.Physics.SecondLawGrammar.candidates do
    IO.println ("SecondLawGrammar\t" ++ SFT.Physics.SecondLawGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SecondLawGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SecondLawGrammar.exactForm c ++ "\t" ++ SFT.Physics.SecondLawGrammar.decisionReason c)

  for c in SFT.Physics.ThirdLawGrammar.candidates do
    IO.println ("ThirdLawGrammar\t" ++ SFT.Physics.ThirdLawGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ThirdLawGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ThirdLawGrammar.exactForm c ++ "\t" ++ SFT.Physics.ThirdLawGrammar.decisionReason c)

  for c in SFT.Physics.StatisticalWeightGrammar.candidates do
    IO.println ("StatisticalWeightGrammar\t" ++ SFT.Physics.StatisticalWeightGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.StatisticalWeightGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.StatisticalWeightGrammar.exactForm c ++ "\t" ++ SFT.Physics.StatisticalWeightGrammar.decisionReason c)

  for c in SFT.Physics.StateRelationGrammar.candidates do
    IO.println ("StateRelationGrammar\t" ++ SFT.Physics.StateRelationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.StateRelationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.StateRelationGrammar.exactForm c ++ "\t" ++ SFT.Physics.StateRelationGrammar.decisionReason c)

  for c in SFT.Physics.PhaseEquilibriumGrammar.candidates do
    IO.println ("PhaseEquilibriumGrammar\t" ++ SFT.Physics.PhaseEquilibriumGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PhaseEquilibriumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PhaseEquilibriumGrammar.exactForm c ++ "\t" ++ SFT.Physics.PhaseEquilibriumGrammar.decisionReason c)

  for c in SFT.Physics.KineticTransportGrammar.candidates do
    IO.println ("KineticTransportGrammar\t" ++ SFT.Physics.KineticTransportGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.KineticTransportGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.KineticTransportGrammar.exactForm c ++ "\t" ++ SFT.Physics.KineticTransportGrammar.decisionReason c)

  for c in SFT.Physics.FluctuationGrammar.candidates do
    IO.println ("FluctuationGrammar\t" ++ SFT.Physics.FluctuationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FluctuationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FluctuationGrammar.exactForm c ++ "\t" ++ SFT.Physics.FluctuationGrammar.decisionReason c)

  for c in SFT.Physics.IrreversibilityGrammar.candidates do
    IO.println ("IrreversibilityGrammar\t" ++ SFT.Physics.IrreversibilityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.IrreversibilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.IrreversibilityGrammar.exactForm c ++ "\t" ++ SFT.Physics.IrreversibilityGrammar.decisionReason c)

  for c in SFT.Physics.ThermalResponseGrammar.candidates do
    IO.println ("ThermalResponseGrammar\t" ++ SFT.Physics.ThermalResponseGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ThermalResponseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ThermalResponseGrammar.exactForm c ++ "\t" ++ SFT.Physics.ThermalResponseGrammar.decisionReason c)

  for c in SFT.Physics.MolarPlanckGrammar.candidates do
    IO.println ("MolarPlanckGrammar\t" ++ SFT.Physics.MolarPlanckGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MolarPlanckGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MolarPlanckGrammar.exactForm c ++ "\t" ++ SFT.Physics.MolarPlanckGrammar.decisionReason c)

  for c in SFT.Physics.MeasuredMomentumGrammar.candidates do
    IO.println ("MeasuredMomentumGrammar\t" ++ SFT.Physics.MeasuredMomentumGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MeasuredMomentumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MeasuredMomentumGrammar.exactForm c ++ "\t" ++ SFT.Physics.MeasuredMomentumGrammar.decisionReason c)

  for c in SFT.Physics.MeasuredForceGrammar.candidates do
    IO.println ("MeasuredForceGrammar\t" ++ SFT.Physics.MeasuredForceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MeasuredForceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MeasuredForceGrammar.exactForm c ++ "\t" ++ SFT.Physics.MeasuredForceGrammar.decisionReason c)

  for c in SFT.Physics.MeasuredPotentialGrammar.candidates do
    IO.println ("MeasuredPotentialGrammar\t" ++ SFT.Physics.MeasuredPotentialGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MeasuredPotentialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MeasuredPotentialGrammar.exactForm c ++ "\t" ++ SFT.Physics.MeasuredPotentialGrammar.decisionReason c)

  for c in SFT.Physics.MeasuredFieldGrammar.candidates do
    IO.println ("MeasuredFieldGrammar\t" ++ SFT.Physics.MeasuredFieldGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MeasuredFieldGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MeasuredFieldGrammar.exactForm c ++ "\t" ++ SFT.Physics.MeasuredFieldGrammar.decisionReason c)

  for c in SFT.Physics.MeasuredFrequencyGrammar.candidates do
    IO.println ("MeasuredFrequencyGrammar\t" ++ SFT.Physics.MeasuredFrequencyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MeasuredFrequencyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MeasuredFrequencyGrammar.exactForm c ++ "\t" ++ SFT.Physics.MeasuredFrequencyGrammar.decisionReason c)

  for c in SFT.Physics.MeasuredWaveEnergyGrammar.candidates do
    IO.println ("MeasuredWaveEnergyGrammar\t" ++ SFT.Physics.MeasuredWaveEnergyGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MeasuredWaveEnergyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MeasuredWaveEnergyGrammar.exactForm c ++ "\t" ++ SFT.Physics.MeasuredWaveEnergyGrammar.decisionReason c)

  for c in SFT.Physics.MolarThermalGrammar.candidates do
    IO.println ("MolarThermalGrammar\t" ++ SFT.Physics.MolarThermalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MolarThermalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MolarThermalGrammar.exactForm c ++ "\t" ++ SFT.Physics.MolarThermalGrammar.decisionReason c)

  for c in SFT.Physics.CoarseGrainGrammar.candidates do
    IO.println ("CoarseGrainGrammar\t" ++ SFT.Physics.CoarseGrainGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CoarseGrainGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CoarseGrainGrammar.exactForm c ++ "\t" ++ SFT.Physics.CoarseGrainGrammar.decisionReason c)

  for c in SFT.Physics.DensityGrammar.candidates do
    IO.println ("DensityGrammar\t" ++ SFT.Physics.DensityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DensityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DensityGrammar.exactForm c ++ "\t" ++ SFT.Physics.DensityGrammar.decisionReason c)

  for c in SFT.Physics.PressureStressGrammar.candidates do
    IO.println ("PressureStressGrammar\t" ++ SFT.Physics.PressureStressGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PressureStressGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PressureStressGrammar.exactForm c ++ "\t" ++ SFT.Physics.PressureStressGrammar.decisionReason c)

  for c in SFT.Physics.FlowConservationGrammar.candidates do
    IO.println ("FlowConservationGrammar\t" ++ SFT.Physics.FlowConservationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FlowConservationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FlowConservationGrammar.exactForm c ++ "\t" ++ SFT.Physics.FlowConservationGrammar.decisionReason c)

  for c in SFT.Physics.InviscidGrammar.candidates do
    IO.println ("InviscidGrammar\t" ++ SFT.Physics.InviscidGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.InviscidGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.InviscidGrammar.exactForm c ++ "\t" ++ SFT.Physics.InviscidGrammar.decisionReason c)

  for c in SFT.Physics.ViscosityGrammar.candidates do
    IO.println ("ViscosityGrammar\t" ++ SFT.Physics.ViscosityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ViscosityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ViscosityGrammar.exactForm c ++ "\t" ++ SFT.Physics.ViscosityGrammar.decisionReason c)

  for c in SFT.Physics.TurbulenceGrammar.candidates do
    IO.println ("TurbulenceGrammar\t" ++ SFT.Physics.TurbulenceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TurbulenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TurbulenceGrammar.exactForm c ++ "\t" ++ SFT.Physics.TurbulenceGrammar.decisionReason c)

  for c in SFT.Physics.PlasmaCollectiveGrammar.candidates do
    IO.println ("PlasmaCollectiveGrammar\t" ++ SFT.Physics.PlasmaCollectiveGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PlasmaCollectiveGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PlasmaCollectiveGrammar.exactForm c ++ "\t" ++ SFT.Physics.PlasmaCollectiveGrammar.decisionReason c)

  for c in SFT.Physics.PlasmaOscillationGrammar.candidates do
    IO.println ("PlasmaOscillationGrammar\t" ++ SFT.Physics.PlasmaOscillationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PlasmaOscillationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PlasmaOscillationGrammar.exactForm c ++ "\t" ++ SFT.Physics.PlasmaOscillationGrammar.decisionReason c)

  for c in SFT.Physics.PlasmaMHDGrammar.candidates do
    IO.println ("PlasmaMHDGrammar\t" ++ SFT.Physics.PlasmaMHDGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PlasmaMHDGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PlasmaMHDGrammar.exactForm c ++ "\t" ++ SFT.Physics.PlasmaMHDGrammar.decisionReason c)

  for c in SFT.Physics.LatticeGrammar.candidates do
    IO.println ("LatticeGrammar\t" ++ SFT.Physics.LatticeGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.LatticeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.LatticeGrammar.exactForm c ++ "\t" ++ SFT.Physics.LatticeGrammar.decisionReason c)

  for c in SFT.Physics.BandGrammar.candidates do
    IO.println ("BandGrammar\t" ++ SFT.Physics.BandGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.BandGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.BandGrammar.exactForm c ++ "\t" ++ SFT.Physics.BandGrammar.decisionReason c)

  for c in SFT.Physics.PhaseOrderGrammar.candidates do
    IO.println ("PhaseOrderGrammar\t" ++ SFT.Physics.PhaseOrderGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PhaseOrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PhaseOrderGrammar.exactForm c ++ "\t" ++ SFT.Physics.PhaseOrderGrammar.decisionReason c)

  for c in SFT.Physics.SuperconductivityGrammar.candidates do
    IO.println ("SuperconductivityGrammar\t" ++ SFT.Physics.SuperconductivityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SuperconductivityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SuperconductivityGrammar.exactForm c ++ "\t" ++ SFT.Physics.SuperconductivityGrammar.decisionReason c)

  for c in SFT.Physics.TopologicalGrammar.candidates do
    IO.println ("TopologicalGrammar\t" ++ SFT.Physics.TopologicalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TopologicalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TopologicalGrammar.exactForm c ++ "\t" ++ SFT.Physics.TopologicalGrammar.decisionReason c)

  for c in SFT.Chemistry.EntityGrammar.candidates do
    IO.println ("EntityGrammar\t" ++ SFT.Chemistry.EntityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.EntityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.EntityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.EntityGrammar.decisionReason c)

  for c in SFT.Chemistry.SpeciesGrammar.candidates do
    IO.println ("SpeciesGrammar\t" ++ SFT.Chemistry.SpeciesGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.SpeciesGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.SpeciesGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.SpeciesGrammar.decisionReason c)

  for c in SFT.Chemistry.SubstanceGrammar.candidates do
    IO.println ("SubstanceGrammar\t" ++ SFT.Chemistry.SubstanceGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.SubstanceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.SubstanceGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.SubstanceGrammar.decisionReason c)

  for c in SFT.Chemistry.AmountGrammar.candidates do
    IO.println ("AmountGrammar\t" ++ SFT.Chemistry.AmountGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AmountGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AmountGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AmountGrammar.decisionReason c)

  for c in SFT.Chemistry.FormulaGrammar.candidates do
    IO.println ("FormulaGrammar\t" ++ SFT.Chemistry.FormulaGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.FormulaGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.FormulaGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.FormulaGrammar.decisionReason c)

  for c in SFT.Chemistry.NomenclatureGrammar.candidates do
    IO.println ("NomenclatureGrammar\t" ++ SFT.Chemistry.NomenclatureGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.NomenclatureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.NomenclatureGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.NomenclatureGrammar.decisionReason c)

  for c in SFT.Chemistry.UncertaintyGrammar.candidates do
    IO.println ("UncertaintyGrammar\t" ++ SFT.Chemistry.UncertaintyGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.UncertaintyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.UncertaintyGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.UncertaintyGrammar.decisionReason c)

  for c in SFT.Chemistry.TraceabilityGrammar.candidates do
    IO.println ("TraceabilityGrammar\t" ++ SFT.Chemistry.TraceabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.TraceabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.TraceabilityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.TraceabilityGrammar.decisionReason c)

  for c in SFT.Chemistry.ElementGrammar.candidates do
    IO.println ("ElementGrammar\t" ++ SFT.Chemistry.ElementGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ElementGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ElementGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ElementGrammar.decisionReason c)

  for c in SFT.Chemistry.AtomicNumberGrammar.candidates do
    IO.println ("AtomicNumberGrammar\t" ++ SFT.Chemistry.AtomicNumberGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AtomicNumberGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AtomicNumberGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AtomicNumberGrammar.decisionReason c)

  for c in SFT.Chemistry.IsotopeGrammar.candidates do
    IO.println ("IsotopeGrammar\t" ++ SFT.Chemistry.IsotopeGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.IsotopeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.IsotopeGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.IsotopeGrammar.decisionReason c)

  for c in SFT.Chemistry.AtomicWeightGrammar.candidates do
    IO.println ("AtomicWeightGrammar\t" ++ SFT.Chemistry.AtomicWeightGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AtomicWeightGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AtomicWeightGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AtomicWeightGrammar.decisionReason c)

  for c in SFT.Chemistry.PeriodicOrderGrammar.candidates do
    IO.println ("PeriodicOrderGrammar\t" ++ SFT.Chemistry.PeriodicOrderGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PeriodicOrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PeriodicOrderGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PeriodicOrderGrammar.decisionReason c)

  for c in SFT.Chemistry.PeriodicRecurrenceGrammar.candidates do
    IO.println ("PeriodicRecurrenceGrammar\t" ++ SFT.Chemistry.PeriodicRecurrenceGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PeriodicRecurrenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PeriodicRecurrenceGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PeriodicRecurrenceGrammar.decisionReason c)

  for c in SFT.Chemistry.GroupPeriodGrammar.candidates do
    IO.println ("GroupPeriodGrammar\t" ++ SFT.Chemistry.GroupPeriodGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.GroupPeriodGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.GroupPeriodGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.GroupPeriodGrammar.decisionReason c)

  for c in SFT.Chemistry.ValenceGrammar.candidates do
    IO.println ("ValenceGrammar\t" ++ SFT.Chemistry.ValenceGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ValenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ValenceGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ValenceGrammar.decisionReason c)

  for c in SFT.Chemistry.IonGrammar.candidates do
    IO.println ("IonGrammar\t" ++ SFT.Chemistry.IonGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.IonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.IonGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.IonGrammar.decisionReason c)

  for c in SFT.Chemistry.PeriodicBoundaryGrammar.candidates do
    IO.println ("PeriodicBoundaryGrammar\t" ++ SFT.Chemistry.PeriodicBoundaryGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PeriodicBoundaryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PeriodicBoundaryGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PeriodicBoundaryGrammar.decisionReason c)

  for c in SFT.Chemistry.CompositionGrammar.candidates do
    IO.println ("CompositionGrammar\t" ++ SFT.Chemistry.CompositionGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.CompositionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.CompositionGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.CompositionGrammar.decisionReason c)

  for c in SFT.Chemistry.ConservationGrammar.candidates do
    IO.println ("ConservationGrammar\t" ++ SFT.Chemistry.ConservationGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ConservationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ConservationGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ConservationGrammar.decisionReason c)

  for c in SFT.Chemistry.CoefficientGrammar.candidates do
    IO.println ("CoefficientGrammar\t" ++ SFT.Chemistry.CoefficientGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.CoefficientGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.CoefficientGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.CoefficientGrammar.decisionReason c)

  for c in SFT.Chemistry.LimitingGrammar.candidates do
    IO.println ("LimitingGrammar\t" ++ SFT.Chemistry.LimitingGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.LimitingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.LimitingGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.LimitingGrammar.decisionReason c)

  for c in SFT.Chemistry.YieldGrammar.candidates do
    IO.println ("YieldGrammar\t" ++ SFT.Chemistry.YieldGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.YieldGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.YieldGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.YieldGrammar.decisionReason c)

  for c in SFT.Chemistry.MixtureGrammar.candidates do
    IO.println ("MixtureGrammar\t" ++ SFT.Chemistry.MixtureGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.MixtureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.MixtureGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.MixtureGrammar.decisionReason c)

  for c in SFT.Chemistry.SolutionGrammar.candidates do
    IO.println ("SolutionGrammar\t" ++ SFT.Chemistry.SolutionGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.SolutionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.SolutionGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.SolutionGrammar.decisionReason c)

  for c in SFT.Chemistry.BondGrammar.candidates do
    IO.println ("BondGrammar\t" ++ SFT.Chemistry.BondGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.BondGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.BondGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.BondGrammar.decisionReason c)

  for c in SFT.Chemistry.CovalentGrammar.candidates do
    IO.println ("CovalentGrammar\t" ++ SFT.Chemistry.CovalentGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.CovalentGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.CovalentGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.CovalentGrammar.decisionReason c)

  for c in SFT.Chemistry.IonicGrammar.candidates do
    IO.println ("IonicGrammar\t" ++ SFT.Chemistry.IonicGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.IonicGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.IonicGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.IonicGrammar.decisionReason c)

  for c in SFT.Chemistry.MetallicGrammar.candidates do
    IO.println ("MetallicGrammar\t" ++ SFT.Chemistry.MetallicGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.MetallicGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.MetallicGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.MetallicGrammar.decisionReason c)

  for c in SFT.Chemistry.OrderGrammar.candidates do
    IO.println ("OrderGrammar\t" ++ SFT.Chemistry.OrderGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.OrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.OrderGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.OrderGrammar.decisionReason c)

  for c in SFT.Chemistry.LengthGrammar.candidates do
    IO.println ("LengthGrammar\t" ++ SFT.Chemistry.LengthGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.LengthGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.LengthGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.LengthGrammar.decisionReason c)

  for c in SFT.Chemistry.MoleculeGrammar.candidates do
    IO.println ("MoleculeGrammar\t" ++ SFT.Chemistry.MoleculeGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.MoleculeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.MoleculeGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.MoleculeGrammar.decisionReason c)

  for c in SFT.Chemistry.GeometryGrammar.candidates do
    IO.println ("GeometryGrammar\t" ++ SFT.Chemistry.GeometryGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.GeometryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.GeometryGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.GeometryGrammar.decisionReason c)

  for c in SFT.Chemistry.IsomerGrammar.candidates do
    IO.println ("IsomerGrammar\t" ++ SFT.Chemistry.IsomerGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.IsomerGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.IsomerGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.IsomerGrammar.decisionReason c)

  for c in SFT.Chemistry.IntermolecularGrammar.candidates do
    IO.println ("IntermolecularGrammar\t" ++ SFT.Chemistry.IntermolecularGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.IntermolecularGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.IntermolecularGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.IntermolecularGrammar.decisionReason c)

  for c in SFT.Chemistry.SupramolecularGrammar.candidates do
    IO.println ("SupramolecularGrammar\t" ++ SFT.Chemistry.SupramolecularGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.SupramolecularGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.SupramolecularGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.SupramolecularGrammar.decisionReason c)

  for c in SFT.Chemistry.NetworkGrammar.candidates do
    IO.println ("NetworkGrammar\t" ++ SFT.Chemistry.NetworkGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.NetworkGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.NetworkGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.NetworkGrammar.decisionReason c)

  for c in SFT.Chemistry.AcidbaseGrammar.candidates do
    IO.println ("AcidbaseGrammar\t" ++ SFT.Chemistry.AcidbaseGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AcidbaseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AcidbaseGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AcidbaseGrammar.decisionReason c)

  for c in SFT.Chemistry.ProtonGrammar.candidates do
    IO.println ("ProtonGrammar\t" ++ SFT.Chemistry.ProtonGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ProtonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ProtonGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ProtonGrammar.decisionReason c)

  for c in SFT.Chemistry.LewisGrammar.candidates do
    IO.println ("LewisGrammar\t" ++ SFT.Chemistry.LewisGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.LewisGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.LewisGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.LewisGrammar.decisionReason c)

  for c in SFT.Chemistry.AmphotericGrammar.candidates do
    IO.println ("AmphotericGrammar\t" ++ SFT.Chemistry.AmphotericGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AmphotericGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AmphotericGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AmphotericGrammar.decisionReason c)

  for c in SFT.Chemistry.BufferGrammar.candidates do
    IO.println ("BufferGrammar\t" ++ SFT.Chemistry.BufferGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.BufferGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.BufferGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.BufferGrammar.decisionReason c)

  for c in SFT.Chemistry.AffinityGrammar.candidates do
    IO.println ("AffinityGrammar\t" ++ SFT.Chemistry.AffinityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AffinityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AffinityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AffinityGrammar.decisionReason c)

  for c in SFT.Chemistry.PolarityGrammar.candidates do
    IO.println ("PolarityGrammar\t" ++ SFT.Chemistry.PolarityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PolarityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PolarityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PolarityGrammar.decisionReason c)

  for c in SFT.Chemistry.OxidationGrammar.candidates do
    IO.println ("OxidationGrammar\t" ++ SFT.Chemistry.OxidationGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.OxidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.OxidationGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.OxidationGrammar.decisionReason c)

  for c in SFT.Chemistry.RedoxGrammar.candidates do
    IO.println ("RedoxGrammar\t" ++ SFT.Chemistry.RedoxGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.RedoxGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.RedoxGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.RedoxGrammar.decisionReason c)

  for c in SFT.Chemistry.CellGrammar.candidates do
    IO.println ("CellGrammar\t" ++ SFT.Chemistry.CellGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.CellGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.CellGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.CellGrammar.decisionReason c)

  for c in SFT.Chemistry.ReactionGrammar.candidates do
    IO.println ("ReactionGrammar\t" ++ SFT.Chemistry.ReactionGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ReactionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ReactionGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ReactionGrammar.decisionReason c)

  for c in SFT.Chemistry.MechanismGrammar.candidates do
    IO.println ("MechanismGrammar\t" ++ SFT.Chemistry.MechanismGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.MechanismGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.MechanismGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.MechanismGrammar.decisionReason c)

  for c in SFT.Chemistry.IntermediateGrammar.candidates do
    IO.println ("IntermediateGrammar\t" ++ SFT.Chemistry.IntermediateGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.IntermediateGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.IntermediateGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.IntermediateGrammar.decisionReason c)

  for c in SFT.Chemistry.ActivationGrammar.candidates do
    IO.println ("ActivationGrammar\t" ++ SFT.Chemistry.ActivationGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ActivationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ActivationGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ActivationGrammar.decisionReason c)

  for c in SFT.Chemistry.RateGrammar.candidates do
    IO.println ("RateGrammar\t" ++ SFT.Chemistry.RateGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.RateGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.RateGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.RateGrammar.decisionReason c)

  for c in SFT.Chemistry.KineticOrderGrammar.candidates do
    IO.println ("KineticOrderGrammar\t" ++ SFT.Chemistry.KineticOrderGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.KineticOrderGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.KineticOrderGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.KineticOrderGrammar.decisionReason c)

  for c in SFT.Chemistry.EquilibriumGrammar.candidates do
    IO.println ("EquilibriumGrammar\t" ++ SFT.Chemistry.EquilibriumGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.EquilibriumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.EquilibriumGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.EquilibriumGrammar.decisionReason c)

  for c in SFT.Chemistry.ThermochemistryGrammar.candidates do
    IO.println ("ThermochemistryGrammar\t" ++ SFT.Chemistry.ThermochemistryGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ThermochemistryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ThermochemistryGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ThermochemistryGrammar.decisionReason c)

  for c in SFT.Chemistry.DirectionGrammar.candidates do
    IO.println ("DirectionGrammar\t" ++ SFT.Chemistry.DirectionGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.DirectionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.DirectionGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.DirectionGrammar.decisionReason c)

  for c in SFT.Chemistry.PhaseGrammar.candidates do
    IO.println ("PhaseGrammar\t" ++ SFT.Chemistry.PhaseGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PhaseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PhaseGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PhaseGrammar.decisionReason c)

  for c in SFT.Chemistry.PhotoGrammar.candidates do
    IO.println ("PhotoGrammar\t" ++ SFT.Chemistry.PhotoGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PhotoGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PhotoGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PhotoGrammar.decisionReason c)

  for c in SFT.Chemistry.CatalystGrammar.candidates do
    IO.println ("CatalystGrammar\t" ++ SFT.Chemistry.CatalystGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.CatalystGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.CatalystGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.CatalystGrammar.decisionReason c)

  for c in SFT.Chemistry.SolubilityGrammar.candidates do
    IO.println ("SolubilityGrammar\t" ++ SFT.Chemistry.SolubilityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.SolubilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.SolubilityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.SolubilityGrammar.decisionReason c)

  for c in SFT.Chemistry.PathwayGrammar.candidates do
    IO.println ("PathwayGrammar\t" ++ SFT.Chemistry.PathwayGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PathwayGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PathwayGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PathwayGrammar.decisionReason c)

  for c in SFT.Chemistry.SelectivityGrammar.candidates do
    IO.println ("SelectivityGrammar\t" ++ SFT.Chemistry.SelectivityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.SelectivityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.SelectivityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.SelectivityGrammar.decisionReason c)

  for c in SFT.Chemistry.ReactionNetGrammar.candidates do
    IO.println ("ReactionNetGrammar\t" ++ SFT.Chemistry.ReactionNetGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ReactionNetGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ReactionNetGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ReactionNetGrammar.decisionReason c)

  for c in SFT.Chemistry.AutocatalysisGrammar.candidates do
    IO.println ("AutocatalysisGrammar\t" ++ SFT.Chemistry.AutocatalysisGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AutocatalysisGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AutocatalysisGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AutocatalysisGrammar.decisionReason c)

  for c in SFT.Chemistry.AdsorptionGrammar.candidates do
    IO.println ("AdsorptionGrammar\t" ++ SFT.Chemistry.AdsorptionGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AdsorptionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AdsorptionGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AdsorptionGrammar.decisionReason c)

  for c in SFT.Chemistry.ColloidGrammar.candidates do
    IO.println ("ColloidGrammar\t" ++ SFT.Chemistry.ColloidGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ColloidGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ColloidGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ColloidGrammar.decisionReason c)

  for c in SFT.Chemistry.InterfaceTransferGrammar.candidates do
    IO.println ("InterfaceTransferGrammar\t" ++ SFT.Chemistry.InterfaceTransferGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.InterfaceTransferGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.InterfaceTransferGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.InterfaceTransferGrammar.decisionReason c)

  for c in SFT.Chemistry.ChiralityGrammar.candidates do
    IO.println ("ChiralityGrammar\t" ++ SFT.Chemistry.ChiralityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ChiralityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ChiralityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ChiralityGrammar.decisionReason c)

  for c in SFT.Chemistry.EnantiomerGrammar.candidates do
    IO.println ("EnantiomerGrammar\t" ++ SFT.Chemistry.EnantiomerGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.EnantiomerGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.EnantiomerGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.EnantiomerGrammar.decisionReason c)

  for c in SFT.Chemistry.DiastereomerGrammar.candidates do
    IO.println ("DiastereomerGrammar\t" ++ SFT.Chemistry.DiastereomerGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.DiastereomerGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.DiastereomerGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.DiastereomerGrammar.decisionReason c)

  for c in SFT.Chemistry.FunctionalGrammar.candidates do
    IO.println ("FunctionalGrammar\t" ++ SFT.Chemistry.FunctionalGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.FunctionalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.FunctionalGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.FunctionalGrammar.decisionReason c)

  for c in SFT.Chemistry.ReactionFamilyGrammar.candidates do
    IO.println ("ReactionFamilyGrammar\t" ++ SFT.Chemistry.ReactionFamilyGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.ReactionFamilyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.ReactionFamilyGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.ReactionFamilyGrammar.decisionReason c)

  for c in SFT.Chemistry.PolymerChainGrammar.candidates do
    IO.println ("PolymerChainGrammar\t" ++ SFT.Chemistry.PolymerChainGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PolymerChainGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PolymerChainGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PolymerChainGrammar.decisionReason c)

  for c in SFT.Chemistry.PolymerDistributionGrammar.candidates do
    IO.println ("PolymerDistributionGrammar\t" ++ SFT.Chemistry.PolymerDistributionGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PolymerDistributionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PolymerDistributionGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PolymerDistributionGrammar.decisionReason c)

  for c in SFT.Chemistry.BiomolecularGrammar.candidates do
    IO.println ("BiomolecularGrammar\t" ++ SFT.Chemistry.BiomolecularGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.BiomolecularGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.BiomolecularGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.BiomolecularGrammar.decisionReason c)

  for c in SFT.Chemistry.AnalyticalSampleGrammar.candidates do
    IO.println ("AnalyticalSampleGrammar\t" ++ SFT.Chemistry.AnalyticalSampleGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AnalyticalSampleGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AnalyticalSampleGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AnalyticalSampleGrammar.decisionReason c)

  for c in SFT.Chemistry.AnalyticalCalibrationGrammar.candidates do
    IO.println ("AnalyticalCalibrationGrammar\t" ++ SFT.Chemistry.AnalyticalCalibrationGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AnalyticalCalibrationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AnalyticalCalibrationGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AnalyticalCalibrationGrammar.decisionReason c)

  for c in SFT.Chemistry.AnalyticalSelectivityGrammar.candidates do
    IO.println ("AnalyticalSelectivityGrammar\t" ++ SFT.Chemistry.AnalyticalSelectivityGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AnalyticalSelectivityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AnalyticalSelectivityGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AnalyticalSelectivityGrammar.decisionReason c)

  for c in SFT.Chemistry.MassSpectralGrammar.candidates do
    IO.println ("MassSpectralGrammar\t" ++ SFT.Chemistry.MassSpectralGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.MassSpectralGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.MassSpectralGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.MassSpectralGrammar.decisionReason c)

  for c in SFT.Chemistry.InfraredGrammar.candidates do
    IO.println ("InfraredGrammar\t" ++ SFT.Chemistry.InfraredGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.InfraredGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.InfraredGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.InfraredGrammar.decisionReason c)

  for c in SFT.Chemistry.UVVisGrammar.candidates do
    IO.println ("UVVisGrammar\t" ++ SFT.Chemistry.UVVisGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.UVVisGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.UVVisGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.UVVisGrammar.decisionReason c)

  for c in SFT.Chemistry.RotVibGrammar.candidates do
    IO.println ("RotVibGrammar\t" ++ SFT.Chemistry.RotVibGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.RotVibGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.RotVibGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.RotVibGrammar.decisionReason c)

  for c in SFT.Chemistry.AnalyticalRecordGrammar.candidates do
    IO.println ("AnalyticalRecordGrammar\t" ++ SFT.Chemistry.AnalyticalRecordGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.AnalyticalRecordGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.AnalyticalRecordGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.AnalyticalRecordGrammar.decisionReason c)

  for c in SFT.Physics.AtomicOrbitCapacityGrammar.candidates do
    IO.println ("AtomicOrbitCapacityGrammar\t" ++ SFT.Physics.AtomicOrbitCapacityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.AtomicOrbitCapacityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.AtomicOrbitCapacityGrammar.exactForm c ++ "\t" ++ SFT.Physics.AtomicOrbitCapacityGrammar.decisionReason c)

  for c in SFT.Physics.NuclearClosureGrammar.candidates do
    IO.println ("NuclearClosureGrammar\t" ++ SFT.Physics.NuclearClosureGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NuclearClosureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NuclearClosureGrammar.exactForm c ++ "\t" ++ SFT.Physics.NuclearClosureGrammar.decisionReason c)

  for c in SFT.Physics.AtomicBoundaryGrammar.candidates do
    IO.println ("AtomicBoundaryGrammar\t" ++ SFT.Physics.AtomicBoundaryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.AtomicBoundaryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.AtomicBoundaryGrammar.exactForm c ++ "\t" ++ SFT.Physics.AtomicBoundaryGrammar.decisionReason c)

  for c in SFT.Physics.AlphaIntervalGrammar.candidates do
    IO.println ("AlphaIntervalGrammar\t" ++ SFT.Physics.AlphaIntervalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.AlphaIntervalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.AlphaIntervalGrammar.exactForm c ++ "\t" ++ SFT.Physics.AlphaIntervalGrammar.decisionReason c)

  for c in SFT.Physics.NuclearSequenceGrammar.candidates do
    IO.println ("NuclearSequenceGrammar\t" ++ SFT.Physics.NuclearSequenceGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NuclearSequenceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NuclearSequenceGrammar.exactForm c ++ "\t" ++ SFT.Physics.NuclearSequenceGrammar.decisionReason c)

  for c in SFT.Materials.MaterialGrammar.candidates do
    IO.println ("MaterialGrammar\t" ++ SFT.Materials.MaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.MaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.MaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.MaterialGrammar.decisionReason c)

  for c in SFT.Physics.InverseSquareGrammar.candidates do
    IO.println ("InverseSquareGrammar\t" ++ SFT.Physics.InverseSquareGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.InverseSquareGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.InverseSquareGrammar.exactForm c ++ "\t" ++ SFT.Physics.InverseSquareGrammar.decisionReason c)

  for c in SFT.Physics.InverseSquareIntervalGrammar.candidates do
    IO.println ("InverseSquareIntervalGrammar\t" ++ SFT.Physics.InverseSquareIntervalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.InverseSquareIntervalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.InverseSquareIntervalGrammar.exactForm c ++ "\t" ++ SFT.Physics.InverseSquareIntervalGrammar.decisionReason c)

  for c in SFT.Chemistry.GBlockGrammar.candidates do
    IO.println ("GBlockGrammar\t" ++ SFT.Chemistry.GBlockGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.GBlockGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.GBlockGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.GBlockGrammar.decisionReason c)

  for c in SFT.Chemistry.SmithiumGrammar.candidates do
    IO.println ("SmithiumGrammar\t" ++ SFT.Chemistry.SmithiumGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.SmithiumGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.SmithiumGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.SmithiumGrammar.decisionReason c)

  for c in SFT.Chemistry.PeriodicEndpointGrammar.candidates do
    IO.println ("PeriodicEndpointGrammar\t" ++ SFT.Chemistry.PeriodicEndpointGrammar.candidateId c ++ "\t" ++ (if SFT.Chemistry.PeriodicEndpointGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Chemistry.PeriodicEndpointGrammar.exactForm c ++ "\t" ++ SFT.Chemistry.PeriodicEndpointGrammar.decisionReason c)

  for c in SFT.Materials.SpecimenGrammar.candidates do
    IO.println ("SpecimenGrammar\t" ++ SFT.Materials.SpecimenGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SpecimenGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SpecimenGrammar.exactForm c ++ "\t" ++ SFT.Materials.SpecimenGrammar.decisionReason c)

  for c in SFT.Materials.CompositionGrammar.candidates do
    IO.println ("CompositionGrammar\t" ++ SFT.Materials.CompositionGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CompositionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CompositionGrammar.exactForm c ++ "\t" ++ SFT.Materials.CompositionGrammar.decisionReason c)

  for c in SFT.Materials.PhaseGrammar.candidates do
    IO.println ("PhaseGrammar\t" ++ SFT.Materials.PhaseGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PhaseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PhaseGrammar.exactForm c ++ "\t" ++ SFT.Materials.PhaseGrammar.decisionReason c)

  for c in SFT.Materials.MicrostructureGrammar.candidates do
    IO.println ("MicrostructureGrammar\t" ++ SFT.Materials.MicrostructureGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.MicrostructureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.MicrostructureGrammar.exactForm c ++ "\t" ++ SFT.Materials.MicrostructureGrammar.decisionReason c)

  for c in SFT.Materials.PropertyGrammar.candidates do
    IO.println ("PropertyGrammar\t" ++ SFT.Materials.PropertyGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PropertyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PropertyGrammar.exactForm c ++ "\t" ++ SFT.Materials.PropertyGrammar.decisionReason c)

  for c in SFT.Materials.TraceabilityGrammar.candidates do
    IO.println ("TraceabilityGrammar\t" ++ SFT.Materials.TraceabilityGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.TraceabilityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.TraceabilityGrammar.exactForm c ++ "\t" ++ SFT.Materials.TraceabilityGrammar.decisionReason c)

  for c in SFT.Materials.LatticeGrammar.candidates do
    IO.println ("LatticeGrammar\t" ++ SFT.Materials.LatticeGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.LatticeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.LatticeGrammar.exactForm c ++ "\t" ++ SFT.Materials.LatticeGrammar.decisionReason c)

  for c in SFT.Materials.UnitCellGrammar.candidates do
    IO.println ("UnitCellGrammar\t" ++ SFT.Materials.UnitCellGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.UnitCellGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.UnitCellGrammar.exactForm c ++ "\t" ++ SFT.Materials.UnitCellGrammar.decisionReason c)

  for c in SFT.Materials.CrystalTranslationGrammar.candidates do
    IO.println ("CrystalTranslationGrammar\t" ++ SFT.Materials.CrystalTranslationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CrystalTranslationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CrystalTranslationGrammar.exactForm c ++ "\t" ++ SFT.Materials.CrystalTranslationGrammar.decisionReason c)

  for c in SFT.Materials.CubicGrammar.candidates do
    IO.println ("CubicGrammar\t" ++ SFT.Materials.CubicGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CubicGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CubicGrammar.exactForm c ++ "\t" ++ SFT.Materials.CubicGrammar.decisionReason c)

  for c in SFT.Materials.RotationGrammar.candidates do
    IO.println ("RotationGrammar\t" ++ SFT.Materials.RotationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.RotationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.RotationGrammar.exactForm c ++ "\t" ++ SFT.Materials.RotationGrammar.decisionReason c)

  for c in SFT.Materials.SystemsGrammar.candidates do
    IO.println ("SystemsGrammar\t" ++ SFT.Materials.SystemsGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SystemsGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SystemsGrammar.exactForm c ++ "\t" ++ SFT.Materials.SystemsGrammar.decisionReason c)

  for c in SFT.Materials.BravaisGrammar.candidates do
    IO.println ("BravaisGrammar\t" ++ SFT.Materials.BravaisGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.BravaisGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.BravaisGrammar.exactForm c ++ "\t" ++ SFT.Materials.BravaisGrammar.decisionReason c)

  for c in SFT.Materials.ReciprocalGrammar.candidates do
    IO.println ("ReciprocalGrammar\t" ++ SFT.Materials.ReciprocalGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ReciprocalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ReciprocalGrammar.exactForm c ++ "\t" ++ SFT.Materials.ReciprocalGrammar.decisionReason c)

  for c in SFT.Materials.QuasicrystalGrammar.candidates do
    IO.println ("QuasicrystalGrammar\t" ++ SFT.Materials.QuasicrystalGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.QuasicrystalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.QuasicrystalGrammar.exactForm c ++ "\t" ++ SFT.Materials.QuasicrystalGrammar.decisionReason c)

  for c in SFT.Materials.PhononGrammar.candidates do
    IO.println ("PhononGrammar\t" ++ SFT.Materials.PhononGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PhononGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PhononGrammar.exactForm c ++ "\t" ++ SFT.Materials.PhononGrammar.decisionReason c)

  for c in SFT.Materials.PointDefectGrammar.candidates do
    IO.println ("PointDefectGrammar\t" ++ SFT.Materials.PointDefectGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PointDefectGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PointDefectGrammar.exactForm c ++ "\t" ++ SFT.Materials.PointDefectGrammar.decisionReason c)

  for c in SFT.Materials.VacancyGrammar.candidates do
    IO.println ("VacancyGrammar\t" ++ SFT.Materials.VacancyGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.VacancyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.VacancyGrammar.exactForm c ++ "\t" ++ SFT.Materials.VacancyGrammar.decisionReason c)

  for c in SFT.Materials.InterstitialGrammar.candidates do
    IO.println ("InterstitialGrammar\t" ++ SFT.Materials.InterstitialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.InterstitialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.InterstitialGrammar.exactForm c ++ "\t" ++ SFT.Materials.InterstitialGrammar.decisionReason c)

  for c in SFT.Materials.DislocationGrammar.candidates do
    IO.println ("DislocationGrammar\t" ++ SFT.Materials.DislocationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.DislocationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.DislocationGrammar.exactForm c ++ "\t" ++ SFT.Materials.DislocationGrammar.decisionReason c)

  for c in SFT.Materials.GrainGrammar.candidates do
    IO.println ("GrainGrammar\t" ++ SFT.Materials.GrainGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.GrainGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.GrainGrammar.exactForm c ++ "\t" ++ SFT.Materials.GrainGrammar.decisionReason c)

  for c in SFT.Materials.InterfaceGrammar.candidates do
    IO.println ("InterfaceGrammar\t" ++ SFT.Materials.InterfaceGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.InterfaceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.InterfaceGrammar.exactForm c ++ "\t" ++ SFT.Materials.InterfaceGrammar.decisionReason c)

  for c in SFT.Materials.DiffusionGrammar.candidates do
    IO.println ("DiffusionGrammar\t" ++ SFT.Materials.DiffusionGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.DiffusionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.DiffusionGrammar.exactForm c ++ "\t" ++ SFT.Materials.DiffusionGrammar.decisionReason c)

  for c in SFT.Materials.NucleationGrammar.candidates do
    IO.println ("NucleationGrammar\t" ++ SFT.Materials.NucleationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.NucleationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.NucleationGrammar.exactForm c ++ "\t" ++ SFT.Materials.NucleationGrammar.decisionReason c)

  for c in SFT.Materials.BandGapGrammar.candidates do
    IO.println ("BandGapGrammar\t" ++ SFT.Materials.BandGapGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.BandGapGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.BandGapGrammar.exactForm c ++ "\t" ++ SFT.Materials.BandGapGrammar.decisionReason c)

  for c in SFT.Materials.ConductorGrammar.candidates do
    IO.println ("ConductorGrammar\t" ++ SFT.Materials.ConductorGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ConductorGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ConductorGrammar.exactForm c ++ "\t" ++ SFT.Materials.ConductorGrammar.decisionReason c)

  for c in SFT.Materials.DualityGrammar.candidates do
    IO.println ("DualityGrammar\t" ++ SFT.Materials.DualityGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.DualityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.DualityGrammar.exactForm c ++ "\t" ++ SFT.Materials.DualityGrammar.decisionReason c)

  for c in SFT.Materials.OccupationGrammar.candidates do
    IO.println ("OccupationGrammar\t" ++ SFT.Materials.OccupationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.OccupationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.OccupationGrammar.exactForm c ++ "\t" ++ SFT.Materials.OccupationGrammar.decisionReason c)

  for c in SFT.Materials.DopingGrammar.candidates do
    IO.println ("DopingGrammar\t" ++ SFT.Materials.DopingGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.DopingGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.DopingGrammar.exactForm c ++ "\t" ++ SFT.Materials.DopingGrammar.decisionReason c)

  for c in SFT.Materials.PNTypeGrammar.candidates do
    IO.println ("PNTypeGrammar\t" ++ SFT.Materials.PNTypeGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PNTypeGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PNTypeGrammar.exactForm c ++ "\t" ++ SFT.Materials.PNTypeGrammar.decisionReason c)

  for c in SFT.Materials.SemiTransportGrammar.candidates do
    IO.println ("SemiTransportGrammar\t" ++ SFT.Materials.SemiTransportGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SemiTransportGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SemiTransportGrammar.exactForm c ++ "\t" ++ SFT.Materials.SemiTransportGrammar.decisionReason c)

  for c in SFT.Materials.SemiOpticalGrammar.candidates do
    IO.println ("SemiOpticalGrammar\t" ++ SFT.Materials.SemiOpticalGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SemiOpticalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SemiOpticalGrammar.exactForm c ++ "\t" ++ SFT.Materials.SemiOpticalGrammar.decisionReason c)

  for c in SFT.Materials.CoherentPairGrammar.candidates do
    IO.println ("CoherentPairGrammar\t" ++ SFT.Materials.CoherentPairGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CoherentPairGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CoherentPairGrammar.exactForm c ++ "\t" ++ SFT.Materials.CoherentPairGrammar.decisionReason c)

  for c in SFT.Materials.ZeroResistanceGrammar.candidates do
    IO.println ("ZeroResistanceGrammar\t" ++ SFT.Materials.ZeroResistanceGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ZeroResistanceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ZeroResistanceGrammar.exactForm c ++ "\t" ++ SFT.Materials.ZeroResistanceGrammar.decisionReason c)

  for c in SFT.Materials.MeissnerGrammar.candidates do
    IO.println ("MeissnerGrammar\t" ++ SFT.Materials.MeissnerGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.MeissnerGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.MeissnerGrammar.exactForm c ++ "\t" ++ SFT.Materials.MeissnerGrammar.decisionReason c)

  for c in SFT.Materials.FluxQuantizationGrammar.candidates do
    IO.println ("FluxQuantizationGrammar\t" ++ SFT.Materials.FluxQuantizationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.FluxQuantizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.FluxQuantizationGrammar.exactForm c ++ "\t" ++ SFT.Materials.FluxQuantizationGrammar.decisionReason c)

  for c in SFT.Materials.JosephsonGrammar.candidates do
    IO.println ("JosephsonGrammar\t" ++ SFT.Materials.JosephsonGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.JosephsonGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.JosephsonGrammar.exactForm c ++ "\t" ++ SFT.Materials.JosephsonGrammar.decisionReason c)

  for c in SFT.Materials.SuperfluidGrammar.candidates do
    IO.println ("SuperfluidGrammar\t" ++ SFT.Materials.SuperfluidGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SuperfluidGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SuperfluidGrammar.exactForm c ++ "\t" ++ SFT.Materials.SuperfluidGrammar.decisionReason c)

  for c in SFT.Materials.CirculationGrammar.candidates do
    IO.println ("CirculationGrammar\t" ++ SFT.Materials.CirculationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CirculationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CirculationGrammar.exactForm c ++ "\t" ++ SFT.Materials.CirculationGrammar.decisionReason c)

  for c in SFT.Materials.MaterialInvariantGrammar.candidates do
    IO.println ("MaterialInvariantGrammar\t" ++ SFT.Materials.MaterialInvariantGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.MaterialInvariantGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.MaterialInvariantGrammar.exactForm c ++ "\t" ++ SFT.Materials.MaterialInvariantGrammar.decisionReason c)

  for c in SFT.Materials.BulkBoundaryGrammar.candidates do
    IO.println ("BulkBoundaryGrammar\t" ++ SFT.Materials.BulkBoundaryGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.BulkBoundaryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.BulkBoundaryGrammar.exactForm c ++ "\t" ++ SFT.Materials.BulkBoundaryGrammar.decisionReason c)

  for c in SFT.Materials.StressStrainGrammar.candidates do
    IO.println ("StressStrainGrammar\t" ++ SFT.Materials.StressStrainGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.StressStrainGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.StressStrainGrammar.exactForm c ++ "\t" ++ SFT.Materials.StressStrainGrammar.decisionReason c)

  for c in SFT.Materials.ElasticityGrammar.candidates do
    IO.println ("ElasticityGrammar\t" ++ SFT.Materials.ElasticityGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ElasticityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ElasticityGrammar.exactForm c ++ "\t" ++ SFT.Materials.ElasticityGrammar.decisionReason c)

  for c in SFT.Materials.PlasticityGrammar.candidates do
    IO.println ("PlasticityGrammar\t" ++ SFT.Materials.PlasticityGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PlasticityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PlasticityGrammar.exactForm c ++ "\t" ++ SFT.Materials.PlasticityGrammar.decisionReason c)

  for c in SFT.Materials.SlipGrammar.candidates do
    IO.println ("SlipGrammar\t" ++ SFT.Materials.SlipGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SlipGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SlipGrammar.exactForm c ++ "\t" ++ SFT.Materials.SlipGrammar.decisionReason c)

  for c in SFT.Materials.ModulusGrammar.candidates do
    IO.println ("ModulusGrammar\t" ++ SFT.Materials.ModulusGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ModulusGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ModulusGrammar.exactForm c ++ "\t" ++ SFT.Materials.ModulusGrammar.decisionReason c)

  for c in SFT.Materials.StrengthGrammar.candidates do
    IO.println ("StrengthGrammar\t" ++ SFT.Materials.StrengthGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.StrengthGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.StrengthGrammar.exactForm c ++ "\t" ++ SFT.Materials.StrengthGrammar.decisionReason c)

  for c in SFT.Materials.FractureGrammar.candidates do
    IO.println ("FractureGrammar\t" ++ SFT.Materials.FractureGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.FractureGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.FractureGrammar.exactForm c ++ "\t" ++ SFT.Materials.FractureGrammar.decisionReason c)

  for c in SFT.Materials.FatigueCreepGrammar.candidates do
    IO.println ("FatigueCreepGrammar\t" ++ SFT.Materials.FatigueCreepGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.FatigueCreepGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.FatigueCreepGrammar.exactForm c ++ "\t" ++ SFT.Materials.FatigueCreepGrammar.decisionReason c)

  for c in SFT.Materials.HeatCapacityGrammar.candidates do
    IO.println ("HeatCapacityGrammar\t" ++ SFT.Materials.HeatCapacityGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.HeatCapacityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.HeatCapacityGrammar.exactForm c ++ "\t" ++ SFT.Materials.HeatCapacityGrammar.decisionReason c)

  for c in SFT.Materials.ThermalConductionGrammar.candidates do
    IO.println ("ThermalConductionGrammar\t" ++ SFT.Materials.ThermalConductionGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ThermalConductionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ThermalConductionGrammar.exactForm c ++ "\t" ++ SFT.Materials.ThermalConductionGrammar.decisionReason c)

  for c in SFT.Materials.ThermalExpansionGrammar.candidates do
    IO.println ("ThermalExpansionGrammar\t" ++ SFT.Materials.ThermalExpansionGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ThermalExpansionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ThermalExpansionGrammar.exactForm c ++ "\t" ++ SFT.Materials.ThermalExpansionGrammar.decisionReason c)

  for c in SFT.Materials.FerromagnetismGrammar.candidates do
    IO.println ("FerromagnetismGrammar\t" ++ SFT.Materials.FerromagnetismGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.FerromagnetismGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.FerromagnetismGrammar.exactForm c ++ "\t" ++ SFT.Materials.FerromagnetismGrammar.decisionReason c)

  for c in SFT.Materials.AntiferromagnetismGrammar.candidates do
    IO.println ("AntiferromagnetismGrammar\t" ++ SFT.Materials.AntiferromagnetismGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.AntiferromagnetismGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.AntiferromagnetismGrammar.exactForm c ++ "\t" ++ SFT.Materials.AntiferromagnetismGrammar.decisionReason c)

  for c in SFT.Materials.DielectricPolarizationGrammar.candidates do
    IO.println ("DielectricPolarizationGrammar\t" ++ SFT.Materials.DielectricPolarizationGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.DielectricPolarizationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.DielectricPolarizationGrammar.exactForm c ++ "\t" ++ SFT.Materials.DielectricPolarizationGrammar.decisionReason c)

  for c in SFT.Materials.RefractiveResponseGrammar.candidates do
    IO.println ("RefractiveResponseGrammar\t" ++ SFT.Materials.RefractiveResponseGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.RefractiveResponseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.RefractiveResponseGrammar.exactForm c ++ "\t" ++ SFT.Materials.RefractiveResponseGrammar.decisionReason c)

  for c in SFT.Materials.MaterialTransitionGrammar.candidates do
    IO.println ("MaterialTransitionGrammar\t" ++ SFT.Materials.MaterialTransitionGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.MaterialTransitionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.MaterialTransitionGrammar.exactForm c ++ "\t" ++ SFT.Materials.MaterialTransitionGrammar.decisionReason c)

  for c in SFT.Materials.MetallicMaterialGrammar.candidates do
    IO.println ("MetallicMaterialGrammar\t" ++ SFT.Materials.MetallicMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.MetallicMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.MetallicMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.MetallicMaterialGrammar.decisionReason c)

  for c in SFT.Materials.CeramicMaterialGrammar.candidates do
    IO.println ("CeramicMaterialGrammar\t" ++ SFT.Materials.CeramicMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CeramicMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CeramicMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.CeramicMaterialGrammar.decisionReason c)

  for c in SFT.Materials.PolymerMaterialGrammar.candidates do
    IO.println ("PolymerMaterialGrammar\t" ++ SFT.Materials.PolymerMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PolymerMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PolymerMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.PolymerMaterialGrammar.decisionReason c)

  for c in SFT.Materials.CompositeMaterialGrammar.candidates do
    IO.println ("CompositeMaterialGrammar\t" ++ SFT.Materials.CompositeMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CompositeMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CompositeMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.CompositeMaterialGrammar.decisionReason c)

  for c in SFT.Materials.GlassMaterialGrammar.candidates do
    IO.println ("GlassMaterialGrammar\t" ++ SFT.Materials.GlassMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.GlassMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.GlassMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.GlassMaterialGrammar.decisionReason c)

  for c in SFT.Materials.PorousMaterialGrammar.candidates do
    IO.println ("PorousMaterialGrammar\t" ++ SFT.Materials.PorousMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PorousMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PorousMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.PorousMaterialGrammar.decisionReason c)

  for c in SFT.Materials.BulkMaterialGrammar.candidates do
    IO.println ("BulkMaterialGrammar\t" ++ SFT.Materials.BulkMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.BulkMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.BulkMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.BulkMaterialGrammar.decisionReason c)

  for c in SFT.Materials.AnisotropyMaterialGrammar.candidates do
    IO.println ("AnisotropyMaterialGrammar\t" ++ SFT.Materials.AnisotropyMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.AnisotropyMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.AnisotropyMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.AnisotropyMaterialGrammar.decisionReason c)

  for c in SFT.Materials.SizeMaterialGrammar.candidates do
    IO.println ("SizeMaterialGrammar\t" ++ SFT.Materials.SizeMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SizeMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SizeMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.SizeMaterialGrammar.decisionReason c)

  for c in SFT.Materials.ProcessMaterialGrammar.candidates do
    IO.println ("ProcessMaterialGrammar\t" ++ SFT.Materials.ProcessMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ProcessMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ProcessMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.ProcessMaterialGrammar.decisionReason c)

  for c in SFT.Materials.PhaseMapMaterialGrammar.candidates do
    IO.println ("PhaseMapMaterialGrammar\t" ++ SFT.Materials.PhaseMapMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PhaseMapMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PhaseMapMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.PhaseMapMaterialGrammar.decisionReason c)

  for c in SFT.Materials.SolidificationMaterialGrammar.candidates do
    IO.println ("SolidificationMaterialGrammar\t" ++ SFT.Materials.SolidificationMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SolidificationMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SolidificationMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.SolidificationMaterialGrammar.decisionReason c)

  for c in SFT.Materials.SinteringMaterialGrammar.candidates do
    IO.println ("SinteringMaterialGrammar\t" ++ SFT.Materials.SinteringMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.SinteringMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.SinteringMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.SinteringMaterialGrammar.decisionReason c)

  for c in SFT.Materials.HeatMaterialGrammar.candidates do
    IO.println ("HeatMaterialGrammar\t" ++ SFT.Materials.HeatMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.HeatMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.HeatMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.HeatMaterialGrammar.decisionReason c)

  for c in SFT.Materials.CorrosionMaterialGrammar.candidates do
    IO.println ("CorrosionMaterialGrammar\t" ++ SFT.Materials.CorrosionMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.CorrosionMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.CorrosionMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.CorrosionMaterialGrammar.decisionReason c)

  for c in SFT.Materials.WearMaterialGrammar.candidates do
    IO.println ("WearMaterialGrammar\t" ++ SFT.Materials.WearMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.WearMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.WearMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.WearMaterialGrammar.decisionReason c)

  for c in SFT.Materials.RadiationDamageMaterialGrammar.candidates do
    IO.println ("RadiationDamageMaterialGrammar\t" ++ SFT.Materials.RadiationDamageMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.RadiationDamageMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.RadiationDamageMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.RadiationDamageMaterialGrammar.decisionReason c)

  for c in SFT.Materials.PiezoMaterialGrammar.candidates do
    IO.println ("PiezoMaterialGrammar\t" ++ SFT.Materials.PiezoMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PiezoMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PiezoMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.PiezoMaterialGrammar.decisionReason c)

  for c in SFT.Materials.FerroelectricMaterialGrammar.candidates do
    IO.println ("FerroelectricMaterialGrammar\t" ++ SFT.Materials.FerroelectricMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.FerroelectricMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.FerroelectricMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.FerroelectricMaterialGrammar.decisionReason c)

  for c in SFT.Materials.ThermoelectricMaterialGrammar.candidates do
    IO.println ("ThermoelectricMaterialGrammar\t" ++ SFT.Materials.ThermoelectricMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.ThermoelectricMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.ThermoelectricMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.ThermoelectricMaterialGrammar.decisionReason c)

  for c in SFT.Materials.PhotonicMaterialGrammar.candidates do
    IO.println ("PhotonicMaterialGrammar\t" ++ SFT.Materials.PhotonicMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.PhotonicMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.PhotonicMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.PhotonicMaterialGrammar.decisionReason c)

  for c in SFT.Materials.FunctionalMagneticMaterialGrammar.candidates do
    IO.println ("FunctionalMagneticMaterialGrammar\t" ++ SFT.Materials.FunctionalMagneticMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.FunctionalMagneticMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.FunctionalMagneticMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.FunctionalMagneticMaterialGrammar.decisionReason c)

  for c in SFT.Materials.NanoRegimeMaterialGrammar.candidates do
    IO.println ("NanoRegimeMaterialGrammar\t" ++ SFT.Materials.NanoRegimeMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.NanoRegimeMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.NanoRegimeMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.NanoRegimeMaterialGrammar.decisionReason c)

  for c in SFT.Materials.BiomaterialMaterialGrammar.candidates do
    IO.println ("BiomaterialMaterialGrammar\t" ++ SFT.Materials.BiomaterialMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.BiomaterialMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.BiomaterialMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.BiomaterialMaterialGrammar.decisionReason c)

  for c in SFT.Materials.LifecycleMaterialGrammar.candidates do
    IO.println ("LifecycleMaterialGrammar\t" ++ SFT.Materials.LifecycleMaterialGrammar.candidateId c ++ "\t" ++ (if SFT.Materials.LifecycleMaterialGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Materials.LifecycleMaterialGrammar.exactForm c ++ "\t" ++ SFT.Materials.LifecycleMaterialGrammar.decisionReason c)

  for c in SFT.Physics.KoideIntervalGrammar.candidates do
    IO.println ("KoideIntervalGrammar\t" ++ SFT.Physics.KoideIntervalGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.KoideIntervalGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.KoideIntervalGrammar.exactForm c ++ "\t" ++ SFT.Physics.KoideIntervalGrammar.decisionReason c)

  for c in SFT.Foundation.AdmissionGrammar.candidates do
    IO.println ("AdmissionGrammar\t" ++ SFT.Foundation.AdmissionGrammar.candidateId c ++ "\t" ++ (if SFT.Foundation.AdmissionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Foundation.AdmissionGrammar.exactForm c ++ "\t" ++ SFT.Foundation.AdmissionGrammar.decisionReason c)

  for c in SFT.Mathematics.AlgebraicBalanceGrammar.candidates do
    IO.println ("AlgebraicBalanceGrammar\t" ++ SFT.Mathematics.AlgebraicBalanceGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.AlgebraicBalanceGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.AlgebraicBalanceGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.AlgebraicBalanceGrammar.decisionReason c)

  for c in SFT.Mathematics.BoundedNBodyGrammar.candidates do
    IO.println ("BoundedNBodyGrammar\t" ++ SFT.Mathematics.BoundedNBodyGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.BoundedNBodyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.BoundedNBodyGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.BoundedNBodyGrammar.decisionReason c)

  for c in SFT.Mathematics.FlooredFluidGrammar.candidates do
    IO.println ("FlooredFluidGrammar\t" ++ SFT.Mathematics.FlooredFluidGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.FlooredFluidGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.FlooredFluidGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.FlooredFluidGrammar.decisionReason c)

  for c in SFT.Mathematics.PrimePairGrammar.candidates do
    IO.println ("PrimePairGrammar\t" ++ SFT.Mathematics.PrimePairGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.PrimePairGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.PrimePairGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.PrimePairGrammar.decisionReason c)

  for c in SFT.Mathematics.RiemannMirrorGrammar.candidates do
    IO.println ("RiemannMirrorGrammar\t" ++ SFT.Mathematics.RiemannMirrorGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.RiemannMirrorGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.RiemannMirrorGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.RiemannMirrorGrammar.decisionReason c)

  for c in SFT.Mathematics.CollatzGrammar.candidates do
    IO.println ("CollatzGrammar\t" ++ SFT.Mathematics.CollatzGrammar.candidateId c ++ "\t" ++ (if SFT.Mathematics.CollatzGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Mathematics.CollatzGrammar.exactForm c ++ "\t" ++ SFT.Mathematics.CollatzGrammar.decisionReason c)

  for c in SFT.Computation.NativeBusyGrammar.candidates do
    IO.println ("NativeBusyGrammar\t" ++ SFT.Computation.NativeBusyGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.NativeBusyGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.NativeBusyGrammar.exactForm c ++ "\t" ++ SFT.Computation.NativeBusyGrammar.decisionReason c)

  for c in SFT.Computation.NativePnpGrammar.candidates do
    IO.println ("NativePnpGrammar\t" ++ SFT.Computation.NativePnpGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.NativePnpGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.NativePnpGrammar.exactForm c ++ "\t" ++ SFT.Computation.NativePnpGrammar.decisionReason c)

  for c in SFT.Computation.NativeCircuitGrammar.candidates do
    IO.println ("NativeCircuitGrammar\t" ++ SFT.Computation.NativeCircuitGrammar.candidateId c ++ "\t" ++ (if SFT.Computation.NativeCircuitGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Computation.NativeCircuitGrammar.exactForm c ++ "\t" ++ SFT.Computation.NativeCircuitGrammar.decisionReason c)

  for c in SFT.QuantumComputation.UnboundedGrammar.candidates do
    IO.println ("UnboundedGrammar\t" ++ SFT.QuantumComputation.UnboundedGrammar.candidateId c ++ "\t" ++ (if SFT.QuantumComputation.UnboundedGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.QuantumComputation.UnboundedGrammar.exactForm c ++ "\t" ++ SFT.QuantumComputation.UnboundedGrammar.decisionReason c)

  for c in SFT.Physics.PMNSGrammar.candidates do
    IO.println ("PMNSGrammar\t" ++ SFT.Physics.PMNSGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PMNSGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PMNSGrammar.exactForm c ++ "\t" ++ SFT.Physics.PMNSGrammar.decisionReason c)

  for c in SFT.Physics.WZGrammar.candidates do
    IO.println ("WZGrammar\t" ++ SFT.Physics.WZGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.WZGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.WZGrammar.exactForm c ++ "\t" ++ SFT.Physics.WZGrammar.decisionReason c)

  for c in SFT.Physics.CPGrammar.candidates do
    IO.println ("CPGrammar\t" ++ SFT.Physics.CPGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CPGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CPGrammar.exactForm c ++ "\t" ++ SFT.Physics.CPGrammar.decisionReason c)

  for c in SFT.Physics.DiracGrammar.candidates do
    IO.println ("DiracGrammar\t" ++ SFT.Physics.DiracGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DiracGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DiracGrammar.exactForm c ++ "\t" ++ SFT.Physics.DiracGrammar.decisionReason c)

  for c in SFT.Physics.ParityGrammar.candidates do
    IO.println ("ParityGrammar\t" ++ SFT.Physics.ParityGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ParityGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ParityGrammar.exactForm c ++ "\t" ++ SFT.Physics.ParityGrammar.decisionReason c)

  for c in SFT.Physics.EWValidationGrammar.candidates do
    IO.println ("EWValidationGrammar\t" ++ SFT.Physics.EWValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.EWValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.EWValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.EWValidationGrammar.decisionReason c)

  for c in SFT.Physics.HierarchyValidationGrammar.candidates do
    IO.println ("HierarchyValidationGrammar\t" ++ SFT.Physics.HierarchyValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.HierarchyValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.HierarchyValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.HierarchyValidationGrammar.decisionReason c)

  for c in SFT.Physics.SectorValidationGrammar.candidates do
    IO.println ("SectorValidationGrammar\t" ++ SFT.Physics.SectorValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.SectorValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.SectorValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.SectorValidationGrammar.decisionReason c)

  for c in SFT.Physics.VacuumInertiaGrammar.candidates do
    IO.println ("VacuumInertiaGrammar\t" ++ SFT.Physics.VacuumInertiaGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumInertiaGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumInertiaGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumInertiaGrammar.decisionReason c)

  for c in SFT.Physics.VacuumBeatGrammar.candidates do
    IO.println ("VacuumBeatGrammar\t" ++ SFT.Physics.VacuumBeatGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumBeatGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumBeatGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumBeatGrammar.decisionReason c)

  for c in SFT.Physics.VacuumCycleGrammar.candidates do
    IO.println ("VacuumCycleGrammar\t" ++ SFT.Physics.VacuumCycleGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumCycleGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumCycleGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumCycleGrammar.decisionReason c)

  for c in SFT.Physics.VacuumFloorValidationGrammar.candidates do
    IO.println ("VacuumFloorValidationGrammar\t" ++ SFT.Physics.VacuumFloorValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumFloorValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumFloorValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumFloorValidationGrammar.decisionReason c)

  for c in SFT.Physics.VacuumPolarizationValidationGrammar.candidates do
    IO.println ("VacuumPolarizationValidationGrammar\t" ++ SFT.Physics.VacuumPolarizationValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumPolarizationValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumPolarizationValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumPolarizationValidationGrammar.decisionReason c)

  for c in SFT.Physics.VacuumInertiaValidationGrammar.candidates do
    IO.println ("VacuumInertiaValidationGrammar\t" ++ SFT.Physics.VacuumInertiaValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumInertiaValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumInertiaValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumInertiaValidationGrammar.decisionReason c)

  for c in SFT.Physics.VacuumExtractionValidationGrammar.candidates do
    IO.println ("VacuumExtractionValidationGrammar\t" ++ SFT.Physics.VacuumExtractionValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.VacuumExtractionValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.VacuumExtractionValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.VacuumExtractionValidationGrammar.decisionReason c)

  for c in SFT.Physics.FreePhaseGrammar.candidates do
    IO.println ("FreePhaseGrammar\t" ++ SFT.Physics.FreePhaseGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FreePhaseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FreePhaseGrammar.exactForm c ++ "\t" ++ SFT.Physics.FreePhaseGrammar.decisionReason c)

  for c in SFT.Physics.PotentialPhaseGrammar.candidates do
    IO.println ("PotentialPhaseGrammar\t" ++ SFT.Physics.PotentialPhaseGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PotentialPhaseGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PotentialPhaseGrammar.exactForm c ++ "\t" ++ SFT.Physics.PotentialPhaseGrammar.decisionReason c)

  for c in SFT.Physics.StationaryGrammar.candidates do
    IO.println ("StationaryGrammar\t" ++ SFT.Physics.StationaryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.StationaryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.StationaryGrammar.exactForm c ++ "\t" ++ SFT.Physics.StationaryGrammar.decisionReason c)

  for c in SFT.Physics.TwoHandGrammar.candidates do
    IO.println ("TwoHandGrammar\t" ++ SFT.Physics.TwoHandGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TwoHandGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TwoHandGrammar.exactForm c ++ "\t" ++ SFT.Physics.TwoHandGrammar.decisionReason c)

  for c in SFT.Physics.FullDiracGrammar.candidates do
    IO.println ("FullDiracGrammar\t" ++ SFT.Physics.FullDiracGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FullDiracGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FullDiracGrammar.exactForm c ++ "\t" ++ SFT.Physics.FullDiracGrammar.decisionReason c)

  for c in SFT.Physics.CoulombGrammar.candidates do
    IO.println ("CoulombGrammar\t" ++ SFT.Physics.CoulombGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CoulombGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CoulombGrammar.exactForm c ++ "\t" ++ SFT.Physics.CoulombGrammar.decisionReason c)

  for c in SFT.Physics.MagneticCorrectionGrammar.candidates do
    IO.println ("MagneticCorrectionGrammar\t" ++ SFT.Physics.MagneticCorrectionGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MagneticCorrectionGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MagneticCorrectionGrammar.exactForm c ++ "\t" ++ SFT.Physics.MagneticCorrectionGrammar.decisionReason c)

  for c in SFT.Physics.LorentzTransferEntryGrammar.candidates do
    IO.println ("LorentzTransferEntryGrammar\t" ++ SFT.Physics.LorentzTransferEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.LorentzTransferEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.LorentzTransferEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.LorentzTransferEntryGrammar.decisionReason c)

  for c in SFT.Physics.MaxwellPlanarEntryGrammar.candidates do
    IO.println ("MaxwellPlanarEntryGrammar\t" ++ SFT.Physics.MaxwellPlanarEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MaxwellPlanarEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MaxwellPlanarEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.MaxwellPlanarEntryGrammar.decisionReason c)

  for c in SFT.Physics.MaxwellSpatialEntryGrammar.candidates do
    IO.println ("MaxwellSpatialEntryGrammar\t" ++ SFT.Physics.MaxwellSpatialEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MaxwellSpatialEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MaxwellSpatialEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.MaxwellSpatialEntryGrammar.decisionReason c)

  for c in SFT.Physics.OpticalEntryGrammar.candidates do
    IO.println ("OpticalEntryGrammar\t" ++ SFT.Physics.OpticalEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.OpticalEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.OpticalEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.OpticalEntryGrammar.decisionReason c)

  for c in SFT.Physics.FiniteLoopEntryGrammar.candidates do
    IO.println ("FiniteLoopEntryGrammar\t" ++ SFT.Physics.FiniteLoopEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FiniteLoopEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FiniteLoopEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.FiniteLoopEntryGrammar.decisionReason c)

  for c in SFT.Physics.DynamicsValidationGrammar.candidates do
    IO.println ("DynamicsValidationGrammar\t" ++ SFT.Physics.DynamicsValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.DynamicsValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.DynamicsValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.DynamicsValidationGrammar.decisionReason c)

  for c in SFT.Physics.RelativisticFieldValidationGrammar.candidates do
    IO.println ("RelativisticFieldValidationGrammar\t" ++ SFT.Physics.RelativisticFieldValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.RelativisticFieldValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.RelativisticFieldValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.RelativisticFieldValidationGrammar.decisionReason c)

  for c in SFT.Physics.OpticsValidationGrammar.candidates do
    IO.println ("OpticsValidationGrammar\t" ++ SFT.Physics.OpticsValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.OpticsValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.OpticsValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.OpticsValidationGrammar.decisionReason c)

  for c in SFT.Physics.FiniteLoopValidationGrammar.candidates do
    IO.println ("FiniteLoopValidationGrammar\t" ++ SFT.Physics.FiniteLoopValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.FiniteLoopValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.FiniteLoopValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.FiniteLoopValidationGrammar.decisionReason c)

  for c in SFT.Physics.GravityFluxEntryGrammar.candidates do
    IO.println ("GravityFluxEntryGrammar\t" ++ SFT.Physics.GravityFluxEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityFluxEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityFluxEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityFluxEntryGrammar.decisionReason c)

  for c in SFT.Physics.CausalIntervalEntryGrammar.candidates do
    IO.println ("CausalIntervalEntryGrammar\t" ++ SFT.Physics.CausalIntervalEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CausalIntervalEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CausalIntervalEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.CausalIntervalEntryGrammar.decisionReason c)

  for c in SFT.Physics.StaticFoldClockEntryGrammar.candidates do
    IO.println ("StaticFoldClockEntryGrammar\t" ++ SFT.Physics.StaticFoldClockEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.StaticFoldClockEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.StaticFoldClockEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.StaticFoldClockEntryGrammar.decisionReason c)

  for c in SFT.Physics.RedshiftEquivalenceEntryGrammar.candidates do
    IO.println ("RedshiftEquivalenceEntryGrammar\t" ++ SFT.Physics.RedshiftEquivalenceEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.RedshiftEquivalenceEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.RedshiftEquivalenceEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.RedshiftEquivalenceEntryGrammar.decisionReason c)

  for c in SFT.Physics.LatticeCurvatureEntryGrammar.candidates do
    IO.println ("LatticeCurvatureEntryGrammar\t" ++ SFT.Physics.LatticeCurvatureEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.LatticeCurvatureEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.LatticeCurvatureEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.LatticeCurvatureEntryGrammar.decisionReason c)

  for c in SFT.Physics.GravitySelfSourceEntryGrammar.candidates do
    IO.println ("GravitySelfSourceEntryGrammar\t" ++ SFT.Physics.GravitySelfSourceEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravitySelfSourceEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravitySelfSourceEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravitySelfSourceEntryGrammar.decisionReason c)

  for c in SFT.Physics.GravitonPolarizationEntryGrammar.candidates do
    IO.println ("GravitonPolarizationEntryGrammar\t" ++ SFT.Physics.GravitonPolarizationEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravitonPolarizationEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravitonPolarizationEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravitonPolarizationEntryGrammar.decisionReason c)

  for c in SFT.Physics.GravityWaveEntryGrammar.candidates do
    IO.println ("GravityWaveEntryGrammar\t" ++ SFT.Physics.GravityWaveEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityWaveEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityWaveEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityWaveEntryGrammar.decisionReason c)

  for c in SFT.Physics.StrongHorizonEntryGrammar.candidates do
    IO.println ("StrongHorizonEntryGrammar\t" ++ SFT.Physics.StrongHorizonEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.StrongHorizonEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.StrongHorizonEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.StrongHorizonEntryGrammar.decisionReason c)

  for c in SFT.Physics.HorizonInformationEntryGrammar.candidates do
    IO.println ("HorizonInformationEntryGrammar\t" ++ SFT.Physics.HorizonInformationEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.HorizonInformationEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.HorizonInformationEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.HorizonInformationEntryGrammar.decisionReason c)

  for c in SFT.Physics.WormholeEntryGrammar.candidates do
    IO.println ("WormholeEntryGrammar\t" ++ SFT.Physics.WormholeEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.WormholeEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.WormholeEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.WormholeEntryGrammar.decisionReason c)

  for c in SFT.Physics.WarpEntryGrammar.candidates do
    IO.println ("WarpEntryGrammar\t" ++ SFT.Physics.WarpEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.WarpEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.WarpEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.WarpEntryGrammar.decisionReason c)

  for c in SFT.Physics.TimelikeEntryGrammar.candidates do
    IO.println ("TimelikeEntryGrammar\t" ++ SFT.Physics.TimelikeEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.TimelikeEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.TimelikeEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.TimelikeEntryGrammar.decisionReason c)

  for c in SFT.Physics.GravityClockValidationGrammar.candidates do
    IO.println ("GravityClockValidationGrammar\t" ++ SFT.Physics.GravityClockValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityClockValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityClockValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityClockValidationGrammar.decisionReason c)

  for c in SFT.Physics.GravityWaveValidationGrammar.candidates do
    IO.println ("GravityWaveValidationGrammar\t" ++ SFT.Physics.GravityWaveValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityWaveValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityWaveValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityWaveValidationGrammar.decisionReason c)

  for c in SFT.Physics.GravityHorizonValidationGrammar.candidates do
    IO.println ("GravityHorizonValidationGrammar\t" ++ SFT.Physics.GravityHorizonValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.GravityHorizonValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.GravityHorizonValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.GravityHorizonValidationGrammar.decisionReason c)

  for c in SFT.Physics.NonstandardSpacetimeValidationGrammar.candidates do
    IO.println ("NonstandardSpacetimeValidationGrammar\t" ++ SFT.Physics.NonstandardSpacetimeValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NonstandardSpacetimeValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NonstandardSpacetimeValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.NonstandardSpacetimeValidationGrammar.decisionReason c)

  for c in SFT.Physics.QuarkDressingEntryGrammar.candidates do
    IO.println ("QuarkDressingEntryGrammar\t" ++ SFT.Physics.QuarkDressingEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.QuarkDressingEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.QuarkDressingEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.QuarkDressingEntryGrammar.decisionReason c)

  for c in SFT.Physics.CKMFibreEntryGrammar.candidates do
    IO.println ("CKMFibreEntryGrammar\t" ++ SFT.Physics.CKMFibreEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.CKMFibreEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.CKMFibreEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.CKMFibreEntryGrammar.decisionReason c)

  for c in SFT.Physics.PhysicalCKMEntryGrammar.candidates do
    IO.println ("PhysicalCKMEntryGrammar\t" ++ SFT.Physics.PhysicalCKMEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PhysicalCKMEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PhysicalCKMEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.PhysicalCKMEntryGrammar.decisionReason c)

  for c in SFT.Physics.ProtonIdentityEntryGrammar.candidates do
    IO.println ("ProtonIdentityEntryGrammar\t" ++ SFT.Physics.ProtonIdentityEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ProtonIdentityEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ProtonIdentityEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.ProtonIdentityEntryGrammar.decisionReason c)

  for c in SFT.Physics.NeutrinoSplittingEntryGrammar.candidates do
    IO.println ("NeutrinoSplittingEntryGrammar\t" ++ SFT.Physics.NeutrinoSplittingEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NeutrinoSplittingEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NeutrinoSplittingEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.NeutrinoSplittingEntryGrammar.decisionReason c)

  for c in SFT.Physics.NeutrinoMassEntryGrammar.candidates do
    IO.println ("NeutrinoMassEntryGrammar\t" ++ SFT.Physics.NeutrinoMassEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.NeutrinoMassEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.NeutrinoMassEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.NeutrinoMassEntryGrammar.decisionReason c)

  for c in SFT.Physics.PMNSPhysicalEntryGrammar.candidates do
    IO.println ("PMNSPhysicalEntryGrammar\t" ++ SFT.Physics.PMNSPhysicalEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.PMNSPhysicalEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.PMNSPhysicalEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.PMNSPhysicalEntryGrammar.decisionReason c)

  for c in SFT.Physics.MajoranaEntryGrammar.candidates do
    IO.println ("MajoranaEntryGrammar\t" ++ SFT.Physics.MajoranaEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MajoranaEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MajoranaEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.MajoranaEntryGrammar.decisionReason c)

  for c in SFT.Physics.ZeroNuEntryGrammar.candidates do
    IO.println ("ZeroNuEntryGrammar\t" ++ SFT.Physics.ZeroNuEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ZeroNuEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ZeroNuEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.ZeroNuEntryGrammar.decisionReason c)

  for c in SFT.Physics.MagneticAnomalyEntryGrammar.candidates do
    IO.println ("MagneticAnomalyEntryGrammar\t" ++ SFT.Physics.MagneticAnomalyEntryGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.MagneticAnomalyEntryGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.MagneticAnomalyEntryGrammar.exactForm c ++ "\t" ++ SFT.Physics.MagneticAnomalyEntryGrammar.decisionReason c)

  for c in SFT.Physics.QuarkCKMValidationGrammar.candidates do
    IO.println ("QuarkCKMValidationGrammar\t" ++ SFT.Physics.QuarkCKMValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.QuarkCKMValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.QuarkCKMValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.QuarkCKMValidationGrammar.decisionReason c)

  for c in SFT.Physics.ProtonPrecisionValidationGrammar.candidates do
    IO.println ("ProtonPrecisionValidationGrammar\t" ++ SFT.Physics.ProtonPrecisionValidationGrammar.candidateId c ++ "\t" ++ (if SFT.Physics.ProtonPrecisionValidationGrammar.survives c then "true" else "false") ++ "\t" ++ SFT.Physics.ProtonPrecisionValidationGrammar.exactForm c ++ "\t" ++ SFT.Physics.ProtonPrecisionValidationGrammar.decisionReason c)
