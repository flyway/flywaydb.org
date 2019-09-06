ifeq ($(OS), Windows_NT)
FORCE_POLLING = true
else
FORCE_POLLING = false
endif

all: clean run

clean:
	docker run --rm -v "$(realpath .):/app" bash \
		rm -rf /app/_site

run:
	docker run --rm \
		-v "$(realpath .):/srv/jekyll" \
		-p 35729:35729 -p 4000:4000 \
		-e FORCE_POLLING=$(FORCE_POLLING) \
		-e PAGES_REPO_NWO='flyway/flywaydb.org' \
		-it jekyll/jekyll:3.8 \
		jekyll serve --livereload --incremental