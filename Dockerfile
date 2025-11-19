FROM python:3.9-alpine3.13
LABEL maintainer="tonmoyrashid"

ENV PYTHONUNBUFFERED=1

# Create virtual environment first
RUN python -m venv /py && /py/bin/pip install --upgrade pip

# Copy requirements separately (better caching)
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Install production dependencies
RUN /py/bin/pip install -r /tmp/requirements.txt

# Install dev dependencies only if DEV=true
ARG DEV=false
RUN if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi

# Copy app code last (so dependency layers are cached)
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# Clean up temp files
RUN rm -rf /tmp && \
    adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"
USER django-user