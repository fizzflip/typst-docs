#let meta = json("../../../misc/metadata.json")

#let m(it) = box(
  fill: rgb("#1b1b1f"),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 3pt),
  radius: 3pt,
  stroke: 0.2pt + rgb("#555"),
  text(fill: rgb("#ffffff"), font: "DejaVu Sans Mono", size: 9.5pt, it),
)

// Helper function for visual progress bars inside dark tables
#let progress_bar(percent, fill_color: rgb("#10b981")) = box(
  width: 100%,
  height: 11pt,
  radius: 3pt,
  fill: rgb("#2b2b36"),
  [
    #place(left)[
      #block(
        width: percent * 100%,
        height: 100%,
        radius: 3pt,
        fill: fill_color,
      )
    ]
    #align(center + horizon)[
      #text(size: 7pt, weight: "bold", fill: white)[#str(calc.round(percent * 100))% Saved]
    ]
  ],
)

#set page(
  paper: "a4",
  fill: rgb("#141414"), // Dark background
  margin: (x: 2.5cm, y: 2.5cm),
  footer: context {
    if here().page() > 2 {
      set text(size: 9pt, fill: gray.lighten(30%))
      [Huffman Coding Analysis -- ADA]
      h(1fr)
      counter(page).display("1 / 1", both: true)
    }
  },
)

#set text(
  fill: rgb("#f0f0f0"), // Light text
  font: ("Magnisa Sans", "Times New Roman"),
  size: 11pt,
)

#set par(
  justify: true,
  leading: 0.7em,
  spacing: 1.2em,
)

#show heading: it => block(
  inset: (top: 1em, bottom: 0.5em),
  text(size: 1.4em, weight: "regular", fill: rgb("#ffffff"), it.body),
)

#show heading.where(level: 2): it => block(
  inset: (top: 0.5em, bottom: 0.3em),
  text(size: 1.2em, weight: "regular", fill: rgb("#ffffff"), it.body),
)

// Custom code block styling
#show raw.where(block: true): it => block(
  fill: rgb("#1b1b1f"),
  inset: 12pt,
  radius: 6pt,
  width: 100%,
  stroke: 0.5pt + rgb("#333"),
  text(fill: rgb("#e0e0e0"), font: "DejaVu Sans Mono", size: 9pt, it),
)

// --- PAGE 1: COVER ---
#align(right)[
  #text(size: 48pt, weight: 900, font: "Magnisa Sans")[#meta.name]

  #v(-2.5em)
  #box[
    #set text(size: 19pt, font: "Arcon")
    #grid(
      columns: (auto, auto),
      align: (right, left),
      inset: (x: 0.6em, y: 0.2em),
      stroke: (x, y) => if x == 0 { (right: .5pt + rgb("#ffffff")) } else {
        none
      },
      [#meta.subject], [SUB],
      [#meta.roll_no], [#meta.ern],
      [#meta.section], [#meta.cla],
      [II], [#meta.ala],
    )
  ]
]

#v(1fr)
#align(left)[
  #set text(
    size: 48pt,
    font: "Mexcellent",
  )
  #set par(leading: 0.2em)
  HUFFMAN \
  CODING \
  ANALYSIS
]

#pagebreak()

// --- PAGE 2: TABLE OF CONTENTS ---
#v(2em)
#align(center)[
  #text(size: 2em, weight: "bold")[Table of Contents]
]
#v(1em)
#outline(title: none, indent: auto)

#pagebreak()

// --- PAGE 3+: MAIN CONTENT ---
#counter(page).update(1)

= Introduction
In standard computer systems, textual data is stored using fixed-length encoding schemes such as #m[ASCII] or #m[UTF-8]. Under standard #m[ASCII], every character (e.g., `'a'`, `'e'`, `'z'`, `'\n'`) occupies exactly $8 "bits"$ ($1 "byte"$) of storage regardless of how frequently characters appear in the file.

However, natural language text and structured data files exhibit a non-uniform character frequency distribution. For instance, in typical English text, the letter 'e' occurs far more frequently than the letter 'z'. Storing 'e' using the same number of bits as 'z' results in significant statistical redundancy.

To eliminate this redundancy, we use a *variable-length prefix code*. Instead of giving every character 8 bits, we assign shorter binary codes to frequent characters and longer binary codes to rare ones.

A *prefix code* guarantees that no character's binary code is a starting prefix of another character's code (for example, if `'e'` is assigned `#m[01]`, no other character's code can start with `#m[01]`). This property ensures the compressed bitstream can be decoded unambiguously from left to right without needing spaces or extra delimiters.

The overall objective is simple: minimize the total file size by ensuring that the most common characters contribute the fewest total bits to the final stream.

#v(0.5em)
#align(center)[
  #image("assets/huffman_encoding_comparison.svg", width: 100%)
]

== 1. Algorithmic Taxonomy of Lossless Compression
Huffman coding belongs to the class of *Entropy Coding* algorithms. Below is a taxonomy mindmap showing where Huffman coding fits within the broader landscape of data compression algorithms:

#v(0.5em)
#align(center)[
  #image("assets/compression_taxonomy.svg", width: 93%)
]
#v(0.5em)

== 2. High-Level Compression / Decompression Pipeline
The compression process transforms raw bytes into a compact bitstream, while decompression executes the exact inverse operations:

#v(0.5em)
#align(center)[
  #image("assets/compression_decompression_pipeline.svg", width: 100%)
]
#v(0.5em)

== 3. Scale of the Problem
File storage and network transmission are fundamental constraints in computer science. Modern systems process gigabytes of log files, source code repositories, and web assets every second:

#align(center)[
  #table(
    columns: (1.4fr, 1.2fr, 1.2fr, 1.4fr),
    fill: (x, y) => if y == 0 { rgb("#1e1b2e") } else if calc.even(y) { rgb("#1b1b1f") } else { rgb("#141414") },
    stroke: 0.3pt + rgb("#444"),
    align: (col, row) => if row == 0 { center } else { horizon },

    [*File Type / Asset*], [*Fixed 8-Bit Size*], [*Huffman Encoded Size*], [*Space Savings*],
    [English Text (.txt)], [1,000,000 bytes], [$approx 560,000 "bytes"$], progress_bar(0.44),
    [JSON Data (.json)], [5,000,000 bytes], [$approx 2,750,000 "bytes"$], progress_bar(0.45),
    [Source Code (.cpp/.py)], [500,000 bytes], [$approx 290,000 "bytes"$], progress_bar(0.42),
  )
]

== 4. Why Solving it Efficiently Matters
1. *Storage Optimization:* Saving $40\% - 50\%$ of file storage space directly reduces storage media requirements in web servers, cloud archives, and database systems.
2. *Network Bandwidth Reduction:* Transmitting smaller files over networks reduces transfer latency and bandwidth consumption during network downloads.
3. *Foundation for Advanced Compression:* Huffman coding serves as the final entropy encoding stage in major industrial compression standards, including #m[ZIP], #m[GZIP], and #m[JPEG].

#pagebreak()

= Algorithmic Principle

== 1. The Greedy Choice Paradigm
Huffman coding relies on the *Greedy Algorithmic Paradigm*. A greedy algorithm builds up a solution piece-by-piece, always choosing the option that offers the most immediate local benefit.

In the case of prefix tree construction, the greedy choice rule is:
#align(center)[
  #block(
    fill: rgb("#1b1b24"),
    stroke: 0.5pt + rgb("#4f46e5"),
    inset: 12pt,
    radius: 6pt,
    width: 90%,
  )[
    *Greedy Rule:* Repeatedly merge the two trees that have the lowest total frequencies. \ This guarantees that characters with the lowest frequencies end up deepest \ in the tree (receiving the longest code lengths).
  ]
]

== 2. Encoder Component Interaction Pipeline
The component interaction diagram below shows how internal software modules pass data and state during the encoding process across three core phases:

#align(center)[
  #image("assets/huffman_encoder_pipeline.svg", width: 100%)
]

== 3. Step-by-Step Priority Queue (Min-Heap) Transitions
The diagram below shows how the min-priority queue extracts the two minimum frequency nodes and re-inserts their merged parent at each iteration:

#align(center)[
  #image("assets/huffman_heap_transitions.svg", width: 100%)
]

== 4. Structural Tree Topology Diagram
Below is the resulting binary tree structure for an alphabet `{A: 45, B: 13, C: 12, D: 16, E: 9, F: 5}`:

#v(0.5em)
#align(center)[
  #image("assets/huffman_tree_structure.svg", width: 100%)
]
#v(0.5em)

== 5. Intuitive Proof of Correctness
The correctness of Huffman coding rests on two straightforward concepts:

1. *Greedy Choice Property:* The two characters that appear least frequently should be merged first. This guarantees that rare characters end up at the bottom of the tree, receiving the longest code lengths, while frequent characters stay near the top with short codes.
2. *Optimal Substructure Property:* Merging two nodes $x$ and $y$ into a parent node $z$ reduces a problem of $K$ characters to an identical subproblem of $K-1$ characters. Repeating this greedy step at each level guarantees an optimal overall tree.

#align(center)[
  #image("assets/huffman_proof_correctness.svg", width: 100%)
]

#pagebreak()

= Real-World Adaptation

While the basic Huffman algorithm is straightforward, building a working file compressor (like #m[zip] or a custom CLI utility) requires handling several engineering challenges:

== 1. State Diagram of the Encoder
The state diagram below illustrates the operating state transitions during file encoding across two structured processing phases:

#align(center)[
  #image("assets/huffman_fsm.svg", width: 100%)
]

== 2. Storing the Tree / Header Serialization
To decompress a file, the decoder must know the exact Huffman tree used during compression. If the decoder does not have the tree, it cannot interpret the variable-length bits.

*Real-World Adaptation:*
- The compressor writes a *Header* at the beginning of the output file containing the character frequency table or the tree structure itself.
- For a small input file (e.g., $100 "bytes"$), storing a $256 "byte"$ frequency table header can make the compressed file *larger* than the original file!
- To minimize header overhead, systems serialize only non-zero character frequencies or store the bit lengths using *Canonical Huffman Codes*.

#align(center)[
  #image("assets/huffman_header_serialization.svg", width: 80%)
]

== 3. Bit-Level I/O Buffer Management
Standard computer file APIs read and write data in whole bytes ($8 "bits"$ at a time). \ However, Huffman codewords have arbitrary bit lengths (e.g., `'e'` = `01` [2 bits], `'z'` = `110101` [6 bits]).

#v(0.5em)
#align(center)[
  #image("assets/huffman_bit_buffer.svg", width: 100%)
]
#v(0.5em)

*Real-World Adaptation:*
- The compressor maintains an *Accumulator Buffer* (a 32-bit or 64-bit integer) and a #m[bit_count] tracker.
- Codewords are appended to the buffer using bitwise left-shifts (`<<`) and bitwise OR (`|`) operations.
- Whenever #m[bit_count] reaches $>= 8$, a full byte is flushed to the output file:

```cpp
// Pseudocode for Bit-Level Writing in C++
void write_bits(uint32_t code, int length) {
    bit_buffer = (bit_buffer << length) | code;
    bit_count += length;
    while (bit_count >= 8) {
        uint8_t byte_out = (bit_buffer >> (bit_count - 8)) & 0xFF;
        file.write(byte_out);
        bit_count -= 8;
    }
}
```

== 4. End-of-File (EOF) Padding
Because the total encoded bitstream length may not be an exact multiple of 8, the last byte in the file will contain extra unused padding bits.

#align(center)[
  #image("assets/huffman_eof_padding.svg", width: 100%)
]

== 5. Decompression Tree Traversal
During decompression, the decoder reads the compressed payload bit-by-bit, starting at the root of the reconstructed Huffman tree. For each bit:
- A `0` bit moves to the left child node.
- A `1` bit moves to the right child node.
- When a leaf node is reached, its character symbol is emitted to the output file, and the pointer resets back to the root node.

Below is a diagram demonstrating step-by-step tree traversal when decoding the bit sequence #m[1101] to extract the character `'E'`:

#align(center)[
  #image("assets/huffman_decoding_traversal.svg", width: 100%)
]
#pagebreak()
= Complexity Analysis

== 1. Time and Space Complexity Breakdown
Let $N$ be the total number of characters in the file, and let $K$ be the number of unique characters in the alphabet (for 8-bit bytes, $K <= 256$).

#align(center)[
  #table(
    columns: (1.5fr, 1.3fr, 1.4fr),
    fill: (x, y) => if y == 0 { rgb("#1e1b2e") } else if calc.even(y) { rgb("#1b1b1f") } else { rgb("#141414") },
    stroke: 0.3pt + rgb("#444"),
    align: (col, row) => if row == 0 { center } else { left },

    [*Phase*], [*Time Complexity*], [*Space Complexity*],
    [Frequency Counting], [$O(N)$], [$O(K)$ table space],
    [Min-Heap Initialization], [$O(K)$], [$O(K)$ heap space],
    [Huffman Tree Construction], [$O(K log K)$], [$O(K)$ tree nodes],
    [Code Table Generation], [$O(K)$], [$O(K)$ lookup table],
    [File Encoding (Pass 2)], [$O(N)$], [$O(1)$ bit buffer],
    [File Decoding (Extraction)], [$O(N)$], [$O(K)$ tree memory],
    [*Overall Algorithm*], [*$O(N)$ Linear Time*], [*$O(1)$ Fixed Space*],
  )
]

== 2. Practical Metric Interpretation

=== I. Linear Scaling with File Size
- In practice, the alphabet size $K$ for byte-level compression is fixed at $K = 256$.
- Therefore, the tree building time is a tiny constant ($256 log_2 256 = 2048$ operations).
- The overall execution time simplifies to *$O(N)$ linear time*, meaning execution speed scales directly with file size. A 10 MB file takes roughly $10 times$ longer to compress than a 1 MB file.

=== II. Memory Efficiency
- Memory usage is fixed at less than $5 "KB"$ of RAM for a 256-symbol frequency table and tree nodes.
- Because memory requirements do not depend on the input file size $N$, Huffman coding can compress multi-gigabyte files on low-memory embedded systems using streaming I/O buffers.

#align(center)[
  #image("assets/huffman_memory_streaming.svg", width: 95%)
]

=== III. Data Entropy Spectrum & Compression Efficiency
The chart below illustrates how input file character distribution dictates compression performance:

#align(center)[
  #image("assets/huffman_entropy_spectrum.svg", width: 100%)
]

= Modern Compression Techniques

While Huffman coding remains a foundational algorithm in computer science curricula, modern software production systems utilize advanced hybrid compression suites that combine dictionary matching, static context modeling, and next-generation entropy coders.

== 1. Overview of State-of-the-Art Algorithms

1. *Zstandard (ZSTD) -- Meta / Facebook:*
  - *Architecture:* Combines LZ77 sliding window match-finding with *Finite State Entropy (FSE)*, an implementation of Asymmetric Numeral Systems (ANS).
  - *Compression Ratio:* *$2.8:1 "to" 3.5:1$ ($65\% - 72\%$ size reduction)* on structured log archives and text.
  - *Performance:* Delivers exceptional decompression speeds ($> 1.2 "GB/s"$) with compression ratios matching LZMA/Bzip2.
  - *Applications:* Standard compression engine in modern Linux kernels, Btrfs file systems, RocksDB, and Facebook data stores.

2. *Brotli -- Google:*
  - *Architecture:* Combines LZ77 dictionary matching with a *13,504-byte static web dictionary* (containing frequent HTML/CSS/JS fragments) and 2nd-order context modeling fed into Huffman coders.
  - *Compression Ratio:* *$3.0:1 "to" 3.8:1$ ($67\% - 74\%$ size reduction)* on web front-end assets.
  - *Performance:* Achieves $15\% - 25\%$ higher compression density for web text assets than GZIP.
  - *Applications:* Standard web HTTP response payload compression (`Content-Encoding: br`) across all modern web browsers and CDNs.

3. *LZ4 -- Yann Collet / Meta:*
  - *Architecture:* Byte-aligned LZ77 variant designed without an entropy encoding stage.
  - *Compression Ratio:* *$1.6:1 "to" 2.1:1$ ($38\% - 52\%$ size reduction)* on raw binary/memory pages.
  - *Performance:* Focuses purely on raw throughput, achieving decompression speeds exceeding $4.5 "GB/s"$ per CPU core (near RAM memory bus bandwidth limits).
  - *Applications:* In-memory swap compression (Android zRAM), database page caches, and high-speed NVMe storage streaming.

4. *Asymmetric Numeral Systems (ANS) / Finite State Entropy (FSE):*
  - *Paradigm:* Created by Jarek Duda, ANS combines the compression density of Arithmetic Coding with the processing speed of Huffman Coding (1 symbol per state transition).
  - *Applications:* Replaced Huffman coding in ZSTD, Apple LZFSE, and modern image formats.

#pagebreak()
== 2. Evolutionary Pipeline Comparison
The diagram below illustrates how modern algorithms evolve beyond classic Huffman coding by incorporating pre-built dictionaries and ANS/FSE entropy engines in a vertically stacked evolutionary layout:

#v(0.5em)
#align(center)[
  #image("assets/huffman_evolutionary_pipeline.svg", width: 100%)
]
#v(0.5em)

== 3. Performance Trade-Off Matrix

#align(center)[
  #table(
    columns: (1.1fr, 1.1fr, 1.1fr, 1.3fr, 1.1fr, 1.1fr, 1.4fr),
    fill: (x, y) => if y == 0 { rgb("#1e1b2e") } else if calc.even(y) { rgb("#1b1b1f") } else { rgb("#141414") },
    stroke: 0.3pt + rgb("#444"),
    align: (col, row) => if row == 0 { center } else { horizon },

    [*Algorithm*], [*Entropy Engine*], [*Ratio*], [*Space Saved*], [*Compress*], [*Decompress*], [*Primary Domain*],
    [Huffman (Classic)],
    [Huffman Tree],
    [$1.8:1 - 2.2:1$],
    progress_bar(0.46),
    [Moderate],
    [approx.$300 "MB/s"$],
    [ZIP, GZIP, PNG],

    [Zstandard (ZSTD)],
    [FSE / ANS],
    [$2.8:1 - 3.5:1$],
    progress_bar(0.70),
    [Fast],
    [more than \ $1.2 "GB/s"$],
    [Linux, \ Cloud Log],

    [Brotli],
    [Huffman \ + Context],
    [$3.0:1 - 3.8:1$],
    progress_bar(0.73),
    [Slow],
    [approx.$500 "MB/s"$],
    [Web Assets \ (HTTP)],

    [LZ4],
    [None \ (Byte-Align)],
    [$1.6:1 - 2.1:1$],
    progress_bar(0.48),
    [Blazing],
    [more than \ $4.5 "GB/s"$],
    [Android zRAM, \ DB],
  )
]

= Conclusion
Huffman Coding illustrates the power of greedy algorithm design in practical computer engineering. By combining character frequency counts with a min-priority queue, the algorithm builds an optimal prefix tree that minimizes data redundancy. Understanding both its theoretical performance ($O(N)$ linear time, $O(1)$ fixed space) and implementation details (header serialization, bit buffer management) provides a strong foundation in algorithm design and data structures.
