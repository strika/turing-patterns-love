(local turing (require :turing))

(local columns 100)
(local rows 100)

(var iteration 0)

(var u-grid nil)
(var v-grid nil)

(fn love.load []
  (set u-grid (turing.build-grid-with-noise columns rows))
  (set v-grid (turing.build-grid-with-noise columns rows)))

(fn love.update [dt]
  (set iteration (+ iteration 1))
  (let [[new-u-grid new-v-grid] (turing.update u-grid v-grid dt)]
    (set u-grid new-u-grid)
    (set v-grid new-v-grid))
  (if (= iteration 10000)
    (do
      (print "U-GRID:")
      (for [x 1 rows]
        (for [y 1 columns]
          (print (turing.cell u-grid y x))))
      (print "V-GRID")
      (for [x 1 rows]
        (for [y 1 columns]
          (print (turing.cell v-grid y x)))))))

(fn love.draw [])
