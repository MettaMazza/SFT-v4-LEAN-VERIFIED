"""Fold-native analytical precision and repeatability law (ANAL-002)."""
from fractions import Fraction
from sft.claim_evidence import EMPTY_ONE
from sft.engine.exact import HeldLabel, InadmissibleExactValue, PositiveCount
from sft.physics.generated_empirical_law import dimension

def replicate_record(sample,method,condition,values):
    if (sample.family,method.family,condition.family)!=("analytical-sample","analytical-method","repeatability-condition") or not values or any(v<=0 for v in values): raise InadmissibleExactValue("positive same-condition replicate support required")
    distances=tuple(EMPTY_ONE if values[i]==values[j] else abs(values[i]-values[j]) for i in range(len(values)) for j in range(i+1,len(values)))
    spread=EMPTY_ONE if max(values)==min(values) else max(values)-min(values)
    return tuple(values),distances,spread

DEPENDENCIES=("SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-ANALYTICAL-SAMPLE-001","SFT-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001")
DIMENSIONS=(
 dimension("identity","replicates-without-sample","Results cannot be paired.","held-sample-measurand-method","All replicate identities remain."),
 dimension("conditions","mixed-condition-pool","Repeatability is obscured.","same-held-repeatability-conditions","Conditions are identical and explicit."),
 dimension("support","summary-only","A summary erases rows.","complete-positive-ordered-replicates","Every replicate remains."),
 dimension("comparison","signed-deviation-list","Signed values are not native proof distances.","all-pair-positive-distance-or-EmptyOne","All unordered pairs are exact."),
 dimension("spread","fitted-dispersion-parameter","A fit cannot define observed spread.","exact-extreme-distance-or-EmptyOne","Spread is forced by retained extrema."),
 dimension("class","precision-equals-trueness","Agreement with a reference is distinct.","repeatability-class-held-separately","Precision and trueness remain separate."),
 dimension("adverse","outlier-deleted","Deletion inflates precision.","all-adverse-replicates-retained","Every registered replicate remains."),
 dimension("extension","summary-renormalized","Earlier distances disappear.","successor-retains-and-recomputes-pairs","New replicates extend all pair comparisons."),)
EXACT_RESULT="held-sample-measurand-method__same-held-repeatability-conditions__complete-positive-ordered-replicates__all-pair-positive-distance-or-EmptyOne__exact-extreme-distance-or-EmptyOne__repeatability-class-held-separately__all-adverse-replicates-retained__successor-retains-and-recomputes-pairs"
_s=HeldLabel("analytical-sample","s");_m=HeldLabel("analytical-method","m");_c=HeldLabel("repeatability-condition","same");_v=(Fraction(10),Fraction(101,10),Fraction(99,10));_x=replicate_record(_s,_m,_c,_v)
OPERATIONAL_WITNESSES=(("identity","Identity held.",_s.label=="s"),("conditions","Condition held.",_c.label=="same"),("support","Three rows retained.",len(_x[0])==3),("comparison","Three pairs retained.",len(_x[1])==3),("spread","Spread exact.",_x[2]==Fraction(1,5)),("class","No reference imported.",len(_x)==3),("adverse","Lowest row retained.",min(_x[0])==Fraction(99,10)),("successor","Pairs extend.",len(replicate_record(_s,_m,_c,_v+(Fraction(10),))[1])==6))
