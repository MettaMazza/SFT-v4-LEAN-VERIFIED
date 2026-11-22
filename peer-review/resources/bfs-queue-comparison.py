#!/usr/bin/env python3
"""Reproduce the queue counts in Maria Smith's BFS discussion contribution.

Prepared with AI assistance. Python 3 standard library only.
Run: python3 bfs-queue-comparison.py

Discussion:
https://ishanjmukherjee.substack.com/p/optimal-bfs/comment/393706815
Article: https://ishanjmukherjee.substack.com/p/optimal-bfs

This educational comparison implements three marking policies on open square
8-neighbour grids. It retains the article's neighbour order and stops when the
target is popped. The initial entry counts as one enqueue. Pops include the
returned target; expansions count neighbour scans and exclude that target.
The skip variant checks visited after the target check and before marking.

This is not the article's interactive visualization, a timing benchmark, an
SFT implementation, or a new Lean proof. It records the example described in
the public discussion. All three variants return the same cell-count distance;
their queue histories differ. For n=6 the enqueue counts are 864, 111 and 36.
"""
from collections import deque
import json

def run(n, mode):
    grid = [[0] * n for _ in range(n)]
    queue = deque([(0, 0, 1)])
    enqueues, pops, expansions = 1, 0, 0
    if mode == 'discovery': grid[0][0] = 2
    while queue:
        r, c, distance = queue.popleft()
        pops += 1
        if r == c == n-1:
            return dict(mode=mode,n=n,distance=distance,enqueues=enqueues,pops=pops,expansions=expansions)
        if mode == 'dequeue_skip' and grid[r][c] == 2: continue
        if mode != 'discovery': grid[r][c] = 2
        expansions += 1
        for ar, ac in ((r-1,c-1),(r-1,c),(r-1,c+1),(r,c-1),(r,c+1),(r+1,c-1),(r+1,c),(r+1,c+1)):
            if 0 <= ar < n and 0 <= ac < n and grid[ar][ac] == 0:
                if mode == 'discovery': grid[ar][ac] = 2
                queue.append((ar,ac,distance+1))
                enqueues += 1

rows=[run(n,m) for n in (3,6) for m in ('dequeue_no_skip','dequeue_skip','discovery')]
assert all(r['distance']==r['n'] for r in rows)
print(json.dumps(rows,indent=2))
