#-------------------------------------------------------------------------------
# Running `make` will show the list of subcommands that will run.

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

#-------------------------------------------------------------------------------
# Global stuff.

GO=$(shell which go)
#BREW_PREFIX=$(shell brew --prefix)

# Determine which version of `echo` to use. Use version from coreutils if available.
# ECHOCHECK := $(shell command -v $(BREW_PREFIX)/opt/coreutils/libexec/gnubin/echo 2> /dev/null)
# ifdef ECHOCHECK
#     ECHO="$(BREW_PREFIX)/opt/coreutils/libexec/gnubin/echo" -e
# else
#     ECHO=echo
# endif
ECHO=echo
#-------------------------------------------------------------------------------
# Running `make` will show the list of subcommands that will run.

all: help

.PHONY: help
## help: [help]* Prints this help message.
help:
	@ $(ECHO) "Usage:"
	@ $(ECHO) ""
	@ sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /' | \
		while IFS= read -r line; do \
			if [[ "$$line" == *"]*"* ]]; then \
				$(ECHO) "\033[1;33m$$line\033[0m"; \
			else \
				$(ECHO) "$$line"; \
			fi; \
		done

#-------------------------------------------------------------------------------
# Clean

.PHONY: clean-tests
## clean-tests: [clean] cleans all files/folders inside the tests and examples directories which begin with a "."
clean-tests: clean-logs
	@ echo " "
	@ echo "=====> Cleaning artifacts from tests..."
	- find . -type d -name ".terraform" | xargs rm -Rf
	- find ./examples -type d -name "\.*" | xargs rm -Rf
	- find ./tests -type d -name "\.*" | xargs rm -Rf
	- find ./tests -type f -name ".terraform.lock.hcl" | xargs rm -Rf

.PHONY: clean-npm
## clean-npm: [clean] removes the root `node_modules` directory
clean-npm:
	@ echo " "
	@ echo "=====> Cleaning npm..."
	- rm -Rf ./node_modules

.PHONY: clean-logs
## clean-logs: [clean] removes the test-related log files
clean-logs:
	@ echo " "
	@ echo "=====> Cleaning log files..."
	- rm -Rf ./tests/terratest-*
	- rm -Rf ./tests/terraform.tfstate*
	- rm -Rf ./tests/**/terratest-*
	- rm -Rf ./tests/**/terraform.tfstate*

.PHONY: clean
## clean: [clean]* runs ALL cleaning tasks except `make clean-npm`
clean: clean-tests clean-logs clean-npm

#-------------------------------------------------------------------------------
# Documentation

.PHONY: readme
## readme: [docs] replaces `@@` markers in the README with consistently-formatted output from `terraform-docs` and `gh-md-toc`
readme:
	@ echo " "
	@ echo "=====> Running terraform-docs and gh-md-toc..."
	@ # 1. `cat` the contents of the _template_ README to stdout.
	@ # 2. `awk` with variable replacement, replacing `@@INPUT-OUTPUT@@` with the contents of the `input_output` awk variable.
	@ #    2.1. Run `terraform-docs` against the *.tf files in the current directory. Outputs a Markdown-formatted table with some quirks.
	@ #    2.2. Quirk #1 is that all underscores are prefixed with a back-slash. Use `sed` to remove the back-slashes.
	@ #    2.3. Quirk #2 is that the input/output variable names should be formatted as "code". Use `sed` and some PCRE regexes to parse the
	@ #         first table column (starts with a vertical pipe, space, alphanum with underscores). This is incompatible with macOS's BSD-flavored
	@ #         `sed`. If someone wants to contribute a version with identical results using POSIX-style regexes (sed -e), PRs are welcome.
	@ #    2.4. Pipe the previous output to `markdown-table-formatter` which aligns Markdown table columns with whitespace.
	@ # 3. `awk` with variable replacement, replacing `@@TOC@@` with the contents of the `toc` awk variable.
	@ #    3.1. Use `gh-md-toc` to read the headers in the Markdown, and generate a Table of Contents.
	@ # 4. Output everything we've done to the _real_ README, overwriting whatever used to be there.
	./bin/dependency-check.py
	cat .templates/README.md \
		| awk -v tf_supported="$$(bin/supported-versions.py versions.tf)" '{ gsub(/@@TF_SUPPORTED@@/, tf_supported); print }' \
		| awk -v tf_current="1.1" '{ gsub(/@@TF_CURRENT@@/, tf_current); print }' \
		| awk -v tf_legacy="< 0.13" '{ gsub(/@@TF_LEGACY@@/, tf_legacy); print }' \
		| awk -v node_current="17" '{ gsub(/@@NODE_CURRENT@@/, node_current); print }' \
		| awk -v go_current="1.17" '{ gsub(/@@GO_CURRENT@@/, go_current); print }' \
		| awk -v input_output="$$(terraform-docs . | sed -r 's/^####\s/## /g' | markdown-table-formatter)" '{ gsub(/@@INPUT-OUTPUT@@/, input_output); print }' \
		| awk -v toc="Select the bullet-list icon in the upper-left corner of the README." '{ gsub(/@@TOC@@/, toc); print }' \
		> README.md

.PHONY: examples
## examples: [docs] reads the test files, and uses them to create working standalone examples
examples:
	@ echo " "
	@ echo "=====> Generating examples from tests..."
	- bin/examples.sh

.PHONY: workflows
## workflows: [docs] updates .github/workflows/terraform.yml with the Terraform versions supported by this module
workflows:
	@ echo " "
	@ echo "=====> Updating .github/workflows/terraform.yml..."
	- content="$$(bin/update-github-actions-terraform.py --versions="$$(bin/supported-versions.py < versions.tf)" < .github/workflows/terraform.yml)" && echo "$$content" > .github/workflows/terraform.yml

.PHONY: docs
## docs: [docs]* runs ALL documentation tasks except `make resources`
docs: readme workflows examples

#-------------------------------------------------------------------------------
# Linting

.PHONY: golint
## golint: [lint] runs `golangci-lint` (static analysis, formatting) against all Golang (*.go) tests with a standardized set of rules
golint:
	@ echo " "
	@ echo "=====> Running golangci-lint..."
	for dir in $$(find tests/ -type f -name "*.go" | xargs -I% dirname % | uniq); do \
		cd "$$dir" && \
			golangci-lint run --fix *.go ; \
		cd $(current_dir) ; \
	done

.PHONY: markdownlint
## markdownlint: [lint] runs `markdownlint` (formatting, spelling) against all Markdown (*.md) documents with a standardized set of rules
markdownlint:
	@ echo " "
	@ echo "=====> Running Markdownlint...FIXME"
	## npx -y markdownlint-cli --fix '**/*.md' --ignore 'node_modules'

.PHONY: tflint
## tflint: [lint] runs `tflint` (formatting, value validation) against all Terraform (*.tf) code with a standardized set of rules
tflint: clean-tests
	@ echo " "
	@ echo "=====> Running tflint..."
	- find . -type d -name ".terraform" | xargs rm -Rf
	GITHUB_TOKEN="" tflint --init
	for dir in $$(find tests/ -type f -name "*.tf" | xargs -I% dirname % | uniq); do \
		cd "$$dir" && \
			terraform init && \
			tflint --config=$(current_dir).tflint.hcl . ; \
		cd $(current_dir); \
	done

.PHONY: tfvalidate
## tfvalidate: [lint] runs `terraform validate` (valid syntax) against all Terraform (*.tf) code
tfvalidate: clean-tests
	@ echo " "
	@ echo "=====> Running terraform validate..."
	terraform init && terraform validate
	for dir in $$(find tests/ -type f -name "*.tf" | xargs -I% dirname % | uniq); do \
		cd "$$dir" && \
			terraform init && \
			terraform validate ; \
		cd $(current_dir) ; \
	done

# Formats all Terraform code to its canonical format.
.PHONY: fmt
## fmt: [lint] runs `terraform fmt` (formatting) against all Terraform (*.tf) code
fmt: clean-tests
	@ echo " "
	@ echo "=====> Running Terraform format..."
	terraform fmt
	for dir in $$(find tests/ -type f -name "*.tf" | xargs -I% dirname % | uniq); do \
		cd "$$dir" && \
			terraform fmt ; \
		cd $(current_dir) ; \
	done

.PHONY: lint
## lint: [lint]* runs ALL linting/validation tasks
lint: fmt tfvalidate tflint markdownlint golint

#-------------------------------------------------------------------------------
# Testing

.PHONY: skips
## skips: [test] generates the list of "SKIP_" environment variables that can be applied during testing; see j.mp/3cY0XUe
skips:
	@ find ./tests -maxdepth 2 -type f -name "*.go" | xargs -I% bash -c 'bin/show-skips.sh "$$1"' _ % \;

.PHONY: test-prep
## test-prep: [test] prepares the tests to run by installing/compiling the dependencies; should be called as part of `make test`
test-prep:
	find . -type f -name "go.mod" | xargs -I% bash -c 'cd $$(dirname $$1) && go mod tidy -go=1.18' _ % \;

.PHONY: test
## test: [test]* runs ALL testing tasks
test: test-prep
	$(MAKE) -C tests

#-------------------------------------------------------------------------------
# Git Tasks

.PHONY: tag
## tag: [release]* tags (and GPG-signs) the release
tag:
	@ if [ $$(git status -s -uall | wc -l) != 1 ]; then echo 'ERROR: Git workspace must be clean.'; exit 1; fi;

	@echo "This release will be tagged as: $$(cat ./VERSION)"
	@echo "This version should match your release. If it doesn't, re-run 'make version'."
	@echo "---------------------------------------------------------------------"
	@read -p "Press any key to continue, or press Control+C to cancel. " x;

	@echo " "
	@chag update $$(cat ./VERSION)
	@echo " "

	@echo "These are the contents of the CHANGELOG for this release. Are these correct?"
	@echo "---------------------------------------------------------------------"
	@chag contents
	@echo "---------------------------------------------------------------------"
	@echo "Are these release notes correct? If not, cancel and update CHANGELOG.md."
	@read -p "Press any key to continue, or press Control+C to cancel. " x;

	@echo " "

	git add .
	git commit -a -m "Preparing the $$(cat ./VERSION) release."
	chag tag --sign

.PHONY: version
## version: [release]* sets the version for the next release; pre-req for a release tag
version:
	@echo "Current version: $$(cat ./VERSION)"
	@read -p "Enter new version number: " nv; \
	printf "$$nv" > ./VERSION

.PHONY: relnotes
## relnotes: [release] Pushes the release notes to GitHub after cutting a release.
relnotes:
	bin/push-release-notes.py $(shell git remote -v | grep ^origin | head -n1 | cut -d' ' -f1 | cut -d':' -f2 | cut -d'.' -f1) $(shell cat ./VERSION)
