from django.http import JsonResponse
from django.db import connection

from .neo4j_client import verify_connectivity


def index(request):
    return JsonResponse({'ok': True, 'service': 'backend'})


def neo4j_health(request):
    try:
        verify_connectivity()
    except Exception as e:
        return JsonResponse({'ok': False, 'error': str(e)}, status=500)

    return JsonResponse({'ok': True})


def db_health(request):
    try:
        with connection.cursor() as cursor:
            cursor.execute('SELECT 1;')
            row = cursor.fetchone()
    except Exception as e:
        return JsonResponse({'ok': False, 'error': str(e)}, status=500)

    return JsonResponse({'ok': row == (1,)})
