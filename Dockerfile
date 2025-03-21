# Copyright 2024 Nils Knieling
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# The python:3.11-slim tag points to the latest release based on Debian 12 (bookworm)
FROM python:3.11-slim

WORKDIR /app

# Log Python messages immediately instead of being buffered
ENV PYTHONUNBUFFERED="True"

# Default HTTP port
EXPOSE 4000/tcp

# Install LiteLLM proxy
COPY requirements.txt requirements.txt
COPY config.yaml config.yaml
RUN pip install -r requirements.txt && \
    pip cache purge

RUN prisma generate

# Start
ENTRYPOINT ["litellm"]
CMD ["--port", "4000", "--config", "config.yaml"]
