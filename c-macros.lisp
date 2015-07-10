(in-package :cl-spread)


(defun unreliable-messp (type) (not (zerop (logand type +unreliable-mess+))))
(defun reliable-messp (type) (not (zerop (logand type +reliable-mess+))))
(defun fifo-messp (type) (not (zerop (logand type +fifo-mess+))))
(defun causal-messp (type) (not (zerop (logand type +causal-mess+))))
(defun agreed-messp (type) (not (zerop (logand type +agreed-mess+))))
(defun safe-messp (type) (not (zerop (logand type +safe-mess+))))
(defun regular-messp (type) (and (not (zerop (logand type +regular-mess+)))
				 (zerop (logand type +reject-mess+))))
(defun self-discardp (type) (not (zerop (logand type +self-discard+))))
(defun reg-memb-messp (type) (not (zerop (logand type +reg-memb-mess+))))
(defun transition-messp (type) (not (zerop (logand type +transition-mess+))))
(defun caused-join-messp (type) (not (zerop (logand type +caused-by-join+))))
(defun caused-leave-messp (type) (not (zerop (logand type +caused-by-leave+))))
(defun caused-disconnect-messp (type) (not (zerop (logand type +caused-by-disconnect+))))
(defun caused-network-messp (type) (not (zerop (logand type +caused-by-network+))))
(defun membership-messp (type) (and (not (zerop (logand type +membership-mess+)))
				    (zerop (logand type +reject-mess+))))
(defun reject-messp (type) (not (zerop (logand type +reject-mess+))))
(defun self-leavep (type) (and (not (zerop (logand type +caused-by-leave+)))
			       (zerop (logior (logand type +reg-memb-mess+) +transition-mess+))))