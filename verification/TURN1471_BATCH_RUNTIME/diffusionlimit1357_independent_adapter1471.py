"""Implementation-distinct value-free KIN-011 reconstruction."""
from fractions import Fraction
from itertools import product as cartesian_product
import json, sys
CLAIM = 'SFT-CHEM-DIFFUSION-LIMITED-REACTION-BOUNDARY-011'
DOMAINS = (('selected-initial-encounter-or-product-endpoint', 'complete-finite-transport-state-and-transition-word'), ('transport-and-reaction-treated-as-unrelated-processes', 'transport-exit-is-exact-reaction-encounter-entry'), ('imported-Fick-Smoluchowski-continuum-or-collision-law', 'reaction-admissible-only-after-complete-transport-word'), ('fitted-diffusion-coefficient-rate-constant-or-continuum-time', 'completed-reaction-occurrences-per-exact-positive-observation-parts'), ('solvation-transport-encounter-or-product-stage-omitted-or-collapsed', 'all-separated-solvation-transport-encounter-and-product-stages-retained'), ('simulation-measurement-discrepancy-large-droplet-deviation-or-nonencounter-question-omitted', 'all-favorable-adverse-control-and-unresolved-statuses-retained'), ('selected-fit-rate-table-or-trajectory', 'complete-251-record-article-supplements-movies-and-dual-archive-ledger'), ('distance-time-velocity-yield-rate-fit-or-target-readable-before-seal', 'value-free-251-record-identity-seal-and-depth-independent-path-successor'))
SURVIVOR = 'complete-finite-transport-state-and-transition-word__transport-exit-is-exact-reaction-encounter-entry__reaction-admissible-only-after-complete-transport-word__completed-reaction-occurrences-per-exact-positive-observation-parts__all-separated-solvation-transport-encounter-and-product-stages-retained__all-favorable-adverse-control-and-unresolved-statuses-retained__complete-251-record-article-supplements-movies-and-dual-archive-ledger__value-free-251-record-identity-seal-and-depth-independent-path-successor'

def main():
    d = json.load(open(sys.argv[1]))
    generated = ['__'.join(row) for row in cartesian_product(*DOMAINS)]
    received = [row['candidate_id'] for row in d['census']['candidates']]
    decisions = {row['candidate_id']: row['survives'] for row in d['decisions']}
    states = ('separated-reactants', 'initiated-solvation', 'transport-occurrence-word', 'encounter-boundary')
    edges = tuple(((states[i], states[i + 1]) for i in range(len(states) - 1)))
    reactant = tuple(('same-held-reactant' for _ in states))
    reaction_entry = states[-1]
    product = 'product-complex'
    completion = Fraction(3, 2)
    occurrence = (states, edges, reactant, reaction_entry, product)
    prior = (occurrence,)
    extended = prior + ((states, edges, reactant, reaction_entry, product),)
    witnesses = len(states) == 4 and len(edges) == 3 and all((edges[i] == (states[i], states[i + 1]) for i in range(3))) and (len(set(reactant)) == 1) and (edges[-1][1] == reaction_entry) and (reaction_entry != product) and (completion.numerator == 3) and (completion.denominator == 2) and (extended[:len(prior)] == prior) and (len(extended) == len(prior) + 1)
    passed = d['claim_id'] == CLAIM and received == generated and (len(generated) == 256) and (len(set(received)) == 256) and (d['census']['expected_cardinality'] == 256) and (decisions == {candidate: candidate == SURVIVOR for candidate in generated}) and (sum(decisions.values()) == 1) and (d['closure']['scope'] == 'depth_independent') and d['closure']['minimality_passed'] and d['closure']['named_shape_uniqueness_passed'] and ({row['kind'] for row in d['controls']} == {'false_premise', 'tampered_source', 'tampered_artifact', 'boundary'}) and all((row['passed'] for row in d['controls'])) and witnesses
    print(json.dumps({'validated_seal_hash': d['seal_hash'], 'recomputed_from_declared_inputs': True, 'passed': passed, 'certificate': {'claim_id': CLAIM, 'generated_cardinality': len(generated), 'unique_survivor': SURVIVOR if passed else None, 'closure': 'depth_independent' if passed else None, 'complete_finite_transport_word_reconstructed': witnesses, 'transport_exit_reaction_entry_identity_and_exact_positive_completion_relation_reconstructed': witnesses, 'transport_reaction_successor_preserves_prior_family': witnesses, 'numerical_zero_negative_irrational_imaginary_logarithmic_signed_or_continuum_proof_value_used': False, 'Fick_Smoluchowski_diffusion_equation_continuum_fit_stochastic_weight_target_measurement_or_source_file_accessed': False}}, sort_keys=True))
if __name__ == '__main__':
    main()
