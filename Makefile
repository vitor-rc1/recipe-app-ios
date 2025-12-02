setup-project:
	@sh ./scripts/generate-project.sh

local-setup:
	@sh ./scripts/local-setup.sh

ci-setup:
	@sh ./scripts/ci-setup.sh

tuist-edit:
	mise exec -C ./RecipeApp/src -- tuist edit