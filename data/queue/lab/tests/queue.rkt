#lang typed/racket/base

(require "../../lab.rkt" typed/rackunit)


(test-case "Test queue creation"
  (: test-queue (Queue Nothing Natural))
  (define test-queue (make-queue))
  (check-true   (queue? test-queue))
  (check-equal? (queue-length test-queue) 0)
  (check-false  (non-empty-queue? 0))
  (check-false  (non-empty-queue? test-queue))
  (check-true   (queue-empty? test-queue)))

(test-case "Test enqueue!"
  (: test-queue0 (Queue Any Any))
  (define test-queue0 (make-queue))
  (enqueue! test-queue0 "Hello")
  (: test-queue1 (Queue Natural Any))
  (define test-queue1 test-queue0)
  (enqueue! test-queue1 10)
  (check-false  (queue-empty? test-queue1))
  (check-equal? (queue-length test-queue1) 2)
  (check-equal? (dequeue! test-queue0) "Hello")
  (check-equal? (queue-length test-queue0) 1)
  (check-equal? (dequeue! test-queue1) 10)
  (check-false  (non-empty-queue? test-queue0))
  (check-true   (queue-empty? test-queue1)))

(test-case "Test enqueue-front!"
  (: test-queue0 (Queue Any Any))
  (define test-queue0 (make-queue))
  (enqueue-front! test-queue0 "Hello")
  (: test-queue1 (Queue Natural Any))
  (define test-queue1 test-queue0)
  (enqueue-front! test-queue1 20)
  (check-equal? (queue-length test-queue0) 2)
  (enqueue-front! test-queue1 30)
  (check-equal? (queue-length test-queue1) 3)
  (check-equal? (dequeue! test-queue0) 30)
  (check-equal? (dequeue! test-queue1) 20)
  (check-equal? (dequeue! test-queue0) "Hello")
  (check-false  (non-empty-queue? test-queue0))
  (check-true   (queue-empty? test-queue1)))

(test-case "Test queue->list"
  (define test-queue (make-queue))
  (enqueue! test-queue 1)
  (enqueue! test-queue 2)
  (enqueue! test-queue 3)
  (check-equal? (queue->list test-queue) '(1 2 3))
  (check-true   (non-empty-queue? test-queue))
  (check-false  (queue-empty? test-queue)))

(test-case "Test in-queue"
  (define test-queue (make-queue))
  (enqueue! test-queue 100)
  (enqueue! test-queue 200)
  (check-equal? (for/list : (Listof Any) ([i (in-queue test-queue)]) i) '(100 200))
  (check-true   (non-empty-queue? test-queue))
  (check-false  (queue-empty? test-queue)))
