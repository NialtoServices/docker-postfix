# syntax=docker/dockerfile:1
#
# Copyright 2025 Nialto Services Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM alpine:3.21

LABEL org.opencontainers.image.description="Postfix"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.source="https://github.com/NialtoServices/docker-postfix"

ARG POSTFIX_VERSION="3.9.3"

RUN apk upgrade --no-cache

RUN \
addgroup --system --gid 810 postfix && \
addgroup --system --gid 811 postdrop && \
addgroup --system --gid 850 vmail && \
adduser --system --uid 810 --ingroup postfix --gecos postfix --disabled-password --no-create-home --home /var/spool/postfix --shell /sbin/nologin postfix && \
adduser --system --uid 850 --ingroup vmail --gecos vmail --disabled-password --no-create-home --home /var/mail --shell /sbin/nologin vmail

RUN \
apk add --no-cache \
ca-certificates \
openssl \
postfix~=$POSTFIX_VERSION \
postfix-ldap~=$POSTFIX_VERSION \
postfix-mysql~=$POSTFIX_VERSION \
postfix-pcre~=$POSTFIX_VERSION \
postfix-pgsql~=$POSTFIX_VERSION \
postfix-sqlite~=$POSTFIX_VERSION

COPY bin/bootstrap /usr/local/sbin/bootstrap

ENTRYPOINT ["/usr/local/sbin/bootstrap"]
