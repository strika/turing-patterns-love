;;; Turing Patterns

(local turing {})

(local neighbourhood-coordinates [[-1 0] [1 0] [0 -1] [0 1]])

; Parameters
(local a 1)
(local b -1)
(local c 2)
(local d -1.5)
(local h 1)
(local k 1)
(local du 0.0001) ; diffusion constant of u
(local dv 0.0006) ; diffusion constant of v

(fn turing.noise []
  (let [c (* (math.random) 0.03)]
    (if (> (math.random) 0.5)
      c
      (- 0 c))))

(fn turing.build-grid-with-noise [rows columns]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      (+ 1 (turing.noise)))))

(fn turing.build-grid [rows columns]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      1)))

(fn turing.rows [grid]
  (length grid))

(fn turing.columns [grid]
  (length (. grid 1)))

(fn turing.cell [grid column row]
  (let [c (if (> column (turing.columns grid)) 1 column)
        c (if (< c 1) (turing.columns grid) c)
        r (if (> row (turing.rows grid)) 1 row)
        r (if (< r 1) (turing.rows grid) r)]
    (. grid r c)))

(fn turing.neighbourhood [grid row column]
  (accumulate [sum 0
               _ [dr dc] (ipairs neighbourhood-coordinates)]
    (+ sum (turing.cell grid (+ row dr) (+ column dc)))))

(fn turing.update [grid]
  (each [i row (ipairs grid)]
    (each [j cell (ipairs row)]
      (print cell))))

turing
