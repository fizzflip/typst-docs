#import "@preview/mmdr:0.2.1": mermaid
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
      [Huffman Coding Analysis -- #meta.subject]
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
  #mermaid(
    "graph LR
      subgraph Fixed [Fixed 8-Bit ASCII Encoding: 32 Bits Total]
        F1[\"e : 01100101 (8b)\"] --> F2[\"e : 01100101 (8b)\"]
        F2 --> F3[\"e : 01100101 (8b)\"]
        F3 --> F4[\"z : 01111010 (8b)\"]
      end

      subgraph Variable [Variable-Length Prefix Encoding: 7 Bits Total]
        V1[\"e : 0 (1b)\"] --> V2[\"e : 0 (1b)\"]
        V2 --> V3[\"e : 0 (1b)\"]
        V3 --> V4[\"z : 1101 (4b)\"]
      end

      style Fixed fill:#1b1b1f,stroke:#444,color:#fff
      style Variable fill:#1e1b2e,stroke:#6366f1,color:#fff
      style F1 fill:#2b2b36,stroke:#555,color:#fff
      style F2 fill:#2b2b36,stroke:#555,color:#fff
      style F3 fill:#2b2b36,stroke:#555,color:#fff
      style F4 fill:#2b2b36,stroke:#555,color:#fff
      style V1 fill:#064e3b,stroke:#10b981,color:#fff
      style V2 fill:#064e3b,stroke:#10b981,color:#fff
      style V3 fill:#064e3b,stroke:#10b981,color:#fff
      style V4 fill:#3730a3,stroke:#6366f1,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

== 1. Algorithmic Taxonomy of Lossless Compression
Huffman coding belongs to the class of *Entropy Coding* algorithms. Below is a taxonomy mindmap showing where Huffman coding fits within the broader landscape of data compression algorithms:

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      Root((\"Lossless Compression\")) --> EC[\"Entropy Coding\"]
      Root --> DC[\"Dictionary Coding\"]
      Root --> HS[\"Hybrid Standards\"]

      EC --> HC[\"Huffman Coding (Primary Focus)\"]
      EC --> AC[\"Arithmetic Coding\"]
      EC --> SF[\"Shannon-Fano\"]

      DC --> LZ1[\"LZ77 (Sliding Window)\"]
      DC --> LZ2[\"LZSS\"]
      DC --> LZW[\"LZW (GIF Format)\"]

      HS --> DEF[\"DEFLATE (ZIP and GZIP)\"]
      HS --> ZSTD[\"Zstandard (ZSTD)\"]

      style Root fill:#1e1b2e,stroke:#6366f1,stroke-width:2pt,color:#fff
      style EC fill:#1e1b2e,stroke:#6366f1,color:#fff
      style DC fill:#1e1b2e,stroke:#6366f1,color:#fff
      style HS fill:#1e1b2e,stroke:#6366f1,color:#fff
      style HC fill:#064e3b,stroke:#10b981,stroke-width:2pt,color:#fff
      style AC fill:#1b1b1f,stroke:#444,color:#eee
      style SF fill:#1b1b1f,stroke:#444,color:#eee
      style LZ1 fill:#1b1b1f,stroke:#444,color:#eee
      style LZ2 fill:#1b1b1f,stroke:#444,color:#eee
      style LZW fill:#1b1b1f,stroke:#444,color:#eee
      style DEF fill:#1b1b1f,stroke:#444,color:#eee
      style ZSTD fill:#1b1b1f,stroke:#444,color:#eee
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

== 2. High-Level Compression & Decompression Pipeline
The compression process transforms raw bytes into a compact bitstream, while decompression executes the exact inverse operations:

#v(0.5em)
#align(center)[
  #mermaid(
    "graph TD
      subgraph Compression [Compression Pipeline]
        C1[Raw Input File] --> C2[Frequency Analysis]
        C2 --> C3[Min-Heap Construction]
        C3 --> C4[Greedy Tree Merge]
        C4 --> C5[Bit Buffer Packing]
        C5 --> C6[Compressed File Header + Bitstream]
      end

      subgraph Decompression [Decompression Pipeline]
        D1[Compressed File] --> D2[Read Header & Rebuild Tree]
        D2 --> D3[Stream Input Bits]
        D3 --> D4[Traverse Tree Root-to-Leaf]
        D4 --> D5[Emit Character Byte]
        D5 --> D6[Restored Original File]
      end

      style Compression fill:#1b1b1f,stroke:#4f46e5,color:#fff
      style Decompression fill:#1e1b2e,stroke:#10b981,color:#fff
      style C1 fill:#2b2b36,stroke:#555,color:#fff
      style C6 fill:#064e3b,stroke:#10b981,color:#fff
      style D1 fill:#3730a3,stroke:#6366f1,color:#fff
      style D6 fill:#064e3b,stroke:#10b981,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

== 2. Scale of the Problem
File storage and network transmission are fundamental constraints in computer science. Modern systems process gigabytes of log files, source code repositories, and web assets every second:

#align(center)[
  #table(
    columns: (1.4fr, 1.2fr, 1.2fr, 1.4fr),
    fill: (x, y) => if y == 0 { rgb("#1e1b2e") } else if calc.even(y) { rgb("#1b1b1f") } else { rgb("#141414") },
    stroke: 0.3pt + rgb("#444"),
    align: (col, row) => if row == 0 { center } else { horizon },

    [*File Type / Asset*], [*Fixed 8-Bit Size*], [*Huffman Encoded Size*], [*Space Savings Bar*],
    [English Text (.txt)], [1,000,000 bytes], [$approx 560,000 "bytes"$], progress_bar(0.44),
    [JSON Data (.json)], [5,000,000 bytes], [$approx 2,750,000 "bytes"$], progress_bar(0.45),
    [Source Code (.cpp/.py)], [500,000 bytes], [$approx 290,000 "bytes"$], progress_bar(0.42),
  )
]

== 4. Why Solving it Efficiently Matters
1. *Storage Optimization:* Saving $40\% - 50\%$ of file storage space directly reduces storage media requirements in web servers, cloud archives, and database systems.
2. *Network Bandwidth Reduction:* Transmitting smaller files over networks reduces transfer latency and bandwidth consumption during network downloads.
3. *Foundation for Advanced Compression:* Huffman coding serves as the final entropy encoding stage in major industrial compression standards, including #m[ZIP], #m[GZIP], and #m[JPEG].

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
    *Greedy Rule:* Repeatedly merge the two trees that have the lowest total frequencies. This guarantees that characters with the lowest frequencies end up deepest in the tree (receiving the longest code lengths).
  ]
]

== 2. Encoder Component Sequence Interaction
The sequence diagram below shows how internal software components interact during the encoding process:

#v(0.5em)
#align(center)[
  #mermaid(
    "sequenceDiagram
      autonumber
      participant FS as File Stream
      participant FC as Frequency Counter
      participant MH as Min-Heap
      participant TB as Tree Builder
      participant BB as Bit Buffer

      FS->>FC: Read Raw Input Bytes
      FC->>MH: Insert Single-Node Trees
      loop Until 1 Root Node Remains
          MH->>TB: Pop 2 Smallest Nodes (x, y)
          TB->>MH: Push Merged Parent (z)
      end
      TB->>BB: Generate Codeword Table
      BB->>FS: Flush Encoded Byte Stream
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

== 3. Step-by-Step Priority Queue (Min-Heap) Transitions
The diagram below shows how the min-priority queue extracts the two minimum frequency nodes and re-inserts their merged parent at each iteration:

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      H0[\"Initial Heap: (F:5), (E:9), (C:12), (B:13), (D:16), (A:45)\"] -->|Pop F:5 & E:9| H1[\"Step 1: Merge -> (z1:14)\"]
      H1 -->|Pop C:12 & B:13| H2[\"Step 2: Merge -> (z2:25)\"]
      H2 -->|Pop z1:14 & D:16| H3[\"Step 3: Merge -> (z3:30)\"]
      H3 -->|Pop z2:25 & z3:30| H4[\"Step 4: Merge -> (z4:55)\"]
      H4 -->|Pop A:45 & z4:55| H5[\"Final Step: Root -> (100)\"]

      style H0 fill:#1b1b1f,stroke:#444,color:#fff
      style H1 fill:#1e1b2e,stroke:#4f46e5,color:#fff
      style H2 fill:#1e1b2e,stroke:#4f46e5,color:#fff
      style H3 fill:#1e1b2e,stroke:#4f46e5,color:#fff
      style H4 fill:#1e1b2e,stroke:#4f46e5,color:#fff
      style H5 fill:#064e3b,stroke:#10b981,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

== 4. Structural Tree Topology Diagram
Below is the resulting binary tree structure for an alphabet `{A: 45, B: 13, C: 12, D: 16, E: 9, F: 5}`:

#v(0.5em)
#align(center)[
  #mermaid(
    "graph TD
      Root((Root: 100)) -- 0 --> A[\"A : 45 (Code: 0)\"]
      Root -- 1 --> Z4((z4: 55))
      Z4 -- 0 --> Z2((z2: 25))
      Z4 -- 1 --> Z3((z3: 30))
      Z2 -- 0 --> C[\"C : 12 (Code: 100)\"]
      Z2 -- 1 --> B[\"B : 13 (Code: 101)\"]
      Z3 -- 0 --> Z1((z1: 14))
      Z3 -- 1 --> D[\"D : 16 (Code: 111)\"]
      Z1 -- 0 --> F[\"F : 5 (Code: 1100)\"]
      Z1 -- 1 --> E[\"E : 9 (Code: 1101)\"]

      style Root fill:#1e1b2e,stroke:#6366f1,color:#fff
      style Z4 fill:#1b1b1f,stroke:#6366f1,color:#fff
      style Z2 fill:#1b1b1f,stroke:#444,color:#fff
      style Z3 fill:#1b1b1f,stroke:#444,color:#fff
      style Z1 fill:#1b1b1f,stroke:#444,color:#fff
      style A fill:#064e3b,stroke:#10b981,color:#fff
      style B fill:#064e3b,stroke:#10b981,color:#fff
      style C fill:#064e3b,stroke:#10b981,color:#fff
      style D fill:#064e3b,stroke:#10b981,color:#fff
      style E fill:#064e3b,stroke:#10b981,color:#fff
      style F fill:#064e3b,stroke:#10b981,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

== 5. Intuitive Proof of Correctness
The correctness of Huffman coding rests on two straightforward concepts:

1. *Greedy Choice Property:* The two characters that appear least frequently should be merged first. This guarantees that rare characters end up at the bottom of the tree, receiving the longest code lengths, while frequent characters stay near the top with short codes.
2. *Optimal Substructure Property:* Merging two nodes $x$ and $y$ into a parent node $z$ reduces a problem of $K$ characters to an identical subproblem of $K-1$ characters. Repeating this greedy step at each level guarantees an optimal overall tree.

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      A[\"Original Problem: K Characters\"] -->|Merge 2 Lowest Frequencies| B[\"Combined Parent Node (f1 + f2)\"]
      B --> C[\"Reduced Subproblem: K - 1 Characters\"]
      C -->|Repeat Greedy Step| D[\"Single Optimal Root Node\"]

      style A fill:#1e1b2e,stroke:#6366f1,color:#fff
      style B fill:#1b1b1f,stroke:#444,color:#fff
      style C fill:#1b1b1f,stroke:#6366f1,color:#fff
      style D fill:#064e3b,stroke:#10b981,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

= Real-World Adaptation

While the basic Huffman algorithm is straightforward, building a working file compressor (like #m[zip] or a custom CLI utility) requires handling several engineering challenges:

== 1. Finite State Machine (FSM) of the Encoder
The state diagram below illustrates the operating state transitions during file encoding across two structured processing phases:

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 16pt,
  block(
    fill: rgb("#141414"),
    stroke: 0.5pt + rgb("#333"),
    inset: 10pt,
    radius: 6pt,
    width: 100%,
    align(center)[
      #text(weight: "bold", fill: rgb("#818cf8"))[Phase 1: Analysis & Tree Build]
      #v(0.5em)
      #mermaid(
        "graph TD
          S0((Start)) -->|Open File| S1[\"1. ReadingInput\"]
          S1 -->|Stream Bytes| S2[\"2. FrequencyCounting\"]
          S2 -->|Populate Freqs| S3[\"3. BuildingHeap\"]
          S3 -->|Min-Heap Active| S4[\"4. MergingNodes\"]

          style S0 fill:#1e1b2e,stroke:#6366f1,color:#fff
          style S1 fill:#1b1b1f,stroke:#444,color:#fff
          style S2 fill:#1b1b1f,stroke:#444,color:#fff
          style S3 fill:#1b1b1f,stroke:#444,color:#fff
          style S4 fill:#1e1b2e,stroke:#6366f1,color:#fff
        ",
        theme: (background: "#141414"),
      )
    ],
  ),
  block(
    fill: rgb("#141414"),
    stroke: 0.5pt + rgb("#333"),
    inset: 10pt,
    radius: 6pt,
    width: 100%,
    align(center)[
      #text(weight: "bold", fill: rgb("#34d399"))[Phase 2: Codewords & Output Stream]
      #v(0.5em)
      #mermaid(
        "graph TD
          S5[\"5. CodewordAssignment\"] -->|Traverse Tree| S6[\"6. BitwisePacking\"]
          S6 -->|Output Mode| S7[\"7. WritingHeader\"]
          S7 -->|Stream Bits| S8[\"8. FlushingPayload\"]
          S8 -->|EOF Alignment| S9(((End)))

          style S5 fill:#1b1b1f,stroke:#444,color:#fff
          style S6 fill:#1b1b1f,stroke:#444,color:#fff
          style S7 fill:#1b1b1f,stroke:#444,color:#fff
          style S8 fill:#064e3b,stroke:#10b981,color:#fff
          style S9 fill:#064e3b,stroke:#10b981,color:#fff
        ",
        theme: (background: "#141414"),
      )
    ],
  ),
)
#v(0.5em)

== 2. Storing the Tree / Header Serialization
To decompress a file, the decoder must know the exact Huffman tree used during compression. If the decoder does not have the tree, it cannot interpret the variable-length bits.

*Real-World Adaptation:*
- The compressor writes a *Header* at the beginning of the output file containing the character frequency table or the tree structure itself.
- For a small input file (e.g., $100 "bytes"$), storing a $256 "byte"$ frequency table header can make the compressed file *larger* than the original file!
- To minimize header overhead, systems serialize only non-zero character frequencies or store the bit lengths using *Canonical Huffman Codes*.

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      subgraph Naive [Naive Header: High Overhead]
        N1[\"Raw Frequency Array: 256 Bytes\"] --> N2[\"Uncompressed Payload\"]
      end

      subgraph Optimized [Canonical Header: Low Overhead]
        O1[\"Bit-Length Array: ~15 to 30 Bytes\"] --> O2[\"Compressed Payload Stream\"]
      end

      style Naive fill:#1b1b1f,stroke:#444,color:#fff
      style Optimized fill:#1e1b2e,stroke:#6366f1,color:#fff
      style N1 fill:#371b1e,stroke:#ef4444,color:#fff
      style N2 fill:#2b2b36,stroke:#555,color:#fff
      style O1 fill:#064e3b,stroke:#10b981,color:#fff
      style O2 fill:#2b2b36,stroke:#555,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

== 3. Bit-Level I/O Buffer Management
Standard computer file APIs read and write data in whole bytes ($8 "bits"$ at a time). However, Huffman codewords have arbitrary bit lengths (e.g., `'e'` = `01` [2 bits], `'z'` = `110101` [6 bits]).

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      A[\"1. Incoming Codeword\"] --> B[\"2. Append to Bit Buffer\"]
      B --> C{\"3. Is bit_count >= 8?\"}
      C -- \"Yes\" --> D[\"4. Extract Top 8 Bits\"]
      D --> E[\"5. Write Byte to File\"]
      C -- \"No\" --> F[\"6. Retain Remainder\"]

      style A fill:#1e1b2e,stroke:#6366f1,color:#fff
      style B fill:#1b1b1f,stroke:#444,color:#fff
      style C fill:#1e1b2e,stroke:#6366f1,color:#fff
      style D fill:#1b1b1f,stroke:#444,color:#fff
      style E fill:#064e3b,stroke:#10b981,color:#fff
      style F fill:#1b1b1f,stroke:#444,color:#fff
    ",
    theme: (background: "#141414"),
  )
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

== 4. End-of-File (EOF) Padding & Markers
Because the total encoded bitstream length may not be an exact multiple of 8, the last byte in the file will contain extra unused padding bits.

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      subgraph Alignment [Byte Alignment & EOF Handling]
        P1[\"Encoded Bit Stream\"] --> P2[\"Payload Bits (e.g. 5 Bits: 10110)\"]
        P2 --> P3[\"Unused Padding Bits (3 Bits: 000)\"]
        P3 --> P4[\"Final Flushed Byte (10110000)\"]
      end

      style Alignment fill:#1e1b2e,stroke:#6366f1,color:#fff
      style P1 fill:#1b1b1f,stroke:#444,color:#fff
      style P2 fill:#064e3b,stroke:#10b981,color:#fff
      style P3 fill:#371b1e,stroke:#ef4444,color:#fff
      style P4 fill:#1b1b1f,stroke:#6366f1,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

*Adaptation:*
- Without proper handling, the decoder might interpret padding bits at the end of the file as an extra character.
- Real-world implementations handle this by either:
  1. Storing the exact original file length (in bytes) in the file header.
  2. Defining a special pseudo-EOF character symbol (e.g., symbol `256` in an extended alphabet) with its own Huffman code.

= Complexity Analysis

== 1. Time and Space Complexity Breakdown
Let $N$ be the total number of characters in the file, and let $K$ be the number of unique characters in the alphabet (for 8-bit bytes, $K \le 256$).

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

=== 1. Linear Scaling with File Size
- In practice, the alphabet size $K$ for byte-level compression is fixed at $K = 256$.
- Therefore, the tree building time is a tiny constant ($256 log_2 256 = 2048$ operations).
- The overall execution time simplifies to *$O(N)$ linear time*, meaning execution speed scales directly with file size. A 10 MB file takes roughly $10 times$ longer to compress than a 1 MB file.

=== 2. Memory Efficiency
- Memory usage is fixed at less than $5 "KB"$ of RAM for a 256-symbol frequency table and tree nodes.
- Because memory requirements do not depend on the input file size $N$, Huffman coding can compress multi-gigabyte files on low-memory embedded systems using streaming I/O buffers.

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      File[\"Input File: N Bytes (e.g. 1 GB)\"] --> Stream[\"Streaming 8-Bit Buffer\"]
      Stream --> Ram[\"RAM Memory Used: < 5 KB (Fixed)\"]

      style File fill:#1e1b2e,stroke:#6366f1,color:#fff
      style Stream fill:#1b1b1f,stroke:#444,color:#fff
      style Ram fill:#064e3b,stroke:#10b981,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

=== 3. Data Entropy Spectrum & Compression Efficiency
The chart below illustrates how input file character distribution dictates compression performance:

#v(0.5em)
#align(center)[
  #mermaid(
    "graph LR
      subgraph Skewed [Skewed Distribution: Natural Text]
        S1[\"Frequent Chars: Short 1-2 Bit Codes\"] --> S2[\"High Compression Ratio (~50% Reduction)\"]
      end

      subgraph Uniform [Uniform Distribution: Encrypted / Compressed Data]
        U1[\"Equal Frequencies: Long 8-Bit Codes\"] --> U2[\"Zero Compression / Slight Overhead (+1%)\"]
      end

      style Skewed fill:#064e3b,stroke:#10b981,color:#fff
      style Uniform fill:#371b1e,stroke:#ef4444,color:#fff
      style S1 fill:#1b1b1f,stroke:#444,color:#fff
      style S2 fill:#1b1b1f,stroke:#444,color:#fff
      style U1 fill:#1b1b1f,stroke:#444,color:#fff
      style U2 fill:#1b1b1f,stroke:#444,color:#fff
    ",
    theme: (background: "#141414"),
  )
]
#v(0.5em)

= Modern & Industry-Leading Compression Techniques

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

== 2. Evolutionary Pipeline Comparison
The diagram below illustrates how modern algorithms evolve beyond classic Huffman coding by incorporating pre-built dictionaries and ANS/FSE entropy engines in a vertically stacked evolutionary layout:

#v(0.5em)
#align(center)[
  #block(
    fill: rgb("#141414"),
    stroke: 0.5pt + rgb("#333"),
    inset: 10pt,
    radius: 6pt,
    width: 100%,
    align(center)[
      #text(weight: "bold", fill: rgb("#a5b4fc"))[Classic Entropy Pipeline (ZIP / GZIP)]
      #v(0.3em)
      #mermaid(
        "graph LR
          C1[\"Raw Data\"] --> C2[\"LZ77 Dictionary\"] --> C3[\"Huffman Coding\"] --> C4[\"GZIP / ZIP File\"]


        style C1 fill:#2b2b36,stroke:#555,color:#fff
          style C2 fill:#1b1b1f,stroke:#444,color:#fff
          style C3 fill:#1e1b2e,stroke:#6366f1,color:#fff
          style C4 fill:#2b2b36,stroke:#555,color:#fff
        ",
        theme: (background: "#141414"),
      )
    ],
  )

  #v(0.4em)
  #text(size: 11pt, fill: rgb("#818cf8"))[↓ Architectural Evolution ↓]
  #v(0.4em)
  #block(
    fill: rgb("#141414"),
    stroke: 0.5pt + rgb("#6366f1"),
    inset: 10pt,
    radius: 6pt,
    width: 100%,
    align(center)[
      #text(weight: "bold", fill: rgb("#34d399"))[Modern State-of-the-Art Pipeline (ZSTD / Brotli)]
      #v(0.3em)
      #mermaid(
        "graph LR
          M1[\"Raw Data\"] --> M2[\"Static + Dynamic LZ77\"] --> M3[\"FSE / ANS Entropy Engine\"] --> M4[\"ZSTD / Brotli Output\"]
          style M1 fill:#2b2b36,stroke:#555,color:#fff
          style M2 fill:#1b1b1f,stroke:#444,color:#fff
          style M3 fill:#064e3b,stroke:#10b981,color:#fff
          style M4 fill:#064e3b,stroke:#10b981,color:#fff
        ",
        theme: (background: "#141414"),
      )
    ],
  )
]
#v(0.5em)

== 3. Industrial Performance Trade-Off Matrix

#align(center)[
  #table(
    columns: (1.1fr, 1.1fr, 1.1fr, 1.3fr, 1.1fr, 1.1fr, 1.4fr),
    fill: (x, y) => if y == 0 { rgb("#1e1b2e") } else if calc.even(y) { rgb("#1b1b1f") } else { rgb("#141414") },
    stroke: 0.3pt + rgb("#444"),
    align: (col, row) => if row == 0 { center } else { horizon },

    [*Algorithm*], [*Entropy Engine*], [*Ratio*], [*Space Saved Bar*], [*Compress*], [*Decompress*], [*Primary Domain*],
    [Huffman (Classic)],
    [Huffman Tree],
    [$1.8:1 - 2.2:1$],
    progress_bar(0.46),
    [Moderate],
    [$~300 "MB/s"$],
    [ZIP, GZIP, PNG],

    [Zstandard (ZSTD)],
    [FSE / ANS],
    [$2.8:1 - 3.5:1$],
    progress_bar(0.70),
    [Fast],
    [$> 1.2 "GB/s"$],
    [Linux, Cloud Log],

    [Brotli], [Huffman + Context], [$3.0:1 - 3.8:1$], progress_bar(0.73), [Slow], [$~500 "MB/s"$], [Web Assets (HTTP)],
    [LZ4], [None (Byte-Align)], [$1.6:1 - 2.1:1$], progress_bar(0.48), [Blazing], [$> 4.5 "GB/s"$], [Android zRAM, DB],
  )
]

= Conclusion
Huffman Coding illustrates the power of greedy algorithm design in practical computer engineering. By combining character frequency counts with a min-priority queue, the algorithm builds an optimal prefix tree that minimizes data redundancy. Understanding both its theoretical performance ($O(N)$ linear time, $O(1)$ fixed space) and implementation details (header serialization, bit buffer management) provides a strong foundation in algorithm design and data structures.
