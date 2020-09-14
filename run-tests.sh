#!/usr/bin/env sh
# -*- coding: utf-8 -*-
#
# Copyright (C) 2019 CERN.
# Copyright (C) 2019 Northwestern University.
#
# Invenio-Records-Permissions is free software; you can redistribute it
# and/or modify it under the terms of the MIT License; see LICENSE file for
# more details.

python -m pydocstyle invenio_records_permissions tests docs && \
python -m isort invenio_records_permissions tests --check-only --diff && \
python -m check_manifest --ignore ".travis-*" && \
python -m sphinx.cmd.build -qnNW docs docs/_build/html && \
docker-services-cli up es postgresql
python -m pytest
tests_exit_code=$?
docker-services-cli down
exit "$tests_exit_code"
