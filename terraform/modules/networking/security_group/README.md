# Example Terraform Module Repo #

This is an example repo for production quality terraform modules. Ideally,
this would be some sort of "solution" or approach to a architectural
pattern rather than a generic module for some resource as there are
already many of those publicly available.  This should have a Rackspace
unique approach or specific value-add.

## Repo Structure ##

```
.
|
|-- .github                     (contains GH actions, etc)
|-- .templates                  (contains templates for auto-generation)
|-- /bin                        (all binary executables)
|-- /examples                   (location of all examples using the module)
|-- /tests                      (location of all Terratests)
    |-- test1                   (test subfolder)
    |-- test2                   (test subfolder)
    | Makefile                  (entry point for test execution)
|-- .gitignore                  (repo files to ignore)
|-- .terraform-docs.yml         ()
|-- .terraform-validator.yaml   ()
|-- .tflint.hcl                 (tflint config)
|-- CHANGELOG.md                (repo changelog, symantic versioning)
|-- *.tf                        (any module terraform files, such as main.tf, variables.tf, etc) 
|-- README.md                   (auto generated via template in .templates)
|-- Makefile                    (main entry point for all commands)
|-- VERSION                     (version of the repo for publishing)

```

### What is this repository for? ###

* This is an example repo for a Terraform module(s).  This is intended to be a blueprint for adding future modules.
* All versions should follow [Semantic Versioning](https://semver.org/)
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions (Should we include [Localstack](https://docs.localstack.cloud/integrations/terraform/))?

[![Linter](https://github.com/rax-incubate/rax-terraform-module-template/workflows/Linter/badge.svg)](https://github.com/terraform/rax-terraform-module-template/actions?query=workflow%3A%22Linter%22)
[![Terraform](https://github.com/rax-incubate/rax-terraform-module-template/workflows/Terraform%20%28Supported%29/badge.svg)](https://github.com/terraform/rax-terraform-module-template/actions?query=workflow%3A%22Terraform+%28Supported%29%22)

### Contribution guidelines ###

* All modules should have tests that prove your code is functional. 
* All tests should live within the `tests` directory in a dedicated folder.
* Writing tests , See [Terratest](https://terratest.gruntwork.io/docs/getting-started/quick-start/) and [Testify](https://github.com/stretchr/testify)

```sh
cd tests/<test-dir>
go mod init "github.com/<org>/<repo>"
go mod tidy

go test -timeout=30m -v -run Test<something>
```

* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact
