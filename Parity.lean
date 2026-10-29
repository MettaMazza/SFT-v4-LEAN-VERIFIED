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

