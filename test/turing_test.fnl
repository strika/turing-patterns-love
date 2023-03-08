(local t (require :fspec))

(local turing (require :turing))

;; Test build-cell

(t.eq (turing.build-cell) {:u 1 :v 1})


;; Test build-cell-with-noise

(let [cell (turing.build-cell-with-noise)
      u (. cell :u)
      v (. cell :v)]
  (t.true (> u 0.97))
  (t.true (< u 1.03))
  (t.true (> v 0.97))
  (t.true (< v 1.03)))

;; Test build-grid

(t.eq (turing.build-grid 3 2)
      [[{:u 1 :v 1} {:u 1 :v 1} {:u 1 :v 1}]
       [{:u 1 :v 1} {:u 1 :v 1} {:u 1 :v 1}]])

;; Test build-grid-with-noise

(let [grid (turing.build-grid-with-noise 3 2)]
  (t.is-table grid)
  (for [i 1 2]
    (for [j 1 3]
      (let [cell (. grid i j)
            u (. cell :u)
            v (. cell :v)]
        (t.true (> u 0.97))
        (t.true (< u 1.03))
        (t.true (> v 0.97))
        (t.true (< v 1.03))))))

;; Test rows

(let [grid (turing.build-grid 3 2)]
  (t.eq (turing.rows grid) 2))

;; Test columns

(let [grid (turing.build-grid 3 2)]
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
  (t.eq (turing.cell grid 4 3) 4)
  (t.eq (turing.cell grid 0 1) 4)
  (t.eq (turing.cell grid 1 0) 5))

;; Test update-cell

(let [grid [[1 2 3]
            [4 5 6]]]
  (turing.update-cell grid 2 1 42)
  (t.eq (turing.cell grid 2 1) 42))

;; Test neighbourhood

(let [grid [[{:u 1 :v 1} {:u 2 :v 2}   {:u 3 :v 3}   {:u 4 :v 4}]
            [{:u 5 :v 5} {:u 6 :v 6}   {:u 7 :v 7}   {:u 8 :v 8}]
            [{:u 9 :v 9} {:u 10 :v 10} {:u 11 :v 11} {:u 12 :v 12}]]]
  (t.eq (. (turing.neighbourhood grid 2 2) :u) 24)
  (t.eq (. (turing.neighbourhood grid 2 2) :v) 24)
  (t.eq (. (turing.neighbourhood grid 3 2) :u) 28)
  (t.eq (. (turing.neighbourhood grid 3 2) :v) 28)
  (t.eq (. (turing.neighbourhood grid 1 1) :u) 20)
  (t.eq (. (turing.neighbourhood grid 1 1) :v) 20)
  (t.eq (. (turing.neighbourhood grid 4 3) :u) 32)
  (t.eq (. (turing.neighbourhood grid 4 3) :v) 32))

;; Test update
(let [grid (turing.build-grid-with-noise 10 10)
      new-grid (turing.build-grid 10 10)
      parameters {:a 1 :b -1 :c 2 :d -1 :h 1 :k 1 :du 0.0001 :dv 0.0006}
      [old-grid new-grid] (turing.update grid new-grid parameters 0.2)]
  (t.eq (turing.columns new-grid) 10)
  (t.eq (turing.rows new-grid) 10)
  (t.eq (turing.columns grid) 10)
  (t.eq (turing.rows grid) 10))

(t.run!)
