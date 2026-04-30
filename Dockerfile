# FROM python:3.13-slim
# WORKDIR /app

# # MySQL client dependencies
# RUN apt-get update && apt-get install -y \
#     default-libmysqlclient-dev \
#     gcc \
#     pkg-config \
#     && rm -rf /var/lib/apt/lists/*


# # Copy requirements first for caching
# COPY requirements.txt ./
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy backend code
# COPY . .

# # Make entrypoint executable
# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]

# FROM python:3.13-slim

# WORKDIR /app

# # Install dependencies + netcat for the database check
# RUN apt-get update && apt-get install -y \
#     default-libmysqlclient-dev \
#     gcc \
#     pkg-config \
#     netcat-openbsd \
#     && rm -rf /var/lib/apt/lists/*

# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . .

# # Ensure permissions
# RUN chmod +x entrypoint.sh

# # Using ['sh', './entrypoint.sh'] is safer than calling the file directly
# ENTRYPOINT ["sh", "./entrypoint.sh"]


FROM python:3.13-slim

# Install dependencies + netcat for the database check
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Hugging Face-এর জন্য ইউজার আইডি 1000 দিয়ে একটি নতুন ইউজার তৈরি করা
RUN useradd -m -u 1000 user

WORKDIR /app

# ওয়ার্কিং ডিরেক্টরির মালিকানা নতুন ইউজারকে দেওয়া
RUN chown -R user:user /app

# নন-রুট ইউজারে সুইচ করা
USER user
ENV PATH="/home/user/.local/bin:${PATH}"

# ফাইলগুলো কপি করার সময় --chown=user:user ব্যবহার করা
COPY --chown=user:user requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=user:user . .

# Ensure permissions
RUN chmod +x entrypoint.sh

# Using ['sh', './entrypoint.sh'] is safer than calling the file directly
ENTRYPOINT ["sh", "./entrypoint.sh"]