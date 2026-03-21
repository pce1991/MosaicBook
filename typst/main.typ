#set heading(numbering: "1.")
#outline(indent: auto)

// #set page(
//   width: 6in,
//   height: 9in,
//   margin: (inside: 1in, outside: 0.75in, y: 1in),
// )

#set page(
  width: 8.5in,
  height: 11in,
  margin: (x: 0.75in, y: 1in), // 'x' sets both left and right to 0.75in
)

#set text(
  font: "Century Schoolbook",
  size: 14pt,
  lang: "en",
  region: "US",
  fill: rgb("#333333"),
  tracking: 0pt,
  weight: "regular",
)

#show raw.where(block: true): it => {
  block(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    text(font: "Consolas", size: 0.9em, it)
  )
}

#show raw.where(block: false): it => {
  box(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    text(font: "Consolas", size: 0.9em, it)
  )
}

// A simple thin line across the page
#line(length: 100%, stroke: 0.5pt + luma(150))

// // A centered "Textbook" divider (three stars or dots)
// #align(center)[
//   #v(1em)
//   \* \* \*
//   #v(1em)
// ]

#show heading.where(level: 1): it => {
   // 2. Formatting for the full-page divider
  pagebreak(weak: true)
  v(40%)
  align(center)[
    #set text(size: 2em, weight: "bold")
    #it.body
  ]
  pagebreak()
}

#show heading.where(level: 2): it => {
  // 1. Set the Font and Size for the Chapter Title
  set text(font: "Century Schoolbook", size: 18pt, weight: "bold")
  
  // 2. Display the Title (with its number)
  block(it)
  
  // 3. Add the Divider (Line and Space)
  v(0.2em)
  line(length: 100%, stroke: 0.5pt + luma(150))
  v(1.2em) // Space before the first paragraph starts
}

#set heading(numbering: (..nums) => {
  let n = nums.pos()
  // If it's a chapter (Level 2), only show the last digit
  if n.len() > 1 {
    numbering("1.", n.last())
  } else {
    // If it's a Book (Level 1), show nothing (since you want them unnumbered)
    none
  }
})

// 1. Global Numbering (Continuous)
#set heading(numbering: (..n) => {
  if n.pos().len() > 1 { numbering("1.", n.pos().last()) }
})

= PART 0 \ PRELUDE
#pagebreak()

#include "philosophy.typ"
#pagebreak()

= PART 1 \ PROGRAMMING FUNDAMENTALS
#pagebreak()

#include "mosaic_intro.typ"
#pagebreak()

#include "variables_and_values.typ"
#pagebreak()

#include "compiler_errors.typ"
#pagebreak()

#include "frames_and_time.typ"
#pagebreak()

#include "conditionals.typ"
#pagebreak()

#include "printing.typ"
#pagebreak()

#include "functions_1.typ"
#pagebreak()

#include "loops.typ"
#pagebreak()

#include "arrays.typ"
#pagebreak()

#include "enums.typ"
#pagebreak()

#include "structs.typ"
#pagebreak()

#include "functions_2.typ"
#pagebreak()

= PART 2 \ GAME FUNDAMENTALS
#include "random_values.typ"
#pagebreak()

#include "axis_aligned_bounding_boxes.typ"
#pagebreak()

#include "raycasts.typ"
#pagebreak()

= PART 3 \ MEMORY

#include "pointers.typ"
#pagebreak()

#include "allocation.typ"
#pagebreak()

#include "memory_arenas.typ"
#pagebreak()

#include "dynamic_arrays.typ"
#pagebreak()

#include "file_writing.typ"
#pagebreak()

= PART 4 \ DATA STRUCTURES
#include "outside_mosaic.typ"
#pagebreak()

#include "freelist.typ"
#pagebreak()

#include "hash_tables.typ"
#pagebreak()

#include "handles.typ"
#pagebreak()

#include "bitfields_and_flags.typ"
#pagebreak()
