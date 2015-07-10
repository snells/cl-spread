(in-package :cl-spread)

(defun make-c-vector (type &key size vals)
  (let* ((len (cond (size size)
		    (vals (length vals))
		    (t 1)))
	 (v (alloc type len)))
    (if vals
	(dotimes (x (min len (length vals)))
	  (let ((val (nth x vals)))
	    (if val 
		(setf (mem-aref v type x) val)))))
    v))

(defun make-c-array (type size &optional vals)
  (cond ((numberp size)
	 (make-c-vector type :size size :vals vals))
	(t 
	 (let ((v (alloc :pointer (car size))))
	   (dotimes (x (car size))
	     (setf (mem-aref v :pointer x) (make-c-vector type  :size (cadr size)
							  :vals (car vals))
		   vals (cdr vals)))
	   v))))
								      
								       

		  









