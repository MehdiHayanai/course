FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

ENV UV_COMPILE_BYTECODE=1

COPY pyproject.toml uv.lock ./

# Install dependencies
# --frozen: Sync exactly what is in uv.lock (no updates)
# --no-dev: Exclude development dependencies
# --no-install-project: Don't try to install the current directory as a package yet
RUN uv sync --frozen --no-dev --no-install-project

COPY main.py .

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8501

CMD ["streamlit", "run", "main.py", "--server.address=0.0.0.0"]