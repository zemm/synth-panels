SRC = $(HOME)/Dropbox/synth/Panels

test: check

.PHONY: check
check:
	# Check that source exists
	test -d "$(SRC)"
	# Check that worspace is clean
	[ -z "$$(git status --short)" ]
	# Check that source has changes
	[ -n "$$(git --work-tree="$(SRC)" status --short)" ]

st: status

.PHONY: status
status:
	# Source status:
	git --work-tree="$(SRC)" status

.PHONY: pull
pull: test status
	git --work-tree="$(SRC)" add .
	git --work-tree="$(SRC)" commit -av || >&2 echo "# Pull cancelled"
	git reset --hard HEAD
