(asdf:defsystem #:cl-spread-example
  :depends-on (#:cl-spread #:bordeaux-threads)
  :serial t
  :components ((:file "example")))
