(local t (require :fspec))

(local turing (require :turing))

;; Test build-grid

(let [grid (turing.build-grid 2 3)]
  (t.is-table grid)
  (for [i 1 2]
    (for [j 1 3]
      (let [v (. grid i j)]
        (t.neq v 1)
        (t.true (> v 0.97))
        (t.true (< v 1.03))))))

;; Test rows

(let [grid (turing.build-grid 2 3)]
  (t.eq (turing.rows grid) 2))

;; Test columns

(let [grid (turing.build-grid 2 3)]
  (t.eq (turing.columns grid) 3))

;; Test cell

(let [grid [[1 2 3 4]
            [5 6 7 8]]]
  (t.eq (turing.cell grid 1 1) 1)
  (t.eq (turing.cell grid 2 1) 2)
  (t.eq (turing.cell grid 1 2) 5)
  (t.eq (turing.cell grid 4 2) 8)
  (t.eq (turing.cell grid 1 3) 1)
  (t.eq (turing.cell grid 5 1) 1)
  (t.eq (turing.cell grid 5 3) 1)
  (t.eq (turing.cell grid 4 3) 4))

;; Test neighbourhood

(let [grid [[1 2 3 4]
            [5 6 7 8]
            [9 10 11 12]]]
  (t.eq (turing.neighbourhood grid 2 2) 24)
  (t.eq (turing.neighbourhood grid 3 2) 28)
  (t.eq (turing.neighbourhood grid 1 1) 20)
  (t.eq (turing.neighbourhood grid 4 3) 32))

(t.run!)
