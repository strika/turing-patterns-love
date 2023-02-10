;;; Turing Patterns

(local turing {})

(fn turing.noise []
  (let [c (* (math.random) 0.03)]
    (if (> (math.random) 0.5)
      c
      (- 0 c))))

(fn turing.build-grid [rows columns]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      (+ 1 (turing.noise)))))

(fn turing.rows [grid]
  (length grid))

(fn turing.columns [grid]
  (length (. grid 1)))

(fn turing.neighbourhood [grid colum row]
  1)

(fn turing.update [grid]
  (each [i row (ipairs grid)]
    (each [j cell (ipairs row)]
      (print cell))))

turing
