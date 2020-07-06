SRC = $(wildcard ./*.ipynb)

all: akshat_nbdev_test docs

akshat_nbdev_test: $(SRC)
	nbdev_build_lib
	touch akshat_nbdev_test

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist