;;; Turing Patterns

(local turing {})

(fn turing.build-grid [columns rows]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      1)))

turing
