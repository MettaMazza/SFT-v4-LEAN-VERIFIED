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
