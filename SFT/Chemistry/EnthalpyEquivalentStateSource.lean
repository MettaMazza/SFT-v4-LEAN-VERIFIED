import SFT.Chemistry.EnthalpyEquivalentStateExperiment
import SFT.Chemistry.EnthalpyStateAnalysis
namespace SFT.Chemistry.EnthalpyEquivalentStateSource
-- V3 explicitly imports _source_rows from internal_energy_composition_validation_v1.
abbrev Target := InternalEnergyCompositionSource.Target
def sourceRows := InternalEnergyCompositionSource.sourceRows
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev Analysis := EnthalpyStateAnalysis.Analysis
def exactEnthalpyAnalysis := EnthalpyStateAnalysis.exactEnthalpyAnalysis
end SFT.Chemistry.EnthalpyEquivalentStateSource
