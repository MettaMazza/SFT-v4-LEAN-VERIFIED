# Constructive reachability, cycles and shortest paths on generated finite graphs

**Maria Smith**  
Ernos Labs  
Correspondence: [Maria.smith.sftoe@gmail.com](mailto:Maria.smith.sftoe@gmail.com)  
18 November 2026 · Version 1.1 · DOI: 10.5281/zenodo.24354792  
SFT community and invitation: [https://discord.gg/QCNkzq6kZC](https://discord.gg/QCNkzq6kZC)

## Abstract

The original finite directed search returns true exactly when a complete valid path exists. The cycle search returns true exactly when a nontrivial valid path returns to an earlier node. The original undirected path search returns a shortest complete path whenever one exists, and returns None exactly when no path exists; identity retains the structural EmptyOne result. These equivalences follow from explicit path construction, finite-search exhaustion, return-trace induction and preserved queue-length bounds. The paper derives the proofs, exact cuts and token balance, boundary-depth dimension, finite open-family closure and inverse-image continuity. It retains the original traversal order and all input decisions. Two completed source entries supply twenty-one native Lean modules and 408 audited definitions and theorems with empty axiom dependencies. Executable reproduction exhausts 512 directed graphs, 64 undirected graphs, 64 ordered acyclic incidence complexes and all 256 open families on three points, yielding 29 topologies and 22,707 continuity decisions.

## 1. Generated graphs and complete path composition

An admitted directed graph is a pair \(G=(V,E)\), where \(V\) is a nonempty ordered list of distinct node identities and \(E\) is an ordered list of distinct directed pairs whose endpoints belong to \(V\). The constructor checks those conditions in that order. Self-edges are allowed. Let

\[
 \operatorname{Pairs}([v_0,\ldots,v_n])
 =[(v_0,v_1),\ldots,(v_{n-1},v_n)].
\]

The original path predicate is exactly

\[
 \operatorname{Valid}_G(P)\ \Longleftrightarrow\
 P\ne[]\ \land\ (\forall v\in P,\ v\in V)
 \ \land\ (\forall e\in\operatorname{Pairs}(P),\ e\in E).
\]

Thus a one-node path is valid precisely when its node belongs to \(V\). No edge is needed for that identity path. A zero-node list is rejected. These are `GraphOperations.pathMeaning`, `identityPathIff` and `emptyPathRejected` [6].

For arbitrary lists \(A,B\) and interface node \(m\), adjacent-pair induction gives

\[
 \operatorname{Pairs}(A\mathbin{+\!+}[m]\mathbin{+\!+}B)
 =\operatorname{Pairs}(A\mathbin{+\!+}[m])
  \mathbin{+\!+}\operatorname{Pairs}(m::B).
\]

At \(A=[]\), the first pair list is empty and the equation is immediate. At \(A=a::A'\), the common leading pair is retained and the induction equation applies to the remaining list. Node membership in the concatenation comes from one of the two component paths. Hence

\[
 \operatorname{Valid}_G(A\mathbin{+\!+}m::B)
 \ \Longleftrightarrow\
 \operatorname{Valid}_G(A\mathbin{+\!+}[m])
 \land\operatorname{Valid}_G(m::B).
\]

The forward direction restricts every node and pair to its component list; the reverse direction uses append membership to recover every whole-path obligation. `adjacentPairsComposition` and `pathCompositionIff` prove the exact list equations. Composing paths retains one shared interface node and every transition.

## 2. Reachability: soundness and completeness

A path witness from \(s\) to \(t\) is a nonempty valid list \(A\mathbin{+\!+}[t]\) whose first element is \(s\). The original directed search treats \(s=t\) by testing membership in \(V\). Otherwise it starts with frontier \([s]\) and empty visited list. It removes the frontier head, returns true if it equals \(t\), skips it if already visited, and otherwise appends it to visited before appending all its unvisited outgoing targets in original edge order.

### 2.1 Finite execution without changing the queue

The native search retains an auxiliary finite unseen list containing every frontier node and edge target not yet visited. Its initial list is the origin followed by all edge targets. On a fresh expansion it removes the held node from unseen; on a visited-node skip unseen is unchanged. The lexicographic measure

\[
 (|\mathrm{unseen}|,|\mathrm{frontier}|)
\]

strictly decreases. A fresh head belongs to unseen by the coverage invariant and is removed, reducing the first coordinate. A skip removes one queue entry, reducing the second coordinate. Appending all original outgoing targets preserves the coverage invariant. This proves termination of the unchanged source queue, including repeated queued entries, through `GraphReachability.searchOrder`, `skipDecreases` and `expandDecreases`.

### 2.2 A successful search constructs the whole path

Maintain the frontier property: every queued node is either the initial origin or has a complete path witness from it. Initially the sole frontier element is the origin. A skip retains the property for the tail. At an expansion, each new target \(u\) comes from a retained edge \((v,u)\). Constructor admission supplies both endpoint memberships. If \(v\) is the initial origin, its identity path is valid; otherwise its witness is already present. Compose that witness with \([v,u]\) using Section 1. The result is the complete witness to \(u\).

A successful target hit therefore supplies a path, except for the identity case already decided by node membership. The native induction is `searchPreservesProperty` instantiated with this exact property; `extendPathWitness`, `reachableHasPath` and `admittedReachabilityHasPath` give the resulting construction.

### 2.3 Exhaustion cannot omit a valid path

The completeness invariant is

\[
 v\in\mathrm{visited}\ \land\ (v,u)\in E
 \quad\Longrightarrow\quad
 u\in\mathrm{visited}\ \lor\ u\in\mathrm{frontier}.
\]

Skipping an already visited head preserves coverage: the removed node still belongs to visited. On expansion, every edge from the new visited node either ends in visited or generates a frontier entry. Earlier visited edges retain their coverage. These are `skipPreservesClosure` and `expandPreservesClosure`.

If the search returns false, well-founded induction constructs an exhausted set-list \(X\) that contains the starting frontier and visited nodes, omits \(t\), and is closed under all outgoing edges:

\[
 s\in X,\qquad t\notin X,\qquad
 v\in X\land(v,u)\in E\Longrightarrow u\in X.
\]

At empty frontier, the invariant gives outgoing closure of visited itself. In either recursive branch, the final exhausted list supplied by induction contains every removed or retained old entry. A valid path beginning at \(s\) must lie wholly in \(X\): its first node is in \(X\), and each successive edge preserves membership. In particular its last node \(t\) would lie in \(X\), contradicting exhaustion.

Thus every complete path is found. Combining both directions gives, for every admitted finite graph and arbitrary origin and target,

\[
 \operatorname{reachable}(G,s,t)=\mathrm{true}
 \quad\Longleftrightarrow\quad\operatorname{PathWitness}_G(s,t).
\]

`searchFailureCertificate`, `closedAlongPath`, `pathWitnessReachable` and `admittedReachabilityIffPath` implement this proof [6]. Identity witnesses prove reflexivity on \(V\); composing witnesses and applying completeness proves transitivity.

## 3. Cycles as complete return paths

The original cycle search visits each node in carrier order. At a current node it scans edges in their stored order, ignoring edges with another origin. If a matching edge returns to a node already in the held path, it succeeds. Otherwise it appends the fresh target and recursively visits it; a failed child resumes the remaining edge scan.

Its exact trace relation has two constructors. A closing step is

\[
 (v,u)\in E,\ u\in H
 \quad\Longrightarrow\quad\operatorname{ReturnTrace}(v,H,[u]).
\]

An advancing step is

\[
 (v,u)\in E,\ u\notin H,\
 \operatorname{ReturnTrace}(u,H\mathbin{+\!+}[u],T)
 \quad\Longrightarrow\quad\operatorname{ReturnTrace}(v,H,u::T).
\]

A recursive advance removes its fresh target from a finite unseen-target list, strictly reducing its length. The local edge scan is ordinary list recursion. These two inductions establish finite execution with the original order unchanged.

For soundness, induction through a successful edge scan finds its first successful branch. An immediate return gives the closing constructor. A successful recursive visit gives a child trace, to which the advancing constructor prepends the traversed target. For completeness, induction on a return trace selects its first edge in the exhaustive scan. Its closing constructor triggers immediate success; its advancing constructor supplies recursive success. Earlier successes also suffice, and earlier failures leave the selected edge available. Hence the actual Boolean visit succeeds exactly when a return trace exists.

Every such trace is nonempty, contains only the traversed directed edges, and has a decomposition \(A\mathbin{+\!+}[u]\) with \(u\) in the initial held path or in \(A\). Starting from a node \(v\) and held path \([v]\), endpoint admission turns it into a complete valid path

\[
 P=v::(A\mathbin{+\!+}[u]),\qquad u\in v::A.
\]

Conversely, scan any such valid path. If its next node is already held, its first return closes a trace immediately. If fresh, append it and apply induction to the remaining path. This derives a return trace even when the supplied path continues beyond its first return. Therefore

\[
 \operatorname{cycleExists}(G)=\mathrm{true}
 \ \Longleftrightarrow\
 \exists v,A,u:\ v\in V\land\operatorname{Valid}_G(v::(A\mathbin{+\!+}[u]))
 \land u\in v::A.
\]

`GraphCycleTrace.cycleVisitIffReturnTrace`, `walkReturnProducesTrace` and `admittedCycleIffCompleteReturnPath` prove the equivalence. It includes the one-edge self-return \([v,v]\) when \((v,v)\in E\). Repetition without the connecting edge trace is never sufficient.

## 4. The ordered undirected shortest-path operation

The original geometry operation takes a supplied node list \(N\), finite edge list \(E\) and endpoints \(s,t\). It checks that both endpoints belong to \(N\). If they coincide, it returns the structural EmptyOne record. For distinct endpoints, each pair \((a,b)\in E\) may be traversed in either direction. Its queue holds complete pairs \((v,P)\), beginning with \((s,[s])\). A visited head is skipped. A fresh head is marked visited, and every unvisited neighbor is scanned in original edge order. A target neighbor returns the extended path immediately; otherwise all extended paths are appended in that order.

This operation has its own original domain: it checks endpoint membership, while intermediate identities and adjacency come from the supplied edges. For example,

\[
 N=[a,c],\quad E=[(a,x),(x,c)]
 \quad\Longrightarrow\quad\operatorname{pathDistance}(N,E,a,c)=[a,x,c].
\]

The theorem retains that behavior. A complete undirected trace starts at \([s]\) and appends \(u\) to a trace ending at \(v\) when \((v,u)\in E\) or \((u,v)\in E\). Every queue item has such a trace by induction on queue updates. Every returned result therefore has the correct start, terminal and full adjacency sequence (`pathLoopTrace`, `pathDistanceTrace`).

The queue terminates using the lexicographic unseen-endpoint/queue-length measure from Section 2, now covering both endpoints of every supplied edge. It does not impose a numerical iteration cap or alter queue duplicates.

### 4.1 The four shortest-path invariants

The proof retains four properties of the queue \(Q\) and visited list \(V_*\):

1. **Origin coverage.** The origin is visited, or the queue contains its one-node identity path.
2. **Visited-neighbor bound.** For every visited \(v\), every complete trace \(P:s\leadsto v\), and every adjacent \(u\), either \(u\) is visited or the queue contains a path to \(u\) of length at most \(|P|+1\).
3. **Queue order.** Path lengths are nondecreasing from head to tail.
4. **Queue width.** Any two queue path lengths differ by at most one.

Lengths here count retained nodes; the edge count of a nonempty path is one less. These are the native `OriginCovered`, `VisitedBound`, `QueueOrdered` and `QueueWidth` predicates in `GeometryShortest` [7].

First prove the frontier lower-bound lemma: if a trace reaches an unvisited node, some queue item has length no greater than that trace. Induct on the trace. At its identity base, origin coverage supplies the item. At a final edge, if its preceding node is visited, the visited-neighbor bound supplies an item to the final node. If the preceding node is unvisited, apply induction to the prefix; its bound also bounds the longer trace. Queue order then shows that a fresh queue head is no longer than any alternative trace to that head.

When the fresh head is expanded, each new neighbor path has head length plus one. That fresh-head minimality establishes the visited-neighbor bound for the new visited node; old bounds survive because old queue entries remain or have become visited. All new entries have equal length. Old remaining entries are at most head length plus one by queue width and at least head length by queue order. Appending the new entries therefore preserves both nondecreasing order and width at most one. A skip preserves the same properties by removing only an already visited head. The initial one-item queue satisfies all four properties.

### 4.2 Immediate target return is already minimal

Before the first target hit, the target is neither visited nor queued: encountering it as a neighbor returns immediately instead of enqueuing it. For any alternative target trace \(P\), a stronger frontier lemma produces a queued item \(q\) satisfying

\[
 |q|+1\le|P|.
\]

The identity case would put the target at the origin and contradict distinct endpoints. At the last edge of \(P\), a visited predecessor would already have visited or queued the target, contradicting the invariant. Hence that predecessor is unvisited. Apply the previous frontier lower-bound lemma to the prefix and add one for the last edge. This is `frontierStrict`.

At a target hit, let \(h\) be the current queue-head path. Queue order gives \(|h|\le|q|\). The returned path is \(h\mathbin{+\!+}[t]\), so

\[
 |h\mathbin{+\!+}[t]|=|h|+1\le|q|+1\le|P|.
\]

Thus the first returned path is no longer than any complete alternative. If the queue were empty while an alternative existed, the frontier lower-bound lemma would demand an item in the empty queue, a contradiction. Well-founded induction over skips and expansions yields both discovery and minimality. `pathLoopBound`, `pathDistanceComplete` and `pathDistanceShortest` encode these arguments.

For admitted distinct endpoints, returning None is equivalent to absence of any complete undirected trace. In one direction, a trace would force a successful result by completeness. In the other, a successful result would itself supply a trace by soundness. `pathDistanceNoneIff` proves this exact negative result.

Equal-length alternatives retain source order. With edges \([(a,b),(a,c),(b,d),(c,d)]\), the result from \(a\) to \(d\) is \([a,b,d]\). Swapping the first two edges gives \([a,c,d]\). Both are shortest; the original queue determines which complete witness is returned.

## 5. Cuts, network balance and boundary depth

For a nonempty held node selection \(H\subseteq V\), the crossing cut is the ordered edge filter

\[
 \delta(H)=[(a,b)\in E\mid(a\in H)\mathbin{\mathrm{xor}}(b\in H)].
\]

Filter membership proves both directions: every returned edge is original and has exactly one selected endpoint; every such edge is returned. Duplicate entries in the supplied selection do not change membership decisions. `cutMembership` preserves the original edge order and criterion.

The original internal-balance operation takes incoming and outgoing lists of token words. It succeeds exactly when the incoming list is nonempty, the two lengths agree, and each list is internally duplicate-free. `balanceMeaning` is obtained by splitting the corresponding Boolean conjunction. Equal lengths permit positional pairing of every incoming word with exactly one outgoing word, and conversely. This retains the two complete lists; it does not require their token identities to be equal.

### 5.1 Fresh-node support and preservation

Let \(z\notin V\) be a fresh node and let \(V'=V\mathbin{+\!+}[z]\). The original successor generates the ordered pair support in row order. Writing \(\Vert\) for concatenation in the displayed order, its exact expansion is

\[
 \operatorname{PairsCarrier}(V')=
 \mathop{\Vert}_{v\in V}\left([(v,u):u\in V]\mathbin{+\!+}[(v,z)]\right)
 \mathbin{+\!+}[(z,u):u\in V]\mathbin{+\!+}[(z,z)].
\]

For each old left endpoint, mapping over the appended carrier retains its old row and appends its one pair to \(z\). The final left endpoint is \(z\), giving its complete row, including its self-pair. Induction distributes mapping and concatenation over the original node list and proves this order exactly (`freshGraphPairSupportOrder`). Thus the successor retains all old pair cells and supplies every new pair cell once. It makes \(2|V|+1\) new cells; the graph selects its actual added edges from them. Self-edges remain admitted by the original graph constructor. [4,6]

Let \(F\) be a duplicate-free ordered selection of added edges, each with endpoints in \(V'\) and at least one endpoint equal to \(z\). No edge can belong to both \(E\) and \(F\): an old edge has both endpoints in \(V\), while equality to a new edge would put \(z\) in \(V\). Therefore \(E\mathbin{+\!+}F\) is duplicate-free. The appended carrier is nonempty and distinct, and every retained or new endpoint belongs to it. All original constructor checks hold, proving

\[
 G'=(V\mathbin{+\!+}[z],E\mathbin{+\!+}F)
 \quad\text{is admitted}.
\]

These are the arguments in `freshEdgesDisjoint` and `freshGraphAccepted`. Every valid old path retains its complete node and edge memberships in \(G'\); its first and last nodes are unchanged. A return trace also persists: its closing edge remains, and each advancing constructor retains the same edge, freshness test and recursively retained tail. Consequently old reachability and old cycle witnesses persist (`retainedPathValid`, `retainedReachability`, `retainedReturnTrace`, `retainedCycle`).

For a proposed path whose nodes all lie in \(V\), even its rejection decision is preserved when every added edge touches \(z\). If such a path became valid, an adjacent edge absent from \(E\) must occur in \(F\). Both endpoints occur in the old-node path, so the endpoint equal to \(z\) would belong to \(V\), a contradiction. This proves `freshOnlyEdgesPreserveOldPathDecision`. Paths traversing the fresh node are tested by their full new edge traces. The source base is the one-node edgeless graph: its identity path and reachability hold and it has no return cycle (`oneGraphAccepted`, `oneIdentityPath`, `oneIdentityReachable`, `oneHasNoCycle`). [6]

### 5.2 Exact cut updates

For any retained nonempty selection \(H\subseteq V\), let \(\chi_H(a,b)\) be the exclusive-or test in the cut definition. Filtering distributes over concatenation, hence

\[
 \delta_{G'}(H)=\delta_G(H)\mathbin{+\!+}
                 [e\in F:\chi_H(e)].
\]

The proof is list induction: an edge passing the test is prepended to both sides; a rejected edge is omitted from both. The old selection remains valid in the extended carrier. This is `cutUnderFreshExtension`.

If the fresh node is also selected, \(H'=H\mathbin{+\!+}[z]\), membership becomes

\[
 x\in H'\iff(x\in H)\lor(x=z).
\]

Neither endpoint of an old edge equals \(z\). Its two endpoint tests, and hence its crossing decision, remain unchanged. Only added edges require the enlarged-selection test:

\[
 \delta_{G'}(H')=\delta_G(H)\mathbin{+\!+}
                  [e\in F:\chi_{H'}(e)].
\]

`cutCheckHeldAppend`, `cutCheckUnchangedAway` and `freshHeldCutUpdate` give these exact equations. Selecting an additional existing node uses the same disjunction and tests every original edge in order (`cutHeldSelectionExtension`). [6]

### 5.3 Complete token pairing and its successor

Write the incoming and outgoing words as \(I=[i_1,\ldots,i_n]\) and \(O=[o_1,\ldots,o_n]\). Positional pairing gives the complete relation \([(i_1,o_1),\ldots,(i_n,o_n)]\). Distinctness within each list makes each incoming and each outgoing token occur in exactly one pair. Every token identity remains present; the paired incoming and outgoing names need not be the same. A single pair is the first balanced case (`firstTokenPairBalanced`).

For arbitrary finite prior lists, append one token to each. Expanding the original balance predicate gives the exact equivalence

\[
 \operatorname{Balance}(I\mathbin{+\!+}[i],O\mathbin{+\!+}[o])
 \iff |I|=|O|\ \land\operatorname{Distinct}(I)
 \land\operatorname{Distinct}(O)\land i\notin I\land o\notin O.
\]

The appended incoming list is automatically nonempty. Equal successor lengths imply equal prior lengths by cancellation of one. An appended list is distinct exactly when its prefix is distinct and its final token is absent from that prefix: splitting the duplicate test proves necessity; checking old-old and old-new pairs proves sufficiency. Apply this on both sides. This is `balancePairedExtensionIff`. If the prior pair is balanced, the equivalence reduces precisely to the two freshness conditions (`balancedPairRequiresFreshTokens`), and the successor appends the new pair while retaining every old pair. These are the original graph-law base and successor obligations, with their existing native proofs. [4,6]

### 5.4 Boundary depth

For incidence geometry, \(C\) is a nonempty distinct cell list and \(B\) a distinct list of face-to-cell pairs with both endpoints in \(C\) and unequal endpoints. `incidenceMeaning` proves equivalence of these conditions and the exact well-formedness check. Boundary depth separately detects a return during recursive descent. For the queried cell \(c\), let \(F(c)\) be every retained face whose boundary pair ends at \(c\). Successful depth satisfies

\[
 d(c)=\begin{cases}1,&F(c)=[],\\1+\max_{f\in F(c)}d(f),&F(c)\ne[].\end{cases}
\]

The algorithm retains the active visiting path. Encountering a visited cell returns the original cycle error. Otherwise it recursively evaluates every face in order and adds one to the maximum returned height. The native `DepthDerivation` constructor requires freshness and a derivation for every face; its result is one plus their maximum, with empty maximum zero. Induction on the successful computation constructs precisely this derivation. Conversely, induction through the face derivations makes every recursive call succeed and reconstructs the same maximum. `dimensionIffDerivation` proves the equivalence for admitted incidence and queried-cell membership.

Each successful face chain has height at most the computed maximum plus one; a maximizing face attains that value. Induction therefore identifies depth with the longest retained descent, counted in cells. In the original example, point cells have depth 1, the cells pq and qr have depth 2, and their parent triangle has depth 3. Distinct cells are adjacent exactly when their face lists share a member. The existential shared-face witness proves adjacency symmetry by exchanging its two memberships.

## 6. Generated open families and inverse-image continuity

The finite topology source uses an ordered point carrier \(X\) and the exact normalization

\[
 N_X(A)=\operatorname{filter}_{x\in X}(x\in A),
\]

with an empty filtered result represented by the original EmptyOne record. The canonical family removes duplicates from the normalized supplied opens. Acceptance requires a nonempty distinct point carrier, canonical-family length equal to the supplied-family length, presence of EmptyOne and the whole carrier, and closure under the original pair operations

\[
 U_X(A,B)=\operatorname{filter}_{x\in X}(x\in A\lor x\in B),
\]
\[
 I_X(A,B)=\operatorname{filter}_{x\in X}(x\in A\land x\in B),
\]

again using EmptyOne when the result is empty. `topologyMeaning` proves exactly this conjunction by expanding the Boolean tests and all-member checks.

A generated join of a finite admitted subfamily starts with EmptyOne and repeatedly applies \(U_X\). Induction proves that it stays in the canonical open family: the base is its required EmptyOne member, and the successor uses the binary closure clause. Generated finite intersections start with the whole carrier and use \(I_X\); the same induction proves closure. These are `generatedJoinAdmitted` and `generatedIntersectionAdmitted`.

The original continuity operation converts mapping rows into a dictionary, so the final row for a repeated key supplies its image. It requires that the resulting key set equal the source point set. For each supplied target open \(O\), it constructs

\[
 f^{-1}(O)=[x\in X\mid f(x)\in O],
\]

with EmptyOne for empty inverse image, and tests membership in the supplied source opens. Hence continuity holds exactly when the key-coverage conditions and every inverse-open condition hold. `continuousMeaning` proves the equivalence; `imageLastWins` proves the actual duplicate-key decision. The source does not run the topology validator inside this operation; its arguments remain the declared source and target open families.

The registered geometry grammar also identifies connectedness by absence of a nonempty disjoint open separation and deformation by a reversible incidence-preserving trace. These are retained source criteria. The executable operations treated here are incidence, boundary depth, adjacency, path distance, open-family closure and continuity, exactly as defined by the original source.

## 7. Complete grammar construction and uniqueness

The graph registration has nine binary coordinates and the geometry/topology registration ten. Their literal source alternatives are listed below, with hyphens displayed as spaces.

### 7.1 Directed graphs and networks

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| nodes | partial or aliased nodes | complete canonical nodes |
| edges | free endpoint list | held pair cell relation |
| orientation | signed edge weight | held endpoint order |
| path | endpoint only | complete adjacent trace |
| connectivity | assumed connected | generated path witness |
| cycle | repeated label only | explicit return path |
| cut | borrowed scalar threshold | held crossing selection |
| balance | unaccounted net value | ingress egress pairing |
| addition | extra network rule | no extra network rule |


### 7.2 Finite geometry and topology

| Coordinate | First alternative | Admitted alternative |
|---|---|---|
| cells | coordinate samples | canonical generated cells |
| incidence | assumed containment | held acyclic boundary |
| dimension | borrowed coordinate count | boundary chain depth |
| adjacency | metric threshold | shared incidence witness |
| distance | floating metric | shortest generated path |
| opens | named neighborhoods | generated open family closure |
| connectedness | visual continuity | no disjoint open separation |
| continuity | epsilon scale | inverse open preservation |
| deformation | untracked shape change | reversible incidence trace |
| addition | continuum or extra metric | no ambient continuum |


The nested product generator contains \(2^9=512\) graph candidates and \(2^{10}=1{,}024\) geometry candidates in the original coordinate order. For any candidate, case analysis on each binary field proves membership in that field's generating pair. Nesting those witnesses through the product proves that every candidate appears. The original decision matches the conjunction of all admitted-field tests:

\[
 D(c)=\bigwedge_{i=1}^{d}[c_i=\mathrm{admitted}],\qquad d\in\{9,10\}.
\]

Success forces every field to its admitted constructor and hence determines one candidate. That candidate passes by direct evaluation. Any first-alternative field contradicts its corresponding conjunct and is rejected. `GraphGrammar` and `GeometryGrammar` retain the complete enumeration, criteria equivalence and unique survivor. The witnesses, source clauses, exact rejection reasons and controls are retained in their corresponding native evidence modules.

The mathematical closure arguments use the generated objects themselves. Complete paths extend one edge at a time; search exhaustion propagates closure along each edge; cycles retain the first lawful return; finite queues preserve the length invariants at every extension; boundary derivations include every face; open families remain closed under each generated finite combination. These arguments quantify over arbitrary finite source data, rather than relying on a fixed graph-size table.

## 8. Evidence and executable reproduction

| Completed registration | Direct modules | Audited definitions and theorems | Retained completion |
|---|---:|---:|---|
| SFT-MATH-GRAPH-NETWORK-001 | 13 | 204 | TURN118; source/program review TURN115, audit TURN117 |
| SFT-MATH-GEOMETRY-TOPOLOGY-001 | 8 | 204 | TURN124 |
| Total | 21 | 408 | Two source entries |

All 408 listed definitions and theorems have raw empty-axiom audit records. All 65 native modules including imports match the published V4 archive, and every recorded graph receipt source/module digest matches. The original complete-program reports retain all 512 and 1,024 candidate decisions and the applicable registration, census, closure, control and hash fields. The corresponding successful builds and source-specific reviews accompany the proof bodies.

The portable replay executes the original Python operations and compares them with independently enumerated witnesses. It checks all 512 directed graphs on three labelled nodes, including self-edges: 4,608 reachability pairs, 487 cycle-positive graphs and 3,584 cuts. It checks all 64 undirected simple graphs on four nodes and their 1,024 endpoint pairs against every simple path, including disconnection and identity results. It separately preserves original ordered ties and the endpoint-only raw distance domain.

For incidence, all 64 subsets of the six forward pairs on four ordered cells give 256 queried depth checks against enumerated longest chains; the cycle error is checked separately. All 256 open families on three points yield exactly 29 accepted topologies. Across every ordered pair of these topologies and all 27 point maps, the 22,707 continuity decisions agree with the complete inverse-image test; 9,867 maps pass. Mapping overwrite and original balance controls are also retained.

`SOURCE_CORRESPONDENCE.json` records the exact declarations, source paths, pins and digests. `SOURCE_AND_EVIDENCE.zip` contains the original source, native proofs and retained evidence. Extract it and run `python3 reproduction/check_paper_arithmetic.py` to regenerate the paper's finite witness comparisons. The general equivalence and shortest-path theorems are supplied as the native induction proofs described above.

<div style="break-before: page"></div>

## References

[1] Maria Smith. SFT V3 foundation. [doi:10.5281/zenodo.21627656](https://doi.org/10.5281/zenodo.21627656).

[2] Maria Smith. SFT exhaustive monograph. [doi:10.5281/zenodo.21900790](https://doi.org/10.5281/zenodo.21900790).

[3] Maria Smith. SFT V4 Lean verified corpus, edition 0.4. [doi:10.5281/zenodo.24320778](https://doi.org/10.5281/zenodo.24320778). Contact edition: [doi:10.5281/zenodo.24337358](https://doi.org/10.5281/zenodo.24337358).

[4] Maria Smith. V3 graph/network construction, `sft/mathematics/graph_network/law.py`, pinned commit `76f1b34e9e9682989adcbb088797b4ae4ce4fcf1`. Original registration, derivation, certificate and execution/validator files accompany this paper.

[5] Maria Smith. V3 finite geometry/topology construction, `sft/mathematics/geometry_topology/law.py`, at the commit in [4]. Original source operations and complete ten-axis specification are included verbatim.

[6] Maria Smith. [Native graph proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Mathematics), V4 commit `21cdf559922fb057f8560f42d056ffa035329eb3`. GraphOperations, GraphReachability, GraphPathSoundness, GraphPathCompleteness, GraphCycles, GraphCycleTrace, GraphInduction, GraphExtension, GraphPartitionBalance and graph grammar/evidence modules; TURN115/117/118 evidence.

[7] Maria Smith. [Native geometry and shortest-path proofs](https://github.com/MettaMazza/SFT-v4-LEAN-VERIFIED/tree/21cdf559922fb057f8560f42d056ffa035329eb3/SFT/Mathematics), same V4 commit. GeometryTopology, GeometryDimension, GeometryPaths, GeometryShortest and geometry grammar/evidence modules; TURN124 completion and full-program evidence.
