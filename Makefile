# Variables
TAILWIND_INPUT = public/style.css
TAILWIND_OUTPUT = public/tailwind.css
BUILD_DIR = build
PUBLIC_DIR = public
GENERATED_TEMPLATES = "**/*_templ.go"

# Commands
TAILWIND_CMD = npx tailwindcss build -i $(TAILWIND_INPUT) -o $(TAILWIND_OUTPUT) -m
GENERATE_CMD = templ generate
GO_RUN_CMD = go run main.go serve
GO_BUILD_CMD = go build -o $(BUILD_DIR)/app

# Targets
dev:
	npx nodemon --signal SIGTERM -e "templ go" -x "$(TAILWIND_CMD) && $(GENERATE_CMD) && $(GO_RUN_CMD)" -i $(GENERATED_TEMPLATES)

generate_styles:
	$(TAILWIND_CMD)

generate: generate_styles
	$(GENERATE_CMD)

build: generate
	rm -rf $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/$(PUBLIC_DIR)
	cp $(PUBLIC_DIR)/index.js $(BUILD_DIR)/$(PUBLIC_DIR)
	cp $(TAILWIND_OUTPUT) $(BUILD_DIR)/$(PUBLIC_DIR)
	$(GO_BUILD_CMD)

run: generate
	$(GO_RUN_CMD)
