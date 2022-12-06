;;; rock-paper-scissors.el --- Advent of Code 2022 Day 2

;;; Commentary:
;; Today, the elves are having a rock paper scissors tournament.
;; An appreciative elf from yesterday handed us a strategy guide to win enough points to win,
;; but not enough to be suspicious about winning every game.
;; We need to calculate how many points we would actually get,
;; should we actually follow the elf's strategy guide.
;;
;; The strategy guide is made up of two letters, the first A, B or C;
;; and the second X, Y, or Z.
;; The first letter is what the opponent will play, and the second is what we should play.
;; We are told that A is rock, B is paper, and Z is scissors.
;; We are led to believe that X is rock, Y is paper, and Z is scissors.
;;
;; The scoring is as follows:
;; We get points for the shape we selected (1 for rock, 2 for paper, 3 for scissors),
;; and points for the outcome of the round (0 for a loss, 3 for a draw, and 6 for a win).
;;
;; For part 2, we learn that the encoding of the second part was assumed incorrectly!
;; X means lose, Y means draw, and Z means win.
;; We will set a second variable to count the new method.

;;; Code:

;; debugging
(setq-local debug-on-error t)

;; get the strategy list
(setq-local strategy-list
	    (with-temp-buffer
	      (insert-file-contents "input.txt")
	      (split-string (buffer-string) "\n" t)))

;; initialize count
(setq-local earned-points 0)
(setq-local part2-points 0)

;; iterate the list
(dolist (item strategy-list)
  (progn
    ;; get our current strategy
    (setq-local the-strat (split-string item " " t))
    (setq-local opponent-move (pop the-strat))
    (setq-local our-move (pop the-strat))

    ;; determine the result and bonus shape points
    (cond ((string= our-move "X")
	   (progn
	     (setq-local earned-points (+ earned-points 1)) ; rock
	     (setq-local part2-points (+ part2-points 0))   ; lose
	     (cond ((string= opponent-move "A")
		    (progn
		      (setq-local earned-points (+ earned-points 3))     ; draw
		      (setq-local part2-points (+ part2-points 3))))     ; scissors
		   ((string= opponent-move "B")
		    (progn
		      (setq-local earned-points (+ earned-points 0))     ; lose
		      (setq-local part2-points (+ part2-points 1))))     ; rock
		   ((string= opponent-move "C")
		    (progn
		      (setq-local earned-points (+ earned-points 6))     ; win
		      (setq-local part2-points (+ part2-points 2)))))))  ; paper
	   ((string= our-move "Y")
	   (progn
	     (setq-local earned-points (+ earned-points 2)) ; paper
	     (setq-local part2-points (+ part2-points 3))   ; draw
	     (cond ((string= opponent-move "A")
		    (progn
		      (setq-local earned-points (+ earned-points 6))     ; win
		      (setq-local part2-points (+ part2-points 1))))     ; rock
		   ((string= opponent-move "B")
		    (progn
		      (setq-local earned-points (+ earned-points 3))     ; draw
		      (setq-local part2-points (+ part2-points 2))))     ; paper
		   ((string= opponent-move "C")
		    (progn
		      (setq-local earned-points (+ earned-points 0))     ; lose
		      (setq-local part2-points (+ part2-points 3)))))))  ; scissors
	   ((string= our-move "Z")
	   (progn
	     (setq-local earned-points (+ earned-points 3)) ; scissors
	     (setq-local part2-points (+ part2-points 6))   ; win
	     (cond ((string= opponent-move "A")
		    (progn
		      (setq-local earned-points (+ earned-points 0))     ; lose
		      (setq-local part2-points (+ part2-points 2))))     ; paper
		   ((string= opponent-move "B")
		    (progn
		      (setq-local earned-points (+ earned-points 6))     ; win
		      (setq-local part2-points (+ part2-points 3))))     ; scissors
		   ((string= opponent-move "C")
		    (progn
		      (setq-local earned-points (+ earned-points 3))     ; draw
		      (setq-local part2-points (+ part2-points 1)))))))))) ; rock

(with-output-to-temp-buffer "rock-paper-scissors-result"
  (print (concat "Part 1: " (number-to-string earned-points) "\n"
		 "Part 2: " (number-to-string part2-points))))


(provide 'rock-paper-scissors)

;;; rock-paper-scissors.el ends here
