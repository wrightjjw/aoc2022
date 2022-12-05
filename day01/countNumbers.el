;;; countNumbers.el --- Advent of Code 2022 Day 1

;;; Commentary:
;; This year, we are accomponying Santa's elves on a trip to the jungle
;; to collect star fruit for teh reindeer so they have enough magical energy
;; to make the Christmas journey.
;;
;; After making land in the jungle, our first objective is to find food.
;; The elves go out and find various amounts of food,
;; and have provided us with a list (input.txt).
;; Our task is to find the calorie total of the elf who brought the most calories.
;;
;; The list is organized in such a way where each elf wrote down
;; the number of calories of each food item they found,
;; and ended their own inventory with a blank line.
;; Thus, each "block" of text between blank lines represents the food found by one elf.
;; There is an unkown number of elves, and each elf brought a variable amount of food.
;;
;; Thus, the solution is to iterate through our input list,
;; calculating the total amount of calories each elf brought as we go.
;; We keep track of the total calorie count of the most profitable elf as we go,
;; and replace it when we find a greater total.
;; When we reach the end of the input file, our tracked value will be our solution.
;;
;; Part 2 of today's problem is to find the total amount of calories carried
;; by the top 3 most successful elves.
;; We can find the solution by adding all of our total results to a list,
;; sorting it, and adding up the top three items.

;;; Code:

;; debugging
(setq-local debug-on-error t)

;; bringing in the input list
(setq-local input-list
  (with-temp-buffer
    (insert-file-contents "input.txt")
    (split-string
     ;; add "e" to empty lines so split can discriminate
     (replace-regexp-in-string "\n\n" "\ne\n" (buffer-string))
     "\n" t)))

;; initialize our counts
(setq-local max-total 0)     ; the max total so far
(setq-local current-count 0) ; total of current elf
(setq-local totals-list '())

;; iterate the list
(dolist (item input-list)
	;; set the max total
	(setq-local max-total
		    ;; if the current line is blank ("e")
		    (if (string= item "e")
			;; set local variable local-ret, return value of progn,
			;; because we are changing current-count before the expression ends
			(progn (setq-local local-ret
					   (if (> current-count max-total) current-count max-total))
			       (setq-local totals-list (cons current-count totals-list))
			       (setq-local current-count 0)
			       local-ret)

		      ;; if the current line is not blank...
		      ;; ... add the item to the current count
		      (setq-local current-count (+ current-count (string-to-number item)))
		      ;; ... and return max-total
		      max-total)))

(setq-local totals-list (sort totals-list '>))
(setq-local top3-total (+ (pop totals-list)
			  (pop totals-list)
			  (pop totals-list)))

(setq-local result-string (concat "Amount of most successful elf: " (number-to-string max-total) "\n"
				  "Amount of top 3 successful elves: " (number-to-string top3-total)))

(with-output-to-temp-buffer "count-numbers-result"
  (print result-string))


(provide 'countNumbers)

;;; countNumbers.el ends here
