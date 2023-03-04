.PHONY: docs test unittest

PYTHON := $(shell which python)

PROJ_DIR      := .
DOC_DIR       := ${PROJ_DIR}/docs
BUILD_DIR     := ${PROJ_DIR}/build
DIST_DIR      := ${PROJ_DIR}/dist
TEST_DIR      := ${PROJ_DIR}/test
TESTFILE_DIR  := ${TEST_DIR}/testfile
SRC_DIR       := ${PROJ_DIR}/fake_html
TEMPLATES_DIR := ${PROJ_DIR}/templates

RANGE_DIR      ?= .
RANGE_TEST_DIR := ${TEST_DIR}/${RANGE_DIR}
RANGE_SRC_DIR  := ${SRC_DIR}/${RANGE_DIR}

COV_TYPES ?= xml term-missing

package:
	$(PYTHON) -m build --sdist --wheel --outdir ${DIST_DIR}
clean:
	rm -rf ${DIST_DIR} ${BUILD_DIR} *.egg-info

test: unittest

unittest:
	pytest "${RANGE_TEST_DIR}" \
		-sv -m unittest \
		$(shell for type in ${COV_TYPES}; do echo "--cov-report=$$type"; done) \
		--cov="${RANGE_SRC_DIR}" \
		$(if ${MIN_COVERAGE},--cov-fail-under=${MIN_COVERAGE},) \
		$(if ${WORKERS},-n ${WORKERS},)

docs:
	$(MAKE) -C "${DOC_DIR}" build
pdocs:
	$(MAKE) -C "${DOC_DIR}" prod

dataset:
	$(PYTHON) -m fake_html.crawl download \
		-u car_home 'https://www.autohome.com.cn/shanghai/' \
		-u baidu_home 'https://www.baidu.com' \
		-u baidu_search 'https://www.baidu.com/s?wd=python%20guassian%20blur%202d&rsv_idx=2&tn=baiduhome_pg&ie=utf-8&f=13&nojc=1&rqlang=cn&rsv_pq=927e06580000fe9d&oq=python%20guassian%20blur%202d&rsv_t=7b8ah7A1JLC6Toz6NowWe%2F30vl9CC6pyvAIs58d4f%2Fgo9jDcPpNC%2F%2FWgbalvz3UeXoRP' \
		-u zhihu_article_1 'https://zhuanlan.zhihu.com/p/501495148' \
		-u zhihu_article_2 'https://zhuanlan.zhihu.com/p/390821442' \
		-u zhihu_question_1 'https://www.zhihu.com/question/60751553' \
		-u zhihu_question_2 'https://www.zhihu.com/question/487319180' \
		-u csdn_article_1 'https://blog.csdn.net/asaander/article/details/120064433?spm=1001.2101.3001.6650.10&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-10-120064433-blog-107124374.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-10-120064433-blog-107124374.pc_relevant_default&utm_relevant_index=11' \
		-u csdn_article_2 'https://blog.csdn.net/qq_39521554/article/details/78877505?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522167775679216800213095588%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=167775679216800213095588&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_positive~default-1-78877505-null-null.142^v73^pc_new_rank,201^v4^add_ask,239^v2^insert_chatgpt&utm_term=%E7%89%B9%E5%BE%81%E5%B7%A5%E7%A8%8B&spm=1018.2226.3001.4187' \
		-u github_repo_1 'https://github.com/jsvine/markovify' \
		-u github_repo_2 'https://github.com/opendilab/treevalue' \
		-u github_source_1 'https://github.com/opendilab/treevalue/blob/main/treevalue/tree/tree/tree.pyx' \
		-u github_source_2 'https://github.com/pytorch/vision/blob/main/torchvision/__init__.py' \
		-u huggingface_card 'https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english' \
		-u huggingface_files_1 'https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english/tree/main' \
		-u huggingface_files_2 'https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english/tree/main' \

rmds:
	rm -rf ${SRC_DIR}/dataset/*.html