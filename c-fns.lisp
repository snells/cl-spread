(in-package :cl-spread)
(defcfun "memcpy" :void
  (pt1 :pointer)
  (pt2 :pointer)
  (n :uint))
(defcfun "strcmp" :int
  (str1 :pointer)
  (str2 :pointer))

(defcfun "SP_version" :int
  (major :pointer)
  (minor :pointer)
  (patch :pointer))

(defcfun "SP_connect" :int
  (spread-name :pointer)
  (private-name :pointer)
  (priority :int)
  (membership :int)
  (mbox p-mailbox)
  (private-group :pointer))

(defcfun "SP_connect_timeout" :int
  (spread-name :pointer)
  (private-name :pointer)
  (priority :int)
  (group :int)
  (mbox p-mailbox)
  (private-group :pointer)
  (time-out sp-time))
(defcfun "SP_disconnect" :int
  (mbox mailbox))

(defcfun "SP_kill" :int
  (mbox mailbox))
 
(defcfun "SP_join" :int
  (mbox mailbox)
  (group :pointer))
 
(defcfun "SP_leave" :int
  (mbox mailbox)
  (group :pointer))

(defcfun "SP_multicast" :int
  (mbox mailbox)
  (service-type service)
  (group :pointer)
  (mess-type :int16)
  (mess-len :int)
  (mess :pointer))
(defcfun "SP_scat_multicast" :int
  (mbox mailbox)
  (service-type service)
  (group :pointer)
  (mess-type :int)
  (scat-mess p-scatter))
(defcfun "SP_multigroup_multicast" :int  	
  (mbox mailbox)
  (service-type service)
  (num-group :int)
  (groups :pointer)
  (mess-type :int)
  (mess-len :int)
  (mess :pointer))
(defcfun "SP_multigroup_scat_multicast" :int
  (mbox mailbox)
  (service-type service)
  (num-groups :int)
  (groups :pointer)
  (mess-type :int)
  (scat-mess p-scatter))

(defcfun "SP_receive" :int
  (mbox mailbox)
  (service-type p-service)
  (sender :pointer)
  (max-groups :int)
  (num-groups :pointer)
  (gropus :pointer)
  (mess-type :pointer)
  (endian-mismatch :pointer)
  (max-mess-len :int)
  (mess :pointer))

(defcfun "SP_scat_receive" :int
  (mbox mailbox)
  (service-type :pointer)
  (sender :pointer)
  (max-groups :int)
  (num-groups :int)
  (groups :pointer)
  (mess-type :pointer)
  (endian-mismatch :pointer)
  (scat-mess p-scatter))


(defcfun "SP_error" :void
  (e :int))

(defcfun "SP_poll" :int
  (mbox mailbox))

(defcfun "SP_get_memb_info" :int
  (mess :pointer)
  (service-type service)
  (mem-info (:pointer membership-info)))

(defcfun "SP_scat_get_memb_info" :int
  (memb-mess-scat (:pointer scatter))
  (service-type service)
  (memb-info (:pointer membership-info)))

(defcfun "SP_get_vs_sets_info" :int
  (memb-mess :pointer)
  (vs-sets (:pointer vs-set-info))
  (num-vs-sets :int)
  (my-vs-set-index :uint))
(defcfun "SP_scat_get_vs_sets_info" :int
  (memb-mess-scat (:pointer scatter))
  (vs-sets (:pointer vs-set-info))
  (num-vs-sets :int)
  (my-vs-set-index :uint))

(defcfun "SP_get_vs_set_members" :int
  (memb-mess :pointer)
  (vs-set (:pointer vs-set-info))
  (member-names :pointer)
  (member-names-count :int))
(defcfun "SP_scat_get_vs_set_members" :int
  (memb-mess-scat (:pointer scatter))
  (vs-set (:pointer vs-set-info))
  (member-names :pointer)
  (memer-names-count :int))
(defcfun "SP_equal_group_ids" :int
  (gl group-id)
  (gl2 group-id))
