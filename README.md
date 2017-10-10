# GFS-Kernel

This is a simple bootloader combined with a (not yet written) kernel I wrote for school.

## Floppy Disk

Sector size: 512 Bytes

### Disk Layout

| C   | H   | S   | Content        |
|-----|-----|-----|----------------|
| 0   | 0   | 1   | stage1         |
| 0   | 0   | 2   | stage2 (start) |
| ... | ... | ... | ...            |
| 0   | 0   | 18  | stage2 (end)   |
| 0   | 1   | 1   | (unused)       |
| ... | ... | ... | ...            |
| 0   | 1   | 18  | (unused)       |
| 1   | 0   | 1   | kernel (start) |
| ... | ... | ... | ...            |
| 32  | 1   | 18  | kernel (end)   |
| 0   | 0   | 2   | stage2 (start) |
| ... | ... | ... | ...            |
| 0   | 0   | 18  | stage2 (end)   |
| 0   | 1   | 1   | (unused)       |
| ... | ... | ... | ...            |
| 0   | 1   | 18  | (unused)       |
| 1   | 0   | 1   | kernel (start) |
| ... | ... | ... | ...            |
| 32  | 1   | 18  | kernel (end)   |
| 33  | 0   | 1   | (unused)       |
| ... | ... | ... | ...            |
| 79  | 1   | 18  | (unused)       |


## Bootloader

The bootloader consists of two stages:
The first stage is written to the boot sector of the floppy disk.
Then it loads the second stage into memory and begins execution.
The second stage loads and executes the kernel

## Kernel

No content yet
