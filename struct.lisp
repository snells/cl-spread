(in-package :cl-spread)

(defvar +max-group-name+ 32)

(defcstruct sp-time
  (sec :int32)
  (usec :int32))
;(defctype sp-time (:pointer (:struct dummy-time)))
(defcstruct dummy-scat-element
  (buf :pointer)
  (len :uint))
(defctype scat-element (:struct dummy-scat-element))
(defcstruct dummy-scatter
  (num-elements :uint)
  (elements (:pointer scat-element)))
(defctype scatter (:struct dummy-scatter))


(defcstruct dummy-group-id
  (id :int :count 3))
(defctype group-id (:struct dummy-group-id))
(defcstruct dummy-vs-set-info
  (num-members :uint)
  (members-offset :uint))
(defctype vs-set-info (:struct dummy-vs-set-info))
(defcstruct dummy-membership-info
  (gid group-id)
  (changed-member :char :count 32) ;max-group-name
  (num-vs-sets :uint)
  (my-vs-set vs-set-info))
(defctype membership-info (:struct dummy-membership-info))


(defvar pointers '())

(defun struct-val (pt type slot)
  (foreign-slot-value pt type slot))

(defun struct-pt (pt type slot)
  (foreign-slot-pointer pt type slot))

(defun set-struct-val (pt type slot val)
  (setf (foreign-slot-value pt type slot) val))

(defun struct-nested (lst &optional (fn #'struct-val))
  (if (null (cdr lst))
      (apply fn (car lst))
      (progn (push (apply #'struct-pt (car lst))
		   (cadr lst))
	     (struct-nested (cdr lst) fn))))

(defun set-struct-nest (lst)
  (struct-nested lst #'set-struct-val))

(defun struct-nested-val (lst)
  (struct-nested lst #'struct-val))
(defun struct-nested-pt (lst)
  (struct-nested lst #'struct-pt))


  
;  '(("ORIGIN" s-origin)
; 				 ("GEOMETRY" s-geometry ((origin s-origin)
; 							 (size s-size)))))
;(unless (boundp 'origin.x)

(defmacro define-struct-slot-fns (base-name type &optional lst)
  (let ((l '()))
    (dolist (ext (foreign-slot-names type))
      (let* ((name-string (string-upcase (format nil "~a.~a" base-name ext)))
	     (name (intern name-string))
	     (pt-name (intern (string-upcase (format nil "PT-~a" name-string))))
	     (setter-name (intern (string-upcase (format nil "SET-~a" name-string))))
	     (base-pt (intern (string-upcase (format nil "PT-~a" base-name)))))
	(push `(progn 
		 (defun ,name (pt)
		   ,(if (fboundp base-name)
			`(struct-val (,base-pt pt) ',type ',ext)
			`(struct-val pt ',type ',ext)))
		 (defun ,pt-name (pt)
		   ,(if (fboundp base-name)
			`(struct-pt (,base-pt pt) ',type ',ext)
			`(struct-pt pt ',type ',ext)))
		 (defun ,setter-name (pt val)
		   ,(if (fboundp base-name)
			`(set-struct-val (,base-pt pt) ',type ',ext val)
			`(set-struct-val pt ',type ',ext val))))
 	      l)
	(when (equal ext (car lst))
	  (push `(define-struct-slot-fns ,name , (cadr lst) nil) l))))
    (setf l (reverse l))
    `(progn ,@l)))

(defmacro struct-macro-caller (lst)
  `(define-struct-slot-fns ,(car lst) ,(cadr lst) ,(caddr lst)))

(defmacro define-struct-slot-fns-form-list (lst)
  (let ((l '()))
    (dolist (set lst)
      (let ((base (car set))
	    (type (cadr set))
	    (nested (caddr set)))
	(push `(define-struct-slot-fns ,base ,type ,nested) l)))
    `(progn ,@l)))
(defmacro define-struct-fns ()
  `(define-struct-slot-fns-from-list ,struct-list-to-getters))
(defmacro the-actual-struct-generating-macro ()
 (let ((struct-list-to-getters '((scatter scatter (elements scat-element))
				 (sp-time sp-time)
				 (vs-set-info vs-set-info)
				 (membership-info membership-info (gid group-id)))))
 
   `(progn ,@(mapcar (lambda (x) `(struct-macro-caller ,x)) struct-list-to-getters))))
(the-actual-struct-generating-macro)

;(dolist (val struct-list-to-getters)
;  (let* ((first-val (car val))
; 	 (base-name (if (consp first-val) (string (car first-val)) (string first-val)))
; 	 (type (if (consp first-val) (cadr first-val) first-val))
; 	 (lst (cadr val)))
;    (dolist (ext (foreign-slot-names type))
;      (let* ((name-string (string-upcase (format nil "~a.~a" base-name ext)))
; 	     (name (intern name-string))
; 	     (setter-name (intern (string-upcase (format nil "SET-~a" name-string)))))
; 	(eval `(progn (defun ,name (pt)
; 			(struct-val pt ',type ',ext))
; 		      (defun ,setter-name (pt val)
; 			(set-struct-val pt ',type ',ext val))))
; 	(when lst
; 	  (dolist (l lst)
; 	    (when (equal ext (car l))
; 	      (let* ((nested-type (cadr l)))
; 		  (dolist (nested-slot (foreign-slot-names nested-type))
; 		    (let* ((nested-name (intern (format nil "~a.~a.~a" base-name ext nested-slot)))
; 			   (setter-name (intern (format nil "SET-~a" nested-name))))
; 		      (eval `(defun ,nested-name (pt)
; 			       (struct-val (struct-pt pt ',type ',ext) ',nested-type ',nested-slot)))
; 		      (eval `(defun ,setter-name (pt val)
; 			       (set-struct-val (struct-pt pt ',type ',ext) ',nested-type ',nested-slot val)))))))))))))
; 			    
