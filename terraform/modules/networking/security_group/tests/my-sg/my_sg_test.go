package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestMySg(t *testing.T) {
	// https://golang.org/pkg/testing/#T.Parallel
	// t.Parallel()

	// Generate a temporary directory to work in.
	// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/test-structure#CopyTerraformFolderToTemp
	// tmpDir := test_structure.CopyTerraformFolderToTemp(t, "..", "..")
	tmpDir := "."

	// Apply the Terraform code
	// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/test-structure#RunTestStage
	// How to use: https://github.com/gruntwork-io/terratest/issues/244
	test_structure.RunTestStage(t, "tfapply", func() {
		// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/terraform#Options
		terraformOptions := &terraform.Options{

			// The path to where our Terraform code is located
			TerraformDir: tmpDir,

			// Disable colors in Terraform commands so its easier to parse stdout/stderr
			NoColor: true,
		}

		// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
		// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/terraform#InitAndApply
		terraform.InitAndApply(t, terraformOptions)

		// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/test-structure#SaveTerraformOptions
		test_structure.SaveTerraformOptions(t, tmpDir, terraformOptions)
	})

	// Verify we're getting back the outputs we expect
	test_structure.RunTestStage(t, "outputs", func() {

		// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/test-structure#LoadTerraformOptions
		terraformOptions := test_structure.LoadTerraformOptions(t, tmpDir)

		// Sg Id Exists
		sgName := terraform.Output(t, terraformOptions, "example_security_group_name")
		assert.Contains(t, sgName, "myapp-SecurityGroup")

	})

	// Destroy
	test_structure.RunTestStage(t, "destroy", func() {

		// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/test-structure#LoadTerraformOptions
		terraformOptions := test_structure.LoadTerraformOptions(t, tmpDir)

		// At the end of the test, run `terraform destroy` to clean up any resources that were created
		// https://pkg.go.dev/github.com/gruntwork-io/terratest/modules/terraform#Destroy
		terraform.Destroy(t, terraformOptions)
	})
}
