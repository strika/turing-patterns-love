(local turing (require :turing))

(local columns 100)
(local rows 100)

(var iteration 0)

(var u-grid nil)
(var v-grid nil)

(fn print-grid [grid]
  (for [x 1 10]
    (for [y 1 10]
      (print (turing.cell grid y x)))))

(fn love.load []
  (set u-grid (turing.build-grid-with-noise columns rows))
  (set v-grid (turing.build-grid-with-noise columns rows)))

(fn love.update [dt]
  (set iteration (+ iteration 1))
  (let [[new-u-grid new-v-grid] (turing.update u-grid v-grid dt)]
    (set u-grid new-u-grid)
    (set v-grid new-v-grid))
  (if (= (% iteration 1000) 0)
    (print "ITERATION: " iteration))
  (if (= iteration 100000)
    (do
      (print "U-GRID:")
      (print-grid u-grid)
      (print "V-GRID")
      (print-grid v-grid)
      (love.event.quit))))

(fn love.draw [])
