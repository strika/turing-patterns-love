;;; Experiments

(local experiment {})

(fn copy-parameters [parameters]
  (local new-parameters {})
  (each [k v (pairs parameters)]
    (tset new-parameters k v))
  new-parameters)

(fn experiment.generate-parameters [source-data]
  (var parameters-list [{}])
  (each [parameter [start end step] (pairs source-data)]
    (let [new-parameters-list []]
      (for [n start end step]
        (each [_ parameters (ipairs parameters-list)]
          (let [new-parameters (copy-parameters parameters)]
            (tset new-parameters parameter n)
            (table.insert new-parameters-list new-parameters))))
      (set parameters-list new-parameters-list)))
  parameters-list)

experiment
