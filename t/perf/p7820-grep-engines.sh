#!/bin/sh

test_description="Comparison of git-grep's regex engines"

. ./perf-lib.sh

test_perf_large_repo
test_checkout_worktree

for engine in extended perl
do
	# Patterns stolen from http://sljit.sourceforge.net/pcre.html
	for pattern in \
		'how.to' \
		'^how to' \
		'\w+our\w*' \
		'-?-?-?-?-?-?-?-?-?-?-?-----------$'
	do
		test_perf "$engine with $pattern" "
			git -c grep.patternType=$engine grep -- '$pattern' || :
		"
	done
done

test_done
