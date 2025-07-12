# Lab 8: SRE

## Task 1: Key Metrics

### Top 3 CPU-consuming processes:
1. `java` - 1.2%
2. `nginx` - 0.9%
3. `node` - 0.3%

### Top 3 memory-consuming processes:
1. `java` - 1.8%
2. `python3` - 0.4%
3. `mysqld` - 0.1%

### Top 3 I/O devices (from iostat):
1. CPU usage is very low: ~3.2% busy, ~99.5% idle.
2. Disk sdc is the most active with ~11 reads/sec and ~3 writes/sec.
3. No significant I/O wait times observed.

The system is not under load

### Largest files in /var:
1. `/var` - 739 MB
2. `/var/lib` - 453 MB
3. `/var/lib/apt/lists` - 423 MB