;;;; package.lisp

(defpackage #:cl-spread
  (:use #:cl #:cffi)
  (:export :connect
	   :join
	   :receive-formatted-mess
	   :poll
	   :quit-con
	   :send
	   :version
	   :receive
	   :disconnect))

(defpackage #:cl-spread-example
  (:use #:cl #:cl-spread)
  (:export :main))
	   


(in-package :cl-spread)

(define-foreign-library spread
    (:unix "libspread.so")
  (t (:default "libspread")))
(use-foreign-library spread)

(define-foreign-library spread-core
  (:unix "libspread-core.so")
  (t (:default "libspread-core")))
(use-foreign-library spread-core)
