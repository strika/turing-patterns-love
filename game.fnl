(local turing (require :turing))
(local experiment (require :experiment))

(local color-multiplier 25)
(local log-file "experiments.csv")

(local fdt 0.01) ; Fixed dt

(local columns 100)
(local rows 100)
(local pixel-size 10)

(var experiment-end-iteration 10000)
(var experiment-index 1)
(var experiments [])

(fn build-experiment [parameters]
  {:grid (turing.build-grid-with-noise columns rows)
   :parameters parameters
   :iteration 0})

(fn current-experiment []
  (. experiments experiment-index))

(fn generate-experiments []
  (local parameters (experiment.generate-parameters {:a [1 1 0.1]
                                                     :b [-1 -1 0.1]
                                                     :c [2 2 0.1]
                                                     :d [-1.5 -1.5 0.1]
                                                     :h [1 1 1]
                                                     :k [1 1 1]
                                                     :du [0.0001 0.0001 0.0001]
                                                     :dv [0.0006 0.0006 0.0001]}))
  (local experiments-count (accumulate [c 0
                                        _ _ (ipairs parameters)]
                            (+ c 1)))
  (print "Generating" experiments-count " experiments...")
  (accumulate [experiments []
               _ p (ipairs parameters)]
    (do
     (table.insert experiments (build-experiment p))
     experiments)))

(fn log-experiment-details [experiment]
  (let [params (. experiment :parameters)
        details (.. (. params :a) ","
                    (. params :b) ","
                    (. params :c) ","
                    (. params :d) ","
                    (. params :h) ","
                    (. params :k) ","
                    (. params :du) ","
                    (. params :dv) "\n")]
    (with-open [log (io.open log-file :a)]
      (log:write details))))

(fn draw-experiment [experiment]
  (local grid (. experiment :grid))
  (for [x 1 columns]
    (for [y 1 rows]
      (let [{: u : v } (turing.cell grid x y)
            blue (math.max (math.min (* color-multiplier u) 255) 0)
            red (math.max (math.min (* color-multiplier v) 255) 0)]
        (love.graphics.setColor (love.math.colorFromBytes red 0 blue))
        (love.graphics.rectangle "fill"
                                 (* (- x 1) pixel-size)
                                 (* (- y 1) pixel-size)
                                 pixel-size
                                 pixel-size)))))

(fn love.load []
  (set experiments (generate-experiments))
  (with-open [log (io.open log-file :w)]
    (log:write "a,b,c,d,h,k,du,dv\n")))

(fn love.update [dt]
  (if (> experiment-index (length experiments))
    (do
      (print "Done.")
      (love.event.quit))
    (do
      (let [experiment (current-experiment)
            iteration (+ (. experiment :iteration) 1)
            grid (. experiment :grid)
            parameters (. experiment :parameters)]
        (tset experiment :iteration iteration)
        (tset experiment :grid (turing.update grid parameters fdt))
        (if (> iteration experiment-end-iteration)
          (set experiment-index (+ experiment-index 1)))))))

(fn love.draw []
  (if (<= experiment-index (length experiments))
    (let [experiment (current-experiment)
          iteration (. experiment :iteration)]
      (draw-experiment experiment)
      (if (= iteration experiment-end-iteration)
        (do
          (love.graphics.captureScreenshot (.. "experiment-" experiment-index "-iteration-" iteration ".png"))
          (log-experiment-details experiment))))))
