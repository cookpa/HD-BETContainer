FROM python:3.11-bookworm AS builder

COPY requirements.txt /opt/requirements/requirements.txt

RUN apt-get update && \
    python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    python3 -m pip install --upgrade pip && \
    pip install --requirement /opt/requirements/requirements.txt && \
    mkdir -p /opt/src && \
    cd /opt/src && \
    git clone https://github.com/MIC-DKFZ/HD-BET

# This ensures data gets downloaded to /opt/hd-bet_params and tells hd-bet where to
# look for data
COPY paths.py /opt/src/HD-BET/HD_BET/paths.py

# Does the actual download
COPY cache_data.py /opt/scripts/cache_data.py

RUN . /opt/venv/bin/activate && \
    cd /opt/src/HD-BET && \
    pip install wheel && \
    pip install --no-deps . && \
    python /opt/scripts/cache_data.py

FROM python:3.11-slim-bookworm

ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Avoids trouble in HPC environments, users can override at run time
ENV ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS=1
ENV OMP_NUM_THREADS=1

COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /opt/hd-bet_params /opt/hd-bet_params

LABEL maintainer="Philip A Cook (https://github.com/cookpa)"
LABEL description="Containerization of HD-BET brain extraction software. Please see the HD-BET page \
https://github.com/MIC-DKFZ/HD-BET for more information."

ENTRYPOINT ["hd-bet"]
CMD ["-h"]
