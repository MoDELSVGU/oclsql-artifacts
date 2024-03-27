; This file includes 
;     a) the mapping from datamodel to FOL
;     b) the mapping from database to FOL
; Fragment used: Uninterpreted functino + string + linear integer arithmetic 
(set-logic UFSLIA)
; =================================================
;   A. Mapping from datamodel to FOL
; =================================================
(declare-sort Classifier 0)
(declare-const nullClassifier Classifier)
(declare-const invalidClassifier Classifier)
(declare-const nullInt Int)
(declare-const invalidInt Int)
(declare-const nullString String)
(declare-const invalidString String)
(declare-fun Lecturer (Classifier) Bool)
(declare-fun Student (Classifier) Bool)
(declare-fun age_Lecturer (Classifier) Int)
(declare-fun email_Lecturer (Classifier) String)
(declare-fun name_Lecturer (Classifier) String)
(declare-fun age_Student (Classifier) Int)
(declare-fun name_Student (Classifier) String)
(declare-fun email_Student (Classifier) String)
(declare-fun Enrolment (Classifier Classifier) Bool)

(assert (distinct nullClassifier invalidClassifier))
(assert (distinct nullInt invalidInt))
(assert (distinct nullString invalidString))
(assert (not (Lecturer nullClassifier)))
(assert (not (Student nullClassifier)))
(assert (not (Lecturer invalidClassifier)))
(assert (= (age_Lecturer nullClassifier) invalidInt))
(assert (= (age_Lecturer invalidClassifier) invalidInt))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (age_Lecturer x) invalidInt))))
(assert (= (email_Lecturer nullClassifier) invalidString))
(assert (= (email_Lecturer invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (email_Lecturer x) invalidString))))
(assert (= (name_Lecturer nullClassifier) invalidString))
(assert (= (name_Lecturer invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (name_Lecturer x) invalidString))))
(assert (not (Student invalidClassifier)))
(assert (= (age_Student nullClassifier) invalidInt))
(assert (= (age_Student invalidClassifier) invalidInt))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (age_Student x) invalidInt))))
(assert (= (name_Student nullClassifier) invalidString))
(assert (= (name_Student invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (name_Student x) invalidString))))
(assert (= (email_Student nullClassifier) invalidString))
(assert (= (email_Student invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (email_Student x) invalidString))))
(assert (forall ((x Classifier) (y Classifier))
    (=> (Enrolment x y) 
        (and (Lecturer x) (Student y)))))
(assert (forall ((x Classifier)) 
    (=> (Lecturer x) (not (Student x)))))
(assert (forall ((x Classifier)) 
    (=> (Student x) (not (Lecturer x)))))

; =================================================
;   B. Mapping from database to FOL
; =================================================
(declare-sort BOOL 0)
(declare-const TRUE BOOL)
(declare-const FALSE BOOL)
(declare-const NULL BOOL)
(declare-fun id (Int) Classifier)
(declare-fun left (Int) Int)
(declare-fun right (Int) Int)
(declare-fun student-index (Int) Bool)
(declare-fun lecturer-index (Int) Bool)
(declare-fun enrolment-index (Int) Bool)
(declare-fun val-student-id (Int) Classifier)
(declare-fun val-student-age (Int) Int)
(declare-fun val-student-name (Int) String)
(declare-fun val-student-email (Int) String)
(declare-fun val-lecturer-id (Int) Classifier)
(declare-fun val-lecturer-age (Int) Int)
(declare-fun val-lecturer-name (Int) String)
(declare-fun val-lecturer-email (Int) String)
(declare-fun val-enrolment-lecturers (Int) Classifier)
(declare-fun val-enrolment-students (Int) Classifier)

(assert (not (= TRUE FALSE)))
(assert (not (= TRUE NULL)))
(assert (not (= FALSE NULL)))
(assert (forall ((x BOOL))
    (or (= x TRUE) (or (= x FALSE) (= x NULL)))))
(assert (forall ((x Int))
    (=> (student-index x)
        (exists ((c Classifier))
            (and (Student c)
                 (= c (id x)))))))
(assert (forall ((c Classifier))
    (=> (Student c)
        (exists ((x Int))
            (and (student-index x)
                 (= c (id x)))))))
(assert (forall ((x Int) (y Int))
    (=> (and (student-index x) (student-index y) (not (= x y)))
        (not (= (id x) (id y))))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-id x) (id x)))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-age x) (age_Student (id x))))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-name x) (name_Student (id x))))))
(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-email x) (email_Student (id x))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (exists ((c Classifier))
            (and (Lecturer c)
                 (= c (id x)))))))
(assert (forall ((c Classifier))
    (=> (Lecturer c)
        (exists ((x Int))
            (and (lecturer-index x)
                 (= c (id x)))))))
(assert (forall ((x Int) (y Int))
    (=> (and (lecturer-index x) (lecturer-index y) (not (= x y)))
        (not (= (id x) (id y))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-id x) (id x)))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-age x) (age_Lecturer (id x))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-name x) (name_Lecturer (id x))))))
(assert (forall ((x Int))
    (=> (lecturer-index x)
        (= (val-lecturer-email x) (email_Lecturer (id x))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (exists ((c1 Classifier) (c2 Classifier))
            (and (Enrolment c1 c2)
                 (= c1 (id (left x)))
                 (= c2 (id (right x))))))))
(assert (forall ((c1 Classifier) (c2 Classifier))
    (=> (Enrolment c1 c2)
        (exists ((x Int))
            (and (enrolment-index x)
                 (= c1 (id (left x)))
                 (= c2 (id (right x))))))))
(assert (forall ((x Int) (y Int))
    (=> (and (enrolment-index x) (enrolment-index y) (not (= x y)))
        (not (and (= (left x) (left y))
                  (= (right x) (right y)))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (val-enrolment-lecturers x) (id (left x))))))
(assert (forall ((x Int))
    (=> (enrolment-index x)
        (= (val-enrolment-students x) (id (right x))))))
; =================================================
;   END CORE
; =================================================

; =================================================
;   VARIABLES
; =================================================
(declare-const self Classifier)
(assert (Student self))
(declare-const user String)
; =================================================

; Example #7
; SELECT CASE WHEN name IS NULL THEN user IS NULL
;             ELSE CASE WHEN user IS NULL THEN FALSE 
;                       ELSE name = user END END
; FROM Student
; WHERE Student_id = self                  

; sel1 = SELECT CASE WHEN name IS NULL THEN user IS NULL ELSE CASE WHEN user IS NULL THEN FALSE ELSE name = user END END FROM Student WHERE Student_id = self                  
; expr1 = CASE WHEN name IS NULL THEN user IS NULL ELSE CASE WHEN user IS NULL THEN FALSE ELSE name = user END END
; expr2 = name IS NULL
; expr3 = name
; expr4 = user IS NULL
; expr5 = user
; expr6 = CASE WHEN user IS NULL THEN FALSE ELSE name = user END
; expr7 = FALSE
; expr8 = name = user
; expr9 = Student_id = self
; expr10 = Student_id
; expr11 = self
(declare-fun index-sel1 (Int) Bool)
(declare-fun val-sel1-expr1 (Int) BOOL)
(declare-fun val-sel1-expr2 (Int) BOOL)
(declare-fun val-sel1-expr3 (Int) String)
(declare-fun val-sel1-expr4 (Int) BOOL)
(declare-fun val-sel1-expr5 (Int) String)
(declare-fun val-sel1-expr6 (Int) BOOL)
(declare-fun val-sel1-expr7 (Int) BOOL)
(declare-fun val-sel1-expr8 (Int) BOOL)
(declare-fun val-student-expr9 (Int) BOOL)
(declare-fun val-student-expr10 (Int) Classifier)
(declare-fun val-student-expr11 (Int) Classifier)

(assert (forall ((x Int))
    (= (index-sel1 x)
       (and (student-index x) (= (val-student-expr9 x) TRUE)))))

(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-expr10 x) (val-student-id x)))))

(assert (forall ((x Int))
    (=> (student-index x)
        (= (val-student-expr11 x) self))))

(assert (forall ((x Int))
    (=> (student-index x)
        (= (= (val-student-expr9 x) TRUE)
           (and (not (= (val-student-expr10 x) nullClassifier))
                (not (= (val-student-expr11 x) nullClassifier))
                (= (val-student-expr10 x) (val-student-expr11 x)))))))

(assert (forall ((x Int))
    (=> (student-index x)
        (= (= (val-student-expr9 x) FALSE)
           (and (not (= (val-student-expr10 x) nullClassifier))
                (not (= (val-student-expr11 x) nullClassifier))
                (not (= (val-student-expr10 x) (val-student-expr11 x))))))))

(assert (forall ((x Int))
    (=> (student-index x)
        (= (= (val-student-expr9 x) NULL)
           (or (= (val-student-expr10 x) nullClassifier)
               (= (val-student-expr11 x) nullClassifier))))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr8 x) TRUE)
           (and (not (= (val-sel1-expr3 x) nullString))
                (not (= (val-sel1-expr5 x) nullString))
                (= (val-sel1-expr3 x) (val-sel1-expr5 x)))))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr8 x) FALSE)
           (and (not (= (val-sel1-expr3 x) nullString))
                (not (= (val-sel1-expr5 x) nullString))
                (not (= (val-sel1-expr3 x) (val-sel1-expr5 x))))))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr8 x) NULL)
           (or (= (val-sel1-expr3 x) nullString)
               (= (val-sel1-expr5 x) nullString))))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (val-sel1-expr7 x) FALSE))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr6 x) (val-sel1-expr7 x))
           (= (val-sel1-expr4 x) TRUE)))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr6 x) (val-sel1-expr8 x))
           (or (= (val-sel1-expr4 x) FALSE)
               (= (val-sel1-expr4 x) NULL))))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (val-sel1-expr5 x) user))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr4 x) TRUE)
           (= (val-sel1-expr5 x) nullString)))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr4 x) FALSE)
           (not (= (val-sel1-expr5 x) nullString))))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (val-sel1-expr3 x) (val-student-name x)))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr2 x) TRUE)
           (= (val-sel1-expr3 x) nullString)))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr2 x) FALSE)
           (not (= (val-sel1-expr3 x) nullString))))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr1 x) (val-sel1-expr4 x))
           (= (val-sel1-expr2 x) TRUE)))))

(assert (forall ((x Int))
    (=> (index-sel1 x)
        (= (= (val-sel1-expr1 x) (val-sel1-expr6 x))
           (or (= (val-sel1-expr2 x) FALSE)
               (= (val-sel1-expr2 x) NULL))))))

; Subgoal C2: Prove that it is the correct implementation of the OCL
; OCL: self.name = user
; This proof is a two fold, this is the first one.
(assert (not (or (and (= (name_Student self) nullString)
                          (= user nullString))
                     (and (not (= (name_Student self) nullString))
                          (not (= user nullString))
                          (= (name_Student self) user)))))
(assert (forall ((x Int))
                    (=> (index-sel1 x)
                        (= (val-sel1-expr1 x) TRUE))))

(check-sat)
