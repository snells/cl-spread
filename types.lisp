(in-package :cl-spread)

(defctype mailbox :int)
(defctype p-mailbox (:pointer mailbox))
(defctype service :int)
(defctype p-service (:pointer service))
;(defctype sp-time (:struct dummy-time))
(defctype p-sp-time (:pointer sp-time))
(defctype scat-element (:struct dummy-scat-element))
(defctype scatter (:struct dummy-scatter))
(defctype p-scatter (:pointer scatter))

