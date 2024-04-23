# Push web app

# flutter pub run build_runner build --delete-conflicting-outputs
# dart fix --apply

# cd C:\Users\gribk\AndroidStudioProjects\testing_training\make
# make deploy M=""

OUTPUT = grib-testing-training.github.io
BASE_HREF = /$(OUTPUT)/
GITHUB_USER = grib-testing-training
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT)

deploy:
	cd .. && \
	dart fix --apply && \
	flutter clean && \
	flutter pub get && \
	flutter create . --platform web && \
	flutter build web && \
#	python make/copy_dirs.py && \
#	cd build/web && \
#	git init && \
#	git add . && \
#	git commit -m "$(M)" && \
#	git branch -M main && \
#	git remote add origin $(GITHUB_REPO) && \
#	git push -u -f origin main && \
#	cd ../.. && \
#	git add . && \
#	git commit -m "$(M)" && \
#	git push

	@echo "Finished deploy: $(GITHUB_REPO)"
	@echo "Flutter web URL: https://$(GITHUB_USER).github.io/"

.PHONY: deploy