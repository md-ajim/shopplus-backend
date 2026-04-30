#!/bin/sh
set -e

echo "Applying database migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting Gunicorn..."
exec gunicorn settings.wsgi:application --bind 0.0.0.0:8000



# #!/bin/sh

# echo "Waiting for Aurora RDS at $DB_HOST..."

# # Check if RDS is reachable on port 3306
# while ! nc -z $DB_HOST 3306; do
#   echo "RDS is not reachable yet. Checking again..."
#   sleep 2
# done

# echo "Aurora RDS is ready!"

# python manage.py migrate --noinput
# python manage.py collectstatic --noinput

# exec gunicorn project.wsgi:application --bind 0.0.0.0:8000 --workers 3
