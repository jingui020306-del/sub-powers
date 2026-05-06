---
name: sub-powers-performance
description: Use for algorithm, indexing, I/O, database, memory/VRAM, CPU/GPU, latency, throughput, batch, or runtime bottlenecks where measurement and correctness must guide optimization.
metadata:
  short-description: Measurement-first performance work
---

# Sub-Powers Performance

Correctness comes before speed.

## Start

- Slow code, algorithm performance, indexing, database, I/O, memory/VRAM, CPU/GPU utilization, latency, throughput, batch size, or runtime bottleneck.

## Required Output

- Baseline.
- Suspected hot path.
- Resource utilization.
- Measurement method.
- Correctness risk.
- After result.
- Measurement limits.
- Remaining bottlenecks.

## Inspect When Relevant

- CPU/GPU utilization.
- Memory/VRAM.
- I/O wait.
- Throughput and latency.
- Batch size.
- Algorithm complexity.
- Data loading and preprocessing.
- Serialization/deserialization.
- CPU-GPU transfer.
- Batching and caching.
- Indexing and retrieval.
- Concurrency and locks.
- Benchmark reproducibility.

## Rules

- Optimize only measured hot paths.
- Preserve existing outputs before changing performance-sensitive code.
- Use focused tests when optimization changes algorithm behavior, ordering, edge cases, or data contracts.
- Prefer simple algorithm/index/data-structure improvements before complex rewrites.
- Do not mix optimization with unrelated cleanup, redesign, dependency upgrades, or behavior changes.
