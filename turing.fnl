;;; Turing Patterns

(local turing {})

(fn noise []
  (let [c (* (math.random) 0.03)]
    (if (> (math.random) 0.5)
      c
      (- 0 c))))

(fn turing.build-grid [rows columns]
  (fcollect [i 1 rows]
    (fcollect [j 1 columns]
      (+ 1 (noise)))))

turing
