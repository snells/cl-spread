;;;; cl-spread.asd

(asdf:defsystem #:cl-spread
  :description "Describe cl-spread here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:cffi #:cffi-libffi #:bordeaux-threads)
  :serial t
  :components ((:file "package")
	       (:file "util")
	       (:file "c-util")
	       (:file "struct")
	       (:file "constants")
	       (:file "types")
	       (:file "c-fns")
	       (:file "c-macros")
               (:file "cl-spread")))
	       

